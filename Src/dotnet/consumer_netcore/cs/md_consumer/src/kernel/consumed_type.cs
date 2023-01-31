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
		public bool has_generic_type=false;
        public bool has_pointer_type=false;
        public bool is_forwarded_type=false;
        public bool is_excluded() {
            return has_generic_type || has_pointer_type;
        }        

        public CONSUMED_REFERENCED_TYPE(string n, int i)
        {
            name = n;
            has_generic_type = n.IndexOf('`') > 0 || n.IndexOf('[') > 0;// FIXME: support for generics?
            has_pointer_type = name.IndexOf('*') > 0 ;
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
        public new bool is_excluded() {
            return base.is_excluded() || element_type.is_excluded();
        }   
        public CONSUMED_ARRAY_TYPE(string n, int i, CONSUMED_REFERENCED_TYPE t) : base (n, i)
        {
            element_type = t;
        }
    }

    public class CONSUMED_TYPE
    {
        public string dotnet_name;
        public string eiffel_name;
        public int assembly_id=-1;
        public bool is_forwarded_type=false;
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

        public bool is_excluded() {
            return parent != null && parent.is_excluded();
            // FIXME: add more criteria!
        }        

        public CONSUMED_TYPE (string dn, string en,
			bool is_inter, bool is_abstract, bool is_sealed, bool is_value_type, bool is_enumerator,
            CONSUMED_REFERENCED_TYPE? par,
            List<CONSUMED_REFERENCED_TYPE> interf,
            int aid=-1
        )
        {
            assembly_id = aid;
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
            CONSUMED_REFERENCED_TYPE enc_type,
            int aid=-1
        ) : base(dn, en, is_inter, is_abstract, is_sealed, is_value_type, is_enumerator, par, interfaces, aid)
        {
            enclosing_type = enc_type;
        }
    }
    
}