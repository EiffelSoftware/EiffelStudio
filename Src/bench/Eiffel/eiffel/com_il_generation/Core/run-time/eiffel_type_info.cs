/*
indexing
	description: "Ancestor to all Eiffel generated classes."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;

namespace ISE.Runtime {

public interface EIFFEL_TYPE_INFO {
/*
feature -- Assertion checking
*/
	[CLSCompliantAttribute (false)]
	void _invariant ();
		/* Checks invariant of current class, throw an exception
		 * when invariant is not satisfied.
		 */
/*
feature -- Access
*/
	[CLSCompliantAttribute (false)]
	EIFFEL_DERIVATION ____type();
		/* Get generic type if any. */

	[CLSCompliantAttribute (false)]
	String ____class_name();
		/* Name of current object's generating class
		 * (base class of the type of which it is a direct instance)
		 */
/*
feature -- Settings
*/

	[CLSCompliantAttribute (false)]
	void ____set_type(EIFFEL_DERIVATION type);
		/* Set `____type' with `type'. */
}

}
