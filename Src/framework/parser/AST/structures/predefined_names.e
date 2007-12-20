indexing
	description: "Predefined constants for use in NAMES_HEAP"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREDEFINED_NAMES

feature -- Constants

		-- Predefined name IDs constants
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
	internal_invariant_name_id: INTEGER is 17
	internal_argument_array_name_id: INTEGER is 18
	to_natural_8_name_id: INTEGER is 19
	to_natural_16_name_id: INTEGER is 20
	to_natural_32_name_id: INTEGER is 21
	to_natural_64_name_id: INTEGER is 22
	as_natural_8_name_id: INTEGER is 23
	as_natural_16_name_id: INTEGER is 24
	as_natural_32_name_id: INTEGER is 25
	as_natural_64_name_id: INTEGER is 26
	as_integer_8_name_id: INTEGER is 27
	as_integer_16_name_id: INTEGER is 28
	as_integer_32_name_id: INTEGER is 29
	eif_plug_header_name_id: INTEGER is 30
	eif_misc_header_name_id: INTEGER is 31
	eif_out_header_name_id: INTEGER is 32
	string_header_name_id: INTEGER is 33
	math_header_name_id: INTEGER is 34
	count_name_id: INTEGER is 35
	upper_name_id: INTEGER is 36
	all_default_name_id: INTEGER is 37
	clear_all_name_id: INTEGER is 38
	index_of_name_id: INTEGER is 39
	resized_area_name_id: INTEGER is 40
	same_items_name_id: INTEGER is 41
	is_equal_name_id: INTEGER is 42
	standard_is_equal_name_id: INTEGER is 43
	deep_equal_name_id: INTEGER is 44
	deep_twin_name_id: INTEGER is 45
	out_name_id: INTEGER is 46
	hash_code_name_id: INTEGER is 47
	max_name_id: INTEGER is 48
	min_name_id: INTEGER is 49
	abs_name_id: INTEGER is 50
	zero_name_id: INTEGER is 51
	one_name_id: INTEGER is 52
	generator_name_id: INTEGER is 53
	generating_type_name_id: INTEGER is 54
	to_integer_8_name_id: INTEGER is 55
	to_integer_16_name_id: INTEGER is 56
	to_integer_32_name_id: INTEGER is 57
	to_integer_64_name_id: INTEGER is 58
	infix_plus_name_id: INTEGER is 59
	default_name_id: INTEGER is 60
	bit_and_name_id: INTEGER is 61
	infix_and_name_id: INTEGER is 62
	bit_or_name_id: INTEGER is 63
	infix_or_name_id: INTEGER is 64
	bit_xor_name_id: INTEGER is 65
	bit_not_name_id: INTEGER is 66
	bit_shift_left_name_id: INTEGER is 67
	infix_shift_left_name_id: INTEGER is 68
	bit_shift_right_name_id: INTEGER is 69
	infix_shift_right_name_id: INTEGER is 70
	bit_test_name_id: INTEGER is 71
	memory_copy_name_id: INTEGER is 72
	memory_move_name_id: INTEGER is 73
	memory_set_name_id: INTEGER is 74
	truncated_to_integer_name_id: INTEGER is 75
	set_item_name_id: INTEGER is 76
	copy_name_id: INTEGER is 77
	deep_copy_name_id: INTEGER is 78
	standard_copy_name_id: INTEGER is 79
	standard_clone_name_id: INTEGER is 80
	make_from_cil_name_id: INTEGER is 81
	equal_name_id: INTEGER is 82
	truncated_to_real_name_id: INTEGER is 83
	code_name_id: INTEGER is 84
	to_integer_name_id: INTEGER is 85
	to_character_name_id: INTEGER is 86
	ascii_char_name_id: INTEGER is 87
	standard_twin_name_id: INTEGER is 88
	internal_copy_name_id: INTEGER is 89
	put_value_at_name_id: INTEGER is 90
	set_bit_with_mask_name_id: INTEGER is 91
	memory_alloc_name_id: INTEGER is 92
	memory_free_name_id: INTEGER is 93
	from_integer_name_id: INTEGER is 94
	finalize_name_id: INTEGER is 95
	eif_helpers_header_name_id: INTEGER is 96
	internal_native_array_name_id: INTEGER is 97
	to_string_name_id: INTEGER is 98
	to_cil_name_id: INTEGER is 99
	is_digit_name_id: INTEGER is 100
	internal_correct_mismatch_name_id: INTEGER is 101
	memory_calloc_name_id: INTEGER is 102
	internal_hash_code_name_id: INTEGER is 103
	base_address_name_id: INTEGER is 104
	item_address_name_id: INTEGER is 105
	to_double_name_id: INTEGER is 106
	to_real_name_id: INTEGER is 107
	conforms_to_name_id: INTEGER is 108
	deep_clone_name_id: INTEGER is 109
	default_pointer_name_id: INTEGER is 110
	do_nothing_name_id: INTEGER is 111
	io_name_id: INTEGER is 112
	operating_environment_name_id: INTEGER is 113
	print_name_id: INTEGER is 114
	same_type_name_id: INTEGER is 115
	standard_equal_name_id: INTEGER is 116
	tagged_out_name_id: INTEGER is 117
	to_dotnet_name_id: INTEGER is 118
	twin_name_id: INTEGER is 119
	system_string_name_id: INTEGER is 120
	system_object_name_id: INTEGER is 121
	system_boolean_name_id: INTEGER is 122
	get_hash_code_name_id: INTEGER is 123
	equals_name_id: INTEGER is 124
	three_way_comparison_name_id: INTEGER is 125
	ctype_header_name_id: INTEGER is 126
	as_integer_64_name_id: INTEGER is 127
	to_real_32_name_id: INTEGER is 128
	to_real_64_name_id: INTEGER is 129
	is_lower_name_id: INTEGER is 130
	is_upper_name_id: INTEGER is 131
	set_bit_name_id: INTEGER is 132
	infix_and_then_name_id: INTEGER is 133
	infix_or_else_name_id: INTEGER is 134
	infix_implies_name_id: INTEGER is 135
	as_lower_name_id: INTEGER is 136
	as_upper_name_id: INTEGER is 137
	is_space_name_id: INTEGER is 138
	copy_data_name_id: INTEGER is 139
	move_data_name_id: INTEGER is 140
	overlapping_move_name_id: INTEGER is 141
	non_overlapping_move_name_id: INTEGER is 142
	bracket_symbol_id: INTEGER is 143
	to_character_8_name_id: INTEGER is 144
	to_character_32_name_id: INTEGER is 145
	natural_32_code_name_id: INTEGER is 146
	rout_disp_name_id: INTEGER is 147
	calc_rout_addr_name_id: INTEGER is 148
	closed_operands_name_id: INTEGER is 149
	last_result_name_id: INTEGER is 150
	class_id_name_id: INTEGER is 151
	feature_id_name_id: INTEGER is 152
	is_precompiled_name_id: INTEGER is 153
	is_basic_name_id: INTEGER is 154
	open_map_name_id: INTEGER is 155
	open_count_name_id: INTEGER is 156
	closed_count_name_id: INTEGER is 157
	encaps_rout_disp_name_id: INTEGER is 158
	fake_inline_agent_target_name_id: INTEGER is 159
	fake_inline_agent_name_name_id: INTEGER is 160
	callable_name_id: INTEGER is 161
	valid_operands_name_id: INTEGER is 162
	set_rout_disp_final_name_id: INTEGER is 163
	to_pointer_name_id: INTEGER is 164
	none_class_name_id: INTEGER is 165
	precursor_name_id: INTEGER is 166
	fast_item_name_id: INTEGER is 167
	pointer_item_name_id: INTEGER is 168
	eif_built_in_header_name_id: INTEGER is 169
	truncated_to_integer_64_name_id: INTEGER is 170
	ceiling_real_32_name_id: INTEGER is 171
	ceiling_real_64_name_id: INTEGER is 172
	floor_real_32_name_id: INTEGER is 173
	floor_real_64_name_id: INTEGER is 174
	is_deep_equal_name_id: INTEGER is 175
	set_exception_data_name_id: INTEGER is 176
	last_exception_name_id: INTEGER is 177
	set_last_exception_name_id: INTEGER is 178
	is_code_ignored_name_id: INTEGER is 179
	once_raise_name_id: INTEGER is 180
	notify_name_id: INTEGER is 181
	notify_argument_name_id: INTEGER is 182
	init_exception_manager_id: INTEGER is 183
	free_preallocated_trace_id: INTEGER is 184
	any_name_id: INTEGER is 185

feature -- Classification

	is_semi_strict_id (name_id: INTEGER): BOOLEAN is
			-- Does `name_id' denote a semistrict operator?
		do
			inspect name_id
			when infix_and_then_name_id, infix_or_else_name_id, infix_implies_name_id then
				Result := True
			else
					-- False by default
			end
		ensure
			definition: Result = (name_id = infix_and_then_name_id or name_id = infix_or_else_name_id or name_id = infix_implies_name_id)
		end

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

end -- class PREDEFINED_NAMES
