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
    class EC_CHECKED_MEMBER : EC_CHECKED_ENTITY
    {
        public MemberInfo member;
        public EC_CHECKED_MEMBER(MemberInfo m)
        {
            member = m;
            init_reasons();
        }
    	protected override void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {            
            EC_CHECKED_TYPE? l_checked_type;
            if (internal_is_compliant && !internal_is_marked) {
                // -- No CLS-compliant attribute was set on member so we need to check parent
                // -- container type.
                Type? l_type;
                l_type = member.DeclaringType;
                if (l_type != null) {
                    l_checked_type = entity_factory().checked_type (l_type);
                    internal_is_compliant = l_checked_type.is_compliant();
                    internal_is_marked = l_checked_type.is_marked();
                    non_compliant_reason = l_checked_type.non_compliant_reason;
                } else {
                    Debug.Assert(false, "from_documentation_declaring_type_attached");
                }
            } else if (!internal_is_compliant) {
                non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_member_marked_non_cls_compliant;
            }
        }

	    protected override void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
		{
			EC_CHECKED_TYPE? l_checked_type;
			string? l_member_name;
			bool l_compliant;
		    l_member_name = member.Name;
			l_compliant = l_member_name != null && (l_member_name.IndexOf('`') < 0);
			if (l_compliant) {
                Type? l_type = member.DeclaringType;
                if (l_type != null) {
					l_checked_type = checked_type (l_type);
					l_compliant = l_checked_type.is_eiffel_compliant();
					if (!l_compliant) {
						if (l_checked_type.non_eiffel_compliant_reason.Equals (EC_CHECKED_REASON_CONSTANTS.reason_type_is_generic)) {
							non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_member_is_generic;
						} else {
							non_eiffel_compliant_reason = l_checked_type.non_eiffel_compliant_reason;
						}
					}
					internal_is_eiffel_compliant = l_compliant;
                } else {
					Debug.Assert(false, "from_documentation__declaring_type_attached");
				}
			} else {
				internal_is_eiffel_compliant = false;
				non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_member_is_generic;
			}
        }

        public override ICustomAttributeProvider custom_attribute_provider() {
            return member;
		}
    }

    class EC_CHECKED_MEMBER_METHOD_BASE : EC_CHECKED_MEMBER
    {
        public MethodBase method;
        public EC_CHECKED_MEMBER_METHOD_BASE (MemberInfo m) : base(m)
        {
            method = (MethodBase) m;
        }
    	protected new void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {        
            MethodBase l_member = method;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_extended_compliance();
                if (internal_is_compliant && !internal_is_marked) {
                    bool l_compliant = l_member.CallingConvention != CallingConventions.VarArgs;
                    if (!l_compliant) {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_method_uses_var_args;
                    }
                    internal_is_compliant = l_compliant;
                }
            } else {
                internal_is_compliant = true;
                internal_is_marked = true;
            }
        }

	    protected new void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
        {        
            MethodBase l_member = method;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_eiffel_compliance();
                if (internal_is_eiffel_compliant) {
                    bool l_compliant = l_member.CallingConvention != CallingConventions.VarArgs;
                    if (!l_compliant) {
                        non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_method_uses_var_args;
                    }
                    internal_is_eiffel_compliant = l_compliant;
                }
            }
        }
        protected EC_CHECKED_TYPE[] checked_parameter_types()
        {
            ParameterInfo[] l_parameters = method.GetParameters();
            List<EC_CHECKED_TYPE> res = new List<EC_CHECKED_TYPE>();
            foreach (ParameterInfo l_info in l_parameters)
            {
                Type? l_param_type = l_info.ParameterType;
                if (l_param_type != null) {
                    EC_CHECKED_TYPE t = entity_factory().checked_type (l_param_type);
                    res.Add(t);
                }
            }
            return res.ToArray();
        }

        protected bool are_parameters_compliant (bool a_check_eiffel)
        {
            EC_CHECKED_TYPE[] l_params = checked_parameter_types();
            bool res = true;
            foreach (EC_CHECKED_TYPE t in l_params.Reverse())
            {
                if (a_check_eiffel) {
                    res = t.is_eiffel_compliant();
                } else {
                    res = t.is_compliant();
                }
                if (res) { break; }
            }
            return res;
        }
    }
    class EC_CHECKED_MEMBER_METHOD : EC_CHECKED_MEMBER_METHOD_BASE
    {
        public new MethodInfo method;
        public EC_CHECKED_MEMBER_METHOD (MemberInfo m) : base(m)
        {
            method = (MethodInfo) m;
        }
        public EC_CHECKED_TYPE checked_return_type()
        {
            Type t = method.ReturnType;
            return checked_type (t);
        }
    	protected new void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {        
            MethodInfo l_member = method;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_extended_compliance();
                if (internal_is_compliant && !internal_is_marked) {
                    bool l_compliant = is_cls_member_name(l_member);
                    if (l_compliant) {
                        l_compliant =  are_parameters_compliant (false);
                        if (l_compliant) {
                            l_compliant = checked_return_type().is_compliant();
                            if (!l_compliant) {
                                non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_method_returns_non_compliant_type;
                            }
                        } else {
                            non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_parameters_uses_non_compliant_types;
                        }
                    } else {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_method_name_is_non_compliant;
                    }
                    internal_is_compliant = l_compliant;
                }
            } else {
                internal_is_compliant = true;
                internal_is_marked = true;
            }    
        }

	    protected new void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
		{
            MethodInfo l_member = method;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_eiffel_compliance();
                if (internal_is_eiffel_compliant) {
                    bool l_compliant = are_parameters_compliant(true);
                    if (l_compliant) {
                        l_compliant = checked_return_type().is_eiffel_compliant();
                        if (!l_compliant) {
                            non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_method_returns_non_compliant_type;
                        }
                    } else {
                        non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_parameters_uses_non_compliant_types;

                    }
                    internal_is_eiffel_compliant = l_compliant;
                }
            }

        }
    }

    class EC_CHECKED_MEMBER_CONSTRUCTOR : EC_CHECKED_MEMBER_METHOD_BASE
    {
        public ConstructorInfo constructor;
        public EC_CHECKED_MEMBER_CONSTRUCTOR (MemberInfo m) : base(m)
        {
            constructor = (ConstructorInfo) m;
        }
    	protected new void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {
            ConstructorInfo l_member = constructor;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_extended_compliance();
                if (internal_is_compliant && ! internal_is_marked) {
                    bool l_compliant = are_parameters_compliant (false);
                    if (!l_compliant) {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_parameters_uses_non_compliant_types;
                    }
                    internal_is_compliant = l_compliant;
                }
            } else {
                internal_is_compliant = true;
                internal_is_marked = true;
            }
        }

	    protected new void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
        {
            ConstructorInfo l_member = constructor;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_extended_compliance();
                if (internal_is_eiffel_compliant) {
                    bool l_compliant = are_parameters_compliant (true);
                    if (!l_compliant) {
                        non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_parameters_uses_non_compliant_types;
                    }
                    internal_is_eiffel_compliant = l_compliant;
                }
            }
        }
    }   

  class EC_CHECKED_MEMBER_EVENT : EC_CHECKED_MEMBER
    {
        private const bool V = false;
        public EventInfo member_event;
        public EC_CHECKED_MEMBER_EVENT (MemberInfo m) : base(m)
        {
            member_event = (EventInfo) m;
        }

        EC_CHECKED_TYPE? checked_event_type()
        {
            Type? t = member_event.EventHandlerType;
            if (t != null) {
                return entity_factory().checked_type (t);
            } else {
                Debug.Assert(false, "from doc event handler type is attached");
                return null;
            }
        }

    	protected new void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {    
            EventInfo l_member = member_event;
            base.check_extended_compliance();
            if (internal_is_compliant && ! internal_is_marked) {
                bool l_compliant = is_cls_member_name (l_member);
                if (l_compliant) {
                    EC_CHECKED_TYPE? cet = checked_event_type();
                    l_compliant = (cet != null) && cet.is_compliant();
                    if (!l_compliant) {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_field_uses_non_compliant_type;
                    }
                } else {
                    non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_event_name_is_non_compliant;
                }
                internal_is_compliant = l_compliant;
            }        
        }

	    protected new void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
		{
            base.check_eiffel_compliance();
            if (internal_is_eiffel_compliant) {
                    EventInfo l_member = member_event;
                    if (! internal_is_compliant) {
                        bool l_compliant= false;
                        EC_CHECKED_TYPE? cet = checked_event_type();
                        l_compliant = (cet != null) && cet.is_eiffel_compliant();
                        if (l_compliant) {
                            internal_is_eiffel_compliant = true;
                        } else {
                            // internal_is_eiffel_compliant = V; // FIXME: ?
                            non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_field_uses_non_compliant_type;
                        }
                    }
            }
        }
    }     

  class EC_CHECKED_MEMBER_PROPERTY : EC_CHECKED_MEMBER
    {
        public PropertyInfo property;
        public EC_CHECKED_MEMBER_PROPERTY (MemberInfo m) : base(m)
        {
            property = (PropertyInfo) m;
        }

        EC_CHECKED_TYPE checked_property_type()
        {
            Type t = property.PropertyType;
            return entity_factory().checked_type (t);
        }
    	protected new void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {      
            base.check_extended_compliance();
            if (internal_is_compliant && ! internal_is_marked) {
                PropertyInfo l_member = property;
                bool l_compliant = is_cls_member_name (l_member);
                if (l_compliant) {
                    l_compliant = checked_property_type().is_compliant();
                    if (!l_compliant) {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_property_uses_non_compliant_type;
                    }
                } else {
                    non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_property_name_is_non_compliant;
                }
                internal_is_compliant = l_compliant;
            }    
        }

	    protected new void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
        {      
            base.check_eiffel_compliance();
            if (internal_is_eiffel_compliant) {
                if (! internal_is_eiffel_compliant) {
                    PropertyInfo l_member = property;
                    bool l_compliant = checked_property_type().is_eiffel_compliant();
                    if (!l_compliant) {
                        non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_property_uses_non_compliant_type;
                    }
                    internal_is_eiffel_compliant = l_compliant;
                }
            }    
        }
    }

  class EC_CHECKED_MEMBER_FIELD : EC_CHECKED_MEMBER
    {
        public FieldInfo field;
        public EC_CHECKED_MEMBER_FIELD (MemberInfo m) : base(m)
        {
            field = (FieldInfo) m;
        }
        EC_CHECKED_TYPE checked_field_type()
        {
            Type t = field.FieldType;
            return entity_factory().checked_type (t);
        }
    	protected new void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {  
            FieldInfo l_member = field;
            if (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly) {
                base.check_extended_compliance();
                if (internal_is_compliant && ! internal_is_marked) {
                    bool l_compliant = is_cls_member_name(l_member);
                    if (l_compliant) {
                        l_compliant = checked_field_type().is_compliant();
                        if (!l_compliant) {
                            non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_field_uses_non_compliant_type;
                        }
                    } else {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_field_name_is_non_compliant;
                    }
                    internal_is_compliant = l_compliant;
                }
            } else {
                internal_is_compliant = true;
                internal_is_marked = true;
            }      
        }

	    protected new void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
		{
            base.check_eiffel_compliance();
            if (internal_is_eiffel_compliant) {
                FieldInfo l_member = field;
                if (! internal_is_compliant && (l_member.IsPublic || l_member.IsFamily || l_member.IsFamilyOrAssembly )) {
                    EC_CHECKED_TYPE cft = checked_field_type();
                    bool l_compliant = cft.is_eiffel_compliant();
                    if (l_compliant) {
                        internal_is_eiffel_compliant = true;
                    } else {
                        non_eiffel_compliant_reason = cft.non_eiffel_compliant_reason;
                    }
                }
            }

        }
    }            
 
}
