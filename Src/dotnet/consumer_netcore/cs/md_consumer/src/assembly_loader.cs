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
    static public class SHARED_ASSEMBLY_LOADER
    {
        public static ASSEMBLY_LOADER assembly_loader = new ASSEMBLY_LOADER(null);
        public static void set_assembly_loader(ASSEMBLY_LOADER loader)
        {
            assembly_loader = loader;
        }
    }
    public class ASSEMBLY_LOADER : IDisposable
    {
        MetadataLoadContext? md_context;
        public List<string> locations;
        public List<string> side_locations;
        Dictionary<string,Assembly?> loaded_assemblies;
        List<string> ignored_assemblies;
        private bool is_debug=false;

        public ASSEMBLY_LOADER(List<string>? locs)
        {
            locations = new List<string>(0);
            side_locations = new List<string>(0);
            loaded_assemblies = new Dictionary<string,Assembly?>(1);
            ignored_assemblies = new List<string>(0);
                
            register_locations(locs);

            // foreach (AssemblyName an in System.Reflection.Assembly.GetExecutingAssembly().GetReferencedAssemblies()) {
            //     Assembly asm = System.Reflection.Assembly.Load(an.ToString());
            //     loaded_assemblies[an.ToString()] = asm;
            //     loaded_assemblies[asm.Location] = asm;
            // }
        }
        public void set_is_debug (bool b)
        {
            is_debug = b;
        }
        public void register_sdk_locations(List<string>? locs)
        {
            register_locations (locs);
        }
        public void register_runtime_locations(List<string>? locs)
        {
            register_locations (locs);
            if (locs != null) {
                    // Search for other runtime folder, to resolve the location of specific assemblies (such as System.IO.Port, ...)
                foreach (var loc in locs) {
                    var fdn = Path.GetDirectoryName(Path.GetDirectoryName(loc)); // parent of parent
                    var fn = Path.GetFileName(loc);
                    if (fdn != null) {
                        foreach (var d in Directory.GetDirectories(fdn)) {
                            var ndn = Path.Join(d, fn);
                            if (Directory.Exists(ndn)) {
                                register_side_location(ndn);
                            }
                        }
                    }
                }
            }
        }        
        public void register_locations(List<string>? locs)
        {
            if (locs != null && locs.Count > 0) {
                foreach (var i in locs) {
                    register_location(i);
                }
            }
        }
        public void register_location(string loc)
        {
            if (!locations.Contains(loc)) {
                locations.Add (loc);
            }
        }     
        public void register_side_location(string loc)
        {
            if (!side_locations.Contains(loc)) {
                side_locations.Add (loc);
            }
        }              
        public Assembly? loaded_assembly (string n)
        {
            if (loaded_assemblies.ContainsKey(n)) {
                return loaded_assemblies[n];
            } else {
                return null;
            }
        }
        public bool ignored_assembly (string n)
        {
            if (ignored_assemblies.Contains(n)) {
                return true;
            } else {
                return false;
            }
        }
        public void ignore_assembly (string n)
        {
            if (!ignored_assemblies.Contains(n)) {
                ignored_assemblies.Add(n);
            }
        }
               
        public Assembly? assembly_from_name(AssemblyName name)
        {
            string? l_full_name = name.FullName;
            if (l_full_name != null) {
                var l_loaded_ass = loaded_assembly(l_full_name);
                if (l_loaded_ass != null) {
                    return l_loaded_ass;
                } else if (!ignored_assembly(l_full_name)){
                    MetadataLoadContext? mlc = md_context;
                    if  (mlc != null) {
                        Assembly? res;
                        try {
                            res= mlc.LoadFromAssemblyName(l_full_name);
                            return res;
                        }  catch {
                            ignore_assembly(l_full_name);
                            return null;
                        }                        
                    }
                }
            }
            return null;
        }
        protected void register_resolver_path(string p, List<string> paths, List<string> dirs)
        {
            if (Directory.Exists(p)) {
                if (!dirs.Contains(p)) {
                    dirs.Add(p);
                }
            } else if (p.EndsWith("mscorlib.dll")) {
                // Console.WriteLine("Ignore mscorlib.dll for resolver.");
            } else if (!paths.Contains(p)) {
                paths.Add(p);
            }
        }
        public Assembly? assembly_from(string location)
        {
            // Console.WriteLine("load_assembly: " + location);
            Assembly? assembly = assembly = loaded_assembly(location);
            if (assembly == null) {
                string runtime_dir = RuntimeEnvironment.GetRuntimeDirectory();

                try {
                    // Get the array of runtime assemblies.
                    // This will allow us to at least inspect types depending only on BCL.
                    // Create MetadataLoadContext that can resolve assemblies using the created list.
                    MetadataLoadContext? mlc = md_context;
                    if (mlc == null) {
                        string[] runtimeAssemblies = Directory.GetFiles(RuntimeEnvironment.GetRuntimeDirectory(), "*.dll");

                        // Create the list of assembly paths consisting of runtime assemblies and the input file.
                        var paths = new List<string>(runtimeAssemblies);
                        var dirs = new List<string>(1);

                        if (locations != null && locations.Count > 0) {
                            foreach (string loc in locations) {
                                register_resolver_path (loc, paths, dirs);
                            }
                        }
                        if (!paths.Contains(location)) {
                            register_resolver_path (location, paths, dirs);
                        } else {
                            // Console.WriteLine(String.Format("Location already in resolver paths: {0}", location));
                        }

                        if (side_locations != null && side_locations.Count > 0) {
                            /* Register side_location at the last position, so it is used only in last cases */
                            foreach (string loc in side_locations) {
                                register_resolver_path (loc, paths, dirs);
                            }
                        }
                        // Console.WriteLine("RESOLVER paths:"); foreach(var v in paths) { Console.WriteLine("  - " + v); }
                        var resolver = new PathAssemblyResolverExt(paths, dirs);
                        mlc = new MetadataLoadContext(resolver); //, "netstandard");
                        md_context = mlc;
                    }                       

                    // foreach (var a in mlc.GetAssemblies())  {
                    //     Console.WriteLine(" - " + (a.FullName != null ? a.FullName : a.Location) + ": " + a.Location);
                    // }

                    // using (mlc) // See `Dispose` 
                    {
                        // Load assembly into MetadataLoadContext.
                        assembly = null;               
                        try {
                            assembly = mlc.LoadFromAssemblyPath(location);
                        } catch {
                            string? assname = Path.GetFileNameWithoutExtension(location);
                            if (assname != null) {
                                assembly = mlc.LoadFromAssemblyName(assname);
                            }
                        }
                        if (assembly != null) {
                            loaded_assemblies[location] = assembly;
                        }
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
    class PathAssemblyResolverExt : System.Reflection.PathAssemblyResolver
    {
        private List<string> directories;
        private List<string>? discovered_dirs=null;
        private Dictionary<string,string?> ext_paths;
        public PathAssemblyResolverExt(IEnumerable<string> assemblyPaths, IEnumerable<string> assemblyDirs) : base (assemblyPaths)
        {
            ext_paths = new Dictionary<string, string?>(10);
            directories = new List<string>(3);
            foreach (var i in assemblyDirs) {
                directories.Add(i);
            }
        }
        private string? assembly_location_from_directories(AssemblyName assemblyName, List<string> dirs)
        {
            string? assname = assemblyName.Name;
            if (assname != null) {
                foreach (var d in dirs) {
                    string fn = Path.Combine(d, assname + ".dll");
                    if (File.Exists(fn)) {
                        return fn;
                    }
                }
            }
            return null;
        }
        public override Assembly? Resolve(MetadataLoadContext context, AssemblyName assemblyName)
        {
            // Console.WriteLine("Search " + assemblyName.Name);
            Assembly? res = base.Resolve(context, assemblyName);
            if (res == null) {
                string? fn = null;
                string n = assemblyName.ToString();
                if (ext_paths.ContainsKey(n)) {
                    fn = ext_paths[n];
                }
                if (fn == null) {
                    fn = assembly_location_from_directories(assemblyName, directories);
                }
                if (fn == null) {
                    if (discovered_dirs == null) {
                        discovered_dirs = new List<string>(0);
                        foreach(var d in directories) {
                            string dn = Path.Combine(d, "ref");
                            if (Directory.Exists(dn) && !directories.Contains(dn) && !discovered_dirs.Contains(dn)) {
                                discovered_dirs.Add(dn);
                            }

                        }
                    }
                    if (discovered_dirs != null && discovered_dirs.Count > 0) {
                        fn = assembly_location_from_directories(assemblyName, discovered_dirs);
                    }
                }                

                ext_paths[n] = fn; /* Record result, even if not found! */

                if (fn != null && File.Exists(fn)) {
                    try {
                        res = context.LoadFromAssemblyPath(fn);
                    } catch {
                        res = null;
                    }
                }
            }

            return res;
        }
    }    
}
