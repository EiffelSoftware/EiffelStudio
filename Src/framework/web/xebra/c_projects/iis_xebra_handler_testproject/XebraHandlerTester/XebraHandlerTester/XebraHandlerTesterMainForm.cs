using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Xebra;

namespace XebraHandlerTester
{
    public partial class XebraHandlerTesterMainForm : Form
    {
        XServerConnection srv;
        XTextBoxLogger log;
        string html = "nothin";

        public XebraHandlerTesterMainForm()
        {
            InitializeComponent();
            webBrowser1.Navigated += new WebBrowserNavigatedEventHandler(webBrowser1_Navigated);
            webBrowser1.Navigate("about:blank");
            log = new XTextBoxLogger(this.textBox2);
        }

       

       
        

        private void button1_Click(object sender, EventArgs e)
        {
            string response;
            srv = new XServerConnection(log);
            srv.connect();
            srv.sendMessage(textBox1.Text);
            response = srv.receiveMessage();
            html = response.Substring(response.IndexOf("#H#") + 3);
            textBox2.AppendText("\r\nRESPONSE:'" + response + "'");           
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        public void outputter(String s)
        {
            textBox2.AppendText(s + "\r\n");
        }

        private void webBrowser1_Navigated(object sender, WebBrowserNavigatedEventArgs e)
        {
            HtmlDocument htmlDocument = webBrowser1.Document;
            HtmlElement body = htmlDocument.Body;
            body.InnerHtml = html;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            webBrowser1.Navigate("about:blank");
        }

        
    }
}
