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

    class EC_CHECKED_TYPE : EC_CACHABLE_CHECKED_ENTITY
    {
        public Type type;

        public EC_CHECKED_TYPE? element_checked_type;

        public EC_CHECKED_TYPE(Type t)
        {
            type = t;
            init_reasons();
            if (t.HasElementType) {
                Type? et = t.GetElementType();
                if (et != null) {
                    EC_CHECKED_ENTITY? e = cached_checked_entity(et);
                    if (e != null && typeof(EC_CHECKED_TYPE).IsAssignableFrom(e.GetType())) {
                        element_checked_type = (EC_CHECKED_TYPE) e;
                    } else {
                        element_checked_type = new EC_CHECKED_TYPE(et);
                    }
                } else {
                    Debug.Assert(false, "From doc element type is set");
                }
            }
        }

        public bool has_element_checked_type() {
            return element_checked_type != null;
        }

        protected override void check_extended_compliance()
        {
            Type t = type;
            if (t.IsPointer) {
                internal_is_marked = true;
                internal_is_compliant = false;
                non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_marked_non_cls_compliant;
            } else {
                EC_CHECKED_TYPE? l_element = element_checked_type;
                if (l_element != null) {
                    internal_is_marked = l_element.is_marked();
                    if (l_element.is_compliant()) {
                        internal_is_compliant = true;
                    } else {
                        internal_is_compliant = false;
                        non_compliant_reason = l_element.non_compliant_reason;

                    }
                } else if (! internal_is_marked) {
                    // -- type was not marked with CLS-compliant attribute, but it might be marked on an
					// -- assembly level.
                    if (t.IsVisible) {
                        Assembly l_asm = t.Assembly;
                        EC_CHECKED_ASSEMBLY l_checked_asm = entity_factory().checked_assembly(l_asm);
                        internal_is_marked = l_checked_asm.is_marked();
                        if (l_checked_asm.is_compliant()) {
                            internal_is_compliant = true;
                        } else {
                            internal_is_compliant = false;
                            non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_assembly_marked_non_cls_compliant;
                        }
                    } else {
                        non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_is_not_visible;
                    }
                    
                } else if (! internal_is_compliant) {
                    non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_marked_non_cls_compliant;
                }
            }

        }
        protected override void check_eiffel_compliance()
        {
            try{
                Type t = type;
                if (t.IsVisible) {
                    Assembly l_asm = t.Assembly;
                    EC_CHECKED_ASSEMBLY l_checked_asm = entity_factory().checked_assembly(l_asm);
                    internal_is_marked = l_checked_asm.is_marked();                        
                    bool l_compliant = l_checked_asm.is_eiffel_compliant();
                    if (l_compliant) {
                        string? fn = t.FullName;
                        l_compliant = (fn != null) && (fn.IndexOf('`') < 0);
                        if (l_compliant) {
                            l_compliant = ! t.IsPointer;
                            if (l_compliant) {
                                EC_CHECKED_TYPE? l_element_type = element_checked_type;
                                if (l_element_type != null) {
                                    l_compliant = l_element_type.is_eiffel_compliant();
                                    if (!l_compliant) {
                                        non_eiffel_compliant_reason = l_element_type.non_eiffel_compliant_reason;
                                    }
                                } 
                            } else {
                                non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_marked_non_eiffel_consumable;
                            }
                        } else {
                            non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_is_generic; // FIXME generics
                        }
                    } else {
                        non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_assembly_marked_non_eiffel_consumable;
                    }
                    internal_is_eiffel_compliant = l_compliant;
                } else {
                    internal_is_eiffel_compliant = false;
                    non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_is_not_visible;
                }
            } catch {
                internal_is_eiffel_compliant = false;
                non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_crash;
            }
        }

        public override ICustomAttributeProvider custom_attribute_provider() {
            return type;
        }
    }

    class EC_CHECKED_ABSTRACT_TYPE : EC_CHECKED_TYPE
    {
        public string non_compliant_interface_reason;
        public string non_eiffel_compliant_interface_reason;
        public bool has_interface_been_checked = false;
        protected bool internal_is_compliant_interface = false;
        protected bool internal_is_eiffel_compliant_interface = false;
        public EC_CHECKED_ABSTRACT_TYPE(Type t) : base (t)
        {
            non_compliant_interface_reason = "";
            non_eiffel_compliant_interface_reason = "";
        }
        public bool is_compliant_interface()
        {
            if (! has_been_checked) {
                check_compliance();
            }
            if (! has_interface_been_checked) {
                check_interface_compliance();
            }
            return internal_is_compliant_interface;
        }
        public bool is_eiffel_compliant_interface()
        {
            if (! has_been_checked) {
                check_compliance();
            }
            if (! has_interface_been_checked) {
                check_interface_compliance();
            }
            return internal_is_eiffel_compliant_interface;
        }

        void check_interface_compliance()
        {
            is_being_checked = true;
            check_extended_interface_compliance();
            has_interface_been_checked = true;
            is_being_checked = false;
        }
        void check_extended_interface_compliance()
        {
            MemberInfo[] l_members;
            bool l_compliant = true;
            bool l_eiffel_compliant = true;
            l_members = type.GetMembers();
            foreach (MemberInfo l_member in l_members) 
            {
                if (!l_compliant && !l_eiffel_compliant) {
                    break;
                }
                if (is_applicable_member(l_member)) {
                    EC_CHECKED_MEMBER? l_checked_member = checked_member (l_member);
                    if (l_checked_member != null) {
                        if (l_compliant) {
                            l_compliant = l_checked_member.is_compliant();
                            if (!l_compliant) {
                                l_compliant = l_checked_member.is_marked();
                            }
                        }
                        if (l_eiffel_compliant) {
                            l_eiffel_compliant = l_checked_member.is_eiffel_compliant();
                        }
                    }
                }
            }
            internal_is_compliant_interface = l_compliant;
            internal_is_eiffel_compliant_interface = l_eiffel_compliant;
            if (!l_compliant) {
                non_compliant_interface_reason = EC_CHECKED_REASON_CONSTANTS.reason_interface_contains_non_cls_compliant_members;
            }
            if (!l_eiffel_compliant) {
                non_eiffel_compliant_interface_reason = EC_CHECKED_REASON_CONSTANTS.reason_interface_contains_non_eiffel_compliant_members;
            }

        }
        bool is_applicable_member(MemberInfo m)
        {
            if (m is MethodInfo) {
                MethodInfo mi = (MethodInfo) m;
                if (!mi.IsConstructor) {
                    return mi.IsAbstract && (mi.IsPublic || mi.IsFamily || mi.IsFamilyOrAssembly);
                }
            }
            return false;
        }
    }

    class EC_STATIC_CHECKED_TYPE : EC_CHECKED_TYPE
    {
        public EC_STATIC_CHECKED_TYPE(Type t, bool is_compliant, bool is_eiffel_compliant) : base (t)
        {
            has_been_checked = true;
            internal_is_marked = true;
            internal_is_compliant = is_compliant;
            if (! is_compliant) {
                 non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_marked_non_cls_compliant;
            }
            internal_is_eiffel_compliant = is_eiffel_compliant;
            if (! is_compliant) {
                 non_eiffel_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_type_marked_non_cls_compliant;
            }
        }
    }
}
