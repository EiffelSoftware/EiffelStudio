indexing
	description: "[
					Roundtrip compiler factory
					It doesn't generate `match_list' during parsing.
					Use `EIFFEL_ROUNDTRIP_SCANNER' to generate `match_list' later.
					Or use `AST_ROUNDTRIP_COMPILER_FACTORY' to do parsing and `match_list' generating
					at the same time.
					]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ROUNDTRIP_COMPILER_LIGHT_FACTORY

inherit
	AST_ROUNDTRIP_LIGHT_FACTORY
		undefine
			new_integer_as,
			new_integer_hexa_as,
			new_feature_as,
			new_bits_as,
			new_class_as,
			new_class_type_as,
			set_expanded_class_type,
			new_debug_as,
			new_expr_address_as,
			new_integer_value,
			new_real_value,
			new_external_lang_as,
			new_formal_dec_as,
			validate_integer_real_type
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
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				match_list_count := match_list_count + 1
				Result.set_index (match_list_count)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
				Result.set_sign_symbol (s_as)
				match_list_count := match_list_count + 1
				Result.set_index (match_list_count)
			end
		end

end
