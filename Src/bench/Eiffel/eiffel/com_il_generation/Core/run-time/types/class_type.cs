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
public class RT_CLASS_TYPE: RT_TYPE {

/*
feature -- Access
*/
	public RuntimeTypeHandle type;
		// Current associated System.Type.

	public Type dotnet_type ()
		// Associated .NET type of `type'.
	{
		return Type.GetTypeFromHandle (type);
	}

/*
feature -- Status Report
*/
	public override int GetHashCode()
		// Associated hash_code
	{
		return (int) type.Value;
	}

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
			if (l_type.IsArray) {
					// This is not the perfect solution as it could be an instance
					// of System.Array and not a vector array. But that will do for now.
				Result = "NATIVE_ARRAY";
			} else {
				Result = l_type.Name;
			}
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
feature -- Comparison
*/

	public override bool Equals (object other)
		// Is Current equal to `other'?
	{
		RT_CLASS_TYPE l_other = other as RT_CLASS_TYPE;

		return (l_other != null && (type.Value == l_other.type.Value));
	}
/*
feature -- Setting
*/
	public void set_type (RuntimeTypeHandle a_type)
		// Assign `a_type' to `type'.
	{
		type = a_type;
	}

}

}
