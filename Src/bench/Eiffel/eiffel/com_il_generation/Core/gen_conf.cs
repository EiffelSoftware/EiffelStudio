/*
indexing
	description: "Set of features needed during execution of an Eiffel system for
		a proper implementation of generic conformance."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace ISE.Runtime {

	public class EIFFEL_TYPE_INFO {
		public Type base_type;
				// Associated System.Type object to current Eiffel type.

		public Int32 base_id;
				// Associated ID for fast lookup of EIFFEL_TYPE_INFO.

		public Int32[] type_array;
				// Array describing current type completely.

		public static Int32 Formal_type_id = -32;
				// Starting ID of a generic formal parameter. For example,
				// -33 represents the first generic parameter, -34, the
				// second one and so on.

		public static Int32 Tuple_type_id = -15;
				// ID of a tuple.

		public static Int32 Like_arg_type_id = -11;
		public static Int32 Like_current_type_id = -12;
		public static Int32 Like_feature_type = -14;
				// IDs representing types anchored to some others.
	}

	[CLSCompliantAttribute (false)]
	public interface _EIFFEL_TYPE_INFO {
		int ____type_id();
		void ____set_type_id(Int32 type_id);
	}

	public class EIFFEL_TYPES {
		public static EIFFEL_TYPE_INFO [] eiffel_types;
			// List all computed Eiffel types.
	}

}
