/*
indexing
	description: "Representation of an Eiffel type that is formal. I.e.
		its real type is only known at run-time."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace EiffelSoftware.Runtime.Types {

[CLSCompliantAttribute (false)]
[Serializable]
public class FORMAL_TYPE: TYPE {
/*
feature -- Access
*/
	public Int32 position;
		// Formal position.

/*
feature -- Status report
*/
	public override TYPE evaluated_type (EIFFEL_TYPE_INFO context_object)
		// Evaluate Current in context of `context_object'.
	{
			// Get type of formal in context of `a_current' object.
		return context_object.____type().generics [position - 1];
	}

	public override bool has_formal ()
		// Does `Current' have a formal generic parameter?
	{
		return true;
	}

/*
feature -- Settings
*/
	public void set_position (Int32 pos)
		// Assign `pos' to `position'.
	{
		position = pos;
	}
}

}
