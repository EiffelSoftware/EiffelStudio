using System;
using System.Text;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;
using System.Diagnostics;


namespace md_consumer
{

    class METHOD_RETRIEVER
    {
        public static MethodInfo? property_getter (PropertyInfo prop)
        // Get `getter` of `prop` if exists.
        {
            try {
                return prop.GetGetMethod(true);
            } catch {
                return null;
            }
        }
        public static MethodInfo? property_setter (PropertyInfo prop)
        // Get `setter` of `prop` if exists.
        {
            try {
                return prop.GetSetMethod(true);
            } catch {
                return null;
            }
        }        
        public static MethodInfo? event_adder (EventInfo ev)
        // Get `adder` of event `ev` if exists.
        {
            try {
                return ev.GetAddMethod(true);
            } catch {
                return null;
            }
        }
        public static MethodInfo? event_remover (EventInfo ev)
        // Get `remover` of event `ev` if exists.
        {
            try {
                return ev.GetRemoveMethod(true);
            } catch {
                return null;
            }
        }  
        public static MethodInfo? event_raiser (EventInfo ev)
        // Get `raiser` of event `ev` if exists.
        {
            try {
                return ev.GetRaiseMethod(true);
            } catch {
                return null;
            }
        }                      
    }
}
