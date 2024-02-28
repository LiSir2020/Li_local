#include "./SM3_h.h"

// 应用函数
void My_SM3(const char *message, const int message_len, unsigned int *hash){
    // message_len是指message有多少个字节
    // 在填充0之前，消息可以分成多少组(group)
    int test = (message_len + MESSAGE_LENGTH_SIZE + 1) % GROUP_SIZE;
    unsigned int message_group_num;
    if(test == 0) message_group_num = (message_len + MESSAGE_LENGTH_SIZE + 1) / GROUP_SIZE;
    else message_group_num = (message_len + MESSAGE_LENGTH_SIZE + 1) / GROUP_SIZE + 1;
    // pad添加字节之后，l的位置
    unsigned int message_pad_len = message_group_num * GROUP_SIZE - MESSAGE_LENGTH_SIZE;// - message_len - 1;
    // padding之后的初始化，将比特"1"添加到消息末尾
    unsigned int sizeof_pad = message_group_num * GROUP_SIZE;
    unsigned char message_pad[sizeof_pad];
    memset(message_pad, 0, sizeof(message_pad)); // 以字节为单位
    memcpy(message_pad, message, message_len);
    message_pad[message_len] = 0x80;

    // 加上l的二进制表示
    unsigned long long bit_msg_l = message_len * 8;
    for (unsigned int i = 0; i < MESSAGE_LENGTH_SIZE; ++i) {
        message_pad[message_pad_len + i] = ((unsigned char*)&bit_msg_l)[MESSAGE_LENGTH_SIZE - i - 1];
    }

    //test the padding
    // cout << "the size of msgpadding is:" << sizeof_pad << endl;
    // cout << "after padding, m\' is:" << endl;
    // for(int i = 0; i < sizeof_pad; i++){
    //     cout << hex << (int)message_pad[i];
    //     if((i+1)%4==0) cout << '\t';
    //     if((i+1)%32==0) cout << endl;
    // }
    // cout << endl;
    //test right

    unsigned int state[8];
    memcpy(state, IV, sizeof(IV));
    unsigned int W[68], W_[64];
    unsigned int A, B, C, D, E, F, G, H;
    for(unsigned int i = 0; i < message_group_num; i++){
        memset(W, 0, sizeof(W)); // 初始化每个块内容，对应每个512bit
        memset(W_, 0, sizeof(W_));
        // 机器大小端会导致memcpy顺序错误
        // memcpy(W, message_pad + (i * GROUP_SIZE), GROUP_SIZE);
        // 一个W[]四个字节
        for(int j = 0; j < 16; j++){
            W[j] = 
				(message_pad[i*64 + j*4]  <<24) | (message_pad[i*64 + j*4+1]<<16) | 
				(message_pad[i*64 + j*4+2]<<8)  | message_pad[i*64 + j*4+3];
        }
        // a)将消息分组划分成16个字W0...W15
        // b)for j = 16 to 67
        for (int j = 16; j < 68; j++) {
            W[j] = P1(W[j - 16] ^ W[j - 9] ^ ROTATE_LEFT(W[j - 3], 15)) ^ ROTATE_LEFT(W[j - 13], 7) ^ W[j - 6];
        }
        for(int j = 0; j < 64; j++){
            W_[j] = W[j] ^ W[j+4];
        }
        // //test W
        // cout << "\n\nthe W result is:" << endl;
        // for(int j = 0; j < 68; j++){
        //     cout << hex << (int)W[j] << ' ';
        //     if((j + 1) % 8 == 0) cout << endl;
        // }
        // //test W right
        // // test W_
        // cout << "\n\nthe W_ result is:" << endl;
        // for(int j = 0; j < 64; j++){
        //     cout << hex << (int)W_[j] << ' ';
        //     if((j + 1) % 8 == 0) cout << endl;
        // }
        // //test W_ right

        // update and test
        A = state[0];
        B = state[1];
        C = state[2];
        D = state[3];
        E = state[4];
        F = state[5];
        G = state[6];
        H = state[7];

        // cout << "orig_A~H is:" << endl;
        // A = state[0]; cout << hex << (int)A << ' ';
        // B = state[1]; cout << hex << (int)B << ' ';
        // C = state[2]; cout << hex << (int)C << ' ';
        // D = state[3]; cout << hex << (int)D << ' ';
        // E = state[4]; cout << hex << (int)E << ' ';
        // F = state[5]; cout << hex << (int)F << ' ';
        // G = state[6]; cout << hex << (int)G << ' ';
        // H = state[7]; cout << hex << (int)H << ' ' << endl;
        // c)for j = 0 to 63 压缩函数
        // cout << "\nA________B________C________D________E________F________G________H" << endl;
        for (unsigned int j = 0; j < GROUP_SIZE; ++j) {
            int tmpp = 0;
            if(j <= 15) tmpp = T_0_15;
            else tmpp = T_16_63;
            unsigned int SS1 = ROTATE_LEFT(ROTATE_LEFT(A, 12) + E + ROTATE_LEFT(tmpp, j%32), 7);
            unsigned int SS2 = SS1 ^ ROTATE_LEFT(A, 12);
            unsigned int TT1, TT2;
            TT1 = FF(A, B, C, j) + D + SS2 + W_[j];
            TT2 = GG(E, F, G, j) + H + SS1 + W[j];
            
            D = C;
            C = ROTATE_LEFT(B, 9);
            B = A;
            A = TT1;
            H = G;
            G = ROTATE_LEFT(F, 19);
            F = E;
            E = P0(TT2);

            //test A~H
            // cout << hex << (int)A << ' ';
            // cout << hex << (int)B << ' ';
            // cout << hex << (int)C << ' ';
            // cout << hex << (int)D << ' ';
            // cout << hex << (int)E << ' ';
            // cout << hex << (int)F << ' ';
            // cout << hex << (int)G << ' ';
            // cout << hex << (int)H << ' ' << endl;
            //test ok
        }
        // 迭代到下一轮
        state[0] ^= A;
        state[1] ^= B;
        state[2] ^= C;
        state[3] ^= D;
        state[4] ^= E;
        state[5] ^= F;
        state[6] ^= G;
        state[7] ^= H;

    }

    for (unsigned int i = 0; i < 8; i++) { //8字节
        hash[i] = state[i];
    }

    return;
}

