using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;

namespace md_consumer
{
    static class SHARED_ASSEMBLY_LOADER
    {
        public static ASSEMBLY_LOADER assembly_loader = new ASSEMBLY_LOADER(null);
        public static void set_assembly_loader(ASSEMBLY_LOADER loader)
        {
            assembly_loader = loader;
        }
    }
    class ASSEMBLY_LOADER : IDisposable
    {
        MetadataLoadContext? md_context;
        public List<string>? locations;
        Dictionary<string,Assembly?> loaded_assemblies;

        public ASSEMBLY_LOADER(List<string>? locs)
        {
            locations = locs;
            loaded_assemblies = new Dictionary<string,Assembly?>(1);
        }
        public Assembly? loaded_assembly (string n)
        {
            if (loaded_assemblies.ContainsKey(n)) {
                return loaded_assemblies[n];
            } else {
                return null;
            }
        }
        public Assembly? assembly_from_name(AssemblyName name)
        {
            string? l_full_name = name.FullName;
            if (l_full_name != null) {
                var l_loaded_ass = loaded_assembly(l_full_name);
                if (l_loaded_ass != null) {
                    return l_loaded_ass;
                } else {
                    MetadataLoadContext? mlc = md_context;
                    if  (mlc != null) {
                        return mlc.LoadFromAssemblyName(l_full_name);
                    }
                }
            }
            return null;
        }
        public Assembly? assembly_from(string location)
        {
            // Console.WriteLine("load_assembly: " + location);
            Assembly? assembly = assembly = loaded_assembly(location);
            if (assembly == null) {
                string runtime_dir = RuntimeEnvironment.GetRuntimeDirectory();
                try
                {
                    // Get the array of runtime assemblies.
                    // This will allow us to at least inspect types depending only on BCL.
                    // Create MetadataLoadContext that can resolve assemblies using the created list.
                    MetadataLoadContext? mlc = md_context;
                    if (mlc == null) {
                        string[] runtimeAssemblies = Directory.GetFiles(RuntimeEnvironment.GetRuntimeDirectory(), "*.dll");

                        // Create the list of assembly paths consisting of runtime assemblies and the input file.
                        var paths = new List<string>(runtimeAssemblies);
                        if (locations != null && locations.Count > 0) {
                            foreach (string loc in locations) {
                                paths.Add(loc);
                            }
                        }
                        paths.Add(location);

                        var resolver = new PathAssemblyResolver(paths);
                        mlc = new MetadataLoadContext(resolver);
                        md_context = mlc;
                    }                          

                    // using (mlc) // See `Dispose` 
                    {
                        // Load assembly into MetadataLoadContext.
                        assembly = mlc.LoadFromAssemblyPath(location);
                    }
                }
                catch (IOException ex)
                {
                    Console.WriteLine("I/O error occured when trying to load assembly: ");
                    Console.WriteLine(ex.ToString());
                    assembly = null;
                }
                catch (UnauthorizedAccessException ex)
                {
                    Console.WriteLine("Access denied when trying to load assembly: ");
                    Console.WriteLine(ex.ToString());
                    assembly = null;
                }
                loaded_assemblies[location] = assembly;
            }
            return assembly;
        }
        public void Dispose()
        {
            close();
        }
        public void close()
        {
            var mlc = md_context;
            if (mlc != null) {
                mlc?.Dispose();
            }
            md_context = null;
        }  
    }

    class AssemblyAnalyzer: IDisposable
    {
        string location;

        public ASSEMBLY_LOADER assembly_loader;

        public Assembly? assembly;
        public AssemblyAnalyzer(string loc, ASSEMBLY_LOADER loader)
        {
            location = loc;
            assembly_loader = loader;
        }

        public void Dispose()
        {
            close();
        }

        public void close()
        {
            assembly = null;
        }

        public void load_assembly(StringBuilder? output=null)
        {
            // Console.WriteLine("load_assembly: " + location);
            if (output != null) {
                var ms = new MemoryStream();
                var options = new JsonWriterOptions { Indented = true };
                Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
                writer.WriteStartObject();
                writer.WritePropertyName("location");
                writer.WriteStringValue(location);

                List<string>? locations = assembly_loader.locations;
                if (locations != null && locations.Count > 0) {
                    writer.WritePropertyName("locations");
                    writer.WriteStartArray();
                    foreach (string loc in locations) {
                        writer.WriteStringValue(loc);
                    };
                    writer.WriteEndArray();
                }

                string runtime_dir = RuntimeEnvironment.GetRuntimeDirectory();
                writer.WritePropertyName("runtime");
                writer.WriteStringValue(runtime_dir.ToString());

                // writer.WritePropertyName("LD_LIBRARY_PATH");
                // writer.WriteStringValue(Environment.GetEnvironmentVariable("LD_LIBRARY_PATH"));

                writer.WriteBoolean("success", true);
                writer.WriteEndObject();
                writer.Flush();
                ms.Close();
                output.AppendLine(System.Text.Encoding.UTF8.GetString(ms.ToArray()));
            }

            assembly = assembly_loader.assembly_from(location);
        }
        public static CONSUMED_ASSEMBLY new_consumed_assembly (Assembly assembly, string? a_uid=null) 
        {
            AssemblyName name = assembly.GetName();
            (string? name, string public_key_token, string culture, string version) l_name_data = assembly_name_tuple (name);
            string? l_assembly_name = l_name_data.name;
            string l_uid;

            if (a_uid != null) {
                l_uid = a_uid;
            } else {
                l_uid = Guid.NewGuid().ToString().ToUpper();
            }
            string fn = l_uid;
            //FIXME: uncomment to have more human friendly title
            // if (l_assembly_name != null) {
            //     fn = l_assembly_name + '!' + fn;
            // }

            CONSUMED_ASSEMBLY ca = new CONSUMED_ASSEMBLY(l_uid, fn, l_assembly_name, l_name_data.version, l_name_data.culture, l_name_data.public_key_token, assembly.Location.ToString());
            ca.fullname = name.FullName;
            return ca;
        }        
        public CONSUMED_ASSEMBLY? consume_assembly_metadata(CONSUMED_ASSEMBLY? a_consumed_assembly, Assembly assembly, bool a_info_only, string cache_location)
        {
            CONSUMED_ASSEMBLY ca;
            if (a_consumed_assembly != null) {
                ca = a_consumed_assembly;
            } else {
                ca = new_consumed_assembly(assembly, null);
            }

            string? c_path = cache_location;
            if (c_path != null) {
                c_path = Path.Combine(c_path, ca.folder_name);
            }
            AssemblyConsumer consumer = new AssemblyConsumer(c_path);
            MdConsumerData md_data = consumer.consume(assembly, a_info_only);
            ca.set_is_consumed (true, a_info_only);
            return ca;
        }
        static public (string? name, string public_key_token, string culture, string version) assembly_name_tuple(AssemblyName name)
        {
            string? l_ass_name = name.Name;
            byte[]? pubKeyToken = name.GetPublicKeyToken();
            string public_key_token = "";
            if (pubKeyToken != null) {
                public_key_token = Convert.ToHexString(pubKeyToken);
            }
            string culture = "neutral";
            if (name.CultureInfo != null) {
                culture = name.CultureInfo.ToString();
                if (culture.Length == 0) {
                    culture = "neutral";
                }
            }
            string v = "";
            if (name.Version != null) {
                v = name.Version.ToString();
            }
            return (l_ass_name, public_key_token, culture, v);
        }          


        public void get_types_list (StringBuilder output)
        {
            if (assembly != null) {
                get_assembly_types(assembly, output);
            } else {
                output.Append("No assembly!\n");
            }
        }

        public void get_type_metadata (StringBuilder output, string typename)
        {
            if (assembly != null) {
                get_assembly_type_metadata(assembly, output, typename);
            } else {
                output.Append("No assembly!\n");
            }            
        }

        public void get_metadata(bool a_info_only, string? cache_location, StringBuilder output)
        {
            if (assembly != null) {
                get_assembly_metadata(assembly, a_info_only, cache_location, output);
            } else {
                output.Append("No assembly!\n");
            }
        }   

        public void get_assembly_metadata(Assembly assembly, bool a_info_only, string? cache_location, StringBuilder output)
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = true };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            writer.WriteStartObject();
            // a.appendToJson(writer);
            CONSUMED_ASSEMBLY ca = new_consumed_assembly (assembly);

            string? c_path = cache_location;
            if (c_path != null) {
                c_path = Path.Combine(c_path, ca.folder_name);
            }
            AssemblyConsumer consumer = new AssemblyConsumer(c_path);
            consumer.append_referenced_assembly (assembly, writer);

            MdConsumerData md_data = consumer.consume(assembly, a_info_only);
            ca.set_is_consumed (true, a_info_only);

            md_data.serialize_to_json(writer);

            writer.WriteBoolean("success", true);
            writer.WriteEndObject();
            writer.Flush();
            ms.Close();

            string text = System.Text.Encoding.UTF8.GetString(ms.ToArray());
            output.AppendLine(text);
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

        public void get_assembly_type_metadata(Assembly assembly, StringBuilder output, string typename)
        {

            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = true };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);

            writer.WriteStartObject();
            if (assembly == null)
            {
            }
            else
            {
                // Print assembly attribute information.
                // writer.WritePropertyName("type");
                // writer.WriteStartObject();
                writer.WritePropertyName("typename");
                writer.WriteStringValue(typename);
                
                Type? t = assembly.GetType (typename);
                if (t != null) {
                    Type? baseType = t.BaseType;

                    if (t.IsClass && baseType != null && !String.Equals(baseType.FullName, "System.Object", StringComparison.InvariantCulture))
                    {
                        writer.WritePropertyName("ancestor");
                        writer.WriteStringValue(baseType.FullName);
                    }
                    ConstructorInfo[] l_constructors = t.GetConstructors();
                    if (l_constructors.Length > 0)
                    {
                        writer.WritePropertyName("constructors");
                        writer.WriteStartArray();
                        foreach (ConstructorInfo ci in l_constructors)
                        {
                            writer.WriteStringValue(ci.ToString());
                        }
                        writer.WriteEndArray();
                    }

                    FieldInfo[] l_fields = t.GetFields();
                    if (l_fields.Length > 0)
                    {
                        writer.WritePropertyName("fields");
                        writer.WriteStartArray();
                        foreach (FieldInfo fi in l_fields)
                        {
                            writer.WriteStringValue(fi.ToString());
                        }
                        writer.WriteEndArray();
                    }

                    MethodInfo[] l_methods = t.GetMethods();
                    if (l_methods.Length > 0)
                    {
                        writer.WritePropertyName("methods");
                        writer.WriteStartArray();
                        foreach (MethodInfo mi in l_methods)
                        {
                            writer.WriteStringValue(mi.ToString());
                        }
                        writer.WriteEndArray();
                    }
                }
                // writer.WriteEndObject(); // type                
            }
            writer.Flush();
            ms.Close();

            output.AppendLine(System.Text.Encoding.UTF8.GetString(ms.ToArray()));
        }


        public string full_formatted_type_name (string name, HashSet<string>? used_names)
        {
            string simple_name;
            /* Add table to store result */
            int index = name.Count(f => (f == '.'));
            if (index > 0) {
                int i = 2;
                int count = name.Length;
                int pos = name.LastIndexOf('.', count - 1);
                simple_name = name.Substring(pos, count - 1);
                foreach (char c in name) {
                    if (i > index) {
                        break;
                    } else {
                        pos = name.LastIndexOf('.', pos - 1);
                        simple_name = name.Substring (pos + 1, count - 1);
                        i = i + 1;
                    }
                }
            } else {
                simple_name = name;
            }
            string res = simple_name;
            if (res[-1] == ']') {

            }
            return res;

        }
        public string formatted_type_name (string name, HashSet<string>? used_names)
        {
            return full_formatted_type_name(name, used_names);
        }
    }
}
