note
	description: "[
	 	Captured Eiffel object defined through a number of items. This is currently used for {TUPLE} or
	 	    {SPECIAL} objects.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURED_ITEM_OBJECT

inherit
	TEST_CAPTURED_OBJECT
		redefine
			has_items,
			items
		end

create
	make

feature {NONE} -- Initialization

	make (a_id: like id; a_type: like type; a_count: INTEGER)
			-- Initialize `Current'.
			--
			-- `a_id': Identifier for object.
			-- `a_type': Full type name of captured object
			-- `a_count': Expected number of items
		do
			make_object (a_id, a_type)
			create {attached DS_ARRAYED_LIST [attached STRING]} items.make (a_count)
		end

feature -- Access

	items: attached DS_LIST [attached STRING]

feature -- Status report

	has_items: BOOLEAN = True
			-- <Precursor>

note
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
