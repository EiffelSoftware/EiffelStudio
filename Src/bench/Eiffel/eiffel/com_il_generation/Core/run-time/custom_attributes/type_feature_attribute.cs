/*
indexing
	description: "Custom attributes to save name of feature that gives the current
		type of an attribute, when it is a formal or a generic."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace EiffelSoftware.Runtime.CA
{

[AttributeUsage (AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
[Serializable]
public class TYPE_FEATURE_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public TYPE_FEATURE_ATTRIBUTE(String a_feature_name)
	{
		feature_name = a_feature_name;
	}

/*
feature -- Access
*/
	public String feature_name;
		// Name of feature associated to current attribute.

}

} // class TYPE_FEATURE_ATTRIBUTE
