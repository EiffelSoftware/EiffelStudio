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

    public class CONSUMED_ASSEMBLY_MAPPING
    {
        public List<CONSUMED_ASSEMBLY> assemblies;
        public CONSUMED_ASSEMBLY_MAPPING(List<CONSUMED_ASSEMBLY> lst)
        {
            assemblies = new List<CONSUMED_ASSEMBLY>(lst.Count);
            foreach (var c in lst) {
                assemblies.Add(c);
            }
        }
        public bool has_assembly(CONSUMED_ASSEMBLY ca)
        {
            return assemblies.Contains(ca);
        }
    }
    public class CONSUMED_ASSEMBLY_TYPES
    {
        public string[] eiffel_names; // Assembly types eiffel names
        public string[] dotnet_names; // Assembly types .Net names
        public int[] flags; // Flags
        public int[] positions; // Positions of types
        public int count = 0; // Number of types
        public CONSUMED_ASSEMBLY_TYPES(int a_count)
        {
            eiffel_names = new string[a_count];
            dotnet_names = new string[a_count];
            flags = new int[a_count];
            positions = new int[a_count];
            count =  a_count;
        }

        public string[] namespaces()
        {
            List<string> l_namespaces = new List<string>(count);
            foreach(string name in dotnet_names)
            {
                int i = name.LastIndexOf('.');
                if (i < 0) {
                    i = 0;
                }
                string ns = name.Substring(0, i - 1);
                if (!l_namespaces.Contains(ns)) {
                    l_namespaces.Add(ns);
                }
            }
            return l_namespaces.ToArray();
        }
        public int[] namespace_types(string ns)
        {
            List<int> l_types_index = new List<int>(count);
            int i = 0;
            foreach(string name in dotnet_names)
            {
                int l_index = name.IndexOf(ns);
                if (l_index == 0 && name.Count(c => (c == '.')) == 1) {
                    l_types_index.Add(i);
                }
                i = i + 1;
            }
            return l_types_index.ToArray();
        }

        private int index = 0; // Number of items inserted so far in arrays
        public void put (string dn, string en, bool a_int, bool a_enum, bool a_delegate, bool a_value_type, int a_pos)
        // Add type with Eiffel name `en`, and .Net name `dn`.
        // - a_int: is interface?
        // - a_enum: is enum?
        // - a_delegate : is delegate?
        // - a_value_type : is value type?
        // Put those information for position `a_pos`
        {
            int flag = 0;
            eiffel_names[index] = en;
            dotnet_names[index] = dn;
            positions[index] = a_pos;
            if (a_int) { flag = flag_is_interface; }
            else if (a_enum) { flag = flag_is_enum; }
            else if (a_delegate) { flag = flag_is_delegate; }
            else if (a_value_type) { flag = flag_is_value_type; }
            flags[index] = flag;

            index = index + 1;
        }

        static public int flag_is_class = 0;
        static public int flag_is_interface = 1;
        static public int flag_is_enum = 2;
        static public int flag_is_delegate = 3;
        static public int flag_is_value_type = 4;
    }
}
