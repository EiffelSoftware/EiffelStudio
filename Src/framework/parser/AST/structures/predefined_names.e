note
	description: "Predefined constants for use in NAMES_HEAP"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREDEFINED_NAMES

feature -- Constants

		-- Predefined name IDs constants
	put_name_id: INTEGER = 1
	item_name_id: INTEGER = 2
	invariant_name_id: INTEGER = 3
	make_area_name_id: INTEGER = 4
	at_name_id: INTEGER = 5
	infix_at_name_id: INTEGER = 6
	set_area_name_id: INTEGER = 7
	area_name_id: INTEGER = 8
	lower_name_id: INTEGER = 9
	clone_name_id: INTEGER = 10
	set_count_name_id: INTEGER = 11
	make_name_id: INTEGER = 12
	to_c_name_id: INTEGER = 13
	set_rout_disp_name_id: INTEGER = 14
	default_create_name_id: INTEGER = 15
	default_rescue_name_id: INTEGER = 16
	dispose_name_id: INTEGER = 17
	internal_invariant_name_id: INTEGER = 18
	internal_argument_array_name_id: INTEGER = 19
	to_natural_8_name_id: INTEGER = 20
	to_natural_16_name_id: INTEGER = 21
	to_natural_32_name_id: INTEGER = 22
	to_natural_64_name_id: INTEGER = 23
	as_natural_8_name_id: INTEGER = 24
	as_natural_16_name_id: INTEGER = 25
	as_natural_32_name_id: INTEGER = 26
	as_natural_64_name_id: INTEGER = 27
	as_integer_8_name_id: INTEGER = 28
	as_integer_16_name_id: INTEGER = 29
	as_integer_32_name_id: INTEGER = 30
	eif_plug_header_name_id: INTEGER = 31
	eif_misc_header_name_id: INTEGER = 32
	eif_out_header_name_id: INTEGER = 33
	string_header_name_id: INTEGER = 34
	math_header_name_id: INTEGER = 35
	count_name_id: INTEGER = 36
	upper_name_id: INTEGER = 37
	all_default_name_id: INTEGER = 38
	clear_all_name_id: INTEGER = 39
	index_of_name_id: INTEGER = 40
	resized_area_name_id: INTEGER = 41
	same_items_name_id: INTEGER = 42
	is_equal_name_id: INTEGER = 43
	standard_is_equal_name_id: INTEGER = 44
	deep_equal_name_id: INTEGER = 45
	deep_twin_name_id: INTEGER = 46
	out_name_id: INTEGER = 47
	hash_code_name_id: INTEGER = 48
	max_name_id: INTEGER = 49
	min_name_id: INTEGER = 50
	abs_name_id: INTEGER = 51
	zero_name_id: INTEGER = 52
	one_name_id: INTEGER = 53
	generator_name_id: INTEGER = 54
	generating_type_name_id: INTEGER = 55
	to_integer_8_name_id: INTEGER = 56
	to_integer_16_name_id: INTEGER = 57
	to_integer_32_name_id: INTEGER = 58
	to_integer_64_name_id: INTEGER = 59
	plus_name_id: INTEGER = 60
	infix_plus_name_id: INTEGER = 61
	default_name_id: INTEGER = 62
	bit_and_name_id: INTEGER = 63
	infix_bit_and_name_id: INTEGER = 64
	bit_or_name_id: INTEGER = 65
	infix_bit_or_name_id: INTEGER = 66
	bit_xor_name_id: INTEGER = 67
	bit_not_name_id: INTEGER = 68
	bit_shift_left_name_id: INTEGER = 69
	infix_shift_left_name_id: INTEGER = 70
	bit_shift_right_name_id: INTEGER = 71
	infix_shift_right_name_id: INTEGER = 72
	bit_test_name_id: INTEGER = 73
	memory_copy_name_id: INTEGER = 74
	memory_move_name_id: INTEGER = 75
	memory_set_name_id: INTEGER = 76
	truncated_to_integer_name_id: INTEGER = 77
	set_item_name_id: INTEGER = 78
	copy_name_id: INTEGER = 79
	deep_copy_name_id: INTEGER = 80
	standard_copy_name_id: INTEGER = 81
	standard_clone_name_id: INTEGER = 82
	make_from_cil_name_id: INTEGER = 83
	equal_name_id: INTEGER = 84
	truncated_to_real_name_id: INTEGER = 85
	code_name_id: INTEGER = 86
	to_integer_name_id: INTEGER = 87
	to_character_name_id: INTEGER = 88
	ascii_char_name_id: INTEGER = 89
	standard_twin_name_id: INTEGER = 90
	internal_copy_name_id: INTEGER = 91
	put_value_at_name_id: INTEGER = 92
	set_bit_with_mask_name_id: INTEGER = 93
	memory_alloc_name_id: INTEGER = 94
	memory_free_name_id: INTEGER = 95
	from_integer_name_id: INTEGER = 96
	finalize_name_id: INTEGER = 97
	eif_helpers_header_name_id: INTEGER = 98
	internal_native_array_name_id: INTEGER = 99
	to_string_name_id: INTEGER = 100
	to_cil_name_id: INTEGER = 101
	is_digit_name_id: INTEGER = 102
	internal_correct_mismatch_name_id: INTEGER = 103
	memory_calloc_name_id: INTEGER = 104
	internal_hash_code_name_id: INTEGER = 105
	base_address_name_id: INTEGER = 106
	item_address_name_id: INTEGER = 107
	to_double_name_id: INTEGER = 108
	to_real_name_id: INTEGER = 109
	conforms_to_name_id: INTEGER = 110
	deep_clone_name_id: INTEGER = 111
	default_pointer_name_id: INTEGER = 112
	do_nothing_name_id: INTEGER = 113
	io_name_id: INTEGER = 114
	operating_environment_name_id: INTEGER = 115
	print_name_id: INTEGER = 116
	same_type_name_id: INTEGER = 117
	standard_equal_name_id: INTEGER = 118
	tagged_out_name_id: INTEGER = 119
	to_dotnet_name_id: INTEGER = 120
	twin_name_id: INTEGER = 121
	system_string_name_id: INTEGER = 122
	system_object_name_id: INTEGER = 123
	system_boolean_name_id: INTEGER = 124
	get_hash_code_name_id: INTEGER = 125
	equals_name_id: INTEGER = 126
	three_way_comparison_name_id: INTEGER = 127
	ctype_header_name_id: INTEGER = 128
	as_integer_64_name_id: INTEGER = 129
	to_real_32_name_id: INTEGER = 130
	to_real_64_name_id: INTEGER = 131
	is_lower_name_id: INTEGER = 132
	is_upper_name_id: INTEGER = 133
	set_bit_name_id: INTEGER = 134
	conjuncted_semistrict_name_id: INTEGER = 135
	infix_and_then_name_id: INTEGER = 136
	disjuncted_semistrict_name_id: INTEGER = 137
	infix_or_else_name_id: INTEGER = 138
	implication_name_id: INTEGER = 139
	infix_implies_name_id: INTEGER = 140
	as_lower_name_id: INTEGER = 141
	as_upper_name_id: INTEGER = 142
	is_space_name_id: INTEGER = 143
	copy_data_name_id: INTEGER = 144
	move_data_name_id: INTEGER = 145
	overlapping_move_name_id: INTEGER = 146
	non_overlapping_move_name_id: INTEGER = 147
	bracket_symbol_id: INTEGER = 148
	to_character_8_name_id: INTEGER = 149
	to_character_32_name_id: INTEGER = 150
	natural_32_code_name_id: INTEGER = 151
	rout_disp_name_id: INTEGER = 152
	calc_rout_addr_name_id: INTEGER = 153
	closed_operands_name_id: INTEGER = 154
	last_result_name_id: INTEGER = 155
	class_id_name_id: INTEGER = 156
	feature_id_name_id: INTEGER = 157
	is_precompiled_name_id: INTEGER = 158
	is_basic_name_id: INTEGER = 159
	open_map_name_id: INTEGER = 160
	open_count_name_id: INTEGER = 161
	closed_count_name_id: INTEGER = 162
	encaps_rout_disp_name_id: INTEGER = 163
	fake_inline_agent_target_name_id: INTEGER = 164
	fake_inline_agent_name_name_id: INTEGER = 165
	callable_name_id: INTEGER = 166
	valid_operands_name_id: INTEGER = 167
	set_rout_disp_final_name_id: INTEGER = 168
	to_pointer_name_id: INTEGER = 169
	none_class_name_id: INTEGER = 170
	precursor_name_id: INTEGER = 171
	fast_item_name_id: INTEGER = 172
	pointer_item_name_id: INTEGER = 173
	eif_built_in_header_name_id: INTEGER = 174
	truncated_to_integer_64_name_id: INTEGER = 175
	ceiling_real_32_name_id: INTEGER = 176
	ceiling_real_64_name_id: INTEGER = 177
	floor_real_32_name_id: INTEGER = 178
	floor_real_64_name_id: INTEGER = 179
	is_deep_equal_name_id: INTEGER = 180
	set_exception_data_name_id: INTEGER = 181
	last_exception_name_id: INTEGER = 182
	set_last_exception_name_id: INTEGER = 183
	is_code_ignored_name_id: INTEGER = 184
	once_raise_name_id: INTEGER = 185
	notify_name_id: INTEGER = 186
	notify_argument_name_id: INTEGER = 187
	init_exception_manager_name_id: INTEGER = 188
	free_preallocated_trace_name_id: INTEGER = 189
	any_name_id: INTEGER = 190
	system_void_name_id: INTEGER = 191
	call_name_id: INTEGER = 192
	put_default_name_id: INTEGER = 193
	as_attached_name_id: INTEGER = 194
	is_default_name_id: INTEGER = 195
	extend_name_id: INTEGER = 196
	make_filled_name_id: INTEGER = 197
	make_empty_name_id: INTEGER = 198
	has_default_name_id: INTEGER = 199
	type_id_name_id: INTEGER = 200
	runtime_name_name_id: INTEGER = 201
	generic_parameter_count_name_id: INTEGER = 202
	generic_parameter_type_name_id: INTEGER = 203
	to_array_name_id: INTEGER = 204
	is_nan_name_id: INTEGER = 205
	is_negative_infinity_name_id: INTEGER = 206
	is_positive_infinity_name_id: INTEGER = 207
	nan_name_id: INTEGER = 208
	negative_infinity_name_id: INTEGER = 209
	positive_infinity_name_id: INTEGER = 210
	force_name_id: INTEGER = 211
	fill_with_name_id: INTEGER = 212
	start_name_id: INTEGER = 213
	is_default_pointer_name_id: INTEGER = 214
	is_character_8_name_id: INTEGER = 215
	parentheses_symbol_id: INTEGER = 216
	new_cursor_name_id: INTEGER = 217
	hash_code_64_name_id: INTEGER = 218
	is_attached_name_id: INTEGER = 219
	is_deferred_name_id: INTEGER = 220
	is_expanded_name_id: INTEGER = 221
	minus_name_id: INTEGER = 222
	ieee_is_equal_name_id: INTEGER = 223
	ieee_is_greater_name_id: INTEGER = 224
	ieee_is_greater_equal_name_id: INTEGER = 225
	ieee_is_less_name_id: INTEGER = 226
	ieee_is_less_equal_name_id: INTEGER = 227
	ieee_maximum_number_name_id: INTEGER = 228
	ieee_minimum_number_name_id: INTEGER = 229
	make_from_c_byte_array_name_id: INTEGER = 230
	identity_name_id: INTEGER = 231
	opposite_name_id: INTEGER = 232
	product_name_id: INTEGER = 233
	quotient_name_id: INTEGER = 234
	integer_quotient_name_id: INTEGER = 235
	integer_remainder_name_id: INTEGER = 236
	power_name_id: INTEGER = 237
	is_less_name_id: INTEGER = 238
	is_less_equal_name_id: INTEGER = 239
	is_greater_name_id: INTEGER = 240
	is_greater_equal_name_id: INTEGER = 241
	negated_name_id: INTEGER = 242
	conjuncted_name_id: INTEGER = 243
	disjuncted_name_id: INTEGER = 244
	disjuncted_exclusive_name_id: INTEGER = 245
	inspect_attribute_name_id: INTEGER = 246

feature -- Classification

	is_semi_strict_id (name_id: INTEGER): BOOLEAN
			-- Does `name_id' denote a semistrict operator?
		do
			inspect name_id
			when
				conjuncted_semistrict_name_id, disjuncted_semistrict_name_id, implication_name_id,
				infix_and_then_name_id, infix_or_else_name_id, infix_implies_name_id
			then
				Result := True
			else
					-- False by default
			end
		ensure
			definition: Result = (name_id = conjuncted_semistrict_name_id or name_id = disjuncted_semistrict_name_id or name_id = implication_name_id) or
				(name_id = infix_and_then_name_id or name_id = infix_or_else_name_id or name_id = infix_implies_name_id)
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
