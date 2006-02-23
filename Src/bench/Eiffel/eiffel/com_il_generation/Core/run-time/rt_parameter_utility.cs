/*
indexing
	description: "Set of features for setting out arguments in Eiffel."
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

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
