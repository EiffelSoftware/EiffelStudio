using System;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Diagnostics;

using System.Threading;


namespace md_consumer
{
    public class CACHE_GUARD: IDisposable
    {
        public static int cache_locks = 0;
        public static Mutex? shared_guard;
        public static bool is_initialized = false;

        public bool is_guard_initialized()
        {
            return CACHE_GUARD.is_initialized;
        }
        public void initialize_guard(string a_cache_location)
        {
            CACHE_GUARD.initialize (a_cache_location);            
        }

        public static void initialize(string a_cache_location)
        {
            string id = a_cache_location;
            id = id.Replace(':', '!');
            id = id.Replace('\\', '!');
            id = id.Replace('/', '!');
            shared_guard = new Mutex(false, "Global\\" + id);

            is_initialized = true;
        }
        public void Dispose()
        {
            if (shared_guard != null) {
                shared_guard.Dispose();
                shared_guard = null;
                is_initialized = false;
            }
        }

        public bool is_cache_locked()
        {
            return (cache_locks > 0);
        }

        public static void lock_cache()
        {
            cache_locks = cache_locks + 1;
            if (cache_locks == 1) {
                perform_locking();
            }
        }
        public static void unlock_cache()
        {
            cache_locks = cache_locks - 1;
            if (cache_locks == 0) {
                perform_unlocking();
            }
        }

        private static Mutex guard
        {
            get {
                var g = shared_guard; 
                if (g == null) {
                    g = new Mutex(false, "Global\\-not-initialized");
                    shared_guard = g;
                }
                return g;
            }
        }

        private static void perform_locking()
        {
            guard.WaitOne();
        }
        private static void perform_unlocking()
        {
            guard.ReleaseMutex();
        }
    }
    public class CACHE_INFO
    {
        public List<CONSUMED_ASSEMBLY> assemblies;
        public bool is_dirty = false;
        public CACHE_INFO()
        {
            assemblies = new List<CONSUMED_ASSEMBLY>(0);
        }
        public bool has_assembly(CONSUMED_ASSEMBLY? a)
        {
            if (a == null) {
                return false;
            } else {
                bool res=false;
                foreach (var i in assemblies) {
                    if (a.same_as (i)) {
                        res = true;
                        break;
                    }
                }
                return res;
            }
        }
        public bool has_non_unique_entries()
        {
            foreach(var ca in assemblies)
            {
                foreach (var i in assemblies) {
                    if (ca != i && ca.same_as (i)) {
                        return true;
                    }
                }
            }
            return false;
        }
        public void add_assembly (CONSUMED_ASSEMBLY a)
        {
            //Debug.Assert(!has_assembly(a), "not has assembly");
            assemblies.Add(a);
            is_dirty = true;
            //Debug.Assert(!has_non_unique_entries(), "Unique entries!");
        }
        public void remove_assembly (CONSUMED_ASSEMBLY a)
        {
            assemblies.Remove(a);
            is_dirty = true;
            //Debug.Assert(!has_non_unique_entries(), "Unique entries!");
        }   
        public void update_assembly (CONSUMED_ASSEMBLY a)
        {
            is_dirty = true;
            bool found=false;
            for (int i = 0; i < assemblies.Count; i++) {
                var ass = assemblies[i];
                if (ass.same_as (a)) {
                    found = true;
                    assemblies[i] = a;
                    is_dirty = true;
                    break;
                }
            }
            if (!found) {
            	//DEBUG: Debug.Assert(found, "Assembly not found to be updated");
            }
            //Debug.Assert(!has_non_unique_entries(), "Unique entries!");
        }
    }
    public class CACHE_COMMON
    {
        protected string cache_location;
        public string eac_info_file_name = "eac.info";
        private CACHE_GUARD guard;
        public CACHE_COMMON (string a_cache_loc)
        {
            cache_location = a_cache_loc;
            guard = new CACHE_GUARD();
            if (! guard.is_guard_initialized()) {
                guard.initialize_guard (a_cache_loc);
            }
        }
    }
    public class CACHE_READER : CACHE_COMMON
    {
        private string info_location;

        public CACHE_READER(string loc): base(loc)
        {
            info_location = Path.Combine(loc, eac_info_file_name);
        }
        public bool is_initialized() {
            return File.Exists(info_location);
        }
        public bool is_assembly_in_cache (string path, bool a_consumed)
        // Is `path` in cache and if `a_consumed` has it been consumed?
        {
            CONSUMED_ASSEMBLY? ca =  consumed_assembly_from_path(path);
            return ca != null && (!a_consumed || ca.is_consumed);
        }
        private CACHE_INFO? _cache_info=null;

        public void reset_info()
        {
            _cache_info = null;
        }
        private string? json_string_value(JsonObject jo, string name)
        {
            if (jo.ContainsKey(name)) {
                return jo[name]!.ToString();
            }
            return null;
        }
        private CONSUMED_ASSEMBLY? consumed_assembly_from_json_node (JsonNode? j_item)
        {
            CONSUMED_ASSEMBLY? ca = null;
            if (j_item is JsonObject) {
                JsonObject j = (JsonObject) j_item;
                string? loc = json_string_value(j, JSON_NAMES.location);
                string? uid = json_string_value(j, JSON_NAMES.unique_id);
                string? fn = json_string_value(j, JSON_NAMES.folder_name);
                string? name = json_string_value(j, JSON_NAMES.name);
                string? fullname = json_string_value(j, JSON_NAMES.fullname);
                string? version = json_string_value(j, JSON_NAMES.version);
                string? culture = json_string_value(j, JSON_NAMES.culture);
                string? key = json_string_value(j, JSON_NAMES.public_key_token);
                if (loc != null && uid != null && version != null && culture != null && key != null) {
                    ca = new CONSUMED_ASSEMBLY(uid, fn, name, version, culture, key, loc);
                    if (fullname != null) {
                        ca.fullname = fullname;
                    }
                    bool is_consumed = false;
                    bool has_info_only = false;
                    JsonNode? jbool;
                    jbool = j[JSON_NAMES.is_consumed];
                    if (jbool != null) { is_consumed = jbool.GetValue<bool>(); }
                    jbool = j[JSON_NAMES.has_info_only];
                    if (jbool != null) { has_info_only = jbool.GetValue<bool>(); }
                    ca.set_is_consumed(is_consumed, has_info_only);
                }
            }
            return ca;
        }
        public CACHE_INFO? info() {
            CACHE_GUARD.lock_cache();
            CACHE_INFO? info = _cache_info;
            if (info != null) {
                return info;
            } else {
                info = new CACHE_INFO();
                if (is_initialized()) {
                    string json = System.IO.File.ReadAllText(info_location);
                    JsonNode? jdoc = JsonNode.Parse(json);
                    JsonNode? jroot = jdoc!.Root;    

                    if (jroot != null) {
                        JsonArray? j_assemblies = jroot!["CACHE_INFO"]!["assemblies"]!.AsArray();
                        if (j_assemblies != null) {
                            foreach (JsonNode? j_item in j_assemblies) {
                                CONSUMED_ASSEMBLY? ca = consumed_assembly_from_json_node (j_item);
                                if (ca != null) {
                                    info.add_assembly (ca);
                                }
                            }
                        }
                    }
                    info.is_dirty = false;
                }
            }
            _cache_info = info;
            CACHE_GUARD.unlock_cache();
            return info;
        }
        public List<CONSUMED_ASSEMBLY>? assemblies()
        {
            if (is_initialized()) {
                CACHE_INFO? l_info = info();
                if (l_info != null) {
                    return l_info.assemblies;
                }
            }
            return null;
        }
        public List<CONSUMED_ASSEMBLY>? consumed_assemblies()
        {
            var lst = assemblies();
            if (lst  != null) {
                List<CONSUMED_ASSEMBLY> res = new List<CONSUMED_ASSEMBLY>(lst.Count);
                foreach (var a in lst) {
                    if (a.is_consumed) {
                        res.Add(a);
                    }
                }
                return res;
            }
            return null;
        }
        public CONSUMED_ASSEMBLY? consumed_assembly_from_path(string a_path)
        {
            CACHE_GUARD.lock_cache();
            var lst = assemblies();
            CONSUMED_ASSEMBLY? res = null;
            if (lst  != null) {
                string p = Path.GetFullPath(a_path);
                foreach (var ca in lst) {
                    if (ca.has_same_path (p)) {
                        res = ca;
                        break;
                    }
                }
            }
            CACHE_GUARD.unlock_cache();
            return res;
        }
        public string assembly_directory_name_from_consumed_assembly (CONSUMED_ASSEMBLY ca)
        {
            return Path.Combine(cache_location, ca.folder_name);
        }        
        public string assembly_mapping_file_name_from_consumed_assembly (CONSUMED_ASSEMBLY ca)
        {
            return Path.Combine(assembly_directory_name_from_consumed_assembly (ca), AssemblyConsumer.assembly_mapping_file_name);
        }
        public string assembly_classes_file_name_from_consumed_assembly (CONSUMED_ASSEMBLY ca)
        {
            return Path.Combine(assembly_directory_name_from_consumed_assembly (ca), AssemblyConsumer.classes_file_name);
        }
        public string assembly_types_file_name_from_consumed_assembly (CONSUMED_ASSEMBLY ca)
        {
            return Path.Combine(assembly_directory_name_from_consumed_assembly (ca), AssemblyConsumer.assembly_types_file_name);
        }

        public CONSUMED_ASSEMBLY_MAPPING? assembly_mapping_from_consumed_assembly (CONSUMED_ASSEMBLY ca)
        {
            string fn = assembly_mapping_file_name_from_consumed_assembly(ca);
            CONSUMED_ASSEMBLY_MAPPING? res = null;
            if (File.Exists(fn)) {
                string? json=null;
                json = System.IO.File.ReadAllText(fn);
                // FileStream f = File.OpenRead(fn);
                // f.Position = pos;
                // var freader = new StreamReader(f);
                // json = freader.ReadLine();
                if (json != null) {
                    JsonNode? jdoc = JsonNode.Parse(json);
                    JsonNode? jroot = jdoc!.Root;
                    if (jroot != null) {
                        List<CONSUMED_ASSEMBLY> lst = new List<CONSUMED_ASSEMBLY>(0);
                        JsonArray? j_assemblies = jroot!["CONSUMED_ASSEMBLY_MAPPING"]!["assemblies"]!.AsArray();
                        if (j_assemblies != null) {
                            foreach (JsonNode? j_item in j_assemblies) {
                                CONSUMED_ASSEMBLY? i_ca = consumed_assembly_from_json_node (j_item);
                                if (i_ca != null) {
                                    lst.Add (i_ca);
                                }
                            }
                        }
                        res = new CONSUMED_ASSEMBLY_MAPPING(lst);
                    }
                }
            }
            return res;
        }

        public CONSUMED_ASSEMBLY_TYPES? assembly_types (CONSUMED_ASSEMBLY ca)
        {
            CONSUMED_ASSEMBLY_TYPES? res = null;
            string fn = assembly_types_file_name_from_consumed_assembly (ca);
            if (File.Exists(fn)) {
                string json = System.IO.File.ReadAllText(fn);
                JsonNode? jdoc = JsonNode.Parse(json);
                JsonNode? jroot = jdoc!.Root;
                if (jroot != null) {
                    var j_types = jroot!["CONSUMED_ASSEMBLY_TYPES"];
                    if (j_types != null) {
                        int l_count = j_types["count"]!.GetValue<int>();
                        res = new CONSUMED_ASSEMBLY_TYPES(l_count);
                        JsonArray? j_items = j_types["items"]?.AsArray();
                        if (j_items != null) {
                            int i = 0;
                            JsonObject? jo = null;
                            JsonNode? jn = null;
                            string? en = null;
                            string? dn = null;
                            int aid = 0;
                            foreach (var j in j_items) {
                                jo = j?.AsObject();
                                if (jo != null) {
                                    en = jo[JSON_NAMES.eiffel_name]?.GetValue<string>();
                                    dn = jo[JSON_NAMES.dotnet_name]?.GetValue<string>();

                                    if (en != null && dn != null) {
                                        var jnum = jo[JSON_NAMES.assembly_id];
                                        if (jnum == null) {
                                            aid = 0;
                                        } else {
                                            aid = jnum.GetValue<int>();
                                        }
                                        res.eiffel_names[i] = en;
                                        res.dotnet_names[i] = dn;
                                        jn = jo[JSON_NAMES.flag];
                                        res.flags[i] = jn != null ? jn.GetValue<int>() : 0;
                                        jn = jo[JSON_NAMES.position];
                                        res.positions[i] = jn != null ? jn.GetValue<int>() : 0;
                                        res.assembly_ids[i] = aid;
                                    }
                                }
                                i = i + 1;
                            }
                        } else {
                            JsonArray? j_eiffel_names = j_types["eiffel_names"]?.AsArray();
                            JsonArray? j_dotnet_names = j_types["dotnet_names"]?.AsArray();
                            JsonArray? j_flags = j_types["flags"]?.AsArray();
                            JsonArray? j_positions = j_types["positions"]?.AsArray();
                            JsonArray? j_assembly_ids = j_types["assembly"]?.AsArray();
                            if (j_eiffel_names != null && j_dotnet_names != null && j_flags != null && j_positions != null) {
                                for (int i = 0; i < l_count; i++) {
                                    string? en = j_eiffel_names[i]?.GetValue<string>();
                                    string? dn = j_dotnet_names[i]?.GetValue<string>();
                                    int fl = j_flags[i]!.GetValue<int>();
                                    int po = j_positions[i]!.GetValue<int>();
                                    int aid = 0;
                                    if (j_assembly_ids != null) {
                                        aid = j_assembly_ids[i]!.GetValue<int>();
                                    }
                                    if (en != null && dn != null) {
                                        res.eiffel_names[i] = en;
                                        res.dotnet_names[i] = dn;
                                        res.flags[i] = fl;
                                        res.positions[i] = po;
                                        res.assembly_ids[i] = aid;
                                    }
                                }
                            }
                        }
                        res.count = l_count;
                    }
                }
            }
            return res;
        }
        public string assembly_location(Type a_type) 
        {
            Assembly a = a_type.Assembly;
            return a.Location;
        }
        private long type_position_from_type_name (CONSUMED_ASSEMBLY ca, string a_type_name)
        {
            CONSUMED_ASSEMBLY_TYPES? l_types = assembly_types (ca);
            long res = -1;
            if (l_types != null) {
                for (int i = 0; i < l_types.count; i++) {
                    if (i >= l_types.dotnet_names.Length) {
                        break;
                    }
                    string? dn = l_types.dotnet_names[i];
                    if (dn == null) {
                        break;
                    }
                    if (a_type_name.Equals(dn)) {
                        res = l_types.positions[i];
                        if (res >= 0) {
                            break;
                        }
                    }
                }
            }
            return res;
        }
        private long type_position_from_type(Type a_type)
        {
            var ca = consumed_assembly_from_path(assembly_location(a_type));
            if (ca != null) {
                string? l_type_name = a_type.FullName;
                if (l_type_name != null) {
                    return type_position_from_type_name (ca, l_type_name);
                }
            }
            return -1;
        }

        public string? json_type_from_consumed_assembly_at_position (CONSUMED_ASSEMBLY ca, int pos)
        {
            if (pos >= 0) {
                string fn = assembly_classes_file_name_from_consumed_assembly(ca);
                if (File.Exists(fn)) {
                    string? json=null;
                    using (FileStream f = File.OpenRead(fn)) {
                        f.Position = pos;
                        var freader = new StreamReader(f);
                        json = freader.ReadLine();
                        return json;
                    }
                }
            }
            return null;
        }
/*
        public CONSUMED_TYPE? consumed_type (Type a_type)
        {
            CONSUMED_TYPE? res = null;
            var pos = type_position_from_type(a_type);
            if (pos >= 0) {
                CONSUMED_ASSEMBLY? ca = consumed_assembly_from_path(assembly_location(a_type));
                if (ca != null) {
                    string fn = assembly_classes_file_name_from_consumed_assembly(ca);
                    if (File.Exists(fn)) {
                        string? json=null;
                        using (FileStream f = File.OpenRead(fn)) {
                            f.Position = pos;
                            var freader = new StreamReader(f);
                            json = freader.ReadLine();
                            if (json != null) {
                                JsonNode? jdoc = JsonNode.Parse(json);
                                JsonNode? jroot = jdoc!.Root;
                                if (jroot != null) {
                                    //FIXME ...
                                }
                            }
                        }
                    }
                }
            }
            return res;
        }        
*/
        
        public List<CONSUMED_ASSEMBLY>? client_assemblies(CONSUMED_ASSEMBLY ca)
        {
            var lst = consumed_assemblies();
            if (lst  != null) {
                List<CONSUMED_ASSEMBLY> res = new List<CONSUMED_ASSEMBLY>(lst.Count);
                foreach (var a in lst) {
                    var l_referenced_assemblies = assembly_mapping_from_consumed_assembly (a);
                    if (l_referenced_assemblies != null && l_referenced_assemblies.has_assembly(a)) {
                        res.Add(a);
                    }
                }
                return res;
            }
            return null;
        }              
    }

    public class CACHE_WRITER : CACHE_COMMON
    {
        CACHE_READER reader;
        StringBuilder output;
        private bool is_debug=false;

        public CACHE_WRITER(string loc, StringBuilder o): base(loc)
        {
            output = o;
            reader = new CACHE_READER(loc);

            // Build assembly_mapping from existing consumed assemblies.
            CACHE_GUARD.lock_cache();
            List<CONSUMED_ASSEMBLY>? assemblies = reader.assemblies();
            CACHE_GUARD.unlock_cache();
            var l_mapping = new SHARED_ASSEMBLY_MAPPING();
            l_mapping.reset_assembly_mapping();
            if (assemblies != null) {
                // Console.WriteLine("Load assembly mapping ...");
                int i = 0;
                foreach (var c in assemblies) {
                    i = l_mapping.last_index() + 1;
                    var n = c.fullname;
                    if (n != null) {
                        if (l_mapping.is_assembly_mapped(n)) {  
                            // FIXME: why ? conflict between current App Assembly (.Net version)  and the one currently inspected?
                        } else {
                            l_mapping.record_assembly_mapping (i, n);
                        }
                    }
                }
            }
        }
        public void set_is_debug (bool b)
        {
            is_debug = b;
        }
        public CACHE_INFO cache_info()
        {
            CACHE_GUARD.lock_cache();
            var res = reader.info();
            if (res == null) {
                res = new CACHE_INFO();
            }
            CACHE_GUARD.unlock_cache();
            return res;
        }

        private void update_info(CACHE_INFO info)
        {
            CACHE_GUARD.lock_cache();
            if (info.is_dirty) {
                try {
                    var ms = new MemoryStream();
                    var options = new JsonWriterOptions { Indented = true };
                    Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
                    CONSUMER_SERIALIZER ser = new CONSUMER_SERIALIZER(writer);
                    string fn = Path.Combine(cache_location, eac_info_file_name);
                    var nb = serialize_cache_info_to_json_file (info, fn);
                    info.is_dirty = false;
                } catch {
                    // FIXME
                }
            }
            CACHE_GUARD.unlock_cache();
        }

        private void update_client_assembly_mappings(CONSUMED_ASSEMBLY ca)
        {
            CACHE_GUARD.lock_cache();
            var lst = reader.client_assemblies (ca);
            if (lst != null) {
                foreach (var a in lst) {
                    update_assembly_mappings(a);
                }
            }
            CACHE_GUARD.unlock_cache();
        }
        private void update_assembly_mappings(CONSUMED_ASSEMBLY ca)
        {
            CACHE_GUARD.lock_cache();
            var l_mappings = reader.assembly_mapping_from_consumed_assembly(ca);
            if (l_mappings != null) {
                List<CONSUMED_ASSEMBLY> lst = l_mappings.assemblies;
                for (int i = 0; i < lst.Count; i++) {
                    var l_ref_ca = consumed_assembly_from_path(lst[i].location);
                    if (l_ref_ca != null) {
                        lst[i] = l_ref_ca;
                    } else {
                        lst[i].set_is_consumed(false, true);
                    }
                }
                serialize_assembly_mapping_to_json_file(l_mappings, Path.Combine(cache_location, ca.folder_name, AssemblyConsumer.assembly_mapping_file_name));
            }
            CACHE_GUARD.unlock_cache();
        }        

        private long serialize_assembly_mapping_to_json_file (CONSUMED_ASSEMBLY_MAPPING a_mapping, string location)
        // Serialize `a_mapping` as JSON in file at `location`, and return the size of the file (i.e last position).
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = false };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            CONSUMER_SERIALIZER serializer = new CONSUMER_SERIALIZER(writer);
            writer.WriteStartObject();
            writer.WritePropertyName("CONSUMED_ASSEMBLY_MAPPING");
            writer.WriteStartObject();
            serializer.serialize_assembly_mapping(a_mapping.assemblies);
            writer.WriteEndObject();
            writer.WriteEndObject();
            writer.Flush();
            ms.Close();
            string json = System.Text.Encoding.UTF8.GetString(ms.ToArray());
            using (StreamWriter file = new(location)) {
                file.WriteLine(json);
            }
            return new System.IO.FileInfo(location).Length;
        }         

        private long serialize_cache_info_to_json_file (CACHE_INFO info, string location)
        // Serialize `info` as JSON in file at `location`, and return the size of the file (i.e last position).
        {
            var ms = new MemoryStream();
            var options = new JsonWriterOptions { Indented = false };
            Utf8JsonWriter writer = new Utf8JsonWriter(ms, options);
            CONSUMER_SERIALIZER serializer = new CONSUMER_SERIALIZER(writer);
            writer.WriteStartObject();
            writer.WritePropertyName("CACHE_INFO");
            writer.WriteStartObject();
            writer.WritePropertyName(JSON_NAMES.assemblies); //"assemblies");
            serializer.serialize_assembly_list(info.assemblies);
            writer.WriteEndObject(); // CACHE_INFO
            writer.WriteEndObject();
            writer.Flush();
            ms.Close();
            string json = System.Text.Encoding.UTF8.GetString(ms.ToArray());
            using (StreamWriter file = new(location)) {
                file.WriteLine(json);
            }
            return new System.IO.FileInfo(location).Length;
        }         
        public void unconsume_assembly(string a_path)
        {
            CACHE_GUARD.lock_cache();
            // Debug.Assert(reader.is_assembly_in_cache (a_path, true), "is assembly in cache");
            md_consumer.STATUS_PRINTER.info (String.Format("Unconsuming assembly '{0}'", a_path));
            output.AppendLine(String.Format("Unconsuming assembly '{0}'", a_path));
            CACHE_READER r = reader;
            CONSUMED_ASSEMBLY? ca = r.consumed_assembly_from_path(a_path);
            CACHE_INFO info = cache_info();
            if (ca != null && info != null) {
                string fn = reader.assembly_directory_name_from_consumed_assembly(ca);
                if (Directory.Exists(fn)) {
                    Directory.Delete(fn, true);
                }
                ca.set_is_consumed(false, true);
                info.update_assembly(ca);
                update_client_assembly_mappings(ca);
                update_info(info);
            }
            CACHE_GUARD.unlock_cache();
        }
        // public CONSUMED_ASSEMBLY? add_assembly(string a_path, bool a_info_only)
        // {
        //     List<string> processed = new List<string>(0);
        //     return add_assembly_ex (a_path, a_info_only, null, processed);
        // }
        public bool cache_is_assembly_stale(string k) 
        {
            CACHE_GUARD.lock_cache();
            bool res = false;
            var ca = consumed_assembly_from_path(k);
            if (ca != null && ca.is_consumed) {
                string l_consume_path = reader.assembly_directory_name_from_consumed_assembly(ca);
                DirectoryInfo di = new DirectoryInfo(l_consume_path);
                FileInfo fi = new FileInfo(ca.location);
                res = !Directory.Exists(l_consume_path) || DateTime.Compare(fi.LastWriteTime, di.CreationTime) > 0;
            }
            CACHE_GUARD.unlock_cache();
            return res;
        }

        public CONSUMED_ASSEMBLY? add_assembly_ex(string a_path,
                bool a_info_only, 
                List<string>? a_other_assemblies,  
                List<string> a_processed
            )
        // Add assembly at `a_path` and its dependencies into cache.
        {
            CACHE_GUARD.lock_cache();
            md_consumer.STATUS_PRINTER.info (String.Format("Adding assembly (does not mean consuming) '{0}'", a_path));

            StringBuilder o = output;
            StringBuilder data = new StringBuilder();

            string l_key_path = a_path;
            bool l_info_updated = false;

            CONSUMED_ASSEMBLY? ca = null;
            if (reader.is_initialized()) {
                ca = reader.consumed_assembly_from_path (a_path);
            }
            if (ca != null) {
                l_key_path = ca.location;
                if (ca.has_info_only && !a_info_only) {
                    // l_reason = "Consuming extra information";
                }
            } else {
                l_key_path = Path.GetFullPath(a_path);
            }
            // l_key_path = l_key_path.ToLower();

            a_processed.Add(l_key_path);

            if (ca != null && ca.is_consumed) {
                md_consumer.STATUS_PRINTER.info (String.Format("'{0}' has already been consumed. Checking ...", a_path));
                output.AppendLine(String.Format("'{0}' has already been consumed. Checking ...", a_path));
                l_info_updated = true; //FIXME: force for now
                if (l_info_updated) {
                    CACHE_INFO? info = cache_info();
                    if (info != null) {
                        info.update_assembly(ca);
                        update_info (info);
                    }
                    update_client_assembly_mappings (ca);
                }
            }
            if (ca != null && ca.is_consumed 
                    && (
                        (!a_info_only && ca.has_info_only) || cache_is_assembly_stale (l_key_path)
                    )
                )
            {
                unconsume_assembly (l_key_path);
            }
            l_info_updated = false;

            if (ca == null) {
                ca = consumed_assembly_from_path(l_key_path);
            }
            if (ca != null) {
                string fn = reader.assembly_directory_name_from_consumed_assembly(ca);
                if (!Directory.Exists(fn)) {
                    Directory.CreateDirectory(fn);
                }
                var md = new md_consumer.MdConsumer();
                var (consumed_ca, assembly) = md.consume_into_cache(ca, a_path, 
                        a_info_only, a_other_assemblies,
                        cache_location, output
                    );
                if (consumed_ca != null) {
                    l_info_updated = true;
                    var l_info = cache_info();
                    consumed_ca.set_is_consumed(true, a_info_only);
                    l_info.update_assembly(consumed_ca);
                    if (!consumed_ca.location.Equals(l_key_path)) {
                        l_info_updated = true;
                        consumed_ca.location = l_key_path;
                        l_info.update_assembly(consumed_ca);
                    }
                    update_info(l_info);

                    if (assembly != null) {
                        AssemblyName[] l_names = assembly.GetReferencedAssemblies();
                        foreach (AssemblyName l_name in l_names) {
                            Assembly? i_ass = SHARED_ASSEMBLY_LOADER.assembly_loader.assembly_from_name(l_name);
                            if (i_ass != null) {
                                string i_ass_loc = i_ass.Location;
                                if (!a_processed.Contains(i_ass_loc) && !(reader.is_assembly_in_cache(i_ass_loc, true) || cache_is_assembly_stale(i_ass_loc))) {
                                    var unused_ca = add_assembly_ex(
                                            i_ass_loc, 
                                            a_info_only || (a_other_assemblies == null || ! a_other_assemblies.Contains(i_ass_loc)), // JFIAT: check if this is really valid with ForwardedType
                                            a_other_assemblies, a_processed
                                        );
                                    l_info_updated = true;
                                }
                            }
                        }
                    }
                }
                if (l_info_updated && ca != null) {
                    update_assembly_mappings(ca);
                    update_client_assembly_mappings(ca);
                }
            }
            CACHE_GUARD.unlock_cache();
            return ca;
        }

        public CONSUMED_ASSEMBLY? consumed_assembly_from_path (string path)
        {
            CACHE_GUARD.lock_cache();
            CONSUMED_ASSEMBLY? res = null;
            string l_key_path = Path.GetFullPath(path);
            if (reader.is_initialized()) {
                res = reader.consumed_assembly_from_path(l_key_path);
            }
            if (res == null) {
                string l_uid = Guid.NewGuid().ToString().ToUpper();
                res = create_consumed_assembly_from_path (l_uid, l_key_path);
                if (res != null) {
                    CACHE_INFO info = cache_info();
                    info.add_assembly(res);
                    update_info(info);
                    reader.reset_info();
                }
            }
            CACHE_GUARD.unlock_cache();
            return res;
        }

        public CONSUMED_ASSEMBLY? create_consumed_assembly_from_path (string a_id, string path)
        {
            Assembly? a = SHARED_ASSEMBLY_LOADER.assembly_loader.assembly_from(path);
            if (a != null) {
                string s_id = a_id;
                if (is_debug) {
                    // human friendly title
                    AssemblyName? l_assembly_name = a.GetName();
                    s_id = l_assembly_name.Name + "!" + s_id;
                }
                return AssemblyAnalyzer.new_consumed_assembly(a, s_id);
            } else {
                return null;
            }
        }

        public void build_html()
        {
            build_info_html(Path.Join(cache_location, "index.html"));
        }
        public void build_info_html(string fn)
        {
            Console.WriteLine("Build html pages...");

            CACHE_INFO inf = cache_info();
            string html = @"<html>
                <head>
                    <title>.Net MetaData</title>
                    <style>
                        div#assemblies {
                            margin-bottom: 3px;
                        }
                        div.info { border-left: solid 2px #666; }
                        div.full { border-left: solid 2px #6f6; }
                        a { text-decoration: none; }
                        span.name { font-weight: bold; }
                        span.location { font-style: italic; color: #999; }
                    </style>
                </head>
                <body>
                ";
            html += "<h1>Assemblies</h1><div id=\"assemblies\">";
            foreach (CONSUMED_ASSEMBLY ca in inf.assemblies) {
                if (ca.has_info_only) {
                    html += "<div class=\"info\"> - ";
                } else {
                    html += "<div class=\"full\"> + ";
                }
                html += "<a href=\""+ ca.folder_name +"/index.html\">";
                string title = ca.guid;
                if (ca.name != null) {
                    title = ca.name;
                }
                html += "<span class=\"name\">" + title + "</span>: ";
                html += "<span class=\"location\">" + ca.location + "</span>";
                html += "</a></div>\n";
                try {
                    build_assembly_html(ca, title, Path.Join(cache_location, ca.folder_name, "index.html"));
                } catch {
                    // Ignore for now.
                }
            }
            html += "</div>";
            html += "</body></html>";
            using (StreamWriter file = new(fn)) {
                file.WriteLine(html);
            }
        }

        public void build_assembly_html(CONSUMED_ASSEMBLY ca, string title, string fn)
        {
            CACHE_GUARD.lock_cache();
            Console.WriteLine(" - build html for " + title);
            string html = @"<html>
                <head>
                    <title>";
            html += title;
            html += @"</title>
                    <style>
                        div#assemblies {
                            margin-bottom: 3px;
                        }
                        a { text-decoration: none; }
                        span.name { font-weight: bold; }
                        span.location { font-style: italic; color: #999; }
                        div#types > div { margin-top: .5em; }
                    </style>
                </head>
                <body>";
            string n = ca.guid;
            if (ca.name != null) {
                n = ca.name;
            }
            html += "<h1>Assembly: " + n + "</h1>";
            html += "<div id=\"info\">";
            html += "<div>Location: " + ca.location + "</div>\n";
            html += "<div>GUID: " + ca.guid + "</div>\n";
            html += "<div>Version: " + ca.version + "</div>\n";
            html += "<div>Culture: " + ca.culture + "</div>\n";
            html += "<div>Pub Key: " + ca.public_key_token + "</div>\n";
            html += "</div>";
            CONSUMED_ASSEMBLY_TYPES? l_types = reader.assembly_types(ca);
            if (l_types != null) {
                html += "<h2>" + l_types.count + " types</h2>\n";
                html += "<details><summary>all types</summary>\n<div id=\"types\">";
                for(int i = 0; i < l_types.count; i++) {
                    string? en = l_types.eiffel_names[i];
                    string? dn = l_types.dotnet_names[i];
                    if (en != null && dn != null) {
                        string? json = reader.json_type_from_consumed_assembly_at_position(ca, l_types.positions[i]);
                        if (json != null) {
                            html += "<details><summary><strong>"+ dn +"</strong>: "+ en + "</summary>";
                            html += "<code class=\"json\">" + System.Net.WebUtility.HtmlEncode (json) + "</code>\n";
                            html += "</details>\n";
                        } else {
                            html += "<div><strong>"+ dn +"</strong>: "+ en ;
                            // Why ?
                        }
                        html += "</div>\n";
                    }
                }
                html += "</div>\n";
                html += "</details>\n";                
            }
            string f;
            f = Path.Join (cache_location, ca.folder_name, "classes.info");
            if (File.Exists(f)) {
                html += "<div><a href=\"classes.info\">Classes</a></div>\n";
            }
            f = Path.Join (cache_location, ca.folder_name, "types.info");
            if (File.Exists(f)) {
                html += "<div><a href=\"types.info\">Types</a></div>\n";
            }
            f = Path.Join (cache_location, ca.folder_name, "referenced_assemblies.info");
            if (File.Exists(f)) {
                html += "<div><a href=\"referenced_assemblies.info\">Referenced assemblies</a></div>\n";
                CONSUMED_ASSEMBLY_MAPPING? mapping = reader.assembly_mapping_from_consumed_assembly(ca);
                if (mapping != null) {
                    html += "<ol>\n";
                    foreach (CONSUMED_ASSEMBLY i_ca in mapping.assemblies) {
                        if (i_ca.guid.Equals(ca.guid)) {
                            html += "<li>Current: "+ System.Net.WebUtility.HtmlEncode (i_ca.title()) +"</li>\n";
                        } else {
                            html += "<li><a href=\"../"+ i_ca.folder_name + "/index.html\">"+ System.Net.WebUtility.HtmlEncode (i_ca.title()) +"</a></li>\n";
                        }
                    }
                    html += "</ol>\n";
                }
            }
            html += "</body></html>";
            using (StreamWriter file = new(fn)) {
                file.WriteLine(html);
            }
            CACHE_GUARD.unlock_cache();
        }
    }
}