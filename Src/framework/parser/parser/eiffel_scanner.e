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
	yy_end := yy_start + yy_more_len + 1
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
	yy_end := yy_start + yy_more_len + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				if syntax_version = obsolete_syntax then
					process_id_as
					last_token := TE_FREE
				else
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_AT, Current)
					last_token := TE_AT
				end
			
when 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 17 then
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
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.translation_in_context (once "Assignment attempt symbol %"?=%" is not part of ECMA/ISO Eiffel and will not be supported in the future. Use object test instead.", once "parser.eiffel.warning")))
				end
			
when 18 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 19 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 20 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 21 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 22 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 23 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			
when 24 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 31 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 32 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 33 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 34 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 35 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 36 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 37 then
	yy_end := yy_start + yy_more_len + 2
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
	yy_end := yy_start + yy_more_len + 2
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
	yy_end := yy_start + yy_more_len + 2
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
	yy_end := yy_start + yy_more_len + 2
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_BAR, Current)
				last_token := TE_BAR
			
when 44 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
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
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_NOT
					end
			
when 49 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_AND
					end
			
when 50 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_AND_THEN
					end
			
when 51 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_OR
					end
			
when 52 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_OR_ELSE
					end
			
when 53 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_IMPLIES
					end
			
when 54 then
	yy_end := yy_start + yy_more_len + 1
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_id_as
				last_token :=
					if syntax_version = obsolete_syntax then
						TE_FREE
					else
						TE_FREE_XOR
					end
			
when 55 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 56 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 57 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 58 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 59 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
				if
					syntax_version /= obsolete_syntax and then
					has_syntax_warning
				then
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.formatted_string (locale.translation_in_context (once "Obsolete operator notation `$1` is used. Replace it with a contemporary operator (if available) or an unfolded feature call.", once "parser.eiffel.warning"), unicode_text)))
				end
			
when 60 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
				if
					syntax_version /= obsolete_syntax and then
					has_syntax_warning
				then
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.formatted_string (locale.translation_in_context (once "Obsolete operator notation `$1` is used. Replace it with a contemporary operator (if available) or an unfolded feature call.", once "parser.eiffel.warning"), unicode_text)))
				end
			
when 61 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
				if
					syntax_version /= obsolete_syntax and then
					has_syntax_warning
				then
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.formatted_string (locale.translation_in_context (once "Obsolete operator notation `$1` is used. Replace it with a contemporary operator (if available) or an unfolded feature call.", once "parser.eiffel.warning"), unicode_text)))
				end
			
when 62 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
				if
					syntax_version /= obsolete_syntax and then
					has_syntax_warning
				then
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.formatted_string (locale.translation_in_context (once "Obsolete operator notation `$1` is used. Replace it with a contemporary operator (if available) or an unfolded feature call.", once "parser.eiffel.warning"), unicode_text)))
				end
			
when 63 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
				if
					syntax_version /= obsolete_syntax and then
					has_syntax_warning
				then
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.formatted_string (locale.translation_in_context (once "Obsolete operator notation `$1` is used. Replace it with a contemporary operator (if available) or an unfolded feature call.", once "parser.eiffel.warning"), unicode_text)))
				end
			
when 64 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
				if
					syntax_version /= obsolete_syntax and then
					has_syntax_warning
				then
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.formatted_string (locale.translation_in_context (once "Obsolete operator notation `$1` is used. Replace it with a contemporary operator (if available) or an unfolded feature call.", once "parser.eiffel.warning"), unicode_text)))
				end
			
when 65 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Keyword `across` is used as identifier.", once "parser.eiffel.warning")))
					end
				end
			
when 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 67 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 68 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 69 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 70 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 71 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 72 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Keyword `attached` is used as identifier.", once "parser.eiffel.warning")))
					end
				end
			
when 73 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Keyword `attribute` is used as identifier.", once "parser.eiffel.warning")))
					end
				end
			
when 74 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 75 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 76 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 77 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 78 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 79 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 80 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 81 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 82 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Keyword `detachable` is used as identifier.", once "parser.eiffel.warning")))
					end
				end
			
when 83 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 84 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 85 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 86 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 87 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 88 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 89 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 90 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 91 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 92 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 93 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 94 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 95 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 96 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 97 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Usage of `indexing` has been replaced by `note`.", once "parser.eiffel.warning")))
					end

				end
			
when 98 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 99 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 100 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 101 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 102 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 103 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 105 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 106 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Keyword `note` is used as identifier.", once "parser.eiffel.warning")))
					end
				end
			
when 107 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 108 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 109 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- '{' is for the typed manifest string.
				last_detachable_keyword_as_value := ast_factory.new_once_string_keyword_as (utf8_text, line, column, position, 4, character_column, character_position, 4)
				last_token := TE_ONCE_STRING
			
when 110 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- '{' is for the typed manifest string.
				last_detachable_keyword_as_value := ast_factory.new_once_string_keyword_as (utf8_text_substring (1, 4), line, column, position, 4, character_column, character_position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (utf8_text_substring (5, text_count), line, column + 4, position + 4, text_count - 4, character_column + 4, character_position + 4, unicode_text_count - 4)
				last_token := TE_ONCE_STRING
			
when 111 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 112 then
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
					report_one_warning
						(create {SYNTAX_WARNING}.make (line, column, filename,
						locale.translation_in_context (once "Use of `only`, possibly a new keyword in the future standard of Eiffel.", once "parser.eiffel.warning")))
				end
			
when 113 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 114 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 115 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 116 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 117 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 118 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 119 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 120 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 121 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 122 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 123 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 124 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 125 then
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
						report_one_warning
							(create {SYNTAX_WARNING}.make (line, column, filename,
							locale.translation_in_context (once "Keyword `some` is used as identifier.", once "parser.eiffel.warning")))
					end
				end
			
when 126 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 129 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 130 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 131 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 132 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 133 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 136 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 137 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 138 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when` `1.` `.2` `then`
					-- instead of:
					--     `when` `1` `..` `2` `then`
				update_character_locations
				token_buffer.wipe_out
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 139 then
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
					--     `when` `1.` `.2` `then`
					-- instead of:
					--     `when` `1` `..` `2` `then`
				update_character_locations
				token_buffer.wipe_out
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes hexadecimal integer numbers.
				update_character_locations
				token_buffer.wipe_out
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 141 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes octal integer numbers.
				update_character_locations
				token_buffer.wipe_out
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 142 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes binary integer numbers.
				update_character_locations
				token_buffer.wipe_out
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 143 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 144 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				token_buffer.wipe_out
				append_utf8_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_detachable_char_as_value := ast_factory.new_character_as (char_32_from_source (utf8_text_substring (2, text_count - 1)), line, column, position, text_count, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
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
			
when 154 then
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
			
when 155 then
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
			
when 156 then
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
			
when 157 then
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
			
when 158 then
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
			
when 159 then
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
			
when 160 then
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
			
when 161 then
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
			
when 162 then
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
			
when 163 then
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
			
when 164 then
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
			
when 165 then
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
			
when 166 then
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
			
when 167 then
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
			
when 168 then
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
				append_utf8_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 169 then
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
				append_utf8_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 170 then
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
				append_utf8_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 171 then
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
				append_utf8_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (utf8_text)
			
when 174 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (utf8_text)
			
when 175 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 176 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 177 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 178 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 179 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 180 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 181 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 182 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 183 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 184 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 185 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 186 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 187 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 188 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 189 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 190 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 191 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 192 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 193 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 194 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 196 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 197 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 199 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 200 then
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
				append_utf8_text_substring_to_string (2, text_count - 1, verbatim_marker)
				start_location.set_position (line, column, position, text_count, character_column, character_position, unicode_text_count)
				set_start_condition (VERBATIM_STR3)
			
when 201 then
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
			
when 202 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				append_utf8_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 203 then
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
					append_utf8_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 204 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 205 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 206 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 207 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 208 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 209 then
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
					append_utf8_text_substring_to_string (2, text_count, token_buffer)
				end
				start_location.set_position (line, column, position, text_count, character_column, character_position, unicode_text_count)
				set_start_condition (SPECIAL_STR)
			
when 210 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 213 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 214 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 215 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 216 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 217 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 218 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 219 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 220 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 221 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 222 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 223 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 224 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 225 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 226 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 227 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 228 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 229 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 230 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 231 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 232 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 233 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 234 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 235 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 236 then
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
			
when 237 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if text_count > 1 then
					append_utf8_text_substring_to_string (1, text_count - 1, token_buffer)
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
			
when 238 then
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
			
when 239 then
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
			
when 240 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 241 then
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
			create an_array.make_filled (0, 0, 2917)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (277, 791, 816)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			an_array.area.fill_with (476, 1467, 1492)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			yy_nxt_template_14 (an_array)
			yy_nxt_template_15 (an_array)
			an_array.area.fill_with (866, 2821, 2917)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   15,   16,   15,   17,   18,   19,   20,   14,   19,
			   21,   22,   23,   24,   25,   26,   27,   28,   29,   30,
			   31,   31,   31,   32,   33,   34,   35,   36,   37,   38,
			   39,   40,   41,   42,   43,   44,   40,   40,   45,   40,
			   40,   46,   40,   47,   48,   49,   40,   50,   51,   52,
			   53,   54,   55,   56,   40,   40,   57,   58,   59,   60,
			   17,   14,   39,   40,   41,   42,   43,   44,   40,   45,
			   46,   47,   40,   50,   51,   52,   53,   54,   61,   62,
			   63,   64,   14,   65,   14,   17,   17,   66,   67,   68,
			   69,   70,   71,   72,   73,   74,   75,   14,   77,   77,

			  256,   78,   78,  257,   79,   79,   81,   82,   81,  857,
			   83,   81,   82,   81,  846,   83,   88,   89,   88,   88,
			   89,   88,   91,   92,   91,   91,   92,   91,   94,   94,
			   94,   94,   94,   94,   97,   98,  126,   93,  127,  209,
			   93,  128,  129,   95,  130,  131,   95,  133,  134,  136,
			  199,  137,  137,  137,  137,  150,  151,  160,  135,  154,
			  155,  156,  157,   84,  152,  153,  256,  161,   84,  260,
			  209,  158,  159,  212,  213,  214,  215,  216,   98,  217,
			   98,  491,  199,  492,   84,  218,   98,  219,   98,   84,
			   99,  845,   99,  100,  101,  102,   99,  103,  102,   99, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  104,   99,  105,  106,   99,  107,   99,  108,   99,   99,
			   99,   99,   99,   99,  109,  100,  110,   99,  111,  112,
			   99,   99,   99,   99,   99,   99,   99,  113,   99,   99,
			   99,   99,  114,  115,   99,   99,   99,   99,   99,   99,
			   99,   99,  116,   99,   99,  117,  118,   99,  119,  100,
			   99,  112,   99,   99,   99,   99,   99,   99,  113,   99,
			  114,   99,   99,   99,   99,   99,   99,  120,   99,  100,
			  100,   99,  100,   99,  100,  100,  100,  100,  100,  100,
			  100,  100,   99,   99,  100,  100,   99,  121,  839,  121,
			   97,   98,  121,  138,  139,  140,  121,  121,  206,  123,

			  124,  121,  143,  141,  144,  144,  144,  144,  121,  121,
			  121,  834,  121,  296,  178,  183,  145,  146,  143,  184,
			  144,  144,  144,  144,  179,  180,  206,  181,  190,  220,
			   98,  211,  185,  197,  191,  225,   98,  182,  147,  287,
			  121,  296,  121,  121,  121,  148,  178,  183,  145,  146,
			  198,  184,  228,   98,  180,  181,  289,  142,  185,  190,
			  288,  148,  280,  121,  121,  197,  121,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  198,  290,   96,   96,
			  162,  442,  162,  163,  280,  162,  163,  163,  163,  162,
			  162,  163,  164,  165,  162,  163,  163,  163,  163,  163, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  163,  162,  162,  162,  163,  162,  167,  207,  221,   98,
			  168,  186,  442,  223,   98,  169,  708,  170,  187,  188,
			  299,  208,  171,  172,  189,  229,   98,  263,  264,  263,
			  268,   98,  163,  162,  163,  162,  162,  162,  167,  207,
			  265,  265,  265,  186,  169,  170,  299,  188,  171,  172,
			  189,  265,  265,  265,  163,  163,  162,  162,  163,  162,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,  173,
			  775,   96,   96,  174,  193,  285,  175,  200,  222,  176,
			  817,  203,  177,  224,  194,  866,  195,  201,  286,  387,
			  196,  204,  202,  392,  205,   97,   98,  258,  256,  258,

			  173,  257,  174,  342,  343,  176,  193,  816,  177,  200,
			  348,  349,  203,  194,  195,  387,  196,  204,  202,  392,
			  205,  232,  232,  232,  388,  233,  350,  351,  234,  771,
			  235,  236,  237,   94,   94,   94,  268,   98,  238,  270,
			  270,  270,  270,  352,  353,  239,  256,  240,   95,  257,
			  241,  242,  243,  244,  259,  245,  388,  246,  301,  302,
			  301,  247,  815,  248,  358,  358,  249,  250,  251,  252,
			  253,  254,  360,  360,  360,  259,   99,  271,   99,  370,
			  371,   99,  632,   99,  633,   99,   99,  391,   99,  866,
			   99,  301,  302,  301,  376,  377,  480,   99,   99,   99, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  393,   99,   99,  311,  311,  311,  311,  472,  268,   98,
			   99,  338,  338,  338,  338,   99,   99,  268,   98,  391,
			  340,  340,  340,  340,  394,   99,  393,  307,  120,   99,
			  814,   99,   99,  143,   99,  357,  357,  357,  357,  378,
			   98,   99,  810,   99,  362,  362,  362,  362,  303,  396,
			  379,  407,   99,   99,  395,   99,  394,   99,   99,   99,
			   99,   99,   99,   99,   99,  445,  446,   99,   99,  272,
			  273,  272,  397,  408,  272,  763,  148,  396,  272,  272,
			  407,  274,  272,  272,  398,  363,  395,  681,  420,  402,
			  272,  272,  272,  789,  272,  866,  866,  866,  866,  866,

			  866,  866,  866,  866,  397,  408,  866,  866,   97,   98,
			  398,  341,  341,  341,  341,  402,  344,  344,  344,  344,
			  420,  418,  272,  764,  272,  272,  272,  424,  744,  268,
			   98,  345,  347,  347,  347,  347,  268,   98,  708,  365,
			  365,  365,  365,  457,   98,  272,  272,  418,  272,  272,
			  272,  272,  272,  272,  272,  272,  272,  272,  271,  424,
			  272,  272,   99,  345,   99,  275,  276,  275,  277,  103,
			  275,  277,  277,  277,  275,  275,  277,  278,  275,  275,
			  277,  277,  277,  277,  277,  277,  275,  275,  275,  277,
			  275, yy_Dummy>>,
			1, 191, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  279,  275,  277,  275,  275,  275,  277,  277,  277,  277,
			  277,  277,  277,  277,  277,  277,  277,  277,  277,  277,
			  277,  277,  279,  277,  275,  275,  277,  275,  272,  272,
			  272,  272,  272,  272,  272,  272,  272,   99,   99,  272,
			  272,   99,  284,  100,  459,   98,  100,  271,   99,  704,
			  100,  100,  435,   99,  100,  100,  354,  419,  355,  355,
			  355,  355,  100,  403,  100,  381,  100,   99,  386,  386,
			  386,  386,  695,  356,  366,   99,  367,   98,  404,  416,
			   99,   99,  692,  419,  435,  368,  389,  369,  421,  390,
			   99,  417,  481,  120,  100,  403,  100,  422,  100,   99,

			  232,  232,  232,  472,  404,  356,   99,  465,   99,  268,
			   98,  416,  373,  373,  373,  373,  256,  389,  390,  260,
			  421,  100,  291,  292,  291,  293,  422,  291,  293,  293,
			  293,  291,  291,  293,  294,  291,  291,  293,  293,  293,
			  293,  293,  293,  291,  291,  291,  293,  291,  268,   98,
			  443,  375,  375,  375,  375,  423,  405,  434,  431,  586,
			  406,  688,  432,  675,  436,  441,  444,  268,   98,  482,
			  448,  448,  448,  448,  295,  291,  293,  291,  291,  291,
			  472,  423,  443,  434,  762,  399,  406,  431,  586,  400,
			  436,  441,  444,  263,  264,  263,  295,  293,  291,  291, yy_Dummy>>,
			1, 200, 817)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  293,  291,  121,  401,  121,  490,  663,  121,  265,  265,
			  265,  121,  121,  488,  306,  124,  121,  399,  258,  256,
			  258,  400,  257,  121,  121,  121,  763,  121,  411,  401,
			  493,  490,  412,  495,  438,  466,  467,  467,  467,  439,
			  301,  302,  301,  413,  472,  488,  414,  658,  268,   98,
			  440,  450,  450,  450,  450,  121,  493,  121,  121,  121,
			  411,  547,   98,  412,  268,   98,  438,  566,  655,  413,
			  439,  564,  414,  549,  565,  259,  440,  770,  121,  121,
			  557,  121,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,  358,  358,   96,   96,  308,  259,  308,  566,  564,

			  308,  301,  302,  301,  308,  308,  565,  310,  308,  308,
			  470,  470,  470,  478,  302,  478,  308,  308,  308,  771,
			  308,  425,  569,  426,  651,  269,  471,  301,  302,  301,
			  570,  427,  540,  584,  428,  571,  429,  430,  506,  507,
			  507,  507,  526,  526,  526,  526,  585,  573,  308,  354,
			  308,  308,  308,  425,  569,  426,  570,  345,  574,  427,
			  428,  571,  429,  430,  611,  360,  360,  360,  280,  613,
			  543,  308,  308,  573,  308,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  574,  572,  132,  132,  314,  345,
			  280,  315,  611,  316,  317,  318,  500,  578,  613,  268, yy_Dummy>>,
			1, 200, 1017)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   98,  319,  525,  525,  525,  525,  542,  575,  320,  541,
			  321,  268,   98,  322,  323,  324,  325,  572,  326,  774,
			  327,  637,  550,  578,  328,  307,  329,  701,  701,  330,
			  331,  332,  333,  334,  335,  383,  635,  383,  384,  575,
			  383,  384,  384,  384,  383,  383,  384,  385,  383,  383,
			  384,  384,  384,  384,  384,  384,  383,  383,  383,  384,
			  383,  775,  268,   98,  866,  866,  866,  866,  866,  866,
			  866,  866,  866,  159,  576,  866,  866,  527,  631,  527,
			  619,  582,  528,  528,  528,  528,  292,  384,  383,  384,
			  383,  383,  383,  866,  866,  866,  866,  866,  866,  866,

			  866,  866,  577,  581,  866,  866,  576,  582,  619,  384,
			  384,  383,  383,  384,  383,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  668,  579,  132,  132,  277,  474,
			  277,  709,  709,  277,  577,  581,  583,  277,  277,  580,
			  475,  277,  277,  470,  470,  470,  630,  598,  276,  277,
			  277,  277,  668,  277,  470,  470,  470,  579,  529,  471,
			  268,   98,  583,  530,  530,  530,  530,  587,  273,  531,
			  471,  268,   98,  598,  532,  532,  532,  532,  470,  470,
			  470,  277,  629,  277,  277,  277,  268,   98,  634,  534,
			  534,  534,  534,  533,  471,  537,  603,  537,  597,  587, yy_Dummy>>,
			1, 200, 1217)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  538,  538,  538,  538,  277,  277,  595,  277,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  634,  593,   99,
			   99,   99,  603,   99,  102,  271,  102,  476,  103,  102,
			  476,  476,  476,  102,  102,  476,   99,  102,  102,  476,
			  476,  476,  476,  476,  476,  102,  102,  102,  476,  102, yy_Dummy>>,
			1, 50, 1417)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  477,  102,  476,  102,  102,  102,  476,  476,  476,  476,
			  476,  476,  476,  476,  476,  476,  476,  476,  476,  476,
			  476,  476,  477,  476,  102,  102,  476,  102,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,   99,   99,  100,
			  100,   99,  293,  484,  293,  293,  589,  293,  293,  293,
			  293,  293,  293,  293,  485,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  535,  535,
			  535,  535,  546,  546,  546,  546,  470,  470,  470,  588,
			  590,  563,  591,  536,  382,  470,  470,  470,  470,  470,
			  470,  548,  471,  562,  295,  293,  293,  293,  293,  293,

			  551,  471,  592,  553,  471,  143,  561,  539,  539,  539,
			  539,  588,  590,  363,  591,  536,  295,  293,  293,  293,
			  293,  293,  111,  271,  111,  486,  543,  111,  486,  486,
			  486,  111,  111,  486,  592,  111,  111,  486,  486,  486,
			  486,  486,  486,  111,  111,  111,  486,  111,  148,  544,
			  594,  545,  545,  545,  545,  268,   98,  596,  552,  552,
			  552,  552,  268,   98,  606,  554,  554,  554,  554,  470,
			  470,  470,  547,   98,  487,  111,  486,  111,  111,  111,
			  599,  600,  594,  369,  555,  471,  702,  702,  702,  596,
			  606,  541,  363,  556,  556,  556,  487,  486,  111,  111, yy_Dummy>>,
			1, 200, 1493)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  486,  111,  496,  496,  496,  308,  567,  308,  557,  558,
			  308,  601,  599,  600,  308,  308,  602,  310,  497,  308,
			  559,  559,  559,  568,  604,  607,  308,  308,  308,  615,
			  308,  608,  609,  652,  610,  560,  616,  612,  567,  614,
			  524,  617,  605,  601,  618,  359,  359,  653,  602,  568,
			  523,  301,  302,  301,  522,  615,  604,  607,  308,  652,
			  308,  308,  308,  608,  609,  610,  630,  616,  605,  612,
			  521,  614,  617,  653,  268,   98,  618,  621,  621,  621,
			  621,  308,  308,  636,  308,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  520,  654,  132,  132,  498,  498,

			  498,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  358,  358,  679,  499,  519,  636,  620,  471,  518,  622,
			  471,  654,  623,  471,  624,  467,  467,  467,  467,  624,
			  467,  467,  467,  467,  301,  302,  301,  625,  626,   97,
			   98,  679,  270,  270,  270,  270,  478,  302,  478,  631,
			  123,  540,  517,  311,  311,  311,  311,  499,  656,  627,
			  638,  507,  507,  507,  507,  659,  628,  657,  660,  625,
			  626,  628,  528,  528,  528,  528,  528,  528,  528,  528,
			  661,  866,  866,  866,  866,  866,  866,  866,  866,  866,
			  656,  659,  866,  866,  476,  474,  476,  516,  657,  476, yy_Dummy>>,
			1, 200, 1693)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  660,  280,  642,  476,  476,  680,  661,  476,  476,  645,
			  645,  645,  645,  664,  721,  476,  476,  476,  515,  476,
			  866,  866,  866,  280,  536,  866,  866,  866,  866,  866,
			  866,  866,  866,  866,  680,  560,  866,  866,  646,  664,
			  646,  727,  721,  647,  647,  647,  647,  476,  514,  476,
			  476,  476,  538,  538,  538,  538,  536,  538,  538,  538,
			  538,  366,  561,  367,   98,  386,  386,  386,  386,  727,
			  476,  476,  368,  476,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,  701,  701,   99,   99,  486,  484,  486,
			  486,  662,  486,  486,  486,  486,  486,  486,  486,  691,

			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  486,  638,  507,  507,  507,  507,  734,  470,
			  470,  470,  665,  662,  759,  666,  639,  640,  691,  513,
			  643,  643,  643,  643,  650,  471,  671,  361,  361,  487,
			  486,  486,  486,  486,  486,  345,  734,  648,  641,  539,
			  539,  539,  539,  673,  665,  642,  666,  667,  639,  640,
			  669,  487,  486,  486,  486,  486,  486,  670,  671,  672,
			  544,  644,  649,  649,  649,  649,  544,  345,  546,  546,
			  546,  546,  676,  667,  674,  673,  669,  684,  677,  686,
			  363,  678,  689,  670,  693,  672,  681,  681,  681,  685, yy_Dummy>>,
			1, 200, 1893)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  682,  687,  690,  694,  696,  697,  698,  700,  676,  699,
			  512,  683,  511,  363,  706,  674,  722,  678,  684,  363,
			  677,  686,  705,  689,  707,  685,  693,  687,  690,  694,
			  703,  703,  698,  711,  711,  711,  696,  697,  699,  700,
			  467,  467,  467,  467,  720,  706,  723,  722,  705,  713,
			  713,  713,  713,  707,  643,  643,  643,  643,  715,  715,
			  715,  715,  716,  716,  716,  716,  724,  729,  730,  714,
			  720,  728,  163,  682,  163,  510,  163,  536,  723,  163,
			  731,  628,  647,  647,  647,  647,  647,  647,  647,  647,
			  642,  354,  724,  716,  716,  716,  716,  728,  729,  732,

			  730,  714,  719,  717,  546,  546,  546,  546,  718,  536,
			  733,  725,  731,  735,  736,  726,  737,  509,  738,  739,
			  740,  746,  741,  742,  745,  748,  681,  681,  681,  747,
			  743,  732,  749,  750,  751,  752,  733,  753,  754,  735,
			  718,  683,  736,  725,  755,  148,  726,  746,  737,  738,
			  739,  756,  740,  741,  757,  742,  745,  748,  765,  750,
			  747,  752,  766,  753,  749,  767,  751,  758,  701,  701,
			  754,  760,  702,  702,  702,  755,  768,  709,  709,  786,
			  791,  802,  757,  756,  772,  711,  711,  711,  508,  765,
			  505,  767,  792,  504,  766,  776,  713,  713,  713,  713, yy_Dummy>>,
			1, 200, 2093)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  777,  787,  777,  743,  503,  778,  778,  778,  778,  759,
			  802,  786,  791,  761,  779,  779,  779,  779,  769,  716,
			  716,  716,  716,  793,  792,  788,  773,  787,  790,  780,
			  782,  782,  782,  782,  781,  794,  783,  642,  783,  795,
			  797,  784,  784,  784,  784,  354,  796,  782,  782,  782,
			  782,  788,  798,  799,  790,  793,  800,  801,  803,  804,
			  806,  780,  785,  805,  807,  808,  781,  794,  797,  809,
			  811,  795,  796,  702,  702,  702,  813,  812,  798,  799,
			  710,  710,  502,  801,  803,  827,  501,  804,  800,  123,
			  807,  805,  806,  808,  785,  809,  778,  778,  778,  778,

			  828,  494,  811,  812,  778,  778,  778,  778,  813,  818,
			  818,  818,  818,  819,  761,  819,  830,  827,  820,  820,
			  820,  820,  831,  821,  780,  821,  828,  829,  822,  822,
			  822,  822,  823,  823,  823,  823,  784,  784,  784,  784,
			  784,  784,  784,  784,  825,  832,  825,  824,  830,  826,
			  826,  826,  826,  833,  831,  829,  780,  835,  836,  844,
			  837,  837,  837,  840,  841,  842,  843,  780,  820,  820,
			  820,  820,  820,  820,  820,  820,  850,  832,  489,  824,
			  712,  712,  833,  483,  479,  835,  473,  844,  851,  271,
			  836,  838,  472,  644,  469,  840,  841,  842,  843,  780, yy_Dummy>>,
			1, 200, 2293)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  822,  822,  822,  822,  822,  822,  822,  822,  850,  847,
			  847,  847,  847,  848,  852,  848,  854,  851,  849,  849,
			  849,  849,  855,  838,  824,  826,  826,  826,  826,  826,
			  826,  826,  826,  837,  837,  837,  856,  824,  858,  860,
			  852,  849,  849,  849,  849,  854,  859,  861,  855,  849,
			  849,  849,  849,   96,  862,  863,  824,  864,  865,  132,
			   96,   96,  262,  717,  853,  231,  132,  132,  856,  824,
			  858,  860,  464,  463,  462,  859,  461,  460,  458,  861,
			  862,  863,  456,  864,  865,  122,  455,  122,  454,  122,
			  122,  122,  122,  122,  453,  452,  853,   76,   76,   76,

			   76,   76,   76,   76,   76,   76,   76,   76,   76,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,  125,  451,  125,
			  125,  125,  125,  125,  125,  125,  125,  125,  125,  166,
			  166,  166,  166,  230,  449,  230,  230,  230,  447,  230,
			  230,  230,  230,  230,  230,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  259,  259,  259, yy_Dummy>>,
			1, 200, 2493)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  259,  259,  259,  259,  259,  259,  259,  259,  259,  261,
			  261,  261,  261,  261,  261,  261,  261,  261,  261,  261,
			  261,  103,  437,  103,  433,  103,  103,  103,  103,  103,
			  103,  103,  103,  309,  415,  309,  410,  309,  309,  309,
			  309,  309,  312,  409,  312,  312,  312,  312,  312,  312,
			  312,  312,  312,  312,  468,  382,  468,  468,  468,  468,
			  468,  468,  468,  468,  468,  468,  384,  384,  384,  381,
			  384,  380,  384,  374,  372,  384,  744,  744,  744,  744,
			  744,  744,  744,  744,  744,  744,  744,  744,  810,  364,
			  810,  810,  810,  810,  810,  810,  810,  810,  810,  810,

			  346,  341,  339,  337,  336,  313,  305,  304,  300,  298,
			  297,  283,  282,  281,  269,  267,  266,  262,  231,  227,
			  226,  210,  192,  149,  866,   86,   86,   13, yy_Dummy>>,
			1, 128, 2693)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2917)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 97)
			yy_chk_template_1 (an_array)
			an_array.area.fill_with (18, 192, 286)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (102, 764, 858)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			an_array.area.fill_with (278, 1440, 1534)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			yy_chk_template_14 (an_array)
			an_array.area.fill_with (866, 2820, 2917)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   80,    3,    4,   80,    3,    4,    5,    5,
			    5,  844,    5,    6,    6,    6,  813,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   21,   11,
			   21,   55,   12,   24,   24,   15,   25,   25,   16,   27,
			   27,   28,   50,   28,   28,   28,   28,   34,   34,   37,
			   27,   35,   35,   36,   36,    5,   34,   34,   84,   37,
			    6,   84,   55,   36,   36,   60,   60,   63,   63,   64,
			   64,   65,   65,  299,   50,  299,    5,   66,   66,   67,
			   67,    6,   18,  812, yy_Dummy>>,
			1, 94, 98)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   19,  803,   19,   58,   58,   19,   29,   29,   29,   19,
			   19,   53,   19,   19,   19,   30,   29,   30,   30,   30,
			   30,   19,   19,   19,  797,   19,  112,   42,   44,   30,
			   30,   31,   44,   31,   31,   31,   31,   42,   43,   53,
			   43,   46,   68,   68,   58,   44,   49,   46,   71,   71,
			   43,   30,  109,   19,  112,   19,   19,   19,   30,   42,
			   44,   30,   30,   49,   44,   74,   74,   43,   43,  110,
			   29,   44,   46,  109,   31,  103,   19,   19,   49,   19,
			   19,   19,   19,   19,   19,   19,   19,   19,   19,   49,
			  110,   19,   19,   38,  208,   38,   38,  103,   38,   38,

			   38,   38,   38,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   38,   38,   38,   39,
			   54,   69,   69,   39,   45,  208,   70,   70,   39,  776,
			   39,   45,   45,  115,   54,   39,   39,   45,   75,   75,
			   88,   88,   88,   96,   96,   38,   38,   38,   38,   38,
			   38,   39,   54,   91,   91,   91,   45,   39,   39,  115,
			   45,   39,   39,   45,   92,   92,   92,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   41,  775,   38,   38,   41,   48,  108,   41,
			   51,   69,   41,  774,   52,   41,   70,   48,  773,   48, yy_Dummy>>,
			1, 200, 287)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   51,  108,  167,   48,   52,   51,  171,   52,  132,  132,
			   81,   81,   81,   41,   81,   41,  135,  135,   41,   48,
			  772,   41,   51,  140,  140,   52,   48,   48,  167,   48,
			   52,   51,  171,   52,   79,   79,   79,  168,   79,  141,
			  141,   79,  771,   79,   79,   79,   94,   94,   94,   98,
			   98,   79,   98,   98,   98,   98,  142,  142,   79,  255,
			   79,   94,  255,   79,   79,   79,   79,   81,   79,  168,
			   79,  120,  120,  120,   79,  770,   79,  145,  145,   79,
			   79,   79,   79,   79,   79,  146,  146,  146,   81,   99,
			   99,   99,  153,  153,   99,  488,   99,  488,   99,   99,

			  170,   99,  769,   99,  117,  117,  117,  158,  158,  286,
			   99,   99,   99,  172,   99,   99,  124,  124,  124,  124,
			  286,  129,  129,   99,  129,  129,  129,  129,   99,   99,
			  131,  131,  170,  131,  131,  131,  131,  173,   99,  172,
			  122,   99,   99,  768,   99,   99,  144,   99,  144,  144,
			  144,  144,  159,  159,   99,  764,   99,  148,  148,  148,
			  148,  117,  175,  159,  183,   99,   99,  174,   99,  173,
			   99,   99,   99,   99,   99,   99,   99,   99,  211,  211,
			   99,   99,  100,  100,  100,  176,  184,  100,  763,  144,
			  175,  100,  100,  183,  100,  100,  100,  177,  148,  174, yy_Dummy>>,
			1, 200, 487)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  744,  194,  180,  100,  100,  100,  726,  100,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  176,  184,  122,
			  122,  134,  134,  177,  134,  134,  134,  134,  180,  137,
			  137,  137,  137,  194,  192,  100,  704,  100,  100,  100,
			  198,  683,  139,  139,  137,  139,  139,  139,  139,  151,
			  151,  638,  151,  151,  151,  151,  222,  222,  100,  100,
			  192,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  631,  198,  100,  100,  102,  137, yy_Dummy>>,
			1, 77, 687)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  107,  107,  224,  224,  107,  630,  107,  629,  107,  107,
			  203,  107,  107,  107,  143,  193,  143,  143,  143,  143,
			  107,  181,  107,  165,  107,  107,  165,  165,  165,  165,
			  610,  143,  152,  107,  152,  152,  181,  191,  107,  107,
			  606,  193,  203,  152,  169,  152,  195,  169,  107,  191,
			  288,  107,  107,  181,  107,  195,  107,  107,  232,  232,
			  232,  288,  181,  143,  107,  232,  107,  155,  155,  191,
			  155,  155,  155,  155,  259,  169,  169,  259,  195,  107,
			  111,  111,  111,  111,  195,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,

			  111,  111,  111,  111,  111,  111,  157,  157,  209,  157,
			  157,  157,  157,  197,  182,  202,  200,  410,  182,  602,
			  200,  587,  204,  207,  210,  213,  213,  290,  213,  213,
			  213,  213,  111,  111,  111,  111,  111,  111,  290,  197,
			  209,  202,  703,  178,  182,  200,  410,  178,  204,  207,
			  210,  263,  263,  263,  111,  111,  111,  111,  111,  111,
			  121,  178,  121,  298,  574,  121,  265,  265,  265,  121,
			  121,  296,  121,  121,  121,  178,  258,  258,  258,  178,
			  258,  121,  121,  121,  703,  121,  188,  178,  300,  298,
			  188,  304,  206,  238,  238,  238,  238,  206,  279,  279, yy_Dummy>>,
			1, 200, 859)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  279,  188,  304,  296,  188,  569,  215,  215,  206,  215,
			  215,  215,  215,  121,  300,  121,  121,  121,  188,  366,
			  366,  188,  368,  368,  206,  392,  566,  188,  206,  388,
			  188,  368,  389,  258,  206,  710,  121,  121,  561,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  358,
			  358,  121,  121,  123,  258,  123,  392,  388,  123,  295,
			  295,  295,  123,  123,  389,  123,  123,  123,  268,  268,
			  268,  280,  280,  280,  123,  123,  123,  710,  123,  199,
			  394,  199,  548,  268,  268,  301,  301,  301,  395,  199,
			  358,  409,  199,  396,  199,  199,  319,  319,  319,  319,

			  344,  344,  344,  344,  409,  398,  123,  544,  123,  123,
			  123,  199,  394,  199,  395,  344,  399,  199,  199,  396,
			  199,  199,  435,  360,  360,  360,  280,  437,  543,  123,
			  123,  398,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  399,  397,  123,  123,  126,  344,  280,  126,
			  435,  126,  126,  126,  309,  404,  437,  343,  343,  126,
			  343,  343,  343,  343,  360,  400,  126,  541,  126,  369,
			  369,  126,  126,  126,  126,  397,  126,  712,  126,  493,
			  369,  404,  126,  311,  126,  625,  625,  126,  126,  126,
			  126,  126,  126,  164,  490,  164,  164,  400,  164,  164, yy_Dummy>>,
			1, 200, 1059)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  712,
			  379,  379,  309,  309,  309,  309,  309,  309,  309,  309,
			  309,  379,  401,  309,  309,  345,  486,  345,  443,  407,
			  345,  345,  345,  345,  483,  164,  164,  164,  164,  164,
			  164,  311,  311,  311,  311,  311,  311,  311,  311,  311,
			  402,  406,  311,  311,  401,  407,  443,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  579,  405,  164,  164,  277,  277,  277,  639,
			  639,  277,  402,  406,  408,  277,  277,  405,  277,  277,

			  277,  348,  348,  348,  476,  423,  473,  277,  277,  277,
			  579,  277,  350,  350,  350,  405,  348,  348,  349,  349,
			  408,  349,  349,  349,  349,  411,  472,  350,  350,  351,
			  351,  423,  351,  351,  351,  351,  352,  352,  352,  277,
			  469,  277,  277,  277,  353,  353,  489,  353,  353,  353,
			  353,  352,  352,  356,  428,  356,  422,  411,  356,  356,
			  356,  356,  277,  277,  419,  277,  277,  277,  277,  277,
			  277,  277,  277,  277,  277,  489,  417,  277,  277,  278,
			  428, yy_Dummy>>,
			1, 181, 1259)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  293,  293,  293,  293,  413,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  355,  355,  355,  355,
			  363,  363,  363,  363,  367,  367,  367,  412,  414,  387,
			  415,  355,  386,  370,  370,  370,  376,  376,  376,  367,
			  367,  384,  293,  293,  293,  293,  293,  293,  370,  370,
			  416,  376,  376,  357,  383,  357,  357,  357,  357,  412,
			  414,  363,  415,  355,  293,  293,  293,  293,  293,  293,
			  294,  294,  294,  294,  361,  294,  294,  294,  294,  294,
			  294,  294,  416,  294,  294,  294,  294,  294,  294,  294,

			  294,  294,  294,  294,  294,  294,  357,  362,  418,  362,
			  362,  362,  362,  371,  371,  421,  371,  371,  371,  371,
			  377,  377,  430,  377,  377,  377,  377,  378,  378,  378,
			  550,  550,  294,  294,  294,  294,  294,  294,  424,  425,
			  418,  550,  378,  378,  626,  626,  626,  421,  430,  359,
			  362,  381,  381,  381,  294,  294,  294,  294,  294,  294,
			  306,  306,  306,  306,  393,  306,  381,  381,  306,  426,
			  424,  425,  306,  306,  427,  306,  306,  306,  382,  382,
			  382,  393,  429,  431,  306,  306,  306,  439,  306,  432,
			  433,  563,  434,  382,  440,  436,  393,  438,  342,  441, yy_Dummy>>,
			1, 200, 1535)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  429,  426,  442,  884,  884,  564,  427,  393,  335,  477,
			  477,  477,  334,  439,  429,  431,  306,  563,  306,  306,
			  306,  432,  433,  434,  477,  440,  429,  436,  333,  438,
			  441,  564,  446,  446,  442,  446,  446,  446,  446,  306,
			  306,  491,  306,  306,  306,  306,  306,  306,  306,  306,
			  306,  306,  332,  565,  306,  306,  307,  307,  307,  445,
			  445,  445,  457,  457,  457,  459,  459,  459,  540,  540,
			  592,  307,  331,  491,  445,  445,  330,  457,  457,  565,
			  459,  459,  466,  466,  466,  466,  466,  467,  467,  467,
			  467,  467,  487,  487,  487,  466,  466,  471,  471,  592,

			  471,  471,  471,  471,  478,  478,  478,  487,  497,  540,
			  329,  497,  497,  497,  497,  500,  567,  466,  507,  507,
			  507,  507,  507,  570,  466,  568,  571,  466,  466,  467,
			  527,  527,  527,  527,  528,  528,  528,  528,  572,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  567,  570,
			  307,  307,  475,  475,  475,  328,  568,  475,  571,  478,
			  507,  475,  475,  595,  572,  475,  475,  535,  535,  535,
			  535,  575,  655,  475,  475,  475,  327,  475,  562,  562,
			  562,  478,  535,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  595,  562,  500,  500,  536,  575,  536,  662, yy_Dummy>>,
			1, 200, 1735)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  655,  536,  536,  536,  536,  475,  326,  475,  475,  475,
			  537,  537,  537,  537,  535,  538,  538,  538,  538,  549,
			  558,  549,  549,  558,  558,  558,  558,  662,  475,  475,
			  549,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  759,  759,  475,  475,  485,  485,  485,  485,  573,
			  485,  485,  485,  485,  485,  485,  485,  605,  485,  485,
			  485,  485,  485,  485,  485,  485,  485,  485,  485,  485,
			  485,  506,  506,  506,  506,  506,  670,  547,  547,  547,
			  576,  573,  759,  577,  506,  506,  605,  325,  526,  526,
			  526,  526,  547,  547,  582,  885,  885,  485,  485,  485,

			  485,  485,  485,  526,  670,  539,  506,  539,  539,  539,
			  539,  585,  576,  506,  577,  578,  506,  506,  580,  485,
			  485,  485,  485,  485,  485,  581,  582,  583,  545,  526,
			  545,  545,  545,  545,  546,  526,  546,  546,  546,  546,
			  588,  578,  586,  585,  580,  598,  589,  600,  539,  590,
			  603,  581,  607,  583,  596,  596,  596,  599,  596,  601,
			  604,  608,  613,  614,  615,  617,  588,  616,  324,  596,
			  323,  545,  634,  586,  656,  590,  598,  546,  589,  600,
			  632,  603,  636,  599,  607,  601,  604,  608,  889,  889,
			  615,  640,  640,  640,  613,  614,  616,  617,  628,  628, yy_Dummy>>,
			1, 200, 1935)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  628,  628,  652,  634,  657,  656,  632,  642,  642,  642,
			  642,  636,  643,  643,  643,  643,  644,  644,  644,  644,
			  645,  645,  645,  645,  660,  665,  666,  643,  652,  664,
			  886,  596,  886,  322,  886,  645,  657,  886,  667,  628,
			  646,  646,  646,  646,  647,  647,  647,  647,  642,  648,
			  660,  648,  648,  648,  648,  664,  665,  668,  666,  643,
			  649,  645,  649,  649,  649,  649,  648,  645,  669,  661,
			  667,  672,  673,  661,  674,  321,  675,  676,  677,  685,
			  678,  680,  684,  687,  681,  681,  681,  686,  681,  668,
			  688,  689,  690,  691,  669,  693,  694,  672,  648,  681,

			  673,  661,  697,  649,  661,  685,  674,  675,  676,  698,
			  677,  678,  700,  680,  684,  687,  705,  689,  686,  691,
			  706,  693,  688,  707,  690,  701,  701,  701,  694,  702,
			  702,  702,  702,  697,  709,  709,  709,  722,  728,  745,
			  700,  698,  711,  711,  711,  711,  320,  705,  318,  707,
			  729,  317,  706,  713,  713,  713,  713,  713,  714,  723,
			  714,  681,  316,  714,  714,  714,  714,  701,  745,  722,
			  728,  702,  715,  715,  715,  715,  709,  716,  716,  716,
			  716,  732,  729,  724,  711,  723,  727,  715,  717,  717,
			  717,  717,  716,  734,  718,  713,  718,  735,  738,  718, yy_Dummy>>,
			1, 200, 2135)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  718,  718,  718,  719,  737,  719,  719,  719,  719,  724,
			  739,  740,  727,  732,  741,  742,  746,  747,  750,  715,
			  719,  748,  754,  755,  716,  734,  738,  757,  765,  735,
			  737,  761,  761,  761,  767,  766,  739,  740,  890,  890,
			  315,  742,  746,  786,  314,  747,  741,  308,  754,  748,
			  750,  755,  719,  757,  777,  777,  777,  777,  787,  303,
			  765,  766,  778,  778,  778,  778,  767,  779,  779,  779,
			  779,  780,  761,  780,  791,  786,  780,  780,  780,  780,
			  792,  781,  779,  781,  787,  789,  781,  781,  781,  781,
			  782,  782,  782,  782,  783,  783,  783,  783,  784,  784,

			  784,  784,  785,  793,  785,  782,  791,  785,  785,  785,
			  785,  794,  792,  789,  779,  800,  801,  811,  802,  802,
			  802,  804,  805,  807,  808,  818,  819,  819,  819,  819,
			  820,  820,  820,  820,  828,  793,  297,  782,  891,  891,
			  794,  291,  281,  800,  275,  811,  831,  274,  801,  802,
			  272,  818,  266,  804,  805,  807,  808,  818,  821,  821,
			  821,  821,  822,  822,  822,  822,  828,  823,  823,  823,
			  823,  824,  835,  824,  838,  831,  824,  824,  824,  824,
			  839,  802,  823,  825,  825,  825,  825,  826,  826,  826,
			  826,  837,  837,  837,  841,  847,  851,  854,  835,  848, yy_Dummy>>,
			1, 200, 2335)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  848,  848,  848,  838,  853,  859,  839,  849,  849,  849,
			  849,  872,  860,  861,  823,  862,  863,  875,  872,  872,
			  261,  847,  837,  230,  875,  875,  841,  847,  851,  854,
			  229,  228,  227,  853,  226,  225,  223,  859,  860,  861,
			  221,  862,  863,  873,  220,  873,  219,  873,  873,  873,
			  873,  873,  218,  217,  837,  867,  867,  867,  867,  867,
			  867,  867,  867,  867,  867,  867,  867,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  870,  870,  870,  870,  870,  870,  870,  870,  870,

			  870,  870,  870,  871,  871,  871,  871,  871,  871,  871,
			  871,  871,  871,  871,  871,  874,  216,  874,  874,  874,
			  874,  874,  874,  874,  874,  874,  874,  876,  876,  876,
			  876,  877,  214,  877,  877,  877,  212,  877,  877,  877,
			  877,  877,  877,  878,  878,  878,  878,  878,  878,  878,
			  878,  878,  878,  878,  878,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  880,  880,  880,
			  880,  880,  880,  880,  880,  880,  880,  880,  880,  881,
			  205,  881,  201,  881,  881,  881,  881,  881,  881,  881,
			  881,  882,  190,  882,  187,  882,  882,  882,  882,  882, yy_Dummy>>,
			1, 200, 2535)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  883,  185,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  887,  163,  887,  887,  887,  887,  887,  887,
			  887,  887,  887,  887,  888,  888,  888,  162,  888,  160,
			  888,  156,  154,  888,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  893,  150,  893,  893,
			  893,  893,  893,  893,  893,  893,  893,  893,  138,  133,
			  130,  128,  127,  125,  119,  118,  116,  114,  113,  106,
			  105,  104,   97,   95,   93,   85,   76,   73,   72,   56,
			   47,   32,   13,    8,    7, yy_Dummy>>,
			1, 85, 2735)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 893)
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
			    0,    0,    0,   96,   97,  105,  110, 2817, 2816,  115,
			  118,  121,  124, 2817, 2820,  127,  130,  118,  189,  283,
			 2820,  128, 2820, 2820,  125,  128, 2820,  131,  132,  277,
			  285,  301, 2790, 2820,  139,  143,  145,  141,  376,  374,
			    0,  432,  280,  284,  285,  376,  290, 2771,  443,  303,
			  116,  443,  444,  255,  377,  102, 2770, 2820,  274, 2820,
			  157, 2820, 2820,  159,  161,  163,  169,  171,  313,  392,
			  397,  319, 2797, 2796,  336,  409, 2806, 2820, 2820,  520,
			   98,  496, 2820, 2820,  164, 2808, 2820, 2820,  426, 2820,
			 2820,  439,  450, 2793,  532, 2792,  414, 2791,  520,  572,

			  665, 2820,  761,  306, 2794, 2800, 2799,  854,  470,  334,
			  351,  935,  270, 2761, 2758,  373, 2757,  590, 2743, 2794,
			  557, 1015,  611, 1108,  584, 2788, 1200, 2787, 2780,  592,
			 2779,  601,  479, 2778,  692,  487, 2820,  697, 2777,  713,
			  494,  510,  527,  856,  616,  545,  553,    0,  625, 2820,
			 2766,  720,  877,  563, 2751,  910, 2750,  949,  578,  623,
			 2748, 2820, 2746, 2732, 1248,  866,    0,  442,  490,  865,
			  554,  445,  551,  590,  624,  606,  638,  637,  971,    0,
			  641,  847,  928,  610,  643, 2692,    0, 2684, 1012,    0,
			 2687,  864,  672,  826,  655,  873,    0,  925,  693, 1105, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  934, 2675,  927,  835,  931, 2670, 1018,  935,  343,  933,
			  936,  649, 2655,  968, 2651, 1049, 2635, 2572, 2571, 2565,
			 2563, 2559,  727, 2555,  845, 2554, 2553, 2551, 2550, 2549,
			 2553, 2820,  916, 2820, 2820, 2820, 2820, 2820, 1033, 2820,
			 2820, 2820, 2820, 2820, 2820, 2820, 2820, 2820, 2820, 2820,
			 2820, 2820, 2820, 2820, 2820,  544, 2820, 2820, 1034,  931,
			 2820, 2553, 2820, 1009, 2820, 1024, 2481, 2820, 1126, 2820,
			 2820, 2820, 2469, 2820, 2477, 2463, 2820, 1341, 1437, 1056,
			 1129, 2472, 2820, 2820, 2820, 2820,  591, 2820,  904, 2820,
			  981, 2460, 2820, 1531, 1611, 1117,  997, 2426,  973,  178,

			 1000, 1143, 2820, 2389, 1045, 2820, 1694, 1790, 2366, 1197,
			 2820, 1226, 2820, 2820, 2369, 2365, 2287, 2276, 2273, 1136,
			 2271, 2200, 2158, 2095, 2093, 2012, 1931, 1901, 1880, 1835,
			 1801, 1797, 1777, 1753, 1737, 1733, 2820, 2820, 2820, 2820,
			 2820, 2820, 1717, 1200, 1140, 1280, 2820, 2820, 1359, 1361,
			 1370, 1372, 1394, 1387, 2820, 1542, 1398, 1581, 1089, 1624,
			 1163, 1559, 1625, 1546, 2820, 2820, 1062, 1568, 1065, 1212,
			 1577, 1632, 2820, 2820, 2820, 2820, 1580, 1639, 1661, 1263,
			 2820, 1685, 1712, 1583, 1570, 2820, 1561, 1530, 1045, 1061,
			    0,    0, 1046, 1669, 1107, 1099, 1101, 1172, 1117, 1125, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1190, 1261, 1285,    0, 1164, 1312, 1286, 1250, 1304, 1108,
			  935, 1350, 1538, 1494, 1543, 1541, 1565, 1390, 1609, 1379,
			    0, 1616, 1361, 1315, 1641, 1640, 1670, 1679, 1363, 1685,
			 1610, 1684, 1694, 1691, 1689, 1138, 1696, 1145, 1698, 1676,
			 1691, 1696, 1704, 1254,    0, 1793, 1751, 2820, 2820, 2820,
			 2820, 2820, 2820, 2820, 2820, 2820, 2820, 1796, 2820, 1799,
			 2820, 2820, 2820, 2820, 2820, 2820, 1799, 1804,    0, 1329,
			 2820, 1816, 1380, 1360, 2820, 1883, 1347, 1743, 1838, 2820,
			 2820, 2820, 2820, 1298, 2820, 1976, 1279, 1826,  579, 1364,
			 1248, 1742, 2820, 1233, 2820, 2820, 2820, 1827, 2820, 2820,

			 1834, 2820, 2820, 2820, 2820, 2820, 1988, 1835, 2820, 2820,
			 2820, 2820, 2820, 2820, 2820, 2820, 2820, 2820, 2820, 2820,
			 2820, 2820, 2820, 2820, 2820, 2820, 2004, 1846, 1850, 2820,
			 2820, 2820, 2820, 2820, 2820, 1883, 1917, 1926, 1931, 2023,
			 1784, 1166,    0, 1127, 1149, 2046, 2052, 2011, 1125, 1940,
			 1649, 2820, 2820, 2820, 2820, 2820, 2820, 2820, 1939, 2820,
			 2820, 1081, 1912, 1678, 1691, 1740, 1049, 1819, 1822, 1024,
			 1810, 1827, 1824, 1950,  987, 1859, 1983, 1980, 2003, 1298,
			 2006, 2013, 1995, 2012,    0, 2012, 2039,  927, 2028, 2047,
			 2037,    0, 1764,    0,    0, 1857, 2088,    0, 2042, 2042, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2047, 2047,  936, 2047, 2045, 1951,  845, 2055, 2049,    0,
			  844,    0,    0, 2063, 2063, 2049, 2061, 2070,    0,    0,
			 2820, 2820, 2820, 2820, 2820, 1225, 1660,    0, 2114,  797,
			  859,  753, 2066, 2820, 2069, 2820, 2076, 2820,  728, 1329,
			 2107,    0, 2123, 2128, 2132, 2136, 2156, 2160, 2167, 2178,
			 2820, 2820, 2089,    0,    0, 1864, 2072, 2108,    0,    0,
			 2112, 2170, 1891,    0, 2117, 2123, 2126, 2139, 2159, 2154,
			 1968,    0, 2159, 2164, 2175, 2173, 2174, 2181, 2177,    0,
			 2182, 2218, 2820,  712, 2187, 2167, 2184, 2184, 2191, 2179,
			 2193, 2179,    0, 2181, 2201,    0,    0, 2199, 2210,    0,

			 2204, 2242, 2246,  983,  652, 2214, 2221, 2210, 2820, 2251,
			 1076, 2259, 1218, 2270, 2279, 2288, 2293, 2304, 2315, 2321,
			    0,    0, 2238, 2244, 2269,    0,  649, 2272, 2239, 2255,
			    0,    0, 2282,    0, 2298, 2298,    0, 2291, 2290, 2296,
			 2297, 2319, 2301, 2820,  685, 2233, 2303, 2309, 2313,    0,
			 2319,    0,    0,    0, 2308, 2315,    0, 2313, 2820, 1957,
			 2820, 2347, 2820,  615,  576, 2329, 2322, 2335,  620,  571,
			  552,  469,  497,  467,  470,  410,  406, 2370, 2378, 2383,
			 2392, 2402, 2406, 2410, 2414, 2423, 2345, 2344,    0, 2377,
			    0, 2376, 2384, 2405, 2405,    0,    0,  275,    0,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2407, 2417, 2452,  244, 2422, 2425,    0, 2424, 2425,    0,
			    0, 2409,  186,  109, 2820, 2820, 2820, 2820, 2426, 2442,
			 2446, 2474, 2478, 2483, 2492, 2499, 2503,    0, 2435,    0,
			    0, 2440,    0,    0,    0, 2458,    0, 2525, 2468, 2468,
			    0, 2495,    0,    0,  104, 2820, 2820, 2496, 2515, 2523,
			    0, 2497,    0, 2498, 2502,    0,    0, 2820,    0, 2510,
			 2499, 2500, 2502, 2503,    0, 2820, 2820, 2589, 2601, 2613,
			 2625, 2637, 2543, 2575, 2649, 2549, 2655, 2665, 2677, 2689,
			 2701, 2713, 2723, 2734, 1731, 2023, 2162, 2746, 2758, 2116,
			 2366, 2466, 2768, 2780, yy_Dummy>>,
			1, 94, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 893)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (876, 166, 210)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (866, 312, 341)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (876, 387, 444)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (866, 501, 539)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (876, 563, 619)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (876, 652, 680)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (866, 867, 893)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  866,    1,  867,  867,  868,  868,  869,  869,  870,
			  870,  871,  871,  866,  866,  866,  866,  872,  866,  873,
			  866,  874,  866,  866,  872,  872,  866,  875,  866,  872,
			  866,  866,  866,  866,  872,  872,  872,  866,  866,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  866,  872,  866,
			  872,  866,  866,  872,  872,  872,  872,  872,  872,  872,
			  872,  872,  866,  866,  872,  872,  877,  866,  866,  866,
			  878,  878,  866,  866,  879,  880,  866,  866,  866,  866,
			  866,  866,  866,  866,  866,  866,  872,  875,  872,   18,

			   99,  866,  866,  881,   99,  100,  100,   18,  100,  100,
			  100,  100,   99,   99,   99,   99,   99,   99,  100,  100,
			   99,  873,  873,  882,  121,  883,  883,  883,  875,  872,
			  875,  872,  872,  866,  872,  872,  866,  866,  875,  872,
			  872,  872,  872,  866,  866,  884,  884,  885,  866,  866,
			  875,  872,  872,  872,  875,  872,  875,  872,  872,  872,
			  866,  866,   38,  886,  866,   38, yy_Dummy>>,
			1, 166, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  872,  875,  872,  875,  872,  875,  875,  875,  875,  875,
			  875,  872,  875,  872,  875,  866,  866,  875,  875,  877,
			  866,  866,  866,  866,  866,  866,  866,  866,  866,  866,
			  866,  866,  866,  866,  866,  866,  866,  866,  866,  866,
			  866,  866,  866,  866,  878,  866,  866,  878,  879,  866,
			  880,  866,  866,  866,  866,  887,  866,  875,  866,  866,
			  866,  100,  866,  107,  102,  866,  102,  866,  277,  881,
			   99,  866,  866,  866,  866,  100,  866,  100,  866,  100,
			  111,  866,   99,  107,  293,   99,   99,   99,   99,   99,
			   99,  866,   99,  100,  866,  882,  882,  121,  873,  866,

			  873, yy_Dummy>>,
			1, 101, 211)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  875,  872,  866,  866,  866,  866,  875,  872,  875,  872,
			  875,  872,  866,  866,  866,  866,  884,  884,  884,  885,
			  866,  866,  866,  866,  872,  875,  872,  872,  875,  872,
			  866,  866,  866,  866,  875,  872,  875,  872,  866,  164,
			  888,   38,  886,  866,  886, yy_Dummy>>,
			1, 45, 342)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  875,  872,  866,  866,  866,  866,  866,  866,  866,  866,
			  866,  866,  875,  866,  875,  866,  866,  866,  866,  866,
			  866,  866,  866,  887,  887,  866,  872,  107,  278,  866,
			  278,  277,  277,  881,  866,  866,  866,  866,  294,  866,
			   99,  293,  293,   99,   99,   99,   99,  866,   99,  866,
			  866,  866,  121,  866,  866,  882, yy_Dummy>>,
			1, 56, 445)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  884,  884,  360,  885,  866,  866,  866,  875,  866,  872,
			  872,  866,  866,  866,  866,  866,  866,  866,   38,  866,
			  866,  164,  888, yy_Dummy>>,
			1, 23, 540)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  866,  866,  866,  866,  866,  866,  866,  889,  866,  887,
			  475,  485,   99,  866,   99,  866,   99,  866,  866,  890,
			  890,  891,  866,  866,  866,  866,  866,  866,  866,  866,
			  866,  866, yy_Dummy>>,
			1, 32, 620)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  866,  866,  866,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  866,  866,  889,  887,   99,   99,   99,  866,  890,  890,
			  890,  891,  866,  866,  866,  866,  866,  866,  866,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  866,  892,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  866,  866,  866,
			  866,  866,  889,  887,   99,   99,   99,  866,  709,  866,
			  890,  866,  711,  866,  891,  866,  866,  866,  866,  866,

			  866,  866,  866,  866,  866,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  893,
			   99,   99,   99,  866,  866,  866,  866,  866,  866,  866,
			  866,  866,  866,  866,  866,  866,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  866,  876,  876,  876,
			  876,  876,  876,   99,  866,  866,  866,  866,  866,  876,
			  876,  876,  866,  876,  876,  876,  866,  876,  866,  876,
			  866,  876,  866,  876,  866,    0, yy_Dummy>>,
			1, 186, 681)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 127948)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (97, 127, 159)
			yy_ec_template_2 (an_array)
			an_array.area.fill_with (82, 216, 246)
			yy_ec_template_3 (an_array)
			an_array.area.fill_with (97, 256, 705)
			yy_ec_template_4 (an_array)
			an_array.area.fill_with (97, 768, 884)
			yy_ec_template_5 (an_array)
			an_array.area.fill_with (97, 904, 1013)
			an_array.put (85, 1014)
			an_array.area.fill_with (97, 1015, 1153)
			an_array.put (85, 1154)
			an_array.area.fill_with (97, 1155, 1369)
			an_array.area.fill_with (85, 1370, 1375)
			an_array.area.fill_with (97, 1376, 1416)
			yy_ec_template_6 (an_array)
			an_array.area.fill_with (97, 1424, 1469)
			yy_ec_template_7 (an_array)
			an_array.area.fill_with (97, 1479, 1522)
			yy_ec_template_8 (an_array)
			an_array.area.fill_with (97, 1568, 1641)
			an_array.area.fill_with (85, 1642, 1645)
			an_array.area.fill_with (97, 1646, 1747)
			yy_ec_template_9 (an_array)
			an_array.area.fill_with (97, 1806, 2037)
			yy_ec_template_10 (an_array)
			an_array.area.fill_with (97, 2048, 2095)
			an_array.area.fill_with (85, 2096, 2110)
			an_array.area.fill_with (97, 2111, 2141)
			an_array.put (85, 2142)
			an_array.area.fill_with (97, 2143, 2403)
			yy_ec_template_11 (an_array)
			an_array.area.fill_with (97, 2417, 2545)
			yy_ec_template_12 (an_array)
			an_array.area.fill_with (97, 2558, 2677)
			an_array.put (85, 2678)
			an_array.area.fill_with (97, 2679, 2799)
			an_array.area.fill_with (85, 2800, 2801)
			an_array.area.fill_with (97, 2802, 2927)
			an_array.put (85, 2928)
			an_array.area.fill_with (97, 2929, 3058)
			an_array.area.fill_with (85, 3059, 3066)
			an_array.area.fill_with (97, 3067, 3190)
			yy_ec_template_13 (an_array)
			an_array.area.fill_with (97, 3205, 3406)
			an_array.put (85, 3407)
			an_array.area.fill_with (97, 3408, 3448)
			an_array.put (85, 3449)
			an_array.area.fill_with (97, 3450, 3571)
			an_array.put (85, 3572)
			an_array.area.fill_with (97, 3573, 3646)
			yy_ec_template_14 (an_array)
			an_array.area.fill_with (97, 3676, 3840)
			yy_ec_template_15 (an_array)
			an_array.area.fill_with (97, 3897, 3972)
			an_array.put (85, 3973)
			an_array.area.fill_with (97, 3974, 4029)
			yy_ec_template_16 (an_array)
			an_array.area.fill_with (97, 4059, 4169)
			an_array.area.fill_with (85, 4170, 4175)
			an_array.area.fill_with (97, 4176, 4253)
			an_array.area.fill_with (85, 4254, 4255)
			an_array.area.fill_with (97, 4256, 4346)
			an_array.put (85, 4347)
			an_array.area.fill_with (97, 4348, 4959)
			an_array.area.fill_with (85, 4960, 4968)
			an_array.area.fill_with (97, 4969, 5007)
			an_array.area.fill_with (85, 5008, 5017)
			an_array.area.fill_with (97, 5018, 5119)
			an_array.put (85, 5120)
			an_array.area.fill_with (97, 5121, 5740)
			yy_ec_template_17 (an_array)
			an_array.area.fill_with (97, 5761, 5866)
			an_array.area.fill_with (85, 5867, 5869)
			an_array.area.fill_with (97, 5870, 5940)
			an_array.area.fill_with (85, 5941, 5942)
			an_array.area.fill_with (97, 5943, 6099)
			yy_ec_template_18 (an_array)
			an_array.area.fill_with (97, 6108, 6143)
			an_array.area.fill_with (85, 6144, 6154)
			an_array.area.fill_with (97, 6155, 6463)
			yy_ec_template_19 (an_array)
			an_array.area.fill_with (97, 6470, 6621)
			an_array.area.fill_with (85, 6622, 6655)
			an_array.area.fill_with (97, 6656, 6685)
			an_array.area.fill_with (85, 6686, 6687)
			an_array.area.fill_with (97, 6688, 6815)
			yy_ec_template_20 (an_array)
			an_array.area.fill_with (97, 6830, 7001)
			yy_ec_template_21 (an_array)
			an_array.area.fill_with (97, 7037, 7163)
			an_array.area.fill_with (85, 7164, 7167)
			an_array.area.fill_with (97, 7168, 7226)
			an_array.area.fill_with (85, 7227, 7231)
			an_array.area.fill_with (97, 7232, 7293)
			an_array.area.fill_with (85, 7294, 7295)
			an_array.area.fill_with (97, 7296, 7359)
			yy_ec_template_22 (an_array)
			an_array.area.fill_with (97, 7380, 8124)
			yy_ec_template_23 (an_array)
			an_array.area.fill_with (97, 8288, 8313)
			yy_ec_template_24 (an_array)
			an_array.area.fill_with (85, 8352, 8383)
			an_array.area.fill_with (97, 8384, 8447)
			yy_ec_template_25 (an_array)
			an_array.area.fill_with (97, 8528, 8585)
			yy_ec_template_26 (an_array)
			an_array.area.fill_with (85, 8592, 8657)
			an_array.put (87, 8658)
			an_array.area.fill_with (85, 8659, 8703)
			yy_ec_template_27 (an_array)
			an_array.area.fill_with (85, 8708, 8742)
			yy_ec_template_28 (an_array)
			an_array.area.fill_with (85, 8745, 8890)
			an_array.put (92, 8891)
			an_array.area.fill_with (85, 8892, 8967)
			an_array.area.fill_with (97, 8968, 8971)
			an_array.area.fill_with (85, 8972, 9000)
			an_array.area.fill_with (97, 9001, 9002)
			an_array.area.fill_with (85, 9003, 9254)
			an_array.area.fill_with (97, 9255, 9279)
			an_array.area.fill_with (85, 9280, 9290)
			an_array.area.fill_with (97, 9291, 9371)
			an_array.area.fill_with (85, 9372, 9449)
			an_array.area.fill_with (97, 9450, 9471)
			an_array.area.fill_with (85, 9472, 10087)
			an_array.area.fill_with (97, 10088, 10131)
			an_array.area.fill_with (85, 10132, 10180)
			an_array.area.fill_with (97, 10181, 10182)
			an_array.area.fill_with (85, 10183, 10213)
			yy_ec_template_29 (an_array)
			an_array.area.fill_with (85, 10228, 10626)
			an_array.area.fill_with (97, 10627, 10648)
			an_array.area.fill_with (85, 10649, 10711)
			an_array.area.fill_with (97, 10712, 10715)
			an_array.area.fill_with (85, 10716, 10747)
			an_array.area.fill_with (97, 10748, 10749)
			an_array.area.fill_with (85, 10750, 11123)
			an_array.area.fill_with (97, 11124, 11125)
			an_array.area.fill_with (85, 11126, 11157)
			an_array.put (97, 11158)
			an_array.area.fill_with (85, 11159, 11263)
			an_array.area.fill_with (97, 11264, 11492)
			yy_ec_template_30 (an_array)
			an_array.area.fill_with (97, 11520, 11631)
			an_array.put (85, 11632)
			an_array.area.fill_with (97, 11633, 11775)
			yy_ec_template_31 (an_array)
			an_array.area.fill_with (97, 11859, 11903)
			an_array.area.fill_with (85, 11904, 11929)
			an_array.put (97, 11930)
			an_array.area.fill_with (85, 11931, 12019)
			an_array.area.fill_with (97, 12020, 12031)
			an_array.area.fill_with (85, 12032, 12245)
			an_array.area.fill_with (97, 12246, 12271)
			yy_ec_template_32 (an_array)
			an_array.area.fill_with (97, 12352, 12442)
			yy_ec_template_33 (an_array)
			an_array.area.fill_with (97, 12449, 12538)
			an_array.put (85, 12539)
			an_array.area.fill_with (97, 12540, 12687)
			yy_ec_template_34 (an_array)
			an_array.area.fill_with (97, 12704, 12735)
			an_array.area.fill_with (85, 12736, 12771)
			an_array.area.fill_with (97, 12772, 12799)
			an_array.area.fill_with (85, 12800, 12830)
			an_array.area.fill_with (97, 12831, 12841)
			an_array.area.fill_with (85, 12842, 12871)
			yy_ec_template_35 (an_array)
			an_array.area.fill_with (85, 12896, 12927)
			an_array.area.fill_with (97, 12928, 12937)
			an_array.area.fill_with (85, 12938, 12976)
			an_array.area.fill_with (97, 12977, 12991)
			an_array.area.fill_with (85, 12992, 13311)
			an_array.area.fill_with (97, 13312, 19903)
			an_array.area.fill_with (85, 19904, 19967)
			an_array.area.fill_with (97, 19968, 42127)
			an_array.area.fill_with (85, 42128, 42182)
			an_array.area.fill_with (97, 42183, 42237)
			an_array.area.fill_with (85, 42238, 42239)
			an_array.area.fill_with (97, 42240, 42508)
			an_array.area.fill_with (85, 42509, 42511)
			an_array.area.fill_with (97, 42512, 42610)
			yy_ec_template_36 (an_array)
			an_array.area.fill_with (97, 42623, 42737)
			yy_ec_template_37 (an_array)
			an_array.area.fill_with (97, 42786, 42888)
			an_array.area.fill_with (84, 42889, 42890)
			an_array.area.fill_with (97, 42891, 43047)
			yy_ec_template_38 (an_array)
			an_array.area.fill_with (97, 43066, 43123)
			an_array.area.fill_with (85, 43124, 43127)
			an_array.area.fill_with (97, 43128, 43213)
			an_array.area.fill_with (85, 43214, 43215)
			an_array.area.fill_with (97, 43216, 43255)
			yy_ec_template_39 (an_array)
			an_array.area.fill_with (97, 43261, 43309)
			an_array.area.fill_with (85, 43310, 43311)
			an_array.area.fill_with (97, 43312, 43358)
			an_array.put (85, 43359)
			an_array.area.fill_with (97, 43360, 43456)
			yy_ec_template_40 (an_array)
			an_array.area.fill_with (97, 43488, 43611)
			yy_ec_template_41 (an_array)
			an_array.area.fill_with (97, 43642, 43741)
			yy_ec_template_42 (an_array)
			an_array.area.fill_with (97, 43762, 43866)
			yy_ec_template_43 (an_array)
			an_array.area.fill_with (97, 43884, 44010)
			an_array.put (85, 44011)
			an_array.area.fill_with (97, 44012, 62248)
			an_array.put (85, 62249)
			an_array.area.fill_with (97, 62250, 62385)
			an_array.area.fill_with (84, 62386, 62401)
			an_array.area.fill_with (97, 62402, 62971)
			yy_ec_template_44 (an_array)
			an_array.area.fill_with (97, 63084, 63232)
			yy_ec_template_45 (an_array)
			an_array.area.fill_with (97, 63265, 63291)
			yy_ec_template_46 (an_array)
			an_array.area.fill_with (97, 63297, 63323)
			yy_ec_template_47 (an_array)
			an_array.area.fill_with (97, 63334, 63455)
			yy_ec_template_48 (an_array)
			an_array.area.fill_with (97, 63486, 63743)
			an_array.area.fill_with (85, 63744, 63746)
			an_array.area.fill_with (97, 63747, 63798)
			an_array.area.fill_with (85, 63799, 63807)
			an_array.area.fill_with (97, 63808, 63864)
			yy_ec_template_49 (an_array)
			an_array.area.fill_with (97, 63905, 63951)
			an_array.area.fill_with (85, 63952, 63996)
			an_array.area.fill_with (97, 63997, 64414)
			an_array.put (85, 64415)
			an_array.area.fill_with (97, 64416, 64463)
			an_array.put (85, 64464)
			an_array.area.fill_with (97, 64465, 64878)
			an_array.put (85, 64879)
			an_array.area.fill_with (97, 64880, 65622)
			an_array.put (85, 65623)
			an_array.area.fill_with (97, 65624, 65654)
			an_array.area.fill_with (85, 65655, 65656)
			an_array.area.fill_with (97, 65657, 65822)
			an_array.put (85, 65823)
			an_array.area.fill_with (97, 65824, 65854)
			an_array.put (85, 65855)
			an_array.area.fill_with (97, 65856, 66127)
			an_array.area.fill_with (85, 66128, 66136)
			an_array.area.fill_with (97, 66137, 66174)
			an_array.put (85, 66175)
			an_array.area.fill_with (97, 66176, 66247)
			an_array.put (85, 66248)
			an_array.area.fill_with (97, 66249, 66287)
			an_array.area.fill_with (85, 66288, 66294)
			an_array.area.fill_with (97, 66295, 66360)
			an_array.area.fill_with (85, 66361, 66367)
			an_array.area.fill_with (97, 66368, 66456)
			an_array.area.fill_with (85, 66457, 66460)
			an_array.area.fill_with (97, 66461, 67244)
			an_array.put (85, 67245)
			an_array.area.fill_with (97, 67246, 67412)
			an_array.area.fill_with (85, 67413, 67417)
			an_array.area.fill_with (97, 67418, 67654)
			an_array.area.fill_with (85, 67655, 67661)
			an_array.area.fill_with (97, 67662, 67770)
			yy_ec_template_50 (an_array)
			an_array.area.fill_with (97, 67778, 67903)
			an_array.area.fill_with (85, 67904, 67907)
			an_array.area.fill_with (97, 67908, 67955)
			an_array.area.fill_with (85, 67956, 67957)
			an_array.area.fill_with (97, 67958, 68036)
			yy_ec_template_51 (an_array)
			an_array.area.fill_with (97, 68064, 68151)
			an_array.area.fill_with (85, 68152, 68157)
			an_array.area.fill_with (97, 68158, 68264)
			an_array.put (85, 68265)
			an_array.area.fill_with (97, 68266, 68682)
			yy_ec_template_52 (an_array)
			an_array.area.fill_with (97, 68702, 68805)
			an_array.put (85, 68806)
			an_array.area.fill_with (97, 68807, 69056)
			an_array.area.fill_with (85, 69057, 69079)
			an_array.area.fill_with (97, 69080, 69184)
			an_array.area.fill_with (85, 69185, 69187)
			an_array.area.fill_with (97, 69188, 69215)
			an_array.area.fill_with (85, 69216, 69228)
			an_array.area.fill_with (97, 69229, 69435)
			an_array.area.fill_with (85, 69436, 69439)
			an_array.area.fill_with (97, 69440, 69690)
			an_array.put (85, 69691)
			an_array.area.fill_with (97, 69692, 69955)
			an_array.area.fill_with (85, 69956, 69958)
			an_array.area.fill_with (97, 69959, 70113)
			an_array.put (85, 70114)
			an_array.area.fill_with (97, 70115, 70206)
			an_array.area.fill_with (85, 70207, 70214)
			an_array.area.fill_with (97, 70215, 70297)
			yy_ec_template_53 (an_array)
			an_array.area.fill_with (97, 70307, 70720)
			an_array.area.fill_with (85, 70721, 70725)
			an_array.area.fill_with (97, 70726, 70767)
			an_array.area.fill_with (85, 70768, 70769)
			an_array.area.fill_with (97, 70770, 71414)
			an_array.area.fill_with (85, 71415, 71416)
			an_array.area.fill_with (97, 71417, 71636)
			an_array.area.fill_with (85, 71637, 71665)
			yy_ec_template_54 (an_array)
			an_array.area.fill_with (97, 71680, 72815)
			an_array.area.fill_with (85, 72816, 72820)
			an_array.area.fill_with (97, 72821, 90733)
			an_array.area.fill_with (85, 90734, 90735)
			an_array.area.fill_with (97, 90736, 90868)
			an_array.put (85, 90869)
			an_array.area.fill_with (97, 90870, 90934)
			yy_ec_template_55 (an_array)
			an_array.area.fill_with (97, 90950, 91798)
			an_array.area.fill_with (85, 91799, 91802)
			an_array.area.fill_with (97, 91803, 92129)
			an_array.put (85, 92130)
			an_array.area.fill_with (97, 92131, 111771)
			yy_ec_template_56 (an_array)
			an_array.area.fill_with (97, 111776, 116735)
			an_array.area.fill_with (85, 116736, 116981)
			an_array.area.fill_with (97, 116982, 116991)
			an_array.area.fill_with (85, 116992, 117030)
			an_array.area.fill_with (97, 117031, 117032)
			an_array.area.fill_with (85, 117033, 117092)
			yy_ec_template_57 (an_array)
			an_array.area.fill_with (85, 117132, 117161)
			an_array.area.fill_with (97, 117162, 117165)
			an_array.area.fill_with (85, 117166, 117224)
			an_array.area.fill_with (97, 117225, 117247)
			an_array.area.fill_with (85, 117248, 117313)
			yy_ec_template_58 (an_array)
			an_array.area.fill_with (97, 117318, 117503)
			an_array.area.fill_with (85, 117504, 117590)
			an_array.area.fill_with (97, 117591, 118464)
			an_array.put (85, 118465)
			an_array.area.fill_with (97, 118466, 118490)
			an_array.put (85, 118491)
			an_array.area.fill_with (97, 118492, 118522)
			an_array.put (85, 118523)
			an_array.area.fill_with (97, 118524, 118548)
			an_array.put (85, 118549)
			an_array.area.fill_with (97, 118550, 118580)
			an_array.put (85, 118581)
			an_array.area.fill_with (97, 118582, 118606)
			an_array.put (85, 118607)
			an_array.area.fill_with (97, 118608, 118638)
			an_array.put (85, 118639)
			an_array.area.fill_with (97, 118640, 118664)
			an_array.put (85, 118665)
			an_array.area.fill_with (97, 118666, 118696)
			an_array.put (85, 118697)
			an_array.area.fill_with (97, 118698, 118722)
			an_array.put (85, 118723)
			an_array.area.fill_with (97, 118724, 118783)
			an_array.area.fill_with (85, 118784, 119295)
			an_array.area.fill_with (97, 119296, 119350)
			an_array.area.fill_with (85, 119351, 119354)
			an_array.area.fill_with (97, 119355, 119404)
			yy_ec_template_59 (an_array)
			an_array.area.fill_with (97, 119436, 121166)
			an_array.put (85, 121167)
			an_array.area.fill_with (97, 121168, 121598)
			an_array.put (85, 121599)
			an_array.area.fill_with (97, 121600, 123229)
			an_array.area.fill_with (85, 123230, 123231)
			an_array.area.fill_with (97, 123232, 124075)
			yy_ec_template_60 (an_array)
			an_array.area.fill_with (97, 124081, 124205)
			an_array.put (85, 124206)
			an_array.area.fill_with (97, 124207, 124655)
			an_array.area.fill_with (85, 124656, 124657)
			an_array.area.fill_with (97, 124658, 124927)
			an_array.area.fill_with (85, 124928, 124971)
			an_array.area.fill_with (97, 124972, 124975)
			an_array.area.fill_with (85, 124976, 125075)
			yy_ec_template_61 (an_array)
			an_array.area.fill_with (85, 125137, 125173)
			an_array.area.fill_with (97, 125174, 125196)
			an_array.area.fill_with (85, 125197, 125357)
			an_array.area.fill_with (97, 125358, 125413)
			an_array.area.fill_with (85, 125414, 125442)
			an_array.area.fill_with (97, 125443, 125455)
			an_array.area.fill_with (85, 125456, 125499)
			yy_ec_template_62 (an_array)
			an_array.area.fill_with (97, 125542, 125695)
			an_array.area.fill_with (85, 125696, 125946)
			an_array.area.fill_with (84, 125947, 125951)
			an_array.area.fill_with (85, 125952, 126679)
			yy_ec_template_63 (an_array)
			an_array.area.fill_with (85, 126720, 126835)
			an_array.area.fill_with (97, 126836, 126847)
			an_array.area.fill_with (85, 126848, 126936)
			yy_ec_template_64 (an_array)
			an_array.area.fill_with (85, 126992, 127047)
			yy_ec_template_65 (an_array)
			an_array.area.fill_with (85, 127072, 127111)
			an_array.area.fill_with (97, 127112, 127119)
			an_array.area.fill_with (85, 127120, 127149)
			yy_ec_template_66 (an_array)
			an_array.area.fill_with (97, 127154, 127231)
			an_array.area.fill_with (85, 127232, 127352)
			an_array.put (97, 127353)
			an_array.area.fill_with (85, 127354, 127435)
			an_array.put (97, 127436)
			an_array.area.fill_with (85, 127437, 127571)
			yy_ec_template_67 (an_array)
			an_array.area.fill_with (85, 127632, 127656)
			yy_ec_template_68 (an_array)
			an_array.area.fill_with (97, 127703, 127743)
			an_array.area.fill_with (85, 127744, 127890)
			an_array.put (97, 127891)
			an_array.area.fill_with (85, 127892, 127946)
			an_array.area.fill_with (97, 127947, 127948)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,   97,   97,   97,   97,   97,   97,   97,   97,    1,
			    2,    1,    1,    1,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,    3,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   21,   21,   21,   21,   21,   22,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   36,   68,   69,   39,   40,   70,   42,
			   71,   44,   45,   72,   73,   74,   75,   76,   77,   52,
			   53,   54,   55,   78,    9,   79,   80, yy_Dummy>>,
			1, 127, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    4,    4,    4,    4,    4,   81,    4,   61,    4,
			   82,   82,   83,   82,    4,   61,    4,    4,   82,   82,
			   61,   82,    4,    4,   61,   82,   82,   82,   82,   82,
			   82,    4,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,    4, yy_Dummy>>,
			1, 56, 160)
		end

	yy_ec_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    4,   82,   82,   82,   82,   82,   82,   82,   82, yy_Dummy>>,
			1, 9, 247)
		end

	yy_ec_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   97,   97,   97,   97,   97,   84,   84,   84,   84,   84,
			   84,   84,   97,   84,   97,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84, yy_Dummy>>,
			1, 62, 706)
		end

	yy_ec_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   97,   97,   97,   97,   97,   97,   97,   97,   85,
			   97,   97,   97,   97,   97,   84,   84,   97,   85, yy_Dummy>>,
			1, 19, 885)
		end

	yy_ec_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   85,   85,   85, yy_Dummy>>,
			1, 7, 1417)
		end

	yy_ec_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   85,   97,   97,   85,   97,   97,   85, yy_Dummy>>,
			1, 9, 1470)
		end

	yy_ec_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   97,   97,   85,   85, yy_Dummy>>,
			1, 45, 1523)
		end

	yy_ec_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   85,   85,   97,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 58, 1748)
		end

	yy_ec_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   97,   97,   97,   97,   85,   85, yy_Dummy>>,
			1, 10, 2038)
		end

	yy_ec_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   85, yy_Dummy>>,
			1, 13, 2404)
		end

	yy_ec_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   97,   97,   85,   85,
			   97,   85, yy_Dummy>>,
			1, 12, 2546)
		end

	yy_ec_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   97,   97,   97,   97,   97,   85,   97,
			   97,   97,   97,   85, yy_Dummy>>,
			1, 14, 3191)
		end

	yy_ec_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   85,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   85,   85, yy_Dummy>>,
			1, 29, 3647)
		end

	yy_ec_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   97,   97,   85,   85,   85,   85,   85,
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   85,   97,   85,   97,   85, yy_Dummy>>,
			1, 56, 3841)
		end

	yy_ec_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   97,   85,
			   85,   85,   85,   85,   85,   97,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 29, 4030)
		end

	yy_ec_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,    1, yy_Dummy>>,
			1, 20, 5741)
		end

	yy_ec_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   97,   85,   85,   85,   85, yy_Dummy>>,
			1, 8, 6100)
		end

	yy_ec_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   97,   85,   85, yy_Dummy>>,
			1, 6, 6464)
		end

	yy_ec_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   97,   85,   85,
			   85,   85,   85,   85, yy_Dummy>>,
			1, 14, 6816)
		end

	yy_ec_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   85,   85,   85,   85,
			   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 35, 7002)
		end

	yy_ec_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   85, yy_Dummy>>,
			1, 20, 7360)
		end

	yy_ec_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   97,   84,   84,   84,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   84,   84,   84,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   84,   84,   84,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   84,   84,
			   84,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   84,   84,   97,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,   97,   97,
			   97,   97,   97,   85,   85,   85,   85,   85,   85,   85,
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   85,

			   85,   85,   85,   85,   85,   86,   85,   97,   97,   97,
			   97,   97,   97,   97,    1,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   97,   97,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   97,   97,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,    1, yy_Dummy>>,
			1, 163, 8125)
		end

	yy_ec_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   85,   85,   85,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 38, 8314)
		end

	yy_ec_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   85,   85,   85,   85,   97,   85,   85,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   97,   85,   85,   85,   97,   97,   97,   97,   97,
			   85,   85,   85,   85,   85,   85,   97,   85,   97,   85,
			   97,   85,   97,   97,   97,   97,   85,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   85,   85,
			   97,   97,   97,   97,   85,   85,   85,   85,   85,   97,
			   97,   97,   97,   97,   85,   85,   85,   85,   97,   85, yy_Dummy>>,
			1, 80, 8448)
		end

	yy_ec_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97, yy_Dummy>>,
			1, 6, 8586)
		end

	yy_ec_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   88,   85,   85,   89, yy_Dummy>>,
			1, 4, 8704)
		end

	yy_ec_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   90,   91, yy_Dummy>>,
			1, 2, 8743)
		end

	yy_ec_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   93,   94,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   85,   95,   96, yy_Dummy>>,
			1, 14, 10214)
		end

	yy_ec_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   85,   85,   85,   97,   85,   85, yy_Dummy>>,
			1, 27, 11493)
		end

	yy_ec_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   85,   85,   85,   97,
			   97,   85,   97,   97,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   97,   97,
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   85,   85,   85,   85,   85,   97,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   97,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85, yy_Dummy>>,
			1, 83, 11776)
		end

	yy_ec_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   97,   97,   97,   97,    1,   85,   85,   85,
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   85,   85,   97,   97,   97,   97,
			   97,   97,   97,   97,   85,   97,   97,   97,   85,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   85,   97,   97,   97,   97,   97,
			   85,   85,   97,   97,   97,   97,   97,   85,   85,   85, yy_Dummy>>,
			1, 80, 12272)
		end

	yy_ec_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   97,   97,   97,   85, yy_Dummy>>,
			1, 6, 12443)
		end

	yy_ec_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 16, 12688)
		end

	yy_ec_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   85,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97, yy_Dummy>>,
			1, 24, 12872)
		end

	yy_ec_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   85, yy_Dummy>>,
			1, 12, 42611)
		end

	yy_ec_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   97,   97,   97,   97,
			   97,   97,   97,   97,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   84,   84, yy_Dummy>>,
			1, 48, 42738)
		end

	yy_ec_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   85,   85,   85,   85, yy_Dummy>>,
			1, 18, 43048)
		end

	yy_ec_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   97,   85, yy_Dummy>>,
			1, 5, 43256)
		end

	yy_ec_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   85,
			   85, yy_Dummy>>,
			1, 31, 43457)
		end

	yy_ec_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   85,   85,   85, yy_Dummy>>,
			1, 30, 43612)
		end

	yy_ec_template_42 (an_array: ARRAY [INTEGER])
			-- Fill chunk #42 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   85,   85, yy_Dummy>>,
			1, 20, 43742)
		end

	yy_ec_template_43 (an_array: ARRAY [INTEGER])
			-- Fill chunk #43 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   84,   84, yy_Dummy>>,
			1, 17, 43867)
		end

	yy_ec_template_44 (an_array: ARRAY [INTEGER])
			-- Fill chunk #44 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   85,   85,   85,   85,   85,   85,   97,   97,   85,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   85,   85,   85,   85,   85,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   85,   85,   97,   97,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   97,   85,   85,
			   85,   85,   85,   97,   97,   97,   97,   97,   97,   85,

			   85,   85,   85,   85,   85,   85,   85,   97,   85,   85,
			   85,   85, yy_Dummy>>,
			1, 112, 62972)
		end

	yy_ec_template_45 (an_array: ARRAY [INTEGER])
			-- Fill chunk #45 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   97,   97,   85,
			   85,   85,   85,   85,   85,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   85,   85,   85,   85,   85,
			   85,   85, yy_Dummy>>,
			1, 32, 63233)
		end

	yy_ec_template_46 (an_array: ARRAY [INTEGER])
			-- Fill chunk #46 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   84,   85,   84, yy_Dummy>>,
			1, 5, 63292)
		end

	yy_ec_template_47 (an_array: ARRAY [INTEGER])
			-- Fill chunk #47 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   85,   97,   97,   85,   97,   97,   85,   85, yy_Dummy>>,
			1, 10, 63324)
		end

	yy_ec_template_48 (an_array: ARRAY [INTEGER])
			-- Fill chunk #48 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   84,   85,   85,   85,   97,   85,   85,
			   85,   85,   85,   85,   85,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   85,   85, yy_Dummy>>,
			1, 30, 63456)
		end

	yy_ec_template_49 (an_array: ARRAY [INTEGER])
			-- Fill chunk #49 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   97,   97,   85,
			   85,   85,   97,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   97,   97,   97,   85, yy_Dummy>>,
			1, 40, 63865)
		end

	yy_ec_template_50 (an_array: ARRAY [INTEGER])
			-- Fill chunk #50 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   97,   85,   85,   85,   85, yy_Dummy>>,
			1, 7, 67771)
		end

	yy_ec_template_51 (an_array: ARRAY [INTEGER])
			-- Fill chunk #51 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   97,   97,   97,   97,   85,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   85,   97,   85,   85,   85, yy_Dummy>>,
			1, 27, 68037)
		end

	yy_ec_template_52 (an_array: ARRAY [INTEGER])
			-- Fill chunk #52 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   85,   85,   97,   85, yy_Dummy>>,
			1, 19, 68683)
		end

	yy_ec_template_53 (an_array: ARRAY [INTEGER])
			-- Fill chunk #53 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   97,   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 9, 70298)
		end

	yy_ec_template_54 (an_array: ARRAY [INTEGER])
			-- Fill chunk #54 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   85, yy_Dummy>>,
			1, 14, 71666)
		end

	yy_ec_template_55 (an_array: ARRAY [INTEGER])
			-- Fill chunk #55 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   97,
			   97,   97,   97,   85,   85, yy_Dummy>>,
			1, 15, 90935)
		end

	yy_ec_template_56 (an_array: ARRAY [INTEGER])
			-- Fill chunk #56 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   85, yy_Dummy>>,
			1, 4, 111772)
		end

	yy_ec_template_57 (an_array: ARRAY [INTEGER])
			-- Fill chunk #57 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   85,   85,   85,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   85,   85,   97,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 39, 117093)
		end

	yy_ec_template_58 (an_array: ARRAY [INTEGER])
			-- Fill chunk #58 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   85, yy_Dummy>>,
			1, 4, 117314)
		end

	yy_ec_template_59 (an_array: ARRAY [INTEGER])
			-- Fill chunk #59 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   97,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   97,   85,   85,   85,   85,   85,   85,
			   85, yy_Dummy>>,
			1, 31, 119405)
		end

	yy_ec_template_60 (an_array: ARRAY [INTEGER])
			-- Fill chunk #60 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   85,   97,   97,   97,   85, yy_Dummy>>,
			1, 5, 124076)
		end

	yy_ec_template_61 (an_array: ARRAY [INTEGER])
			-- Fill chunk #61 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   97,   97,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   97,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   97, yy_Dummy>>,
			1, 61, 125076)
		end

	yy_ec_template_62 (an_array: ARRAY [INTEGER])
			-- Fill chunk #62 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   97,   97,   97,   97,   97,   97,   97,
			   85,   85,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   85,   85,   85,   85,
			   85,   85, yy_Dummy>>,
			1, 42, 125500)
		end

	yy_ec_template_63 (an_array: ARRAY [INTEGER])
			-- Fill chunk #63 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   97,   97,   97,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   97,   97,   97, yy_Dummy>>,
			1, 40, 126680)
		end

	yy_ec_template_64 (an_array: ARRAY [INTEGER])
			-- Fill chunk #64 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   97,   97,   97,   97, yy_Dummy>>,
			1, 55, 126937)
		end

	yy_ec_template_65 (an_array: ARRAY [INTEGER])
			-- Fill chunk #65 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   97,   97,
			   97,   97,   97,   97, yy_Dummy>>,
			1, 24, 127048)
		end

	yy_ec_template_66 (an_array: ARRAY [INTEGER])
			-- Fill chunk #66 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   85,   85, yy_Dummy>>,
			1, 4, 127150)
		end

	yy_ec_template_67 (an_array: ARRAY [INTEGER])
			-- Fill chunk #67 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   97,   97,   85,   85,
			   85,   85,   85,   97,   97,   97,   85,   85,   85,   97,
			   97,   97,   97,   97,   85,   85,   85,   85,   85,   85,
			   85,   97,   97,   97,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 60, 127572)
		end

	yy_ec_template_68 (an_array: ARRAY [INTEGER])
			-- Fill chunk #68 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   85,   85,   85,
			   85,   85,   85,   85,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   85,   85,   85,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   85,
			   85,   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 46, 127657)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    1,    3,    4,    3,    5,    6,    3,
			    5,    5,    5,    3,    3,    5,    3,    3,    3,    7,
			    7,    7,    7,    5,    5,    3,    3,    3,    5,    3,
			    8,    8,    8,    8,    8,    8,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    5,    3,    5,    3,
			   10,    3,    8,    8,    8,    8,    8,    8,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    5,    5,
			    3,    3,    5,    3,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   12,   12,   11,   11,   12, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 867)
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
			   23,   26,   29,   32,   35,   39,   43,   46,   49,   52,
			   56,   59,   62,   65,   68,   72,   76,   80,   83,   88,
			   91,   94,   97,  100,  103,  106,  109,  112,  115,  118,
			  121,  124,  127,  130,  133,  136,  139,  142,  145,  148,
			  151,  155,  158,  161,  165,  169,  173,  177,  181,  185,
			  189,  193,  197,  200,  203,  207,  211,  213,  215,  217,
			  219,  221,  223,  225,  227,  229,  231,  233,  235,  237,
			  239,  241,  244,  246,  248,  249,  249,  250,  250,  251,

			  252,  253,  254,  255,  255,  256,  257,  258,  259,  260,
			  261,  262,  263,  264,  265,  266,  267,  268,  270,  271,
			  272,  274,  276,  277,  277,  279,  280,  281,  282,  282,
			  283,  283,  284,  285,  286,  287,  289,  290,  291,  291,
			  292,  294,  296,  298,  299,  300,  300,  300,  300,  300,
			  301,  301,  302,  304,  306,  306,  307,  307,  308,  310,
			  312,  312,  313,  315,  316,  316,  318,  319,  320,  321,
			  322,  323,  325,  326,  327,  328,  329,  330,  331,  332,
			  334,  335,  336,  337,  338,  339,  340,  342,  343,  344,
			  346,  347,  348,  349,  350,  351,  352,  354,  355,  356, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  357,  358,  359,  360,  361,  362,  363,  364,  365,  366,
			  367,  368,  370,  370,  371,  371,  372,  372,  372,  372,
			  372,  372,  372,  374,  374,  376,  376,  376,  376,  376,
			  376,  377,  378,  378,  379,  380,  381,  382,  383,  383,
			  384,  385,  386,  387,  388,  389,  390,  391,  392,  393,
			  394,  395,  396,  397,  398,  399,  400,  401,  402,  403,
			  404,  406,  407,  408,  408,  409,  410,  411,  412,  413,
			  414,  415,  416,  417,  419,  420,  421,  424,  425,  426,
			  428,  429,  430,  433,  436,  438,  441,  442,  445,  446,
			  449,  450,  451,  454,  455,  456,  458,  459,  460,  461,

			  462,  463,  464,  465,  466,  467,  470,  472,  473,  475,
			  476,  478,  480,  481,  483,  484,  485,  486,  487,  488,
			  489,  490,  491,  492,  493,  494,  495,  496,  497,  498,
			  499,  500,  501,  502,  503,  504,  505,  507,  509,  511,
			  513,  515,  516,  516,  517,  518,  518,  520,  522,  523,
			  524,  525,  526,  527,  528,  529,  530,  530,  531,  533,
			  534,  536,  537,  538,  538,  540,  542,  544,  546,  547,
			  548,  549,  550,  552,  554,  556,  558,  559,  560,  561,
			  562,  563,  565,  566,  568,  569,  572,  574,  575,  576,
			  577,  579,  581,  582,  583,  584,  585,  586,  587,  588, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  589,  590,  591,  592,  594,  595,  596,  597,  598,  599,
			  600,  601,  602,  603,  604,  605,  606,  607,  608,  610,
			  611,  613,  614,  615,  616,  617,  618,  619,  620,  621,
			  622,  623,  624,  625,  626,  627,  628,  629,  630,  631,
			  632,  633,  634,  635,  636,  638,  639,  640,  642,  644,
			  646,  648,  650,  652,  654,  656,  658,  660,  661,  663,
			  664,  666,  667,  668,  670,  672,  673,  673,  673,  674,
			  675,  676,  677,  678,  679,  681,  682,  683,  685,  685,
			  687,  690,  693,  696,  697,  699,  700,  701,  703,  704,
			  705,  706,  707,  709,  710,  712,  715,  717,  719,  720,

			  721,  721,  722,  723,  724,  725,  726,  727,  728,  729,
			  730,  731,  732,  733,  734,  735,  736,  737,  738,  739,
			  740,  741,  742,  743,  744,  746,  748,  749,  749,  750,
			  752,  754,  756,  758,  760,  762,  763,  763,  763,  764,
			  765,  765,  765,  765,  765,  765,  766,  767,  768,  770,
			  772,  774,  776,  778,  780,  782,  784,  786,  788,  790,
			  791,  792,  792,  792,  793,  794,  795,  796,  797,  798,
			  799,  800,  801,  802,  803,  804,  805,  806,  808,  809,
			  810,  811,  812,  813,  814,  816,  817,  818,  819,  820,
			  821,  822,  824,  825,  827,  829,  830,  832,  834,  835, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  836,  837,  838,  839,  840,  841,  842,  843,  844,  845,
			  847,  848,  850,  852,  853,  854,  855,  856,  857,  859,
			  861,  863,  865,  867,  869,  870,  870,  870,  870,  870,
			  871,  872,  873,  874,  876,  877,  879,  880,  882,  883,
			  883,  883,  883,  883,  884,  884,  885,  885,  886,  887,
			  888,  890,  891,  892,  894,  896,  897,  898,  899,  901,
			  903,  904,  905,  906,  908,  909,  910,  911,  912,  913,
			  914,  915,  917,  918,  919,  920,  921,  922,  923,  924,
			  926,  927,  927,  928,  928,  929,  930,  931,  932,  933,
			  934,  935,  936,  938,  939,  940,  942,  944,  945,  946,

			  948,  949,  949,  949,  949,  950,  951,  952,  953,  954,
			  954,  954,  954,  954,  954,  954,  955,  956,  956,  956,
			  957,  959,  961,  962,  963,  964,  966,  967,  968,  969,
			  970,  972,  974,  975,  977,  978,  979,  981,  982,  983,
			  984,  985,  986,  987,  988,  988,  989,  990,  991,  992,
			  994,  995,  997,  999, 1001, 1002, 1003, 1005, 1006, 1007,
			 1007, 1008, 1008, 1009, 1009, 1010, 1011, 1012, 1013, 1013,
			 1013, 1013, 1013, 1013, 1013, 1013, 1013, 1013, 1013, 1014,
			 1015, 1015, 1015, 1016, 1016, 1017, 1017, 1018, 1019, 1021,
			 1022, 1024, 1025, 1026, 1027, 1028, 1030, 1032, 1033, 1035, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1045, 1046, 1047,
			 1049, 1051, 1052, 1053, 1054, 1056, 1057, 1059, 1060, 1061,
			 1061, 1062, 1062, 1063, 1064, 1064, 1064, 1065, 1067, 1068,
			 1070, 1072, 1073, 1075, 1077, 1079, 1080, 1082, 1082, 1083,
			 1084, 1086, 1087, 1089, 1091, 1092, 1094, 1096, 1097, 1097,
			 1098, 1100, 1101, 1103, 1103, 1104, 1106, 1108, 1110, 1112,
			 1112, 1113, 1113, 1114, 1114, 1116, 1117, 1117, yy_Dummy>>,
			1, 68, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1116)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			yy_acclist_template_3 (an_array)
			yy_acclist_template_4 (an_array)
			yy_acclist_template_5 (an_array)
			yy_acclist_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			    0,  206,  206,  208,  208,  242,  240,  241,    1,  240,
			  241,    1,  241,   55,  240,  241,  209,  240,  241,   55,
			   62,  240,  241,   14,  240,  241,  173,  240,  241,   25,
			  240,  241,   26,  240,  241,   33,   55,  240,  241,   31,
			   55,  240,  241,    9,  240,  241,   32,  240,  241,   13,
			  240,  241,   34,   55,  240,  241,  138,  240,  241,  138,
			  240,  241,    8,  240,  241,    7,  240,  241,   19,   55,
			  240,  241,   18,   55,  240,  241,   20,   55,  240,  241,
			   11,  240,  241,   15,   55,   59,  240,  241,  137,  240,
			  241,  137,  240,  241,  137,  240,  241,  137,  240,  241,

			  137,  240,  241,  137,  240,  241,  137,  240,  241,  137,
			  240,  241,  137,  240,  241,  137,  240,  241,  137,  240,
			  241,  137,  240,  241,  137,  240,  241,  137,  240,  241,
			  137,  240,  241,  137,  240,  241,  137,  240,  241,  137,
			  240,  241,   29,  240,  241,   55,  240,  241,   30,  240,
			  241,   35,   55,  240,  241,   27,  240,  241,   28,  240,
			  241,   12,   55,  240,  241,   43,   55,  240,  241,   48,
			   55,  240,  241,   53,   55,  240,  241,   41,   55,  240,
			  241,   42,   55,  240,  241,   49,   55,  240,  241,   51,
			   55,  240,  241,   54,   55,  240,  241,   46,  240,  241, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   47,  240,  241,   45,   55,  240,  241,   44,   55,  240,
			  241,  210,  241,  239,  241,  237,  241,  238,  241,  206,
			  241,  206,  241,  205,  241,  204,  241,  206,  241,  208,
			  241,  207,  241,  202,  241,  202,  241,  201,  241,    6,
			  241,    5,    6,  241,    5,  241,    6,  241,    1,   55,
			   55,  209,  209,  198,  209,  209,  209,  209,  209,  209,
			  209,  209,  209,  209,  209,  209,  209,  209,  209, -441,
			  209,  209,  209, -441,   55,   62,   62,   55,   62,  173,
			  173,  173,   55,   55,   55,    2,   55,   36,   55,   10,
			  144,   55,   39,   55,   24,   55,   23,   55,  144,  138,

			   16,   55,   37,   55,   21,   55,   55,   55,   22,   55,
			   38,   55,   17,   55,   59,   59,   55,   59,  137,  137,
			  137,  137,  137,   70,  137,  137,  137,  137,  137,  137,
			  137,  137,   83,  137,  137,  137,  137,  137,  137,  137,
			   95,  137,  137,  137,  101,  137,  137,  137,  137,  137,
			  137,  137,  113,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,   40,   55,
			   55,   55,   50,   55,   52,   55,  210,  237,  227,  225,
			  226,  228,  229,  230,  231,  211,  212,  213,  214,  215,
			  216,  217,  218,  219,  220,  221,  222,  223,  224,  206, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  205,  204,  206,  206,  203,  204,  208,  207,  201,    5,
			    4,    2,   55,   58,   56,  199,  209,  195,  199,  209,
			  209,  195,  197,  199,  209,  209,  209, -441, -441,  209,
			  181,  195,  199,  179,  195,  199,  180,  199,  182,  195,
			  199,  209,  175,  195,  199,  209,  176,  195,  199,  209,
			  209,  195,  196,  199,  209,  209,  209, -441,  209,  209,
			  209,  209,  209,  209, -200,  209,  209,  183,  195,  199,
			   55,   62,   62,   55,   62,   62,   58,   64,   56,   62,
			  173,  145,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,

			  173,  173,  173,  173,  173,  146,  173,   33,   58,   33,
			   56,   31,   58,   31,   56,   32,   55,  144,   34,   58,
			   34,   56,   55,   55,   55,   55,   55,   55,  139,  144,
			  138,  142,  143,  143,  141,  143,  140,  138,   19,   58,
			   19,   56,   37,   55,   37,   55,   55,   55,   55,   55,
			   18,   58,   18,   56,   20,   58,   20,   56,   55,   55,
			   55,   55,   11,   55,   59,   59,   55,   59,   59,   15,
			   58,   61,   56,   59,  137,  137,  137,   68,  137,   69,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,   86,  137,  137,  137,  137,  137,  137,  137, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  137,  137,  137,  137,  137,  137,  137,  137,  105,  137,
			  137,  108,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  136,  137,   55,   55,
			   35,   58,   35,   56,   12,   58,   12,   56,   43,   58,
			   48,   58,   53,   58,   41,   58,   42,   58,   49,   58,
			   55,   51,   58,   55,   54,   58,   46,   47,   45,   58,
			   44,   58,  236,    4,    4,   57,   55,  209,  209,  197,
			  199,  209,  209,  209, -441,  187,  199,  184,  195,  199,
			  177,  195,  199,  178,  195,  199,  209,  196,  199,  209,

			  209,  209, -441,  209,  209,  209,  209,  192,  199,  209,
			  186,  199,  185,  195,  199,   57,   63,   55,   62,   63,
			   64,  163,  161,  162,  164,  165,  174,  174,  166,  167,
			  147,  148,  149,  150,  151,  152,  153,  154,  155,  156,
			  157,  158,  159,  160,   36,   58,   36,   56,  144,  144,
			   39,   58,   39,   56,   24,   58,   24,   56,   23,   58,
			   23,   56,  144,  144,  138,  138,  138,   55,   37,   58,
			   37,   55,   37,   55,   21,   58,   21,   56,   22,   58,
			   22,   56,   38,   58,   57,   60,   58,   61,   55,   59,
			   60,   61,  137,  137,  137,  137,  137,  137,  137,  137, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  137,  137,  137,  137,  137,  137,   84,  137,  137,  137,
			  137,  137,  137,  137,   93,  137,  137,  137,  137,  137,
			  137,  137,  102,  137,  137,  104,  137,  106,  137,  137,
			  111,  137,  112,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  125,  137,  137,  127,  137,
			  128,  137,  137,  137,  137,  137,  137,  134,  137,  135,
			  137,   40,   58,   40,   56,   50,   58,   52,   58,  232,
			    4,  209,  209,  209,  188,  199,  209,  191,  199,  209,
			  194,  199,  174,  144,  144,  144,  144,  138,   37,   58,
			   37,  137,   66,  137,   67,  137,  137,  137,  137,   74,

			  137,   75,  137,  137,  137,  137,   80,  137,  137,  137,
			  137,  137,  137,  137,  137,   91,  137,  137,  137,  137,
			  137,  137,  137,  137,  103,  137,  137,  109,  137,  137,
			  137,  137,  137,  137,  137,  137,  122,  137,  137,  137,
			  126,  137,  129,  137,  137,  137,  132,  137,  137,    4,
			  209,  209,  209,  168,  144,  144,  144,   65,  137,   71,
			  137,  137,  137,  137,   77,  137,  137,  137,  137,  137,
			   85,  137,   87,  137,  137,   89,  137,  137,  137,   94,
			  137,  137,  137,  137,  137,  137,  137,  110,  137,  137,
			  137,  137,  118,  137,  137,  120,  137,  121,  137,  123, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  137,  137,  137,  131,  137,  137,  235,  234,  233,    4,
			  209,  209,  209,  144,  144,  144,  144,  137,  137,   76,
			  137,  137,   79,  137,  137,  137,  137,  137,   92,  137,
			   96,  137,  137,   98,  137,   99,  137,  137,  137,  137,
			  137,  137,  137,  119,  137,  137,  137,  133,  137,    3,
			    4,  209,  209,  209,  171,  172,  172,  170,  172,  169,
			  144,  144,  144,  144,  144,   72,  137,  137,   78,  137,
			   81,  137,  137,   88,  137,   90,  137,   97,  137,  137,
			  107,  137,  137,  137,  116,  137,  137,  124,  137,  130,
			  137,  209,  190,  199,  193,  199,  144,  144,   73,  137,

			  137,  100,  137,  137,  115,  137,  117,  137,  189,  199,
			   82,  137,  137,  137,  114,  137,  114, yy_Dummy>>,
			1, 117, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2820
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 866
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 867
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 97
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 127947
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

	yyNb_rules: INTEGER = 241
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 242
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
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end
