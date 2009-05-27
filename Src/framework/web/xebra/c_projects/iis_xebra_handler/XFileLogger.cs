using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Xebra
{
    class XFileLogger : XLogger
    {

        TextWriter file;

        public XFileLogger(string path)
        {
            file = new StreamWriter(path);            
        }

        ~XFileLogger()
	    {
            file.Close();
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
            file.WriteLine(msg);
        }

        #endregion
    }
}
