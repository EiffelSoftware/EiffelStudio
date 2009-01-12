indexing
	description: "[
		Input provider receiving input from a list of strings.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INPUT_LIST
	

inherit
	INPUT_PROVIDER

create
	make

feature -- Initialization

	make (a_list: LIST [like next])
			-- Initialize `Current'.
			--
			-- `a_list': List of input strings.
		do
			create items.make (a_list.count)
			a_list.do_all (agent items.force)
			items.go_i_th (0)
		ensure
			same_count: items.count = a_list.count
			same_items: items.for_all (agent a_list.has)
		end

feature -- Access

	next: STRING
			-- <Precursor>
		do
			Result := items.item_for_iteration
		ensure then
			result_is_current_item: Result.same_string (items.item_for_iteration)
		end

feature {NONE} -- Access

	items: ARRAYED_LIST [like next]
			-- List containing all inputs

feature -- Status report

	has_next: BOOLEAN
		do
			Result := not items.off
		ensure then
			result_implies_items_not_off: Result implies not items.off
		end

feature -- Basic functionality

	retrieve
			-- <Precursor>
		do
			if not items.after then
				items.forth
			end
		end

;indexing
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
