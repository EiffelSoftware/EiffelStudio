indexing
	description: "Items for EB_GRID_LISTABLE_CHOICE_ITEM"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_LISTABLE_CHOICE_ITEM_ITEM

create
	make

feature	{NONE} -- Initialization

	make (a_item: !like item_components) is
			-- Initialization
		do
			item_components := a_item
		ensure
			item_components_set: item_components = a_item
		end

feature -- Element change

	set_data (a_data: like data) is
			-- Set `data' with `a_data'
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature -- Access

	item_components: !ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]
			-- Components of the item

	data: ?ANY;
			-- Associated data

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
