/*
indexing
	description: "Custom attributes to save real Eiffel class name in metadata."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace EiffelSoftware.Runtime.CA
{

[AttributeUsage (AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
[Serializable]
public class EIFFEL_NAME_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public EIFFEL_NAME_ATTRIBUTE(String a_name)
	{
		name = a_name;
		generics = null;
	}

	public EIFFEL_NAME_ATTRIBUTE(String a_name, Type [] a_generics)
	{
		name = a_name;
		generics = a_generics;
	}

/*
feature -- Access
*/
	public String name;
		// Name of class associated to Current.

	public Type [] generics;
		// Generic paramter if any.

	public bool is_generic ()
		// Is current class generic?
	{
		return (generics != null);
	}
}

} // class EIFFEL_NAME_ATTRIBUTE
