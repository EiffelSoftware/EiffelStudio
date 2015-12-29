note
	description: "Collection of IRON node package."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_PACKAGE_COLLECTION

inherit
	ITERABLE [IRON_NODE_PACKAGE]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	count: INTEGER
			-- Number of versions.
		do
			Result := items.count
		end

	items: ARRAYED_LIST [IRON_NODE_PACKAGE]

	new_cursor: ITERATION_CURSOR [IRON_NODE_PACKAGE]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Element change

	force, put (v: IRON_NODE_PACKAGE)
		do
			items.force (v)
		end

feature -- Sorting

	sort
			-- Sort alphabetically, older first.
		local
			s: QUICK_SORTER [IRON_NODE_PACKAGE]
		do
			create s.make (create {COMPARABLE_COMPARATOR [IRON_NODE_PACKAGE]})
			s.sort (items)
		end

	reverse_sort
			-- Sort alphabetically, latest first.
		local
			s: QUICK_SORTER [IRON_NODE_PACKAGE]
		do
			create s.make (create {COMPARABLE_COMPARATOR [IRON_NODE_PACKAGE]})
			s.reverse_sort (items)
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
