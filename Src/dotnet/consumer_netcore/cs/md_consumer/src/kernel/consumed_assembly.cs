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
        public CONSUMED_ASSEMBLY(CONSUMED_ASSEMBLY ca)
        // Duplication of `ca`
        {
            guid = ca.guid;
            folder_name = ca.folder_name;
            name = ca.name;
            location = ca.location;
            public_key_token = ca.public_key_token;
            culture = ca.culture;
            version = ca.version;
            fullname = ca.fullname;
            is_consumed = ca.is_consumed;
            has_info_only = ca.has_info_only;
        }
        public bool same_as (CONSUMED_ASSEMBLY? other)
        {
            if (this == other) {
                return true;
            } else if (other == null) {
                return false;
            } else {
                return same_locations(location, other.location);
            }
        }

        private bool same_locations (string loc1, string loc2)
        {
            string s1;
            string s2;
            if (Path.IsPathRooted(loc1) && Path.IsPathRooted(loc2)) {
                s1 = Path.GetFullPath(loc1);
                s2 = Path.GetFullPath(loc2);             
            } else {
                s1 = loc1;
                s2 = loc2;
            }
            if ((System.Environment.OSVersion.Platform == PlatformID.Unix) || (System.Environment.OSVersion.Platform == PlatformID.Other)) {
                return string.Equals(s1, s2);
            } else {
                /* Windows */
                return string.Equals(s1, s2, StringComparison.OrdinalIgnoreCase);
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
        public bool has_same_path (string path)
        {
            return same_locations(location, path);
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