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
			initialize_constants
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

feature -- Constants

	put_name_id: INTEGER is 1
	item_name_id: INTEGER is 2
	invariant_name_id: INTEGER is 3
	make_area_name_id: INTEGER is 4
	infix_at_name_id: INTEGER is 5
	set_area_name_id: INTEGER is 6
	area_name_id: INTEGER is 7
	lower_name_id: INTEGER is 8
	clone_name_id: INTEGER is 9
	set_count_name_id: INTEGER is 10
	make_name_id: INTEGER is 11
	to_c_name_id: INTEGER is 12
	set_rout_disp_name_id: INTEGER is 13
	default_create_name_id: INTEGER is 14
	default_rescue_name_id: INTEGER is 15
	dispose_name_id: INTEGER is 16
			-- Predefined name IDs constants
	
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

	initialize_constants is
			-- Initialize Current with predefined constants value
		do
			put ("put") check found_item = put_name_id end
			put ("item") check found_item = item_name_id end
			put ("invariant") check found_item = invariant_name_id end
			put ("make_area") check found_item = make_area_name_id end
			put ("_infix_@") check found_item = infix_at_name_id end
			put ("set_area") check found_item = set_area_name_id end
			put ("area") check found_item = area_name_id end
			put ("lower") check found_item = lower_name_id end
			put ("clone") check found_item = clone_name_id end
			put ("set_count") check found_item = set_count_name_id end
			put ("make") check found_item = make_name_id end
			put ("to_c") check found_item = to_c_name_id end
			put ("set_rout_disp") check found_item = set_rout_disp_name_id end
			put ("default_create") check found_item = default_create_name_id end
			put ("default_rescue") check found_item = default_rescue_name_id end
			put ("dispose") check found_item = dispose_name_id end
		end
		
invariant
	area_not_void: area /= Void
	lookup_table_not_void: lookup_table /= Void
	top_index_positive: top_index >= 0
	found_item_positive: found_item >= 0
	
end -- class NAMES_HEAP
