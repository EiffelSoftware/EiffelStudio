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
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_FORALL, Current)
					last_token := TE_FORALL
				end
			
when 42 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_EXISTS, Current)
					last_token := TE_EXISTS
				end
			
when 43 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_BAR, Current)
				last_token := TE_BAR
			
when 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_REPEAT_OPEN, Current)
					last_token := TE_REPEAT_OPEN
				end
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_REPEAT_CLOSE, Current)
					last_token := TE_REPEAT_CLOSE
				end
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_BLOCK_OPEN, Current)
					last_token := TE_BLOCK_OPEN
				end
			
when 47 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_BLOCK_CLOSE, Current)
					last_token := TE_BLOCK_CLOSE
				end
			
when 48 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 49 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 50 then
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
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 52 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 53 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 54 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 55 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 56 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 57 then
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
			
when 58 then
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
			
when 59 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 60 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 61 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 62 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 63 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 64 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 65 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 66 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 67 then
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
			
when 68 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 69 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 70 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 71 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 72 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 73 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 74 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 75 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 77 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 78 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 79 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 80 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 81 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 82 then
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
			
when 83 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 84 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 85 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 86 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 87 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 88 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 89 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 90 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 91 then
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
			
when 92 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 93 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 94 then
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
			
when 95 then
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
			
when 96 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 97 then
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
			
when 98 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 99 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 100 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 101 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 102 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 103 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 104 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 105 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 106 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 107 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 108 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 109 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 110 then
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
			
when 111 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 112 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 113 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 114 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 115 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 116 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 117 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 118 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 121 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 123 then
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
			
when 124 then
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
			
when 125 then
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
			
when 126 then
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
			
when 127 then
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
			
when 128 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 129 then
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
			
when 130 then
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
			
when 131 then
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
			
when 132 then
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
			
when 133 then
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
			
when 134 then
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
			
when 135 then
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
			
when 136 then
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
			
when 137 then
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
			
when 138 then
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
			
when 139 then
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
			
when 140 then
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
			
when 141 then
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
			
when 142 then
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
			
when 143 then
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
			
when 144 then
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
			
when 145 then
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
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
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
			
when 154 then
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
			
when 155 then
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
			
when 156 then
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
			
when 157 then
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
			
when 158 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 159 then
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
			
when 160 then
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
			
when 161 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 163 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 164 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 165 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 166 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 167 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 168 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 169 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 170 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 171 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 172 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 173 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 174 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 175 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 176 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 177 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 178 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 179 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 180 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 181 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 182 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 185 then
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
			
when 186 then
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
			
when 187 then
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
			
when 188 then
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
			
when 189 then
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
			
when 190 then
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
			
when 191 then
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
			
when 192 then
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
			
when 193 then
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
			
when 194 then
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
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 213 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 214 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 215 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 216 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 217 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 218 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 219 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 220 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 221 then
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
			
when 222 then
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
			
when 223 then
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
			
when 224 then
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
			
when 225 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 226 then
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
			create an_array.make_filled (0, 0, 4679)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			an_array.area.fill_with (223, 586, 618)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			an_array.area.fill_with (112, 945, 975)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			an_array.area.fill_with (219, 1681, 1714)
			yy_nxt_template_10 (an_array)
			an_array.area.fill_with (219, 1758, 1782)
			yy_nxt_template_11 (an_array)
			an_array.area.fill_with (219, 1801, 1850)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			yy_nxt_template_14 (an_array)
			yy_nxt_template_15 (an_array)
			yy_nxt_template_16 (an_array)
			yy_nxt_template_17 (an_array)
			an_array.area.fill_with (219, 3019, 3069)
			yy_nxt_template_18 (an_array)
			an_array.area.fill_with (341, 3196, 3229)
			yy_nxt_template_19 (an_array)
			yy_nxt_template_20 (an_array)
			yy_nxt_template_21 (an_array)
			an_array.area.fill_with (341, 3755, 3788)
			yy_nxt_template_22 (an_array)
			yy_nxt_template_23 (an_array)
			yy_nxt_template_24 (an_array)
			yy_nxt_template_25 (an_array)
			an_array.area.fill_with (877, 4557, 4679)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   15,   16,   15,   15,   17,   18,   19,   20,   14,
			   19,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   31,   31,   32,   33,   34,   35,   36,   37,
			   19,   38,   39,   40,   41,   42,   43,   39,   39,   44,
			   39,   39,   45,   39,   46,   47,   48,   39,   49,   50,
			   51,   52,   53,   54,   55,   39,   39,   56,   57,   58,
			   59,   14,   14,   38,   39,   40,   41,   42,   43,   39,
			   39,   44,   39,   39,   45,   39,   46,   47,   48,   39,
			   49,   50,   51,   52,   53,   54,   55,   39,   39,   60,
			   19,   61,   62,   14,   14,   14,   14,   14,   14,   14,

			   14,   63,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   64,   65,   66,   67,   68,   69,   70,   71,   72,
			   73,   74,   75,   14,   77,   77,  154,  173,   78,   78,
			  199,   79,   79,   81,   82,   81,   81,  155,   83,   81,
			   82,   81,   81,  840,   83,   92,   93,   92,   92,  168,
			  169,   92,   93,   92,   92,  170,  171,   99,  100,   99,
			   99,  840,  199,   99,  100,   99,   99,  158,  185,  106,
			  106,  106,  106,  101,  140,  159,  206,  140,  186,  101,
			  106,  106,  106,  106,  156,  107,  157,  157,  157,  157,
			  161,   84,  162,  162,  162,  162,  107,   84,  197,  180, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  185,  840,  204,  181,  198,  213,  182,  216,  206,  183,
			  186,  266,  184,  217,  266,  267,  266,  266,  274,  205,
			  267,  267,  865,   84,  266,  288,  289,  862,  267,   84,
			  197,  180,  840,  166,  204,  181,  198,  213,  182,  216,
			  160,  183,  214,   85,  184,  217,   86,   87,   88,   85,
			  707,  205,   86,   87,   88,   94,  215,  308,   95,   96,
			   97,   94,  298,  299,   95,   96,   97,  102,  302,  303,
			  103,  104,  105,  102,  214,  820,  103,  104,  105,  108,
			  395,  819,  109,  110,  111,  480,  481,  266,  215,  308,
			  108,  267,  818,  109,  110,  111,  113,  114,  200,  115,

			  114,  396,  116,  817,  117,  118,  813,  119,  201,  120,
			  202,  187,  395,  188,  203,  278,  121,  268,  122,  399,
			  114,  123,  161,  189,  162,  162,  162,  162,  210,  124,
			  200,  400,  401,  396,  125,  126,  163,  164,  211,  402,
			  201,  212,  202,  187,  127,  188,  203,  128,  129,  193,
			  130,  399,  403,  123,  676,  189,  194,  195,  165,  676,
			  210,  124,  196,  400,  401,  166,  125,  126,  163,  164,
			  211,  402,  676,  212,  266,  676,  127,  767,  274,  131,
			  114,  193,  174,  190,  403,  275,  175,  191,  194,  195,
			  165,  176,  747,  177,  196,  288,  289,  744,  178,  179, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  192,  132,  132,  133,  134,  134,  134,  134,  135,  136,
			  137,  138,  139,  142,  174,  190,  374,  676,  175,  191,
			  143,  404,  144,  176,  207,  177,  393,  393,  393,  393,
			  178,  179,  192,  397,  208,  743,  398,  405,  406,  209,
			  298,  299,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  404,  700,  700,  207,  219,  219,  235,
			  235,  235,  235,  235,  235,  397,  208,  394,  398,  405,
			  406,  209,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  220,  219,  221,  219,  219,  219,  219,  219,  222,
			  222,  222,  222,  222,  222,  222,  222,  707,  382,  382,

			  382,  382,  382,  382,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  146,  146,  147,  148,  148,  148,  148,  149,
			  150,  151,  152,  153,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  223,  223,  223,  223,  223,  223,  223,  224,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  225,  226,
			  227,  227,  228,  227,  227,  227,  229,  227,  227,  227,
			  227,  227,  227,  227,  227,  230, yy_Dummy>>,
			1, 186, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  233,  233,  233,  233,
			  233,  233,  233,  233,  233,  233,  233,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  238,  238,  238,  238,  410,  239,
			  415,  703,  240,  266,  241,  242,  243,  267,  268,  266,
			  268,  268,  244,  267,  281,  282,  281,  281,  416,  245,
			  305,  246,  385,  115,  247,  248,  249,  250,  621,  251,
			  410,  252,  415,  310,  238,  253,  115,  254,  417,  238,

			  255,  256,  257,  258,  259,  260,  291,  291,  291,  291,
			  416,  238,  291,  291,  291,  291,  745,  746,  106,  106,
			  106,  106,  305,  539,  311,  115,  269,  115,  538,  309,
			  417,  131,  537,  411,  107,  312,  863,  864,  115,  418,
			  313,  536,  423,  115,  131,  426,  332,  305,  412,  115,
			  115,  535,  534,  314,  276,  277,  533,  161,  269,  388,
			  388,  388,  388,  131,  261,  411,  266,  262,  263,  264,
			  267,  418,  532,  131,  423,  131,  131,  426,  270,  531,
			  412,  271,  272,  273,  283,  319,  131,  284,  285,  286,
			  315,  131,  317,  115,  530,  115,  305,  131,  131,  115, yy_Dummy>>,
			1, 200, 619)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  305,  374,  305,  115,  131,  115,  131,  427,  305,
			  529,  316,  115,  318,  528,  527,  292,  319,  131,  293,
			  294,  295,  292,  131,  428,  293,  294,  295,  108,  131,
			  131,  109,  110,  111,  112,  321,  112,  112,  320,  306,
			  427,  131,  115,  131,  526,  322,  413,  131,  323,  431,
			  414,  432,  131,  439,  131,  441,  428,  440,  525,  442,
			  131,  383,  383,  383,  383,  524,  268,  321,  521,  520,
			  320,  700,  700,  131,  519,  131,  384,  322,  413,  131,
			  323,  431,  414,  432,  131,  439,  131,  441,  518,  440,
			  307,  442,  131,  376,  376,  376,  376,  376,  376,  376,

			  376,  324,  325,  324,  324,  517,  305,  266,  384,  115,
			  305,  267,  762,  115,  106,  324,  325,  324,  324,  106,
			  305,  305,  307,  115,  115,  106, yy_Dummy>>,
			1, 126, 819)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  424,  326,  429,  131,  331,  385,  443,  386,  386,
			  386,  386,  430,  425,  131,  131,  444,  445,  305,  449,
			  450,  115,  266,  387,  469,  470,  267,  266,  471,  472,
			  291,  267,  131,  424,  305,  429,  131,  115,  451,  443,
			  291,  276,  277,  452,  430,  425,  131,  131,  444,  445,
			  559,  449,  450,  291,  327,  387,  374,  328,  329,  330,
			  334,  334,  334,  334,  334,  334,  334,  334,  327,  131,
			  451,  328,  329,  330,  305,  452,  484,  115,  477,  478,
			  478,  478,  559,  560,  561,  131,  300,  562,  297,  342,
			  291,  266,  281,  281,  565,  267,  305,  281,  290,  115,

			  287,  131,  701,  701,  701,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  373,  560,  561,  131,  278,  562,
			  275,  522,  523,  523,  523,  131,  565,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  338,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  131,  374,  281,
			  236,  236,  266,  236,  236,  236,  267,  131,  280,  482,
			  479,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  305,  131,
			  238,  115,  268,  340,  340,  340,  340,  340,  340,  343,
			  343,  344,  345,  345,  345,  345,  346,  347,  348,  349, yy_Dummy>>,
			1, 200, 976)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  350,  343,  343,  344,  345,  345,  345,  345,  346,  347,
			  348,  349,  350,  374,  343,  343,  344,  345,  345,  345,
			  345,  346,  347,  348,  349,  350,  374,  566,  237,  131,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  238,  238,  238,
			  238,  268,  374,  374,  304,  476,  301,  106,  154,  566,
			  266,  131,  567,  300,  267,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  305,  297,  291,  115,  510,  510,  510,  510,
			  510,  510,  510,  510,  567,  377,  377,  377,  377,  377,

			  377,  377,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  374,  296,  380,  380,  380,  380,  380,  380,
			  380,  380,  380,  380,  380,  281,  282,  281,  281,  290,
			  287,  568,  281,  131,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  379,  268,  281,  281,  281,  281,  281,  261,  569,  570,
			  262,  263,  264,  568,  490,  131,  281,  115,  280,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  305,  237,  218,  115,
			  569,  570,  172,  167,  381,  381,  381,  381,  381,  381, yy_Dummy>>,
			1, 200, 1176)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  389,  389,  390,  390,  131,  877,  391,  391,  391,
			  390,   90,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  571,  283,  572,  131,  284,  285,
			  286,  491,   90,  877,  115,  877,  877,  131,  516,  516,
			  516,  516,  516,  516,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  571,  573,  572,  131,
			  574,  877,  877,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  351,  577,  131,  352,  877,  353,  354,  355,  578,  573,

			  877,  877,  574,  356,  492,  493,  877,  115,  115,  407,
			  357,  579,  358,  408,  877,  359,  360,  361,  362,  877,
			  363,  877,  364,  577,  131,  877,  365,  409,  366,  877,
			  578,  367,  368,  369,  370,  371,  372,  392,  392,  392,
			  392,  407,  419,  579,  575,  408,  420,  877,  392,  392,
			  392,  392,  392,  392,  582,  131,  131,  421,  576,  409,
			  422,  106,  106,  106,  106,  291,  291,  291,  291,  291,
			  305,  877,  877,  115,  419,  877,  575,  107,  420,  291,
			  392,  392,  392,  392,  392,  392,  582,  131,  131,  421,
			  576,  877,  422,  877,  877,  343,  343,  344,  345,  345, yy_Dummy>>,
			1, 200, 1376)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  345,  345,  346,  347,  348,  349,  350,  433,  446,  434,
			  495,  583,  584,  447,  585,  453,  586,  435,  587,  588,
			  436,  131,  437,  438,  448,  454,  454,  455,  456,  457,
			  456,  456,  458,  459,  460,  461,  462,  877,  877,  433,
			  446,  434,  495,  583,  584,  447,  585,  877,  586,  435,
			  587,  588,  436,  131,  437,  438,  448,  546,  546,  546,
			  546,  453,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  463,  454,  455,  464,  465,  466,  456,  458,  459,
			  460,  461,  462,  453,  545,  877,  545,  877,  877,  546,
			  546,  546,  546,  454,  454,  455,  456,  457,  456,  456,

			  458,  459,  460,  461,  462, yy_Dummy>>,
			1, 105, 1576)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  220,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  220,  220,  220,
			  220,  220,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  220,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  220, yy_Dummy>>,
			1, 43, 1715)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  467,  219,  219,  468,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  220, yy_Dummy>>,
			1, 18, 1783)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  268,  266,  268,  268,  266,  267,  877,  877,  267,
			  291,  291,  291,  291,  106,  106,  106,  106,  106,  305,
			  877,  497,  115,  498,  500,  877,  115,  115,  106,  485,
			  325,  485,  485,  877,  877,  305,  305,  877,  115,  115,
			  161,  589,  551,  551,  551,  551,  590,  494,  324,  325,

			  324,  324,  305,  305,  877,  115,  115,  305,  877,  269,
			  115,  549,  305,  549,  877,  115,  550,  550,  550,  550,
			  131,  877,  877,  589,  131,  131,  877,  499,  590,  494,
			  496,  305,  877,  166,  115,  308,  131,  131,  877,  591,
			  505,  269,  877,  115,  877,  877,  268,  268,  268,  268,
			  268,  877,  131,  131,  131,  563,  131,  131,  131,  499,
			  268,  270,  496,  131,  271,  272,  273,  308,  131,  131,
			  292,  591,  564,  293,  294,  295,  324,  325,  324,  324,
			  877,  306,  131,  580,  115,  131,  131,  563,  592,  486,
			  131,  131,  487,  488,  489,  131,  581,  593,  324,  502, yy_Dummy>>,
			1, 200, 1851)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  503,  501,  877,  877,  564,  877,  877,  877,  327,  877,
			  877,  328,  329,  330,  131,  580,  506,  877,  504,  115,
			  592,  877,  556,  131,  557,  557,  557,  557,  581,  593,
			  594,  595,  307,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  877,  594,  595,  307,  394,  877,  131,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  327,  112,  112,  328,
			  329,  330,  112,  112,  112,  112,  112,  112,  112,  131,

			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  546,  546,  546,
			  546,  132,  132,  133,  134,  134,  134,  134,  135,  136,
			  137,  138,  139,  305,  877,  877,  115,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  540,  558,  558,  558,  558,  596,  597,  598,  599,
			  602,  877,  603,  604,  131,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375, yy_Dummy>>,
			1, 200, 2051)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  550,  550,  550,  550,  605,  606,  596,  597,
			  598,  599,  602,  394,  603,  604,  131,  877,  877,  877,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  305,  605,  606,
			  115,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  222,  222,
			  222,  222,  222,  222,  222,  222,  616,  478,  478,  478,
			  478,  343,  343,  344,  345,  345,  345,  345,  346,  347,
			  348,  349,  350,  607,  608,  609,  610,  611,  131,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,

			  375,  375,  375,  375,  375,  375,  877,  877,  620,  877,
			  612,  613,  877,  877,  877,  607,  608,  609,  610,  611,
			  131,  877,  877,  877,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  305,  612,  613,  115,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  541,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  541,  541,  541,  541,  614,
			  615,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  877,  877,  131,  542,  542,  542,  542,  542,  542,  542, yy_Dummy>>,
			1, 200, 2251)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  877,  614,  615,  233,  233,  233,  233,  233,  233,  233,
			  233,  233,  233,  233,  131,  877,  877,  877,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  305,  877,  647,  115,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  544,  544,  544,  544,
			  547,  547,  547,  547,  600,  389,  389,  390,  390,  647,
			  308,  384,  877,  308,  877,  548,  390,  390,  390,  390,
			  390,  390,  601,  877,  877,  308,  131,  235,  235,  235,

			  235,  235,  235,  877,  877,  877,  600,  877,  877,  626,
			  877,  627,  308,  384,  115,  308,  552,  548,  390,  390,
			  390,  390,  390,  390,  601,  485,  622,  308,  131,  877,
			  877,  625,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  305,
			  877,  877,  115,  238,  238,  238,  238,  238,  390,  390,
			  390,  390,  131,  550,  550,  550,  550,  238,  877,  390,
			  390,  390,  390,  390,  390,  391,  391,  391,  390,  877,
			  642,  642,  642,  642,  877,  648,  390,  390,  390,  390,
			  390,  390,  308,  649,  131,  548,  877,  877,  650,  553, yy_Dummy>>,
			1, 200, 2451)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  390,  390,  390,  390,  390,  390,  629,  631,  305,
			  115,  115,  115,  761,  700,  700,  554,  648,  390,  390,
			  390,  390,  390,  390,  308,  649,  877,  548,  623,  624,
			  650,  877,  131,  877,  651,  652,  507,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  507,  305,  877,  762,  115,  877,  131,  131,
			  131,  653,  392,  392,  392,  392,  651,  652,  877,  877,
			  654,  877,  877,  392,  392,  392,  392,  392,  392,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  131,  131,  131,  653,  219,  219,  324,  635,  523,  523,

			  523,  523,  654,  555,  131,  392,  392,  392,  392,  392,
			  392,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  714,  714,
			  714,  714,  644,  644,  644,  644,  131,  877,  877,  639,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  305,  877,  877,
			  115,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  227,  227,
			  227,  227,  227,  227,  227,  227,  453,  227,  227,  227,
			  227,  227,  227,  227,  227,  655,  454,  454,  455,  456, yy_Dummy>>,
			1, 200, 2651)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  457,  456,  456,  458,  459,  460,  461,  462,  131,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  643,  655,  643,  877,
			  877,  644,  644,  644,  644,  644,  644,  644,  644,  877,
			  131,  877,  877,  877,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  220,  219,  219,
			  219,  219,  219,  219,  219,  223,  223,  223,  223,  223,

			  223,  223,  224,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  225,  226,  227,  227,  227,  227,  227,  227,
			  656,  227,  227,  227,  227,  227,  227,  227,  227,  230,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  453,  785,  785,  785,
			  785,  877,  656,  877,  877,  877,  454,  454,  455,  456,
			  457,  456,  456,  458,  459,  460,  461,  462, yy_Dummy>>,
			1, 168, 2851)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  616,  478,  478,  478,  478,  485,  325,  485,  485,  657,
			  877,  658,  305,  617,  618,  115,  877,  877,  305,  305,
			  305,  115,  115,  115,  659,  640,  640,  640,  640,  877,
			  305,  877,  660,  115,  645,  619,  551,  551,  551,  551,
			  384,  657,  620,  658,  661,  617,  618,  630,  628,  556,
			  662,  646,  646,  646,  646,  556,  659,  558,  558,  558,
			  558,  308,  663,  131,  660,  664,  641,  619,  665,  131,
			  131,  131,  384,  666,  667,  877,  661,  394,  877,  630,
			  628,  131,  662,  877,  668,  676,  676,  676,  676,  676,
			  877,  669,  394,  308,  663,  131,  877,  664,  394,  676,

			  665,  131,  131,  131,  877,  666,  667,  324,  324,  324,
			  324,  324,  877,  131,  324,  486,  668,  324,  487,  488,
			  489,  324,  305,  669,  877,  115, yy_Dummy>>,
			1, 126, 3070)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  670,  671,  672,  673,  674,  675,  683,  684,  685,  686,
			  687,  688,  689,  131,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  877,  670,  671,  672,  673,  674,  675,  683,  684,
			  685,  686,  687,  688,  689,  131,  877,  877,  877,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  305,  877,  877,  115,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  632,  632,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632,

			  632,  632,  632,  632,  690,  691,  692,  693,  694,  695,
			  696,  697,  698,  699,  308,  308,  719,  131,  633,  633,
			  633,  633,  633,  633,  633,  633,  633,  633,  633,  633,
			  633,  633,  633,  633,  633,  877,  690,  691,  692,  693,
			  694,  695,  696,  697,  698,  699,  308,  308,  719,  131,
			  485,  485,  877,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  305,  877,  877,  115,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  375,  375,  375,  375,  375,  375,  375,  375,  375, yy_Dummy>>,
			1, 200, 3230)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  375,  375,  375,  375,  375,  375,  877,  635,
			  523,  523,  523,  523,  720,  478,  478,  478,  478,  877,
			  721,  131,  636,  637,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  877,  722,  723,  638,  877,  720,  781,  781,  781,
			  781,  639,  721,  131,  636,  637,  620,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  722,  723,  638,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  389,  389,  390,  390,  877,  676,

			  676,  676,  676,  877,  677,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  678,  726,  727,  728,  729,
			  877,  308,  390,  390,  390,  390,  390,  390,  877,  712,
			  712,  712,  712,  877,  877,  552,  730,  390,  390,  390,
			  390,  390,  390,  781,  781,  781,  781,  877,  726,  727,
			  728,  729,  553,  308,  390,  390,  390,  390,  390,  390,
			  391,  391,  391,  390,  877,  485,  305,  877,  730,  115,
			  639,  390,  390,  390,  390,  390,  390,  392,  392,  392,
			  392,  877,  877,  702,  702,  702,  702,  677,  392,  392,
			  392,  392,  392,  392,  702,  702,  702,  702,  702,  702, yy_Dummy>>,
			1, 200, 3430)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  308,  554,  731,  390,  390,  390,  390,  390,  390,  679,
			  704,  877,  680,  681,  682,  877,  305,  131,  555,  115,
			  392,  392,  392,  392,  392,  392,  702,  702,  702,  702,
			  702,  702,  308,  732,  731,  877,  485,  485,  485,  485,
			  485,  305,  704,  718,  115,  558,  558,  558,  558,  131,
			  485,  724,  706,  733,  877,  725,  734,  708,  708,  709,
			  709,  735,  736,  737,  738,  732,  739,  131,  709,  709,
			  709,  709,  709,  709,  705,  787,  787,  787,  787,  787,
			  787,  787,  787,  724,  706,  733,  166,  725,  734,  877,
			  877,  877,  131,  735,  736,  737,  738,  877,  739,  131,

			  709,  709,  709,  709,  709,  709,  705,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  131, yy_Dummy>>,
			1, 125, 3630)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  710,  710,  710,  709,  740,  741,  711,  711,  711,  711,
			  877,  709,  709,  709,  709,  709,  709,  711,  711,  711,
			  711,  711,  711,  640,  640,  640,  640,  715,  715,  715,
			  715,  877,  877,  748,  877,  749,  740,  741,  713,  750,
			  877,  751,  548,  709,  709,  709,  709,  709,  709,  711,
			  711,  711,  711,  711,  711,  385,  752,  715,  715,  715,
			  715,  676,  676,  676,  676,  748,  742,  749,  716,  753,
			  713,  750,  717,  751,  548,  754,  755,  678,  756,  757,
			  758,  759,  760,  763,  701,  701,  701,  877,  752,  305,
			  305,  877,  115,  115,  305,  877,  877,  115,  701,  701,

			  701,  753,  789,  790,  717,  791,  792,  754,  755,  877,
			  756,  757,  758,  759,  760,  765,  702,  702,  702,  702,
			  793,  768,  794,  769,  795,  764,  796,  702,  702,  702,
			  702,  702,  702,  770,  789,  790,  877,  791,  792,  764,
			  131,  131,  877,  877,  877,  131,  877,  877,  877,  742,
			  877,  877,  793,  768,  794,  769,  795,  766,  796,  702,
			  702,  702,  702,  702,  702,  770,  771,  708,  708,  709,
			  709,  679,  131,  131,  680,  681,  682,  131,  709,  709,
			  709,  709,  709,  709,  773,  709,  709,  709,  709,  877,
			  877,  877,  782,  782,  782,  782,  709,  709,  709,  709, yy_Dummy>>,
			1, 200, 3789)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  709,  709,  779,  712,  712,  712,  712,  783,  772,  797,
			  709,  709,  709,  709,  709,  709,  780,  877,  780,  877,
			  877,  781,  781,  781,  781,  877,  774,  877,  709,  709,
			  709,  709,  709,  709,  775,  710,  710,  710,  709,  783,
			  877,  797,  798,  799,  639,  800,  709,  709,  709,  709,
			  709,  709,  777,  711,  711,  711,  711,  715,  715,  715,
			  715,  801,  877,  802,  711,  711,  711,  711,  711,  711,
			  803,  877,  784,  877,  798,  799,  776,  800,  709,  709,
			  709,  709,  709,  709,  786,  804,  786,  805,  877,  787,
			  787,  787,  787,  801,  778,  802,  711,  711,  711,  711,

			  711,  711,  803,  385,  784,  785,  785,  785,  785,  806,
			  807,  808,  809,  810,  811,  812,  830,  804,  831,  805,
			  788,  702,  702,  702,  702,  305,  305,  305,  115,  115,
			  115,  832,  702,  702,  702,  702,  702,  702,  877,  833,
			  834,  806,  807,  808,  809,  810,  811,  812,  830,  877,
			  831,  822,  788,  822,  814,  816,  823,  823,  823,  823,
			  877,  877,  766,  832,  702,  702,  702,  702,  702,  702,
			  815,  833,  834,  877,  877,  835,  131,  131,  131,  708,
			  708,  709,  709,  877,  877,  877,  814,  816,  877,  836,
			  709,  709,  709,  709,  709,  709,  821,  821,  821,  821, yy_Dummy>>,
			1, 200, 3989)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  837,  877,  815,  709,  709,  709,  709,  835,  131,  131,
			  131,  783,  877,  838,  709,  709,  709,  709,  709,  709,
			  772,  836,  709,  709,  709,  709,  709,  709,  824,  877,
			  824,  877,  837,  825,  825,  825,  825,  823,  823,  823,
			  823,  877,  839,  783,  774,  838,  709,  709,  709,  709,
			  709,  709,  710,  710,  710,  709,  877,  877,  826,  826,
			  826,  826,  846,  709,  709,  709,  709,  709,  709,  711,
			  711,  711,  711,  827,  839,  852,  877,  877,  115,  847,
			  711,  711,  711,  711,  711,  711,  840,  840,  840,  840,
			  848,  849,  850,  776,  846,  709,  709,  709,  709,  709,

			  709,  828,  877,  828,  877,  827,  829,  829,  829,  829,
			  778,  847,  711,  711,  711,  711,  711,  711,  841,  783,
			  877,  877,  848,  849,  850,  305,  131,  853,  115,  877,
			  115,  823,  823,  823,  823,  825,  825,  825,  825,  825,
			  825,  825,  825,  857,  877,  641,  854,  854,  854,  854,
			  841,  783,  829,  829,  829,  829,  858,  859,  131,  861,
			  855,  827,  855,  851,  877,  856,  856,  856,  856,  829,
			  829,  829,  829,  866,  867,  857,  131,  827,  131,  840,
			  840,  840,  840,  868,  877,  877,  115,  877,  858,  859,
			  869,  861,  870,  827,  871,  851,  842,  877,  877,  843, yy_Dummy>>,
			1, 200, 4189)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  844,  845,  877,  716,  872,  866,  867,  873,  131,  827,
			  131,  860,  856,  856,  856,  856,  856,  856,  856,  856,
			  874,  875,  869,  876,  870,  877,  871,  840,  840,  840,
			  840,  840,  877,  877,  131,  877,  872,  877,  877,  873,
			  877,  840,  877,  860,   76,   76,   76,   76,   76,   76,
			   76,  877,  874,  875,  877,  876,   80,   80,   80,   80,
			   80,   80,   80,  877,  877,  877,  131,   89,   89,   89,
			   89,   89,   89,   89,   91,   91,   91,   91,   91,   91,
			   91,   98,   98,   98,   98,   98,   98,   98,  877,  842,
			  877,  877,  843,  844,  845,  112,  112,  112,  112,  112,

			  112,  141,  141,  141,  141,  141,  141,  141,  265,  265,
			  265,  265,  265,  265,  265,  269,  269,  269,  269,  269,
			  269,  269,  279,  279,  279,  279,  279,  279,  279,  114,
			  114,  114,  114,  114,  114,  115,  877,  115,  115,  115,
			  115,  341,  341,  341,  341,  341,  877,  341,  483,  483,
			  483,  483,  483,  483,  743,  743,  743,  743,  743,  743,
			  743,  813,  813,  813,  813,  813,  813,   13, yy_Dummy>>,
			1, 168, 4389)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4679)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 123)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (21, 504, 533)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (114, 945, 975)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			an_array.area.fill_with (307, 2119, 2149)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			yy_chk_template_14 (an_array)
			yy_chk_template_15 (an_array)
			yy_chk_template_16 (an_array)
			yy_chk_template_17 (an_array)
			yy_chk_template_18 (an_array)
			yy_chk_template_19 (an_array)
			yy_chk_template_20 (an_array)
			yy_chk_template_21 (an_array)
			yy_chk_template_22 (an_array)
			yy_chk_template_23 (an_array)
			an_array.area.fill_with (896, 4550, 4555)
			an_array.area.fill_with (877, 4556, 4679)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   27,  886,    3,    4,   46,    3,    4,    5,
			    5,    5,    5,   27,    5,    6,    6,    6,    6,  865,
			    6,    9,    9,    9,    9,   34,   34,   10,   10,   10,
			   10,   36,   36,   11,   11,   11,   11,  864,   46,   12,
			   12,   12,   12,   29,   41,   15,   15,   15,   15,   11,
			  884,   29,   49,  884,   41,   12,   16,   16,   16,   16,
			   28,   15,   28,   28,   28,   28,   31,    5,   31,   31,
			   31,   31,   16,    6,   45,   40,   41,  862,   48,   40,
			   45,   52,   40,   54,   49,   40,   41,   80,   40,   55,
			   84,   80,  265,   85,   84,   48,  265,   85,  845,    5,

			   88,   96,   96,  843,   88,    6,   45,   40,  842,   31,
			   48,   40,   45,   52,   40,   54,   29,   40,   53,    5,
			   40,   55,    5,    5,    5,    6,  779,   48,    6,    6,
			    6,    9,   53,  115,    9,    9,    9,   10,  104,  104,
			   10,   10,   10,   11,  110,  110,   11,   11,   11,   12,
			   53,  777,   12,   12,   12,   15,  174,  775,   15,   15,
			   15,  263,  263,   86,   53,  115,   16,   86,  773,   16,
			   16,   16,   18,   18,   47,   18,   18,  175,   18,  771,
			   18,   18,  767,   18,   47,   18,   47,   42,  174,   42,
			   47,   88,   18,   85,   18,  177,   18,   18,   30,   42, yy_Dummy>>,
			1, 200, 124)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   30,   30,   30,   30,   51,   18,   47,  178,  179,  175,
			   18,   18,   30,   30,   51,  180,   47,   51,   47,   42,
			   18,   42,   47,   18,   18,   44,   18,  177,  181,   18,
			  747,   42,   44,   44,   30,  746,   51,   18,   44,  178,
			  179,   30,   18,   18,   30,   30,   51,  180,  744,   51,
			  269,  743,   18,  703,  269,   18,   18,   44,   38,   43,
			  181,   86,   38,   43,   44,   44,   30,   38,  682,   38,
			   44,  285,  285,  680,   38,   38,   43,   18,   18,   18,
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   21,
			   38,   43,  153,  679,   38,   43,   21,  182,   21,   38,

			   50,   38,  166,  166,  166,  166,   38,   38,   43,  176,
			   50,  678,  176,  183,  184,   50,  294,  294,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  182,
			  617,  617,   50,   63,   63,   75,   75,   75,   75,   75,
			   75,  176,   50,  166,  176,  183,  184,   50,   64,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   66,   66,   66,   66,   66,
			   66,   66,   66,  635,  153,  153,  153,  153,  153,  153, yy_Dummy>>,
			1, 180, 324)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   72,   72,   72,   72,   72,   72,

			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   73,   73,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   79,
			   79,   79,   79,  187,   79,  190,  621,   79,   87,   79,
			   79,   79,   87,   81,   81,   81,   81,   79,   81,   92,
			   92,   92,   92,  191,   79,  112,   79,  556,  112,   79,
			   79,   79,   79,  484,   79,  187,   79,  190,  117,  482,
			   79,  117,   79,  192,  481,   79,   79,   79,   79,   79,
			   79,   99,   99,   99,   99,  191,  479,  100,  100,  100, yy_Dummy>>,
			1, 200, 534)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  100,  681,  681,  106,  106,  106,  106,  116,  372,  118,
			  116,   81,  118,  371,  116,  192,  112,  370,  188,  106,
			  119,  844,  844,  119,  194,  120,  369,  197,  120,  117,
			  199,  130,  123,  188,  130,  123,  368,  367,  120,   87,
			   87,  366,  162,   81,  162,  162,  162,  162,  112,   79,
			  188,  270,   79,   79,   79,  270,  194,  365,  116,  197,
			  118,  117,  199,   81,  364,  188,   81,   81,   81,   92,
			  123,  119,   92,   92,   92,  121,  120,  122,  121,  363,
			  122,  125,  130,  123,  125,  162,  124,  147,  126,  124,
			  116,  126,  118,  200,  127,  362,  121,  127,  122,  361,

			  360,   99,  123,  119,   99,   99,   99,  100,  120,  201,
			  100,  100,  100,  106,  130,  123,  106,  106,  106,  114,
			  125,  114,  114,  124,  114,  200,  121,  114,  122,  359,
			  126,  189,  125,  127,  204,  189,  205,  124,  207,  126,
			  208,  201,  207,  358,  209,  127,  157,  157,  157,  157,
			  357,  270,  125,  355,  354,  124,  762,  762,  121,  353,
			  122,  157,  126,  189,  125,  127,  204,  189,  205,  124,
			  207,  126,  208,  352,  207,  114,  209,  127,  147,  147,
			  147,  147,  147,  147,  147,  147,  128,  128,  128,  128,
			  351,  128,  272,  157,  128,  129,  272,  762,  129,  304, yy_Dummy>>,
			1, 200, 734)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  131,  131,  131,  131,  303,  131,  133,  114,  131,  133,
			  301, yy_Dummy>>,
			1, 11, 934)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  128,  198,  128,  202,  129,  129,  161,  210,  161,  161,
			  161,  161,  202,  198,  131,  133,  211,  212,  135,  214,
			  215,  135,  271,  161,  229,  229,  271,  273,  229,  229,
			  300,  273,  128,  198,  137,  202,  129,  137,  216,  210,
			  299,  272,  272,  217,  202,  198,  131,  133,  211,  212,
			  395,  214,  215,  297,  128,  161,  149,  128,  128,  128,
			  133,  133,  133,  133,  133,  133,  133,  133,  131,  135,
			  216,  131,  131,  131,  132,  217,  296,  132,  244,  244,
			  244,  244,  395,  396,  397,  137,  295,  400,  293,  141,
			  292,  275,  290,  289,  402,  275,  139,  287,  286,  139,

			  284,  135,  618,  618,  618,  135,  135,  135,  135,  135,
			  135,  135,  135,  135,  144,  396,  397,  137,  273,  400,
			  271,  356,  356,  356,  356,  132,  402,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  139,  146,  283,
			  887,  887,  277,  887,  887,  887,  277,  132,  279,  264,
			  262,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  134,  139,
			  261,  134,  275,  139,  139,  139,  139,  139,  139,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141, yy_Dummy>>,
			1, 200, 976)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  141,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  148,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  144,  144,  151,  403,  236,  134,
			  146,  146,  146,  146,  146,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  146,  146,  238,  238,  238,
			  238,  277,  150,  145,  111,  238,  109,  108,  107,  403,
			  278,  134,  404,  105,  278,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  136,  103,  102,  136,  344,  344,  344,  344,
			  344,  344,  344,  344,  404,  148,  148,  148,  148,  148,

			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  152,  101,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  281,  281,  281,  281,   97,
			   95,  405,   94,  136,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  278,  288,  288,  288,  288,  288,  238,  406,  407,
			  238,  238,  238,  405,  309,  136,  288,  309,   89,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  138,   76,   57,  138,
			  406,  407,   37,   32,  152,  152,  152,  152,  152,  152, yy_Dummy>>,
			1, 200, 1176)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  163,  163,  163,  163,  309,   13,  164,  164,  164,
			  164,    8,  163,  163,  163,  163,  163,  163,  164,  164,
			  164,  164,  164,  164,  408,  281,  409,  138,  281,  281,
			  281,  314,    7,    0,  314,    0,    0,  309,  350,  350,
			  350,  350,  350,  350,  163,  163,  163,  163,  163,  163,
			  164,  164,  164,  164,  164,  164,  408,  410,  409,  138,
			  412,    0,    0,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  143,  414,  314,  143,    0,  143,  143,  143,  415,  410,

			    0,    0,  412,  143,  316,  318,    0,  316,  318,  185,
			  143,  416,  143,  185,    0,  143,  143,  143,  143,    0,
			  143,    0,  143,  414,  314,    0,  143,  185,  143,    0,
			  415,  143,  143,  143,  143,  143,  143,  165,  165,  165,
			  165,  185,  195,  416,  413,  185,  195,    0,  165,  165,
			  165,  165,  165,  165,  418,  316,  318,  195,  413,  185,
			  195,  220,  220,  220,  220,  298,  298,  298,  298,  298,
			  320,    0,    0,  320,  195,    0,  413,  220,  195,  298,
			  165,  165,  165,  165,  165,  165,  418,  316,  318,  195,
			  413,    0,  195,    0,    0,  143,  143,  143,  143,  143, yy_Dummy>>,
			1, 200, 1376)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  143,  143,  143,  143,  143,  143,  143,  206,  213,  206,
			  320,  419,  420,  213,  421,  219,  422,  206,  423,  424,
			  206,  320,  206,  206,  213,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,    0,    0,  206,
			  213,  206,  320,  419,  420,  213,  421,    0,  422,  206,
			  423,  424,  206,  320,  206,  206,  213,  545,  545,  545,
			  545,  220,  346,  346,  346,  346,  346,  346,  346,  346,
			  346,  220,  220,  220,  220,  220,  220,  220,  220,  220,
			  220,  220,  220,  221,  384,    0,  384,    0,    0,  384,
			  384,  384,  384,  221,  221,  221,  221,  221,  221,  221,

			  221,  221,  221,  221,  221,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227, yy_Dummy>>,
			1, 200, 1576)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  227,  227,  227,  227,  227,  227,  227,  228,  228,  228,
			  228,  228,  228,  228,  228,  228,  228,  228,  228,  228,
			  228,  228,  228,  228,  230,  230,  230,  230,  230,  230,
			  230,  230,  230,  230,  230,  230,  230,  230,  230,  230,
			  230,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  233,  233,  233,  233,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  233,  233,  234,  234,  234,  234,  234,  234,  234,  234,

			  234,  234,  234,  234,  234,  234,  234,  234,  234,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  268,  268,  268,  268,
			  276,  268,    0,    0,  276,  291,  291,  291,  291,  302,
			  302,  302,  302,  302,  319,    0,  322,  319,  322,  326,
			    0,  322,  326,  302,  308,  308,  308,  308,    0,    0,
			  323,  321,    0,  323,  321,  388,  425,  388,  388,  388,
			  388,  426,  319,  324,  324,  324,  324,  327,  324,    0,
			  327,  324,  328,    0,  268,  328,  387,  329,  387,    0,
			  329,  387,  387,  387,  387,  319,    0,    0,  425,  322, yy_Dummy>>,
			1, 200, 1776)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  326,    0,  323,  426,  319,  321,  330,    0,  388,  330,
			  308,  323,  321,    0,  427,  331,  268,    0,  331,    0,
			    0,  276,  276,  276,  276,  276,    0,  319,  327,  324,
			  401,  322,  326,  328,  323,  276,  268,  321,  329,  268,
			  268,  268,  308,  323,  321,  291,  427,  401,  291,  291,
			  291,  307,  307,  307,  307,    0,  307,  330,  417,  307,
			  327,  324,  401,  429,  308,  328,  331,  308,  308,  308,
			  329,  417,  430,  327,  329,  329,  328,    0,    0,  401,
			    0,    0,    0,  324,    0,    0,  324,  324,  324,  330,
			  417,  333,    0,  330,  333,  429,    0,  393,  331,  393,

			  393,  393,  393,  417,  430,  431,  432,  307,  343,  343,
			  343,  343,  343,  343,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  348,  348,  348,  348,  348,
			  348,  348,  348,  348,  348,  348,    0,  431,  432,  307,
			  393,    0,  333, yy_Dummy>>,
			1, 143, 1976)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  333,  345,  345,  345,  345,  345,  345,  345,  345,  345,
			  345,  345,  345,  345,  345,  345,  345,  345,  546,  546,
			  546,  546,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  334,    0,    0,  334,  347,  347,
			  347,  347,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  347,  347,  347,  349,  349,  349,  349,  349,
			  349,  349,  349,  349,  349,  349,  349,  349,  349,  349,
			  349,  349,  375,  394,  394,  394,  394,  433,  434,  435,
			  436,  438,    0,  439,  440,  334,  376,  376,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,

			  376,  376,  376,  549,  549,  549,  549,  441,  442,  433,
			  434,  435,  436,  438,  394,  439,  440,  334,    0,    0,
			    0,  334,  334,  334,  334,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  335,  441,
			  442,  335,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  455,
			  455,  455,  455,  455,  455,  455,  455,  478,  478,  478,
			  478,  478,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  443,  444,  445,  446,  447,  335,
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378, yy_Dummy>>,
			1, 200, 2150)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  378,  378,  378,  378,  378,  378,  378,    0,    0,  478,
			    0,  448,  449,    0,    0,    0,  443,  444,  445,  446,
			  447,  335,    0,    0,    0,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  336,  448,  449,  336,  379,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  380,
			  450,  451,  458,  458,  458,  458,  458,  458,  458,  458,
			  458,    0,    0,  336,  381,  381,  381,  381,  381,  381,

			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,    0,  450,  451,  460,  460,  460,  460,  460,  460,
			  460,  460,  460,  460,  460,  336,    0,    0,    0,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  337,    0,  559,  337,
			  382,  382,  382,  382,  382,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  383,  383,  383,
			  383,  386,  386,  386,  386,  437,  389,  389,  389,  389,
			  559,  486,  383,    0,  487,    0,  386,  389,  389,  389,
			  389,  389,  389,  437,    0,    0,  489,  337,  462,  462, yy_Dummy>>,
			1, 200, 2350)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  462,  462,  462,  462,    0,    0,    0,  437,    0,    0,
			  494,    0,  494,  486,  383,  494,  487,  389,  386,  389,
			  389,  389,  389,  389,  389,  437,  486,  487,  489,  337,
			    0,    0,  489,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  338,    0,    0,  338,  480,  480,  480,  480,  480,  390,
			  390,  390,  390,  494,  550,  550,  550,  550,  480,    0,
			  390,  390,  390,  390,  390,  390,  391,  391,  391,  391,
			    0,  547,  547,  547,  547,    0,  560,  391,  391,  391,
			  391,  391,  391,  488,  561,  494,  547,    0,    0,  562,

			  390,  338,  390,  390,  390,  390,  390,  390,  496,  499,
			  501,  496,  499,  501,  700,  700,  700,  391,  560,  391,
			  391,  391,  391,  391,  391,  488,  561,    0,  547,  488,
			  488,  562,    0,  338,    0,  563,  564,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  339,    0,  700,  339,    0,  496,
			  499,  501,  565,  392,  392,  392,  392,  563,  564,    0,
			    0,  566,    0,    0,  392,  392,  392,  392,  392,  392,
			  453,  453,  453,  453,  453,  453,  453,  453,  453,  453,
			  453,  496,  499,  501,  565,  453,  453,  501,  523,  523, yy_Dummy>>,
			1, 200, 2550)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  523,  523,  523,  566,  392,  339,  392,  392,  392,  392,
			  392,  392,  454,  454,  454,  454,  454,  454,  454,  454,
			  454,  454,  454,  454,  454,  454,  454,  454,  454,  641,
			  641,  641,  641,  643,  643,  643,  643,  339,    0,    0,
			  523,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  340,    0,
			    0,  340,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  457,
			  457,  457,  457,  457,  457,  457,  457,  467,  457,  457,
			  457,  457,  457,  457,  457,  457,  567,  467,  467,  467,

			  467,  467,  467,  467,  467,  467,  467,  467,  467,  340,
			  459,  459,  459,  459,  459,  459,  459,  459,  459,  459,
			  459,  459,  459,  459,  459,  459,  459,  548,  567,  548,
			    0,    0,  548,  548,  548,  548,  644,  644,  644,  644,
			    0,  340,    0,    0,    0,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  463,
			  463,  463,  463,  463,  463,  463,  463,  463,  463,  463,
			  463,  463,  463,  463,  463,  463,  464,  464,  464,  464, yy_Dummy>>,
			1, 200, 2750)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  464,  464,  464,  464,  464,  464,  464,  464,  464,  464,
			  464,  464,  464,  465,  465,  465,  465,  465,  465,  465,
			  465,  568,  465,  465,  465,  465,  465,  465,  465,  465,
			  466,  466,  466,  466,  466,  466,  466,  466,  466,  466,
			  466,  466,  466,  466,  466,  466,  466,  468,  716,  716,
			  716,  716,    0,  568,    0,    0,    0,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  468,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,

			  474,  474,  474,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  477,  477,  477,  477,  477,  485,  485,  485,  485,  569,
			    0,  570,  495,  477,  477,  495,    0,    0,  497,  503,
			  502,  497,  503,  502,  571,  544,  544,  544,  544,    0,
			  504,    0,  572,  504,  551,  477,  551,  551,  551,  551,
			  544,  569,  477,  570,  573,  477,  477,  497,  495,  557,
			  574,  557,  557,  557,  557,  558,  571,  558,  558,  558,
			  558,  485,  575,  495,  572,  576,  544,  477,  577,  497,
			  503,  502,  544,  578,  579,    0,  573,  551,    0,  497, yy_Dummy>>,
			1, 200, 2950)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  495,  504,  574,    0,  581,  745,  745,  745,  745,  745,
			    0,  582,  557,  485,  575,  495,    0,  576,  558,  745,
			  577,  497,  503,  502,    0,  578,  579,  502,  502,  502,
			  502,  502,    0,  504,  503,  485,  581,  504,  485,  485,
			  485,  502,  507,  582,    0,  507,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  583,  584,  585,  586,  588,  591,  594,  595,  596,  597,
			  598,  599,  600,  507,  512,  512,  512,  512,  512,  512,

			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,    0,  583,  584,  585,  586,  588,  591,  594,  595,
			  596,  597,  598,  599,  600,  507,    0,    0,    0,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  508,    0,    0,  508,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  601,  602,  603,  604,  606,  609,
			  610,  611,  612,  613,  622,  625,  647,  508,  515,  515, yy_Dummy>>,
			1, 200, 3150)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,    0,  601,  602,  603,  604,
			  606,  609,  610,  611,  612,  613,  622,  625,  647,  508,
			  622,  625,    0,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  509,    0,    0,  509,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  541,  541,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  541,  541,  541,    0,  522,
			  522,  522,  522,  522,  650,  620,  620,  620,  620,    0,

			  651,  509,  522,  522,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,    0,  652,  655,  522,    0,  650,  780,  780,  780,
			  780,  522,  651,  509,  522,  522,  620,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  652,  655,  522,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  552,  552,  552,  552,    0,  592,
			  592,  592,  592,    0,  592,  552,  552,  552,  552,  552,
			  552,  553,  553,  553,  553,  592,  657,  659,  660,  661, yy_Dummy>>,
			1, 200, 3350)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  624,  553,  553,  553,  553,  553,  553,    0,  639,
			  639,  639,  639,    0,    0,  552,  662,  552,  552,  552,
			  552,  552,  552,  781,  781,  781,  781,    0,  657,  659,
			  660,  661,  553,  624,  553,  553,  553,  553,  553,  553,
			  554,  554,  554,  554,    0,  624,  626,    0,  662,  626,
			  639,  554,  554,  554,  554,  554,  554,  555,  555,  555,
			  555,    0,    0,  619,  619,  619,  619,  592,  555,  555,
			  555,  555,  555,  555,  619,  619,  619,  619,  619,  619,
			  623,  554,  663,  554,  554,  554,  554,  554,  554,  592,
			  626,    0,  592,  592,  592,    0,  630,  626,  555,  630,

			  555,  555,  555,  555,  555,  555,  619,  619,  619,  619,
			  619,  619,  623,  664,  663,    0,  623,  623,  623,  623,
			  623,  628,  626,  646,  628,  646,  646,  646,  646,  626,
			  623,  656,  630,  665,    0,  656,  667,  636,  636,  636,
			  636,  668,  669,  670,  671,  664,  672,  630,  636,  636,
			  636,  636,  636,  636,  628,  786,  786,  786,  786,  787,
			  787,  787,  787,  656,  630,  665,  646,  656,  667,    0,
			    0,    0,  628,  668,  669,  670,  671,    0,  672,  630,
			  636,  636,  636,  636,  636,  636,  628,  632,  632,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632, yy_Dummy>>,
			1, 200, 3550)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  632,  632,  632,  632,  628,  633,  633,  633,  633,  633,
			  633,  633,  633,  633,  633,  633,  633,  633,  633,  633,
			  633,  633,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  637,
			  637,  637,  637,  673,  675,  638,  638,  638,  638,    0,
			  637,  637,  637,  637,  637,  637,  638,  638,  638,  638,
			  638,  638,  640,  640,  640,  640,  642,  642,  642,  642,
			    0,    0,  683,    0,  684,  673,  675,  640,  685,    0,
			  686,  642,  637,  637,  637,  637,  637,  637,  638,  638,
			  638,  638,  638,  638,  645,  687,  645,  645,  645,  645,

			  676,  676,  676,  676,  683,  676,  684,  642,  688,  640,
			  685,  645,  686,  642,  689,  690,  676,  692,  693,  696,
			  697,  699,  701,  701,  701,  701,    0,  687,  704,  706,
			    0,  704,  706,  705,    0,    0,  705,  764,  764,  764,
			  688,  721,  722,  645,  723,  725,  689,  690,    0,  692,
			  693,  696,  697,  699,  702,  702,  702,  702,  702,  726,
			  704,  727,  705,  728,  701,  731,  702,  702,  702,  702,
			  702,  702,  706,  721,  722,    0,  723,  725,  764,  704,
			  706,    0,    0,    0,  705,    0,    0,    0,  676,    0,
			    0,  726,  704,  727,  705,  728,  702,  731,  702,  702, yy_Dummy>>,
			1, 200, 3750)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  702,  702,  702,  702,  706,  708,  708,  708,  708,  708,
			  676,  704,  706,  676,  676,  676,  705,  708,  708,  708,
			  708,  708,  708,  709,  709,  709,  709,  709,    0,    0,
			    0,  714,  714,  714,  714,  709,  709,  709,  709,  709,
			  709,  712,  712,  712,  712,  712,  714,  708,  733,  708,
			  708,  708,  708,  708,  708,  713,    0,  713,    0,    0,
			  713,  713,  713,  713,    0,  709,    0,  709,  709,  709,
			  709,  709,  709,  710,  710,  710,  710,  710,  714,    0,
			  733,  734,  736,  712,  737,  710,  710,  710,  710,  710,
			  710,  711,  711,  711,  711,  711,  715,  715,  715,  715,

			  738,    0,  739,  711,  711,  711,  711,  711,  711,  740,
			    0,  715,    0,  734,  736,  710,  737,  710,  710,  710,
			  710,  710,  710,  717,  741,  717,  748,    0,  717,  717,
			  717,  717,  738,  711,  739,  711,  711,  711,  711,  711,
			  711,  740,  718,  715,  718,  718,  718,  718,  749,  750,
			  751,  753,  757,  758,  760,  789,  741,  790,  748,  718,
			  766,  766,  766,  766,  768,  770,  769,  768,  770,  769,
			  792,  766,  766,  766,  766,  766,  766,    0,  794,  795,
			  749,  750,  751,  753,  757,  758,  760,  789,    0,  790,
			  783,  718,  783,  768,  770,  783,  783,  783,  783,    0, yy_Dummy>>,
			1, 200, 3950)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  766,  792,  766,  766,  766,  766,  766,  766,  769,
			  794,  795,    0,    0,  796,  768,  770,  769,  772,  772,
			  772,  772,    0,    0,    0,  768,  770,    0,  797,  772,
			  772,  772,  772,  772,  772,  782,  782,  782,  782,  800,
			    0,  769,  774,  774,  774,  774,  796,  768,  770,  769,
			  782,    0,  803,  774,  774,  774,  774,  774,  774,  772,
			  797,  772,  772,  772,  772,  772,  772,  784,    0,  784,
			    0,  800,  784,  784,  784,  784,  822,  822,  822,  822,
			    0,  804,  782,  774,  803,  774,  774,  774,  774,  774,
			  774,  776,  776,  776,  776,    0,    0,  785,  785,  785,

			  785,  806,  776,  776,  776,  776,  776,  776,  778,  778,
			  778,  778,  785,  804,  815,    0,    0,  815,  807,  778,
			  778,  778,  778,  778,  778,  805,  805,  805,  805,  808,
			  810,  811,  776,  806,  776,  776,  776,  776,  776,  776,
			  788,    0,  788,    0,  785,  788,  788,  788,  788,  778,
			  807,  778,  778,  778,  778,  778,  778,  805,  821,    0,
			    0,  808,  810,  811,  814,  815,  816,  814,    0,  816,
			  823,  823,  823,  823,  824,  824,  824,  824,  825,  825,
			  825,  825,  831,    0,  821,  826,  826,  826,  826,  805,
			  821,  828,  828,  828,  828,  834,  838,  815,  841,  827, yy_Dummy>>,
			1, 200, 4150)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  826,  827,  814,    0,  827,  827,  827,  827,  829,  829,
			  829,  829,  846,  848,  831,  814,  854,  816,  840,  840,
			  840,  840,  851,    0,    0,  851,    0,  834,  838,  858,
			  841,  860,  826,  861,  814,  805,    0,    0,  805,  805,
			  805,    0,  854,  870,  846,  848,  871,  814,  854,  816,
			  840,  855,  855,  855,  855,  856,  856,  856,  856,  872,
			  873,  858,  874,  860,    0,  861,  863,  863,  863,  863,
			  863,    0,    0,  851,    0,  870,    0,    0,  871,    0,
			  863,    0,  840,  878,  878,  878,  878,  878,  878,  878,
			    0,  872,  873,    0,  874,  879,  879,  879,  879,  879,

			  879,  879,    0,    0,    0,  851,  880,  880,  880,  880,
			  880,  880,  880,  881,  881,  881,  881,  881,  881,  881,
			  882,  882,  882,  882,  882,  882,  882,    0,  840,    0,
			    0,  840,  840,  840,  883,  883,  883,  883,  883,  883,
			  885,  885,  885,  885,  885,  885,  885,  888,  888,  888,
			  888,  888,  888,  888,  889,  889,  889,  889,  889,  889,
			  889,  890,  890,  890,  890,  890,  890,  890,  891,  891,
			  891,  891,  891,  891,  892,    0,  892,  892,  892,  892,
			  893,  893,  893,  893,  893,    0,  893,  894,  894,  894,
			  894,  894,  894,  895,  895,  895,  895,  895,  895,  895, yy_Dummy>>,
			1, 200, 4350)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 896)
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
			    0,    0,    0,  122,  123,  132,  138, 1416, 1395,  144,
			  150,  156,  162, 1392, 4556,  168,  179, 4556,  290,    0,
			 4556,  411, 4556, 4556, 4556, 4556, 4556,  109,  166,  148,
			  304,  172, 1342, 4556,  123, 4556,  128, 1341,  349,    0,
			  161,  133,  269,  352,  313,  159,   85,  266,  171,  141,
			  389,  290,  161,  211,  169,  168, 4556, 1306, 4556, 4556,
			 4556, 4556, 4556,  349,  379,  441,  387,  458,  475,  492,
			  509,  526,  535,  546,  563,  366, 1357, 4556, 4556,  672,
			  209,  686, 4556, 4556,  212,  215,  285,  680,  222, 1342,
			 4556, 4556,  692, 4556, 1206, 1206,  132, 1212, 4556,  724,

			  730, 1272, 1158, 1159,  169, 1146,  736, 1217, 1131, 1132,
			  175, 1137,  693, 4556,  852,  200,  735,  706,  737,  748,
			  753,  803,  805,  760,  814,  809,  816,  822,  919,  923,
			  759,  933, 1044,  934, 1148,  988, 1252, 1004, 1356, 1066,
			    0, 1054, 1066, 1460, 1079, 1218, 1113,  810, 1178, 1021,
			 1217, 1191, 1277,  405, 4556, 4556, 4556,  860, 4556, 4556,
			 4556,  964,  758, 1367, 1373, 1493,  406, 4556, 4556, 4556,
			 4556, 4556, 4556,    0,  232,  266,  394,  285,  282,  282,
			  304,  321,  377,  402,  390, 1453,    0,  628,  718,  819,
			  637,  666,  672,    0,  712, 1484,    0,  720,  944,  714, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  778,  809,  946,    0,  820,  835, 1549,  830,  831,  830,
			  948,  941,  947, 1550,  947,  957,  979,  971, 4556, 1490,
			 1536, 1558, 1588, 1605, 1622, 1639, 1656, 1673, 1690,  896,
			 1707, 1724, 1741, 1758, 1775, 1792, 1198, 4556, 1222, 4556,
			 4556, 4556, 4556, 4556, 1034, 4556, 4556, 4556, 4556, 4556,
			 4556, 4556, 4556, 4556, 4556, 4556, 4556, 4556, 4556, 4556,
			 4556, 1054, 1036,  192, 1042,  214, 4556, 4556, 1901,  372,
			  783,  996,  924, 1001, 4556, 1065, 1904, 1126, 1234, 1132,
			 4556, 1300, 4556, 1023,  976,  302,  981,  980, 1235,  968,
			  975, 1910,  964,  964,  347,  969, 1045,  936, 1448,  915,

			  913,  851, 1822,  837,  840, 4556, 4556, 2026, 1929, 1334,
			 4556, 4556, 4556, 4556, 1411, 4556, 1474, 4556, 1475, 1914,
			 1540, 1931, 1918, 1930, 1948, 4556, 1919, 1947, 1952, 1957,
			 1976, 1985, 4556, 2061, 2178, 2282, 2386, 2490, 2594, 2698,
			 2802, 4556, 4556, 1991, 1160, 2058, 1545, 2095, 2002, 2112,
			 1331,  913,  896,  882,  877,  876, 1077,  873,  866,  852,
			  823,  822,  818,  802,  787,  780,  764,  760,  759,  749,
			  740,  736,  731, 4556, 4556, 2211, 2143, 2199, 2247, 2303,
			 2320, 2351, 2407, 2497, 1645, 4556, 2501, 1947, 1923, 2506,
			 2589, 2606, 2693, 2055, 2203,  981, 1015, 1029,    0,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1024, 1975, 1037, 1154, 1186, 1276, 1286, 1284, 1375, 1381,
			 1408,    0, 1395, 1489, 1432, 1425, 1437, 1991, 1488, 1552,
			 1553, 1544, 1561, 1559, 1564, 1896, 1912, 1945,    0, 2004,
			 1993, 2031, 2049, 2192, 2193, 2198, 2179, 2492, 2183, 2198,
			 2203, 2222, 2219, 2290, 2300, 2294, 2302, 2291, 2322, 2323,
			 2396, 2387,    0, 2637, 2669, 2207, 2719, 2736, 2339, 2767,
			 2365, 2819, 2455, 2836, 2853, 2870, 2887, 2736, 2896, 4556,
			 4556, 4556, 4556, 2926, 2943, 2960, 4556, 3051, 2298,  637,
			 2511,  617,  620,    0,  633, 3074, 2474, 2477, 2586, 2489,
			 4556, 4556, 4556, 4556, 2556, 3076, 2652, 3082, 4556, 2653,

			 4556, 2654, 3084, 3083, 3094, 4556, 4556, 3186, 3290, 3394,
			 3103, 3120, 3151, 3207, 3224, 3255, 3311, 4556, 4556, 4556,
			 4556, 4556, 3420, 2729, 4556, 4556, 4556, 4556, 4556, 4556,
			 4556, 4556, 4556, 4556, 4556, 4556, 4556, 4556, 4556, 4556,
			 4556, 3328, 3361, 3414, 3075, 1613, 2148, 2611, 2862, 2233,
			 2594, 3086, 3504, 3521, 3570, 3587,  683, 3101, 3107, 2449,
			 2586, 2595, 2612, 2652, 2647, 2671, 2672, 2811, 2921, 3044,
			 3044, 3046, 3069, 3075, 3072, 3088, 3087, 3090, 3108, 3093,
			    0, 3119, 3122, 3176, 3183, 3197, 3185,    0, 3192,    0,
			    0, 3193, 3528,    0, 3197, 3186, 3202, 3191, 3197, 3202, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3191, 3292, 3280, 3303, 3289,    0, 3292,    0,    0, 3304,
			 3304, 3290, 3300, 3312,    0,    0, 4556,  434, 1058, 3593,
			 3425,  609, 3287, 3573, 3494, 3288, 3590, 4556, 3665, 4556,
			 3640, 4556, 3644, 3662, 3679,  486, 3667, 3769, 3775, 3539,
			 3792, 2759, 3796, 2763, 2866, 3826, 3655, 3297,    0,    0,
			 3400, 3412, 3440,    0,    0, 3425, 3646, 3502,    0, 3499,
			 3510, 3513, 3531, 3598, 3613, 3639,    0, 3638, 3647, 3657,
			 3654, 3655, 3663, 3754,    0, 3759, 3849, 4556,  418,  315,
			  297,  642,  299, 3791, 3776, 3789, 3795, 3810, 3810, 3829,
			 3815,    0, 3817, 3837,    0,    0, 3830, 3835,    0, 3827,

			 2645, 3853, 3885,  301, 3872, 3877, 3873, 4556, 3936, 3954,
			 4004, 4022, 3972, 3990, 3961, 4026, 2978, 4058, 4074,    0,
			    0, 3856, 3841, 3844,    0, 3850, 3859, 3876, 3882,    0,
			    0, 3880,    0, 3967, 3996,    0, 3983, 3990, 4000, 4002,
			 4028, 4024, 4556,  373,  279, 3062,  258,  261, 4034, 4049,
			 4055, 4056,    0, 4066,    0,    0,    0, 4052, 4059,    0,
			 4054, 4556,  870, 4556, 3867, 4556, 4090,  239, 4108, 4110,
			 4109,  292, 4148,  281, 4172,  270, 4221,  264, 4238,  239,
			 3457, 3553, 4165, 4125, 4202, 4227, 3685, 3689, 4275, 4071,
			 4057,    0, 4076,    0, 4094, 4097, 4130, 4136,    0,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 4152,    0,    0, 4158, 4196, 4274, 4206, 4233, 4246,    0,
			 4245, 4246,    0,    0, 4308, 4258, 4310, 4556, 4556, 4556,
			 4556, 4273, 4206, 4300, 4304, 4308, 4315, 4334, 4321, 4338,
			    0, 4297,    0,    0, 4303,    0,    0,    0, 4296,    0,
			 4367, 4306,  130,  127,  662,  129, 4314,    0, 4328,    0,
			    0, 4366, 4556, 4556, 4331, 4381, 4385,    0, 4344,    0,
			 4339, 4352,  108, 4323,   60,   50,    0,    0, 4556,    0,
			 4362, 4347, 4360, 4361, 4363,    0, 4556, 4556, 4432, 4444,
			 4455, 4462, 4469, 4482,  172, 4489,  122, 1124, 4496, 4503,
			 4510, 4516, 4522, 4529, 4535, 4542, 4548, yy_Dummy>>,
			1, 97, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 896)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (877, 145, 172)
			an_array.area.fill_with (886, 173, 217)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (877, 237, 264)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (877, 341, 374)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (886, 395, 452)
			an_array.area.fill_with (877, 453, 482)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (877, 510, 558)
			an_array.area.fill_with (886, 559, 615)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (886, 647, 675)
			yy_def_template_7 (an_array)
			yy_def_template_8 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  877,    1,  878,  878,  879,  879,  880,  880,  881,
			  881,  882,  882,  877,  877,  877,  877,  877,  883,  884,
			  877,  885,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  887,  877,  877,  877,
			  888,  888,  877,  877,  889,  888,  888,  888,  888,  890,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,

			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  883,  877,  891,  892,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  884,  893,  893,  893,  893, yy_Dummy>>,
			1, 145, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  887, yy_Dummy>>,
			1, 19, 218)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  888,  877,  877,  888,  889,  888,  888,  888,  888,  877,
			  888,  888,  888,  888,  890,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  894,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  891,  892,  883,  877,  877,  877,  877,  883,
			  877,  883,  877,  883,  883,  883,  883,  883,  883,  883,
			  877,  883,  883,  883,  883,  883,  883,  877,  883,  883,
			  883,  883,  883,  883,  883,  883, yy_Dummy>>,
			1, 76, 265)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  893,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877, yy_Dummy>>,
			1, 20, 375)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  894,  894,  892,  892,  892,  892,  892,  877,  877,  877,
			  877,  883,  883,  883,  883,  877,  883,  877,  883,  883,
			  883,  883,  877,  877,  883,  883,  883, yy_Dummy>>,
			1, 27, 483)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  877,  877,  877,  894,  892,  892,  892,  892,
			  883,  877,  883,  877,  883,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877, yy_Dummy>>,
			1, 31, 616)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  877,  877,  877,  877,  877,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  877,  877,  877,  894,  883,  883,
			  883,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  877,  895,  877,  877,
			  877,  877,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  877,  877,  877,  877,  877,
			  877,  894,  883,  883,  883,  877,  877,  877,  877,  877,

			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  896,  883,  883,
			  883,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  877,  886,  877,  877,  877,  877,
			  886,  886,  886,  886,  886,  883,  877,  877,  877,  877,
			  877,  886,  886,  886,  877,  886,  877,  877,  877,  877,
			  886,  886,  877,  886,  877,  886,  877,  886,  877,  886, yy_Dummy>>,
			1, 200, 676)
		end

	yy_def_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  877,    0,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877, yy_Dummy>>,
			1, 21, 876)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (112, 195, 223)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,  123,  123,  123,  123,  123,  123,  123,  123,    1,
			    2,    1,    1,    3,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,

			   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,  123,   93,   94,
			   95,   96,   95,   95,   95,   95,   97,   95,   95,   98,
			   98,   98,   98,   98,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,  100,   99,   99,   99,   99,  101,
			  102,  103,  103,  103,  103,  103,  104,  105,  106,  106,
			  106,  106,  106,  106,  106,  107,  103,  103,  108,  109,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  110,  110,  111, yy_Dummy>>,
			1, 195, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  113,  114,  115,  116,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  118,  119,  119,  120,  121,  121,  121,
			  122,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  123, yy_Dummy>>,
			1, 34, 224)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    7,    1,    7,    7,    2,    3,    2,    2,    4,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    5,    5,    5,    5,    2,    2,    2,    2,    2,    2,
			    2,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    2,    2,    2,
			    2,    5,    2,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    2,
			    2,    2,    2,    6,    6,    6,    6,    6,    6,    6,

			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 878)
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
			  204,  206,  208,  210,  212,  214,  216,  218,  220,  222,

			  225,  227,  229,  231,  233,  235,  237,  238,  238,  238,
			  238,  238,  238,  239,  240,  241,  241,  242,  243,  244,
			  245,  246,  247,  248,  249,  250,  251,  252,  253,  255,
			  256,  257,  259,  260,  261,  262,  263,  264,  265,  266,
			  267,  268,  269,  270,  271,  272,  272,  272,  272,  272,
			  272,  272,  272,  272,  272,  273,  274,  275,  276,  277,
			  278,  279,  280,  281,  281,  281,  281,  281,  282,  283,
			  284,  285,  286,  287,  288,  289,  290,  291,  292,  294,
			  295,  296,  297,  298,  299,  300,  301,  303,  304,  305,
			  306,  307,  308,  309,  311,  312,  313,  315,  316,  317, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  318,  319,  320,  321,  323,  324,  325,  326,  327,  328,
			  329,  330,  331,  332,  333,  334,  335,  336,  337,  338,
			  339,  341,  343,  343,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  343,  343,  344,  345,  345,
			  346,  347,  348,  349,  350,  350,  351,  352,  353,  354,
			  355,  356,  357,  358,  359,  360,  361,  362,  363,  364,
			  365,  366,  366,  366,  366,  366,  367,  368,  369,  370,
			  371,  372,  373,  374,  375,  377,  378,  379,  380,  381,
			  382,  383,  383,  384,  384,  384,  384,  384,  384,  384,
			  384,  384,  385,  385,  385,  385,  385,  386,  386,  386,

			  386,  386,  386,  386,  386,  386,  387,  389,  391,  392,
			  393,  395,  397,  399,  401,  402,  404,  405,  407,  408,
			  409,  410,  411,  412,  413,  414,  415,  416,  417,  418,
			  419,  420,  421,  423,  424,  425,  426,  427,  428,  429,
			  430,  431,  432,  434,  434,  434,  434,  434,  434,  434,
			  434,  434,  435,  436,  437,  438,  439,  440,  441,  442,
			  443,  444,  445,  446,  447,  448,  449,  450,  451,  452,
			  453,  454,  455,  456,  458,  459,  460,  460,  460,  460,
			  460,  460,  460,  460,  461,  461,  462,  463,  463,  464,
			  466,  467,  469,  470,  471,  471,  472,  473,  474,  476, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  478,  479,  480,  481,  482,  483,  484,  485,  486,  487,
			  488,  489,  491,  492,  493,  494,  495,  496,  497,  498,
			  499,  500,  501,  502,  503,  504,  505,  507,  508,  510,
			  511,  512,  513,  514,  515,  516,  517,  518,  519,  520,
			  521,  522,  523,  524,  525,  526,  527,  528,  529,  530,
			  531,  532,  533,  535,  535,  535,  535,  535,  535,  535,
			  535,  535,  535,  535,  535,  535,  535,  535,  537,  539,
			  540,  541,  542,  543,  543,  543,  543,  544,  544,  544,
			  544,  544,  544,  544,  545,  546,  546,  546,  546,  546,
			  546,  548,  550,  552,  554,  555,  556,  557,  558,  560,

			  561,  563,  564,  565,  566,  567,  569,  571,  572,  573,
			  574,  574,  574,  574,  574,  574,  574,  574,  575,  576,
			  577,  578,  579,  580,  581,  582,  583,  584,  585,  586,
			  587,  588,  589,  590,  591,  592,  593,  594,  595,  596,
			  597,  599,  599,  599,  599,  600,  600,  601,  602,  602,
			  602,  603,  604,  604,  604,  604,  604,  604,  605,  606,
			  607,  608,  609,  610,  611,  612,  613,  614,  615,  616,
			  617,  618,  619,  620,  622,  623,  624,  625,  626,  627,
			  628,  630,  631,  632,  633,  634,  635,  636,  638,  639,
			  641,  643,  644,  646,  648,  649,  650,  651,  652,  653, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  654,  655,  656,  657,  658,  659,  661,  662,  664,  666,
			  667,  668,  669,  670,  671,  673,  675,  676,  676,  676,
			  676,  676,  677,  677,  677,  677,  677,  678,  680,  681,
			  683,  684,  686,  686,  686,  686,  687,  687,  687,  687,
			  687,  688,  688,  689,  689,  690,  691,  692,  693,  695,
			  697,  698,  699,  700,  702,  704,  705,  706,  707,  709,
			  710,  711,  712,  713,  714,  715,  716,  718,  719,  720,
			  721,  722,  723,  724,  725,  727,  728,  728,  729,  729,
			  729,  729,  729,  729,  730,  731,  732,  733,  734,  735,
			  736,  737,  739,  740,  741,  743,  745,  746,  747,  749,

			  750,  750,  750,  750,  751,  752,  753,  754,  755,  755,
			  755,  755,  755,  755,  755,  756,  757,  757,  757,  758,
			  760,  762,  763,  764,  765,  767,  768,  769,  770,  771,
			  773,  775,  776,  778,  779,  780,  782,  783,  784,  785,
			  786,  787,  788,  789,  789,  789,  789,  789,  789,  790,
			  791,  792,  793,  795,  796,  798,  800,  802,  803,  804,
			  806,  807,  808,  808,  809,  809,  810,  810,  811,  812,
			  813,  814,  814,  814,  814,  814,  814,  814,  814,  814,
			  814,  814,  815,  816,  816,  816,  817,  817,  818,  818,
			  819,  820,  822,  823,  825,  826,  827,  828,  829,  831, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  833,  834,  836,  838,  839,  840,  841,  842,  843,  844,
			  846,  847,  848,  850,  852,  853,  854,  855,  857,  858,
			  860,  861,  862,  862,  863,  863,  864,  865,  865,  865,
			  866,  868,  869,  871,  873,  874,  876,  878,  880,  881,
			  883,  883,  884,  884,  884,  884,  884,  885,  887,  888,
			  890,  892,  893,  895,  897,  898,  898,  899,  901,  902,
			  904,  904,  905,  905,  905,  905,  905,  907,  909,  911,
			  913,  913,  914,  914,  915,  915,  917,  918,  918, yy_Dummy>>,
			1, 79, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 917)
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
			    0,  191,  191,  193,  193,  227,  225,  226,    1,  225,
			  226,    1,  226,   36,  225,  226,  194,  225,  226,   48,
			  225,  226,   14,  225,  226,  159,  225,  226,   24,  225,
			  226,   25,  225,  226,   32,  225,  226,   30,  225,  226,
			    9,  225,  226,   31,  225,  226,   13,  225,  226,   33,
			  225,  226,  123,  225,  226,  123,  225,  226,    8,  225,
			  226,    7,  225,  226,   18,  225,  226,   17,  225,  226,
			   19,  225,  226,   11,  225,  226,  122,  225,  226,  122,
			  225,  226,  122,  225,  226,  122,  225,  226,  122,  225,
			  226,  122,  225,  226,  122,  225,  226,  122,  225,  226,

			  122,  225,  226,  122,  225,  226,  122,  225,  226,  122,
			  225,  226,  122,  225,  226,  122,  225,  226,  122,  225,
			  226,  122,  225,  226,  122,  225,  226,  122,  225,  226,
			   28,  225,  226,  225,  226,   29,  225,  226,   34,  225,
			  226,   26,  225,  226,   27,  225,  226,   12,  225,  226,
			  225,  226,  225,  226,  225,  226,  225,  226,  225,  226,
			  225,  226,  225,  226,  225,  226,  225,  226,  225,  226,
			  225,  226,  225,  226,  225,  226,  195,  226,  224,  226,
			  222,  226,  223,  226,  191,  226,  191,  226,  190,  226,
			  189,  226,  191,  226,  191,  226,  191,  226,  191,  226, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  191,  226,  193,  226,  192,  226,  187,  226,  187,  226,
			  186,  226,  187,  226,  187,  226,  187,  226,  187,  226,
			    6,  226,    5,    6,  226,    5,  226,    6,  226,    6,
			  226,    6,  226,    6,  226,    6,  226,    1,  194,  183,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  194,  194,  194, -411,  194,  194,  194, -411,  194,
			  194,  194,  194,  194,  194,  194,  194,   48,  159,  159,
			  159,  159,    2,   35,   10,  129,   39,   23,   22,  129,
			  123,   15,   37,   20,   21,   38,   16,  122,  122,  122,
			  122,  122,   55,  122,  122,  122,  122,  122,  122,  122,

			  122,   68,  122,  122,  122,  122,  122,  122,  122,   80,
			  122,  122,  122,   86,  122,  122,  122,  122,  122,  122,
			  122,   98,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,   40,   49,    1,
			   49,   43,   49,  195,  222,  212,  210,  211,  213,  214,
			  215,  216,  196,  197,  198,  199,  200,  201,  202,  203,
			  204,  205,  206,  207,  208,  209,  191,  190,  189,  191,
			  191,  191,  191,  191,  191,  188,  189,  191,  191,  191,
			  191,  193,  192,  186,    5,    4,  184,  181,  184,  194,
			 -411, -411,  194,  167,  184,  165,  184,  166,  184,  168, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  184,  194,  161,  184,  194,  162,  184,  194,  194,  194,
			  194,  194,  194,  194, -185,  194,  194,  194,  194,  194,
			  194,  169,  184,  194,  194,  194,  194,  194,  194,  194,
			  194,  159,  130,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  132,  159,  130,  159,
			  129,  124,  129,  123,  127,  128,  128,  126,  128,  125,
			  123,  122,  122,  122,   53,  122,   54,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,   71,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,

			  122,  122,  122,  122,  122,   90,  122,  122,   93,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  121,  122,   41,   49,   42,   49,   46,
			   47,   45,   44,  221,    4,    4,  173,  184,  170,  184,
			  163,  184,  164,  184,  194,  194,  194,  194,  178,  184,
			  194,  172,  184,  194,  194,  194,  194,  171,  184,  182,
			  184,  194,  194,  194,  149,  147,  148,  150,  151,  160,
			  160,  152,  153,  133,  134,  135,  136,  137,  138,  139,
			  140,  141,  142,  143,  144,  145,  146,  131,  159,  129, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  129,  129,  129,  123,  123,  123,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			   69,  122,  122,  122,  122,  122,  122,  122,   78,  122,
			  122,  122,  122,  122,  122,  122,   87,  122,  122,   89,
			  122,   91,  122,  122,   96,  122,   97,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  110,
			  122,  122,  112,  122,  113,  122,  122,  122,  122,  122,
			  122,  119,  122,  120,  122,  217,    4,  194,  174,  184,
			  194,  177,  184,  194,  180,  184,  160,  129,  129,  129,
			  129,  123,  122,   51,  122,   52,  122,  122,  122,  122,

			   59,  122,   60,  122,  122,  122,  122,   65,  122,  122,
			  122,  122,  122,  122,  122,  122,   76,  122,  122,  122,
			  122,  122,  122,  122,  122,   88,  122,  122,   94,  122,
			  122,  122,  122,  122,  122,  122,  122,  107,  122,  122,
			  122,  111,  122,  114,  122,  122,  122,  117,  122,  122,
			    4,  194,  194,  194,  154,  129,  129,  129,   50,  122,
			   56,  122,  122,  122,  122,   62,  122,  122,  122,  122,
			  122,   70,  122,   72,  122,  122,   74,  122,  122,  122,
			   79,  122,  122,  122,  122,  122,  122,  122,   95,  122,
			  122,  122,  122,  103,  122,  122,  105,  122,  106,  122, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  108,  122,  122,  122,  116,  122,  122,  220,  219,  218,
			    4,  194,  194,  194,  129,  129,  129,  129,  122,  122,
			   61,  122,  122,   64,  122,  122,  122,  122,  122,   77,
			  122,   81,  122,  122,   83,  122,   84,  122,  122,  122,
			  122,  122,  122,  122,  104,  122,  122,  122,  118,  122,
			    3,    4,  194,  194,  194,  157,  158,  158,  156,  158,
			  155,  129,  129,  129,  129,  129,   57,  122,  122,   63,
			  122,   66,  122,  122,   73,  122,   75,  122,   82,  122,
			  122,   92,  122,  122,  122,  101,  122,  122,  109,  122,
			  115,  122,  194,  176,  184,  179,  184,  129,  129,   58,

			  122,  122,   85,  122,  122,  100,  122,  102,  122,  175,
			  184,   67,  122,  122,  122,   99,  122,   99, yy_Dummy>>,
			1, 118, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 4556
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 877
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 878
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 123
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 256
			-- All symbols greater than this symbol will have
			-- the same equivalence class as this symbol

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

	yyNb_rules: INTEGER = 226
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 227
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
