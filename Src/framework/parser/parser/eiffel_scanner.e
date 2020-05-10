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
						TE_FREE_NOT
					end
			
when 49 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
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
	yy_column := yy_column + 6
	yy_position := yy_position + 6
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
	yy_column := yy_column + 3
	yy_position := yy_position + 3
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
	yy_column := yy_column + 6
	yy_position := yy_position + 6
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
	yy_column := yy_column + 3
	yy_position := yy_position + 3
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
	yy_column := yy_column + 3
	yy_position := yy_position + 3
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
			
when 58 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 59 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 60 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 61 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 62 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 63 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 64 then
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
			
when 65 then
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
			
when 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 67 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 68 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 69 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 70 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 72 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 73 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 74 then
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
			
when 75 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 76 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 77 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 78 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 79 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 80 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 81 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 82 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 83 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 84 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 85 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 86 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 87 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 88 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 89 then
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
			
when 90 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 91 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 92 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 93 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 94 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 95 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 96 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 97 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 98 then
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
			
when 99 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 100 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 101 then
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
			
when 102 then
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
			
when 103 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 104 then
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
			
when 105 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 106 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 107 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 108 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 109 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 110 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 111 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 112 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 113 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 114 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 115 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 116 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 117 then
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
			
when 118 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 121 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 122 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 123 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 124 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 125 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 128 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 129 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 130 then
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
			
when 131 then
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
			
when 132 then
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
			
when 133 then
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
			
when 134 then
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
			
when 135 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 136 then
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
			
when 137 then
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
			
when 138 then
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
			
when 139 then
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
			
when 140 then
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
			
when 141 then
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
			
when 142 then
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
			
when 143 then
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
			
when 144 then
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
			
when 145 then
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
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
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
			
when 154 then
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
			
when 155 then
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
			
when 156 then
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
			
when 157 then
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
			
when 158 then
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
			
when 159 then
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
			
when 160 then
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
			
when 161 then
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
			
when 162 then
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
			
when 163 then
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
			
when 164 then
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
			
when 165 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 166 then
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
			
when 167 then
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
			
when 168 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 169 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 170 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 171 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 172 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 173 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 174 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 175 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 176 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 177 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 178 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 179 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 180 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 181 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 182 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 183 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 184 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 185 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 186 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 187 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 188 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 189 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 191 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 192 then
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
			
when 193 then
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
			
when 194 then
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
			
when 195 then
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
			
when 196 then
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
				append_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 198 then
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
			
when 199 then
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
			
when 200 then
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
			
when 201 then
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
			
when 202 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 213 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 214 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 215 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 216 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 217 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 218 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 219 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 220 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 221 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 222 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 223 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 224 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 225 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 226 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 227 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 228 then
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
			
when 229 then
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
			
when 230 then
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
			
when 231 then
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
			
when 232 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 233 then
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
			create an_array.make_filled (0, 0, 3707)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			an_array.area.fill_with (112, 836, 872)
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
			an_array.area.fill_with (890, 3579, 3707)
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

			   14,   14,   14,   14,   63,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   64,   65,   66,
			   67,   68,   69,   70,   71,   72,   73,   74,   75,   14,
			   77,   77,  154,  643,   78,   78,  199,   79,   79,   81,
			   82,   81,   81,  155,   83,   81,   82,   81,   81,  642,
			   83,   92,   93,   92,   92,  168,  169,   92,   93,   92,
			   92,  170,  171,   99,  100,   99,   99,  641,  199,   99,
			  100,   99,   99,  158,  550,  106,  106,  106,  106,  101,
			  269,  159,  206,  549,  270,  101,  106,  106,  106,  106,
			  156,  107,  157,  157,  157,  157,  161,   84,  162,  162, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  162,  162,  107,   84,  213,  185,  161,  548,  162,  162,
			  162,  162,  180,  204,  206,  186,  181,  522,  197,  182,
			  163,  164,  183,  269,  198,  184,  220,  277,  221,   84,
			  205,  216,  222,  291,  292,   84,  213,  185,  520,  166,
			  301,  302,  165,  217,  180,  204,  160,  186,  181,  166,
			  197,  182,  163,  164,  183,   85,  198,  184,   86,   87,
			   88,   85,  205,  216,   86,   87,   88,   94,  305,  306,
			   95,   96,   97,   94,  165,  217,   95,   96,   97,  102,
			  518,  311,  103,  104,  105,  102,  398,  709,  103,  104,
			  105,  108,  399,  269,  109,  110,  111,  270,  890,  269,

			  344,  308,  108,  270,  115,  109,  110,  111,  113,  114,
			  482,  115,  114,  311,  116,  481,  117,  118,  398,  119,
			  480,  120,  190,  187,  399,  188,  191,  269,  121,  193,
			  122,  270,  114,  123,  174,  189,  194,  195,  175,  192,
			  269,  124,  196,  176,  270,  177,  125,  126,  237,  214,
			  178,  179,  131,  402,  190,  187,  127,  188,  191,  128,
			  129,  193,  130,  215,  235,  123,  174,  189,  194,  195,
			  175,  192,  228,  124,  196,  176,  269,  177,  125,  126,
			  270,  214,  178,  179,  131,  402,  313,  224,  127,  115,
			  281,  131,  114,  226,  227,  215,  271,  229,  230,  231, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  200,  210,  403,  207,  232,  219,  396,  396,  396,  396,
			  201,  211,  202,  208,  212,  173,  203,  404,  209,  132,
			  132,  133,  134,  134,  134,  134,  135,  136,  137,  138,
			  139,  142,  200,  210,  403,  207,  853,  131,  143,  853,
			  144,  278,  201,  211,  202,  208,  212,  397,  203,  404,
			  209,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  487,  488,  279,  280,  131,
			  853,  219,  219,  219,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  236,  236,  236,

			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  238,  238,  238,  238,  238,  238,  238,  238,
			  291,  292,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  146,  146,  147,  148,
			  148,  148,  148,  149,  150,  151,  152,  153,  241,  241,
			  241,  241,  405,  242,  308,  878,  243,  115,  244,  245,
			  246,  312,  271,  269,  271,  271,  247,  270,  284,  285,
			  284,  284,  406,  248,  314,  249,  875,  115,  250,  251,
			  252,  253,  710,  254,  405,  255,  407,  315,  269,  256, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  115,  257,  277,  890,  258,  259,  260,  261,  262,  263,
			  294,  294,  294,  294,  406,  131,  294,  294,  294,  294,
			  408,  853,  106,  106,  106,  106,  409,  378,  407,  378,
			  272,  316,  413,  318,  115,  131,  115,  418,  107,  320,
			  301,  302,  115,  718,  317,  711,  711,  131,  131,  833,
			  308,  269,  408,  115,  319,  270,  308,  419,  409,  115,
			  321,  345,  272,  832,  413,  226,  227,  131,  831,  418,
			  308,  830,  308,  115,  264,  115,  890,  265,  266,  267,
			  131,  414,  131,  308,  131,  420,  115,  323,  273,  419,
			  131,  274,  275,  276,  286,  324,  415,  287,  288,  289,

			  335,  131,  377,  115,  476,  477,  826,  131,  322,  308,
			  478,  479,  115,  414,  131,  685,  131,  420,  421,  323,
			  685,  131,  131,  131,  334,  325,  295,  324,  415,  296,
			  297,  298,  295,  131,  131,  296,  297,  298,  108,  131,
			  322,  109,  110,  111,  112,  685,  112,  112,  326,  309,
			  421,  131,  115,  131,  271,  131,  685,  325,  756,  757,
			  131,  400,  426,  429,  401,  430,  131,  346,  346,  347,
			  348,  348,  348,  348,  349,  350,  351,  352,  353,  376,
			  326,  431,  434,  131,  385,  385,  385,  385,  385,  385,
			  385,  385,  131,  400,  426,  429,  401,  430,  435,  780, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  310,  346,  346,  347,  348,  348,  348,  348,  349,  350,
			  351,  352,  353,  431,  434,  876,  877,  327,  328,  327,
			  327,  380,  308,  380,  773,  115,  327,  328,  327,  327,
			  435,  308,  310,  382,  115,  382, yy_Dummy>>,
			1, 36, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  308,  329,  772,  115,  308,  416,  758,  115,  131,
			  417,  755,  346,  346,  347,  348,  348,  348,  348,  349,
			  350,  351,  352,  353,  386,  386,  386,  386,  685,  377,
			  444,  388,  131,  389,  389,  389,  389,  754,  416,  387,
			  308,  131,  417,  115,  432,  377,  718,  442,  390,  445,
			  446,  443,  131,  433,  447,  448,  131,  452,  453,  384,
			  330,  384,  444,  331,  332,  333,  712,  712,  712,  330,
			  714,  387,  331,  332,  333,  308,  432,  388,  115,  442,
			  390,  445,  446,  443,  131,  433,  447,  448,  131,  452,
			  453,  131,  343,  343,  343,  343,  343,  343,  343,  343,

			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  381,  381,  131,  454,  455,  131,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  377,  484,  485,  485,  485,  890,  454,  455,  131,  890,
			  890,  630,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  338,  338,  338, yy_Dummy>>,
			1, 200, 873)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  338,  338,  338,  338,  338,  338,  338,  338,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  308,  566,  161,  115,  391,  391,  391,  391,  241,
			  383,  383,  383,  383,  383,  383,  383,  383,  383,  383,
			  383,  383,  383,  383,  383,  392,  392,  393,  393,  410,
			  241,  241,  567,  411,  566,  233,  393,  393,  393,  393,
			  393,  393,  394,  394,  394,  393,  166,  412,  427,  568,
			  225,  569,  131,  393,  393,  393,  393,  393,  393,  471,
			  428,  410,  472,  269,  567,  411,  220,  270,  393,  393,

			  393,  393,  393,  393,  473,  474,  890,  890,  269,  412,
			  427,  568,  270,  569,  131,  393,  393,  393,  393,  393,
			  393,  140,  428,  890,  140,  140,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  342,  342,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  342,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  342,  342,  354,  572,  890,  355,  269,  356,
			  357,  358,  270,  890,  269,  546,  269,  359,  270,  545,
			  270,  269,  544,  422,  360,  270,  361,  423,  573,  362,
			  363,  364,  365,  543,  366,  271,  367,  572,  424,  281, yy_Dummy>>,
			1, 200, 1073)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  368,  425,  369,  542,  541,  370,  371,  372,  373,  374,
			  375,  395,  395,  395,  395,  422,  449,  574,  540,  423,
			  573,  450,  395,  395,  395,  395,  395,  395,  539,  575,
			  424,  576,  451,  425,  106,  106,  106,  106,  577,  578,
			  538,  220,  220,  220,  220,  220,  220,  220,  449,  574,
			  107,  537,  536,  450,  395,  395,  395,  395,  395,  395,
			  220,  575,  535,  576,  451,  279,  280,  271,  534,  278,
			  577,  578,  271,  533,  532,  346,  346,  347,  348,  348,
			  348,  348,  349,  350,  351,  352,  353,  436,  579,  437,
			  580,  456,  581,  241,  241,  241,  241,  438,  584,  585,

			  439,  483,  440,  441,  457,  457,  458,  459,  460,  459,
			  459,  461,  462,  463,  464,  465,  531,  528,  527,  436,
			  579,  437,  580,  497,  581,  456,  115,  526,  525,  438,
			  584,  585,  439,  524,  440,  441,  106,  456,  457,  457,
			  458,  459,  460,  459,  459,  461,  462,  463,  464,  465,
			  466,  457,  458,  467,  468,  469,  459,  461,  462,  463,
			  464,  465,  456,  271,  269,  271,  271,  269,  270,  498,
			  586,  270,  115,  106,  131,  457,  457,  458,  459,  460,
			  459,  459,  461,  462,  463,  464,  465,  284,  285,  284,
			  284,  284,  284,  284,  284,  284,  284,  284,  294,  294, yy_Dummy>>,
			1, 200, 1273)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  294,  294,  586,  106,  499,  500,  131,  115,  115,  264,
			  284,  589,  265,  266,  267,  294,  492,  328,  492,  492,
			  131,  272,  294,  294,  294,  294,  294,  294,  294,  106,
			  106,  106,  106,  106,  106,  106,  529,  530,  530,  530,
			  294,  294,  590,  589,  504,  294,  505,  507,  106,  115,
			  115,  308,  131,  272,  115,  131,  131,  491,  271,  271,
			  271,  271,  271,  271,  271,  308,  303,  582,  115,  774,
			  711,  711,  311,  308,  590,  308,  115,  271,  115,  273,
			  300,  583,  274,  275,  276,  294,  284,  131,  131,  308,
			  308,  308,  115,  115,  115,  503,  284,  131,  131,  582,

			  284,  501,  131,  286,  311,  293,  287,  288,  289,  512,
			  290,  775,  115,  583,  295,  502,  131,  296,  297,  298,
			  327,  328,  327,  327,  131,  309,  131,  503,  115,  131,
			  131,  506,  493,  501,  131,  494,  495,  496,  284,  283,
			  131,  131,  131,  565,  565,  565,  565,  502,  131,  489,
			  551,  551,  551,  551,  591,  486,  131,  592,  131,  593,
			  131,  241,  240,  506,  327,  387,  161,  220,  558,  558,
			  558,  558,  131,  131,  131,  552,  310,  552,  509,  510,
			  553,  553,  553,  553,  397,  475,  591,  508,  470,  592,
			  220,  593,  131,  327,  328,  327,  327,  387,  308,  308, yy_Dummy>>,
			1, 200, 1473)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  220,  115,  115,  377,  513,  377,  377,  115,  310,  166,
			  377,  377,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  330,  112,  112,  331,
			  332,  333,  112,  112,  112,  112,  112,  112,  112,  131,
			  131,  594,  595,  596,  307,  131,  517,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  517,  519,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  519,  597,
			  304,  131,  131,  594,  595,  596,  511,  131,  521,  521,
			  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,

			  521,  521,  521,  547,  553,  553,  553,  553,  106,  330,
			  154,  597,  331,  332,  333,  132,  132,  133,  134,  134,
			  134,  134,  135,  136,  137,  138,  139,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  523,  523,  523,  523, yy_Dummy>>,
			1, 200, 1673)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  523,  523,  523,  523,  625,  485,  485,  485,  485,  346,
			  346,  347,  348,  348,  348,  348,  349,  350,  351,  352,
			  353,  554,  554,  554,  554,  556,  303,  556,  300,  294,
			  557,  557,  557,  557,  587,  598,  555,  392,  392,  393,
			  393,  299,  293,  599,  600,  570,  629,  588,  393,  393,
			  393,  393,  393,  393,  290,  601,  284,  283,  393,  393,
			  393,  393,  571,  602,  603,  604,  587,  598,  555,  393,
			  393,  393,  393,  393,  393,  599,  600,  570,  559,  588,
			  393,  393,  393,  393,  393,  393,  563,  601,  564,  564,
			  564,  564,  711,  711,  571,  602,  603,  604,  605,  560,

			  606,  393,  393,  393,  393,  393,  393,  394,  394,  394,
			  393,  609,  610,  607,  611,  612,  240,  613,  393,  393,
			  393,  393,  393,  393,  395,  395,  395,  395,  614,  397,
			  605,  608,  606,  775,  615,  395,  395,  395,  395,  395,
			  395,  616,  617,  609,  610,  607,  611,  612,  561,  613,
			  393,  393,  393,  393,  393,  393,  618,  619,  620,  621,
			  614,  622,  233,  608,  225,  562,  615,  395,  395,  395,
			  395,  395,  395,  616,  617,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  218,  172,  618,  619,
			  620,  621,  167,  622,  219,  219,  219,  219,  219,  219, yy_Dummy>>,
			1, 200, 1873)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  219,  219,  219,  219,  219,  219,  219,  219,  635,  890,
			  636,   90,   90,  115,  219,  219,  219,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  236,
			  236,  236,  236,  236,  236,  236,  236,  236,  236,  236,
			  236,  236,  236,  236,  238,  238,  238,  238,  238,  238,
			  238,  238,  456,  553,  553,  553,  553,  890,  311,  656,
			  311,  131,  890,  890,  456,  457,  457,  458,  459,  460,
			  459,  459,  461,  462,  463,  464,  465,  457,  457,  458,
			  459,  460,  459,  459,  461,  462,  463,  464,  465,  456,
			  311,  656,  311,  131,  632,  633,  634,  557,  557,  557,

			  557,  456,  457,  457,  458,  459,  460,  459,  459,  461,
			  462,  463,  464,  465,  457,  457,  458,  459,  623,  459,
			  459,  461,  462,  463,  464,  465,  456,  492,  328,  492,
			  492,  638,  890,  890,  115,  890,  890,  890,  456,  457,
			  457,  458,  459,  624,  459,  459,  461,  462,  463,  464,
			  465,  457,  457,  458,  459,  460,  459,  459,  461,  462,
			  463,  464,  465,  625,  485,  485,  485,  485,  241,  241,
			  241,  241,  241,  241,  241,  311,  626,  627,  311,  657,
			  658,  308,  131,  311,  115,  640,  890,  241,  115,  308,
			  308,  308,  115,  115,  115,  890,  890,  659,  628,  557, yy_Dummy>>,
			1, 200, 2073)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  557,  557,  557,  308,  890,  629,  115,  311,  626,  627,
			  311,  657,  658,  660,  131,  311,  308,  637,  639,  115,
			  652,  661,  652,  492,  631,  653,  653,  653,  653,  659,
			  628,  662,  131,  663,  664,  890,  131,  665,  666,  667,
			  131,  131,  131,  493,  668,  660,  494,  495,  496,  637,
			  639,  890,  890,  661,  131,  890,  644,  530,  530,  530,
			  530,  890,  890,  662,  131,  663,  664,  131,  131,  665,
			  666,  667,  131,  131,  131,  890,  668,  327,  327,  327,
			  327,  327,  327,  327,  327,  669,  131,  649,  649,  649,
			  649,  644,  530,  530,  530,  530,  890,  327,  648,  131,

			  890,  327,  387,  327,  645,  646,  651,  651,  651,  651,
			  890,  654,  890,  558,  558,  558,  558,  669,  890,  890,
			  670,  555,  890,  671,  672,  673,  647,  890,  650,  392,
			  392,  393,  393,  648,  387,  674,  645,  646,  890,  675,
			  393,  393,  393,  393,  393,  393,  890,  676,  393,  393,
			  393,  393,  670,  555,  397,  671,  672,  673,  647,  393,
			  393,  393,  393,  393,  393,  890,  890,  674,  890,  677,
			  559,  675,  393,  393,  393,  393,  393,  393,  563,  676,
			  655,  655,  655,  655,  890,  890,  678,  679,  680,  560,
			  681,  393,  393,  393,  393,  393,  393,  394,  394,  394, yy_Dummy>>,
			1, 200, 2273)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  393,  677,  890,  890,  890,  682,  890,  683,  393,  393,
			  393,  393,  393,  393,  395,  395,  395,  395,  678,  679,
			  680,  397,  681,  890,  684,  395,  395,  395,  395,  395,
			  395,  563,  692,  565,  565,  565,  565,  682,  561,  683,
			  393,  393,  393,  393,  393,  393,  693,  685,  685,  685,
			  685,  694,  686,  695,  696,  562,  684,  395,  395,  395,
			  395,  395,  395,  687,  692,  697,  698,  699,  700,  701,
			  702,  703,  704,  705,  397,  706,  707,  708,  693,  713,
			  713,  713,  713,  694,  311,  695,  696,  311,  890,  730,
			  713,  713,  713,  713,  713,  713,  311,  697,  698,  699,

			  700,  701,  702,  703,  704,  705,  311,  706,  707,  708,
			  485,  485,  485,  485,  308,  890,  311,  115,  731,  311,
			  492,  730,  713,  713,  713,  713,  713,  713,  311,  890,
			  732,  890,  492,  890,  492,  686,  308,  308,  311,  115,
			  115,  890,  492,  492,  492,  492,  492,  492,  492,  890,
			  731,  629,  725,  725,  725,  725,  890,  733,  715,  890,
			  890,  492,  732,  688,  890,  131,  689,  690,  691,  716,
			  734,  737,  738,  717,  723,  723,  723,  723,  890,  890,
			  719,  719,  720,  720,  739,  740,  741,  131,  131,  733,
			  715,  720,  720,  720,  720,  720,  720,  131,  890,  890, yy_Dummy>>,
			1, 200, 2473)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  890,  716,  734,  737,  738,  717,  649,  649,  649,  649,
			  653,  653,  653,  653,  890,  648,  739,  740,  741,  131,
			  131,  724,  890,  720,  720,  720,  720,  720,  720,  721,
			  721,  721,  720,  890,  890,  722,  722,  722,  722,  742,
			  720,  720,  720,  720,  720,  720,  722,  722,  722,  722,
			  722,  722,  743,  724,  726,  726,  726,  726,  653,  653,
			  653,  653,  729,  890,  565,  565,  565,  565,  744,  555,
			  890,  742,  720,  720,  720,  720,  720,  720,  722,  722,
			  722,  722,  722,  722,  743,  388,  745,  726,  726,  726,
			  726,  746,  735,  747,  748,  727,  736,  749,  750,  751,

			  744,  555,  728,  752,  759,  166,  685,  685,  685,  685,
			  760,  753,  761,  762,  763,  764,  765,  766,  745,  767,
			  768,  769,  687,  746,  735,  747,  748,  770,  736,  749,
			  750,  751,  771,  890,  728,  752,  759,  776,  712,  712,
			  712,  890,  760,  890,  761,  762,  763,  764,  765,  766,
			  802,  767,  768,  769,  778,  713,  713,  713,  713,  770,
			  308,  803,  308,  115,  771,  115,  713,  713,  713,  713,
			  713,  713,  792,  723,  723,  723,  723,  308,  804,  777,
			  115,  793,  802,  793,  890,  890,  794,  794,  794,  794,
			  890,  782,  781,  803,  753,  890,  779,  805,  713,  713, yy_Dummy>>,
			1, 200, 2673)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  713,  713,  713,  713,  798,  798,  798,  798,  806,  807,
			  804,  131,  808,  131,  648,  795,  795,  795,  795,  890,
			  783,  890,  688,  782,  781,  689,  690,  691,  131,  805,
			  796,  809,  810,  890,  784,  719,  719,  720,  720,  811,
			  806,  807,  812,  131,  808,  131,  720,  720,  720,  720,
			  720,  720,  783,  786,  720,  720,  720,  720,  890,  890,
			  131,  813,  796,  809,  810,  720,  720,  720,  720,  720,
			  720,  811,  890,  890,  812,  890,  785,  814,  720,  720,
			  720,  720,  720,  720,  799,  890,  799,  890,  890,  800,
			  800,  800,  800,  813,  890,  787,  815,  720,  720,  720,

			  720,  720,  720,  788,  721,  721,  721,  720,  816,  814,
			  817,  726,  726,  726,  726,  720,  720,  720,  720,  720,
			  720,  790,  722,  722,  722,  722,  797,  388,  815,  798,
			  798,  798,  798,  722,  722,  722,  722,  722,  722,  818,
			  816,  819,  817,  820,  801,  789,  890,  720,  720,  720,
			  720,  720,  720,  821,  822,  823,  824,  825,  797,  794,
			  794,  794,  794,  791,  890,  722,  722,  722,  722,  722,
			  722,  818,  890,  819,  890,  820,  801,  685,  685,  685,
			  685,  685,  685,  685,  456,  821,  822,  823,  824,  825,
			  890,  890,  890,  712,  712,  712,  685,  457,  457,  458, yy_Dummy>>,
			1, 200, 2873)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  459,  460,  459,  459,  461,  462,  463,  464,  465,  456,
			  308,  308,  308,  115,  115,  115,  794,  794,  794,  794,
			  843,  844,  457,  457,  458,  459,  460,  459,  459,  461,
			  462,  463,  464,  465,  777,  713,  713,  713,  713,  827,
			  845,  829,  800,  800,  800,  800,  713,  713,  713,  713,
			  713,  713,  843,  844,  828,  800,  800,  800,  800,  846,
			  847,  131,  131,  131,  848,  849,  836,  836,  836,  836,
			  890,  827,  845,  829,  890,  890,  779,  850,  713,  713,
			  713,  713,  713,  713,  890,  890,  828,  719,  719,  720,
			  720,  846,  847,  131,  131,  131,  848,  849,  720,  720,

			  720,  720,  720,  720,  720,  720,  720,  720,  851,  850,
			  834,  834,  834,  834,  852,  720,  720,  720,  720,  720,
			  720,  836,  836,  836,  836,  796,  859,  890,  785,  890,
			  720,  720,  720,  720,  720,  720,  835,  890,  835,  890,
			  851,  836,  836,  836,  836,  787,  852,  720,  720,  720,
			  720,  720,  720,  721,  721,  721,  720,  796,  859,  839,
			  839,  839,  839,  860,  720,  720,  720,  720,  720,  720,
			  722,  722,  722,  722,  840,  838,  838,  838,  838,  890,
			  861,  722,  722,  722,  722,  722,  722,  890,  853,  853,
			  853,  853,  890,  890,  789,  860,  720,  720,  720,  720, yy_Dummy>>,
			1, 200, 3073)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  720,  720,  837,  862,  837,  863,  840,  838,  838,  838,
			  838,  791,  861,  722,  722,  722,  722,  722,  722,  841,
			  854,  841,  796,  890,  842,  842,  842,  842,  308,  865,
			  866,  115,  115,  115,  890,  862,  890,  863,  838,  838,
			  838,  838,  867,  867,  867,  867,  870,  890,  650,  890,
			  871,  872,  854,  868,  796,  868,  874,  840,  869,  869,
			  869,  869,  842,  842,  842,  842,  864,  842,  842,  842,
			  842,  853,  853,  853,  853,  890,  890,  890,  870,  131,
			  131,  131,  871,  872,  879,  880,  890,  881,  874,  840,
			  115,  882,  840,  869,  869,  869,  869,  883,  864,  869,

			  869,  869,  869,  873,  855,  884,  890,  856,  857,  858,
			  890,  131,  131,  131,  885,  886,  879,  880,  727,  887,
			  888,  889,  890,  882,  840,  890,  890,  239,  239,  883,
			  239,  239,  239,  239,  239,  873,  890,  884,  131,  853,
			  853,  853,  853,  853,  853,  853,  885,  886,  890,  890,
			  890,  887,  888,  889,  890,  890,  890,  890,  853,   76,
			   76,   76,   76,   76,   76,   76,   76,   76,  890,  890,
			  131,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			  344,  344,  344,  344,  344,  344,  890,  855,  344,  890,
			  856,  857,  858,   89,   89,   89,   89,   89,   89,   89, yy_Dummy>>,
			1, 200, 3273)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   89,   89,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   98,   98,   98,   98,   98,   98,   98,   98,   98,
			  112,  112,  112,  112,  112,  112,  112,  112,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  272,  272,  272,  272,
			  272,  272,  272,  272,  272,  282,  282,  282,  282,  282,
			  282,  282,  282,  282,  114,  114,  114,  114,  114,  114,
			  114,  114,  115,  890,  115,  115,  115,  115,  115,  115,
			  490,  490,  490,  490,  490,  490,  490,  490,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  826,  826,  826,

			  826,  826,  826,  826,  826,   13, yy_Dummy>>,
			1, 106, 3473)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 3707)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 129)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (21, 522, 557)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (114, 836, 872)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			an_array.area.fill_with (310, 1685, 1721)
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
			an_array.area.fill_with (890, 3578, 3707)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   27,  929,    3,    4,   46,    3,    4,    5,
			    5,    5,    5,   27,    5,    6,    6,    6,    6,  928,
			    6,    9,    9,    9,    9,   34,   34,   10,   10,   10,
			   10,   36,   36,   11,   11,   11,   11,  927,   46,   12,
			   12,   12,   12,   29,  926,   15,   15,   15,   15,   11,
			   80,   29,   49,  925,   80,   12,   16,   16,   16,   16,
			   28,   15,   28,   28,   28,   28,   31,    5,   31,   31,
			   31,   31,   16,    6,   52,   41,   30,  924,   30,   30,
			   30,   30,   40,   48,   49,   41,   40,  923,   45,   40,
			   30,   30,   40,   84,   45,   40,   64,   84,   64,    5,

			   48,   54,   64,   96,   96,    6,   52,   41,  922,   31,
			  104,  104,   30,   55,   40,   48,   29,   41,   40,   30,
			   45,   40,   30,   30,   40,    5,   45,   40,    5,    5,
			    5,    6,   48,   54,    6,    6,    6,    9,  110,  110,
			    9,    9,    9,   10,   30,   55,   10,   10,   10,   11,
			  921,  115,   11,   11,   11,   12,  174,  623,   12,   12,
			   12,   15,  175,   85,   15,   15,   15,   85,  623,   88,
			  920,  112,   16,   88,  112,   16,   16,   16,   18,   18,
			  918,   18,   18,  115,   18,  917,   18,   18,  174,   18,
			  916,   18,   43,   42,  175,   42,   43,  268,   18,   44, yy_Dummy>>,
			1, 200, 130)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   18,  268,   18,   18,   38,   42,   44,   44,   38,   43,
			   86,   18,   44,   38,   86,   38,   18,   18,  904,   53,
			   38,   38,  112,  177,   43,   42,   18,   42,   43,   18,
			   18,   44,   18,   53,  903,   18,   38,   42,   44,   44,
			   38,   43,  902,   18,   44,   38,   87,   38,   18,   18,
			   87,   53,   38,   38,  112,  177,  117,  901,   18,  117,
			   88,   18,   18,   68,   68,   53,   85,   68,   68,   68,
			   47,   51,  178,   50,   68,  900,  166,  166,  166,  166,
			   47,   51,   47,   50,   51,  899,   47,  179,   50,   18,
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,

			   18,   21,   47,   51,  178,   50,  878,  117,   21,  877,
			   21,   86,   47,   51,   47,   50,   51,  166,   47,  179,
			   50,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,  266,  266,   87,   87,  117,
			  875,   63,   63,   63,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,   75,   75,   75,   75,   75,   75,   75,   75,
			  288,  288, yy_Dummy>>,
			1, 192, 330)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   79,   79,   79,   79,  180,   79,  116,  858,   79,  116,
			   79,   79,   79,  116,   81,   81,   81,   81,   79,   81,
			   92,   92,   92,   92,  181,   79,  118,   79,  856,  118,
			   79,   79,   79,   79,  624,   79,  180,   79,  182,  119,
			  272,   79,  119,   79,  272,  624,   79,   79,   79,   79,
			   79,   79,   99,   99,   99,   99,  181,  116,  100,  100,
			  100,  100,  183,  855,  106,  106,  106,  106,  184,  912,
			  182,  912,   81,  120,  187,  121,  120,  118,  121,  190,
			  106,  122,  297,  297,  122,  792,  120,  626,  626,  116,
			  119,  790,  124,  273,  183,  124,  121,  273,  125,  191,

			  184,  125,  122,  141,   81,  788,  187,  468,  468,  118,
			  786,  190,  123,  784,  129,  123,   79,  129,  468,   79,
			   79,   79,  119,  188,  120,  126,  121,  192,  126,  124,
			   81,  191,  122,   81,   81,   81,   92,  125,  188,   92,
			   92,   92,  130,  124,  153,  130,  232,  232,  780,  125,
			  123,  127,  232,  232,  127,  188,  120,  758,  121,  192,
			  194,  124,  757,  123,  122,  129,  129,  126,   99,  125,
			  188,   99,   99,   99,  100,  124,  126,  100,  100,  100,
			  106,  125,  123,  106,  106,  106,  114,  755,  114,  114,
			  127,  114,  194,  130,  114,  123,  273,  129,  754,  126, yy_Dummy>>,
			1, 200, 558)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  690,  690,  127,  176,  197,  199,  176,  200,  126,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  144,  127,  201,  204,  130,  153,  153,  153,  153,
			  153,  153,  153,  153,  127,  176,  197,  199,  176,  200,
			  205,  714,  114,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  201,  204,  857,  857,  128,
			  128,  128,  128,  913,  128,  913,  710,  128,  131,  131,
			  131,  131,  205,  131,  114,  914,  131,  914, yy_Dummy>>,
			1, 78, 758)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  128,  133,  128,  709,  133,  139,  189,  691,  139,  131,
			  189,  689,  144,  144,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  157,  157,  157,  157,  688,  149,
			  208,  161,  128,  161,  161,  161,  161,  687,  189,  157,
			  135,  131,  189,  135,  202,  147,  644,  207,  161,  209,
			  210,  207,  133,  202,  211,  212,  139,  214,  215,  915,
			  128,  915,  208,  128,  128,  128,  627,  627,  627,  131,
			  630,  157,  131,  131,  131,  132,  202,  563,  132,  207,
			  161,  209,  210,  207,  133,  202,  211,  212,  139,  214,
			  215,  135,  139,  139,  139,  139,  139,  139,  139,  139,

			  133,  133,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  149,  149,  149,  149,  149,  149,  149,  149,  149,
			  149,  149,  149,  135,  216,  217,  132,  135,  135,  135,
			  135,  135,  135,  135,  135,  135,  135,  135,  135,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  151,  247,  247,  247,  247,  550,  216,  217,  132,  549,
			  548,  491,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134, yy_Dummy>>,
			1, 200, 873)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  134,  134,  134,  134,  134,  134,  134,  134,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  137,  398,  162,  137,  162,  162,  162,  162,  489,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  163,  163,  163,  163,  185,
			  488,  486,  399,  185,  398,  469,  163,  163,  163,  163,
			  163,  163,  164,  164,  164,  164,  162,  185,  198,  400,
			  467,  403,  137,  164,  164,  164,  164,  164,  164,  230,
			  198,  185,  230,  280,  399,  185,  466,  280,  163,  163,

			  163,  163,  163,  163,  230,  230,  460,  382,  276,  185,
			  198,  400,  276,  403,  137,  164,  164,  164,  164,  164,
			  164,  897,  198,  381,  897,  897,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  143,  405,  380,  143,  274,  143,
			  143,  143,  274,  379,  275,  375,  278,  143,  275,  374,
			  278,  281,  373,  195,  143,  281,  143,  195,  406,  143,
			  143,  143,  143,  372,  143,  280,  143,  405,  195,  276, yy_Dummy>>,
			1, 200, 1073)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  143,  195,  143,  371,  370,  143,  143,  143,  143,  143,
			  143,  165,  165,  165,  165,  195,  213,  407,  369,  195,
			  406,  213,  165,  165,  165,  165,  165,  165,  368,  408,
			  195,  409,  213,  195,  220,  220,  220,  220,  410,  411,
			  367,  226,  226,  226,  226,  226,  226,  226,  213,  407,
			  220,  366,  365,  213,  165,  165,  165,  165,  165,  165,
			  226,  408,  364,  409,  213,  275,  275,  278,  363,  274,
			  410,  411,  281,  362,  361,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  206,  412,  206,
			  413,  219,  415,  241,  241,  241,  241,  206,  417,  418,

			  206,  241,  206,  206,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  360,  358,  357,  206,
			  412,  206,  413,  312,  415,  221,  312,  356,  355,  206,
			  417,  418,  206,  354,  206,  206,  307,  220,  221,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  220,  220,  220,  220,  220,  220,  220,  220,  220,  220,
			  220,  220,  222,  271,  271,  271,  271,  279,  271,  317,
			  419,  279,  317,  306,  312,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  284,  284,  284,
			  284,  291,  291,  291,  291,  291,  291,  291,  294,  294, yy_Dummy>>,
			1, 200, 1273)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  294,  294,  419,  304,  319,  321,  312,  319,  321,  241,
			  291,  421,  241,  241,  241,  303,  311,  311,  311,  311,
			  317,  271,  301,  301,  301,  301,  301,  301,  301,  305,
			  305,  305,  305,  305,  305,  305,  359,  359,  359,  359,
			  302,  301,  422,  421,  325,  300,  325,  329,  305,  325,
			  329,  324,  317,  271,  324,  319,  321,  299,  279,  279,
			  279,  279,  279,  279,  279,  330,  298,  416,  330,  711,
			  711,  711,  311,  322,  422,  323,  322,  279,  323,  271,
			  296,  416,  271,  271,  271,  295,  293,  319,  321,  326,
			  331,  332,  326,  331,  332,  324,  292,  325,  329,  416,

			  290,  322,  324,  284,  311,  289,  284,  284,  284,  334,
			  287,  711,  334,  416,  294,  323,  330,  294,  294,  294,
			  310,  310,  310,  310,  322,  310,  323,  324,  310,  325,
			  329,  326,  311,  322,  324,  311,  311,  311,  286,  282,
			  326,  331,  332,  397,  397,  397,  397,  323,  330,  267,
			  386,  386,  386,  386,  423,  265,  322,  424,  323,  425,
			  334,  264,  239,  326,  330,  386,  391,  233,  391,  391,
			  391,  391,  326,  331,  332,  387,  310,  387,  332,  332,
			  387,  387,  387,  387,  397,  231,  423,  331,  229,  424,
			  227,  425,  334,  327,  327,  327,  327,  386,  327,  333, yy_Dummy>>,
			1, 200, 1473)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  225,  327,  333,  152,  336,  150,  148,  336,  310,  391,
			  146,  145, yy_Dummy>>,
			1, 12, 1673)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  327,  333,  426,  427,  428,  111,  336,  347,  347,  347,
			  347,  347,  347,  347,  347,  347,  347,  347,  349,  349,
			  349,  349,  349,  349,  349,  349,  349,  349,  349,  349,
			  429,  109,  327,  333,  426,  427,  428,  333,  336,  351,
			  351,  351,  351,  351,  351,  351,  351,  351,  351,  351,
			  351,  351,  351,  351,  378,  552,  552,  552,  552,  108,
			  327,  107,  429,  327,  327,  327,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,

			  341,  342,  342,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  342,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  342,  342,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  343,  343,  353,  353,  353,
			  353,  353,  353,  353,  353,  485,  485,  485,  485,  485,
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378,
			  378,  378,  389,  389,  389,  389,  390,  105,  390,  103,
			  102,  390,  390,  390,  390,  420,  430,  389,  392,  392,
			  392,  392,  101,   97,  432,  433,  404,  485,  420,  392, yy_Dummy>>,
			1, 200, 1722)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  392,  392,  392,  392,  392,   95,  434,   94,   89,  393,
			  393,  393,  393,  404,  435,  436,  437,  420,  430,  389,
			  393,  393,  393,  393,  393,  393,  432,  433,  404,  392,
			  420,  392,  392,  392,  392,  392,  392,  396,  434,  396,
			  396,  396,  396,  775,  775,  404,  435,  436,  437,  438,
			  393,  439,  393,  393,  393,  393,  393,  393,  394,  394,
			  394,  394,  441,  442,  440,  443,  444,   76,  445,  394,
			  394,  394,  394,  394,  394,  395,  395,  395,  395,  446,
			  396,  438,  440,  439,  775,  447,  395,  395,  395,  395,
			  395,  395,  448,  449,  441,  442,  440,  443,  444,  394,

			  445,  394,  394,  394,  394,  394,  394,  450,  451,  452,
			  453,  446,  454,   69,  440,   67,  395,  447,  395,  395,
			  395,  395,  395,  395,  448,  449,  458,  458,  458,  458,
			  458,  458,  458,  458,  458,  458,  458,   57,   37,  450,
			  451,  452,  453,   32,  454,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  501,
			   13,  501,    8,    7,  501,  456,  456,  456,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  463,  463,  463,  463,  463,  463,  463,  463,  463,  463,
			  463,  463,  463,  463,  463,  465,  465,  465,  465,  465, yy_Dummy>>,
			1, 200, 1922)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  465,  465,  465,  470,  553,  553,  553,  553,    0,  495,
			  566,  496,  501,    0,    0,  471,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  471,  471,
			  471,  471,  471,  471,  471,  471,  471,  471,  471,  471,
			  472,  495,  566,  496,  501,  495,  495,  496,  556,  556,
			  556,  556,  473,  472,  472,  472,  472,  472,  472,  472,
			  472,  472,  472,  472,  472,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  474,  492,  492,
			  492,  492,  503,    0,    0,  503,    0,    0,    0,  475,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,

			  474,  474,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  484,  484,  484,  484,  484,  487,
			  487,  487,  487,  487,  487,  487,  493,  484,  484,  494,
			  567,  568,  502,  503,  492,  502,  506,    0,  487,  506,
			  504,  508,  509,  504,  508,  509,    0,    0,  569,  484,
			  557,  557,  557,  557,  510,    0,  484,  510,  493,  484,
			  484,  494,  567,  568,  570,  503,  492,  511,  502,  504,
			  511,  555,  571,  555,  493,  494,  555,  555,  555,  555,
			  569,  484,  572,  502,  573,  574,    0,  506,  575,  576,
			  577,  504,  508,  509,  492,  578,  570,  492,  492,  492, yy_Dummy>>,
			1, 200, 2122)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  502,  504,    0,    0,  571,  510,    0,  530,  530,  530,
			  530,  530,    0,    0,  572,  502,  573,  574,  511,  506,
			  575,  576,  577,  504,  508,  509,    0,  578,  508,  509,
			  509,  509,  509,  509,  509,  509,  579,  510,  551,  551,
			  551,  551,  529,  529,  529,  529,  529,    0,  509,  530,
			  511,    0,  510,  551,  511,  529,  529,  554,  554,  554,
			  554,    0,  558,    0,  558,  558,  558,  558,  579,    0,
			    0,  580,  554,    0,  581,  582,  583,  529,    0,  551,
			  559,  559,  559,  559,  529,  551,  584,  529,  529,    0,
			  585,  559,  559,  559,  559,  559,  559,    0,  586,  560,

			  560,  560,  560,  580,  554,  558,  581,  582,  583,  529,
			  560,  560,  560,  560,  560,  560,    0,    0,  584,    0,
			  588,  559,  585,  559,  559,  559,  559,  559,  559,  564,
			  586,  564,  564,  564,  564,    0,    0,  589,  590,  591,
			  560,  592,  560,  560,  560,  560,  560,  560,  561,  561,
			  561,  561,  588,    0,    0,    0,  593,    0,  595,  561,
			  561,  561,  561,  561,  561,  562,  562,  562,  562,  589,
			  590,  591,  564,  592,    0,  598,  562,  562,  562,  562,
			  562,  562,  565,  601,  565,  565,  565,  565,  593,  561,
			  595,  561,  561,  561,  561,  561,  561,  602,  599,  599, yy_Dummy>>,
			1, 200, 2322)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  599,  599,  603,  599,  604,  605,  562,  598,  562,  562,
			  562,  562,  562,  562,  599,  601,  606,  607,  608,  609,
			  610,  611,  613,  616,  617,  565,  618,  619,  620,  602,
			  628,  628,  628,  628,  603,  631,  604,  605,  633,    0,
			  656,  628,  628,  628,  628,  628,  628,  634,  606,  607,
			  608,  609,  610,  611,  613,  616,  617,  632,  618,  619,
			  620,  629,  629,  629,  629,  635,    0,  631,  635,  659,
			  633,  631,  656,  628,  628,  628,  628,  628,  628,  634,
			    0,  660,    0,  634,    0,  633,  599,  637,  639,  632,
			  637,  639,    0,  632,  632,  632,  632,  632,  632,  632,

			    0,  659,  629,  650,  650,  650,  650,    0,  661,  635,
			    0,    0,  632,  660,  599,    0,  635,  599,  599,  599,
			  637,  664,  666,  668,  639,  648,  648,  648,  648,    0,
			    0,  645,  645,  645,  645,  669,  670,  671,  637,  639,
			  661,  635,  645,  645,  645,  645,  645,  645,  635,    0,
			    0,    0,  637,  664,  666,  668,  639,  649,  649,  649,
			  649,  652,  652,  652,  652,    0,  648,  669,  670,  671,
			  637,  639,  649,    0,  645,  645,  645,  645,  645,  645,
			  646,  646,  646,  646,    0,    0,  647,  647,  647,  647,
			  672,  646,  646,  646,  646,  646,  646,  647,  647,  647, yy_Dummy>>,
			1, 200, 2522)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  647,  647,  647,  673,  649,  651,  651,  651,  651,  653,
			  653,  653,  653,  655,    0,  655,  655,  655,  655,  674,
			  651,    0,  672,  646,  646,  646,  646,  646,  646,  647,
			  647,  647,  647,  647,  647,  673,  654,  676,  654,  654,
			  654,  654,  677,  665,  678,  679,  651,  665,  680,  681,
			  682,  674,  651,  654,  684,  692,  655,  685,  685,  685,
			  685,  693,  685,  694,  695,  696,  697,  698,  699,  676,
			  701,  702,  705,  685,  677,  665,  678,  679,  706,  665,
			  680,  681,  682,  708,    0,  654,  684,  692,  712,  712,
			  712,  712,    0,  693,    0,  694,  695,  696,  697,  698,

			  699,  732,  701,  702,  705,  713,  713,  713,  713,  713,
			  706,  715,  733,  716,  715,  708,  716,  713,  713,  713,
			  713,  713,  713,  723,  723,  723,  723,  723,  717,  734,
			  712,  717,  724,  732,  724,    0,    0,  724,  724,  724,
			  724,    0,  716,  715,  733,  685,    0,  713,  736,  713,
			  713,  713,  713,  713,  713,  727,  727,  727,  727,  737,
			  738,  734,  715,  739,  716,  723,  725,  725,  725,  725,
			    0,  717,    0,  685,  716,  715,  685,  685,  685,  717,
			  736,  725,  742,  744,    0,  719,  719,  719,  719,  719,
			  745,  737,  738,  747,  715,  739,  716,  719,  719,  719, yy_Dummy>>,
			1, 200, 2722)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  719,  719,  719,  717,  720,  720,  720,  720,  720,    0,
			    0,  717,  748,  725,  742,  744,  720,  720,  720,  720,
			  720,  720,  745,    0,    0,  747,    0,  719,  749,  719,
			  719,  719,  719,  719,  719,  728,    0,  728,    0,    0,
			  728,  728,  728,  728,  748,    0,  720,  750,  720,  720,
			  720,  720,  720,  720,  721,  721,  721,  721,  721,  751,
			  749,  752,  726,  726,  726,  726,  721,  721,  721,  721,
			  721,  721,  722,  722,  722,  722,  722,  726,  729,  750,
			  729,  729,  729,  729,  722,  722,  722,  722,  722,  722,
			  759,  751,  760,  752,  761,  729,  721,    0,  721,  721,

			  721,  721,  721,  721,  762,  764,  768,  769,  771,  726,
			  793,  793,  793,  793,  722,    0,  722,  722,  722,  722,
			  722,  722,  759,    0,  760,    0,  761,  729,  756,  756,
			  756,  756,  756,  756,  756,  772,  762,  764,  768,  769,
			  771,    0,    0,    0,  777,  777,  777,  756,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  773,  781,  782,  783,  781,  782,  783,  794,  794,  794,
			  794,  802,  803,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  777,  779,  779,  779,  779,
			  781,  805,  783,  799,  799,  799,  799,  779,  779,  779, yy_Dummy>>,
			1, 200, 2922)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  779,  779,  779,  802,  803,  782,  800,  800,  800,  800,
			  807,  808,  781,  782,  783,  809,  810,  835,  835,  835,
			  835,    0,  781,  805,  783,    0,    0,  779,  813,  779,
			  779,  779,  779,  779,  779,    0,    0,  782,  785,  785,
			  785,  785,  807,  808,  781,  782,  783,  809,  810,  785,
			  785,  785,  785,  785,  785,  787,  787,  787,  787,  816,
			  813,  795,  795,  795,  795,  817,  787,  787,  787,  787,
			  787,  787,  836,  836,  836,  836,  795,  819,    0,  785,
			    0,  785,  785,  785,  785,  785,  785,  796,    0,  796,
			    0,  816,  796,  796,  796,  796,  787,  817,  787,  787,

			  787,  787,  787,  787,  789,  789,  789,  789,  795,  819,
			  798,  798,  798,  798,  820,  789,  789,  789,  789,  789,
			  789,  791,  791,  791,  791,  798,  837,  837,  837,  837,
			    0,  821,  791,  791,  791,  791,  791,  791,    0,  818,
			  818,  818,  818,    0,    0,  789,  820,  789,  789,  789,
			  789,  789,  789,  797,  823,  797,  824,  798,  797,  797,
			  797,  797,  791,  821,  791,  791,  791,  791,  791,  791,
			  801,  818,  801,  834,    0,  801,  801,  801,  801,  827,
			  828,  829,  827,  828,  829,    0,  823,    0,  824,  838,
			  838,  838,  838,  839,  839,  839,  839,  844,    0,  834, yy_Dummy>>,
			1, 200, 3122)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  847,  851,  818,  840,  834,  840,  854,  839,  840,
			  840,  840,  840,  841,  841,  841,  841,  827,  842,  842,
			  842,  842,  853,  853,  853,  853,    0,    0,    0,  844,
			  827,  828,  829,  847,  851,  859,  861,    0,  864,  854,
			  839,  864,  871,  867,  868,  868,  868,  868,  873,  827,
			  869,  869,  869,  869,  853,  818,  874,    0,  818,  818,
			  818,    0,  827,  828,  829,  883,  884,  859,  861,  867,
			  885,  886,  887,    0,  871,  867,    0,    0,  905,  905,
			  873,  905,  905,  905,  905,  905,  853,    0,  874,  864,
			  876,  876,  876,  876,  876,  876,  876,  883,  884,    0,

			    0,    0,  885,  886,  887,    0,    0,    0,    0,  876,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,    0,
			    0,  864,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  911,  911,  911,  911,  911,  911,    0,  853,  911,
			    0,  853,  853,  853,  893,  893,  893,  893,  893,  893,
			  893,  893,  893,  894,  894,  894,  894,  894,  894,  894,
			  894,  894,  895,  895,  895,  895,  895,  895,  895,  895,
			  895,  896,  896,  896,  896,  896,  896,  896,  896,  898,
			  898,  898,  898,  898,  898,  898,  898,  898,  906,  906,
			  906,  906,  906,  906,  906,  906,  906,  907,  907,  907, yy_Dummy>>,
			1, 200, 3322)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  907,  907,  907,  907,  907,  907,  908,  908,  908,  908,
			  908,  908,  908,  908,  908,  909,  909,  909,  909,  909,
			  909,  909,  909,  910,    0,  910,  910,  910,  910,  910,
			  910,  919,  919,  919,  919,  919,  919,  919,  919,  930,
			  930,  930,  930,  930,  930,  930,  930,  930,  931,  931,
			  931,  931,  931,  931,  931,  931, yy_Dummy>>,
			1, 56, 3522)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 931)
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
			    0,    0,    0,  128,  129,  138,  144, 2083, 2082,  150,
			  156,  162,  168, 2082, 3578,  174,  185, 3578,  302,    0,
			 3578,  429, 3578, 3578, 3578, 3578, 3578,  115,  172,  154,
			  188,  178, 2038, 3578,  129, 3578,  134, 2033,  301,    0,
			  174,  170,  281,  291,  293,  179,   91,  368,  182,  147,
			  368,  363,  160,  318,  193,  198, 3578, 2001, 3578, 3578,
			 3578, 3578, 3578,  358,  121,    0,  369, 1934,  300, 1942,
			    0,  392,    0,  396,    0,  419, 1983, 3578, 3578,  557,
			  178,  571, 3578, 3578,  221,  291,  338,  374,  297, 1928,
			 3578, 3578,  577, 3578, 1824, 1824,  140, 1822, 3578,  609,

			  615, 1897, 1797, 1798,  147, 1806,  621, 1766, 1676, 1650,
			  175, 1634,  295, 3578,  743,  224,  558,  380,  578,  591,
			  625,  627,  633,  664,  644,  650,  677,  703,  816,  666,
			  694,  825,  942,  868,  965,  907,  988, 1098, 1121,  872,
			    0,  650,  684, 1231,  768, 1673, 1672,  907, 1668,  891,
			 1667, 1012, 1665,  691, 3578, 3578, 3578,  877, 3578, 3578,
			 3578,  886, 1088, 1108, 1125, 1264,  386, 3578, 3578, 3578,
			 3578, 3578, 3578,    0,  238,  257,  722,  319,  353,  367,
			  527,  551,  552,  585,  578, 1100,    0,  583,  647,  833,
			  595,  626,  640,    0,  672, 1222,    0,  721, 1118,  713, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  716,  747,  884,    0,  734,  763, 1326,  878,  860,  874,
			  888,  876,  882, 1255,  882,  892,  962,  950, 3578, 1260,
			 1306, 1294, 1331,    0,    0, 1580, 1221, 1559,    0, 1559,
			 1069, 1543,  597, 1547,    0,    0,    0,    0,    0, 1629,
			 3578, 1365, 3578, 3578, 3578, 3578, 3578, 1004, 3578, 3578,
			 3578, 3578, 3578, 3578, 3578, 3578, 3578, 3578, 3578, 3578,
			 3578, 3578, 3578, 3578, 1529, 1525,  372, 1529,  325, 3578,
			 3578, 1435,  596,  649, 1239, 1245, 1179, 3578, 1247, 1438,
			 1164, 1252, 1610, 3578, 1459, 3578, 1506, 1480,  427, 1485,
			 1480, 1371, 1465, 1466, 1470, 1453, 1450,  547, 1446, 1523,

			 1425, 1402, 1409, 1395, 1383, 1409, 1342, 1316, 3578, 3578,
			 1592, 1488, 1390, 3578, 3578, 3578, 3578, 1436, 3578, 1471,
			 3578, 1472, 1540, 1542, 1518, 1513, 1556, 1665, 3578, 1514,
			 1532, 1557, 1558, 1666, 1576, 3578, 1671,    0,    0,    0,
			    0, 1707, 1730, 1753, 3578, 3578,    0, 1624,    0, 1647,
			    0, 1660,    0, 1776, 1395, 1390, 1389, 1380, 1379, 1489,
			 1378, 1336, 1335, 1330, 1324, 1314, 1313, 1302, 1290, 1280,
			 1266, 1265, 1255, 1244, 1241, 1237, 3578, 3578, 1765, 1235,
			 1228, 1185, 1169,    0,    0,    0, 1603, 1633, 3578, 1874,
			 1883, 1621, 1890, 1911, 1960, 1977, 1941, 1596, 1060, 1091, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1121,    0,    0, 1115, 1887, 1205, 1212, 1238, 1271, 1256,
			 1260, 1277, 1330, 1328,    0, 1314, 1509, 1336, 1323, 1393,
			 1864, 1442, 1480, 1592, 1584, 1601, 1689, 1694, 1680, 1717,
			 1863,    0, 1881, 1862, 1878, 1903, 1902, 1903, 1940, 1922,
			 1953, 1936, 1950, 1956, 1953, 1951, 1957, 1972, 1972, 1980,
			 1982, 1991, 1992, 1998, 1990,    0, 1974,    0, 1943,    0,
			 1075, 1997,    0, 2001,    0, 2024, 1064, 1050,  572, 1045,
			 2021, 2033, 2058, 2070, 2095, 2107, 3578, 3578, 3578, 3578,
			    0,    0,    0, 3578, 2217, 1858, 1041, 2148, 1029, 1019,
			    0,  960, 2199, 2191, 2194, 2074, 2076, 3578, 3578, 3578,

			 3578, 2077, 2248, 2198, 2256, 3578, 2252, 3578, 2257, 2258,
			 2270, 2283, 3578, 3578,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0, 3578, 3578, 3578, 3578, 3578, 2345,
			 2310, 3578, 3578, 3578, 3578, 3578, 3578, 3578, 3578, 3578,
			 3578, 3578, 3578, 3578, 3578, 3578, 3578, 3578, 1022, 1021,
			 1017, 2340, 1757, 2106, 2359, 2278, 2150, 2252, 2366, 2382,
			 2401, 2450, 2467,  932, 2433, 2486, 2083, 2202, 2204, 2233,
			 2253, 2255, 2263, 2257, 2272, 2260, 2276, 2275, 2269, 2325,
			 2354, 2348, 2353, 2350, 2360, 2377, 2369,    0, 2407, 2420,
			 2406, 2413, 2428, 2430,    0, 2438,    0,    0, 2455, 2519, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0, 2466, 2468, 2488, 2478, 2484, 2499, 2488, 2498, 2486,
			 2509, 2495,    0, 2498,    0,    0, 2510, 2510, 2497, 2507,
			 2519,    0,    0,  194,  499, 3578,  625,  919, 2532, 2563,
			  872, 2500, 2522, 2503, 2512, 2581, 3578, 2603, 3578, 2604,
			 3578,    0,    0,    0,  908, 2633, 2682, 2688, 2627, 2659,
			 2605, 2707, 2663, 2711, 2740, 2717, 2513,    0,    0, 2547,
			 2565, 2598,    0,    0, 2595, 2730, 2600,    0, 2597, 2619,
			 2622, 2624, 2678, 2675, 2697,    0, 2711, 2720, 2731, 2728,
			 2731, 2738, 2733,    0, 2741, 2778, 3578,  893,  796,  781,
			  665,  787, 2746, 2735, 2746, 2751, 2752, 2740, 2754, 2740,

			    0, 2742, 2762,    0,    0, 2755, 2765,    0, 2761,  769,
			  717, 1523, 2791, 2808,  723, 2827, 2829, 2844, 3578, 2888,
			 2907, 2957, 2975, 2826, 2839, 2868, 2964, 2857, 2942, 2982,
			    0,    0, 2788, 2783, 2801,    0, 2825, 2831, 2847, 2854,
			    0,    0, 2869,    0, 2874, 2877,    0, 2866, 2890, 2900,
			 2919, 2950, 2933, 3578,  754,  652, 2957,  616,  622, 2970,
			 2965, 2972, 2982,    0, 2992,    0,    0,    0, 2978, 2985,
			    0, 2980, 2953, 2978, 3578, 1945, 3578, 3046, 3578, 3088,
			  639, 3077, 3078, 3079,  660, 3140,  657, 3157,  652, 3206,
			  638, 3223,  632, 3012, 3069, 3163, 3194, 3260, 3212, 3095, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3108, 3277, 3059, 3044,    0, 3069,    0, 3098, 3101, 3103,
			 3096,    0,    0, 3113,    0,    0, 3137, 3152, 3260, 3154,
			 3201, 3220,    0, 3241, 3243,    0,    0, 3295, 3296, 3297,
			 3578, 3578, 3578, 3578, 3260, 3119, 3174, 3228, 3291, 3295,
			 3311, 3315, 3320,    0, 3284,    0,    0, 3281,    0,    0,
			    0, 3274,    0, 3343, 3287,  516,  483,  722,  472, 3309,
			    0, 3323,    0,    0, 3354, 3578, 3578, 3330, 3346, 3352,
			    0, 3329,    0, 3328, 3347,  377, 3319,  335,  343,    0,
			    0, 3578,    0, 3356, 3339, 3343, 3344, 3345,    0, 3578,
			 3578, 3431, 3443, 3465, 3474, 3483, 3491, 1192, 3500,  409,

			  398,  380,  365,  357,  341, 3398, 3509, 3518, 3527, 3535,
			 3543, 3452,  622,  816,  828,  927,  313,  308,  303, 3551,
			  293,  273,  231,  210,  200,  176,  167,  160,  142,  126,
			 3560, 3568, yy_Dummy>>,
			1, 132, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 931)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (899, 173, 217)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (890, 240, 267)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (890, 353, 377)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (899, 398, 455)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (899, 566, 622)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (899, 656, 684)
			yy_def_template_7 (an_array)
			yy_def_template_8 (an_array)
			an_array.area.fill_with (890, 891, 931)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  890,    1,  891,  891,  892,  892,  893,  893,  894,
			  894,  895,  895,  890,  890,  890,  890,  890,  896,  897,
			  890,  898,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  890,  890,  890,  890,
			  890,  890,  890,  890,  900,  900,  890,  901,  902,  901,
			  901,  890,  903,  890,  904,  890,  905,  890,  890,  890,
			  906,  906,  890,  890,  907,  906,  906,  906,  906,  908,
			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,

			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  896,  890,  909,  910,  896,  896,  896,  896,
			  896,  896,  896,  896,  896,  896,  896,  896,  896,  896,
			  896,  896,  896,  896,  132,  896,  132,  896,  132,  896,
			  897,  911,  911,  911,  911,  890,  912,  890,  913,  890,
			  914,  890,  915,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890, yy_Dummy>>,
			1, 173, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  890,  890,  890,  890,  890,  900,  900,  900,  900,  900,
			  900,  900,  900,  900,  890,  900,  900,  900,  916,  917,
			  918,  905, yy_Dummy>>,
			1, 22, 218)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  906,  890,  890,  906,  907,  906,  906,  906,  906,  890,
			  906,  906,  906,  906,  908,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  919,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  909,  910,  896,  890,  890,  890,  890,  896,
			  890,  896,  890,  896,  896,  896,  896,  896,  896,  896,
			  890,  896,  896,  896,  896,  896,  896,  890,  896,  132,
			  132,  132,  132,  132,  132,  132,  890,  890,  920,  890,
			  921,  890,  922,  890,  923, yy_Dummy>>,
			1, 85, 268)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  911,  912,  912,  912,  912,  924,  925,  926,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890, yy_Dummy>>,
			1, 20, 378)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  890,  900,  890,  901,  902,  890,  903,  890,  904,  890,
			  900,  901,  902,  901,  890,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  900,  900,  900,  890,  890,  890,
			  890,  890,  890,  890,  919,  919,  910,  910,  910,  910,
			  910,  890,  890,  890,  890,  896,  896,  896,  896,  890,
			  896,  890,  896,  896,  896,  896,  890,  890,  132,  132,
			  132,  920,  920,  920,  920,  927,  928,  929,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  912,  912,  912,  890,  890,  890,  890,  890,

			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890, yy_Dummy>>,
			1, 110, 456)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  902,  902,  890,  890,  890,  890,  890,  919,  910,  910,
			  910,  910,  896,  890,  896,  890,  896,  890,  920,  920,
			  920,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890, yy_Dummy>>,
			1, 33, 623)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  890,  890,  890,  890,  890,  890,  890,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  899,  899,
			  899,  899,  899,  899,  900,  900,  890,  890,  890,  919,
			  896,  896,  896,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  899,  899,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  890,  930,
			  890,  890,  890,  890,  899,  899,  899,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  890,  890,  890,
			  890,  890,  890,  890,  890,  919,  896,  896,  896,  890,

			  890,  890,  890,  890,  890,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  899,  899,
			  899,  931,  896,  896,  896,  890,  890,  890,  890,  890,
			  890,  890,  890,  890,  890,  890,  890,  890,  899,  899,
			  899,  899,  899,  899,  899,  899,  899,  899,  890,  899,
			  890,  890,  890,  890,  899,  899,  899,  899,  899,  896,
			  890,  890,  890,  890,  890,  899,  899,  899,  890,  899,
			  890,  890,  890,  890,  899,  899,  890,  899,  890,  899, yy_Dummy>>,
			1, 200, 685)
		end

	yy_def_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  890,  899,  890,  899,  890,    0, yy_Dummy>>,
			1, 6, 885)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (118, 195, 223)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,  129,  129,  129,  129,  129,  129,  129,  129,    1,
			    2,    1,    1,    3,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,

			   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,  129,   93,   94,
			   95,   96,   95,   95,   95,   97,   98,   95,   99,  100,
			  100,  100,  100,  100,  101,  101,  102,  101,  101,  101,
			  101,  101,  101,  101,  103,  101,  101,  101,  101,  104,
			  105,  106,  106,  106,  106,  106,  107,  108,  109,  110,
			  110,  110,  111,  110,  110,  112,  106,  106,  113,  114,
			  106,  106,  106,  106,  106,  106,  106,  115,  106,  106,
			  106,  106,  116,  116,  117, yy_Dummy>>,
			1, 195, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  119,  120,  121,  122,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  124,  125,  125,  126,  127,  127,  127,
			  128,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  129, yy_Dummy>>,
			1, 34, 224)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    9,    1,    9,    9,    2,    3,    2,    2,    4,
			    2,    5,    2,    2,    2,    2,    2,    2,    2,    2,
			    6,    6,    6,    6,    2,    2,    2,    2,    2,    2,
			    2,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    2,    2,    2,
			    2,    6,    2,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    2,
			    2,    2,    2,    7,    7,    7,    7,    7,    7,    7,

			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    8,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 891)
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
			  339,  341,  343,  345,  345,  345,  345,  345,  345,  345,
			  345,  345,  345,  345,  345,  345,  345,  345,  345,  345,
			  346,  347,  347,  348,  349,  350,  351,  352,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  365,  366,  367,  368,  368,  368,  368,  368,  369,
			  370,  371,  372,  373,  374,  375,  376,  377,  379,  380,
			  381,  382,  383,  384,  385,  385,  386,  386,  386,  386,
			  386,  386,  386,  386,  386,  387,  387,  387,  387,  387,

			  388,  388,  388,  388,  388,  388,  388,  388,  388,  389,
			  391,  393,  394,  395,  397,  399,  401,  403,  404,  406,
			  407,  409,  410,  411,  412,  413,  414,  415,  416,  417,
			  418,  419,  420,  421,  422,  423,  425,  426,  427,  428,
			  429,  430,  431,  432,  433,  434,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  437,  438,  439,  440,  441,
			  442,  443,  444,  445,  446,  447,  448,  449,  450,  451,
			  452,  453,  454,  455,  456,  457,  458,  460,  461,  462,
			  462,  462,  462,  462,  462,  462,  462,  463,  463,  464,
			  465,  465,  466,  468,  469,  471,  472,  473,  473,  474, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  475,  476,  478,  480,  481,  482,  483,  484,  485,  486,
			  487,  488,  489,  490,  491,  493,  494,  495,  496,  497,
			  498,  499,  500,  501,  502,  503,  504,  505,  506,  507,
			  509,  510,  512,  513,  514,  515,  516,  517,  518,  519,
			  520,  521,  522,  523,  524,  525,  526,  527,  528,  529,
			  530,  531,  532,  533,  534,  535,  537,  537,  537,  537,
			  537,  537,  537,  537,  537,  537,  537,  537,  537,  537,
			  537,  539,  541,  543,  545,  547,  549,  550,  551,  552,
			  553,  553,  553,  553,  554,  554,  554,  554,  554,  554,
			  554,  555,  556,  556,  556,  556,  556,  556,  558,  560,

			  562,  564,  565,  566,  567,  568,  570,  571,  573,  574,
			  575,  576,  577,  579,  581,  582,  583,  584,  584,  584,
			  584,  584,  584,  584,  584,  585,  586,  587,  588,  589,
			  590,  591,  592,  593,  594,  595,  596,  597,  598,  599,
			  600,  601,  602,  603,  604,  605,  606,  607,  609,  609,
			  609,  609,  610,  610,  611,  612,  612,  612,  613,  614,
			  614,  614,  614,  614,  614,  615,  616,  617,  618,  619,
			  620,  621,  622,  623,  624,  625,  626,  627,  628,  629,
			  630,  632,  633,  634,  635,  636,  637,  638,  640,  641,
			  642,  643,  644,  645,  646,  648,  649,  651,  653,  654, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  656,  658,  659,  660,  661,  662,  663,  664,  665,  666,
			  667,  668,  669,  671,  672,  674,  676,  677,  678,  679,
			  680,  681,  683,  685,  685,  685,  686,  686,  686,  686,
			  686,  687,  687,  687,  687,  687,  688,  690,  691,  693,
			  694,  696,  696,  696,  696,  697,  697,  697,  697,  697,
			  698,  698,  699,  699,  700,  701,  702,  703,  705,  707,
			  708,  709,  710,  712,  714,  715,  716,  717,  719,  720,
			  721,  722,  723,  724,  725,  726,  728,  729,  730,  731,
			  732,  733,  734,  735,  737,  738,  738,  739,  739,  739,
			  739,  739,  739,  740,  741,  742,  743,  744,  745,  746,

			  747,  749,  750,  751,  753,  755,  756,  757,  759,  760,
			  760,  760,  760,  760,  760,  761,  762,  763,  764,  765,
			  765,  765,  765,  765,  765,  765,  766,  767,  767,  767,
			  768,  770,  772,  773,  774,  775,  777,  778,  779,  780,
			  781,  783,  785,  786,  788,  789,  790,  792,  793,  794,
			  795,  796,  797,  798,  799,  799,  799,  799,  799,  799,
			  800,  801,  802,  803,  805,  806,  808,  810,  812,  813,
			  814,  816,  817,  819,  821,  822,  822,  823,  823,  824,
			  824,  825,  826,  827,  828,  828,  828,  828,  828,  828,
			  828,  828,  828,  828,  828,  829,  830,  830,  830,  831, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  831,  832,  832,  833,  834,  836,  837,  839,  840,  841,
			  842,  843,  845,  847,  848,  850,  852,  853,  854,  855,
			  856,  857,  858,  860,  861,  862,  864,  866,  867,  868,
			  869,  871,  872,  874,  875,  876,  876,  877,  877,  878,
			  879,  879,  879,  880,  882,  883,  885,  887,  888,  890,
			  892,  894,  895,  897,  897,  898,  898,  898,  898,  898,
			  899,  901,  902,  904,  906,  907,  909,  911,  912,  912,
			  913,  915,  916,  918,  918,  919,  919,  919,  919,  919,
			  921,  923,  925,  927,  927,  928,  928,  929,  929,  931,
			  932,  932, yy_Dummy>>,
			1, 92, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 931)
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
			    0,  198,  198,  200,  200,  234,  232,  233,    1,  232,
			  233,    1,  233,   36,  232,  233,  201,  232,  233,   55,
			  232,  233,   14,  232,  233,  166,  232,  233,   24,  232,
			  233,   25,  232,  233,   32,  232,  233,   30,  232,  233,
			    9,  232,  233,   31,  232,  233,   13,  232,  233,   33,
			  232,  233,  130,  232,  233,  130,  232,  233,    8,  232,
			  233,    7,  232,  233,   18,  232,  233,   17,  232,  233,
			   19,  232,  233,   11,  232,  233,  129,  232,  233,  129,
			  232,  233,  129,  232,  233,  129,  232,  233,  129,  232,
			  233,  129,  232,  233,  129,  232,  233,  129,  232,  233,

			  129,  232,  233,  129,  232,  233,  129,  232,  233,  129,
			  232,  233,  129,  232,  233,  129,  232,  233,  129,  232,
			  233,  129,  232,  233,  129,  232,  233,  129,  232,  233,
			   28,  232,  233,  232,  233,   29,  232,  233,   34,  232,
			  233,   26,  232,  233,   27,  232,  233,   12,  232,  233,
			  232,  233,  232,  233,  232,  233,  232,  233,  232,  233,
			  232,  233,  232,  233,  232,  233,  232,  233,  232,  233,
			  232,  233,  232,  233,  232,  233,  202,  233,  231,  233,
			  229,  233,  230,  233,  198,  233,  198,  233,  197,  233,
			  196,  233,  198,  233,  198,  233,  198,  233,  198,  233, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  198,  233,  200,  233,  199,  233,  194,  233,  194,  233,
			  193,  233,  194,  233,  194,  233,  194,  233,  194,  233,
			    6,  233,    5,    6,  233,    5,  233,    6,  233,    6,
			  233,    6,  233,    6,  233,    6,  233,    1,  201,  190,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201, -425,  201,  201,  201, -425,  201,
			  201,  201,  201,  201,  201,  201,  201,   55,  166,  166,
			  166,  166,    2,   35,   10,  136,   39,   23,   22,  136,
			  130,   15,   37,   20,   21,   38,   16,  129,  129,  129,
			  129,  129,   62,  129,  129,  129,  129,  129,  129,  129,

			  129,   75,  129,  129,  129,  129,  129,  129,  129,   87,
			  129,  129,  129,   93,  129,  129,  129,  129,  129,  129,
			  129,  105,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,   40,   56,    1,
			   56,   43,   56,   48,   56,  202,  229,  219,  217,  218,
			  220,  221,  222,  223,  203,  204,  205,  206,  207,  208,
			  209,  210,  211,  212,  213,  214,  215,  216,  198,  197,
			  196,  198,  198,  198,  198,  198,  198,  195,  196,  198,
			  198,  198,  198,  200,  199,  193,    5,    4,  191,  188,
			  191,  201, -425, -425,  201,  174,  191,  172,  191,  173, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  191,  175,  191,  201,  168,  191,  201,  169,  191,  201,
			  201,  201,  201,  201,  201,  201, -192,  201,  201,  201,
			  201,  201,  201,  176,  191,  201,  201,  201,  201,  201,
			  201,  201,  201,  166,  137,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  139,  166,
			  137,  166,  136,  131,  136,  130,  134,  135,  135,  133,
			  135,  132,  130,  129,  129,  129,   60,  129,   61,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,   78,  129,  129,  129,  129,  129,  129,  129,  129,

			  129,  129,  129,  129,  129,  129,  129,   97,  129,  129,
			  100,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  128,  129,   53,   56,   41,
			   56,   42,   56,   49,   56,   51,   56,   54,   56,   46,
			   47,   45,   44,  228,    4,    4,  180,  191,  177,  191,
			  170,  191,  171,  191,  201,  201,  201,  201,  185,  191,
			  201,  179,  191,  201,  201,  201,  201,  178,  191,  189,
			  191,  201,  201,  201,  156,  154,  155,  157,  158,  167,
			  167,  159,  160,  140,  141,  142,  143,  144,  145,  146, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  147,  148,  149,  150,  151,  152,  153,  138,  166,  136,
			  136,  136,  136,  130,  130,  130,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			   76,  129,  129,  129,  129,  129,  129,  129,   85,  129,
			  129,  129,  129,  129,  129,  129,   94,  129,  129,   96,
			  129,   98,  129,  129,  103,  129,  104,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  117,
			  129,  129,  119,  129,  120,  129,  129,  129,  129,  129,
			  129,  126,  129,  127,  129,  224,    4,  201,  181,  191,
			  201,  184,  191,  201,  187,  191,  167,  136,  136,  136,

			  136,  130,  129,   58,  129,   59,  129,  129,  129,  129,
			   66,  129,   67,  129,  129,  129,  129,   72,  129,  129,
			  129,  129,  129,  129,  129,  129,   83,  129,  129,  129,
			  129,  129,  129,  129,  129,   95,  129,  129,  101,  129,
			  129,  129,  129,  129,  129,  129,  129,  114,  129,  129,
			  129,  118,  129,  121,  129,  129,  129,  124,  129,  129,
			    4,  201,  201,  201,  161,  136,  136,  136,   57,  129,
			   63,  129,  129,  129,  129,   69,  129,  129,  129,  129,
			  129,   77,  129,   79,  129,  129,   81,  129,  129,  129,
			   86,  129,  129,  129,  129,  129,  129,  129,  102,  129, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  129,  129,  129,  110,  129,  129,  112,  129,  113,  129,
			  115,  129,  129,  129,  123,  129,  129,   50,   56,   52,
			   56,  227,  226,  225,    4,  201,  201,  201,  136,  136,
			  136,  136,  129,  129,   68,  129,  129,   71,  129,  129,
			  129,  129,  129,   84,  129,   88,  129,  129,   90,  129,
			   91,  129,  129,  129,  129,  129,  129,  129,  111,  129,
			  129,  129,  125,  129,    3,    4,  201,  201,  201,  164,
			  165,  165,  163,  165,  162,  136,  136,  136,  136,  136,
			   64,  129,  129,   70,  129,   73,  129,  129,   80,  129,
			   82,  129,   89,  129,  129,   99,  129,  129,  129,  108,

			  129,  129,  116,  129,  122,  129,  201,  183,  191,  186,
			  191,  136,  136,   65,  129,  129,   92,  129,  129,  107,
			  129,  109,  129,  182,  191,   74,  129,  129,  129,  106,
			  129,  106, yy_Dummy>>,
			1, 132, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 3578
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 890
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 891
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 129
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

	yyNb_rules: INTEGER = 233
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 234
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
