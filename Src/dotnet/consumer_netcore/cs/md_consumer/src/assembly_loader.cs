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
        Dictionary<string,Assembly?> loaded_assemblies;
        List<string> ignored_assemblies;

        public ASSEMBLY_LOADER(List<string>? locs)
        {
            locations = new List<string>(0);
            loaded_assemblies = new Dictionary<string,Assembly?>(1);
            ignored_assemblies = new List<string>(0);
                
            register_locations(locs);

            foreach (AssemblyName an in System.Reflection.Assembly.GetExecutingAssembly().GetReferencedAssemblies()) {
                Assembly asm = System.Reflection.Assembly.Load(an.ToString());
                loaded_assemblies[an.ToString()] = asm;
                loaded_assemblies[asm.Location] = asm;
            }
        }

        public void register_locations(List<string>? locs)
        {
            if (locs != null && locs.Count > 0) {
                foreach (var i in locs) {
                    if (!locations.Contains(i)) {
                        locations.Add (i);
                    }
                }
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
                        // Console.WriteLine("RESOLVER paths:"); foreach(var v in paths) { Console.WriteLine("  - " + v); }
                        var resolver = new PathAssemblyResolverExt(paths, dirs);
                        mlc = new MetadataLoadContext(resolver);
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
        private List<string> dirs;
        private Dictionary<string,string> ext_paths;
        public PathAssemblyResolverExt(IEnumerable<string> assemblyPaths, IEnumerable<string> assemblyDirs) : base (assemblyPaths)
        {
            ext_paths = new Dictionary<string, string>(10);
            dirs = new List<string>(3);
            foreach (var i in assemblyDirs) {
                dirs.Add(i);
            }
        }
        public override Assembly? Resolve(MetadataLoadContext context, AssemblyName assemblyName)
        {
            Assembly? res = base.Resolve(context, assemblyName);
            if (res == null) {
                string? fn = null;
                string n = assemblyName.ToString();
                if (ext_paths.ContainsKey(n)) {
                    fn = ext_paths[n];
                }
                if (fn == null) {
                    string? assname = assemblyName.Name;
                    if (assname != null) {
                        foreach (var d in dirs) {
                            fn = Path.Combine(d, assemblyName.Name + ".dll");
                            if (File.Exists(fn)) {
                                break;
                            }
                        }
                    }
                }
                if (fn != null && File.Exists(fn)) {
                    try {
                        res = context.LoadFromAssemblyPath(fn);
                        ext_paths[n] = fn;
                    } catch {
                        res = null;
                    }
                }
            }
            return res;
        }
    }    
}
