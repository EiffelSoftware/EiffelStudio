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
 
				update_character_locations
				ast_factory.create_break_as (Current)  
		
when 2 then
	yy_end := yy_end - 2
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				save_break_as_data
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				set_start_condition (PRAGMA)
		
when 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

			less (0)
			create_break_as_with_saved_data
			set_start_condition (INITIAL)
		
when 7 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
when 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 13 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 15 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
				if has_syntax_warning and then syntax_version /= obsolete_syntax then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Assignment attempt symbol %"?=%" is not part of ECMA/ISO Eiffel and will not be supported in the future. Use object test instead."))
				end
			
when 17 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 18 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 20 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 21 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			
when 23 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 36 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 38 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 39 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 40 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 41 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 42 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 43 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ACROSS, Current)
					last_token := TE_ACROSS
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `across' is used as identifier."))
					end
				end
			
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 45 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 47 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 48 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 49 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 50 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
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

				update_character_locations
				if syntax_version /= obsolete_syntax then
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
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 53 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 54 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 55 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 56 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 57 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 58 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 59 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 60 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
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

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 62 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 63 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 64 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 65 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 66 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 67 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 68 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 69 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 71 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 72 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 73 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 74 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 75 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = ecma_syntax or else syntax_version = provisional_syntax then
					process_id_as
					last_token := TE_ID
				else
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_INDEXING, Current)
					last_token := TE_INDEXING
					if has_syntax_warning and then syntax_version /= obsolete_syntax then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Usage of `indexing' has been replaced by `note'."))
					end

				end
			
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 77 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 78 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 79 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 80 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = ecma_syntax or else syntax_version = provisional_syntax then
					process_id_as
					last_token := TE_ID
				else
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
					last_token := TE_IS
					if has_syntax_warning and then syntax_version /= obsolete_syntax then
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

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 82 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 83 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 84 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 85 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
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
			
when 86 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 87 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 88 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- `{' is for the typed manifest string.
				last_detachable_keyword_as_value := ast_factory.new_once_string_keyword_as (text, line, column, position, 4, character_column, character_position, 4)
				last_token := TE_ONCE_STRING
			
when 89 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- `{' is for the typed manifest string.
				last_detachable_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4), line, column, position, 4, character_column, character_position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4, character_column + 4, character_position + 4, unicode_text_count - 4)
				last_token := TE_ONCE_STRING
			
when 90 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 91 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
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

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 93 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 94 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 96 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 97 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 99 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 103 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 104 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_SOME, Current)
					last_token := TE_SOME
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `some' is used as identifier."))
					end
				end
			
when 106 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 107 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 108 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 110 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 111 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 112 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 113 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 118 then
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
				update_character_locations
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 119 then
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
				update_character_locations
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes hexadecimal integer numbers.
				update_character_locations
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
		-- Recognizes octal integer numbers.
				update_character_locations
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
		-- Recognizes binary integer numbers.
				update_character_locations
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
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 124 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			
when 125 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as (char_32_from_source (text_substring (2, text_count - 1)), line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 126 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as (char_32_from_source (text_substring (2, text_count - 1)), line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 127 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- This is not correct Eiffel!
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%A', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%B', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%C', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%D', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%F', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%H', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%L', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%N', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%Q', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%R', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%S', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%T', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%U', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%V', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%%', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%"', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 145 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%(', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 146 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%)', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 147 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%<', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 148 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as ('%>', line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 149 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 150 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 151 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 152 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 153 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 154 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
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

				update_character_locations
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

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 157 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 158 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 159 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 160 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 161 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 164 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 166 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 167 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 168 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 169 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 170 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 171 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 172 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 173 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 174 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 175 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 176 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 179 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 180 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
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
				start_location.set_position (line, column, position, text_count, character_column, character_position, unicode_text_count)
				set_start_condition (VERBATIM_STR3)
			
when 181 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				set_start_condition (VERBATIM_STR1)
			
when 182 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 183 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if is_verbatim_string_closer then
					set_start_condition (INITIAL)
						-- Remove the trailing new-line.
					if token_buffer.count > 1 then
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
						last_detachable_string_as_value := ast_factory.new_verbatim_string_as ("",
							verbatim_marker.substring (2, verbatim_marker.count), verbatim_marker.item (1) = ']',
							start_location.line, start_location.column, start_location.position,
							position + text_count - start_location.position, 
							start_location.character_column, start_location.character_position,
							character_position + unicode_text_count - start_location.character_position, 
							verbatim_common_columns, roundtrip_token_buffer)
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_detachable_string_as_value := ast_factory.new_verbatim_string_as (cloned_string (token_buffer),
							verbatim_marker.substring (2, verbatim_marker.count), verbatim_marker.item (1) = ']',
							start_location.line, start_location.column, start_location.position,
							position + text_count - start_location.position, 
							start_location.character_column, start_location.character_position,
							character_position + unicode_text_count - start_location.character_position, 
							verbatim_common_columns, roundtrip_token_buffer)
						last_token := TE_VERBATIM_STRING
						if token_buffer.count > maximum_string_length then
							report_too_long_string (token_buffer)
						end
					end
				else
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 185 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 186 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 187 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 188 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 189 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- String with special characters.
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				start_location.set_position (line, column, position, text_count, character_column, character_position, unicode_text_count)
				set_start_condition (SPECIAL_STR)
			
when 190 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 212 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_natural_32)
			
when 213 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			
when 214 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_detachable_string_as_value := ast_factory.new_string_as (
						cloned_string (token_buffer), start_location.line, start_location.column,
						start_location.position,
						position + text_count - start_location.position,
						start_location.character_column,
						start_location.character_position,
						character_position + unicode_text_count - start_location.character_position,
						roundtrip_token_buffer)
					last_token := TE_EMPTY_STRING
				else
					last_detachable_string_as_value := ast_factory.new_string_as (
						cloned_string (token_buffer), start_location.line, start_location.column,
						start_location.position,
						position + text_count - start_location.position, 
						start_location.character_column,
						start_location.character_position,
						character_position + unicode_text_count - start_location.character_position,
						roundtrip_token_buffer)
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
			
when 215 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Bad special character.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 216 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 217 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 218 then
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

				update_character_locations
					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 2 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 3 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 4 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 5 then
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

			update_character_locations
			create_break_as_with_saved_data
			set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 3864)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			yy_nxt_template_14 (an_array)
			yy_nxt_template_15 (an_array)
			yy_nxt_template_16 (an_array)
			yy_nxt_template_17 (an_array)
			yy_nxt_template_18 (an_array)
			yy_nxt_template_19 (an_array)
			yy_nxt_template_20 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   14,   15,   16,   15,   15,   17,   18,   19,   20,
			   14,   19,   21,   22,   23,   24,   25,   26,   27,   28,
			   29,   30,   31,   31,   31,   32,   33,   34,   35,   36,
			   37,   19,   38,   39,   40,   41,   42,   43,   39,   39,
			   44,   39,   39,   45,   39,   46,   47,   48,   39,   49,
			   50,   51,   52,   53,   54,   55,   39,   39,   56,   57,
			   58,   59,   14,   14,   38,   39,   40,   41,   42,   43,
			   39,   39,   44,   39,   39,   45,   39,   46,   47,   48,
			   39,   49,   50,   51,   52,   53,   54,   55,   39,   39,
			   60,   19,   61,   62,   14,   14,   14,   14,   14,   14,

			   14,   14,   14,   14,   14,   63,   64,   65,   66,   67,
			   68,   69,   70,   71,   72,   73,   75,   75,  150,  593,
			   76,   76,  195,   77,   77,   79,   80,   79,   79,  151,
			   81,   79,   80,   79,   79,  202,   81,   90,   91,   90,
			   90,  164,  165,   90,   91,   90,   90,  166,  167,   97,
			   98,   97,   97,  200,  195,   97,   98,   97,   97,  181,
			  209,  104,  104,  104,  104,   99,  807,  202,  210,  182,
			  201,   99,  104,  104,  104,  104,  152,  105,  153,  153,
			  153,  153,  211,   82,  193,  200,  154,  212,  105,   82,
			  194,  181,  209,  157,  155,  158,  158,  158,  158,  807, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  210,  182,  201,  213,  215,  215,  215,  215,  215,  215,
			  215,  216,  215,  215,  211,   82,  193,  279,  280,  212,
			  807,   82,  194,  217,  217,  217,  257,  363,   83,  833,
			  258,   84,   85,   86,   83,  213,  162,   84,   85,   86,
			   92,  289,  290,   93,   94,   95,   92,  293,  294,   93,
			   94,   95,  100,  830,  299,  101,  102,  103,  100,  156,
			  740,  101,  102,  103,  106,  807,  383,  107,  108,  109,
			  226,  226,  226,  226,  787,  106,  458,  459,  107,  108,
			  109,  111,  112,  786,  113,  112,  299,  114,  785,  115,
			  116,  186,  117,  257,  118,  187,  257,  265,  383,  784,

			  258,  119,  741,  120,  780,  112,  121,  157,  188,  158,
			  158,  158,  158,  183,  122,  184,  365,  365,  365,  123,
			  124,  159,  160,  186,  176,  185,  203,  187,  177,  125,
			  384,  178,  126,  127,  179,  128,  204,  180,  121,  385,
			  188,  205,  386,  161,  387,  183,  122,  184,  279,  280,
			  162,  123,  124,  159,  160,  257,  176,  185,  203,  258,
			  177,  125,  384,  178,  129,  112,  179,  649,  204,  180,
			  649,  385,  744,  205,  386,  161,  387,  649,  388,  130,
			  130,  131,  132,  132,  132,  132,  133,  134,  135,  136,
			  139,  170,  389,  390,  259,  171,  189,  140,  391,  141, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  172,  196,  173,  190,  191,  206,  392,  174,  175,  192,
			  388,  197,  393,  198,  745,  207,  394,  199,  208,  456,
			  456,  456,  456,  170,  389,  390,  649,  171,  189,  734,
			  391,  718,  172,  196,  173,  190,  191,  206,  392,  174,
			  175,  192,  715,  197,  393,  198,  269,  207,  394,  199,
			  208,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  218,  218,  218,  218,  218,  219,  218,  218,  218,
			  218,  220,  221,  218,  218,  218,  218,  218,  218,  218,
			  218,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  143,  143,  144,  145,  145,  145,  145,  146,

			  147,  148,  149,  222,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  223,  223,  223,  223,  223,  223,  223,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  229,  229,  229,  229,  649,  230,  398,  714,  231,  257,
			  232,  233,  234,  258,  259,  257,  259,  259,  235,  258,
			  257,  289,  290,  679,  258,  236,  296,  237,  675,  113,
			  238,  239,  240,  241,  373,  242,  301,  243,  398,  113,
			  257,  244,  302,  245,  258,  113,  246,  247,  248,  249, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  250,  251,  272,  273,  272,  272,  716,  717,  282,  282,
			  282,  282,  831,  832,  282,  282,  282,  282,  487,  487,
			  487,  595,  260,  104,  104,  104,  104,  129,  403,  296,
			  303,  229,  113,  113,  404,  304,  300,  129,  113,  105,
			  229,  229,  306,  129,  308,  113,  405,  113,  305,  381,
			  381,  381,  381,  252,  260,  266,  253,  254,  255,  129,
			  403,  267,  268,  307,  515,  309,  404,  261,  363,  129,
			  262,  263,  264,  323,  514,  129,  113,  513,  405,  257,
			  129,  129,  512,  265,  257,  511,  129,  406,  258,  296,
			  382,  296,  113,  129,  113,  129,  296,  296,  296,  113,

			  113,  113,  510,  296,  296,  274,  113,  113,  275,  276,
			  277,  283,  129,  129,  284,  285,  286,  283,  129,  406,
			  284,  285,  286,  509,  129,  129,  106,  129,  311,  107,
			  108,  109,  110,  110,  310,  110,  110,  312,  297,  313,
			  129,  113,  129,  314,  508,  412,  415,  129,  129,  129,
			  370,  370,  370,  370,  129,  129,  129,  257,  507,  506,
			  311,  258,  315,  316,  315,  315,  310,  296,  505,  312,
			  113,  313,  129,  504,  129,  314,  363,  412,  415,  129,
			  129,  129,  259,  325,  325,  325,  129,  129,  503,  298,
			  330,  330,  330,  330,  502,  501,  296,  500,  497,  113, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  315,  316,  315,  315,  296,  296,  496,  113,  113,  157,
			  495,  376,  376,  376,  376,  494,  332,  416,  129,  493,
			  317,  298,  217,  217,  217,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  129,  322,  416,
			  129,  296,  162,  266,  113,  129,  129,  417,  367,  367,
			  367,  367,  367,  367,  367,  318,  104,  104,  319,  320,
			  321,  296,  104,  420,  113,  272,  272,  272,  282,  129,
			  282,  282,  296,  462,  272,  113,  291,  129,  129,  417,
			  288,  324,  324,  324,  324,  324,  324,  324,  324,  324,

			  324,  296,  129,  318,  113,  420,  319,  320,  321,  333,
			  333,  334,  335,  335,  335,  335,  336,  337,  338,  339,
			  282,  399,  129,  272,  421,  430,  257,  272,  257,  272,
			  258,  281,  258,  129,  129,  431,  400,  278,  326,  326,
			  326,  326,  326,  326,  326,  326,  326,  326,  432,  272,
			  433,  401,  129,  399,  129,  402,  421,  430,  327,  327,
			  327,  327,  327,  327,  327,  129,  362,  431,  400,  328,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  434,
			  432,  428,  433,  401,  129,  429,  438,  402,  329,  329,
			  329,  329,  329,  329,  329,  329,  329,  329,  333,  333, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  334,  335,  335,  335,  335,  336,  337,  338,  339,  340,
			  363,  434,  341,  428,  342,  343,  344,  429,  438,  267,
			  268,  271,  345,  259,  460,  371,  371,  371,  371,  346,
			  457,  347,  229,  228,  348,  349,  350,  351,  363,  352,
			  372,  353,  439,  440,  413,  354,  441,  355,  363,  363,
			  356,  357,  358,  359,  360,  361,  414,  295,  363,  333,
			  333,  334,  335,  335,  335,  335,  336,  337,  338,  339,
			  292,  104,  372,  150,  439,  440,  413,  291,  441,  288,
			  282,  282,  282,  492,  492,  492,  492,  534,  414,  282,
			  282,  287,  364,  364,  364,  364,  364,  364,  364,  364,

			  364,  364,  498,  499,  499,  499,  281,  333,  333,  334,
			  335,  335,  335,  335,  336,  337,  338,  339,  278,  534,
			  366,  366,  366,  366,  366,  366,  366,  366,  366,  366,
			  368,  368,  368,  368,  368,  368,  368,  368,  368,  368,
			  369,  369,  369,  369,  369,  369,  369,  369,  369,  369,
			  373,  272,  374,  374,  374,  374,  271,  377,  377,  378,
			  378,  228,  214,  379,  379,  379,  378,  375,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378,
			  380,  380,  380,  380,  168,  257,  535,  468,  418,  258,
			  113,  380,  380,  380,  380,  380,  380,  419,  163,  375, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378,
			  378,  378,  395,  104,  104,  104,  396,  407,  535,  408,
			  418,  409,  104,  380,  380,  380,  380,  380,  380,  419,
			  397,  536,  410,  537,  435,  411,  540,  541,  129,  436,
			  104,  104,  104,  104,  395,  422,  846,  423,  396,  407,
			  437,  408,   88,  409,   88,  424,  105,  542,  425,  543,
			  426,  427,  397,  536,  410,  537,  435,  411,  540,  541,
			  129,  436,  226,  226,  226,  226,  269,  422,  520,  423,
			  520,  846,  437,  521,  521,  521,  521,  424,  846,  542,
			  425,  543,  426,  427,  442,  442,  443,  444,  444,  444,

			  444,  445,  446,  447,  448,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  216,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  846,  846,  257,  257,  846,
			  846,  258,  258,  449,  442,  443,  450,  451,  452,  444,
			  445,  446,  447,  448,  216,  216,  216,  215,  215,  215,
			  215,  215,  215,  216,  215,  215,  215,  215,  215,  215,
			  216,  215,  215,  215,  216,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  215,  215,  215,  215,  453,  453,  453,  453,  453,  453,
			  453,  453,  453,  453,  454,  454,  454,  454,  454,  454,
			  454,  454,  454,  454,  229,  229,  229,  229,  259,  259,
			  846,  846,  455,  259,  257,  259,  259,  469,  258,  846,
			  113,  470,  257,  846,  113,  538,  258,  272,  273,  272,
			  272,  544,  545,  282,  282,  282,  282,  229,  229,  229,
			  471,  296,  539,  113,  113,  296,  229,  846,  113,  463,
			  316,  463,  463,  846,  524,  296,  524,  538,  113,  525,
			  525,  525,  525,  544,  545,  475,  546,  476,  129,  472,
			  113,  260,  129,  846,  539,  846,  315,  316,  315,  315,

			  846,  296,  846,  846,  113,  473,  533,  533,  533,  533,
			  846,  129,  129,  547,  846,  846,  129,  846,  546,  474,
			  129,  472,  846,  260,  129,  299,  129,  252,  846,  846,
			  253,  254,  255,  259,  259,  259,  261,  473,  129,  262,
			  263,  264,  259,  129,  129,  547,  296,  382,  129,  113,
			  274,  474,  129,  275,  276,  277,  283,  299,  129,  284,
			  285,  286,  110,  315,  316,  315,  315,  846,  297,  548,
			  129,  113,  464,  846,  846,  465,  466,  467,  593,  594,
			  594,  594,  594,  549,  129,  552,  553,  846,  477,  608,
			  499,  499,  499,  499,  846,  478,  846,  129,  113,  318, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  846,  548,  319,  320,  321,  331,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  549,  554,  552,  553,  298,
			  477,  489,  489,  489,  489,  489,  489,  489,  296,  129,
			  296,  113,  296,  113,  846,  113,  296,  483,  484,  113,
			  113,  113,  521,  521,  521,  521,  129,  846,  554,  846,
			  557,  298,  846,  558,  559,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  318,  110,  110,  319,
			  320,  321,  110,  110,  110,  110,  110,  296,  129,  129,
			  113,  129,  557,  129,  550,  558,  559,  129,  129,  129,
			  157,  846,  526,  526,  526,  526,  296,  846,  551,  113,

			  488,  488,  488,  488,  488,  488,  488,  488,  488,  488,
			  846,  129,  846,  129,  846,  129,  550,  480,  481,  129,
			  129,  129,  315,  482,  479,  560,  296,  561,  129,  113,
			  551,  562,  846,  162,  846,  846,  130,  130,  131,  132,
			  132,  132,  132,  133,  134,  135,  136,  129,  296,  563,
			  531,  113,  532,  532,  532,  532,  846,  560,  846,  561,
			  129,  846,  846,  562,  324,  324,  324,  324,  324,  324,
			  324,  324,  324,  324,  564,  296,  846,  129,  113,  129,
			  565,  563,  846,  324,  324,  324,  324,  324,  324,  324,
			  324,  324,  324,  382,  296,  566,  567,  113,  568,  129, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  569,  570,  573,  846,  846,  846,  564,  846,  516,  129,
			  846,  846,  565,  324,  324,  324,  324,  324,  324,  324,
			  324,  324,  324,  846,  574,  575,  129,  566,  567,  576,
			  568,  129,  569,  570,  573,  324,  324,  324,  324,  324,
			  324,  324,  324,  324,  324,  129,  490,  490,  490,  490,
			  490,  490,  490,  490,  490,  490,  574,  575,  129,  846,
			  846,  576,  485,  485,  485,  485,  485,  485,  485,  485,
			  485,  485,  521,  521,  521,  521,  846,  129,  846,  846,
			  846,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  491,  491,  491,  491,  491,  491,  491,  491,  491,

			  491,  333,  333,  334,  335,  335,  335,  335,  336,  337,
			  338,  339,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  517,  517,  517,  517,  517,  517,  517,  517,
			  517,  517,  518,  518,  518,  518,  518,  518,  518,  518,
			  518,  518,  519,  519,  519,  519,  522,  522,  522,  522,
			  846,  377,  377,  378,  378,  571,  577,  372,  572,  555,
			  846,  523,  378,  378,  378,  378,  378,  378,  378,  378, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  378,  378,  556,  579,  578,  580,  581,  846,  582,  378,
			  378,  378,  378,  378,  378,  846,  846,  571,  577,  372,
			  572,  555,  527,  523,  378,  378,  378,  378,  378,  378,
			  525,  525,  525,  525,  556,  579,  578,  580,  581,  528,
			  582,  378,  378,  378,  378,  378,  378,  379,  379,  379,
			  378,  583,  584,  585,  586,  587,  846,  588,  378,  378,
			  378,  378,  378,  378,  380,  380,  380,  380,  589,  590,
			  591,  592,  619,  846,  620,  380,  380,  380,  380,  380,
			  380,  846,  846,  583,  584,  585,  586,  587,  529,  588,
			  378,  378,  378,  378,  378,  378,  525,  525,  525,  525,

			  589,  590,  591,  592,  619,  530,  620,  380,  380,  380,
			  380,  380,  380,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  223,  223,  223,  223,  223,  223,  223,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  215,  215,  215,  215,  215,  215,  215,  216,  215,  215,
			  218,  218,  218,  218,  218,  219,  218,  218,  218,  218,
			  220,  221,  218,  218,  218,  218,  218,  218,  218,  218,
			  222,  218,  218,  218,  218,  218,  218,  218,  218,  218, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  463,  316,  463,  463,  299,  299,  299,  600,  299,  601,
			  846,  603,  113,  296,  113,  605,  113,  296,  113,  296,
			  113,  846,  113,  621,  846,  622,  296,  296,  846,  113,
			  113,  623,  846,  624,  846,  625,  299,  299,  299,  626,
			  299,  627,  597,  598,  599,  846,  596,  463,  604,  602,
			  296,  846,  846,  113,  628,  621,  299,  622,  846,  629,
			  129,  630,  129,  623,  129,  624,  129,  625,  129,  846,
			  129,  626,  296,  627,  846,  113,  846,  129,  129,  631,

			  604,  602,  614,  614,  614,  614,  628,  296,  299,  846,
			  113,  629,  129,  630,  129,  846,  129,  523,  129,  632,
			  129,  129,  129,  464,  315,  846,  465,  466,  467,  129,
			  129,  631,  846,  315,  315,  315,  846,  633,  634,  615,
			  315,  615,  315,  129,  616,  616,  616,  616,  846,  523,
			  846,  632,  846,  129,  846,  846,  846,  315,  129,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  331,  633,
			  634,  685,  685,  685,  685,  129,  846,  846,  846,  324,
			  324,  324,  324,  324,  324,  324,  324,  324,  324,  846,
			  129,  846,  846,  846,  324,  324,  324,  324,  324,  324, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  324,  324,  324,  324,  331,  331,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  331,  331,
			  331,  331,  331,  331,  606,  606,  606,  606,  606,  606,
			  606,  606,  606,  606,  607,  607,  607,  607,  607,  607,
			  607,  607,  607,  607,  608,  499,  499,  499,  499,  617,
			  846,  526,  526,  526,  526,  846,  846,  609,  610,  364,
			  364,  364,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  364,  364,  364,  364,  364,  364,  364,  611,
			  612,  612,  612,  612,  846,  377,  377,  378,  378,  609,

			  610,  635,  382,  636,  846,  372,  378,  378,  378,  378,
			  378,  378,  378,  378,  378,  378,  846,  846,  637,  638,
			  639,  611,  640,  378,  378,  378,  378,  378,  378,  846,
			  846,  613,  846,  635,  641,  636,  527,  372,  378,  378,
			  378,  378,  378,  378,  531,  846,  618,  618,  618,  618,
			  637,  638,  639,  528,  640,  378,  378,  378,  378,  378,
			  378,  379,  379,  379,  378,  846,  641,  846,  846,  642,
			  846,  643,  378,  378,  378,  378,  378,  378,  380,  380,
			  380,  380,  644,  645,  646,  647,  648,  382,  656,  380,
			  380,  380,  380,  380,  380,  531,  846,  533,  533,  533, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  533,  642,  529,  643,  378,  378,  378,  378,  378,  378,
			  657,  846,  658,  659,  644,  645,  646,  647,  648,  530,
			  656,  380,  380,  380,  380,  380,  380,  649,  649,  649,
			  649,  660,  650,  661,  662,  663,  664,  665,  382,  666,
			  667,  668,  657,  651,  658,  659,  669,  670,  671,  672,
			  673,  593,  674,  674,  674,  674,  299,  299,  299,  690,
			  846,  296,  846,  660,  113,  661,  662,  663,  664,  665,
			  846,  666,  667,  668,  299,  846,  691,  692,  669,  670,
			  671,  672,  673,  616,  616,  616,  616,  846,  299,  299,
			  299,  690,  463,  463,  463,  463,  296,  846,  846,  113,

			  463,  846,  463,  846,  296,  676,  299,  113,  691,  692,
			  463,  693,  129,  694,  697,  650,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  698,  699,  700,  677,
			  652,  846,  846,  653,  654,  655,  846,  676,  846,  846,
			  678,  846,  846,  693,  129,  694,  697,  129,  616,  616,
			  616,  616,  701,  695,  702,  129,  846,  696,  698,  699,
			  700,  677,  331,  331,  331,  331,  331,  331,  331,  331,
			  331,  331,  678,  612,  612,  612,  612,  846,  846,  129,
			  680,  680,  681,  681,  701,  695,  702,  129,  684,  696,
			  703,  681,  681,  681,  681,  681,  681,  682,  682,  682, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  681,  846,  846,  683,  683,  683,  683,  704,  681,  681,
			  681,  681,  681,  681,  683,  683,  683,  683,  683,  683,
			  684,  846,  703,  681,  681,  681,  681,  681,  681,  689,
			  705,  533,  533,  533,  533,  846,  706,  707,  708,  704,
			  681,  681,  681,  681,  681,  681,  683,  683,  683,  683,
			  683,  683,  686,  686,  686,  686,  373,  709,  686,  686,
			  686,  686,  705,  710,  711,  712,  719,  523,  706,  707,
			  708,  720,  162,  688,  649,  649,  649,  649,  721,  713,
			  722,  723,  724,  725,  726,  727,  728,  729,  730,  709,
			  651,  731,  732,  687,  846,  710,  711,  712,  719,  523,

			  846,  296,  755,  720,  113,  688,  296,  846,  296,  113,
			  721,  113,  722,  723,  724,  725,  726,  727,  728,  729,
			  730,  846,  846,  731,  732,  593,  733,  733,  733,  733,
			  738,  680,  680,  735,  755,  736,  742,  682,  682,  682,
			  746,  846,  746,  846,  846,  747,  747,  747,  747,  846,
			  846,  737,  129,  748,  748,  748,  748,  129,  756,  129,
			  846,  846,  713,  846,  846,  735,  846,  736,  749,  846,
			  846,  846,  739,  686,  686,  686,  686,  652,  743,  757,
			  653,  654,  655,  737,  129,  758,  759,  760,  750,  129,
			  756,  129,  751,  751,  751,  751,  752,  761,  752,  762, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  749,  753,  753,  753,  753,  373,  763,  751,  751,  751,
			  751,  757,  764,  765,  766,  767,  768,  758,  759,  760,
			  750,  769,  754,  770,  649,  649,  649,  771,  772,  761,
			  773,  762,  774,  649,  775,  776,  777,  778,  763,  593,
			  779,  779,  779,  779,  764,  765,  766,  767,  768,  296,
			  846,  846,  113,  769,  754,  770,  797,  798,  296,  771,
			  772,  113,  773,  846,  774,  799,  775,  776,  777,  778,
			  296,  846,  846,  113,  747,  747,  747,  747,  781,  680,
			  680,  681,  681,  747,  747,  747,  747,  800,  797,  798,
			  681,  681,  681,  681,  681,  681,  801,  799,  802,  783,

			  129,  782,  681,  681,  681,  681,  803,  804,  805,  129,
			  781,  846,  806,  681,  681,  681,  681,  681,  681,  800,
			  739,  129,  681,  681,  681,  681,  681,  681,  801,  846,
			  802,  783,  129,  782,  753,  753,  753,  753,  803,  804,
			  805,  129,  846,  741,  806,  681,  681,  681,  681,  681,
			  681,  846,  846,  129,  682,  682,  682,  681,  813,  846,
			  788,  788,  788,  788,  814,  681,  681,  681,  681,  681,
			  681,  683,  683,  683,  683,  749,  793,  793,  793,  793,
			  846,  815,  683,  683,  683,  683,  683,  683,  846,  816,
			  813,  794,  817,  846,  846,  743,  814,  681,  681,  681, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  681,  681,  681,  789,  846,  789,  846,  749,  790,  790,
			  790,  790,  745,  815,  683,  683,  683,  683,  683,  683,
			  791,  816,  791,  794,  817,  792,  792,  792,  792,  753,
			  753,  753,  753,  795,  296,  795,  749,  113,  796,  796,
			  796,  796,  807,  807,  807,  807,  593,  818,  818,  818,
			  818,  820,  821,  846,  113,  113,  790,  790,  790,  790,
			  846,  825,  613,  790,  790,  790,  790,  826,  749,  846,
			  846,  846,  819,  827,  808,  792,  792,  792,  792,  792,
			  792,  792,  792,  829,  834,  129,  822,  822,  822,  822,
			  823,  835,  823,  825,  846,  824,  824,  824,  824,  826,

			  846,  794,  129,  129,  819,  827,  808,  796,  796,  796,
			  796,  796,  796,  796,  796,  829,  834,  129,  846,  807,
			  807,  807,  807,  835,  593,  836,  836,  836,  836,  837,
			  794,  838,  113,  794,  129,  129,  824,  824,  824,  824,
			  824,  824,  824,  824,  839,  809,  840,  841,  810,  811,
			  812,  828,  807,  807,  807,  842,  687,  843,  844,  845,
			  846,  807,  794,  838,  169,  169,  169,  169,  169,  169,
			  169,  169,  169,  846,  846,  846,  839,  846,  840,  841,
			  129,  846,  846,  828,  846,  846,  846,  842,  846,  843,
			  844,  845,  137,  846,  846,  137,  137,  137,  137,  137, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  137,  137,  137,  137,  137,  137,  137,  681,  681,  681,
			  681,  846,  129,  846,  681,  846,  683,  683,  683,  683,
			  846,  846,  809,  683,  846,  810,  811,  812,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   89,   89,   89,   89,   89,
			   89,   89,   89,   89,   89,   89,   89,   89,   89,   89,

			   89,   89,   89,   89,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,  110,  846,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  227,  846,  227,  227,  846,  227,  227,  227,  227,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  260, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  260,  260,  260,  260,  260,  260,  260,  260,  260,  260,
			  260,  260,  260,  260,  260,  260,  260,  260,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  112,  846,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  113,  846,  113,  846,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  331,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  331,  331,
			  331,  331,  461,  846,  461,  461,  461,  461,  461,  461,

			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  714,  714,  714,  714,  714,  714,  714,  714,  714,
			  714,  714,  714,  714,  714,  714,  714,  714,  714,  714,
			  780,  846,  780,  780,  780,  780,  780,  780,  780,  780,
			  780,  780,  780,  780,  780,  780,  780,  780,  780,   13,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846, yy_Dummy>>,
			1, 65, 3800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 3864)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			yy_chk_template_14 (an_array)
			yy_chk_template_15 (an_array)
			yy_chk_template_16 (an_array)
			yy_chk_template_17 (an_array)
			yy_chk_template_18 (an_array)
			yy_chk_template_19 (an_array)
			yy_chk_template_20 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
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

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    3,    4,   27,  836,
			    3,    4,   46,    3,    4,    5,    5,    5,    5,   27,
			    5,    6,    6,    6,    6,   49,    6,    9,    9,    9,
			    9,   34,   34,   10,   10,   10,   10,   36,   36,   11,
			   11,   11,   11,   48,   46,   12,   12,   12,   12,   41,
			   52,   15,   15,   15,   15,   11,  833,   49,   53,   41,
			   48,   12,   16,   16,   16,   16,   28,   15,   28,   28,
			   28,   28,   53,    5,   45,   48,   29,   54,   16,    6,
			   45,   41,   52,   31,   29,   31,   31,   31,   31,  832, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   53,   41,   48,   55,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   53,    5,   45,   94,   94,   54,
			  830,    6,   45,   65,   65,   65,   78,  144,    5,  812,
			   78,    5,    5,    5,    6,   55,   31,    6,    6,    6,
			    9,  102,  102,    9,    9,    9,   10,  108,  108,   10,
			   10,   10,   11,  810,  113,   11,   11,   11,   12,   29,
			  681,   12,   12,   12,   15,  809,  170,   15,   15,   15,
			   73,   73,   73,   73,  744,   16,  254,  254,   16,   16,
			   16,   18,   18,  742,   18,   18,  113,   18,  740,   18,
			   18,   43,   18,   82,   18,   43,   83,   82,  170,  738,

			   83,   18,  681,   18,  734,   18,   18,   30,   43,   30,
			   30,   30,   30,   42,   18,   42,  144,  144,  144,   18,
			   18,   30,   30,   43,   40,   42,   50,   43,   40,   18,
			  171,   40,   18,   18,   40,   18,   50,   40,   18,  172,
			   43,   50,  172,   30,  173,   42,   18,   42,  276,  276,
			   30,   18,   18,   30,   30,   86,   40,   42,   50,   86,
			   40,   18,  171,   40,   18,   18,   40,  718,   50,   40,
			  717,  172,  683,   50,  172,   30,  173,  715,  174,   18,
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   21,   38,  175,  176,   83,   38,   44,   21,  177,   21, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   38,   47,   38,   44,   44,   51,  178,   38,   38,   44,
			  174,   47,  179,   47,  683,   51,  180,   47,   51,  235,
			  235,  235,  235,   38,  175,  176,  714,   38,   44,  675,
			  177,  655,   38,   47,   38,   44,   44,   51,  178,   38,
			   38,   44,  653,   47,  179,   47,   86,   51,  180,   47,
			   51,   64,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,

			   21,   21,   21,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   70,   70,   70,   70,   70,   70,   70,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   77,   77,   77,   77,  652,   77,  183,  651,   77,   84,
			   77,   77,   77,   84,   79,   79,   79,   79,   77,   79,
			   85,  285,  285,  608,   85,   77,  110,   77,  595,  110,
			   77,   77,   77,   77,  531,   77,  115,   77,  183,  115,
			  256,   77,  116,   77,  256,  116,   77,   77,   77,   77, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   77,   77,   90,   90,   90,   90,  654,  654,   97,   97,
			   97,   97,  811,  811,   98,   98,   98,   98,  334,  334,
			  334,  462,   79,  104,  104,  104,  104,  110,  186,  114,
			  117,  460,  114,  117,  187,  118,  114,  115,  118,  104,
			  459,  457,  119,  116,  120,  119,  188,  120,  118,  162,
			  162,  162,  162,   77,   79,   84,   77,   77,   77,  110,
			  186,   85,   85,  119,  361,  120,  187,   79,  149,  115,
			   79,   79,   79,  128,  360,  116,  128,  359,  188,  260,
			  114,  117,  358,  260,  261,  357,  118,  190,  261,  131,
			  162,  122,  131,  119,  122,  120,  121,  124,  123,  121,

			  124,  123,  356,  136,  125,   90,  136,  125,   90,   90,
			   90,   97,  114,  117,   97,   97,   97,   98,  118,  190,
			   98,   98,   98,  355,  128,  119,  104,  120,  122,  104,
			  104,  104,  112,  112,  121,  112,  112,  123,  112,  124,
			  131,  112,  122,  125,  354,  193,  195,  121,  124,  123,
			  149,  149,  149,  149,  136,  125,  128,  262,  353,  352,
			  122,  262,  126,  126,  126,  126,  121,  126,  351,  123,
			  126,  124,  131,  350,  122,  125,  146,  193,  195,  121,
			  124,  123,  261,  131,  131,  131,  136,  125,  349,  112,
			  136,  136,  136,  136,  348,  347,  127,  346,  344,  127, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  129,  129,  129,  129,  130,  129,  343,  130,  129,  158,
			  342,  158,  158,  158,  158,  341,  138,  196,  126,  340,
			  126,  112,  443,  443,  443,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  127,  127,  196,
			  126,  132,  158,  262,  132,  130,  129,  197,  146,  146,
			  146,  146,  146,  146,  146,  126,  295,  294,  126,  126,
			  126,  133,  292,  200,  133,  279,  279,  279,  291,  127,
			  290,  288,  134,  287,  279,  134,  286,  130,  129,  197,
			  284,  130,  130,  130,  130,  130,  130,  130,  130,  130,

			  130,  135,  132,  129,  135,  200,  129,  129,  129,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  283,  184,  133,  281,  201,  204,  268,  280,  263,  278,
			  268,  277,  263,  134,  132,  205,  184,  275,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  206,  274,
			  207,  185,  135,  184,  133,  185,  201,  204,  133,  133,
			  133,  133,  133,  133,  133,  134,  141,  205,  184,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  208,
			  206,  203,  207,  185,  135,  203,  210,  185,  135,  135,
			  135,  135,  135,  135,  135,  135,  135,  135,  139,  139, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  140,
			  143,  208,  140,  203,  140,  140,  140,  203,  210,  263,
			  263,  270,  140,  268,  255,  153,  153,  153,  153,  140,
			  253,  140,  252,  227,  140,  140,  140,  140,  145,  140,
			  153,  140,  211,  212,  194,  140,  213,  140,  147,  142,
			  140,  140,  140,  140,  140,  140,  194,  109,  148,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  107,  106,  153,  105,  211,  212,  194,  103,  213,  101,
			  289,  289,  289,  339,  339,  339,  339,  383,  194,  289,
			  100,   99,  143,  143,  143,  143,  143,  143,  143,  143,

			  143,  143,  345,  345,  345,  345,   95,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,   93,  383,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  157,   92,  157,  157,  157,  157,   87,  159,  159,  159,
			  159,   74,   57,  160,  160,  160,  160,  157,  159,  159,
			  159,  159,  159,  159,  160,  160,  160,  160,  160,  160,
			  161,  161,  161,  161,   37,  264,  384,  300,  198,  264,
			  300,  161,  161,  161,  161,  161,  161,  198,   32,  157, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  159,  159,  159,  159,  159,  159,  160,  160,  160,  160,
			  160,  160,  181,  293,  293,  293,  181,  191,  384,  191,
			  198,  191,  293,  161,  161,  161,  161,  161,  161,  198,
			  181,  385,  191,  388,  209,  191,  390,  391,  300,  209,
			  216,  216,  216,  216,  181,  202,   13,  202,  181,  191,
			  209,  191,    8,  191,    7,  202,  216,  392,  202,  393,
			  202,  202,  181,  385,  191,  388,  209,  191,  390,  391,
			  300,  209,  448,  448,  448,  448,  264,  202,  372,  202,
			  372,    0,  209,  372,  372,  372,  372,  202,    0,  392,
			  202,  393,  202,  202,  215,  215,  215,  215,  215,  215,

			  215,  215,  215,  215,  215,  217,  217,  217,  217,  217,
			  217,  217,  217,  217,  217,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,    0,    0,  266,  269,    0,
			    0,  266,  269,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  220,  220,  220,  220,  220,  220,
			  220,  220,  220,  220,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  221,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  224,  224,  224,  224,  224,  224, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  224,  224,  224,  224,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  229,  229,  229,  229,  266,  269,
			    0,    0,  229,  259,  259,  259,  259,  305,  259,    0,
			  305,  307,  267,    0,  307,  389,  267,  272,  272,  272,
			  272,  394,  395,  282,  282,  282,  282,  458,  458,  458,
			  309,  310,  389,  309,  310,  311,  458,    0,  311,  299,
			  299,  299,  299,    0,  375,  312,  375,  389,  312,  375,
			  375,  375,  375,  394,  395,  313,  396,  313,  305,  310,
			  313,  259,  307,    0,  389,    0,  315,  315,  315,  315,

			    0,  315,    0,    0,  315,  311,  382,  382,  382,  382,
			    0,  309,  310,  397,    0,    0,  311,    0,  396,  312,
			  305,  310,    0,  259,  307,  299,  312,  229,    0,    0,
			  229,  229,  229,  267,  267,  267,  259,  311,  313,  259,
			  259,  259,  267,  309,  310,  397,  314,  382,  311,  314,
			  272,  312,  315,  272,  272,  272,  282,  299,  312,  282,
			  282,  282,  298,  298,  298,  298,  298,    0,  298,  398,
			  313,  298,  299,    0,    0,  299,  299,  299,  456,  456,
			  456,  456,  456,  400,  315,  402,  403,    0,  314,  499,
			  499,  499,  499,  499,    0,  317,    0,  314,  317,  315, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  398,  315,  315,  315,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  400,  404,  402,  403,  298,
			  314,  336,  336,  336,  336,  336,  336,  336,  318,  314,
			  320,  318,  319,  320,    0,  319,  321,  322,  324,  321,
			  322,  324,  520,  520,  520,  520,  317,    0,  404,    0,
			  406,  298,    0,  407,  408,  298,  298,  298,  298,  298,
			  298,  298,  298,  298,  298,  298,  298,  298,  298,  298,
			  298,  298,  298,  298,  298,  298,  298,  325,  317,  318,
			  325,  320,  406,  319,  401,  407,  408,  321,  322,  324,
			  376,    0,  376,  376,  376,  376,  326,    0,  401,  326,

			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			    0,  318,    0,  320,    0,  319,  401,  320,  320,  321,
			  322,  324,  318,  321,  319,  409,  327,  410,  325,  327,
			  401,  411,    0,  376,    0,    0,  324,  324,  324,  324,
			  324,  324,  324,  324,  324,  324,  324,  326,  328,  412,
			  381,  328,  381,  381,  381,  381,    0,  409,    0,  410,
			  325,    0,    0,  411,  325,  325,  325,  325,  325,  325,
			  325,  325,  325,  325,  413,  329,    0,  327,  329,  326,
			  414,  412,    0,  326,  326,  326,  326,  326,  326,  326,
			  326,  326,  326,  381,  330,  415,  416,  330,  418,  328, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  419,  420,  422,    0,    0,    0,  413,    0,  364,  327,
			    0,    0,  414,  327,  327,  327,  327,  327,  327,  327,
			  327,  327,  327,    0,  423,  424,  329,  415,  416,  425,
			  418,  328,  419,  420,  422,  328,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  330,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  423,  424,  329,    0,
			    0,  425,  329,  329,  329,  329,  329,  329,  329,  329,
			  329,  329,  521,  521,  521,  521,    0,  330,    0,    0,
			    0,  330,  330,  330,  330,  330,  330,  330,  330,  330,
			  330,  338,  338,  338,  338,  338,  338,  338,  338,  338,

			  338,  364,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  365,  365,  365,  365,  365,  365,  365,  365,
			  365,  365,  366,  366,  366,  366,  366,  366,  366,  366,
			  366,  366,  367,  367,  367,  367,  367,  367,  367,  367,
			  367,  367,  368,  368,  368,  368,  368,  368,  368,  368,
			  368,  368,  369,  369,  369,  369,  369,  369,  369,  369,
			  369,  369,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  371,  371,  371,  371,  374,  374,  374,  374,
			    0,  377,  377,  377,  377,  421,  426,  371,  421,  405,
			    0,  374,  377,  377,  377,  377,  377,  377,  378,  378, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  378,  378,  405,  427,  426,  428,  429,    0,  430,  378,
			  378,  378,  378,  378,  378,    0,    0,  421,  426,  371,
			  421,  405,  377,  374,  377,  377,  377,  377,  377,  377,
			  524,  524,  524,  524,  405,  427,  426,  428,  429,  378,
			  430,  378,  378,  378,  378,  378,  378,  379,  379,  379,
			  379,  431,  432,  433,  434,  435,    0,  436,  379,  379,
			  379,  379,  379,  379,  380,  380,  380,  380,  437,  438,
			  439,  440,  534,    0,  535,  380,  380,  380,  380,  380,
			  380,    0,    0,  431,  432,  433,  434,  435,  379,  436,
			  379,  379,  379,  379,  379,  379,  525,  525,  525,  525,

			  437,  438,  439,  440,  534,  380,  535,  380,  380,  380,
			  380,  380,  380,  442,  442,  442,  442,  442,  442,  442,
			  442,  442,  442,  444,  444,  444,  444,  444,  444,  444,
			  444,  444,  444,  445,  445,  445,  445,  445,  445,  445,
			  446,  446,  446,  446,  446,  446,  446,  446,  446,  446,
			  447,  447,  447,  447,  447,  447,  447,  447,  447,  447,
			  449,  449,  449,  449,  449,  449,  449,  449,  449,  449,
			  450,  450,  450,  450,  450,  450,  450,  450,  450,  450,
			  451,  451,  451,  451,  451,  451,  451,  451,  451,  451,
			  452,  452,  452,  452,  452,  452,  452,  452,  452,  452, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  453,  453,  453,  453,  453,  453,  453,  453,  453,  453,
			  454,  454,  454,  454,  454,  454,  454,  454,  454,  454,
			  463,  463,  463,  463,  464,  465,  466,  472,  467,  472,
			    0,  474,  472,  473,  474,  477,  473,  479,  477,  475,
			  479,    0,  475,  536,    0,  537,  480,  481,    0,  480,
			  481,  538,    0,  539,    0,  540,  464,  465,  466,  541,
			  467,  542,  466,  466,  467,    0,  465,  464,  475,  473,
			  482,    0,    0,  482,  543,  536,  463,  537,    0,  544,
			  472,  545,  474,  538,  473,  539,  477,  540,  479,    0,
			  475,  541,  485,  542,    0,  485,    0,  480,  481,  546,

			  475,  473,  522,  522,  522,  522,  543,  486,  463,    0,
			  486,  544,  472,  545,  474,    0,  473,  522,  477,  547,
			  479,  482,  475,  463,  479,    0,  463,  463,  463,  480,
			  481,  546,    0,  480,  480,  480,    0,  548,  549,  523,
			  481,  523,  480,  485,  523,  523,  523,  523,    0,  522,
			    0,  547,    0,  482,    0,    0,    0,  482,  486,  487,
			  487,  487,  487,  487,  487,  487,  487,  487,  487,  548,
			  549,  613,  613,  613,  613,  485,    0,    0,    0,  485,
			  485,  485,  485,  485,  485,  485,  485,  485,  485,    0,
			  486,    0,    0,    0,  486,  486,  486,  486,  486,  486, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  486,  486,  486,  486,  488,  488,  488,  488,  488,  488,
			  488,  488,  488,  488,  489,  489,  489,  489,  489,  489,
			  489,  489,  489,  489,  490,  490,  490,  490,  490,  490,
			  490,  490,  490,  490,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  491,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  498,  498,  498,  498,  498,  526,
			    0,  526,  526,  526,  526,    0,    0,  498,  498,  517,
			  517,  517,  517,  517,  517,  517,  517,  517,  517,  518,
			  518,  518,  518,  518,  518,  518,  518,  518,  518,  498,
			  519,  519,  519,  519,    0,  527,  527,  527,  527,  498,

			  498,  550,  526,  551,    0,  519,  527,  527,  527,  527,
			  527,  527,  528,  528,  528,  528,    0,    0,  552,  553,
			  554,  498,  556,  528,  528,  528,  528,  528,  528,    0,
			    0,  519,    0,  550,  557,  551,  527,  519,  527,  527,
			  527,  527,  527,  527,  532,    0,  532,  532,  532,  532,
			  552,  553,  554,  528,  556,  528,  528,  528,  528,  528,
			  528,  529,  529,  529,  529,    0,  557,    0,    0,  558,
			    0,  559,  529,  529,  529,  529,  529,  529,  530,  530,
			  530,  530,  560,  561,  562,  564,  567,  532,  570,  530,
			  530,  530,  530,  530,  530,  533,    0,  533,  533,  533, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  533,  558,  529,  559,  529,  529,  529,  529,  529,  529,
			  571,    0,  572,  573,  560,  561,  562,  564,  567,  530,
			  570,  530,  530,  530,  530,  530,  530,  568,  568,  568,
			  568,  574,  568,  575,  576,  577,  578,  579,  533,  580,
			  581,  583,  571,  568,  572,  573,  586,  587,  588,  589,
			  590,  594,  594,  594,  594,  594,  596,  597,  598,  619,
			    0,  600,    0,  574,  600,  575,  576,  577,  578,  579,
			    0,  580,  581,  583,  599,    0,  622,  623,  586,  587,
			  588,  589,  590,  615,  615,  615,  615,    0,  596,  597,
			  598,  619,  596,  597,  597,  597,  602,    0,    0,  602,

			  598,    0,  597,    0,  604,  600,  599,  604,  622,  623,
			  599,  624,  600,  627,  629,  568,  606,  606,  606,  606,
			  606,  606,  606,  606,  606,  606,  631,  632,  633,  602,
			  568,    0,    0,  568,  568,  568,    0,  600,    0,    0,
			  604,    0,    0,  624,  600,  627,  629,  602,  616,  616,
			  616,  616,  634,  628,  635,  604,    0,  628,  631,  632,
			  633,  602,  607,  607,  607,  607,  607,  607,  607,  607,
			  607,  607,  604,  612,  612,  612,  612,    0,    0,  602,
			  609,  609,  609,  609,  634,  628,  635,  604,  612,  628,
			  636,  609,  609,  609,  609,  609,  609,  610,  610,  610, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  610,    0,    0,  611,  611,  611,  611,  637,  610,  610,
			  610,  610,  610,  610,  611,  611,  611,  611,  611,  611,
			  612,    0,  636,  609,  609,  609,  609,  609,  609,  618,
			  639,  618,  618,  618,  618,    0,  640,  641,  642,  637,
			  610,  610,  610,  610,  610,  610,  611,  611,  611,  611,
			  611,  611,  614,  614,  614,  614,  617,  644,  617,  617,
			  617,  617,  639,  645,  646,  648,  656,  614,  640,  641,
			  642,  657,  618,  617,  649,  649,  649,  649,  658,  649,
			  659,  660,  661,  662,  663,  664,  666,  667,  670,  644,
			  649,  671,  673,  614,    0,  645,  646,  648,  656,  614,

			    0,  676,  692,  657,  676,  617,  677,    0,  678,  677,
			  658,  678,  659,  660,  661,  662,  663,  664,  666,  667,
			  670,    0,    0,  671,  673,  674,  674,  674,  674,  674,
			  680,  680,  680,  676,  692,  677,  682,  682,  682,  682,
			  684,    0,  684,    0,    0,  684,  684,  684,  684,    0,
			    0,  678,  676,  685,  685,  685,  685,  677,  693,  678,
			    0,    0,  649,    0,    0,  676,    0,  677,  685,    0,
			    0,    0,  680,  686,  686,  686,  686,  649,  682,  694,
			  649,  649,  649,  678,  676,  696,  697,  698,  686,  677,
			  693,  678,  687,  687,  687,  687,  688,  699,  688,  702, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  685,  688,  688,  688,  688,  689,  704,  689,  689,  689,
			  689,  694,  705,  707,  708,  709,  710,  696,  697,  698,
			  686,  711,  689,  712,  716,  716,  716,  719,  720,  699,
			  722,  702,  723,  716,  725,  729,  730,  732,  704,  733,
			  733,  733,  733,  733,  705,  707,  708,  709,  710,  735,
			    0,    0,  735,  711,  689,  712,  755,  756,  736,  719,
			  720,  736,  722,    0,  723,  758,  725,  729,  730,  732,
			  737,    0,    0,  737,  746,  746,  746,  746,  735,  739,
			  739,  739,  739,  747,  747,  747,  747,  760,  755,  756,
			  739,  739,  739,  739,  739,  739,  761,  758,  762,  737,

			  735,  736,  741,  741,  741,  741,  763,  766,  769,  736,
			  735,    0,  770,  741,  741,  741,  741,  741,  741,  760,
			  739,  737,  739,  739,  739,  739,  739,  739,  761,    0,
			  762,  737,  735,  736,  752,  752,  752,  752,  763,  766,
			  769,  736,    0,  741,  770,  741,  741,  741,  741,  741,
			  741,    0,    0,  737,  743,  743,  743,  743,  772,    0,
			  748,  748,  748,  748,  773,  743,  743,  743,  743,  743,
			  743,  745,  745,  745,  745,  748,  751,  751,  751,  751,
			    0,  774,  745,  745,  745,  745,  745,  745,    0,  776,
			  772,  751,  777,    0,    0,  743,  773,  743,  743,  743, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  743,  743,  743,  749,    0,  749,    0,  748,  749,  749,
			  749,  749,  745,  774,  745,  745,  745,  745,  745,  745,
			  750,  776,  750,  751,  777,  750,  750,  750,  750,  753,
			  753,  753,  753,  754,  781,  754,  788,  781,  754,  754,
			  754,  754,  771,  771,  771,  771,  779,  779,  779,  779,
			  779,  782,  783,    0,  782,  783,  789,  789,  789,  789,
			    0,  798,  788,  790,  790,  790,  790,  801,  788,    0,
			    0,    0,  781,  805,  771,  791,  791,  791,  791,  792,
			  792,  792,  792,  808,  813,  781,  793,  793,  793,  793,
			  794,  815,  794,  798,    0,  794,  794,  794,  794,  801,

			    0,  793,  782,  783,  781,  805,  771,  795,  795,  795,
			  795,  796,  796,  796,  796,  808,  813,  781,    0,  807,
			  807,  807,  807,  815,  818,  818,  818,  818,  818,  819,
			  822,  826,  819,  793,  782,  783,  823,  823,  823,  823,
			  824,  824,  824,  824,  828,  771,  829,  839,  771,  771,
			  771,  807,  831,  831,  831,  840,  822,  841,  842,  843,
			    0,  831,  822,  826,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,    0,    0,    0,  828,    0,  829,  839,
			  819,    0,    0,  807,    0,    0,    0,  840,    0,  841,
			  842,  843,  853,    0,    0,  853,  853,  853,  853,  853, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  853,  853,  853,  853,  853,  853,  853,  864,  864,  864,
			  864,    0,  819,    0,  864,    0,  865,  865,  865,  865,
			    0,    0,  807,  865,    0,  807,  807,  807,  847,  847,
			  847,  847,  847,  847,  847,  847,  847,  847,  847,  847,
			  847,  847,  847,  847,  847,  847,  847,  848,  848,  848,
			  848,  848,  848,  848,  848,  848,  848,  848,  848,  848,
			  848,  848,  848,  848,  848,  848,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  850,

			  850,  850,  850,  850,  851,  851,  851,  851,  851,  851,
			  851,  851,  851,  851,  851,  851,  851,  851,  851,  851,
			  851,  851,  851,  852,    0,  852,  852,  852,  852,  852,
			  852,  852,  852,  852,  852,  852,  852,  852,  852,  852,
			  852,  852,  854,  854,  854,  854,  854,  854,  854,  854,
			  854,  854,  854,  854,  854,  854,  854,  854,  854,  854,
			  854,  856,    0,  856,  856,    0,  856,  856,  856,  856,
			  856,  856,  856,  856,  856,  856,  856,  856,  856,  856,
			  857,  857,  857,  857,  857,  857,  857,  857,  857,  857,
			  857,  857,  857,  857,  857,  857,  857,  857,  857,  858, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  858,  858,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  860,    0,  860,
			  860,  860,  860,  860,  860,  860,  860,  860,  860,  860,
			  860,  860,  860,  860,  860,  860,  861,    0,  861,    0,
			  861,  861,  861,  861,  861,  861,  861,  861,  861,  861,
			  861,  861,  861,  861,  861,  862,  862,  862,  862,  862,
			  862,  862,  862,  862,  862,  862,  862,  862,  862,  862,
			  862,  862,  863,    0,  863,  863,  863,  863,  863,  863,

			  863,  863,  863,  863,  863,  863,  863,  863,  863,  863,
			  863,  866,  866,  866,  866,  866,  866,  866,  866,  866,
			  866,  866,  866,  866,  866,  866,  866,  866,  866,  866,
			  867,    0,  867,  867,  867,  867,  867,  867,  867,  867,
			  867,  867,  867,  867,  867,  867,  867,  867,  867,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846, yy_Dummy>>,
			1, 65, 3800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 867)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			yy_base_template_4 (an_array)
			yy_base_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  113,  114,  123,  129, 1251, 1249,  135,
			  141,  147,  153, 1246, 3749,  159,  170, 3749,  274,    0,
			 3749,  387, 3749, 3749, 3749, 3749, 3749,  100,  157,  166,
			  288,  174, 1170, 3749,  114, 3749,  119, 1156,  357,    0,
			  285,  123,  270,  259,  359,  144,   76,  368,  121,   99,
			  290,  366,  115,  136,  148,  157, 3749, 1103, 3749, 3749,
			 3749, 3749, 3749,  110,  357,  122,  367,  377,  409,  419,
			  429,  436,  446,  176, 1154, 3749, 3749,  548,  223,  562,
			 3749, 3749,  290,  293,  556,  567,  352, 1153, 3749, 3749,
			  600, 3749, 1050, 1019,  123, 1012, 3749,  606,  612, 1073,

			  989,  980,  147,  983,  621, 1055,  970,  971,  153,  963,
			  569, 3749,  731,  196,  622,  579,  585,  623,  628,  635,
			  637,  689,  684,  691,  690,  697,  760,  789,  666,  798,
			  797,  682,  844,  864,  875,  894,  696,    0,  804,  893,
			 1002,  954, 1037,  998,  215, 1026,  764, 1036, 1046,  656,
			 3749, 3749, 3749, 1004, 3749, 3749, 3749, 1131,  790, 1136,
			 1142, 1159,  628, 3749, 3749, 3749, 3749, 3749, 3749,    0,
			  217,  294,  299,  309,  328,  341,  357,  366,  361,  376,
			  367, 1179,    0,  506,  886,  904,  585,  602,  600,    0,
			  640, 1182,    0,  703, 1010,  695,  767,  822, 1154,    0, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  824,  888, 1210,  938,  881,  886,  912,  898,  932, 1199,
			  937, 1002, 1007,  997, 3749, 1189, 1238, 1211, 1221, 1231,
			 1260, 1270, 1280, 1290, 1300, 1310, 1320, 1026, 3749, 1422,
			 3749, 3749, 3749, 3749, 3749,  398, 3749, 3749, 3749, 3749,
			 3749, 3749, 3749, 3749, 3749, 3749, 3749, 3749, 3749, 3749,
			 3749, 3749,  931,  931,  182,  930,  587, 3749, 3749, 1431,
			  676,  681,  754,  925, 1182, 3749, 1334, 1439,  923, 1335,
			 1018, 3749, 1445, 3749,  848,  838,  254,  837,  835,  781,
			  827,  829, 1451,  819,  791,  477,  792,  875,  787,  986,
			  780,  784,  778, 1119,  767,  772, 3749, 3749, 1561, 1467,

			 1180, 3749, 3749, 3749, 3749, 1430, 3749, 1434, 3749, 1453,
			 1454, 1458, 1468, 1480, 1539, 1494, 3749, 1588, 1621, 1625,
			 1623, 1629, 1630, 3749, 1631, 1670, 1689, 1719, 1741, 1768,
			 1787, 3749, 3749, 1511,  517, 1606, 1527, 1752, 1797,  989,
			  807,  803,  798,  794,  786, 1081,  785,  783,  782,  776,
			  761,  756,  747,  746,  732,  711,  690,  673,  670,  665,
			  662,  652, 3749, 3749, 1796, 1818, 1828, 1838, 1848, 1858,
			 1868, 1951, 1262, 3749, 1955, 1458, 1671, 1960, 1977, 2026,
			 2043, 1731, 1485, 1041, 1141, 1199,    0,    0, 1193, 1413,
			 1202, 1187, 1204, 1227, 1402, 1400, 1450, 1481, 1533,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1531, 1652, 1549, 1536, 1565, 1945, 1607, 1617, 1614, 1689,
			 1680, 1699, 1713, 1742, 1733, 1759, 1750,    0, 1762, 1744,
			 1750, 1951, 1766, 1788, 1793, 1777, 1952, 1954, 1969, 1974,
			 1972, 2011, 2007, 2017, 2011, 2019, 2009, 2028, 2029, 2035,
			 2026,    0, 2019,  721, 2029, 2039, 2046, 2056, 1178, 2066,
			 2076, 2086, 2096, 2106, 2116, 3749, 1558,  547, 1363,  540,
			  537,    0,  546, 2218, 2166, 2167, 2168, 2170, 3749, 3749,
			 3749, 3749, 2222, 2226, 2224, 2232, 3749, 2228, 3749, 2230,
			 2239, 2240, 2263, 3749, 3749, 2285, 2300, 2265, 2310, 2320,
			 2330, 2340, 2350, 3749, 3749, 3749, 3749, 3749, 2434, 1569,

			 3749, 3749, 3749, 3749, 3749, 3749, 3749, 3749, 3749, 3749,
			 3749, 3749, 3749, 3749, 3749, 3749, 3749, 2375, 2385, 2469,
			 1621, 1851, 2281, 2323, 2009, 2075, 2440, 2474, 2491, 2540,
			 2557,  565, 2525, 2576, 2022, 2023, 2193, 2207, 2217, 2213,
			 2213, 2209, 2225, 2223, 2243, 2243, 2250, 2285, 2297, 2289,
			 2456, 2454, 2469, 2483, 2468,    0, 2486, 2494, 2514, 2516,
			 2533, 2547, 2535,    0, 2542,    0,    0, 2543, 2625,    0,
			 2548, 2558, 2572, 2576, 2582, 2589, 2594, 2583, 2593, 2581,
			 2605, 2591,    0, 2594,    0,    0, 2610, 2610, 2596, 2606,
			 2618,    0,    0, 3749, 2631,  506, 2598, 2599, 2600, 2616, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2654, 3749, 2689, 3749, 2697, 3749, 2622, 2668,  561, 2759,
			 2776, 2782, 2752, 2350, 2831, 2662, 2727, 2837, 2810, 2609,
			    0,    0, 2631, 2638, 2678,    0,    0, 2664, 2717, 2669,
			    0, 2677, 2688, 2691, 2716, 2719, 2739, 2762,    0, 2781,
			 2791, 2801, 2798,    0, 2817, 2829, 2824,    0, 2829, 2872,
			 3749,  539,  453,  343,  512,  337, 2834, 2822, 2823, 2840,
			 2845, 2846, 2834, 2848, 2834,    0, 2835, 2855,    0,    0,
			 2848, 2855,    0, 2847, 2905,  352, 2894, 2899, 2901, 3749,
			 2910,  240, 2916,  352, 2924, 2932, 2952, 2971, 2980, 2986,
			    0,    0, 2866, 2906, 2928,    0, 2939, 2935, 2951, 2965,

			    0,    0, 2963,    0, 2974, 2976,    0, 2963, 2969, 2964,
			 2965, 2989, 2972, 3749,  423,  283, 2930,  270,  273, 2984,
			 2978,    0, 2985, 2987,    0, 2998,    0,    0,    0, 2984,
			 2991,    0, 2986, 3019,  236, 3042, 3051, 3063,  287, 3058,
			  276, 3081,  271, 3133,  262, 3150, 3053, 3062, 3139, 3187,
			 3204, 3155, 3113, 3208, 3217, 3021, 3006,    0, 3020,    0,
			 3052, 3063, 3063, 3063,    0,    0, 3069,    0,    0, 3063,
			 3076, 3240, 3112, 3128, 3147,    0, 3153, 3156,    0, 3226,
			    0, 3227, 3244, 3245, 3749, 3749, 3749, 3749, 3200, 3235,
			 3242, 3254, 3258, 3265, 3274, 3286, 3290,    0, 3225,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0, 3224,    0,    0,    0, 3222,    0, 3317, 3240,  164,
			  154,  518,  135, 3235,    0, 3255,    0,    0, 3304, 3322,
			 3749, 3749, 3294, 3315, 3319,    0, 3295,    0, 3301, 3314,
			  126, 3258,   99,   72,    0,    0,   99, 3749,    0, 3315,
			 3305, 3307, 3308, 3309,    0, 3749, 3749, 3427, 3446, 3465,
			 3484, 3503, 3522, 3389, 3541, 3357, 3560, 3579, 3598, 3617,
			 3636, 3655, 3674, 3691, 3401, 3410, 3710, 3729, yy_Dummy>>,
			1, 68, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 867)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			yy_def_template_3 (an_array)
			yy_def_template_4 (an_array)
			yy_def_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  846,    1,  847,  847,  848,  848,  849,  849,  850,
			  850,  851,  851,  846,  846,  846,  846,  846,  852,  853,
			  846,  854,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  856,  846,  846,  846,  857,  857,
			  846,  846,  858,  857,  857,  857,  857,  859,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,

			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  852,  846,  860,  861,  852,  852,  852,  852,  852,  852,
			  852,  852,  852,  852,  852,  852,  852,  852,  852,  852,
			  852,  852,  852,  852,  852,  852,  852,  853,  862,  862,
			  862,  862,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  856,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  857,  846,  846,  857,
			  858,  857,  857,  857,  857,  846,  857,  857,  857,  857,
			  859,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  863,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  860,  861,

			  852,  846,  846,  846,  846,  852,  846,  852,  846,  852,
			  852,  852,  852,  852,  852,  852,  846,  852,  852,  852,
			  852,  852,  852,  846,  852,  852,  852,  852,  852,  852,
			  852,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  862,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  863,  863,  861,  861,  861,  861,  861,  846,  846,
			  846,  846,  852,  852,  852,  852,  846,  852,  846,  852,
			  852,  852,  852,  846,  846,  852,  852,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,

			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  846,  846,  863,  861,  861,  861,  861, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  852,  846,  852,  846,  852,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  846,
			  846,  846,  846,  846,  846,  846,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  846,  863,  852,  852,  852,  846,
			  864,  864,  864,  865,  846,  846,  846,  846,  846,  846,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,

			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  846,  866,  846,  846,  846,  846,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  846,  863,  852,  852,  852,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  855,  855,  855,  855,  846,
			  867,  852,  852,  852,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  855,  855,  855, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  855,  855,  855,  855,  855,  855,  855,  846,  855,  846,
			  846,  846,  846,  855,  855,  855,  855,  855,  846,  852,
			  846,  846,  846,  846,  846,  855,  855,  855,  846,  855,
			  846,  846,  846,  846,  855,  855,  846,  846,  855,  846,
			  855,  846,  855,  846,  855,  846,    0,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  846,  846, yy_Dummy>>,
			1, 68, 800)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 256)
			yy_ec_template_1 (an_array)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    2,    2,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   23,   23,   23,   23,   23,   24,   24,   25,   26,
			   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   40,   41,   42,   43,   44,   45,   46,
			   47,   48,   49,   50,   51,   52,   53,   54,   55,   56,
			   57,   58,   59,   60,   61,   62,   63,   64,   65,   66,

			   67,   68,   69,   70,   71,   72,   73,   74,   75,   76,
			   77,   78,   79,   80,   81,   82,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,    1,   94,   95,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   97,
			   97,   97,   97,   97,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   99,   98,   98,   98,   98,  100,
			  101,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  103,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  104,  104,  105,  106,  106,  106,  106,  106, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  107,  108,  109,  110,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  112,  113,  113,
			  104,  114,  114,  114,  115,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    1,    3,    4,    3,    3,
			    5,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    6,    7,    7,    8,    9,    3,    3,    3,    3,    3,
			    3,    3,    7,    7,    7,    7,    7,    7,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   11,   12,    3,    3,
			    3,    3,   13,    3,    7,    7,    7,    7,    7,    7,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   14,   15,
			    3,    3,   16,   17,   18,   18,   18,   18,   18,   18,

			   18,   18,   18,   18,   19,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 847)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			yy_accept_template_4 (an_array)
			yy_accept_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    2,    3,    4,    5,
			    5,    5,    5,    5,    6,    8,   11,   13,   16,   19,
			   22,   25,   28,   31,   34,   37,   40,   43,   46,   49,
			   52,   55,   58,   61,   64,   67,   70,   73,   76,   79,
			   82,   85,   88,   91,   94,   97,  100,  103,  106,  109,
			  112,  115,  118,  121,  124,  127,  130,  133,  135,  138,
			  141,  144,  147,  150,  152,  154,  156,  158,  160,  162,
			  164,  166,  168,  170,  172,  174,  176,  178,  180,  182,
			  184,  186,  188,  190,  192,  194,  196,  198,  200,  202,
			  204,  206,  208,  210,  212,  214,  216,  218,  221,  223,

			  225,  227,  229,  231,  233,  234,  234,  234,  234,  234,
			  234,  235,  236,  237,  237,  238,  239,  240,  241,  242,
			  243,  244,  245,  246,  247,  248,  249,  251,  252,  253,
			  255,  256,  257,  258,  259,  260,  261,  262,  263,  264,
			  265,  266,  267,  267,  267,  267,  267,  267,  267,  267,
			  267,  268,  269,  270,  271,  272,  273,  274,  275,  276,
			  276,  276,  276,  276,  277,  278,  279,  280,  281,  282,
			  283,  284,  285,  286,  287,  289,  290,  291,  292,  293,
			  294,  295,  296,  298,  299,  300,  301,  302,  303,  304,
			  306,  307,  308,  310,  311,  312,  313,  314,  315,  316, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  318,  319,  320,  321,  322,  323,  324,  325,  326,  327,
			  328,  329,  330,  331,  332,  333,  334,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  337,  338,
			  338,  339,  340,  341,  342,  343,  343,  344,  345,  346,
			  347,  348,  349,  350,  351,  352,  353,  354,  355,  356,
			  357,  358,  359,  359,  359,  359,  359,  360,  361,  362,
			  363,  364,  365,  366,  367,  368,  370,  371,  372,  373,
			  374,  375,  376,  376,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  378,  378,  378,  378,  378,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  380,  382,  384,

			  385,  386,  388,  390,  392,  394,  395,  397,  398,  400,
			  401,  402,  403,  404,  405,  406,  407,  408,  409,  410,
			  411,  412,  413,  414,  416,  417,  418,  419,  420,  421,
			  422,  423,  424,  426,  426,  426,  426,  426,  426,  426,
			  426,  427,  428,  429,  430,  431,  432,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,
			  446,  447,  448,  450,  451,  452,  452,  452,  452,  452,
			  452,  452,  453,  453,  454,  455,  455,  456,  458,  459,
			  461,  462,  463,  463,  464,  465,  466,  468,  470,  471,
			  472,  473,  474,  475,  476,  477,  478,  479,  480,  481, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  483,  484,  485,  486,  487,  488,  489,  490,  491,  492,
			  493,  494,  495,  496,  497,  498,  500,  501,  503,  504,
			  505,  506,  507,  508,  509,  510,  511,  512,  513,  514,
			  515,  516,  517,  518,  519,  520,  521,  522,  523,  524,
			  525,  526,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  528,  529,  529,  529,  529,
			  529,  529,  530,  531,  531,  531,  531,  531,  531,  533,
			  535,  537,  539,  540,  541,  542,  543,  545,  546,  548,
			  549,  550,  551,  552,  554,  556,  557,  558,  558,  558,
			  558,  558,  558,  558,  559,  560,  561,  562,  563,  564,

			  565,  566,  567,  568,  569,  570,  571,  572,  573,  574,
			  575,  576,  577,  578,  579,  580,  581,  583,  583,  583,
			  584,  584,  585,  586,  586,  586,  587,  588,  588,  588,
			  588,  588,  588,  589,  590,  591,  592,  593,  594,  595,
			  596,  597,  598,  599,  600,  601,  602,  603,  604,  606,
			  607,  608,  609,  610,  611,  612,  614,  615,  616,  617,
			  618,  619,  620,  621,  623,  624,  626,  628,  629,  631,
			  633,  634,  635,  636,  637,  638,  639,  640,  641,  642,
			  643,  644,  645,  647,  648,  650,  652,  653,  654,  655,
			  656,  657,  659,  661,  662,  662,  663,  663,  663,  663, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  663,  664,  666,  667,  669,  670,  672,  672,  672,  673,
			  673,  673,  673,  674,  674,  675,  675,  676,  677,  678,
			  679,  681,  683,  684,  685,  686,  688,  690,  691,  692,
			  693,  695,  696,  697,  698,  699,  700,  701,  702,  704,
			  705,  706,  707,  708,  710,  711,  712,  713,  715,  716,
			  716,  717,  717,  717,  717,  717,  717,  718,  719,  720,
			  721,  722,  723,  724,  725,  726,  728,  729,  730,  732,
			  734,  735,  736,  738,  739,  739,  740,  741,  742,  743,
			  744,  744,  744,  744,  744,  744,  745,  746,  746,  746,
			  747,  749,  751,  752,  753,  754,  756,  757,  758,  759,

			  760,  762,  764,  765,  767,  768,  769,  771,  772,  773,
			  774,  775,  776,  777,  778,  778,  778,  778,  778,  778,
			  779,  780,  782,  783,  784,  786,  787,  789,  791,  793,
			  794,  795,  797,  798,  798,  799,  800,  801,  802,  802,
			  802,  802,  802,  802,  802,  802,  802,  802,  803,  804,
			  804,  804,  805,  805,  806,  806,  807,  808,  810,  811,
			  813,  814,  815,  816,  817,  819,  821,  822,  824,  826,
			  827,  828,  829,  830,  831,  832,  834,  835,  836,  838,
			  838,  840,  841,  842,  843,  845,  846,  848,  849,  850,
			  850,  851,  851,  852,  853,  853,  853,  854,  856,  857, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  859,  861,  862,  864,  866,  868,  869,  871,  871,  872,
			  872,  872,  872,  872,  873,  875,  876,  878,  880,  880,
			  881,  883,  885,  886,  886,  887,  889,  890,  892,  892,
			  893,  893,  893,  893,  893,  895,  897,  897,  899,  901,
			  901,  902,  902,  903,  903,  905,  906,  906, yy_Dummy>>,
			1, 48, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 905)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			yy_acclist_template_3 (an_array)
			yy_acclist_template_4 (an_array)
			yy_acclist_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			    0,  186,  186,  188,  188,  219,  217,  218,    1,  217,
			  218,    1,  218,   36,  217,  218,  189,  217,  218,   41,
			  217,  218,   14,  217,  218,  154,  217,  218,   24,  217,
			  218,   25,  217,  218,   32,  217,  218,   30,  217,  218,
			    9,  217,  218,   31,  217,  218,   13,  217,  218,   33,
			  217,  218,  118,  217,  218,  118,  217,  218,    8,  217,
			  218,    7,  217,  218,   18,  217,  218,   17,  217,  218,
			   19,  217,  218,   11,  217,  218,  117,  217,  218,  117,
			  217,  218,  117,  217,  218,  117,  217,  218,  117,  217,
			  218,  117,  217,  218,  117,  217,  218,  117,  217,  218,

			  117,  217,  218,  117,  217,  218,  117,  217,  218,  117,
			  217,  218,  117,  217,  218,  117,  217,  218,  117,  217,
			  218,  117,  217,  218,  117,  217,  218,  117,  217,  218,
			   28,  217,  218,  217,  218,   29,  217,  218,   34,  217,
			  218,   26,  217,  218,   27,  217,  218,   12,  217,  218,
			  217,  218,  217,  218,  217,  218,  217,  218,  217,  218,
			  217,  218,  217,  218,  217,  218,  217,  218,  217,  218,
			  217,  218,  190,  218,  216,  218,  214,  218,  215,  218,
			  186,  218,  186,  218,  185,  218,  184,  218,  186,  218,
			  186,  218,  186,  218,  186,  218,  186,  218,  188,  218, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  187,  218,  182,  218,  182,  218,  181,  218,  182,  218,
			  182,  218,  182,  218,  182,  218,    6,  218,    5,    6,
			  218,    5,  218,    6,  218,    6,  218,    6,  218,    6,
			  218,    6,  218,    1,  189,  178,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			 -398,  189,  189,  189, -398,  189,  189,  189,  189,  189,
			  189,  189,   41,  154,  154,  154,  154,    2,   35,   10,
			  124,   39,   23,   22,  124,  118,   15,   37,   20,   21,
			   38,   16,  117,  117,  117,  117,  117,   48,  117,  117,
			  117,  117,  117,  117,  117,  117,   61,  117,  117,  117,

			  117,  117,  117,  117,   73,  117,  117,  117,   80,  117,
			  117,  117,  117,  117,  117,  117,   92,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,   40,   42,    1,   42,  190,  214,  207,  205,
			  206,  208,  209,  210,  211,  191,  192,  193,  194,  195,
			  196,  197,  198,  199,  200,  201,  202,  203,  204,  186,
			  185,  184,  186,  186,  186,  186,  186,  186,  183,  184,
			  186,  186,  186,  186,  188,  187,  181,    5,    4,  179,
			  176,  179,  189, -398, -398,  189,  162,  179,  160,  179,
			  161,  179,  163,  179,  189,  156,  179,  189,  157,  179, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  189,  189,  189,  189,  189,  189,  189, -180,  189,  189,
			  189,  189,  189,  189,  164,  179,  189,  189,  189,  189,
			  189,  189,  189,  154,  125,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  127,  154,
			  125,  154,  124,  119,  124,  118,  122,  123,  123,  121,
			  123,  120,  118,  117,  117,  117,   46,  117,   47,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,   64,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,   84,  117,

			  117,   87,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  116,  117,  213,    4,
			    4,  168,  179,  165,  179,  158,  179,  159,  179,  189,
			  189,  189,  189,  173,  179,  189,  167,  179,  189,  189,
			  189,  189,  166,  179,  177,  179,  189,  189,  144,  142,
			  143,  145,  146,  155,  155,  147,  148,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,  140,
			  141,  126,  154,  124,  124,  124,  124,  118,  118,  118,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,  117,  117,  117,   62,  117,  117,  117,  117,  117,
			  117,  117,   71,  117,  117,  117,  117,  117,  117,  117,
			  117,   81,  117,  117,   83,  117,   85,  117,  117,   90,
			  117,   91,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  105,  117,  117,  107,  117,
			  108,  117,  117,  117,  117,  117,  117,  114,  117,  115,
			  117,  212,    4,  189,  169,  179,  189,  172,  179,  189,
			  175,  179,  155,  124,  124,  124,  124,  118,  117,   44,
			  117,   45,  117,  117,  117,  117,   52,  117,   53,  117,
			  117,  117,  117,   58,  117,  117,  117,  117,  117,  117,

			  117,  117,   69,  117,  117,  117,  117,  117,   76,  117,
			  117,  117,  117,   82,  117,  117,   88,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  102,  117,  117,  117,
			  106,  117,  109,  117,  117,  117,  112,  117,  117,    4,
			  189,  189,  189,  149,  124,  124,  124,   43,  117,   49,
			  117,  117,  117,  117,   55,  117,  117,  117,  117,  117,
			   63,  117,   65,  117,  117,   67,  117,  117,  117,   72,
			  117,  117,  117,  117,  117,  117,  117,   89,  117,  117,
			   95,  117,  117,  117,   98,  117,  117,  100,  117,  101,
			  117,  103,  117,  117,  117,  111,  117,  117,    4,  189, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  189,  189,  124,  124,  124,  124,  117,  117,   54,  117,
			  117,   57,  117,  117,  117,  117,  117,   70,  117,   74,
			  117,  117,   77,  117,   78,  117,  117,  117,  117,  117,
			  117,  117,   99,  117,  117,  117,  113,  117,    3,    4,
			  189,  189,  189,  152,  153,  153,  151,  153,  150,  124,
			  124,  124,  124,  124,   50,  117,  117,   56,  117,   59,
			  117,  117,   66,  117,   68,  117,   75,  117,  117,   86,
			  117,  117,  117,   96,  117,  117,  104,  117,  110,  117,
			  189,  171,  179,  174,  179,  124,  124,   51,  117,  117,
			   79,  117,  117,   94,  117,   97,  117,  170,  179,   60,

			  117,  117,  117,   93,  117,   93, yy_Dummy>>,
			1, 106, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 3749
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 846
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 847
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

	yyNb_rules: INTEGER = 218
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 219
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
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_SCANNER
