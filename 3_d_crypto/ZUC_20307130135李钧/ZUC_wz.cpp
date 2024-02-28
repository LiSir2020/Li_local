#include "./ZUC_H.h"

int get_L_wz(uint32 length){
    uint32 t;
    t = length % 32;
    if(t == 0){
        return length/32 + 2;
    }
    else{
        return length/32 + 3;
    }
}

uint32 GET_WORD(uint32 *DATA, uint32 i){
    uint32 WORD, ti;
    ti = i % 32;
    if(ti == 0){
        WORD = DATA[i/32];
    }
    else{
        WORD = (DATA[i/32] << ti) | (DATA[i/32 + 1] >> (32 - ti));
    }
    return WORD;
}

uint8 GET_BIT(uint32 *DATA, uint32 i){
    return (DATA[i/32] & (1 << (31 - (i%32)))) ? 1 : 0;
}

void ZUC_wz_Init(uint8 *ik, uint8 *count,
                uint8 *KEY, uint8 *IV,
                uint8 bearer, uint8 direction, int &keylen){
    keylen = get_L_wz(LENGTH_w);
    //init KEY
    for(uint8 i = 0; i < 16; i++){
        KEY[i] = ik[i];
        printf("%02x ", KEY[i]);// test
    }
    printf("\nKEY init above, and count below\n");
    for(uint8 i = 0; i < 4; i++) printf("%02x", count[i]);
    //init IV
    for(uint8 i = 0; i < 4; i++)
        IV[i] = count[i];
    IV[4] = (bearer << 3) & 0xf8;
    IV[5] = 0x00; IV[6] = 0x00; IV[7] = 0x00;
    IV[8] = IV[0] ^ ((direction & 1) << 7);
    for(uint8 i = 9; i < 14; i++)
        IV[i] = IV[i - 8];
    IV[14] = IV[6] ^ ((direction & 1) << 7);
    IV[15] = IV[7];

    //show IV
    printf("\nthis is IV below:\n");
    for(uint8 i = 0; i < 16; i++){
        printf("%02x ", IV[i]);
        if(i==7) printf("\n");
    }
    printf("\nBEARER is %x, DIRECTION is %x", bearer, direction);
}

uint32 ZUC_MAC(uint32 *m, uint32 *k, uint32 length){
    uint32 T = 0;
    uint32 mac;
    printf("into the ZUC_MAC, length: %d\n", length);
    for(uint32 i = 0; i < length; i++){
        if(GET_BIT(m, i)){
            T = T ^ GET_WORD(k, i);
        }        
    }
    T = T ^ GET_WORD(k, length);
    int L = get_L_wz(length);
    mac = T ^ k[L-1];
    printf("\nMAC is %08x\n", mac);

    //0xfae8ff0b
    return mac;
}
