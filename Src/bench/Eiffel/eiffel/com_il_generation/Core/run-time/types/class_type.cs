/*
indexing
	description: "Representation of an Eiffel type that is known in advance.
		Usually type of a non-generic Eiffel class or a generic class but
		with no generic information."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using EiffelSoftware.Runtime.CA;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
[CLSCompliantAttribute (false)]
public class CLASS_TYPE: TYPE {

/*
feature -- Access
*/
	public RuntimeTypeHandle type;
		// Current associated System.Type.

/*
feature -- Status Report
*/
	public override String class_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		String Result;
		Object [] l_ca;
		Type l_type;
		EIFFEL_NAME_ATTRIBUTE l_class_name;

		l_type = Type.GetTypeFromHandle (type);
		l_ca = l_type.GetCustomAttributes (typeof (EIFFEL_NAME_ATTRIBUTE), false);

		#if ASSERTIONS
			ASSERTIONS.CHECK ("`l_ca' should not be Void", l_ca != null);
		#endif

		if (l_ca.Length == 1) {
			l_class_name = (EIFFEL_NAME_ATTRIBUTE) l_ca [0];
			Result = l_class_name.name;
		} else {
			Result = l_type.Name;
		}

		return Result;
	}

	public override String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return class_name ();
	}

/*
feature -- Setting
*/
	public void set_type (RuntimeTypeHandle a_type)
		// Assign `a_type' to `type'.
	{
		type = a_type;
	}

} // class CLASS_TYPE

}
