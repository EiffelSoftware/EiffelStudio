/*
* description:  "Implementation of XLogger. Logs to Windows EventLog."
* date:		"$Date: 2009-05-15 15:41:52 -0700 (Fri, 15 May 2009) $"
* revision:	"$Revision: 78721 $"
* copyright:	"Copyright (c) 1985-2007, Eiffel Software."
* license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
* licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
* copying: ""
* source: 	"[
* 			Eiffel Software
* 			5949 Hollister Ave #B, Goleta, CA 93117
* 			Telephone 805-685-1006, Fax 805-685-6869
* 			Website http://www.eiffel.com
* 			Customer support http://support.eiffel.com
* 			]"
*/
﻿using System;
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
