/*
indexing
	description: "Representation of an Eiffel type that is formal. I.e.
		its real type is only known at run-time."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

public class FORMAL_TYPE: TYPE {
/*
feature -- Access
*/
	public Int32 position;
		// Formal position.
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
