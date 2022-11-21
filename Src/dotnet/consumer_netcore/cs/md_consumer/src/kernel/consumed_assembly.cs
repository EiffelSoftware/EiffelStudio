using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    public class CONSUMED_ASSEMBLY
    {
        public string guid;
        public string folder_name;
        public string? name;
        public string location;
        public string public_key_token;
        public string culture;
        public string version;
        public string? fullname;

        public bool in_gac=false; /* Obsolete  in .Net core */

        public bool is_consumed = false;
        public bool has_info_only = true;
        public CONSUMED_ASSEMBLY(string id, string? fn, string? n, string v, string c, string k, string loc)
        {
            guid = id;
            if (fn != null) {
                folder_name = fn;
            } else {
                folder_name = id;
            }
            name = n;
            location = loc;
            public_key_token = k;
            culture = c;
            version = v;
            in_gac = false; /* GAC is only supported for .Net framework, otherwise it is obsolete */
        }
        public bool same_as (CONSUMED_ASSEMBLY? other)
        {
            if (other == null) {
                return false;
            } else {
                return string.Equals(location, other.location, StringComparison.OrdinalIgnoreCase); //FIXME
            }
        }
        public bool same_info_as (CONSUMED_ASSEMBLY? other)
        {
            if (other == null) {
                return false;
            } else {
                string? n1,n2;
                n1 = name;
                n2 = other.name;
                return ((n1 == null || n2 == null) || n1.Equals (n2)) //FIXME
                    && version.Equals(other.version)
                    && culture.Equals(other.culture)
                    && public_key_token.Equals(other.public_key_token)
                    ;
            }
        }
        public bool has_same_path (string path, bool is_already_prepared=false)       
        {
            string p;
            if (is_already_prepared) {
                p = path;
            } else {
                p = Path.GetFullPath(path);
            }
            return location.Equals(p); //FIXME implement same file as ... using handle ...
        }

        public void set_is_consumed (bool a_is_consumed, bool info_only) {
            is_consumed = a_is_consumed;
            has_info_only = info_only;
        }

        public void appendToJson(Utf8JsonWriter writer) 
        {
            
            writer.WritePropertyName(JSON_NAMES.assembly);
            writer.WriteStartObject();

            writer.WritePropertyName(JSON_NAMES.unique_id);
            writer.WriteStringValue(guid);

            writer.WritePropertyName(JSON_NAMES.name);
            writer.WriteStringValue(name);
            
            writer.WritePropertyName(JSON_NAMES.location);
            writer.WriteStringValue(location);

            writer.WritePropertyName(JSON_NAMES.public_key_token);
            writer.WriteStringValue(public_key_token);

            writer.WritePropertyName(JSON_NAMES.culture);
            writer.WriteStringValue(culture);

            writer.WritePropertyName(JSON_NAMES.version);
            writer.WriteStringValue(version);

            if (has_info_only) {
                writer.WritePropertyName(JSON_NAMES.has_info_only);
                writer.WriteBooleanValue(has_info_only);
            }
            writer.WritePropertyName(JSON_NAMES.is_in_gac);
            writer.WriteBooleanValue(in_gac); // FIXME

            if (fullname != null)
            {
                writer.WritePropertyName(JSON_NAMES.fullname);
                writer.WriteStringValue(fullname);
            }

            writer.WriteEndObject(); // assembly
        }
    }

}