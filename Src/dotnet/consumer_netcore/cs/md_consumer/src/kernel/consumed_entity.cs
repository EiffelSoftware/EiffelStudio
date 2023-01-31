using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    static public class FEATURE_ATTRIBUTE
    {
        // Possible attributes of a feature
        static public int is_frozen = 1;
        static public int is_static = 2;
        static public int is_deferred = 4;
        static public int is_infix = 8;
        static public int is_prefix = 16;
        static public int is_public = 32;
        static public int is_artificially_added = 64;
        static public int is_property_or_event = 128;
        static public int is_init_only = 256;
        static public int is_newslot = 512;
        static public int is_virtual = 1024;
        static public int is_attribute_setter = 2048;
    }
    abstract public class CONSUMED_ENTITY : IComparable<CONSUMED_ENTITY>
    {
        public string dotnet_name;
        public string eiffel_name;
        public string dotnet_eiffel_name;

        public CONSUMED_REFERENCED_TYPE declared_type;
        public bool _is_public ;
        public bool is_excluded() {
            // Is current entity excluded from consumer result?
            // FIXME: for now, any generic related entity is excluded
            return declared_type.is_excluded();
        }

        public bool is_public()
        {
            return _is_public;
        }
        public CONSUMED_ENTITY(string en, string dn, bool pub, CONSUMED_REFERENCED_TYPE a_type)
        {
            eiffel_name = en;
            dotnet_name = dn;
            dotnet_eiffel_name = en;
            declared_type = a_type;
            set_is_public (pub);
        }

        public void set_is_public(bool b)
        {
            _is_public = b;
        }
        public bool is_less (CONSUMED_ENTITY other)
        {
            return eiffel_name.CompareTo(other.eiffel_name) < 0;
        }

        public int CompareTo (CONSUMED_ENTITY? other)
        {
            if (other == null) {
                return 1;
            } else {
                return eiffel_name.CompareTo(other.eiffel_name);
            }
        }
    }

    public class CONSUMED_PROPERTY : CONSUMED_ENTITY
    {
        protected int flags = 0;
        public bool is_static;
        public CONSUMED_FUNCTION? getter;
        public CONSUMED_PROCEDURE? setter;

        public CONSUMED_PROPERTY(string dn, bool pub, bool a_static, CONSUMED_REFERENCED_TYPE a_decl_type, CONSUMED_FUNCTION? cp_getter, CONSUMED_PROCEDURE? cp_setter) : base (dn, dn, pub, a_decl_type)
        {
            set_is_public (pub);
            is_static = a_static;
            if (cp_getter != null) {
                cp_getter.update_dotnet_eiffel_name_for_getter();
            }
            getter = cp_getter;
            setter = cp_setter;
        }
    }

    public class CONSUMED_EVENT : CONSUMED_ENTITY
    {
        protected int flags = 0;
        public bool is_event = true;
        public bool is_property_or_event = true;
        public CONSUMED_PROCEDURE? raiser;
        public CONSUMED_PROCEDURE? adder;
        public CONSUMED_PROCEDURE? remover;

        public CONSUMED_EVENT(string dn, bool pub, CONSUMED_REFERENCED_TYPE a_decl_type, CONSUMED_PROCEDURE? cp_raiser, CONSUMED_PROCEDURE? cp_adder, CONSUMED_PROCEDURE? cp_remover) : base (dn, dn, pub, a_decl_type)
        {
            set_is_public (pub);      
            raiser = cp_raiser;
            adder = cp_adder;
            remover = cp_remover;
        }
    }    

}