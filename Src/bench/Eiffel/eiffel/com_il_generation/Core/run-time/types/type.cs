/*
indexing
	description: "Abstract representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public abstract class RT_TYPE {

/*
feature -- Status Report
*/
	public virtual bool is_basic ()
		// Does `Current' represent a basic type?
	{
		return false;
	}

	public virtual bool is_tuple ()
		// Does `Current' represent a TUPLE type?
	{
		return false;
	}

	public virtual bool has_formal ()
		// Does `Current' have a formal generic parameter?
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
	
	public virtual RT_TYPE evaluated_type (RT_GENERIC_TYPE context_type)
		// Evaluate Current in context of `context_type'.
	{
		return this;
	}
}

}
