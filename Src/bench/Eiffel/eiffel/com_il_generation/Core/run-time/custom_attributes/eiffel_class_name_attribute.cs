/*
indexing
	description: "Custom attributes to save real Eiffel class name in metadata."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace EiffelSoftware.Runtime.CA
{

[CLSCompliant(false)]
[AttributeUsage (AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
[Serializable]
public class EIFFEL_CLASS_NAME_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public EIFFEL_CLASS_NAME_ATTRIBUTE(String name)
	{
		class_name = name;
	}

/*
feature -- Access
*/
	public String class_name;
		// Name of class associated to Current.
}

} // class EIFFEL_CLASS_NAME_ATTRIBUTE
