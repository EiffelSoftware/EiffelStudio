﻿using System;
using System.Windows.Forms;

namespace XebraHandlerTester
{
    static class Program
    {
        /// <summary>
        /// Der Haupteinstiegspunkt für die Anwendung.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new XebraHandlerTesterMainForm());
        }
    }
}
