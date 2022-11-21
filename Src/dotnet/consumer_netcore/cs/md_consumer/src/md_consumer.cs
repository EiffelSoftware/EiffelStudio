using System;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.IO;
using System.Collections.Generic;
using System.Reflection;

namespace md_consumer
{
    public class MdConsumerData
    {
        public CONSUMED_ASSEMBLY_TYPES? assembly_types;
        public List<CONSUMED_ASSEMBLY>? assembly_mapping;
        public List<CONSUMED_TYPE> consumed_types;
        public MdConsumerData()
        {
            consumed_types = new List<CONSUMED_TYPE>(10);
        }
        public void reset() {
            consumed_types.Clear();
            assembly_types = null;
        }
        public void set_assembly_types(CONSUMED_ASSEMBLY_TYPES types)
        {
            assembly_types = types;
        }
        public void set_assembly_mapping(List<CONSUMED_ASSEMBLY> assembly_ids)
        {
            assembly_mapping = assembly_ids;
        }
        public void add_consumed_type(CONSUMED_TYPE t)
        {
            consumed_types.Add(t);
        }
        public void serialize_to_json (Utf8JsonWriter json)
        {
            CONSUMER_SERIALIZER serializer = new CONSUMER_SERIALIZER(json);
            json.WritePropertyName("assemblies");
            json.WriteStartObject();
            var l_assembly_mapping = assembly_mapping;
            if (l_assembly_mapping != null) {
                json.WritePropertyName("count");
                json.WriteNumberValue(l_assembly_mapping.Count);
                serializer.serialize_assembly_mapping(l_assembly_mapping);
            }
            var l_assembly_types = assembly_types;
            if (l_assembly_types != null) {
                serializer.serialize_assembly_types(l_assembly_types, true);
            }
            json.WriteEndObject();

            json.WritePropertyName("CONSUMED_TYPES");
            json.WriteStartArray();
            foreach(var t in consumed_types) {
                json.WriteStartObject();
                serializer.serialize_type(t);
                json.WriteEndObject();
            }
            json.WriteEndArray();
        }
      
        public long serialize_type_to_json_file (CONSUMED_TYPE t, string location, bool is_appending=false)
        // Serialize `t` as JSON in file at `location`, and return the size of the file (i.e last position).
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = false };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            CONSUMER_SERIALIZER serializer = new CONSUMER_SERIALIZER(writer);
            writer.WriteStartObject();
            serializer.serialize_type(t);
            writer.WriteEndObject();
            writer.Flush();
            ms.Close();
            string json = System.Text.Encoding.UTF8.GetString(ms.ToArray());
            if (is_appending) {
                using (StreamWriter file = new(location, append: true)) {
                    file.WriteLine(json);
                }                
            } else {
                using (StreamWriter file = new(location)) {
                    file.WriteLine(json);
                }
            }
            return new System.IO.FileInfo(location).Length;
        }
        public void serialize_assembly_types_to_json_file (string location)
        // Serialize ``assembly_types` as JSON in file at `location`, and return the size of the file (i.e last position).
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = false };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            CONSUMER_SERIALIZER serializer = new CONSUMER_SERIALIZER(writer);
            writer.WriteStartObject();
            var l_assembly_types = assembly_types;
            if (l_assembly_types != null) {
                serializer.serialize_assembly_types(l_assembly_types, true);
            }
            writer.WriteEndObject();
            writer.Flush();
            ms.Close();
            string json = System.Text.Encoding.UTF8.GetString(ms.ToArray());
            using (StreamWriter file = new(location)) {
                file.WriteLine(json);
            }
        }
        public void serialize_assembly_mapping_to_json_file (string location)
        // Serialize ``assembly_mapping` as JSON in file at `location`, and return the size of the file (i.e last position).
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = false };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            CONSUMER_SERIALIZER serializer = new CONSUMER_SERIALIZER(writer);
            writer.WriteStartObject();
            writer.WritePropertyName("CONSUMED_ASSEMBLY_MAPPING");
            writer.WriteStartObject();                
            var l_assembly_mapping = assembly_mapping;
            if (l_assembly_mapping != null) {
                serializer.serialize_assembly_mapping(l_assembly_mapping);
            }
            writer.WriteEndObject();
            writer.WriteEndObject();
            writer.Flush();
            ms.Close();
            string json = System.Text.Encoding.UTF8.GetString(ms.ToArray());
            using (StreamWriter file = new(location)) {
                file.WriteLine(json);
            }
        }
    }    

    public class MdConsumer
    {

        public MdConsumer()
        {
        }
        public (CONSUMED_ASSEMBLY?, Assembly?) consume_into_cache(CONSUMED_ASSEMBLY? a_consumed_assembly, string assembly_loc, bool a_info_only, List<string>? other_assemblies,
            string cache_location, StringBuilder output)
        {
            AssemblyAnalyzer? l_analyzer;
            CONSUMED_ASSEMBLY? ca = a_consumed_assembly;
            Assembly? l_assembly = null;
            var o = output;
            o.AppendLine("+---------------------------------------------------+\n");
            o.AppendLine("Analyze Assembly: " + assembly_loc);
            try
            {
                ASSEMBLY_LOADER loader = new ASSEMBLY_LOADER(other_assemblies);
                SHARED_ASSEMBLY_LOADER.set_assembly_loader (loader);

                l_analyzer = new AssemblyAnalyzer(assembly_loc, loader);
                o.AppendLine("+ Load assembly");
                l_analyzer.load_assembly(o);
                StringBuilder buf = new StringBuilder();
                o.AppendLine("+ Get metadata");
                l_assembly = l_analyzer.assembly;
                if (l_assembly != null) {
                    ca = l_analyzer.consume_assembly_metadata(ca, l_assembly, a_info_only, cache_location);
                }
                l_analyzer.close();
            }
            catch (IOException e)
            {
                Console.WriteLine("Exception raised: " + e.ToString());
                o.AppendLine("\nException raised: " + e.ToString());
                if (e.Source != null) {
                    o.AppendLine("\n\tIOException source:" + e.Source);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Exception raised: " + e.ToString());
                o.AppendLine("\nException raised: " + e.ToString());
            }
            return (ca, l_assembly);
        }        

        public int analyze(string loc, List<string>? locs, bool a_info_only, string? query,
            string? cache_location, string? json_outputfile,
            StringBuilder data, StringBuilder? output)
        {
            AssemblyAnalyzer? l_analyzer;
            StringBuilder o;
            if (output != null) {
                o = output;
            } else {
                o = new StringBuilder();
            }
            //   int res;

            o.AppendLine("+---------------------------------------------------+\n");
            o.AppendLine("Analyze Assembly: " + loc);
            try
            {
                ASSEMBLY_LOADER loader = new ASSEMBLY_LOADER(locs);
                SHARED_ASSEMBLY_LOADER.set_assembly_loader (loader);
                l_analyzer = new AssemblyAnalyzer(loc, loader);
                o.AppendLine("+ Load assembly");
                l_analyzer.load_assembly(o);
                StringBuilder buf = new StringBuilder();
                if (query != null) {
                    if (query.Equals("types")) {
                        o.AppendLine("+ Get types");
                        l_analyzer.get_types_list (buf);
                    } else if (query.StartsWith ("type=")) {
                        o.AppendLine("+ Get for type [" + query.Substring(5) + "]");
                        l_analyzer.get_type_metadata (buf, query.Substring(5));
                    }
                } else {
                    o.AppendLine("+ Get metadata");
                    l_analyzer.get_metadata(a_info_only, cache_location, buf);
                }
                l_analyzer.close();
                // l_analyzer = null;

                if (json_outputfile != null)
                {
                    using (StreamWriter file = new(json_outputfile)) {
                        file.WriteLine(buf.ToString());
                    }
                    o.AppendLine("+ Saved data into " + json_outputfile);
                }
                else
                {
                    data.Append(buf.ToString());
                }
            }
            catch (IOException e)
            {
                Console.WriteLine("Exception raised: " + e.ToString());
                o.AppendLine("\nException raised: " + e.ToString());
                if (e.Source != null)
                    o.AppendLine("\n\tIOException source:" + e.Source);
                // throw;
            }
            catch (Exception e)
            {
                Console.WriteLine("Exception raised: " + e.ToString());
                o.AppendLine("\nException raised: " + e.ToString());
            }
            // if (l_analyzer != null) {
            //     l_analyzer.dispose();
            //     l_analyzer = null;
            // }
            return 0;
        }
    }
}