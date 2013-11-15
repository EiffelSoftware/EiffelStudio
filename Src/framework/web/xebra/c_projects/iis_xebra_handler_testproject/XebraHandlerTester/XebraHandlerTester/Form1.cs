using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace XebraHandlerTester
{
    public partial class Form1 : Form
    {
        XebraServerConnection srv;

        public Form1()
        {
            InitializeComponent();
            srv = new XebraServerConnection(outputter);
            srv.connect();
                
        }

        private void button1_Click(object sender, EventArgs e)
        {
      
            srv.sendMessage(textBox1.Text);

            textBox1.AppendText("\r\nRESPONSE:'" + srv.receiveMessage() + "'");
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        public void outputter(String s)
        {
            textBox2.AppendText(s + "\r\n");
            

        }
    }
}
