/*
indexing
	description: "Representation of an Eiffel type that has been computed
		at runtime. Usually case of a generic class."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

[Serializable]
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

	public override TYPE evaluated_type (EIFFEL_TYPE_INFO context_object)
		// Evaluate Current in context of `context_object'.
	{
		GENERIC_TYPE l_type;
		Int32 i = 0;

			// Duplicate current data as after the evaluation in context
			// of `context_object' it will be the same except for `type_array'
			// which will only contained fully evaluated types that's why
			// `type_array' is created of type `CLASS_TYPE []'.
		l_type = (GENERIC_TYPE) MemberwiseClone();
		l_type.set_type_array (new CLASS_TYPE [nb_generics]);

			// Evaluate all types contained in `type_array' in context of `context_object'
		for (i = 0; i < nb_generics ; i ++) {
				// No need for cast here as we are 100% sure that result of evaluation
				// on each item of the array will yield to an instance of CLASS_TYPE.
			#if ASSERTIONS
				ASSERTIONS.CHECK ("Valid element type", type_array [i].evaluated_type (context_object) is CLASS_TYPE);
			#endif
			l_type.type_array [i] = type_array [i].evaluated_type (context_object);
		}

		return l_type;
	}

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
