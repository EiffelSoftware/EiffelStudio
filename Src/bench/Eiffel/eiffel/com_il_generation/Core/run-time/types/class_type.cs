/*
indexing
	description: "Representation of an Eiffel type that is known in advance.
		Usually type of a non-generic Eiffel class or a generic class but
		with no generic information."
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
using EiffelSoftware.Runtime.CA;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class RT_CLASS_TYPE: RT_TYPE {

/*
feature -- Initialization
*/
	public RT_CLASS_TYPE ()
		// Default creation procedure
	{
	}

	public RT_CLASS_TYPE (RuntimeTypeHandle a_type)
		// Initialize `Current' with type `a_type'.
	{
		type = a_type;
	}

/*
feature -- Access
*/
	public RuntimeTypeHandle type;
		// Current associated System.Type.

	public Type dotnet_type ()
		// Associated .NET type of `type'.
	{
		return Type.GetTypeFromHandle (type);
	}

/*
feature -- Conformance
*/
	public override bool conform_to (RT_TYPE other)
		// Does `Current' conform to `other'?
	{
		RT_CLASS_TYPE l_other = other as RT_CLASS_TYPE;
		bool Result = l_other != null;
		if (Result) {
			Result = l_other.dotnet_type().IsAssignableFrom (dotnet_type ()) &&
				l_other.valid_generic (this);
		}
		return Result;
	}

	public virtual bool valid_generic (RT_CLASS_TYPE a_type)
		// Do the generic parameters of `type' conform to those of Current?
		// Assumes that `a_type' base class conforms to current's base class.
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE("a_type_not_null", a_type != null);
		#endif
		return true;
	}

/*
feature -- Status Report
*/
	public override int GetHashCode()
		// Associated hash_code
	{
		return type.Value.GetHashCode();
	}

	public override String class_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		String Result;
		Object [] l_ca;
		Type l_type;
		EIFFEL_NAME_ATTRIBUTE l_class_name;

		l_type = Type.GetTypeFromHandle (type);
		l_ca = l_type.GetCustomAttributes (typeof (EIFFEL_NAME_ATTRIBUTE), false);

		#if ASSERTIONS
			ASSERTIONS.CHECK ("`l_ca' should not be Void", l_ca != null);
		#endif

		if (l_ca.Length == 1) {
			l_class_name = (EIFFEL_NAME_ATTRIBUTE) l_ca [0];
			Result = l_class_name.name;
		} else {
			if (l_type.IsArray) {
					// This is not the perfect solution as it could be an instance
					// of System.Array and not a vector array. But that will do for now.
				Result = "NATIVE_ARRAY";
			} else {
				Result = l_type.Name;
			}
		}

		return Result;
	}

	public override String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return class_name ();
	}

/*
feature -- Comparison
*/

	public override bool Equals (object other)
		// Is Current equal to `other'?
	{
		RT_CLASS_TYPE l_other = other as RT_CLASS_TYPE;

		return (l_other != null && (type.Value == l_other.type.Value));
	}
/*
feature -- Setting
*/
	public void set_type (RuntimeTypeHandle a_type)
		// Assign `a_type' to `type'.
	{
		type = a_type;
	}

}

}
