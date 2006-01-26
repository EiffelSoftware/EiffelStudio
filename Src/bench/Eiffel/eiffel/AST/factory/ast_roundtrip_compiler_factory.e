indexing
	description: "[
					Roundtrip compiler factory
					It will generate `match_list' during parsing.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_COMPILER_FACTORY

inherit
	AST_ROUNDTRIP_FACTORY
		undefine
			new_integer_as,
			new_integer_hexa_as,
			new_feature_as,
			new_bits_as,
			new_class_as,
			new_class_type_as,
			new_debug_as,
			new_expr_address_as,
			new_integer_value,
			new_real_value,
			new_external_lang_as
		end

	AST_COMPILER_FACTORY
		undefine
			create_match_list,
			new_keyword_as,
			new_symbol_as,
			new_current_as,
			new_deferred_as,
			new_boolean_as,
			new_result_as,
			new_retry_as,
			new_unique_as,
			new_void_as,
			new_filled_id_as,

			reverse_extend_separator,
			extend_pre_as,
			extend_post_as,
			reverse_extend_identifier,
			new_character_as, new_typed_char_as,
			set_buffer, append_text_to_buffer,
			new_once_string_keyword_as,
			new_square_symbol_as,
			new_creation_keyword_as,
			new_end_keyword_as,
			new_frozen_keyword_as,
			new_infix_keyword_as,
			new_precursor_keyword_as,
			new_prefix_keyword_as,
			new_integer_as,
			new_integer_hexa_as,
			new_real_as,
			new_filled_bit_id_as,
			new_string_as,
			new_verbatim_string_as,
			append_string_to_buffer,
			new_bin_and_then_as,
			new_bin_or_else_as,
			new_tagged_as,
			create_break_as,
			create_break_as_with_data,
			new_filled_id_as_with_existing_stub,
			extend_match_list_with_stub,
			extend_match_list
		end

feature -- Roundtrip

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		require else
			valid_type: t /= Void implies (t.actual_type.is_integer or t.actual_type.is_natural)
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				match_list_count := match_list_count + 1
				Result.set_index (match_list_count)
				extend_match_list_with_stub (create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		require else
			valid_type: t /= Void implies (t.actual_type.is_integer or t.actual_type.is_natural)
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				match_list_count := match_list_count + 1
				Result.set_index (match_list_count)
				extend_match_list_with_stub (create{LEAF_STUB_AS}.make (buf.string, l, c, p, n))
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
