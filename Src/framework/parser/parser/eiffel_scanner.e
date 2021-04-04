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
			
when 90 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
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
			create an_array.make_filled (0, 0, 2414)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			an_array.area.fill_with (287, 917, 942)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			an_array.area.fill_with (831, 2318, 2414)
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

			  263,   78,   78,  264,   79,   79,   81,   82,   81,  677,
			   83,   81,   82,   81,  201,   83,   88,   89,   88,   88,
			   89,   88,   91,   92,   91,   91,   92,   91,   94,   94,
			   94,   94,   94,   94,   96,   96,   96,   93,  173,  124,
			   93,  125,  201,   95,  292,  192,   95,  185,  174,   98,
			  126,  126,  126,  186,  128,  128,  128,  130,  130,  130,
			  204,  263,  193,   84,  267,  127,  292,  675,   84,  129,
			  173,  134,  132,  135,  135,  135,  135,  192,  185,  270,
			  271,  270,  668,  133,   84,  272,  272,  272,  193,   84,
			   99,  204,   99,  100,  101,  102,   99,  103,  102,   99, yy_Dummy>>,
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
			  100,  100,   99,   99,  100,  100,   99,   96,   96,   96,
			  120,  361,  120,  358,  358,  120,  272,  272,  272,  120,

			  120,  194,  122,  120,  120,  136,  136,  136,  308,  309,
			  308,  120,  120,  120,  141,  120,  142,  142,  142,  142,
			  137,  141,  138,  142,  142,  142,  142,  359,  143,  144,
			  139,  297,  299,  194,  148,  148,  148,  152,  152,  152,
			  158,  158,  158,  120,  298,  120,  120,  120,  202,  149,
			  145,  303,  153,  300,  822,  159,  380,  146,  150,  151,
			  143,  144,  203,  399,  146,  160,  120,  120,  434,  120,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,  303,
			  202,   97,   97,  301,  140,  154,  154,  154,  380,  175,
			  178,  176,  399,  811,  179,  306,  360,  360,  360,  434, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  155,  177,  263,  263,  302,  264,  267,  180,  379,  383,
			  156,  157,   96,   96,   96,  120,  384,  120,  175,  176,
			  120,  306,  178,  810,  120,  120,  179,  122,  120,  120,
			  207,  207,  207,  180,  379,  162,  120,  120,  120,  163,
			  120,  383,  384,  385,  164,  208,  165,  181,  388,  168,
			  804,  166,  167,  169,  182,  183,  170,  799,  381,  171,
			  184,  382,  172,  456,  457,  457,  457,  162,  120,  385,
			  120,  120,  120,  164,  165,  673,  388,  166,  167,  181,
			  168,  386,  169,  183,  390,  171,  184,  387,  172,  381,
			  382,  120,  120,  389,  120,   97,   97,   97,   97,   97,

			   97,   97,   97,   97,  188,  740,   97,   97,  195,  552,
			  390,  198,  782,  386,  189,  474,  190,  475,  196,  387,
			  191,  199,  553,  197,  200,  389,   96,   96,   96,  831,
			  209,  209,  209,  211,  211,  211,  188,  213,  213,  213,
			  195,   98,  198,  189,  190,  210,  191,  199,  212,  197,
			  200,  781,  214,  215,  215,  215,  217,  217,  217,  219,
			  219,  219,  221,  221,  221,  224,  224,  224,  216,  736,
			  468,  218,  397,  394,  220,  532,  398,  222,  534,  400,
			  225,  463,  206,  227,  227,  227,  229,  229,  229,  231,
			  231,  231,  233,  233,  233,  235,  235,  235,  228,  394, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  410,  230,  398,  532,  232,  411,  780,  234,  415,  534,
			  236,  400,  265,  263,  265,  578,  264,   94,   94,   94,
			  275,  275,  275,  275,  275,  275,  410,  308,  309,  308,
			  426,  411,   95,  428,  415,  276,  831,  469,  313,   96,
			   96,   96,  343,  343,  343,  779,  578,  223,  463,  775,
			  226,  239,  239,  239,   98,  240,  426,  344,  241,  428,
			  242,  243,  244,  345,  345,  345,  345,  579,  245,  266,
			  728,  348,  348,  348,  395,  246,  408,  247,  346,  646,
			  248,  249,  250,  251,  310,  252,  349,  253,  409,  396,
			  266,  254,  754,  255,  412,  579,  256,  257,  258,  259,

			  260,  261,   99,  279,   99,  416,  395,   99,  408,   99,
			  346,   99,   99,  729,   99,  396,   99,  350,  350,  350,
			  352,  352,  352,   99,   99,   99,  412,   99,   99,  370,
			  370,  370,  351,  427,  435,  353,   99,  416,  831,  831,
			  831,   99,   99,  471,  371,  423,  239,  239,  239,  424,
			  433,   99,  709,  455,  119,   99,  436,   99,   99,  141,
			   99,  357,  357,  357,  357,  427,  435,   99,  673,   99,
			  362,  362,  362,  362,  423,  471,  433,  473,   99,   99,
			  470,   99,  436,   99,   99,   99,   99,   99,   99,   99,
			   99,  463,  277,   99,   99,  280,  281,  280,  277,  478, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  280,  669,  146,  473,  280,  280,  660,  282,  280,  280,
			  463,  363,  270,  271,  270,  657,  283,  280,  284,  653,
			  280,  831,  831,  831,  831,  831,  831,  831,  831,  831,
			  476,  587,  831,  831,  584,  533,  354,  537,  355,  355,
			  355,  355,  365,  365,  365,  374,  374,  374,  280,  640,
			  280,  280,  280,  356,  628,  366,  476,  367,  538,  587,
			  375,  272,  272,  272,  623,  584,  368,  533,  369,  537,
			  620,  280,  280,   97,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  538,  356,  280,  280,   99,  616,
			   99,  285,  286,  285,  287,  103,  285,  287,  287,  287,

			  285,  285,  287,  288,  285,  285,  287,  287,  287,  287,
			  287,  287,  289,  285,  290,  287,  285, yy_Dummy>>,
			1, 117, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  291,  285,  287,  285,  285,  285,  287,  287,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  287,
			  287,  287,  291,  287,  285,  285,  287,  285,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,   99,   99,  280,
			  280,   99,  296,  100,  358,  358,  100,  597,   99,  598,
			  100,  100,  539,   99,  100,  100,  376,  376,  376,  391,
			  540,  354,  100,  392,  100,  727,  100,   99,  519,  403,
			  517,  377,  479,  404,  602,   99,  541,  393,  539,  413,
			   99,   99,  378,  542,  405,  516,  546,  406,  414,  550,
			   99,  391,  540,  119,  100,  392,  100,  535,  100,   99,

			  430,  403,  541,  393,  404,  431,   99,  728,   99,  542,
			  405,  413,  546,  406,  536,  550,  432,  414,  437,  437,
			  437,  100,  831,  831,  831,  314,  585,  314,  543,  535,
			  314,  544,  430,  438,  314,  314,  431,  315,  314,  314,
			  536,  554,  432,  447,  447,  447,  314,  314,  314,  600,
			  314,  417,  545,  418,  450,  450,  450,  585,  448,  549,
			  543,  419,  286,  544,  420,  281,  421,  422,  461,  451,
			  554,  265,  263,  265,  596,  264,  565,  551,  314,  563,
			  314,  314,  314,  417,  545,  418,  308,  309,  308,  419,
			  420,  549,  421,  422,  308,  309,  308,  486,  487,  487, yy_Dummy>>,
			1, 200, 943)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  487,  314,  314,  551,  314,  277,  277,  277,  277,  277,
			  277,  277,  277,  277,  666,  666,  277,  277,  318,  674,
			  674,  319,  561,  320,  321,  322,  555,  557,  266,  531,
			  519,  323,  460,  460,  460,  667,  667,  667,  324,  556,
			  325,  547,  558,  326,  327,  328,  329,  461,  330,  266,
			  331,  275,  275,  275,  332,  548,  333,  566,  555,  334,
			  335,  336,  337,  338,  339,  571,  462,  287,  465,  287,
			  581,  556,  287,  547,  558,  517,  287,  287,  559,  287,
			  287,  287,  504,  566,  466,  309,  466,  503,  287,  287,
			  287,  571,  287,  460,  460,  460,  275,  275,  275,  581,

			  360,  360,  360,  831,  831,  831,  560,  506,  479,  506,
			  559,  480,  507,  507,  507,  507,  505,  505,  505,  505,
			  287,  502,  287,  287,  287,  460,  460,  460,  513,  633,
			  513,  346,  562,  514,  514,  514,  514,  599,  560,  292,
			  508,  518,  574,  287,  287,  564,  287,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,  686,  633,   99,   99,
			  102,  292,  102,  346,  562,  102,  599,  644,  574,  102,
			  102,  501,  500,  102,  102,  499,  583,  564,  567,  568,
			  569,  102,  102,  102,  686,  102,  831,  831,  831,  831,
			  831,  831,  831,  831,  831,  570,  644,  831,  831,  460, yy_Dummy>>,
			1, 200, 1143)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  460,  460,  583,  460,  460,  460,  511,  511,  511,  511,
			  567,  568,  569,  102,  509,  102,  102,  102,  510,  622,
			  141,  512,  515,  515,  515,  515,  520,  570,  521,  521,
			  521,  521,  522,  522,  522,  522,  102,  102,  498,  102,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  497,
			  622,  100,  100,  512,  735,  365,  365,  365,  496,  524,
			  524,  524,  575,  146,  275,  275,  275,  576,  572,  363,
			  523,  739,  495,  363,  525,  275,  275,  275,  577,  276,
			  460,  460,  460,  460,  460,  460,  573,  580,  526,  582,
			  276,  460,  460,  460,  575,  528,  736,  586,  529,  576,

			  572,  527,  275,  275,  275,  494,  530,  460,  460,  460,
			  577,  493,  573,  740,  466,  309,  466,  276,  601,  580,
			  645,  582,  588,  460,  460,  460,  358,  358,  157,  586,
			  460,  460,  460,  591,  457,  457,  457,  457,  589,  591,
			  457,  457,  457,  457,  621,  590,  592,  593,  617,  645,
			  601,  831,  831,  831,  618,  492,  491,  603,  487,  487,
			  487,  487,  603,  487,  487,  487,  487,  516,  594,  292,
			  604,  605,  619,  692,  617,  595,  621,  490,  592,  593,
			  618,  595,  608,  608,  608,  608,  507,  507,  507,  507,
			  625,  292,  606,  507,  507,  507,  507,  346,  619,  607, yy_Dummy>>,
			1, 200, 1343)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  699,  692,  604,  605,  607,  610,  610,  610,  610,  611,
			   97,  611,  523,  489,  612,  612,  612,  612,  624,  631,
			  512,   97,  625,  609,  514,  514,  514,  514,  699,  346,
			  514,  514,  514,  514,  831,  831,  831,  831,  831,  831,
			  831,  831,  831,  627,  624,  831,  831,  626,  629,  630,
			  631,  613,  512,  515,  515,  515,  515,  520,  639,  614,
			  614,  614,  614,  520,  632,  522,  522,  522,  522,  460,
			  460,  460,  634,  626,  629,  627,  635,  636,  637,  638,
			  642,  630,  641,  649,  615,  654,  651,  643,  658,  639,
			  632,  650,  656,  652,  363,  646,  646,  646,  634,  647,

			  363,  655,  635,  659,  637,  661,  363,  662,  641,  636,
			  648,  638,  642,  643,  649,  663,  654,  650,  651,  652,
			  658,  656,  664,  665,  670,  671,  685,  655,  672,  659,
			  457,  457,  457,  457,  676,  676,  676,  661,  688,  662,
			  488,  663,  678,  678,  678,  678,  608,  608,  608,  608,
			  670,  664,  685,  485,  484,  665,  671,  672,  687,  483,
			  694,  679,  680,  680,  680,  680,  681,  681,  681,  681,
			  688,  595,  647,  612,  612,  612,  612,  612,  612,  612,
			  612,  512,  354,  607,  681,  681,  681,  681,  689,  687,
			  693,  694,  684,  679,  522,  522,  522,  522,  690,  683, yy_Dummy>>,
			1, 200, 1543)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  695,  698,  691,  700,  696,  697,  701,  682,  702,  482,
			  703,  704,  705,  512,  689,  706,  693,  707,  710,  711,
			  712,  713,  714,  716,  646,  646,  646,  698,  708,  700,
			  690,  683,  695,  691,  701,  146,  696,  697,  715,  648,
			  702,  703,  704,  717,  705,  711,  706,  718,  719,  707,
			  710,  712,  720,  713,  714,  716,  721,  722,  723,  666,
			  666,  730,  731,  732,  715,  725,  667,  667,  667,  717,
			  733,  674,  674,  718,  737,  676,  676,  676,  752,  481,
			  719,  751,  756,  720,  477,  722,  472,  762,  721,  732,
			  467,  464,  730,  464,  731,  741,  678,  678,  678,  678,

			  724,  708,  757,  742,  752,  742,  464,  726,  743,  743,
			  743,  743,  734,  751,  756,  762,  738,  744,  744,  744,
			  744,  681,  681,  681,  681,  747,  747,  747,  747,  753,
			  755,  758,  745,  748,  757,  748,  746,  607,  749,  749,
			  749,  749,  354,  759,  747,  747,  747,  747,  760,  765,
			  761,  763,  764,  766,  767,  753,  755,  769,  768,  750,
			  770,  771,  773,  758,  745,  776,  772,  778,  746,  774,
			  666,  666,  667,  667,  667,  759,  761,  763,  764,  766,
			  760,  765,  777,  767,  768,  769,  793,  792,  770,  795,
			  773,  750,  772,  771,  794,  774,  463,  776,  463,  778, yy_Dummy>>,
			1, 200, 1743)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  743,  743,  743,  743,  743,  743,  743,  743,  777,  279,
			  463,  724,  793,  726,  783,  783,  783,  783,  784,  792,
			  784,  795,  794,  785,  785,  785,  785,  796,  786,  745,
			  786,  797,  800,  787,  787,  787,  787,  788,  788,  788,
			  788,  749,  749,  749,  749,  749,  749,  749,  749,  790,
			  798,  790,  789,  801,  791,  791,  791,  791,  805,  796,
			  800,  745,  806,  797,  802,  802,  802,  807,  808,  809,
			  745,  785,  785,  785,  785,  785,  785,  785,  785,  798,
			  787,  787,  787,  787,  789,  801,  787,  787,  787,  787,
			  805,  817,  459,  269,  806,  803,  609,  809,  815,  807,

			  808,  238,  745,  812,  812,  812,  812,  813,  816,  813,
			  819,  821,  814,  814,  814,  814,  820,  817,  789,  791,
			  791,  791,  791,  791,  791,  791,  791,  803,  789,  823,
			  815,  802,  802,  802,  824,  825,  826,  816,  827,  819,
			  828,  454,  820,  821,  814,  814,  814,  814,  829,  830,
			  789,   97,   97,   97,  682,  814,  814,  814,  814,   97,
			  789,  823,  818,  824,  827,  453,  828,  825,  826,  161,
			  161,  161,  231,  229,  829,  830,   76,   76,   76,   76,
			   76,   76,   76,   76,   76,   76,  452,  449,  446,  445,
			  444,  443,  442,  441,  818,   80,   80,   80,   80,   80, yy_Dummy>>,
			1, 200, 1943)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   80,   80,   80,   80,   80,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,  121,  121,  121,  440,  121,
			  439,  121,  121,  121,  123,  429,  123,  123,  123,  123,
			  123,  123,  123,  123,  131,  131,  131,  237,  425,  237,
			  237,  237,  131,  237,  237,  237,  237,  262,  262,  262,
			  262,  262,  262,  262,  262,  262,  262,  266,  266,  266,
			  266,  266,  266,  266,  266,  266,  266,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,  103,  407,  103,

			  402,  103,  103,  103,  103,  103,  103,  316,  401,  316,
			  316,  316,  316,  316,  316,  316,  316,  458,  158,  458,
			  458,  458,  458,  458,  458,  458,  458,  709,  709,  709,
			  709,  709,  709,  709,  709,  709,  709,  775,  373,  775,
			  775,  775,  775,  775,  775,  775,  775,  372,  364,  347,
			  130,  342,  341,  340,  317,  312,  311,  307,  305,  304,
			  295,  294,  293,  278,  274,  273,  269,  238,  205,  187,
			  147,  831,   86,   86,   13, yy_Dummy>>,
			1, 175, 2143)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2414)
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
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			an_array.area.fill_with (831, 2317, 2414)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   80,    3,    4,   80,    3,    4,    5,    5,
			    5,  854,    5,    6,    6,    6,   53,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   17,   11,
			   42,   21,   12,   21,   53,   15,  103,   49,   16,   46,
			   42,   17,   24,   24,   24,   46,   25,   25,   25,   27,
			   27,   27,   55,   84,   49,    5,   84,   24,  103,  853,
			    6,   25,   42,   28,   27,   28,   28,   28,   28,   49,
			   46,   88,   88,   88,  852,   27,    5,   91,   91,   91,
			   49,    6,   18,   55, yy_Dummy>>,
			1, 94, 98)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   19,   19,   19,   19,  850,   19,  143,  143,   19,   92,
			   92,   92,   19,   19,   50,   19,   19,   19,   29,   29,
			   29,  119,  119,  119,   19,   19,   19,   30,   19,   30,
			   30,   30,   30,   29,   31,   29,   31,   31,   31,   31,
			  849,   30,   30,   29,  108,  109,   50,   34,   34,   34,
			   35,   35,   35,   37,   37,   37,   19,  108,   19,   19,
			   19,   54,   34,   30,  111,   35,  109,  809,   37,  163,
			   30,   34,   34,   30,   30,   54,  178,   31,   37,   19,
			   19,  203,   19,   19,   19,   19,   19,   19,   19,   19,
			   19,   19,  111,   54,   19,   19,  110,   29,   36,   36,

			   36,  163,   43,   44,   43,  178,  778,   44,  114,  144,
			  144,  144,  203,   36,   43,  262,  266,  110,  262,  266,
			   44,  162,  165,   36,   36,   38,   38,   38,   38,  166,
			   38,   43,   43,   38,  114,   44,  777,   38,   38,   44,
			   38,   38,   38,   60,   60,   60,   44,  162,   39,   38,
			   38,   38,   39,   38,  165,  166,  167,   39,   60,   39,
			   45,  170,   41,  768,   39,   39,   41,   45,   45,   41,
			  762,  164,   41,   45,  164,   41,  245,  245,  245,  245,
			   39,   38,  167,   38,   38,   38,   39,   39,  741,  170,
			   39,   39,   45,   41,  168,   41,   45,  172,   41,   45, yy_Dummy>>,
			1, 200, 287)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  169,   41,  164,  164,   38,   38,  171,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   38,   48,  740,   38,
			   38,   51,  401,  172,   52,  739,  168,   48,  306,   48,
			  306,   51,  169,   48,   52,  401,   51,   52,  171,   58,
			   58,   58,  738,   63,   63,   63,   64,   64,   64,   48,
			   65,   65,   65,   51,   58,   52,   48,   48,   63,   48,
			   52,   64,   51,   52,  737,   65,   66,   66,   66,   67,
			   67,   67,   68,   68,   68,   69,   69,   69,   70,   70,
			   70,   66,  736,  298,   67,  177,  175,   68,  380,  177,
			   69,  384,  179,   70,  298,   58,   71,   71,   71,   72,

			   72,   72,   73,   73,   73,   74,   74,   74,   75,   75,
			   75,   71,  175,  187,   72,  177,  380,   73,  188,  735,
			   74,  192,  384,   75,  179,   81,   81,   81,  426,   81,
			   94,   94,   94,   97,   97,   97,  120,  120,  120,  187,
			  116,  116,  116,  197,  188,   94,  199,  192,   97,  734,
			  300,  120,  131,  131,  131,  133,  133,  133,  733,  426,
			   69,  300,  729,   70,   79,   79,   79,  131,   79,  197,
			  133,   79,  199,   79,   79,   79,  135,  135,  135,  135,
			  427,   79,   81,  728,  138,  138,  138,  176,   79,  186,
			   79,  135,  709,   79,   79,   79,   79,  116,   79,  138, yy_Dummy>>,
			1, 200, 487)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   79,  186,  176,   81,   79,  691,   79,  189,  427,   79,
			   79,   79,   79,   79,   79,   99,   99,   99,  193,  176,
			   99,  186,   99,  135,   99,   99,  669,   99,  176,   99,
			  139,  139,  139,  140,  140,  140,   99,   99,   99,  189,
			   99,   99,  151,  151,  151,  139,  198,  204,  140,   99,
			  193,  121,  121,  121,   99,   99,  303,  151,  195,  239,
			  239,  239,  195,  202,   99,  648,  239,   99,   99,  205,
			   99,   99,  142,   99,  142,  142,  142,  142,  198,  204,
			   99,  603,   99,  146,  146,  146,  146,  195,  303,  202,
			  305,   99,   99,  302,   99,  205,   99,   99,   99,   99,

			   99,   99,   99,   99,  302,  846,   99,   99,  100,  100,
			  100,  846,  311,  100,  596,  142,  305,  100,  100,  578,
			  100,  100,  100,  311,  146,  270,  270,  270,  574,  100,
			  100,  100,  570,  100,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  307,  435,  121,  121,  432,  381,  141,
			  386,  141,  141,  141,  141,  150,  150,  150,  156,  156,
			  156,  100,  555,  100,  100,  100,  141,  542,  150,  307,
			  150,  387,  435,  156,  272,  272,  272,  537,  432,  150,
			  381,  150,  386,  534,  100,  100,  526,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  387,  141,  100, yy_Dummy>>,
			1, 200, 687)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  100,  102,  525, yy_Dummy>>,
			1, 3, 887)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  107,  107,  358,  358,  107,  471,  107,  471,  107,  107,
			  388,  107,  107,  107,  157,  157,  157,  173,  389,  520,
			  107,  173,  107,  668,  107,  107,  519,  183,  517,  157,
			  480,  183,  476,  107,  390,  173,  388,  190,  107,  107,
			  157,  391,  183,  358,  396,  183,  190,  399,  107,  173,
			  389,  107,  107,  173,  107,  385,  107,  107,  201,  183,
			  390,  173,  183,  201,  107,  668,  107,  391,  183,  190,
			  396,  183,  385,  399,  201,  190,  206,  206,  206,  107,
			  122,  122,  122,  122,  433,  122,  392,  385,  122,  393,
			  201,  206,  122,  122,  201,  122,  122,  122,  385,  402,

			  201,  223,  223,  223,  122,  122,  122,  473,  122,  194,
			  394,  194,  226,  226,  226,  433,  223,  398,  392,  194,
			  464,  393,  194,  463,  194,  194,  462,  226,  402,  265,
			  265,  265,  459,  265,  414,  400,  122,  411,  122,  122,
			  122,  194,  394,  194,  291,  291,  291,  194,  194,  398,
			  194,  194,  308,  308,  308,  323,  323,  323,  323,  122,
			  122,  400,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  592,  592,  122,  122,  124,  604,  604,  124,
			  409,  124,  124,  124,  403,  405,  265,  379,  361,  124,
			  276,  276,  276,  593,  593,  593,  124,  404,  124,  397, yy_Dummy>>,
			1, 200, 985)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  406,  124,  124,  124,  124,  276,  124,  265,  124,  277,
			  277,  277,  124,  397,  124,  415,  403,  124,  124,  124,
			  124,  124,  124,  420,  277,  287,  287,  287,  429,  404,
			  287,  397,  406,  359,  287,  287,  407,  287,  287,  287,
			  344,  415,  292,  292,  292,  339,  287,  287,  287,  420,
			  287,  313,  313,  313,  314,  314,  314,  429,  360,  360,
			  360,  315,  315,  315,  408,  346,  313,  346,  407,  314,
			  346,  346,  346,  346,  345,  345,  345,  345,  287,  338,
			  287,  287,  287,  349,  349,  349,  356,  547,  356,  345,
			  410,  356,  356,  356,  356,  472,  408,  292,  349,  360,

			  422,  287,  287,  413,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,  620,  547,  287,  287,  288,  292,
			  288,  345,  410,  288,  472,  560,  422,  288,  288,  337,
			  336,  288,  288,  335,  431,  413,  416,  417,  418,  288,
			  288,  288,  620,  288,  315,  315,  315,  315,  315,  315,
			  315,  315,  315,  419,  560,  315,  315,  351,  351,  351,
			  431,  353,  353,  353,  355,  355,  355,  355,  416,  417,
			  418,  288,  351,  288,  288,  288,  353,  536,  357,  355,
			  357,  357,  357,  357,  362,  419,  362,  362,  362,  362,
			  363,  363,  363,  363,  288,  288,  334,  288,  288,  288, yy_Dummy>>,
			1, 200, 1185)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  288,  288,  288,  288,  288,  288,  288,  333,  536,  288,
			  288,  355,  675,  366,  366,  366,  332,  367,  367,  367,
			  423,  357,  368,  368,  368,  424,  421,  362,  366,  677,
			  331,  363,  367,  369,  369,  369,  425,  368,  371,  371,
			  371,  375,  375,  375,  421,  428,  368,  430,  369,  377,
			  377,  377,  423,  371,  675,  434,  375,  424,  421,  369,
			  378,  378,  378,  330,  377,  438,  438,  438,  425,  329,
			  421,  677,  466,  466,  466,  378,  474,  428,  563,  430,
			  438,  448,  448,  448,  516,  516,  378,  434,  451,  451,
			  451,  456,  456,  456,  456,  456,  448,  457,  457,  457,

			  457,  457,  535,  451,  456,  456,  531,  563,  474,  479,
			  479,  479,  532,  328,  327,  486,  486,  486,  486,  486,
			  487,  487,  487,  487,  487,  516,  456,  466,  486,  486,
			  533,  627,  531,  456,  535,  326,  456,  456,  532,  457,
			  505,  505,  505,  505,  506,  506,  506,  506,  539,  466,
			  486,  507,  507,  507,  507,  505,  533,  486,  635,  627,
			  486,  486,  487,  511,  511,  511,  511,  512,  527,  512,
			  527,  325,  512,  512,  512,  512,  538,  545,  511,  527,
			  539,  505,  513,  513,  513,  513,  635,  505,  514,  514,
			  514,  514,  479,  479,  479,  479,  479,  479,  479,  479, yy_Dummy>>,
			1, 200, 1385)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  479,  541,  538,  479,  479,  540,  543,  544,  545,  515,
			  511,  515,  515,  515,  515,  521,  554,  521,  521,  521,
			  521,  522,  546,  522,  522,  522,  522,  523,  523,  523,
			  548,  540,  543,  541,  549,  550,  551,  553,  557,  544,
			  556,  566,  523,  571,  568,  558,  575,  554,  546,  567,
			  573,  569,  515,  564,  564,  564,  548,  564,  521,  572,
			  549,  576,  551,  581,  522,  582,  556,  550,  564,  553,
			  557,  558,  566,  583,  571,  567,  568,  569,  575,  573,
			  584,  585,  597,  599,  617,  572,  601,  576,  595,  595,
			  595,  595,  605,  605,  605,  581,  622,  582,  324,  583,

			  607,  607,  607,  607,  608,  608,  608,  608,  597,  584,
			  617,  322,  321,  585,  599,  601,  621,  320,  630,  608,
			  609,  609,  609,  609,  610,  610,  610,  610,  622,  595,
			  564,  611,  611,  611,  611,  612,  612,  612,  612,  610,
			  613,  607,  613,  613,  613,  613,  625,  621,  629,  630,
			  614,  608,  614,  614,  614,  614,  626,  613,  631,  634,
			  626,  637,  632,  633,  638,  610,  639,  319,  640,  641,
			  642,  610,  625,  643,  629,  645,  649,  650,  651,  652,
			  653,  655,  646,  646,  646,  634,  646,  637,  626,  613,
			  631,  626,  638,  614,  632,  633,  654,  646,  639,  640, yy_Dummy>>,
			1, 200, 1585)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  641,  656,  642,  650,  643,  658,  659,  645,  649,  651,
			  662,  652,  653,  655,  663,  665,  666,  666,  666,  670,
			  671,  672,  654,  667,  667,  667,  667,  656,  674,  674,
			  674,  658,  676,  676,  676,  676,  688,  318,  659,  687,
			  693,  662,  310,  665,  304,  703,  663,  672,  293,  290,
			  670,  289,  671,  678,  678,  678,  678,  678,  666,  646,
			  694,  679,  688,  679,  285,  667,  679,  679,  679,  679,
			  674,  687,  693,  703,  676,  680,  680,  680,  680,  681,
			  681,  681,  681,  682,  682,  682,  682,  689,  692,  697,
			  680,  683,  694,  683,  681,  678,  683,  683,  683,  683,

			  684,  699,  684,  684,  684,  684,  700,  706,  702,  704,
			  705,  707,  710,  689,  692,  712,  711,  684,  713,  715,
			  720,  697,  680,  730,  719,  732,  681,  722,  724,  724,
			  726,  726,  726,  699,  702,  704,  705,  707,  700,  706,
			  731,  710,  711,  712,  752,  751,  713,  756,  720,  684,
			  719,  715,  754,  722,  284,  730,  283,  732,  742,  742,
			  742,  742,  743,  743,  743,  743,  731,  282,  280,  724,
			  752,  726,  744,  744,  744,  744,  745,  751,  745,  756,
			  754,  745,  745,  745,  745,  757,  746,  744,  746,  758,
			  765,  746,  746,  746,  746,  747,  747,  747,  747,  748, yy_Dummy>>,
			1, 200, 1785)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  748,  748,  748,  749,  749,  749,  749,  750,  759,  750,
			  747,  766,  750,  750,  750,  750,  769,  757,  765,  744,
			  770,  758,  767,  767,  767,  772,  773,  776,  783,  784,
			  784,  784,  784,  785,  785,  785,  785,  759,  786,  786,
			  786,  786,  747,  766,  787,  787,  787,  787,  769,  800,
			  273,  268,  770,  767,  783,  776,  793,  772,  773,  237,
			  783,  788,  788,  788,  788,  789,  796,  789,  803,  806,
			  789,  789,  789,  789,  804,  800,  788,  790,  790,  790,
			  790,  791,  791,  791,  791,  767,  812,  816,  793,  802,
			  802,  802,  818,  819,  824,  796,  825,  803,  826,  236,

			  804,  806,  813,  813,  813,  813,  827,  828,  788,  837,
			  837,  837,  812,  814,  814,  814,  814,  837,  812,  816,
			  802,  818,  825,  234,  826,  819,  824,  841,  841,  841,
			  232,  230,  827,  828,  832,  832,  832,  832,  832,  832,
			  832,  832,  832,  832,  228,  225,  222,  220,  218,  216,
			  214,  212,  802,  833,  833,  833,  833,  833,  833,  833,
			  833,  833,  833,  834,  834,  834,  834,  834,  834,  834,
			  834,  834,  834,  835,  835,  835,  835,  835,  835,  835,
			  835,  835,  835,  836,  836,  836,  836,  836,  836,  836,
			  836,  836,  836,  838,  838,  838,  210,  838,  208,  838, yy_Dummy>>,
			1, 200, 1985)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  838,  838,  839,  200,  839,  839,  839,  839,  839,  839,
			  839,  839,  840,  840,  840,  842,  196,  842,  842,  842,
			  840,  842,  842,  842,  842,  843,  843,  843,  843,  843,
			  843,  843,  843,  843,  843,  844,  844,  844,  844,  844,
			  844,  844,  844,  844,  844,  845,  845,  845,  845,  845,
			  845,  845,  845,  845,  845,  847,  185,  847,  182,  847,
			  847,  847,  847,  847,  847,  848,  180,  848,  848,  848,
			  848,  848,  848,  848,  848,  851,  159,  851,  851,  851,
			  851,  851,  851,  851,  851,  855,  855,  855,  855,  855,
			  855,  855,  855,  855,  855,  856,  155,  856,  856,  856,

			  856,  856,  856,  856,  856,  153,  149,  137,  132,  129,
			  127,  125,  123,  118,  117,  115,  113,  112,  106,  105,
			  104,   98,   95,   93,   85,   76,   56,   47,   32,   13,
			    8,    7, yy_Dummy>>,
			1, 132, 2185)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 856)
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
			    0,    0,    0,   96,   97,  105,  110, 2314, 2313,  115,
			  118,  121,  124, 2314, 2317,  127,  130,  133,  189,  286,
			 2317,  131, 2317, 2317,  149,  153, 2317,  156,  154,  304,
			  297,  304, 2287, 2317,  333,  336,  384,  339,  411,  403,
			    0,  412,  104,  348,  360,  412,  109, 2268,  473,  115,
			  267,  474,  474,   71,  318,  123, 2267, 2317,  525, 2317,
			  429, 2317, 2317,  529,  532,  536,  552,  555,  558,  561,
			  564,  582,  585,  588,  591,  594, 2305, 2317, 2317,  650,
			   98,  611, 2317, 2317,  159, 2307, 2317, 2317,  178, 2317,
			 2317,  184,  295, 2292,  616, 2291, 2317,  619, 2290,  698,

			  791, 2317,  887,   88, 2293, 2299, 2298,  980,  326,  327,
			  378,  308, 2260, 2257,  348, 2256,  626, 2242, 2293,  307,
			  622,  737, 1064, 2287, 1156, 2286, 2317, 2279, 2317, 2278,
			 2317,  638, 2277,  641, 2317,  644, 2317, 2276,  670,  716,
			  719,  819,  742,  274,  377,    0,  751, 2317, 2317, 2275,
			  841,  728, 2317, 2274, 2317, 2265,  844,  998, 2317, 2245,
			 2317,    0,  361,  322,  420,  376,  368,  394,  447,  457,
			  405,  459,  437,  971,    0,  525,  641,  527,  322,  549,
			 2207,    0, 2198,  979,    0, 2201,  644,  551,  557,  661,
			  990,    0,  561,  671, 1061,  704, 2159,  583,  699,  583, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2143, 1010,  703,  330,  700,  709, 1060, 2317, 2167, 2317,
			 2165, 2317, 2120, 2317, 2119, 2317, 2118, 2317, 2117, 2317,
			 2116, 2317, 2115, 1085, 2317, 2114, 1096, 2317, 2113, 2317,
			 2100, 2317, 2099, 2317, 2092, 2317, 2068, 2039, 2317,  745,
			 2317, 2317, 2317, 2317, 2317,  444, 2317, 2317, 2317, 2317,
			 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317,
			 2317, 2317,  400, 2317, 2317, 1113,  401, 2317, 2034, 2317,
			  811, 2317,  860, 2029, 2317, 2317, 1174, 1193, 2317, 2317,
			 1937, 2317, 1947, 1925, 1923, 1833, 2317, 1206, 1299, 1820,
			 1818, 1128, 1226, 1828, 2317, 2317, 2317, 2317,  565, 2317,

			  632, 2317,  775,  710, 1784,  728,  512,  783, 1136, 2317,
			 1822,  794, 2317, 1235, 1238, 1245, 2317, 2317, 1812, 1742,
			 1692, 1687, 1686, 1121, 1673, 1546, 1510, 1489, 1488, 1444,
			 1438, 1405, 1391, 1382, 1371, 1308, 1305, 1304, 1254, 1220,
			 2317, 2317, 2317, 2317, 1209, 1240, 1236, 2317, 2317, 1267,
			 2317, 1341, 2317, 1345, 2317, 1330, 1257, 1346,  968, 1158,
			 1224, 1113, 1352, 1356, 2317, 2317, 1397, 1401, 1406, 1417,
			 2317, 1422, 2317, 2317, 2317, 1425, 2317, 1433, 1444, 1128,
			  532,  805,    0,    0,  540, 1010,  805,  810,  944,  973,
			  972,  976, 1037, 1044, 1061,    0,  979, 1154, 1068,  984, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1071,  467, 1043, 1135, 1148, 1125, 1155, 1187, 1219, 1120,
			 1241, 1078,    0, 1254, 1065, 1151, 1289, 1288, 1289, 1308,
			 1158, 1379, 1238, 1371, 1380, 1387,  577,  624, 1396, 1172,
			 1398, 1273,  796, 1031, 1407,  788,    0, 2317, 1449, 2317,
			 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317, 1465, 2317,
			 2317, 1472, 2317, 2317, 2317, 2317, 1458, 1464,    0, 1047,
			 2317, 2317, 1095, 1103, 1100, 2317, 1456, 2317, 2317, 2317,
			 2317,  987, 1239, 1087, 1427, 2317, 1012, 2317, 2317, 1493,
			  999, 2317, 2317, 2317, 2317, 2317, 1482, 1487, 2317, 2317,
			 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317, 2317,

			 2317, 2317, 2317, 2317, 2317, 1506, 1510, 1517, 2317, 2317,
			 2317, 1529, 1538, 1548, 1554, 1577, 1450,  953,    0,  951,
			  987, 1583, 1589, 1611, 2317,  873,  846, 1539, 2317, 2317,
			 2317, 1443, 1448, 1467,  834, 1455, 1324,  824, 1513, 1499,
			 1541, 1552,  818, 1544, 1560, 1524, 1560, 1229, 1568, 1572,
			 1586, 1571,    0, 1588, 1563,  796, 1578, 1589, 1583,    0,
			 1269,    0,    0, 1422, 1637,    0, 1588, 1584, 1594, 1589,
			  777, 1590, 1594, 1594,  761, 1599, 1599,    0,  761,    0,
			    0, 1614, 1615, 1608, 1624, 1636,    0,    0, 2317, 2317,
			 2317, 2317, 1138, 1159,    0, 1654,  732, 1618, 2317, 1630, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2317, 1630, 2317,  758, 1143, 1658,    0, 1666, 1670, 1686,
			 1690, 1697, 1701, 1708, 1718, 2317, 2317, 1621,    0,    0,
			 1256, 1664, 1650,    0,    0, 1684, 1707, 1473,    0, 1686,
			 1666, 1708, 1713, 1715, 1695, 1500,    0, 1699, 1706, 1717,
			 1715, 1716, 1723, 1720,    0, 1726, 1766, 2317,  736, 1731,
			 1715, 1725, 1730, 1731, 1734, 1732, 1737,    0, 1741, 1761,
			    0,    0, 1757, 1765,    0, 1757, 1783, 1790,  990,  642,
			 1767, 1771, 1758, 2317, 1795, 1379, 1799, 1396, 1820, 1832,
			 1841, 1845, 1849, 1862, 1868,    0,    0, 1790, 1771, 1823,
			    0,  648, 1824, 1791, 1815,    0,    0, 1840,    0, 1856,

			 1857,    0, 1845, 1787, 1845, 1846, 1862, 1847, 2317,  677,
			 1856, 1853, 1857, 1860,    0, 1870,    0,    0,    0, 1860,
			 1862,    0, 1863, 2317, 1894, 2317, 1896, 2317,  610,  583,
			 1874, 1877, 1876,  635,  618,  596,  509,  541,  511,  502,
			  445,  465, 1924, 1928, 1938, 1947, 1957, 1961, 1965, 1969,
			 1978, 1897, 1880,    0, 1894,    0, 1899, 1939, 1941, 1952,
			    0,    0,  421,    0,    0, 1932, 1962, 2006,  406, 1967,
			 1973,    0, 1976, 1977,    0,    0, 1969,  418,  388, 2317,
			 2317, 2317, 2317, 1979, 1995, 1999, 2004, 2010, 2027, 2036,
			 2043, 2047,    0, 2007,    0,    0, 2010,    0,    0,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1985,    0, 2073, 2012, 2012,    0, 2020,    0,    0,  349,
			 2317, 2317, 2037, 2068, 2079,    0, 2038,    0, 2036, 2048,
			    0,    0, 2317,    0, 2049, 2033, 2035, 2043, 2044,    0,
			 2317, 2317, 2118, 2137, 2147, 2157, 2167, 2093, 2177, 2186,
			 2196, 2105, 2199, 2209, 2219, 2229,  789, 2239, 2249,  320,
			  284, 2259,  175,  160,  102, 2269, 2279, yy_Dummy>>,
			1, 57, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 856)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (841, 161, 205)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (831, 316, 343)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (841, 379, 436)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (831, 481, 515)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (841, 531, 587)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (841, 617, 645)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (831, 832, 856)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  831,    1,  832,  832,  833,  833,  834,  834,  835,
			  835,  836,  836,  831,  831,  831,  831,  837,  831,  838,
			  831,  839,  831,  831,  837,  837,  831,  840,  831,  837,
			  831,  831,  831,  831,  837,  837,  837,  831,  838,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  831,  837,  831,
			  837,  831,  831,  837,  837,  837,  837,  837,  837,  837,
			  837,  837,  831,  831,  837,  837,  842,  831,  831,  831,
			  843,  843,  831,  831,  844,  845,  831,  831,  831,  831,
			  831,  831,  831,  831,  831,  831,  831,  837,  846,   18,

			   99,  831,  831,  847,   99,  100,  100,   18,  100,  100,
			  100,   99,   99,   99,   99,   99,   99,  100,  100,   99,
			   38,  838,  838,  848,  848,  848,  831,  846,  831,  846,
			  831,  837,  831,  837,  831,  831,  831,  846,  837,  837,
			  837,  831,  831,  849,  849,  850,  831,  831,  831,  846,
			  837,  837,  831,  846,  831,  846,  837,  837,  831,  831,
			  831, yy_Dummy>>,
			1, 161, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  837,  831,  846,  831,  846,  831,  846,  831,  846,  831,
			  846,  831,  846,  831,  846,  831,  846,  837,  831,  846,
			  837,  831,  846,  831,  831,  831,  831,  831,  846,  831,
			  846,  842,  831,  831,  831,  831,  831,  831,  831,  831,
			  831,  831,  831,  831,  831,  831,  831,  831,  831,  831,
			  831,  831,  831,  831,  831,  831,  843,  831,  831,  843,
			  844,  831,  845,  831,  831,  831,  831,  851,  831,  831,
			  846,  837,  831,  831,  100,  831,  107,  100,  100,  102,
			  831,  102,  287,  102,  102,  287,  847,   99,  831,  831,
			  831,  831,  100,  831,  100,  831,  100,   99,   99,   99,

			   99,   99,   99,  831,   99,  100,  831,  122,   38,  838, yy_Dummy>>,
			1, 110, 206)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  846,  831,  831,  831,  831,  846,  831,  846,  831,  846,
			  831,  831,  831,  831,  849,  849,  849,  850,  831,  831,
			  831,  831,  837,  846,  837,  837,  831,  846,  831,  831,
			  831,  846,  831,  846,  837, yy_Dummy>>,
			1, 35, 344)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  831,  846,  831,  831,  831,  831,  831,  831,  831,  831,
			  831,  846,  831,  831,  846,  831,  831,  831,  831,  831,
			  831,  851,  851,  831,  831,  846,  107,  288,  831,  847,
			  831,  831,  831,  831,   99,   99,   99,   99,  831,   99,
			  831,  831,  838,  122, yy_Dummy>>,
			1, 44, 437)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  849,  849,  360,  850,  831,  831,  831,  846,  831,  831,
			  150,  150,  831,  831,  831, yy_Dummy>>,
			1, 15, 516)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  831,  831,  831,  831,  831,  831,  852,  831,  851,   99,
			  831,   99,  831,   99,  831,  831,  853,  853,  854,  831,
			  831,  831,  831,  831,  831,  831,  831,  831,  831, yy_Dummy>>,
			1, 29, 588)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  831,  831,  831,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  831,  831,  852,  851,   99,   99,   99,  831,  853,  853,
			  853,  854,  831,  831,  831,  831,  831,  831,  831,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  831,  855,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  831,  831,  831,
			  831,  831,  852,  851,   99,   99,   99,  831,  674,  831,
			  853,  831,  676,  831,  854,  831,  831,  831,  831,  831,

			  831,  831,  831,  831,  831,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  841,  841,  841,  856,
			   99,   99,   99,  831,  831,  831,  831,  831,  831,  831,
			  831,  831,  831,  831,  831,  831,  841,  841,  841,  841,
			  841,  841,  841,  841,  841,  841,  831,  841,  841,  841,
			  841,  841,  841,   99,  831,  831,  831,  831,  831,  841,
			  841,  841,  831,  841,  841,  841,  831,  841,  831,  841,
			  831,  841,  831,  841,  831,    0, yy_Dummy>>,
			1, 186, 646)
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
			create an_array.make_filled (0, 0, 832)
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
			   25,   28,   31,   34,   37,   42,   47,   50,   53,   56,
			   61,   64,   67,   70,   73,   78,   83,   88,   91,   97,
			  100,  103,  106,  109,  112,  115,  118,  121,  124,  127,
			  130,  133,  136,  139,  142,  145,  148,  151,  154,  158,
			  161,  166,  169,  172,  177,  182,  187,  192,  197,  202,
			  207,  212,  217,  220,  223,  228,  233,  235,  237,  239,
			  241,  243,  245,  247,  249,  251,  253,  255,  257,  259,
			  261,  263,  266,  268,  270,  271,  271,  273,  275,  275,

			  276,  277,  278,  279,  279,  280,  281,  282,  283,  284,
			  285,  286,  287,  288,  289,  290,  291,  293,  294,  295,
			  297,  300,  301,  302,  303,  304,  305,  308,  308,  311,
			  311,  312,  314,  315,  318,  319,  320,  323,  323,  326,
			  329,  332,  333,  334,  334,  334,  334,  334,  335,  338,
			  338,  341,  344,  347,  347,  350,  350,  353,  356,  357,
			  357,  358,  359,  360,  361,  362,  363,  365,  366,  367,
			  368,  369,  370,  371,  372,  374,  375,  376,  377,  378,
			  379,  380,  382,  383,  384,  386,  387,  388,  389,  390,
			  391,  392,  394,  395,  396,  397,  398,  399,  400,  401, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  402,  403,  404,  405,  406,  407,  408,  411,  414,  414,
			  417,  417,  420,  420,  423,  423,  426,  426,  429,  429,
			  432,  432,  435,  435,  438,  441,  441,  444,  447,  447,
			  448,  448,  449,  449,  452,  452,  455,  455,  456,  457,
			  457,  458,  459,  460,  461,  462,  462,  463,  464,  465,
			  466,  467,  468,  469,  470,  471,  472,  473,  474,  475,
			  476,  477,  478,  479,  480,  481,  482,  483,  485,  486,
			  487,  487,  488,  489,  490,  491,  493,  494,  496,  497,
			  498,  499,  501,  502,  503,  504,  505,  508,  509,  510,
			  511,  512,  514,  515,  516,  519,  522,  524,  527,  528,

			  531,  532,  535,  536,  537,  538,  539,  540,  541,  542,
			  543,  544,  545,  548,  550,  553,  555,  556,  558,  559,
			  560,  561,  562,  563,  564,  565,  566,  567,  568,  569,
			  570,  571,  572,  573,  574,  575,  576,  577,  578,  579,
			  580,  582,  584,  586,  589,  589,  590,  590,  592,  595,
			  596,  599,  600,  603,  604,  605,  606,  606,  607,  609,
			  610,  612,  613,  614,  614,  616,  619,  622,  624,  626,
			  628,  631,  632,  634,  636,  639,  640,  643,  644,  646,
			  647,  648,  649,  651,  653,  654,  655,  656,  657,  658,
			  659,  660,  661,  662,  663,  664,  666,  667,  668,  669, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  670,  671,  672,  673,  674,  675,  676,  677,  678,  679,
			  680,  682,  683,  685,  686,  687,  688,  689,  690,  691,
			  692,  693,  694,  695,  696,  697,  698,  699,  700,  701,
			  702,  703,  704,  705,  706,  707,  708,  710,  713,  714,
			  716,  718,  720,  722,  724,  726,  728,  730,  733,  734,
			  736,  739,  740,  742,  744,  746,  747,  747,  747,  748,
			  749,  750,  751,  751,  752,  753,  755,  755,  757,  760,
			  763,  766,  767,  768,  769,  770,  772,  773,  775,  778,
			  780,  781,  782,  783,  784,  785,  786,  787,  788,  789,
			  790,  791,  792,  793,  794,  795,  796,  797,  798,  799,

			  800,  801,  802,  803,  804,  806,  807,  807,  808,  810,
			  812,  814,  815,  815,  815,  816,  817,  817,  817,  817,
			  817,  817,  818,  819,  820,  822,  824,  827,  830,  832,
			  834,  836,  837,  838,  839,  840,  841,  842,  843,  844,
			  845,  846,  847,  848,  849,  850,  852,  853,  854,  855,
			  856,  857,  858,  860,  861,  862,  863,  864,  865,  866,
			  868,  869,  871,  873,  874,  876,  878,  879,  880,  881,
			  882,  883,  884,  885,  886,  887,  888,  889,  891,  892,
			  894,  896,  897,  898,  899,  900,  901,  903,  905,  907,
			  909,  911,  912,  912,  912,  912,  912,  913,  914,  916, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  917,  919,  920,  922,  923,  923,  923,  923,  923,  924,
			  924,  925,  925,  926,  927,  928,  930,  931,  932,  934,
			  936,  937,  938,  939,  941,  943,  944,  945,  946,  948,
			  949,  950,  951,  952,  953,  954,  955,  957,  958,  959,
			  960,  961,  962,  963,  964,  966,  967,  967,  968,  968,
			  969,  970,  971,  972,  973,  974,  975,  976,  978,  979,
			  980,  982,  984,  985,  986,  988,  989,  989,  989,  989,
			  990,  991,  992,  993,  994,  994,  994,  994,  994,  994,
			  994,  995,  996,  996,  996,  997,  999, 1001, 1002, 1003,
			 1004, 1006, 1007, 1008, 1009, 1010, 1012, 1014, 1015, 1017,

			 1018, 1019, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028,
			 1028, 1029, 1030, 1031, 1032, 1034, 1035, 1037, 1039, 1041,
			 1042, 1043, 1045, 1046, 1047, 1047, 1048, 1048, 1049, 1049,
			 1050, 1051, 1052, 1053, 1053, 1053, 1053, 1053, 1053, 1053,
			 1053, 1053, 1053, 1053, 1054, 1055, 1055, 1055, 1056, 1056,
			 1057, 1057, 1058, 1059, 1061, 1062, 1064, 1065, 1066, 1067,
			 1068, 1070, 1072, 1073, 1075, 1077, 1078, 1079, 1080, 1081,
			 1082, 1083, 1085, 1086, 1087, 1089, 1091, 1092, 1093, 1094,
			 1096, 1097, 1099, 1100, 1101, 1101, 1102, 1102, 1103, 1104,
			 1104, 1104, 1105, 1107, 1108, 1110, 1112, 1113, 1115, 1117, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1119, 1120, 1122, 1122, 1123, 1124, 1126, 1127, 1129, 1131,
			 1132, 1134, 1136, 1137, 1137, 1138, 1140, 1141, 1143, 1143,
			 1144, 1146, 1148, 1150, 1152, 1152, 1153, 1153, 1154, 1154,
			 1156, 1157, 1157, yy_Dummy>>,
			1, 33, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1156)
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
			  267,    1,  267,   86,  266,  267, -357,  235,  266,  267,
			   86,   91,  266,  267, -357,   16,  266,  267,  200,  266,
			  267,   34,  266,  267,   35,  266,  267,   44,   86,  266,
			  267, -357,   40,   86,  266,  267, -357,    9,  266,  267,
			   42,  266,  267,   15,  266,  267,   46,   86,  266,  267,
			 -357,  165,  266,  267,  165,  266,  267,    8,  266,  267,
			    7,  266,  267,   22,   86,  266,  267, -357,   20,   86,
			  266,  267, -357,   24,   86,  266,  267, -357,   11,  266,
			  267,   17,   86,   91,  266,  267, -357,  164,  266,  267,

			  164,  266,  267,  164,  266,  267,  164,  266,  267,  164,
			  266,  267,  164,  266,  267,  164,  266,  267,  164,  266,
			  267,  164,  266,  267,  164,  266,  267,  164,  266,  267,
			  164,  266,  267,  164,  266,  267,  164,  266,  267,  164,
			  266,  267,  164,  266,  267,  164,  266,  267,  164,  266,
			  267,   38,  266,  267,   86,  266,  267, -357,   39,  266,
			  267,   48,   86,  266,  267, -357,   36,  266,  267,   37,
			  266,  267,   13,   86,  266,  267, -357,   62,   86,  266,
			  267, -357,   72,   86,  266,  267, -357,   82,   86,  266,
			  267, -357,   58,   86,  266,  267, -357,   60,   86,  266, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  267, -357,   74,   86,  266,  267, -357,   78,   86,  266,
			  267, -357,   84,   86,  266,  267, -357,   68,  266,  267,
			   70,  266,  267,   66,   86,  266,  267, -357,   64,   86,
			  266,  267, -357,  236,  267,  265,  267,  263,  267,  264,
			  267,  232,  267,  232,  267,  231,  267,  230,  267,  232,
			  267,  234,  267,  233,  267,  228,  267,  228,  267,  227,
			  267,    6,  267,    5,    6,  267,    5,  267,    6,  267,
			    1,   88,  -90,   86, -356,  235,  235,  224,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235, -493,  235,  235,  235, -493,   86,   91, -356,

			   91,   91,  200,  200,  200,   45,   88,  -90,   41,   88,
			  -90,   43,   86, -357,    2,   50,   86, -357,   10,  171,
			   47,   88,  -90,   54,   86, -356,   32,   86, -356,   30,
			   86, -356,  171,  165,   18,   23,   88,  -90,   52,   86,
			 -356,   26,   86, -356,   21,   88,  -90,   25,   88,  -90,
			   28,   86, -356,   53,   86, -356,   12,   19,  164,  164,
			  164,  164,  164,   97,  164,  164,  164,  164,  164,  164,
			  164,  164,  110,  164,  164,  164,  164,  164,  164,  164,
			  122,  164,  164,  164,  128,  164,  164,  164,  164,  164,
			  164,  164,  140,  164,  164,  164,  164,  164,  164,  164, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  164,  164,  164,  164,  164,  164,  164,  164,   56,   86,
			 -356,   49,   88,  -90,   14,   88,  -90,   63,   88,  -90,
			   73,   88,  -90,   83,   88,  -90,   59,   88,  -90,   61,
			   88,  -90,   75,   88,  -90,   76,   86, -356,   79,   88,
			  -90,   80,   86, -356,   85,   88,  -90,   69,   71,   67,
			   88,  -90,   65,   88,  -90,  236,  263,  253,  251,  252,
			  254,  255,  256,  257,  237,  238,  239,  240,  241,  242,
			  243,  244,  245,  246,  247,  248,  249,  250,  232,  231,
			  230,  232,  232,  229,  230,  234,  233,  227,    5,    4,
			    2,   88,  -89,   86,   86, -356,  -90,  225,  235,  223,

			  225,  235,  235,  235,  235,  222,  223,  225,  235,  235,
			  235,  235,  235, -493, -493,  235,  208,  223,  225,  206,
			  223,  225,  207,  225,  209,  223,  225,  235,  202,  223,
			  225,  235,  203,  223,  225,  235,  235,  235,  235,  235,
			  235,  235, -226,  235,  235,  210,  223,  225,   86,   91,
			   86,   91, -356,  -90,   91,  200,  172,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  173,  200,   45,  -90,   41,  -90,   51,   88,  -90,  171,
			   47,  -90,   55,   88,  -89,   86,   33,   88,  -89,   86, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   31,   88,  -89,   86,  166,  171,  165,  169,  170,  170,
			  168,  170,  167,  165,   23,  -90,   52,   88,  -89,   52,
			   86, -356,   52,   86,   86, -356,   86, -356,   27,   88,
			  -89,   86,   21,  -90,   25,  -90,   29,   88,  -89,   86,
			   53,   88,  -89,   86,   86, -356,  164,  164,  164,   95,
			  164,   96,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  113,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  132,  164,  164,  135,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,

			  164,  164,  164,  164,  164,  164,  164,  164,  163,  164,
			   57,   88,  -89,   86,   49,  -90,   14,  -90,   63,  -90,
			   73,  -90,   83,  -90,   59,  -90,   61,  -90,   75,  -90,
			   77,   88,  -89,   86,   79,  -90,   81,   88,  -89,   86,
			   85,  -90,   67,  -90,   65,  -90,  262,    4,    4,   87,
			  -89,  235,  235,  222,  225,  214,  225,  211,  223,  225,
			  204,  223,  225,  205,  223,  225,  235,  235,  235,  235,
			  219,  225,  235,  213,  225,  212,  223,  225,  -89,   91,
			   91,  190,  188,  189,  191,  192,  201,  201,  193,  194,
			  174,  175,  176,  177,  178,  179,  180,  181,  182,  183, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  184,  185,  186,  187,   51,  -90,  171,  171,   55,  -89,
			   33,  -89,   31,  -89,  171,  171,  165,  165,  165,   86,
			   52,   87,   52,  -89,   52,   86, -356,   52,   86, -356,
			   27,  -89,   29,  -89,   53,  -89,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  111,  164,  164,  164,  164,  164,  164,  164,  120,  164,
			  164,  164,  164,  164,  164,  164,  129,  164,  164,  131,
			  164,  133,  164,  164,  138,  164,  139,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  152,
			  164,  164,  154,  164,  155,  164,  164,  164,  164,  164,

			  164,  161,  164,  162,  164,   57,  -89,   77,  -89,   81,
			  -89,  258,    4,  235,  215,  225,  235,  218,  225,  235,
			  221,  225,  201,  171,  171,  171,  171,  165,   52,  -89,
			   52,  164,   93,  164,   94,  164,  164,  164,  164,  101,
			  164,  102,  164,  164,  164,  164,  107,  164,  164,  164,
			  164,  164,  164,  164,  164,  118,  164,  164,  164,  164,
			  164,  164,  164,  164,  130,  164,  164,  136,  164,  164,
			  164,  164,  164,  164,  164,  164,  149,  164,  164,  164,
			  153,  164,  156,  164,  164,  164,  159,  164,  164,    4,
			  235,  235,  235,  195,  171,  171,  171,   92,  164,   98, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  164,  164,  164,  164,  104,  164,  164,  164,  164,  164,
			  112,  164,  114,  164,  164,  116,  164,  164,  164,  121,
			  164,  164,  164,  164,  164,  164,  164,  137,  164,  164,
			  164,  164,  145,  164,  164,  147,  164,  148,  164,  150,
			  164,  164,  164,  158,  164,  164,  261,  260,  259,    4,
			  235,  235,  235,  171,  171,  171,  171,  164,  164,  103,
			  164,  164,  106,  164,  164,  164,  164,  164,  119,  164,
			  123,  164,  164,  125,  164,  126,  164,  164,  164,  164,
			  164,  164,  164,  146,  164,  164,  164,  160,  164,    3,
			    4,  235,  235,  235,  198,  199,  199,  197,  199,  196,

			  171,  171,  171,  171,  171,   99,  164,  164,  105,  164,
			  108,  164,  164,  115,  164,  117,  164,  124,  164,  164,
			  134,  164,  164,  164,  143,  164,  164,  151,  164,  157,
			  164,  235,  217,  225,  220,  225,  171,  171,  100,  164,
			  164,  127,  164,  164,  142,  164,  144,  164,  216,  225,
			  109,  164,  164,  164,  141,  164,  141, yy_Dummy>>,
			1, 157, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2317
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 831
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 832
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
