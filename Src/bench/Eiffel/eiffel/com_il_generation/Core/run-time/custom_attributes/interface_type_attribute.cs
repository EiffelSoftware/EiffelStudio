/*
indexing
	description: "Custom attributes to store associated interface of an Eiffel implementation class. Only used to get type of generic parameters and to perform conformance checking."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using ISE.Runtime.Enums;

namespace ISE.Runtime.CA
{

[CLSCompliant(false)]
[AttributeUsage (AttributeTargets.Class | AttributeTargets.Enum |
	AttributeTargets.Struct, AllowMultiple = false, Inherited = false)]
[Serializable]
public class INTERFACE_TYPE_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public INTERFACE_TYPE_ATTRIBUTE(Type type)
	{
		class_type = type;
	}

/*
feature -- Access
*/
	public Type class_type;
		// Type of class associated to Current.

}

} // class INTERFACE_TYPE_ATTRIBUTE
