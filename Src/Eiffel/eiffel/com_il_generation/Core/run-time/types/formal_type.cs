/*
indexing
	description: "Representation of an Eiffel type that is formal. I.e.
		its real type is only known at run-time."
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

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class RT_FORMAL_TYPE: RT_TYPE {
/*
feature -- Access
*/
	public Int32 position;
		// Formal position.

/*
feature -- Status report
*/
	public override RT_TYPE evaluated_type (RT_GENERIC_TYPE context_type)
		// Evaluate Current in context of `context_type'.
	{
			// Get type of formal in context of `a_current' object.
		return context_type.generics [position - 1];
	}

	public override bool has_formal ()
		// Does `Current' have a formal generic parameter?
	{
		return true;
	}

/*
feature -- Settings
*/
	public void set_position (Int32 pos)
		// Assign `pos' to `position'.
	{
		position = pos;
	}
}

}
