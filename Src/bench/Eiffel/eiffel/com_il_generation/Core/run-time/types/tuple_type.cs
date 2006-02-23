/*
indexing
	description: "Representation of an Eiffel type that has been computed
		at runtime. Usual case of a TUPLE type."
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
public class RT_TUPLE_TYPE: RT_GENERIC_TYPE {

/*
feature -- Conformance
*/
	public override bool conform_to (RT_TYPE other)
		// Does `Current' conform to `other'?
	{
		RT_TUPLE_TYPE l_tuple_type = other as RT_TUPLE_TYPE;
		RT_TYPE [] l_generics, l_type_generics;
		bool Result;
		int i, nb;

		if (l_tuple_type != null) {
				// Conformance between TUPLEs.
			nb = l_tuple_type.count;
			Result = count >= nb;
			l_generics = generics;
			l_type_generics = l_tuple_type.generics;
			for (i = 0; (i < nb) && Result; i++) {
				Result = (l_generics [i]).conform_to (l_type_generics [i]);
			}
		} else {
				// Conformance TUPLE -> other class types.
			Result = base.conform_to (other);
		}
		return Result;
	}

/*
feature -- Status report
*/
	public override bool is_tuple () 
		// Is current a TUPLE?
	{
		return true;
	}

/*
feature -- Comparison
*/
	public override bool Equals (Object other)
		// Is `other' similar to Current?
	{
		bool Result;

		if (other is RT_TUPLE_TYPE) {
			Result = base.Equals (other);
		} else {
			Result = false;
		}
		return Result;
	}

}

}
