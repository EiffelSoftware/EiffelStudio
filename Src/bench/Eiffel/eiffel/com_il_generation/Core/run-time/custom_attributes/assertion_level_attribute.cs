/*
indexing
	description: "Custom attributes to save assertion levels for a given class type."
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
