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
			create an_array.make_filled (0, 0, 4692)
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
			  703,  240,  266,  241,  242,  243,  267,  268,  266,  268,
			  268,  244,  267,  281,  282,  281,  281,  416,  245,  305,

			  246,  385,  115,  247,  248,  249,  250,  621,  251,  410,
			  252,  415,  310,  238,  253,  115,  254,  417,  238,  255,
			  256,  257,  258,  259,  260,  291,  291,  291,  291,  416,
			  238,  291,  291,  291,  291,  418,  423,  106,  106,  106,
			  106,  305,  539,  311,  115,  269,  115,  426,  309,  417,
			  131,  538,  427,  107,  312,  745,  746,  115,  428,  313,
			  537,  431,  115,  131,  863,  864,  305,  418,  423,  115,
			  700,  700,  314,  276,  277,  536,  535,  269,  315,  426,
			  534,  115,  131,  261,  427,  533,  262,  263,  264,  532,
			  428,  531,  131,  431,  131,  131,  374,  270,  530,  316, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  271,  272,  273,  283,  319,  131,  284,  285,  286,  317,
			  131,  762,  115,  305,  529,  528,  115,  131,  305,  305,
			  332,  115,  115,  115,  131,  305,  131,  527,  115,  131,
			  318,  424,  526,  525,  432,  292,  319,  131,  293,  294,
			  295,  292,  131,  425,  293,  294,  295,  108,  524,  131,
			  109,  110,  111,  112,  112,  320,  112,  112,  321,  306,
			  131,  131,  115,  424,  131,  331,  432,  322,  413,  131,
			  131,  131,  414,  411,  441,  425,  131,  521,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  320,  412,  520,
			  321,  519,  131,  442,  518,  443,  131,  517,  374,  322,

			  413,  131,  131,  131,  414,  411,  441,  106,  131,  439,
			  307,  444,  445,  440,  469,  470,  106,  106,  471,  472,
			  412,  324,  325,  324,  324,  442,  305,  443,  291,  115,
			  324,  325,  324,  324,  291,  305,  305,  305,  115,  115,
			  115,  439,  307,  444,  445,  440,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  323,  131,  305,  326,
			  266,  115,  449,  291,  267,  450,  131,  131,  131,  376,
			  376,  376,  376,  376,  376,  376,  376,  484,  429,  305, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  451,  266,  115,  300,  297,  267,  452,  430,  323,  131,
			  559,  291,  305,  281,  449,  115,  342,  450,  131,  131,
			  131,  281,  281,  340,  340,  340,  340,  340,  340,  131,
			  429,  327,  451,  407,  328,  329,  330,  408,  452,  430,
			  327,  560,  559,  328,  329,  330,  305,  290,  287,  115,
			  131,  409,  383,  383,  383,  383,  477,  478,  478,  478,
			  266,  131,  281,  131,  267,  407,  373,  384,  280,  408,
			  482,  276,  277,  560,  334,  334,  334,  334,  334,  334,
			  334,  334,  131,  409,  479,  238,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  131,  374,  131,  266,  384,

			  266,  268,  267,  237,  267,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  343,  343,  344,  345,
			  345,  345,  345,  346,  347,  348,  349,  350,  374,  131,
			  701,  701,  701,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  305,  278,  374,  115,  343,  343,  344,  345,  345,  345,
			  345,  346,  347,  348,  349,  350,  343,  343,  344,  345,
			  345,  345,  345,  346,  347,  348,  349,  350,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  374,  275,  561,  562,  268, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  565,  131,  522,  523,  523,  523,  374,  304,  301,  106,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  374,  154,  561,
			  562,  300,  565,  131,  566,  297,  291,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  305,  296,  290,  115,  385,  287,
			  386,  386,  386,  386,  281,  161,  566,  388,  388,  388,
			  388,  280,  237,  218,  567,  387,  172,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  379,  380,  380,  380,  380,  380,  380,

			  380,  380,  380,  380,  380,  131,  567,  387,  166,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  381,  381,  381,  381,  381,  281,  281,  281,  281,
			  281,  266,  266,  167,  266,  267,  267,  131,  267,  877,
			  281,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  305,   90,
			   90,  115,  877,  238,  238,  238,  238,  389,  389,  390,
			  390,  476,  877,  391,  391,  391,  390,  877,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  392,  392,  392,  392,  291,  291,  291,  291,  291,  568, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  569,  392,  392,  392,  392,  392,  392,  877,  291,  131,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  268,  268,  877,  268,  268,  268,  268,  268,
			  877,  568,  569,  392,  392,  392,  392,  392,  392,  268,
			  570,  131,  571,  877,  877,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  351,  563,  877,  352,  877,  353,  354,  355,
			  877,  877,  570,  261,  571,  356,  262,  263,  264,  877,
			  564,  419,  357,  572,  358,  420,  446,  359,  360,  361,
			  362,  447,  363,  877,  364,  563,  421,  573,  365,  422,

			  366,  574,  448,  367,  368,  369,  370,  371,  372,  433,
			  577,  434,  564,  419,  877,  572,  877,  420,  446,  435,
			  877,  578,  436,  447,  437,  438,  877,  877,  421,  573,
			  877,  422,  579,  574,  448,  877,  106,  106,  106,  106,
			  877,  433,  577,  434,  106,  106,  106,  106,  106,  877,
			  877,  435,  107,  578,  436,  877,  437,  438,  106,  490,
			  877,  877,  115,  877,  579,  877,  877,  343,  343,  344,
			  345,  345,  345,  345,  346,  347,  348,  349,  350,  453,
			  510,  510,  510,  510,  510,  510,  510,  510,  877,  454,
			  454,  455,  456,  457,  456,  456,  458,  459,  460,  461, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  462,  453,  516,  516,  516,  516,  516,  516,  877,  582,
			  131,  454,  454,  455,  456,  457,  456,  456,  458,  459,
			  460,  461,  462,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  545,  877,  545,  877,  453,  546,  546,  546,
			  546,  582,  131,  877,  877,  877,  463,  454,  455,  464,
			  465,  466,  456,  458,  459,  460,  461,  462,  219,  219,
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
			  467,  219,  219,  468,  219,  219,  219,  219,  219,  219,
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
			  219,  219,  219,  219,  219,  219,  219,  219,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  268,
			  266,  268,  268,  583,  267,  281,  282,  281,  281,  584,
			  877,  291,  291,  291,  291,  491,  492,  493,  115,  115,

			  115,  305,  305,  305,  115,  115,  115,  877,  485,  325,
			  485,  485,  585,  877,  305,  583,  877,  115,  497,  500,
			  498,  584,  115,  115,  586,  544,  544,  544,  544,  494,
			  580,  324,  325,  324,  324,  575,  305,  269,  877,  115,
			  384,  877,  495,  581,  585,  499,  131,  131,  131,  576,
			  587,  588,  131,  131,  131,  877,  586,  877,  496,  877,
			  877,  494,  580,  877,  308,  131,  877,  575,  877,  269,
			  131,  131,  384,  305,  495,  581,  115,  499,  131,  131,
			  131,  576,  587,  588,  131,  131,  131,  131,  305,  270,
			  496,  115,  271,  272,  273,  283,  308,  131,  284,  285, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  286,  292,  131,  131,  293,  294,  295,  112,  324,  325,
			  324,  324,  305,  306,  505,  115,  115,  115,  486,  131,
			  877,  487,  488,  489,  131,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  589,  877,  590,  131,
			  591,  327,  592,  593,  328,  329,  330,  305,  877,  594,
			  115,  877,  549,  595,  549,  596,  131,  550,  550,  550,
			  550,  877,  877,  131,  307,  131,  877,  877,  589,  324,
			  590,  131,  591,  877,  592,  593,  546,  546,  546,  546,
			  506,  594,  501,  115,  877,  595,  877,  596,  877,  161,
			  877,  551,  551,  551,  551,  131,  307,  131,  131,  504,

			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  327,  112,
			  112,  328,  329,  330,  112,  112,  112,  112,  112,  112,
			  131,  131,  166,  877,  502,  503,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  540,  877,  556,  877,  557,  557,  557,
			  557,  877,  877,  131,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  546,  546,  546,  546,  132,  132,  133,  134,  134,
			  134,  134,  135,  136,  137,  138,  139,  305,  394,  877, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  115,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  547,  547,  547,  547,  597,
			  558,  558,  558,  558,  598,  599,  602,  603,  131,  877,
			  548,  604,  877,  343,  343,  344,  345,  345,  345,  345,
			  346,  347,  348,  349,  350,  877,  877,  643,  877,  643,
			  605,  597,  644,  644,  644,  644,  598,  599,  602,  603,
			  131,  394,  548,  604,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,

			  333,  305,  605,  877,  115,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  606,
			  607,  608,  609,  610,  611,  612,  613,  614,  615,  308,
			  647,  308,  131,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  877,  606,  607,  608,  609,  610,  611,  612,  613,  614,
			  615,  308,  647,  308,  131,  623,  624,  625,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  333,  333,  333,  333,  333,  305,  877,  877,  115,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  222,  222,  222,  222,  222,  222,  222,
			  222,  550,  550,  550,  550,  648,  131,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  877,  877,  648,  131,  219,
			  219,  877,  333,  333,  333,  333,  333,  333,  333,  333,

			  333,  333,  333,  333,  333,  333,  333,  333,  333,  305,
			  877,  877,  115,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  389,  389,  390,  390,  600,  235,  235,  235,  235,  235,
			  235,  390,  390,  390,  390,  390,  390,  616,  478,  478,
			  478,  478,  601,  238,  238,  238,  238,  238,  649,  650,
			  131,  550,  550,  550,  550,  877,  600,  238,  877,  877,
			  877,  552,  877,  390,  390,  390,  390,  390,  390,  877,
			  877,  877,  308,  308,  601,  714,  714,  714,  714,  620,
			  649,  650,  131,  877,  877,  877,  333,  333,  333,  333, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  305,  308,  308,  115,  635,  523,  523,
			  523,  523,  390,  390,  390,  390,  622,  485,  651,  652,
			  653,  877,  877,  390,  390,  390,  390,  390,  390,  391,
			  391,  391,  390,  642,  642,  642,  642,  877,  877,  654,
			  390,  390,  390,  390,  390,  390,  655,  877,  548,  639,
			  651,  652,  653,  553,  131,  390,  390,  390,  390,  390,
			  390,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  554,  654,  390,  390,  390,  390,  390,  390,  655,  645,
			  548,  551,  551,  551,  551,  877,  131,  877,  656,  657,

			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  305,  877,  556,
			  115,  646,  646,  646,  646,  877,  392,  392,  392,  392,
			  656,  657,  394,  658,  659,  877,  877,  392,  392,  392,
			  392,  392,  392,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  660,  661,  394,  662,  663,  658,  659,  555,  131,  392,
			  392,  392,  392,  392,  392,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  660,  661,  877,  662,  663,  877,  877,  877, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  664,  877,  877,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  305,  877,  877,  115,  227,  227,  227,  227,  227,
			  227,  227,  227,  664,  227,  227,  227,  227,  227,  227,
			  227,  227,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  665,  666,  131,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  644,  644,  644,  644,  644,  644,  644,  644,  785,  785,

			  785,  785,  665,  666,  131,  877,  877,  877,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  220,  219,  219,  219,  219,  219,
			  219,  219,  223,  223,  223,  223,  223,  223,  223,  224,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  225,
			  226,  227,  227,  227,  227,  227,  227,  667,  227,  227,
			  227,  227,  227,  227,  227,  227,  230,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  453,  781,  781,  781,  781,  877,  667, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  877,  454,  454,  455,  456,  457,  456,  456,
			  458,  459,  460,  461,  462,  453,  780,  877,  780,  877,
			  877,  781,  781,  781,  781,  454,  454,  455,  456,  457,
			  456,  456,  458,  459,  460,  461,  462,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  616,  478,
			  478,  478,  478,  485,  325,  485,  485,  877,  626,  877,

			  627,  617,  618,  115,  877,  305,  629,  305,  115,  115,
			  115,  631,  305,  305,  115,  115,  115,  556,  668,  558,
			  558,  558,  558,  619,  877,  877,  305,  669,  305,  115,
			  620,  115,  877,  617,  618,  670,  630,  640,  640,  640,
			  640,  628,  671,  672,  673,  877,  877,  877,  674,  308,
			  668,  131,  384,  675,  683,  619,  131,  131,  131,  669,
			  394,  684,  131,  131,  131,  685,  686,  670,  630,  687,
			  688,  877,  689,  628,  671,  672,  673,  131,  641,  131,
			  674,  308,  877,  131,  384,  675,  683,  690,  131,  131,
			  131,  877,  691,  684,  131,  131,  131,  685,  686,  324, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  324,  687,  688,  486,  689,  877,  487,  488,  489,  131,
			  877,  131,  877,  324,  324,  324,  324,  324,  877,  690,
			  877,  877,  877,  324,  691,  877,  877,  324,  305,  877,
			  877,  115,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  692,  693,  694,  695,
			  696,  697,  698,  699,  308,  719,  308,  720,  877,  131,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  877,  692,  693,

			  694,  695,  696,  697,  698,  699,  308,  719,  308,  720,
			  485,  131,  485,  877,  877,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  305,  877,  877,  115,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  632,  632,  632,  632,  632,  632,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632,
			  478,  478,  478,  478,  308,  712,  712,  712,  712,  877,
			  721,  722,  723,  131,  633,  633,  633,  633,  633,  633,
			  633,  633,  633,  633,  633,  633,  633,  633,  633,  633, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  633,  877,  786,  877,  786,  726,  308,  787,  787,  787,
			  787,  620,  721,  722,  723,  131,  639,  877,  485,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  305,  726,  877,  115,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  877,  635,  523,  523,  523,  523,
			  724,  727,  728,  729,  725,  877,  730,  131,  636,  637,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,

			  375,  375,  375,  375,  375,  375,  375,  877,  731,  732,
			  638,  877,  724,  727,  728,  729,  725,  639,  730,  131,
			  636,  637,  877,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  731,  732,  638,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  389,  389,  390,  390,  733,  676,  676,  676,  676,  877,
			  677,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  678,  734,  640,  640,  640,  640,  735,  390,  390,
			  390,  390,  390,  390,  877,  877,  733,  877,  713,  736, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  877,  552,  737,  390,  390,  390,  390,  390,  390,  781,
			  781,  781,  781,  877,  734,  738,  739,  877,  553,  735,
			  390,  390,  390,  390,  390,  390,  391,  391,  391,  390,
			  713,  736,  305,  877,  737,  115,  740,  390,  390,  390,
			  390,  390,  390,  392,  392,  392,  392,  738,  739,  702,
			  702,  702,  702,  677,  392,  392,  392,  392,  392,  392,
			  702,  702,  702,  702,  702,  702,  308,  554,  740,  390,
			  390,  390,  390,  390,  390,  679,  704,  877,  680,  681,
			  682,  877,  305,  131,  555,  115,  392,  392,  392,  392,
			  392,  392,  702,  702,  702,  702,  702,  702,  308,  741,

			  748,  877,  485,  485,  485,  485,  485,  305,  704,  718,
			  115,  558,  558,  558,  558,  131,  485,  749,  706,  750,
			  877,  751,  752,  708,  708,  709,  709,  753,  754,  755,
			  756,  741,  748,  131,  709,  709,  709,  709,  709,  709,
			  705,  676,  676,  676,  676,  676,  877,  877,  877,  749,
			  706,  750,  166,  751,  752,  676,  877,  877,  131,  753,
			  754,  755,  756,  877,  877,  131,  709,  709,  709,  709,
			  709,  709,  705,  341,  341,  341,  341,  341,  341,  341,
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
			  341,  341,  341,  341,  341,  710,  710,  710,  709,  757,
			  758,  711,  711,  711,  711,  759,  709,  709,  709,  709,
			  709,  709,  711,  711,  711,  711,  711,  711,  715,  715,
			  715,  715,  305,  877,  760,  115,  761,  700,  700,  877,
			  877,  757,  758,  548,  877,  877,  877,  759,  709,  709,
			  709,  709,  709,  709,  711,  711,  711,  711,  711,  711,
			  385,  769,  715,  715,  715,  715,  760,  305,  877,  716,
			  115,  676,  676,  676,  676,  548,  742,  717,  762,  763,

			  701,  701,  701,  131,  789,  790,  877,  678,  765,  702,
			  702,  702,  702,  769,  791,  305,  792,  793,  115,  768,
			  702,  702,  702,  702,  702,  702,  877,  794,  877,  717,
			  782,  782,  782,  782,  877,  131,  789,  790,  131,  877,
			  877,  764,  877,  877,  795,  783,  791,  877,  792,  793,
			  766,  768,  702,  702,  702,  702,  702,  702,  770,  794,
			  779,  712,  712,  712,  712,  796,  131,  797,  798,  877,
			  131,  771,  708,  708,  709,  709,  795,  783,  799,  742,
			  800,  877,  801,  709,  709,  709,  709,  709,  709,  877,
			  770,  877,  877,  877,  802,  803,  804,  796,  131,  797, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  798,  679,  639,  877,  680,  681,  682,  877,  877,  877,
			  799,  877,  800,  772,  801,  709,  709,  709,  709,  709,
			  709,  773,  709,  709,  709,  709,  802,  803,  804,  715,
			  715,  715,  715,  709,  709,  709,  709,  709,  709,  775,
			  710,  710,  710,  709,  784,  385,  805,  785,  785,  785,
			  785,  709,  709,  709,  709,  709,  709,  701,  701,  701,
			  877,  877,  788,  774,  806,  709,  709,  709,  709,  709,
			  709,  787,  787,  787,  787,  807,  784,  808,  805,  809,
			  810,  776,  811,  709,  709,  709,  709,  709,  709,  777,
			  711,  711,  711,  711,  788,  812,  806,  830,  764,  877,

			  831,  711,  711,  711,  711,  711,  711,  807,  877,  808,
			  877,  809,  810,  305,  811,  305,  115,  305,  115,  877,
			  115,  787,  787,  787,  787,  832,  877,  812,  877,  830,
			  833,  778,  831,  711,  711,  711,  711,  711,  711,  702,
			  702,  702,  702,  834,  814,  835,  816,  836,  877,  837,
			  702,  702,  702,  702,  702,  702,  815,  832,  708,  708,
			  709,  709,  833,  838,  131,  839,  131,  877,  131,  709,
			  709,  709,  709,  709,  709,  834,  814,  835,  816,  836,
			  766,  837,  702,  702,  702,  702,  702,  702,  815,  823,
			  823,  823,  823,  877,  877,  838,  131,  839,  131,  772, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  709,  709,  709,  709,  709,  709,  709,  709,  709,
			  709,  846,  847,  821,  821,  821,  821,  848,  709,  709,
			  709,  709,  709,  709,  710,  710,  710,  709,  783,  877,
			  826,  826,  826,  826,  849,  709,  709,  709,  709,  709,
			  709,  877,  877,  846,  847,  827,  877,  877,  774,  848,
			  709,  709,  709,  709,  709,  709,  822,  877,  822,  850,
			  783,  823,  823,  823,  823,  776,  849,  709,  709,  709,
			  709,  709,  709,  711,  711,  711,  711,  827,  840,  840,
			  840,  840,  877,  877,  711,  711,  711,  711,  711,  711,
			  824,  850,  824,  877,  857,  825,  825,  825,  825,  828,

			  305,  828,  783,  115,  829,  829,  829,  829,  858,  859,
			  841,  877,  852,  877,  778,  115,  711,  711,  711,  711,
			  711,  711,  853,  877,  877,  115,  857,  877,  641,  823,
			  823,  823,  823,  861,  783,  877,  866,  877,  851,  877,
			  858,  859,  841,  825,  825,  825,  825,  825,  825,  825,
			  825,  131,  854,  854,  854,  854,  829,  829,  829,  829,
			  877,  868,  867,  131,  115,  861,  877,  827,  866,  855,
			  851,  855,  827,  131,  856,  856,  856,  856,  829,  829,
			  829,  829,  869,  131,  840,  840,  840,  840,  842,  870,
			  871,  843,  844,  845,  867,  131,  872,  873,  716,  827, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  856,  856,  856,  856,  827,  131,  856,  856,  856,  856,
			  874,  875,  131,  876,  869,  877,  860,  877,  877,  877,
			  877,  870,  871,  840,  840,  840,  840,  840,  872,  873,
			   76,   76,   76,   76,   76,   76,   76,  840,  877,  877,
			  877,  877,  874,  875,  131,  876,  877,  877,  860,   80,
			   80,   80,   80,   80,   80,   80,   89,   89,   89,   89,
			   89,   89,   89,   91,   91,   91,   91,   91,   91,   91,
			   98,   98,   98,   98,   98,   98,   98,  112,  877,  112,
			  112,  112,  112,  112,  141,  141,  141,  141,  141,  141,
			  141,  877,  877,  877,  842,  877,  877,  843,  844,  845,

			  236,  877,  236,  236,  877,  236,  236,  265,  265,  265,
			  265,  265,  265,  265,  269,  269,  269,  269,  269,  269,
			  269,  279,  279,  279,  279,  279,  279,  279,  114,  877,
			  114,  114,  114,  114,  114,  115,  877,  115,  877,  115,
			  115,  115,  341,  341,  341,  341,  341,  341,  483,  877,
			  483,  483,  483,  483,  483,  743,  743,  743,  743,  743,
			  743,  743,  813,  877,  813,  813,  813,  813,  813,   13,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877, yy_Dummy>>,
			1, 93, 4600)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4692)
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
			    1,    1,    1,    1,    3,    4,   27,  886,    3,    4,
			   46,    3,    4,    5,    5,    5,    5,   27,    5,    6,
			    6,    6,    6,  865,    6,    9,    9,    9,    9,   34,
			   34,   10,   10,   10,   10,   36,   36,   11,   11,   11,
			   11,  864,   46,   12,   12,   12,   12,   29,   41,   15,
			   15,   15,   15,   11,  884,   29,   49,  884,   41,   12,
			   16,   16,   16,   16,   28,   15,   28,   28,   28,   28,
			   31,    5,   31,   31,   31,   31,   16,    6,   45,   40, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   41,  862,   48,   40,   45,   52,   40,   54,   49,   40,
			   41,   80,   40,   55,   84,   80,  265,   85,   84,   48,
			  265,   85,  845,    5,   88,   96,   96,  843,   88,    6,
			   45,   40,  842,   31,   48,   40,   45,   52,   40,   54,
			   29,   40,   53,    5,   40,   55,    5,    5,    5,    6,
			  779,   48,    6,    6,    6,    9,   53,  115,    9,    9,
			    9,   10,  104,  104,   10,   10,   10,   11,  110,  110,
			   11,   11,   11,   12,   53,  777,   12,   12,   12,   15,
			  174,  775,   15,   15,   15,  263,  263,   86,   53,  115,
			   16,   86,  773,   16,   16,   16,   18,   18,   47,   18,

			   18,  175,   18,  771,   18,   18,  767,   18,   47,   18,
			   47,   42,  174,   42,   47,   88,   18,   85,   18,  177,
			   18,   18,   30,   42,   30,   30,   30,   30,   51,   18,
			   47,  178,  179,  175,   18,   18,   30,   30,   51,  180,
			   47,   51,   47,   42,   18,   42,   47,   18,   18,   44,
			   18,  177,  181,   18,  747,   42,   44,   44,   30,  746,
			   51,   18,   44,  178,  179,   30,   18,   18,   30,   30,
			   51,  180,  744,   51,  269,  743,   18,  703,  269,   18,
			   18,   44,   38,   43,  181,   86,   38,   43,   44,   44,
			   30,   38,  682,   38,   44,  285,  285,  680,   38,   38, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   43,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   18,   18,   18,   21,   38,   43,  153,  679,   38,   43,
			   21,  182,   21,   38,   50,   38,  166,  166,  166,  166,
			   38,   38,   43,  176,   50,  678,  176,  183,  184,   50,
			  294,  294,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  182,  617,  617,   50,   63,   63,   75,
			   75,   75,   75,   75,   75,  176,   50,  166,  176,  183,
			  184,   50,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   66,
			   66,   66,   66,   66,   66,   66,   66,  635,  153,  153,

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
			  621,   79,   87,   79,   79,   79,   87,   81,   81,   81,
			   81,   79,   81,   92,   92,   92,   92,  191,   79,  112,

			   79,  556,  112,   79,   79,   79,   79,  484,   79,  187,
			   79,  190,  117,  482,   79,  117,   79,  192,  481,   79,
			   79,   79,   79,   79,   79,   99,   99,   99,   99,  191,
			  479,  100,  100,  100,  100,  194,  197,  106,  106,  106,
			  106,  116,  372,  118,  116,   81,  118,  199,  116,  192,
			  112,  371,  200,  106,  119,  681,  681,  119,  201,  120,
			  370,  204,  120,  117,  844,  844,  123,  194,  197,  123,
			  762,  762,  120,   87,   87,  369,  368,   81,  121,  199,
			  367,  121,  112,   79,  200,  366,   79,   79,   79,  365,
			  201,  364,  116,  204,  118,  117,  149,   81,  363,  121, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   81,   81,   81,   92,  123,  119,   92,   92,   92,  122,
			  120,  762,  122,  129,  362,  361,  129,  123,  124,  125,
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
			  618,  618,  618,  132,  132,  132,  132,  132,  132,  132,
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
			  401,  195,  143,  409,  143,  195,  213,  143,  143,  143,
			  143,  213,  143,    0,  143,  401,  195,  410,  143,  195,

			  143,  412,  213,  143,  143,  143,  143,  143,  143,  206,
			  414,  206,  401,  195,    0,  409,    0,  195,  213,  206,
			    0,  415,  206,  213,  206,  206,    0,    0,  195,  410,
			    0,  195,  416,  412,  213,    0,  220,  220,  220,  220,
			    0,  206,  414,  206,  302,  302,  302,  302,  302,    0,
			    0,  206,  220,  415,  206,    0,  206,  206,  302,  309,
			    0,    0,  309,    0,  416,    0,    0,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  219,
			  344,  344,  344,  344,  344,  344,  344,  344,    0,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  219,  221,  350,  350,  350,  350,  350,  350,    0,  418,
			  309,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  346,  346,  346,  346,  346,  346,  346,
			  346,  346,  384,    0,  384,    0,  220,  384,  384,  384,
			  384,  418,  309,    0,    0,    0,  220,  220,  220,  220,
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
			  268,  268,  268,  419,  268,  281,  281,  281,  281,  420,
			    0,  291,  291,  291,  291,  314,  316,  318,  314,  316,

			  318,  319,  320,  323,  319,  320,  323,    0,  308,  308,
			  308,  308,  421,    0,  321,  419,    0,  321,  322,  326,
			  322,  420,  326,  322,  422,  383,  383,  383,  383,  319,
			  417,  324,  324,  324,  324,  413,  324,  268,    0,  324,
			  383,    0,  320,  417,  421,  323,  314,  316,  318,  413,
			  423,  424,  319,  320,  323,    0,  422,    0,  321,    0,
			    0,  319,  417,    0,  308,  321,    0,  413,    0,  268,
			  326,  322,  383,  327,  320,  417,  327,  323,  314,  316,
			  318,  413,  423,  424,  319,  320,  323,  324,  328,  268,
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
			  348,  348,  348,  348,  348,  348,  425,    0,  426,  328,
			  427,  324,  429,  430,  324,  324,  324,  329,    0,  431,
			  329,    0,  387,  432,  387,  433,  327,  387,  387,  387,
			  387,    0,    0,  330,  307,  331,    0,    0,  425,  327,
			  426,  328,  427,    0,  429,  430,  545,  545,  545,  545,
			  333,  431,  328,  333,    0,  432,    0,  433,    0,  388,
			    0,  388,  388,  388,  388,  330,  307,  331,  329,  330,

			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  329,  333,  388,    0,  329,  329,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  375,    0,  393,    0,  393,  393,  393,
			  393,    0,    0,  333,  345,  345,  345,  345,  345,  345,
			  345,  345,  345,  345,  345,  345,  345,  345,  345,  345,
			  345,  546,  546,  546,  546,  333,  333,  333,  333,  333,
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
			  394,  394,  394,  394,  435,  436,  438,  439,  334,    0,
			  386,  440,    0,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,    0,    0,  548,    0,  548,
			  441,  434,  548,  548,  548,  548,  435,  436,  438,  439,
			  334,  394,  386,  440,  334,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  334,  334,

			  334,  335,  441,    0,  335,  376,  376,  376,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  376,  376,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  442,
			  443,  444,  445,  446,  447,  448,  449,  450,  451,  488,
			  559,  489,  335,  378,  378,  378,  378,  378,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378,
			    0,  442,  443,  444,  445,  446,  447,  448,  449,  450,
			  451,  488,  559,  489,  335,  488,  488,  489,  335,  335,
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
			  380,  380,  380,  455,  455,  455,  455,  455,  455,  455,
			  455,  549,  549,  549,  549,  560,  336,  381,  381,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  381,  381,  381,  453,  453,  453,  453,  453,  453,
			  453,  453,  453,  453,  453,    0,    0,  560,  336,  453,
			  453,    0,  336,  336,  336,  336,  336,  336,  336,  336,

			  336,  336,  336,  336,  336,  336,  336,  336,  336,  337,
			    0,    0,  337,  382,  382,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  382,  382,
			  389,  389,  389,  389,  437,  462,  462,  462,  462,  462,
			  462,  389,  389,  389,  389,  389,  389,  478,  478,  478,
			  478,  478,  437,  480,  480,  480,  480,  480,  561,  562,
			  337,  550,  550,  550,  550,    0,  437,  480,    0,    0,
			    0,  389,    0,  389,  389,  389,  389,  389,  389,    0,
			    0,    0,  486,  487,  437,  641,  641,  641,  641,  478,
			  561,  562,  337,    0,    0,    0,  337,  337,  337,  337, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  338,  486,  487,  338,  523,  523,  523,
			  523,  523,  390,  390,  390,  390,  487,  486,  563,  564,
			  565,    0,    0,  390,  390,  390,  390,  390,  390,  391,
			  391,  391,  391,  547,  547,  547,  547,    0,    0,  566,
			  391,  391,  391,  391,  391,  391,  567,    0,  547,  523,
			  563,  564,  565,  390,  338,  390,  390,  390,  390,  390,
			  390,  458,  458,  458,  458,  458,  458,  458,  458,  458,
			  391,  566,  391,  391,  391,  391,  391,  391,  567,  551,
			  547,  551,  551,  551,  551,    0,  338,    0,  568,  569,

			  338,  338,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  339,    0,  557,
			  339,  557,  557,  557,  557,    0,  392,  392,  392,  392,
			  568,  569,  551,  570,  571,    0,    0,  392,  392,  392,
			  392,  392,  392,  454,  454,  454,  454,  454,  454,  454,
			  454,  454,  454,  454,  454,  454,  454,  454,  454,  454,
			  572,  573,  557,  574,  575,  570,  571,  392,  339,  392,
			  392,  392,  392,  392,  392,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  572,  573,    0,  574,  575,    0,    0,    0, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  339,  576,    0,    0,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  340,    0,    0,  340,  457,  457,  457,  457,  457,
			  457,  457,  457,  576,  457,  457,  457,  457,  457,  457,
			  457,  457,  459,  459,  459,  459,  459,  459,  459,  459,
			  459,  459,  459,  459,  459,  459,  459,  459,  459,  460,
			  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,
			  577,  578,  340,  461,  461,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  643,  643,  643,  643,  644,  644,  644,  644,  716,  716,

			  716,  716,  577,  578,  340,    0,    0,    0,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  463,  463,  463,  463,  463,
			  463,  463,  463,  463,  463,  463,  463,  463,  463,  463,
			  463,  463,  464,  464,  464,  464,  464,  464,  464,  464,
			  464,  464,  464,  464,  464,  464,  464,  464,  464,  465,
			  465,  465,  465,  465,  465,  465,  465,  579,  465,  465,
			  465,  465,  465,  465,  465,  465,  466,  466,  466,  466,
			  466,  466,  466,  466,  466,  466,  466,  466,  466,  466,
			  466,  466,  466,  467,  780,  780,  780,  780,    0,  579, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  467,  467,  467,  467,  467,  467,  467,
			  467,  467,  467,  467,  467,  468,  713,    0,  713,    0,
			    0,  713,  713,  713,  713,  468,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  468,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  477,  477,
			  477,  477,  477,  485,  485,  485,  485,    0,  494,    0,

			  494,  477,  477,  494,    0,  495,  496,  497,  495,  496,
			  497,  499,  501,  504,  499,  501,  504,  558,  581,  558,
			  558,  558,  558,  477,    0,    0,  502,  582,  503,  502,
			  477,  503,    0,  477,  477,  583,  497,  544,  544,  544,
			  544,  495,  584,  585,  586,    0,    0,    0,  588,  485,
			  581,  494,  544,  591,  594,  477,  495,  496,  497,  582,
			  558,  595,  499,  501,  504,  596,  597,  583,  497,  598,
			  599,    0,  600,  495,  584,  585,  586,  502,  544,  503,
			  588,  485,    0,  494,  544,  591,  594,  601,  495,  496,
			  497,    0,  602,  595,  499,  501,  504,  596,  597,  501, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  504,  598,  599,  485,  600,    0,  485,  485,  485,  502,
			    0,  503,    0,  502,  502,  502,  502,  502,    0,  601,
			    0,    0,    0,  503,  602,    0,    0,  502,  507,    0,
			    0,  507,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  603,  604,  606,  609,
			  610,  611,  612,  613,  622,  647,  625,  650,    0,  507,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  512,  512,    0,  603,  604,

			  606,  609,  610,  611,  612,  613,  622,  647,  625,  650,
			  622,  507,  625,    0,    0,  507,  507,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  508,    0,    0,  508,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  620,  620,  620,  620,  624,  639,  639,  639,  639,    0,
			  651,  652,  655,  508,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  515,    0,  717,    0,  717,  657,  624,  717,  717,  717,
			  717,  620,  651,  652,  655,  508,  639,    0,  624,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  509,  657,    0,  509,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  541,  541,  541,
			  541,  541,  541,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,    0,  522,  522,  522,  522,  522,
			  656,  659,  660,  661,  656,    0,  662,  509,  522,  522,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

			  542,  542,  542,  542,  542,  542,  542,    0,  663,  664,
			  522,    0,  656,  659,  660,  661,  656,  522,  662,  509,
			  522,  522,    0,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  663,  664,  522,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  552,  552,  552,  552,  665,  592,  592,  592,  592,    0,
			  592,  552,  552,  552,  552,  552,  552,  553,  553,  553,
			  553,  592,  667,  640,  640,  640,  640,  668,  553,  553,
			  553,  553,  553,  553,    0,    0,  665,    0,  640,  669, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  552,  670,  552,  552,  552,  552,  552,  552,  781,
			  781,  781,  781,    0,  667,  671,  672,    0,  553,  668,
			  553,  553,  553,  553,  553,  553,  554,  554,  554,  554,
			  640,  669,  626,    0,  670,  626,  673,  554,  554,  554,
			  554,  554,  554,  555,  555,  555,  555,  671,  672,  619,
			  619,  619,  619,  592,  555,  555,  555,  555,  555,  555,
			  619,  619,  619,  619,  619,  619,  623,  554,  673,  554,
			  554,  554,  554,  554,  554,  592,  626,    0,  592,  592,
			  592,    0,  630,  626,  555,  630,  555,  555,  555,  555,
			  555,  555,  619,  619,  619,  619,  619,  619,  623,  675,

			  683,    0,  623,  623,  623,  623,  623,  628,  626,  646,
			  628,  646,  646,  646,  646,  626,  623,  684,  630,  685,
			    0,  686,  687,  636,  636,  636,  636,  688,  689,  690,
			  692,  675,  683,  630,  636,  636,  636,  636,  636,  636,
			  628,  745,  745,  745,  745,  745,    0,    0,    0,  684,
			  630,  685,  646,  686,  687,  745,    0,    0,  628,  688,
			  689,  690,  692,    0,    0,  630,  636,  636,  636,  636,
			  636,  636,  628,  632,  632,  632,  632,  632,  632,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632,
			  628,  633,  633,  633,  633,  633,  633,  633,  633,  633, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  633,  633,  633,  633,  633,  633,  633,  633,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  637,  637,  637,  637,  693,
			  696,  638,  638,  638,  638,  697,  637,  637,  637,  637,
			  637,  637,  638,  638,  638,  638,  638,  638,  642,  642,
			  642,  642,  705,    0,  699,  705,  700,  700,  700,    0,
			    0,  693,  696,  642,    0,    0,    0,  697,  637,  637,
			  637,  637,  637,  637,  638,  638,  638,  638,  638,  638,
			  645,  705,  645,  645,  645,  645,  699,  704,    0,  642,
			  704,  676,  676,  676,  676,  642,  676,  645,  700,  701,

			  701,  701,  701,  705,  721,  722,    0,  676,  702,  702,
			  702,  702,  702,  705,  723,  706,  725,  726,  706,  704,
			  702,  702,  702,  702,  702,  702,    0,  727,    0,  645,
			  714,  714,  714,  714,    0,  705,  721,  722,  704,    0,
			    0,  701,    0,    0,  728,  714,  723,    0,  725,  726,
			  702,  704,  702,  702,  702,  702,  702,  702,  706,  727,
			  712,  712,  712,  712,  712,  731,  706,  733,  734,    0,
			  704,  708,  708,  708,  708,  708,  728,  714,  736,  676,
			  737,    0,  738,  708,  708,  708,  708,  708,  708,    0,
			  706,    0,    0,    0,  739,  740,  741,  731,  706,  733, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  734,  676,  712,    0,  676,  676,  676,    0,    0,    0,
			  736,    0,  737,  708,  738,  708,  708,  708,  708,  708,
			  708,  709,  709,  709,  709,  709,  739,  740,  741,  715,
			  715,  715,  715,  709,  709,  709,  709,  709,  709,  710,
			  710,  710,  710,  710,  715,  718,  748,  718,  718,  718,
			  718,  710,  710,  710,  710,  710,  710,  764,  764,  764,
			    0,    0,  718,  709,  749,  709,  709,  709,  709,  709,
			  709,  786,  786,  786,  786,  750,  715,  751,  748,  753,
			  757,  710,  758,  710,  710,  710,  710,  710,  710,  711,
			  711,  711,  711,  711,  718,  760,  749,  789,  764,    0,

			  790,  711,  711,  711,  711,  711,  711,  750,    0,  751,
			    0,  753,  757,  769,  758,  768,  769,  770,  768,    0,
			  770,  787,  787,  787,  787,  792,    0,  760,    0,  789,
			  794,  711,  790,  711,  711,  711,  711,  711,  711,  766,
			  766,  766,  766,  795,  768,  796,  770,  797,    0,  800,
			  766,  766,  766,  766,  766,  766,  769,  792,  772,  772,
			  772,  772,  794,  803,  769,  804,  768,    0,  770,  772,
			  772,  772,  772,  772,  772,  795,  768,  796,  770,  797,
			  766,  800,  766,  766,  766,  766,  766,  766,  769,  822,
			  822,  822,  822,    0,    0,  803,  769,  804,  768,  772, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  770,  772,  772,  772,  772,  772,  772,  774,  774,  774,
			  774,  806,  807,  782,  782,  782,  782,  808,  774,  774,
			  774,  774,  774,  774,  776,  776,  776,  776,  782,    0,
			  785,  785,  785,  785,  810,  776,  776,  776,  776,  776,
			  776,    0,    0,  806,  807,  785,    0,    0,  774,  808,
			  774,  774,  774,  774,  774,  774,  783,    0,  783,  811,
			  782,  783,  783,  783,  783,  776,  810,  776,  776,  776,
			  776,  776,  776,  778,  778,  778,  778,  785,  805,  805,
			  805,  805,    0,    0,  778,  778,  778,  778,  778,  778,
			  784,  811,  784,    0,  831,  784,  784,  784,  784,  788,

			  814,  788,  821,  814,  788,  788,  788,  788,  834,  838,
			  805,    0,  815,    0,  778,  815,  778,  778,  778,  778,
			  778,  778,  816,    0,    0,  816,  831,    0,  821,  823,
			  823,  823,  823,  841,  821,    0,  846,    0,  814,    0,
			  834,  838,  805,  824,  824,  824,  824,  825,  825,  825,
			  825,  814,  826,  826,  826,  826,  828,  828,  828,  828,
			    0,  851,  848,  815,  851,  841,    0,  826,  846,  827,
			  814,  827,  854,  816,  827,  827,  827,  827,  829,  829,
			  829,  829,  858,  814,  840,  840,  840,  840,  805,  860,
			  861,  805,  805,  805,  848,  815,  870,  871,  854,  826, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  855,  855,  855,  855,  854,  816,  856,  856,  856,  856,
			  872,  873,  851,  874,  858,    0,  840,    0,    0,    0,
			    0,  860,  861,  863,  863,  863,  863,  863,  870,  871,
			  878,  878,  878,  878,  878,  878,  878,  863,    0,    0,
			    0,    0,  872,  873,  851,  874,    0,    0,  840,  879,
			  879,  879,  879,  879,  879,  879,  880,  880,  880,  880,
			  880,  880,  880,  881,  881,  881,  881,  881,  881,  881,
			  882,  882,  882,  882,  882,  882,  882,  883,    0,  883,
			  883,  883,  883,  883,  885,  885,  885,  885,  885,  885,
			  885,    0,    0,    0,  840,    0,    0,  840,  840,  840,

			  887,    0,  887,  887,    0,  887,  887,  888,  888,  888,
			  888,  888,  888,  888,  889,  889,  889,  889,  889,  889,
			  889,  890,  890,  890,  890,  890,  890,  890,  891,    0,
			  891,  891,  891,  891,  891,  892,    0,  892,    0,  892,
			  892,  892,  893,  893,  893,  893,  893,  893,  894,    0,
			  894,  894,  894,  894,  894,  895,  895,  895,  895,  895,
			  895,  895,  896,    0,  896,  896,  896,  896,  896,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877, yy_Dummy>>,
			1, 93, 4600)
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
			    0,    0,    0,  121,  122,  131,  137, 1357, 1356,  143,
			  149,  155,  161, 1339, 4569,  167,  178, 4569,  289,    0,
			 4569,  410, 4569, 4569, 4569, 4569, 4569,  108,  165,  147,
			  303,  171, 1305, 4569,  122, 4569,  127, 1248,  348,    0,
			  160,  132,  268,  351,  312,  158,   84,  265,  170,  140,
			  388,  289,  160,  210,  168,  167, 4569, 1214, 4569, 4569,
			 4569, 4569, 4569,  348,  378,  440,  386,  457,  474,  491,
			  508,  525,  534,  545,  562,  365, 1265, 4569, 4569,  671,
			  208,  685, 4569, 4569,  211,  214,  284,  679,  221, 1268,
			 4569, 4569,  691, 4569, 1161, 1158,  131, 1162, 4569,  723,

			  729, 1237, 1133, 1134,  168, 1137,  735, 1210, 1106, 1107,
			  174, 1113,  692, 4569,  852,  199,  734,  705,  736,  747,
			  752,  771,  802,  759,  811,  812,  818,  930,  919,  806,
			  813,  928, 1039,  971, 1143,  992, 1247, 1005, 1351,  929,
			    0, 1004, 1042, 1455, 1054, 1140, 1084,  886, 1116,  784,
			 1183, 1194, 1215,  404, 4569, 4569, 4569, 1031, 4569, 4569,
			 4569, 1239, 1246, 1346, 1352, 1369,  405, 4569, 4569, 4569,
			 4569, 4569, 4569,    0,  231,  265,  393,  284,  281,  281,
			  303,  320,  376,  401,  389, 1000,    0,  627,  838,  821,
			  636,  665,  671,    0,  688, 1446,    0,  694,  797,  696, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  702,  723,  964,    0,  712,  798, 1474,  866,  830,  844,
			  859,  859,  865, 1451,  933,  945,  964,  957, 4569, 1477,
			 1534, 1499, 1564, 1581, 1598, 1615, 1632, 1649, 1666,  809,
			 1683, 1700, 1717, 1734, 1751, 1768, 1096, 4569, 1361, 4569,
			 4569, 4569, 4569, 4569, 1035, 4569, 4569, 4569, 4569, 4569,
			 4569, 4569, 4569, 4569, 4569, 4569, 4569, 4569, 4569, 4569,
			 4569,  982,  983,  191,  976,  213, 4569, 4569, 1877,  371,
			  998, 1095,  977, 1057, 4569, 1328, 1331, 1097, 1329, 1065,
			 4569, 1883, 4569,  959,  947,  301,  953,  928, 1232,  919,
			  919, 1889,  908,  903,  346,  909,  989,  889, 1300,  832,

			  834,  823, 1450,  814,  813, 4569, 4569, 2006, 1906, 1552,
			 4569, 4569, 4569, 4569, 1888, 4569, 1889, 4569, 1890, 1894,
			 1895, 1907, 1913, 1896, 1929, 4569, 1912, 1966, 1981, 2040,
			 2005, 2007, 4569, 2073, 2190, 2294, 2398, 2502, 2606, 2710,
			 2814, 4569, 4569, 2042, 1477, 2070, 1529, 2107, 1925, 2124,
			 1508,  885,  882,  879,  877,  865, 1181,  836,  821,  820,
			  815,  803,  802,  786,  779,  777,  773,  768,  764,  763,
			  748,  739,  730, 4569, 4569, 2141, 2211, 2228, 2259, 2315,
			 2332, 2363, 2419, 1904, 1616, 4569, 2214, 2036, 2070, 2509,
			 2601, 2618, 2705, 2136, 2219,  964,  996, 1165,    0,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1158, 1431, 1166, 1184, 1221, 1367, 1351, 1388, 1406, 1451,
			 1461,    0, 1449, 1903, 1474, 1471, 1481, 1886, 1566, 1847,
			 1853, 1865, 1892, 1914, 1919, 1989, 2002, 1994,    0, 2006,
			 1987, 1998, 2019, 2019, 2203, 2212, 2193, 2500, 2197, 2211,
			 2219, 2234, 2299, 2295, 2305, 2299, 2307, 2296, 2305, 2306,
			 2312, 2303,    0, 2380, 2649, 2340, 2681, 2731, 2577, 2748,
			 2759, 2779, 2441, 2831, 2848, 2865, 2882, 2891, 2913, 4569,
			 4569, 4569, 4569, 2943, 2960, 2977, 4569, 3068, 2527,  636,
			 2459,  616,  619,    0,  632, 3091, 2524, 2525, 2291, 2293,
			 4569, 4569, 4569, 4569, 3093, 3098, 3099, 3100, 4569, 3104,

			 4569, 3105, 3119, 3121, 3106, 4569, 4569, 3221, 3325, 3429,
			 3138, 3155, 3186, 3242, 3259, 3290, 3346, 4569, 4569, 4569,
			 4569, 4569, 3455, 2597, 4569, 4569, 4569, 4569, 4569, 4569,
			 4569, 4569, 4569, 4569, 4569, 4569, 4569, 4569, 4569, 4569,
			 4569, 3363, 3396, 3449, 3116, 2055, 2160, 2622, 2251, 2430,
			 2540, 2670, 3539, 3556, 3605, 3622,  682, 2700, 3098, 2300,
			 2404, 2508, 2521, 2594, 2589, 2588, 2599, 2620, 2647, 2663,
			 2695, 2685, 2726, 2721, 2714, 2719, 2752, 2821, 2835, 2915,
			    0, 3082, 3087, 3080, 3093, 3107, 3095,    0, 3105,    0,
			    0, 3110, 3563,    0, 3114, 3109, 3128, 3117, 3125, 3130, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3120, 3144, 3136, 3232, 3218,    0, 3221,    0,    0, 3233,
			 3233, 3219, 3229, 3241,    0,    0, 4569,  433, 1109, 3628,
			 3349,  608, 3216, 3608, 3316, 3218, 3625, 4569, 3700, 4569,
			 3675, 4569, 3679, 3697, 3714,  485, 3702, 3804, 3810, 3354,
			 3562, 2564, 3827, 2869, 2873, 3861, 3690, 3225,    0,    0,
			 3232, 3341, 3348,    0,    0, 3333, 3444, 3360,    0, 3432,
			 3443, 3446, 3450, 3473, 3458, 3519,    0, 3533, 3542, 3563,
			 3562, 3575, 3582, 3596,    0, 3663, 3889, 4569,  417,  314,
			  296,  661,  298, 3668, 3668, 3679, 3685, 3686, 3678, 3692,
			 3678,    0, 3679, 3797,    0,    0, 3790, 3799,    0, 3809,

			 3836, 3879, 3888,  300, 3880, 3845, 3908, 4569, 3951, 4001,
			 4019, 4069, 3940, 3000, 3909, 4008, 2877, 3386, 4026,    0,
			    0, 3868, 3853, 3863,    0, 3870, 3866, 3891, 3912,    0,
			    0, 3929,    0, 3935, 3932,    0, 3928, 3935, 3931, 3943,
			 3963, 3945, 4569,  372,  278, 3647,  257,  260, 4003, 4014,
			 4030, 4032,    0, 4043,    0,    0,    0, 4029, 4037,    0,
			 4044, 4569,  749, 4569, 4036, 4569, 4118,  238, 4108, 4106,
			 4110,  291, 4137,  280, 4186,  269, 4203,  263, 4252,  238,
			 2973, 3588, 4192, 4240, 4274, 4209, 4050, 4100, 4283, 4062,
			 4049,    0, 4080,    0, 4095, 4110, 4110, 4104,    0,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 4111,    0,    0, 4118, 4129, 4276, 4165, 4176, 4183,    0,
			 4198, 4223,    0,    0, 4293, 4305, 4315, 4569, 4569, 4569,
			 4569, 4266, 4168, 4308, 4322, 4326, 4331, 4353, 4335, 4357,
			    0, 4258,    0,    0, 4265,    0,    0,    0, 4258,    0,
			 4382, 4290,  129,  126,  670,  128, 4287,    0, 4326,    0,
			    0, 4354, 4569, 4569, 4336, 4379, 4385,    0, 4346,    0,
			 4346, 4358,  107, 4329,   59,   49,    0,    0, 4569,    0,
			 4364, 4347, 4360, 4361, 4363,    0, 4569, 4569, 4429, 4448,
			 4455, 4462, 4469, 4476,  171, 4483,  121, 4499, 4506, 4513,
			 4520, 4527, 4534, 4541, 4547, 4554, 4561, yy_Dummy>>,
			1, 97, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 896)
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
			  884,  893,  893,  893,  893,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  887,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  888,  877,  877,  888,  889,
			  888,  888,  888,  888,  877,  888,  888,  888,  888,  890,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  894,  877,  877,  877,

			  877,  877,  877,  877,  877,  877,  877,  891,  892,  883,
			  877,  877,  877,  877,  883,  877,  883,  877,  883,  883,
			  883,  883,  883,  883,  883,  877,  883,  883,  883,  883,
			  883,  883,  877,  883,  883,  883,  883,  883,  883,  883,
			  883,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  893,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  886,  886,  886,  886,  886, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  894,  894,  892,  892,  892,  892,  892,
			  877,  877,  877,  877,  883,  883,  883,  883,  877,  883,

			  877,  883,  883,  883,  883,  877,  877,  883,  883,  883,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  877,  877,  877,  877,
			  877,  894,  892,  892,  892,  892,  883,  877,  883,  877,
			  883,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  877,  877,  877,  877,
			  877,  877,  877,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,

			  877,  877,  877,  894,  883,  883,  883,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  877,  895,  877,  877,  877,  877,  886,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  877,  877,  877,  877,  877,  877,  894,  883,  883,
			  883,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  896,  883,  883,  883,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  877,  886,  877,  877,  877,  877,  886,  886,  886,  886,
			  886,  883,  877,  877,  877,  877,  877,  886,  886,  886,
			  877,  886,  877,  877,  877,  877,  886,  886,  877,  886,
			  877,  886,  877,  886,  877,  886,  877,    0,  877,  877,
			  877,  877,  877,  877,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  877, yy_Dummy>>,
			1, 97, 800)
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

	yyJam_base: INTEGER = 4569
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 877
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 878
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
