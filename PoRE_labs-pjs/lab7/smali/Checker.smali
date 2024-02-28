###### Class defpackage.Checker (Checker)
.class public LChecker;
.super Ljava/lang/Object;
.source "Checker.java"


# instance fields
.field secret:[B


# direct methods
.method public constructor <init>()V
    .registers 2

    .prologue
    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    const/16 v0, 0x8

    new-array v0, v0, [B

    fill-array-data v0, :array_e

    iput-object v0, p0, LChecker;->secret:[B

    return-void

    nop

    :array_e
    .array-data 1
        0x70t
        0x64t
        0x64t
        0x44t
        0x1ft
        0x5t
        0x72t
        0x78t
    .end array-data
.end method

.method private static charToByteAscii(C)B
    .registers 2

    .prologue
    .line 6
    int-to-byte v0, p0

    .line 7
    return v0
.end method

.method private checkStr1(Ljava/lang/String;)Z
    .registers 6

    .prologue
    const/4 v1, 0x0

    .line 11
    move v0, v1

    :goto_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_1d

    .line 12
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, LChecker;->charToByteAscii(C)B

    move-result v2

    mul-int/lit8 v3, v0, 0xb

    xor-int/2addr v2, v3

    iget-object v3, p0, LChecker;->secret:[B

    aget-byte v3, v3, v0

    if-eq v2, v3, :cond_1a

    .line 16
    :goto_19
    return v1

    .line 11
    :cond_1a
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 16
    :cond_1d
    const/4 v1, 0x1

    goto :goto_19
.end method

.method private checkStr2(Ljava/lang/String;)Z
    .registers 6

    .prologue
    const/4 v0, 0x0

    .line 21
    :try_start_1
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 22
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/16 v3, 0x3e8

    if-ge v2, v3, :cond_12

    .line 31
    :cond_11
    :goto_11
    return v0

    .line 25
    :cond_12
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    rem-int/lit8 v2, v2, 0x10

    if-eqz v2, :cond_2c

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    rem-int/lit8 v2, v2, 0x1b

    if-eqz v2, :cond_2c

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    rem-int/lit8 v1, v1, 0xa
    :try_end_28
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_28} :catch_2e

    const/16 v2, 0x8

    if-ne v1, v2, :cond_11

    .line 31
    :cond_2c
    const/4 v0, 0x1

    goto :goto_11

    .line 28
    :catch_2e
    move-exception v1

    goto :goto_11
.end method


# virtual methods
.method public check(Ljava/lang/String;)Z
    .registers 6

    .prologue
    const/16 v3, 0xc

    const/16 v2, 0x8

    const/4 v0, 0x0

    .line 35
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-eq v1, v3, :cond_c

    .line 43
    :cond_b
    :goto_b
    return v0

    .line 38
    :cond_c
    invoke-virtual {p1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 39
    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 40
    invoke-direct {p0, v1}, LChecker;->checkStr1(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    invoke-direct {p0, v2}, LChecker;->checkStr2(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 41
    const/4 v0, 0x1

    goto :goto_b
.end method

