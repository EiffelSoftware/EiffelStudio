/*
indexing
	description: "Ancestor class for calling agents."
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

namespace EiffelSoftware.Runtime {

public class AGENT_PROXY {
/*
feature -- Basic operations
*/
	public virtual void call (object agent, object[] open_operands)
			// Call associated routine `agent' with open arguments `open_operands'.
	{
		#if ASSERTIONS
			ASSERTIONS.CHECK ("open_operands_not_void", open_operands != null);
		#endif
	}

/*
feature -- Access
*/

	public object last_result;
			// Last result of a function call

	public object item (object agent, object[] open_operands)
			// Call associated routine `agent' with open arguments `open_operands'.
	{
		#if ASSERTIONS
			ASSERTIONS.CHECK ("open_operands_not_void", open_operands != null);
		#endif
		call (agent, open_operands);
		return last_result;
	}

/*
feature -- Settings
*/

	public virtual void set_closed_arguments (object [] closed_arguments)
			// Set current object with `closed_arguments'.
	{
	}
}
}


