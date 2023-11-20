using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text.Json;

namespace md_consumer
{
    public class CONSUMED_MEMBER : CONSUMED_ENTITY
    {
        protected int flags = 0;
        public CONSUMED_MEMBER(string en, string dn, bool pub, CONSUMED_REFERENCED_TYPE a_type) : base (en, dn, pub, a_type)
        {
        }
        public virtual bool has_generic_type() 
        {
            return false;
        }
        public override bool is_public()
        {
            return (flags & FEATURE_ATTRIBUTE.is_public) == FEATURE_ATTRIBUTE.is_public;
        }
        public bool is_frozen()
        {
            return (flags & FEATURE_ATTRIBUTE.is_frozen) == FEATURE_ATTRIBUTE.is_frozen;
        }
        public bool is_static()
        {
            return (flags & FEATURE_ATTRIBUTE.is_static) == FEATURE_ATTRIBUTE.is_static;
        }    
        public bool is_deferred()
        {
            return (flags & FEATURE_ATTRIBUTE.is_deferred) == FEATURE_ATTRIBUTE.is_deferred;
        } 
        public bool is_artificially_added()
        {
            return (flags & FEATURE_ATTRIBUTE.is_artificially_added) == FEATURE_ATTRIBUTE.is_artificially_added;
        } 
        public bool is_property_or_event()
        {
            return (flags & FEATURE_ATTRIBUTE.is_property_or_event) == FEATURE_ATTRIBUTE.is_property_or_event;
        }   
        public bool is_new_slot()
        {
            return (flags & FEATURE_ATTRIBUTE.is_newslot) == FEATURE_ATTRIBUTE.is_newslot;
        }  
        public virtual bool is_virtual()
        {
            return (flags & FEATURE_ATTRIBUTE.is_virtual) == FEATURE_ATTRIBUTE.is_virtual;
        }
        public bool is_attribute_setter()
        {
            return (flags & FEATURE_ATTRIBUTE.is_attribute_setter) == FEATURE_ATTRIBUTE.is_attribute_setter;
        }

	    public override void set_is_public (bool pub)
        {
            if (pub) {
                flags = flags | FEATURE_ATTRIBUTE.is_public;
            } else {
                flags = flags & ~FEATURE_ATTRIBUTE.is_public;
            }
        }
	    public void set_is_artificially_added (bool val)
        {
            if (val) {
                flags = flags | FEATURE_ATTRIBUTE.is_artificially_added;
            } else {
                flags = flags & ~FEATURE_ATTRIBUTE.is_artificially_added;
            }
        }  
    }
    public class CONSUMED_PROCEDURE: CONSUMED_MEMBER
    {
        public CONSUMED_ARGUMENT[] arguments;

        public bool is_generic_method = false;
        public string[]? generic_parameters = null;
        public CONSUMED_PROCEDURE(string en, string dn, string den, CONSUMED_ARGUMENT[] args, bool froz, bool a_static, bool defer, bool pub, bool ns, bool virt, bool poe, CONSUMED_REFERENCED_TYPE a_type) : base (en, dn, pub, a_type)
        {
            if (!den.Equals(en)) {
                dotnet_eiffel_name = den;
            } else {
                dotnet_eiffel_name = en;
            }
            arguments = args;
            if (froz || !virt) {
                flags = flags | FEATURE_ATTRIBUTE.is_frozen;
            }
            if (a_static) {
                flags = flags | FEATURE_ATTRIBUTE.is_static;
            }
            if (defer) {
                flags = flags | FEATURE_ATTRIBUTE.is_deferred;
            }
            if (ns) {
                flags = flags | FEATURE_ATTRIBUTE.is_newslot;
            }
            if (virt) {
                flags = flags | FEATURE_ATTRIBUTE.is_virtual;
            }
            if (poe) {
                flags = flags | FEATURE_ATTRIBUTE.is_property_or_event;
            }
        }
 
        public CONSUMED_PROCEDURE(string en, string dn, CONSUMED_ARGUMENT arg, CONSUMED_REFERENCED_TYPE a_type, bool a_static) : base (en, dn, true, a_type)
        {
            dotnet_eiffel_name = en;
            arguments = new CONSUMED_ARGUMENT[]{arg};
            flags = flags | FEATURE_ATTRIBUTE.is_frozen;
            if (a_static) {
                flags = flags | FEATURE_ATTRIBUTE.is_static;
            }
            flags = flags | FEATURE_ATTRIBUTE.is_attribute_setter;
        } 

        public void set_is_generic_method(bool v, string[]? a_generic_parameters)
        {
            is_generic_method = v;
            generic_parameters = a_generic_parameters;
        }

        public override bool is_excluded() 
        {
            if (base.is_excluded()) {
                return true;
            } else {
                if (arguments != null) {
                    foreach (var a in arguments) {
                        if (a.is_excluded()) {
                            return true;
                        }
                    }
                }
            }
            return false;
        }
        public bool has_generic_type_arguments() 
        {
            if (arguments != null) {
                foreach (var a in arguments) {
                    if (a.has_generic_type()) {
                        return true;
                    }
                }
            }
            return false;
        }         
        
        public override bool has_generic_type() 
        {
            if (arguments != null) {
                foreach (var a in arguments) {
                    if (a.has_generic_type()) {
                        return true;
                    }
                }
            } else {
                return base.has_generic_type();
            }
            return false;
        }        
        public bool same_procedure (CONSUMED_PROCEDURE obj)
        {
            if (dotnet_name.Equals (obj.dotnet_name)) 
            {
                if (
				    eiffel_name.Equals (obj.eiffel_name)
				    && dotnet_eiffel_name.Equals (obj.dotnet_eiffel_name)
				    && flags == obj.flags
                    && declared_type.same_as (obj.declared_type)
                    && arguments.Length == obj.arguments.Length
                )
                {
                    int n = arguments.Length;
                    bool b=true;
                    for (var i=0; i < n && b; i++) {
                        if (! arguments[i].same_as(obj.arguments[i])) {
                            b=false;
                        };
                    }
                    return b;
                }
            }
            return false;            
        }

        //FIXME ...
    }

    public class CONSUMED_FUNCTION : CONSUMED_PROCEDURE
    {
        public CONSUMED_REFERENCED_TYPE return_type;

        public CONSUMED_FUNCTION(string en, string dn, string den, CONSUMED_ARGUMENT[] args, CONSUMED_REFERENCED_TYPE ret, 
            bool froz, bool a_static, bool defer, bool inf, bool pref, bool pub, bool ns, bool virt, bool poe, CONSUMED_REFERENCED_TYPE a_type) : base (en, dn, den, args,froz,a_static,defer,pub,ns,virt,poe, a_type)
        {
            return_type = ret;

            if (inf) {
                flags = flags | FEATURE_ATTRIBUTE.is_infix;
            }
            if (pref) {
                flags = flags | FEATURE_ATTRIBUTE.is_prefix;
            }
        }

        public bool same_function (CONSUMED_FUNCTION obj)
        {
            return same_procedure (obj) && return_type.same_as (obj.return_type);
        }
        public override bool is_excluded()
        {
            return return_type.is_excluded() || base.is_excluded();
        }
        public override bool has_generic_type() 
        {
            return return_type.has_generic_type || base.has_generic_type();
        }
        public bool is_infix()
        {
            return (flags & FEATURE_ATTRIBUTE.is_infix) == FEATURE_ATTRIBUTE.is_infix;
        }
        public bool is_prefix()
        {
            return (flags & FEATURE_ATTRIBUTE.is_prefix) == FEATURE_ATTRIBUTE.is_prefix;
        }

        public void update_dotnet_eiffel_name_for_getter()
        {
            if (dotnet_eiffel_name.StartsWith("get_")) {
                dotnet_eiffel_name = dotnet_eiffel_name.Substring(4);
            }
        }

        //FIXME ...
    }    


    public class CONSUMED_FIELD: CONSUMED_MEMBER
    {
        // public string dotnet_name;
        // public string eiffel_name;

        public CONSUMED_REFERENCED_TYPE return_type;
        public CONSUMED_PROCEDURE? setter;

        public bool is_attribute = true;
        public bool has_return_value = true;
        public bool is_init_only()
        {
            return (flags & FEATURE_ATTRIBUTE.is_init_only) == FEATURE_ATTRIBUTE.is_init_only;
        }
        public override bool is_virtual()
        {
            return !is_static();
        }
        public CONSUMED_FIELD(string en, string dn, CONSUMED_REFERENCED_TYPE rt, bool a_static, bool pub, bool init_only, CONSUMED_REFERENCED_TYPE a_type) : base (en, dn, pub, a_type)
        {
            if (a_static) {
                flags = flags | FEATURE_ATTRIBUTE.is_static;
            }
            if (init_only) {
                flags = flags | FEATURE_ATTRIBUTE.is_init_only;
            }
            return_type = rt;
        }
        public override bool is_excluded() {
            return base.is_excluded() || (has_return_value && return_type.is_excluded());
        }

        public override bool has_generic_type() 
        {
            return has_return_value && return_type.has_generic_type;
        }

        public void set_setter(CONSUMED_PROCEDURE? a_setter)
        {
            setter = a_setter;
        }

    }

    public class CONSUMED_LITERAL_FIELD : CONSUMED_FIELD
    {
        public string value;
        public bool is_literal = true;
        public CONSUMED_LITERAL_FIELD(string en, string dn, CONSUMED_REFERENCED_TYPE rt, bool a_static, bool pub, string val, CONSUMED_REFERENCED_TYPE a_type) : base (en, dn, rt, a_static, pub, true, a_type)
        {
            value = val;
        }        
    }

}
