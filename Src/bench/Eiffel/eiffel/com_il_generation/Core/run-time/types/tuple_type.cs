/*
indexing
	description: "Representation of an Eiffel type that has been computed
		at runtime. Usual case of a TUPLE type."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class RT_TUPLE_TYPE: RT_GENERIC_TYPE {

/*
feature -- Conformance
*/
	public override bool conform_to (RT_TYPE other)
		// Does `Current' conform to `other'?
	{
		RT_TUPLE_TYPE l_tuple_type = other as RT_TUPLE_TYPE;
		RT_TYPE [] l_generics, l_type_generics;
		bool Result;
		int i, nb;

		if (l_tuple_type != null) {
				// Conformance between TUPLEs.
			nb = l_tuple_type.count;
			Result = count >= nb;
			l_generics = generics;
			l_type_generics = l_tuple_type.generics;
			for (i = 0; (i < nb) && Result; i++) {
				Result = (l_generics [i]).conform_to (l_type_generics [i]);
			}
		} else {
				// Conformance TUPLE -> other class types.
			Result = base.conform_to (other);
		}
		return Result;
	}

/*
feature -- Status report
*/
	public override bool is_tuple () 
		// Is current a TUPLE?
	{
		return true;
	}

/*
feature -- Comparison
*/
	public override bool Equals (Object other)
		// Is `other' similar to Current?
	{
		bool Result;

		if (other is RT_TUPLE_TYPE) {
			Result = base.Equals (other);
		} else {
			Result = false;
		}
		return Result;
	}

}

}
