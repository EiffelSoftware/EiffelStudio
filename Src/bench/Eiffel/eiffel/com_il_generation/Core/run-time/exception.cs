/*
indexing
	description: "To manage exceptions from the Eiffel side"
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

public class EXCEPTION_MANAGER {
/*
feature -- Access
*/
	public static Exception last_exception;
		// Last raised exception in `rescue' clause.

/*
feature -- Exceptions
*/
	public static void raise (Exception e)
		// Throw an exception `e'.
	{
		throw e;
	}

}
}
