/*
indexing
	description: "Representation of an Eiffel type that is known in advance.
		Usually type of a non-generic Eiffel class or a generic class but
		with no generic information."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

public class CLASS_TYPE: TYPE {
/*
feature -- Access
*/
	public RuntimeTypeHandle type;
		// Current associated System.Type.

/*
feature -- Status Report
*/
	public override String class_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return Type.GetTypeFromHandle (type).Name;
	}

	public override String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return class_name ();
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
