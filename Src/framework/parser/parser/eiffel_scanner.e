note

	description: "Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit
	EIFFEL_SCANNER_SKELETON

	STRING_HANDLER

create
	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= PRAGMA)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
 ast_factory.create_break_as (Current)  
when 2 then
	yy_end := yy_end - 2
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_break_as_start_position := position
				last_break_as_start_line := line
				last_break_as_start_column := column
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				set_start_condition (PRAGMA)
		
when 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

			less (0)
			ast_factory.create_break_as_with_data (roundtrip_token_buffer,
																last_break_as_start_line,
																last_break_as_start_column,
																last_break_as_start_position,
																roundtrip_token_buffer.count)
			set_start_condition (INITIAL)
		
when 7 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
when 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 13 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 15 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
when 17 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 18 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 20 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 21 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			
when 23 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 36 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 38 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 39 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 40 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 41 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_FREE
				process_id_as
			
when 42 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_FREE
				process_id_as
			
when 43 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version = provisional_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ACROSS, Current)
					last_token := TE_ACROSS
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Provisional keyword `across' is used as identifier."))
					end
				end
			
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 45 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 47 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 48 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 49 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 50 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ATTACHED, Current)
					last_token := TE_ATTACHED
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `attached' is used as identifier."))
					end
				end
			
when 51 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ATTRIBUTE, Current)
					last_token := TE_ATTRIBUTE
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `attribute' is used as identifier."))
					end
				end
			
when 52 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "The `bit' keyword will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			
when 53 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 54 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 55 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 56 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 57 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 58 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 59 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 60 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 61 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_DETACHABLE, Current)
					last_token := TE_DETACHABLE
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `detachable' is used as identifier."))
					end
				end
			
when 62 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 63 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 64 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 65 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 66 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 67 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 68 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 69 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 70 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 72 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 73 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 74 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 75 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 76 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version = ecma_syntax or else syntax_version = provisional_syntax then
					process_id_as
					last_token := TE_ID
				else
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_INDEXING, Current)
					last_token := TE_INDEXING
					if has_syntax_warning and then syntax_version /= obsolete_64_syntax then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Usage of `indexing' has been replace by `note'."))
					end

				end
			
when 77 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 78 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 79 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 80 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 81 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version = ecma_syntax or else syntax_version = provisional_syntax then
					process_id_as
					last_token := TE_ID
				else
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
					last_token := TE_IS
					if has_syntax_warning and then syntax_version /= obsolete_64_syntax then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Usage of `is' has now been deprecated."))
					end
				end

			
when 82 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 83 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 84 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 85 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 86 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_NOTE, Current)
					last_token := TE_NOTE
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `note' is used as identifier."))
					end
				end
			
when 87 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 88 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 89 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- `{' is for the typed manifest string.
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 90 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- `{' is for the typed manifest string.
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING
			
when 91 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 92 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 93 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 94 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 95 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 96 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 97 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 98 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 99 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 100 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 102 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 103 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 104 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 105 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 106 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version = provisional_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_SOME, Current)
					last_token := TE_SOME
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Provisional keyword `some' is used as identifier."))
					end
				end
			
when 107 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 108 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 109 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 110 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_TUPLE
				process_id_as
			
when 111 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 112 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 113 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 114 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 116 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 117 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 118 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_ID
				process_id_as
			
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_A_BIT
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of bit syntax will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 121 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes octal integer numbers.
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 124 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes binary integer numbers.
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 125 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				report_invalid_integer_error (token_buffer)
			
when 126 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			
when 127 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as (char_32_from_source (text_substring (2, text_count - 1)), line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 128 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as (char_32_from_source (text_substring (2, text_count - 1)), line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- This is not correct Eiffel!
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%A', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%B', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%C', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%D', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%F', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%H', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%L', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%N', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%Q', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%R', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%S', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%T', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%U', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%V', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%%', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 145 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 146 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%"', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 147 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%(', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 148 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%)', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 149 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%<', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 150 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%>', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 151 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 152 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 153 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 154 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 155 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				report_invalid_integer_error (token_buffer)
			
when 156 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 157 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 158 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_LT)
			
when 159 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_GT)
			
when 160 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_LE)
			
when 161 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_GE)
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_PLUS)
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_MINUS)
			
when 164 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_STAR)
			
when 165 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_SLASH)
			
when 166 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_POWER)
			
when 167 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_DIV)
			
when 168 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_MOD)
			
when 169 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_BRACKET)
			
when 170 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_AND)
			
when 171 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_AND_THEN)
			
when 172 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_IMPLIES)
			
when 173 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_NOT)
			
when 174 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_OR)
			
when 175 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_OR_ELSE)
			
when 176 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_XOR)
			
when 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_FREE)
			
when 178 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_FREE)
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_EMPTY_STRING)
			
when 180 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 181 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Verbatim string.
				token_buffer.wipe_out
				verbatim_marker.wipe_out
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				start_location.set_position (line, column, position, text_count)
				set_start_condition (VERBATIM_STR3)
			
when 182 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				set_start_condition (VERBATIM_STR1)
			
when 183 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if is_verbatim_string_closer then
					set_start_condition (INITIAL)
						-- Remove the trailing new-line.
					if token_buffer.count >= 2 then
						check new_line: token_buffer.item (token_buffer.count) = '%N' end
						if token_buffer.item (token_buffer.count - 1) = '%R' then
								-- Under Windows a we have \r\n.
								-- Remove both characters.
							token_buffer.set_count (token_buffer.count - 2)
						else
							token_buffer.set_count (token_buffer.count - 1)
						end
					elseif token_buffer.count = 1 then
						check new_line: token_buffer.item (1) = '%N' end
						token_buffer.wipe_out
					end
					if verbatim_marker.item (1) = ']' then
						align_left (token_buffer)
					else
						verbatim_common_columns := 0
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_string_as_value := ast_factory.new_verbatim_string_as ("",
							verbatim_marker.substring (2, verbatim_marker.count), verbatim_marker.item (1) = ']',
							start_location.line, start_location.column, start_location.position,
							position + text_count - start_location.position, verbatim_common_columns, roundtrip_token_buffer)
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_string_as_value := ast_factory.new_verbatim_string_as (cloned_string (token_buffer),
							verbatim_marker.substring (2, verbatim_marker.count), verbatim_marker.item (1) = ']',
							start_location.line, start_location.column, start_location.position,
							position + text_count - start_location.position, verbatim_common_columns, roundtrip_token_buffer)
						last_token := TE_VERBATIM_STRING
						if token_buffer.count > maximum_string_length then
							report_too_long_string (token_buffer)
						end
					end
				else
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 185 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 186 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 187 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 188 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 189 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 190 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- String with special characters.
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				start_location.set_position (line, column, position, text_count)
				set_start_condition (SPECIAL_STR)
			
when 191 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 213 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_natural_32)
			
when 214 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 215 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_string_as_value := ast_factory.new_string_as (
						cloned_string (token_buffer), start_location.line, start_location.column,
						start_location.position,
						position + text_count - start_location.position, roundtrip_token_buffer)
					last_token := TE_EMPTY_STRING
				else
					last_string_as_value := ast_factory.new_string_as (
						cloned_string (token_buffer), start_location.line, start_location.column,
						start_location.position,
						position + text_count - start_location.position, roundtrip_token_buffer)
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
			
when 216 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 217 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 218 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				report_unknown_token_error (text_item (1))
			
when 219 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				terminate
			
when 1 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 2 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 3 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 4 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 5 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

			ast_factory.create_break_as_with_data (roundtrip_token_buffer,
																last_break_as_start_line,
																last_break_as_start_column,
																last_break_as_start_position,
																roundtrip_token_buffer.count)
			set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2535)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,   14,   15,   16,   15,   17,   18,   19,   20,   14,
			   19,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   32,   33,   34,   35,   36,   37,   38,
			   19,   39,   40,   41,   42,   43,   44,   45,   45,   46,
			   45,   45,   47,   45,   48,   49,   50,   45,   51,   52,
			   53,   54,   55,   56,   57,   45,   45,   58,   59,   60,
			   61,   14,   14,   39,   40,   41,   42,   43,   44,   45,
			   45,   46,   45,   45,   47,   45,   48,   49,   50,   45,
			   51,   52,   53,   54,   55,   56,   57,   45,   45,   62,
			   19,   63,   64,   14,   14,   14,   14,   65,   66,   67,

			   68,   69,   70,   71,   73,   73,  521,   74,   74,  131,
			   75,   75,   77,   78,   77,  159,   79,   77,   78,   77,
			  132,   79,   84,   85,   84,   84,   85,   84,   87,   88,
			   87,   87,   88,   87,   90,   90,   90,   90,   90,   90,
			  135,  147,  148,   89,  149,  150,   89,  159,  136,   91,
			  179,  133,   91,  134,  134,  134,  134,  138,  177,  139,
			  139,  140,  140,  165,  178,  167,  186,  168,  661,   80,
			  193,  145,  184,  166,   80,  703,  138,  169,  140,  140,
			  140,  140,  179,  199,  199,  199,  201,  201,  201,  185,
			  177,  305,  196,  754,  197,  165,  178,  167,  186,  168,

			  144,   80,  193,  145,  184,  166,   80,   93,   94,  169,
			   95,   94,  702,  137,  305,   96,   97,  120,   98,  144,
			   99,  185,  657,  121,  196,  122,  197,  100,  701,  101,
			  754,   94,  102,  153,  246,  170,  326,  154,  187,  171,
			  103,  327,  155,  305,  156,  104,  105,  160,  188,  157,
			  158,  161,  172,  189,  162,  106,  330,  163,  107,  108,
			  164,  109,  202,  202,  102,  153,  246,  170,  326,  154,
			  187,  171,  103,  327,  155,  307,  156,  104,  105,  160,
			  188,  157,  158,  161,  172,  189,  162,  106,  330,  163,
			  110,   94,  164,  203,  203,  203,  309,  309,  111,  112,

			  113,  114,  115,  116,  117,  194,  700,  123,  123,  123,
			  123,  124,  125,  126,  127,  128,  129,  130,  138,  195,
			  139,  139,  140,  140,  696,  312,  180,  173,  204,  204,
			  204,  190,  141,  142,  174,  175,  181,  194,  182,  331,
			  176,  191,  183,  232,  192,  232,  233,  573,  236,  320,
			  320,  195,  332,  656,  143,  239,  240,  239,  180,  173,
			  333,  144,  650,  190,  141,  142,  174,  175,  181,  634,
			  182,  331,  176,  191,  183,  599,  192,  241,  241,  241,
			  660,  234,  232,  234,  332,  233,  143,  208,  208,  208,
			  243,  209,  333,   95,  210,  657,  211,  212,  213,  241,

			  241,  241,  595,  305,  214,   90,   90,   90,  315,  247,
			  458,  215,   95,  216,  416,  416,  217,  218,  219,  220,
			   91,  221,  661,  222,  334,  248,  456,  223,   95,  224,
			  523,  335,  225,  226,  227,  228,  229,  230,  235,  249,
			  250,  110,   95,   95,  252,  254,  243,   95,   95,   95,
			  205,  243,  200,  251,   95,  243,  334,  336,   95,  243,
			  110,  243,   95,  335,   95,  253,  255,  337,  265,  232,
			  235,   95,  233,  110,   92,   92,  110,   92,  458,  244,
			  456,  338,   95,  342,  256,  306,  306,  306,  257,  336,
			  110,  110,  110,  347,  258,  110,  110,  110,  442,  337,

			  260,  259,  110,  441,  243,  440,  110,   95,  110,  439,
			  110,  438,  110,  338,  243,  342,  256,   95,  437,  110,
			  257,  348,  110,  110,  436,  347,  258,  110,  110,  110,
			  245,  274,  260,  259,  110,  322,  322,  322,  110,  261,
			  262,  261,  110,  243,  110,  232,   95,  243,  236,  305,
			   95,  110,  349,  348,  435,  110,  264,  261,  262,  261,
			  243,  243,  245,   95,   95,  110,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,  243,  434,  305,
			   95,  202,  202,  243,  349,  305,   95,  110,  320,  320,
			  243,  433,  328,   95,  110,  329,  263,  110,  110,  600,

			  600,  266,  266,  266,  243,  350,  356,   95,  359,  432,
			  343,  110,  110,  324,  324,  324,  324,  275,  276,  277,
			  278,  279,  280,  281,  328,  344,  110,  329,  110,  455,
			  110,  308,  308,  308,  110,  431,  267,  350,  356,  430,
			  359,  110,  343,  110,  110,  429,  428,  268,  268,  268,
			  199,  199,  199,  304,  325,  110,  360,  344,  361,  427,
			  110,  310,  310,  310,  269,  269,  110,  311,  311,  311,
			  270,  270,  270,  110,  199,  199,  199,  271,  271,  271,
			  275,  276,  277,  278,  279,  280,  281,  110,  360,  424,
			  361,  272,  282,  364,  365,  283,  423,  284,  285,  286,

			  313,  313,  313,  313,  315,  287,  316,  316,  316,  316,
			  320,  320,  288,  422,  289,  314,  374,  290,  291,  292,
			  293,  317,  294,  421,  295,  364,  365,  375,  296,  420,
			  297,  419,  414,  298,  299,  300,  301,  302,  303,  275,
			  276,  277,  278,  279,  280,  281,  339,  314,  374,  376,
			  340,  455,  138,  317,  318,  318,  319,  319,  138,  375,
			  319,  319,  319,  319,  341,  362,  145,  345,  357,  398,
			  377,  346,  378,  382,  363,  351,  238,  352,  339,  353,
			  358,  376,  340,  275,  276,  277,  278,  279,  280,  281,
			  354,  207,  305,  355,  383,  144,  341,  362,  145,  345,

			  357,  144,  377,  346,  378,  382,  363,  351,  366,  352,
			  367,  353,  358,  372,  379,  384,  385,  373,  368,  380,
			  462,  369,  354,  370,  371,  355,  383,  199,  199,  199,
			  381,  386,  387,  388,  389,  390,  391,  392,  131,  242,
			  366,  400,  367,  238,   95,  372,  379,  384,  385,  373,
			  368,  380,  462,  369,  207,  370,  371,  199,  199,  199,
			  205,  463,  381,  393,  393,  393,  394,  394,  394,  208,
			  208,  208,  396,  396,  396,  396,  395,  234,  232,  234,
			  200,  233,  239,  240,  239,  241,  241,  241,  198,  399,
			  262,  399,  110,  463,  401,  402,  464,   95,   95,  243,

			  151,  243,   95,  243,   95,  406,   95,  407,  146,  243,
			   95,  409,   95,  754,   95,   82,  261,  262,  261,   82,
			  243,  754,  754,   95,  110,  465,  754,  403,  464,  410,
			  754,  754,   95,  754,  235,  754,  411,  243,  754,   95,
			   95,  404,  468,  754,  246,  110,  110,  405,  754,  469,
			  110,  408,  110,  243,  110,  754,   95,  465,  110,  403,
			  110,  754,  110,  273,  273,  273,  235,   92,  261,  262,
			  261,  110,  244,  404,  468,   95,  246,  110,  110,  405,
			  110,  469,  110,  408,  110,  754,  110,  110,  110,  470,
			  110,  754,  110,  243,  110,  754,   95,  415,  415,  415, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  754,  754,  243,  110,  110,   95,  417,  417,  417,  418,
			  418,  418,  110,  425,  426,  426,  426,  443,  754,  110,
			  110,  470,  471,  245,  266,  266,  266,  111,  112,  113,
			  114,  115,  116,  117,  754,  243,  110,  754,   95,  754,
			  266,  266,  266,  243,  110,  754,   95,  306,  306,  306,
			  306,  306,  306,  110,  471,  245,  306,  306,  306,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			  306,  306,  306,  444,  444,  444,  110,  445,  445,  445,
			  266,  266,  266,  472,  473,  110,  110,  474,  475,  266,
			  266,  266,  754,  476,  110,  446,  446,  446,  446,  449,

			  449,  449,  449,  275,  276,  277,  278,  279,  280,  281,
			  314,  754,  477,  754,  450,  472,  473,  754,  110,  474,
			  475,  480,  412,  412,  412,  476,  110,  322,  322,  322,
			  413,  413,  413,  447,  754,  447,  754,  754,  448,  448,
			  448,  448,  314,  451,  477,  451,  450,  466,  452,  452,
			  452,  452,  138,  480,  453,  453,  454,  454,  138,  754,
			  454,  454,  454,  454,  467,  481,  145,  459,  457,  460,
			  460,  460,  460,  461,  461,  461,  461,  478,  754,  466,
			  482,  483,  754,  485,  486,  487,  488,  489,  490,  491,
			  492,  479,  493,  494,  484,  144,  467,  481,  145,  495,

			  496,  144,  497,  498,  499,  501,  502,  500,  503,  478,
			  325,  504,  482,  483,  325,  485,  486,  487,  488,  489,
			  490,  491,  492,  479,  493,  494,  484,  505,  507,  508,
			  509,  495,  496,  510,  497,  498,  499,  501,  502,  500,
			  503,  511,  512,  504,  513,  506,  514,  515,  516,  517,
			  518,  519,  520,  199,  199,  199,  201,  201,  201,  505,
			  507,  508,  509,  754,  754,  510,  203,  203,  203,  204,
			  204,  204,  243,  511,  512,   95,  513,  506,  514,  515,
			  516,  517,  518,  519,  520,  199,  199,  199,  199,  199,
			  199,  521,  522,  522,  522,  522,  399,  262,  399,  524,

			  754,  525,  527,  243,   95,   95,   95,  529,  526,  243,
			   95,  754,   95,  273,  273,  273,  243,  754,  754,   95,
			  273,  273,  273,  110,  273,  273,  273,  273,  273,  273,
			  754,  754,  528,  530,  530,  530,  531,  531,  531,  754,
			  526,  754,  754,  532,  426,  426,  426,  426,  306,  306,
			  306,  246,  110,  110,  110,  110,  533,  534,  110,  543,
			  110,  306,  306,  306,  528,  754,  754,  110,  532,  426,
			  426,  426,  426,  448,  448,  448,  448,  754,  535,  536,
			  536,  536,  536,  246,  110,  110,  110,  544,  533,  534,
			  110,  543,  110,  545,  314,  754,  266,  266,  266,  110,

			  273,  273,  273,  266,  266,  266,  448,  448,  448,  448,
			  535,  546,  538,  538,  538,  538,  539,  754,  539,  544,
			  537,  540,  540,  540,  540,  545,  314,  450,  452,  452,
			  452,  452,  452,  452,  452,  452,  541,  547,  453,  453,
			  454,  454,  541,  546,  454,  454,  454,  454,  548,  459,
			  145,  542,  542,  542,  542,  549,  550,  551,  459,  450,
			  461,  461,  461,  461,  552,  553,  554,  555,  556,  547,
			  557,  558,  559,  560,  561,  562,  563,  564,  565,  325,
			  548,  566,  145,  567,  568,  325,  569,  549,  550,  551,
			  570,  571,  325,  572,  754,  754,  552,  553,  554,  555,

			  556,  325,  557,  558,  559,  560,  561,  562,  563,  564,
			  565,  576,  577,  566,  578,  567,  568,  579,  569,  580,
			  581,  582,  570,  571,  583,  572,  573,  573,  573,  584,
			  574,  585,  586,  587,  588,  589,  590,  591,  592,  593,
			  754,  575,  243,  576,  577,   95,  578,  243,  754,  579,
			   95,  580,  581,  582,  243,  610,  583,   95,  273,  273,
			  273,  584,  611,  585,  586,  587,  588,  589,  590,  591,
			  592,  593,  521,  594,  594,  594,  594,  602,  602,  602,
			  597,  536,  536,  536,  536,  754,  596,  610,  612,  754,
			  598,  613,  614,  110,  611,  617,  604,  618,  110,  605,

			  605,  605,  605,  754,  619,  110,  606,  606,  606,  606,
			  754,  754,  597,  574,  540,  540,  540,  540,  596,  754,
			  612,  450,  598,  613,  614,  110,  620,  617,  604,  618,
			  110,  540,  540,  540,  540,  615,  619,  110,  315,  616,
			  606,  606,  606,  606,  621,  622,  609,  607,  461,  461,
			  461,  461,  623,  450,  624,  608,  625,  754,  620,  626,
			  627,  628,  629,  630,  631,  632,  635,  615,  573,  573,
			  573,  616,  633,  636,  637,  638,  621,  622,  639,  640,
			  641,  642,  643,  575,  623,  644,  624,  608,  625,  144,
			  645,  626,  627,  628,  629,  630,  631,  632,  635,  646,

			  647,  648,  654,  600,  600,  636,  637,  638,  754,  754,
			  639,  640,  641,  642,  643,  243,  243,  644,   95,   95,
			  754,  754,  645,  521,  649,  649,  649,  649,  321,  321,
			  321,  646,  647,  648,  754,  243,  671,  672,   95,  658,
			  602,  602,  602,  754,  655,  652,  662,  651,  662,  754,
			  754,  663,  663,  663,  663,  633,  664,  664,  664,  664,
			  606,  606,  606,  606,  673,  674,  110,  110,  671,  672,
			  675,  665,  676,  677,  678,  666,  679,  652,  653,  651,
			  754,  659,  667,  667,  667,  667,  110,  668,  680,  668,
			  681,  682,  669,  669,  669,  669,  673,  674,  110,  110,

			  683,  684,  675,  665,  676,  677,  678,  666,  679,  315,
			  653,  667,  667,  667,  667,  685,  686,  687,  110,  688,
			  680,  689,  681,  682,  690,  691,  670,  692,  693,  694,
			  754,  754,  683,  684,  521,  695,  695,  695,  695,  243,
			  243,  243,   95,   95,   95,  713,  754,  685,  686,  687,
			  714,  688,  754,  689,  754,  754,  690,  691,  670,  692,
			  693,  694,  663,  663,  663,  663,  715,  754,  697,  754,
			  699,  663,  663,  663,  663,  754,  716,  713,  704,  704,
			  704,  704,  714,  698,  669,  669,  669,  669,  717,  718,
			  110,  110,  110,  665,  709,  709,  709,  709,  715,  705,

			  697,  705,  699,  754,  706,  706,  706,  706,  716,  710,
			  719,  707,  720,  707,  721,  698,  708,  708,  708,  708,
			  717,  718,  110,  110,  110,  665,  669,  669,  669,  669,
			  711,  722,  711,  725,  726,  712,  712,  712,  712,  727,
			  728,  710,  719,  729,  720,  737,  721,  723,  723,  723,
			  521,  730,  730,  730,  730,  243,  732,  733,   95,   95,
			   95,  754,  665,  722,  754,  725,  726,  706,  706,  706,
			  706,  727,  728,  738,  754,  729,  754,  737,  724,  706,
			  706,  706,  706,  708,  708,  708,  708,  754,  537,  708,
			  708,  708,  708,  731,  665,  739,  734,  734,  734,  734, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  712,  712,  712,  712,  741,  738,  110,  110,  110,  742,
			  724,  710,  735,  743,  735,  754,  710,  736,  736,  736,
			  736,  712,  712,  712,  712,  731,  746,  739,  723,  723,
			  723,  521,  744,  744,  744,  744,  741,  747,  110,  110,
			  110,  742,  607,  710,  745,  743,  748,   95,  710,  736,
			  736,  736,  736,  736,  736,  736,  736,  749,  746,  740,
			  750,  751,  752,  754,  753,  323,  323,  323,  754,  747,
			  601,  601,  601,  603,  603,  603,  754,  754,  748,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  754,  749,
			  754,  740,  750,  751,  752,  110,  753,  118,  754,  754,

			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  110,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   76,   76,   76,   76,
			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,

			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   92,  754,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  206,  754,  206,  206,  754,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,

			  235,  235,  235,  235,  235,  235,  235,  235,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,   94,  754,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   95,  754,   95,  754,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,  273,  273,  273,  273,  273,  273,  273,  273,
			  273,  273,  273,  273,  273,  273,  273,  273,  397,  754,
			  397,  397,  397,  397,  397,  397,  397,  397,  397,  397,
			  397,  397,  397,  397,  397,  397,  634,  634,  634,  634,

			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  696,  754,  696,  696,  696,  696,
			  696,  696,  696,  696,  696,  696,  696,  696,  696,  696,
			  696,  696,   13,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,

			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754, yy_Dummy>>,
			1, 536, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2535)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    3,    4,  744,    3,    4,   27,
			    3,    4,    5,    5,    5,   40,    5,    6,    6,    6,
			   27,    6,    9,    9,    9,   10,   10,   10,   11,   11,
			   11,   12,   12,   12,   15,   15,   15,   16,   16,   16,
			   29,   35,   35,   11,   37,   37,   12,   40,   29,   15,
			   48,   28,   16,   28,   28,   28,   28,   31,   47,   31,
			   31,   31,   31,   42,   47,   43,   51,   43,  661,    5,
			   54,   31,   50,   42,    6,  660,   32,   43,   32,   32,
			   32,   32,   48,   65,   65,   65,   67,   67,   67,   50,
			   47,  125,   56,  659,   57,   42,   47,   43,   51,   43,

			   31,    5,   54,   31,   50,   42,    6,   18,   18,   43,
			   18,   18,  658,   29,  127,   18,   18,   21,   18,   32,
			   18,   50,  657,   21,   56,   21,   57,   18,  656,   18,
			  655,   18,   18,   39,   95,   44,  153,   39,   52,   44,
			   18,  154,   39,  130,   39,   18,   18,   41,   52,   39,
			   39,   41,   44,   52,   41,   18,  156,   41,   18,   18,
			   41,   18,   68,   68,   18,   39,   95,   44,  153,   39,
			   52,   44,   18,  154,   39,  125,   39,   18,   18,   41,
			   52,   39,   39,   41,   44,   52,   41,   18,  156,   41,
			   18,   18,   41,   69,   69,   69,  127,  127,   18,   18,

			   18,   18,   18,   18,   18,   55,  654,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   30,   55,
			   30,   30,   30,   30,  650,  130,   49,   46,   70,   70,
			   70,   53,   30,   30,   46,   46,   49,   55,   49,  157,
			   46,   53,   49,   76,   53,   80,   76,  634,   80,  141,
			  141,   55,  158,  601,   30,   84,   84,   84,   49,   46,
			  159,   30,  595,   53,   30,   30,   46,   46,   49,  575,
			   49,  157,   46,   53,   49,  532,   53,   87,   87,   87,
			  603,   77,   77,   77,  158,   77,   30,   75,   75,   75,
			   92,   75,  159,   92,   75,  601,   75,   75,   75,   88,

			   88,   88,  523,  124,   75,   90,   90,   90,  459,   96,
			  458,   75,   96,   75,  278,  278,   75,   75,   75,   75,
			   90,   75,  603,   75,  160,   97,  456,   75,   97,   75,
			  398,  161,   75,   75,   75,   75,   75,   75,   77,   98,
			   99,   92,   98,   99,  100,  101,  102,  100,  101,  102,
			  392,  103,  387,   99,  103,  104,  160,  162,  104,  105,
			   96,  106,  105,  161,  106,  100,  101,  163,  109,  231,
			   77,  109,  231,   92,   94,   94,   97,   94,  323,   94,
			  321,  164,   94,  167,  102,  124,  124,  124,  103,  162,
			   98,   99,   96,  170,  104,  100,  101,  102,  303,  163,

			  106,  105,  103,  302,  108,  301,  104,  108,   97,  300,
			  105,  299,  106,  164,  111,  167,  102,  111,  298,  109,
			  103,  171,   98,   99,  297,  170,  104,  100,  101,  102,
			   94,  119,  106,  105,  103,  142,  142,  142,  104,  107,
			  107,  107,  105,  107,  106,  235,  107,  112,  235,  126,
			  112,  109,  172,  171,  296,  108,  108,  110,  110,  110,
			  113,  110,   94,  113,  110,  111,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,  114,  295,  128,
			  114,  389,  389,  115,  172,  129,  115,  108,  320,  320,
			  116,  294,  155,  116,  107,  155,  107,  111,  112,  533,

			  533,  111,  111,  111,  117,  174,  177,  117,  179,  293,
			  168,  113,  110,  144,  144,  144,  144,  119,  119,  119,
			  119,  119,  119,  119,  155,  168,  107,  155,  114,  320,
			  112,  126,  126,  126,  115,  292,  112,  174,  177,  291,
			  179,  116,  168,  113,  110,  290,  289,  113,  113,  113,
			  200,  200,  200,  122,  144,  117,  180,  168,  181,  288,
			  114,  128,  128,  128,  114,  114,  115,  129,  129,  129,
			  115,  115,  115,  116,  201,  201,  201,  116,  116,  116,
			  120,  120,  120,  120,  120,  120,  120,  117,  180,  286,
			  181,  117,  121,  184,  185,  121,  285,  121,  121,  121,

			  134,  134,  134,  134,  138,  121,  138,  138,  138,  138,
			  455,  455,  121,  284,  121,  134,  188,  121,  121,  121,
			  121,  138,  121,  283,  121,  184,  185,  189,  121,  282,
			  121,  281,  276,  121,  121,  121,  121,  121,  121,  122,
			  122,  122,  122,  122,  122,  122,  165,  134,  188,  190,
			  165,  455,  139,  138,  139,  139,  139,  139,  140,  189,
			  140,  140,  140,  140,  165,  182,  139,  169,  178,  242,
			  191,  169,  192,  194,  182,  175,  237,  175,  165,  175,
			  178,  190,  165,  121,  121,  121,  121,  121,  121,  121,
			  175,  206,  123,  175,  195,  139,  165,  182,  139,  169,

			  178,  140,  191,  169,  192,  194,  182,  175,  186,  175,
			  186,  175,  178,  187,  193,  196,  197,  187,  186,  193,
			  326,  186,  175,  186,  186,  175,  195,  202,  202,  202,
			  193,  199,  199,  199,  199,  199,  199,  199,   91,   89,
			  186,  251,  186,   81,  251,  187,  193,  196,  197,  187,
			  186,  193,  326,  186,   72,  186,  186,  203,  203,  203,
			   71,  327,  193,  204,  204,  204,  205,  205,  205,  208,
			  208,  208,  214,  214,  214,  214,  208,  234,  234,  234,
			   66,  234,  239,  239,  239,  241,  241,  241,   59,  246,
			  246,  246,  251,  327,  253,  255,  328,  253,  255,  256,

			   38,  257,  256,  258,  257,  259,  258,  259,   33,  260,
			  259,  263,  260,   13,  263,    8,  261,  261,  261,    7,
			  261,    0,    0,  261,  251,  331,    0,  256,  328,  264,
			    0,    0,  264,    0,  234,    0,  266,  267,    0,  266,
			  267,  257,  334,    0,  246,  253,  255,  258,    0,  335,
			  256,  260,  257,  268,  258,    0,  268,  331,  259,  256,
			  260,    0,  263,  275,  275,  275,  234,  245,  245,  245,
			  245,  261,  245,  257,  334,  245,  246,  253,  255,  258,
			  264,  335,  256,  260,  257,    0,  258,  266,  267,  336,
			  259,    0,  260,  269,  263,    0,  269,  277,  277,  277, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  270,  261,  268,  270,  279,  279,  279,  280,
			  280,  280,  264,  287,  287,  287,  287,  306,    0,  266,
			  267,  336,  337,  245,  267,  267,  267,  266,  266,  266,
			  266,  266,  266,  266,    0,  271,  268,    0,  271,    0,
			  268,  268,  268,  272,  269,    0,  272,  307,  307,  307,
			  308,  308,  308,  270,  337,  245,  309,  309,  309,  245,
			  245,  245,  245,  245,  245,  245,  245,  245,  245,  245,
			  310,  310,  310,  311,  311,  311,  269,  312,  312,  312,
			  269,  269,  269,  338,  339,  270,  271,  340,  341,  270,
			  270,  270,    0,  342,  272,  313,  313,  313,  313,  316,

			  316,  316,  316,  306,  306,  306,  306,  306,  306,  306,
			  313,    0,  344,    0,  316,  338,  339,    0,  271,  340,
			  341,  346,  271,  271,  271,  342,  272,  322,  322,  322,
			  272,  272,  272,  314,    0,  314,    0,    0,  314,  314,
			  314,  314,  313,  317,  344,  317,  316,  332,  317,  317,
			  317,  317,  318,  346,  318,  318,  318,  318,  319,    0,
			  319,  319,  319,  319,  332,  347,  318,  324,  322,  324,
			  324,  324,  324,  325,  325,  325,  325,  345,    0,  332,
			  348,  349,    0,  350,  351,  352,  353,  354,  355,  356,
			  357,  345,  358,  359,  349,  318,  332,  347,  318,  360,

			  362,  319,  363,  364,  365,  366,  367,  365,  368,  345,
			  324,  369,  348,  349,  325,  350,  351,  352,  353,  354,
			  355,  356,  357,  345,  358,  359,  349,  370,  371,  372,
			  373,  360,  362,  374,  363,  364,  365,  366,  367,  365,
			  368,  375,  376,  369,  377,  370,  378,  379,  380,  381,
			  382,  383,  384,  386,  386,  386,  388,  388,  388,  370,
			  371,  372,  373,    0,    0,  374,  390,  390,  390,  391,
			  391,  391,  404,  375,  376,  404,  377,  370,  378,  379,
			  380,  381,  382,  383,  384,  393,  393,  393,  394,  394,
			  394,  396,  396,  396,  396,  396,  399,  399,  399,  403,

			    0,  403,  405,  406,  403,  405,  406,  408,  404,  412,
			  408,    0,  412,  414,  414,  414,  413,    0,    0,  413,
			  415,  415,  415,  404,  416,  416,  416,  417,  417,  417,
			    0,    0,  406,  418,  418,  418,  419,  419,  419,    0,
			  404,    0,    0,  425,  425,  425,  425,  425,  444,  444,
			  444,  399,  403,  405,  406,  404,  425,  425,  408,  462,
			  412,  445,  445,  445,  406,    0,    0,  413,  426,  426,
			  426,  426,  426,  447,  447,  447,  447,    0,  425,  446,
			  446,  446,  446,  399,  403,  405,  406,  463,  425,  425,
			  408,  462,  412,  464,  446,    0,  412,  412,  412,  413,

			  530,  530,  530,  413,  413,  413,  448,  448,  448,  448,
			  425,  465,  449,  449,  449,  449,  450,    0,  450,  463,
			  446,  450,  450,  450,  450,  464,  446,  449,  451,  451,
			  451,  451,  452,  452,  452,  452,  453,  466,  453,  453,
			  453,  453,  454,  465,  454,  454,  454,  454,  467,  460,
			  453,  460,  460,  460,  460,  468,  469,  470,  461,  449,
			  461,  461,  461,  461,  471,  472,  473,  474,  475,  466,
			  476,  477,  478,  479,  480,  481,  482,  484,  485,  453,
			  467,  486,  453,  487,  488,  454,  489,  468,  469,  470,
			  490,  492,  460,  495,    0,    0,  471,  472,  473,  474,

			  475,  461,  476,  477,  478,  479,  480,  481,  482,  484,
			  485,  498,  499,  486,  500,  487,  488,  501,  489,  502,
			  503,  504,  490,  492,  505,  495,  496,  496,  496,  506,
			  496,  507,  508,  509,  511,  514,  515,  516,  517,  518,
			    0,  496,  524,  498,  499,  524,  500,  526,    0,  501,
			  526,  502,  503,  504,  528,  543,  505,  528,  531,  531,
			  531,  506,  546,  507,  508,  509,  511,  514,  515,  516,
			  517,  518,  522,  522,  522,  522,  522,  534,  534,  534,
			  526,  536,  536,  536,  536,    0,  524,  543,  547,    0,
			  528,  548,  551,  524,  546,  553,  536,  555,  526,  537,

			  537,  537,  537,    0,  556,  528,  538,  538,  538,  538,
			    0,    0,  526,  496,  539,  539,  539,  539,  524,    0,
			  547,  538,  528,  548,  551,  524,  557,  553,  536,  555,
			  526,  540,  540,  540,  540,  552,  556,  528,  541,  552,
			  541,  541,  541,  541,  558,  559,  542,  538,  542,  542,
			  542,  542,  560,  538,  561,  541,  563,    0,  557,  564,
			  565,  566,  568,  569,  570,  572,  576,  552,  573,  573,
			  573,  552,  573,  577,  578,  579,  558,  559,  580,  581,
			  582,  583,  584,  573,  560,  586,  561,  541,  563,  542,
			  587,  564,  565,  566,  568,  569,  570,  572,  576,  590,

			  591,  593,  600,  600,  600,  577,  578,  579,    0,    0,
			  580,  581,  582,  583,  584,  596,  597,  586,  596,  597,
			    0,    0,  587,  594,  594,  594,  594,  594,  771,  771,
			  771,  590,  591,  593,    0,  598,  612,  613,  598,  602,
			  602,  602,  602,    0,  600,  597,  604,  596,  604,    0,
			    0,  604,  604,  604,  604,  573,  605,  605,  605,  605,
			  606,  606,  606,  606,  614,  616,  596,  597,  612,  613,
			  617,  605,  618,  619,  622,  606,  624,  597,  598,  596,
			    0,  602,  607,  607,  607,  607,  598,  608,  625,  608,
			  627,  628,  608,  608,  608,  608,  614,  616,  596,  597,

			  629,  630,  617,  605,  618,  619,  622,  606,  624,  609,
			  598,  609,  609,  609,  609,  631,  632,  635,  598,  636,
			  625,  638,  627,  628,  639,  641,  609,  645,  646,  648,
			    0,    0,  629,  630,  649,  649,  649,  649,  649,  651,
			  652,  653,  651,  652,  653,  671,    0,  631,  632,  635,
			  672,  636,    0,  638,    0,    0,  639,  641,  609,  645,
			  646,  648,  662,  662,  662,  662,  674,    0,  651,    0,
			  653,  663,  663,  663,  663,    0,  676,  671,  664,  664,
			  664,  664,  672,  652,  668,  668,  668,  668,  677,  678,
			  651,  652,  653,  664,  667,  667,  667,  667,  674,  665,

			  651,  665,  653,    0,  665,  665,  665,  665,  676,  667,
			  679,  666,  682,  666,  685,  652,  666,  666,  666,  666,
			  677,  678,  651,  652,  653,  664,  669,  669,  669,  669,
			  670,  686,  670,  688,  689,  670,  670,  670,  670,  690,
			  692,  667,  679,  693,  682,  714,  685,  687,  687,  687,
			  695,  695,  695,  695,  695,  697,  698,  699,  697,  698,
			  699,    0,  704,  686,    0,  688,  689,  705,  705,  705,
			  705,  690,  692,  717,    0,  693,    0,  714,  687,  706,
			  706,  706,  706,  707,  707,  707,  707,    0,  704,  708,
			  708,  708,  708,  697,  704,  721,  709,  709,  709,  709, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  711,  711,  711,  711,  724,  717,  697,  698,  699,  725,
			  687,  709,  710,  727,  710,    0,  734,  710,  710,  710,
			  710,  712,  712,  712,  712,  697,  738,  721,  723,  723,
			  723,  730,  730,  730,  730,  730,  724,  740,  697,  698,
			  699,  725,  734,  709,  731,  727,  741,  731,  734,  735,
			  735,  735,  735,  736,  736,  736,  736,  747,  738,  723,
			  748,  749,  750,    0,  751,  772,  772,  772,    0,  740,
			  774,  774,  774,  775,  775,  775,    0,    0,  741,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,    0,  747,
			    0,  723,  748,  749,  750,  731,  751,  761,    0,    0,

			  761,  761,  761,  761,  761,  761,  761,  761,  761,  761,
			  761,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  731,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  756,  756,  756,  756,
			  756,  756,  756,  756,  756,  756,  756,  756,  756,  756,
			  756,  756,  756,  756,  757,  757,  757,  757,  757,  757,
			  757,  757,  757,  757,  757,  757,  757,  757,  757,  757,
			  757,  757,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,

			  759,  759,  759,  759,  759,  759,  759,  759,  759,  759,
			  759,  759,  759,  759,  759,  759,  759,  759,  760,    0,
			  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
			  760,  760,  760,  760,  760,  760,  762,  762,  762,  762,
			  762,  762,  762,  762,  762,  762,  762,  762,  762,  762,
			  762,  762,  762,  762,  764,    0,  764,  764,    0,  764,
			  764,  764,  764,  764,  764,  764,  764,  764,  764,  764,
			  764,  764,  765,  765,  765,  765,  765,  765,  765,  765,
			  765,  765,  765,  765,  765,  765,  765,  765,  765,  765,
			  766,  766,  766,  766,  766,  766,  766,  766,  766,  766,

			  766,  766,  766,  766,  766,  766,  766,  766,  767,  767,
			  767,  767,  767,  767,  767,  767,  767,  767,  767,  767,
			  767,  767,  767,  767,  767,  767,  768,    0,  768,  768,
			  768,  768,  768,  768,  768,  768,  768,  768,  768,  768,
			  768,  768,  768,  768,  769,    0,  769,    0,  769,  769,
			  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,
			  769,  769,  770,  770,  770,  770,  770,  770,  770,  770,
			  770,  770,  770,  770,  770,  770,  770,  770,  773,    0,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  776,  776,  776,  776,

			  776,  776,  776,  776,  776,  776,  776,  776,  776,  776,
			  776,  776,  776,  776,  777,    0,  777,  777,  777,  777,
			  777,  777,  777,  777,  777,  777,  777,  777,  777,  777,
			  777,  777,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,

			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754, yy_Dummy>>,
			1, 536, 2000)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  101,  102,  110,  115,  916,  912,  120,
			  123,  126,  129,  913, 2432,  132,  135, 2432,  201,    0,
			 2432,  214, 2432, 2432, 2432, 2432, 2432,   92,  133,  121,
			  300,  139,  158,  881, 2432,  115, 2432,  117,  873,  200,
			   76,  209,  128,  123,  204,    0,  291,  119,  105,  294,
			  141,  131,  203,  293,  126,  274,  154,  149, 2432,  830,
			 2432, 2432, 2432, 2432, 2432,   90,  785,   93,  169,  200,
			  235,  767,  848, 2432, 2432,  385,  340,  379, 2432, 2432,
			  342,  840, 2432, 2432,  353, 2432, 2432,  375,  397,  822,
			  403,  821,  384, 2432,  473,  177,  403,  419,  433,  434,

			  438,  439,  440,  445,  449,  453,  455,  537,  498,  462,
			  555,  508,  541,  554,  571,  577,  584,  598,    0,  520,
			  583,  686,  642,  781,  392,  180,  538,  203,  568,  574,
			  232, 2432, 2432, 2432,  680, 2432, 2432, 2432,  686,  734,
			  740,  329,  515,    0,  593, 2432, 2432, 2432, 2432, 2432,
			 2432, 2432,    0,  188,  206,  553,  222,  290,  302,  310,
			  389,  400,  413,  432,  433,  714,    0,  434,  576,  721,
			  451,  490,  507,    0,  559,  741,    0,  565,  735,  558,
			  607,  624,  732,    0,  645,  659,  774,  771,  673,  679,
			  714,  719,  726,  780,  725,  755,  780,  768, 2432,  734,

			  557,  581,  734,  764,  770,  773,  785, 2432,  867, 2432,
			 2432, 2432, 2432, 2432,  852, 2432, 2432, 2432, 2432, 2432,
			 2432, 2432, 2432, 2432, 2432, 2432, 2432, 2432, 2432, 2432,
			 2432,  466, 2432, 2432,  875,  542, 2432,  773, 2432,  880,
			 2432,  883,  762, 2432, 2432,  966,  887, 2432, 2432, 2432,
			 2432,  835, 2432,  888, 2432,  889,  893,  895,  897,  901,
			  903,  914, 2432,  905,  923, 2432,  930,  931,  947,  987,
			  996, 1029, 1037, 2432, 2432,  870,  637,  904,  321,  913,
			  916,  638,  718,  712,  702,  685,  678,  993,  648,  635,
			  634,  628,  624,  598,  580,  567,  543,  513,  507,  500,

			  498,  494,  492,  487, 2432, 2432, 1006,  954,  957,  963,
			  977,  980,  984, 1075, 1118, 2432, 1079, 1128, 1134, 1140,
			  568,  419, 1107,  417, 1149, 1153,  775,  817,  865,    0,
			    0,  886, 1116,    0,  909,  900,  937,  991, 1035, 1033,
			 1052, 1057, 1058,    0, 1061, 1146, 1086, 1116, 1130, 1138,
			 1141, 1149, 1146, 1151, 1141, 1157, 1154, 1159, 1146, 1158,
			 1154,    0, 1165, 1147, 1153, 1171, 1170, 1171, 1177, 1160,
			 1194, 1180, 1194, 1199, 1198, 1202, 1198, 1209, 1204, 1212,
			 1201, 1210, 1211, 1217, 1208,    0, 1160,  357, 1163,  488,
			 1173, 1176,  357, 1192, 1195, 2432, 1272,    0,  356, 1294,

			 2432, 2432, 2432, 1295, 1266, 1296, 1297, 2432, 1301, 2432,
			 2432, 2432, 1303, 1310, 1220, 1227, 1231, 1234, 1240, 1243,
			 2432, 2432, 2432, 2432, 2432, 1324, 1349, 2432, 2432, 2432,
			 2432, 2432, 2432, 2432, 2432, 2432, 2432, 2432, 2432, 2432,
			 2432, 2432, 2432, 2432, 1255, 1268, 1359, 1353, 1386, 1392,
			 1401, 1408, 1412, 1418, 1424,  690,  365,    0,  349,  390,
			 1431, 1440, 1310, 1337, 1344, 1374, 1404, 1409, 1414, 1407,
			 1422, 1414, 1430, 1429, 1419, 1435, 1431, 1423, 1428, 1425,
			 1426, 1440, 1425,    0, 1442, 1439, 1427, 1429, 1436, 1451,
			 1442,    0, 1449,    0,    0, 1451, 1524,    0, 1472, 1461,

			 1475, 1481, 1471, 1477, 1482, 1473, 1487, 1476, 1499, 1485,
			    0, 1488,    0,    0, 1500, 1500, 1486, 1496, 1508,    0,
			    0, 2432, 1553,  331, 1536, 2432, 1541, 2432, 1548, 2432,
			 1307, 1465,  364,  579, 1557,    0, 1561, 1579, 1586, 1594,
			 1611, 1620, 1628, 1506,    0,    0, 1518, 1550, 1559,    0,
			    0, 1544, 1600, 1551,    0, 1549, 1566, 1590, 1609, 1611,
			 1602, 1610,    0, 1608, 1615, 1625, 1622,    0, 1623, 1630,
			 1625,    0, 1630, 1666, 2432,  352, 1635, 1625, 1620, 1636,
			 1643, 1644, 1632, 1646, 1632,    0, 1635, 1659,    0,    0,
			 1660, 1665,    0, 1657, 1704,  286, 1709, 1710, 1729, 2432,

			 1683,  334, 1720,  361, 1731, 1736, 1740, 1762, 1772, 1791,
			    0,    0, 1701, 1686, 1714,    0, 1720, 1720, 1737, 1742,
			    0,    0, 1739,    0, 1745, 1753,    0, 1741, 1747, 1750,
			 1751, 1784, 1766, 2432,  344, 1775, 1770,    0, 1777, 1780,
			    0, 1790,    0,    0,    0, 1777, 1784,    0, 1779, 1815,
			  257, 1833, 1834, 1835,  295,  211,  217,  161,  201,  174,
			  164,  107, 1842, 1851, 1858, 1884, 1896, 1874, 1864, 1906,
			 1915, 1811, 1800,    0, 1822,    0, 1842, 1856, 1855, 1868,
			    0,    0, 1875,    0,    0, 1870, 1896, 1945, 1888, 1899,
			 1906,    0, 1905, 1908,    0, 1931,    0, 1949, 1950, 1951,

			 2432, 2432, 2432, 2432, 1927, 1947, 1959, 1963, 1969, 1976,
			 1997, 1980, 2001,    0, 1910,    0,    0, 1931,    0,    0,
			    0, 1945,    0, 2026, 1962, 1961,    0, 1978,    0,    0,
			 2012, 2038, 2432, 2432, 1981, 2029, 2033,    0, 1991,    0,
			 1995, 2015,    0,    0,   87, 2432,    0, 2026, 2011, 2012,
			 2013, 2015,    0, 2432, 2432, 2127, 2145, 2163, 2181, 2199,
			 2217, 2094, 2235, 2073, 2253, 2271, 2289, 2307, 2325, 2343,
			 2361, 1722, 2059, 2377, 2064, 2067, 2395, 2413, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  754,    1,  755,  755,  756,  756,  757,  757,  758,
			  758,  759,  759,  754,  754,  754,  754,  754,  760,  761,
			  754,  762,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  764,  754,  754,  754,  765,  765,  754,  754,
			  766,  767,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  760,  754,  768,  769,  760,  760,  760,  760,

			  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
			  760,  760,  760,  760,  760,  760,  760,  760,  761,  770,
			  770,  770,  770,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  771,  771,  772,  754,  754,  754,  754,  754,  754,
			  754,  754,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  754,  754,

			  754,  754,  754,  754,  754,  754,  764,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  765,  754,  754,  765,  766,  754,  767,  754,  754,
			  754,  754,  773,  754,  754,  768,  769,  754,  754,  754,
			  754,  760,  754,  760,  754,  760,  760,  760,  760,  760,
			  760,  760,  754,  760,  760,  754,  760,  760,  760,  760,
			  760,  760,  760,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,

			  754,  754,  754,  754,  754,  754,  770,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  771,  771,  771,  772,  754,  754,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  773,  773,  769,

			  754,  754,  754,  760,  760,  760,  760,  754,  760,  754,
			  754,  754,  760,  760,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  771,  771,  322,  772,  754,
			  754,  754,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,

			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  754,  754,  773,  760,  754,  760,  754,  760,  754,
			  754,  754,  754,  774,  774,  775,  754,  754,  754,  754,
			  754,  754,  754,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  754,  754,  754,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  754,  773,  760,  760,  760,  754,

			  774,  774,  774,  775,  754,  754,  754,  754,  754,  754,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  754,  776,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  754,
			  773,  760,  760,  760,  754,  600,  754,  774,  754,  602,
			  754,  775,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  754,  777,  760,  760,  760,

			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  754,  763,  763,  763,  763,  763,  763,
			  754,  760,  754,  754,  754,  754,  754,  763,  763,  763,
			  754,  763,  763,  763,  754,  754,  763,  754,  763,  754,
			  763,  754,  763,  754,    0,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,

			   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,    1,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   96,   96,   97,   97,   97,   97,   97,   97,

			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   98,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  100,  101,  101,
			   96,  102,  102,  102,  103,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    4,    3,    3,    5,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    6,    6,    7,    8,    3,    3,    3,    3,    3,    3,
			    3,    6,    6,    6,    6,    6,    6,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,   10,   11,    3,    3,    3,
			    3,   12,    3,    6,    6,    6,    6,    6,    6,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,   13,   14,    3,
			    3,   15,   16,   17,   17,   17,   18,    1,    1,    1,

			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    2,    3,    4,    5,
			    5,    5,    5,    5,    6,    8,   11,   13,   16,   19,
			   22,   25,   28,   31,   34,   37,   40,   43,   46,   49,
			   52,   55,   58,   61,   64,   67,   70,   73,   76,   79,
			   82,   85,   88,   91,   94,   97,  100,  103,  106,  109,
			  112,  115,  118,  121,  124,  127,  130,  133,  136,  139,
			  141,  144,  147,  150,  153,  156,  158,  160,  162,  164,
			  166,  168,  170,  172,  174,  176,  178,  180,  182,  184,
			  186,  188,  190,  192,  194,  196,  198,  200,  203,  205,
			  207,  208,  208,  209,  210,  211,  211,  212,  213,  214,

			  215,  216,  217,  218,  219,  220,  221,  222,  224,  225,
			  226,  228,  229,  230,  231,  232,  233,  234,  235,  236,
			  237,  238,  239,  240,  240,  240,  240,  240,  240,  240,
			  240,  240,  241,  242,  243,  244,  245,  246,  247,  248,
			  249,  250,  251,  251,  251,  251,  252,  253,  254,  255,
			  256,  257,  258,  259,  260,  261,  262,  263,  265,  266,
			  267,  268,  269,  270,  271,  272,  273,  275,  276,  277,
			  278,  279,  280,  281,  283,  284,  285,  287,  288,  289,
			  290,  291,  292,  293,  295,  296,  297,  298,  299,  300,
			  301,  302,  303,  304,  305,  306,  307,  308,  309,  310,

			  311,  311,  311,  311,  311,  311,  311,  312,  313,  313,
			  314,  315,  316,  317,  318,  318,  319,  320,  321,  322,
			  323,  324,  325,  326,  327,  328,  329,  330,  331,  332,
			  333,  334,  335,  336,  337,  338,  339,  341,  342,  343,
			  343,  344,  345,  346,  347,  349,  351,  352,  354,  356,
			  358,  360,  361,  363,  364,  366,  367,  368,  369,  370,
			  371,  372,  373,  374,  375,  376,  378,  379,  380,  381,
			  382,  383,  384,  385,  386,  388,  388,  388,  388,  388,
			  388,  388,  388,  389,  390,  391,  392,  393,  394,  395,
			  396,  397,  398,  399,  400,  401,  402,  403,  404,  405,

			  406,  407,  408,  409,  410,  412,  413,  414,  414,  414,
			  414,  414,  414,  414,  415,  415,  416,  417,  417,  418,
			  419,  421,  422,  424,  425,  426,  426,  427,  428,  429,
			  431,  433,  434,  435,  437,  438,  439,  440,  441,  442,
			  443,  444,  445,  446,  448,  449,  450,  451,  452,  453,
			  454,  455,  456,  457,  458,  459,  460,  461,  462,  463,
			  465,  466,  468,  469,  470,  471,  472,  473,  474,  475,
			  476,  477,  478,  479,  480,  481,  482,  483,  484,  485,
			  486,  487,  488,  489,  490,  491,  493,  493,  493,  493,
			  493,  493,  493,  493,  493,  493,  494,  494,  495,  496,

			  496,  498,  500,  502,  503,  504,  505,  506,  508,  509,
			  511,  513,  515,  516,  517,  517,  517,  517,  517,  517,
			  517,  518,  519,  520,  521,  522,  523,  524,  525,  526,
			  527,  528,  529,  530,  531,  532,  533,  534,  535,  536,
			  537,  538,  539,  540,  542,  542,  542,  543,  543,  544,
			  545,  545,  545,  546,  547,  548,  548,  548,  548,  548,
			  548,  549,  550,  551,  552,  553,  554,  555,  556,  557,
			  558,  559,  560,  561,  562,  563,  564,  566,  567,  568,
			  569,  570,  571,  572,  574,  575,  576,  577,  578,  579,
			  580,  581,  583,  584,  586,  588,  589,  591,  593,  594,

			  595,  596,  597,  598,  599,  600,  601,  602,  603,  604,
			  605,  607,  608,  610,  612,  613,  614,  615,  616,  617,
			  619,  621,  622,  622,  623,  624,  626,  627,  629,  630,
			  632,  632,  632,  633,  633,  633,  633,  634,  634,  635,
			  635,  636,  637,  638,  639,  641,  643,  644,  645,  646,
			  648,  650,  651,  652,  653,  655,  656,  657,  658,  659,
			  660,  661,  662,  664,  665,  666,  667,  668,  670,  671,
			  672,  673,  675,  676,  676,  677,  677,  678,  679,  680,
			  681,  682,  683,  684,  685,  686,  688,  689,  690,  692,
			  694,  695,  696,  698,  699,  699,  700,  701,  702,  703,

			  704,  704,  704,  704,  704,  704,  705,  706,  706,  706,
			  707,  709,  711,  712,  713,  714,  716,  717,  718,  719,
			  720,  722,  724,  725,  727,  728,  729,  731,  732,  733,
			  734,  735,  736,  737,  738,  738,  739,  740,  742,  743,
			  744,  746,  747,  749,  751,  753,  754,  755,  757,  758,
			  758,  759,  760,  761,  762,  762,  762,  762,  762,  762,
			  762,  762,  762,  762,  763,  764,  764,  764,  765,  765,
			  766,  766,  767,  768,  770,  771,  773,  774,  775,  776,
			  777,  779,  781,  782,  784,  786,  787,  788,  789,  790,
			  791,  792,  794,  795,  796,  798,  798,  800,  801,  802,

			  803,  805,  806,  808,  809,  810,  810,  811,  811,  812,
			  813,  813,  813,  814,  816,  817,  819,  821,  822,  824,
			  826,  828,  829,  831,  831,  832,  833,  835,  836,  838,
			  840,  840,  841,  843,  845,  846,  846,  847,  849,  850,
			  852,  852,  853,  855,  857,  857,  859,  861,  861,  862,
			  862,  863,  863,  865,  866,  866, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  187,  187,  189,  189,  220,  218,  219,    1,  218,
			  219,    1,  219,   36,  218,  219,  190,  218,  219,   41,
			  218,  219,   14,  218,  219,  156,  218,  219,   24,  218,
			  219,   25,  218,  219,   32,  218,  219,   30,  218,  219,
			    9,  218,  219,   31,  218,  219,   13,  218,  219,   33,
			  218,  219,  120,  218,  219,  120,  218,  219,  120,  218,
			  219,    8,  218,  219,    7,  218,  219,   18,  218,  219,
			   17,  218,  219,   19,  218,  219,   11,  218,  219,  118,
			  218,  219,  118,  218,  219,  118,  218,  219,  118,  218,
			  219,  118,  218,  219,  118,  218,  219,  118,  218,  219,

			  118,  218,  219,  118,  218,  219,  118,  218,  219,  118,
			  218,  219,  118,  218,  219,  118,  218,  219,  118,  218,
			  219,  118,  218,  219,  118,  218,  219,  118,  218,  219,
			  118,  218,  219,  118,  218,  219,   28,  218,  219,  218,
			  219,   29,  218,  219,   34,  218,  219,   26,  218,  219,
			   27,  218,  219,   12,  218,  219,  218,  219,  218,  219,
			  218,  219,  218,  219,  218,  219,  218,  219,  218,  219,
			  191,  219,  217,  219,  215,  219,  216,  219,  187,  219,
			  187,  219,  186,  219,  185,  219,  187,  219,  189,  219,
			  188,  219,  183,  219,  183,  219,  182,  219,    6,  219,

			    5,    6,  219,    5,  219,    6,  219,    1,  190,  179,
			  190,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  190,  190, -400,  190,  190,  190, -400,  190,  190,
			  190,  190,  190,  190,  190,   41,  156,  156,  156,  156,
			    2,   35,   10,  126,   39,   23,   22,  126,  120,  120,
			  119,  119,   15,   37,   20,   21,   38,   16,  118,  118,
			  118,  118,  118,   48,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,   62,  118,  118,  118,  118,  118,  118,
			  118,   74,  118,  118,  118,   81,  118,  118,  118,  118,
			  118,  118,  118,   93,  118,  118,  118,  118,  118,  118,

			  118,  118,  118,  118,  118,  118,  118,  118,  118,   40,
			   42,  191,  215,  208,  206,  207,  209,  210,  211,  212,
			  192,  193,  194,  195,  196,  197,  198,  199,  200,  201,
			  202,  203,  204,  205,  187,  186,  185,  187,  187,  184,
			  185,  189,  188,  182,    5,    4,  180,  177,  180,  190,
			 -400, -400,  164,  180,  162,  180,  163,  180,  165,  180,
			  190,  158,  180,  190,  159,  180,  190,  190,  190,  190,
			  190,  190,  190, -181,  190,  190,  166,  180,  190,  190,
			  190,  190,  190,  190,  190,  156,  127,  156,  156,  156,
			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,

			  156,  156,  156,  156,  156,  156,  156,  156,  156,  156,
			  129,  156,  127,  156,  126,  121,  126,  120,  120,  124,
			  125,  125,  123,  125,  122,  120,  118,  118,  118,   46,
			  118,   47,  118,  118,  118,   52,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,   65,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,   85,  118,  118,   88,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  117,  118,  214,    4,    4,  167,  180,  160,  180,

			  161,  180,  190,  190,  190,  190,  174,  180,  190,  169,
			  180,  168,  180,  178,  180,  190,  190,  146,  144,  145,
			  147,  148,  157,  157,  149,  150,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,  140,  141,  142,  143,
			  128,  156,  126,  126,  126,  126,  120,  120,  120,  120,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,   63,  118,  118,  118,  118,  118,
			  118,  118,   72,  118,  118,  118,  118,  118,  118,  118,
			  118,   82,  118,  118,   84,  118,   86,  118,  118,   91,
			  118,   92,  118,  118,  118,  118,  118,  118,  118,  118,

			  118,  118,  118,  118,  118,  106,  118,  118,  108,  118,
			  109,  118,  118,  118,  118,  118,  118,  115,  118,  116,
			  118,  213,    4,  190,  170,  180,  190,  173,  180,  190,
			  176,  180,  157,  126,  126,  126,  126,  120,  118,   44,
			  118,   45,  118,  118,  118,  118,   53,  118,   54,  118,
			  118,  118,  118,   59,  118,  118,  118,  118,  118,  118,
			  118,  118,   70,  118,  118,  118,  118,  118,   77,  118,
			  118,  118,  118,   83,  118,  118,   89,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  103,  118,  118,  118,
			  107,  118,  110,  118,  118,  118,  113,  118,  118,    4,

			  190,  190,  190,  151,  126,  126,  126,   43,  118,   49,
			  118,  118,  118,  118,   56,  118,  118,  118,  118,  118,
			   64,  118,   66,  118,  118,   68,  118,  118,  118,   73,
			  118,  118,  118,  118,  118,  118,  118,   90,  118,  118,
			   96,  118,  118,  118,   99,  118,  118,  101,  118,  102,
			  118,  104,  118,  118,  118,  112,  118,  118,    4,  190,
			  190,  190,  126,  126,  126,  126,  118,  118,   55,  118,
			  118,   58,  118,  118,  118,  118,  118,   71,  118,   75,
			  118,  118,   78,  118,   79,  118,  118,  118,  118,  118,
			  118,  118,  100,  118,  118,  118,  114,  118,    3,    4,

			  190,  190,  190,  154,  155,  155,  153,  155,  152,  126,
			  126,  126,  126,  126,   50,  118,  118,   57,  118,   60,
			  118,  118,   67,  118,   69,  118,   76,  118,  118,   87,
			  118,  118,  118,   97,  118,  118,  105,  118,  111,  118,
			  190,  172,  180,  175,  180,  126,  126,   51,  118,  118,
			   80,  118,  118,   95,  118,   98,  118,  171,  180,   61,
			  118,  118,  118,   94,  118,   94, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2432
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 754
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 755
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 219
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 220
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = true
			-- Is `position' used?

	INITIAL: INTEGER = 0
	SPECIAL_STR: INTEGER = 1
	VERBATIM_STR1: INTEGER = 2
	VERBATIM_STR2: INTEGER = 3
	VERBATIM_STR3: INTEGER = 4
	PRAGMA: INTEGER = 5
			-- Start condition codes

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class EIFFEL_SCANNER
