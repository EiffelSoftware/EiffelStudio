/*
indexing
	description: "Representation of an Eiffel type that has been computed
		at runtime. Usually case of a generic class."
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

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class RT_GENERIC_TYPE: RT_CLASS_TYPE {

/*
feature -- Access
*/
	public RT_TYPE[] generics;
		// Type holding information about current generic derivation

	public int count;
		// Number of elements in `generics'

	private byte has_formal_flags;
		// Does current generic type has formals?
	
/*
feature -- Conformance
*/
	public override bool valid_generic (RT_CLASS_TYPE a_type)
		// Do the generic parameters of `type' conform to those of Current?
		// Assumes that `a_type' base class conforms to current's base class.
	{
		bool Result = false;
		RT_GENERIC_TYPE l_type;
		RT_TYPE [] l_generics, l_type_generics;
		int i, nb;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE("a_type_not_null", a_type != null);
		#endif

		if (type.Value == a_type.type.Value) {
				// Types are the same, check that their generic paramters are conformant
			Result = true;
			l_type = a_type as RT_GENERIC_TYPE;
			#if ASSERTIONS
				ASSERTIONS.CHECK("l_type_not_void", l_type != null);
				ASSERTIONS.CHECK("same_count", count == l_type.count);
			#endif
			l_generics = generics;
			l_type_generics = l_type.generics;
			nb = count;
			for (i = 0; (i < nb) && Result; i++) {
				Result = (l_type_generics [i]).conform_to (l_generics [i]);
			}
		} else {
				// `type' is a descendant type of Current: so we
				// have to check the current generic parameters
				// FIXME: We cannot do that because we do not have a parent table.
				//        for now we simply return True as we know that we have
				//        conformance of classes.
			Result = true;
		}
		return Result;
	}

/*
feature -- Status Report
*/
	public override RT_TYPE evaluated_type (RT_GENERIC_TYPE context_type)
		// Evaluate Current in context of `context_type'.
	{
		RT_GENERIC_TYPE Result;
		RT_TYPE [] l_generics, l_other_generics;
		int i, nb;

		if (has_formal ()) {
			i = 0;
			nb = count;

				// Duplicate current data as after the evaluation in context
				// of `context_type' it will be the same except for `generics'
				// which will only contained fully evaluated types that's why
				// `generics' is created of type `RT_CLASS_TYPE []'.
			Result = (RT_GENERIC_TYPE) MemberwiseClone();
			l_other_generics = new RT_CLASS_TYPE [nb];
			Result.set_generics (l_other_generics);

				// Evaluate all types contained in `generics' in context of `context_type'
			l_generics = generics;
			for (; i < nb ; i ++) {
				#if ASSERTIONS
					ASSERTIONS.CHECK ("Valid element type",
						l_generics [i].evaluated_type (context_type) is RT_CLASS_TYPE);
				#endif
				l_other_generics [i] = l_generics [i].evaluated_type (context_type);
			}
			Result.set_has_formal (false);
		} else {
			Result = this;
		}
		return Result;
	}

	public override bool has_formal ()
		// Does `Current' have a formal generic parameter?
	{
		int i, nb;
		byte l_flags = has_formal_flags;
		RT_TYPE[] l_generics;
		
		if ((l_flags & 0x10) == 0x10) {
			return (l_flags & 0x01) == 0x01;
		} else {
			l_generics = generics;

			for (i = 0, nb = count; i < nb; i++) {
				if (l_generics [i].has_formal ()) {
					has_formal_flags = 0x11;
					return true;
				}
			}
			has_formal_flags = 0x10;
			return false;
		}
	}

	public override String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		String Result = base.type_name ();
		RT_TYPE [] l_generics;
		int i, nb;

		nb = count;
		if (nb > 0) {
			Result = String.Concat (Result, str_open_generics);
		}

		l_generics = generics;
		for (i = 0; i < nb; i++) {
			Result = String.Concat (Result, l_generics [i].type_name ());
			if (i + 1 < nb) {
				Result = String.Concat (Result, str_comma);
			}
		}

		if (nb > 0) {
			Result = String.Concat (Result, str_close_generics);
		}
		return Result;
	}

/*
feature -- Settings
*/
	public void set_generics (RT_TYPE[] an_array)
		// Assign `an_array' to `generics'.
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE("an_array_not_void", an_array != null);
		#endif
		generics = an_array;
		count = an_array.Length;
	}

	public void set_has_formal (bool v)
		// Assign `v' to `has_formal'.
	{
		if (v) {
			has_formal_flags = 0x11;
		} else {
			has_formal_flags = 0x10;
		}
	}

/*
feature -- Comparison
*/
	public override bool Equals (Object other)
		// Is `other' similar to Current?
	{
		bool Result = false;
		RT_GENERIC_TYPE l_other = other as RT_GENERIC_TYPE;
		RT_TYPE [] l_generics, l_other_generics;
		int i, nb;

		if (l_other != null) {
			nb = count;
			if ((type.Value == l_other.type.Value) && (nb == l_other.count)) {
				Result = true;
				l_generics = generics;
				l_other_generics = l_other.generics;
				for (i = 0; (i < nb) && Result; i++) {
					Result = (l_generics [i]).Equals (l_other_generics [i]);
				}
			}
		}
		return Result;
	}

/*
feature {NONE} -- Implementation
*/

	private static string str_open_generics = " [";
	private static string str_close_generics = "]";
	private static string str_comma = ", ";
		// Constants for type name formatting.

}

}
