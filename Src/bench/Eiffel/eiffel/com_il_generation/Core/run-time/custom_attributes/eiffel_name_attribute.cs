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
	}

/*
feature -- Access
*/
	public String name;
		// Name of class associated to Current.
}

} // class EIFFEL_NAME_ATTRIBUTE
