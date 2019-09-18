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
				if syntax_version /= obsolete_syntax then
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_FORALL, Current)
					last_token := TE_FORALL
				else
					process_id_as
					last_token := TE_FREE
				end
			
when 42 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_EXISTS, Current)
					last_token := TE_EXISTS
				else
					process_id_as
					last_token := TE_FREE
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
				if syntax_version /= obsolete_syntax then
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_REPEAT_OPEN, Current)
					last_token := TE_REPEAT_OPEN
				else
					process_id_as
					last_token := TE_FREE
				end
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_REPEAT_CLOSE, Current)
					last_token := TE_REPEAT_CLOSE
				else
					process_id_as
					last_token := TE_FREE
				end
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_BLOCK_OPEN, Current)
					last_token := TE_BLOCK_OPEN
				else
					process_id_as
					last_token := TE_FREE
				end
			
when 47 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version /= obsolete_syntax then
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_BLOCK_CLOSE, Current)
					last_token := TE_BLOCK_CLOSE
				else
					process_id_as
					last_token := TE_FREE
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
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 84 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 85 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 86 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 87 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 88 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 89 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 90 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 91 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 92 then
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
			
when 93 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 94 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 95 then
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
			
when 96 then
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
			
when 97 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 98 then
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
			
when 99 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 100 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 101 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 102 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 103 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 104 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 105 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 106 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 107 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 108 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 110 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 111 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 112 then
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
			
when 113 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 116 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 117 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 118 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 119 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 120 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 123 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 124 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 125 then
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
			
when 126 then
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
			
when 127 then
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
			
when 128 then
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
			
when 129 then
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
			
when 130 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 131 then
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
			
when 132 then
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
			
when 133 then
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
			
when 134 then
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
			
when 135 then
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
			
when 136 then
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
			
when 137 then
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
			
when 138 then
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
			
when 139 then
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
			
when 140 then
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
			
when 141 then
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
			
when 142 then
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
			
when 143 then
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
			
when 144 then
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
			
when 145 then
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
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
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
			
when 154 then
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
			
when 155 then
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
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 159 then
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
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 161 then
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
			
when 162 then
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
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 164 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 166 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 167 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 168 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 169 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 170 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 171 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 172 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 173 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 174 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 175 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 176 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 177 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 178 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 179 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 180 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 181 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 182 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 183 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 186 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 187 then
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
			
when 188 then
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
			
when 189 then
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
			
when 190 then
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
			
when 191 then
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
			
when 195 then
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
			
when 196 then
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
			
when 197 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 213 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 214 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 215 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 216 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 217 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 218 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 222 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 223 then
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
			
when 224 then
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
			
when 225 then
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
			
when 226 then
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
			
when 227 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 228 then
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
			create an_array.make_filled (0, 0, 4694)
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
			yy_nxt_template_21 (an_array)
			yy_nxt_template_22 (an_array)
			yy_nxt_template_23 (an_array)
			yy_nxt_template_24 (an_array)
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

			   14,   14,   63,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   64,   65,   66,   67,   68,   69,   70,   71,
			   72,   73,   74,   75,   77,   77,  154,  173,   78,   78,
			  199,   79,   79,   81,   82,   81,   81,  155,   83,   81,
			   82,   81,   81,  846,   83,   92,   93,   92,   92,  168,
			  169,   92,   93,   92,   92,  170,  171,   99,  100,   99,
			   99,  846,  199,   99,  100,   99,   99,  158,  185,  106,
			  106,  106,  106,  101,  140,  159,  206,  140,  186,  101,
			  106,  106,  106,  106,  156,  107,  157,  157,  157,  157,
			  161,   84,  162,  162,  162,  162,  107,   84,  197,  180, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  185,  846,  204,  181,  198,  213,  182,  216,  206,  183,
			  186,  266,  184,  217,  266,  267,  266,  266,  274,  205,
			  267,  267,  871,   84,  266,  288,  289,  868,  267,   84,
			  197,  180,  846,  166,  204,  181,  198,  213,  182,  216,
			  160,  183,  214,   85,  184,  217,   86,   87,   88,   85,
			  712,  205,   86,   87,   88,   94,  215,  308,   95,   96,
			   97,   94,  298,  299,   95,   96,   97,  102,  302,  303,
			  103,  104,  105,  102,  214,  826,  103,  104,  105,  108,
			  395,  825,  109,  110,  111,  481,  482,  266,  215,  308,
			  108,  267,  824,  109,  110,  111,  113,  114,  200,  115,

			  114,  396,  116,  823,  117,  118,  819,  119,  201,  120,
			  202,  187,  395,  188,  203,  278,  121,  268,  122,  399,
			  114,  123,  161,  189,  162,  162,  162,  162,  210,  124,
			  200,  400,  401,  396,  125,  126,  163,  164,  211,  402,
			  201,  212,  202,  187,  127,  188,  203,  128,  129,  193,
			  130,  399,  403,  123,  680,  189,  194,  195,  165,  680,
			  210,  124,  196,  400,  401,  166,  125,  126,  163,  164,
			  211,  402,  680,  212,  266,  680,  127,  773,  274,  131,
			  114,  193,  174,  190,  403,  275,  175,  191,  194,  195,
			  165,  176,  752,  177,  196,  288,  289,  749,  178,  179, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  192,  132,  132,  133,  134,  134,  134,  134,  135,  136,
			  137,  138,  139,  142,  174,  190,  374,  680,  175,  191,
			  143,  404,  144,  176,  207,  177,  393,  393,  393,  393,
			  178,  179,  192,  397,  208,  748,  398,  405,  406,  209,
			  298,  299,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  404,  705,  705,  207,  219,  219,  235,
			  235,  235,  235,  235,  235,  397,  208,  394,  398,  405,
			  406,  209,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  220,  219,  221,  219,  219,  219,  219,  219,  222,
			  222,  222,  222,  222,  222,  222,  222,  712,  382,  382,

			  382,  382,  382,  382,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  146,  146,  147,  148,  148,  148,  148,  149,
			  150,  151,  152,  153,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  223,  223,  223,  223,  223,  223,  223,  224,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  225,  226,
			  227,  227,  228,  227,  227,  227,  229,  227,  227,  227,
			  227,  227,  227,  227,  227,  230,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  233,  233,  233,  233,  233,
			  233,  233,  233,  233,  233,  233,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  238,  238,  238,  238,  410,  239,  415,
			  708,  240,  266,  241,  242,  243,  267,  268,  266,  268,
			  268,  244,  267,  281,  282,  281,  281,  416,  245,  305,

			  246,  385,  115,  247,  248,  249,  250,  624,  251,  410,
			  252,  415,  310,  238,  253,  115,  254,  417,  238,  255,
			  256,  257,  258,  259,  260,  291,  291,  291,  291,  416,
			  238,  291,  291,  291,  291,  418,  424,  106,  106,  106,
			  106,  305,  540,  311,  115,  269,  115,  427,  309,  417,
			  131,  539,  428,  107,  312,  750,  751,  115,  429,  313,
			  538,  432,  115,  131,  869,  870,  305,  418,  424,  115,
			  705,  705,  314,  276,  277,  537,  536,  269,  315,  427,
			  535,  115,  131,  261,  428,  534,  262,  263,  264,  533,
			  429,  532,  131,  432,  131,  131,  374,  270,  531,  316, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  271,  272,  273,  283,  319,  131,  284,  285,  286,  317,
			  131,  768,  115,  305,  530,  529,  115,  131,  305,  305,
			  332,  115,  115,  115,  131,  305,  131,  528,  115,  131,
			  318,  425,  527,  526,  433,  292,  319,  131,  293,  294,
			  295,  292,  131,  426,  293,  294,  295,  108,  525,  131,
			  109,  110,  111,  112,  112,  320,  112,  112,  321,  306,
			  131,  131,  115,  425,  131,  331,  433,  322,  413,  131,
			  131,  131,  414,  411,  442,  426,  131,  522,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  320,  412,  521,
			  321,  520,  131,  443,  519,  444,  131,  518,  374,  322,

			  413,  131,  131,  131,  414,  411,  442,  106,  131,  440,
			  307,  445,  446,  441,  470,  471,  106,  106,  472,  473,
			  412,  324,  325,  324,  324,  443,  305,  444,  291,  115,
			  324,  325,  324,  324,  291,  305,  305,  305,  115,  115,
			  115,  440,  307,  445,  446,  441,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  323,  131,  305,  326,
			  266,  115,  450,  291,  267,  451,  131,  131,  131,  376,
			  376,  376,  376,  376,  376,  376,  376,  485,  430,  305, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  452,  266,  115,  300,  297,  267,  453,  431,  323,  131,
			  560,  291,  305,  281,  450,  115,  342,  451,  131,  131,
			  131,  281,  281,  340,  340,  340,  340,  340,  340,  131,
			  430,  327,  452,  407,  328,  329,  330,  408,  453,  431,
			  327,  561,  560,  328,  329,  330,  305,  290,  287,  115,
			  131,  409,  383,  383,  383,  383,  478,  479,  479,  479,
			  266,  131,  281,  131,  267,  407,  373,  384,  280,  408,
			  483,  276,  277,  561,  334,  334,  334,  334,  334,  334,
			  334,  334,  131,  409,  480,  238,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  131,  374,  131,  266,  384,

			  266,  268,  267,  237,  267,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  343,  343,  344,  345,
			  345,  345,  345,  346,  347,  348,  349,  350,  374,  131,
			  706,  706,  706,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  305,  278,  374,  115,  343,  343,  344,  345,  345,  345,
			  345,  346,  347,  348,  349,  350,  343,  343,  344,  345,
			  345,  345,  345,  346,  347,  348,  349,  350,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  374,  275,  562,  563,  268, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  566,  131,  523,  524,  524,  524,  374,  304,  301,  106,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  374,  154,  562,
			  563,  300,  566,  131,  567,  297,  291,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  305,  296,  290,  115,  385,  287,
			  386,  386,  386,  386,  281,  161,  567,  388,  388,  388,
			  388,  280,  237,  218,  568,  387,  172,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  379,  380,  380,  380,  380,  380,  380,

			  380,  380,  380,  380,  380,  131,  568,  387,  166,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  381,  381,  381,  381,  381,  281,  281,  281,  281,
			  281,  266,  266,  167,  266,  267,  267,  131,  267,  883,
			  281,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  305,   90,
			   90,  115,  883,  238,  238,  238,  238,  389,  389,  390,
			  390,  477,  883,  391,  391,  391,  390,  883,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  392,  392,  392,  392,  291,  291,  291,  291,  291,  569, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  570,  392,  392,  392,  392,  392,  392,  883,  291,  131,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  268,  268,  883,  268,  268,  268,  268,  268,
			  883,  569,  570,  392,  392,  392,  392,  392,  392,  268,
			  571,  131,  572,  883,  883,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  351,  564,  883,  352,  883,  353,  354,  355,
			  883,  883,  571,  261,  572,  356,  262,  263,  264,  883,
			  565,  419,  357,  420,  358,  421,  447,  359,  360,  361,
			  362,  448,  363,  883,  364,  564,  422,  573,  365,  423,

			  366,  574,  449,  367,  368,  369,  370,  371,  372,  434,
			  575,  435,  565,  419,  883,  420,  883,  421,  447,  436,
			  883,  578,  437,  448,  438,  439,  883,  883,  422,  573,
			  883,  423,  579,  574,  449,  883,  106,  106,  106,  106,
			  883,  434,  575,  435,  106,  106,  106,  106,  106,  883,
			  883,  436,  107,  578,  437,  883,  438,  439,  106,  491,
			  883,  883,  115,  883,  579,  883,  883,  343,  343,  344,
			  345,  345,  345,  345,  346,  347,  348,  349,  350,  454,
			  511,  511,  511,  511,  511,  511,  511,  511,  883,  455,
			  455,  456,  457,  458,  457,  457,  459,  460,  461,  462, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  463,  454,  517,  517,  517,  517,  517,  517,  883,  580,
			  131,  455,  455,  456,  457,  458,  457,  457,  459,  460,
			  461,  462,  463,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  546,  883,  546,  883,  454,  547,  547,  547,
			  547,  580,  131,  883,  883,  883,  464,  455,  456,  465,
			  466,  467,  457,  459,  460,  461,  462,  463,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  220,  219,  219,  219,  219,  219,  219,  219,

			  219,  219,  219,  219,  219,  219,  219,  219,  219,  220,
			  220,  220,  220,  220,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  220,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  220,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  468,  219,  219,  469,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  220,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  476,  476,  476,  476,  476,  476,  476,  476,
			  476,  476,  476,  476,  476,  476,  476,  476,  476,  268,
			  266,  268,  268,  583,  267,  281,  282,  281,  281,  584,
			  883,  291,  291,  291,  291,  492,  493,  494,  115,  115,

			  115,  305,  305,  305,  115,  115,  115,  883,  486,  325,
			  486,  486,  585,  883,  305,  583,  883,  115,  498,  501,
			  499,  584,  115,  115,  586,  545,  545,  545,  545,  495,
			  581,  324,  325,  324,  324,  576,  305,  269,  883,  115,
			  384,  883,  496,  582,  585,  500,  131,  131,  131,  577,
			  587,  588,  131,  131,  131,  883,  586,  883,  497,  883,
			  883,  495,  581,  883,  308,  131,  883,  576,  883,  269,
			  131,  131,  384,  305,  496,  582,  115,  500,  131,  131,
			  131,  577,  587,  588,  131,  131,  131,  131,  305,  270,
			  497,  115,  271,  272,  273,  283,  308,  131,  284,  285, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  286,  292,  131,  131,  293,  294,  295,  112,  324,  325,
			  324,  324,  305,  306,  506,  115,  115,  115,  487,  131,
			  883,  488,  489,  490,  131,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  589,  883,  590,  131,
			  591,  327,  592,  593,  328,  329,  330,  305,  883,  594,
			  115,  883,  550,  595,  550,  596,  131,  551,  551,  551,
			  551,  883,  883,  131,  307,  131,  883,  883,  589,  324,
			  590,  131,  591,  883,  592,  593,  547,  547,  547,  547,
			  507,  594,  502,  115,  883,  595,  883,  596,  883,  161,
			  883,  552,  552,  552,  552,  131,  307,  131,  131,  505,

			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  327,  112,
			  112,  328,  329,  330,  112,  112,  112,  112,  112,  112,
			  131,  131,  166,  883,  503,  504,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  541,  883,  557,  883,  558,  558,  558,
			  558,  883,  883,  131,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  547,  547,  547,  547,  132,  132,  133,  134,  134,
			  134,  134,  135,  136,  137,  138,  139,  305,  394,  883, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  115,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  548,  548,  548,  548,  599,
			  559,  559,  559,  559,  597,  600,  601,  598,  131,  883,
			  549,  602,  883,  343,  343,  344,  345,  345,  345,  345,
			  346,  347,  348,  349,  350,  883,  883,  646,  883,  646,
			  605,  599,  647,  647,  647,  647,  597,  600,  601,  598,
			  131,  394,  549,  602,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,

			  333,  305,  605,  883,  115,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  606,
			  607,  608,  609,  610,  611,  612,  613,  614,  615,  616,
			  617,  618,  131,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  883,  606,  607,  608,  609,  610,  611,  612,  613,  614,
			  615,  616,  617,  618,  131,  883,  883,  883,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  333,  333,  333,  333,  333,  305,  883,  883,  115,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  222,  222,  222,  222,  222,  222,  222,
			  222,  551,  551,  551,  551,  308,  131,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  883,  883,  308,  131,  219,
			  219,  628,  333,  333,  333,  333,  333,  333,  333,  333,

			  333,  333,  333,  333,  333,  333,  333,  333,  333,  305,
			  883,  883,  115,  544,  544,  544,  544,  544,  544,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  544,  544,
			  389,  389,  390,  390,  603,  235,  235,  235,  235,  235,
			  235,  390,  390,  390,  390,  390,  390,  619,  479,  479,
			  479,  479,  604,  238,  238,  238,  238,  238,  308,  650,
			  131,  551,  551,  551,  551,  883,  603,  238,  883,  883,
			  883,  553,  883,  390,  390,  390,  390,  390,  390,  883,
			  883,  883,  308,  308,  604,  719,  719,  719,  719,  623,
			  308,  650,  131,  883,  626,  627,  333,  333,  333,  333, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  305,  308,  308,  115,  638,  524,  524,
			  524,  524,  390,  390,  390,  390,  625,  486,  651,  652,
			  653,  883,  883,  390,  390,  390,  390,  390,  390,  391,
			  391,  391,  390,  645,  645,  645,  645,  883,  883,  654,
			  390,  390,  390,  390,  390,  390,  655,  883,  549,  642,
			  651,  652,  653,  554,  131,  390,  390,  390,  390,  390,
			  390,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  555,  654,  390,  390,  390,  390,  390,  390,  655,  648,
			  549,  552,  552,  552,  552,  883,  131,  883,  656,  657,

			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  305,  883,  557,
			  115,  649,  649,  649,  649,  883,  392,  392,  392,  392,
			  656,  657,  394,  658,  659,  883,  883,  392,  392,  392,
			  392,  392,  392,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  660,  661,  394,  662,  663,  658,  659,  556,  131,  392,
			  392,  392,  392,  392,  392,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  660,  661,  883,  662,  663,  883,  883,  883, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  664,  883,  883,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  305,  883,  883,  115,  227,  227,  227,  227,  227,
			  227,  227,  227,  664,  227,  227,  227,  227,  227,  227,
			  227,  227,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  665,  666,  131,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  647,  647,  647,  647,  647,  647,  647,  647,  791,  791,

			  791,  791,  665,  666,  131,  883,  883,  883,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  220,  219,  219,  219,  219,  219,
			  219,  219,  223,  223,  223,  223,  223,  223,  223,  224,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  225,
			  226,  227,  227,  227,  227,  227,  227,  667,  227,  227,
			  227,  227,  227,  227,  227,  227,  230,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  454,  787,  787,  787,  787,  883,  667, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  883,  883,  883,  455,  455,  456,  457,  458,  457,  457,
			  459,  460,  461,  462,  463,  454,  786,  883,  786,  883,
			  883,  787,  787,  787,  787,  455,  455,  456,  457,  458,
			  457,  457,  459,  460,  461,  462,  463,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  619,  479,
			  479,  479,  479,  486,  325,  486,  486,  883,  629,  883,

			  630,  620,  621,  115,  883,  305,  632,  305,  115,  115,
			  115,  634,  305,  305,  115,  115,  115,  557,  668,  559,
			  559,  559,  559,  622,  883,  883,  305,  669,  305,  115,
			  623,  115,  883,  620,  621,  670,  633,  643,  643,  643,
			  643,  631,  671,  672,  673,  883,  883,  883,  674,  308,
			  668,  131,  384,  675,  676,  622,  131,  131,  131,  669,
			  394,  677,  131,  131,  131,  678,  679,  670,  633,  687,
			  688,  883,  689,  631,  671,  672,  673,  131,  644,  131,
			  674,  308,  883,  131,  384,  675,  676,  690,  131,  131,
			  131,  883,  691,  677,  131,  131,  131,  678,  679,  324, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  324,  687,  688,  487,  689,  883,  488,  489,  490,  131,
			  883,  131,  883,  324,  324,  324,  324,  324,  883,  690,
			  883,  883,  883,  324,  691,  883,  883,  324,  305,  883,
			  883,  115,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  692,  693,  694,  695,
			  696,  697,  698,  699,  700,  701,  702,  703,  704,  131,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  883,  692,  693,

			  694,  695,  696,  697,  698,  699,  700,  701,  702,  703,
			  704,  131,  883,  883,  883,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  305,  883,  883,  115,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  479,  479,  479,  479,  308,  724,  308,  717,  717,  717,
			  717,  725,  726,  131,  636,  636,  636,  636,  636,  636,
			  636,  636,  636,  636,  636,  636,  636,  636,  636,  636, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  636,  787,  787,  787,  787,  727,  308,  724,  308,  883,
			  486,  623,  486,  725,  726,  131,  883,  883,  642,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  305,  727,  883,  115,
			  637,  637,  637,  637,  637,  637,  637,  637,  637,  637,
			  637,  637,  637,  637,  637,  637,  637,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  883,  638,  524,  524,  524,  524,
			  728,  731,  729,  732,  733,  883,  730,  131,  639,  640,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,

			  375,  375,  375,  375,  375,  375,  375,  883,  734,  735,
			  641,  883,  728,  731,  729,  732,  733,  642,  730,  131,
			  639,  640,  883,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  734,  735,  641,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  389,  389,  390,  390,  736,  680,  680,  680,  680,  883,
			  681,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  682,  737,  643,  643,  643,  643,  308,  390,  390,
			  390,  390,  390,  390,  883,  883,  736,  883,  718,  883, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  883,  553,  738,  390,  390,  390,  390,  390,  390,  793,
			  793,  793,  793,  883,  737,  739,  740,  883,  554,  308,
			  390,  390,  390,  390,  390,  390,  391,  391,  391,  390,
			  718,  486,  305,  883,  738,  115,  741,  390,  390,  390,
			  390,  390,  390,  392,  392,  392,  392,  739,  740,  707,
			  707,  707,  707,  681,  392,  392,  392,  392,  392,  392,
			  707,  707,  707,  707,  707,  707,  308,  555,  741,  390,
			  390,  390,  390,  390,  390,  683,  709,  883,  684,  685,
			  686,  883,  305,  131,  556,  115,  392,  392,  392,  392,
			  392,  392,  707,  707,  707,  707,  707,  707,  308,  742,

			  743,  883,  486,  486,  486,  486,  486,  305,  709,  723,
			  115,  559,  559,  559,  559,  131,  486,  744,  711,  745,
			  883,  746,  753,  713,  713,  714,  714,  754,  755,  756,
			  757,  742,  743,  131,  714,  714,  714,  714,  714,  714,
			  710,  680,  680,  680,  680,  680,  883,  883,  883,  744,
			  711,  745,  166,  746,  753,  680,  883,  883,  131,  754,
			  755,  756,  757,  883,  883,  131,  714,  714,  714,  714,
			  714,  714,  710,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  131,  341,  341,  341,  341,  341,  341,  341,  341,  341, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  715,  715,  715,  714,  758,
			  759,  716,  716,  716,  716,  760,  714,  714,  714,  714,
			  714,  714,  716,  716,  716,  716,  716,  716,  720,  720,
			  720,  720,  883,  883,  761,  762,  763,  883,  764,  883,
			  883,  758,  759,  549,  883,  883,  765,  760,  714,  714,
			  714,  714,  714,  714,  716,  716,  716,  716,  716,  716,
			  385,  766,  720,  720,  720,  720,  761,  762,  763,  721,
			  764,  680,  680,  680,  680,  549,  747,  722,  765,  767,

			  705,  705,  769,  706,  706,  706,  795,  682,  771,  707,
			  707,  707,  707,  766,  305,  305,  305,  115,  115,  115,
			  707,  707,  707,  707,  707,  707,  883,  796,  883,  722,
			  883,  785,  717,  717,  717,  717,  883,  883,  795,  883,
			  883,  768,  797,  883,  770,  775,  774,  883,  883,  883,
			  772,  883,  707,  707,  707,  707,  707,  707,  776,  796,
			  788,  788,  788,  788,  798,  131,  131,  131,  777,  713,
			  713,  714,  714,  642,  797,  789,  799,  775,  774,  747,
			  714,  714,  714,  714,  714,  714,  792,  883,  792,  883,
			  776,  793,  793,  793,  793,  883,  798,  131,  131,  131, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  883,  683,  883,  883,  684,  685,  686,  789,  799,  883,
			  778,  800,  714,  714,  714,  714,  714,  714,  779,  714,
			  714,  714,  714,  801,  802,  803,  720,  720,  720,  720,
			  714,  714,  714,  714,  714,  714,  781,  715,  715,  715,
			  714,  790,  385,  800,  791,  791,  791,  791,  714,  714,
			  714,  714,  714,  714,  883,  801,  802,  803,  883,  794,
			  780,  804,  714,  714,  714,  714,  714,  714,  793,  793,
			  793,  793,  805,  790,  806,  807,  808,  809,  782,  810,
			  714,  714,  714,  714,  714,  714,  783,  716,  716,  716,
			  716,  794,  811,  804,  812,  813,  883,  814,  716,  716,

			  716,  716,  716,  716,  805,  815,  806,  807,  808,  809,
			  816,  810,  817,  818,  706,  706,  706,  305,  305,  305,
			  115,  115,  115,  883,  811,  883,  812,  813,  784,  814,
			  716,  716,  716,  716,  716,  716,  883,  815,  707,  707,
			  707,  707,  816,  883,  817,  818,  820,  883,  822,  707,
			  707,  707,  707,  707,  707,  770,  827,  827,  827,  827,
			  836,  821,  829,  829,  829,  829,  837,  838,  131,  131,
			  131,  789,  832,  832,  832,  832,  883,  883,  820,  772,
			  822,  707,  707,  707,  707,  707,  707,  833,  839,  840,
			  883,  883,  836,  821,  713,  713,  714,  714,  837,  838, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  131,  131,  789,  841,  714,  714,  714,  714,  714,
			  714,  714,  714,  714,  714,  842,  883,  883,  883,  833,
			  839,  840,  714,  714,  714,  714,  714,  714,  829,  829,
			  829,  829,  843,  844,  845,  778,  841,  714,  714,  714,
			  714,  714,  714,  828,  883,  828,  883,  842,  829,  829,
			  829,  829,  780,  852,  714,  714,  714,  714,  714,  714,
			  715,  715,  715,  714,  843,  844,  845,  853,  854,  883,
			  855,  714,  714,  714,  714,  714,  714,  716,  716,  716,
			  716,  846,  846,  846,  846,  852,  883,  856,  716,  716,
			  716,  716,  716,  716,  831,  831,  831,  831,  883,  853,

			  854,  782,  855,  714,  714,  714,  714,  714,  714,  830,
			  883,  830,  863,  847,  831,  831,  831,  831,  784,  856,
			  716,  716,  716,  716,  716,  716,  834,  305,  834,  789,
			  115,  835,  835,  835,  835,  858,  859,  883,  115,  115,
			  831,  831,  831,  831,  863,  847,  835,  835,  835,  835,
			  864,  860,  860,  860,  860,  644,  835,  835,  835,  835,
			  865,  789,  861,  883,  861,  857,  833,  862,  862,  862,
			  862,  846,  846,  846,  846,  867,  872,  873,  131,  833,
			  874,  883,  864,  115,  875,  876,  131,  131,  877,  878,
			  883,  848,  865,  883,  849,  850,  851,  857,  833,  862, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  862,  862,  862,  866,  883,  721,  879,  867,  872,  873,
			  131,  833,  862,  862,  862,  862,  875,  876,  131,  131,
			  877,  878,  846,  846,  846,  846,  846,  880,  881,  882,
			  883,  131,  883,  883,  883,  866,  846,  883,  879,   76,
			   76,   76,   76,   76,   76,   76,   80,   80,   80,   80,
			   80,   80,   80,  341,  341,  341,  341,  341,  341,  880,
			  881,  882,  883,  131,   89,   89,   89,   89,   89,   89,
			   89,   91,   91,   91,   91,   91,   91,   91,  883,  883,
			  883,  848,  883,  883,  849,  850,  851,   98,   98,   98,
			   98,   98,   98,   98,  112,  883,  112,  112,  112,  112,

			  112,  141,  141,  141,  141,  141,  141,  141,  236,  883,
			  236,  236,  883,  236,  236,  265,  265,  265,  265,  265,
			  265,  265,  269,  269,  269,  269,  269,  269,  269,  279,
			  279,  279,  279,  279,  279,  279,  114,  883,  114,  114,
			  114,  114,  114,  115,  883,  115,  883,  115,  115,  115,
			  484,  883,  484,  484,  484,  484,  484,  748,  748,  748,
			  748,  748,  748,  748,  819,  883,  819,  819,  819,  819,
			  819,   13,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883, yy_Dummy>>,
			1, 95, 4600)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4694)
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
			yy_chk_template_21 (an_array)
			yy_chk_template_22 (an_array)
			yy_chk_template_23 (an_array)
			yy_chk_template_24 (an_array)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    3,    4,   27,  892,    3,    4,
			   46,    3,    4,    5,    5,    5,    5,   27,    5,    6,
			    6,    6,    6,  871,    6,    9,    9,    9,    9,   34,
			   34,   10,   10,   10,   10,   36,   36,   11,   11,   11,
			   11,  870,   46,   12,   12,   12,   12,   29,   41,   15,
			   15,   15,   15,   11,  890,   29,   49,  890,   41,   12,
			   16,   16,   16,   16,   28,   15,   28,   28,   28,   28,
			   31,    5,   31,   31,   31,   31,   16,    6,   45,   40, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   41,  868,   48,   40,   45,   52,   40,   54,   49,   40,
			   41,   80,   40,   55,   84,   80,  265,   85,   84,   48,
			  265,   85,  851,    5,   88,   96,   96,  849,   88,    6,
			   45,   40,  848,   31,   48,   40,   45,   52,   40,   54,
			   29,   40,   53,    5,   40,   55,    5,    5,    5,    6,
			  785,   48,    6,    6,    6,    9,   53,  115,    9,    9,
			    9,   10,  104,  104,   10,   10,   10,   11,  110,  110,
			   11,   11,   11,   12,   53,  783,   12,   12,   12,   15,
			  174,  781,   15,   15,   15,  263,  263,   86,   53,  115,
			   16,   86,  779,   16,   16,   16,   18,   18,   47,   18,

			   18,  175,   18,  777,   18,   18,  773,   18,   47,   18,
			   47,   42,  174,   42,   47,   88,   18,   85,   18,  177,
			   18,   18,   30,   42,   30,   30,   30,   30,   51,   18,
			   47,  178,  179,  175,   18,   18,   30,   30,   51,  180,
			   47,   51,   47,   42,   18,   42,   47,   18,   18,   44,
			   18,  177,  181,   18,  752,   42,   44,   44,   30,  751,
			   51,   18,   44,  178,  179,   30,   18,   18,   30,   30,
			   51,  180,  749,   51,  269,  748,   18,  708,  269,   18,
			   18,   44,   38,   43,  181,   86,   38,   43,   44,   44,
			   30,   38,  686,   38,   44,  285,  285,  684,   38,   38, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   43,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   18,   18,   18,   21,   38,   43,  153,  683,   38,   43,
			   21,  182,   21,   38,   50,   38,  166,  166,  166,  166,
			   38,   38,   43,  176,   50,  682,  176,  183,  184,   50,
			  294,  294,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  182,  620,  620,   50,   63,   63,   75,
			   75,   75,   75,   75,   75,  176,   50,  166,  176,  183,
			  184,   50,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   66,
			   66,   66,   66,   66,   66,   66,   66,  638,  153,  153,

			  153,  153,  153,  153,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   69,   69,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   73,   73,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   79,   79,   79,   79,  187,   79,  190,
			  624,   79,   87,   79,   79,   79,   87,   81,   81,   81,
			   81,   79,   81,   92,   92,   92,   92,  191,   79,  112,

			   79,  557,  112,   79,   79,   79,   79,  485,   79,  187,
			   79,  190,  117,  483,   79,  117,   79,  192,  482,   79,
			   79,   79,   79,   79,   79,   99,   99,   99,   99,  191,
			  480,  100,  100,  100,  100,  194,  197,  106,  106,  106,
			  106,  116,  372,  118,  116,   81,  118,  199,  116,  192,
			  112,  371,  200,  106,  119,  685,  685,  119,  201,  120,
			  370,  204,  120,  117,  850,  850,  123,  194,  197,  123,
			  768,  768,  120,   87,   87,  369,  368,   81,  121,  199,
			  367,  121,  112,   79,  200,  366,   79,   79,   79,  365,
			  201,  364,  116,  204,  118,  117,  149,   81,  363,  121, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   81,   81,   81,   92,  123,  119,   92,   92,   92,  122,
			  120,  768,  122,  129,  362,  361,  129,  123,  124,  125,
			  130,  124,  125,  130,  116,  126,  118,  360,  126,  121,
			  122,  198,  359,  358,  205,   99,  123,  119,   99,   99,
			   99,  100,  120,  198,  100,  100,  100,  106,  357,  123,
			  106,  106,  106,  114,  114,  124,  114,  114,  125,  114,
			  122,  121,  114,  198,  129,  129,  205,  126,  189,  124,
			  125,  130,  189,  188,  208,  198,  126,  355,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  124,  188,  354,
			  125,  353,  122,  209,  352,  210,  129,  351,  147,  126,

			  189,  124,  125,  130,  189,  188,  208,  304,  126,  207,
			  114,  211,  212,  207,  229,  229,  303,  301,  229,  229,
			  188,  128,  128,  128,  128,  209,  128,  210,  300,  128,
			  131,  131,  131,  131,  299,  131,  139,  127,  131,  139,
			  127,  207,  114,  211,  212,  207,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  127,  128,  133,  128,
			  272,  133,  214,  297,  272,  215,  131,  139,  127,  147,
			  147,  147,  147,  147,  147,  147,  147,  296,  202,  135, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  216,  270,  135,  295,  293,  270,  217,  202,  127,  128,
			  395,  292,  137,  290,  214,  137,  141,  215,  131,  139,
			  127,  289,  287,  139,  139,  139,  139,  139,  139,  133,
			  202,  128,  216,  185,  128,  128,  128,  185,  217,  202,
			  131,  396,  395,  131,  131,  131,  132,  286,  284,  132,
			  135,  185,  157,  157,  157,  157,  244,  244,  244,  244,
			  273,  133,  283,  137,  273,  185,  144,  157,  279,  185,
			  264,  272,  272,  396,  133,  133,  133,  133,  133,  133,
			  133,  133,  135,  185,  262,  261,  135,  135,  135,  135,
			  135,  135,  135,  135,  135,  137,  146,  132,  271,  157,

			  277,  270,  271,  236,  277,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  148,  132,
			  621,  621,  621,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  134,  273,  145,  134,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  144,  144,  144,  144,
			  144,  144,  144,  144,  144,  144,  144,  144,  146,  146,
			  146,  146,  146,  146,  146,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  150,  271,  397,  400,  277, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  402,  134,  356,  356,  356,  356,  151,  111,  109,  108,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  152,  107,  397,
			  400,  105,  402,  134,  403,  103,  102,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  136,  101,   97,  136,  161,   95,
			  161,  161,  161,  161,   94,  162,  403,  162,  162,  162,
			  162,   89,   76,   57,  404,  161,   37,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  151,  151,  151,  151,  151,  151,

			  151,  151,  151,  151,  151,  136,  404,  161,  162,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  152,  152,  152,  288,  288,  288,  288,
			  288,  275,  278,   32,  276,  275,  278,  136,  276,   13,
			  288,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  138,    8,
			    7,  138,    0,  238,  238,  238,  238,  163,  163,  163,
			  163,  238,    0,  164,  164,  164,  164,    0,  163,  163,
			  163,  163,  163,  163,  164,  164,  164,  164,  164,  164,
			  165,  165,  165,  165,  298,  298,  298,  298,  298,  405, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  406,  165,  165,  165,  165,  165,  165,    0,  298,  138,
			  163,  163,  163,  163,  163,  163,  164,  164,  164,  164,
			  164,  164,  275,  278,    0,  276,  276,  276,  276,  276,
			    0,  405,  406,  165,  165,  165,  165,  165,  165,  276,
			  407,  138,  408,    0,    0,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  143,  401,    0,  143,    0,  143,  143,  143,
			    0,    0,  407,  238,  408,  143,  238,  238,  238,    0,
			  401,  195,  143,  195,  143,  195,  213,  143,  143,  143,
			  143,  213,  143,    0,  143,  401,  195,  409,  143,  195,

			  143,  410,  213,  143,  143,  143,  143,  143,  143,  206,
			  412,  206,  401,  195,    0,  195,    0,  195,  213,  206,
			    0,  414,  206,  213,  206,  206,    0,    0,  195,  409,
			    0,  195,  415,  410,  213,    0,  220,  220,  220,  220,
			    0,  206,  412,  206,  302,  302,  302,  302,  302,    0,
			    0,  206,  220,  414,  206,    0,  206,  206,  302,  309,
			    0,    0,  309,    0,  415,    0,    0,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  219,
			  344,  344,  344,  344,  344,  344,  344,  344,    0,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  219,  221,  350,  350,  350,  350,  350,  350,    0,  416,
			  309,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  346,  346,  346,  346,  346,  346,  346,
			  346,  346,  384,    0,  384,    0,  220,  384,  384,  384,
			  384,  416,  309,    0,    0,    0,  220,  220,  220,  220,
			  220,  220,  220,  220,  220,  220,  220,  220,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  224,  224,  224,  224,  224,  224,  224,  224,

			  224,  224,  224,  224,  224,  224,  224,  224,  224,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  227,  227,  227,  227,  227,  227,  227,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  228,  228,  228,  228,  228,  228,  228,  228,  228,  228,
			  228,  228,  228,  228,  228,  228,  228,  230,  230,  230,
			  230,  230,  230,  230,  230,  230,  230,  230,  230,  230,
			  230,  230,  230,  230,  231,  231,  231,  231,  231,  231, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  233,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  233,  233,  233,  233,  233,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  268,
			  268,  268,  268,  418,  268,  281,  281,  281,  281,  419,
			    0,  291,  291,  291,  291,  314,  316,  318,  314,  316,

			  318,  319,  320,  323,  319,  320,  323,    0,  308,  308,
			  308,  308,  420,    0,  321,  418,    0,  321,  322,  326,
			  322,  419,  326,  322,  421,  383,  383,  383,  383,  319,
			  417,  324,  324,  324,  324,  413,  324,  268,    0,  324,
			  383,    0,  320,  417,  420,  323,  314,  316,  318,  413,
			  422,  423,  319,  320,  323,    0,  421,    0,  321,    0,
			    0,  319,  417,    0,  308,  321,    0,  413,    0,  268,
			  326,  322,  383,  327,  320,  417,  327,  323,  314,  316,
			  318,  413,  422,  423,  319,  320,  323,  324,  328,  268,
			  321,  328,  268,  268,  268,  281,  308,  321,  281,  281, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  281,  291,  326,  322,  291,  291,  291,  307,  307,  307,
			  307,  307,  330,  307,  331,  330,  307,  331,  308,  324,
			    0,  308,  308,  308,  327,  348,  348,  348,  348,  348,
			  348,  348,  348,  348,  348,  348,  424,    0,  425,  328,
			  426,  324,  427,  428,  324,  324,  324,  329,    0,  430,
			  329,    0,  387,  431,  387,  432,  327,  387,  387,  387,
			  387,    0,    0,  330,  307,  331,    0,    0,  424,  327,
			  425,  328,  426,    0,  427,  428,  546,  546,  546,  546,
			  333,  430,  328,  333,    0,  431,    0,  432,    0,  388,
			    0,  388,  388,  388,  388,  330,  307,  331,  329,  330,

			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  329,  333,  388,    0,  329,  329,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  375,    0,  393,    0,  393,  393,  393,
			  393,    0,    0,  333,  345,  345,  345,  345,  345,  345,
			  345,  345,  345,  345,  345,  345,  345,  345,  345,  345,
			  345,  547,  547,  547,  547,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  334,  393,    0, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  334,  347,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  347,  347,  347,  347,  347,  347,  349,  349,
			  349,  349,  349,  349,  349,  349,  349,  349,  349,  349,
			  349,  349,  349,  349,  349,  386,  386,  386,  386,  434,
			  394,  394,  394,  394,  433,  435,  436,  433,  334,    0,
			  386,  437,    0,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,    0,    0,  549,    0,  549,
			  439,  434,  549,  549,  549,  549,  433,  435,  436,  433,
			  334,  394,  386,  437,  334,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  334,  334,

			  334,  335,  439,    0,  335,  376,  376,  376,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  376,  376,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  440,
			  441,  442,  443,  444,  445,  446,  447,  448,  449,  450,
			  451,  452,  335,  378,  378,  378,  378,  378,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378,
			    0,  440,  441,  442,  443,  444,  445,  446,  447,  448,
			  449,  450,  451,  452,  335,    0,    0,    0,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  335,  335,  335,  335,  335,  336,    0,    0,  336,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  380,  380,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  380,  456,  456,  456,  456,  456,  456,  456,
			  456,  550,  550,  550,  550,  490,  336,  381,  381,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  381,  381,  381,  454,  454,  454,  454,  454,  454,
			  454,  454,  454,  454,  454,    0,    0,  490,  336,  454,
			  454,  490,  336,  336,  336,  336,  336,  336,  336,  336,

			  336,  336,  336,  336,  336,  336,  336,  336,  336,  337,
			    0,    0,  337,  382,  382,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  382,  382,
			  389,  389,  389,  389,  438,  463,  463,  463,  463,  463,
			  463,  389,  389,  389,  389,  389,  389,  479,  479,  479,
			  479,  479,  438,  481,  481,  481,  481,  481,  489,  560,
			  337,  551,  551,  551,  551,    0,  438,  481,    0,    0,
			    0,  389,    0,  389,  389,  389,  389,  389,  389,    0,
			    0,    0,  487,  488,  438,  644,  644,  644,  644,  479,
			  489,  560,  337,    0,  489,  489,  337,  337,  337,  337, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  338,  487,  488,  338,  524,  524,  524,
			  524,  524,  390,  390,  390,  390,  488,  487,  561,  562,
			  563,    0,    0,  390,  390,  390,  390,  390,  390,  391,
			  391,  391,  391,  548,  548,  548,  548,    0,    0,  564,
			  391,  391,  391,  391,  391,  391,  565,    0,  548,  524,
			  561,  562,  563,  390,  338,  390,  390,  390,  390,  390,
			  390,  459,  459,  459,  459,  459,  459,  459,  459,  459,
			  391,  564,  391,  391,  391,  391,  391,  391,  565,  552,
			  548,  552,  552,  552,  552,    0,  338,    0,  566,  567,

			  338,  338,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  339,    0,  558,
			  339,  558,  558,  558,  558,    0,  392,  392,  392,  392,
			  566,  567,  552,  568,  569,    0,    0,  392,  392,  392,
			  392,  392,  392,  455,  455,  455,  455,  455,  455,  455,
			  455,  455,  455,  455,  455,  455,  455,  455,  455,  455,
			  570,  571,  558,  572,  573,  568,  569,  392,  339,  392,
			  392,  392,  392,  392,  392,  457,  457,  457,  457,  457,
			  457,  457,  457,  457,  457,  457,  457,  457,  457,  457,
			  457,  457,  570,  571,    0,  572,  573,    0,    0,    0, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  339,  574,    0,    0,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  340,    0,    0,  340,  458,  458,  458,  458,  458,
			  458,  458,  458,  574,  458,  458,  458,  458,  458,  458,
			  458,  458,  460,  460,  460,  460,  460,  460,  460,  460,
			  460,  460,  460,  460,  460,  460,  460,  460,  460,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  575,  576,  340,  462,  462,  462,  462,  462,  462,  462,
			  462,  462,  462,  462,  462,  462,  462,  462,  462,  462,
			  646,  646,  646,  646,  647,  647,  647,  647,  721,  721,

			  721,  721,  575,  576,  340,    0,    0,    0,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  464,  464,  464,  464,  464,
			  464,  464,  464,  464,  464,  464,  464,  464,  464,  464,
			  464,  464,  465,  465,  465,  465,  465,  465,  465,  465,
			  465,  465,  465,  465,  465,  465,  465,  465,  465,  466,
			  466,  466,  466,  466,  466,  466,  466,  577,  466,  466,
			  466,  466,  466,  466,  466,  466,  467,  467,  467,  467,
			  467,  467,  467,  467,  467,  467,  467,  467,  467,  467,
			  467,  467,  467,  468,  786,  786,  786,  786,    0,  577, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  469,  718,    0,  718,    0,
			    0,  718,  718,  718,  718,  469,  469,  469,  469,  469,
			  469,  469,  469,  469,  469,  469,  469,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  476,  476,  476,  476,  476,  476,  476,  476,  476,
			  476,  476,  476,  476,  476,  476,  476,  476,  478,  478,
			  478,  478,  478,  486,  486,  486,  486,    0,  495,    0,

			  495,  478,  478,  495,    0,  496,  497,  498,  496,  497,
			  498,  500,  502,  505,  500,  502,  505,  559,  578,  559,
			  559,  559,  559,  478,    0,    0,  503,  579,  504,  503,
			  478,  504,    0,  478,  478,  580,  498,  545,  545,  545,
			  545,  496,  582,  583,  584,    0,    0,    0,  585,  486,
			  578,  495,  545,  586,  587,  478,  496,  497,  498,  579,
			  559,  588,  500,  502,  505,  590,  593,  580,  498,  596,
			  597,    0,  598,  496,  582,  583,  584,  503,  545,  504,
			  585,  486,    0,  495,  545,  586,  587,  599,  496,  497,
			  498,    0,  600,  588,  500,  502,  505,  590,  593,  502, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  505,  596,  597,  486,  598,    0,  486,  486,  486,  503,
			    0,  504,    0,  503,  503,  503,  503,  503,    0,  599,
			    0,    0,    0,  504,  600,    0,    0,  503,  508,    0,
			    0,  508,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  512,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  512,  601,  602,  603,  604,
			  605,  606,  607,  609,  612,  613,  614,  615,  616,  508,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,    0,  601,  602,

			  603,  604,  605,  606,  607,  609,  612,  613,  614,  615,
			  616,  508,    0,    0,    0,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  509,    0,    0,  509,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  623,  623,  623,  623,  625,  650,  628,  642,  642,  642,
			  642,  653,  654,  509,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  516,  787,  787,  787,  787,  655,  625,  650,  628,    0,
			  625,  623,  628,  653,  654,  509,    0,    0,  642,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  510,  655,    0,  510,
			  517,  517,  517,  517,  517,  517,  517,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  517,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,    0,  523,  523,  523,  523,  523,
			  658,  660,  659,  662,  663,    0,  659,  510,  523,  523,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,

			  543,  543,  543,  543,  543,  543,  543,    0,  664,  665,
			  523,    0,  658,  660,  659,  662,  663,  523,  659,  510,
			  523,  523,    0,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  664,  665,  523,  544,  544,  544,  544,  544,  544,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  544,  544,
			  553,  553,  553,  553,  666,  594,  594,  594,  594,    0,
			  594,  553,  553,  553,  553,  553,  553,  554,  554,  554,
			  554,  594,  667,  643,  643,  643,  643,  627,  554,  554,
			  554,  554,  554,  554,    0,    0,  666,    0,  643,    0, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  553,  668,  553,  553,  553,  553,  553,  553,  792,
			  792,  792,  792,    0,  667,  670,  671,    0,  554,  627,
			  554,  554,  554,  554,  554,  554,  555,  555,  555,  555,
			  643,  627,  629,    0,  668,  629,  672,  555,  555,  555,
			  555,  555,  555,  556,  556,  556,  556,  670,  671,  622,
			  622,  622,  622,  594,  556,  556,  556,  556,  556,  556,
			  622,  622,  622,  622,  622,  622,  626,  555,  672,  555,
			  555,  555,  555,  555,  555,  594,  629,    0,  594,  594,
			  594,    0,  633,  629,  556,  633,  556,  556,  556,  556,
			  556,  556,  622,  622,  622,  622,  622,  622,  626,  673,

			  675,    0,  626,  626,  626,  626,  626,  631,  629,  649,
			  631,  649,  649,  649,  649,  629,  626,  676,  633,  677,
			    0,  679,  687,  639,  639,  639,  639,  688,  689,  690,
			  691,  673,  675,  633,  639,  639,  639,  639,  639,  639,
			  631,  750,  750,  750,  750,  750,    0,    0,    0,  676,
			  633,  677,  649,  679,  687,  750,    0,    0,  631,  688,
			  689,  690,  691,    0,    0,  633,  639,  639,  639,  639,
			  639,  639,  631,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  631,  636,  636,  636,  636,  636,  636,  636,  636,  636, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  636,  636,  636,  636,  636,  636,  636,  636,  637,  637,
			  637,  637,  637,  637,  637,  637,  637,  637,  637,  637,
			  637,  637,  637,  637,  637,  640,  640,  640,  640,  692,
			  693,  641,  641,  641,  641,  694,  640,  640,  640,  640,
			  640,  640,  641,  641,  641,  641,  641,  641,  645,  645,
			  645,  645,    0,    0,  695,  697,  698,    0,  701,    0,
			    0,  692,  693,  645,    0,    0,  702,  694,  640,  640,
			  640,  640,  640,  640,  641,  641,  641,  641,  641,  641,
			  648,  704,  648,  648,  648,  648,  695,  697,  698,  645,
			  701,  680,  680,  680,  680,  645,  680,  648,  702,  705,

			  705,  705,  706,  706,  706,  706,  726,  680,  707,  707,
			  707,  707,  707,  704,  709,  711,  710,  709,  711,  710,
			  707,  707,  707,  707,  707,  707,    0,  727,    0,  648,
			    0,  717,  717,  717,  717,  717,    0,    0,  726,    0,
			    0,  705,  728,    0,  706,  710,  709,    0,    0,    0,
			  707,    0,  707,  707,  707,  707,  707,  707,  711,  727,
			  719,  719,  719,  719,  730,  709,  711,  710,  713,  713,
			  713,  713,  713,  717,  728,  719,  731,  710,  709,  680,
			  713,  713,  713,  713,  713,  713,  722,    0,  722,    0,
			  711,  722,  722,  722,  722,    0,  730,  709,  711,  710, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  680,    0,    0,  680,  680,  680,  719,  731,    0,
			  713,  732,  713,  713,  713,  713,  713,  713,  714,  714,
			  714,  714,  714,  733,  736,  738,  720,  720,  720,  720,
			  714,  714,  714,  714,  714,  714,  715,  715,  715,  715,
			  715,  720,  723,  732,  723,  723,  723,  723,  715,  715,
			  715,  715,  715,  715,    0,  733,  736,  738,    0,  723,
			  714,  739,  714,  714,  714,  714,  714,  714,  793,  793,
			  793,  793,  741,  720,  742,  743,  744,  745,  715,  746,
			  715,  715,  715,  715,  715,  715,  716,  716,  716,  716,
			  716,  723,  753,  739,  754,  756,    0,  757,  716,  716,

			  716,  716,  716,  716,  741,  759,  742,  743,  744,  745,
			  763,  746,  764,  766,  770,  770,  770,  774,  775,  776,
			  774,  775,  776,    0,  753,    0,  754,  756,  716,  757,
			  716,  716,  716,  716,  716,  716,    0,  759,  772,  772,
			  772,  772,  763,    0,  764,  766,  774,    0,  776,  772,
			  772,  772,  772,  772,  772,  770,  788,  788,  788,  788,
			  795,  775,  828,  828,  828,  828,  796,  798,  774,  775,
			  776,  788,  791,  791,  791,  791,    0,    0,  774,  772,
			  776,  772,  772,  772,  772,  772,  772,  791,  800,  801,
			    0,    0,  795,  775,  778,  778,  778,  778,  796,  798, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  774,  775,  776,  788,  802,  778,  778,  778,  778,  778,
			  778,  780,  780,  780,  780,  803,    0,    0,    0,  791,
			  800,  801,  780,  780,  780,  780,  780,  780,  829,  829,
			  829,  829,  806,  809,  810,  778,  802,  778,  778,  778,
			  778,  778,  778,  789,    0,  789,    0,  803,  789,  789,
			  789,  789,  780,  812,  780,  780,  780,  780,  780,  780,
			  782,  782,  782,  782,  806,  809,  810,  813,  814,    0,
			  816,  782,  782,  782,  782,  782,  782,  784,  784,  784,
			  784,  811,  811,  811,  811,  812,    0,  817,  784,  784,
			  784,  784,  784,  784,  830,  830,  830,  830,    0,  813,

			  814,  782,  816,  782,  782,  782,  782,  782,  782,  790,
			    0,  790,  837,  811,  790,  790,  790,  790,  784,  817,
			  784,  784,  784,  784,  784,  784,  794,  820,  794,  827,
			  820,  794,  794,  794,  794,  821,  822,    0,  821,  822,
			  831,  831,  831,  831,  837,  811,  834,  834,  834,  834,
			  840,  832,  832,  832,  832,  827,  835,  835,  835,  835,
			  844,  827,  833,    0,  833,  820,  832,  833,  833,  833,
			  833,  846,  846,  846,  846,  847,  852,  854,  820,  860,
			  857,    0,  840,  857,  864,  866,  821,  822,  867,  876,
			    0,  811,  844,    0,  811,  811,  811,  820,  832,  861, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  861,  861,  861,  846,    0,  860,  877,  847,  852,  854,
			  820,  860,  862,  862,  862,  862,  864,  866,  821,  822,
			  867,  876,  869,  869,  869,  869,  869,  878,  879,  880,
			    0,  857,    0,    0,    0,  846,  869,    0,  877,  884,
			  884,  884,  884,  884,  884,  884,  885,  885,  885,  885,
			  885,  885,  885,  899,  899,  899,  899,  899,  899,  878,
			  879,  880,    0,  857,  886,  886,  886,  886,  886,  886,
			  886,  887,  887,  887,  887,  887,  887,  887,    0,    0,
			    0,  846,    0,    0,  846,  846,  846,  888,  888,  888,
			  888,  888,  888,  888,  889,    0,  889,  889,  889,  889,

			  889,  891,  891,  891,  891,  891,  891,  891,  893,    0,
			  893,  893,    0,  893,  893,  894,  894,  894,  894,  894,
			  894,  894,  895,  895,  895,  895,  895,  895,  895,  896,
			  896,  896,  896,  896,  896,  896,  897,    0,  897,  897,
			  897,  897,  897,  898,    0,  898,    0,  898,  898,  898,
			  900,    0,  900,  900,  900,  900,  900,  901,  901,  901,
			  901,  901,  901,  901,  902,    0,  902,  902,  902,  902,
			  902,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883, yy_Dummy>>,
			1, 95, 4600)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 902)
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
			    0,    0,    0,  121,  122,  131,  137, 1357, 1356,  143,
			  149,  155,  161, 1339, 4571,  167,  178, 4571,  289,    0,
			 4571,  410, 4571, 4571, 4571, 4571, 4571,  108,  165,  147,
			  303,  171, 1305, 4571,  122, 4571,  127, 1248,  348,    0,
			  160,  132,  268,  351,  312,  158,   84,  265,  170,  140,
			  388,  289,  160,  210,  168,  167, 4571, 1214, 4571, 4571,
			 4571, 4571, 4571,  348,  378,  440,  386,  457,  474,  491,
			  508,  525,  534,  545,  562,  365, 1265, 4571, 4571,  671,
			  208,  685, 4571, 4571,  211,  214,  284,  679,  221, 1268,
			 4571, 4571,  691, 4571, 1161, 1158,  131, 1162, 4571,  723,

			  729, 1237, 1133, 1134,  168, 1137,  735, 1210, 1106, 1107,
			  174, 1113,  692, 4571,  852,  199,  734,  705,  736,  747,
			  752,  771,  802,  759,  811,  812,  818,  930,  919,  806,
			  813,  928, 1039,  971, 1143,  992, 1247, 1005, 1351,  929,
			    0, 1004, 1042, 1455, 1054, 1140, 1084,  886, 1116,  784,
			 1183, 1194, 1215,  404, 4571, 4571, 4571, 1031, 4571, 4571,
			 4571, 1239, 1246, 1346, 1352, 1369,  405, 4571, 4571, 4571,
			 4571, 4571, 4571,    0,  231,  265,  393,  284,  281,  281,
			  303,  320,  376,  401,  389, 1000,    0,  627,  838,  821,
			  636,  665,  671,    0,  688, 1446,    0,  694,  797,  696, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  702,  723,  964,    0,  712,  798, 1474,  866,  830,  844,
			  859,  859,  865, 1451,  933,  945,  964,  957, 4571, 1477,
			 1534, 1499, 1564, 1581, 1598, 1615, 1632, 1649, 1666,  809,
			 1683, 1700, 1717, 1734, 1751, 1768, 1096, 4571, 1361, 4571,
			 4571, 4571, 4571, 4571, 1035, 4571, 4571, 4571, 4571, 4571,
			 4571, 4571, 4571, 4571, 4571, 4571, 4571, 4571, 4571, 4571,
			 4571,  982,  983,  191,  976,  213, 4571, 4571, 1877,  371,
			  998, 1095,  977, 1057, 4571, 1328, 1331, 1097, 1329, 1065,
			 4571, 1883, 4571,  959,  947,  301,  953,  928, 1232,  919,
			  919, 1889,  908,  903,  346,  909,  989,  889, 1300,  832,

			  834,  823, 1450,  814,  813, 4571, 4571, 2006, 1906, 1552,
			 4571, 4571, 4571, 4571, 1888, 4571, 1889, 4571, 1890, 1894,
			 1895, 1907, 1913, 1896, 1929, 4571, 1912, 1966, 1981, 2040,
			 2005, 2007, 4571, 2073, 2190, 2294, 2398, 2502, 2606, 2710,
			 2814, 4571, 4571, 2042, 1477, 2070, 1529, 2107, 1925, 2124,
			 1508,  885,  882,  879,  877,  865, 1181,  836,  821,  820,
			  815,  803,  802,  786,  779,  777,  773,  768,  764,  763,
			  748,  739,  730, 4571, 4571, 2141, 2211, 2228, 2259, 2315,
			 2332, 2363, 2419, 1904, 1616, 4571, 2214, 2036, 2070, 2509,
			 2601, 2618, 2705, 2136, 2219,  964,  996, 1165,    0,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1158, 1431, 1166, 1184, 1221, 1367, 1351, 1388, 1406, 1465,
			 1465,    0, 1458, 1903, 1485, 1482, 1558, 1886, 1840, 1853,
			 1872, 1888, 1903, 1919, 2000, 2006, 1993, 2006, 1997,    0,
			 2013, 1997, 2004, 2210, 2203, 2209, 2214, 2199, 2500, 2221,
			 2303, 2308, 2305, 2302, 2298, 2308, 2302, 2310, 2299, 2308,
			 2309, 2315, 2306,    0, 2380, 2649, 2340, 2681, 2731, 2577,
			 2748, 2759, 2779, 2441, 2831, 2848, 2865, 2882, 2891, 2913,
			 4571, 4571, 4571, 4571, 2943, 2960, 2977, 4571, 3068, 2527,
			  636, 2459,  616,  619,    0,  632, 3091, 2524, 2525, 2500,
			 2397, 4571, 4571, 4571, 4571, 3093, 3098, 3099, 3100, 4571,

			 3104, 4571, 3105, 3119, 3121, 3106, 4571, 4571, 3221, 3325,
			 3429, 3138, 3155, 3186, 3242, 3259, 3290, 3346, 4571, 4571,
			 4571, 4571, 4571, 3455, 2597, 4571, 4571, 4571, 4571, 4571,
			 4571, 4571, 4571, 4571, 4571, 4571, 4571, 4571, 4571, 4571,
			 4571, 4571, 3363, 3396, 3449, 3116, 2055, 2160, 2622, 2251,
			 2430, 2540, 2670, 3539, 3556, 3605, 3622,  682, 2700, 3098,
			 2509, 2577, 2579, 2592, 2615, 2616, 2656, 2649, 2697, 2683,
			 2724, 2723, 2714, 2730, 2761, 2821, 2826, 2918, 3069, 3091,
			 3083,    0, 3106, 3103, 3089, 3093, 3104, 3118, 3112,    0,
			 3122,    0,    0, 3123, 3563,    0, 3129, 3118, 3132, 3150, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3143, 3222, 3227, 3216, 3226, 3214, 3237, 3223,    0, 3226,
			    0,    0, 3238, 3238, 3224, 3234, 3246,    0,    0, 4571,
			  433, 1109, 3628, 3349,  608, 3316, 3608, 3529, 3318, 3625,
			 4571, 3700, 4571, 3675, 4571, 3679, 3697, 3714,  485, 3702,
			 3804, 3810, 3356, 3562, 2564, 3827, 2869, 2873, 3861, 3690,
			 3325,    0,    0, 3336, 3343, 3372,    0,    0, 3431, 3446,
			 3436,    0, 3434, 3445, 3471, 3473, 3529, 3531, 3557,    0,
			 3566, 3571, 3600, 3659,    0, 3660, 3683, 3679,    0, 3685,
			 3889, 4571,  417,  314,  296,  661,  298, 3690, 3678, 3673,
			 3689, 3694, 3793, 3781, 3799, 3803,    0, 3804, 3824,    0,

			    0, 3818, 3830,    0, 3836, 3879, 3882, 3888,  300, 3907,
			 3909, 3908, 4571, 3948, 3998, 4016, 4066, 3911, 3000, 3939,
			 4005, 2877, 3970, 4023,    0,    0, 3870, 3875, 3891,    0,
			 3918, 3925, 3975, 3991,    0,    0, 3988,    0, 3993, 4025,
			    0, 4022, 4029, 4024, 4025, 4045, 4028, 4571,  372,  278,
			 3647,  257,  260, 4049, 4044,    0, 4050, 4052,    0, 4069,
			    0,    0,    0, 4059, 4067,    0, 4062, 4571,  749, 4571,
			 4093, 4571, 4117,  238, 4110, 4111, 4112,  291, 4173,  280,
			 4190,  269, 4239,  263, 4256,  238, 2973, 3380, 4135, 4227,
			 4293, 4151, 3588, 4047, 4310, 4125, 4115,    0, 4122,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 4153, 4156, 4169, 4172,    0,    0, 4194,    0,    0, 4188,
			 4198, 4279, 4207, 4231, 4234,    0, 4234, 4251,    0,    0,
			 4320, 4328, 4329, 4571, 4571, 4571, 4571, 4293, 4141, 4207,
			 4273, 4319, 4330, 4346, 4325, 4335,    0, 4276,    0,    0,
			 4307,    0,    0,    0, 4309,    0, 4369, 4332,  129,  126,
			  670,  128, 4327,    0, 4341,    0,    0, 4373, 4571, 4571,
			 4343, 4378, 4391,    0, 4348,    0, 4342, 4356,  107, 4328,
			   59,   49,    0,    0, 4571,    0, 4357, 4356, 4377, 4378,
			 4379,    0, 4571, 4571, 4438, 4445, 4463, 4470, 4486, 4493,
			  171, 4500,  121, 4507, 4514, 4521, 4528, 4535, 4542, 4452,

			 4549, 4556, 4563, yy_Dummy>>,
			1, 103, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 902)
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
			    0,  883,    1,  884,  884,  885,  885,  886,  886,  887,
			  887,  888,  888,  883,  883,  883,  883,  883,  889,  890,
			  883,  891,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  893,  883,  883,  883,
			  894,  894,  883,  883,  895,  894,  894,  894,  894,  896,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,

			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  889,  883,  897,  898,  889,  889,  889,  889,
			  889,  889,  889,  889,  889,  889,  889,  889,  889,  889,
			  889,  889,  889,  889,  889,  889,  889,  889,  889,  889,
			  890,  899,  899,  899,  899,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  893,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  894,  883,  883,  894,  895,
			  894,  894,  894,  894,  883,  894,  894,  894,  894,  896,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  900,  883,  883,  883,

			  883,  883,  883,  883,  883,  883,  883,  897,  898,  889,
			  883,  883,  883,  883,  889,  883,  889,  883,  889,  889,
			  889,  889,  889,  889,  889,  883,  889,  889,  889,  889,
			  889,  889,  883,  889,  889,  889,  889,  889,  889,  889,
			  889,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  899,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  892,  892,  892,  892,  892, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  900,  900,  898,  898,  898,  898,
			  898,  883,  883,  883,  883,  889,  889,  889,  889,  883,

			  889,  883,  889,  889,  889,  889,  883,  883,  889,  889,
			  889,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  883,
			  883,  883,  883,  883,  900,  898,  898,  898,  898,  889,
			  883,  889,  883,  889,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  883,  883,  883,  883,  883,  883,  883,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,

			  892,  892,  892,  892,  892,  883,  883,  883,  900,  889,
			  889,  889,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  883,  901,  883,
			  883,  883,  883,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  883,  883,  883,
			  883,  883,  883,  900,  889,  889,  889,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  892,  892,  892,  892,  892, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  902,
			  889,  889,  889,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  883,  892,  883,  883,
			  883,  883,  892,  892,  892,  892,  892,  889,  883,  883,
			  883,  883,  883,  892,  892,  892,  883,  892,  883,  883,
			  883,  883,  892,  892,  883,  892,  883,  892,  883,  892,
			  883,  892,  883,    0,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,

			  883,  883,  883, yy_Dummy>>,
			1, 103, 800)
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
			   96,   97,   96,   96,   96,   96,   98,   96,   96,   99,
			   99,   99,   99,   99,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  101,  100,  100,  100,  100,  102,
			  103,  104,  104,  104,  104,  104,  105,  106,  107,  107,
			  107,  107,  107,  107,  107,  108,  104,  104,  109,  110,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  111,  111,  112,  113,  113,  113,  113,  113, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  114,  115,  116,  117,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  119,  120,  120,
			  121,  122,  122,  122,  123,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    1,    3,    4,    3,    3,
			    5,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    6,    6,    6,    6,    3,    3,    3,    3,    3,
			    3,    3,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    3,    3,
			    3,    3,    6,    3,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    3,    3,    3,    3,    7,    7,    7,    7,    7,    7,

			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 884)
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
			  499,  500,  501,  502,  503,  504,  505,  506,  508,  509,
			  511,  512,  513,  514,  515,  516,  517,  518,  519,  520,
			  521,  522,  523,  524,  525,  526,  527,  528,  529,  530,
			  531,  532,  533,  534,  536,  536,  536,  536,  536,  536,
			  536,  536,  536,  536,  536,  536,  536,  536,  536,  538,
			  540,  541,  542,  543,  544,  544,  544,  544,  545,  545,
			  545,  545,  545,  545,  545,  546,  547,  547,  547,  547,
			  547,  547,  549,  551,  553,  555,  556,  557,  558,  559,

			  561,  562,  564,  565,  566,  567,  568,  570,  572,  573,
			  574,  575,  575,  575,  575,  575,  575,  575,  575,  576,
			  577,  578,  579,  580,  581,  582,  583,  584,  585,  586,
			  587,  588,  589,  590,  591,  592,  593,  594,  595,  596,
			  597,  598,  600,  600,  600,  600,  601,  601,  602,  603,
			  603,  603,  604,  605,  605,  605,  605,  605,  605,  606,
			  607,  608,  609,  610,  611,  612,  613,  614,  615,  616,
			  617,  618,  619,  620,  621,  623,  624,  625,  626,  627,
			  628,  629,  631,  632,  633,  634,  635,  636,  637,  638,
			  640,  641,  643,  645,  646,  648,  650,  651,  652,  653, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  654,  655,  656,  657,  658,  659,  660,  661,  662,  664,
			  665,  667,  669,  670,  671,  672,  673,  674,  676,  678,
			  679,  679,  679,  679,  679,  680,  680,  680,  680,  680,
			  681,  683,  684,  686,  687,  689,  689,  689,  689,  690,
			  690,  690,  690,  690,  691,  691,  692,  692,  693,  694,
			  695,  696,  698,  700,  701,  702,  703,  705,  707,  708,
			  709,  710,  712,  713,  714,  715,  716,  717,  718,  719,
			  721,  722,  723,  724,  725,  727,  728,  729,  730,  732,
			  733,  733,  734,  734,  734,  734,  734,  734,  735,  736,
			  737,  738,  739,  740,  741,  742,  743,  745,  746,  747,

			  749,  751,  752,  753,  755,  756,  756,  756,  756,  757,
			  758,  759,  760,  761,  761,  761,  761,  761,  761,  761,
			  762,  763,  763,  763,  764,  766,  768,  769,  770,  771,
			  773,  774,  775,  776,  777,  779,  781,  782,  784,  785,
			  786,  788,  789,  790,  791,  792,  793,  794,  795,  795,
			  795,  795,  795,  795,  796,  797,  799,  800,  801,  803,
			  804,  806,  808,  810,  811,  812,  814,  815,  816,  816,
			  817,  817,  818,  818,  819,  820,  821,  822,  822,  822,
			  822,  822,  822,  822,  822,  822,  822,  822,  823,  824,
			  824,  824,  825,  825,  826,  826,  827,  828,  830,  831, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  833,  834,  835,  836,  837,  839,  841,  842,  844,  846,
			  847,  848,  849,  850,  851,  852,  854,  855,  856,  858,
			  860,  861,  862,  863,  865,  866,  868,  869,  870,  870,
			  871,  871,  872,  873,  873,  873,  874,  876,  877,  879,
			  881,  882,  884,  886,  888,  889,  891,  891,  892,  892,
			  892,  892,  892,  893,  895,  896,  898,  900,  901,  903,
			  905,  906,  906,  907,  909,  910,  912,  912,  913,  913,
			  913,  913,  913,  915,  917,  919,  921,  921,  922,  922,
			  923,  923,  925,  926,  926, yy_Dummy>>,
			1, 85, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 925)
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
			    0,  193,  193,  195,  195,  229,  227,  228,    1,  227,
			  228,    1,  228,   36,  227,  228,  196,  227,  228,   48,
			  227,  228,   14,  227,  228,  161,  227,  228,   24,  227,
			  228,   25,  227,  228,   32,  227,  228,   30,  227,  228,
			    9,  227,  228,   31,  227,  228,   13,  227,  228,   33,
			  227,  228,  125,  227,  228,  125,  227,  228,    8,  227,
			  228,    7,  227,  228,   18,  227,  228,   17,  227,  228,
			   19,  227,  228,   11,  227,  228,  124,  227,  228,  124,
			  227,  228,  124,  227,  228,  124,  227,  228,  124,  227,
			  228,  124,  227,  228,  124,  227,  228,  124,  227,  228,

			  124,  227,  228,  124,  227,  228,  124,  227,  228,  124,
			  227,  228,  124,  227,  228,  124,  227,  228,  124,  227,
			  228,  124,  227,  228,  124,  227,  228,  124,  227,  228,
			   28,  227,  228,  227,  228,   29,  227,  228,   34,  227,
			  228,   26,  227,  228,   27,  227,  228,   12,  227,  228,
			  227,  228,  227,  228,  227,  228,  227,  228,  227,  228,
			  227,  228,  227,  228,  227,  228,  227,  228,  227,  228,
			  227,  228,  227,  228,  227,  228,  197,  228,  226,  228,
			  224,  228,  225,  228,  193,  228,  193,  228,  192,  228,
			  191,  228,  193,  228,  193,  228,  193,  228,  193,  228, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  193,  228,  195,  228,  194,  228,  189,  228,  189,  228,
			  188,  228,  189,  228,  189,  228,  189,  228,  189,  228,
			    6,  228,    5,    6,  228,    5,  228,    6,  228,    6,
			  228,    6,  228,    6,  228,    6,  228,    1,  196,  185,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196, -415,  196,  196,  196, -415,  196,
			  196,  196,  196,  196,  196,  196,  196,   48,  161,  161,
			  161,  161,    2,   35,   10,  131,   39,   23,   22,  131,
			  125,   15,   37,   20,   21,   38,   16,  124,  124,  124,
			  124,  124,   55,  124,  124,  124,  124,  124,  124,  124,

			  124,   68,  124,  124,  124,  124,  124,  124,  124,   80,
			  124,  124,  124,   87,  124,  124,  124,  124,  124,  124,
			  124,   99,  124,  124,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,   40,   49,    1,
			   49,   43,   49,  197,  224,  214,  212,  213,  215,  216,
			  217,  218,  198,  199,  200,  201,  202,  203,  204,  205,
			  206,  207,  208,  209,  210,  211,  193,  192,  191,  193,
			  193,  193,  193,  193,  193,  190,  191,  193,  193,  193,
			  193,  195,  194,  188,    5,    4,  186,  183,  186,  196,
			 -415, -415,  196,  169,  186,  167,  186,  168,  186,  170, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  186,  196,  163,  186,  196,  164,  186,  196,  196,  196,
			  196,  196,  196,  196, -187,  196,  196,  196,  196,  196,
			  196,  171,  186,  196,  196,  196,  196,  196,  196,  196,
			  196,  161,  132,  161,  161,  161,  161,  161,  161,  161,
			  161,  161,  161,  161,  161,  161,  161,  161,  161,  161,
			  161,  161,  161,  161,  161,  161,  134,  161,  132,  161,
			  131,  126,  131,  125,  129,  130,  130,  128,  130,  127,
			  125,  124,  124,  124,   53,  124,   54,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,   71,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,  124,

			  124,  124,  124,  124,  124,  124,   91,  124,  124,   94,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  123,  124,   41,   49,   42,   49,
			   46,   47,   45,   44,  223,    4,    4,  175,  186,  172,
			  186,  165,  186,  166,  186,  196,  196,  196,  196,  180,
			  186,  196,  174,  186,  196,  196,  196,  196,  173,  186,
			  184,  186,  196,  196,  196,  151,  149,  150,  152,  153,
			  162,  162,  154,  155,  135,  136,  137,  138,  139,  140,
			  141,  142,  143,  144,  145,  146,  147,  148,  133,  161, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  131,  131,  131,  131,  125,  125,  125,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
			  124,   69,  124,  124,  124,  124,  124,  124,  124,   78,
			  124,  124,  124,  124,  124,  124,  124,  124,   88,  124,
			  124,   90,  124,   92,  124,  124,   97,  124,   98,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
			  124,  124,  112,  124,  124,  114,  124,  115,  124,  124,
			  124,  124,  124,  124,  121,  124,  122,  124,  219,    4,
			  196,  176,  186,  196,  179,  186,  196,  182,  186,  162,
			  131,  131,  131,  131,  125,  124,   51,  124,   52,  124,

			  124,  124,  124,   59,  124,   60,  124,  124,  124,  124,
			   65,  124,  124,  124,  124,  124,  124,  124,  124,   76,
			  124,  124,  124,  124,  124,   83,  124,  124,  124,  124,
			   89,  124,  124,   95,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  109,  124,  124,  124,  113,  124,  116,
			  124,  124,  124,  119,  124,  124,    4,  196,  196,  196,
			  156,  131,  131,  131,   50,  124,   56,  124,  124,  124,
			  124,   62,  124,  124,  124,  124,  124,   70,  124,   72,
			  124,  124,   74,  124,  124,  124,   79,  124,  124,  124,
			  124,  124,  124,  124,   96,  124,  124,  102,  124,  124, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  124,  105,  124,  124,  107,  124,  108,  124,  110,  124,
			  124,  124,  118,  124,  124,  222,  221,  220,    4,  196,
			  196,  196,  131,  131,  131,  131,  124,  124,   61,  124,
			  124,   64,  124,  124,  124,  124,  124,   77,  124,   81,
			  124,  124,   84,  124,   85,  124,  124,  124,  124,  124,
			  124,  124,  106,  124,  124,  124,  120,  124,    3,    4,
			  196,  196,  196,  159,  160,  160,  158,  160,  157,  131,
			  131,  131,  131,  131,   57,  124,  124,   63,  124,   66,
			  124,  124,   73,  124,   75,  124,   82,  124,  124,   93,
			  124,  124,  124,  103,  124,  124,  111,  124,  117,  124,

			  196,  178,  186,  181,  186,  131,  131,   58,  124,  124,
			   86,  124,  124,  101,  124,  104,  124,  177,  186,   67,
			  124,  124,  124,  100,  124,  100, yy_Dummy>>,
			1, 126, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 4571
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 883
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 884
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

	yyNb_rules: INTEGER = 228
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 229
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
