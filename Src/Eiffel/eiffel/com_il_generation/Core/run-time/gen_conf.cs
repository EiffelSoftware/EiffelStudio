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

	public static void compute_type (
		EIFFEL_TYPE_INFO a_target_object,
		RT_TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Give an Eiffel generated object type `obj' and its associated type array
		// information `type_array' generate if not yet done a new RT_GENERIC_TYPE
		// object and assign it to `obj'. We use `current' in case some research needs
		// to be done in current context.
	{
		RT_GENERIC_TYPE computed_type;

		if (a_type is RT_GENERIC_TYPE) {
				// We are handling a generic type.
			computed_type = (RT_GENERIC_TYPE) a_type.evaluated_type (a_current.____type());
			a_target_object.____set_type (computed_type);
		} else {
				// Normal class type, nothing special needs to be done.
		}
	}

	public static EIFFEL_TYPE_INFO create_type (
		RT_TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Create new instance of `a_type' in context of `a_current' object.
		// Handles creation of class type as well as creation of formal generic parameter.
	{
		RT_CLASS_TYPE type_to_create;
		RT_GENERIC_TYPE computed_type;
		EIFFEL_TYPE_INFO Result;

			// Evaluate type in context of Current object.
		type_to_create = (RT_CLASS_TYPE) a_type.evaluated_type (a_current.____type());

			// Create new object of type `type_to_create'.
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = (EIFFEL_TYPE_INFO) Activator.
			CreateInstance (Type.GetTypeFromHandle (type_to_create.type));

			// Properly initializes `Result'.
		computed_type = type_to_create as RT_GENERIC_TYPE;
		if (computed_type != null ) {
			Result.____set_type (computed_type);
		}
		return Result;
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
		RT_GENERIC_TYPE l_gen_type;
		EIFFEL_TYPE_INFO Result;

			// Create a new instance of the same type of `an_obj'
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = (EIFFEL_TYPE_INFO) Activator.CreateInstance (an_obj.GetType ());

			// If it is a generic type, we also need to set its type.
		l_gen_type = an_obj.____type ();
		if (l_gen_type != null) {
			Result.____set_type (l_gen_type);
		}
		return Result;
	}

	public static object create_like_object (object an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
		RT_GENERIC_TYPE l_type;
		object Result;
		EIFFEL_TYPE_INFO l_obj_info;

			// Create a new instance of the same type of `an_obj'
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = Activator.CreateInstance (an_obj.GetType ());

		l_obj_info = an_obj as EIFFEL_TYPE_INFO;
		if (l_obj_info != null) {
				// If it is a generic type, we also need to set its type.
			l_type = l_obj_info.____type ();
			if (l_type != null) {
				((EIFFEL_TYPE_INFO) Result).____set_type (l_type);
			}
		}
		return Result;
	}

	public static RT_TYPE load_type_of_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' extract its type information.
	{
		RT_GENERIC_TYPE l_gen_type;
		RT_CLASS_TYPE Result;

		l_gen_type = an_obj.____type ();

		if (l_gen_type == null) {
				// It is not a generic type, so we can simply find its type through
				// Reflection and then creates a RT_CLASS_TYPE object.
			Result = new RT_CLASS_TYPE ();
			Result.set_type (an_obj.GetType ().TypeHandle);
		} else {
				// It is a generic type, so we can simply find its type through
				// its RT_GENERIC_TYPE.
			Result = l_gen_type;
		}
		return Result;

	}
}

}
