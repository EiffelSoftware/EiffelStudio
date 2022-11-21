using System;
using System.Text;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting;
using System.Text.Json;
using System.Linq;
using System.Diagnostics;
using EiffelSoftware.Runtime;

namespace md_consumer
{
    class EC_CHECKED_REASON_CONSTANTS
    {
        		// Entity marks
        static public string reason_assembly_marked_non_cls_compliant = "Assembly was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_type_marked_non_cls_compliant = "Type was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_constructor_marked_non_cls_compliant = "Constructor was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_method_marked_non_cls_compliant = "Method was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_property_marked_non_cls_compliant = "Property was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_field_marked_non_cls_compliant = "Field was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_event_marked_non_cls_compliant = "Event was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_member_marked_non_cls_compliant = "Member was marked with 'ClsCompliantAttribute (false)'";
        static public string reason_assembly_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_type_marked_non_eiffel_consumable = "Type was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_constructor_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_method_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_property_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_field_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_event_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";
        static public string reason_member_marked_non_eiffel_consumable = "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'";

            // Entity name
        static public string reason_type_name_is_non_compliant = "Type name is non-compliant";
        static public string reason_method_name_is_non_compliant = "Method name is non-compliant";
        static public string reason_property_name_is_non_compliant = "Property name is non-compliant";
        static public string reason_field_name_is_non_compliant = "Field name is non-compliant";
        static public string reason_event_name_is_non_compliant = "Event name is non-compliant";

            // Interface
        static public string reason_interface_contains_non_cls_compliant_members = "Interface contains non-CLS-compliant members";
        static public string reason_interface_contains_non_eiffel_compliant_members = "Interface contains non-Eiffel-compliant members";

            // Using non-compliant types
        static public string reason_field_uses_non_compliant_type = "Field uses non-compliant type";
        static public string reason_event_uses_non_compliant_type = "Event uses non-compliant type";
        static public string reason_property_uses_non_compliant_type = "Property uses non-compliant type";
        static public string reason_method_returns_non_compliant_type = "Method returns a non-compliant type";
        static public string reason_parameters_uses_non_compliant_types = "One or more parameters use non-compliant types";

            // Varargs
        static public string reason_constructor_uses_var_args = "Constructor accepts variable number of parameters";
        static public string reason_method_uses_var_args = "Method accepts variable number of parameters";

            // Generics
        static public string reason_type_is_generic = "Type is a generic type";
        static public string reason_member_is_generic = "Member is a generic member";
        static public string reason_type_is_not_visible = "Type is not visible";

        static public string reason_entity_marked_non_eiffel_compliant = "Entity was marked with EIFFEL_CONSUMABLE_ATTRIBUTE";

        static public string reason_type_crash = "Crash during type evaluation";
    }
    class EC_CHECKED_CACHE
    {
        static public Hashtable? checked_entities_table;

        public EC_CHECKED_CACHE()
        {
            if (checked_entities_table == null) {
                checked_entities_table = new Hashtable();
                add_predefine_checked_entities (checked_entities_table);
            }
        }
        public Hashtable checked_entities() {
            Hashtable? tb = checked_entities_table;
            if (tb == null) {
                // See EC_CHECKED_CACHE constructor
                Debug.Assert(false, "table already set");
                tb = new Hashtable();
                checked_entities_table = tb;
            }
            return tb;
        }
        public EC_CHECKED_ENTITY? cached_checked_entity(Object obj)
        {
            Hashtable tb = checked_entities();

            Object? r = tb[obj];
            if (r != null && typeof(EC_CHECKED_ENTITY).IsAssignableFrom(r.GetType())) {
                return (EC_CHECKED_ENTITY) r;
            } else {
                return null;
            }
        }
        public void set_checked_entity (ICustomAttributeProvider e, EC_CHECKED_ENTITY ce)
        {
            Hashtable? tb = checked_entities();
            tb.Add(e, ce);
        }
        public void wipe_out_cache()
        {
            Hashtable? tb = checked_entities();
            tb.Clear();
            add_predefine_checked_entities (tb);
        }

        void add_predefine_checked_entities (Hashtable a_table)
        {
			add_predefined_type ("System.SByte", false, true, a_table);
			add_predefined_type ("System.Int16", true, true, a_table);
			add_predefined_type ("System.Int32", true, true, a_table);
			add_predefined_type ("System.Int64", true, true, a_table);
			add_predefined_type ("System.Single", true, true, a_table);
			add_predefined_type ("System.Double", true, true, a_table);
			add_predefined_type ("System.Char", true, true, a_table);
			add_predefined_type ("System.Boolean", true, true, a_table);
			add_predefined_type ("System.String", true, true, a_table);
			add_predefined_type ("System.Byte" , true, true, a_table);
			add_predefined_type ("System.UInt16", false, true, a_table);
			add_predefined_type ("System.UInt32", false, true, a_table);
			add_predefined_type ("System.UInt64", false, true, a_table);
			add_predefined_type ("System.IntPtr", true, true, a_table);
			add_predefined_type ("System.UIntPtr", false, false, a_table);
			add_predefined_type ("System.Void", true, true, a_table);
			add_predefined_type ("System.TypedReference", false, false, a_table);
		}


	    void add_predefined_type (string name, bool is_compliant, bool is_eiffel_compliant, Hashtable table)
			// -- Add a predefined type of name `name`
			// -- that is compliant and Eiffel-compliant according to values of `is_compliant` and `is_eiffel_compliant`
			// -- to the table `table`.
		{
            Type? t;
            t = Type.GetType(name);
			if (t != null) {
                table.Add (t, new EC_STATIC_CHECKED_TYPE(t, is_compliant, is_eiffel_compliant));
            } else {
                // check is_type_predefined: false end
			}
        }
    }

    class EC_CHECKED_ENTITY_FACTORY : EC_CHECKED_CACHE
    {
        public EC_CHECKED_ASSEMBLY checked_assembly(Assembly a)
        {
            EC_CHECKED_ASSEMBLY? l_checked_asm = null;
            EC_CHECKED_ENTITY? e = null;
            e = cached_checked_entity (a);
            if (e != null && typeof(EC_CHECKED_ASSEMBLY).IsAssignableFrom(e.GetType())) {
                return (EC_CHECKED_ASSEMBLY) e;
            } else {
                l_checked_asm = new EC_CHECKED_ASSEMBLY(a);
                if (l_checked_asm.cache_checked_entity()) {
                    set_checked_entity (a, l_checked_asm);
                }
                return l_checked_asm;
            }
        }

        public EC_CHECKED_TYPE checked_type(Type t)
        {
            EC_CHECKED_TYPE? l_checked_type = null;
            EC_CHECKED_ENTITY? e = null;
            e = cached_checked_entity (t);
            if (e != null && typeof(EC_CHECKED_TYPE).IsAssignableFrom(e.GetType())) {
                return (EC_CHECKED_TYPE) e;
            } else {
                if (t.IsInterface || t.IsAbstract) {
                    l_checked_type = new EC_CHECKED_ABSTRACT_TYPE(t);
                } else {
                    l_checked_type = new EC_CHECKED_TYPE(t);
                }
                if (l_checked_type.cache_checked_entity()) {
                    set_checked_entity (t, l_checked_type);
                    Debug.Assert(cached_checked_entity(t) != null, "has cached checked entity");
                }
                return l_checked_type;
            }
        }

        public EC_CHECKED_MEMBER? checked_member (MemberInfo m)
        {
            EC_CHECKED_ENTITY? e = null;
            e = cached_checked_entity (m);
            if (e != null && typeof(EC_CHECKED_MEMBER).IsAssignableFrom(e.GetType())) {
                return (EC_CHECKED_MEMBER) e;
            } else {
                if (m is MethodInfo) {
                    return new EC_CHECKED_MEMBER_METHOD ((MethodInfo) m); 
                } else if (m is PropertyInfo) {
                    return new EC_CHECKED_MEMBER_PROPERTY ((PropertyInfo) m); 
                } else if (m is ConstructorInfo) {
                    return new EC_CHECKED_MEMBER_CONSTRUCTOR ((ConstructorInfo) m);
                } else if (m is EventInfo) {
                    return new EC_CHECKED_MEMBER_EVENT ((EventInfo) m); 
                } else if (m is FieldInfo) {
                    return new EC_CHECKED_MEMBER_FIELD ((FieldInfo) m);
                } else {
                    return null;
                }
            }
        }
    }

    class REFLECTION : EC_CHECKED_ENTITY_FACTORY
    {
        public bool is_consumed_type (Type t)
        // Is `t` a public CLS compliant type?
        {
            return checked_type(t).is_eiffel_compliant();
        }

        public bool is_eiffel_compliant_member (MemberInfo member)
            // Is `member` Eiffel compliant?
        {
            if (member is Type) {
                return is_consumed_type((Type) member);
            } else {
                EC_CHECKED_MEMBER? m = checked_member(member);
                if (m != null) {
                    return m.is_eiffel_compliant();
                } else {
                    return false;
                }
            }
        }        

        public bool is_consumed_method (MethodBase m)
        // Is `m` a public/family  CLS compliant method?
        {
            if (m.IsHideBySig) {
                return false;  //FIXME: added !IsHideBySig
            } else if (m.IsPublic || m.IsFamily || m.IsFamilyOrAssembly) {
                return is_eiffel_compliant_member (m);
            } else {
                return false;
            }
        }
        public bool is_consumed_field (FieldInfo f)
        // Is `f` a public/family  CLS compliant field?
        {
            if (f.IsPublic || f.IsFamily || f.IsFamilyOrAssembly) {
                bool res = is_eiffel_compliant_member (f);
                if (res && f.IsLiteral) {
                    res = is_valid_literal_field (f);
                }
                return res;
            } else {
                return false;
            }
        }   
        public bool is_public_field(FieldInfo f) 
        {
            return f.IsPublic && !f.IsLiteral;
        }
        public bool is_init_only_field(FieldInfo f)
        {
            return f.IsInitOnly;
        }        
        public bool is_valid_literal_field(FieldInfo f)
        {
            return field_value (f) != null;
        }
        public Object field_value (FieldInfo fi)
        // Value from field `fi`.
        {
            Object? res = fi.GetRawConstantValue();
            if (res == null) {
                Debug.Assert(false, "unexpected");
                res = 0;
            }
            return res;
        }
    }


}
