/*
indexing
	description: "Representation of an Eiffel basic type."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

public class BASIC_TYPE: CLASS_TYPE {

	public override bool is_basic ()
		// Does `Current' represent a basic type?
		// Yes.
	{
		return true;
	}
}

}
