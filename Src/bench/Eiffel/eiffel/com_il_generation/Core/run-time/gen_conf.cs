/*
indexing
	description: "Set of features needed during execution of an Eiffel system for
		a proper implementation of generic conformance."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;

namespace ISE.Runtime {

[Serializable]
public class GENERIC_CONFORMANCE {

	public static void compute_type (
		EIFFEL_TYPE_INFO a_target_object,
		TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Give an Eiffel generated object type `obj' and its associated type array
		// information `type_array' generate if not yet done a new EIFFEL_DERIVATION
		// object and assign it to `obj'. We use `current' in case some research needs
		// to be done in current context.
	{
		GENERIC_TYPE computed_type;
		EIFFEL_DERIVATION derivation;

		if (a_type is GENERIC_TYPE) {
				// We are handling a generic type.
			computed_type = (GENERIC_TYPE) a_type.evaluated_type (a_current);
			derivation = new EIFFEL_DERIVATION (computed_type, computed_type.nb_generics,
				(CLASS_TYPE []) computed_type.type_array);
			a_target_object.____set_type (derivation);
		} else {
				// Normal class type, nothing special needs to be done.
		}
	}

	public static EIFFEL_TYPE_INFO create_type (
		TYPE a_type,
		EIFFEL_TYPE_INFO a_current
	)
		// Give an Eiffel generated object type `obj' and its associated type array
		// information `type_array' generate if not yet done a new EIFFEL_DERIVATION
		// object and assign it to `obj'. We use `current' in case some research needs
		// to be done in current context.
	{
		CLASS_TYPE type_to_create;
		GENERIC_TYPE computed_type;
		EIFFEL_DERIVATION derivation;
		ConstructorInfo constructor;
		EIFFEL_TYPE_INFO Result;

			// Evaluate type in context of Current object.
		type_to_create = (CLASS_TYPE) a_type.evaluated_type (a_current);

			// Create new object of type `type_to_create'.
		constructor = Type.GetTypeFromHandle (type_to_create.type).GetConstructor (Type.EmptyTypes);
		Result = (EIFFEL_TYPE_INFO) constructor.Invoke (null);

			// Properly initializes `Result'.
		if (type_to_create is GENERIC_TYPE) {
			computed_type = (GENERIC_TYPE) a_type.evaluated_type (a_current);
			derivation = new EIFFEL_DERIVATION (computed_type, computed_type.nb_generics,
				(CLASS_TYPE []) computed_type.type_array);
			Result.____set_type (derivation);
		}
		return Result;
	}

	public static EIFFEL_TYPE_INFO create_like_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' create a new one of same type.
	{
		EIFFEL_DERIVATION der;
		EIFFEL_TYPE_INFO Result;
		ConstructorInfo constructor;

		der = an_obj.____type ();

		if (der == null) {
				// It is not a generic type, so we can simply find its type through
				// Reflection and then gets its constructor.
			constructor = an_obj.GetType ().GetConstructor (Type.EmptyTypes);
			Result = (EIFFEL_TYPE_INFO) constructor.Invoke (null);
		} else {
				// It is a generic type, so we can simply find its type through
				// its RuntimeTypeHandle and then gets its constructor.
			constructor = Type.GetTypeFromHandle (der.type.type).GetConstructor (Type.EmptyTypes);
			Result = (EIFFEL_TYPE_INFO) constructor.Invoke (null);
			Result.____set_type (der);
		}
		return Result;
	}

	public static TYPE load_type_of_object (EIFFEL_TYPE_INFO an_obj)
		// Given an Eiffel object `an_obj' extract its type information.
	{
		EIFFEL_DERIVATION der;
		CLASS_TYPE Result;

		der = an_obj.____type ();

		if (der == null) {
				// It is not a generic type, so we can simply find its type through
				// Reflection and then creates a CLASS_TYPE object.
			Result = new CLASS_TYPE ();
			Result.set_type (an_obj.GetType ().TypeHandle);
		} else {
				// It is a generic type, so we can simply find its type through
				// its EIFFEL_DERIVATION.
			Result = der.type;
		}
		return Result;

	}

	public static Boolean conforms_to (Object obj1, Object obj2)
		// Does dynamic type of object attached to `obj1' conform to
		// dynamic type of object attached to `obj2'?
		// Only called for Eiffel object.
	{
		Boolean Result;
		EIFFEL_TYPE_INFO t, s;
		EIFFEL_DERIVATION der1, der2;
		t = (EIFFEL_TYPE_INFO) obj1;
		s = (EIFFEL_TYPE_INFO) obj2;

		der1 = t.____type ();
		der2 = s.____type ();
		if (der2 == null) {
				// Parent type represented by the `obj2' instance
				// is not generic, therefore `obj1' should directly
				// conform to the parent type.
			Result = obj1.GetType ().IsInstanceOfType (obj2);
		} else if (der1 == null) {
				// Parent is generic, but not type represented by
				// `obj1', so let's first check if it simply
				// conforms without looking at the generic parameter.
			Result = obj1.GetType ().IsInstanceOfType (obj2);
			if (Result) {
					// It does conform, so now we have to go through
					// the parents to make sure it has the same generic
					// derivation.
			}
		} else {
				// Both types are generic. We first check if they
				// simply conforms.
			Result = obj1.GetType ().IsInstanceOfType (obj2);
			if (Result) {
			}
		}
		return Result;
	}
}

}
