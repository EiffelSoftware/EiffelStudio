using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    public class CONSUMED_REFERENCED_TYPE
    {
        public string name;
        public int assembly_id;

        public CONSUMED_REFERENCED_TYPE(string n, int i)
        {
            name = n;
            assembly_id = i;
        }

        public bool is_by_ref() 
        {
            return name[name.Length - 1] == '&';
        }
        public void set_is_by_ref()
        {
            name = name + '&';
        }

        public bool same_as (CONSUMED_REFERENCED_TYPE other)
        {
            return assembly_id.Equals(other.assembly_id) && name.Equals(other.name) && is_by_ref() == other.is_by_ref();
        }
    }   

    public class CONSUMED_ARRAY_TYPE : CONSUMED_REFERENCED_TYPE
    {
        public CONSUMED_REFERENCED_TYPE element_type;
        public CONSUMED_ARRAY_TYPE(string n, int i, CONSUMED_REFERENCED_TYPE t) : base (n, i)
        {
            element_type = t;
        }
    }

    public class CONSUMED_TYPE
    {
        public string dotnet_name;
        public string eiffel_name;
        public CONSUMED_REFERENCED_TYPE? parent;
        public List<CONSUMED_REFERENCED_TYPE> interfaces;
        public int flags = 0;
			// -- Different mask.        
        static int is_deferred_mask = 1;
	    static int is_enum_mask = 2;
	    static int is_expanded_mask = 4;
	    static int is_frozen_mask = 8;
	    static int is_interface_mask = 16;
        public List<CONSUMED_FIELD>? fields = null;
        public List<CONSUMED_PROCEDURE>? internal_procedures = null;
        public List<CONSUMED_FUNCTION>? internal_functions = null;
        public List<CONSUMED_PROPERTY>? properties = null;
        public List<CONSUMED_EVENT>? events = null;
        public List<CONSUMED_CONSTRUCTOR>? constructors = null;

        public CONSUMED_TYPE (string dn, string en,
			bool is_inter, bool is_abstract, bool is_sealed, bool is_value_type, bool is_enumerator,
            CONSUMED_REFERENCED_TYPE? par,
            List<CONSUMED_REFERENCED_TYPE> interf
        )
        {
            dotnet_name = dn;
            eiffel_name = en;
            if (is_inter) flags = flags | is_interface_mask;
            if (is_abstract) flags = flags | is_deferred_mask;
            if (is_sealed) flags = flags | is_frozen_mask;
            if (is_value_type) flags = flags | is_expanded_mask;
            if (is_enumerator) flags = flags | is_enum_mask;
            parent = par;
            interfaces = interf;
        }

        public bool is_interface() => (flags & is_interface_mask) == is_interface_mask;
			// -- Is .NET type an interface?
        public bool is_deferred() => (flags & is_deferred_mask) == is_deferred_mask;
			// -- Is .NET type abstract?
        public bool is_enum() => (flags & is_enum_mask) == is_enum_mask;
			// -- Is .NET type an enum?
        public bool is_frozen() => (flags & is_frozen_mask) == is_frozen_mask;
			// -- Is .NET type sealed?
        public bool is_expanded() => (flags & is_expanded_mask) == is_expanded_mask;
			// -- Is .NET type a value type?
        public void set_fields (List<CONSUMED_FIELD> lst)
        {
            fields = lst;
        }
        public void set_procedures (List<CONSUMED_PROCEDURE> lst)
        {
            internal_procedures = lst;
        }
        public void set_functions (List<CONSUMED_FUNCTION> lst)
        {
            internal_functions = lst;
        }
        public void set_properties (List<CONSUMED_PROPERTY> lst)
        {
            properties = lst;
        }
        public void set_events (List<CONSUMED_EVENT> lst)
        {
            events = lst;
        }        
        public void set_constructors (List<CONSUMED_CONSTRUCTOR> lst)
        {
            constructors = lst;
        }

    }

    public class CONSUMED_NESTED_TYPE : CONSUMED_TYPE
    {
        public CONSUMED_REFERENCED_TYPE enclosing_type;
        public CONSUMED_NESTED_TYPE (string dn, string en,
			bool is_inter, bool is_abstract, bool is_sealed, bool is_value_type, bool is_enumerator,
            CONSUMED_REFERENCED_TYPE? par,
            List<CONSUMED_REFERENCED_TYPE> interfaces,
            CONSUMED_REFERENCED_TYPE enc_type
        ) : base(dn, en, is_inter, is_abstract, is_sealed, is_value_type, is_enumerator, par, interfaces)
        {
            enclosing_type = enc_type;
        }
    }
    
    public class JSON_CONSUMED_TYPE
    {
        public Type type;

        public JSON_CONSUMED_TYPE(Type t)
        {
            type = t;
        }

        public void appendToJson(Utf8JsonWriter writer) 
        {
            writer.WritePropertyName("type");
            writer.WriteStartObject();

            Type? baseType = type.BaseType;
            string? tname = type_declaration();

            if (tname != null) { // && is_eiffel_compliant()) {

                writer.WritePropertyName("name");
                writer.WriteStringValue(tname);

                if (type.IsClass && baseType != null && !String.Equals(baseType.FullName, "System.Object", StringComparison.InvariantCulture))
                {
                    writer.WritePropertyName("ancestor");
                    writer.WriteStringValue(baseType.FullName);
                }
                ConstructorInfo[] l_constructors = type.GetConstructors();
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

                FieldInfo[] l_fields = type.GetFields();
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

                MethodInfo[] l_methods = type.GetMethods();
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
            writer.WriteEndObject(); // type
        }

        public void appendTypeNamesToJsonArray(Utf8JsonWriter writer) 
        {
            Type? baseType = type.BaseType;
            string? tname = type_declaration();

            if (tname != null && is_eiffel_compliant()) {
                tname = tname + " " + type.FullName;
                writer.WriteStringValue(tname);
            }
        }

        string? type_declaration()
        {
            if (type.IsClass)
            {
                return "class";
            }
            else if (type.IsValueType)
            {
                Type? baseType = type.BaseType;

                if (String.Equals(baseType?.FullName, "System.Enum", StringComparison.InvariantCulture))
                {
                    return "enum";
                }
                else
                {
                    return "struct";
                }
            }
            else if (type.IsInterface)
            {
                return "interface";
            }
            else
            {
                // return "unknown";
                return null;
            }
        }
        bool is_eiffel_compliant() 
        {
            /*
             * Check REFLECTION.is_consumed_type and EC_CHECKED_ENTITY 
             */
             
            string? tname=type_declaration();

            if (tname == null)
            {
                return false;
            }
            else if (type.IsNested || type.IsNotPublic || type.Name.Contains("<"))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }

}