using System;
using System.Text;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting;
using System.Linq;
using System.Diagnostics;

namespace md_consumer
{
    class EC_CHECKED_ASSEMBLY : EC_CACHABLE_CHECKED_ENTITY
    {
        public Assembly assembly;
        public EC_CHECKED_ASSEMBLY(Assembly a)
        {
            assembly = a;
            init_reasons();
        }
    	protected override void check_extended_compliance()
			// -- Checks entity's CLS-compliance.
        {            
        }

	    protected override void check_eiffel_compliance()
			// -- Checks entity to see if it is Eiffel-compliant.
		{
            internal_is_eiffel_compliant = true;
        }

        public override ICustomAttributeProvider custom_attribute_provider() {
            return assembly;
		}
    }
          
 
}
