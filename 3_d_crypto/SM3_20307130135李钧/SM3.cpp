#include "./SM3_h.h"

// 基本函数
unsigned int FF(unsigned int X, unsigned int Y, unsigned int Z, int j){
    if(j <= 15) return (X ^ Y ^ Z);
    else return ((X&Y) | (X&Z) | (Y&Z));
}
unsigned int GG(unsigned int X, unsigned int Y, unsigned int Z, int j){
    if(j <= 15) return (X ^ Y ^ Z);
    else return (X&Y) | ((~X)&Z);
}
unsigned int P0(unsigned int x) {
    return x ^ ROTATE_LEFT(x, 9) ^ ROTATE_LEFT(x, 17);
}
unsigned int P1(unsigned int x) {
    return x ^ ROTATE_LEFT(x, 15) ^ ROTATE_LEFT(x, 23);
}

//初始化函数SM3_Init
int SM3_Init(SM3_CTX *c)
{
    memset(c, 0, sizeof(*c));
    c->A = IV[0];
    c->B = IV[1];
    c->C = IV[2];
    c->D = IV[3];
    c->E = IV[4];
    c->F = IV[5];
    c->G = IV[6];
    c->H = IV[7];
    return 1;
}

//消息扩展，压缩函数
void SM3_block_data_order(SM3_CTX *ctx, const void *p, size_t num)
{
    const unsigned char *data = (unsigned char*)p;
    unsigned int W[68], W_[64];
    unsigned int A, B, C, D, E, F, G, H;

    for (; num--;)
    {
        A = ctx->A;
        B = ctx->B;
        C = ctx->C;
        D = ctx->D;
        E = ctx->E;
        F = ctx->F;
        G = ctx->G;
        H = ctx->H;

        memset(W, 0, sizeof(W)); // 初始化每个块内容，对应每个512bit
        memset(W_, 0, sizeof(W_));
        // 机器大小端会导致memcpy顺序错误
        // memcpy(W, data, GROUP_SIZE);
        // 一个W[]四个字节
        for(int j = 0; j < 16; j++){
            W[j] = 
				(data[j*4]  <<24) | (data[j*4+1]<<16) | 
				(data[j*4+2]<<8)  | data[j*4+3];
        }
        // a)将消息分组划分成16个字W0...W15
        // b)for j = 16 to 67
        for (int j = 16; j < 68; j++) {
            W[j] = P1(W[j - 16] ^ W[j - 9] ^ ROTATE_LEFT(W[j - 3], 15)) ^ ROTATE_LEFT(W[j - 13], 7) ^ W[j - 6];
        }
        for(int j = 0; j < 64; j++){
            W_[j] = W[j] ^ W[j+4];
        }

        //test W
        // printf("\nthe W result is:\n");
        // for(int j = 0; j < 68; j++){
        //     printf("%08x ", W[j]);
        //     if((j + 1) % 8 == 0) printf("\n");
        // }
        // //test W right
        // // test W_
        // printf("\nthe W_ result is:\n");
        // for(int j = 0; j < 64; j++){
        //     printf("%08x ", W_[j]);
        //     if((j + 1) % 8 == 0) printf("\n");
        // }
        //test W_ right

        //c)for j = 0 to 63 压缩函数
        // printf("\nA________B________C________D________E________F________G________H\n");
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

            // printf("%08x ", A);
            // printf("%08x ", B);
            // printf("%08x ", C);
            // printf("%08x ", D);
            // printf("%08x ", E);
            // printf("%08x ", F);
            // printf("%08x ", G);
            // printf("%08x \n", H);
        }

        ctx->A ^= A;
        ctx->B ^= B;
        ctx->C ^= C;
        ctx->D ^= D;
        ctx->E ^= E;
        ctx->F ^= F;
        ctx->G ^= G;
        ctx->H ^= H;
    }
}

//更新函数SM3_Update
int SM3_Update(SM3_CTX *c, const void *data_, size_t len)
{
    const unsigned char* data = (unsigned char*)data_;
    unsigned char* p;
    HASH_LONG l;
    size_t n;

    if(len == 0) return 1;

    l = (c->Nl + (((HASH_LONG) len) << 3)) & 0xffffffffUL;
    if (l < c->Nl)
        c->Nh++;
    c->Nh += (HASH_LONG) (len >> 29);
    c->Nl = l;

    n = c->num;
    if (n != 0) {
        p = (unsigned char *)c->data;

        if (len >= HASH_CBLOCK || len + n >= HASH_CBLOCK) {
            memcpy(p + n, data, HASH_CBLOCK - n);
            SM3_block_data_order(c, p, 1);
            n = HASH_CBLOCK - n;
            data += n;
            len -= n;
            c->num = 0;
            memset(p, 0, HASH_CBLOCK); /* keep it zeroed */
        } else {
            memcpy(p + n, data, len);
            c->num += (unsigned int)len;
            return 1;
        }
    }

    n = len / HASH_CBLOCK;
    if (n > 0) {
        SM3_block_data_order(c, data, n);
        n *= HASH_CBLOCK;
        data += n;
        len -= n;
    }

    if (len != 0) {
        p = (unsigned char *)c->data;
        c->num = (unsigned int)len;
        memcpy(p, data, len);
    }
    return 1;
}

//SM3_Final
int SM3_Final(unsigned char *md, SM3_CTX *c)
{
    unsigned char *p = (unsigned char *)c->data;
    size_t n = c->num;
    p[n] = 0x80;
    n++;
    if (n > (HASH_CBLOCK - 8)) {
        memset(p + n, 0, HASH_CBLOCK - n);
        n = 0;
        SM3_block_data_order(c, p, 1);
    }
    memset(p + n, 0, HASH_CBLOCK - 8 - n);

    p += HASH_CBLOCK - 8;

    (void)HOST_l2c(c->Nh, p);
    (void)HOST_l2c(c->Nl, p);

    p -= HASH_CBLOCK;
    SM3_block_data_order(c, p, 1);
    c->num = 0;
    memset(p, 0, HASH_CBLOCK);

    HASH_MAKE_STRING(c, md);

    return 1;
}

