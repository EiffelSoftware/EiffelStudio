/*
indexing
	description: "Abstract representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
namespace ISE.Runtime {

[Serializable]
public class NONE_TYPE: CLASS_TYPE {

	public override String class_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		return "NONE";
	}
}

}
