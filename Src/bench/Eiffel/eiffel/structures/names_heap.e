indexing
	description: "[
		Correspondance between names and integers.
		The structure is very efficient for accessing from an integer
		the corresponding name. However the contrary is not as efficient
		(lookup through HASH_TABLE). It should be used
		if more access to names are done, than name insertions.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	NAMES_HEAP

inherit
	TO_SPECIAL [STRING]
		export
			{NONE} all
		end
		
create {SYSTEM_I}
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
			Result_not_void: Result /= Void
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
			Result := i > 0 and then i < top_index
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

feature -- Element change

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
	
end -- class NAMES_HEAP
