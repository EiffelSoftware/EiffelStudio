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
		TYPE type;
		FORMAL_TYPE formal_type;
		CLASS_TYPE[] type_array;
		EIFFEL_DERIVATION derivation;

		if (a_type is GENERIC_TYPE) {
				// We are handling a generic type.
			computed_type = (GENERIC_TYPE) a_type;
			type_array = new CLASS_TYPE [computed_type.nb_generics];
			for (int i = 0; i < computed_type.nb_generics; i ++) {
				type = computed_type.type_array [i];
				if (type is FORMAL_TYPE) {
					formal_type = (FORMAL_TYPE) type;
					type_array [i] = a_current.____type().generics_type [formal_type.position - 1];
				} else {
					type_array [i] = (CLASS_TYPE) type;
				}
			}
			derivation = new EIFFEL_DERIVATION (computed_type, computed_type.nb_generics,
				type_array);
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
		CLASS_TYPE[] type_array;
		CLASS_TYPE type_to_create;
		GENERIC_TYPE computed_type;
		FORMAL_TYPE formal_type;
		EIFFEL_DERIVATION derivation;
		ConstructorInfo constructor;
		EIFFEL_TYPE_INFO Result;

		if (a_type is FORMAL_TYPE) {
			formal_type = (FORMAL_TYPE) a_type;
				// Get type of formal in context of `a_current' object.
			type_to_create = a_current.____type().generics_type [formal_type.position - 1];
		} else {
			type_to_create = (CLASS_TYPE) a_type;
		}

			// Create new object of type `type_to_create'.
		constructor = Type.GetTypeFromHandle (type_to_create.type).GetConstructor (Type.EmptyTypes);
		Result = (EIFFEL_TYPE_INFO) constructor.Invoke (null);

			// Properly initializes `Result'.
		if (type_to_create is GENERIC_TYPE) {
			computed_type = (GENERIC_TYPE) type_to_create;
			type_array = new CLASS_TYPE [computed_type.nb_generics];
			for (int i = 0; i < computed_type.nb_generics; i ++) {
					// Since `computed_type' is a living type, it can only
					// be composed of CLASS_TYPE and therefore cast will
					// always succeed.
				type_array [i] = (CLASS_TYPE) computed_type.type_array [i];
			}
			derivation = new EIFFEL_DERIVATION (computed_type, computed_type.nb_generics,
				type_array);
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

public class EIFFEL_DERIVATION {
/*
feature {NONE} -- Initialization
*/
	public EIFFEL_DERIVATION (CLASS_TYPE a_type, Int32 n, CLASS_TYPE [] types)
		// Initialize an instance of Current with `a_type' run-time
		// type of current instance, `n' as number of generic parameters
		// and `types' as array completely describing generics type.
	{
		set_type (a_type);
		set_nb_generics (n);
		set_generics_type (types);
	}
/*
feature -- Access
*/
	public CLASS_TYPE type;
		// TYPE representing current instance.

	public Int32 nb_generics;
		// Number of generic parameters if any.

	public CLASS_TYPE[] generics_type;
		// Array describing current type for each generic parameter.


/*
feature -- Status Report
*/
	public bool has_generic ()
		// Does `Current' have generic parameters?
	{
		return nb_generics > 0;
	}

	public String class_name ()
		// Name of object's generating class who has Current as an EIFFEL_DERIVATION
		// (base class of the type of which it is a direct instance)
	{
		return type.class_name ();
	}

	public String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return type.type_name ();
	}

/*
feature -- Settings
*/
	public void set_type (CLASS_TYPE a_type)
		// Assign `a_type' to `type'.
	{
		type = a_type;
	}

	public void set_nb_generics (Int32 n)
		// Assign `n' to `nb_generics'.
	{
		nb_generics = n;
	}

	public void set_generics_type (CLASS_TYPE [] types)
		// Assign `generics_type' to `type_array'.
	{
		generics_type = types;
	}
}

[CLSCompliantAttribute (false)]
public interface EIFFEL_TYPE_INFO {
	EIFFEL_DERIVATION ____type();
	String ____class_name();
	void ____set_type(EIFFEL_DERIVATION type);
}

public class EIFFEL_DERIVATION_LIST {
	public static EIFFEL_DERIVATION [] eiffel_types;
		// List all computed Eiffel types.
}

}
