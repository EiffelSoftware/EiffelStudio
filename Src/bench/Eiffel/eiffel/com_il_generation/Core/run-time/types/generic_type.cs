/*
indexing
	description: "Representation of an Eiffel type that has been computed
		at runtime. Usually case of a generic class."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

public class GENERIC_TYPE: CLASS_TYPE {

/*
feature -- Access
*/
	public TYPE[] type_array;
		// Type holding information about current generic derivation

	public int nb_generics;
		// Number of generics if any.

/*
feature -- Status Report
*/
	public override String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		String Result = base.type_name ();

		Result = String.Concat (Result, " [");

		for (int i = 0; i < nb_generics; i++) {
			Result = String.Concat (Result, type_array [i].type_name ());
			if (i + 1 < nb_generics) {
				Result = String.Concat (Result, ", ");
			}
		}

		Result = String.Concat (Result, "]");
		return Result;
	}

/*
feature -- Settings
*/
	public void set_type_array (TYPE[] an_array)
		// Assign `an_array' to `type_array'.
	{
		type_array = an_array;
	}

	public void set_nb_generics (int nb)
		// Assign `nb' to `nb_generics'.
	{
		nb_generics = nb;
	}
}

}
