using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
// using Microsoft.Build.Framework; // See for SdkResolver

using EifMdConsumer;

namespace EifMdConsumer
{
    class Program
    {
        static public string version = "8.0.0.3";
        static int Main(string[] args)
        {
            md_consumer.MdConsumer? md;

            if (args.Length < 1)
            {
                Program.display_help();
                return 0;
            }

            List<string> add_assemblies = new List<string>(3);
            List<string> ref_assemblies = new List<string>(2);
            List<string> sdk_locations = new List<string>(1);
            List<string> runtime_locations = new List<string>(1);
          
            string? cache_location = null;

            string? json_outputfile = null;
            bool has_info_only=false;
            bool is_help = false;
            bool has_halt = false;
            bool nologo = false;
            bool is_debug = false;
            int debug_level = 0;
            bool is_cleaning = false;
            bool build_html = false;
            bool is_silent = false;

            int res = 0;
            // res = a.LoadFromAssemblyPath (inputFile);

            for (int i = 0; i < args.Length; i++)
            {
                var a = args[i];
                if (a.Equals("-a")) {
                    i = i + 1;
                    add_assemblies.Add(args[i]);
                } else if (a.Equals("-i")) {
                    i = i + 1;
                    ref_assemblies.Add(args[i]);
                } else if (a.Equals("-clean")) {
                    is_cleaning = true;
                } else if (a.Equals("-sdk")) {
                    i = i + 1;
                    sdk_locations.Add(args[i]);
                } else if (a.Equals("-runtime")) {
                    i = i + 1;
                    runtime_locations.Add(args[i]);
                } else if (a.Equals("--json-output-file")) {
                    i = i + 1;
                    json_outputfile = args[i];
                } else if (a.Equals("-g")) {
                    has_info_only = true;
                } else if (a.Equals("-o")) {
                    i = i + 1;
                    cache_location = args[i];
                } else if (a.Equals("-json")) {
                    // Ignore as JSON is the default and only format
                } else if (a.Equals("-halt")) {
                    has_halt = true;
                } else if (a.Equals("-build_html")) {                    
                    build_html = true;
                } else if (a.Equals("-debug")) {
                    is_debug = true;     
                    debug_level = debug_level + 1;
                } else if (a.Equals("-silent")) {
                    is_silent = true;                
                } else if (a.Equals("-v")) {
                    is_silent = false;                
                } else if (a.Equals("-nologo")) {
                    nologo = true;
                } else if (a.Equals("--help") || a.Equals("-?")) {
                    is_help = true;
                } else {
                    // TODO: maybe reject those values!
                    Console.WriteLine("Ignore parameter: " + args[i]);
                }
            }

			md_consumer.STATUS_PRINTER.set_error (true);
            if (is_silent) {
                nologo = true;
			} else {
	            md_consumer.STATUS_PRINTER.set_info (true);
	            // md_consumer.STATUS_PRINTER.set_warning (true);
            }

            if (is_help) {
                Program.display_help();
                return 0;
            } else {
                if (!(build_html || is_cleaning) && add_assemblies.Count == 0) {
                    Console.WriteLine("Error: no assembly given via -a argument. See usage using --help\n");
                } else {
                    if (!nologo) {
                        Program.display_logo();
                    }
                    if (cache_location != null) {
                        if (is_cleaning && Directory.Exists(cache_location)) {
                            Directory.Delete(cache_location, true);
                        }
                        if (!Directory.Exists(cache_location)) {
                            Console.WriteLine("Create cache location \"" + cache_location + "\"");
                            Directory.CreateDirectory(cache_location);
                        }
                    }
                    // Initialize ASSEMBLY_LOADER
                    md_consumer.ASSEMBLY_LOADER loader = md_consumer.SHARED_ASSEMBLY_LOADER.assembly_loader;
                    if (is_debug) {
                        loader.set_is_debug (true);
                        if (debug_level > 1) {
                            md_consumer.STATUS_PRINTER.set_debug (true, debug_level - 1);
                        }
                    }
                    loader.register_locations(ref_assemblies);
                    loader.register_sdk_locations(sdk_locations);
                    loader.register_runtime_locations(runtime_locations);
                    loader.register_locations(add_assemblies);
                    
                    StringBuilder o = new StringBuilder();
                    if (cache_location != null) {
                        md_consumer.CACHE_WRITER cache = new md_consumer.CACHE_WRITER(cache_location, o);
                        if (is_debug) {
                            cache.set_is_debug (true);
                        }
                        List<string> processed = new List<string>(10);
                        foreach (var a in add_assemblies) {
                            var ca = cache.add_assembly_ex(a, has_info_only, ref_assemblies, processed);
                        }
                        if (build_html) {
                            cache.build_html();
                        }
                    } else {
                        md = new md_consumer.MdConsumer();
                        StringBuilder data = new StringBuilder();

                        foreach (var a in add_assemblies) {
                            res = md.analyze(a, ref_assemblies, has_info_only, null, cache_location, json_outputfile, data, o);
                        }
                        // if (json_outputfile == null) {
                        //     Console.WriteLine(data.ToString());
                        // }
                    }
                    // Console.WriteLine(o.ToString());
                    if (has_halt) {
                        Console.WriteLine("Please press enter to exit...");
                        string? line = Console.ReadLine();
                    }
                }
            }
            return res;
        }

        static protected void display_logo() 
        {
            Console.WriteLine(String.Format(@"
Eiffel Assembly Metadata ""Consumer"" - Version: {0}
Copyright Eiffel Software 2006-2023. All Rights Reserved.
", Program.version));
        }
        static protected void display_help() 
        {
            Program.display_logo();
            Console.WriteLine(@"USAGE:
   emdc [-nologo]
   emdc -a <assembly> [-a...] [-g] [-i <path> [-i...]] [-sdk <directory>] [-runtime <directory>] [-o <cache>] [-v] [-halt] [-json] [-nologo]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -a      : Adds a specified assemblies to the cache.
             <assembly>: Path to a valid .NET assembly
   -g      : Forces consumer to ignore all types in added assemblies. (Optional)
   -i      : Add a lookup reference path for dependency resolution. (Optional)
   -sdk    : Add a SDK location for dependency resolution. (Optional)
             <path>: A directory location on disk
   -runtime: Add a runtime location for dependency resolution. (Optional)
             <path>: A dll location on disk
             <path>: A directory location on disk
   -v      : Display verbose output. (Optional)
   -o      : Location of Eiffel assembly cache to perform operations on. (Optional)
             <cache>: A location of an Eiffel assembly cache
   -halt   : Waits for user to press enter before exiting. (Optional)
   -json   : Use JSON content for the cache storage. (Optional, default)
   -?,--help      : Display help (Optional)
   -version: Displays version information. (Optional)
   -nologo : Supresses copyright information. (Optional)
                ");
        }
    }
}

