note
	description: "[
					Roundtrip compiler factory
					It doesn't generate `match_list' during parsing.
					Use `EIFFEL_ROUNDTRIP_SCANNER' to generate `match_list' later.
					Or use `AST_ROUNDTRIP_COMPILER_FACTORY' to do parsing and `match_list' generating
					at the same time.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_COMPILER_LIGHT_FACTORY

inherit
	AST_ROUNDTRIP_LIGHT_FACTORY
		undefine
			new_array_as,
			new_integer_as,
			new_integer_hexa_as,
			new_integer_octal_as,
			new_integer_binary_as,
			new_feature_as,
			new_class_as,
			new_class_type_as,
			set_expanded_class_type,
			new_debug_as,
			new_expr_address_as,
			new_integer_value,
			new_real_value,
			new_external_lang_as,
			new_formal_dec_as,
			new_vtgc1_error,
			new_vvok1_error, new_vvok2_error,
			validate_integer_real_type,
			validate_non_conforming_inheritance_type,
			new_line_pragma
		end

	AST_COMPILER_FACTORY
		undefine
			create_match_list,
			backup_match_list_count,
			resume_match_list_count,
			new_keyword_as,
			new_keyword_id_as,
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
			reverse_extend_identifier,
			reverse_extend_identifier_separator,

			new_character_as, new_typed_char_as,
			set_buffer, append_text_to_buffer,
			new_once_string_keyword_as,
			new_integer_as,
			new_integer_hexa_as,
			new_real_as,
			new_string_as,
			new_verbatim_string_as,
			new_bin_and_then_as,
			new_bin_or_else_as,
			create_break_as,
			create_break_as_with_data,
			new_filled_id_as_with_existing_stub,
			extend_match_list_with_stub,
			extend_match_list
		end

feature -- Roundtrip

	new_integer_as (t: detachable TYPE_AS; s: BOOLEAN; v: detachable STRING; buf: detachable STRING; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_CONSTANT
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

	new_integer_hexa_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: STRING; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_CONSTANT
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
				Result.set_sign_symbol (s_as)
				increase_match_list_count
				Result.set_index (match_list_count)
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
