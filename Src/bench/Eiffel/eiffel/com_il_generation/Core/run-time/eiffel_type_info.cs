/*
indexing
	description: "Ancestor to all Eiffel generated classes."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;

namespace ISE.Runtime {

[CLSCompliantAttribute (false)]
public interface EIFFEL_TYPE_INFO {
/*
feature -- Assertion checking
*/
	void _invariant ();
		/* Checks invariant of current class, throw an exception
		 * when invariant is not satisfied.
		 */
/*
feature -- Access
*/
	EIFFEL_DERIVATION ____type();
		/* Get generic type if any. */

	String ____class_name();
		/* Name of current object's generating class
		 * (base class of the type of which it is a direct instance)
		 */
/*
feature -- Settings
*/
	void ____set_type(EIFFEL_DERIVATION type);
		/* Set `____type' with `type'. */
}

}
