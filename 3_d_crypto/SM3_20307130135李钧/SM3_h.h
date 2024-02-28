#include <iostream>
#include <stdlib.h>
#include <cstring>
using namespace std;

# define SM3_DIGEST_LENGTH 32
# define SM3_WORD unsigned int

# define SM3_CBLOCK      64
# define SM3_LBLOCK      (SM3_CBLOCK/4)

#define HASH_LONG SM3_WORD
#define HASH_CBLOCK 64

#define HOST_l2c(l,c) (*((c)++)=(unsigned char)(((l)>>24)&0xff), *((c)++)=(unsigned char)(((l)>>16)&0xff), *((c)++)=(unsigned char)(((l)>> 8)&0xff), *((c)++)=(unsigned char)(((l) )&0xff), l)
#define HASH_MAKE_STRING(c, s)              \
      do {                                  \
        unsigned long ll;                   \
        ll=(c)->A; (void)HOST_l2c(ll, (s)); \
        ll=(c)->B; (void)HOST_l2c(ll, (s)); \
        ll=(c)->C; (void)HOST_l2c(ll, (s)); \
        ll=(c)->D; (void)HOST_l2c(ll, (s)); \
        ll=(c)->E; (void)HOST_l2c(ll, (s)); \
        ll=(c)->F; (void)HOST_l2c(ll, (s)); \
        ll=(c)->G; (void)HOST_l2c(ll, (s)); \
        ll=(c)->H; (void)HOST_l2c(ll, (s)); \
      } while (0)


typedef struct SM3state_st {
   SM3_WORD A, B, C, D, E, F, G, H;
   SM3_WORD Nl, Nh;
   SM3_WORD data[SM3_LBLOCK];
   unsigned int num;
} SM3_CTX;

#define ROTATE_LEFT(x, n) (((x) << (n)) | ((x) >> (32 - (n))))
const int GROUP_SIZE = 512 / 8; // 分组长度，以字节为单位
const int MESSAGE_LENGTH_SIZE = 64 / 8; // 表示消息长度的二进制数长度

// 常数、常量
const unsigned long IV[8] = {0x7380166f, 0x4914b2b9, 0x172442d7, 0xda8a0600,
                            0xa96f30bc, 0x163138aa, 0xe38dee4d, 0xb0fb0e4e};
const long T_0_15 = 0x79cc4519;
const long T_16_63 = 0x7a879d8a;

// 基本函数
unsigned int FF(unsigned int X, unsigned int Y, unsigned int Z, int j);
unsigned int GG(unsigned int X, unsigned int Y, unsigned int Z, int j);
unsigned int P0(unsigned int x);
unsigned int P1(unsigned int x);

//实现函数
// void My_SM3(const char *message, const int message_len, unsigned int *hash);
int SM3_Init(SM3_CTX *c);
void SM3_block_data_order(SM3_CTX *ctx, const void *p, size_t num);
int SM3_Update(SM3_CTX *c, const void *data_, size_t len);
int SM3_Final(unsigned char *md, SM3_CTX *c);

