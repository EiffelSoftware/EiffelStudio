/*
indexing
	description: "Ancestor to all Eiffel generated classes."
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

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
