.class public Lcom/pore/haveagoodtime/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# instance fields
.field array:[B

.field flag:Ljava/lang/Boolean;

.field hint:Landroid/widget/TextView;

.field input:Landroid/widget/EditText;

.field pore:[C

.field random:Ljava/util/Random;

.field times:I

.field total:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    const/16 v0, 0xc

    .line 24
    iput v0, p0, Lcom/pore/haveagoodtime/MainActivity;->total:I

    const/4 v0, 0x0

    .line 25
    iput v0, p0, Lcom/pore/haveagoodtime/MainActivity;->times:I

    .line 26
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->flag:Ljava/lang/Boolean;

    .line 27
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    iput-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->random:Ljava/util/Random;

    const/4 v0, 0x4

    new-array v0, v0, [C

    .line 28
    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->pore:[C

    const/16 v0, 0x10

    new-array v0, v0, [B

    .line 29
    iput-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->array:[B

    return-void

    :array_0
    .array-data 2
        0x50s
        0x4fs
        0x52s
        0x45s
    .end array-data
.end method


# virtual methods
.method public buttonClick(Landroid/view/View;)V
    .locals 3

    .line 57
    iget-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->input:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    .line 58
    iget-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->flag:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_1

    .line 60
    invoke-static {p1}, Lcom/pore/haveagoodtime/HappyTime;->getKey(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    iput-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->flag:Ljava/lang/Boolean;

    .line 61
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 63
    iget-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->hint:Landroid/widget/TextView;

    const-string v1, "Success! Let\'s play a game."

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 64
    invoke-static {p1}, Lcom/pore/haveagoodtime/HappyTime;->generateArray(Ljava/lang/String;)[B

    move-result-object p1

    iput-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->array:[B

    :cond_0
    return-void

    .line 68
    :cond_1
    invoke-virtual {p0, p1}, Lcom/pore/haveagoodtime/MainActivity;->playGame(Ljava/lang/String;)V

    .line 69
    iget-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->hint:Landroid/widget/TextView;

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    iget v2, p0, Lcom/pore/haveagoodtime/MainActivity;->times:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v1

    iget v1, p0, Lcom/pore/haveagoodtime/MainActivity;->total:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    const-string v1, "%d / %d"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 70
    iget p1, p0, Lcom/pore/haveagoodtime/MainActivity;->times:I

    iget v0, p0, Lcom/pore/haveagoodtime/MainActivity;->total:I

    if-ne p1, v0, :cond_2

    .line 72
    iget-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->hint:Landroid/widget/TextView;

    const-string v0, "You WIN!!!"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 73
    invoke-virtual {p0}, Lcom/pore/haveagoodtime/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "Get the flag by yourself!"

    invoke-static {p1, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    invoke-virtual {p0}, Lcom/pore/haveagoodtime/MainActivity;->show()V

    :cond_2
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    .line 79
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b001c

    .line 80
    invoke-virtual {p0, p1}, Lcom/pore/haveagoodtime/MainActivity;->setContentView(I)V

    const p1, 0x7f08006d

    .line 81
    invoke-virtual {p0, p1}, Lcom/pore/haveagoodtime/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->input:Landroid/widget/EditText;

    const p1, 0x7f080084

    .line 82
    invoke-virtual {p0, p1}, Lcom/pore/haveagoodtime/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->hint:Landroid/widget/TextView;

    const p1, 0x7f08010d

    .line 84
    invoke-virtual {p0, p1}, Lcom/pore/haveagoodtime/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    return-void
.end method

.method public playGame(Ljava/lang/String;)V
    .locals 4

    .line 43
    iget-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->random:Ljava/util/Random;

    const/16 v1, 0x2710

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    .line 44
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 v1, 0x1

    if-ne p1,p1, :cond_0

    .line 45
    invoke-virtual {p0}, Lcom/pore/haveagoodtime/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "success"

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 46
    iget p1, p0, Lcom/pore/haveagoodtime/MainActivity;->times:I

    add-int/2addr p1, v1

    iput p1, p0, Lcom/pore/haveagoodtime/MainActivity;->times:I

    .line 47
    iget-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->array:[B

    const-wide/16 v2, 0x0

    invoke-static {p1, v2, v3, v1}, Lcom/pore/haveagoodtime/HappyTime;->crypt([BJI)[B

    move-result-object p1

    iput-object p1, p0, Lcom/pore/haveagoodtime/MainActivity;->array:[B

    goto :goto_0

    .line 50
    :cond_0
    invoke-virtual {p0}, Lcom/pore/haveagoodtime/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "WRONG, it is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :goto_0
    return-void
.end method

.method public show()V
    .locals 4

    .line 36
    iget-object v0, p0, Lcom/pore/haveagoodtime/MainActivity;->hint:Landroid/widget/TextView;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    new-instance v2, Ljava/lang/String;

    iget-object v3, p0, Lcom/pore/haveagoodtime/MainActivity;->array:[B

    invoke-direct {v2, v3}, Ljava/lang/String;-><init>([B)V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "flag{%s}"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
