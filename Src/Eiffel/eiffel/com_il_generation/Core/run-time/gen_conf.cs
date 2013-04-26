/*
indexing
	description: "Set of features needed during execution of an Eiffel system for
		a proper implementation of generic conformance."
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
[Serializable]
public class GENERIC_CONFORMANCE {

	public static EIFFEL_TYPE_INFO create_type (
		RT_TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Create new instance of `a_type' in context of `a_current' object.
		// Handles creation of class type as well as creation of formal generic parameter.
	{
		RT_CLASS_TYPE type_to_create;
		RT_GENERIC_TYPE computed_type;

			// Evaluate type in context of Current object.
		type_to_create = (RT_CLASS_TYPE) a_type.evaluated_type (a_current.____type());

			// Create new object of type `type_to_create'.
		computed_type = type_to_create as RT_GENERIC_TYPE;
		return (EIFFEL_TYPE_INFO) create_instance (Type.GetTypeFromHandle (type_to_create.type), computed_type);
	}

	public static object create_array (
		int n,
		RT_TYPE a_type,
		EIFFEL_TYPE_INFO a_current,
		RuntimeTypeHandle any_type_handle
	)
		// Create new instance of an array type whose element types are `a_type' in context of
		// `a_current' object.
		// Handles elements that are class types as well as formals.
	{
		RT_CLASS_TYPE type_to_create;

			// Evaluate type in context of Current object.
		type_to_create = (RT_CLASS_TYPE) a_type.evaluated_type (a_current.____type());

		if (type_to_create.is_none() || (type_to_create.type.Value == any_type_handle.Value)) {
			return new object [n];
		} else {
			return Array.CreateInstance (
				ISE_RUNTIME.interface_type (Type.GetTypeFromHandle (type_to_create.type)), n);
		}
	}

	public static EIFFEL_TYPE_INFO create_like_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
			// Create a new instance of the same type of `an_obj'
			// If it is a generic type, we also need to set its type.
		return (EIFFEL_TYPE_INFO) create_instance
			(an_obj.GetType (), an_obj.____type ());
	}

	public static object create_like_object (object an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
		EIFFEL_TYPE_INFO l_obj_info;
		RT_GENERIC_TYPE l_type = null;

			// Create a new instance of the same type of `an_obj'
		l_obj_info = an_obj as EIFFEL_TYPE_INFO;
		if (l_obj_info != null) {
				// If it is a generic type, we also need to set its type.
			l_type = l_obj_info.____type ();
		}
		return create_instance (an_obj.GetType (), l_type);
	}

	public static RT_TYPE load_type_of_object (object an_obj)
		// Given an Eiffel object `an_obj' extract its type information.
	{
		RT_GENERIC_TYPE l_gen_type;
		RT_CLASS_TYPE Result;
		EIFFEL_TYPE_INFO l_obj = an_obj as EIFFEL_TYPE_INFO;

		if (l_obj != null) {
			l_gen_type = l_obj.____type ();
		} else {
			l_gen_type = null;
		}

		if (l_gen_type == null) {
				// It is not an Eiffel generic type or it is a .NET type, so we can simply
				// find its type through Reflection and then creates a RT_CLASS_TYPE object.
				// Note that .NET generic types are treated as non-generic.
			Result = new RT_CLASS_TYPE ();
			Result.set_type (an_obj.GetType ().TypeHandle);
		} else {
				// It is a generic type, so we can simply find its type through
				// its RT_GENERIC_TYPE.
			Result = l_gen_type;
		}
		return Result;

	}

	internal static object create_instance (Type type, RT_GENERIC_TYPE computed_type)
		// Create instance of a given `type' with the type information
		// `computed_type' (if any).
	{
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		if (computed_type == null ) {
				// Use argumentless constructor.
			return Activator.CreateInstance (type);
		} else {
				// Use constructor with a type parameter.
			return Activator.CreateInstance (type, new Object [] {computed_type});
		}
	}
}

}
