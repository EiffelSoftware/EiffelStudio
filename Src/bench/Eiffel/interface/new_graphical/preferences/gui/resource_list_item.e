indexing
	description: "List item associated to a resource."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_LIST_ITEM

inherit
	EV_MULTI_COLUMN_LIST_ROW

create
	make_resource

feature {NONE} -- Initialization

	make_resource (res: RESOURCE) is
			-- Creation
		require
			resource_exists: res /= Void
		local
			s: STRING
			description: STRING
		do
			description := res.description
			if description /= Void and then not description.is_empty then
				s := clone (description)
			else
				s := clone (res.name)
				s.replace_substring_all ("_", " ")
			end
			s.prune_all ('%N')
			s.prune_all ('%T')
			s.prune_all ('%R')	
			default_create
			extend (s)
			extend (res.value)
			resource := res
		ensure
			resource_consistent: resource = res
		end
		
feature -- Access

	resource: RESOURCE
			-- Resource
			
	row_number: INTEGER
			-- Row number in the list.

feature -- Element change

	set_row_number (a_number: INTEGER) is
			-- Set `row_number' to `a_number'
		do
			row_number := a_number
		end
		

feature -- Basic operations

	update is
			-- Refresh Current's display according to its new value.
		local
			s: STRING
			description: STRING
		do
			description := resource.description
			if description /= Void and then not description.is_empty then
				s := clone (description)
			else
				s := clone (resource.name)
				s.replace_substring_all ("_", " ")
			end
			s.prune_all ('%N')
			s.prune_all ('%T')
			s.prune_all ('%R')
			wipe_out
			extend (s)
			extend (resource.value)
		end

invariant
	RESOURCE_LIST_ITEM_resource_exists: resource /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class RESOURCE_LIST_ITEM
