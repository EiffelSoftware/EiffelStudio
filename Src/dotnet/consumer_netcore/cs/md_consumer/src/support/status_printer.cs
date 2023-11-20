using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;
using System.Diagnostics;
using System.Runtime.Loader;

namespace md_consumer
{
    public class STATUS_PRINTER
    {
        private static int mode = 0;
        private static int debug_level = 0;
        private static bool using_diagnostic = true;
        const int mode_info = 1;
        const int mode_warning = 2;
        const int mode_error = 4;
        const int mode_debug = 8;
        private static void set_mode_flag(int f, bool b)
        {
            if (b) {
                mode = mode | f;
            } else {
                mode = mode ^ f;
            }
        }        
        public static void setup(bool is_console=true)
        {
            if (is_console) {
                System.Diagnostics.Trace.Listeners.Add(new TextWriterTraceListener(Console.Out));
                // System.Diagnostics.Debug.Listeners.Add(new TextWriterTraceListener(Console.Out));
            }
            Trace.AutoFlush = true;            
        }
        public static void set_info(bool b)
        {
            set_mode_flag (mode_info, b);
        }
        public static void set_warning(bool b)
        {
            set_mode_flag (mode_warning, b);
        }
        public static void set_error(bool b)
        {
            set_mode_flag (mode_error, b);
        }
        public static void set_debug(bool b, int dbg_level=0)
        {
            debug_level = dbg_level;
            set_mode_flag (mode_debug, b);
        }
        static public void trace(string msg, int m) {
            if ((mode & m) == m) {
                if (using_diagnostic) {
                    if (m == mode_error) {
                        System.Diagnostics.Trace.WriteLine("[ERROR] " + msg);
                    } else if (m == mode_debug) {
                        System.Diagnostics.Trace.WriteLine("[DEBUG] "+ msg);
                        // System.Diagnostics.Debug.WriteLine(msg);
                    } else {
                        System.Diagnostics.Trace.WriteLine(msg);
                    }
                } else {
                    if (m == mode_error) {
                        Console.WriteLine("[ERROR] " + msg);
                    } else if (m == mode_debug) {
                        Console.WriteLine("[DEBUG] "+ msg);
                    } else {
                        Console.WriteLine(msg);
                    }
                }
            }
        }
        static public void info(string msg) {
            trace (msg, mode_info);
        }
        static public void error(string msg) {
            trace (msg, mode_error);
        }       
        static public void warning(string msg) {
            trace (msg, mode_warning);
        }         
        static public void debug(string msg, int lev=1) {
            if (debug_level <= lev) {
                trace (msg, mode_debug);
            }
        }
    }

}