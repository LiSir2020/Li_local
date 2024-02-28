namespace JrIntercepter
{
    partial class FrmMain
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要    
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmMain));
            this.pContainer = new System.Windows.Forms.Panel();
            this.pBody = new System.Windows.Forms.Panel();
            this.tbResponse = new System.Windows.Forms.TextBox();
            this.splitter1 = new System.Windows.Forms.Splitter();
            this.tbRequest = new System.Windows.Forms.TextBox();
            this.splitter3 = new System.Windows.Forms.Splitter();
            this.pLeft = new System.Windows.Forms.Panel();
            this.pLeftTop = new System.Windows.Forms.Panel();
            this.btnClearSessions = new System.Windows.Forms.Button();
            this.pSpliter = new System.Windows.Forms.Panel();
            this.tbCommand = new System.Windows.Forms.TextBox();
            this.splitter2 = new System.Windows.Forms.Splitter();
            this.lvSessions = new System.Windows.Forms.ListView();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.文件FToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.pContainer.SuspendLayout();
            this.pBody.SuspendLayout();
            this.pLeft.SuspendLayout();
            this.pLeftTop.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // pContainer
            // 
            this.pContainer.Controls.Add(this.pBody);
            this.pContainer.Controls.Add(this.splitter3);
            this.pContainer.Controls.Add(this.pLeft);
            this.pContainer.Location = new System.Drawing.Point(66, 25);
            this.pContainer.Name = "pContainer";
            this.pContainer.Size = new System.Drawing.Size(745, 431);
            this.pContainer.TabIndex = 0;
            // 
            // pBody
            // 
            this.pBody.Controls.Add(this.tbResponse);
            this.pBody.Controls.Add(this.splitter1);
            this.pBody.Controls.Add(this.tbRequest);
            this.pBody.Location = new System.Drawing.Point(398, 24);
            this.pBody.Name = "pBody";
            this.pBody.Size = new System.Drawing.Size(322, 376);
            this.pBody.TabIndex = 8;
            // 
            // tbResponse
            // 
            this.tbResponse.Location = new System.Drawing.Point(33, 228);
            this.tbResponse.Multiline = true;
            this.tbResponse.Name = "tbResponse";
            this.tbResponse.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.tbResponse.Size = new System.Drawing.Size(322, 100);
            this.tbResponse.TabIndex = 4;
            // 
            // splitter1
            // 
            this.splitter1.Dock = System.Windows.Forms.DockStyle.Top;
            this.splitter1.Location = new System.Drawing.Point(0, 0);
            this.splitter1.Name = "splitter1";
            this.splitter1.Size = new System.Drawing.Size(322, 8);
            this.splitter1.TabIndex = 3;
            this.splitter1.TabStop = false;
            // 
            // tbRequest
            // 
            this.tbRequest.Location = new System.Drawing.Point(37, 0);
            this.tbRequest.Multiline = true;
            this.tbRequest.Name = "tbRequest";
            this.tbRequest.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.tbRequest.Size = new System.Drawing.Size(338, 209);
            this.tbRequest.TabIndex = 2;
            // 
            // splitter3
            // 
            this.splitter3.Location = new System.Drawing.Point(0, 0);
            this.splitter3.Name = "splitter3";
            this.splitter3.Size = new System.Drawing.Size(8, 431);
            this.splitter3.TabIndex = 9;
            this.splitter3.TabStop = false;
            // 
            // pLeft
            // 
            this.pLeft.AccessibleName = "";
            this.pLeft.Controls.Add(this.pLeftTop);
            this.pLeft.Controls.Add(this.pSpliter);
            this.pLeft.Controls.Add(this.tbCommand);
            this.pLeft.Controls.Add(this.splitter2);
            this.pLeft.Controls.Add(this.lvSessions);
            this.pLeft.Location = new System.Drawing.Point(0, 24);
            this.pLeft.Name = "pLeft";
            this.pLeft.Size = new System.Drawing.Size(371, 376);
            this.pLeft.TabIndex = 7;
            // 
            // pLeftTop
            // 
            this.pLeftTop.Controls.Add(this.btnClearSessions);
            this.pLeftTop.Location = new System.Drawing.Point(34, 17);
            this.pLeftTop.Name = "pLeftTop";
            this.pLeftTop.Size = new System.Drawing.Size(200, 25);
            this.pLeftTop.TabIndex = 4;
            // 
            // btnClearSessions
            // 
            this.btnClearSessions.Dock = System.Windows.Forms.DockStyle.Left;
            this.btnClearSessions.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClearSessions.Location = new System.Drawing.Point(0, 0);
            this.btnClearSessions.Name = "btnClearSessions";
            this.btnClearSessions.Size = new System.Drawing.Size(25, 25);
            this.btnClearSessions.TabIndex = 0;
            this.btnClearSessions.Tag = "";
            this.btnClearSessions.Text = "C";
            this.btnClearSessions.UseVisualStyleBackColor = true;
            this.btnClearSessions.Click += new System.EventHandler(this.btnClearSessions_Click);
            // 
            // pSpliter
            // 
            this.pSpliter.Location = new System.Drawing.Point(42, 318);
            this.pSpliter.Name = "pSpliter";
            this.pSpliter.Size = new System.Drawing.Size(200, 10);
            this.pSpliter.TabIndex = 3;
            // 
            // tbCommand
            // 
            this.tbCommand.BackColor = System.Drawing.SystemColors.InfoText;
            this.tbCommand.ForeColor = System.Drawing.SystemColors.Window;
            this.tbCommand.Location = new System.Drawing.Point(34, 352);
            this.tbCommand.Name = "tbCommand";
            this.tbCommand.Size = new System.Drawing.Size(100, 21);
            this.tbCommand.TabIndex = 2;
            // 
            // splitter2
            // 
            this.splitter2.Location = new System.Drawing.Point(0, 0);
            this.splitter2.Name = "splitter2";
            this.splitter2.Size = new System.Drawing.Size(3, 376);
            this.splitter2.TabIndex = 1;
            this.splitter2.TabStop = false;
            // 
            // lvSessions
            // 
            this.lvSessions.FullRowSelect = true;
            this.lvSessions.Location = new System.Drawing.Point(34, 70);
            this.lvSessions.Name = "lvSessions";
            this.lvSessions.Size = new System.Drawing.Size(208, 220);
            this.lvSessions.TabIndex = 0;
            this.lvSessions.UseCompatibleStateImageBehavior = false;
            this.lvSessions.View = System.Windows.Forms.View.Details;
            this.lvSessions.SelectedIndexChanged += new System.EventHandler(this.lvSessions_SelectedIndexChanged);
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.文件FToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(889, 24);
            this.menuStrip1.TabIndex = 1;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // 文件FToolStripMenuItem
            // 
            this.文件FToolStripMenuItem.Name = "文件FToolStripMenuItem";
            this.文件FToolStripMenuItem.Size = new System.Drawing.Size(57, 20);
            this.文件FToolStripMenuItem.Text = "文件(&F)";
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 516);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(889, 22);
            this.statusStrip1.TabIndex = 2;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.ForeColor = System.Drawing.Color.Black;
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(43, 17);
            this.toolStripStatusLabel1.Text = "状态栏";
            // 
            // FrmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(889, 538);
            this.Controls.Add(this.pContainer);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menuStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FrmMain";
            this.Text = "主界面";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.FrmMain_FormClosed);
            this.pContainer.ResumeLayout(false);
            this.pBody.ResumeLayout(false);
            this.pBody.PerformLayout();
            this.pLeft.ResumeLayout(false);
            this.pLeft.PerformLayout();
            this.pLeftTop.ResumeLayout(false);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel pContainer;
        private System.Windows.Forms.Panel pBody;
        private System.Windows.Forms.TextBox tbResponse;
        private System.Windows.Forms.Splitter splitter1;
        public System.Windows.Forms.TextBox tbRequest;
        private System.Windows.Forms.Splitter splitter3;
        private System.Windows.Forms.Panel pLeft;
        private System.Windows.Forms.Panel pSpliter;
        private System.Windows.Forms.TextBox tbCommand;
        private System.Windows.Forms.Splitter splitter2;
        private System.Windows.Forms.ListView lvSessions;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem 文件FToolStripMenuItem;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.Panel pLeftTop;
        private System.Windows.Forms.Button btnClearSessions;




    }
}

