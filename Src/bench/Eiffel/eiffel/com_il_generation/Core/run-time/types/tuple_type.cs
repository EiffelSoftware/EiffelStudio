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
