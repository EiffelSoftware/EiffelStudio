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

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= PRAGMA)
		end

feature {NONE} -- Implementation

	yy_build_tables is
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

	yy_execute_action (yy_act: INTEGER) is
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
				ast_factory.set_buffer (token_buffer2, Current)
				set_start_condition (PRAGMA)					
		
when 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

			less (0)
			ast_factory.create_break_as_with_data (token_buffer2, 
																last_break_as_start_line, 
																last_break_as_start_column, 
																last_break_as_start_position, 
																token_buffer2.count)
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
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 43 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 46 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 47 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 48 then
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
			
when 49 then
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
			
when 50 then
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
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 52 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 53 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 54 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 55 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
when 56 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 57 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 58 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
when 59 then
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
			
when 60 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 61 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 62 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 63 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 64 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 65 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 66 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 67 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 68 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 69 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 70 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 71 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 72 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 73 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 74 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				if syntax_version /= ecma_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
					last_token := TE_INDEXING
				else
					process_id_as
					last_token := TE_ID
				end
			
when 75 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 76 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 77 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 78 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 79 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
when 80 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 81 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 82 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 83 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 84 then
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
			
when 85 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 86 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 87 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 88 then
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
			
when 89 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 90 then
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
			
when 91 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 92 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 93 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 94 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 95 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 96 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 97 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 98 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 99 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 101 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 102 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 103 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 104 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 106 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 107 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_TUPLE
				process_id_as
			
when 108 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 109 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 110 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 111 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 112 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 113 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 114 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				last_token := TE_ID
				process_id_as
			
when 116 then
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
			
when 117 then
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

				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 118 then
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

				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes octal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes binary integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				report_invalid_integer_error (token_buffer)
			
when 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			
when 124 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 145 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 146 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 147 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 148 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 149 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 150 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 151 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				report_invalid_integer_error (token_buffer)
			
when 152 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 153 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 154 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 155 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 156 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 157 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 158 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 159 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 160 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 161 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 163 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 164 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 166 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 167 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 168 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 169 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 170 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 171 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 172 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 175 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Regular string.
				string_position := position
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 176 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Verbatim string.
				string_position := position
				verbatim_start_position := position
				token_buffer.clear_all
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				ast_factory.set_buffer (token_buffer2, Current)				
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				set_start_condition (VERBATIM_STR3)
			
when 177 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 178 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 179 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
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
						token_buffer.clear_all
					end
					if verbatim_marker.item (1) = ']' then
						align_left (token_buffer)
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
						if token_buffer.count > maximum_string_length then
							report_too_long_string (token_buffer)
						end
					end
				else
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 180 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 181 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 182 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 183 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 185 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- String with special characters.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				string_start_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 186 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%A")
				token_buffer.append_character ('%A')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%B")
				token_buffer.append_character ('%B')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%C")
				token_buffer.append_character ('%C')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%D")
				token_buffer.append_character ('%D')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%F")
				token_buffer.append_character ('%F')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%H")
				token_buffer.append_character ('%H')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%L")
				token_buffer.append_character ('%L')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%N")
				token_buffer.append_character ('%N')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%Q")
				token_buffer.append_character ('%Q')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%R")
				token_buffer.append_character ('%R')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%S")
				token_buffer.append_character ('%S')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%T")
				token_buffer.append_character ('%T')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%U")
				token_buffer.append_character ('%U')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%V")
				token_buffer.append_character ('%V')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%%")
				token_buffer.append_character ('%%')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%'")
				token_buffer.append_character ('%'')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%"")
				token_buffer.append_character ('%"')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%(")
				token_buffer.append_character ('%(')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%)")
				token_buffer.append_character ('%)')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%<")
				token_buffer.append_character ('%<')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%>")
				token_buffer.append_character ('%>')
			
when 208 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 209 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 210 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
			
when 211 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 212 then
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
			
when 213 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				report_unknown_token_error (text_item (1))
			
when 214 then
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

	yy_execute_eof_action (yy_sc: INTEGER) is
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
					
			ast_factory.create_break_as_with_data (token_buffer2, 
																last_break_as_start_line, 
																last_break_as_start_column, 
																last_break_as_start_position, 
																token_buffer2.count)
			set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2034)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
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
			   19,   63,   64,   66,   66,  577,   67,   67,  108,   68,

			   68,   70,   71,   70,  618,   72,   70,   71,   70,  109,
			   72,   77,   78,   77,   77,   78,   77,   80,   81,   80,
			   80,   81,   80,   83,   83,   83,   83,   83,   83,  106,
			  135,  107,   82,  124,  125,   82,  126,  127,   84,  112,
			  110,   84,  111,  111,  111,  111,  115,  113,  116,  116,
			  117,  117,  155,  153,  160,  162,  141,  667,   73,  154,
			  118,  119,  135,   73,  617,  115,  142,  116,  116,  117,
			  117,  161,  115,  573,  117,  117,  117,  117,  616,  122,
			  200,  168,  120,  201,  155,  153,  160,  162,  141,  121,
			   73,  154,  118,  119,  667,   73,   86,   87,  142,   88,

			   87,  266,  266,  161,   89,   90,  171,   91,  121,   92,
			  163,  122,  114,  168,  120,  121,   93,  615,   94,  130,
			   87,   95,  611,  136,  131,  164,  132,  137,  172,   96,
			  138,  133,  134,  139,   97,   98,  140,  143,  171,  144,
			  169,  214,  163,  200,   99,  272,  204,  100,  101,  145,
			  102,  130,  491,   95,  170,  136,  131,  164,  132,  137,
			  172,   96,  138,  133,  134,  139,   97,   98,  140,  143,
			  146,  144,  169,  214,  147,  149,   99,  272,  566,  103,
			   87,  145,  150,  151,  156,  165,  170,  148,  152,  207,
			  208,  207,  275,  276,  157,  166,  158,  277,  167,  278,

			  159,  442,  146,  209,  209,  209,  147,  149,  551,  202,
			  200,  202,  517,  201,  150,  151,  156,  165,  513,  148,
			  152,  209,  209,  209,  275,  276,  157,  166,  158,  277,
			  167,  278,  159,  176,  176,  176,  211,  177,  215,   88,
			  178,   88,  179,  180,  181,   83,   83,   83,   85,   85,
			  182,   85,  216,  212,  279,   88,   88,  183,  217,  184,
			   84,   88,  185,  186,  187,  188,  203,  189,  261,  190,
			  381,  218,  379,  191,   88,  192,  518,  518,  193,  194,
			  195,  196,  197,  198,  219,  200,  279,  103,  201,  103,
			  444,  220,  222,  211,   88,   88,   88,  211,  203,  211,

			   88,  381,   88,  103,  213,  211,  379,  211,   88,  103,
			   88,  233,  221,  223,   88,  368,  229,  230,  229,  103,
			  211,  103,  103,   88,  367,  280,  229,  230,  229,  366,
			  211,  224,  281,   88,  225,  103,  213,  273,  226,  365,
			  274,  103,  103,  103,  103,  282,  228,  227,  103,  211,
			  103,  572,   88,  364,  103,  283,  103,  280,  103,  268,
			  268,  268,  103,  224,  281,  287,  225,  292,  363,  273,
			  226,  103,  274,  231,  103,  103,  103,  282,  228,  227,
			  103,  103,  103,  259,  259,  259,  259,  283,  103,  200,
			  103,  362,  204,  573,  103,  288,  293,  287,  260,  292,

			  103,  232,  261,  103,  262,  262,  262,  262,  361,  294,
			  289,  295,  301,  103,  360,  270,  270,  270,  270,  263,
			  304,  115,  305,  264,  264,  265,  265,  288,  293,  359,
			  260,  358,  103,  236,  357,  122,  237,  356,  238,  239,
			  240,  294,  289,  295,  301,  115,  241,  265,  265,  265,
			  265,  263,  304,  242,  305,  243,  271,  306,  244,  245,
			  246,  247,  284,  248,  121,  249,  285,  122,  290,  250,
			  302,  251,  291,  309,  252,  253,  254,  255,  256,  257,
			  286,  296,  303,  297,  307,  298,  310,  355,  121,  306,
			  319,  317,  320,  308,  284,  318,  299,  354,  285,  300,

			  290,  321,  302,  353,  291,  309,  322,  326,  327,  350,
			  328,  329,  286,  296,  303,  297,  307,  298,  310,  311,
			  349,  312,  319,  317,  320,  308,  348,  318,  299,  313,
			  347,  300,  314,  321,  315,  316,  323,  385,  322,  326,
			  327,  324,  328,  329,  207,  208,  207,  176,  176,  176,
			  576,  311,  325,  312,  330,  331,  331,  331,  331,  386,
			  335,  313,  336,   88,  314,   88,  315,  316,  323,  385,
			  202,  200,  202,  324,  201,  209,  209,  209,   85,  229,
			  230,  229,  337,  212,  325,   88,   88,  334,  230,  334,
			  211,  386,  577,   88,  346,  211,  211,  333,   88,   88,

			  341,  344,  342,  206,   88,   88,  211,  345,  175,   88,
			   88,  103,  258,  103,  235,  229,  230,  229,  338,  211,
			  266,  266,   88,  351,  352,  352,  352,  203,  387,  369,
			  369,  369,  369,  103,  213,  339,  372,  372,  372,  372,
			  340,  103,  214,  103,  260,  103,  103,  103,  343,  390,
			  338,  373,  103,  103,  268,  268,  268,  103,  103,  203,
			  387,  378,  108,  210,  391,  103,  213,  339,  206,  392,
			  103,  175,  340,  103,  214,  173,  260,  128,  103,  103,
			  343,  390,  388,  373,  103,  103,  370,  393,  370,  103,
			  103,  371,  371,  371,  371,  380,  391,  123,  374,  389,

			  374,  392,  103,  375,  375,  375,  375,  115,  394,  376,
			  376,  377,  377,  115,  388,  377,  377,  377,  377,  393,
			  382,  122,  383,  383,  383,  383,  384,  384,  384,  384,
			  395,  389,  396,  397,  398,  667,  399,  400,  402,  403,
			  394,  404,  405,  407,  408,  409,  410,  411,  412,  413,
			  121,  401,  414,  122,  415,  406,  121,  416,  417,  418,
			  419,  420,  395,  271,  396,  397,  398,  271,  399,  400,
			  402,  403,  423,  404,  405,  407,  408,  409,  410,  411,
			  412,  413,  421,  401,  414,  422,  415,  406,  424,  416,
			  417,  418,  419,  420,  425,  426,  429,  427,  430,  431,

			  432,  433,  434,  435,  423,  436,  437,  438,  439,  440,
			  441,  334,  230,  334,  421,  428,  211,  422,   75,   88,
			  424,  442,  443,  443,  443,  443,  425,  426,  429,  427,
			  430,  431,  432,  433,  434,  435,   75,  436,  437,  438,
			  439,  440,  441,  445,  667,  446,  448,  428,   88,   88,
			  211,  450,  447,   88,   88,  520,  520,  520,  451,  352,
			  352,  352,  352,  267,  267,  267,  214,  103,  266,  266,
			  667,  452,  453,  451,  352,  352,  352,  352,  667,  449,
			  455,  455,  455,  455,  447,  371,  371,  371,  371,  371,
			  371,  371,  371,  454,  462,  260,  103,  103,  214,  103, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  463,  103,  103,  452,  453,  457,  457,  457,  457,  378,
			  458,  449,  458,  667,  667,  459,  459,  459,  459,  667,
			  373,  456,  269,  269,  269,  454,  462,  260,  103,  103,
			  667,  667,  463,  103,  103,  375,  375,  375,  375,  375,
			  375,  375,  375,  460,  464,  376,  376,  377,  377,  465,
			  466,  460,  373,  377,  377,  377,  377,  122,  382,  467,
			  461,  461,  461,  461,  382,  468,  384,  384,  384,  384,
			  469,  470,  471,  472,  473,  667,  464,  474,  475,  476,
			  477,  465,  466,  478,  479,  480,  271,  481,  482,  122,
			  483,  467,  484,  485,  271,  486,  487,  468,  488,  489,

			  490,  271,  469,  470,  471,  472,  473,  271,  494,  474,
			  475,  476,  477,  495,  496,  478,  479,  480,  497,  481,
			  482,  498,  483,  499,  484,  485,  500,  486,  487,  501,
			  488,  489,  490,  491,  491,  491,  502,  492,  503,  504,
			  494,  505,  506,  507,  508,  495,  496,  509,  493,  510,
			  497,  511,  667,  498,  211,  499,  211,   88,  500,   88,
			  667,  501,  442,  512,  512,  512,  512,  667,  502,  667,
			  503,  504,  528,  505,  506,  507,  508,  211,  529,  509,
			   88,  510,  667,  511,  455,  455,  455,  455,  667,  515,
			  523,  523,  523,  523,  524,  524,  524,  524,  514,  522,

			  459,  459,  459,  459,  528,  103,  530,  103,  531,  373,
			  529,  534,  667,  516,  459,  459,  459,  459,  535,  536,
			  527,  515,  384,  384,  384,  384,  537,  538,  103,  667,
			  514,  522,  532,  539,  540,  525,  533,  103,  530,  103,
			  531,  373,  541,  534,  261,  516,  524,  524,  524,  524,
			  535,  536,  542,  543,  544,  545,  546,  547,  537,  538,
			  103,  526,  548,  121,  532,  539,  540,  549,  533,  552,
			  553,  554,  555,  556,  541,  491,  491,  491,  557,  550,
			  558,  559,  560,  561,  542,  543,  544,  545,  546,  547,
			  493,  562,  563,  526,  548,  564,  565,  211,  667,  549,

			   88,  552,  553,  554,  555,  556,  211,  667,  211,   88,
			  557,   88,  558,  559,  560,  561,  570,  518,  518,  583,
			  583,  583,  583,  562,  563,  667,  667,  564,  565,  567,
			  574,  520,  520,  520,  578,  568,  578,  587,  588,  579,
			  579,  579,  579,  519,  519,  519,  589,  667,  103,  667,
			  590,  569,  667,  580,  580,  580,  580,  103,  571,  103,
			  591,  567,  524,  524,  524,  524,  592,  568,  581,  587,
			  588,  261,  575,  583,  583,  583,  583,  582,  589,  584,
			  103,  584,  590,  569,  585,  585,  585,  585,  586,  103,
			  593,  103,  591,  594,  595,  596,  597,  598,  592,  599,

			  581,  600,  601,  602,  603,  604,  605,  606,  607,  582,
			  608,  609,  610,  667,  211,  667,  211,   88,  211,   88,
			  586,   88,  593,  667,  628,  594,  595,  596,  597,  598,
			  629,  599,  630,  600,  601,  602,  603,  604,  605,  606,
			  607,  667,  608,  609,  610,  612,  667,  614,  579,  579,
			  579,  579,  579,  579,  579,  579,  628,  613,  619,  619,
			  619,  619,  629,  631,  630,  103,  632,  103,  633,  103,
			  634,  635,  636,  581,  667,  667,  620,  612,  620,  614,
			  667,  621,  621,  621,  621,  622,  667,  622,  667,  613,
			  623,  623,  623,  623,  667,  631,  637,  103,  632,  103,

			  633,  103,  634,  635,  636,  581,  624,  624,  624,  624,
			  585,  585,  585,  585,  585,  585,  585,  585,  626,  640,
			  626,  625,  641,  627,  627,  627,  627,  642,  637,  638,
			  638,  638,  643,  644,  211,  646,  647,   88,   88,   88,
			  667,  581,  621,  621,  621,  621,  621,  621,  621,  621,
			  651,  640,  652,  625,  641,  623,  623,  623,  623,  642,
			  639,  667,  667,  658,  643,  644,   88,  456,  623,  623,
			  623,  623,  645,  581,  648,  648,  648,  648,  627,  627,
			  627,  627,  651,  653,  652,  103,  103,  103,  649,  625,
			  649,  655,  639,  650,  650,  650,  650,  627,  627,  627,

			  627,  638,  638,  638,  645,  656,  657,  625,  650,  650,
			  650,  650,  659,  660,  103,  653,  661,  103,  103,  103,
			  662,  625,  663,  655,  650,  650,  650,  650,  664,  665,
			  666,  667,  654,  525,  521,  521,  521,  656,  657,  625,
			  667,  667,  667,  667,  659,  660,  103,  667,  661,  667,
			  667,  667,  662,  667,  663,  667,  667,  667,  667,  667,
			  664,  665,  666,  667,  654,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   74,   74,   74,   74,   74,

			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   76,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   85,  667,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,  104,  667,  104,  667,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  105,  667,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  174,  667,  174,  174,  174,  667,  174,  174,

			  174,  174,  174,  174,  174,  174,  174,  199,  199,  199,
			  199,  199,  199,  199,  199,  199,  199,  199,  199,  199,
			  199,  199,  203,  203,  203,  203,  203,  203,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  205,  205,  205,
			  205,  205,  205,  205,  205,  205,  205,  205,  205,  205,
			  205,  205,   87,  667,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   88,  667,   88,
			  667,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			   88,   88,  234,  667,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  332,  667,  332,

			  332,  332,  332,  332,  332,  332,  332,  332,  332,  332,
			  332,  332,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  611,  667,  611,
			  611,  611,  611,  611,  611,  611,  611,  611,  611,  611,
			  611,  611,   13,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667, yy_Dummy>>,
			1, 35, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2034)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER]) is
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
			    1,    1,    1,    3,    4,  577,    3,    4,   27,    3,

			    4,    5,    5,    5,  576,    5,    6,    6,    6,   27,
			    6,    9,    9,    9,   10,   10,   10,   11,   11,   11,
			   12,   12,   12,   15,   15,   15,   16,   16,   16,   21,
			   40,   21,   11,   35,   35,   12,   37,   37,   15,   29,
			   28,   16,   28,   28,   28,   28,   30,   29,   30,   30,
			   30,   30,   48,   47,   50,   51,   42,  575,    5,   47,
			   30,   30,   40,    6,  574,   31,   42,   31,   31,   31,
			   31,   50,   32,  573,   32,   32,   32,   32,  572,   31,
			   69,   54,   30,   69,   48,   47,   50,   51,   42,   30,
			    5,   47,   30,   30,  571,    6,   18,   18,   42,   18,

			   18,  118,  118,   50,   18,   18,   56,   18,   31,   18,
			   52,   31,   29,   54,   30,   32,   18,  570,   18,   39,
			   18,   18,  566,   41,   39,   52,   39,   41,   57,   18,
			   41,   39,   39,   41,   18,   18,   41,   43,   56,   43,
			   55,   88,   52,   73,   18,  130,   73,   18,   18,   43,
			   18,   39,  551,   18,   55,   41,   39,   52,   39,   41,
			   57,   18,   41,   39,   39,   41,   18,   18,   41,   43,
			   44,   43,   55,   88,   44,   46,   18,  130,  513,   18,
			   18,   43,   46,   46,   49,   53,   55,   44,   46,   77,
			   77,   77,  132,  133,   49,   53,   49,  134,   53,  135,

			   49,  512,   44,   80,   80,   80,   44,   46,  493,   70,
			   70,   70,  451,   70,   46,   46,   49,   53,  444,   44,
			   46,   81,   81,   81,  132,  133,   49,   53,   49,  134,
			   53,  135,   49,   68,   68,   68,   85,   68,   89,   85,
			   68,   89,   68,   68,   68,   83,   83,   83,   87,   87,
			   68,   87,   90,   87,  136,   90,   87,   68,   91,   68,
			   83,   91,   68,   68,   68,   68,   70,   68,  382,   68,
			  381,   92,  379,   68,   92,   68,  452,  452,   68,   68,
			   68,   68,   68,   68,   92,  199,  136,   85,  199,   89,
			  333,   93,   94,   95,   93,   94,   95,   96,   70,   97,

			   96,  269,   97,   90,   87,   98,  267,   99,   98,   91,
			   99,  102,   93,   94,  102,  257,  100,  100,  100,   85,
			  100,   89,   92,  100,  256,  137,  103,  103,  103,  255,
			  103,   95,  138,  103,   96,   90,   87,  131,   97,  254,
			  131,   91,   93,   94,   95,  139,   99,   98,   96,  101,
			   97,  519,  101,  253,   92,  140,   98,  137,   99,  119,
			  119,  119,  102,   95,  138,  143,   96,  146,  252,  131,
			   97,  100,  131,  100,   93,   94,   95,  139,   99,   98,
			   96,  103,   97,  111,  111,  111,  111,  140,   98,  203,
			   99,  251,  203,  519,  102,  144,  147,  143,  111,  146,

			  101,  101,  115,  100,  115,  115,  115,  115,  250,  148,
			  144,  150,  153,  103,  249,  121,  121,  121,  121,  115,
			  155,  116,  156,  116,  116,  116,  116,  144,  147,  248,
			  111,  247,  101,  106,  246,  116,  106,  245,  106,  106,
			  106,  148,  144,  150,  153,  117,  106,  117,  117,  117,
			  117,  115,  155,  106,  156,  106,  121,  157,  106,  106,
			  106,  106,  141,  106,  116,  106,  141,  116,  145,  106,
			  154,  106,  145,  160,  106,  106,  106,  106,  106,  106,
			  141,  151,  154,  151,  158,  151,  161,  244,  117,  157,
			  164,  163,  165,  158,  141,  163,  151,  243,  141,  151,

			  145,  166,  154,  242,  145,  160,  167,  169,  170,  240,
			  171,  172,  141,  151,  154,  151,  158,  151,  161,  162,
			  239,  162,  164,  163,  165,  158,  238,  163,  151,  162,
			  237,  151,  162,  166,  162,  162,  168,  272,  167,  169,
			  170,  168,  171,  172,  207,  207,  207,  176,  176,  176,
			  521,  162,  168,  162,  176,  182,  182,  182,  182,  273,
			  219,  162,  221,  219,  162,  221,  162,  162,  168,  272,
			  202,  202,  202,  168,  202,  209,  209,  209,  213,  213,
			  213,  213,  223,  213,  168,  223,  213,  214,  214,  214,
			  224,  273,  521,  224,  236,  225,  226,  210,  225,  226,

			  227,  231,  227,  205,  231,  227,  228,  232,  174,  228,
			  232,  219,  107,  221,  105,  229,  229,  229,  224,  229,
			  266,  266,  229,  241,  241,  241,  241,  202,  276,  259,
			  259,  259,  259,  223,  213,  225,  262,  262,  262,  262,
			  226,  224,  214,  219,  259,  221,  225,  226,  228,  279,
			  224,  262,  231,  227,  268,  268,  268,  228,  232,  202,
			  276,  266,   84,   82,  280,  223,  213,  225,   74,  281,
			  229,   65,  226,  224,  214,   59,  259,   38,  225,  226,
			  228,  279,  277,  262,  231,  227,  260,  282,  260,  228,
			  232,  260,  260,  260,  260,  268,  280,   33,  263,  277,

			  263,  281,  229,  263,  263,  263,  263,  264,  283,  264,
			  264,  264,  264,  265,  277,  265,  265,  265,  265,  282,
			  270,  264,  270,  270,  270,  270,  271,  271,  271,  271,
			  284,  277,  285,  286,  287,   13,  289,  290,  291,  292,
			  283,  293,  294,  295,  296,  297,  298,  299,  300,  301,
			  264,  290,  302,  264,  303,  294,  265,  304,  305,  307,
			  308,  309,  284,  270,  285,  286,  287,  271,  289,  290,
			  291,  292,  311,  293,  294,  295,  296,  297,  298,  299,
			  300,  301,  310,  290,  302,  310,  303,  294,  312,  304,
			  305,  307,  308,  309,  313,  314,  316,  315,  317,  318,

			  319,  320,  321,  322,  311,  323,  324,  325,  326,  327,
			  328,  334,  334,  334,  310,  315,  339,  310,    8,  339,
			  312,  331,  331,  331,  331,  331,  313,  314,  316,  315,
			  317,  318,  319,  320,  321,  322,    7,  323,  324,  325,
			  326,  327,  328,  338,    0,  338,  340,  315,  338,  340,
			  341,  343,  339,  341,  343,  453,  453,  453,  351,  351,
			  351,  351,  351,  684,  684,  684,  334,  339,  378,  378,
			    0,  351,  351,  352,  352,  352,  352,  352,    0,  341,
			  369,  369,  369,  369,  339,  370,  370,  370,  370,  371,
			  371,  371,  371,  351,  385,  369,  338,  340,  334,  339, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  386,  341,  343,  351,  351,  372,  372,  372,  372,  378,
			  373,  341,  373,    0,    0,  373,  373,  373,  373,    0,
			  372,  369,  685,  685,  685,  351,  385,  369,  338,  340,
			    0,    0,  386,  341,  343,  374,  374,  374,  374,  375,
			  375,  375,  375,  376,  387,  376,  376,  376,  376,  388,
			  389,  377,  372,  377,  377,  377,  377,  376,  383,  390,
			  383,  383,  383,  383,  384,  391,  384,  384,  384,  384,
			  392,  393,  394,  395,  396,    0,  387,  397,  398,  399,
			  400,  388,  389,  401,  402,  403,  376,  404,  406,  376,
			  407,  390,  408,  409,  377,  410,  411,  391,  412,  414,

			  417,  383,  392,  393,  394,  395,  396,  384,  420,  397,
			  398,  399,  400,  421,  422,  401,  402,  403,  423,  404,
			  406,  424,  407,  425,  408,  409,  426,  410,  411,  427,
			  412,  414,  417,  418,  418,  418,  428,  418,  429,  430,
			  420,  431,  432,  435,  436,  421,  422,  437,  418,  438,
			  423,  439,    0,  424,  445,  425,  447,  445,  426,  447,
			    0,  427,  443,  443,  443,  443,  443,    0,  428,    0,
			  429,  430,  464,  431,  432,  435,  436,  449,  465,  437,
			  449,  438,    0,  439,  455,  455,  455,  455,    0,  447,
			  456,  456,  456,  456,  457,  457,  457,  457,  445,  455,

			  458,  458,  458,  458,  464,  445,  466,  447,  469,  457,
			  465,  471,    0,  449,  459,  459,  459,  459,  473,  474,
			  461,  447,  461,  461,  461,  461,  475,  476,  449,    0,
			  445,  455,  470,  477,  478,  457,  470,  445,  466,  447,
			  469,  457,  479,  471,  460,  449,  460,  460,  460,  460,
			  473,  474,  481,  482,  483,  484,  486,  487,  475,  476,
			  449,  460,  488,  461,  470,  477,  478,  490,  470,  494,
			  495,  496,  497,  498,  479,  491,  491,  491,  499,  491,
			  500,  501,  502,  504,  481,  482,  483,  484,  486,  487,
			  491,  505,  508,  460,  488,  509,  511,  514,    0,  490,

			  514,  494,  495,  496,  497,  498,  515,    0,  516,  515,
			  499,  516,  500,  501,  502,  504,  518,  518,  518,  525,
			  525,  525,  525,  505,  508,    0,    0,  509,  511,  514,
			  520,  520,  520,  520,  522,  515,  522,  529,  530,  522,
			  522,  522,  522,  687,  687,  687,  531,    0,  514,    0,
			  533,  516,    0,  523,  523,  523,  523,  515,  518,  516,
			  534,  514,  524,  524,  524,  524,  535,  515,  523,  529,
			  530,  527,  520,  527,  527,  527,  527,  524,  531,  526,
			  514,  526,  533,  516,  526,  526,  526,  526,  527,  515,
			  536,  516,  534,  539,  541,  542,  544,  545,  535,  546,

			  523,  547,  548,  549,  552,  553,  555,  556,  558,  524,
			  562,  563,  565,    0,  568,    0,  567,  568,  569,  567,
			  527,  569,  536,    0,  587,  539,  541,  542,  544,  545,
			  588,  546,  590,  547,  548,  549,  552,  553,  555,  556,
			  558,    0,  562,  563,  565,  567,    0,  569,  578,  578,
			  578,  578,  579,  579,  579,  579,  587,  568,  580,  580,
			  580,  580,  588,  592,  590,  568,  593,  567,  594,  569,
			  595,  598,  601,  580,    0,    0,  581,  567,  581,  569,
			    0,  581,  581,  581,  581,  582,    0,  582,    0,  568,
			  582,  582,  582,  582,    0,  592,  602,  568,  593,  567,

			  594,  569,  595,  598,  601,  580,  583,  583,  583,  583,
			  584,  584,  584,  584,  585,  585,  585,  585,  586,  604,
			  586,  583,  605,  586,  586,  586,  586,  606,  602,  603,
			  603,  603,  608,  609,  612,  613,  614,  612,  613,  614,
			    0,  619,  620,  620,  620,  620,  621,  621,  621,  621,
			  629,  604,  632,  583,  605,  622,  622,  622,  622,  606,
			  603,    0,    0,  645,  608,  609,  645,  619,  623,  623,
			  623,  623,  612,  619,  624,  624,  624,  624,  626,  626,
			  626,  626,  629,  636,  632,  612,  613,  614,  625,  624,
			  625,  639,  603,  625,  625,  625,  625,  627,  627,  627,

			  627,  638,  638,  638,  612,  640,  642,  648,  649,  649,
			  649,  649,  652,  654,  645,  636,  655,  612,  613,  614,
			  660,  624,  661,  639,  650,  650,  650,  650,  662,  663,
			  664,    0,  638,  648,  688,  688,  688,  640,  642,  648,
			    0,    0,    0,    0,  652,  654,  645,    0,  655,    0,
			    0,    0,  660,    0,  661,    0,    0,    0,    0,    0,
			  662,  663,  664,    0,  638,  668,  668,  668,  668,  668,
			  668,  668,  668,  668,  668,  668,  668,  668,  668,  668,
			  669,  669,  669,  669,  669,  669,  669,  669,  669,  669,
			  669,  669,  669,  669,  669,  670,  670,  670,  670,  670,

			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  671,  671,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  672,  672,  672,  672,  672,
			  672,  672,  672,  672,  672,  672,  672,  672,  672,  672,
			  673,    0,  673,  673,  673,  673,  673,  673,  673,  673,
			  673,  673,  673,  673,  673,  674,    0,  674,    0,  674,
			  674,  674,  674,  674,  674,  674,  674,  674,  675,    0,
			  675,  675,  675,  675,  675,  675,  675,  675,  675,  675,
			  675,  675,  675,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  677,    0,  677,  677,  677,    0,  677,  677,

			  677,  677,  677,  677,  677,  677,  677,  678,  678,  678,
			  678,  678,  678,  678,  678,  678,  678,  678,  678,  678,
			  678,  678,  679,  679,  679,  679,  679,  679,  679,  679,
			  679,  679,  679,  679,  679,  679,  679,  680,  680,  680,
			  680,  680,  680,  680,  680,  680,  680,  680,  680,  680,
			  680,  680,  681,    0,  681,  681,  681,  681,  681,  681,
			  681,  681,  681,  681,  681,  681,  681,  682,    0,  682,
			    0,  682,  682,  682,  682,  682,  682,  682,  682,  682,
			  682,  682,  683,    0,  683,  683,  683,  683,  683,  683,
			  683,  683,  683,  683,  683,  683,  683,  686,    0,  686,

			  686,  686,  686,  686,  686,  686,  686,  686,  686,  686,
			  686,  686,  689,  689,  689,  689,  689,  689,  689,  689,
			  689,  689,  689,  689,  689,  689,  689,  690,    0,  690,
			  690,  690,  690,  690,  690,  690,  690,  690,  690,  690,
			  690,  690,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667, yy_Dummy>>,
			1, 35, 2000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   90,   91,   99,  104,  933,  915,  109,
			  112,  115,  118,  835, 1942,  121,  124, 1942,  190,    0,
			 1942,  120, 1942, 1942, 1942, 1942, 1942,   81,  122,  120,
			  128,  147,  154,  770, 1942,  107, 1942,  109,  750,  182,
			   91,  185,  121,  195,  239,    0,  239,  114,  107,  252,
			  123,  120,  175,  247,  137,  209,  168,  183, 1942,  717,
			 1942, 1942, 1942, 1942, 1942,  765, 1942, 1942,  331,  177,
			  307, 1942, 1942,  240,  765, 1942, 1942,  287, 1942, 1942,
			  301,  319,  746,  343,  745,  330, 1942,  347,  184,  332,
			  346,  352,  365,  385,  386,  387,  391,  393,  399,  401,

			  414,  443,  405,  424,    0,  703,  527,  701, 1942, 1942,
			 1942,  463, 1942, 1942, 1942,  484,  503,  527,  181,  439,
			    0,  495, 1942, 1942, 1942, 1942, 1942, 1942, 1942,    0,
			  210,  398,  258,  244,  247,  249,  319,  394,  388,  410,
			  407,  530,    0,  416,  461,  522,  425,  465,  464,    0,
			  465,  547,    0,  471,  537,  470,  473,  523,  551,    0,
			  525,  551,  585,  549,  542,  557,  550,  560,  602,  559,
			  569,  575,  563, 1942,  702, 1942,  645, 1942, 1942, 1942,
			 1942, 1942,  635, 1942, 1942, 1942, 1942, 1942, 1942, 1942,
			 1942, 1942, 1942, 1942, 1942, 1942, 1942, 1942, 1942,  382,

			 1942, 1942,  668,  486, 1942,  700, 1942,  642, 1942,  673,
			  690, 1942, 1942,  677,  685, 1942, 1942, 1942, 1942,  654,
			 1942,  656, 1942,  676,  684,  689,  690,  696,  700,  713,
			 1942,  695,  701, 1942, 1942, 1942,  683,  619,  615,  609,
			  598,  703,  592,  586,  576,  526,  523,  520,  518,  503,
			  497,  480,  457,  442,  428,  418,  413,  404, 1942,  709,
			  771, 1942,  716,  783,  789,  795,  700,  345,  734,  340,
			  802,  806,  593,  628,    0,    0,  689,  751,    0,  716,
			  715,  717,  756,  760,  779,  797,  802,  799,    0,  785,
			  806,  803,  790,  791,  799,  801,  809,  806,  811,  801,

			  817,  814,  821,  808,  822,  813,    0,  824,  805,  811,
			  849,  837,  853,  863,  844,  864,  848,  863,  868,  861,
			  857,  867,  861,  870,  859,  868,  869,  875,  866,    0,
			 1942,  902,    0,  316,  909, 1942, 1942, 1942,  939,  910,
			  940,  944, 1942,  945, 1942, 1942, 1942, 1942, 1942, 1942,
			 1942,  939,  954, 1942, 1942, 1942, 1942, 1942, 1942, 1942,
			 1942, 1942, 1942, 1942, 1942, 1942, 1942, 1942, 1942,  960,
			  965,  969,  985,  995, 1015, 1019, 1025, 1033,  948,  311,
			    0,  309,  350, 1040, 1046,  944,  951, 1007, 1016, 1011,
			 1018, 1016, 1035, 1021, 1037, 1036, 1026, 1044, 1039, 1031,

			 1036, 1035, 1036, 1050, 1036,    0, 1053, 1051, 1038, 1039,
			 1047, 1061, 1050,    0, 1057,    0,    0, 1058, 1131,    0,
			 1069, 1062, 1075, 1082, 1073, 1080, 1087, 1078, 1094, 1083,
			 1106, 1093, 1096,    0,    0, 1108, 1108, 1096, 1107, 1120,
			    0,    0, 1942, 1143,  247, 1148, 1942, 1150, 1942, 1171,
			 1942,  301,  356,  935,    0, 1164, 1170, 1174, 1180, 1194,
			 1226, 1202,    0,    0, 1128, 1140, 1174,    0,    0, 1160,
			 1197, 1167,    0, 1170, 1181, 1190, 1192, 1199, 1184, 1198,
			    0, 1204, 1209, 1219, 1216,    0, 1217, 1224, 1223,    0,
			 1232, 1273, 1942,  291, 1238, 1222, 1217, 1233, 1238, 1243,

			 1232, 1246, 1232,    0, 1233, 1260,    0,    0, 1253, 1260,
			    0, 1252,  282,  202, 1291, 1300, 1302, 1942, 1297,  432,
			 1311,  631, 1319, 1333, 1342, 1299, 1364, 1353,    0, 1302,
			 1287, 1296,    0, 1305, 1310, 1331, 1359,    0,    0, 1358,
			    0, 1363, 1360,    0, 1347, 1353, 1349, 1351, 1371, 1353,
			 1942,  249, 1362, 1356,    0, 1362, 1363,    0, 1373,    0,
			    0,    0, 1360, 1367,    0, 1362,  155, 1410, 1408, 1412,
			  206,  175,  167,  112,  153,  138,   93,   34, 1428, 1432,
			 1438, 1461, 1470, 1486, 1490, 1494, 1503, 1390, 1380,    0,
			 1388,    0, 1429, 1434, 1434, 1428,    0,    0, 1434,    0,

			    0, 1428, 1461, 1527, 1474, 1487, 1494,    0, 1497, 1498,
			    0,    0, 1528, 1529, 1530, 1942, 1942, 1942, 1942, 1506,
			 1522, 1526, 1535, 1548, 1554, 1573, 1558, 1577,    0, 1515,
			    0,    0, 1510,    0,    0,    0, 1533,    0, 1599, 1549,
			 1557,    0, 1571,    0,    0, 1557, 1942, 1942, 1572, 1588,
			 1604,    0, 1577,    0, 1571, 1585,    0,    0, 1942,    0,
			 1589, 1573, 1579, 1580, 1581,    0, 1942, 1942, 1664, 1679,
			 1694, 1709, 1724, 1739, 1752, 1767, 1776, 1791, 1806, 1821,
			 1836, 1851, 1866, 1881,  956, 1015, 1896, 1336, 1627, 1911,
			 1926, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  667,    1,  668,  668,  669,  669,  670,  670,  671,
			  671,  672,  672,  667,  667,  667,  667,  667,  673,  674,
			  667,  675,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  667,  667,
			  667,  667,  667,  667,  667,  677,  667,  667,  667,  678,
			  678,  667,  667,  679,  680,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  673,  667,  681,  682,  673,
			  673,  673,  673,  673,  673,  673,  673,  673,  673,  673,

			  673,  673,  673,  673,  674,  683,  683,  683,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  684,  684,
			  685,  667,  667,  667,  667,  667,  667,  667,  667,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  667,  677,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  678,

			  667,  667,  678,  679,  667,  680,  667,  667,  667,  667,
			  686,  667,  667,  681,  682,  667,  667,  667,  667,  673,
			  667,  673,  667,  673,  673,  673,  673,  673,  673,  673,
			  667,  673,  673,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  684,  684,  684,  685,
			  667,  667,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,

			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  667,  667,  686,  686,  682,  667,  667,  667,  673,  673,
			  673,  673,  667,  673,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  684,  684,
			  268,  685,  667,  667,  667,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,

			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  667,  667,  686,  673,  667,  673,  667,  673,
			  667,  667,  687,  687,  688,  667,  667,  667,  667,  667,
			  667,  667,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  667,  667,  667,  676,  676,  676,  676,  676,  676,

			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  667,  686,  673,  673,  673,  667,  687,  687,
			  687,  688,  667,  667,  667,  667,  667,  667,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  667,  689,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  686,  673,  673,  673,
			  667,  518,  667,  687,  667,  520,  667,  688,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  676,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,

			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  690,  673,  673,  673,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  667,  676,
			  676,  676,  676,  676,  676,  673,  667,  667,  667,  667,
			  667,  676,  676,  676,  667,  676,  676,  676,  667,  676,
			  667,  676,  667,  676,  667,  676,  667,    0,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,
			  667, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
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

	yy_meta_template: SPECIAL [INTEGER] is
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

	yy_accept_template: SPECIAL [INTEGER] is
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
			  237,  238,  239,  240,  242,  243,  244,  245,  246,  247,
			  248,  249,  250,  252,  253,  254,  255,  256,  257,  258,
			  260,  261,  262,  264,  265,  266,  267,  268,  269,  270,
			  272,  273,  274,  275,  276,  277,  278,  279,  280,  281,
			  282,  283,  284,  285,  286,  287,  288,  288,  289,  290,
			  291,  292,  293,  293,  294,  295,  296,  297,  298,  299,
			  300,  301,  302,  303,  304,  305,  306,  307,  308,  309,

			  310,  311,  312,  313,  314,  316,  317,  318,  318,  319,
			  320,  321,  322,  324,  326,  327,  329,  331,  333,  335,
			  336,  338,  339,  341,  342,  343,  344,  345,  346,  347,
			  348,  349,  350,  351,  353,  354,  356,  357,  358,  359,
			  360,  361,  362,  363,  364,  365,  366,  367,  368,  369,
			  370,  371,  372,  373,  374,  375,  376,  377,  378,  380,
			  381,  381,  382,  383,  383,  384,  385,  387,  388,  390,
			  391,  392,  392,  393,  394,  396,  398,  399,  400,  402,
			  403,  404,  405,  406,  407,  408,  409,  410,  411,  413,
			  414,  415,  416,  417,  418,  419,  420,  421,  422,  423,

			  424,  425,  426,  427,  428,  430,  431,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,
			  446,  447,  448,  449,  450,  451,  452,  453,  454,  455,
			  457,  458,  458,  459,  460,  460,  462,  464,  466,  467,
			  468,  469,  470,  472,  473,  475,  477,  478,  479,  480,
			  481,  482,  483,  484,  485,  486,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  499,  500,
			  501,  501,  502,  503,  503,  503,  504,  505,  506,  506,
			  506,  506,  506,  506,  507,  508,  509,  510,  511,  512,
			  513,  514,  515,  516,  517,  518,  519,  520,  521,  523,

			  524,  525,  526,  527,  528,  529,  531,  532,  533,  534,
			  535,  536,  537,  538,  540,  541,  543,  545,  546,  548,
			  550,  551,  552,  553,  554,  555,  556,  557,  558,  559,
			  560,  561,  562,  563,  565,  567,  568,  569,  570,  571,
			  572,  574,  576,  577,  577,  578,  579,  581,  582,  584,
			  585,  587,  588,  588,  588,  588,  589,  589,  590,  590,
			  591,  592,  593,  595,  597,  598,  599,  600,  602,  604,
			  605,  606,  607,  609,  610,  611,  612,  613,  614,  615,
			  616,  618,  619,  620,  621,  622,  624,  625,  626,  627,
			  629,  630,  630,  631,  631,  632,  633,  634,  635,  636,

			  637,  638,  639,  640,  642,  643,  644,  646,  648,  649,
			  650,  652,  653,  653,  654,  655,  656,  657,  658,  658,
			  658,  658,  658,  658,  659,  660,  660,  660,  661,  663,
			  664,  665,  666,  668,  669,  670,  671,  672,  674,  676,
			  677,  679,  680,  681,  683,  684,  685,  686,  687,  688,
			  689,  690,  690,  691,  692,  694,  695,  696,  698,  699,
			  701,  703,  705,  706,  707,  709,  710,  711,  712,  713,
			  714,  714,  714,  714,  714,  714,  714,  714,  714,  714,
			  715,  716,  716,  716,  717,  717,  718,  718,  719,  720,
			  722,  723,  725,  726,  727,  728,  729,  731,  733,  734,

			  736,  738,  739,  740,  741,  742,  743,  744,  746,  747,
			  748,  750,  752,  753,  754,  755,  757,  758,  760,  761,
			  762,  762,  763,  763,  764,  765,  765,  765,  766,  768,
			  769,  771,  773,  774,  776,  778,  780,  781,  783,  783,
			  784,  785,  787,  788,  790,  792,  793,  795,  797,  798,
			  798,  799,  801,  802,  804,  804,  805,  807,  809,  811,
			  813,  813,  814,  814,  815,  815,  817,  818,  818, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  182,  182,  184,  184,  215,  213,  214,    1,  213,
			  214,    1,  214,   36,  213,  214,  185,  213,  214,   41,
			  213,  214,   14,  213,  214,  152,  213,  214,   24,  213,
			  214,   25,  213,  214,   32,  213,  214,   30,  213,  214,
			    9,  213,  214,   31,  213,  214,   13,  213,  214,   33,
			  213,  214,  117,  213,  214,  117,  213,  214,  117,  213,
			  214,    8,  213,  214,    7,  213,  214,   18,  213,  214,
			   17,  213,  214,   19,  213,  214,   11,  213,  214,  115,
			  213,  214,  115,  213,  214,  115,  213,  214,  115,  213,
			  214,  115,  213,  214,  115,  213,  214,  115,  213,  214,

			  115,  213,  214,  115,  213,  214,  115,  213,  214,  115,
			  213,  214,  115,  213,  214,  115,  213,  214,  115,  213,
			  214,  115,  213,  214,  115,  213,  214,  115,  213,  214,
			  115,  213,  214,  115,  213,  214,   28,  213,  214,  213,
			  214,   29,  213,  214,   34,  213,  214,   26,  213,  214,
			   27,  213,  214,   12,  213,  214,  186,  214,  212,  214,
			  210,  214,  211,  214,  182,  214,  182,  214,  181,  214,
			  180,  214,  182,  214,  184,  214,  183,  214,  178,  214,
			  178,  214,  177,  214,    6,  214,    5,    6,  214,    5,
			  214,    6,  214,    1,  185,  174,  185,  185,  185,  185,

			  185,  185,  185,  185,  185,  185,  185,  185,  185, -390,
			  185,  185,  185, -390,   41,  152,  152,  152,    2,   35,
			   10,  123,   39,   23,   22,  123,  117,  117,  116,  116,
			   15,   37,   20,   21,   38,   16,  115,  115,  115,  115,
			   46,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			   60,  115,  115,  115,  115,  115,  115,  115,   72,  115,
			  115,  115,   79,  115,  115,  115,  115,  115,  115,  115,
			   91,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,   40,  186,  210,  203,  201,
			  202,  204,  205,  206,  207,  187,  188,  189,  190,  191,

			  192,  193,  194,  195,  196,  197,  198,  199,  200,  182,
			  181,  180,  182,  182,  179,  180,  184,  183,  177,    5,
			    4,  175,  173,  175,  185, -390, -390,  160,  175,  158,
			  175,  159,  175,  161,  175,  185,  154,  175,  185,  155,
			  175,  185,  185,  185,  185,  185,  185,  185, -176,  185,
			  185,  162,  175,  152,  124,  152,  152,  152,  152,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  125,  152,
			  123,  118,  123,  117,  117,  121,  122,  122,  120,  122,
			  119,  117,  115,  115,   44,  115,   45,  115,  115,  115,

			   50,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,   63,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,   83,  115,
			  115,   86,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  114,  115,  209,    4,    4,
			  163,  175,  156,  175,  157,  175,  185,  185,  185,  185,
			  170,  175,  185,  165,  175,  164,  175,  142,  140,  141,
			  143,  144,  153,  153,  145,  146,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,

			  123,  123,  123,  123,  117,  117,  117,  117,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,   61,  115,  115,  115,  115,  115,  115,  115,   70,
			  115,  115,  115,  115,  115,  115,  115,  115,   80,  115,
			  115,   82,  115,   84,  115,  115,   89,  115,   90,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  115,  105,  115,  106,  115,  115,  115,  115,
			  115,  115,  112,  115,  113,  115,  208,    4,  185,  166,
			  175,  185,  169,  175,  185,  172,  175,  153,  123,  123,
			  123,  123,  117,   42,  115,   43,  115,  115,  115,  115,

			   51,  115,   52,  115,  115,  115,  115,   57,  115,  115,
			  115,  115,  115,  115,  115,  115,   68,  115,  115,  115,
			  115,  115,   75,  115,  115,  115,  115,   81,  115,  115,
			   87,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  101,  115,  115,  115,  104,  115,  107,  115,  115,  115,
			  110,  115,  115,    4,  185,  185,  185,  147,  123,  123,
			  123,   47,  115,  115,  115,  115,   54,  115,  115,  115,
			  115,  115,   62,  115,   64,  115,  115,   66,  115,  115,
			  115,   71,  115,  115,  115,  115,  115,  115,  115,   88,
			  115,  115,   94,  115,  115,  115,   97,  115,  115,   99,

			  115,  100,  115,  102,  115,  115,  115,  109,  115,  115,
			    4,  185,  185,  185,  123,  123,  123,  123,  115,  115,
			   53,  115,  115,   56,  115,  115,  115,  115,  115,   69,
			  115,   73,  115,  115,   76,  115,   77,  115,  115,  115,
			  115,  115,  115,  115,   98,  115,  115,  115,  111,  115,
			    3,    4,  185,  185,  185,  150,  151,  151,  149,  151,
			  148,  123,  123,  123,  123,  123,   48,  115,  115,   55,
			  115,   58,  115,  115,   65,  115,   67,  115,   74,  115,
			  115,   85,  115,  115,  115,   95,  115,  115,  103,  115,
			  108,  115,  185,  168,  175,  171,  175,  123,  123,   49,

			  115,  115,   78,  115,  115,   93,  115,   96,  115,  167,
			  175,   59,  115,  115,  115,   92,  115,   92, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1942
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 667
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 668
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 214
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 215
			-- End of buffer rule code

	yyLine_used: BOOLEAN is true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is true
			-- Is `position' used?

	INITIAL: INTEGER is 0
	SPECIAL_STR: INTEGER is 1
	VERBATIM_STR1: INTEGER is 2
	VERBATIM_STR2: INTEGER is 3
	VERBATIM_STR3: INTEGER is 4
	PRAGMA: INTEGER is 5
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
