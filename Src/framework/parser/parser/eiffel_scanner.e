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
			
when 63 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 64 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 65 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 66 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 67 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 68 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 69 then
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
			
when 70 then
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
			
when 71 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 72 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 73 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 74 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 75 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 76 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 77 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 78 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 79 then
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
			
when 80 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 81 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 82 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 83 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 84 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 85 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 86 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 87 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 88 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 89 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 90 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 91 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 92 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 93 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 94 then
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
			
when 95 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 96 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 97 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 98 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 99 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 100 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 101 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 102 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 103 then
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
			
when 104 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 105 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 106 then
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
			
when 107 then
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
			
when 108 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 109 then
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
			
when 110 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 111 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 112 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 113 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 114 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 115 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 116 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 117 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 118 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 119 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 120 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 121 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 122 then
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
			
when 123 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 126 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 127 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 128 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 129 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 130 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 133 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 134 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 135 then
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
			
when 136 then
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
			
when 137 then
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
			
when 138 then
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
			
when 139 then
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
			
when 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 141 then
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
			
when 142 then
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
			
when 143 then
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
			
when 144 then
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
			
when 145 then
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
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
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
			
when 154 then
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
			
when 155 then
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
			
when 156 then
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
			
when 157 then
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
			
when 158 then
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
			
when 159 then
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
			
when 160 then
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
			
when 161 then
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
			
when 162 then
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
			
when 163 then
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
			
when 164 then
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
			
when 165 then
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
			
when 166 then
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
			
when 167 then
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
				report_invalid_integer_error (token_buffer)
			
when 170 then
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
			
when 171 then
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
			
when 172 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 173 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 174 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 175 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 176 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 177 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 178 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 179 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 180 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 181 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 182 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 183 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 184 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 185 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 186 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 187 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 188 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 189 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 190 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 191 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 192 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 193 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 196 then
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
			
when 197 then
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
			
when 198 then
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
			
when 199 then
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
			
when 200 then
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
				append_utf8_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 202 then
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
			
when 203 then
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
			
when 204 then
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
			
when 205 then
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
			
when 206 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 213 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 214 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 215 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 216 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 217 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 218 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 219 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 220 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 221 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 222 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 223 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 224 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 225 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 226 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 227 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 228 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 229 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 230 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 231 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 232 then
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
			
when 233 then
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
			
when 234 then
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
			
when 235 then
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
			
when 236 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 237 then
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
			create an_array.make_filled (0, 0, 2574)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (273, 789, 814)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			an_array.area.fill_with (462, 1292, 1317)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			an_array.area.fill_with (839, 2478, 2574)
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

			  252,   78,   78,  253,   79,   79,   81,   82,   81,  685,
			   83,   81,   82,   81,  683,   83,   88,   89,   88,   88,
			   89,   88,   91,   92,   91,   91,   92,   91,   94,   94,
			   94,   94,   94,   94,   97,   98,  125,   93,  126,  205,
			   93,  127,  128,   95,  129,  130,   95,  132,  133,  135,
			  195,  136,  136,  136,  136,  149,  150,  159,  134,  153,
			  154,  155,  156,   84,  151,  152,  252,  160,   84,  256,
			  205,  157,  158,  208,  209,  210,  211,  212,   98,  213,
			   98,  472,  195,  473,   84,  214,   98,  215,   98,   84,
			   99,  676,   99,  100,  101,  102,   99,  103,  102,   99, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  104,   99,  105,  106,   99,  107,   99,  108,   99,   99,
			   99,   99,   99,   99,  109,  100,  110,   99,  102,  111,
			   99,   99,   99,   99,   99,   99,   99,  112,   99,   99,
			   99,   99,  113,  114,   99,   99,   99,   99,   99,   99,
			   99,   99,  115,   99,   99,  116,  117,   99,  118,  100,
			   99,  111,   99,   99,   99,   99,   99,   99,  112,   99,
			  113,   99,   99,   99,   99,   99,   99,  119,   99,  100,
			  100,   99,  100,   99,  100,  100,  100,  100,  100,  100,
			  100,  100,   99,   99,  100,  100,   99,  120,  735,  120,
			   97,   98,  120,  137,  138,  139,  120,  120,  202,  122,

			  123,  120,  142,  140,  143,  143,  143,  143,  120,  120,
			  120,  287,  120,  352,  174,  179,  144,  145,  142,  180,
			  143,  143,  143,  143,  175,  176,  202,  177,  216,   98,
			  736,  207,  181,  221,   98,  224,   98,  178,  146,  287,
			  120,  283,  120,  120,  120,  147,  174,  179,  144,  145,
			  186,  180,  182,  350,  176,  177,  187,  141,  181,  183,
			  184,  147,  284,  120,  120,  185,  120,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  217,   98,   96,   96,
			  120,  186,  120,  830,  182,  120,  225,   98,  184,  120,
			  120,  185,  161,  123,  120,  281,  203,  374,  193,  290, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  163,  120,  120,  120,  164,  120,  219,   98,  282,  165,
			  204,  166,  276,  199,  169,  194,  167,  168,  170,  264,
			   98,  171,  373,  200,  172,  290,  201,  173,  203,  374,
			  193,  819,  163,  120,  276,  120,  120,  120,  165,  166,
			  743,  194,  167,  168,  199,  169,  218,  170,  373,  200,
			  172,  393,  201,  173,  285,  818,  120,  120,  378,  120,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,  189,
			  812,   96,   96,  196,  807,  286,  220,   97,   98,  190,
			  393,  191,  744,  197,  378,  192,  333,  334,  198,  339,
			  340,  254,  252,  254,  560,  253,  259,  260,  259,  341,

			  342,  189,  261,  261,  261,  196,  343,  344,  190,  191,
			  377,  192,  349,  349,  198,  228,  228,  228,  681,  229,
			  361,  362,  230,  560,  231,  232,  233,  261,  261,  261,
			  367,  368,  234,  379,  380,   94,   94,   94,  748,  235,
			  252,  236,  377,  253,  237,  238,  239,  240,  255,  241,
			   95,  242,  292,  293,  292,  243,  384,  244,  587,  379,
			  245,  246,  247,  248,  249,  250,  380,  264,   98,  255,
			  266,  266,  266,  266,   99,  267,   99,  382,  381,   99,
			  383,   99,  384,   99,   99,  388,   99,  587,   99,  292,
			  293,  292,  351,  351,  351,   99,   99,   99,  297,   99, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   99,  302,  302,  302,  302,  382,  369,   98,   99,  294,
			  381,  388,  383,   99,   99,  264,   98,  370,  329,  329,
			  329,  329,  389,   99,  790,  298,  119,   99,  839,   99,
			   99,  142,   99,  348,  348,  348,  348,  390,  404,   99,
			  391,   99,  264,   98,  392,  331,  331,  331,  331,  405,
			   99,   99,  409,   99,  389,   99,   99,   99,   99,   99,
			   99,   99,   99,  390,  404,   99,   99,  268,  269,  268,
			  392,  394,  268,  789,  147,  405,  268,  268,  409,  270,
			  268,  268,  420,  744,  353,  353,  353,  353,  268,  268,
			  268,  466,  268,  839,  839,  839,  839,  839,  839,  839,

			  839,  839,  458,  394,  839,  839,   97,   98,  420,  332,
			  332,  332,  332,  406,  335,  335,  335,  335,  431,  432,
			  268,  788,  268,  268,  268,  354,  428,  264,   98,  336,
			  338,  338,  338,  338,  264,   98,  839,  356,  356,  356,
			  356,  443,   98,  268,  268,  406,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  787,  428,  268,  268,
			   99,  336,   99,  271,  272,  271,  273,  103,  271,  273,
			  273,  273,  271,  271,  273,  274,  271,  271,  273,  273,
			  273,  273,  273,  273,  271,  271,  271,  273,  271, yy_Dummy>>,
			1, 189, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  275,  271,  273,  271,  271,  271,  273,  273,  273,  273,
			  273,  273,  273,  273,  273,  273,  273,  273,  273,  273,
			  273,  273,  275,  273,  271,  271,  273,  271,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,   99,   99,  268,
			  268,   99,  280,  100,  422,  783,  100,  410,   99,  252,
			  100,  100,  256,   99,  100,  100,  345,  421,  346,  346,
			  346,  346,  100,  429,  100,  427,  100,   99,  736,  375,
			  422,  402,  376,  347,  357,   99,  358,   98,  417,  410,
			   99,   99,  418,  403,  385,  359,  467,  360,  386,  421,
			   99,  427,  430,  119,  100,  429,  100,  458,  100,   99,

			  375,  376,  387,  402,  558,  347,   99,  417,   99,  264,
			   98,  471,  364,  364,  364,  364,  385,  559,  430,  468,
			  386,  100,  299,  654,  299,  445,   98,  299,  387,  407,
			  458,  299,  299,  762,  301,  299,  299,  471,  408,  228,
			  228,  228,  540,  299,  299,  299,  451,  299,  264,   98,
			  424,  366,  366,  366,  366,  425,  397,  259,  260,  259,
			  398,  407,  452,  453,  453,  453,  426,  408,  254,  252,
			  254,  399,  253,  540,  400,  299,  476,  299,  299,  299,
			  469,  737,  424,  261,  261,  261,  425,  458,  397,  538,
			  474,  398,  426,  292,  293,  292,  717,  399,  299,  299, yy_Dummy>>,
			1, 200, 815)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  400,  299,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  585,  469,  131,  131,  305,  474,  538,  306,  681,
			  307,  308,  309,  528,   98,  255,  264,   98,  310,  434,
			  434,  434,  434,  264,   98,  311,  539,  312,  543,  585,
			  313,  314,  315,  316,  531,  317,  255,  318,  292,  293,
			  292,  319,  267,  320,  264,   98,  321,  322,  323,  324,
			  325,  326,  299,  530,  299,  349,  349,  299,  539,  584,
			  543,  299,  299,  546,  372,  299,  299,  487,  488,  488,
			  488,  544,  541,  299,  299,  299,  677,  299,  411,  668,
			  412,  264,   98,  665,  436,  436,  436,  436,  413,  542,

			  584,  414,  545,  415,  416,  546,  521,  544,  456,  456,
			  456,  464,  293,  464,  541,  299,  661,  299,  299,  299,
			  411,  481,  412,  265,  457,  542,  413,  414,  545,  415,
			  416,  264,   98,  547,  506,  506,  506,  506,  299,  299,
			  747,  299,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  264,   98,  131,  131,  273,  460,  273,  548,  547,
			  273,  552,  158,  648,  273,  273,  276,  461,  273,  273,
			  477,  477,  477,  351,  351,  351,  273,  273,  273,  636,
			  273,  556,  748,  557,  548,  301,  478,  552,  276,  839,
			  839,  839,  839,  839,  839,  839,  839,  839,  549,  631, yy_Dummy>>,
			1, 200, 1015)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  839,  839,  507,  507,  507,  507,  628,  556,  273,  557,
			  273,  273,  273,  508,  523,  508,  593,  336,  509,  509,
			  509,  509,  264,   98,  624,  511,  511,  511,  511,  345,
			  549,  273,  273,  524,  273,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,  593,  522,   99,   99,   99,  336,
			   99,  102,  267,  102,  462,  103,  102,  462,  462,  462,
			  102,  102,  462,   99,  102,  102,  462,  462,  462,  462,
			  462,  462,  102,  102,  102,  462,  102, yy_Dummy>>,
			1, 77, 1215)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  463,  102,  462,  102,  102,  102,  462,  462,  462,  462,
			  462,  462,  462,  462,  462,  462,  462,  462,  462,  462,
			  462,  462,  463,  462,  102,  102,  462,  102,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,   99,   99,  100,
			  100,   99,  479,  479,  479,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  550,  610,  605,  480,  606,   96,
			  510,  457,  551,  512,  457,   96,  514,  457,  264,   98,
			  298,  513,  513,  513,  513,  264,   98,  641,  515,  515,
			  515,  515,  527,  527,  527,  527,  550,  516,  516,  516,
			  516,  518,  555,  518,  551,  608,  519,  519,  519,  519,

			  528,   98,  517,  561,  142,  641,  520,  520,  520,  520,
			  525,  360,  526,  526,  526,  526,  264,   98,  604,  533,
			  533,  533,  533,  354,  555,  839,  839,  839,  839,  839,
			  839,  839,  839,  839,  517,  561,  839,  839,  839,  839,
			  839,  839,  839,  839,  839,  839,  839,  147,  272,  839,
			  839,  674,  674,  354,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  562,  564,  553,  565,  572,  577,  529,
			  457,  566,  532,  457,  568,  534,  457,  264,   98,  554,
			  535,  535,  535,  535,  456,  456,  456,  570,  573,  574,
			  575,  576,  578,  572,  577,  562,  564,  553,  565,  536, yy_Dummy>>,
			1, 200, 1318)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  457,  580,  581,  566,  589,  582,  568,  583,  586,  588,
			  579,  590,  591,  592,  269,  607,  456,  456,  456,  570,
			  573,  574,  575,  576,  578,  349,  349,  580,  630,  603,
			  589,  594,  457,  609,  581,  629,  579,  582,  571,  583,
			  586,  588,  590,  591,  607,  592,  264,   98,  569,  595,
			  595,  595,  595,  456,  456,  456,  456,  456,  456,  630,
			  598,  453,  453,  453,  453,  609,  521,  629,  596,  457,
			  625,  597,  457,  599,  600,  598,  453,  453,  453,  453,
			   97,   98,  480,  266,  266,  266,  266,  567,  292,  293,
			  292,  464,  293,  464,  122,  601,  625,  302,  302,  302,

			  302,  694,  602,  604,  626,  599,  600,  611,  488,  488,
			  488,  488,  509,  509,  509,  509,  627,  602,  462,  460,
			  462,  563,  357,  462,  358,   98,  537,  462,  462,  694,
			  626,  462,  462,  359,  611,  488,  488,  488,  488,  462,
			  462,  462,  627,  462,  632,  633,  276,  612,  613,  615,
			  839,  839,  839,  839,  839,  839,  839,  839,  839,  524,
			  634,  839,  839,  509,  509,  509,  509,  522,  276,  614,
			  632,  462,  505,  462,  462,  462,  615,  633,  652,  612,
			  613,  616,  616,  616,  616,  619,  634,  619,  635,  638,
			  620,  620,  620,  620,  462,  462,  336,  462,   99,   99, yy_Dummy>>,
			1, 200, 1518)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   99,   99,   99,   99,   99,   99,   99,  652,  637,   99,
			   99,  618,  618,  618,  618,  519,  519,  519,  519,  131,
			  635,  638,  617,  639,  644,  131,  517,  504,  336,  519,
			  519,  519,  519,  621,  637,  520,  520,  520,  520,  525,
			  647,  622,  622,  622,  622,  525,  640,  527,  527,  527,
			  527,  456,  456,  456,  639,  642,  644,  643,  517,  645,
			  646,  649,  650,  651,  653,  658,  623,  457,  503,  657,
			  659,  647,  640,  662,  666,  660,  354,  663,  664,  667,
			  669,  642,  354,  643,  670,  645,  672,  649,  354,  651,
			  673,  658,  646,  653,  650,  654,  654,  654,  671,  655,

			  657,  660,  659,  663,  662,  667,  666,  664,  678,  679,
			  656,  502,  669,  680,  501,  672,  670,  675,  675,  675,
			  682,  682,  673,  700,  671,  453,  453,  453,  453,  684,
			  684,  684,  695,  702,  678,  686,  686,  686,  686,  693,
			  679,  696,  680,  616,  616,  616,  616,  688,  688,  688,
			  688,  700,  689,  689,  689,  689,  703,  697,  687,  620,
			  620,  620,  620,  695,  702,  693,  602,  517,  620,  620,
			  620,  620,  655,  696,  701,  345,  615,  689,  689,  689,
			  689,  704,  692,  697,  527,  527,  527,  527,  703,  705,
			  687,  698,  691,  690,  706,  699,  708,  711,  500,  517, yy_Dummy>>,
			1, 200, 1718)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  701,  707,  709,  710,  499,  712,  713,  719,  714,  715,
			  498,  723,  730,  704,  720,  718,  721,  722,  724,  727,
			  706,  705,  708,  698,  691,  147,  699,  725,  711,  707,
			  709,  728,  726,  719,  729,  710,  712,  723,  713,  714,
			  730,  715,  654,  654,  654,  720,  716,  718,  721,  722,
			  724,  727,  738,  725,  731,  674,  674,  656,  726,  739,
			  740,  497,  728,  741,  682,  682,  729,  733,  675,  675,
			  675,  745,  684,  684,  684,  749,  686,  686,  686,  686,
			  496,  495,  750,  738,  750,  760,  740,  751,  751,  751,
			  751,  739,  752,  752,  752,  752,  732,  689,  689,  689,

			  689,  755,  755,  755,  755,  742,  759,  753,  761,  734,
			  763,  760,  754,  746,  764,  765,  756,  615,  756,  716,
			  766,  757,  757,  757,  757,  345,  767,  755,  755,  755,
			  755,  768,  770,  769,  761,  771,  763,  773,  759,  753,
			  772,  774,  758,  775,  754,  776,  764,  765,  777,  778,
			  779,  494,  766,  780,  782,  781,  674,  674,  767,  769,
			  770,  771,  784,  768,  785,  802,  772,  774,  786,  773,
			  801,  776,  775,  825,  758,  493,  777,  778,  492,  780,
			  782,  491,  779,  781,  675,  675,  675,  490,  806,  489,
			  785,  800,  486,  802,  784,  803,  801,  732,  804,  825, yy_Dummy>>,
			1, 200, 1918)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  786,  751,  751,  751,  751,  751,  751,  751,  751,  791,
			  791,  791,  791,  792,  485,  792,  805,  806,  793,  793,
			  793,  793,  484,  800,  753,  734,  794,  803,  794,  808,
			  804,  795,  795,  795,  795,  796,  796,  796,  796,  757,
			  757,  757,  757,  757,  757,  757,  757,  798,  805,  798,
			  797,  809,  799,  799,  799,  799,  753,  808,  810,  810,
			  810,  813,  814,  815,  816,  828,  753,  483,  482,  817,
			  793,  793,  793,  793,  793,  793,  793,  793,  795,  795,
			  795,  795,  797,  809,  795,  795,  795,  795,  823,  811,
			  824,  828,  617,  813,  814,  815,  816,  817,  753,  820,

			  820,  820,  820,  821,  827,  821,  829,  122,  822,  822,
			  822,  822,  831,  797,  797,  799,  799,  799,  799,  824,
			  823,  811,  799,  799,  799,  799,  810,  810,  810,  822,
			  822,  822,  822,  827,  822,  822,  822,  822,  829,  690,
			  832,  833,  834,  475,  831,  797,  797,  470,  465,  835,
			  836,  837,  838,  162,  162,  162,  459,  826,   76,   76,
			   76,   76,   76,   76,   76,   76,   76,  267,  458,  832,
			  455,  258,  227,  833,  834,  835,  836,  837,  838,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,  450,  826,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   87, yy_Dummy>>,
			1, 200, 2118)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   87,   87,   87,   87,   87,   87,   87,   87,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,  121,  449,  121,
			  448,  121,  121,  121,  124,  124,  124,  124,  124,  124,
			  124,  124,  226,  226,  226,  447,  226,  226,  226,  226,
			  251,  251,  251,  251,  251,  251,  251,  251,  251,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  257,  257,
			  257,  257,  257,  257,  257,  257,  257,  103,  446,  103,
			  103,  103,  103,  103,  103,  300,  444,  300,  442,  300,
			  300,  300,  303,  303,  303,  303,  303,  303,  303,  303,
			  454,  454,  454,  454,  454,  454,  454,  454,  717,  717,

			  717,  717,  717,  717,  717,  717,  717,  783,  783,  783,
			  783,  783,  783,  783,  783,  441,  440,  439,  438,  437,
			  435,  433,  423,  419,  401,  396,  395,  371,  365,  363,
			  355,  337,  332,  330,  328,  327,  304,  297,  296,  295,
			  291,  289,  288,  279,  278,  277,  265,  263,  262,  258,
			  227,  223,  222,  206,  188,  148,  839,   86,   86,   13, yy_Dummy>>,
			1, 160, 2318)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2574)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 97)
			yy_chk_template_1 (an_array)
			an_array.area.fill_with (18, 192, 286)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (102, 762, 856)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			an_array.area.fill_with (274, 1265, 1359)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			an_array.area.fill_with (839, 2477, 2574)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   80,    3,    4,   80,    3,    4,    5,    5,
			    5,  862,    5,    6,    6,    6,  861,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   21,   11,
			   21,   55,   12,   24,   24,   15,   25,   25,   16,   27,
			   27,   28,   50,   28,   28,   28,   28,   34,   34,   37,
			   27,   35,   35,   36,   36,    5,   34,   34,   84,   37,
			    6,   84,   55,   36,   36,   60,   60,   63,   63,   64,
			   64,   65,   65,  290,   50,  290,    5,   66,   66,   67,
			   67,    6,   18,  860, yy_Dummy>>,
			1, 94, 98)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   19,  676,   19,   58,   58,   19,   29,   29,   29,   19,
			   19,   53,   19,   19,   19,   30,   29,   30,   30,   30,
			   30,   19,   19,   19,  111,   19,  858,   42,   44,   30,
			   30,   31,   44,   31,   31,   31,   31,   42,   43,   53,
			   43,   68,   68,  676,   58,   44,   71,   71,   74,   74,
			   43,   30,  111,   19,  109,   19,   19,   19,   30,   42,
			   44,   30,   30,   46,   44,   45,  857,   43,   43,   46,
			   29,   44,   45,   45,   31,  109,   19,   19,   45,   19,
			   19,   19,   19,   19,   19,   19,   19,   19,   19,   69,
			   69,   19,   19,   38,   46,   38,  817,   45,   38,   75,

			   75,   45,   38,   38,   45,   38,   38,   38,  108,   54,
			  164,   49,  114,   39,   38,   38,   38,   39,   38,   70,
			   70,  108,   39,   54,   39,  103,   52,   41,   49,   39,
			   39,   41,   96,   96,   41,  163,   52,   41,  114,   52,
			   41,   54,  164,   49,  786,   39,   38,  103,   38,   38,
			   38,   39,   39,  683,   49,   39,   39,   52,   41,   69,
			   41,  163,   52,   41,  179,   52,   41,  110,  785,   38,
			   38,  167,   38,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   48,  776,   38,   38,   51,  770,  110,   70,
			  131,  131,   48,  179,   48,  683,   51,  167,   48,  134, yy_Dummy>>,
			1, 200, 287)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  134,   51,  139,  139,   81,   81,   81,  396,   81,   88,
			   88,   88,  140,  140,   48,   91,   91,   91,   51,  141,
			  141,   48,   48,  166,   48,  144,  144,   51,   79,   79,
			   79,  749,   79,  152,  152,   79,  396,   79,   79,   79,
			   92,   92,   92,  157,  157,   79,  168,  169,   94,   94,
			   94,  748,   79,  251,   79,  166,  251,   79,   79,   79,
			   79,   81,   79,   94,   79,  116,  116,  116,   79,  173,
			   79,  423,  168,   79,   79,   79,   79,   79,   79,  169,
			   98,   98,   81,   98,   98,   98,   98,   99,   99,   99,
			  171,  170,   99,  172,   99,  173,   99,   99,  176,   99,

			  423,   99,  119,  119,  119,  145,  145,  145,   99,   99,
			   99,  123,   99,   99,  123,  123,  123,  123,  171,  158,
			  158,   99,  116,  170,  176,  172,   99,   99,  128,  128,
			  158,  128,  128,  128,  128,  177,   99,  747,  121,   99,
			   99,  746,   99,   99,  143,   99,  143,  143,  143,  143,
			  177,  188,   99,  178,   99,  130,  130,  178,  130,  130,
			  130,  130,  189,   99,   99,  193,   99,  177,   99,   99,
			   99,   99,   99,   99,   99,   99,  177,  188,   99,   99,
			  100,  100,  100,  178,  180,  100,  745,  143,  189,  100,
			  100,  193,  100,  100,  100,  198,  744,  147,  147,  147, yy_Dummy>>,
			1, 200, 487)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  147,  100,  100,  100,  282,  100,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  282,  180,  121,  121,  133,
			  133,  198,  133,  133,  133,  133,  190,  136,  136,  136,
			  136,  207,  207,  100,  743,  100,  100,  100,  147,  204,
			  138,  138,  136,  138,  138,  138,  138,  150,  150,  742,
			  150,  150,  150,  150,  218,  218,  100,  100,  190,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  741,
			  204,  100,  100,  102,  136, yy_Dummy>>,
			1, 75, 687)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  107,  107,  200,  737,  107,  194,  107,  255,  107,  107,
			  255,  107,  107,  107,  142,  199,  142,  142,  142,  142,
			  107,  205,  107,  203,  107,  107,  736,  165,  200,  187,
			  165,  142,  151,  107,  151,  151,  196,  194,  107,  107,
			  196,  187,  174,  151,  284,  151,  174,  199,  107,  203,
			  206,  107,  107,  205,  107,  284,  107,  107,  165,  165,
			  174,  187,  395,  142,  107,  196,  107,  154,  154,  289,
			  154,  154,  154,  154,  174,  395,  206,  286,  174,  107,
			  122,  717,  122,  220,  220,  122,  174,  191,  286,  122,
			  122,  699,  122,  122,  122,  289,  191,  228,  228,  228,

			  378,  122,  122,  122,  228,  122,  156,  156,  202,  156,
			  156,  156,  156,  202,  184,  259,  259,  259,  184,  191,
			  234,  234,  234,  234,  202,  191,  254,  254,  254,  184,
			  254,  378,  184,  122,  295,  122,  122,  122,  287,  677,
			  202,  261,  261,  261,  202,  295,  184,  374,  291,  184,
			  202,  275,  275,  275,  656,  184,  122,  122,  184,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  421,
			  287,  122,  122,  125,  291,  374,  125,  611,  125,  125,
			  125,  357,  357,  254,  209,  209,  125,  209,  209,  209,
			  209,  360,  360,  125,  375,  125,  380,  421,  125,  125, yy_Dummy>>,
			1, 200, 857)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  125,  125,  360,  125,  254,  125,  292,  292,  292,  125,
			  604,  125,  359,  359,  125,  125,  125,  125,  125,  125,
			  161,  359,  161,  349,  349,  161,  375,  420,  380,  161,
			  161,  383,  161,  161,  161,  310,  310,  310,  310,  381,
			  379,  161,  161,  161,  603,  161,  195,  584,  195,  211,
			  211,  580,  211,  211,  211,  211,  195,  379,  420,  195,
			  382,  195,  195,  383,  349,  381,  264,  264,  264,  276,
			  276,  276,  379,  161,  576,  161,  161,  161,  195,  300,
			  195,  264,  264,  379,  195,  195,  382,  195,  195,  334,
			  334,  384,  334,  334,  334,  334,  161,  161,  685,  161,

			  161,  161,  161,  161,  161,  161,  161,  161,  161,  370,
			  370,  161,  161,  273,  273,  273,  385,  384,  273,  390,
			  370,  561,  273,  273,  276,  273,  273,  273,  297,  297,
			  297,  351,  351,  351,  273,  273,  273,  548,  273,  393,
			  685,  394,  385,  297,  297,  390,  276,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  386,  543,  300,  300,
			  335,  335,  335,  335,  540,  393,  273,  394,  273,  273,
			  273,  336,  351,  336,  429,  335,  336,  336,  336,  336,
			  340,  340,  529,  340,  340,  340,  340,  525,  386,  273,
			  273,  524,  273,  273,  273,  273,  273,  273,  273,  273, yy_Dummy>>,
			1, 200, 1057)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  273,  273,  429,  522,  273,  273,  274,  335, yy_Dummy>>,
			1, 8, 1257)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  298,  298,  298,  339,  339,  339,  341,  341,  341,  343,
			  343,  343,  387,  474,  469,  298,  469,  845,  339,  339,
			  388,  341,  341,  845,  343,  343,  342,  342,  302,  342,
			  342,  342,  342,  344,  344,  553,  344,  344,  344,  344,
			  354,  354,  354,  354,  387,  346,  346,  346,  346,  347,
			  392,  347,  388,  471,  347,  347,  347,  347,  531,  531,
			  346,  397,  348,  553,  348,  348,  348,  348,  353,  531,
			  353,  353,  353,  353,  362,  362,  462,  362,  362,  362,
			  362,  354,  392,  298,  298,  298,  298,  298,  298,  298,
			  298,  298,  346,  397,  298,  298,  302,  302,  302,  302,

			  302,  302,  302,  302,  302,  348,  459,  302,  302,  599,
			  599,  353,  358,  358,  358,  361,  361,  361,  367,  367,
			  367,  398,  400,  391,  401,  409,  414,  358,  358,  402,
			  361,  361,  404,  367,  367,  368,  368,  391,  368,  368,
			  368,  368,  369,  369,  369,  407,  410,  411,  412,  413,
			  415,  409,  414,  398,  400,  391,  401,  369,  369,  416,
			  417,  402,  425,  418,  404,  419,  422,  424,  415,  426,
			  427,  428,  458,  470,  431,  431,  431,  407,  410,  411,
			  412,  413,  415,  521,  521,  416,  542,  455,  425,  431,
			  431,  472,  417,  541,  415,  418,  408,  419,  422,  424, yy_Dummy>>,
			1, 200, 1360)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  426,  427,  470,  428,  432,  432,  405,  432,  432,  432,
			  432,  443,  443,  443,  445,  445,  445,  542,  452,  452,
			  452,  452,  452,  472,  521,  541,  443,  443,  537,  445,
			  445,  452,  452,  453,  453,  453,  453,  453,  457,  457,
			  481,  457,  457,  457,  457,  403,  463,  463,  463,  464,
			  464,  464,  478,  452,  537,  478,  478,  478,  478,  628,
			  452,  463,  538,  452,  452,  488,  488,  488,  488,  488,
			  508,  508,  508,  508,  539,  453,  461,  461,  461,  399,
			  530,  461,  530,  530,  373,  461,  461,  628,  538,  461,
			  461,  530,  487,  487,  487,  487,  487,  461,  461,  461,

			  539,  461,  544,  545,  464,  487,  487,  488,  481,  481,
			  481,  481,  481,  481,  481,  481,  481,  352,  546,  481,
			  481,  509,  509,  509,  509,  350,  464,  487,  544,  461,
			  333,  461,  461,  461,  487,  545,  566,  487,  487,  507,
			  507,  507,  507,  517,  546,  517,  547,  550,  517,  517,
			  517,  517,  461,  461,  507,  461,  461,  461,  461,  461,
			  461,  461,  461,  461,  461,  566,  549,  461,  461,  516,
			  516,  516,  516,  518,  518,  518,  518,  848,  547,  550,
			  507,  551,  556,  848,  516,  326,  507,  519,  519,  519,
			  519,  520,  549,  520,  520,  520,  520,  526,  560,  526, yy_Dummy>>,
			1, 200, 1560)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  526,  526,  526,  527,  552,  527,  527,  527,  527,  528,
			  528,  528,  551,  554,  556,  555,  516,  557,  559,  562,
			  563,  564,  569,  573,  528,  528,  325,  572,  574,  560,
			  552,  577,  581,  575,  520,  578,  579,  582,  587,  554,
			  526,  555,  588,  557,  590,  562,  527,  564,  591,  573,
			  559,  569,  563,  570,  570,  570,  589,  570,  572,  575,
			  574,  578,  577,  582,  581,  579,  605,  607,  570,  324,
			  587,  609,  323,  590,  588,  600,  600,  600,  612,  612,
			  591,  635,  589,  602,  602,  602,  602,  613,  613,  613,
			  629,  638,  605,  615,  615,  615,  615,  625,  607,  630,

			  609,  616,  616,  616,  616,  617,  617,  617,  617,  635,
			  618,  618,  618,  618,  639,  633,  616,  619,  619,  619,
			  619,  629,  638,  625,  602,  618,  620,  620,  620,  620,
			  570,  630,  637,  621,  615,  621,  621,  621,  621,  640,
			  622,  633,  622,  622,  622,  622,  639,  641,  616,  634,
			  621,  618,  642,  634,  645,  648,  322,  618,  637,  643,
			  646,  647,  321,  649,  650,  658,  651,  653,  320,  662,
			  673,  640,  659,  657,  660,  661,  663,  667,  642,  641,
			  645,  634,  621,  622,  634,  664,  648,  643,  646,  670,
			  666,  658,  671,  647,  649,  662,  650,  651,  673,  653, yy_Dummy>>,
			1, 200, 1760)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  654,  654,  654,  659,  654,  657,  660,  661,  663,  667,
			  678,  664,  674,  674,  674,  654,  666,  679,  680,  319,
			  670,  682,  682,  682,  671,  675,  675,  675,  675,  684,
			  684,  684,  684,  686,  686,  686,  686,  686,  318,  317,
			  687,  678,  687,  696,  680,  687,  687,  687,  687,  679,
			  688,  688,  688,  688,  674,  689,  689,  689,  689,  690,
			  690,  690,  690,  682,  695,  688,  697,  675,  700,  696,
			  689,  684,  701,  702,  691,  686,  691,  654,  705,  691,
			  691,  691,  691,  692,  707,  692,  692,  692,  692,  708,
			  711,  710,  697,  712,  700,  714,  695,  688,  713,  715,

			  692,  718,  689,  719,  701,  702,  720,  721,  723,  316,
			  705,  727,  730,  728,  732,  732,  707,  710,  711,  712,
			  738,  708,  739,  762,  713,  715,  740,  714,  760,  719,
			  718,  808,  692,  315,  720,  721,  314,  727,  730,  313,
			  723,  728,  734,  734,  734,  312,  767,  311,  739,  759,
			  309,  762,  738,  764,  760,  732,  765,  808,  740,  750,
			  750,  750,  750,  751,  751,  751,  751,  752,  752,  752,
			  752,  753,  308,  753,  766,  767,  753,  753,  753,  753,
			  307,  759,  752,  734,  754,  764,  754,  773,  765,  754,
			  754,  754,  754,  755,  755,  755,  755,  756,  756,  756, yy_Dummy>>,
			1, 200, 1960)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  756,  757,  757,  757,  757,  758,  766,  758,  755,  774,
			  758,  758,  758,  758,  752,  773,  775,  775,  775,  777,
			  778,  780,  781,  812,  791,  306,  305,  784,  792,  792,
			  792,  792,  793,  793,  793,  793,  794,  794,  794,  794,
			  755,  774,  795,  795,  795,  795,  801,  775,  804,  812,
			  791,  777,  778,  780,  781,  784,  791,  796,  796,  796,
			  796,  797,  811,  797,  814,  299,  797,  797,  797,  797,
			  824,  820,  796,  798,  798,  798,  798,  804,  801,  775,
			  799,  799,  799,  799,  810,  810,  810,  821,  821,  821,
			  821,  811,  822,  822,  822,  822,  814,  820,  826,  827,

			  832,  294,  824,  820,  796,  288,  277,  833,  834,  835,
			  836,  849,  849,  849,  271,  810,  840,  840,  840,  840,
			  840,  840,  840,  840,  840,  270,  268,  826,  262,  257,
			  226,  827,  832,  833,  834,  835,  836,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  225,  810,  842,  842,
			  842,  842,  842,  842,  842,  842,  842,  843,  843,  843,
			  843,  843,  843,  843,  843,  843,  844,  844,  844,  844,
			  844,  844,  844,  844,  844,  846,  224,  846,  223,  846,
			  846,  846,  847,  847,  847,  847,  847,  847,  847,  847,
			  850,  850,  850,  222,  850,  850,  850,  850,  851,  851, yy_Dummy>>,
			1, 200, 2160)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  851,  851,  851,  851,  851,  851,  851,  852,  852,  852,
			  852,  852,  852,  852,  852,  852,  853,  853,  853,  853,
			  853,  853,  853,  853,  853,  854,  221,  854,  854,  854,
			  854,  854,  854,  855,  219,  855,  217,  855,  855,  855,
			  856,  856,  856,  856,  856,  856,  856,  856,  859,  859,
			  859,  859,  859,  859,  859,  859,  863,  863,  863,  863,
			  863,  863,  863,  863,  863,  864,  864,  864,  864,  864,
			  864,  864,  864,  216,  215,  214,  213,  212,  210,  208,
			  201,  197,  186,  183,  181,  159,  155,  153,  149,  137,
			  132,  129,  127,  126,  124,  120,  118,  117,  115,  113,

			  112,  106,  105,  104,   97,   95,   93,   85,   76,   73,
			   72,   56,   47,   32,   13,    8,    7, yy_Dummy>>,
			1, 117, 2360)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 864)
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
			    0,    0,    0,   96,   97,  105,  110, 2474, 2473,  115,
			  118,  121,  124, 2474, 2477,  127,  130,  118,  189,  283,
			 2477,  128, 2477, 2477,  125,  128, 2477,  131,  132,  277,
			  285,  301, 2447, 2477,  139,  143,  145,  141,  376,  368,
			    0,  377,  280,  284,  285,  317,  312, 2428,  438,  368,
			  116,  439,  376,  255,  366,  102, 2427, 2477,  274, 2477,
			  157, 2477, 2477,  159,  161,  163,  169,  171,  312,  360,
			  390,  317, 2454, 2453,  319,  370, 2463, 2477, 2477,  514,
			   98,  490, 2477, 2477,  164, 2465, 2477, 2477,  495, 2477,
			 2477,  501,  526, 2450,  534, 2449,  403, 2448,  551,  570,

			  663, 2477,  759,  356, 2451, 2457, 2456,  852,  390,  336,
			  449,  268, 2418, 2415,  352, 2414,  551, 2400, 2451,  588,
			 2439,  609,  933,  582, 2444, 1025, 2443, 2436,  599, 2435,
			  626,  461, 2434,  690,  470, 2477,  695, 2433,  711,  473,
			  483,  490,  854,  614,  493,  573,    0,  665, 2477, 2432,
			  718,  875,  504, 2431,  908, 2430,  947,  514,  590, 2429,
			 2477, 1073,    0,  375,  363,  846,  477,  410,  484,  500,
			  548,  534,  546,  509,  868,    0,  537,  589,  595,  410,
			  641, 2400,    0, 2398,  938,    0, 2402,  854,  589,  601,
			  680,  912,    0,  605,  828, 1070,  852, 2399,  635,  838, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  809, 2395,  932,  833,  688,  844,  860,  702, 2423, 1025,
			 2422, 1090, 2421, 2420, 2419, 2418, 2417, 2380,  725, 2378,
			  924, 2370, 2337, 2322, 2320, 2290, 2285, 2477,  953, 2477,
			 2477, 2477, 2477, 2477,  958, 2477, 2477, 2477, 2477, 2477,
			 2477, 2477, 2477, 2477, 2477, 2477, 2477, 2477, 2477, 2477,
			 2477,  538, 2477, 2477,  982,  862, 2477, 2287, 2477,  971,
			 2477,  997, 2282, 2477, 1122, 2477, 2477, 2477, 2270, 2477,
			 2280, 2258, 2477, 1166, 1262, 1007, 1125, 2261, 2477, 2477,
			 2477, 2477,  686, 2477,  896, 2477,  929,  962, 2220,  877,
			  178,  958, 1062, 2477, 2256,  986, 2477, 1184, 1359, 2209,

			 1120, 2477, 1372, 2477, 2477, 2176, 2175, 2130, 2122, 2100,
			 1073, 2097, 2095, 2089, 2086, 2083, 2059, 1989, 1988, 1969,
			 1918, 1912, 1906, 1822, 1819, 1776, 1735, 2477, 2477, 2477,
			 2477, 2477, 2477, 1674, 1130, 1198, 1214, 2477, 2477, 1362,
			 1221, 1365, 1370, 1368, 1377, 2477, 1386, 1395, 1405, 1061,
			 1625, 1169, 1617, 1411, 1381, 2477, 2477, 1022, 1471, 1053,
			 1032, 1474, 1418, 2477, 2477, 2477, 2477, 1477, 1479, 1501,
			 1150, 2477, 2477, 1600,  961, 1021,    0,    0,  919, 1067,
			 1021, 1048, 1066, 1058, 1101, 1123, 1179, 1342, 1346,    0,
			 1126, 1453, 1376, 1148, 1149,  877,  453, 1387, 1447, 1594, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1452, 1450, 1459, 1560, 1458, 1522,    0, 1471, 1502, 1436,
			 1474, 1473, 1474, 1479, 1436, 1478, 1472, 1486, 1493, 1491,
			 1046,  983, 1492,  517, 1493, 1476, 1491, 1492, 1498, 1188,
			    0, 1533, 1548, 2477, 2477, 2477, 2477, 2477, 2477, 2477,
			 2477, 2477, 2477, 1570, 2477, 1573, 2477, 2477, 2477, 2477,
			 2477, 2477, 1560, 1575,    0, 1477, 2477, 1582, 1527, 1461,
			 2477, 1632, 1420, 1605, 1608, 2477, 2477, 2477, 2477, 1371,
			 1492, 1408, 1517, 2477, 1368, 2477, 2477, 2477, 1596, 2477,
			 2477, 1584, 2477, 2477, 2477, 2477, 2477, 1634, 1607, 2477,
			 2477, 2477, 2477, 2477, 2477, 2477, 2477, 2477, 2477, 2477,

			 2477, 2477, 2477, 2477, 2477, 2477, 2477, 1680, 1611, 1662,
			 2477, 2477, 2477, 2477, 2477, 2477, 1710, 1689, 1714, 1728,
			 1734, 1524, 1200,    0, 1188, 1227, 1740, 1746, 1768, 1223,
			 1626, 1402, 2477, 2477, 2477, 2477, 2477, 1540, 1573, 1586,
			 1185, 1521, 1508, 1174, 1614, 1629, 1629, 1672, 1158, 1679,
			 1675, 1703, 1717, 1352, 1726, 1728, 1708, 1727,    0, 1744,
			 1720, 1125, 1732, 1746, 1734,    0, 1655,    0,    0, 1741,
			 1812,    0, 1749, 1733, 1753, 1746, 1089, 1753, 1745, 1755,
			 1054, 1760, 1750,    0, 1059,    0,    0, 1764, 1767, 1766,
			 1763, 1778,    0,    0, 2477, 2477, 2477, 2477, 2477, 1450, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1816,    0, 1824, 1032, 1062, 1777, 2477, 1789, 2477, 1790,
			 2477, 1024, 1819, 1828,    0, 1834, 1842, 1846, 1851, 1858,
			 1867, 1876, 1883, 2477, 2477, 1809,    0,    0, 1576, 1813,
			 1828,    0,    0, 1828, 1875, 1798,    0, 1845, 1814, 1839,
			 1865, 1874, 1863, 1876,    0, 1867, 1877, 1887, 1877, 1885,
			 1892, 1888,    0, 1893, 1959, 2477,  995, 1903, 1878, 1894,
			 1900, 1901, 1882, 1902, 1896,    0, 1901, 1907,    0,    0,
			 1911, 1918,    0, 1887, 1954, 1967,  270,  925, 1933, 1943,
			 1930, 2477, 1963,  422, 1971, 1137, 1975, 1986, 1991, 1996,
			 2000, 2020, 2026,    0,    0, 1990, 1953, 1977,    0,  904,

			 1979, 1998, 2003,    0,    0, 2004,    0, 2014, 2015,    0,
			 2003, 2007, 2004, 2009, 2025, 2010, 2477,  936, 2020, 2015,
			 2023, 2024,    0, 2034,    0,    0,    0, 2022, 2030,    0,
			 2023, 2477, 2055, 2477, 2083, 2477,  823,  794, 2046, 2034,
			 2052,  746,  718,  711,  623,  663,  610,  614,  478,  508,
			 2100, 2104, 2108, 2117, 2130, 2134, 2138, 2142, 2151, 2076,
			 2039,    0, 2040,    0, 2080, 2085, 2101, 2065,    0,    0,
			  438,    0,    0, 2104, 2135, 2175,  426, 2145, 2148,    0,
			 2147, 2148,    0,    0, 2144,  450,  426, 2477, 2477, 2477,
			 2477, 2150, 2169, 2173, 2177, 2183, 2198, 2207, 2214, 2221, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0, 2172,    0,    0, 2167,    0,    0,    0, 2042,    0,
			 2243, 2181, 2136,    0, 2190,    0,    0,  378, 2477, 2477,
			 2197, 2228, 2233,    0, 2196,    0, 2217, 2229,    0,    0,
			 2477,    0, 2230, 2219, 2220, 2221, 2222,    0, 2477, 2477,
			 2275, 2296, 2307, 2316, 2325, 1375, 2333, 2340, 1735, 2265,
			 2348, 2357, 2366, 2375, 2383, 2391, 2398,  347,  307, 2406,
			  185,  108,  103, 2415, 2423, yy_Dummy>>,
			1, 65, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 864)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (849, 162, 206)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (839, 303, 332)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (849, 373, 430)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (839, 482, 520)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (849, 537, 593)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (849, 625, 653)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (839, 840, 864)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  839,    1,  840,  840,  841,  841,  842,  842,  843,
			  843,  844,  844,  839,  839,  839,  839,  845,  839,  846,
			  839,  847,  839,  839,  845,  845,  839,  848,  839,  845,
			  839,  839,  839,  839,  845,  845,  845,  839,  846,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  839,  845,  839,
			  845,  839,  839,  845,  845,  845,  845,  845,  845,  845,
			  845,  845,  839,  839,  845,  845,  850,  839,  839,  839,
			  851,  851,  839,  839,  852,  853,  839,  839,  839,  839,
			  839,  839,  839,  839,  839,  839,  845,  848,  845,   18,

			   99,  839,  839,  854,   99,  100,  100,   18,  100,  100,
			  100,   99,   99,   99,   99,   99,   99,  100,  100,   99,
			   38,  846,  855,   38,  856,  856,  856,  848,  845,  848,
			  845,  845,  839,  845,  845,  839,  839,  848,  845,  845,
			  845,  845,  839,  839,  857,  857,  858,  839,  839,  848,
			  845,  845,  845,  848,  845,  848,  845,  845,  845,  839,
			  839,  855, yy_Dummy>>,
			1, 162, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  845,  848,  845,  848,  845,  848,  848,  848,  848,  848,
			  848,  845,  848,  845,  848,  839,  839,  848,  848,  850,
			  839,  839,  839,  839,  839,  839,  839,  839,  839,  839,
			  839,  839,  839,  839,  839,  839,  839,  839,  839,  839,
			  839,  839,  839,  839,  851,  839,  839,  851,  852,  839,
			  853,  839,  839,  839,  839,  859,  839,  848,  839,  839,
			  839,  100,  839,  107,  102,  839,  102,  839,  273,  854,
			   99,  839,  839,  839,  839,  100,  839,  100,  839,  100,
			   99,   99,   99,   99,   99,   99,  839,   99,  100,  839,
			  161,  855,   38,  846,  839,  846, yy_Dummy>>,
			1, 96, 207)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  848,  845,  839,  839,  839,  839,  848,  845,  848,  845,
			  848,  845,  839,  839,  839,  839,  857,  857,  857,  858,
			  839,  839,  839,  839,  845,  848,  845,  845,  848,  845,
			  839,  839,  839,  839,  848,  845,  848,  845,  839,  839, yy_Dummy>>,
			1, 40, 333)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  848,  845,  839,  839,  839,  839,  839,  839,  839,  839,
			  839,  839,  848,  839,  848,  839,  839,  839,  839,  839,
			  839,  839,  839,  859,  859,  839,  845,  107,  274,  839,
			  274,  273,  273,  854,  839,  839,  839,  839,   99,   99,
			   99,   99,  839,   99,  839,  839,  839,   38,  839,  839,
			  855, yy_Dummy>>,
			1, 51, 431)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  857,  857,  351,  858,  839,  839,  839,  848,  839,  845,
			  845,  839,  839,  839,  839,  839, yy_Dummy>>,
			1, 16, 521)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  839,  839,  839,  839,  839,  839,  839,  860,  839,  859,
			  461,   99,  839,   99,  839,   99,  839,  839,  861,  861,
			  862,  839,  839,  839,  839,  839,  839,  839,  839,  839,
			  839, yy_Dummy>>,
			1, 31, 594)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  839,  839,  839,  849,  849,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  849,
			  839,  839,  860,  859,   99,   99,   99,  839,  861,  861,
			  861,  862,  839,  839,  839,  839,  839,  839,  839,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  849,
			  849,  849,  839,  863,  849,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  839,  839,  839,
			  839,  839,  860,  859,   99,   99,   99,  839,  682,  839,
			  861,  839,  684,  839,  862,  839,  839,  839,  839,  839,

			  839,  839,  839,  839,  839,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  849,  849,  849,  864,
			   99,   99,   99,  839,  839,  839,  839,  839,  839,  839,
			  839,  839,  839,  839,  839,  839,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  839,  849,  849,  849,
			  849,  849,  849,   99,  839,  839,  839,  839,  839,  849,
			  849,  849,  839,  849,  849,  849,  839,  849,  839,  849,
			  839,  849,  839,  849,  839,    0, yy_Dummy>>,
			1, 186, 654)
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
			    0,    9,    1,    9,    2,    3,    2,    4,    5,    2,
			    4,    4,    4,    2,    2,    4,    2,    2,    2,    6,
			    6,    6,    6,    4,    4,    2,    2,    2,    4,    2,
			    6,    6,    6,    6,    6,    6,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    4,    2,    4,    2,
			    8,    2,    6,    6,    6,    6,    6,    6,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    4,    4,
			    2,    2,    4,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    9,    9,    2,    2,    9, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 840)
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
			  261,  262,  263,  264,  265,  266,  267,  269,  270,  271,
			  273,  275,  276,  276,  278,  279,  280,  281,  281,  282,
			  282,  283,  284,  285,  286,  288,  289,  290,  290,  291,
			  293,  295,  297,  298,  299,  299,  299,  299,  299,  300,
			  300,  301,  303,  305,  305,  306,  306,  307,  309,  311,
			  311,  312,  312,  313,  314,  315,  316,  317,  319,  320,
			  321,  322,  323,  324,  325,  326,  328,  329,  330,  331,
			  332,  333,  334,  336,  337,  338,  340,  341,  342,  343,
			  344,  345,  346,  348,  349,  350,  351,  352,  353,  354, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  355,  356,  357,  358,  359,  360,  361,  362,  364,  364,
			  365,  365,  366,  366,  366,  366,  366,  366,  366,  368,
			  368,  370,  370,  370,  370,  370,  370,  371,  372,  372,
			  373,  374,  375,  376,  377,  377,  378,  379,  380,  381,
			  382,  383,  384,  385,  386,  387,  388,  389,  390,  391,
			  392,  393,  394,  395,  396,  397,  398,  400,  401,  402,
			  402,  403,  404,  405,  406,  407,  408,  409,  410,  411,
			  413,  414,  415,  418,  419,  420,  422,  423,  424,  427,
			  430,  432,  435,  436,  439,  440,  443,  444,  445,  446,
			  447,  448,  449,  450,  451,  452,  453,  456,  458,  459,

			  461,  462,  464,  466,  467,  469,  470,  471,  472,  473,
			  474,  475,  476,  477,  478,  479,  480,  481,  482,  483,
			  484,  485,  486,  487,  488,  489,  490,  491,  493,  495,
			  497,  499,  501,  502,  502,  503,  504,  504,  506,  508,
			  509,  510,  511,  512,  513,  514,  515,  516,  516,  517,
			  519,  520,  522,  523,  524,  524,  526,  528,  530,  532,
			  533,  534,  535,  536,  538,  540,  542,  544,  545,  546,
			  547,  548,  549,  552,  553,  554,  555,  557,  559,  560,
			  561,  562,  563,  564,  565,  566,  567,  568,  569,  570,
			  572,  573,  574,  575,  576,  577,  578,  579,  580,  581, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  582,  583,  584,  585,  586,  588,  589,  591,  592,  593,
			  594,  595,  596,  597,  598,  599,  600,  601,  602,  603,
			  604,  605,  606,  607,  608,  609,  610,  611,  612,  613,
			  614,  616,  617,  618,  620,  622,  624,  626,  628,  630,
			  632,  634,  636,  638,  639,  641,  642,  644,  645,  646,
			  648,  650,  651,  651,  651,  652,  653,  654,  655,  656,
			  657,  659,  660,  661,  663,  663,  665,  668,  671,  674,
			  675,  676,  677,  678,  680,  681,  683,  686,  688,  690,
			  691,  692,  692,  693,  694,  695,  696,  697,  698,  699,
			  700,  701,  702,  703,  704,  705,  706,  707,  708,  709,

			  710,  711,  712,  713,  714,  715,  717,  719,  720,  720,
			  721,  723,  725,  727,  729,  731,  733,  734,  734,  734,
			  735,  736,  736,  736,  736,  736,  736,  737,  738,  739,
			  741,  743,  745,  747,  749,  751,  753,  755,  756,  757,
			  758,  759,  760,  761,  762,  763,  764,  765,  766,  767,
			  768,  769,  771,  772,  773,  774,  775,  776,  777,  779,
			  780,  781,  782,  783,  784,  785,  787,  788,  790,  792,
			  793,  795,  797,  798,  799,  800,  801,  802,  803,  804,
			  805,  806,  807,  808,  810,  811,  813,  815,  816,  817,
			  818,  819,  820,  822,  824,  826,  828,  830,  832,  833, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  833,  833,  833,  833,  834,  835,  836,  838,  839,  841,
			  842,  844,  845,  845,  845,  845,  845,  846,  846,  847,
			  847,  848,  849,  850,  852,  853,  854,  856,  858,  859,
			  860,  861,  863,  865,  866,  867,  868,  870,  871,  872,
			  873,  874,  875,  876,  877,  879,  880,  881,  882,  883,
			  884,  885,  886,  888,  889,  889,  890,  890,  891,  892,
			  893,  894,  895,  896,  897,  898,  900,  901,  902,  904,
			  906,  907,  908,  910,  911,  911,  911,  911,  912,  913,
			  914,  915,  916,  916,  916,  916,  916,  916,  916,  917,
			  918,  918,  918,  919,  921,  923,  924,  925,  926,  928,

			  929,  930,  931,  932,  934,  936,  937,  939,  940,  941,
			  943,  944,  945,  946,  947,  948,  949,  950,  950,  951,
			  952,  953,  954,  956,  957,  959,  961,  963,  964,  965,
			  967,  968,  969,  969,  970,  970,  971,  971,  972,  973,
			  974,  975,  975,  975,  975,  975,  975,  975,  975,  975,
			  975,  975,  976,  977,  977,  977,  978,  978,  979,  979,
			  980,  981,  983,  984,  986,  987,  988,  989,  990,  992,
			  994,  995,  997,  999, 1000, 1001, 1002, 1003, 1004, 1005,
			 1007, 1008, 1009, 1011, 1013, 1014, 1015, 1016, 1018, 1019,
			 1021, 1022, 1023, 1023, 1024, 1024, 1025, 1026, 1026, 1026, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1027, 1029, 1030, 1032, 1034, 1035, 1037, 1039, 1041, 1042,
			 1044, 1044, 1045, 1046, 1048, 1049, 1051, 1053, 1054, 1056,
			 1058, 1059, 1059, 1060, 1062, 1063, 1065, 1065, 1066, 1068,
			 1070, 1072, 1074, 1074, 1075, 1075, 1076, 1076, 1078, 1079,
			 1079, yy_Dummy>>,
			1, 41, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1078)
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
			    0,  202,  202,  204,  204,  238,  236,  237,    1,  236,
			  237,    1,  237,   55,  236,  237,  205,  236,  237,   55,
			   59,  236,  237,   14,  236,  237,  170,  236,  237,   25,
			  236,  237,   26,  236,  237,   33,   55,  236,  237,   31,
			   55,  236,  237,    9,  236,  237,   32,  236,  237,   13,
			  236,  237,   34,   55,  236,  237,  135,  236,  237,  135,
			  236,  237,    8,  236,  237,    7,  236,  237,   19,   55,
			  236,  237,   18,   55,  236,  237,   20,   55,  236,  237,
			   11,  236,  237,   15,   55,   59,  236,  237,  134,  236,
			  237,  134,  236,  237,  134,  236,  237,  134,  236,  237,

			  134,  236,  237,  134,  236,  237,  134,  236,  237,  134,
			  236,  237,  134,  236,  237,  134,  236,  237,  134,  236,
			  237,  134,  236,  237,  134,  236,  237,  134,  236,  237,
			  134,  236,  237,  134,  236,  237,  134,  236,  237,  134,
			  236,  237,   29,  236,  237,   55,  236,  237,   30,  236,
			  237,   35,   55,  236,  237,   27,  236,  237,   28,  236,
			  237,   12,   55,  236,  237,   43,   55,  236,  237,   48,
			   55,  236,  237,   53,   55,  236,  237,   41,   55,  236,
			  237,   42,   55,  236,  237,   49,   55,  236,  237,   51,
			   55,  236,  237,   54,   55,  236,  237,   46,  236,  237, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   47,  236,  237,   45,   55,  236,  237,   44,   55,  236,
			  237,  206,  237,  235,  237,  233,  237,  234,  237,  202,
			  237,  202,  237,  201,  237,  200,  237,  202,  237,  204,
			  237,  203,  237,  198,  237,  198,  237,  197,  237,    6,
			  237,    5,    6,  237,    5,  237,    6,  237,    1,   55,
			   55,  205,  205,  194,  205,  205,  205,  205,  205,  205,
			  205,  205,  205,  205,  205,  205,  205,  205, -433,  205,
			  205,  205, -433,   55,   59,   59,   55,   59,  170,  170,
			  170,   55,   55,   55,    2,   55,   36,   55,   10,  141,
			   55,   39,   55,   24,   55,   23,   55,  141,  135,   16,

			   55,   37,   55,   21,   55,   55,   55,   22,   55,   38,
			   55,   17,  134,  134,  134,  134,  134,   67,  134,  134,
			  134,  134,  134,  134,  134,  134,   80,  134,  134,  134,
			  134,  134,  134,  134,   92,  134,  134,  134,   98,  134,
			  134,  134,  134,  134,  134,  134,  110,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,   40,   55,   55,   55,   50,   55,   52,   55,
			  206,  233,  223,  221,  222,  224,  225,  226,  227,  207,
			  208,  209,  210,  211,  212,  213,  214,  215,  216,  217,
			  218,  219,  220,  202,  201,  200,  202,  202,  199,  200, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  204,  203,  197,    5,    4,    2,   55,   58,   56,  195,
			  205,  192,  195,  205,  205,  192,  193,  195,  205,  205,
			  205, -433, -433,  205,  178,  192,  195,  176,  192,  195,
			  177,  195,  179,  192,  195,  205,  172,  192,  195,  205,
			  173,  192,  195,  205,  205,  205,  205,  205,  205,  205,
			 -196,  205,  205,  180,  192,  195,   55,   59,   59,   55,
			   59,   59,   58,   61,   56,   59,  170,  142,  170,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  143,  170,   33,   58,   33,   56,   31,   58,   31,

			   56,   32,   55,  141,   34,   58,   34,   56,   55,   55,
			   55,   55,   55,   55,  136,  141,  135,  139,  140,  140,
			  138,  140,  137,  135,   19,   58,   19,   56,   37,   55,
			   37,   55,   55,   55,   55,   55,   18,   58,   18,   56,
			   20,   58,   20,   56,   55,   55,   55,   55,   11,   15,
			   58,   61,  134,  134,  134,   65,  134,   66,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			   83,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  102,  134,  134,  105,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  133,  134,   55,   55,   35,   58,
			   35,   56,   12,   58,   12,   56,   43,   58,   48,   58,
			   53,   58,   41,   58,   42,   58,   49,   58,   55,   51,
			   58,   55,   54,   58,   46,   47,   45,   58,   44,   58,
			  232,    4,    4,   57,   55,  205,  205,  193,  195,  205,
			  205,  205, -433,  184,  195,  181,  192,  195,  174,  192,
			  195,  175,  192,  195,  205,  205,  205,  205,  189,  195,
			  205,  183,  195,  182,  192,  195,   57,   60,   55,   59,
			   60,   61,  160,  158,  159,  161,  162,  171,  171,  163,

			  164,  144,  145,  146,  147,  148,  149,  150,  151,  152,
			  153,  154,  155,  156,  157,   36,   58,   36,   56,  141,
			  141,   39,   58,   39,   56,   24,   58,   24,   56,   23,
			   58,   23,   56,  141,  141,  135,  135,  135,   55,   37,
			   58,   37,   55,   37,   55,   21,   58,   21,   56,   22,
			   58,   22,   56,   38,   58,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,   81,
			  134,  134,  134,  134,  134,  134,  134,   90,  134,  134,
			  134,  134,  134,  134,  134,   99,  134,  134,  101,  134,
			  103,  134,  134,  108,  134,  109,  134,  134,  134,  134, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  134,  134,  134,  134,  134,  134,  134,  134,  122,  134,
			  134,  124,  134,  125,  134,  134,  134,  134,  134,  134,
			  131,  134,  132,  134,   40,   58,   40,   56,   50,   58,
			   52,   58,  228,    4,  205,  205,  185,  195,  205,  188,
			  195,  205,  191,  195,  171,  141,  141,  141,  141,  135,
			   37,   58,   37,  134,   63,  134,   64,  134,  134,  134,
			  134,   71,  134,   72,  134,  134,  134,  134,   77,  134,
			  134,  134,  134,  134,  134,  134,  134,   88,  134,  134,
			  134,  134,  134,  134,  134,  134,  100,  134,  134,  106,
			  134,  134,  134,  134,  134,  134,  134,  134,  119,  134,

			  134,  134,  123,  134,  126,  134,  134,  134,  129,  134,
			  134,    4,  205,  205,  205,  165,  141,  141,  141,   62,
			  134,   68,  134,  134,  134,  134,   74,  134,  134,  134,
			  134,  134,   82,  134,   84,  134,  134,   86,  134,  134,
			  134,   91,  134,  134,  134,  134,  134,  134,  134,  107,
			  134,  134,  134,  134,  115,  134,  134,  117,  134,  118,
			  134,  120,  134,  134,  134,  128,  134,  134,  231,  230,
			  229,    4,  205,  205,  205,  141,  141,  141,  141,  134,
			  134,   73,  134,  134,   76,  134,  134,  134,  134,  134,
			   89,  134,   93,  134,  134,   95,  134,   96,  134,  134, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  134,  134,  134,  134,  134,  116,  134,  134,  134,  130,
			  134,    3,    4,  205,  205,  205,  168,  169,  169,  167,
			  169,  166,  141,  141,  141,  141,  141,   69,  134,  134,
			   75,  134,   78,  134,  134,   85,  134,   87,  134,   94,
			  134,  134,  104,  134,  134,  134,  113,  134,  134,  121,
			  134,  127,  134,  205,  187,  195,  190,  195,  141,  141,
			   70,  134,  134,   97,  134,  134,  112,  134,  114,  134,
			  186,  195,   79,  134,  134,  134,  111,  134,  111, yy_Dummy>>,
			1, 79, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2477
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 839
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 840
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

	yyNb_rules: INTEGER = 237
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 238
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
