/*
indexing
	description: "Ancestor to all Eiffel generated classes."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;
using EiffelSoftware.Runtime.Types;

namespace EiffelSoftware.Runtime {

[System.Runtime.InteropServices.ComVisibleAttribute (false)]
public interface EIFFEL_TYPE_INFO {
/*
feature -- Assertion checking
*/
	[CLSCompliantAttribute (false)]
	void _invariant ();
		// Checks invariant of current class, throw an exception
		// when invariant is not satisfied.
		//
/*
feature -- Access
*/
	[CLSCompliantAttribute (false)]
	GENERIC_TYPE ____type();
		/* Get generic type if any. */

	[CLSCompliantAttribute (false)]
	String ____class_name();
		// Name of current object's generating class
		// (base class of the type of which it is a direct instance)

/*
feature -- Comparison
*/
	[CLSCompliantAttribute (false)]
	bool ____is_equal (Object other);
		// Is `other' attached to an object considered
		// equal to current object?

/*
feature -- Duplication
*/
	[CLSCompliantAttribute (false)]
	void ____copy (Object other);
		// Update current object using fields of object attached
		// to `other', so as to yield equal objects.

	[CLSCompliantAttribute (false)]
	object ____standard_twin ();
		// New object field-by-field identical to `other'.
		// Always uses default copying semantics.

/*
feature -- Settings
*/

	[CLSCompliantAttribute (false)]
	void ____set_type(GENERIC_TYPE type);
		/* Set `____type' with `type'. */
}

}
