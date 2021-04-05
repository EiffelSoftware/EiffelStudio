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
			
when 13 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 14 then
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
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 16 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 17 then
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
			
when 18 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 19 then
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
			
when 20 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 21 then
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
			
when 22 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 23 then
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
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 25 then
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
			
when 26 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 27 then
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
			
when 28 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 29 then
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
			
when 30 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			
when 31 then
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
			
when 32 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 33 then
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
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 35 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 36 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 37 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 38 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 39 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 40 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 41 then
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
			
when 42 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 43 then
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
			
when 44 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 45 then
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
			
when 46 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 47 then
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
			
when 48 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 49 then
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
			
when 50 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 51 then
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
			
when 52 then
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
			
when 53 then
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
			
when 54 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 55 then
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
			
when 56 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 57 then
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
			
when 58 then
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
			
when 59 then
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
			
when 60 then
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
			
when 61 then
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
			
when 62 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_BAR, Current)
				last_token := TE_BAR
			
when 63 then
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
			
when 64 then
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
			
when 65 then
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
			
when 66 then
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
			
when 67 then
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
			
when 68 then
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
			
when 69 then
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
			
when 70 then
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
			
when 71 then
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
			
when 72 then
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
			
when 73 then
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
			
when 74 then
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
			
when 75 then
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
			
when 76 then
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
			
when 77 then
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
			
when 78 then
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
			
when 79 then
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
			
when 80 then
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
			
when 81 then
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
			
when 82 then
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
			
when 83 then
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
			
when 84 then
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
			
when 85 then
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
			
when 86 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 87 then
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
			
when 88 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 89 then
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
			
when 90 then
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
			
when 91 then
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
			
when 92 then
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
			
when 93 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 94 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 95 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 96 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 97 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 99 then
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
			
when 100 then
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
			
when 101 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 103 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 104 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 105 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 106 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 107 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 108 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 109 then
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
			
when 110 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 111 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 112 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 113 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 114 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 115 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 116 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 117 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 118 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 119 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 121 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 122 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 123 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 124 then
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
			
when 125 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 126 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 127 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 128 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 130 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 132 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 133 then
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
			
when 134 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 135 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 136 then
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
			
when 137 then
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
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 139 then
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
			
when 140 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 141 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 142 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 143 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 144 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 145 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 146 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 147 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 148 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 149 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 150 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 151 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 152 then
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
			
when 153 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 154 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 156 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 157 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 158 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 159 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 160 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 161 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 162 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 164 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 165 then
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
			
when 166 then
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
			
when 167 then
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
			
when 168 then
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
			
when 169 then
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
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 171 then
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
			
when 172 then
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
			
when 173 then
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
			
when 174 then
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
			
when 175 then
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
			
when 176 then
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
			
when 177 then
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
			
when 178 then
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
			
when 179 then
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
			
when 180 then
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
			
when 181 then
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
			
when 182 then
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
			
when 183 then
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
			
when 184 then
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
			
when 185 then
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
			
when 186 then
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
			
when 187 then
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
			
when 188 then
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
			
when 189 then
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
			
when 190 then
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
			
when 191 then
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
			
when 192 then
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
			
when 193 then
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
			
when 194 then
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
			
when 195 then
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
			
when 196 then
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
			
when 197 then
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
			
when 198 then
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
			
when 199 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 200 then
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
			
when 201 then
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
			
when 202 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 203 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 204 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 205 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 206 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 207 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 208 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 209 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 210 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 211 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 212 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 213 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 214 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 215 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 216 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 217 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 218 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 219 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 220 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 221 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 222 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 223 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 224 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 225 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 226 then
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
			
when 227 then
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
			
when 228 then
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
			
when 229 then
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
			
when 230 then
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
			
when 231 then
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
			
when 232 then
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
			
when 233 then
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
			
when 234 then
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
			
when 235 then
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
			
when 236 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
			
when 237 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 238 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 239 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 240 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 241 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 242 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 243 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 244 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 245 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 246 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 247 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 248 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 249 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 250 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 251 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 252 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 253 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 254 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 255 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 256 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 257 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 258 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 259 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 260 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 261 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 262 then
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
			
when 263 then
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
			
when 264 then
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
			
when 265 then
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
			
when 266 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 267 then
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
			create an_array.make_filled (0, 0, 2612)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			an_array.area.fill_with (285, 917, 942)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			an_array.area.fill_with (445, 1516, 1541)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			an_array.area.fill_with (803, 2516, 2612)
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

			  266,   78,   78,  267,   79,   79,   81,   82,   81,  649,
			   83,   81,   82,   81,  204,   83,   88,   89,   88,   88,
			   89,   88,   91,   92,   91,   91,   92,   91,   94,   94,
			   94,   94,   94,   94,   96,   96,   96,   93,  176,  125,
			   93,  126,  204,   95,  288,  195,   95,  188,  177,   98,
			  127,  127,  127,  189,  129,  129,  129,  131,  131,  131,
			  207,  266,  196,   84,  270,  128,  288,  647,   84,  130,
			  176,  135,  133,  136,  136,  136,  136,  195,  188,  273,
			  274,  273,  640,  134,   84,  275,  275,  275,  196,   84,
			   99,  207,   99,  100,  101,  102,   99,  103,  102,   99, yy_Dummy>>,
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
			  100,  100,   99,   99,  100,  100,   99,  120,  120,  120,
			  121,  356,  121,  353,  353,  121,  275,  275,  275,  121,

			  121,  197,  123,  121,  121,  137,  137,  137,  304,  305,
			  304,  121,  121,  121,  142,  121,  143,  143,  143,  143,
			  138,  142,  139,  143,  143,  143,  143,  354,  144,  145,
			  140,  293,  295,  197,  149,  149,  149,  153,  153,  153,
			  159,  159,  159,  121,  294,  121,  121,  121,  205,  150,
			  146,  299,  154,  296,  794,  160,  372,  147,  151,  152,
			  144,  145,  206,  391,  147,  161,  121,  121,  426,  121,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,  299,
			  205,   97,   97,  297,  141,  155,  155,  155,  372,  178,
			  181,  179,  391,  783,  182,  302,  355,  355,  355,  426, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  156,  180,  266,  266,  298,  267,  270,  183,  371,  375,
			  157,  158,  162,  162,  162,  121,  376,  121,  178,  179,
			  121,  302,  181,  782,  121,  121,  182,  163,  121,  121,
			  210,  210,  210,  183,  371,  165,  121,  121,  121,  166,
			  121,  375,  376,  377,  167,  211,  168,  184,  380,  171,
			  776,  169,  170,  172,  185,  186,  173,  771,  373,  174,
			  187,  374,  175,  436,  437,  437,  437,  165,  121,  377,
			  121,  121,  121,  167,  168,  645,  380,  169,  170,  184,
			  171,  378,  172,  186,  382,  174,  187,  379,  175,  373,
			  374,  121,  121,  381,  121,   97,   97,   97,   97,   97,

			   97,   97,   97,   97,  191,  712,   97,   97,  198,  527,
			  382,  201,  754,  378,  192,  455,  193,  456,  199,  379,
			  194,  202,  528,  200,  203,  381,   96,   96,   96,  803,
			  212,  212,  212,  214,  214,  214,  191,  216,  216,  216,
			  198,   98,  201,  192,  193,  213,  194,  202,  215,  200,
			  203,  753,  217,  218,  218,  218,  220,  220,  220,  222,
			  222,  222,  224,  224,  224,  227,  227,  227,  219,  708,
			  449,  221,  389,  386,  223,  507,  390,  225,  554,  392,
			  228,  441,  209,  230,  230,  230,  232,  232,  232,  234,
			  234,  234,  236,  236,  236,  238,  238,  238,  231,  386, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  402,  233,  390,  507,  235,  403,  554,  237,  353,  353,
			  239,  392,  268,  266,  268,  752,  267,   94,   94,   94,
			   96,   96,   96,  803,  803,  803,  402,  304,  305,  304,
			  803,  403,   95,  407,  400,  278,  509,  450,   96,  120,
			  120,  120,  803,  803,  803,  751,  401,  226,  441,  494,
			  229,  242,  242,  242,  309,  243,  404,  127,  244,  407,
			  245,  246,  247,  803,  803,  803,  400,  509,  248,  269,
			  747,   96,   96,   96,  387,  249,  408,  250,  129,  418,
			  251,  252,  253,  254,  306,  255,   98,  256,  404,  388,
			  269,  257,  699,  258,  419,  700,  259,  260,  261,  262,

			  263,  264,   99,  279,   99,  418,  387,   99,  408,   99,
			  618,   99,   99,  726,   99,  388,   99,  339,  339,  339,
			  803,  803,  803,   99,   99,   99,  419,   99,   99,  427,
			  420,  553,  340,  452,  700,  137,   99,  343,  343,  343,
			  425,   99,   99,  701,  341,  341,  341,  341,  345,  345,
			  345,   99,  344,  451,  119,   99,  420,   99,   99,  342,
			   99,  427,  553,  346,  441,  452,  425,   99,  559,   99,
			  142,  459,  352,  352,  352,  352,  428,  454,   99,   99,
			  681,   99,  441,   99,   99,   99,   99,   99,   99,   99,
			   99,  342,  645,   99,   99,  280,  281,  280,  279,  559, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  280,  641,  428,  454,  280,  280,  405,  282,  280,  280,
			  347,  347,  347,  147,  508,  406,  280,  280,  280,  349,
			  280,  350,  350,  350,  350,  348,  357,  357,  357,  357,
			  803,  803,  803,  415,  529,  457,  351,  416,  405,  513,
			  359,  359,  359,  514,  406,  149,  508,  570,  280,  571,
			  280,  280,  280,  360,  632,  361,  556,  512,  364,  364,
			  364,  457,  415,  529,  362,  513,  363,  358,  351,  514,
			  629,  280,  280,  365,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  625,  556,  280,  280,   99,  512,
			   99,  283,  284,  283,  285,  103,  283,  285,  285,  285,

			  283,  283,  285,  286,  283,  283,  285,  285,  285,  285,
			  285,  285,  283,  283,  283,  285,  283, yy_Dummy>>,
			1, 117, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  287,  283,  285,  283,  283,  283,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  287,  285,  283,  283,  285,  283,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,   99,   99,  280,
			  280,   99,  292,  100,  562,  605,  100,  515,   99,  612,
			  100,  100,  518,   99,  100,  100,  803,  803,  803,  803,
			  803,  803,  100,  519,  100,  707,  100,   99,  366,  366,
			  366,  153,  562,  605,  155,   99,  368,  368,  368,  515,
			   99,   99,  383,  367,  518,  516,  384,  273,  274,  273,
			   99,  369,  600,  119,  100,  519,  100,  395,  100,   99,

			  385,  396,  370,  242,  242,  242,   99,  708,   99,  560,
			  435,  516,  397,  517,  383,  398,  521,  595,  384,  520,
			  422,  100,  310,  310,  310,  423,  385,  592,  572,  395,
			   97,  522,  396,  409,  524,  410,  424,  311,  397,  517,
			  560,  398,  521,  411,  525,  523,  412,  588,  413,  414,
			  349,  520,  422,  429,  429,  429,  423,  572,  803,  803,
			  803,  530,  424,  522,  531,  409,  524,  410,  430,  526,
			  525,  411,  412,  210,  413,  414,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  803,  803,  803,  803,
			  803,  212,  616,  530,  214,  526,  531,  216,  594,  497, yy_Dummy>>,
			1, 200, 943)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  218,  638,  638,  220,  495,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  575,  533,  803,  803,  312,  603,
			  312,  616,  573,  312,  275,  275,  275,  312,  312,  594,
			  120,  312,  312,  803,  803,  803,  803,  803,  803,  312,
			  312,  312,  541,  312,  431,  431,  431,  533,  222,  617,
			  603,  224,  803,  803,  803,  433,  433,  433,  534,  432,
			  535,  803,  803,  803,  803,  803,  803,  227,  541,  569,
			  434,  312,  284,  312,  312,  312,  230,  281,  617,  236,
			  537,  803,  803,  803,  304,  305,  304,  268,  266,  268,
			  534,  267,  535,  568,  312,  312,  238,  312,  132,  132,

			  132,  132,  132,  132,  132,  132,  132,  540,  510,  132,
			  132,  316,  537,  539,  317,  611,  318,  319,  320,  440,
			  440,  440,  546,  538,  321,  511,  536,  447,  305,  447,
			  542,  322,  543,  323,   96,  549,  324,  325,  326,  327,
			  510,  328,  532,  329,  269,  539,  611,  330,  546,  331,
			  506,  511,  332,  333,  334,  335,  336,  337,  312,  497,
			  312,  549,  542,  312,  543,  269,  544,  312,  312,  495,
			  162,  312,  312,  304,  305,  304,  460,  460,  460,  312,
			  312,  312,  288,  312,  120,  120,  120,  468,  469,  469,
			  469,  120,  803,  803,  803,  487,  545,  487,  544,  123, yy_Dummy>>,
			1, 200, 1143)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  488,  488,  488,  488,  288,  658,  558,  339,   97,  485,
			  501,  312,  484,  312,  312,  312,  440,  440,  440,   97,
			  483,  486,  486,  486,  486,  355,  355,  355,  545,  589,
			  550,  343,  558,  658,  312,  312,  342,  312,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  646,  646,  132,
			  132,  285,  443,  285,  628,  589,  285,  551,  552,  555,
			  285,  285,  550,  444,  285,  285,  496,  590,  342,  440,
			  440,  440,  285,  285,  285,  664,  285,  440,  440,  440,
			  491,  557,  491,  628,  345,  492,  492,  492,  492,  551,
			  552,  555,  347,  590,  489,  489,  489,  489,  671,  500,

			  500,  500,  500,  664,  285,  482,  285,  285,  285,  490,
			  359,  359,  359,  557,  502,  502,  502,  488,  488,  488,
			  488,  488,  488,  488,  488,  501,  671,  285,  285,  503,
			  285,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			  358,  490,   99,   99,   99,  481,   99,  102,  279,  102,
			  445,  103,  102,  445,  445,  445,  102,  102,  445,   99,
			  102,  102,  445,  445,  445,  445,  445,  445,  102,  102,
			  102,  445,  102, yy_Dummy>>,
			1, 173, 1343)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  446,  102,  445,  102,  102,  102,  445,  445,  445,  445,
			  445,  445,  445,  445,  445,  445,  445,  445,  445,  445,
			  445,  445,  446,  445,  102,  102,  445,  102,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,   99,   99,  100,
			  100,   99,  461,  461,  461,  142,  561,  493,  493,  493,
			  493,  498,  636,  499,  499,  499,  499,  310,   96,   96,
			   96,   96,   96,   96,  440,  440,  440,  591,  440,  440,
			  440,  644,  596,  278,  547,  711,  278,  673,  561,  364,
			  621,  636,  504,  366,  440,  440,  440,  505,  147,   96,
			   96,   96,  548,  591,  358,  440,  440,  440,  596,  368,

			  644,  440,  440,  440,  278,  673,  547,  440,  440,  440,
			  429,  621,  447,  305,  447,  158,  431,  712,  548,  304,
			  305,  304,  433,  310,  574,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  569,  480,  803,  803,  310,  310,
			  310,  563,  437,  437,  437,  437,  563,  437,  437,  437,
			  437,  598,  479,  462,  564,  565,  574,  478,  576,  469,
			  469,  469,  469,  581,  581,  581,  581,  288,  353,  353,
			  626,  576,  469,  469,  469,  469,  566,  598,  342,  492,
			  492,  492,  492,  567,  577,  578,  564,  565,  567,  288,
			  694,  803,  803,  803,  803,  803,  803,  803,  803,  803, yy_Dummy>>,
			1, 200, 1542)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  580,  626,  803,  803,  582,  593,  579,  477,  597,  494,
			  342,  643,  601,  580,  599,  604,  577,  578,  694,  606,
			  476,  803,  803,  803,  803,  803,  803,  803,  803,  803,
			  734,  602,  803,  803,  445,  443,  445,  593,  601,  445,
			  597,  604,  643,  445,  445,  606,  599,  445,  445,  583,
			  583,  583,  583,  607,  608,  445,  445,  445,  734,  445,
			  584,  610,  584,  602,  490,  585,  585,  585,  585,  492,
			  492,  492,  492,  440,  440,  440,  609,  614,  475,  607,
			  586,  613,  493,  493,  493,  493,  608,  445,  359,  445,
			  445,  445,  474,  610,  473,  498,  490,  587,  587,  587,

			  587,  498,  609,  500,  500,  500,  500,  613,  615,  614,
			  445,  445,  472,  445,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,  358,  622,   99,   99,  618,  618,  618,
			  623,  619,  624,  627,  615,  630,  633,  631,  358,  634,
			  635,  637,  620,  642,  358,  639,  639,  639,  471,  470,
			  622,  437,  437,  437,  437,  648,  648,  648,  624,  627,
			  659,  467,  623,  631,  657,  466,  635,  630,  633,  642,
			  660,  634,  661,  637,  650,  650,  650,  650,  581,  581,
			  581,  581,  652,  652,  652,  652,  653,  653,  653,  653,
			  657,  659,  567,  651,  585,  585,  585,  585,  661,  662, yy_Dummy>>,
			1, 200, 1742)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  667,  490,  660,  663,  619,  585,  585,  585,  585,  349,
			  665,  653,  653,  653,  653,  580,  656,  666,  500,  500,
			  500,  500,  668,  669,  670,  651,  655,  654,  674,  677,
			  672,  662,  667,  490,  663,  675,  665,  676,  678,  679,
			  682,  683,  618,  618,  618,  684,  680,  685,  666,  686,
			  670,  687,  688,  691,  668,  669,  672,  620,  655,  147,
			  674,  677,  689,  690,  692,  693,  675,  683,  676,  678,
			  702,  679,  682,  695,  638,  638,  684,  687,  703,  685,
			  704,  686,  724,  725,  688,  691,  723,  465,  689,  690,
			  697,  639,  639,  639,  464,  692,  463,  693,  705,  646,

			  646,  702,  709,  648,  648,  648,  704,  728,  724,  725,
			  703,  716,  716,  716,  716,  696,  727,  458,  723,  680,
			  713,  650,  650,  650,  650,  729,  717,  733,  714,  735,
			  714,  730,  698,  715,  715,  715,  715,  731,  453,  728,
			  706,  448,  727,  732,  710,  653,  653,  653,  653,  719,
			  719,  719,  719,  733,  736,  735,  737,  729,  717,  720,
			  718,  720,  580,  730,  721,  721,  721,  721,  349,  731,
			  719,  719,  719,  719,  738,  732,  739,  740,  741,  742,
			  736,  743,  744,  745,  746,  722,  638,  638,  737,  639,
			  639,  639,  718,  748,  749,  442,  750,  764,  766,  279, yy_Dummy>>,
			1, 200, 1942)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  738,  441,  439,  740,  272,  739,  741,  742,  744,  241,
			  746,  745,  234,  743,  765,  772,  767,  722,  232,  421,
			  749,  715,  715,  715,  715,  748,  766,  696,  750,  764,
			  698,  715,  715,  715,  715,  755,  755,  755,  755,  756,
			  765,  756,  768,  772,  757,  757,  757,  757,  767,  758,
			  717,  758,  769,  773,  759,  759,  759,  759,  760,  760,
			  760,  760,  721,  721,  721,  721,  721,  721,  721,  721,
			  762,  770,  762,  761,  768,  763,  763,  763,  763,  774,
			  774,  774,  717,  777,  769,  773,  778,  779,  780,  781,
			  717,  757,  757,  757,  757,  757,  757,  757,  757,  417,

			  770,  759,  759,  759,  759,  761,  759,  759,  759,  759,
			  775,  784,  784,  784,  784,  777,  582,  781,  778,  779,
			  780,  787,  717,  785,  789,  785,  761,  788,  786,  786,
			  786,  786,  763,  763,  763,  763,  763,  763,  763,  763,
			  791,  792,  775,  774,  774,  774,  793,  761,  795,  799,
			  789,  797,  796,  787,  798,  399,  788,  394,  761,  786,
			  786,  786,  786,  786,  786,  786,  786,  792,  800,  791,
			  801,  802,  393,  654,  790,  799,  159,  131,  793,  761,
			  795,  796,  338,  797,  315,  308,  798,   97,   97,   97,
			  132,  132,  132,  307,  800,   97,  801,  802,  132,  164, yy_Dummy>>,
			1, 200, 2142)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  164,  164,  303,  301,  300,  291,  790,   76,   76,   76,
			   76,   76,   76,   76,   76,   76,   76,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,  122,  122,  122,
			  290,  122,  289,  122,  122,  122,  124,  277,  124,  124,
			  124,  124,  124,  124,  124,  124,  240,  276,  240,  240,
			  240,  272,  240,  240,  240,  240,  265,  265,  265,  265,
			  265,  265,  265,  265,  265,  265,  269,  269,  269,  269,

			  269,  269,  269,  269,  269,  269,  271,  271,  271,  271,
			  271,  271,  271,  271,  271,  271,  103,  241,  103,  208,
			  103,  103,  103,  103,  103,  103,  313,  190,  313,  148,
			  313,  313,  313,  314,  803,  314,  314,  314,  314,  314,
			  314,  314,  314,  438,   86,  438,  438,  438,  438,  438,
			  438,  438,  438,  681,  681,  681,  681,  681,  681,  681,
			  681,  681,  681,  747,   86,  747,  747,  747,  747,  747,
			  747,  747,  747,   13, yy_Dummy>>,
			1, 174, 2342)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2612)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 97)
			yy_chk_template_1 (an_array)
			an_array.area.fill_with (18, 192, 286)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (102, 890, 984)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			an_array.area.fill_with (286, 1489, 1583)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			an_array.area.fill_with (803, 2515, 2612)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   80,    3,    4,   80,    3,    4,    5,    5,
			    5,  826,    5,    6,    6,    6,   53,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   17,   11,
			   42,   21,   12,   21,   53,   15,  103,   49,   16,   46,
			   42,   17,   24,   24,   24,   46,   25,   25,   25,   27,
			   27,   27,   55,   84,   49,    5,   84,   24,  103,  825,
			    6,   25,   42,   28,   27,   28,   28,   28,   28,   49,
			   46,   88,   88,   88,  824,   27,    5,   91,   91,   91,
			   49,    6,   18,   55, yy_Dummy>>,
			1, 94, 98)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   19,   19,   19,   19,  822,   19,  144,  144,   19,   92,
			   92,   92,   19,   19,   50,   19,   19,   19,   29,   29,
			   29,  119,  119,  119,   19,   19,   19,   30,   19,   30,
			   30,   30,   30,   29,   31,   29,   31,   31,   31,   31,
			  821,   30,   30,   29,  108,  109,   50,   34,   34,   34,
			   35,   35,   35,   37,   37,   37,   19,  108,   19,   19,
			   19,   54,   34,   30,  111,   35,  109,  781,   37,  166,
			   30,   34,   34,   30,   30,   54,  181,   31,   37,   19,
			   19,  206,   19,   19,   19,   19,   19,   19,   19,   19,
			   19,   19,  111,   54,   19,   19,  110,   29,   36,   36,

			   36,  166,   43,   44,   43,  181,  750,   44,  114,  145,
			  145,  145,  206,   36,   43,  265,  269,  110,  265,  269,
			   44,  165,  168,   36,   36,   38,   38,   38,   38,  169,
			   38,   43,   43,   38,  114,   44,  749,   38,   38,   44,
			   38,   38,   38,   60,   60,   60,   44,  165,   39,   38,
			   38,   38,   39,   38,  168,  169,  170,   39,   60,   39,
			   45,  173,   41,  740,   39,   39,   41,   45,   45,   41,
			  734,  167,   41,   45,  167,   41,  248,  248,  248,  248,
			   39,   38,  170,   38,   38,   38,   39,   39,  713,  173,
			   39,   39,   45,   41,  171,   41,   45,  175,   41,   45, yy_Dummy>>,
			1, 200, 287)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  172,   41,  167,  167,   38,   38,  174,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   38,   48,  712,   38,
			   38,   51,  393,  175,   52,  711,  171,   48,  302,   48,
			  302,   51,  172,   48,   52,  393,   51,   52,  174,   58,
			   58,   58,  710,   63,   63,   63,   64,   64,   64,   48,
			   65,   65,   65,   51,   58,   52,   48,   48,   63,   48,
			   52,   64,   51,   52,  709,   65,   66,   66,   66,   67,
			   67,   67,   68,   68,   68,   69,   69,   69,   70,   70,
			   70,   66,  708,  294,   67,  180,  178,   68,  372,  180,
			   69,  419,  182,   70,  294,   58,   71,   71,   71,   72,

			   72,   72,   73,   73,   73,   74,   74,   74,   75,   75,
			   75,   71,  178,  190,   72,  180,  372,   73,  191,  419,
			   74,  353,  353,   75,  182,   81,   81,   81,  707,   81,
			   94,   94,   94,   97,   97,   97,   98,   98,   98,  190,
			  116,  116,  116,  706,  191,   94,  195,  189,   97,  376,
			  296,   98,  121,  121,  121,  128,  128,  128,  705,  189,
			   69,  296,  353,   70,   79,   79,   79,  121,   79,  192,
			  128,   79,  195,   79,   79,   79,  130,  130,  130,  189,
			  376,   79,   81,  701,  132,  132,  132,  179,   79,  196,
			   79,  130,  200,   79,   79,   79,   79,  116,   79,  132, yy_Dummy>>,
			1, 200, 487)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   79,  192,  179,   81,   79,  640,   79,  201,  700,   79,
			   79,   79,   79,   79,   79,   99,   99,   99,  200,  179,
			   99,  196,   99,  681,   99,   99,  663,   99,  179,   99,
			  134,  134,  134,  138,  138,  138,   99,   99,   99,  201,
			   99,   99,  207,  202,  418,  134,  299,  640,  138,   99,
			  139,  139,  139,  205,   99,   99,  641,  136,  136,  136,
			  136,  140,  140,  140,   99,  139,  298,   99,   99,  202,
			   99,   99,  136,   99,  207,  418,  140,  298,  299,  205,
			   99,  424,   99,  143,  307,  143,  143,  143,  143,  208,
			  301,   99,   99,  620,   99,  307,   99,   99,   99,   99,

			   99,   99,   99,   99,  136,  576,   99,   99,  100,  100,
			  100,  569,  424,  100,  568,  208,  301,  100,  100,  193,
			  100,  100,  100,  141,  141,  141,  143,  373,  193,  100,
			  100,  100,  142,  100,  142,  142,  142,  142,  141,  147,
			  147,  147,  147,  150,  150,  150,  198,  394,  303,  142,
			  198,  193,  379,  151,  151,  151,  380,  193,  150,  373,
			  452,  100,  452,  100,  100,  100,  151,  553,  151,  421,
			  378,  152,  152,  152,  303,  198,  394,  151,  379,  151,
			  147,  142,  380,  549,  100,  100,  152,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  545,  421,  100, yy_Dummy>>,
			1, 200, 687)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  100,  102,  378, yy_Dummy>>,
			1, 3, 887)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  107,  107,  427,  522,  107,  381,  107,  530,  107,  107,
			  384,  107,  107,  107,  154,  154,  154,  156,  156,  156,
			  107,  385,  107,  647,  107,  107,  157,  157,  157,  154,
			  427,  522,  156,  107,  158,  158,  158,  381,  107,  107,
			  176,  157,  384,  382,  176,  273,  273,  273,  107,  158,
			  517,  107,  107,  385,  107,  186,  107,  107,  176,  186,
			  158,  242,  242,  242,  107,  647,  107,  425,  242,  382,
			  186,  383,  176,  186,  388,  512,  176,  386,  204,  107,
			  122,  122,  122,  204,  176,  509,  453,  186,  504,  389,
			  186,  197,  390,  197,  204,  122,  186,  383,  425,  186,

			  388,  197,  391,  389,  197,  503,  197,  197,  498,  386,
			  204,  209,  209,  209,  204,  453,  211,  211,  211,  395,
			  204,  389,  396,  197,  390,  197,  209,  392,  391,  197,
			  197,  211,  197,  197,  213,  213,  213,  215,  215,  215,
			  217,  217,  217,  219,  219,  219,  221,  221,  221,  213,
			  535,  395,  215,  392,  396,  217,  511,  497,  219,  564,
			  564,  221,  495,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  457,  398,  122,  122,  123,  520,  123,  535,
			  454,  123,  275,  275,  275,  123,  123,  511,  123,  123,
			  123,  223,  223,  223,  225,  225,  225,  123,  123,  123, yy_Dummy>>,
			1, 200, 985)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  407,  123,  226,  226,  226,  398,  223,  538,  520,  225,
			  228,  228,  228,  229,  229,  229,  399,  226,  400,  231,
			  231,  231,  237,  237,  237,  228,  407,  445,  229,  123,
			  442,  123,  123,  123,  231,  441,  538,  237,  402,  239,
			  239,  239,  287,  287,  287,  268,  268,  268,  399,  268,
			  400,  439,  123,  123,  239,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  406,  377,  123,  123,  125,
			  402,  405,  125,  529,  125,  125,  125,  278,  278,  278,
			  412,  403,  125,  377,  401,  288,  288,  288,  408,  125,
			  409,  125,  278,  414,  125,  125,  125,  125,  377,  125,

			  397,  125,  268,  405,  529,  125,  412,  125,  371,  377,
			  125,  125,  125,  125,  125,  125,  163,  356,  163,  414,
			  408,  163,  409,  268,  410,  163,  163,  354,  163,  163,
			  163,  304,  304,  304,  309,  309,  309,  163,  163,  163,
			  288,  163,  312,  312,  312,  321,  321,  321,  321,  309,
			  340,  340,  340,  342,  411,  342,  410,  312,  342,  342,
			  342,  342,  288,  592,  423,  340,  505,  337,  505,  163,
			  336,  163,  163,  163,  344,  344,  344,  505,  335,  341,
			  341,  341,  341,  355,  355,  355,  411,  506,  415,  344,
			  423,  592,  163,  163,  341,  163,  163,  163,  163,  163, yy_Dummy>>,
			1, 200, 1185)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  163,  163,  163,  163,  163,  577,  577,  163,  163,  285,
			  285,  285,  548,  506,  285,  416,  417,  420,  285,  285,
			  415,  285,  285,  285,  355,  507,  341,  346,  346,  346,
			  285,  285,  285,  599,  285,  348,  348,  348,  351,  422,
			  351,  548,  346,  351,  351,  351,  351,  416,  417,  420,
			  348,  507,  350,  350,  350,  350,  607,  358,  358,  358,
			  358,  599,  285,  334,  285,  285,  285,  350,  360,  360,
			  360,  422,  361,  361,  361,  487,  487,  487,  487,  488,
			  488,  488,  488,  360,  607,  285,  285,  361,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  358,  350,

			  285,  285,  286,  333, yy_Dummy>>,
			1, 104, 1385)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  311,  311,  311,  352,  426,  352,  352,  352,  352,  357,
			  559,  357,  357,  357,  357,  311,  362,  362,  362,  363,
			  363,  363,  365,  365,  365,  508,  367,  367,  367,  574,
			  513,  362,  413,  649,  363,  610,  426,  365,  541,  559,
			  362,  367,  369,  369,  369,  363,  352,  370,  370,  370,
			  413,  508,  357,  430,  430,  430,  513,  369,  574,  432,
			  432,  432,  370,  610,  413,  434,  434,  434,  430,  541,
			  447,  447,  447,  370,  432,  649,  413,  446,  446,  446,
			  434,  462,  455,  311,  311,  311,  311,  311,  311,  311,
			  311,  311,  446,  332,  311,  311,  313,  313,  313,  436,

			  436,  436,  436,  436,  437,  437,  437,  437,  437,  515,
			  331,  313,  436,  436,  455,  330,  469,  469,  469,  469,
			  469,  486,  486,  486,  486,  447,  494,  494,  546,  468,
			  468,  468,  468,  468,  436,  515,  486,  491,  491,  491,
			  491,  436,  468,  468,  436,  436,  437,  447,  637,  462,
			  462,  462,  462,  462,  462,  462,  462,  462,  469,  546,
			  462,  462,  486,  510,  468,  329,  514,  494,  486,  572,
			  518,  468,  516,  521,  468,  468,  637,  523,  328,  313,
			  313,  313,  313,  313,  313,  313,  313,  313,  675,  519,
			  313,  313,  444,  444,  444,  510,  518,  444,  514,  521, yy_Dummy>>,
			1, 200, 1584)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  572,  444,  444,  523,  516,  444,  444,  489,  489,  489,
			  489,  524,  525,  444,  444,  444,  675,  444,  490,  528,
			  490,  519,  489,  490,  490,  490,  490,  492,  492,  492,
			  492,  501,  501,  501,  526,  532,  327,  524,  493,  531,
			  493,  493,  493,  493,  525,  444,  501,  444,  444,  444,
			  326,  528,  325,  499,  489,  499,  499,  499,  499,  500,
			  526,  500,  500,  500,  500,  531,  533,  532,  444,  444,
			  324,  444,  444,  444,  444,  444,  444,  444,  444,  444,
			  444,  493,  542,  444,  444,  539,  539,  539,  543,  539,
			  544,  547,  533,  550,  556,  551,  499,  557,  558,  560,

			  539,  570,  500,  565,  565,  565,  323,  322,  542,  567,
			  567,  567,  567,  578,  578,  578,  544,  547,  593,  320,
			  543,  551,  589,  319,  558,  550,  556,  570,  594,  557,
			  597,  560,  580,  580,  580,  580,  581,  581,  581,  581,
			  582,  582,  582,  582,  583,  583,  583,  583,  589,  593,
			  567,  581,  584,  584,  584,  584,  597,  598,  603,  583,
			  594,  598,  539,  585,  585,  585,  585,  586,  601,  586,
			  586,  586,  586,  580,  587,  602,  587,  587,  587,  587,
			  604,  605,  606,  581,  586,  583,  611,  614,  609,  598,
			  603,  583,  598,  612,  601,  613,  615,  617,  621,  622, yy_Dummy>>,
			1, 200, 1784)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  618,  618,  618,  623,  618,  624,  602,  625,  606,  626,
			  627,  631,  604,  605,  609,  618,  586,  587,  611,  614,
			  628,  630,  634,  635,  612,  622,  613,  615,  642,  617,
			  621,  638,  638,  638,  623,  626,  643,  624,  644,  625,
			  660,  661,  627,  631,  659,  318,  628,  630,  639,  639,
			  639,  639,  317,  634,  316,  635,  646,  646,  646,  642,
			  648,  648,  648,  648,  644,  665,  660,  661,  643,  652,
			  652,  652,  652,  638,  664,  306,  659,  618,  650,  650,
			  650,  650,  650,  666,  652,  674,  651,  676,  651,  669,
			  639,  651,  651,  651,  651,  671,  300,  665,  646,  289,

			  664,  672,  648,  653,  653,  653,  653,  654,  654,  654,
			  654,  674,  677,  676,  678,  666,  652,  655,  653,  655,
			  650,  669,  655,  655,  655,  655,  656,  671,  656,  656,
			  656,  656,  679,  672,  682,  683,  684,  685,  677,  687,
			  691,  692,  694,  656,  696,  696,  678,  698,  698,  698,
			  653,  702,  703,  283,  704,  723,  726,  282,  679,  280,
			  276,  683,  271,  682,  684,  685,  691,  240,  694,  692,
			  235,  687,  724,  737,  728,  656,  233,  203,  703,  714,
			  714,  714,  714,  702,  726,  696,  704,  723,  698,  715,
			  715,  715,  715,  716,  716,  716,  716,  717,  724,  717, yy_Dummy>>,
			1, 200, 1984)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  729,  737,  717,  717,  717,  717,  728,  718,  716,  718,
			  730,  738,  718,  718,  718,  718,  719,  719,  719,  719,
			  720,  720,  720,  720,  721,  721,  721,  721,  722,  731,
			  722,  719,  729,  722,  722,  722,  722,  739,  739,  739,
			  716,  741,  730,  738,  742,  744,  745,  748,  755,  756,
			  756,  756,  756,  757,  757,  757,  757,  199,  731,  758,
			  758,  758,  758,  719,  759,  759,  759,  759,  739,  760,
			  760,  760,  760,  741,  755,  748,  742,  744,  745,  765,
			  755,  761,  772,  761,  760,  768,  761,  761,  761,  761,
			  762,  762,  762,  762,  763,  763,  763,  763,  775,  776,

			  739,  774,  774,  774,  778,  784,  788,  797,  772,  791,
			  790,  765,  796,  188,  768,  185,  760,  785,  785,  785,
			  785,  786,  786,  786,  786,  776,  798,  775,  799,  800,
			  183,  784,  774,  797,  160,  133,  778,  784,  788,  790,
			  126,  791,  124,  118,  796,  809,  809,  809,  812,  812,
			  812,  117,  798,  809,  799,  800,  812,  813,  813,  813,
			  115,  113,  112,  106,  774,  804,  804,  804,  804,  804,
			  804,  804,  804,  804,  804,  805,  805,  805,  805,  805,
			  805,  805,  805,  805,  805,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  807,  807,  807,  807,  807, yy_Dummy>>,
			1, 200, 2184)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  807,  807,  807,  807,  807,  808,  808,  808,  808,  808,
			  808,  808,  808,  808,  808,  810,  810,  810,  105,  810,
			  104,  810,  810,  810,  811,   95,  811,  811,  811,  811,
			  811,  811,  811,  811,  814,   93,  814,  814,  814,   85,
			  814,  814,  814,  814,  815,  815,  815,  815,  815,  815,
			  815,  815,  815,  815,  816,  816,  816,  816,  816,  816,
			  816,  816,  816,  816,  817,  817,  817,  817,  817,  817,
			  817,  817,  817,  817,  818,   76,  818,   56,  818,  818,
			  818,  818,  818,  818,  819,   47,  819,   32,  819,  819,
			  819,  820,   13,  820,  820,  820,  820,  820,  820,  820,

			  820,  823,    8,  823,  823,  823,  823,  823,  823,  823,
			  823,  827,  827,  827,  827,  827,  827,  827,  827,  827,
			  827,  828,    7,  828,  828,  828,  828,  828,  828,  828,
			  828, yy_Dummy>>,
			1, 131, 2384)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 828)
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
			    0,    0,    0,   96,   97,  105,  110, 2504, 2484,  115,
			  118,  121,  124, 2476, 2515,  127,  130,  133,  189,  286,
			 2515,  131, 2515, 2515,  149,  153, 2515,  156,  154,  304,
			  297,  304, 2445, 2515,  333,  336,  384,  339,  411,  403,
			    0,  412,  104,  348,  360,  412,  109, 2425,  473,  115,
			  267,  474,  474,   71,  318,  123, 2417, 2515,  525, 2515,
			  429, 2515, 2515,  529,  532,  536,  552,  555,  558,  561,
			  564,  582,  585,  588,  591,  594, 2454, 2515, 2515,  650,
			   98,  611, 2515, 2515,  159, 2421, 2515, 2515,  178, 2515,
			 2515,  184,  295, 2403,  616, 2393, 2515,  619,  622,  698,

			  791, 2515,  887,   88, 2392, 2397, 2342,  980,  326,  327,
			  378,  308, 2304, 2301,  348, 2300,  626, 2278, 2322,  307,
			 2515,  638, 1064, 1157, 2316, 1249, 2314, 2515,  641, 2515,
			  662, 2515,  670, 2303,  716, 2515,  725, 2515,  719,  736,
			  747,  809,  802,  753,  274,  377,    0,  807, 2515, 2515,
			  829,  839,  857, 2515,  998, 2515, 1001, 1010, 1018, 2515,
			 2302, 2515, 2515, 1297,    0,  361,  322,  420,  376,  368,
			  394,  447,  457,  405,  459,  437,  994,    0,  525,  641,
			  527,  322,  549, 2270,    0, 2254, 1007,    0, 2257,  602,
			  551,  557,  623,  774,    0,  586,  642, 1043,  792, 2199, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  632,  660,  680, 2116, 1030,  693,  330,  695,  729, 1095,
			 2515, 1100, 2515, 1118, 2515, 1121, 2515, 1124, 2515, 1127,
			 2515, 1130, 2515, 1175, 2515, 1178, 1186, 2515, 1194, 1197,
			 2515, 1203, 2515, 2144, 2515, 2138, 2515, 1206, 2515, 1223,
			 2146, 2515, 1045, 2515, 2515, 2515, 2515, 2515,  444, 2515,
			 2515, 2515, 2515, 2515, 2515, 2515, 2515, 2515, 2515, 2515,
			 2515, 2515, 2515, 2515, 2515,  400, 2515, 2515, 1229,  401,
			 2515, 2144, 2515, 1029, 2515, 1166, 2138, 2515, 1261, 2515,
			 2127, 2515, 2136, 2121, 2515, 1390, 1486, 1226, 1269, 2078,
			 2515, 2515, 2515, 2515,  565, 2515,  632, 2515,  748,  700,

			 2035,  728,  512,  788, 1315, 2515, 2054,  766, 2515, 1318,
			 2515, 1583, 1326, 1679, 2515, 2515, 2028, 2026, 2019, 1897,
			 1893, 1311, 1881, 1880, 1844, 1826, 1824, 1810, 1752, 1739,
			 1689, 1684, 1667, 1478, 1438, 1353, 1345, 1342, 2515, 2515,
			 1334, 1345, 1324, 2515, 1358, 2515, 1411, 2515, 1419, 2515,
			 1418, 1409, 1570,  589, 1252, 1349, 1242, 1576, 1423, 2515,
			 1452, 1456, 1599, 1602, 2515, 1605, 2515, 1609, 2515, 1625,
			 1630, 1249,  532,  784,    0,    0,  598, 1221,  825,  791,
			  792,  960,  981, 1006,  961,  976, 1028,    0, 1009, 1044,
			 1043, 1039, 1063,  467,  793, 1070, 1073, 1240, 1128, 1167, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1173, 1224, 1189, 1222,    0, 1222, 1196, 1136, 1241, 1241,
			 1275, 1309, 1215, 1584, 1231, 1339, 1370, 1367,  693,  535,
			 1368,  815, 1390, 1303,  730, 1014, 1555,  944,    0, 2515,
			 1636, 2515, 1642, 2515, 1648, 2515, 1665, 1670,    0, 1166,
			 2515, 1215, 1210, 2515, 1772, 1196, 1660, 1653, 2515, 2515,
			 2515, 2515,  844, 1030, 1160, 1632, 2515, 1152, 2515, 2515,
			 2515, 2515, 1649, 2515, 2515, 2515, 2515, 2515, 1695, 1682,
			 2515, 2515, 2515, 2515, 2515, 2515, 2515, 2515, 2515, 2515,
			 2515, 2515, 2515, 2515, 2515, 2515, 1686, 1441, 1445, 1772,
			 1788, 1702, 1792, 1805, 1691, 1087,    0, 1082, 1076, 1820,

			 1826, 1814, 2515, 1074, 1046, 1337, 1324, 1361, 1561, 1034,
			 1715, 1103, 1020, 1566, 1716, 1644, 1722,  999, 1707, 1741,
			 1124, 1710,  945, 1714, 1748, 1762, 1768,    0, 1769, 1220,
			  939, 1776, 1785, 1803,    0, 1094,    0,    0, 1151, 1868,
			    0, 1584, 1816, 1837, 1827,  842, 1674, 1825, 1356,  816,
			 1845, 1832,    0,  809,    0,    0, 1844, 1846, 1832, 1553,
			 1853,    0,    0, 2515, 1125, 1868,    0, 1874,  732,  793,
			 1836, 2515, 1715, 2515, 1572, 2515,  782, 1371, 1878,    0,
			 1897, 1901, 1905, 1909, 1917, 1928, 1934, 1941, 2515, 1858,
			    0,    0, 1305, 1865, 1881,    0,    0, 1867, 1907, 1375, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0, 1905, 1922, 1907, 1930, 1932, 1917, 1398,    0, 1925,
			 1576, 1936, 1939, 1941, 1939, 1942,    0, 1947, 1983, 2515,
			  764, 1952, 1936, 1949, 1955, 1957, 1946, 1960, 1955,    0,
			 1956, 1965,    0,    0, 1968, 1973,    0, 1689, 1997, 2014,
			  674,  672, 1975, 1986, 1974, 2515, 2022,  990, 2026, 1599,
			 2044, 2056, 2034, 2068, 2072, 2087, 2093,    0,    0, 1994,
			 1974, 1976,    0,  669, 2009, 2015, 2037,    0,    0, 2039,
			    0, 2049, 2051,    0, 2021, 1729, 2022, 2047, 2068, 2067,
			 2515,  708, 2077, 2071, 2077, 2078,    0, 2089,    0,    0,
			    0, 2075, 2082,    0, 2077, 2515, 2109, 2515, 2112, 2515,

			  635,  604, 2101, 2088, 2104,  635,  612,  605,  509,  541,
			  511,  502,  445,  465, 2144, 2154, 2158, 2167, 2177, 2181,
			 2185, 2189, 2198, 2106, 2107,    0, 2097,    0, 2125, 2153,
			 2161, 2172,    0,    0,  421,    0,    0, 2114, 2161, 2220,
			  406, 2191, 2196,    0, 2195, 2196,    0,    0, 2188,  418,
			  388, 2515, 2515, 2515, 2515, 2198, 2214, 2218, 2224, 2229,
			 2234, 2251, 2255, 2259,    0, 2229,    0,    0, 2228,    0,
			    0,    0, 2217,    0, 2284, 2241, 2236,    0, 2254,    0,
			    0,  349, 2515, 2515, 2255, 2282, 2286,    0, 2256,    0,
			 2253, 2263,    0,    0, 2515,    0, 2266, 2243, 2262, 2264, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2265,    0, 2515, 2515, 2348, 2358, 2368, 2378, 2388, 2328,
			 2398, 2407, 2331, 2334, 2417, 2427, 2437, 2447, 2457, 2465,
			 2474,  320,  284, 2484,  175,  160,  102, 2494, 2504, yy_Dummy>>,
			1, 29, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 828)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (813, 164, 208)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (803, 314, 339)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (813, 371, 428)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (803, 463, 493)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (813, 506, 562)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (813, 589, 617)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (803, 804, 828)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  803,    1,  804,  804,  805,  805,  806,  806,  807,
			  807,  808,  808,  803,  803,  803,  803,  809,  803,  810,
			  803,  811,  803,  803,  809,  809,  803,  812,  803,  809,
			  803,  803,  803,  803,  809,  809,  809,  803,  810,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  803,  809,  803,
			  809,  803,  803,  809,  809,  809,  809,  809,  809,  809,
			  809,  809,  803,  803,  809,  809,  814,  803,  803,  803,
			  815,  815,  803,  803,  816,  817,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  803,  809,  812,   18,

			   99,  803,  803,  818,   99,  100,  100,   18,  100,  100,
			  100,   99,   99,   99,   99,   99,   99,  100,  100,   99,
			  803,   38,  810,  819,  820,  820,  820,  803,  812,  803,
			  812,  803,  809,  803,  809,  803,  803,  803,  812,  809,
			  809,  809,  803,  803,  821,  821,  822,  803,  803,  803,
			  812,  809,  809,  803,  812,  803,  812,  809,  809,  803,
			  803,  803,  803,  819, yy_Dummy>>,
			1, 164, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  809,  803,  812,  803,  812,  803,  812,  803,  812,  803,
			  812,  803,  812,  803,  812,  803,  812,  809,  803,  812,
			  809,  803,  812,  803,  803,  803,  803,  803,  812,  803,
			  812,  814,  803,  803,  803,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  815,  803,  803,  815,
			  816,  803,  817,  803,  803,  803,  803,  823,  803,  812,
			  803,  100,  803,  107,  102,  803,  102,  803,  285,  818,
			   99,  803,  803,  803,  803,  100,  803,  100,  803,  100,
			   99,   99,   99,   99,   99,   99,  803,   99,  100,  803,

			  163,  803,  819,   38,  810, yy_Dummy>>,
			1, 105, 209)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  812,  803,  803,  803,  812,  803,  812,  803,  812,  803,
			  803,  803,  803,  821,  821,  821,  822,  803,  803,  803,
			  809,  812,  809,  809,  803,  812,  803,  812,  803,  812,
			  809, yy_Dummy>>,
			1, 31, 340)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  803,  812,  803,  812,  803,  812,  803,  803,  803,  823,
			  823,  803,  107,  286,  803,  286,  285,  285,  818,  803,
			  803,  803,  803,   99,   99,   99,   99,  803,   99,  803,
			  803,  803,  803,  819, yy_Dummy>>,
			1, 34, 429)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  821,  821,  355,  822,  803,  803,  803,  812,  803,  803,
			  151,  151, yy_Dummy>>,
			1, 12, 494)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  803,  803,  803,  824,  803,  823,  444,   99,  803,   99,
			  803,   99,  803,  803,  825,  825,  826,  803,  803,  803,
			  803,  803,  803,  803,  803,  803, yy_Dummy>>,
			1, 26, 563)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  803,  803,  803,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  803,  803,  824,  823,   99,   99,   99,  803,  825,  825,
			  825,  826,  803,  803,  803,  803,  803,  803,  803,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  803,  827,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  803,  803,  803,
			  803,  803,  824,  823,   99,   99,   99,  803,  646,  803,
			  825,  803,  648,  803,  826,  803,  803,  803,  803,  803,

			  803,  803,  803,  803,  803,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  813,  813,  813,  828,
			   99,   99,   99,  803,  803,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  813,  813,  813,  813,
			  813,  813,  813,  813,  813,  813,  803,  813,  813,  813,
			  813,  813,  813,   99,  803,  803,  803,  803,  803,  813,
			  813,  813,  803,  813,  813,  813,  803,  813,  803,  813,
			  803,  813,  803,  813,  803,    0, yy_Dummy>>,
			1, 186, 618)
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
			    7,    7,    7,    7,    7,    7,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    5,    3,    5,    3,
			    9,    3,    7,    7,    7,    7,    7,    7,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    5,    5,
			    3,    3,    5,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,   10,   10,    3,    3,   10, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 804)
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
			    5,    5,    5,    5,    6,    8,   11,   13,   17,   20,
			   26,   29,   32,   35,   38,   43,   48,   51,   54,   57,
			   62,   65,   68,   71,   74,   79,   84,   89,   92,   99,
			  102,  105,  108,  111,  114,  117,  120,  123,  126,  129,
			  132,  135,  138,  141,  144,  147,  150,  153,  156,  160,
			  163,  168,  171,  174,  179,  184,  189,  194,  199,  204,
			  209,  214,  219,  222,  225,  230,  235,  237,  239,  241,
			  243,  245,  247,  249,  251,  253,  255,  257,  259,  261,
			  263,  265,  268,  270,  272,  273,  273,  274,  276,  276,

			  277,  278,  279,  280,  280,  281,  282,  283,  284,  285,
			  286,  287,  288,  289,  290,  291,  292,  294,  295,  296,
			  298,  300,  304,  306,  306,  307,  308,  309,  311,  311,
			  313,  313,  314,  316,  317,  320,  321,  322,  324,  324,
			  327,  330,  333,  334,  335,  335,  335,  335,  335,  336,
			  338,  338,  341,  344,  346,  346,  348,  348,  351,  354,
			  355,  355,  356,  359,  359,  360,  361,  362,  363,  364,
			  366,  367,  368,  369,  370,  371,  372,  373,  375,  376,
			  377,  378,  379,  380,  381,  383,  384,  385,  387,  388,
			  389,  390,  391,  392,  393,  395,  396,  397,  398,  399, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  400,  401,  402,  403,  404,  405,  406,  407,  408,  409,
			  412,  414,  414,  416,  416,  418,  418,  420,  420,  422,
			  422,  424,  424,  426,  426,  428,  428,  431,  433,  433,
			  436,  438,  438,  439,  439,  440,  440,  442,  442,  444,
			  444,  445,  446,  446,  447,  448,  449,  450,  451,  451,
			  452,  453,  454,  455,  456,  457,  458,  459,  460,  461,
			  462,  463,  464,  465,  466,  467,  468,  469,  470,  471,
			  472,  474,  475,  476,  476,  477,  478,  479,  480,  481,
			  482,  483,  485,  486,  487,  490,  491,  492,  494,  495,
			  496,  499,  502,  504,  507,  508,  511,  512,  515,  516,

			  517,  518,  519,  520,  521,  522,  523,  524,  525,  528,
			  530,  531,  532,  536,  538,  539,  541,  542,  543,  544,
			  545,  546,  547,  548,  549,  550,  551,  552,  553,  554,
			  555,  556,  557,  558,  559,  560,  561,  562,  563,  565,
			  567,  567,  568,  568,  570,  571,  573,  574,  576,  577,
			  578,  579,  579,  580,  582,  583,  585,  586,  587,  587,
			  589,  592,  594,  596,  598,  600,  601,  603,  604,  606,
			  607,  609,  610,  611,  612,  614,  616,  617,  618,  619,
			  620,  621,  622,  623,  624,  625,  626,  627,  629,  630,
			  631,  632,  633,  634,  635,  636,  637,  638,  639,  640, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  641,  642,  643,  645,  646,  648,  649,  650,  651,  652,
			  653,  654,  655,  656,  657,  658,  659,  660,  661,  662,
			  663,  664,  665,  666,  667,  668,  669,  670,  671,  673,
			  675,  676,  678,  679,  681,  682,  683,  683,  683,  684,
			  685,  686,  687,  688,  690,  691,  692,  694,  694,  696,
			  699,  702,  705,  706,  707,  708,  709,  711,  712,  714,
			  717,  719,  720,  720,  721,  722,  723,  724,  725,  726,
			  727,  728,  729,  730,  731,  732,  733,  734,  735,  736,
			  737,  738,  739,  740,  741,  742,  743,  744,  744,  745,
			  746,  746,  746,  747,  748,  748,  748,  748,  748,  748,

			  749,  750,  751,  753,  755,  758,  761,  762,  763,  764,
			  765,  766,  767,  768,  769,  770,  771,  772,  773,  774,
			  775,  777,  778,  779,  780,  781,  782,  783,  785,  786,
			  787,  788,  789,  790,  791,  793,  794,  796,  798,  799,
			  801,  803,  804,  805,  806,  807,  808,  809,  810,  811,
			  812,  813,  814,  816,  817,  819,  821,  822,  823,  824,
			  825,  826,  828,  830,  831,  831,  831,  831,  831,  832,
			  833,  834,  836,  837,  839,  840,  842,  843,  843,  843,
			  843,  843,  844,  844,  845,  845,  846,  847,  848,  849,
			  850,  852,  854,  855,  856,  857,  859,  861,  862,  863, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  864,  866,  867,  868,  869,  870,  871,  872,  873,  875,
			  876,  877,  878,  879,  880,  881,  882,  884,  885,  885,
			  886,  886,  887,  888,  889,  890,  891,  892,  893,  894,
			  896,  897,  898,  900,  902,  903,  904,  906,  907,  907,
			  907,  907,  908,  909,  910,  911,  912,  912,  912,  912,
			  912,  912,  912,  913,  914,  914,  914,  915,  917,  919,
			  920,  921,  922,  924,  925,  926,  927,  928,  930,  932,
			  933,  935,  936,  937,  939,  940,  941,  942,  943,  944,
			  945,  946,  946,  947,  948,  949,  950,  952,  953,  955,
			  957,  959,  960,  961,  963,  964,  965,  965,  966,  966,

			  967,  967,  968,  969,  970,  971,  971,  971,  971,  971,
			  971,  971,  971,  971,  971,  971,  972,  973,  973,  973,
			  974,  974,  975,  975,  976,  977,  979,  980,  982,  983,
			  984,  985,  986,  988,  990,  991,  993,  995,  996,  997,
			  998,  999, 1000, 1001, 1003, 1004, 1005, 1007, 1009, 1010,
			 1011, 1012, 1014, 1015, 1017, 1018, 1019, 1019, 1020, 1020,
			 1021, 1022, 1022, 1022, 1023, 1025, 1026, 1028, 1030, 1031,
			 1033, 1035, 1037, 1038, 1040, 1040, 1041, 1042, 1044, 1045,
			 1047, 1049, 1050, 1052, 1054, 1055, 1055, 1056, 1058, 1059,
			 1061, 1061, 1062, 1064, 1066, 1068, 1070, 1070, 1071, 1071, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1072, 1072, 1074, 1075, 1075, yy_Dummy>>,
			1, 5, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1074)
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
			    0,  232,  232,  234,  234,  268,  266,  267,    1,  266,
			  267,    1,  267,   86,  266,  267, -355,  235,  266,  267,
			   86,   89,  266,  267, -355, -358,   16,  266,  267,  200,
			  266,  267,   34,  266,  267,   35,  266,  267,   44,   86,
			  266,  267, -355,   40,   86,  266,  267, -355,    9,  266,
			  267,   42,  266,  267,   15,  266,  267,   46,   86,  266,
			  267, -355,  165,  266,  267,  165,  266,  267,    8,  266,
			  267,    7,  266,  267,   22,   86,  266,  267, -355,   20,
			   86,  266,  267, -355,   24,   86,  266,  267, -355,   11,
			  266,  267,   17,   86,   89,  266,  267, -355, -358,  164,

			  266,  267,  164,  266,  267,  164,  266,  267,  164,  266,
			  267,  164,  266,  267,  164,  266,  267,  164,  266,  267,
			  164,  266,  267,  164,  266,  267,  164,  266,  267,  164,
			  266,  267,  164,  266,  267,  164,  266,  267,  164,  266,
			  267,  164,  266,  267,  164,  266,  267,  164,  266,  267,
			  164,  266,  267,   38,  266,  267,   86,  266,  267, -355,
			   39,  266,  267,   48,   86,  266,  267, -355,   36,  266,
			  267,   37,  266,  267,   13,   86,  266,  267, -355,   62,
			   86,  266,  267, -355,   72,   86,  266,  267, -355,   82,
			   86,  266,  267, -355,   58,   86,  266,  267, -355,   60, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   86,  266,  267, -355,   74,   86,  266,  267, -355,   78,
			   86,  266,  267, -355,   84,   86,  266,  267, -355,   68,
			  266,  267,   70,  266,  267,   66,   86,  266,  267, -355,
			   64,   86,  266,  267, -355,  236,  267,  265,  267,  263,
			  267,  264,  267,  232,  267,  232,  267,  231,  267,  230,
			  267,  232,  267,  234,  267,  233,  267,  228,  267,  228,
			  267,  227,  267,    6,  267,    5,    6,  267,    5,  267,
			    6,  267,    1,  -88,   86, -355,  235,  235,  224,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235, -493,  235,  235,  235, -493,  -88,  -91,

			   86,   89, -355, -358,   89, -358,  200,  200,  200,   45,
			  -88,   41,  -88,   43,   86, -355,    2,   50,   86, -355,
			   10,  171,   47,  -88,   54,   86, -355,   32,   86, -355,
			   30,   86, -355,  171,  165,   18,   23,  -88,   52,   86,
			 -355,   26,   86, -355,   21,  -88,   25,  -88,   28,   86,
			 -355,   53,   86, -355,   12,   19,   17,  -88,  -91,  164,
			  164,  164,  164,  164,   97,  164,  164,  164,  164,  164,
			  164,  164,  164,  110,  164,  164,  164,  164,  164,  164,
			  164,  122,  164,  164,  164,  128,  164,  164,  164,  164,
			  164,  164,  164,  140,  164,  164,  164,  164,  164,  164, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  164,  164,  164,  164,  164,  164,  164,  164,  164,   56,
			   86, -355,   49,  -88,   14,  -88,   63,  -88,   73,  -88,
			   83,  -88,   59,  -88,   61,  -88,   75,  -88,   76,   86,
			 -355,   79,  -88,   80,   86, -355,   85,  -88,   69,   71,
			   67,  -88,   65,  -88,  236,  263,  253,  251,  252,  254,
			  255,  256,  257,  237,  238,  239,  240,  241,  242,  243,
			  244,  245,  246,  247,  248,  249,  250,  232,  231,  230,
			  232,  232,  229,  230,  234,  233,  227,    5,    4,    2,
			   86,  225,  235,  222,  225,  235,  235,  222,  223,  225,
			  235,  235,  235, -493, -493,  235,  208,  222,  225,  206,

			  222,  225,  207,  225,  209,  222,  225,  235,  202,  222,
			  225,  235,  203,  222,  225,  235,  235,  235,  235,  235,
			  235,  235, -226,  235,  235,  210,  222,  225,   86,   89,
			  -91,   89,   86,   89, -355, -358,   89, -358,  200,  172,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  173,  200,   51,  -88,  171,   55,  -88,
			   86,   33,  -88,   86,   31,  -88,   86,  166,  171,  165,
			  169,  170,  170,  168,  170,  167,  165,   52,  -88,   52,
			   86, -355,   52,   86,   86, -355,   86, -355,   27,  -88, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   86,   29,  -88,   86,   53,  -88,   86,   86, -355,  164,
			  164,  164,   95,  164,   96,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  113,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  132,  164,  164,  135,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  163,  164,   57,  -88,   86,   77,  -88,   86,   81,
			  -88,   86,  262,    4,    4,   87,  235,  235,  223,  225,
			  235,  235,  235, -493,  214,  225,  211,  222,  225,  204,

			  222,  225,  205,  222,  225,  235,  235,  235,  235,  219,
			  225,  235,  213,  225,  212,  222,  225,   87,   90,   90,
			  190,  188,  189,  191,  192,  201,  201,  193,  194,  174,
			  175,  176,  177,  178,  179,  180,  181,  182,  183,  184,
			  185,  186,  187,  171,  171,  171,  171,  165,  165,  165,
			   86,   52,   87,   52,  -88,   52,   86, -355,   52,   86,
			 -355,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  111,  164,  164,  164,  164,
			  164,  164,  164,  120,  164,  164,  164,  164,  164,  164,
			  164,  129,  164,  164,  131,  164,  133,  164,  164,  138, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  164,  139,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  152,  164,  164,  154,  164,  155,
			  164,  164,  164,  164,  164,  164,  161,  164,  162,  164,
			  258,    4,  235,  235,  215,  225,  235,  218,  225,  235,
			  221,  225,  201,  171,  171,  171,  171,  165,   52,  164,
			   93,  164,   94,  164,  164,  164,  164,  101,  164,  102,
			  164,  164,  164,  164,  107,  164,  164,  164,  164,  164,
			  164,  164,  164,  118,  164,  164,  164,  164,  164,  164,
			  164,  164,  130,  164,  164,  136,  164,  164,  164,  164,
			  164,  164,  164,  164,  149,  164,  164,  164,  153,  164,

			  156,  164,  164,  164,  159,  164,  164,    4,  235,  235,
			  235,  195,  171,  171,  171,   92,  164,   98,  164,  164,
			  164,  164,  104,  164,  164,  164,  164,  164,  112,  164,
			  114,  164,  164,  116,  164,  164,  164,  121,  164,  164,
			  164,  164,  164,  164,  164,  137,  164,  164,  164,  164,
			  145,  164,  164,  147,  164,  148,  164,  150,  164,  164,
			  164,  158,  164,  164,  261,  260,  259,    4,  235,  235,
			  235,  171,  171,  171,  171,  164,  164,  103,  164,  164,
			  106,  164,  164,  164,  164,  164,  119,  164,  123,  164,
			  164,  125,  164,  126,  164,  164,  164,  164,  164,  164, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  164,  146,  164,  164,  164,  160,  164,    3,    4,  235,
			  235,  235,  198,  199,  199,  197,  199,  196,  171,  171,
			  171,  171,  171,   99,  164,  164,  105,  164,  108,  164,
			  164,  115,  164,  117,  164,  124,  164,  164,  134,  164,
			  164,  164,  143,  164,  164,  151,  164,  157,  164,  235,
			  217,  225,  220,  225,  171,  171,  100,  164,  164,  127,
			  164,  164,  142,  164,  144,  164,  216,  225,  109,  164,
			  164,  164,  141,  164,  141, yy_Dummy>>,
			1, 75, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2515
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 803
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 804
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

	yyNb_rules: INTEGER = 267
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 268
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
