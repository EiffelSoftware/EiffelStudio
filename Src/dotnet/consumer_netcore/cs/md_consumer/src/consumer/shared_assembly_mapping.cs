using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Linq;
using System.Diagnostics;


namespace md_consumer
{

    class SHARED_ASSEMBLY_MAPPING
    {
        static public Dictionary<string,int> assembly_mapping_table = new Dictionary<string,int>();
        // static public int none;

        public int last_index() {
            return assembly_mapping_table.Count;
        }

        public SHARED_ASSEMBLY_MAPPING()
        {
            // assembly_mapping_cell = (new Dictionary<string,int>(), 0);
        }
        public Dictionary<string, int> assembly_mapping()
        {
            return assembly_mapping_table;
        }

        public int assembly_index(string? a_full_name)
        {
            if (a_full_name == null) {
                return -1;
            } else {
                if (assembly_mapping_table.ContainsKey(a_full_name)) {
                    return assembly_mapping_table[a_full_name];
                } else {
                    return -1;
                }
            }
        }
        public int assembly_index(AssemblyName an, bool is_strict=true)
        {
			// FIXME: check how to remain in the same .Net version.
			// Get assembly index for AssemblyName `an`, comparing only the assembly name
			// (ignoring the version value)
            string fn = an.FullName;
            if (fn != null && assembly_mapping_table.ContainsKey(fn)) {
                return assembly_mapping_table[fn];
            } else if (!is_strict) {
                string? tn = an.Name;
                if (tn != null) {
                    tn = tn + ",";
                    foreach(KeyValuePair<string, int> e in assembly_mapping_table) {
                        string k = e.Key;
                        if (k.StartsWith(tn)) {
                            return e.Value;
                        }
                    }
                }
            }
            return -1;
        }
        public int assembly_index(Assembly a)
        {
            return assembly_index(a.FullName);
        }
        public int assembly_index(Type t)
        {
            return assembly_index(t.Assembly.FullName);
        }        
        public bool is_assembly_mapped(string? a_full_name)
        {
            if (a_full_name == null) {
                return false;
            } else {
                return assembly_mapping_table.ContainsKey(a_full_name);
            }
        }
        public void record_assembly_mapping (int index, string a_full_name)
        {
            // Require
            //Debug.Assert(!is_assembly_mapped(a_full_name), "Not yet recorded!");

            // Console.WriteLine("# " + index + ": " + a_full_name);
            assembly_mapping_table.Add(a_full_name, index);
        }
        public void reset_assembly_mapping()
        {
            // Console.WriteLine("# RESET assembly mapping #");
            assembly_mapping_table = new Dictionary<string,int>();
        }

        public CONSUMED_REFERENCED_TYPE referenced_type_from_type (Type t)
            // Consumed type from `t'
        {
    //     require
    //         non_void_type: t /= Void
    //         is_visible: t.is_visible
            CONSUMED_REFERENCED_TYPE? res = null;
            if (t.IsByRef) {
                Type? l_type = t.GetElementType();
                if (l_type != null) { 
                    res = referenced_type_from_type (l_type);
                    if (res != null) {
                        res.set_is_by_ref();
                    }
                } else {
                    Debug.Assert(false, "from doc");
                }
            } else {
                Assembly l_assembly = t.Assembly;
                string? l_full_name = l_assembly.FullName;
                string? l_name = t.FullName;

                if (l_full_name != null && l_name != null) {
                    int id = -1;
                    if (is_assembly_mapped (l_full_name)) {
                        id = assembly_index(l_full_name);
                    } else {
                        // Could be a version conflict, try to search based on assembly name (ignoring version, ...).
                        AssemblyName an = l_assembly.GetName();
                        id = assembly_index(an, false);
                    }
                    if (id >= 0) {
                        if (t.IsArray) {
                            Type? l_type = t.GetElementType();
                            if (l_type != null) {
                                return new CONSUMED_ARRAY_TYPE(l_name, id, referenced_type_from_type (l_type));
                            } else {
                                Debug.Assert(false, "from doc");
                            }
                        } else {
                            return new CONSUMED_REFERENCED_TYPE(l_name, id);
                        }
                    } else {
                        Debug.Assert(false, "found");
                    }
                } else {
                    // Debug.Assert(false, "from doc");
                }
            }
            if (res == null) {
                // Debug.Assert (false, "has result");
                res = new CONSUMED_REFERENCED_TYPE(t.Name, -1);
                if (t.ContainsGenericParameters) {
                    res.has_generic_type = true;
                }
            }
            return res;
        }    
    }
}
