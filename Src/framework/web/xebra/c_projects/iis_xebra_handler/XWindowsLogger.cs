using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;

namespace Xebra
{
    class XWindowsLogger : XLogger
    {
        #region XLogger Members

        public void Debug(string msg)
        {
            Info(msg);
        }

        public void Error(string msg)
        {
            Log(msg, EventLogEntryType.Error);
        }

        public void Info(string msg)
        {
            Log(msg, EventLogEntryType.Information);
        }

        public void Warning(string msg)
        {
            Log(msg, EventLogEntryType.Warning);
        }
     
        private void Log(String msg, EventLogEntryType type)
        {
            if (msg.Length > 32766)
                EventLog.WriteEntry("XebraHandler", msg.Substring(0,32766), type);
            else
                EventLog.WriteEntry("XebraHandler", msg, type);
        }
        #endregion
    }
}
