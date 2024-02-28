.class public Lcom/pore/haveagoodtime/HappyTime;
.super Ljava/lang/Object;
.source "HappyTime.java"


# static fields
.field static res:[C

.field static res2:[I

.field static str1:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-string v0, "native-lib"

    .line 8
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    const-string v0, "smali"

    .line 14
    sput-object v0, Lcom/pore/haveagoodtime/HappyTime;->str1:Ljava/lang/String;

    const/16 v0, 0x10

    new-array v1, v0, [C

    .line 15
    fill-array-data v1, :array_0

    sput-object v1, Lcom/pore/haveagoodtime/HappyTime;->res:[C

    new-array v0, v0, [I

    .line 16
    fill-array-data v0, :array_1

    sput-object v0, Lcom/pore/haveagoodtime/HappyTime;->res2:[I

    return-void

    :array_0
    .array-data 2
        0x23s
        0x22s
        0x33s
        0x29s
        0x19s
        0x1cs
        0x1fs
        0x4s
        0x3cs
        0x6s
        0x21s
        0x28s
        0x11s
        0x23s
        0x1bs
        0x16s
    .end array-data

    :array_1
    .array-data 4
        0x5f
        0x4b
        0x50
        0xc3
        0x24
        0xed
        0xf1
        0x91
        -0x14
        0x6d
        0xc6
        0x75
        0xca
        0x35
        0x4c
        0x63
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static native crypt([BJI)[B
.end method

.method public static generateArray(Ljava/lang/String;)[B
    .locals 6

    const/16 v0, 0x10

    new-array v1, v0, [B

    const/4 v2, 0x0

    const/4 v3, 0x0

    .line 35
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 37
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    sget-object v5, Lcom/pore/haveagoodtime/HappyTime;->res2:[I

    aget v5, v5, v3

    sub-int/2addr v4, v5

    int-to-byte v4, v4

    aput-byte v4, v1, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    :goto_1
    if-ge v2, v0, :cond_1

    .line 39
    aget-byte p0, v1, v2

    .line 40
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    const-string v3, "byte"

    invoke-static {v3, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    return-object v1
.end method

.method public static getKey(Ljava/lang/String;)Ljava/lang/Boolean;
    .locals 5

    .line 21
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x0

    .line 22
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    const/16 v3, 0x10

    if-eq v0, v3, :cond_0

    return-object v2

    .line 24
    :cond_0
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 26
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    sget-object v3, Lcom/pore/haveagoodtime/HappyTime;->str1:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    rem-int v4, v1, v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->charAt(I)C

    move-result v3

    xor-int/2addr v0, v3

    int-to-char v0, v0

    sget-object v3, Lcom/pore/haveagoodtime/HappyTime;->res:[C

    aget-char v3, v3, v1

    if-eq v0, v3, :cond_1

    return-object v2

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    const/4 p0, 0x1

    .line 29
    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0
.end method

.method public static native read(Ljava/lang/String;J)[B
.end method
