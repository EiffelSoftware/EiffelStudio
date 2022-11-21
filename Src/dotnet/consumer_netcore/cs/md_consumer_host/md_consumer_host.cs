using System;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;

namespace md_consumer
{
    public class MdConsumerHost
    {

        public MdConsumerHost()
        {
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct md_consumer_args
        {
            public int id;
            public IntPtr parameters;
            public IntPtr data;
            public IntPtr logs;
            public int failed;
        }

        public static int analyze_assembly(IntPtr arg, int argLength)
        {
            int l_size_of = System.Runtime.InteropServices.Marshal.SizeOf(typeof(md_consumer_args));

            // Console.WriteLine($"md_consumer::analyze_assembly(arg, {argLength})... {l_size_of}\n", argLength, l_size_of);

            if (argLength < System.Runtime.InteropServices.Marshal.SizeOf(typeof(md_consumer_args)))
            {
                Console.WriteLine($"md_consumer::analyze_assembly: ERROR sizes do not match {l_size_of} /= {argLength}\n", l_size_of, argLength);
                //     return 1;
            }

            md_consumer_args args = Marshal.PtrToStructure<md_consumer_args>(arg);

            args.failed = 0;
            string? location = null;
            string? cache_location = null;
            List<string> locations = new List<string>(1);
            string? query = null;
            bool has_info_only=false;
            // bool only_assembly=false;

            string? parameters = RuntimeInformation.IsOSPlatform(OSPlatform.Windows)
                ? Marshal.PtrToStringUni(args.parameters)
                : Marshal.PtrToStringUTF8(args.parameters);

            if (parameters != null)
            {
                // using JsonDocument jdoc = JsonDocument.Parse(params);

                JsonNode? jdoc = JsonNode.Parse(parameters);
                JsonNode? jroot = jdoc!.Root;
                // JsonElement jroot = jdoc.RootElement;
                // is_emdc = jroot.GetProperty("is_emdc").GetBoolean();
                location = jroot!["location"]!.AsValue().ToString();
                cache_location = jroot!["cache_location"]!.AsValue().ToString();


                JsonNode? jbool;
                jbool = jroot!["only_info"];
                if (jbool != null) { has_info_only = jbool.GetValue<bool>(); }
                // jbool = jroot!["only_assembly"];
                // if (jbool != null) { only_assembly = jbool.GetValue<bool>(); }

                JsonNode? jquery = jroot!["query"];
                if (jquery != null) {
                    query = jquery.AsValue().ToString();
                }

                JsonNode? jlocations_node = jroot!["locations"];
                if (jlocations_node != null)
                {
                    JsonArray? jlocations = jlocations_node.AsArray();
                    if (jlocations != null && jlocations.Count > 0)
                    {
                        locations = new List<string>(jlocations.Count);
                        int i = 0;
                        foreach (JsonNode? l in jlocations)
                        {
                            locations.Add(l!.ToString());
                            // Console.WriteLine("LOC=" + l!.ToString());
                            i = i+1;
                        }
                    }
                }
            }

            // Console.WriteLine($"md_consumer::analyze_assembly:\n\tlocation={loc}\n", loc);

            string data_string, logs_string;

            args.id = args.id + 1;
            if (location != null)
            {
                MdConsumer md = new MdConsumer();

                StringBuilder s = new StringBuilder();
                StringBuilder data = new StringBuilder();
                int res = md.analyze(location, locations, has_info_only, query, cache_location, null, data, s);
                data_string = data.ToString();
                logs_string = s.ToString();
            }
            else
            {
                args.failed = 1;
                data_string = "";
                logs_string = "ERROR: no assembly location provided";
            }

            args.data = Marshal.StringToCoTaskMemUTF8(data_string);
            args.logs = Marshal.StringToCoTaskMemUTF8(logs_string);

            Marshal.StructureToPtr(args, arg, true);

            return 0;
        }
    }
}