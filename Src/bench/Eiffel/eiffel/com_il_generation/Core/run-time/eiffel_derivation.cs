/*
indexing
	description: "Represent generic derivation for a generic class. Used for generic conformance."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Reflection;

namespace ISE.Runtime {

[Serializable]
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

}
