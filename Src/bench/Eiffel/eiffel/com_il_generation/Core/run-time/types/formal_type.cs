/*
indexing
	description: "Representation of an Eiffel type that is formal. I.e.
		its real type is only known at run-time."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class RT_FORMAL_TYPE: RT_TYPE {
/*
feature -- Access
*/
	public Int32 position;
		// Formal position.

/*
feature -- Status report
*/
	public override RT_TYPE evaluated_type (RT_GENERIC_TYPE context_type)
		// Evaluate Current in context of `context_type'.
	{
			// Get type of formal in context of `a_current' object.
		return context_type.generics [position - 1];
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
