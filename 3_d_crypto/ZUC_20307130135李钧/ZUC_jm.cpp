#include "./ZUC_H.h"

int get_L_jm(uint32 length){
    uint32 t;
    t = length % 32;
    if(t == 0){
        return length/32;
    }
    else{
        return length/32 + 1;
    }
}

void ZUC_jm_Init(uint8 *ck, uint8 *count,
                uint8 *KEY, uint8 *IV,
                uint8 bearer, uint8 direction, int &keylen){
    //init KEY
    keylen = get_L_jm(LENGTH);
    for(uint8 i = 0; i < 16; i++){
        KEY[i] = ck[i];
        printf("%02x ", KEY[i]);// test
    }
    printf("\nKEY init above, and count below\n");
    for(uint8 i = 0; i < 4; i++) printf("%02x", count[i]);
    printf("\n");
    //init IV
    for(uint8 i = 0; i < 4; i++)
        IV[i] = count[i];
    IV[4] = ((bearer << 3) & 0xf8) | ((direction << 2) & 0x4);
    IV[5] = 0x00; IV[6] = 0x00; IV[7] = 0x00;
    for(uint8 i = 8; i < 16; i++)
        IV[i] = IV[i - 8];
    
    //show IV
    printf("this is IV below:\n");
    for(uint8 i = 0; i < 16; i++){
        printf("%02x ", IV[i]);
        if(i==7) printf("\n");
    }
    printf("\n");
}

void ZUC_jm_en(uint32 *ibs, uint32 *k, uint32 length, uint32 *obs, int keylen){
    for(int i = 0; i < length/32; i++){
        obs[i] = (ibs[i] ^ k[i]);
    }
    printf("OBS is:\n");
    for(int i = 0; i < keylen; i++)
        printf("%08x ", OBS[i]);
}
