/*
indexing
	description: "Set of features for setting out arguments in Eiffel."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace EiffelSoftware.Runtime
{

	public class RT_PARAMETER_UTILITY
	{
		public static void set_out_argument (out object argument, object val)
			// Set SYSTEM_OBJECT out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out System.IntPtr argument, System.IntPtr val)
			// Set POINTER out argument.
		{
			argument = val;
		}

		// NOT YET SUPPORTED
//		public static void set_out_argument (out System.UIntPtr argument, System.UIntPtr val)
//			// Set POINTER out argument.
//		{
//			argument = val;
//		}

		public static void set_out_argument (out bool argument, bool val)
			// Set NATURAL_8 out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out byte argument, byte val)
			// Set INTEGER_8 out argument.
		{
			argument = val;
		}

		[CLSCompliant (false)]
		public static void set_out_argument (out ushort argument, ushort val)
			// Set NATURAL_16 out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out short argument, short val)
			// Set INTEGER_16 out argument.
		{
			argument = val;
		}

		[CLSCompliant (false)]
		public static void set_out_argument (out uint argument, uint val)
			// Set NATURAL_32 out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out int argument, int val)
			// Set INTEGER out argument.
		{
			argument = val;
		}

		[CLSCompliant (false)]
		public static void set_out_argument (out ulong argument, ulong val)
			// Set NATURAL_64 out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out long argument, long val)
			// Set INTEGER_64 out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out string argument, string val)
			// Set SYSTEM_STRING out argument.
		{
			argument = val;
		}

		public static void set_out_argument (out Guid argument, Guid val)
			// Set GUID out argument.
		{
			argument = val;
		}

	}// class RT_PARAMETER_UTILITY

}// namespace EiffelSoftware.Runtime
