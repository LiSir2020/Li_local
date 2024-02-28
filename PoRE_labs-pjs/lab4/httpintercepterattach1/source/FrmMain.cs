using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net.Sockets;
using System.Threading;
using JrIntercepter.Net;

namespace JrIntercepter
{
    public partial class FrmMain : Form
    {
        private Proxy proxy; 
        // sessions    
        private IList<Session> sessions = new List<Session>(); 
 
        public FrmMain()
        {
            InitializeComponent();
            Control.CheckForIllegalCrossThreadCalls = false;

            pContainer.Dock = DockStyle.Fill;  
            pLeft.Dock = DockStyle.Left;
            pLeft.Width = this.Width/2;
            pLeftTop.Dock = DockStyle.Top;
            pSpliter.Dock = DockStyle.Bottom;  
            tbCommand.Dock = DockStyle.Bottom;  
            // tbDetail.Dock = DockStyle.Fill; 
            splitter3.Dock = DockStyle.Left;
            tbRequest.Dock = DockStyle.Top;
            tbResponse.Dock = DockStyle.Fill;    
            pBody.Dock = DockStyle.Fill;
            // statusStrip1.BringToFront();  

            lvSessions.Dock = DockStyle.Fill;
            lvSessions.BringToFront();  

            Intercepter.OnUpdateSession += new Intercepter.DelegateUpdateSession(this.UpdateSession);

            lvSessions.Columns.Add(new ColumnHeader() { 
                Text = "编号", 
                TextAlign = HorizontalAlignment.Center, 
                Width = 28 
            });
            lvSessions.Columns.Add(new ColumnHeader() { 
                Text = "主机", 
                TextAlign = HorizontalAlignment.Left, 
                Width = 130 
            });
            lvSessions.Columns.Add(new ColumnHeader() { 
                Text = "网址", 
                TextAlign = HorizontalAlignment.Left,
                Width=150 
            });
            lvSessions.Columns.Add(new ColumnHeader() { 
                Text = "方式", 
                TextAlign = HorizontalAlignment.Left,
                Width = 48
            });
            lvSessions.Columns.Add(new ColumnHeader() { 
                Text = "进程", 
                TextAlign = HorizontalAlignment.Left ,
                Width = 80
            });

            proxy = new Proxy();
            proxy.Start(Config.ListenPort);
        }
 
        internal void UpdateSession(Session session)
        {
            try
            {
                lock (lvSessions)
                {
                    sessions.Insert(0, session);
                    //  sessions.Add(session);

                    ListViewItem lvi = new ListViewItem();
                    lvi.Text = session.id.ToString();

                    // FullUrl
                    lvi.SubItems.Add(session.Host);
                    lvi.SubItems.Add(session.Request.Headers.RequestPath);
                    lvi.SubItems.Add(session.Request.Headers.HTTPMethod);
                    lvi.SubItems.Add(session.LocalProcessName);

                    this.lvSessions.Items.Insert(0, lvi);
                }
            }
            catch { 
            
            }
            /*
            this.textBox1.Text = session.Request.headers.HTTPMethod + " " 
                 + (session.Request.headers.Exists("Host") ? session.Request.headers["Host"] : "")  + " "      
                 + session.Request.headers.HTTPVersion + "\r\n" + this.textBox1.Text;  */ 
 

        }   
        
        private void lvSessions_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.lvSessions.SelectedItems.Count > 0)
            {
                int index = this.lvSessions.SelectedItems[0].Index;
                Session session = sessions[index];

                tbRequest.Text = session.Request.Headers.ToString();
                tbRequest.Text += "\r\n";
                tbRequest.Text += Encoding.UTF8.GetString(session.RequestBodyBytes);

                tbResponse.Text = session.Response.Headers.ToString();
                tbResponse.Text += "\r\n";

                // 涉及压缩和编码问题，暂不显示    
                // session.Response.headers.
                // tbResponse.Text += Encoding.UTF8.GetString(session.ResponseBodyBytes);  
            }       
        }

        private void btnClearSessions_Click(object sender, EventArgs e)
        {
            lvSessions.Items.Clear();
            sessions.Clear();  
        }

        private void FrmMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (proxy != null)
            {
                proxy.Stop();
            }  
        }  
    }
}
