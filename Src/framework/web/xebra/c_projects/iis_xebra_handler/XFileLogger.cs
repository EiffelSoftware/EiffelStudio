/*
* description:  "Implementation of XLogger. Logs to a file."
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
