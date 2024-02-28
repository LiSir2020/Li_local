#include "./ZUC_H.h"

uint32 LFSR[16] = {0};//线性反馈以为寄存器
uint32 X[4] = {0};//比特重组输出的4个32比特
uint32 R1 = 0, R2 = 0;//非线性函数F的2个32比特记忆单元变量
uint32 W = 0;//非线性函数F输出的32比特字

// 循环移位
uint32 Rmv(uint32 x, int move){
    return ((x << move) | (x >> (32 - move)));
}

// 模2^31-1加法
uint32 mod_add(uint32 a, uint32 b){
    uint32 c = a + b;
    c = (c & 0x7fffffff) + (c >> 31);
    return c;
}

// 模2^31-1乘法
uint32 mod_2exp_mul(uint32 x, int exp){
    return ((x << exp) | (x >> (31 - exp))) & 0x7fffffff;
    //本算法当中的2^8+1,1==2^0,移位k==0，不做考虑
}

//两个线性变换L
uint32 L1(uint32 x){
    return (x ^ Rmv(x, 2) ^ Rmv(x, 10) ^ Rmv(x, 18) ^ Rmv(x, 24));
}
uint32 L2(uint32 x){
    return (x ^ Rmv(x, 8) ^ Rmv(x, 14) ^ Rmv(x, 22) ^ Rmv(x, 30));
}

//初始化模式
void LFSRWithInitMode(uint32 u){
    uint32 v = 0, tmp = 0, i = 0;

    v = LFSR[0];
    tmp = mod_2exp_mul(LFSR[0], 8);//模2^31-1乘法，s0,2^8+1
    v = mod_add(v, tmp);//模2^31-1加法

    tmp = mod_2exp_mul(LFSR[4], 20);//s4,2^20
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[10], 21);//s10,2^21
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[13], 17);//s13,2^17
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[15], 15);//s15,2^15
    v = mod_add(v, tmp);

    v = mod_add(v, u);//s16 = v + u mod(2^31-1)
    if (v == 0)//if s16 == 0, s16 = 2^31-1
        v = 0x7fffffff;

    for (i = 0; i < 16; i++)//逐位赋值s1->s0,s2->s1,...,s16->s15
        LFSR[i] = LFSR[i + 1];
    LFSR[15] = v;
}

//工作模式（与初始化基本一样）
void LFSRWithWorkMode(){
    uint32 v = 0, tmp = 0, i = 0;

    v = LFSR[0];
    tmp = mod_2exp_mul(LFSR[0], 8);
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[4], 20);
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[10], 21);
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[13], 17);
    v = mod_add(v, tmp);

    tmp = mod_2exp_mul(LFSR[15], 15);
    v = mod_add(v, tmp);

    if (v == 0)
        v = 0x7fffffff;

    for (i = 0; i < 16; i++)
        LFSR[i] = LFSR[i + 1];
    LFSR[15] = v;
}

//比特重组BR，十六位为HL分界
void BitReconstruction(){
    //X0 = s15H || s14L
    X[0] = ((LFSR[15] & 0x7fff8000) << 1) | (LFSR[14] & 0xffff);
    //X1 = s11L || s9H
    X[1] = (LFSR[11] << 16) | (LFSR[9] >> 15);
    //X2 = s7L || s5H
    X[2] = (LFSR[7] << 16) | (LFSR[5] >> 15);
    //X3 = s2L || s0H
    X[3] = (LFSR[2] << 16) | (LFSR[0] >> 15);
}

//S盒输入输出，附录A
uint32 S(uint32 a){
    uint8 x[4] = {0}, y[4] = {0};
    uint32 b = 0;//result
    int i = 0;
    x[0] = a >> 24;
    x[1] = (a >> 16) & 0xff;
    x[2] = (a >> 8) & 0xff;
    x[3] = a & 0xff;
    for (i = 0; i < 4; i++){
        if (i == 0 || i == 2)
            y[i] = S0[x[i]];
        else
            y[i] = S1[x[i]];
    }
    b = (y[0] << 24) | (y[1] << 16) | (y[2] << 8) | y[3];
    return b;
}

//非线性函数F
void F(){
    uint32 W1 = 0, W2 = 0;
    uint32 tmp1 = 0, tmp2 = 0;
    W = (X[0] ^ R1) + R2;
    W1 = R1 + X[1];//模2^32加法，溢出即为模
    W2 = R2 ^ X[2];
    R1 = S(L1((W1 << 16) | (W2 >> 16)));
    R2 = S(L2((W2 << 16) | (W1 >> 16)));
}

//密钥装入，初始化阶段
void Key_Init(uint8 *k, uint8 *iv){
    for(int i = 0; i < 16; i++)
        LFSR[i] = (k[i] << 23) | (D[i] << 8) | iv[i];
    
    R1 = R2 = 0;
    for(int i = 0; i < 32; i++){
        BitReconstruction();
        F();
        LFSRWithInitMode(W >> 1);
    }
}

//工作阶段，最后输出一个32比特的密钥字Z
uint32 *KeyStream_Generator(int keylen){
    uint32 Z = 0, i = 0;
    uint32 *keystream = (uint32 *)malloc((keylen + 1) * sizeof(uint32));
    BitReconstruction();
    F();
    //初始化后线性反馈移位寄存器状态
    // printf("\nLFSR after init:\n");
    // for(i = 0; i < 16; i++){
    //     printf("%08x ", LFSR[i]);
    //     if(i==7) printf("\n");
    // }
    // printf("\n");
    // keystream[0] = W ^ X[3];
    LFSRWithWorkMode();

    //密钥流
    // printf("\nkey stream:\n");
    // printf("X0_______X1_______X2_______X3_______R1_______R2_______z________s15\n");
    // for(i = 0; i < 4; i++){
    //     printf("%08x ", X[i]);
    // }
    // printf("%08x ", R1);
    // printf("%08x ", R2);
    // printf("%08x ", keystream[0]);
    // printf("%08x ", LFSR[15]);
    // printf("\n");

    for (i = 0; i < keylen; i++){
        BitReconstruction();
        F();
        keystream[i] = W ^ X[3];
        LFSRWithWorkMode();
        //密钥流
        // for(int ii = 0; ii < 4; ii++){
        //     printf("%08x ", X[ii]);
        // }
        // printf("%08x ", R1);
        // printf("%08x ", R2);
        // printf("%08x ", keystream[i]);
        // printf("%08x ", LFSR[15]);
        // printf("\n");
    }
    return keystream;
}

