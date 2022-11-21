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
    abstract class EC_CHECKED_ENTITY : EC_CHECKED_CACHE
    {
        public string non_compliant_reason = "";
        public string non_eiffel_compliant_reason = "";
        protected bool has_been_checked = false;
        protected bool internal_is_compliant = false;
        protected bool internal_is_eiffel_compliant = false;
        protected bool internal_is_marked = false;
        protected bool is_being_checked = false;
        bool skip_eiffel_checks = false;

        private static EC_CHECKED_ENTITY_FACTORY? internal_entity_factory;

        public EC_CHECKED_ENTITY_FACTORY entity_factory()
        {
            EC_CHECKED_ENTITY_FACTORY? f = internal_entity_factory;
            if (f == null) {
                f = new EC_CHECKED_ENTITY_FACTORY();
                internal_entity_factory = f;
            }
            return f;
        }

        public EC_CHECKED_MEMBER? checked_member (MemberInfo m)
        {
            return entity_factory().checked_member(m);
        }
        public EC_CHECKED_TYPE checked_type (Type t)
        {
            return entity_factory().checked_type(t);
        }        

        public void init_reasons()
        {
            non_compliant_reason = "";
            non_eiffel_compliant_reason = "";
        }



        // [Synchronization()]
        public bool is_compliant()
        {
            Debug.Assert(has_been_checked || ! is_being_checked);

            if (! has_been_checked) {
                check_compliance();
            }
            return internal_is_compliant;
        }

        // [SynchronizationAttribute]
        public bool is_eiffel_compliant()
        {
            Debug.Assert(has_been_checked || ! is_being_checked);
            if (! has_been_checked) {
                check_compliance();
            }
            return internal_is_eiffel_compliant;
        }  

        // [SynchronizationAttribute]
        public bool is_marked()
        {
            Debug.Assert(has_been_checked || ! is_being_checked);
            if (! has_been_checked) {
                check_compliance();
            }
            return internal_is_marked;
        }  

        // [SynchronizationAttribute]
        protected void check_compliance()
        {
            Debug.Assert(! has_been_checked && ! is_being_checked);
            is_being_checked = true;
            ICustomAttributeProvider provider = custom_attribute_provider();
            examine_attributes (provider);
            check_extended_compliance();        
            if (! skip_eiffel_checks) {
                check_eiffel_compliance();
            }

            // internal_is_compliant = true;
            // internal_is_eiffel_compliant = true;
            // internal_is_marked = true;

            has_been_checked = true;
            is_being_checked = false;
        }
        protected void examine_attributes (ICustomAttributeProvider provider)
        {
            // CLSCompliantAttribute c = new CLSCompliantAttribute(true);
            // Object[] l_attributes = EiffelSoftware.Runtime.RT_CUSTOM_ATTRIBUTE_DATA.get_eiffel_custom_attributes(c.GetType(), provider);
            Object[] l_attributes = EiffelSoftware.Runtime.RT_CUSTOM_ATTRIBUTE_DATA.get_eiffel_custom_attributes(typeof(CLSCompliantAttribute), provider);
            bool l_compliant=true;
            Type ot = typeof(CLSCompliantAttribute); // (new CLSCompliantAttribute(true)).GetType(); //fake instance to get type
            foreach (Object obj in l_attributes)
            {
                if (ot.IsAssignableFrom (obj.GetType())) {
                    CLSCompliantAttribute? att = (CLSCompliantAttribute) obj;
                    if (att != null) {
                        l_compliant = att.IsCompliant;
                        internal_is_marked = true;
                        break;
                    }
                }           
            }
            internal_is_compliant = l_compliant;

            l_attributes = EiffelSoftware.Runtime.RT_CUSTOM_ATTRIBUTE_DATA.get_eiffel_custom_attributes(typeof(EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE), provider);
            ot = typeof(EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE);//(new EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE(true)).GetType(); //fake instance to get type

            foreach (Object obj in l_attributes)
            {
                if (ot.IsAssignableFrom (obj.GetType())) {
                    EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE? att = (EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE) obj;
                    if (att != null) {
                        l_compliant = att.consumable;
                        skip_eiffel_checks = true;
                        internal_is_eiffel_compliant = l_compliant;
                        if (!l_compliant) {
                            non_compliant_reason = EC_CHECKED_REASON_CONSTANTS.reason_entity_marked_non_eiffel_compliant;
                        }
                        break;
                    }
                }           
            }

        } 
        protected abstract void check_extended_compliance();
        protected abstract void check_eiffel_compliance();   
        public abstract ICustomAttributeProvider custom_attribute_provider();

        protected bool is_cls_member_name(MemberInfo m)
        {
            string? m_name = m.Name;
            if (m_name != null) {
                char[] l_name = m_name.ToCharArray();
                char ch=' ';
                int n = l_name.Length;
                if (n > 0) {
                    ch = l_name[0];
                    bool res = Char.IsLetter(ch);
                    if (res) {
                        for (int i = 1; i > n; i++) {
                            ch = l_name[i];
                            res = Char.IsLetterOrDigit(ch) || ch == '_';
                            if (!res) { break; }
                        }
                    }
                    return res;
                }
            }
        return false;
        }
    }
    abstract class EC_CACHABLE_CHECKED_ENTITY : EC_CHECKED_ENTITY
    {
        // override 
        public bool cache_checked_entity()
        {
            //FIXME

            return true;
        }
    }

    
}
