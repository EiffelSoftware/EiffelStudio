indexing
	description: "[
		Correspondance between names and integers.
		The structure is very efficient for accessing from an integer
		the corresponding name. However the contrary is not as efficient
		(lookup through HASH_TABLE). It should be used
		if more access to names are done, than name insertions.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NAMES_HEAP

inherit
	TO_SPECIAL [STRING]
		rename
			put as area_put,
			valid_index as area_valid_index,
			item as area_item,
			infix "@" as area_infix_at
		export
			{NONE} all
		end
		
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create new instance of NAMES_HEAP
		do
			top_index := 1
			make_area (Chunk)
			create lookup_table.make (Chunk)
		end
		
feature -- Access

	item (i: INTEGER): STRING is
			-- Access `i'-th element.
		require
			valid_index: valid_index (i)
		do
			Result := area.item (i)
		ensure
			Result_not_void: i > 0 implies Result /= Void
			Result_void: i = 0 implies Result = Void
		end

	found_item: INTEGER
			-- Index of last element inserted by call to `put'.

	found: BOOLEAN
			-- Has last search been successful?

	id_of (s: STRING): INTEGER is
			-- Id of `s' if inserted, otherwise 0.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			lookup_table.search (s)
			if lookup_table.found then
				Result := lookup_table.found_item
				check
					valid_result: Result > 0
				end
			end
		ensure
			valid_result: Result >= 0
		end

	has (s: STRING): BOOLEAN is
			-- Does current have `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			search (s)
			Result := found
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within bounds?
		do
			Result := i >= 0 and then i < top_index
		end

	search (s: STRING) is
			-- Search for `s' in Current.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			lookup_table.search (s)
			found := lookup_table.found
			if found then
				found_item := lookup_table.found_item
			end
		end

feature -- Element Change

	put (s: STRING) is
			-- Insert `s' in Current if not present,
			-- otherwise does nothing.
			-- In both cases, `found_item' is updated
			-- to location in Current.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			lookup_table.search (s)
			if lookup_table.found then
				found_item := lookup_table.found_item
			else
				found_item := top_index
				if area.count <= top_index then
					area := area.resized_area (top_index + (top_index // 2).max (Chunk))
				end
				area.put (s, top_index)
				lookup_table.put (top_index, s)
				top_index := top_index + 1
			end
		ensure
			elemented_inserted: equal (item (found_item), s)
		end

feature {NONE} -- Implementation: access

	lookup_table: HASH_TABLE [INTEGER, STRING]
			-- Hash-table indexed by string names
			-- Values are indexes of Current to access corresponding
			-- key in an efficient manner.
			
	top_index: INTEGER
			-- Number of elements in Current
	
	Chunk: INTEGER is 500
			-- Default chunk size.
			
invariant
	area_not_void: area /= Void
	lookup_table_not_void: lookup_table /= Void
	top_index_positive: top_index >= 0
	found_item_positive: found_item >= 0
	
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
end -- class NAMES_HEAP
