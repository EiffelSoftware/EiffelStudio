/*
indexing
	description: "Abstract representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

public abstract class TYPE {

/*
feature -- Status Report
*/
	public virtual bool is_basic ()
		// Does `Current' represent a basic type?
	{
		return false;
	}

	public virtual String class_name ()
		// Name of object's generating class who has Current as an EIFFEL_DERIVATION
		// (base class of the type of which it is a direct instance)
	{
		return String.Empty;
	}

	public virtual String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return String.Empty;
	}
		
}

}
