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
			create an_array.make_filled (0, 0, 2557)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (274, 778, 803)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			an_array.area.fill_with (841, 2461, 2557)
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

			  255,   78,   78,  256,   79,   79,   81,   82,   81,  832,
			   83,   81,   82,   81,  821,   83,   88,   89,   88,   88,
			   89,   88,   91,   92,   91,   91,   92,   91,   94,   94,
			   94,   94,   94,   94,   97,   98,  126,   93,  127,  208,
			   93,  128,  129,   95,  130,  131,   95,  132,  133,  135,
			  198,  136,  136,  136,  136,  149,  150,  159,  134,  153,
			  154,  155,  156,   84,  151,  152,  255,  160,   84,  259,
			  208,  157,  158,  211,  212,  213,  214,  215,   98,  216,
			   98,  475,  198,  476,   84,  217,   98,  218,   98,   84,
			   99,  820,   99,  100,  101,  102,   99,  103,  102,   99, yy_Dummy>>,
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
			  100,  100,   99,   99,  100,  100,   99,  121,  814,  121,
			   97,   98,  121,  137,  138,  139,  121,  121,  205,  123,

			  124,  121,  142,  140,  143,  143,  143,  143,  121,  121,
			  121,  809,  121,  292,  177,  182,  144,  145,  142,  183,
			  143,  143,  143,  143,  178,  179,  205,  180,  189,  219,
			   98,  210,  184,  196,  190,  224,   98,  181,  146,  284,
			  121,  292,  121,  121,  121,  147,  177,  182,  144,  145,
			  197,  183,  227,   98,  179,  180,  286,  141,  184,  189,
			  285,  147,  277,  121,  121,  196,  121,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  197,  287,   96,   96,
			  161,  435,  161,  162,  277,  161,  162,  162,  162,  161,
			  161,  162,  163,  164,  161,  162,  162,  162,  162,  162, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  162,  161,  161,  161,  162,  161,  166,  206,  220,   98,
			  167,  185,  435,  222,   98,  168,  683,  169,  186,  187,
			  295,  207,  170,  171,  188,  228,   98,  262,  263,  262,
			   97,   98,  162,  161,  162,  161,  161,  161,  166,  206,
			  264,  264,  264,  185,  168,  169,  295,  187,  170,  171,
			  188,  264,  264,  264,  162,  162,  161,  161,  162,  161,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,  172,
			  750,   96,   96,  173,  192,  282,  174,  199,  221,  175,
			  792,  202,  176,  223,  193,  281,  194,  200,  283,  380,
			  195,  203,  201,  385,  204,  841,   99,  257,  255,  257,

			  172,  256,  173,  336,  337,  175,  192,  791,  176,  199,
			  342,  343,  202,  193,  194,  380,  195,  203,  201,  385,
			  204,  231,  231,  231,  381,  232,  344,  345,  233,  746,
			  234,  235,  236,   94,   94,   94,   97,   98,  237,  269,
			  269,  269,  269,  346,  347,  238,  386,  239,   95,  561,
			  240,  241,  242,  243,  258,  244,  381,  245,  267,  267,
			  267,  246,  562,  247,  352,  352,  248,  249,  250,  251,
			  252,  253,  386,  268,   98,  258,   99,  270,   99,  364,
			  365,   99,  384,   99,  790,   99,   99,  387,   99,  841,
			   99,  297,  298,  297,  297,  298,  297,   99,   99,   99, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  789,   99,   99,  303,  303,  303,  305,  305,  305,  305,
			   99,  267,  267,  267,  384,   99,   99,  388,  304,  387,
			  267,  267,  267,  370,  371,   99,  331,   98,  120,   99,
			  391,   99,   99,  785,   99,  333,   98,  354,  354,  354,
			  390,   99,  142,   99,  351,  351,  351,  351,  299,  388,
			  738,  389,   99,   99,  400,   99,  391,   99,   99,   99,
			   99,   99,   99,   99,   99,  372,   98,   99,   99,  271,
			  100,  395,  390,  100,  656,   99,  373,  100,  100,  389,
			  272,  100,  100,  400,  764,  147,  398,  401,  739,  100,
			  399,  100,  413,  100,   99,   97,   98,  395,  332,  332,

			  332,  332,   99,  338,  338,  338,  338,   99,   99,   97,
			   98,  719,  334,  334,  334,  334,  399,   99,  339,  401,
			  120,  100,  683,  100,  413,  100,   99,  679,  267,  267,
			  267,  438,  439,   99,  670,   99,   97,   98,  667,  335,
			  335,  335,  335,  340,   98,  450,   98,  663,  100,   99,
			  339,   99,  102,  273,  102,  274,  103,  102,  274,  274,
			  274,  102,  102,  274,  275,  102,  102,  274,  274,  274,
			  274,  274,  274,  102,  102,  102,  274,  102, yy_Dummy>>,
			1, 178, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  276,  102,  274,  102,  102,  102,  274,  274,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  274,  274,  274,
			  274,  274,  276,  274,  102,  102,  274,  102,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,   99,   99,  100,
			  100,   99,  111,  288,  111,  289,  650,  111,  289,  289,
			  289,  111,  111,  289,  290,  111,  111,  289,  289,  289,
			  289,  289,  289,  111,  111,  111,  289,  111,   97,   98,
			  396,  341,  341,  341,  341,  267,  267,  267,  411,  638,
			  302,  452,   98,  633,  348,  397,  349,  349,  349,  349,
			  358,   98,  543,  417,  291,  111,  289,  111,  111,  111,

			  255,  350,  396,  256,  411,  356,  356,  356,  356,   97,
			   98,  397,  359,  359,  359,  359,  291,  289,  111,  111,
			  289,  111,  121,  543,  121,  417,  360,  121,  361,   98,
			  630,  121,  121,  350,  123,  124,  121,  362,  412,  363,
			  262,  263,  262,  121,  121,  121,  357,  121,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  626,  409,  841,
			  841,  377,  377,  377,  412,  267,  267,  267,   97,   98,
			  410,  367,  367,  367,  367,  121,  378,  121,  121,  121,
			  366,   98,   97,   98,  428,  369,  369,  369,  369,  375,
			  409,  541,  379,  379,  379,  379,  348,  436,  121,  121, yy_Dummy>>,
			1, 200, 804)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  524,  121,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,  528,   98,   96,   96,  308,  428,  414,  309,  541,
			  310,  311,  312,  267,  267,  267,  415,  255,  313,  436,
			  259,  382,  392,  522,  383,  314,  393,  315,  368,   98,
			  316,  317,  318,  319,  416,  320,  427,  321,  424,  414,
			  394,  322,  425,  323,  612,  415,  324,  325,  326,  327,
			  328,  329,  382,  383,  392,  404,  431,  429,  393,  405,
			  416,  432,  427,  434,  610,  437,  394,  424,  472,  418,
			  406,  419,  433,  407,  231,  231,  231,   97,   98,  420,
			   99,  458,  421,  429,  422,  423,  530,  404,  431,  434,

			  405,  437,  432,  264,  264,  264,  406,   99,  433,  407,
			  472,  418,  542,  419,  267,  267,  267,  420,  421,  474,
			  422,  423,   97,   98,  606,  441,  441,  441,  441,  440,
			   98,  267,  267,  267,   97,   98,  477,  443,  443,  443,
			  443,  267,  267,  267,  542,  474,  442,   98,  267,  267,
			  267,  267,  267,  267,  574,  547,  444,   98,  267,  267,
			  267,  587,  477,  445,   98,  302,  446,   98,  267,  267,
			  267,   97,   98,  447,   98,  267,  267,  267,  267,  267,
			  267,  547,  531,  448,   98,  267,  267,  267,   97,   98,
			  449,   98,  587,  451,   98,  267,  267,  267,  572,  158, yy_Dummy>>,
			1, 200, 1004)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  453,   98,  267,  267,  267,  459,  460,  460,  460,  570,
			  456,   98,  257,  255,  257,  566,  256,  457,   98,  297,
			  298,  297,  465,  298,  465,  297,  298,  297,  297,  298,
			  297,  540,  546,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  352,  352,  841,  841,  487,  488,  488,  488,
			  267,  267,  267,   97,   98,  563,  506,  506,  506,  506,
			  507,  507,  507,  507,  546,  505,   98,  588,  548,  258,
			  267,  267,  267,  590,  508,  339,  508,  277,  596,  509,
			  509,  509,  509,  521,  563,  510,   98,  354,  354,  354,
			  258,  274,  463,  274,  548,  588,  274,  676,  676,  277,

			  274,  274,  590,  464,  274,  274,  596,  339,  593,  267,
			  267,  267,  274,  274,  274,  376,  274,   97,   98,  549,
			  511,  511,  511,  511,  512,   98,   97,   98,  523,  513,
			  513,  513,  513,  550,  267,  267,  267,   97,   98,  593,
			  515,  515,  515,  515,  274,  524,  274,  274,  274,  514,
			   98,  549,  609,  737,  516,  516,  516,  516,  518,  550,
			  518,  551,  654,  519,  519,  519,  519,  274,  274,  517,
			  274,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			  522,  609,   99,   99,  289,  470,  289,  551,  552,  289,
			  607,  654,  608,  289,  289,  738,  471,  289,  289,  555, yy_Dummy>>,
			1, 200, 1204)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  504,  517,  684,  684,  553,  289,  289,  289,  142,  289,
			  520,  520,  520,  520,  525,  554,  526,  526,  526,  526,
			  552,  527,  527,  527,  527,  555,  558,  267,  267,  267,
			  267,  267,  267,  377,  377,  377,  553,  289,  503,  289,
			  289,  289,  529,   98,  502,  532,   98,  554,  537,   97,
			   98,  147,  533,  533,  533,  533,  501,  357,  558,  559,
			  289,  289,  357,  289,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,  544,  564,   99,   99,  480,  480,  480,
			  267,  267,  267,   97,   98,  559,  535,  535,  535,  535,
			  545,  560,  481,  556,  565,  534,   98,  267,  267,  267,

			  538,  538,  538,  567,  568,  544,  564,  557,  569,  571,
			  573,  575,  536,   98,  576,  539,  545,  560,  577,  578,
			  579,  580,  583,  584,  500,  556,  565,  585,  592,  465,
			  298,  465,  352,  352,  499,  567,  568,  575,  581,  498,
			  569,  571,  573,  586,  589,  591,  576,  580,  583,  594,
			  577,  578,  579,  595,  592,  584,  582,  627,  497,  585,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  496,
			  581,  841,  841,  521,  628,  586,  589,  591,  611,  655,
			  594,  629,  582,  627,  277,  595,  267,  267,  267,   97,
			   98,  495,  598,  598,  598,  598,  267,  267,  267,  494, yy_Dummy>>,
			1, 200, 1404)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  628,  597,   98,  267,  267,  267,  277,  629,  655,  493,
			  611,  599,   98,  601,  460,  460,  460,  460,  600,   98,
			  601,  460,  460,  460,  460,  631,  602,  603,  613,  488,
			  488,  488,  488,  613,  488,  488,  488,  488,  267,  267,
			  267,  614,  615,  509,  509,  509,  509,  745,  604,  618,
			  618,  618,  618,  625,   98,  605,  643,  631,  602,  603,
			  528,   98,  605,  616,  339,  509,  509,  509,  509,  492,
			  617,  363,  491,  614,  615,  617,  620,  620,  620,  620,
			  621,  490,  621,  632,  643,  622,  622,  622,  622,  746,
			  619,  517,  519,  519,  519,  519,  339,  519,  519,  519,

			  519,  623,  634,  520,  520,  520,  520,  525,  635,  624,
			  624,  624,  624,  525,  632,  527,  527,  527,  527,  360,
			  636,  361,   98,  517,  641,  637,  639,  640,  634,  489,
			  362,  646,  642,  648,  644,  645,  647,  649,  651,  652,
			  635,  653,  486,  660,  357,  661,  636,  659,  664,  662,
			  357,  668,  639,  666,  665,  641,  357,  637,  642,  640,
			  644,  645,  647,  646,  651,  648,  669,  653,  649,  660,
			  671,  652,  656,  656,  656,  662,  657,  661,  659,  664,
			  665,  672,  666,  668,  673,  674,  675,  658,  677,  677,
			  677,  680,  669,  460,  460,  460,  460,  681,  682,  686, yy_Dummy>>,
			1, 200, 1604)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  686,  686,  671,  688,  688,  688,  688,  695,   96,  485,
			  673,  353,  353,  672,  674,   96,   96,  680,  675,  697,
			  618,  618,  618,  618,  484,  696,  698,  682,  681,  690,
			  690,  690,  690,  695,  605,  689,  691,  691,  691,  691,
			  622,  622,  622,  622,  617,  622,  622,  622,  622,  657,
			  697,  517,  348,  696,  691,  691,  691,  691,  698,  694,
			  699,  527,  527,  527,  527,  702,  703,  689,  700,  693,
			  708,  709,  701,  704,  705,  706,  707,  692,  712,  710,
			  713,  711,  714,  517,  715,  717,  699,  716,  721,  725,
			  720,  483,  703,  702,  722,  723,  708,  724,  726,  709,

			  700,  693,  147,  701,  704,  710,  705,  706,  707,  711,
			  712,  713,  727,  714,  721,  725,  715,  717,  716,  656,
			  656,  656,  720,  718,  728,  722,  729,  723,  730,  724,
			  726,  731,  732,  740,  658,  733,  676,  676,  727,  735,
			  677,  677,  677,  741,  742,  743,  684,  684,  749,  482,
			  728,  747,  686,  686,  686,  479,  761,  766,  729,  730,
			  732,  478,  767,  731,  740,  751,  688,  688,  688,  688,
			  742,  757,  757,  757,  757,  741,  473,  734,  752,  762,
			  752,  736,   99,  753,  753,  753,  753,  744,  761,  766,
			  750,  763,  768,  748,  767,  769,  718,  754,  754,  754, yy_Dummy>>,
			1, 200, 1804)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  754,  691,  691,  691,  691,  762,  348,  617,  757,  757,
			  757,  757,  755,  758,  765,  758,  756,  763,  759,  759,
			  759,  759,  770,  760,  768,  771,  773,  769,  772,  775,
			  777,  774,  776,  781,  778,  779,  780,  469,  783,  468,
			  765,  782,  784,  786,  755,  676,  676,  787,  756,  788,
			  467,  771,  773,  466,  770,  760,  772,  774,  776,  777,
			  778,  775,  802,  779,  780,  781,  783,  782,  784,  677,
			  677,  677,   99,  787,  803,  786,  753,  753,  753,  753,
			   99,  788,  753,  753,  753,  753,  734,  793,  793,  793,
			  793,  794,  805,  794,  802,  806,  795,  795,  795,  795,

			  803,  796,  755,  796,  804,  807,  797,  797,  797,  797,
			  736,  798,  798,  798,  798,  759,  759,  759,  759,  759,
			  759,  759,  759,  800,  805,  800,  799,  806,  801,  801,
			  801,  801,  804,  808,  755,  810,  811,  807,  812,  812,
			  812,  815,  816,  817,  818,  827,  755,  355,  355,  819,
			  795,  795,  795,  795,  795,  795,  795,  795,  799,  825,
			  462,  826,  808,  810,  797,  797,  797,  797,  811,  813,
			  829,  827,  619,  815,  816,  817,  818,  819,  755,  797,
			  797,  797,  797,  822,  822,  822,  822,  823,  830,  823,
			  826,  825,  824,  824,  824,  824,  831,  799,  799,  829, yy_Dummy>>,
			1, 200, 2004)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  833,  813,  801,  801,  801,  801,  801,  801,  801,  801,
			  812,  812,  812,  834,  830,  824,  824,  824,  824,  824,
			  824,  824,  824,  692,  835,  836,  837,  838,  831,  799,
			  799,  261,  833,  839,  840,  165,  165,  165,  165,  678,
			  678,  828,  834,  122,  230,  122,  455,  122,  122,  122,
			  122,  122,  837,  838,  685,  685,  835,  836,  454,  839,
			  840,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,  430,  828,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   87,   87,   87,   87,

			   87,   87,   87,   87,   87,   87,   87,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,  125,  125,
			  125,  125,  125,  125,  125,  125,  125,  125,  229,  229,
			  229,  426,  229,  229,  229,  229,  229,  229,  254,  254,
			  254,  254,  254,  254,  254,  254,  254,  254,  254,  258,
			  258,  258,  258,  258,  258,  258,  258,  258,  258,  258,
			  260,  260,  260,  260,  260,  260,  260,  260,  260,  260,
			  260,  103,  408,  103,  103,  103,  103,  103,  103,  103,
			  103,  306,  306,  306,  306,  306,  306,  306,  306,  306,
			  306,  162,  403,  162,  402,  162,  687,  687,  162,  461, yy_Dummy>>,
			1, 200, 2204)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  719,
			  719,  719,  719,  719,  719,  719,  719,  719,  719,  719,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  376,  375,  374,  335,  330,  307,  301,  300,  296,  294,
			  293,  280,  279,  278,  266,  265,  261,  230,  226,  225,
			  209,  191,  148,  841,   86,   86,   13, yy_Dummy>>,
			1, 57, 2404)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2557)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 97)
			yy_chk_template_1 (an_array)
			an_array.area.fill_with (18, 192, 286)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (102, 751, 845)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			an_array.area.fill_with (841, 2460, 2557)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   80,    3,    4,   80,    3,    4,    5,    5,
			    5,  819,    5,    6,    6,    6,  788,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   21,   11,
			   21,   55,   12,   24,   24,   15,   25,   25,   16,   27,
			   27,   28,   50,   28,   28,   28,   28,   34,   34,   37,
			   27,   35,   35,   36,   36,    5,   34,   34,   84,   37,
			    6,   84,   55,   36,   36,   60,   60,   63,   63,   64,
			   64,   65,   65,  295,   50,  295,    5,   66,   66,   67,
			   67,    6,   18,  787, yy_Dummy>>,
			1, 94, 98)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   19,  778,   19,   58,   58,   19,   29,   29,   29,   19,
			   19,   53,   19,   19,   19,   30,   29,   30,   30,   30,
			   30,   19,   19,   19,  772,   19,  112,   42,   44,   30,
			   30,   31,   44,   31,   31,   31,   31,   42,   43,   53,
			   43,   46,   68,   68,   58,   44,   49,   46,   71,   71,
			   43,   30,  109,   19,  112,   19,   19,   19,   30,   42,
			   44,   30,   30,   49,   44,   74,   74,   43,   43,  110,
			   29,   44,   46,  109,   31,  103,   19,   19,   49,   19,
			   19,   19,   19,   19,   19,   19,   19,   19,   19,   49,
			  110,   19,   19,   38,  207,   38,   38,  103,   38,   38,

			   38,   38,   38,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   38,   38,   38,   39,
			   54,   69,   69,   39,   45,  207,   70,   70,   39,  751,
			   39,   45,   45,  115,   54,   39,   39,   45,   75,   75,
			   88,   88,   88,   96,   96,   38,   38,   38,   38,   38,
			   38,   39,   54,   91,   91,   91,   45,   39,   39,  115,
			   45,   39,   39,   45,   92,   92,   92,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   41,  750,   38,   38,   41,   48,  108,   41,
			   51,   69,   41,  749,   52,   41,   70,   48,  107,   48, yy_Dummy>>,
			1, 200, 287)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   51,  108,  166,   48,   52,   51,  170,   52,  748,  107,
			   81,   81,   81,   41,   81,   41,  134,  134,   41,   48,
			  747,   41,   51,  139,  139,   52,   48,   48,  166,   48,
			   52,   51,  170,   52,   79,   79,   79,  167,   79,  140,
			  140,   79,  746,   79,   79,   79,   94,   94,   94,   98,
			   98,   79,   98,   98,   98,   98,  141,  141,   79,  171,
			   79,   94,  402,   79,   79,   79,   79,   81,   79,  167,
			   79,   97,   97,   97,   79,  402,   79,  144,  144,   79,
			   79,   79,   79,   79,   79,  171,   97,   97,   81,   99,
			   99,   99,  152,  152,   99,  169,   99,  745,   99,   99,

			  172,   99,  744,   99,  117,  117,  117,  120,  120,  120,
			   99,   99,   99,  743,   99,   99,  123,  123,  123,  124,
			  124,  124,  124,   99,  128,  128,  128,  169,   99,   99,
			  173,  123,  172,  130,  130,  130,  157,  157,   99,  128,
			  128,   99,   99,  176,   99,   99,  739,   99,  130,  130,
			  145,  145,  145,  175,   99,  143,   99,  143,  143,  143,
			  143,  117,  173,  738,  174,   99,   99,  182,   99,  176,
			   99,   99,   99,   99,   99,   99,   99,   99,  158,  158,
			   99,   99,  100,  100,  179,  175,  100,  719,  100,  158,
			  100,  100,  174,  100,  100,  100,  182,  701,  143,  181, yy_Dummy>>,
			1, 200, 487)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  183,  679,  100,  181,  100,  193,  100,  100,  129,  129,
			  179,  129,  129,  129,  129,  100,  136,  136,  136,  136,
			  100,  100,  131,  131,  658,  131,  131,  131,  131,  181,
			  100,  136,  183,  100,  100,  613,  100,  193,  100,  100,
			  606,  137,  137,  137,  210,  210,  100,  587,  100,  133,
			  133,  583,  133,  133,  133,  133,  137,  137,  221,  221,
			  579,  100,  102,  136, yy_Dummy>>,
			1, 64, 687)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  111,  111,  111,  111,  564,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  138,  138,  180,  138,
			  138,  138,  138,  149,  149,  149,  191,  551,  122,  223,
			  223,  546,  142,  180,  142,  142,  142,  142,  149,  149,
			  385,  197,  111,  111,  111,  111,  111,  111,  254,  142,
			  180,  254,  191,  147,  147,  147,  147,  150,  150,  180,
			  150,  150,  150,  150,  111,  111,  111,  111,  111,  111,
			  121,  385,  121,  197,  151,  121,  151,  151,  543,  121,
			  121,  142,  121,  121,  121,  151,  192,  151,  262,  262,

			  262,  121,  121,  121,  147,  121,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  529,  190,  122,  122,  163,
			  163,  163,  192,  153,  153,  153,  154,  154,  190,  154,
			  154,  154,  154,  121,  163,  121,  121,  121,  153,  153,
			  156,  156,  202,  156,  156,  156,  156,  164,  190,  381,
			  164,  164,  164,  164,  525,  208,  121,  121,  524,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  360,
			  360,  121,  121,  126,  202,  194,  126,  381,  126,  126,
			  126,  155,  155,  155,  194,  258,  126,  208,  258,  168,
			  177,  522,  168,  126,  177,  126,  155,  155,  126,  126, yy_Dummy>>,
			1, 200, 846)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  126,  126,  196,  126,  201,  126,  199,  194,  177,  126,
			  199,  126,  477,  194,  126,  126,  126,  126,  126,  126,
			  168,  168,  177,  187,  205,  203,  177,  187,  196,  205,
			  201,  206,  474,  209,  177,  199,  292,  198,  187,  198,
			  205,  187,  231,  231,  231,  362,  362,  198,  471,  231,
			  198,  203,  198,  198,  362,  187,  205,  206,  187,  209,
			  205,  264,  264,  264,  187,  464,  205,  187,  292,  198,
			  382,  198,  211,  211,  211,  198,  198,  294,  198,  198,
			  212,  212,  462,  212,  212,  212,  212,  211,  211,  213,
			  213,  213,  214,  214,  296,  214,  214,  214,  214,  215,

			  215,  215,  382,  294,  213,  213,  216,  216,  216,  217,
			  217,  217,  415,  388,  215,  215,  218,  218,  218,  427,
			  296,  216,  216,  305,  217,  217,  219,  219,  219,  363,
			  363,  218,  218,  220,  220,  220,  222,  222,  222,  388,
			  363,  219,  219,  224,  224,  224,  373,  373,  220,  220,
			  427,  222,  222,  227,  227,  227,  412,  373,  224,  224,
			  228,  228,  228,  237,  237,  237,  237,  410,  227,  227,
			  257,  257,  257,  406,  257,  228,  228,  276,  276,  276,
			  277,  277,  277,  291,  291,  291,  297,  297,  297,  380,
			  387,  305,  305,  305,  305,  305,  305,  305,  305,  305, yy_Dummy>>,
			1, 200, 1046)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  352,  352,  305,  305,  313,  313,  313,  313,  336,  336,
			  336,  337,  337,  403,  337,  337,  337,  337,  338,  338,
			  338,  338,  387,  336,  336,  428,  389,  257,  342,  342,
			  342,  430,  339,  338,  339,  277,  436,  339,  339,  339,
			  339,  352,  403,  342,  342,  354,  354,  354,  257,  274,
			  274,  274,  389,  428,  274,  602,  602,  277,  274,  274,
			  430,  274,  274,  274,  436,  338,  433,  344,  344,  344,
			  274,  274,  274,  379,  274,  343,  343,  390,  343,  343,
			  343,  343,  344,  344,  345,  345,  354,  345,  345,  345,
			  345,  391,  346,  346,  346,  347,  347,  433,  347,  347,

			  347,  347,  274,  355,  274,  274,  274,  346,  346,  390,
			  473,  678,  349,  349,  349,  349,  350,  391,  350,  392,
			  569,  350,  350,  350,  350,  274,  274,  349,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  274,  353,  473,
			  274,  274,  289,  289,  289,  392,  393,  289,  472,  569,
			  472,  289,  289,  678,  289,  289,  289,  397,  329,  349,
			  614,  614,  394,  289,  289,  289,  351,  289,  351,  351,
			  351,  351,  356,  395,  356,  356,  356,  356,  393,  357,
			  357,  357,  357,  397,  399,  361,  361,  361,  364,  364,
			  364,  375,  375,  375,  394,  289,  328,  289,  289,  289, yy_Dummy>>,
			1, 200, 1246)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  361,  361,  327,  364,  364,  395,  375,  365,  365,  351,
			  365,  365,  365,  365,  326,  356,  399,  400,  289,  289,
			  357,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  386,  404,  289,  289,  302,  302,  302,  370,  370,
			  370,  371,  371,  400,  371,  371,  371,  371,  386,  401,
			  302,  398,  405,  370,  370,  372,  372,  372,  376,  376,
			  376,  407,  408,  386,  404,  398,  409,  411,  414,  416,
			  372,  372,  417,  376,  386,  401,  418,  419,  420,  421,
			  423,  424,  325,  398,  405,  425,  432,  465,  465,  465,
			  521,  521,  324,  407,  408,  416,  422,  323,  409,  411,

			  414,  426,  429,  431,  417,  421,  423,  434,  418,  419,
			  420,  435,  432,  424,  422,  540,  322,  425,  302,  302,
			  302,  302,  302,  302,  302,  302,  302,  321,  422,  302,
			  302,  521,  541,  426,  429,  431,  475,  572,  434,  542,
			  422,  540,  465,  435,  438,  438,  438,  439,  439,  320,
			  439,  439,  439,  439,  450,  450,  450,  319,  541,  438,
			  438,  452,  452,  452,  465,  542,  572,  318,  475,  450,
			  450,  459,  459,  459,  459,  459,  452,  452,  460,  460,
			  460,  460,  460,  544,  459,  459,  487,  487,  487,  487,
			  487,  488,  488,  488,  488,  488,  528,  528,  528,  487, yy_Dummy>>,
			1, 200, 1446)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  487,  508,  508,  508,  508,  685,  459,  507,  507,  507,
			  507,  528,  528,  459,  556,  544,  459,  459,  531,  531,
			  460,  487,  507,  509,  509,  509,  509,  317,  487,  531,
			  316,  487,  487,  488,  516,  516,  516,  516,  517,  315,
			  517,  545,  556,  517,  517,  517,  517,  685,  507,  516,
			  518,  518,  518,  518,  507,  519,  519,  519,  519,  520,
			  547,  520,  520,  520,  520,  526,  548,  526,  526,  526,
			  526,  527,  545,  527,  527,  527,  527,  530,  549,  530,
			  530,  516,  554,  550,  552,  553,  547,  314,  530,  559,
			  555,  562,  557,  558,  560,  563,  565,  566,  548,  567,

			  312,  576,  520,  577,  549,  575,  580,  578,  526,  584,
			  552,  582,  581,  554,  527,  550,  555,  553,  557,  558,
			  560,  559,  565,  562,  585,  567,  563,  576,  590,  566,
			  573,  573,  573,  578,  573,  577,  575,  580,  581,  591,
			  582,  584,  592,  593,  594,  573,  603,  603,  603,  607,
			  585,  605,  605,  605,  605,  609,  611,  615,  615,  615,
			  590,  617,  617,  617,  617,  627,  847,  311,  592,  857,
			  857,  591,  593,  847,  847,  607,  594,  631,  618,  618,
			  618,  618,  310,  630,  632,  611,  609,  619,  619,  619,
			  619,  627,  605,  618,  620,  620,  620,  620,  621,  621, yy_Dummy>>,
			1, 200, 1646)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  621,  621,  617,  622,  622,  622,  622,  573,  631,  620,
			  623,  630,  623,  623,  623,  623,  632,  624,  635,  624,
			  624,  624,  624,  637,  639,  618,  636,  623,  644,  645,
			  636,  640,  641,  642,  643,  620,  649,  647,  650,  648,
			  651,  620,  652,  655,  635,  653,  660,  664,  659,  309,
			  639,  637,  661,  662,  644,  663,  665,  645,  636,  623,
			  624,  636,  640,  647,  641,  642,  643,  648,  649,  650,
			  666,  651,  660,  664,  652,  655,  653,  656,  656,  656,
			  659,  656,  668,  661,  669,  662,  672,  663,  665,  673,
			  675,  680,  656,  676,  676,  676,  666,  677,  677,  677,

			  677,  681,  682,  684,  684,  684,  687,  308,  668,  686,
			  686,  686,  686,  300,  697,  703,  669,  672,  675,  299,
			  704,  673,  680,  688,  688,  688,  688,  688,  682,  692,
			  692,  692,  692,  681,  293,  676,  689,  698,  689,  677,
			  290,  689,  689,  689,  689,  684,  697,  703,  687,  699,
			  707,  686,  704,  709,  656,  690,  690,  690,  690,  691,
			  691,  691,  691,  698,  694,  688,  694,  694,  694,  694,
			  690,  693,  702,  693,  691,  699,  693,  693,  693,  693,
			  710,  694,  707,  712,  714,  709,  713,  716,  720,  715,
			  717,  725,  721,  722,  723,  287,  730,  285,  702,  729, yy_Dummy>>,
			1, 200, 1846)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  732,  740,  690,  734,  734,  741,  691,  742,  283,  712,
			  714,  278,  710,  694,  713,  715,  717,  720,  721,  716,
			  761,  722,  723,  725,  730,  729,  732,  736,  736,  736,
			  275,  741,  762,  740,  752,  752,  752,  752,  272,  742,
			  753,  753,  753,  753,  734,  754,  754,  754,  754,  755,
			  766,  755,  761,  767,  755,  755,  755,  755,  762,  756,
			  754,  756,  764,  768,  756,  756,  756,  756,  736,  757,
			  757,  757,  757,  758,  758,  758,  758,  759,  759,  759,
			  759,  760,  766,  760,  757,  767,  760,  760,  760,  760,
			  764,  769,  754,  775,  776,  768,  777,  777,  777,  779,

			  780,  782,  783,  810,  793,  858,  858,  786,  794,  794,
			  794,  794,  795,  795,  795,  795,  757,  803,  265,  806,
			  769,  775,  796,  796,  796,  796,  776,  777,  813,  810,
			  793,  779,  780,  782,  783,  786,  793,  797,  797,  797,
			  797,  798,  798,  798,  798,  799,  814,  799,  806,  803,
			  799,  799,  799,  799,  816,  822,  798,  813,  826,  777,
			  800,  800,  800,  800,  801,  801,  801,  801,  812,  812,
			  812,  828,  814,  823,  823,  823,  823,  824,  824,  824,
			  824,  822,  829,  834,  835,  836,  816,  822,  798,  260,
			  826,  837,  838,  850,  850,  850,  850,  861,  861,  812, yy_Dummy>>,
			1, 200, 2046)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  828,  848,  229,  848,  226,  848,  848,  848,  848,  848,
			  835,  836,  862,  862,  829,  834,  225,  837,  838,  842,
			  842,  842,  842,  842,  842,  842,  842,  842,  842,  842,
			  204,  812,  843,  843,  843,  843,  843,  843,  843,  843,
			  843,  843,  843,  844,  844,  844,  844,  844,  844,  844,
			  844,  844,  844,  844,  845,  845,  845,  845,  845,  845,
			  845,  845,  845,  845,  845,  846,  846,  846,  846,  846,
			  846,  846,  846,  846,  846,  846,  849,  849,  849,  849,
			  849,  849,  849,  849,  849,  849,  851,  851,  851,  200,
			  851,  851,  851,  851,  851,  851,  852,  852,  852,  852,

			  852,  852,  852,  852,  852,  852,  852,  853,  853,  853,
			  853,  853,  853,  853,  853,  853,  853,  853,  854,  854,
			  854,  854,  854,  854,  854,  854,  854,  854,  854,  855,
			  189,  855,  855,  855,  855,  855,  855,  855,  855,  856,
			  856,  856,  856,  856,  856,  856,  856,  856,  856,  859,
			  186,  859,  184,  859,  863,  863,  859,  860,  860,  860,
			  860,  860,  860,  860,  860,  860,  860,  864,  864,  864,
			  864,  864,  864,  864,  864,  864,  864,  864,  865,  865,
			  865,  865,  865,  865,  865,  865,  865,  865,  162,  161,
			  159,  132,  127,  125,  119,  118,  116,  114,  113,  106, yy_Dummy>>,
			1, 200, 2246)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  105,  104,   95,   93,   85,   76,   73,   72,   56,   47,
			   32,   13,    8,    7, yy_Dummy>>,
			1, 14, 2446)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 865)
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
			    0,    0,    0,   96,   97,  105,  110, 2457, 2456,  115,
			  118,  121,  124, 2457, 2460,  127,  130,  118,  189,  283,
			 2460,  128, 2460, 2460,  125,  128, 2460,  131,  132,  277,
			  285,  301, 2430, 2460,  139,  143,  145,  141,  376,  374,
			    0,  432,  280,  284,  285,  376,  290, 2411,  443,  303,
			  116,  443,  444,  255,  377,  102, 2410, 2460,  274, 2460,
			  157, 2460, 2460,  159,  161,  163,  169,  171,  313,  392,
			  397,  319, 2437, 2436,  336,  409, 2446, 2460, 2460,  520,
			   98,  496, 2460, 2460,  164, 2448, 2460, 2460,  426, 2460,
			 2460,  439,  450, 2433,  532, 2432,  414,  557,  520,  572,

			  664, 2460,  748,  306, 2435, 2441, 2440,  480,  470,  334,
			  351,  842,  270, 2402, 2399,  373, 2398,  590, 2384, 2435,
			  593,  922,  868,  602,  587, 2429, 1014, 2428,  610,  679,
			  619,  693, 2421,  720,  487, 2460,  684,  727,  856,  494,
			  510,  527,  871,  625,  545,  618,    0,  890, 2460,  878,
			  897,  916,  563,  968,  956, 1026,  970,  607,  649, 2420,
			 2460, 2419, 2418,  964,  977,    0,  442,  490,  997,  549,
			  445,  497,  553,  587,  608,  606,  583, 1005,    0,  623,
			  841,  641,  613,  657, 2354,    0, 2351, 1036,    0, 2336,
			  930,  833,  894,  659,  989,    0, 1001,  863, 1050, 1011, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2293, 1003,  954, 1021, 2231, 1037, 1030,  343,  967, 1032,
			  715, 1117, 1110, 1134, 1122, 1144, 1151, 1154, 1161, 1171,
			 1178,  729, 1181,  869, 1188, 2246, 2234, 1198, 1205, 2243,
			 2460, 1087, 2460, 2460, 2460, 2460, 2460, 1190, 2460, 2460,
			 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460,
			 2460, 2460, 2460, 2460,  902, 2460, 2460, 1215, 1029, 2460,
			 2233, 2460,  943, 2460, 1106, 2158, 2460, 2460, 2460, 2460,
			 2460, 2460, 2068, 2460, 1291, 2060, 1222, 1225, 2052, 2460,
			 2460, 2460, 2460, 2049, 2460, 2038, 2460, 2036, 2460, 1384,
			 1970, 1228, 1049, 1935, 1074,  178, 1093, 1231, 2460, 1960,

			 1954, 2460, 1480, 2460, 2460, 1153, 2460, 2460, 1943, 1885,
			 1818, 1803, 1736, 1231, 1723, 1675, 1666, 1663, 1603, 1593,
			 1585, 1563, 1552, 1533, 1528, 1518, 1450, 1438, 1432, 1394,
			 2460, 2460, 2460, 2460, 2460, 2460, 1253, 1241, 1245, 1264,
			 2460, 2460, 1273, 1305, 1312, 1314, 1337, 1325, 2460, 1339,
			 1348, 1395, 1227, 1324, 1272, 1289, 1401, 1406, 2460, 2460,
			  999, 1430, 1075, 1159, 1433, 1437, 2460, 2460, 2460, 2460,
			 1483, 1471, 1500, 1176, 2460, 1436, 1503, 2460, 2460, 1303,
			 1191,  952, 1086,    0,    0,  858, 1447, 1204, 1111, 1221,
			 1293, 1290, 1315, 1358, 1378, 1385,    0, 1353, 1467, 1396, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1415, 1446,  507, 1218, 1444, 1464, 1174, 1477, 1474, 1482,
			 1168, 1479, 1158,    0, 1480, 1104, 1466, 1486, 1488, 1489,
			 1494, 1475, 1510, 1479, 1493, 1501, 1513, 1127, 1228, 1514,
			 1236, 1515, 1486, 1274, 1515, 1524, 1239,    0, 1589, 1577,
			 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460,
			 1599, 2460, 1606, 2460, 2460, 2460, 2460, 2460, 2460, 1599,
			 1606,    0, 1058, 2460, 1095, 1532, 2460, 2460, 2460, 2460,
			 2460, 1078, 1391, 1315, 1073, 1548, 2460, 1053, 2460, 2460,
			 2460, 2460, 2460, 2460, 2460, 2460, 2460, 1614, 1619, 2460,
			 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460,

			 2460, 2460, 2460, 2460, 2460, 2460, 2460, 1634, 1628, 1650,
			 2460, 2460, 2460, 2460, 2460, 2460, 1661, 1670, 1677, 1682,
			 1688, 1517,  977,    0,  944,  983, 1694, 1700, 1641,  945,
			 1709, 1648, 2460, 2460, 2460, 2460, 2460, 2460, 2460, 2460,
			 1513, 1529, 1537,  898, 1597, 1649,  847, 1658, 1678, 1675,
			 1695,  847, 1683, 1699, 1690, 1689, 1617, 1691, 1692, 1701,
			 1690,    0, 1703, 1703,  797, 1695, 1709, 1698,    0, 1325,
			    0,    0, 1542, 1775,    0, 1713, 1697, 1714, 1706,  705,
			 1714, 1708, 1716,  684, 1723, 1723,    0,  689,    0,    0,
			 1740, 1750, 1738, 1748, 1760,    0,    0, 2460, 2460, 2460, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2460, 2460, 1282, 1773,    0, 1778,  658, 1746, 2460, 1763,
			 2460, 1761, 2460,  712, 1387, 1784,    0, 1788, 1805, 1814,
			 1821, 1825, 1830, 1839, 1846, 2460, 2460, 1763,    0,    0,
			 1786, 1786, 1799,    0,    0, 1817, 1838, 1826,    0, 1823,
			 1840, 1843, 1845, 1847, 1825, 1832,    0, 1836, 1842, 1848,
			 1846, 1848, 1856, 1853,    0, 1855, 1922, 2460,  695, 1864,
			 1845, 1860, 1865, 1867, 1846, 1868, 1867,    0, 1879, 1900,
			    0,    0, 1894, 1901,    0, 1893, 1921, 1925, 1339,  617,
			 1900, 1913, 1900, 2460, 1931, 1633, 1937, 1934, 1951, 1968,
			 1982, 1986, 1956, 2003, 1993,    0,    0, 1926, 1933, 1946,

			    0,  640, 1969, 1927, 1936,    0,    0, 1962,    0, 1969,
			 1992,    0, 1981, 1989, 1981, 1986, 2003, 1987, 2460,  672,
			 1993, 1990, 1996, 1997,    0, 2003,    0,    0,    0, 1996,
			 1999,    0, 1997, 2460, 2030, 2460, 2054, 2460,  590,  567,
			 2013, 2003, 2019,  590,  571,  574,  469,  497,  477,  470,
			  410,  406, 2061, 2067, 2072, 2081, 2091, 2096, 2100, 2104,
			 2113, 2033, 2029,    0, 2065,    0, 2063, 2068, 2076, 2096,
			    0,    0,  275,    0,    0, 2096, 2106, 2141,  244, 2111,
			 2114,    0, 2113, 2114,    0,    0, 2110,  186,  109, 2460,
			 2460, 2460, 2460, 2116, 2135, 2139, 2149, 2164, 2168, 2177, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2187, 2191,    0, 2129,    0,    0, 2124,    0,    0,    0,
			 2100,    0, 2213, 2133, 2145,    0, 2166,    0,    0,  104,
			 2460, 2460, 2167, 2200, 2204,    0, 2170,    0, 2176, 2198,
			    0,    0, 2460,    0, 2199, 2182, 2183, 2189, 2190,    0,
			 2460, 2460, 2264, 2277, 2288, 2299, 2310, 1810, 2245, 2320,
			 2233, 2330, 2341, 2352, 2363, 2373, 2383, 1809, 2145, 2393,
			 2401, 2237, 2252, 2394, 2412, 2422, yy_Dummy>>,
			1, 66, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 865)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (850, 165, 209)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (841, 306, 335)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (850, 380, 437)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (841, 478, 520)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (850, 540, 596)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (850, 627, 655)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (841, 856, 865)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  841,    1,  842,  842,  843,  843,  844,  844,  845,
			  845,  846,  846,  841,  841,  841,  841,  847,  841,  848,
			  841,  849,  841,  841,  847,  847,  841,  847,  841,  847,
			  841,  841,  841,  841,  847,  847,  847,  841,  841,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  841,  847,  841,
			  847,  841,  841,  847,  847,  847,  847,  847,  847,  847,
			  847,  847,  841,  841,  847,  847,  851,  841,  841,  841,
			  852,  852,  841,  841,  853,  854,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  847,  847,  847,   18,

			   18,  841,  841,  855,   99,  100,  100,  100,  100,  100,
			  100,  100,   99,   99,   99,   99,   99,   99,  100,  100,
			   99,  848,  848,  121,  121,  856,  856,  856,  847,  847,
			  847,  847,  841,  847,  847,  841,  841,  847,  847,  847,
			  847,  847,  841,  841,  857,  857,  858,  841,  841,  847,
			  847,  847,  847,  847,  847,  847,  847,  847,  847,  841,
			  841,   38,  859,   38,   38, yy_Dummy>>,
			1, 165, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  847,  847,  847,  847,  847,  847,  847,  847,  847,  847,
			  847,  847,  847,  847,  847,  841,  841,  847,  847,  851,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  852,  841,  841,  852,  853,  841,
			  854,  841,  841,  841,  841,  860,  841,  841,  841,  841,
			  841,  841,  100,  841,  102,  102,  274,  855,   99,  841,
			  841,  841,  841,  100,  841,  100,  841,  100,  841,  111,
			  111,  289,   99,   99,   99,   99,   99,   99,  841,   99,
			  100,  841,  848,  841,  841,  848, yy_Dummy>>,
			1, 96, 210)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  847,  847,  841,  841,  841,  841,  847,  847,  847,  847,
			  847,  847,  841,  841,  841,  841,  857,  857,  857,  858,
			  841,  841,  841,  841,  847,  847,  847,  847,  847,  847,
			  841,  841,  841,  841,  847,  847,  847,  847,  841,   38,
			  859,  841,  841,  859, yy_Dummy>>,
			1, 44, 336)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  847,  847,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  847,  841,  847,  841,  841,  841,  841,  841,
			  841,  841,  841,  860,  860,  841,  274,  855,  841,  841,
			  841,  841,  841,  289,   99,   99,   99,   99,  841,   99, yy_Dummy>>,
			1, 40, 438)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  857,  857,  354,  858,  841,  841,  841,  847,  841,  847,
			  847,  841,  841,  841,  841,  841,  841,  841,  841, yy_Dummy>>,
			1, 19, 521)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  841,  841,  841,  841,  841,  841,  841,  861,  841,  860,
			   99,  841,   99,  841,   99,  841,  841,  862,  862,  863,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841, yy_Dummy>>,
			1, 30, 597)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  841,  841,  841,  850,  850,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  850,
			  841,  841,  861,  860,   99,   99,   99,  841,  862,  862,
			  862,  863,  841,  841,  841,  841,  841,  841,  841,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  850,
			  850,  850,  841,  864,  850,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  841,  841,  841,
			  841,  841,  861,  860,   99,   99,   99,  841,  684,  841,
			  862,  841,  686,  841,  863,  841,  841,  841,  841,  841,

			  841,  841,  841,  841,  841,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  850,  850,  850,  865,
			   99,   99,   99,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  850,  850,  850,  850,
			  850,  850,  850,  850,  850,  850,  841,  850,  850,  850,
			  850,  850,  850,   99,  841,  841,  841,  841,  841,  850,
			  850,  850,  841,  850,  850,  850,  841,  850,  841,  850,
			  841,  850,  841,  850,  841,    0,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841, yy_Dummy>>,
			1, 200, 656)
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
			    0,   11,    1,   11,    2,    3,    2,    4,    5,    2,
			    4,    4,    4,    2,    2,    4,    2,    2,    2,    6,
			    6,    6,    6,    4,    4,    2,    2,    2,    4,    2,
			    7,    7,    7,    7,    7,    7,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    4,    2,    4,    2,
			    9,    2,    7,    7,    7,    7,    7,    7,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    4,    4,
			    2,    2,    4,    2,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   11,   11,   10,   10,   11, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 842)
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
			  239,  241,  244,  246,  248,  249,  249,  250,  251,  252,

			  253,  254,  255,  256,  256,  257,  258,  259,  260,  261,
			  262,  263,  264,  265,  266,  267,  268,  269,  271,  272,
			  273,  275,  277,  278,  280,  282,  283,  284,  285,  286,
			  287,  288,  289,  290,  291,  293,  294,  295,  296,  297,
			  299,  301,  303,  304,  305,  305,  305,  305,  305,  306,
			  307,  308,  310,  312,  313,  314,  315,  316,  318,  320,
			  320,  321,  323,  324,  326,  328,  329,  330,  331,  332,
			  333,  335,  336,  337,  338,  339,  340,  341,  342,  344,
			  345,  346,  347,  348,  349,  350,  352,  353,  354,  356,
			  357,  358,  359,  360,  361,  362,  364,  365,  366,  367, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  368,  369,  370,  371,  372,  373,  374,  375,  376,  377,
			  378,  380,  381,  382,  383,  384,  385,  386,  387,  388,
			  389,  390,  392,  393,  395,  396,  396,  396,  397,  398,
			  399,  400,  400,  401,  402,  403,  404,  405,  405,  406,
			  407,  408,  409,  410,  411,  412,  413,  414,  415,  416,
			  417,  418,  419,  420,  421,  422,  423,  424,  425,  426,
			  428,  429,  430,  430,  431,  432,  433,  434,  435,  436,
			  437,  438,  440,  441,  444,  445,  446,  448,  449,  450,
			  453,  456,  458,  461,  462,  465,  466,  469,  470,  473,
			  474,  475,  477,  478,  479,  480,  481,  482,  483,  484,

			  485,  486,  489,  490,  492,  494,  496,  497,  499,  500,
			  501,  502,  503,  504,  505,  506,  507,  508,  509,  510,
			  511,  512,  513,  514,  515,  516,  517,  518,  519,  520,
			  521,  523,  525,  527,  529,  531,  532,  533,  534,  535,
			  535,  537,  539,  540,  541,  542,  543,  544,  545,  546,
			  547,  547,  548,  550,  551,  553,  554,  555,  555,  557,
			  559,  561,  563,  564,  565,  566,  567,  569,  571,  573,
			  575,  576,  577,  578,  579,  580,  582,  583,  585,  588,
			  590,  591,  592,  593,  595,  597,  598,  599,  600,  601,
			  602,  603,  604,  605,  606,  607,  608,  610,  611,  612, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  613,  614,  615,  616,  617,  618,  619,  620,  621,  622,
			  623,  624,  626,  627,  629,  630,  631,  632,  633,  634,
			  635,  636,  637,  638,  639,  640,  641,  642,  643,  644,
			  645,  646,  647,  648,  649,  650,  651,  652,  654,  655,
			  656,  658,  660,  662,  664,  666,  668,  670,  672,  674,
			  676,  677,  679,  680,  682,  683,  684,  686,  688,  689,
			  689,  689,  690,  691,  693,  694,  694,  696,  699,  702,
			  705,  707,  708,  709,  710,  711,  712,  714,  715,  717,
			  720,  721,  722,  723,  724,  725,  726,  727,  728,  729,
			  730,  731,  732,  733,  734,  735,  736,  737,  738,  739,

			  740,  741,  742,  743,  744,  745,  747,  749,  750,  750,
			  751,  753,  755,  757,  759,  761,  763,  764,  764,  764,
			  765,  766,  766,  766,  766,  766,  766,  767,  768,  769,
			  771,  773,  775,  777,  779,  781,  783,  785,  787,  788,
			  789,  790,  791,  792,  793,  794,  795,  796,  797,  798,
			  799,  800,  801,  802,  803,  805,  806,  807,  808,  809,
			  810,  811,  813,  814,  815,  816,  817,  818,  819,  821,
			  822,  824,  826,  827,  829,  831,  832,  833,  834,  835,
			  836,  837,  838,  839,  840,  841,  842,  844,  845,  847,
			  849,  850,  851,  852,  853,  854,  856,  858,  860,  862, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  864,  866,  867,  867,  867,  867,  867,  868,  869,  871,
			  872,  874,  875,  877,  878,  878,  878,  878,  878,  879,
			  879,  880,  880,  881,  882,  883,  885,  886,  887,  889,
			  891,  892,  893,  894,  896,  898,  899,  900,  901,  903,
			  904,  905,  906,  907,  908,  909,  910,  912,  913,  914,
			  915,  916,  917,  918,  919,  921,  922,  922,  923,  923,
			  924,  925,  926,  927,  928,  929,  930,  931,  933,  934,
			  935,  937,  939,  940,  941,  943,  944,  944,  944,  944,
			  945,  946,  947,  948,  949,  949,  949,  949,  949,  949,
			  949,  950,  951,  951,  951,  952,  954,  956,  957,  958,

			  959,  961,  962,  963,  964,  965,  967,  969,  970,  972,
			  973,  974,  976,  977,  978,  979,  980,  981,  982,  983,
			  983,  984,  985,  986,  987,  989,  990,  992,  994,  996,
			  997,  998, 1000, 1001, 1002, 1002, 1003, 1003, 1004, 1004,
			 1005, 1006, 1007, 1008, 1008, 1008, 1008, 1008, 1008, 1008,
			 1008, 1008, 1008, 1008, 1009, 1010, 1010, 1010, 1011, 1011,
			 1012, 1012, 1013, 1014, 1016, 1017, 1019, 1020, 1021, 1022,
			 1023, 1025, 1027, 1028, 1030, 1032, 1033, 1034, 1035, 1036,
			 1037, 1038, 1040, 1041, 1042, 1044, 1046, 1047, 1048, 1049,
			 1051, 1052, 1054, 1055, 1056, 1056, 1057, 1057, 1058, 1059, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1059, 1059, 1060, 1062, 1063, 1065, 1067, 1068, 1070, 1072,
			 1074, 1075, 1077, 1077, 1078, 1079, 1081, 1082, 1084, 1086,
			 1087, 1089, 1091, 1092, 1092, 1093, 1095, 1096, 1098, 1098,
			 1099, 1101, 1103, 1105, 1107, 1107, 1108, 1108, 1109, 1109,
			 1111, 1112, 1112, yy_Dummy>>,
			1, 43, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1111)
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
			   55,   55,  209,  209,  198,  209,  209,  209,  209,  209,
			  209,  209,  209,  209,  209,  209,  209,  209,  209,  209,
			 -441,  209,  209,  209, -441,   55,   62,   62,   55,   62,
			   55,   62,  173,  173,  173,   55,   55,   55,   55,    2,
			   55,   36,   55,   10,  144,   55,   55,   39,   55,   24,

			   55,   23,   55,  144,  138,   16,   55,   55,   37,   55,
			   21,   55,   55,   55,   55,   55,   22,   55,   38,   55,
			   17,   55,   59,   59,   55,   59,   55,   59,  137,  137,
			  137,  137,  137,   70,  137,  137,  137,  137,  137,  137,
			  137,  137,   83,  137,  137,  137,  137,  137,  137,  137,
			   95,  137,  137,  137,  101,  137,  137,  137,  137,  137,
			  137,  137,  113,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,   40,   55,
			   55,   55,   55,   55,   55,   55,   55,   55,   55,   55,
			   50,   55,   55,   52,   55,   55,   55,   55,  210,  237, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  227,  225,  226,  228,  229,  230,  231,  211,  212,  213,
			  214,  215,  216,  217,  218,  219,  220,  221,  222,  223,
			  224,  206,  205,  204,  206,  206,  203,  204,  208,  207,
			  201,    5,    4,    2,   57,   58,   56,  199,  195,  199,
			  209,  195,  197,  199,  209,  209,  209, -441, -441,  209,
			  181,  195,  199,  179,  195,  199,  180,  199,  182,  195,
			  199,  209,  175,  195,  199,  209,  176,  195,  199,  209,
			  195,  196,  199,  209,  209,  209, -441,  209,  209,  209,
			  209,  209,  209, -200,  209,  209,  183,  195,  199,   62,
			   57,   63,   58,   64,   56,   62,  173,  145,  173,  173,

			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  146,  173,   33,   58,   33,   56,   31,   58,   31,
			   56,   32,   55,   55,  144,   34,   58,   34,   56,   55,
			   55,   55,   55,   55,   55,  139,  144,  138,  142,  143,
			  143,  141,  143,  140,  138,   19,   58,   19,   56,   37,
			   55,   37,   55,   55,   55,   55,   55,   18,   58,   18,
			   56,   20,   58,   20,   56,   55,   55,   55,   55,   11,
			   55,   59,   59,   57,   60,   15,   58,   61,   56,   59,
			  137,  137,  137,   68,  137,   69,  137,  137,  137,  137, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  137,  137,  137,  137,  137,  137,  137,  137,   86,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  105,  137,  137,  108,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  136,  137,   55,   55,   35,   58,   35,   56,
			   12,   58,   12,   56,   43,   58,   48,   58,   53,   58,
			   41,   58,   42,   58,   49,   58,   55,   51,   58,   55,
			   54,   58,   46,   47,   45,   58,   44,   58,  236,    4,
			    4,  197,  199,  209,  187,  199,  184,  195,  199,  177,

			  195,  199,  178,  195,  199,  196,  199,  209,  209,  209,
			  209,  209,  192,  199,  209,  186,  199,  185,  195,  199,
			   63,   64,  163,  161,  162,  164,  165,  174,  174,  166,
			  167,  147,  148,  149,  150,  151,  152,  153,  154,  155,
			  156,  157,  158,  159,  160,   36,   58,   36,   56,  144,
			  144,   39,   58,   39,   56,   24,   58,   24,   56,   23,
			   58,   23,   56,  144,  144,  138,  138,  138,   55,   37,
			   58,   37,   55,   37,   55,   21,   58,   21,   56,   22,
			   58,   22,   56,   38,   58,   58,   61,   60,   61,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  137,  137,  137,   84,  137,  137,  137,  137,  137,  137,
			  137,   93,  137,  137,  137,  137,  137,  137,  137,  102,
			  137,  137,  104,  137,  106,  137,  137,  111,  137,  112,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  125,  137,  137,  127,  137,  128,  137,  137,
			  137,  137,  137,  137,  134,  137,  135,  137,   40,   58,
			   40,   56,   50,   58,   52,   58,  232,    4,  209,  188,
			  199,  209,  191,  199,  209,  194,  199,  174,  144,  144,
			  144,  144,  138,   37,   58,   37,  137,   66,  137,   67,
			  137,  137,  137,  137,   74,  137,   75,  137,  137,  137,

			  137,   80,  137,  137,  137,  137,  137,  137,  137,  137,
			   91,  137,  137,  137,  137,  137,  137,  137,  137,  103,
			  137,  137,  109,  137,  137,  137,  137,  137,  137,  137,
			  137,  122,  137,  137,  137,  126,  137,  129,  137,  137,
			  137,  132,  137,  137,    4,  209,  209,  209,  168,  144,
			  144,  144,   65,  137,   71,  137,  137,  137,  137,   77,
			  137,  137,  137,  137,  137,   85,  137,   87,  137,  137,
			   89,  137,  137,  137,   94,  137,  137,  137,  137,  137,
			  137,  137,  110,  137,  137,  137,  137,  118,  137,  137,
			  120,  137,  121,  137,  123,  137,  137,  137,  131,  137, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  137,  235,  234,  233,    4,  209,  209,  209,  144,  144,
			  144,  144,  137,  137,   76,  137,  137,   79,  137,  137,
			  137,  137,  137,   92,  137,   96,  137,  137,   98,  137,
			   99,  137,  137,  137,  137,  137,  137,  137,  119,  137,
			  137,  137,  133,  137,    3,    4,  209,  209,  209,  171,
			  172,  172,  170,  172,  169,  144,  144,  144,  144,  144,
			   72,  137,  137,   78,  137,   81,  137,  137,   88,  137,
			   90,  137,   97,  137,  137,  107,  137,  137,  137,  116,
			  137,  137,  124,  137,  130,  137,  209,  190,  199,  193,
			  199,  144,  144,   73,  137,  137,  100,  137,  137,  115,

			  137,  117,  137,  189,  199,   82,  137,  137,  137,  114,
			  137,  114, yy_Dummy>>,
			1, 112, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2460
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 841
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 842
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
