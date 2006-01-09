indexing
	description: "Roundtrip compiler factory"
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
			new_real_value
		end

	AST_COMPILER_FACTORY
		undefine
			new_internal_match_list,
			extend_internal_match_list,
			clear_internal_match_list,
			new_keyword_as,
			new_symbol_as,
			new_separator_as,
			new_new_line_as,
			new_comment_as,
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
			new_separator_as_with_data,
			new_comment_as_with_data,
			new_new_line_as_with_data,
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
			new_integer_value,
			new_tagged_as,
			new_break_as,
			new_break_as_with_data,
			new_filled_id_as_with_existing_stub
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
			end
		end

	new_integer_value (a_psr: EIFFEL_PARSER_SKELETON; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING; s_as: SYMBOL_AS): INTEGER_AS is
			-- New integer value.
		local
			l_type: TYPE_A
			token_value: STRING
		do
			if a_type /= Void then
				l_type := a_type.actual_type
			end
			if l_type /= Void then
				if not l_type.is_integer and not l_type.is_natural then
					a_psr.report_invalid_type_for_integer_error (a_type, buffer)
				end
			elseif a_type /= Void then
					-- A type was specified but did not result in a valid type
				a_psr.report_invalid_type_for_integer_error (a_type, buffer)
			end
				-- Remember original token
			token_value := buffer.twin
				-- Remove underscores (if any) without breaking
				-- original token
			if token_value.has ('_') then
				token_value := token_value.twin
				token_value.prune_all ('_')
			end
			if token_value.is_number_sequence then
				Result := new_integer_as (a_type, sign_symbol = '-', token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			elseif
				token_value.item (1) = '0' and then
				token_value.item (2).lower = 'x'
			then
				Result := new_integer_hexa_as (a_type, sign_symbol, token_value, buffer, s_as, a_psr.line, a_psr.column, a_psr.position, a_psr.text_count)
			end
			if Result = Void or else not Result.is_initialized then
				if sign_symbol = '-' then
						-- Add `-' for a better reporting.
					buffer.precede ('-')
					a_psr.report_integer_too_small_error (buffer)
				else
					a_psr.report_integer_too_large_error (buffer)
				end
					-- Dummy code (for error recovery) follows:
				Result := new_integer_as (a_type, False, "0", Void, s_as, 0, 0, 0, 0)
			end
			Result.set_position (a_psr.line, a_psr.column, a_psr.position, buffer.count)
			extend_internal_match_list_with_stub (buffer.string, Result)
		end

end
