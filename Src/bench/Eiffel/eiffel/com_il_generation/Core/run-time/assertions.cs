/*
indexing
	description: "Class used for assertions checking in ISE runtime."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace ISE.Runtime
{

public class ASSERTIONS	{

	public static void REQUIRE (String msg, bool expression)
		// Throw a precondition violation if `expression' is not true.
	{
		if (!expression) {
			throw new Exception ("Precondition violation: " + msg);
		}
	}

	public static void ENSURE (String msg, bool expression)
		// Throw a postcondition violation if `expression' is not true.
	{
		if (!expression) {
			throw new Exception ("Postcondition violation: " + msg);
		}
	}

	public static void CHECK (String msg, bool expression)
		// Throw a check violation if `expression' is not true.
	{
		if (!expression) {
			throw new Exception ("Check violation: " + msg);
		}
	}

} // class ASSERTIONS

} // namespace
