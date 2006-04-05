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
	PREDEFINED_NAMES

create {SYSTEM_I, SHARED_NAMES_HEAP}
	make

feature {NONE} -- Initialization

	make is
			-- Create new instance of NAMES_HEAP
		do
			top_index := 1
			create area.make (Chunk)
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

	area: SPECIAL [STRING]
			-- Store string names indexed by their ID.

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
			put ("infix %"@%"") check found_item = infix_at_name_id end
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
			put ("internal_argument_array") check found_item = internal_argument_array_name_id end
			put ("to_natural_8") check found_item = to_natural_8_name_id end
			put ("to_natural_16") check found_item = to_natural_16_name_id end
			put ("to_natural_32") check found_item = to_natural_32_name_id end
			put ("to_natural_64") check found_item = to_natural_64_name_id end
			put ("as_natural_8") check found_item = as_natural_8_name_id end
			put ("as_natural_16") check found_item = as_natural_16_name_id end
			put ("as_natural_32") check found_item = as_natural_32_name_id end
			put ("as_natural_64") check found_item = as_natural_64_name_id end
			put ("as_integer_8") check found_item = as_integer_8_name_id end
			put ("as_integer_16") check found_item = as_integer_16_name_id end
			put ("as_integer_32") check found_item = as_integer_32_name_id end
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
			put ("deep_twin") check found_item = deep_twin_name_id end
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
			put ("infix %"+%"") check found_item = infix_plus_name_id end
			put ("default") check found_item = default_name_id end
			put ("bit_and") check found_item = bit_and_name_id end
			put ("infix %"&%"") check found_item = infix_and_name_id end
			put ("bit_or") check found_item = bit_or_name_id end
			put ("infix %"|%"") check found_item = infix_or_name_id end
			put ("bit_xor") check found_item = bit_xor_name_id end
			put ("bit_not") check found_item = bit_not_name_id end
			put ("bit_shift_left") check found_item = bit_shift_left_name_id end
			put ("infix %"|<<%"") check found_item = infix_shift_left_name_id end
			put ("bit_shift_right") check found_item = bit_shift_right_name_id end
			put ("infix %"|>>%"") check found_item = infix_shift_right_name_id end
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
			put ("standard_twin") check found_item = standard_twin_name_id end
			put ("internal_copy") check found_item = internal_copy_name_id end
			put ("put_value_at") check found_item = put_value_at_name_id end
			put ("set_bit_with_mask") check found_item = set_bit_with_mask_name_id end
			put ("memory_alloc") check found_item = memory_alloc_name_id end
			put ("memory_free") check found_item = memory_free_name_id end
			put ("from_integer") check found_item = from_integer_name_id end
			put ("finalize") check found_item = finalize_name_id end
			put ("%"eif_helpers.h%"") check found_item = eif_helpers_header_name_id end
			put ("internal_native_array") check found_item = internal_native_array_name_id end
			put ("to_string") check found_item = to_string_name_id end
			put ("to_cil") check found_item = to_cil_name_id end
			put ("is_digit") check found_item = is_digit_name_id end
			put ("internal_correct_mismatch") check found_item = internal_correct_mismatch_name_id end
			put ("memory_calloc") check found_item = memory_calloc_name_id end
			put ("internal_hash_code") check found_item = internal_hash_code_name_id end
			put ("base_address") check found_item = base_address_name_id end
			put ("item_address") check found_item = item_address_name_id end
			put ("to_double") check found_item = to_double_name_id end
			put ("to_real") check found_item = to_real_name_id end
			put ("conforms_to") check found_item = conforms_to_name_id end
			put ("deep_clone") check found_item = deep_clone_name_id end
			put ("default_pointer") check found_item = default_pointer_name_id end
			put ("do_nothing") check found_item = do_nothing_name_id end
			put ("io") check found_item = io_name_id end
			put ("operating_environment") check found_item = operating_environment_name_id end
			put ("print") check found_item = print_name_id end
			put ("same_type") check found_item = same_type_name_id end
			put ("standard_equal") check found_item = standard_equal_name_id end
			put ("tagged_out") check found_item = tagged_out_name_id end
			put ("to_dotnet") check found_item = to_dotnet_name_id end
			put ("twin") check found_item = twin_name_id end
			put ("System.String") check found_item = system_string_name_id end
			put ("System.Object") check found_item = system_object_name_id end
			put ("System.Boolean") check found_item = system_boolean_name_id end
			put ("get_hash_code") check found_item = get_hash_code_name_id end
			put ("equals") check found_item = equals_name_id end
			put ("three_way_comparison") check found_item = three_way_comparison_name_id end
			put ("<ctype.h>") check found_item = ctype_header_name_id end
			put ("as_integer_64") check found_item = as_integer_64_name_id end
			put ("to_real_32") check found_item = to_real_32_name_id end
			put ("to_real_64") check found_item = to_real_64_name_id end
			put ("is_lower") check found_item = is_lower_name_id end
			put ("is_upper") check found_item = is_upper_name_id end
			put ("set_bit") check found_item = set_bit_name_id end
			put ("infix %"and then%"") check found_item = infix_and_then_name_id end
			put ("infix %"or else%"") check found_item = infix_or_else_name_id end
			put ("infix %"implies%"") check found_item = infix_implies_name_id end
			put ("as_lower") check found_item = as_lower_name_id end
			put ("as_upper") check found_item = as_upper_name_id end
			put ("is_space") check found_item = is_space_name_id end
			put ("copy_data") check found_item = copy_data_name_id end
			put ("move_data") check found_item = move_data_name_id end
			put ("overlapping_move") check found_item = overlapping_move_name_id end
			put ("non_overlapping_move") check found_item = non_overlapping_move_name_id end
			put ("[]") check found_item = bracket_symbol_id end
			put ("to_character_8") check found_item = to_character_8_name_id end
			put ("to_character_32") check found_item = to_character_32_name_id end
			put ("natural_32_code") check found_item = natural_32_code_name_id end
		end

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
