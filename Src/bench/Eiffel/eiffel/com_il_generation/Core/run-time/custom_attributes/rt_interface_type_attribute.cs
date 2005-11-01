/*
indexing
	description: "Custom attributes to store associated interface of an Eiffel implementation class. Only used to get type of generic parameters and to perform conformance checking."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using EiffelSoftware.Runtime.Enums;

namespace EiffelSoftware.Runtime.CA
{
[Serializable]
public class RT_INTERFACE_TYPE_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public RT_INTERFACE_TYPE_ATTRIBUTE(Type type)
	{
		class_type = type;
	}

/*
feature -- Access
*/
	public Type class_type;
		// Type of class associated to Current.

}

} // class RT_INTERFACE_TYPE_ATTRIBUTE
