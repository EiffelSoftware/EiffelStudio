/*
indexing
	description: "Representation of an Eiffel basic type."
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
using System.Collections;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class RT_BASIC_TYPE: RT_CLASS_TYPE {

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
				internal_basic_type_names.Add (typeof(System.Byte).TypeHandle, "NATURAL_8");
				internal_basic_type_names.Add (typeof(System.SByte).TypeHandle, "INTEGER_8");
				internal_basic_type_names.Add (typeof(System.Int16).TypeHandle, "INTEGER_16");
				internal_basic_type_names.Add (typeof(System.UInt16).TypeHandle, "NATURAL_16");
				internal_basic_type_names.Add (typeof(System.Int32).TypeHandle, "INTEGER");
				internal_basic_type_names.Add (typeof(System.UInt32).TypeHandle, "NATURAL_32");
				internal_basic_type_names.Add (typeof(System.Int64).TypeHandle, "INTEGER_64");
				internal_basic_type_names.Add (typeof(System.UInt64).TypeHandle, "NATURAL_64");
				internal_basic_type_names.Add (typeof(System.Char).TypeHandle, "CHARACTER");
				internal_basic_type_names.Add (typeof(System.Boolean).TypeHandle, "BOOLEAN");
				internal_basic_type_names.Add (typeof(System.Double).TypeHandle, "DOUBLE");
				internal_basic_type_names.Add (typeof(System.Single).TypeHandle, "REAL");
				internal_basic_type_names.Add (typeof(System.IntPtr).TypeHandle, "POINTER");
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
