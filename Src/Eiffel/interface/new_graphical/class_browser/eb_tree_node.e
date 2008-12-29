note
	description: "Object that represents a tree node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TREE_NODE [G]

feature -- Access

	data: G assign set_data
			-- data included in current

	children: DS_ARRAYED_LIST [EB_TREE_NODE [G]]
			-- Children nodes of current	
		do
			if children_internal = Void then
				create children_internal.make (64)
			end
			Result := children_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_data (a_data: like data)
			-- Set `data' with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature{NONE} -- Implementation

	children_internal: like children
			-- Implementation of `children'

invariant
	children_attached: children /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
