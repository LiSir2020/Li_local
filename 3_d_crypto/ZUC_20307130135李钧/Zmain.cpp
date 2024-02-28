#include "./ZUC_H.h"

uint8 KEY[16] = {0};
uint8 IV[16] = {0};

//机密性
uint8 CK[16] = {0x17, 0x3d, 0x14, 0xba, 0x50, 0x03, 0x73, 0x1d,
                0x7a, 0x60, 0x04, 0x94, 0x70, 0xf0, 0x0a, 0x29};//机密性密钥
uint8 COUNT[4] = {0x66, 0x03, 0x54, 0x92};//计数器
uint8 BEARER = 0xf & 0x1f;//承载层表识
uint8 DIRECTION = 0 & 0x1;//传输方向标识
uint32 LENGTH = 0xc1;//明文消息流的比特长度
uint32 IBS[0xc1/32 + 1] = {0x6cf65340, 0x73552ab, 0x0c9752fa, 0x6f9025fe,
                    0x0bd675d9, 0x005875b2, 0x00000000};//LENGTH
uint32 OBS[0xc1/32 + 1];//LENGTH

//完整性
uint8 IK[16] = {0xc9, 0xe6, 0xce, 0xc4, 0x60, 0x7c, 0x72, 0xdb,
                0x00, 0x0a, 0xef, 0xa8, 0x83, 0x85, 0xab, 0x0a};
uint8 COUNT_w[4] = {0xa9, 0x40, 0x59, 0xda};//计数器
// uint8 IK[16] = {0};
// uint8 COUNT_w[4] = {0};
uint8 BEARER_w = 0xa & 0x1f;//承载层表识
uint8 DIRECTION_w = 1 & 0x1;//传输方向标识
uint32 LENGTH_w = 0x241;//明文消息流的比特长度
// uint32 M[1] = {0};
uint32 M[0x241/32 + 3] = {  0x983b41d4, 0x7d780c9e, 0x1ad11d7e, 0xb70391b1,
                            0xde0b35da, 0x2dc62f83, 0xe7b78d63, 0x06ca0ea0,
                            0x7e941b7b, 0xe91348f9, 0xfcb170e2, 0x217fecd9,
                            0x7f9f68ad, 0xb16e5d7d, 0x21e569d2, 0x80ed775c,
                            0xebde3f40, 0x93c53881, 0x00000000};
uint32 MAC = 0;

int keylen;
int main(){
    // char k[50] = {0};
    // char v[50] = {0};
    // printf("key: ");
    // scanf("%s", k);
    // printf("IV : ");
    // scanf("%s", v);
    // char k[50] = "this_is_key";
    // char v[50] = "the_iv";
    // //进行输入内容的初始化
    // for (int i = 0; i < 16; i++){
    //     key[i] = (((k[2 * i] <= '9') ? (k[2 * i] - '0') : (k[2 * i] - 'a' + 10)) << 4) +
    //              ((k[2 * i + 1] <= '9') ? (k[2 * i + 1] - '0') : (k[2 * i + 1] - 'a' + 10));
    //     iv[i] = (((v[2 * i] <= '9') ? (v[2 * i] - '0') : (v[2 * i] - 'a' + 10)) << 4) +
    //             ((v[2 * i + 1] <= '9') ? (v[2 * i + 1] - '0') : (v[2 * i + 1] - 'a' + 10));
    // }

    //根据给定的参数IK,COUNT,BEARER,DIRECTION来初始化KEY和IV，以及初始化keylen
    ZUC_jm_Init(CK, COUNT, KEY, IV, BEARER, DIRECTION, keylen);
    // ZUC_wz_Init(IK, COUNT_w, KEY, IV, BEARER_w, DIRECTION_w, keylen);

    Key_Init(KEY, IV);//密钥装入
    uint32 *keylist = KeyStream_Generator(keylen);

    printf("\n\nthis is keylen: %d\n\n", keylen);
    for(int i = 0; i < keylen + 1; i++)
        printf("this is the %d key: %08x\n", i, keylist[i]);
    printf("\n");

    ZUC_jm_en(IBS, keylist, LENGTH, OBS, keylen);

    // uint32 mac = ZUC_MAC(M, keylist, LENGTH_w);

    free(keylist);
	keylist = NULL;

    return 0;
}

