indexing
	description: "Generic cache implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE [G, H->HASHABLE]

create
	make

feature {NONE} -- Initialization

	make (c: INTEGER) is
			-- Set `capacity' with `c'.
		require
			valid_capacity: c > 0
		do
			capacity := c
			create internal_table.make (c)
			create history.make (c)
		ensure
			capacity_set: capacity = c
		end

feature -- Access

	capacity: INTEGER
		-- Maximum number of elements in cache

	count: INTEGER
		-- Number of elements in cache

	found_item: G is
			-- Last found item
		do
			Result := internal_table.found_item
		end
		
feature -- Status Report

	found: BOOLEAN is
			-- Was last search successful?
		do
			Result := internal_table.found
		end

feature -- Element Settings

	put (g: G; h: H) is
			-- Add item `g' to cache with key `h'.
		require
			non_void_item: g /= Void
			non_void_key: h /= Void
		do
			if history.count = capacity then
				internal_table.remove (history.item)
				history.remove
			end
			history.put (h)
			internal_table.put (g, h)
		ensure
			put: internal_table.has (h) and then internal_table.item (h) = g
		end
		
feature -- Basic Operations

	search (h: H) is
			-- Search for `h' in cache.
			-- Set `found' to True if found.
			-- Set `found_item' with found item if any.
		require
			valid_key: h /= Void
		do
			internal_table.search (h)
		end
		
feature {NONE} -- Implementation

	internal_table: HASH_TABLE [G, H]
			-- Internal table which holds items in cache

	history: ARRAYED_QUEUE [H]
			-- History of inserted items

invariant
	non_void_internal_table: internal_table /= Void
	non_void_history: history /= Void
	count_not_greater_than_capacity: internal_table.count <= capacity
	valid_history_count: history.count <= capacity

indexing
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


end -- class CACHE
