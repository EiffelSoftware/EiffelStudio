/*
indexing
	description: "Custom attributes to save assertion levels for a given class type."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using EiffelSoftware.Runtime.CA;
using EiffelSoftware.Runtime.Enums;

namespace EiffelSoftware.Runtime.CA
{

[CLSCompliantAttribute (false)]
[AttributeUsage (AttributeTargets.Assembly, AllowMultiple = true, Inherited = false)]
[Serializable]
public class ASSERTION_LEVEL_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public ASSERTION_LEVEL_ATTRIBUTE(Type type, ASSERTION_LEVEL_ENUM level)
	{
		class_type = type;
		assertion_level = level;
	}

/*
feature -- Access
*/
	public Type class_type;
		// Type of class associated to Current.

	public ASSERTION_LEVEL_ENUM assertion_level;
		// Current level of assertion for Current.
}

} // class ASSERTION_LEVEL_ATTRIBUTE
