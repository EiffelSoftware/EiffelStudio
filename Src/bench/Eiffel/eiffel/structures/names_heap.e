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
	
	PREDEFINED_NAMES
		
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

feature -- Convenience

	convert_to_string_array (t: ARRAY [INTEGER]): ARRAY [STRING] is
			-- Convert `t' an array of indexes in NAMES_HEAP into an
			-- array of STRINGs, each string being item of Current associated
			-- with current value in `t'.
		local
			i, nb: INTEGER
		do
			if t /= Void then
				create Result.make (t.lower, t.upper)
				from
					i := t.lower
					nb := t.upper
				until
					i > nb
				loop
					Result.put (item (t.item (i)), i)
					i := i + 1
				end
			end
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
			put ("_invariant") check found_item = internal_invariant_name_id end
			put ("void") check found_item = void_name_id end
			put ("EIF_REFERENCE") check found_item = eif_reference_name_id end
			put ("EIF_INTEGER_8") check found_item = eif_integer_8_name_id end
			put ("EIF_INTEGER_16") check found_item = eif_integer_16_name_id end
			put ("EIF_INTEGER_32") check found_item = eif_integer_32_name_id end
			put ("EIF_INTEGER_64") check found_item = eif_integer_64_name_id end
			put ("EIF_CHARACTER") check found_item = eif_char_name_id end
			put ("EIF_WIDE_CHAR") check found_item = eif_wide_char_name_id end
			put ("EIF_BOLLEAN") check found_item = eif_boolean_name_id end
			put ("EIF_POINTER") check found_item = eif_pointer_name_id end
			put ("EIF_REAL") check found_item = eif_real_name_id end
			put ("EIF_DOUBLE") check found_item = eif_double_name_id end
			put ("%"eif_plug.h%"") check found_item = eif_plug_header_name_id end
			put ("%"eif_misc.h%"") check found_item = eif_misc_header_name_id end
			put ("%"eif_out.h%"") check found_item = eif_out_header_name_id end
			put ("<string.h>") check found_item = string_header_name_id end
			put ("<math.h>") check found_item = math_header_name_id end
			put ("count") check found_item = count_name_id end
			put ("upper") check found_item = upper_name_id end
			put ("all_default") check found_item = all_default_name_id end
			put ("clear_all") check found_item = clear_all_name_id end
			put ("index_of") check found_item = index_of_name_id end
			put ("resized_area") check found_item = resized_area_name_id end
			put ("same_items") check found_item = same_items_name_id end
			put ("is_equal") check found_item = is_equal_name_id end
			put ("standard_is_equal") check found_item = standard_is_equal_name_id end
			put ("deep_equal") check found_item = deep_equal_name_id end
			put ("standard_deep_equal") check found_item = standard_deep_equal_name_id end
			put ("out") check found_item = out_name_id end
			put ("hash_code") check found_item = hash_code_name_id end
			put ("max") check found_item = max_name_id end
			put ("min") check found_item = min_name_id end
			put ("abs") check found_item = abs_name_id end
			put ("zero") check found_item = zero_name_id end
			put ("one") check found_item = one_name_id end
			put ("generator") check found_item = generator_name_id end
			put ("generating_type") check found_item = generating_type_name_id end
			put ("to_integer_8") check found_item = to_integer_8_name_id end
			put ("to_integer_16") check found_item = to_integer_16_name_id end
			put ("to_integer_32") check found_item = to_integer_32_name_id end
			put ("to_integer_64") check found_item = to_integer_64_name_id end
			put ("_infix_plus") check found_item = infix_plus_name_id end
			put ("default") check found_item = default_name_id end
			put ("bit_and") check found_item = bit_and_name_id end
			put ("_infix_&") check found_item = infix_and_name_id end
			put ("bit_or") check found_item = bit_or_name_id end
			put ("_infix_|") check found_item = infix_or_name_id end
			put ("bit_xor") check found_item = bit_xor_name_id end
			put ("bit_not") check found_item = bit_not_name_id end
			put ("bit_shift_left") check found_item = bit_shift_left_name_id end
			put ("_infix_|<<") check found_item = infix_shift_left_name_id end
			put ("bit_shift_right") check found_item = bit_shift_right_name_id end
			put ("_infix_|>>") check found_item = infix_shift_right_name_id end
			put ("bit_test") check found_item = bit_test_name_id end
			put ("memory_copy") check found_item = memory_copy_name_id end
			put ("memory_move") check found_item = memory_move_name_id end
			put ("memory_set") check found_item = memory_set_name_id end
			put ("truncated_to_integer") check found_item = truncated_to_integer_name_id end
			put ("set_item") check found_item = set_item_name_id end
			put ("copy") check found_item = copy_name_id end
			put ("deep_copy") check found_item = deep_copy_name_id end
			put ("standard_copy") check found_item = standard_copy_name_id end
			put ("standard_clone") check found_item = standard_clone_name_id end
			put ("make_from_cil") check found_item = make_from_cil_name_id end
			put ("equal") check found_item = equal_name_id end
			put ("truncated_to_real") check found_item = truncated_to_real_name_id end
			put ("code") check found_item = code_name_id end
			put ("to_integer") check found_item = to_integer_name_id end
			put ("to_character") check found_item = to_character_name_id end
			put ("ascii_char") check found_item = ascii_char_name_id end
			put ("internal_clone") check found_item = internal_clone_name_id end
			put ("internal_copy") check found_item = internal_copy_name_id end
			put ("put_value_at") check found_item = put_value_at_name_id end
		end
		
invariant
	area_not_void: area /= Void
	lookup_table_not_void: lookup_table /= Void
	top_index_positive: top_index >= 0
	found_item_positive: found_item >= 0
	
end -- class NAMES_HEAP
