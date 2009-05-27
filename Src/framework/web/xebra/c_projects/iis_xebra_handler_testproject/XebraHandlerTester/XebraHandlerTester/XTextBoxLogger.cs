using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace XebraHandlerTester
{
    class XTextBoxLogger : Xebra.XLogger
    {
        TextBox tb;

        public XTextBoxLogger(TextBox textBox)
        {
            this.tb = textBox;
        }

        #region XLogger Members

        public void Debug(string msg)
        {
            Log("[Debug] " + msg);
        }

        public void Error(string msg)
        {
            Log("[ERROR] " + msg);
        }

        public void Warning(string msg)
        {
            Log("[Warning] " + msg);
        }

        public void Info(string msg)
        {
            Log("[Info] " + msg);
        }

        private void Log(string msg)
        {
            tb.AppendText(msg + "\r\n");
        }

        #endregion
    }
}
