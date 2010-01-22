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
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version = provisional_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_ACROSS, Current)
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
			
when 43 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 47 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 48 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 49 then
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
			
when 50 then
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
			
when 51 then
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
			
when 52 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 53 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 54 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 55 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 56 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 57 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 58 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 59 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 60 then
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
			
when 61 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 62 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 63 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 64 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 65 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 66 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 67 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 68 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 69 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 71 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 72 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 73 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 74 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 75 then
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
					last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
					last_token := TE_INDEXING
					if has_syntax_warning and then syntax_version /= obsolete_64_syntax then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Usage of `indexing' has been replace by `note'."))
					end

				end
			
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 77 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 78 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 79 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 80 then
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
					last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
					last_token := TE_IS
					if has_syntax_warning and then syntax_version /= obsolete_64_syntax then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Usage of `is' has now been deprecated."))
					end
				end

			
when 81 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 82 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 83 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 84 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 85 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version /= obsolete_64_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_NOTE, Current)
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
			
when 86 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 87 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 88 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 89 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING
			
when 90 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 91 then
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
			
when 92 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 93 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 94 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 96 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 97 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 99 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 103 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 104 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				if syntax_version = provisional_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_SOME, Current)
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
			
when 106 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 107 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 108 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_TUPLE
				process_id_as
			
when 110 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 111 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 112 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 113 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_ID
				process_id_as
			
when 118 then
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
			
when 119 then
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
			
when 120 then
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
			
when 121 then
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
			
when 122 then
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
			
when 123 then
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
			
when 124 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				report_invalid_integer_error (token_buffer)
			
when 125 then
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
			
when 126 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as (text_item (2), line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 127 then
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
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%A', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%B', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%C', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%D', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%F', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%H', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%L', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%N', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%Q', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%R', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%S', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%T', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%U', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%V', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%%', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%"', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 145 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%(', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 146 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%)', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 147 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%<', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 148 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%>', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 149 then
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
			
when 150 then
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

				report_invalid_integer_error (token_buffer)
			
when 154 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 155 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 156 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_LT)
			
when 157 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_GT)
			
when 158 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_LE)
			
when 159 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_GE)
			
when 160 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_PLUS)
			
when 161 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_MINUS)
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_STAR)
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_SLASH)
			
when 164 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_POWER)
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_DIV)
			
when 166 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_MOD)
			
when 167 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_BRACKET)
			
when 168 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_AND)
			
when 169 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_AND_THEN)
			
when 170 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_IMPLIES)
			
when 171 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_NOT)
			
when 172 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_OR)
			
when 173 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_OR_ELSE)
			
when 174 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_XOR)
			
when 175 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_STR_FREE)
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				process_simple_string_as (TE_EMPTY_STRING)
			
when 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 178 then
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
			
when 179 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				set_start_condition (VERBATIM_STR1)
			
when 180 then
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
			
when 181 then
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
			
when 182 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 183 then
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
			
when 184 then
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
			
when 185 then
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
			
when 186 then
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
			
when 187 then
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
			
when 188 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 210 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 211 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 212 then
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
			
when 213 then
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
			
when 214 then
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
			
when 215 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				report_unknown_token_error (text_item (1))
			
when 216 then
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
			create an_array.make (0, 2067)
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
			   19,   63,   64,   66,   66,  585,   67,   67,  108,   68,

			   68,   70,   71,   70,  626,   72,   70,   71,   70,  109,
			   72,   77,   78,   77,   77,   78,   77,   80,   81,   80,
			   80,   81,   80,   83,   83,   83,   83,   83,   83,  106,
			  136,  107,   82,  124,  125,   82,  126,  127,   84,  112,
			  110,   84,  111,  111,  111,  111,  115,  113,  116,  116,
			  117,  117,  156,  154,  161,  163,  142,  675,   73,  155,
			  118,  119,  136,   73,  580,  115,  143,  116,  116,  117,
			  117,  162,  115,  625,  117,  117,  117,  117,  170,  122,
			  202,  173,  120,  203,  156,  154,  161,  163,  142,  121,
			   73,  155,  118,  119,  581,   73,   86,   87,  143,   88,

			   87,  268,  268,  162,   89,   90,  581,   91,  121,   92,
			  170,  122,  114,  173,  120,  121,   93,  624,   94,  174,
			   87,   95,  130,  216,  147,  144,  131,  145,  148,   96,
			  274,  132,  275,  133,   97,   98,  137,  146,  134,  135,
			  138,  149,  202,  139,   99,  206,  140,  100,  101,  141,
			  102,  174,  675,   95,  130,  216,  147,  144,  131,  145,
			  148,   96,  274,  132,  275,  133,   97,   98,  137,  146,
			  134,  135,  138,  149,  171,  139,   99,  150,  140,  103,
			   87,  141,  157,  278,  151,  152,  164,  167,  172,  279,
			  153,  280,  158,  281,  159,  282,  165,  168,  160,  283,

			  169,  166,  209,  210,  209,  213,  171,  284,   88,  150,
			  211,  211,  211,  623,  157,  278,  151,  152,  164,  167,
			  172,  279,  153,  280,  158,  281,  159,  282,  165,  168,
			  160,  283,  169,  166,  178,  178,  178,  285,  179,  284,
			  619,  180,  498,  181,  182,  183,  204,  202,  204,  574,
			  203,  184,  211,  211,  211,  286,  103,  448,  185,  217,
			  186,  559,   88,  187,  188,  189,  190,  524,  191,  285,
			  192,   83,   83,   83,  193,  218,  194,  520,   88,  195,
			  196,  197,  198,  199,  200,  290,   84,  286,  103,   85,
			   85,  295,   85,  219,  214,  220,   88,   88,   88,  222,

			  296,  224,   88,  205,   88,  270,  270,  270,  221,  213,
			  103,  213,   88,  213,   88,  213,   88,  290,   88,  297,
			  223,  263,  225,  295,  213,  293,  103,   88,  202,  294,
			  235,  203,  296,   88,  385,  205,  231,  232,  231,  383,
			  213,  298,  103,   88,  103,  215,  103,  226,  227,  450,
			  103,  297,  103,  213,  228,  229,   88,  293,  103,  385,
			  103,  294,  103,  230,  103,  304,  103,  231,  232,  231,
			  383,  213,  372,  298,   88,  103,  103,  215,  103,  226,
			  227,  103,  103,  371,  103,  202,  228,  229,  206,  268,
			  268,  103,  103,  233,  103,  230,  103,  304,  103,  261,

			  261,  261,  261,  307,  103,  234,  115,  103,  267,  267,
			  267,  267,  308,  103,  262,  263,  309,  264,  264,  264,
			  264,  305,  103,  103,  115,  312,  266,  266,  267,  267,
			  382,  276,  265,  306,  277,  307,  103,  313,  122,  370,
			  178,  178,  178,  369,  308,  368,  262,  334,  309,  121,
			  209,  210,  209,  305,  103,  238,  367,  312,  239,  366,
			  240,  241,  242,  276,  265,  306,  277,  121,  243,  313,
			  122,  272,  272,  272,  272,  244,  322,  245,  365,  291,
			  246,  247,  248,  249,  287,  250,  364,  251,  288,  363,
			  323,  252,  324,  253,  292,  310,  254,  255,  256,  257,

			  258,  259,  289,  299,  311,  300,  320,  301,  322,  325,
			  321,  291,  273,  326,  330,  314,  287,  315,  302,  331,
			  288,  303,  323,  332,  324,  316,  292,  310,  317,  333,
			  318,  319,  268,  268,  289,  299,  311,  300,  320,  301,
			  362,  325,  321,  327,  361,  326,  330,  314,  328,  315,
			  302,  331,  360,  303,  584,  332,  359,  316,  358,  329,
			  317,  333,  318,  319,  335,  335,  335,  335,  204,  202,
			  204,  339,  203,  382,   88,  327,  211,  211,  211,  357,
			  328,   85,  231,  232,  231,  340,  214,  341,   88,   88,
			   88,  329,  338,  232,  338,  213,  585,  213,   88,  213,

			   88,  213,   88,  345,   88,  346,  525,  525,   88,  231,
			  232,  231,  348,  213,  349,   88,   88,   88,  355,  356,
			  356,  356,  103,  342,  354,  205,  389,  373,  373,  373,
			  373,  270,  270,  270,  390,  391,  103,  215,  103,  343,
			  353,  344,  262,  347,  392,  393,  103,  216,  103,  395,
			  103,  396,  103,  352,  103,  342,  103,  205,  389,  527,
			  527,  527,  394,  103,  103,  103,  390,  391,  103,  215,
			  103,  343,  384,  344,  262,  347,  392,  393,  103,  216,
			  103,  395,  103,  396,  103,  374,  351,  374,  103,  350,
			  375,  375,  375,  375,  394,  103,  103,  103,  376,  376,

			  376,  376,  378,  397,  378,  398,  399,  379,  379,  379,
			  379,  400,  115,  377,  380,  380,  381,  381,  115,  401,
			  381,  381,  381,  381,  402,  386,  122,  387,  387,  387,
			  387,  388,  388,  388,  388,  397,  337,  398,  399,  403,
			  208,  404,  407,  400,  408,  377,  405,  409,  412,  410,
			  413,  401,  414,  415,  416,  121,  402,  417,  122,  418,
			  406,  121,  411,  419,  420,  421,  422,  423,  273,  424,
			  425,  403,  273,  404,  407,  428,  408,  429,  405,  409,
			  412,  410,  413,  430,  414,  415,  416,  426,  431,  417,
			  427,  418,  406,  432,  411,  419,  420,  421,  422,  423,

			  434,  424,  425,  435,  436,  437,  438,  428,  439,  429,
			  440,  433,  441,  442,  443,  430,  444,  445,  446,  426,
			  431,  447,  427,  177,  260,  432,  448,  449,  449,  449,
			  449,  213,  434,  237,   88,  435,  436,  437,  438,  468,
			  439,  108,  440,  433,  441,  442,  443,  212,  444,  445,
			  446,  469,  470,  447,  338,  232,  338,  451,  208,  452,
			  454,  213,   88,   88,   88,  456,  177,  453,   88,  175,
			  128,  468,  457,  356,  356,  356,  356,  457,  356,  356,
			  356,  356,  103,  469,  470,  458,  459,  471,  472,  473,
			  455,  461,  461,  461,  461,  375,  375,  375,  375,  453, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  375,  375,  123,  675,  262,  460,   75,  216,
			  103,  103,  103,  474,  103,  475,  103,  458,  459,  471,
			  472,  473,  455,   75,  675,  463,  463,  463,  463,  464,
			  675,  464,  462,  675,  465,  465,  465,  465,  262,  460,
			  377,  216,  103,  103,  103,  474,  675,  475,  103,  379,
			  379,  379,  379,  379,  379,  379,  379,  466,  476,  380,
			  380,  381,  381,  466,  477,  381,  381,  381,  381,  478,
			  479,  122,  377,  386,  675,  467,  467,  467,  467,  386,
			  480,  388,  388,  388,  388,  481,  482,  483,  484,  485,
			  476,  486,  487,  488,  489,  490,  477,  491,  492,  493,

			  273,  478,  479,  122,  494,  495,  273,  496,  497,  269,
			  269,  269,  480,  675,  501,  502,  273,  481,  482,  483,
			  484,  485,  273,  486,  487,  488,  489,  490,  503,  491,
			  492,  493,  504,  505,  506,  507,  494,  495,  508,  496,
			  497,  498,  498,  498,  509,  499,  501,  502,  510,  511,
			  512,  513,  514,  515,  516,  517,  500,  518,  213,  213,
			  503,   88,   88,  535,  504,  505,  506,  507,  675,  675,
			  508,  448,  519,  519,  519,  519,  509,  675,  675,  536,
			  510,  511,  512,  513,  514,  515,  516,  517,  675,  518,
			  675,  537,  522,  213,  675,  535,   88,  675,  461,  461,

			  461,  461,  521,  530,  530,  530,  530,  538,  539,  103,
			  103,  536,  675,  529,  542,  531,  531,  531,  531,  465,
			  465,  465,  465,  537,  522,  465,  465,  465,  465,  523,
			  377,  543,  544,  263,  521,  531,  531,  531,  531,  538,
			  539,  103,  103,  540,  103,  529,  542,  541,  545,  534,
			  533,  388,  388,  388,  388,  546,  532,  547,  548,  549,
			  675,  523,  377,  543,  544,  550,  551,  552,  553,  554,
			  555,  556,  557,  675,  675,  540,  103,  675,  560,  541,
			  545,  561,  533,  562,  563,  564,  565,  546,  675,  547,
			  548,  549,  121,  566,  567,  568,  569,  550,  551,  552,

			  553,  554,  555,  556,  557,  498,  498,  498,  570,  558,
			  560,  571,  572,  561,  573,  562,  563,  564,  565,  213,
			  500,  213,   88,  675,   88,  566,  567,  568,  569,  675,
			  213,  675,  675,   88,  578,  525,  525,  595,  675,  596,
			  570,  675,  597,  571,  572,  598,  573,  599,  675,  675,
			  576,  575,  582,  527,  527,  527,  586,  675,  586,  675,
			  600,  587,  587,  587,  587,  588,  588,  588,  588,  595,
			  103,  596,  103,  577,  597,  675,  579,  598,  675,  599,
			  589,  103,  576,  575,  531,  531,  531,  531,  591,  591,
			  591,  591,  600,  263,  583,  591,  591,  591,  591,  590,

			  601,  592,  103,  592,  103,  577,  593,  593,  593,  593,
			  594,  602,  589,  103,  603,  604,  605,  606,  607,  608,
			  609,  610,  611,  612,  613,  614,  615,  616,  617,  618,
			  675,  590,  601,  213,  213,  213,   88,   88,   88,  271,
			  271,  271,  594,  602,  675,  675,  603,  604,  605,  606,
			  607,  608,  609,  610,  611,  612,  613,  614,  615,  616,
			  617,  618,  620,  675,  622,  587,  587,  587,  587,  587,
			  587,  587,  587,  627,  627,  627,  627,  621,  593,  593,
			  593,  593,  636,  637,  103,  103,  103,  638,  589,  632,
			  632,  632,  632,  628,  620,  628,  622,  639,  629,  629,

			  629,  629,  640,  641,  633,  630,  642,  630,  643,  621,
			  631,  631,  631,  631,  636,  637,  103,  103,  103,  638,
			  589,  593,  593,  593,  593,  634,  644,  634,  645,  639,
			  635,  635,  635,  635,  640,  641,  633,  648,  642,  649,
			  643,  646,  646,  646,  650,  651,  652,  213,  654,  655,
			   88,   88,   88,  675,  589,  526,  526,  526,  644,  675,
			  645,  629,  629,  629,  629,  629,  629,  629,  629,  648,
			  659,  649,  647,  675,  675,  660,  650,  651,  652,  675,
			  462,  631,  631,  631,  631,  653,  589,  631,  631,  631,
			  631,  656,  656,  656,  656,  661,  663,  664,  103,  103,

			  103,  665,  659,  657,  647,  657,  633,  660,  658,  658,
			  658,  658,  635,  635,  635,  635,  633,  653,  635,  635,
			  635,  635,  646,  646,  646,  667,  668,  661,  663,  664,
			  103,  103,  103,  665,  669,  670,  666,  671,  633,   88,
			  672,  673,  532,  658,  658,  658,  658,  674,  633,  658,
			  658,  658,  658,  662,  528,  528,  528,  667,  668,  675,
			  675,  675,  675,  675,  675,  675,  669,  670,  675,  671,
			  675,  675,  672,  673,  675,  675,  675,  675,  675,  674,
			  675,  675,  675,  675,  104,  662,  104,  103,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  129,  129,  129,

			  129,  129,  129,  129,  129,  129,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  103,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   85,  675,   85,   85,   85,

			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			  105,  675,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  176,  675,  176,  176,  176,
			  675,  176,  176,  176,  176,  176,  176,  176,  176,  176,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  205,  205,  205,  205,  205,
			  205,  205,  205,  205,  205,  205,  205,  205,  205,  205,
			  207,  207,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,   87,  675,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,

			   88,  675,   88,  675,   88,   88,   88,   88,   88,   88,
			   88,   88,   88,   88,   88,  236,  675,  236,  236,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  336,  675,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  619,  675,  619,  619,  619,  619,  619,  619,  619,  619,
			  619,  619,  619,  619,  619,   13,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675, yy_Dummy>>,
			1, 68, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2067)
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
			    1,    1,    1,    3,    4,  585,    3,    4,   27,    3,

			    4,    5,    5,    5,  584,    5,    6,    6,    6,   27,
			    6,    9,    9,    9,   10,   10,   10,   11,   11,   11,
			   12,   12,   12,   15,   15,   15,   16,   16,   16,   21,
			   40,   21,   11,   35,   35,   12,   37,   37,   15,   29,
			   28,   16,   28,   28,   28,   28,   30,   29,   30,   30,
			   30,   30,   48,   47,   50,   51,   42,  583,    5,   47,
			   30,   30,   40,    6,  526,   31,   42,   31,   31,   31,
			   31,   50,   32,  582,   32,   32,   32,   32,   54,   31,
			   69,   56,   30,   69,   48,   47,   50,   51,   42,   30,
			    5,   47,   30,   30,  581,    6,   18,   18,   42,   18,

			   18,  118,  118,   50,   18,   18,  526,   18,   31,   18,
			   54,   31,   29,   56,   30,   32,   18,  580,   18,   57,
			   18,   18,   39,   88,   44,   43,   39,   43,   44,   18,
			  130,   39,  131,   39,   18,   18,   41,   43,   39,   39,
			   41,   44,   73,   41,   18,   73,   41,   18,   18,   41,
			   18,   57,  579,   18,   39,   88,   44,   43,   39,   43,
			   44,   18,  130,   39,  131,   39,   18,   18,   41,   43,
			   39,   39,   41,   44,   55,   41,   18,   46,   41,   18,
			   18,   41,   49,  133,   46,   46,   52,   53,   55,  134,
			   46,  135,   49,  136,   49,  137,   52,   53,   49,  138,

			   53,   52,   77,   77,   77,   85,   55,  139,   85,   46,
			   80,   80,   80,  578,   49,  133,   46,   46,   52,   53,
			   55,  134,   46,  135,   49,  136,   49,  137,   52,   53,
			   49,  138,   53,   52,   68,   68,   68,  140,   68,  139,
			  574,   68,  559,   68,   68,   68,   70,   70,   70,  520,
			   70,   68,   81,   81,   81,  141,   85,  519,   68,   89,
			   68,  500,   89,   68,   68,   68,   68,  457,   68,  140,
			   68,   83,   83,   83,   68,   90,   68,  450,   90,   68,
			   68,   68,   68,   68,   68,  144,   83,  141,   85,   87,
			   87,  147,   87,   91,   87,   92,   91,   87,   92,   93,

			  148,   94,   93,   70,   94,  119,  119,  119,   92,   95,
			   89,   96,   95,   98,   96,   97,   98,  144,   97,  149,
			   93,  386,   94,  147,   99,  146,   90,   99,  201,  146,
			  102,  201,  148,  102,  385,   70,  100,  100,  100,  383,
			  100,  151,   89,  100,   91,   87,   92,   95,   96,  337,
			   93,  149,   94,  101,   97,   98,  101,  146,   90,  271,
			   95,  146,   96,   99,   98,  154,   97,  103,  103,  103,
			  269,  103,  259,  151,  103,   99,   91,   87,   92,   95,
			   96,  102,   93,  258,   94,  205,   97,   98,  205,  268,
			  268,  100,   95,  100,   96,   99,   98,  154,   97,  111,

			  111,  111,  111,  156,  101,  101,  117,   99,  117,  117,
			  117,  117,  157,  102,  111,  115,  158,  115,  115,  115,
			  115,  155,  103,  100,  116,  161,  116,  116,  116,  116,
			  268,  132,  115,  155,  132,  156,  101,  162,  116,  257,
			  178,  178,  178,  256,  157,  255,  111,  178,  158,  117,
			  209,  209,  209,  155,  103,  106,  254,  161,  106,  253,
			  106,  106,  106,  132,  115,  155,  132,  116,  106,  162,
			  116,  121,  121,  121,  121,  106,  165,  106,  252,  145,
			  106,  106,  106,  106,  142,  106,  251,  106,  142,  250,
			  166,  106,  167,  106,  145,  159,  106,  106,  106,  106,

			  106,  106,  142,  152,  159,  152,  164,  152,  165,  168,
			  164,  145,  121,  169,  171,  163,  142,  163,  152,  172,
			  142,  152,  166,  173,  167,  163,  145,  159,  163,  174,
			  163,  163,  382,  382,  142,  152,  159,  152,  164,  152,
			  249,  168,  164,  170,  248,  169,  171,  163,  170,  163,
			  152,  172,  247,  152,  528,  173,  246,  163,  245,  170,
			  163,  174,  163,  163,  184,  184,  184,  184,  204,  204,
			  204,  221,  204,  382,  221,  170,  211,  211,  211,  244,
			  170,  215,  215,  215,  215,  223,  215,  225,  223,  215,
			  225,  170,  216,  216,  216,  226,  528,  228,  226,  227,

			  228,  230,  227,  229,  230,  229,  458,  458,  229,  231,
			  231,  231,  233,  231,  234,  233,  231,  234,  243,  243,
			  243,  243,  221,  226,  242,  204,  274,  261,  261,  261,
			  261,  270,  270,  270,  275,  276,  223,  215,  225,  227,
			  241,  228,  261,  230,  279,  280,  226,  216,  228,  282,
			  227,  283,  230,  240,  221,  226,  229,  204,  274,  459,
			  459,  459,  280,  233,  231,  234,  275,  276,  223,  215,
			  225,  227,  270,  228,  261,  230,  279,  280,  226,  216,
			  228,  282,  227,  283,  230,  262,  239,  262,  229,  238,
			  262,  262,  262,  262,  280,  233,  231,  234,  264,  264,

			  264,  264,  265,  284,  265,  285,  286,  265,  265,  265,
			  265,  287,  266,  264,  266,  266,  266,  266,  267,  288,
			  267,  267,  267,  267,  289,  272,  266,  272,  272,  272,
			  272,  273,  273,  273,  273,  284,  212,  285,  286,  290,
			  207,  292,  294,  287,  295,  264,  293,  296,  298,  297,
			  299,  288,  300,  301,  302,  266,  289,  303,  266,  304,
			  293,  267,  297,  305,  306,  307,  308,  310,  272,  311,
			  312,  290,  273,  292,  294,  314,  295,  315,  293,  296,
			  298,  297,  299,  316,  300,  301,  302,  313,  317,  303,
			  313,  304,  293,  318,  297,  305,  306,  307,  308,  310,

			  319,  311,  312,  320,  321,  322,  323,  314,  324,  315,
			  325,  318,  326,  327,  328,  316,  329,  330,  331,  313,
			  317,  332,  313,  176,  107,  318,  335,  335,  335,  335,
			  335,  343,  319,  105,  343,  320,  321,  322,  323,  389,
			  324,   84,  325,  318,  326,  327,  328,   82,  329,  330,
			  331,  390,  391,  332,  338,  338,  338,  342,   74,  342,
			  344,  345,  342,  344,  345,  347,   65,  343,  347,   59,
			   38,  389,  355,  355,  355,  355,  355,  356,  356,  356,
			  356,  356,  343,  390,  391,  355,  355,  392,  393,  394,
			  345,  373,  373,  373,  373,  374,  374,  374,  374,  343, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  375,  375,   33,   13,  373,  355,    8,  338,
			  342,  344,  345,  395,  343,  396,  347,  355,  355,  392,
			  393,  394,  345,    7,    0,  376,  376,  376,  376,  377,
			    0,  377,  373,    0,  377,  377,  377,  377,  373,  355,
			  376,  338,  342,  344,  345,  395,    0,  396,  347,  378,
			  378,  378,  378,  379,  379,  379,  379,  380,  397,  380,
			  380,  380,  380,  381,  398,  381,  381,  381,  381,  399,
			  400,  380,  376,  387,    0,  387,  387,  387,  387,  388,
			  401,  388,  388,  388,  388,  402,  403,  404,  405,  406,
			  397,  407,  408,  409,  411,  412,  398,  413,  414,  415,

			  380,  399,  400,  380,  416,  417,  381,  419,  422,  692,
			  692,  692,  401,    0,  425,  426,  387,  402,  403,  404,
			  405,  406,  388,  407,  408,  409,  411,  412,  427,  413,
			  414,  415,  428,  429,  430,  431,  416,  417,  432,  419,
			  422,  423,  423,  423,  433,  423,  425,  426,  434,  435,
			  436,  438,  441,  442,  443,  444,  423,  445,  451,  453,
			  427,  451,  453,  468,  428,  429,  430,  431,    0,    0,
			  432,  449,  449,  449,  449,  449,  433,    0,    0,  471,
			  434,  435,  436,  438,  441,  442,  443,  444,    0,  445,
			    0,  472,  453,  455,    0,  468,  455,    0,  461,  461,

			  461,  461,  451,  462,  462,  462,  462,  473,  476,  451,
			  453,  471,    0,  461,  478,  463,  463,  463,  463,  464,
			  464,  464,  464,  472,  453,  465,  465,  465,  465,  455,
			  463,  480,  481,  466,  451,  466,  466,  466,  466,  473,
			  476,  451,  453,  477,  455,  461,  478,  477,  482,  467,
			  466,  467,  467,  467,  467,  483,  463,  484,  485,  486,
			    0,  455,  463,  480,  481,  488,  489,  490,  491,  493,
			  494,  495,  497,    0,    0,  477,  455,    0,  501,  477,
			  482,  502,  466,  503,  504,  505,  506,  483,    0,  484,
			  485,  486,  467,  507,  508,  509,  511,  488,  489,  490,

			  491,  493,  494,  495,  497,  498,  498,  498,  512,  498,
			  501,  515,  516,  502,  518,  503,  504,  505,  506,  521,
			  498,  522,  521,    0,  522,  507,  508,  509,  511,    0,
			  523,    0,    0,  523,  525,  525,  525,  537,    0,  538,
			  512,    0,  539,  515,  516,  541,  518,  542,    0,    0,
			  522,  521,  527,  527,  527,  527,  529,    0,  529,    0,
			  543,  529,  529,  529,  529,  530,  530,  530,  530,  537,
			  521,  538,  522,  523,  539,    0,  525,  541,    0,  542,
			  530,  523,  522,  521,  531,  531,  531,  531,  532,  532,
			  532,  532,  543,  534,  527,  534,  534,  534,  534,  531,

			  544,  533,  521,  533,  522,  523,  533,  533,  533,  533,
			  534,  547,  530,  523,  549,  550,  552,  553,  554,  555,
			  556,  557,  560,  561,  563,  564,  566,  570,  571,  573,
			    0,  531,  544,  575,  576,  577,  575,  576,  577,  693,
			  693,  693,  534,  547,    0,    0,  549,  550,  552,  553,
			  554,  555,  556,  557,  560,  561,  563,  564,  566,  570,
			  571,  573,  575,    0,  577,  586,  586,  586,  586,  587,
			  587,  587,  587,  588,  588,  588,  588,  576,  592,  592,
			  592,  592,  595,  596,  575,  576,  577,  598,  588,  591,
			  591,  591,  591,  589,  575,  589,  577,  600,  589,  589,

			  589,  589,  601,  602,  591,  590,  603,  590,  606,  576,
			  590,  590,  590,  590,  595,  596,  575,  576,  577,  598,
			  588,  593,  593,  593,  593,  594,  609,  594,  610,  600,
			  594,  594,  594,  594,  601,  602,  591,  612,  603,  613,
			  606,  611,  611,  611,  614,  616,  617,  620,  621,  622,
			  620,  621,  622,    0,  627,  695,  695,  695,  609,    0,
			  610,  628,  628,  628,  628,  629,  629,  629,  629,  612,
			  637,  613,  611,    0,    0,  640,  614,  616,  617,    0,
			  627,  630,  630,  630,  630,  620,  627,  631,  631,  631,
			  631,  632,  632,  632,  632,  644,  647,  648,  620,  621,

			  622,  650,  637,  633,  611,  633,  632,  640,  633,  633,
			  633,  633,  634,  634,  634,  634,  656,  620,  635,  635,
			  635,  635,  646,  646,  646,  660,  662,  644,  647,  648,
			  620,  621,  622,  650,  663,  668,  653,  669,  632,  653,
			  670,  671,  656,  657,  657,  657,  657,  672,  656,  658,
			  658,  658,  658,  646,  696,  696,  696,  660,  662,    0,
			    0,    0,    0,    0,    0,    0,  663,  668,    0,  669,
			    0,    0,  670,  671,    0,    0,    0,    0,    0,  672,
			    0,    0,    0,    0,  682,  646,  682,  653,  682,  682,
			  682,  682,  682,  682,  682,  682,  682,  684,  684,  684,

			  684,  684,  684,  684,  684,  684,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  653,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  677,  677,  677,  677,  677,
			  677,  677,  677,  677,  677,  677,  677,  677,  677,  677,
			  678,  678,  678,  678,  678,  678,  678,  678,  678,  678,
			  678,  678,  678,  678,  678,  679,  679,  679,  679,  679,
			  679,  679,  679,  679,  679,  679,  679,  679,  679,  679,
			  680,  680,  680,  680,  680,  680,  680,  680,  680,  680,
			  680,  680,  680,  680,  680,  681,    0,  681,  681,  681,

			  681,  681,  681,  681,  681,  681,  681,  681,  681,  681,
			  683,    0,  683,  683,  683,  683,  683,  683,  683,  683,
			  683,  683,  683,  683,  683,  685,    0,  685,  685,  685,
			    0,  685,  685,  685,  685,  685,  685,  685,  685,  685,
			  686,  686,  686,  686,  686,  686,  686,  686,  686,  686,
			  686,  686,  686,  686,  686,  687,  687,  687,  687,  687,
			  687,  687,  687,  687,  687,  687,  687,  687,  687,  687,
			  688,  688,  688,  688,  688,  688,  688,  688,  688,  688,
			  688,  688,  688,  688,  688,  689,    0,  689,  689,  689,
			  689,  689,  689,  689,  689,  689,  689,  689,  689,  689,

			  690,    0,  690,    0,  690,  690,  690,  690,  690,  690,
			  690,  690,  690,  690,  690,  691,    0,  691,  691,  691,
			  691,  691,  691,  691,  691,  691,  691,  691,  691,  691,
			  694,    0,  694,  694,  694,  694,  694,  694,  694,  694,
			  694,  694,  694,  694,  694,  697,  697,  697,  697,  697,
			  697,  697,  697,  697,  697,  697,  697,  697,  697,  697,
			  698,    0,  698,  698,  698,  698,  698,  698,  698,  698,
			  698,  698,  698,  698,  698,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675, yy_Dummy>>,
			1, 68, 2000)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   90,   91,   99,  104, 1020, 1005,  109,
			  112,  115,  118, 1005, 1975,  121,  124, 1975,  190,    0,
			 1975,  120, 1975, 1975, 1975, 1975, 1975,   81,  122,  120,
			  128,  147,  154,  977, 1975,  107, 1975,  109,  943,  189,
			   91,  198,  121,  183,  193,    0,  241,  114,  107,  250,
			  123,  120,  251,  249,  134,  243,  143,  174, 1975,  911,
			 1975, 1975, 1975, 1975, 1975,  960, 1975, 1975,  332,  177,
			  344, 1975, 1975,  239,  955, 1975, 1975,  300, 1975, 1975,
			  308,  350,  930,  369,  924,  299, 1975,  388,  166,  353,
			  369,  387,  389,  393,  395,  403,  405,  409,  407,  418,

			  434,  447,  424,  465,    0,  922,  549,  913, 1975, 1975,
			 1975,  479, 1975, 1975, 1975,  497,  506,  488,  181,  385,
			    0,  551, 1975, 1975, 1975, 1975, 1975, 1975, 1975,    0,
			  182,  197,  492,  249,  240,  241,  243,  260,  268,  263,
			  302,  307,  552,    0,  336,  545,  379,  349,  369,  374,
			    0,  395,  569,    0,  424,  488,  453,  463,  482,  562,
			    0,  477,  502,  581,  564,  533,  542,  557,  558,  567,
			  609,  566,  580,  588,  581, 1975,  917, 1975,  538, 1975,
			 1975, 1975, 1975, 1975,  644, 1975, 1975, 1975, 1975, 1975,
			 1975, 1975, 1975, 1975, 1975, 1975, 1975, 1975, 1975, 1975,

			 1975,  425, 1975, 1975,  666,  482, 1975,  837, 1975,  548,
			 1975,  674,  829, 1975, 1975,  680,  690, 1975, 1975, 1975,
			 1975,  665, 1975,  679, 1975,  681,  689,  693,  691,  699,
			  695,  707, 1975,  706,  708, 1975, 1975, 1975,  778,  775,
			  742,  729,  713,  698,  668,  647,  645,  641,  633,  629,
			  578,  575,  567,  548,  545,  534,  532,  528,  472,  461,
			 1975,  707,  770, 1975,  778,  787,  794,  800,  469,  409,
			  711,  398,  807,  811,  681,  690,  704,    0,    0,  705,
			  714,    0,  716,  702,  751,  774,  758,  760,  784,  793,
			  804,    0,  790,  815,  807,  795,  797,  806,  806,  815,

			  813,  818,  808,  826,  824,  832,  818,  830,  821,    0,
			  832,  814,  820,  854,  840,  842,  852,  837,  860,  852,
			  868,  873,  870,  867,  864,  875,  870,  878,  867,  877,
			  878,  884,  877,    0, 1975,  907,    0,  375,  952, 1975,
			 1975, 1975,  953,  925,  954,  955, 1975,  959, 1975, 1975,
			 1975, 1975, 1975, 1975, 1975,  953,  958, 1975, 1975, 1975,
			 1975, 1975, 1975, 1975, 1975, 1975, 1975, 1975, 1975, 1975,
			 1975, 1975, 1975,  971,  975,  980, 1005, 1014, 1029, 1033,
			 1039, 1045,  612,  378,    0,  373,  403, 1055, 1061,  890,
			  901,  903,  950,  955,  950,  972,  966, 1023, 1014, 1034,

			 1033, 1032, 1052, 1047, 1039, 1044, 1041, 1043, 1057, 1042,
			    0, 1059, 1056, 1043, 1044, 1051, 1069, 1057,    0, 1065,
			    0,    0, 1066, 1139,    0, 1075, 1064, 1089, 1096, 1085,
			 1091, 1096, 1087, 1102, 1093, 1116, 1102,    0, 1105,    0,
			    0, 1117, 1117, 1103, 1113, 1126,    0,    0, 1975, 1152,
			  306, 1152, 1975, 1153, 1975, 1187, 1975,  356,  686,  739,
			    0, 1178, 1183, 1195, 1199, 1205, 1215, 1231, 1114,    0,
			    0, 1135, 1153, 1175,    0,    0, 1160, 1208, 1170,    0,
			 1183, 1194, 1212, 1220, 1223, 1208, 1215,    0, 1217, 1222,
			 1232, 1229,    0, 1230, 1237, 1232,    0, 1237, 1303, 1975,

			  344, 1247, 1233, 1229, 1245, 1250, 1251, 1245, 1259, 1245,
			    0, 1246, 1277,    0,    0, 1272, 1277,    0, 1270,  338,
			  273, 1313, 1315, 1324, 1975, 1315,  145, 1333,  635, 1341,
			 1345, 1364, 1368, 1386, 1375,    0,    0, 1302, 1288, 1292,
			    0, 1300, 1297, 1325, 1369,    0,    0, 1376,    0, 1383,
			 1380,    0, 1367, 1373, 1368, 1369, 1389, 1371, 1975,  339,
			 1380, 1374,    0, 1380, 1381,    0, 1391,    0,    0,    0,
			 1377, 1384,    0, 1379,  273, 1427, 1428, 1429,  302,  233,
			  206,  133,  162,  138,   93,   34, 1445, 1449, 1453, 1478,
			 1490, 1469, 1458, 1501, 1510, 1448, 1433,    0, 1443,    0,

			 1463, 1470, 1469, 1464,    0,    0, 1471,    0,    0, 1482,
			 1493, 1539, 1492, 1504, 1511,    0, 1510, 1511,    0,    0,
			 1541, 1542, 1543, 1975, 1975, 1975, 1975, 1519, 1541, 1545,
			 1561, 1567, 1571, 1588, 1592, 1598,    0, 1535,    0,    0,
			 1533,    0,    0,    0, 1545,    0, 1620, 1554, 1549,    0,
			 1566,    0,    0, 1630, 1975, 1975, 1581, 1623, 1629,    0,
			 1590,    0, 1584, 1603,    0,    0, 1975,    0, 1604, 1588,
			 1591, 1592, 1598,    0, 1975, 1975, 1719, 1734, 1749, 1764,
			 1779, 1794, 1681, 1809, 1690, 1824, 1839, 1854, 1869, 1884,
			 1899, 1914, 1102, 1432, 1929, 1548, 1647, 1944, 1959, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  675,    1,  676,  676,  677,  677,  678,  678,  679,
			  679,  680,  680,  675,  675,  675,  675,  675,  681,  682,
			  675,  683,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  675,  675,
			  675,  675,  675,  675,  675,  685,  675,  675,  675,  686,
			  686,  675,  675,  687,  688,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  681,  675,  689,  690,  681,
			  681,  681,  681,  681,  681,  681,  681,  681,  681,  681,

			  681,  681,  681,  681,  682,  691,  691,  691,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  692,  692,
			  693,  675,  675,  675,  675,  675,  675,  675,  675,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  675,  685,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,

			  675,  686,  675,  675,  686,  687,  675,  688,  675,  675,
			  675,  675,  694,  675,  675,  689,  690,  675,  675,  675,
			  675,  681,  675,  681,  675,  681,  681,  681,  681,  681,
			  681,  681,  675,  681,  681,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  692,  692,
			  692,  693,  675,  675,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,

			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  675,  675,  694,  694,  690,  675,
			  675,  675,  681,  681,  681,  681,  675,  681,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  692,  692,  270,  693,  675,  675,  675,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,

			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  675,  675,
			  694,  681,  675,  681,  675,  681,  675,  675,  695,  695,
			  696,  675,  675,  675,  675,  675,  675,  675,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  675,  675,

			  675,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  675,
			  694,  681,  681,  681,  675,  695,  695,  695,  696,  675,
			  675,  675,  675,  675,  675,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  675,  697,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  694,  681,  681,  681,  675,  525,
			  675,  695,  675,  527,  675,  696,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  684,  684,  684,  684,  684,

			  684,  684,  684,  684,  684,  684,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  684,  684,  684,  698,
			  681,  681,  681,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  684,  684,  684,  684,
			  684,  684,  684,  684,  684,  684,  675,  684,  684,  684,
			  684,  684,  684,  681,  675,  675,  675,  675,  675,  684,
			  684,  684,  675,  684,  684,  684,  675,  684,  675,  684,
			  675,  684,  675,  684,  675,    0,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  675,  675,  675,  675,  675,  675, yy_Dummy>>)
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
			   86,   87,   88,   89,   90,   91,   92,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    4,    3,    5,    6,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    7,    7,    8,    9,    3,    3,    3,    3,    3,    3,
			    3,    7,    7,    7,    7,    7,    7,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   11,   12,    3,    3,    3,
			    3,   13,    3,    7,    7,    7,    7,    7,    7,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   14,   15,    3,
			    3,    3,    3, yy_Dummy>>)
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
			  186,  189,  191,  193,  194,  194,  195,  196,  197,  197,
			  198,  199,  200,  201,  202,  203,  204,  205,  206,  207,

			  208,  210,  211,  212,  214,  215,  216,  217,  218,  219,
			  220,  221,  222,  223,  224,  225,  226,  227,  228,  229,
			  229,  229,  229,  230,  231,  232,  233,  234,  235,  236,
			  237,  238,  239,  240,  241,  243,  244,  245,  246,  247,
			  248,  249,  250,  251,  253,  254,  255,  256,  257,  258,
			  259,  261,  262,  263,  265,  266,  267,  268,  269,  270,
			  271,  273,  274,  275,  276,  277,  278,  279,  280,  281,
			  282,  283,  284,  285,  286,  287,  288,  289,  290,  290,
			  291,  292,  293,  294,  295,  295,  296,  297,  298,  299,
			  300,  301,  302,  303,  304,  305,  306,  307,  308,  309,

			  310,  311,  312,  313,  314,  315,  316,  318,  319,  320,
			  320,  321,  322,  323,  324,  326,  328,  329,  331,  333,
			  335,  337,  338,  340,  341,  343,  344,  345,  346,  347,
			  348,  349,  350,  351,  352,  353,  355,  356,  358,  359,
			  360,  361,  362,  363,  364,  365,  366,  367,  368,  369,
			  370,  371,  372,  373,  374,  375,  376,  377,  378,  379,
			  380,  382,  383,  383,  384,  385,  385,  386,  387,  389,
			  390,  392,  393,  394,  394,  395,  396,  397,  399,  401,
			  402,  403,  405,  406,  407,  408,  409,  410,  411,  412,
			  413,  414,  416,  417,  418,  419,  420,  421,  422,  423,

			  424,  425,  426,  427,  428,  429,  430,  431,  433,  434,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,
			  446,  447,  448,  449,  450,  451,  452,  453,  454,  455,
			  456,  457,  458,  459,  461,  462,  462,  463,  464,  464,
			  466,  468,  470,  471,  472,  473,  474,  476,  477,  479,
			  481,  482,  483,  484,  485,  486,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  499,  500,
			  501,  502,  503,  504,  505,  505,  506,  507,  507,  507,
			  508,  509,  510,  510,  510,  510,  510,  510,  511,  512,
			  513,  514,  515,  516,  517,  518,  519,  520,  521,  522,

			  523,  524,  525,  526,  528,  529,  530,  531,  532,  533,
			  534,  536,  537,  538,  539,  540,  541,  542,  543,  545,
			  546,  548,  550,  551,  553,  555,  556,  557,  558,  559,
			  560,  561,  562,  563,  564,  565,  566,  567,  569,  570,
			  572,  574,  575,  576,  577,  578,  579,  581,  583,  584,
			  584,  585,  586,  588,  589,  591,  592,  594,  595,  595,
			  595,  595,  596,  596,  597,  597,  598,  599,  600,  601,
			  603,  605,  606,  607,  608,  610,  612,  613,  614,  615,
			  617,  618,  619,  620,  621,  622,  623,  624,  626,  627,
			  628,  629,  630,  632,  633,  634,  635,  637,  638,  638,

			  639,  639,  640,  641,  642,  643,  644,  645,  646,  647,
			  648,  650,  651,  652,  654,  656,  657,  658,  660,  661,
			  661,  662,  663,  664,  665,  666,  666,  666,  666,  666,
			  666,  667,  668,  668,  668,  669,  671,  673,  674,  675,
			  676,  678,  679,  680,  681,  682,  684,  686,  687,  689,
			  690,  691,  693,  694,  695,  696,  697,  698,  699,  700,
			  700,  701,  702,  704,  705,  706,  708,  709,  711,  713,
			  715,  716,  717,  719,  720,  721,  722,  723,  724,  724,
			  724,  724,  724,  724,  724,  724,  724,  724,  725,  726,
			  726,  726,  727,  727,  728,  728,  729,  730,  732,  733,

			  735,  736,  737,  738,  739,  741,  743,  744,  746,  748,
			  749,  750,  751,  752,  753,  754,  756,  757,  758,  760,
			  762,  763,  764,  765,  767,  768,  770,  771,  772,  772,
			  773,  773,  774,  775,  775,  775,  776,  778,  779,  781,
			  783,  784,  786,  788,  790,  791,  793,  793,  794,  795,
			  797,  798,  800,  802,  803,  805,  807,  808,  808,  809,
			  811,  812,  814,  814,  815,  817,  819,  821,  823,  823,
			  824,  824,  825,  825,  827,  828,  828, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  184,  184,  186,  186,  217,  215,  216,    1,  215,
			  216,    1,  216,   36,  215,  216,  187,  215,  216,   41,
			  215,  216,   14,  215,  216,  154,  215,  216,   24,  215,
			  216,   25,  215,  216,   32,  215,  216,   30,  215,  216,
			    9,  215,  216,   31,  215,  216,   13,  215,  216,   33,
			  215,  216,  119,  215,  216,  119,  215,  216,  119,  215,
			  216,    8,  215,  216,    7,  215,  216,   18,  215,  216,
			   17,  215,  216,   19,  215,  216,   11,  215,  216,  117,
			  215,  216,  117,  215,  216,  117,  215,  216,  117,  215,
			  216,  117,  215,  216,  117,  215,  216,  117,  215,  216,

			  117,  215,  216,  117,  215,  216,  117,  215,  216,  117,
			  215,  216,  117,  215,  216,  117,  215,  216,  117,  215,
			  216,  117,  215,  216,  117,  215,  216,  117,  215,  216,
			  117,  215,  216,  117,  215,  216,   28,  215,  216,  215,
			  216,   29,  215,  216,   34,  215,  216,   26,  215,  216,
			   27,  215,  216,   12,  215,  216,  188,  216,  214,  216,
			  212,  216,  213,  216,  184,  216,  184,  216,  183,  216,
			  182,  216,  184,  216,  186,  216,  185,  216,  180,  216,
			  180,  216,  179,  216,    6,  216,    5,    6,  216,    5,
			  216,    6,  216,    1,  187,  176,  187,  187,  187,  187,

			  187,  187,  187,  187,  187,  187,  187,  187,  187, -394,
			  187,  187,  187, -394,   41,  154,  154,  154,    2,   35,
			   10,  125,   39,   23,   22,  125,  119,  119,  118,  118,
			   15,   37,   20,   21,   38,   16,  117,  117,  117,  117,
			  117,   47,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,   61,  117,  117,  117,  117,  117,  117,  117,   73,
			  117,  117,  117,   80,  117,  117,  117,  117,  117,  117,
			  117,   92,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,   40,  188,  212,
			  205,  203,  204,  206,  207,  208,  209,  189,  190,  191,

			  192,  193,  194,  195,  196,  197,  198,  199,  200,  201,
			  202,  184,  183,  182,  184,  184,  181,  182,  186,  185,
			  179,    5,    4,  177,  175,  177,  187, -394, -394,  162,
			  177,  160,  177,  161,  177,  163,  177,  187,  156,  177,
			  187,  157,  177,  187,  187,  187,  187,  187,  187,  187,
			 -178,  187,  187,  164,  177,  154,  126,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  127,  154,  125,  120,  125,  119,  119,  123,  124,  124,
			  122,  124,  121,  119,  117,  117,  117,   45,  117,   46,

			  117,  117,  117,   51,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,   64,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,   84,  117,  117,   87,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  116,
			  117,  211,    4,    4,  165,  177,  158,  177,  159,  177,
			  187,  187,  187,  187,  172,  177,  187,  167,  177,  166,
			  177,  144,  142,  143,  145,  146,  155,  155,  147,  148,
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,

			  138,  139,  140,  141,  125,  125,  125,  125,  119,  119,
			  119,  119,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,   62,  117,  117,  117,
			  117,  117,  117,  117,   71,  117,  117,  117,  117,  117,
			  117,  117,  117,   81,  117,  117,   83,  117,   85,  117,
			  117,   90,  117,   91,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  105,  117,  117,
			  107,  117,  108,  117,  117,  117,  117,  117,  117,  114,
			  117,  115,  117,  210,    4,  187,  168,  177,  187,  171,
			  177,  187,  174,  177,  155,  125,  125,  125,  125,  119,

			  117,   43,  117,   44,  117,  117,  117,  117,   52,  117,
			   53,  117,  117,  117,  117,   58,  117,  117,  117,  117,
			  117,  117,  117,  117,   69,  117,  117,  117,  117,  117,
			   76,  117,  117,  117,  117,   82,  117,  117,   88,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  102,  117,
			  117,  117,  106,  117,  109,  117,  117,  117,  112,  117,
			  117,    4,  187,  187,  187,  149,  125,  125,  125,   42,
			  117,   48,  117,  117,  117,  117,   55,  117,  117,  117,
			  117,  117,   63,  117,   65,  117,  117,   67,  117,  117,
			  117,   72,  117,  117,  117,  117,  117,  117,  117,   89,

			  117,  117,   95,  117,  117,  117,   98,  117,  117,  100,
			  117,  101,  117,  103,  117,  117,  117,  111,  117,  117,
			    4,  187,  187,  187,  125,  125,  125,  125,  117,  117,
			   54,  117,  117,   57,  117,  117,  117,  117,  117,   70,
			  117,   74,  117,  117,   77,  117,   78,  117,  117,  117,
			  117,  117,  117,  117,   99,  117,  117,  117,  113,  117,
			    3,    4,  187,  187,  187,  152,  153,  153,  151,  153,
			  150,  125,  125,  125,  125,  125,   49,  117,  117,   56,
			  117,   59,  117,  117,   66,  117,   68,  117,   75,  117,
			  117,   86,  117,  117,  117,   96,  117,  117,  104,  117,

			  110,  117,  187,  170,  177,  173,  177,  125,  125,   50,
			  117,  117,   79,  117,  117,   94,  117,   97,  117,  169,
			  177,   60,  117,  117,  117,   93,  117,   93, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 1975
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 675
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 676
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

	yyNb_rules: INTEGER = 216
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 217
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
