/*
indexing
	description: "Ancestor to all Eiffel generated classes."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;
using EiffelSoftware.Runtime.Types;
using EiffelSoftware.Runtime.CA;

namespace EiffelSoftware.Runtime {

[EIFFEL_CONSUMABLE_ATTRIBUTE (false)]
[CLSCompliant (false)]
[System.Runtime.InteropServices.ComVisibleAttribute (false)]
public interface EIFFEL_TYPE_INFO {
/*
feature -- Assertion checking
*/
	void _invariant ();
		// Checks invariant of current class, throw an exception
		// when invariant is not satisfied.
		//
/*
feature -- Access
*/
	RT_GENERIC_TYPE ____type();
		/* Get generic type if any. */

	String ____class_name();
		// Name of current object's generating class
		// (base class of the type of which it is a direct instance)

/*
feature -- Comparison
*/
	bool ____is_equal (Object other);
		// Is `other' attached to an object considered
		// equal to current object?

/*
feature -- Duplication
*/
	void ____copy (Object other);
		// Update current object using fields of object attached
		// to `other', so as to yield equal objects.

	object ____standard_twin ();
		// New object field-by-field identical to `other'.
		// Always uses default copying semantics.

/*
feature -- Settings
*/

	void ____set_type(RT_GENERIC_TYPE type);
		/* Set `____type' with `type'. */
}

}
