using System;
using System.Text;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;
using System.Linq;
using System.Diagnostics;


namespace md_consumer
{

    class CONSUMER_SERIALIZER
    {
        protected Utf8JsonWriter json_writer;
        public CONSUMER_SERIALIZER(Utf8JsonWriter writer)
        {
            json_writer = writer;
        }

        public void serialize_assembly_types (CONSUMED_ASSEMBLY_TYPES types, bool include_title=false)
        {
            var writer = json_writer;
            if (include_title) {
                writer.WritePropertyName("CONSUMED_ASSEMBLY_TYPES");
            }
            writer.WriteStartObject();
            writer.WritePropertyName(JSON_NAMES.count); //"count");
            writer.WriteNumberValue(types.count);
            bool use_items_object = true;
            if (use_items_object) {
                writer.WritePropertyName(JSON_NAMES.items); //"items");
                writer.WriteStartArray();
                int en_count=types.eiffel_names.Length;
                int dn_count=types.dotnet_names.Length;
                int fl_count=types.flags.Length;
                int po_count=types.positions.Length;
                int as_count=types.assembly_ids.Length;
                string? en=null;
                string? dn=null;

                for (var i=0; i < types.count; i++) {
                    if (i < en_count) {
                        en = types.eiffel_names[i];
                    } else {
                        en = null;
                    }
                    if (i < dn_count) {
                        dn = types.dotnet_names[i];
                    } else {
                        dn = null;
                    }
                    if (en != null || dn != null) {
                        writer.WriteStartObject();
                        writer.WritePropertyName(JSON_NAMES.eiffel_name); //"eiffel_name");
                        writer.WriteStringValue(en);
                        writer.WritePropertyName(JSON_NAMES.dotnet_name); //"dotnet_name");
                        writer.WriteStringValue(dn);

                        if (i < as_count && types.assembly_ids[i] > 0) {
                            writer.WritePropertyName(JSON_NAMES.assembly_id); //"aid");
                            writer.WriteNumberValue(types.assembly_ids[i]);
                        }
                        if (i < fl_count && types.flags[i] > 0) {
                            writer.WritePropertyName(JSON_NAMES.flag); //"flag");
                            writer.WriteNumberValue(types.flags[i]);
                        }
                        if (i < po_count && types.positions[i] > 0) {
                            writer.WritePropertyName(JSON_NAMES.position); //"position");
                            writer.WriteNumberValue(types.positions[i]);
                        }
                        writer.WriteEndObject();

                    }
                }
                writer.WriteEndArray();
            } else {
                writer.WritePropertyName(JSON_NAMES.eiffel_names); //"eiffel_names");
                writer.WriteStartArray();
                foreach (string en in types.eiffel_names) {
                    writer.WriteStringValue(en);
                }
                writer.WriteEndArray();

                writer.WritePropertyName(JSON_NAMES.dotnet_names); //"dotnet_names");
                writer.WriteStartArray();
                foreach (string dn in types.dotnet_names) {
                    writer.WriteStringValue(dn);
                }
                writer.WriteEndArray();

                writer.WritePropertyName(JSON_NAMES.flags); //"flags");
                writer.WriteStartArray();
                foreach (int f in types.flags) {
                    writer.WriteNumberValue(f);
                }
                writer.WriteEndArray();
                
                writer.WritePropertyName(JSON_NAMES.positions); //"positions");
                writer.WriteStartArray();
                foreach (int pos in types.positions) {
                    writer.WriteNumberValue(pos);
                }
                writer.WriteEndArray();

                writer.WritePropertyName(JSON_NAMES.assemblies); //"assemblies");
                writer.WriteStartArray();
                foreach (int aid in types.assembly_ids) {
                    writer.WriteNumberValue(aid);
                }
                writer.WriteEndArray();
            }
            writer.WriteEndObject();
        }
        public void serialize_assembly_mapping (List<CONSUMED_ASSEMBLY> list)
        {
            var writer = json_writer;
            writer.WritePropertyName(JSON_NAMES.assemblies); //"assemblies");
            serialize_assembly_list(list);
        }
        public void serialize_assembly_list (List<CONSUMED_ASSEMBLY> list)
        {
            var writer = json_writer;
            writer.WriteStartArray();
            foreach (CONSUMED_ASSEMBLY a in list)
            {
                writer.WriteStartObject();
                writer.WritePropertyName(JSON_NAMES.unique_id); // "uid");
                writer.WriteStringValue(a.guid.ToUpper());
                writer.WritePropertyName(JSON_NAMES.folder_name); // "folder");
                writer.WriteStringValue(a.folder_name);
                if (a.name != null) {
                    writer.WritePropertyName(JSON_NAMES.name); //"name");
                    writer.WriteStringValue(a.name);
                }
                if (a.fullname != null) {
                    writer.WritePropertyName(JSON_NAMES.fullname); //"fullname");
                    writer.WriteStringValue(a.fullname);
                }                
                writer.WritePropertyName(JSON_NAMES.version); //"version");
                writer.WriteStringValue(a.version);
                writer.WritePropertyName(JSON_NAMES.culture); //"culture");
                writer.WriteStringValue(a.culture);
                writer.WritePropertyName(JSON_NAMES.public_key_token); //"public_key_token");
                writer.WriteStringValue(a.public_key_token);
                writer.WritePropertyName(JSON_NAMES.location); //"location");
                writer.WriteStringValue(a.location);
                if (a.in_gac) {
                    writer.WritePropertyName(JSON_NAMES.is_in_gac); //"is_in_gac");
                    writer.WriteBooleanValue(true);
                }
                if (a.has_info_only) {
                    writer.WritePropertyName(JSON_NAMES.has_info_only); //"has_info_only");
                    writer.WriteBooleanValue(true);
                }                
                writer.WritePropertyName(JSON_NAMES.is_consumed); //"is_consumed");
                writer.WriteBooleanValue(a.is_consumed);

                writer.WriteEndObject();
            }
            writer.WriteEndArray();
        }        
        public void serialize_type (CONSUMED_TYPE type, bool include_title=true)
        {
            var writer = json_writer;
            if (include_title) {
                writer.WritePropertyName("CONSUMED_TYPE");
                begin_serialize_object(type, false);
            }
            writer.WritePropertyName(JSON_NAMES.dotnet_name); //"dotnet_name");
            writer.WriteStringValue(type.dotnet_name);
            writer.WritePropertyName(JSON_NAMES.eiffel_name); //"eiffel_name");
            writer.WriteStringValue(type.eiffel_name);
            if (type.assembly_id >= 0) {
                writer.WritePropertyName(JSON_NAMES.assembly_id); //"assembly_id");
                writer.WriteNumberValue(type.assembly_id);
            }
            if (type.is_interface()) {
                writer.WritePropertyName(JSON_NAMES.is_interface); //"is_interface");
                writer.WriteBooleanValue(true);
            }
            if (type.parent != null) {
                writer.WritePropertyName(JSON_NAMES.parent); 
                serialize_referenced_type_as_object(type.parent);
            }                  
            if (type.is_deferred()) {
                writer.WritePropertyName(JSON_NAMES.is_deferred); //"is_deferred");
                writer.WriteBooleanValue(true);
            }
            if (type.is_enum()) {
                writer.WritePropertyName(JSON_NAMES.is_enum); //"is_enum");
                writer.WriteBooleanValue(true);
            }
            if (type.is_frozen()) {
                writer.WritePropertyName(JSON_NAMES.is_frozen); //"is_frozen");
                writer.WriteBooleanValue(true);
            }
            if (type.is_expanded()) {
                writer.WritePropertyName(JSON_NAMES.is_expanded); //"is_expanded");
                writer.WriteBooleanValue(true);
            }           

            if (type is CONSUMED_NESTED_TYPE) {
                CONSUMED_NESTED_TYPE nested_type = (CONSUMED_NESTED_TYPE) type;
                writer.WritePropertyName(JSON_NAMES.enclosing_type); //"enclosing_type");
                serialize_referenced_type_as_object(nested_type.enclosing_type);
            }             

            List<CONSUMED_REFERENCED_TYPE>? interfaces = type.interfaces;
            if (interfaces != null) {
                writer.WritePropertyName(JSON_NAMES.interfaces); //"interfaces");
                writer.WriteStartArray();
                foreach (CONSUMED_REFERENCED_TYPE l_int in interfaces)
                {
                    // begin_serialize_object (l_int);
                    serialize_referenced_type_as_object (l_int);
                    // end_serialize_object (l_int);
                }
                writer.WriteEndArray();
            }

            List<CONSUMED_FIELD>? fields = type.fields;
            if (fields != null) {
                writer.WritePropertyName(JSON_NAMES.fields); //"fields");
                writer.WriteStartArray();
                foreach (CONSUMED_FIELD l_field in fields)
                {
                    begin_serialize_object (l_field);
                    serialize_field (l_field);
                    end_serialize_object (l_field);
                }
                writer.WriteEndArray();
            }
            var properties = type.properties;
            if (properties != null) {
                writer.WritePropertyName(JSON_NAMES.properties); //"properties");
                writer.WriteStartArray();
                foreach (CONSUMED_PROPERTY l_property in properties)
                {
                    begin_serialize_object (l_property);
                    serialize_property (l_property);
                    end_serialize_object (l_property);
                }
                writer.WriteEndArray();                
            }
            var events = type.events;
            if (events != null) {
                writer.WritePropertyName(JSON_NAMES.events); //"events");
                writer.WriteStartArray();
                foreach (CONSUMED_EVENT l_event in events)
                {
                    begin_serialize_object (l_event);
                    serialize_event (l_event);
                    end_serialize_object (l_event);
                }
                writer.WriteEndArray();               
            }
            var constructors = type.constructors;
            if (constructors != null) {
                writer.WritePropertyName(JSON_NAMES.constructors); //"constructors");
                writer.WriteStartArray();
                foreach (CONSUMED_CONSTRUCTOR l_constructor in constructors)
                {
                    begin_serialize_object (l_constructor);
                    serialize_constructor (l_constructor);
                    end_serialize_object (l_constructor);
                }
                writer.WriteEndArray();                
            }
            var procedures = type.internal_procedures;
            if (procedures != null) {
                writer.WritePropertyName(JSON_NAMES.procedures); //"procedures");
                writer.WriteStartArray();
                foreach (CONSUMED_PROCEDURE l_procedure in procedures)
                {
                    begin_serialize_object (l_procedure);
                    serialize_procedure (l_procedure);
                    end_serialize_object (l_procedure);
                }
                writer.WriteEndArray();                
            }
            var functions = type.internal_functions;
            if (functions != null) {
                writer.WritePropertyName(JSON_NAMES.functions); //"functions");
                writer.WriteStartArray();
                foreach (CONSUMED_FUNCTION l_function in functions)
                {
                    begin_serialize_object(l_function);
                    serialize_function (l_function);
                    end_serialize_object(l_function);
                }
                writer.WriteEndArray();                
            }
            if (include_title) {
                end_serialize_object(type);
            }
        }
        public void begin_serialize_object (Object obj, bool inc_type_name=false)
        {
            var writer = json_writer;
            writer.WriteStartObject();
            if (inc_type_name) {
                writer.WritePropertyName("_TYPE");
                writer.WriteStringValue(obj.GetType().Name);
            }
        }
        public void end_serialize_object (Object obj, bool inc_type_name=true)
        {
            var writer = json_writer;
            if (inc_type_name) {
                writer.WritePropertyName("_TYPE");
                writer.WriteStringValue(obj.GetType().Name);
            }
            writer.WriteEndObject();
        }        

        public void serialize_entity (CONSUMED_ENTITY e)
        {
            var writer = json_writer;
            writer.WritePropertyName(JSON_NAMES.dotnet_name); //"dotnet_name");
            writer.WriteStringValue(e.dotnet_name);
            writer.WritePropertyName(JSON_NAMES.eiffel_name); //"eiffel_name");
            writer.WriteStringValue(e.eiffel_name);
            writer.WritePropertyName(JSON_NAMES.dotnet_eiffel_name); //"dotnet_eiffel_name");
            writer.WriteStringValue(e.dotnet_eiffel_name);
            writer.WritePropertyName(JSON_NAMES.declared_type); //"declared_type");
            serialize_referenced_type_as_object (e.declared_type);
            if (e.is_public()) {
                writer.WritePropertyName(JSON_NAMES.is_public); //"is_public");
                writer.WriteBooleanValue(true);
            }
        }
        public void serialize_member (CONSUMED_MEMBER m)
        {
            var writer = json_writer;
            serialize_entity (m);
            if (m.is_frozen()) {
                writer.WritePropertyName(JSON_NAMES.is_frozen); //"is_frozen");
                writer.WriteBooleanValue(true);
            }
            if (m.is_static()) {
                writer.WritePropertyName(JSON_NAMES.is_static); //"is_static");
                writer.WriteBooleanValue(true);
            }
            if (m.is_virtual()) {
                writer.WritePropertyName(JSON_NAMES.is_virtual); //"is_virtual");
                writer.WriteBooleanValue(true);
            }             
            if (m.is_deferred()) {
                writer.WritePropertyName(JSON_NAMES.is_deferred); //"is_deferred");
                writer.WriteBooleanValue(true);
            }
            if (m.is_artificially_added()) {
                writer.WritePropertyName(JSON_NAMES.is_artificially_added); //"is_artificially_added");
                writer.WriteBooleanValue(true);
            }
            if (m.is_property_or_event()) {
                writer.WritePropertyName(JSON_NAMES.is_property_or_event); //"is_property_or_event");
                writer.WriteBooleanValue(true);
            } 
            if (m.is_new_slot()) {
                writer.WritePropertyName(JSON_NAMES.is_new_slot); //"is_new_slot");
                writer.WriteBooleanValue(true);
            } 
            if (m.is_attribute_setter()) {
                writer.WritePropertyName(JSON_NAMES.is_attribute_setter); //"is_attribute_setter");
                writer.WriteBooleanValue(true);
            }                                                
        }        
        public void serialize_field (CONSUMED_FIELD field)
        {
            var writer = json_writer;
            serialize_member (field);
            writer.WritePropertyName(JSON_NAMES.return_type); //"return_type");
            serialize_referenced_type_as_object (field.return_type);
            if (field.setter != null) {
                writer.WritePropertyName(JSON_NAMES.setter); //"setter");
                begin_serialize_object(field.setter);
                serialize_procedure (field.setter);
                end_serialize_object(field.setter);
            }
            if (field.is_attribute) {
                writer.WritePropertyName(JSON_NAMES.is_attribute); //"is_attribute");
                writer.WriteBooleanValue(true);
            } 
            if (field.has_return_value) {
                writer.WritePropertyName(JSON_NAMES.has_return_value); //"has_return_value");
                writer.WriteBooleanValue(true);
            }   
            if (field.is_init_only()) {
                writer.WritePropertyName(JSON_NAMES.is_init_only); //"is_init_only");
                writer.WriteBooleanValue(true);
            }   
            if (field is CONSUMED_LITERAL_FIELD) {
                CONSUMED_LITERAL_FIELD lf = (CONSUMED_LITERAL_FIELD) field;
                if (lf.is_literal) {
                    writer.WritePropertyName(JSON_NAMES.is_literal); //"is_literal");
                    writer.WriteBooleanValue(true);
                }
                writer.WritePropertyName(JSON_NAMES.value); //"value");
                writer.WriteStringValue(lf.value);

            }   
        }
        public void serialize_property (CONSUMED_PROPERTY prop)
        {
            var writer = json_writer;
            serialize_entity (prop);
            if (prop.is_static) {
                writer.WritePropertyName(JSON_NAMES.is_static); //"is_static");
                writer.WriteBooleanValue(true);
            }
            if (prop.getter != null) {
                writer.WritePropertyName(JSON_NAMES.getter); //"getter");
                begin_serialize_object(prop.getter);
                serialize_function(prop.getter);
                end_serialize_object(prop.getter);
            }
            if (prop.setter != null) {
                writer.WritePropertyName(JSON_NAMES.setter); //"setter");
                begin_serialize_object(prop.setter);
                serialize_procedure(prop.setter);
                end_serialize_object(prop.setter);
            }            
        }
        public void serialize_event (CONSUMED_EVENT ev)
        {
            var writer = json_writer;
            serialize_entity (ev);
            if (ev.is_event) {
                writer.WritePropertyName(JSON_NAMES.is_event); //"is_event");
                writer.WriteBooleanValue(true);
            }
            if (ev.is_property_or_event) {
                writer.WritePropertyName(JSON_NAMES.is_property_or_event); //"is_property_or_event");
                writer.WriteBooleanValue(true);
            }
            if (ev.adder != null) {
                writer.WritePropertyName(JSON_NAMES.adder); //"adder");
                begin_serialize_object(ev.adder);
                serialize_procedure(ev.adder);
                end_serialize_object(ev.adder);
            }
            if (ev.remover != null) {
                writer.WritePropertyName(JSON_NAMES.remover); //"remover");
                begin_serialize_object(ev.remover);
                serialize_procedure(ev.remover);
                end_serialize_object(ev.remover);
            }
            if (ev.raiser != null) {
                writer.WritePropertyName(JSON_NAMES.raiser); //"raiser");
                begin_serialize_object(ev.raiser);
                serialize_procedure(ev.raiser);
                end_serialize_object(ev.raiser);
            }
        }             
        public void serialize_constructor (CONSUMED_CONSTRUCTOR cons)
        {
            var writer = json_writer;
            serialize_entity (cons);
            writer.WritePropertyName(JSON_NAMES.arguments); //"arguments");
            writer.WriteStartArray();
            foreach(CONSUMED_ARGUMENT arg in cons.arguments)
            {
                begin_serialize_object(arg);
                serialize_argument(arg);
                end_serialize_object(arg);
            }
            writer.WriteEndArray();
        }      
        public void serialize_procedure (CONSUMED_PROCEDURE proc)
        {
            var writer = json_writer;
            serialize_member (proc);
            writer.WritePropertyName(JSON_NAMES.arguments); //"arguments");
            writer.WriteStartArray();
            foreach(CONSUMED_ARGUMENT arg in proc.arguments)
            {
                begin_serialize_object(arg);
                serialize_argument(arg);
                end_serialize_object(arg);
            }
            writer.WriteEndArray();
        }    
        public void serialize_function (CONSUMED_FUNCTION func)
        {
            var writer = json_writer;
            serialize_procedure (func);
            writer.WritePropertyName(JSON_NAMES.return_type); //"return_type");
            serialize_referenced_type_as_object(func.return_type);
            if (func.is_infix()) {
                writer.WritePropertyName(JSON_NAMES.is_infix); //"is_infix");
                writer.WriteBooleanValue(true);
            }
            if (func.is_prefix()) {
                writer.WritePropertyName(JSON_NAMES.is_prefix); //"is_prefix");
                writer.WriteBooleanValue(true);
            }
        }
        public void serialize_argument (CONSUMED_ARGUMENT arg)
        {
            var writer = json_writer;
            writer.WritePropertyName(JSON_NAMES.dotnet_name); //"dotnet_name");
            writer.WriteStringValue(arg.dotnet_name);
            writer.WritePropertyName(JSON_NAMES.eiffel_name); //"eiffel_name");
            writer.WriteStringValue(arg.eiffel_name);
            writer.WritePropertyName(JSON_NAMES.type); //"type");
            serialize_referenced_type_as_object(arg.type);
        }

        public void serialize_referenced_type_as_object (CONSUMED_REFERENCED_TYPE ref_type, bool inc_type_name=false)
        {
            var writer = json_writer;
            begin_serialize_object(ref_type, inc_type_name);
            writer.WritePropertyName(JSON_NAMES.name); //"name");
            writer.WriteStringValue(ref_type.name);
            writer.WritePropertyName(JSON_NAMES.assembly_id); //"assembly_id");
            writer.WriteNumberValue(ref_type.assembly_id);
            if (ref_type is CONSUMED_ARRAY_TYPE) {
                CONSUMED_ARRAY_TYPE arr_type = (CONSUMED_ARRAY_TYPE) ref_type;
                writer.WritePropertyName(JSON_NAMES.element_type); //"element_type");
                serialize_referenced_type_as_object(arr_type.element_type, inc_type_name);
            }
            end_serialize_object(ref_type, inc_type_name);
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

        private string? type_declaration()
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
        private bool is_eiffel_compliant() 
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
