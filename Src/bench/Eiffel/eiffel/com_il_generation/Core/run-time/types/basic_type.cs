/*
indexing
	description: "Representation of an Eiffel basic type."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Collections;

namespace ISE.Runtime {

public class BASIC_TYPE: CLASS_TYPE {

/*
feature -- Access
*/
	public override bool is_basic ()
		// Does `Current' represent a basic type?
		// Yes.
	{
		return true;
	}

	public override String class_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		#if ASSERTIONS
			ASSERTIONS.CHECK ("Basic type inserted", Basic_type_names.Contains (type));
		#endif
		return (String) Basic_type_names [type];
	}

/*
feature {NONE} -- Implementation
*/
	private static Hashtable Basic_type_names
		// Association of RuntimeTypeHandle with their associated Eiffel names.
	{
		get {
			if (internal_basic_type_names == null) {
				internal_basic_type_names = new Hashtable (10);
				internal_basic_type_names.Add (Type.GetType ("System.Byte").TypeHandle, "INTEGER_8");
				internal_basic_type_names.Add (Type.GetType ("System.SByte").TypeHandle, "SByte");
				internal_basic_type_names.Add (Type.GetType ("System.Int16").TypeHandle, "INTEGER_16");
				internal_basic_type_names.Add (Type.GetType ("System.UInt16").TypeHandle, "UInt16");
				internal_basic_type_names.Add (Type.GetType ("System.Int32").TypeHandle, "INTEGER");
				internal_basic_type_names.Add (Type.GetType ("System.UInt32").TypeHandle, "UInt32");
				internal_basic_type_names.Add (Type.GetType ("System.Int64").TypeHandle, "INTEGER_64");
				internal_basic_type_names.Add (Type.GetType ("System.UInt64").TypeHandle, "UInt64");
				internal_basic_type_names.Add (Type.GetType ("System.Char").TypeHandle, "CHARACTER");
				internal_basic_type_names.Add (Type.GetType ("System.Boolean").TypeHandle, "BOOLEAN");
				internal_basic_type_names.Add (Type.GetType ("System.Double").TypeHandle, "DOUBLE");
				internal_basic_type_names.Add (Type.GetType ("System.Single").TypeHandle, "REAL");
				internal_basic_type_names.Add (Type.GetType ("System.IntPtr").TypeHandle, "POINTER");
			}
			return internal_basic_type_names;
		}
	}

/*
feature {NONE} -- Implementation
*/

	private static Hashtable internal_basic_type_names = null;
		// Place holder for `Basic_type_names'.

}

}
