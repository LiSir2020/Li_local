#include "./SM3_h.h"

static const unsigned char input1[] = {
        0x61, 0x62, 0x63
};
static const unsigned char input2[] = {
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
    0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64
};

int main(){
    char *message;
    string s;
    printf("input your message here: ");
    scanf("%s", &s);
    message = (char*)malloc(s.length() * sizeof(char));
    for(int i = 0; i < s.length(); i++){
        message[i] = s[i];
    }
    SM3_CTX ctx1;//, ctx2;
    unsigned char md1[SM3_DIGEST_LENGTH];//, md2[SM3_DIGEST_LENGTH];

    int t1 = SM3_Init(&ctx1);
    printf("\nSM3_Init is: %d\n", t1);

    t1 = SM3_Update(&ctx1, message, sizeof(message));//this is important
    printf("\nSM3_Update is: %d\n", t1);

    t1 = SM3_Final(md1, &ctx1);
    printf("\nSM3_Final is: %d\n", t1);

    printf("\nhash value is:\n");
    printf("%08x ", ctx1.A);
    printf("%08x ", ctx1.B);
    printf("%08x ", ctx1.C);
    printf("%08x ", ctx1.D);
    printf("%08x ", ctx1.E);
    printf("%08x ", ctx1.F);
    printf("%08x ", ctx1.G);
    printf("%08x ", ctx1.H);

    return 0;
}
