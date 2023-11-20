using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;
using System.Diagnostics;

namespace md_consumer
{
    class AssemblyConsumer : EC_CHECKED_ENTITY_FACTORY
    {
        // public Assembly assembly;
        string? destination_path_name;
        Dictionary<string, TYPE_CONSUMER> type_consumers;
        List<CONSUMED_ASSEMBLY> assembly_ids;
        int last_index=0;

        protected SHARED_ASSEMBLY_MAPPING shared_assembly_mapping;

        public AssemblyConsumer(string? cache_location=null)
        {
            shared_assembly_mapping = new SHARED_ASSEMBLY_MAPPING();

            // assembly = a;
            type_consumers = new Dictionary<string, TYPE_CONSUMER>();
            assembly_ids = new List<CONSUMED_ASSEMBLY>();
            destination_path_name = cache_location;
        }

        public bool assembly_ids_has (CONSUMED_ASSEMBLY ca)
        {
            foreach(CONSUMED_ASSEMBLY i in assembly_ids) {
                if (i.same_as (ca)) {
                    return true;
                }
            }
            return false;
        }

        public MdConsumerData consume(Assembly assembly, bool a_info_only)
        {
            MdConsumerData md_data = new MdConsumerData();
            if (a_info_only) {
                STATUS_PRINTER.info(string.Format("Beginning consumption for assembly '{0}'.", assembly.ToString()));
                STATUS_PRINTER.info(string.Format("Consuming into '{0}'.", destination_path_name));
            } else {
                STATUS_PRINTER.info(string.Format("Beginning full consumption for assembly '{0}'.", assembly.ToString()));
                STATUS_PRINTER.info(string.Format("Consuming fully into '{0}'.", destination_path_name));
            }
            //JFIAT 
            shared_assembly_mapping.reset_assembly_mapping();


            // AssemblyName[] l_referenced_assemblies = assembly.GetReferencedAssemblies();
            // int count = l_referenced_assemblies.Length;

            string location = assembly.Location;
            string? l_ass_full_name = assembly.FullName;

            if (l_ass_full_name != null) {
            	assembly_ids.Clear();
                CONSUMED_ASSEMBLY? ca = consumed_assembly(assembly);
                if (ca != null) {
                    assembly_ids.Add(ca);
                }
                if (!shared_assembly_mapping.is_assembly_mapped(l_ass_full_name)) { //JFIAT
                    last_index = shared_assembly_mapping.last_index() + 1;
                    shared_assembly_mapping.record_assembly_mapping(last_index, l_ass_full_name);
                }
                build_referenced_assemblies (assembly, a_info_only);
                prepare_consumed_types(assembly, a_info_only);
                serialize_consumed_types (a_info_only, md_data);
            }       
            return md_data;
        }
        public void build_referenced_assemblies (Assembly ass, bool a_info_only)
        {
            AssemblyName[] referenced_assemblies = ass.GetReferencedAssemblies();
            int count = referenced_assemblies.Length;
            if (count > 0) {
                foreach (AssemblyName l_assembly_name in referenced_assemblies)
                {
                    Assembly? l_ref_ass = null;
                    try {
                        l_ref_ass = SHARED_ASSEMBLY_LOADER.assembly_loader.assembly_from_name(l_assembly_name);
                    } catch {
                        l_ref_ass = null;
                    }
                    if (l_ref_ass == null) {
                        STATUS_PRINTER.debug(string.Format(" ! could not load assembly '{0}'.", l_assembly_name.ToString()));
                    } else {
                        string? l_ref_ass_full_name = l_ref_ass.FullName;
                        if (l_ref_ass_full_name != null) {
                            CONSUMED_ASSEMBLY? ca = consumed_assembly (l_ref_ass);
                            if (ca != null) {
                                if (!shared_assembly_mapping.is_assembly_mapped(l_ref_ass_full_name)) {
                                    last_index = shared_assembly_mapping.last_index() + 1;
                                    shared_assembly_mapping.record_assembly_mapping(last_index, l_ref_ass_full_name);
                                }
                                if (!assembly_ids_has(ca)) {
                                    assembly_ids.Add(ca);
                                        // Add also referenced assemblies of assembly referenced.
                                    build_referenced_assemblies (l_ref_ass, a_info_only);
                                }
                            }
                        }
                    }
                }
            }
        }

        public Dictionary<string,CONSUMED_ASSEMBLY> loaded_assemblies = new Dictionary<string, CONSUMED_ASSEMBLY>(10);
        protected CONSUMED_ASSEMBLY? consumed_assembly (Assembly ass)
        {
            try {
                CONSUMED_ASSEMBLY? ca = null;

                AssemblyName name = ass.GetName();
                string? l_full_name = name.FullName;

                if (l_full_name != null && loaded_assemblies.ContainsKey(l_full_name)) {
                    ca = loaded_assemblies[l_full_name];
                }
                if (ca == null) {
                    ca = AssemblyAnalyzer.new_consumed_assembly(ass, null);
                    if (l_full_name != null) {
                        ca.fullname = l_full_name;
                        loaded_assemblies.Add(l_full_name, ca);
                    }
                }
                return ca;
            } catch {
                return null;
            }
        }

        public void append_referenced_assembly (Assembly assembly, Utf8JsonWriter writer)
        {
            AssemblyName[] l_referenced_assemblies = assembly.GetReferencedAssemblies();
            if (l_referenced_assemblies.Length > 0) {
                writer.WritePropertyName(JSON_NAMES.referenced_assemblies);
                writer.WriteStartArray();
                foreach (AssemblyName n in l_referenced_assemblies)
                {
                    Assembly? a_ref = null;
                    try {
                        // Console.WriteLine("TRY to load ref ass " + n.Name + "\n");
                        a_ref = SHARED_ASSEMBLY_LOADER.assembly_loader.assembly_from_name(n);
                        // a_ref = Assembly.Load(n);
                    }
                    catch (FileNotFoundException fnf) { STATUS_PRINTER.error("while trying to load ref ass " + n.Name + ": FILE NOT FOUND ("+ fnf.FileName +")\n"); }
                    catch (FileLoadException) { STATUS_PRINTER.error("while trying to load ref ass " + n.Name + ": FILE LOAD EXCEPTION\n"); }
                    catch (BadImageFormatException) { STATUS_PRINTER.error("while trying to load ref ass " + n.Name + ": BAD IMAGE FORMAT EXCEPTION\n"); }
                    catch {
                        STATUS_PRINTER.error("while trying to load ref ass " + n.Name + ": EXCEPTION OCCURED\n");
                    }

                    writer.WriteStartObject();

                    if (a_ref != null) {
                        writer.WritePropertyName(JSON_NAMES.location);
                        writer.WriteStringValue(a_ref.Location);
                    }

                    (string? name, string? public_key_token, string culture, string? version) d;
                    d = AssemblyAnalyzer.assembly_name_tuple (n);
                    if (d.name != null) {
                        writer.WritePropertyName(JSON_NAMES.name);
                        writer.WriteStringValue(d.name);
                    }

                    writer.WritePropertyName(JSON_NAMES.version);
                    writer.WriteStringValue(d.version);
                    writer.WritePropertyName(JSON_NAMES.public_key_token);
                    writer.WriteStringValue(d.public_key_token);
                    writer.WritePropertyName(JSON_NAMES.culture);
                    writer.WriteStringValue(d.culture);
                    if (n.FullName != null) {
                        writer.WritePropertyName(JSON_NAMES.fullname);
                        writer.WriteStringValue(n.FullName);
                    }
                    
                    writer.WriteEndObject();
                }
                writer.WriteEndArray();
            }
        }

        public bool is_consumed_type (Type t)
        {
                return checked_type(t).is_eiffel_compliant();
        }

        private bool prepare_consumed_type_into (Type t, Dictionary <string,List<TYPE_NAME_SOLVER>> names, int assembly_id = -1)
        {
            if (is_consumed_type (t))
            {
                TYPE_NAME_SOLVER type_name = new TYPE_NAME_SOLVER(t, assembly_id);
                string simple_name = type_name.simple_name;
                List<TYPE_NAME_SOLVER>? l_names = null;
                if (names.ContainsKey(simple_name)) {
                    l_names = names[simple_name];
                }
                if (l_names == null) {
                    l_names = new List<TYPE_NAME_SOLVER>();
                    names.Add(simple_name, l_names);
                }
                l_names.Add(type_name);
                l_names.Sort();
                // l_names.Sort((a,b) => a.weight.CompareTo(b.weight));                        
                return true;
            } else {
                return false;
            }
        }

        public void prepare_consumed_types(Assembly assembly, bool a_info_only)
        {
            int generated_count = 0;
            Dictionary <string,List<TYPE_NAME_SOLVER>> names = new Dictionary<string, List<TYPE_NAME_SOLVER>>();
            Module[] l_modules = assembly.GetModules();
            foreach (Module m in l_modules)
            {
                Type[] l_types = m.GetTypes();
                foreach (Type t in l_types) 
                {
                    if (prepare_consumed_type_into(t, names)) {
                        generated_count = generated_count + 1;
                    }
                }                         
                // FIXME : check ... status_querier  see the Eiffel class ASSEMBLY_CONSUMER.prepare_consumed_types
            }
            try {
                Type[] l_fwd_types = assembly.GetForwardedTypes(); // FIXME : fetch assembly.GetForwardedTypes()  ? or rely on referenced assemblies? Review Eiffel .Net compiler and its dependency on "mscorlib" !!!
                if (l_fwd_types != null) {
                    foreach (Type t in l_fwd_types) 
                    {
                        int aid = shared_assembly_mapping.assembly_index(t);
                        if (prepare_consumed_type_into(t, names, aid)) {
                            generated_count = generated_count + 1;
                        }
                    }
                }
            } catch {
                // FIXME: Oups ...unable to load assembly. See why and if there is a cleaner way to handle the issue.

            }

            Dictionary<string,string> used_names = new Dictionary<string, string>();
            foreach (KeyValuePair<string,List<TYPE_NAME_SOLVER>> kvp in names) 
            {
                List<TYPE_NAME_SOLVER> l_type_names = kvp.Value;
                foreach (TYPE_NAME_SOLVER l_type_name in l_type_names)
                {
                    string? dn = l_type_name.internal_type.FullName;
                    if (dn == null) {
                        dn = l_type_name.internal_type.Name; // FIXME:should not reach this code
                    }
                    string sn = SHARED_NAME_FORMATTER.formatted_type_name (dn, used_names);
                    l_type_name.set_eiffel_name (sn);
                }
            }
            foreach (KeyValuePair<string,List<TYPE_NAME_SOLVER>> kvp in names) {
                List<TYPE_NAME_SOLVER> list = kvp.Value;
                foreach (TYPE_NAME_SOLVER tns in list) {
                    if (tns.eiffel_name.Contains('<') || tns.eiffel_name.Contains('`')) {  // TODO: handle generics!
                        //FIXME Not Yet Supported !! generic                        
                        STATUS_PRINTER.info(string.Format("Ignoring generic type '{0}'.", tns.eiffel_name));
                    } else {
                        // if (kvp.Value.Count > 1) {
                        //     Console.WriteLine(" *-> " + kvp.Key + ": " + tns.eiffel_name + " = " + tns.simple_name);
                        // } else {
                        //     Console.WriteLine("  -> " + kvp.Key + ": " + tns.eiffel_name + " = " + tns.simple_name);
                        // }
                        Type t = tns.internal_type;
                        TYPE_CONSUMER tc;
                        try {
                            if (a_info_only) {
                                // Expand type info ...
                                tc = new TYPE_INFO_ONLY_CONSUMER(t, tns.eiffel_name, tns.assembly_id);
                            } else {
                                tc = new TYPE_CONSUMER(t, tns.eiffel_name, tns.assembly_id);
                            }
                            type_consumers.Add(tns.eiffel_name, tc);
                            STATUS_PRINTER.debug(string.Format("Analyzed '{0}' ('{1}').", tc.consumed_type.dotnet_name, tc.consumed_type.eiffel_name));
                        }
                        catch (System.IO.FileNotFoundException ex)
                        {
                            // We are missing the required dependency assembly.
                            STATUS_PRINTER.error("missing dependency assembly: " + ex.ToString());
                        }
                    }                        
                }
            }
        }
        public void create_consumed_assembly_folders()
        {
            string? path = destination_path_name;
            if (path != null) {
                if (!Directory.Exists(path)) {
                    Directory.CreateDirectory(path);
                }
            }
        }
        public void serialize_consumed_types (bool a_info_only, MdConsumerData md_data)
        {  
            create_consumed_assembly_folders();

            CONSUMED_ASSEMBLY_TYPES types = new CONSUMED_ASSEMBLY_TYPES(type_consumers.Count);
            int l_file_position = 0; // TODO: used here?
            // writer.WritePropertyName("CONSUMED_TYPES");
            // writer.WriteStartArray();
            foreach (KeyValuePair<string, TYPE_CONSUMER> kvp in type_consumers)
            {
                TYPE_CONSUMER tc = kvp.Value;
                if (!a_info_only) {
                    tc.initialize();
                    if (!tc.initialized) {
                        // TODO Error
                        STATUS_PRINTER.error(string.Format("Error: TYPE_CONSUMER '{0}' is not initialized!", tc.eiffel_name));
                    } else {
                        CONSUMED_TYPE type = tc.consumed_type;
                        CONSUMED_REFERENCED_TYPE? parent = type.parent;
                        bool l_is_value_type = false;
                        bool l_is_delegate = false;
                        if (parent != null) {
                            string pn = parent.name;
                            l_is_value_type = pn.Equals("System.ValueType");
                            l_is_delegate = pn.Equals("System.MulticastDelegate") || pn.Equals("System.Delegate");
                        }
                        // Do not add base types in consumed data
                        if (!is_base_type(type.dotnet_name)) {
                            types.put(type.dotnet_name, type.eiffel_name, type.is_interface(), type.is_enum(), l_is_delegate, l_is_value_type, l_file_position, type.assembly_id);
                            // Delete constructor of System.Object for compiler
                            if (type.dotnet_name.Equals("System.Object")) {
                                type.set_constructors(new List<CONSUMED_CONSTRUCTOR>(0));
                            }
                            md_data.add_consumed_type(type);

                            if (destination_path_name != null) {
                                string s = Path.Combine(destination_path_name, classes_file_name);
                                // Append to file `s`
                                long file_size = md_data.serialize_type_to_json_file (type, s, true);
                                STATUS_PRINTER.debug(string.Format("Written '{0}': '{1}'", tc.eiffel_name, s));
                                l_file_position = (int) file_size;
                            }
                        }
                    }
                } else {
                    CONSUMED_TYPE type = tc.consumed_type;
                    if (!is_base_type(type.dotnet_name)) {
                        types.put(type.dotnet_name, type.eiffel_name, type.is_interface(), type.is_enum(), false, false, 0, type.assembly_id);
                    }
                }
            }
            // writer.WriteEndArray();

            //FIXME/TODO: serialize assembly_ids 
            // writer.WritePropertyName("assemblies");
            // writer.WriteStartObject();
            // writer.WritePropertyName("count");
            // writer.WriteNumberValue(assembly_ids.Count);
            md_data.set_assembly_types (types);
            // serialize_assembly_types_to_json (types, writer);
            md_data.set_assembly_mapping (assembly_ids);
            // serialize_assembly_mapping_to_json (assembly_ids, writer);
            // writer.WriteEndObject();

            if (destination_path_name != null) {
                string s = Path.Combine(destination_path_name, assembly_types_file_name);
                // Append to file `s`
                md_data.serialize_assembly_types_to_json_file (s);
                
                s = Path.Combine(destination_path_name, assembly_mapping_file_name);
                md_data.serialize_assembly_mapping_to_json_file (s);
        
                // md_data.serialize_to_json
            }        
        }
        static public string classes_file_name = "classes.info";
        static public string assembly_types_file_name = "types.info";
        static public string assembly_mapping_file_name = "referenced_assemblies.info";
              
        public bool is_base_type (string name)
        {
            switch(name) {
                case "System.Byte": return true; 
                case "System.Int16": return true;
                case "System.Int32": return true;
                case "System.Int64": return true;
                case "System.IntPtr": return true;
                case "System.UInt16": return true;
                case "System.UInt32": return true;
                case "System.UInt64": return true;
                case "System.UIntPtr": return true;
                case "System.Single": return true; 
                case "System.Double": return true; 
                case "System.Char": return true; 
                case "System.Boolean": return true;
                case "System.SByte": return true; 
                case "EiffelSoftware.Runtime.ANY": return true;
                default: return false;
            }
        }


        public void get_assembly_types(Assembly assembly, StringBuilder output)
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = true };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            if (assembly != null) {
                writer.WriteStartArray();
                foreach (TypeInfo t in assembly.GetTypes())
                {
                    //FIXME
                    try
                    {
                        JSON_CONSUMED_TYPE ct = new JSON_CONSUMED_TYPE(t);
                        ct.appendTypeNamesToJsonArray(writer);
                    }
                    catch (System.IO.FileNotFoundException ex)
                    {
                        // We are missing the required dependency assembly.
                        writer.WritePropertyName("#ERROR");
                        writer.WriteStringValue("Error: " + ex.Message);
                    }
                }
                writer.WriteEndArray(); // types
            }
            writer.Flush();
            ms.Close();

            output.AppendLine(System.Text.Encoding.UTF8.GetString(ms.ToArray()));
        }     
    
    }
}
