/*
indexing
	description: "Set of features needed during execution of an Eiffel system for
		a proper implementation of generic conformance."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;
using EiffelSoftware.Runtime.Types;

namespace EiffelSoftware.Runtime {

[Serializable]
public class GENERIC_CONFORMANCE {

	public static void compute_type (
		EIFFEL_TYPE_INFO a_target_object,
		TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Give an Eiffel generated object type `obj' and its associated type array
		// information `type_array' generate if not yet done a new GENERIC_TYPE
		// object and assign it to `obj'. We use `current' in case some research needs
		// to be done in current context.
	{
		GENERIC_TYPE computed_type;

		if (a_type is GENERIC_TYPE) {
				// We are handling a generic type.
			computed_type = (GENERIC_TYPE) a_type.evaluated_type (a_current);
			a_target_object.____set_type (computed_type);
		} else {
				// Normal class type, nothing special needs to be done.
		}
	}

	public static EIFFEL_TYPE_INFO create_type (
		TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Create new instance of `a_type' in context of `a_current' object.
		// Handles creation of class type as well as creation of formal generic parameter.
	{
		CLASS_TYPE type_to_create;
		GENERIC_TYPE computed_type;
		EIFFEL_TYPE_INFO Result;

			// Evaluate type in context of Current object.
		type_to_create = (CLASS_TYPE) a_type.evaluated_type (a_current);

			// Create new object of type `type_to_create'.
			// Note: We use the `Activator' class because it is much faster than
			// creating an instance by getting the associated `ConstructorInfo'.
		Result = (EIFFEL_TYPE_INFO) Activator.
			CreateInstance (Type.GetTypeFromHandle (type_to_create.type));

			// Properly initializes `Result'.
		computed_type = type_to_create as GENERIC_TYPE;
		if (computed_type != null ) {
			Result.____set_type (computed_type);
		}
		return Result;
	}

	public static EIFFEL_TYPE_INFO create_like_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
		GENERIC_TYPE l_gen_type;
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
		GENERIC_TYPE l_type;
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

	public static TYPE load_type_of_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' extract its type information.
	{
		GENERIC_TYPE l_gen_type;
		CLASS_TYPE Result;

		l_gen_type = an_obj.____type ();

		if (l_gen_type == null) {
				// It is not a generic type, so we can simply find its type through
				// Reflection and then creates a CLASS_TYPE object.
			Result = new CLASS_TYPE ();
			Result.set_type (an_obj.GetType ().TypeHandle);
		} else {
				// It is a generic type, so we can simply find its type through
				// its GENERIC_TYPE.
			Result = l_gen_type;
		}
		return Result;

	}
}

}
