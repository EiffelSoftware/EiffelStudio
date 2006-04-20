/*
indexing
	description: "Custom attributes to save real Eiffel class name in metadata."
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

namespace EiffelSoftware.Runtime.CA
{

[AttributeUsage (AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
[Serializable]
public class EIFFEL_NAME_ATTRIBUTE : Attribute
{
/*
feature -- Initialization
*/
	public EIFFEL_NAME_ATTRIBUTE(String a_name)
	{
		name = a_name;
		generics = null;
	}

	public EIFFEL_NAME_ATTRIBUTE(String a_name, Type [] a_generics)
	{
		name = a_name;
		generics = a_generics;
	}

/*
feature -- Access
*/
	public String name;
		// Name of class associated to Current.

	public Type [] generics;
		// Generic paramter if any.

	public bool is_generic ()
		// Is current class generic?
	{
		return (generics != null);
	}
}

} // class EIFFEL_NAME_ATTRIBUTE
