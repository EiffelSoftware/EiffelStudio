using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace XebraEventSourceInstaller
{
    class Program
    {
        static void Main(string[] args)
        {
            EventLog log = new EventLog("Application");
            if (!EventLog.SourceExists("XebraHandler"))
                EventLog.CreateEventSource("XebraHandler", "Application");

            log.Source = "XebraHandler";
            log.WriteEntry("Source successfully installed.", EventLogEntryType.Information);
        }
    }
}
