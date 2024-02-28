###### Class defpackage.CheckBox (CheckBox)
.class public LCheckBox;
.super Ljava/lang/Object;
.source "CheckBox.java"


# instance fields
.field checker:LChecker;

.field encoder:LEncoder;


# direct methods
.method public constructor <init>()V
    .registers 2

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 5
    new-instance v0, LChecker;

    invoke-direct {v0}, LChecker;-><init>()V

    iput-object v0, p0, LCheckBox;->checker:LChecker;

    .line 6
    new-instance v0, LEncoder;

    invoke-direct {v0}, LEncoder;-><init>()V

    iput-object v0, p0, LCheckBox;->encoder:LEncoder;

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 6

    .prologue
    const/4 v4, 0x0

    .line 22
    new-instance v0, LCheckBox;

    invoke-direct {v0}, LCheckBox;-><init>()V

    .line 24
    array-length v1, p0

    const/4 v2, 0x1

    if-eq v1, v2, :cond_12

    .line 25
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "please choose task through command line parameter"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 45
    :goto_11
    return-void

    .line 29
    :cond_12
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "input: "

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->print(Ljava/lang/String;)V

    .line 30
    new-instance v1, Ljava/util/Scanner;

    sget-object v2, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v1, v2}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 31
    invoke-virtual {v1}, Ljava/util/Scanner;->nextLine()Ljava/lang/String;

    move-result-object v1

    .line 33
    aget-object v2, p0, v4

    const-string v3, "task1"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4b

    .line 34
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "task 1: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0, v1}, LCheckBox;->check(Ljava/lang/String;)Z

    move-result v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_11

    .line 36
    :cond_4b
    aget-object v2, p0, v4

    const-string v3, "task2"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8e

    .line 37
    invoke-virtual {v0, v1}, LCheckBox;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 38
    invoke-virtual {v0, v1}, LCheckBox;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 39
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "encode: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 40
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "decode: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_11

    .line 43
    :cond_8e
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "Please choose task"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto/16 :goto_11
.end method


# virtual methods
.method public check(Ljava/lang/String;)Z
    .registers 3

    .prologue
    .line 9
    iget-object v0, p0, LCheckBox;->checker:LChecker;

    invoke-virtual {v0, p1}, LChecker;->check(Ljava/lang/String;)Z

    move-result v0

    .line 10
    return v0
.end method

.method public decode(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .prologue
    .line 18
    iget-object v0, p0, LCheckBox;->encoder:LEncoder;

    invoke-virtual {v0, p1}, LEncoder;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public encode(Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .prologue
    .line 14
    iget-object v0, p0, LCheckBox;->encoder:LEncoder;

    invoke-virtual {v0, p1}, LEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

