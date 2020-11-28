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
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 18 then
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
			
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 20 then
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
			
when 21 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 22 then
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
			
when 23 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 24 then
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
			
when 25 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 26 then
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
			
when 27 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 28 then
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
			
when 29 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			
when 30 then
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
			
when 31 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 32 then
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
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 35 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 36 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 37 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 38 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 39 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 40 then
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
			
when 41 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 42 then
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
			
when 43 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 44 then
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
			
when 45 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 46 then
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
			
when 47 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 48 then
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
			
when 49 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 50 then
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
			
when 51 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
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
			
when 55 then
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
			
when 57 then
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
			
when 59 then
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
			
when 61 then
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
			
when 63 then
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
			
when 65 then
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
			
when 67 then
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
			
when 69 then
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
			
when 71 then
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
			
when 73 then
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
			
when 75 then
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
			
when 77 then
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
			
when 79 then
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
			
when 81 then
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
			
when 83 then
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
			
when 85 then
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
			
when 87 then
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
			
when 92 then
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
			
when 93 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 94 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 95 then
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
			
when 96 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 97 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 98 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 99 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 100 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 102 then
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
			
when 103 then
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
			
when 104 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 105 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 106 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 107 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 108 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 109 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 110 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 111 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 112 then
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
			
when 113 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 115 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 117 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 118 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 119 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 120 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 121 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 122 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 124 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 125 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 126 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 127 then
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
			
when 128 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 129 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 130 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 131 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 133 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 135 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 136 then
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
			
when 137 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 138 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 139 then
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
			
when 140 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- `{' is for the typed manifest string.
				last_detachable_keyword_as_value := ast_factory.new_once_string_keyword_as (utf8_text_substring (1, 4), line, column, position, 4, character_column, character_position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (utf8_text_substring (5, text_count), line, column + 4, position + 4, text_count - 4, character_column + 4, character_position + 4, unicode_text_count - 4)
				last_token := TE_ONCE_STRING
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 142 then
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
			
when 143 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 144 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 145 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 146 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 147 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 148 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 149 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 150 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 151 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 152 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 153 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 154 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 155 then
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
			
when 156 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 157 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 158 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 159 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 160 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 161 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 162 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 163 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 164 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 166 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 167 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 168 then
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
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 169 then
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
				append_utf8_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 170 then
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
			
when 171 then
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
			
when 172 then
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
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 174 then
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
			
when 175 then
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
			
when 176 then
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
			
when 177 then
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
			
when 178 then
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
			
when 179 then
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
			
when 180 then
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
			
when 181 then
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
			
when 182 then
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
			
when 183 then
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
			
when 184 then
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
			
when 185 then
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
			
when 186 then
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
			
when 187 then
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
			
when 188 then
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
			
when 189 then
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
			
when 190 then
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
			
when 191 then
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
			
when 192 then
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
			
when 193 then
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
			
when 194 then
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
			
when 195 then
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
			
when 196 then
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
			
when 197 then
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
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_utf8_text_substring_to_string (4, text_count - 2, token_buffer)
				last_detachable_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			
when 200 then
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
			
when 201 then
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
			
when 202 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 203 then
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
			
when 204 then
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
			
when 205 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 206 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 207 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 208 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 209 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 210 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 211 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 212 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 213 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 214 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 215 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 216 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 217 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 218 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 219 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 220 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 221 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 222 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 223 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 224 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 225 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 226 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 227 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 228 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 229 then
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
			
when 230 then
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
			
when 231 then
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
			
when 232 then
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
			
when 233 then
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
			
when 234 then
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
			
when 235 then
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
			
when 236 then
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
			
when 237 then
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
			
when 238 then
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
			
when 239 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_utf8_text_to_string (token_buffer)
			
when 240 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 241 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 242 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 243 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 244 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 245 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 246 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 247 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 248 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 249 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 250 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 251 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 252 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 253 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 254 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 255 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 256 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 257 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 258 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 259 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 260 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 263 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 264 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (utf8_text_substring (3, text_count - 1))
			
when 265 then
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
			
when 266 then
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
			
when 267 then
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
			
when 268 then
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
			
when 269 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 270 then
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
			create an_array.make_filled (0, 0, 2547)
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
			an_array.area.fill_with (858, 2452, 2547)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   15,   16,   15,   17,   18,   19,   20,   14,   19,
			   21,   22,   23,   24,   25,   26,   27,   28,   29,   30,
			   31,   31,   31,   32,   33,   34,   35,   36,   37,   38,
			   39,   40,   41,   42,   43,   39,   39,   44,   39,   39,
			   45,   39,   46,   47,   48,   39,   49,   50,   51,   52,
			   53,   54,   55,   39,   39,   56,   57,   58,   59,   17,
			   14,   38,   39,   40,   41,   42,   43,   39,   44,   45,
			   46,   39,   49,   50,   51,   52,   53,   60,   61,   62,
			   63,   14,   64,   14,   17,   17,   65,   66,   67,   68,
			   69,   70,   71,   72,   73,   74,   14,   76,   76,  266,

			   77,   77,  267,   78,   78,   80,   81,   80,  704,   82,
			   80,   81,   80,  204,   82,   87,   88,   87,   87,   88,
			   87,   90,   91,   90,   90,   91,   90,   93,   93,   93,
			   93,   93,   93,   95,   95,   95,   92,  176,  127,   92,
			  128,  204,   94,  207,  497,   94,  498,  177,   97,  129,
			  129,  129,  131,  131,  131,  266,  283,   98,  270,   99,
			  702,   83,  371,  371,  130,  284,   83,  132,  285,  176,
			  273,  274,  273,   98,  207,   99,   98,  858,   99,  286,
			  285,  137,   83,  138,  138,  138,  138,   83,  100,  284,
			  100,  101,  102,  103,  100,  104,  103,  100,  105,  100, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  106,  107,  100,  108,  100,  109,  100,  100,  100,  100,
			  100,  100,  110,  101,  111,  100,  112,  100,  100,  100,
			  100,  100,  100,  100,  113,  100,  100,  100,  100,  114,
			  115,  100,  100,  100,  100,  100,  100,  100,  100,  116,
			  100,  100,  117,  118,  100,  119,  101,  100,  112,  100,
			  100,  100,  100,  100,  100,  113,  100,  114,  100,  100,
			  100,  100,  100,  100,  120,  100,  101,  101,  100,  101,
			  100,  101,  101,  101,  101,  101,  101,  101,  101,  100,
			  100,  101,  101,  100,   95,   95,   95,  121,  695,  121,
			  300,  197,  121,  275,  275,  275,  121,  121,  374,  123,

			  377,  121,  133,  133,  133,  139,  139,  139,  124,  121,
			  125,  144,  300,  145,  145,  145,  145,  135,  314,  184,
			  140,  305,  141,  197,  146,  147,  185,  186,  136,   98,
			  142,   99,  187,  144,  306,  145,  145,  145,  145,  121,
			   96,  121,  121,  121,  314,  354,  148,  275,  275,  275,
			  205,  184,  754,  149,  284,  186,  146,  147,  187,  316,
			  317,  316,  121,  121,  206,  121,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,  149,  372,   96,   96,  151,
			  151,  151,  205,  143,  155,  155,  155,  157,  157,  157,
			  161,  161,  161,  755,  152,  287,  388,  181,  309,  156, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  389,  182,  158,  153,  154,  162,  101,  165,   98,  101,
			   99,  166,  159,  160,  183,  163,  167,  573,  168,  310,
			  188,  171,  388,  169,  170,  172,  189,  327,  173,  181,
			  574,  174,  389,  182,  175,  178,  122,  179,  328,  165,
			  183,  195,  311,  191,  849,  167,  168,  180,  393,  169,
			  170,  188,  171,  192,  172,  193,  198,  174,  196,  194,
			  175,  210,  210,  210,  178,  179,  199,  201,  397,  355,
			  311,  200,  360,  195,  393,  191,  211,  202,  284,  392,
			  203,  284,  192,  193,  196,  194,  382,  838,  198,   95,
			   95,   95,  212,  212,  212,  284,  397,  200,  201,  214,

			  214,  214,  395,  202,   97,  383,  203,  213,  216,  216,
			  216,  392,  408,   98,  215,   99,   96,  218,  218,  218,
			  220,  220,  220,  217,  222,  222,  222,  224,  224,  224,
			  390,  448,  219,  391,  395,  221,  227,  227,  227,  223,
			  284,  408,  225,  394,  209,   96,  837,   96,  268,  266,
			  268,  228,  267,  831,   96,  230,  230,  230,  232,  232,
			  232,  390,  391,   96,  396,  234,  234,  234,  398,  394,
			  231,  409,   96,  233,  421,   96,  316,  317,  316,   96,
			  235,  443,   96,  236,  236,  236,  238,  238,  238,  826,
			  399,   96,   93,   93,   93,  425,  396,  307,  237,  266, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  398,  239,  267,  409,  269,  700,  421,   94,  101,  555,
			   96,  226,  443,  278,  278,  278,  399,  100,  308,  101,
			  229,  356,  356,  356,  403,  269,  767,  425,  279,  373,
			  373,  373,  318,  378,  378,  378,  357,  280,   96,  281,
			  555,   96,  242,  242,  242,  622,  243,  623,  379,  244,
			  403,  245,  246,  247,  361,  361,  361,  266,  419,  248,
			  270,  809,  358,  358,  358,  358,  249,  553,  250,  362,
			  251,  252,  253,  254,  420,  255,  359,  256,  280,  424,
			  281,  257,  858,  258,  419,  289,  259,  260,  261,  262,
			  263,  264,  100,  287,  100,  553,  101,  100,  808,  100,

			  420,  100,  100,  435,  100,  424,  100,  404,  359,  363,
			  363,  363,  294,  100,  100,  100,  367,  100,  368,  368,
			  368,  368,  405,  103,  364,  100,  858,  858,  858,  435,
			  100,  100,  369,  280,  436,  281,  365,  365,  365,  404,
			  100,  406,  763,  120,  100,  407,  100,  100,  405,  100,
			  144,  366,  370,  370,  370,  370,  100,  807,  100,  432,
			  280,  437,  281,  433,  369,  442,  436,  100,  100,  445,
			  100,  407,  100,  100,  100,  100,  100,  100,  100,  100,
			  858,  449,  100,  100,  288,  289,  288,  437,  432,  288,
			  284,  442,  149,  288,  288,  445,  290,  806,  288,  693, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  693,  375,  375,  375,  375,  291,  288,  292,  858,  858,
			  858,  858,  858,  858,  858,  858,  858,  400,  444,  858,
			  858,  401,  380,  380,  380,  450,  494,  384,  384,  384,
			  386,  386,  386,  802,  284,  402,  288,  381,  288,  288,
			  288,  376,  385,  451,  600,  387,  452,  453,  454,  400,
			  444,  762,  284,  401,  755,  284,  284,  284,  494,  288,
			  288,  402,  288,  288,  288,  288,  288,  288,  288,  288,
			  288,  288,  600,  417,  288,  288,  100,   96,  100,  293,
			  294,  293,   96,  104,  293,  418,  422,  455,  293,  293,
			  673,  296,  763,  293,  458,  423,  284,  446,  446,  446,

			  297,  293,  298,  284,  412,  417,  461,  781,  413,  575,
			  756,  439,  447,  599,  554,  284,  440,  462,  422,  414,
			  463,  280,  415,  281,  423,  736,  284,  441,  283,  284,
			  299,  293,  700,  293,  293,  293,  412,  284,  575,  413,
			  273,  274,  273,  439,  599,  414,  554,  440,  415,  242,
			  242,  242,  299,  441,  293,  293,  464,  293,  288,  288,
			  288,  288,  288,  288,  288,  288,  288,  100,  100,  288,
			  288,  100,  304,  101,  122,  482,  101,  496,  100,  122,
			  101,  101,  103,  100,  483,  101,  484,  456,  456,  456,
			  696,  295,  101,  103,  100,  499,  100,  465,  466,  466, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  466,  602,  457,  496,  100,  459,  459,  459,  550,  100,
			  100,  280,  687,  281,  268,  266,  268,  284,  267,  100,
			  460,  499,  120,  101,  684,  101,  680,  101,  100,  280,
			  602,  281,  275,  275,  275,  100,  282,  100,  316,  317,
			  316,  605,  282,  469,  469,  469,  505,  471,  471,  471,
			  101,  278,  278,  278,  121,  124,  121,  125,  470,  121,
			  283,  556,  472,  121,  121,  551,  321,  284,  121,  284,
			  269,  858,  605,  286,  284,  322,  121,  323,  557,  426,
			  558,  427,  667,  473,  473,  473,  316,  317,  316,  428,
			  559,  269,  429,  556,  430,  431,  560,  655,  474,  561,

			  278,  278,  278,  287,  557,  650,  121,  284,  121,  121,
			  121,  426,  558,  427,  101,  475,  559,  428,  429,  766,
			  430,  431,  560,  100,  562,  101,  489,  317,  489,  121,
			  121,  561,  121,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,  647,  470,   96,   96,  858,  858,  858,  324,
			  562,  324,  284,  367,  324,   96,  371,  371,  324,  324,
			  767,  325,  564,  324,  476,  476,  476,  478,  478,  478,
			  326,  324,  469,  469,  469,  491,  373,  373,  373,  477,
			  300,  563,  479,  480,  480,  480,  482,  502,  501,  565,
			  608,  471,  471,  471,  564,  483,  543,  484,  481,  482, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  620,  324,  300,  324,  324,  324,  503,  563,  483,  284,
			  484,  473,  473,  473,  858,  122,  545,  328,  608,   96,
			  566,  565,   96,  284,  324,  324,  504,  324,  282,  282,
			  282,  282,  282,  282,  282,  282,  282,  546,   96,  282,
			  282,  331,  570,  567,  332,  568,  333,  334,  335,  476,
			  476,  476,  566,  571,  336,  514,  515,  515,  515,  569,
			  544,  337,  572,  338,  506,  339,  340,  341,  342,  567,
			  343,  576,  344,  124,  570,  125,  345,  568,  346,  571,
			  631,  347,  348,  349,  350,  351,  352,  100,  572,  100,
			  293,  294,  293,  122,  104,  293,  577,  630,  579,  293,

			  293,  580,  485,  576,  293,  478,  478,  478,  480,  480,
			  480,  486,  293,  487,  858,  858,  858,  587,  502,  533,
			  507,  533,  606,  508,  534,  534,  534,  534,  577,  124,
			  579,  125,  124,  580,  125,  581,  469,  469,  469,  701,
			  701,  299,  293,  587,  293,  293,  293,  532,  532,  532,
			  532,  535,  144,  606,  542,  542,  542,  542,  592,  583,
			  284,  359,  595,  299,  660,  293,  293,  581,  293,  288,
			  288,  288,  288,  288,  288,  288,  288,  288,  100,  100,
			  288,  288,  100,  100,  592,  100,  621,  488,  595,  627,
			  104,  583,  660,  359,  149,  284,  858,  858,  858,  858, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  858,  858,  624,  671,  858,  858,  469,
			  469,  469,  469,  469,  469,  538,  538,  538,  538,  858,
			  549,  549,  549,  549,  536,  585,  588,  537,  284,  539,
			  589,  590,  591,  284,  624,  671,  284,  299,  540,  625,
			  540,  294,  289,  541,  541,  541,  541,  858,  547,  617,
			  548,  548,  548,  548,  596,  597,  284,  585,  588,  299,
			  376,  539,  589,  590,  591,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  103,
			  593,  103,  598,  601,  103,  603,  596,  597,  103,  103,
			  376,  607,  604,  103,  713,  469,  469,  469,  594,  586,

			  103,  103,  584,  672,  644,  469,  469,  469,  582,  578,
			  609,  552,  593,  386,  598,  601,  378,  603,  604,  284,
			  610,  626,  713,  607,  594,  469,  469,  469,  289,  284,
			  644,  103,  672,  103,  103,  103,  478,  478,  478,  101,
			  611,  612,  466,  466,  466,  466,  371,  371,  100,  284,
			  101,  618,  683,  626,  103,  103,  546,  103,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  544,  356,  101,
			  101,  612,  466,  466,  466,  466,  294,  478,  478,  478,
			  531,  683,  616,  613,  614,  645,  543,  103,  489,  317,
			  489,   96,  619,  858,  858,  858,  295,  648,  103,  478, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  478,  478,  478,  478,  478,  615,  632,  515,  515,  515,
			  515,  645,  616,  646,  628,  613,  614,  629,  633,  634,
			  691,  530,  651,  124,  529,  125,  124,  528,  125,  648,
			  527,  526,   96,  632,  515,  515,  515,  515,  649,  646,
			  635,  653,  300,  534,  534,  534,  534,  636,  651,  691,
			  633,  634,  637,  637,  637,  637,  534,  534,  534,  534,
			  541,  541,  541,  541,  300,  652,  359,  653,  525,  649,
			  639,  639,  639,  639,  636,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  539,  524,  858,  858,  640,  654,
			  640,  657,  638,  641,  641,  641,  641,  652,  359,  541,

			  541,  541,  541,  642,  656,  542,  542,  542,  542,  547,
			  658,  643,  643,  643,  643,  547,  539,  549,  549,  549,
			  549,  654,  659,  657,  661,  666,  662,  663,  664,  665,
			  656,  669,  668,  676,  670,  678,  677,  681,  673,  673,
			  673,  658,  674,  679,  682,  376,  685,  686,  659,  688,
			  661,  376,  662,  675,  664,  689,  666,  376,  668,  663,
			  670,  665,  677,  669,  676,  690,  692,  678,  681,  679,
			  682,  697,  698,  686,  694,  694,  694,  699,  685,  712,
			  523,  688,  466,  466,  466,  466,  522,  689,  858,  858,
			  858,  690,  703,  703,  703,  716,  521,  697,  692,  705, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  705,  705,  705,  698,  714,  712,  699,  858,  858,  858,
			  637,  637,  637,  637,  674,  707,  707,  707,  707,  715,
			  720,  716,  616,  722,  706,  641,  641,  641,  641,  641,
			  641,  641,  641,  719,  725,  714,  726,  520,  721,  636,
			  708,  708,  708,  708,  519,  711,  720,  549,  549,  549,
			  549,  715,  723,  717,  539,  722,  706,  718,  518,  517,
			  725,  719,  516,  367,  726,  708,  708,  708,  708,  721,
			  858,  858,  858,  858,  858,  858,  858,  858,  858,  710,
			  709,  858,  858,  724,  723,  717,  539,  149,  718,  858,
			  858,  858,  858,  858,  858,  858,  858,  858,  727,  728,

			  858,  858,  729,  738,  730,  731,  732,  742,  733,  734,
			  737,  710,  739,  740,  741,  724,  673,  673,  673,  743,
			  735,  744,  745,  746,  727,  747,  748,  728,  757,  738,
			  513,  675,  749,  742,  729,  730,  731,  758,  732,  733,
			  759,  734,  737,  739,  512,  740,  741,  744,  745,  511,
			  510,  743,  750,  693,  693,  746,  747,  779,  748,  757,
			  749,  752,  694,  694,  694,  780,  759,  509,  500,  758,
			  760,  701,  701,  764,  703,  703,  703,  768,  705,  705,
			  705,  705,  769,  779,  769,  495,  493,  770,  770,  770,
			  770,  780,  735,  751,  771,  771,  771,  771,  708,  708, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  708,  708,  753,  774,  774,  774,  774,  778,  772,  782,
			  783,  761,  773,  784,  765,  775,  785,  775,  636,  786,
			  776,  776,  776,  776,  787,  367,  788,  774,  774,  774,
			  774,  789,  790,  792,  791,  782,  793,  794,  795,  778,
			  772,  777,  783,  796,  773,  784,  797,  798,  785,  799,
			  800,  786,  788,  803,  801,  825,  787,  805,  790,  789,
			  791,  804,  793,  492,  795,  792,  794,  693,  693,  490,
			  819,  796,  103,  777,  797,  799,  821,  287,  800,  798,
			  801,  694,  694,  694,  825,  803,  822,  804,  823,  805,
			  770,  770,  770,  770,  770,  770,  770,  770,  810,  810,

			  810,  810,  819,  811,  821,  811,  824,  751,  812,  812,
			  812,  812,  772,  815,  815,  815,  815,  813,  822,  813,
			  823,  753,  814,  814,  814,  814,  820,  816,  776,  776,
			  776,  776,  776,  776,  776,  776,  827,  828,  824,  832,
			  817,  833,  817,  834,  772,  818,  818,  818,  818,  829,
			  829,  829,  820,  835,  836,  772,  468,  843,  844,  816,
			  812,  812,  812,  812,  827,  812,  812,  812,  812,  828,
			  272,  832,  842,  833,  846,  834,  164,  164,  164,  830,
			  241,  638,  836,  847,  844,  835,  843,  772,  814,  814,
			  814,  814,  814,  814,  814,  814,  839,  839,  839,  839, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  840,  848,  840,  846,  842,  841,  841,  841,  841,  847,
			  816,  830,  818,  818,  818,  818,  818,  818,  818,  818,
			  829,  829,  829,  816,  841,  841,  841,  841,  841,  841,
			  841,  841,  850,  848,  851,  852,  853,  234,  232,  854,
			  855,  438,  816,  856,  857,   96,   96,   96,  434,  709,
			  845,  416,  104,   96,  104,  816,  104,  104,  104,  104,
			  104,  104,  411,  851,  850,  854,  855,  852,  853,  856,
			  857,   75,   75,   75,   75,   75,   75,   75,   75,   75,
			   75,  410,  845,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   84,   84,   84,   84,   84,   84,   84,

			   84,   84,   84,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   89,   89,   89,   89,   89,   89,   89,
			   89,   89,   89,  122,  122,  122,  161,  122,  133,  122,
			  122,  122,  126,   96,  126,  126,  126,  126,  126,  126,
			  126,  126,  134,  134,  134,  240,  353,  240,  240,  240,
			  134,  240,  240,  240,  240,  265,  265,  265,  265,  265,
			  265,  265,  265,  265,  265,  269,  269,  269,  269,  269,
			  269,  269,  269,  269,  269,  271,  271,  271,  271,  271,
			  271,  271,  271,  271,  271,  295,  330,  295,  295,  295,
			  295,  295,  295,  295,  295,  329,  327,  329,  329,  329, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  329,  329,  329,  329,  329,  467,  320,  467,  467,  467,
			  467,  467,  467,  467,  467,  736,  736,  736,  736,  736,
			  736,  736,  736,  736,  736,  802,  319,  802,  802,  802,
			  802,  802,  802,  802,  802,  315,  313,  312,  303,  302,
			  301,  277,  276,  272,  241,  208,  190,  150,  858,   85,
			   85,   13, yy_Dummy>>,
			1, 52, 2400)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2547)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 96)
			yy_chk_template_1 (an_array)
			an_array.area.fill_with (18, 190, 283)
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
			an_array.area.fill_with (858, 2451, 2547)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   79,    3,    4,   79,    3,    4,    5,    5,
			    5,  882,    5,    6,    6,    6,   52,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   17,   11,
			   41,   21,   12,   21,   52,   15,   54,  314,   16,  314,
			   41,   17,   24,   24,   24,   25,   25,   25,   83,   97,
			   17,   83,   17,  881,    5,  146,  146,   24,   97,    6,
			   25,   98,   41,   87,   87,   87,   24,   54,   24,   25,
			   98,   25,   98,   99,   28,    5,   28,   28,   28,   28,
			    6,   18,   99, yy_Dummy>>,
			1, 93, 97)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   19,   19,   19,   19,  880,   19,  104,   49,   19,   90,
			   90,   90,   19,   19,  878,   19,  152,   19,   27,   27,
			   27,   29,   29,   29,   19,   19,   19,   30,  104,   30,
			   30,   30,   30,   27,  115,   44,   29,  109,   29,   49,
			   30,   30,   44,   44,   27,   29,   29,   29,   44,   31,
			  109,   31,   31,   31,   31,   19,  152,   19,   19,   19,
			  115,  130,   30,   91,   91,   91,   53,   44,  695,   30,
			  130,   44,   30,   30,   44,  120,  120,  120,   19,   19,
			   53,   19,   19,   19,   19,   19,   19,   19,   19,   19,
			   19,   31,  877,   19,   19,   34,   34,   34,   53,   29,

			   35,   35,   35,   36,   36,   36,   37,   37,   37,  695,
			   34,  292,  165,   43,  111,   35,  166,   43,   36,   34,
			   34,   37,  292,   38,   35,  111,   35,   38,   36,   36,
			   43,   37,   38,  410,   38,  111,   45,   40,  165,   38,
			   38,   40,   45,  124,   40,   43,  410,   40,  166,   43,
			   40,   42,  124,   42,  124,   38,   43,   48,  112,   47,
			  836,   38,   38,   42,  169,   38,   38,   45,   40,   47,
			   40,   47,   50,   40,   48,   47,   40,   59,   59,   59,
			   42,   42,   50,   51,  173,  132,  112,   50,  140,   48,
			  169,   47,   59,   51,  132,  168,   51,  140,   47,   47, yy_Dummy>>,
			1, 200, 284)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   48,   47,  156,  805,   50,   57,   57,   57,   62,   62,
			   62,  156,  173,   50,   51,   63,   63,   63,  171,   51,
			   57,  158,   51,   62,   64,   64,   64,  168,  181,   57,
			   63,   57,   59,   65,   65,   65,   66,   66,   66,   64,
			   67,   67,   67,   68,   68,   68,  167,  211,   65,  167,
			  171,   66,   69,   69,   69,   67,  211,  181,   68,  170,
			   57,  158,  804,   62,   80,   80,   80,   69,   80,  795,
			   63,   70,   70,   70,   71,   71,   71,  167,  167,   64,
			  172,   72,   72,   72,  174,  170,   70,  182,   65,   71,
			  192,   66,  117,  117,  117,   67,   72,  206,   68,   73,

			   73,   73,   74,   74,   74,  789,  175,   69,   93,   93,
			   93,  196,  172,  110,   73,  265,  174,   74,  265,  182,
			   80,  768,  192,   93,  110,  393,   70,   68,  206,   96,
			   96,   96,  175,  110,  110,  110,   69,  136,  136,  136,
			  178,   80,  767,  196,   96,  147,  147,  147,  117,  153,
			  153,  153,  136,   96,   73,   96,  393,   74,   78,   78,
			   78,  494,   78,  494,  153,   78,  178,   78,   78,   78,
			  141,  141,  141,  269,  190,   78,  269,  766,  138,  138,
			  138,  138,   78,  389,   78,  141,   78,   78,   78,   78,
			  191,   78,  138,   78,  141,  195,  141,   78,  765,   78, yy_Dummy>>,
			1, 200, 484)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  190,  484,   78,   78,   78,   78,   78,   78,  100,  100,
			  100,  389,  484,  100,  764,  100,  191,  100,  100,  200,
			  100,  195,  100,  179,  138,  142,  142,  142,  487,  100,
			  100,  100,  144,  100,  144,  144,  144,  144,  179,  487,
			  142,  100,  122,  122,  122,  200,  100,  100,  144,  142,
			  201,  142,  143,  143,  143,  179,  100,  180,  763,  100,
			  100,  180,  100,  100,  179,  100,  145,  143,  145,  145,
			  145,  145,  100,  762,  100,  198,  143,  202,  143,  198,
			  144,  205,  201,  100,  100,  208,  100,  180,  100,  100,
			  100,  100,  100,  100,  100,  100,  761,  213,  100,  100,

			  101,  101,  101,  202,  198,  101,  213,  205,  145,  101,
			  101,  208,  101,  760,  101,  613,  613,  149,  149,  149,
			  149,  101,  101,  101,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  176,  207,  122,  122,  176,  154,  154,
			  154,  215,  311,  159,  159,  159,  160,  160,  160,  756,
			  215,  176,  101,  154,  101,  101,  101,  149,  159,  217,
			  436,  160,  219,  221,  223,  176,  207,  702,  217,  176,
			  755,  219,  221,  223,  311,  101,  101,  176,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  436,  189,
			  101,  101,  103,  154,  103,  103,  103,  103,  159,  103, yy_Dummy>>,
			1, 200, 684)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  103,  189,  193,  225,  103,  103,  736,  103,  702,  103,
			  228,  193,  225,  209,  209,  209,  103,  103,  103,  228,
			  186,  189,  231,  718,  186,  411,  696,  204,  209,  435,
			  390,  231,  204,  237,  193,  186,  239,  209,  186,  209,
			  193,  675,  237,  204,  377,  239,  103,  103,  632,  103,
			  103,  103,  186,  377,  411,  186,  273,  273,  273,  204,
			  435,  186,  390,  204,  186,  242,  242,  242,  103,  204,
			  103,  103,  242,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  108,  108,
			  629,  288,  108,  313,  108,  628,  108,  108,  297,  108,

			  288,  108,  288,  226,  226,  226,  617,  297,  108,  297,
			  108,  315,  108,  248,  248,  248,  248,  438,  226,  313,
			  108,  229,  229,  229,  381,  108,  108,  226,  599,  226,
			  268,  268,  268,  381,  268,  108,  229,  315,  108,  108,
			  595,  108,  591,  108,  108,  229,  438,  229,  275,  275,
			  275,  108,  873,  108,  299,  299,  299,  441,  873,  279,
			  279,  279,  324,  280,  280,  280,  108,  121,  121,  121,
			  121,  324,  121,  324,  279,  121,  383,  394,  280,  121,
			  121,  385,  121,  279,  121,  383,  268,  280,  441,  280,
			  385,  121,  121,  121,  394,  197,  395,  197,  576,  281, yy_Dummy>>,
			1, 200, 884)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  281,  281,  316,  316,  316,  197,  396,  268,  197,  394,
			  197,  197,  397,  563,  281,  398,  282,  282,  282,  291,
			  394,  558,  121,  281,  121,  121,  121,  197,  395,  197,
			  291,  282,  396,  197,  197,  704,  197,  197,  397,  291,
			  399,  291,  300,  300,  300,  121,  121,  398,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  555,  475,
			  121,  121,  123,  123,  123,  123,  399,  123,  475,  547,
			  123,  282,  371,  371,  123,  123,  704,  123,  401,  123,
			  284,  284,  284,  285,  285,  285,  123,  123,  321,  321,
			  321,  306,  373,  373,  373,  284,  300,  400,  285,  286,

			  286,  286,  306,  321,  319,  402,  444,  322,  322,  322,
			  401,  306,  371,  306,  286,  319,  477,  123,  300,  123,
			  123,  123,  322,  400,  319,  477,  319,  323,  323,  323,
			  479,  322,  373,  322,  444,  284,  403,  402,  285,  479,
			  123,  123,  323,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  546,  286,  123,  123,  127,  407,  405,
			  127,  406,  127,  127,  127,  326,  326,  326,  403,  408,
			  127,  336,  336,  336,  336,  406,  544,  127,  409,  127,
			  326,  127,  127,  127,  127,  405,  127,  412,  127,  326,
			  407,  326,  127,  406,  127,  408,  508,  127,  127,  127, yy_Dummy>>,
			1, 200, 1084)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  127,  127,  127,  293,  409,  293,  293,  293,  293,  507,
			  293,  293,  413,  506,  415,  293,  293,  416,  293,  412,
			  293,  327,  327,  327,  328,  328,  328,  293,  293,  293,
			  325,  325,  325,  424,  505,  359,  327,  359,  442,  328,
			  359,  359,  359,  359,  413,  327,  415,  327,  328,  416,
			  328,  417,  362,  362,  362,  633,  633,  293,  293,  424,
			  293,  293,  293,  358,  358,  358,  358,  362,  370,  442,
			  370,  370,  370,  370,  429,  419,  362,  358,  431,  293,
			  568,  293,  293,  417,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  295,

			  429,  295,  481,  295,  431,  499,  295,  419,  568,  358,
			  370,  481,  325,  325,  325,  325,  325,  325,  325,  325,
			  325,  495,  581,  325,  325,  364,  364,  364,  366,  366,
			  366,  368,  368,  368,  368,  618,  376,  376,  376,  376,
			  364,  422,  425,  366,  618,  368,  426,  427,  428,  364,
			  495,  581,  366,  295,  369,  496,  369,  485,  482,  369,
			  369,  369,  369,  619,  375,  468,  375,  375,  375,  375,
			  432,  433,  619,  422,  425,  295,  376,  368,  426,  427,
			  428,  295,  295,  295,  295,  295,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  296,  430,  296,  434,  437, yy_Dummy>>,
			1, 200, 1284)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  296,  439,  432,  433,  296,  296,  375,  443,  440,  296,
			  647,  447,  447,  447,  430,  423,  296,  296,  420,  584,
			  552,  457,  457,  457,  418,  414,  447,  388,  430,  387,
			  434,  437,  379,  439,  440,  447,  457,  497,  647,  443,
			  430,  460,  460,  460,  483,  457,  552,  296,  584,  296,
			  296,  296,  472,  472,  472,  483,  460,  466,  466,  466,
			  466,  466,  543,  543,  483,  460,  483,  472,  594,  497,
			  296,  296,  374,  296,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,  372,  357,  296,  296,  465,  465,  465,
			  465,  465,  486,  474,  474,  474,  352,  594,  466,  465,

			  465,  553,  543,  486,  489,  489,  489,  472,  474,  502,
			  502,  502,  486,  556,  486,  503,  503,  503,  504,  504,
			  504,  465,  514,  514,  514,  514,  514,  553,  465,  554,
			  503,  465,  465,  504,  514,  514,  605,  351,  559,  503,
			  350,  503,  504,  349,  504,  556,  348,  347,  474,  515,
			  515,  515,  515,  515,  557,  554,  514,  561,  489,  533,
			  533,  533,  533,  514,  559,  605,  514,  514,  532,  532,
			  532,  532,  534,  534,  534,  534,  540,  540,  540,  540,
			  489,  560,  532,  561,  346,  557,  538,  538,  538,  538,
			  515,  502,  502,  502,  502,  502,  502,  502,  502,  502, yy_Dummy>>,
			1, 200, 1484)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  538,  345,  502,  502,  539,  562,  539,  565,  532,  539,
			  539,  539,  539,  560,  532,  541,  541,  541,  541,  542,
			  564,  542,  542,  542,  542,  548,  566,  548,  548,  548,
			  548,  549,  538,  549,  549,  549,  549,  562,  567,  565,
			  569,  575,  570,  571,  572,  574,  564,  578,  577,  587,
			  579,  589,  588,  592,  585,  585,  585,  566,  585,  590,
			  593,  542,  596,  597,  567,  602,  569,  548,  570,  585,
			  572,  603,  575,  549,  577,  571,  579,  574,  588,  578,
			  587,  604,  606,  589,  592,  590,  593,  622,  624,  597,
			  614,  614,  614,  626,  596,  644,  344,  602,  616,  616,

			  616,  616,  343,  603,  630,  630,  630,  604,  634,  634,
			  634,  652,  342,  622,  606,  636,  636,  636,  636,  624,
			  648,  644,  626,  631,  631,  631,  637,  637,  637,  637,
			  585,  638,  638,  638,  638,  649,  656,  652,  616,  658,
			  637,  640,  640,  640,  640,  641,  641,  641,  641,  654,
			  661,  648,  662,  341,  657,  636,  639,  639,  639,  639,
			  340,  643,  656,  643,  643,  643,  643,  649,  659,  653,
			  639,  658,  637,  653,  339,  338,  661,  654,  337,  642,
			  662,  642,  642,  642,  642,  657,  630,  630,  630,  630,
			  630,  630,  630,  630,  630,  642,  639,  630,  630,  660, yy_Dummy>>,
			1, 200, 1684)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  659,  653,  639,  643,  653,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  664,  665,  631,  631,  666,  677,
			  667,  668,  669,  681,  670,  672,  676,  642,  678,  679,
			  680,  660,  673,  673,  673,  682,  673,  683,  685,  686,
			  664,  689,  690,  665,  697,  677,  335,  673,  692,  681,
			  666,  667,  668,  698,  669,  670,  699,  672,  676,  678,
			  334,  679,  680,  683,  685,  333,  332,  682,  693,  693,
			  693,  686,  689,  715,  690,  697,  692,  694,  694,  694,
			  694,  716,  699,  331,  318,  698,  701,  701,  701,  703,
			  703,  703,  703,  705,  705,  705,  705,  705,  706,  715,

			  706,  312,  310,  706,  706,  706,  706,  716,  673,  693,
			  707,  707,  707,  707,  708,  708,  708,  708,  694,  709,
			  709,  709,  709,  714,  707,  719,  720,  701,  708,  721,
			  703,  710,  724,  710,  705,  726,  710,  710,  710,  710,
			  727,  711,  729,  711,  711,  711,  711,  730,  731,  733,
			  732,  719,  734,  737,  738,  714,  707,  711,  720,  739,
			  708,  721,  740,  742,  724,  746,  747,  726,  729,  757,
			  749,  786,  727,  759,  731,  730,  732,  758,  734,  308,
			  738,  733,  737,  751,  751,  301,  778,  739,  298,  711,
			  740,  746,  781,  290,  747,  742,  749,  753,  753,  753, yy_Dummy>>,
			1, 200, 1884)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  786,  757,  783,  758,  784,  759,  769,  769,  769,  769,
			  770,  770,  770,  770,  771,  771,  771,  771,  778,  772,
			  781,  772,  785,  751,  772,  772,  772,  772,  771,  774,
			  774,  774,  774,  773,  783,  773,  784,  753,  773,  773,
			  773,  773,  779,  774,  775,  775,  775,  775,  776,  776,
			  776,  776,  792,  793,  785,  796,  777,  797,  777,  799,
			  771,  777,  777,  777,  777,  794,  794,  794,  779,  800,
			  803,  810,  276,  823,  827,  774,  811,  811,  811,  811,
			  792,  812,  812,  812,  812,  793,  271,  796,  820,  797,
			  830,  799,  868,  868,  868,  794,  240,  810,  803,  831,

			  827,  800,  823,  810,  813,  813,  813,  813,  814,  814,
			  814,  814,  815,  815,  815,  815,  816,  833,  816,  830,
			  820,  816,  816,  816,  816,  831,  815,  794,  817,  817,
			  817,  817,  818,  818,  818,  818,  829,  829,  829,  839,
			  840,  840,  840,  840,  841,  841,  841,  841,  843,  833,
			  845,  846,  851,  235,  233,  852,  853,  203,  815,  854,
			  855,  864,  864,  864,  199,  839,  829,  188,  875,  864,
			  875,  839,  875,  875,  875,  875,  875,  875,  185,  845,
			  843,  852,  853,  846,  851,  854,  855,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  183,  829,  860, yy_Dummy>>,
			1, 200, 2084)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  860,  860,  860,  860,  860,  860,  860,  860,  860,  861,
			  861,  861,  861,  861,  861,  861,  861,  861,  861,  862,
			  862,  862,  862,  862,  862,  862,  862,  862,  862,  863,
			  863,  863,  863,  863,  863,  863,  863,  863,  863,  865,
			  865,  865,  162,  865,  135,  865,  865,  865,  866,  134,
			  866,  866,  866,  866,  866,  866,  866,  866,  867,  867,
			  867,  869,  128,  869,  869,  869,  867,  869,  869,  869,
			  869,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  871,  871,  871,  871,  871,  871,  871,  871,  871,
			  871,  872,  872,  872,  872,  872,  872,  872,  872,  872,

			  872,  874,  126,  874,  874,  874,  874,  874,  874,  874,
			  874,  876,  125,  876,  876,  876,  876,  876,  876,  876,
			  876,  879,  119,  879,  879,  879,  879,  879,  879,  879,
			  879,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  884,  118,  884,  884,  884,  884,  884,  884,  884,
			  884,  116,  114,  113,  107,  106,  105,   94,   92,   84,
			   75,   55,   46,   32,   13,    8,    7, yy_Dummy>>,
			1, 167, 2284)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 884)
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
			    0,    0,    0,   95,   96,  104,  109, 2448, 2447,  114,
			  117,  120,  123, 2448, 2451,  126,  129,  132,  187,  283,
			 2451,  130, 2451, 2451,  148,  151, 2451,  301,  164,  304,
			  294,  316, 2421, 2451,  378,  383,  386,  389,  376,    0,
			  385,  104,  395,  368,  285,  383, 2403,  413,  412,  258,
			  423,  431,   71,  321,  107, 2402, 2451,  488, 2451,  460,
			 2451, 2451,  491,  498,  507,  516,  519,  523,  526,  535,
			  554,  557,  564,  582,  585, 2439, 2451, 2451,  641,   97,
			  547, 2451, 2451,  153, 2441, 2451, 2451,  169, 2451, 2451,
			  292,  346, 2426,  591, 2425, 2451,  612,  140,  152,  164,

			  688,  780, 2451,  875,  235, 2428, 2434, 2433,  967,  316,
			  592,  393,  400, 2396, 2393,  272, 2392,  575, 2370, 2401,
			  358, 1050,  725, 1145,  411, 2380, 2376, 1236, 2336, 2451,
			  329, 2451,  453, 2451, 2277, 2312,  620, 2451,  643, 2451,
			  456,  653,  708,  735,  699,  733,  143,  610,    0,  782,
			 2451, 2451,  284,  632,  821, 2451,  470, 2451,  489,  826,
			  829, 2451, 2310, 2451,    0,  350,  367,  493,  447,  401,
			  495,  469,  535,  426,  535,  544,  787,    0,  577,  675,
			  697,  472,  542, 2238,    0, 2218,  872,    0, 2212,  842,
			  610,  627,  542,  855,    0,  633,  562, 1047,  719, 2207, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  657,  701,  712, 2197,  879,  719,  544,  785,  723,  896,
			 2451,  515, 2451,  765, 2451,  809, 2451,  827, 2451,  830,
			 2451,  831, 2451,  832, 2451,  871,  986, 2451,  878, 1004,
			 2451,  890, 2451, 2222, 2451, 2221, 2451,  901, 2451,  904,
			 2175, 2451,  948, 2451, 2451, 2451, 2451, 2451,  978, 2451,
			 2451, 2451, 2451, 2451, 2451, 2451, 2451, 2451, 2451, 2451,
			 2451, 2451, 2451, 2451, 2451,  597, 2451, 2451, 1013,  655,
			 2451, 2168, 2451,  939, 2451, 1031, 2150, 2451, 2451, 1042,
			 1046, 1082, 1099, 2451, 1163, 1166, 1182, 2451,  959, 2451,
			 2072, 1098,  390, 1286, 2451, 1382, 1475,  966, 2056, 1037,

			 1125, 2064, 2451, 2451, 2451, 2451, 1170, 2451, 2058, 2451,
			 1981,  794, 1941,  929,  141,  949, 1085, 2451, 1963, 1183,
			 2451, 1171, 1190, 1210, 1030, 1313, 1248, 1304, 1307, 2451,
			 2451, 1957, 1940, 1939, 1934, 1920, 1236, 1852, 1849, 1848,
			 1834, 1827, 1786, 1776, 1770, 1675, 1658, 1621, 1620, 1617,
			 1614, 1611, 1570, 2451, 2451, 2451, 2451, 1552, 1328, 1305,
			 2451, 2451, 1335, 2451, 1408, 2451, 1411, 2451, 1396, 1424,
			 1335, 1137, 1508, 1157, 1497, 1431, 1401,  912, 2451, 1500,
			 2451,  992, 2451, 1044, 2451, 1049, 2451, 1497, 1468,  625,
			  885,    0,    0,  572, 1032, 1049, 1043, 1046, 1070, 1078, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1132, 1129, 1160, 1187,    0, 1194, 1216, 1209, 1206, 1214,
			  376,  869, 1238, 1263, 1465, 1269, 1268, 1306, 1464, 1326,
			 1459,    0, 1392, 1446, 1269, 1395, 1397, 1398, 1403, 1309,
			 1449, 1316, 1421, 1426, 1449,  876,  802, 1450,  961, 1452,
			 1447, 1004, 1285, 1459, 1148,    0, 2451, 1494, 2451, 2451,
			 2451, 2451, 2451, 2451, 2451, 2451, 2451, 1504, 2451, 2451,
			 1524, 2451, 2451, 2451, 2451, 1553, 1523,    0, 1380, 2451,
			 2451, 2451, 1535, 2451, 1576, 1127, 2451, 1184, 2451, 1198,
			 2451, 1370, 1437, 1523,  680, 1436, 1571,  707, 2451, 1587,
			 2451, 2451, 2451, 2451,  642, 1365, 1434, 1488, 2451, 1384,

			 2451, 2451, 1592, 1598, 1601, 1302, 1281, 1277, 1264, 2451,
			 2451, 2451, 2451, 2451, 1588, 1615, 2451, 2451, 2451, 2451,
			 2451, 2451, 2451, 2451, 2451, 2451, 2451, 2451, 2451, 2451,
			 2451, 2451, 1633, 1624, 1637, 2451, 2451, 2451, 1651, 1674,
			 1641, 1680, 1686, 1527, 1201,    0, 1178, 1136, 1692, 1698,
			 2451, 2451, 1457, 1537, 1566, 1107, 1566, 1601, 1066, 1575,
			 1632, 1593, 1656, 1062, 1658, 1660, 1673, 1676, 1322, 1678,
			 1680, 1694, 1679,    0, 1696, 1688, 1030, 1686, 1698, 1688,
			    0, 1366,    0,    0, 1463, 1737,    0, 1696, 1687, 1701,
			 1697,  985, 1700, 1695, 1512,  971, 1715, 1701,    0,  968, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0, 1716, 1721, 1716, 1580, 1737,    0,    0, 2451,
			 2451, 2451, 2451,  780, 1755,    0, 1763,  922, 1403, 1431,
			 2451, 2451, 1723, 2451, 1735, 2451, 1737, 2451,  963,  958,
			 1787, 1806,  922, 1320, 1773,    0, 1780, 1791, 1796, 1821,
			 1806, 1810, 1846, 1828, 1732,    0,    0, 1452, 1768, 1789,
			    0,    0, 1749, 1820, 1791,    0, 1774, 1802, 1789, 1819,
			 1851, 1786, 1794,    0, 1852, 1857, 1869, 1867, 1868, 1875,
			 1871,    0, 1876, 1915, 2451,  909, 1881, 1857, 1875, 1880,
			 1881, 1861, 1886, 1873,    0, 1874, 1894,    0,    0, 1888,
			 1893,    0, 1890, 1934, 1943,  334,  840, 1892, 1904, 1893,

			 2451, 1952,  833, 1955, 1101, 1959, 1968, 1975, 1979, 1984,
			 2001, 2008,    0,    0, 1974, 1908, 1917,    0,  864, 1961,
			 1977, 1984,    0,    0, 1983,    0, 1990, 1991,    0, 1979,
			 1989, 1984, 1986, 2004, 1988, 2451,  888, 1997, 1991, 2001,
			 2004,    0, 2014,    0,    0,    0, 2001, 2008,    0, 2006,
			 2451, 2048, 2451, 2062, 2451,  795,  768, 2020, 2014, 2024,
			  787,  762,  747,  683,  688,  664,  651,  567,  595, 2071,
			 2075, 2079, 2089, 2103, 2094, 2109, 2113, 2126, 2038, 2078,
			    0, 2034,    0, 2054, 2058, 2074, 2015,    0,    0,  554,
			    0,    0, 2094, 2104, 2148,  510, 2106, 2110,    0, 2110, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2120,    0,    0, 2112,  541,  482, 2451, 2451, 2451, 2451,
			 2122, 2141, 2146, 2169, 2173, 2177, 2186, 2193, 2197,    0,
			 2139,    0,    0, 2117,    0,    0,    0, 2110,    0, 2219,
			 2134, 2137,    0, 2168,    0,    0,  439, 2451, 2451, 2190,
			 2205, 2209,    0, 2199,    0, 2194, 2206,    0,    0, 2451,
			    0, 2207, 2192, 2193, 2196, 2197,    0, 2451, 2451, 2270,
			 2282, 2292, 2302, 2312, 2244, 2322, 2331, 2341, 2169, 2344,
			 2354, 2364, 2374, 1033, 2384, 2251, 2394,  369,  291, 2404,
			  281,  153,  101, 2414, 2424, yy_Dummy>>,
			1, 85, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 884)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (868, 164, 208)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (858, 329, 361)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (868, 388, 445)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (858, 509, 542)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (868, 552, 608)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (868, 644, 672)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (858, 859, 884)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  858,    1,  859,  859,  860,  860,  861,  861,  862,
			  862,  863,  863,  858,  858,  858,  858,  864,  858,  865,
			  858,  866,  858,  858,  864,  864,  858,  867,  858,  864,
			  858,  858,  858,  858,  867,  864,  867,  858,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  858,  864,  858,   57,
			  858,  858,   57,   57,   57,   57,   57,   57,   57,   57,
			   57,  858,  858,   57,   57,  869,  858,  858,  858,  870,
			  870,  858,  858,  871,  872,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  864,  873,  873,  873,

			   18,  100,  858,  874,  875,  100,  101,  101,   18,  101,
			  108,  108,  100,  100,  100,  100,  100,  100,  101,  101,
			  100,  865,  865,  865,  123,  123,  876,  876,  876,  858,
			  873,  858,  873,  858,   57,  858,  858,  858,  858,  858,
			  873,  864,  864,  864,  858,  858,  877,  877,  878,  858,
			  858,  858,   57,  858,   57,  858,  873,  858,   57,   57,
			  858,  858,  858,  858, yy_Dummy>>,
			1, 164, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  864,  858,  873,  858,  873,  858,  873,  858,  873,  858,
			  873,  858,  873,  858,  873,  858,  873,  864,  858,  873,
			  864,  858,  873,  858,  858,  858,  858,  858,  873,  858,
			  873,  869,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  870,  858,  858,  870,
			  871,  858,  872,  858,  858,  858,  858,  879,  858,  858,
			  873,  873,  873,   57,  858,   57,   57,   57,  858,  101,
			  858,  108,  108,  108,  874,  858,  874,  295,  296,  296,
			  295,  875,  100,  858,  858,  858,  858,  101,  858,  101,

			  858,  101,  100,  100,  100,  100,  100,  100,  858,  100,
			  101,  858,  123,  123,  123,  121,  865,  121,  121,  121, yy_Dummy>>,
			1, 120, 209)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  873,  858,  873,  858,  873,  858,  858,  858,  858,  877,
			  877,  877,  878,  858,  858,  873,  858,  858,  858,  873,
			  858,  873,  858,  873,  858,  858, yy_Dummy>>,
			1, 26, 362)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  858,  873,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  873,  858,  858,  873,  858,  858,  858,  858,  858,
			  858,  879,  879,  858,  858,  858,   57,  858,   57,  873,
			  858,  873,  858,  873,  858,  873,  108,  108,  108,  296,
			  296,  296,  858,  875,  858,  858,  858,  858,  100,  100,
			  100,  100,  858,  100,  858,  858,  865,  121,  121,  123,
			  123,  123,  123, yy_Dummy>>,
			1, 63, 446)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  877,  877,  373,  878,  858,  858,  858,  858,  858, yy_Dummy>>,
			1, 9, 543)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  858,  858,  858,  880,  858,  879,  873,
			  873,  858,  858,  100,  858,  100,  858,  100,  858,  123,
			  123,  865,  865,  858,  881,  881,  882,  858,  858,  858,
			  858,  858,  858,  858,  858, yy_Dummy>>,
			1, 35, 609)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  858,  858,  880,  879,  100,  100,  100,  858,  881,  881,
			  881,  882,  858,  858,  858,  858,  858,  858,  858,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  858,  883,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  858,  858,  858,
			  858,  858,  880,  879,  100,  100,  100,  858,  701,  858,
			  881,  858,  703,  858,  882,  858,  858,  858,  858,  858,

			  858,  858,  858,  858,  858,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  884,
			  100,  100,  100,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  858,  868,  868,  868,
			  868,  868,  868,  100,  858,  858,  858,  858,  858,  868,
			  868,  868,  858,  868,  868,  868,  858,  868,  858,  868,
			  858,  868,  858,  868,  858,    0, yy_Dummy>>,
			1, 186, 673)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 127948)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (96, 127, 159)
			yy_ec_template_2 (an_array)
			an_array.area.fill_with (81, 216, 246)
			yy_ec_template_3 (an_array)
			an_array.area.fill_with (96, 256, 705)
			yy_ec_template_4 (an_array)
			an_array.area.fill_with (96, 768, 884)
			yy_ec_template_5 (an_array)
			an_array.area.fill_with (96, 904, 1013)
			an_array.put (84, 1014)
			an_array.area.fill_with (96, 1015, 1153)
			an_array.put (84, 1154)
			an_array.area.fill_with (96, 1155, 1369)
			an_array.area.fill_with (84, 1370, 1375)
			an_array.area.fill_with (96, 1376, 1416)
			yy_ec_template_6 (an_array)
			an_array.area.fill_with (96, 1424, 1469)
			yy_ec_template_7 (an_array)
			an_array.area.fill_with (96, 1479, 1522)
			yy_ec_template_8 (an_array)
			an_array.area.fill_with (96, 1568, 1641)
			an_array.area.fill_with (84, 1642, 1645)
			an_array.area.fill_with (96, 1646, 1747)
			yy_ec_template_9 (an_array)
			an_array.area.fill_with (96, 1806, 2037)
			yy_ec_template_10 (an_array)
			an_array.area.fill_with (96, 2048, 2095)
			an_array.area.fill_with (84, 2096, 2110)
			an_array.area.fill_with (96, 2111, 2141)
			an_array.put (84, 2142)
			an_array.area.fill_with (96, 2143, 2403)
			yy_ec_template_11 (an_array)
			an_array.area.fill_with (96, 2417, 2545)
			yy_ec_template_12 (an_array)
			an_array.area.fill_with (96, 2558, 2677)
			an_array.put (84, 2678)
			an_array.area.fill_with (96, 2679, 2799)
			an_array.area.fill_with (84, 2800, 2801)
			an_array.area.fill_with (96, 2802, 2927)
			an_array.put (84, 2928)
			an_array.area.fill_with (96, 2929, 3058)
			an_array.area.fill_with (84, 3059, 3066)
			an_array.area.fill_with (96, 3067, 3190)
			yy_ec_template_13 (an_array)
			an_array.area.fill_with (96, 3205, 3406)
			an_array.put (84, 3407)
			an_array.area.fill_with (96, 3408, 3448)
			an_array.put (84, 3449)
			an_array.area.fill_with (96, 3450, 3571)
			an_array.put (84, 3572)
			an_array.area.fill_with (96, 3573, 3646)
			yy_ec_template_14 (an_array)
			an_array.area.fill_with (96, 3676, 3840)
			yy_ec_template_15 (an_array)
			an_array.area.fill_with (96, 3897, 3972)
			an_array.put (84, 3973)
			an_array.area.fill_with (96, 3974, 4029)
			yy_ec_template_16 (an_array)
			an_array.area.fill_with (96, 4059, 4169)
			an_array.area.fill_with (84, 4170, 4175)
			an_array.area.fill_with (96, 4176, 4253)
			an_array.area.fill_with (84, 4254, 4255)
			an_array.area.fill_with (96, 4256, 4346)
			an_array.put (84, 4347)
			an_array.area.fill_with (96, 4348, 4959)
			an_array.area.fill_with (84, 4960, 4968)
			an_array.area.fill_with (96, 4969, 5007)
			an_array.area.fill_with (84, 5008, 5017)
			an_array.area.fill_with (96, 5018, 5119)
			an_array.put (84, 5120)
			an_array.area.fill_with (96, 5121, 5740)
			yy_ec_template_17 (an_array)
			an_array.area.fill_with (96, 5761, 5866)
			an_array.area.fill_with (84, 5867, 5869)
			an_array.area.fill_with (96, 5870, 5940)
			an_array.area.fill_with (84, 5941, 5942)
			an_array.area.fill_with (96, 5943, 6099)
			yy_ec_template_18 (an_array)
			an_array.area.fill_with (96, 6108, 6143)
			an_array.area.fill_with (84, 6144, 6154)
			an_array.area.fill_with (96, 6155, 6463)
			yy_ec_template_19 (an_array)
			an_array.area.fill_with (96, 6470, 6621)
			an_array.area.fill_with (84, 6622, 6655)
			an_array.area.fill_with (96, 6656, 6685)
			an_array.area.fill_with (84, 6686, 6687)
			an_array.area.fill_with (96, 6688, 6815)
			yy_ec_template_20 (an_array)
			an_array.area.fill_with (96, 6830, 7001)
			yy_ec_template_21 (an_array)
			an_array.area.fill_with (96, 7037, 7163)
			an_array.area.fill_with (84, 7164, 7167)
			an_array.area.fill_with (96, 7168, 7226)
			an_array.area.fill_with (84, 7227, 7231)
			an_array.area.fill_with (96, 7232, 7293)
			an_array.area.fill_with (84, 7294, 7295)
			an_array.area.fill_with (96, 7296, 7359)
			yy_ec_template_22 (an_array)
			an_array.area.fill_with (96, 7380, 8124)
			yy_ec_template_23 (an_array)
			an_array.area.fill_with (96, 8288, 8313)
			yy_ec_template_24 (an_array)
			an_array.area.fill_with (84, 8352, 8383)
			an_array.area.fill_with (96, 8384, 8447)
			yy_ec_template_25 (an_array)
			an_array.area.fill_with (96, 8528, 8585)
			yy_ec_template_26 (an_array)
			an_array.area.fill_with (84, 8592, 8657)
			an_array.put (86, 8658)
			an_array.area.fill_with (84, 8659, 8703)
			yy_ec_template_27 (an_array)
			an_array.area.fill_with (84, 8708, 8742)
			yy_ec_template_28 (an_array)
			an_array.area.fill_with (84, 8745, 8890)
			an_array.put (91, 8891)
			an_array.area.fill_with (84, 8892, 8967)
			an_array.area.fill_with (96, 8968, 8971)
			an_array.area.fill_with (84, 8972, 9000)
			an_array.area.fill_with (96, 9001, 9002)
			an_array.area.fill_with (84, 9003, 9254)
			an_array.area.fill_with (96, 9255, 9279)
			an_array.area.fill_with (84, 9280, 9290)
			an_array.area.fill_with (96, 9291, 9371)
			an_array.area.fill_with (84, 9372, 9449)
			an_array.area.fill_with (96, 9450, 9471)
			an_array.area.fill_with (84, 9472, 10087)
			an_array.area.fill_with (96, 10088, 10131)
			an_array.area.fill_with (84, 10132, 10180)
			an_array.area.fill_with (96, 10181, 10182)
			an_array.area.fill_with (84, 10183, 10213)
			yy_ec_template_29 (an_array)
			an_array.area.fill_with (84, 10228, 10626)
			an_array.area.fill_with (96, 10627, 10648)
			an_array.area.fill_with (84, 10649, 10711)
			an_array.area.fill_with (96, 10712, 10715)
			an_array.area.fill_with (84, 10716, 10747)
			an_array.area.fill_with (96, 10748, 10749)
			an_array.area.fill_with (84, 10750, 11123)
			an_array.area.fill_with (96, 11124, 11125)
			an_array.area.fill_with (84, 11126, 11157)
			an_array.put (96, 11158)
			an_array.area.fill_with (84, 11159, 11263)
			an_array.area.fill_with (96, 11264, 11492)
			yy_ec_template_30 (an_array)
			an_array.area.fill_with (96, 11520, 11631)
			an_array.put (84, 11632)
			an_array.area.fill_with (96, 11633, 11775)
			yy_ec_template_31 (an_array)
			an_array.area.fill_with (96, 11859, 11903)
			an_array.area.fill_with (84, 11904, 11929)
			an_array.put (96, 11930)
			an_array.area.fill_with (84, 11931, 12019)
			an_array.area.fill_with (96, 12020, 12031)
			an_array.area.fill_with (84, 12032, 12245)
			an_array.area.fill_with (96, 12246, 12271)
			yy_ec_template_32 (an_array)
			an_array.area.fill_with (96, 12352, 12442)
			yy_ec_template_33 (an_array)
			an_array.area.fill_with (96, 12449, 12538)
			an_array.put (84, 12539)
			an_array.area.fill_with (96, 12540, 12687)
			yy_ec_template_34 (an_array)
			an_array.area.fill_with (96, 12704, 12735)
			an_array.area.fill_with (84, 12736, 12771)
			an_array.area.fill_with (96, 12772, 12799)
			an_array.area.fill_with (84, 12800, 12830)
			an_array.area.fill_with (96, 12831, 12841)
			an_array.area.fill_with (84, 12842, 12871)
			yy_ec_template_35 (an_array)
			an_array.area.fill_with (84, 12896, 12927)
			an_array.area.fill_with (96, 12928, 12937)
			an_array.area.fill_with (84, 12938, 12976)
			an_array.area.fill_with (96, 12977, 12991)
			an_array.area.fill_with (84, 12992, 13311)
			an_array.area.fill_with (96, 13312, 19903)
			an_array.area.fill_with (84, 19904, 19967)
			an_array.area.fill_with (96, 19968, 42127)
			an_array.area.fill_with (84, 42128, 42182)
			an_array.area.fill_with (96, 42183, 42237)
			an_array.area.fill_with (84, 42238, 42239)
			an_array.area.fill_with (96, 42240, 42508)
			an_array.area.fill_with (84, 42509, 42511)
			an_array.area.fill_with (96, 42512, 42610)
			yy_ec_template_36 (an_array)
			an_array.area.fill_with (96, 42623, 42737)
			yy_ec_template_37 (an_array)
			an_array.area.fill_with (96, 42786, 42888)
			an_array.area.fill_with (83, 42889, 42890)
			an_array.area.fill_with (96, 42891, 43047)
			yy_ec_template_38 (an_array)
			an_array.area.fill_with (96, 43066, 43123)
			an_array.area.fill_with (84, 43124, 43127)
			an_array.area.fill_with (96, 43128, 43213)
			an_array.area.fill_with (84, 43214, 43215)
			an_array.area.fill_with (96, 43216, 43255)
			yy_ec_template_39 (an_array)
			an_array.area.fill_with (96, 43261, 43309)
			an_array.area.fill_with (84, 43310, 43311)
			an_array.area.fill_with (96, 43312, 43358)
			an_array.put (84, 43359)
			an_array.area.fill_with (96, 43360, 43456)
			yy_ec_template_40 (an_array)
			an_array.area.fill_with (96, 43488, 43611)
			yy_ec_template_41 (an_array)
			an_array.area.fill_with (96, 43642, 43741)
			yy_ec_template_42 (an_array)
			an_array.area.fill_with (96, 43762, 43866)
			yy_ec_template_43 (an_array)
			an_array.area.fill_with (96, 43884, 44010)
			an_array.put (84, 44011)
			an_array.area.fill_with (96, 44012, 62248)
			an_array.put (84, 62249)
			an_array.area.fill_with (96, 62250, 62385)
			an_array.area.fill_with (83, 62386, 62401)
			an_array.area.fill_with (96, 62402, 62971)
			yy_ec_template_44 (an_array)
			an_array.area.fill_with (96, 63084, 63232)
			yy_ec_template_45 (an_array)
			an_array.area.fill_with (96, 63265, 63291)
			yy_ec_template_46 (an_array)
			an_array.area.fill_with (96, 63297, 63323)
			yy_ec_template_47 (an_array)
			an_array.area.fill_with (96, 63334, 63455)
			yy_ec_template_48 (an_array)
			an_array.area.fill_with (96, 63486, 63743)
			an_array.area.fill_with (84, 63744, 63746)
			an_array.area.fill_with (96, 63747, 63798)
			an_array.area.fill_with (84, 63799, 63807)
			an_array.area.fill_with (96, 63808, 63864)
			yy_ec_template_49 (an_array)
			an_array.area.fill_with (96, 63905, 63951)
			an_array.area.fill_with (84, 63952, 63996)
			an_array.area.fill_with (96, 63997, 64414)
			an_array.put (84, 64415)
			an_array.area.fill_with (96, 64416, 64463)
			an_array.put (84, 64464)
			an_array.area.fill_with (96, 64465, 64878)
			an_array.put (84, 64879)
			an_array.area.fill_with (96, 64880, 65622)
			an_array.put (84, 65623)
			an_array.area.fill_with (96, 65624, 65654)
			an_array.area.fill_with (84, 65655, 65656)
			an_array.area.fill_with (96, 65657, 65822)
			an_array.put (84, 65823)
			an_array.area.fill_with (96, 65824, 65854)
			an_array.put (84, 65855)
			an_array.area.fill_with (96, 65856, 66127)
			an_array.area.fill_with (84, 66128, 66136)
			an_array.area.fill_with (96, 66137, 66174)
			an_array.put (84, 66175)
			an_array.area.fill_with (96, 66176, 66247)
			an_array.put (84, 66248)
			an_array.area.fill_with (96, 66249, 66287)
			an_array.area.fill_with (84, 66288, 66294)
			an_array.area.fill_with (96, 66295, 66360)
			an_array.area.fill_with (84, 66361, 66367)
			an_array.area.fill_with (96, 66368, 66456)
			an_array.area.fill_with (84, 66457, 66460)
			an_array.area.fill_with (96, 66461, 67244)
			an_array.put (84, 67245)
			an_array.area.fill_with (96, 67246, 67412)
			an_array.area.fill_with (84, 67413, 67417)
			an_array.area.fill_with (96, 67418, 67654)
			an_array.area.fill_with (84, 67655, 67661)
			an_array.area.fill_with (96, 67662, 67770)
			yy_ec_template_50 (an_array)
			an_array.area.fill_with (96, 67778, 67903)
			an_array.area.fill_with (84, 67904, 67907)
			an_array.area.fill_with (96, 67908, 67955)
			an_array.area.fill_with (84, 67956, 67957)
			an_array.area.fill_with (96, 67958, 68036)
			yy_ec_template_51 (an_array)
			an_array.area.fill_with (96, 68064, 68151)
			an_array.area.fill_with (84, 68152, 68157)
			an_array.area.fill_with (96, 68158, 68264)
			an_array.put (84, 68265)
			an_array.area.fill_with (96, 68266, 68682)
			yy_ec_template_52 (an_array)
			an_array.area.fill_with (96, 68702, 68805)
			an_array.put (84, 68806)
			an_array.area.fill_with (96, 68807, 69056)
			an_array.area.fill_with (84, 69057, 69079)
			an_array.area.fill_with (96, 69080, 69184)
			an_array.area.fill_with (84, 69185, 69187)
			an_array.area.fill_with (96, 69188, 69215)
			an_array.area.fill_with (84, 69216, 69228)
			an_array.area.fill_with (96, 69229, 69435)
			an_array.area.fill_with (84, 69436, 69439)
			an_array.area.fill_with (96, 69440, 69690)
			an_array.put (84, 69691)
			an_array.area.fill_with (96, 69692, 69955)
			an_array.area.fill_with (84, 69956, 69958)
			an_array.area.fill_with (96, 69959, 70113)
			an_array.put (84, 70114)
			an_array.area.fill_with (96, 70115, 70206)
			an_array.area.fill_with (84, 70207, 70214)
			an_array.area.fill_with (96, 70215, 70297)
			yy_ec_template_53 (an_array)
			an_array.area.fill_with (96, 70307, 70720)
			an_array.area.fill_with (84, 70721, 70725)
			an_array.area.fill_with (96, 70726, 70767)
			an_array.area.fill_with (84, 70768, 70769)
			an_array.area.fill_with (96, 70770, 71414)
			an_array.area.fill_with (84, 71415, 71416)
			an_array.area.fill_with (96, 71417, 71636)
			an_array.area.fill_with (84, 71637, 71665)
			yy_ec_template_54 (an_array)
			an_array.area.fill_with (96, 71680, 72815)
			an_array.area.fill_with (84, 72816, 72820)
			an_array.area.fill_with (96, 72821, 90733)
			an_array.area.fill_with (84, 90734, 90735)
			an_array.area.fill_with (96, 90736, 90868)
			an_array.put (84, 90869)
			an_array.area.fill_with (96, 90870, 90934)
			yy_ec_template_55 (an_array)
			an_array.area.fill_with (96, 90950, 91798)
			an_array.area.fill_with (84, 91799, 91802)
			an_array.area.fill_with (96, 91803, 92129)
			an_array.put (84, 92130)
			an_array.area.fill_with (96, 92131, 111771)
			yy_ec_template_56 (an_array)
			an_array.area.fill_with (96, 111776, 116735)
			an_array.area.fill_with (84, 116736, 116981)
			an_array.area.fill_with (96, 116982, 116991)
			an_array.area.fill_with (84, 116992, 117030)
			an_array.area.fill_with (96, 117031, 117032)
			an_array.area.fill_with (84, 117033, 117092)
			yy_ec_template_57 (an_array)
			an_array.area.fill_with (84, 117132, 117161)
			an_array.area.fill_with (96, 117162, 117165)
			an_array.area.fill_with (84, 117166, 117224)
			an_array.area.fill_with (96, 117225, 117247)
			an_array.area.fill_with (84, 117248, 117313)
			yy_ec_template_58 (an_array)
			an_array.area.fill_with (96, 117318, 117503)
			an_array.area.fill_with (84, 117504, 117590)
			an_array.area.fill_with (96, 117591, 118464)
			an_array.put (84, 118465)
			an_array.area.fill_with (96, 118466, 118490)
			an_array.put (84, 118491)
			an_array.area.fill_with (96, 118492, 118522)
			an_array.put (84, 118523)
			an_array.area.fill_with (96, 118524, 118548)
			an_array.put (84, 118549)
			an_array.area.fill_with (96, 118550, 118580)
			an_array.put (84, 118581)
			an_array.area.fill_with (96, 118582, 118606)
			an_array.put (84, 118607)
			an_array.area.fill_with (96, 118608, 118638)
			an_array.put (84, 118639)
			an_array.area.fill_with (96, 118640, 118664)
			an_array.put (84, 118665)
			an_array.area.fill_with (96, 118666, 118696)
			an_array.put (84, 118697)
			an_array.area.fill_with (96, 118698, 118722)
			an_array.put (84, 118723)
			an_array.area.fill_with (96, 118724, 118783)
			an_array.area.fill_with (84, 118784, 119295)
			an_array.area.fill_with (96, 119296, 119350)
			an_array.area.fill_with (84, 119351, 119354)
			an_array.area.fill_with (96, 119355, 119404)
			yy_ec_template_59 (an_array)
			an_array.area.fill_with (96, 119436, 121166)
			an_array.put (84, 121167)
			an_array.area.fill_with (96, 121168, 121598)
			an_array.put (84, 121599)
			an_array.area.fill_with (96, 121600, 123229)
			an_array.area.fill_with (84, 123230, 123231)
			an_array.area.fill_with (96, 123232, 124075)
			yy_ec_template_60 (an_array)
			an_array.area.fill_with (96, 124081, 124205)
			an_array.put (84, 124206)
			an_array.area.fill_with (96, 124207, 124655)
			an_array.area.fill_with (84, 124656, 124657)
			an_array.area.fill_with (96, 124658, 124927)
			an_array.area.fill_with (84, 124928, 124971)
			an_array.area.fill_with (96, 124972, 124975)
			an_array.area.fill_with (84, 124976, 125075)
			yy_ec_template_61 (an_array)
			an_array.area.fill_with (84, 125137, 125173)
			an_array.area.fill_with (96, 125174, 125196)
			an_array.area.fill_with (84, 125197, 125357)
			an_array.area.fill_with (96, 125358, 125413)
			an_array.area.fill_with (84, 125414, 125442)
			an_array.area.fill_with (96, 125443, 125455)
			an_array.area.fill_with (84, 125456, 125499)
			yy_ec_template_62 (an_array)
			an_array.area.fill_with (96, 125542, 125695)
			an_array.area.fill_with (84, 125696, 125946)
			an_array.area.fill_with (83, 125947, 125951)
			an_array.area.fill_with (84, 125952, 126679)
			yy_ec_template_63 (an_array)
			an_array.area.fill_with (84, 126720, 126835)
			an_array.area.fill_with (96, 126836, 126847)
			an_array.area.fill_with (84, 126848, 126936)
			yy_ec_template_64 (an_array)
			an_array.area.fill_with (84, 126992, 127047)
			yy_ec_template_65 (an_array)
			an_array.area.fill_with (84, 127072, 127111)
			an_array.area.fill_with (96, 127112, 127119)
			an_array.area.fill_with (84, 127120, 127149)
			yy_ec_template_66 (an_array)
			an_array.area.fill_with (96, 127154, 127231)
			an_array.area.fill_with (84, 127232, 127352)
			an_array.put (96, 127353)
			an_array.area.fill_with (84, 127354, 127435)
			an_array.put (96, 127436)
			an_array.area.fill_with (84, 127437, 127571)
			yy_ec_template_67 (an_array)
			an_array.area.fill_with (84, 127632, 127656)
			yy_ec_template_68 (an_array)
			an_array.area.fill_with (96, 127703, 127743)
			an_array.area.fill_with (84, 127744, 127890)
			an_array.put (96, 127891)
			an_array.area.fill_with (84, 127892, 127946)
			an_array.area.fill_with (96, 127947, 127948)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,   96,   96,   96,   96,   96,   96,   96,   96,    1,
			    2,    1,    1,    1,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,    3,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   21,   21,   21,   21,   21,   22,   22,   23,   24,
			   25,   26,   27,   28,    9,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
			   54,   55,   56,   57,   58,   59,   60,   61,   62,   63,

			   64,   65,   66,   35,   67,   68,   38,   39,   69,   41,
			   70,   43,   44,   71,   72,   73,   74,   75,   76,   51,
			   52,   53,   54,   77,    9,   78,   79, yy_Dummy>>,
			1, 127, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    4,    4,    4,    4,    4,   80,    4,   60,    4,
			   81,   81,   82,   81,    4,   60,    4,    4,   81,   81,
			   60,   81,    4,    4,   60,   81,   81,   81,   81,   81,
			   81,    4,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,    4, yy_Dummy>>,
			1, 56, 160)
		end

	yy_ec_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    4,   81,   81,   81,   81,   81,   81,   81,   81, yy_Dummy>>,
			1, 9, 247)
		end

	yy_ec_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   83,   83,   83,   83,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   96,   96,   96,   96,   96,   83,   83,   83,   83,   83,
			   83,   83,   96,   83,   96,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83, yy_Dummy>>,
			1, 62, 706)
		end

	yy_ec_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   83,   96,   96,   96,   96,   96,   96,   96,   96,   84,
			   96,   96,   96,   96,   96,   83,   83,   96,   84, yy_Dummy>>,
			1, 19, 885)
		end

	yy_ec_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   84,   84,   84, yy_Dummy>>,
			1, 7, 1417)
		end

	yy_ec_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   84,   96,   96,   84,   96,   96,   84, yy_Dummy>>,
			1, 9, 1470)
		end

	yy_ec_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   96,   96,   84,   84, yy_Dummy>>,
			1, 45, 1523)
		end

	yy_ec_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   84,   84,   96,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84, yy_Dummy>>,
			1, 58, 1748)
		end

	yy_ec_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   96,   96,   96,   96,   84,   84, yy_Dummy>>,
			1, 10, 2038)
		end

	yy_ec_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   84, yy_Dummy>>,
			1, 13, 2404)
		end

	yy_ec_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   96,   96,   84,   84,
			   96,   84, yy_Dummy>>,
			1, 12, 2546)
		end

	yy_ec_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   96,   96,   96,   96,   96,   84,   96,
			   96,   96,   96,   84, yy_Dummy>>,
			1, 14, 3191)
		end

	yy_ec_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   84,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   84,   84, yy_Dummy>>,
			1, 29, 3647)
		end

	yy_ec_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   96,   96,   84,   84,   84,   84,   84,
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   84,   96,   84,   96,   84, yy_Dummy>>,
			1, 56, 3841)
		end

	yy_ec_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   96,   84,
			   84,   84,   84,   84,   84,   96,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84, yy_Dummy>>,
			1, 29, 4030)
		end

	yy_ec_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,    1, yy_Dummy>>,
			1, 20, 5741)
		end

	yy_ec_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   96,   84,   84,   84,   84, yy_Dummy>>,
			1, 8, 6100)
		end

	yy_ec_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   96,   84,   84, yy_Dummy>>,
			1, 6, 6464)
		end

	yy_ec_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   96,   84,   84,
			   84,   84,   84,   84, yy_Dummy>>,
			1, 14, 6816)
		end

	yy_ec_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   84,   84,   84,   84,
			   84,   84,   84,   84,   84, yy_Dummy>>,
			1, 35, 7002)
		end

	yy_ec_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   84, yy_Dummy>>,
			1, 20, 7360)
		end

	yy_ec_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   83,   96,   83,   83,   83,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   83,   83,   83,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   83,   83,   83,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   83,   83,
			   83,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   83,   83,   96,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,   96,   96,
			   96,   96,   96,   84,   84,   84,   84,   84,   84,   84,
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   84,

			   84,   84,   84,   84,   84,   85,   84,   96,   96,   96,
			   96,   96,   96,   96,    1,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   96,   96,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   96,   96,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,    1, yy_Dummy>>,
			1, 163, 8125)
		end

	yy_ec_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   84,   84,   84,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 38, 8314)
		end

	yy_ec_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   84,   84,   84,   84,   96,   84,   84,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   96,   84,   84,   84,   96,   96,   96,   96,   96,
			   84,   84,   84,   84,   84,   84,   96,   84,   96,   84,
			   96,   84,   96,   96,   96,   96,   84,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   84,   84,
			   96,   96,   96,   96,   84,   84,   84,   84,   84,   96,
			   96,   96,   96,   96,   84,   84,   84,   84,   96,   84, yy_Dummy>>,
			1, 80, 8448)
		end

	yy_ec_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96, yy_Dummy>>,
			1, 6, 8586)
		end

	yy_ec_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   87,   84,   84,   88, yy_Dummy>>,
			1, 4, 8704)
		end

	yy_ec_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   89,   90, yy_Dummy>>,
			1, 2, 8743)
		end

	yy_ec_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   92,   93,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   84,   94,   95, yy_Dummy>>,
			1, 14, 10214)
		end

	yy_ec_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   84,   84,   84,   96,   84,   84, yy_Dummy>>,
			1, 27, 11493)
		end

	yy_ec_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   84,   84,   84,   96,
			   96,   84,   96,   96,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   96,   96,
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   84,   84,   84,   84,   84,   96,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   96,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84, yy_Dummy>>,
			1, 83, 11776)
		end

	yy_ec_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   96,   96,   96,   96,    1,   84,   84,   84,
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   84,   84,   96,   96,   96,   96,
			   96,   96,   96,   96,   84,   96,   96,   96,   84,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   84,   96,   96,   96,   96,   96,
			   84,   84,   96,   96,   96,   96,   96,   84,   84,   84, yy_Dummy>>,
			1, 80, 12272)
		end

	yy_ec_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   83,   83,   96,   96,   96,   84, yy_Dummy>>,
			1, 6, 12443)
		end

	yy_ec_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84, yy_Dummy>>,
			1, 16, 12688)
		end

	yy_ec_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   84,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96, yy_Dummy>>,
			1, 24, 12872)
		end

	yy_ec_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   84, yy_Dummy>>,
			1, 12, 42611)
		end

	yy_ec_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   96,   96,   96,   96,
			   96,   96,   96,   96,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   83,   83, yy_Dummy>>,
			1, 48, 42738)
		end

	yy_ec_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   84,   84,   84,   84, yy_Dummy>>,
			1, 18, 43048)
		end

	yy_ec_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   96,   84, yy_Dummy>>,
			1, 5, 43256)
		end

	yy_ec_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   84,
			   84, yy_Dummy>>,
			1, 31, 43457)
		end

	yy_ec_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   84,   84,   84, yy_Dummy>>,
			1, 30, 43612)
		end

	yy_ec_template_42 (an_array: ARRAY [INTEGER])
			-- Fill chunk #42 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   84,   84, yy_Dummy>>,
			1, 20, 43742)
		end

	yy_ec_template_43 (an_array: ARRAY [INTEGER])
			-- Fill chunk #43 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   83,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   83,   83, yy_Dummy>>,
			1, 17, 43867)
		end

	yy_ec_template_44 (an_array: ARRAY [INTEGER])
			-- Fill chunk #44 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   84,   84,   84,   84,   84,   84,   96,   96,   84,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   84,   84,   84,   84,   84,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   84,   84,   96,   96,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   96,   84,   84,
			   84,   84,   84,   96,   96,   96,   96,   96,   96,   84,

			   84,   84,   84,   84,   84,   84,   84,   96,   84,   84,
			   84,   84, yy_Dummy>>,
			1, 112, 62972)
		end

	yy_ec_template_45 (an_array: ARRAY [INTEGER])
			-- Fill chunk #45 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   96,   96,   84,
			   84,   84,   84,   84,   84,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   84,   84,   84,   84,   84,
			   84,   84, yy_Dummy>>,
			1, 32, 63233)
		end

	yy_ec_template_46 (an_array: ARRAY [INTEGER])
			-- Fill chunk #46 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   83,   84,   83, yy_Dummy>>,
			1, 5, 63292)
		end

	yy_ec_template_47 (an_array: ARRAY [INTEGER])
			-- Fill chunk #47 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   84,   96,   96,   84,   96,   96,   84,   84, yy_Dummy>>,
			1, 10, 63324)
		end

	yy_ec_template_48 (an_array: ARRAY [INTEGER])
			-- Fill chunk #48 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   83,   84,   84,   84,   96,   84,   84,
			   84,   84,   84,   84,   84,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   84,   84, yy_Dummy>>,
			1, 30, 63456)
		end

	yy_ec_template_49 (an_array: ARRAY [INTEGER])
			-- Fill chunk #49 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   96,   96,   84,
			   84,   84,   96,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   96,   96,   96,   84, yy_Dummy>>,
			1, 40, 63865)
		end

	yy_ec_template_50 (an_array: ARRAY [INTEGER])
			-- Fill chunk #50 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   96,   84,   84,   84,   84, yy_Dummy>>,
			1, 7, 67771)
		end

	yy_ec_template_51 (an_array: ARRAY [INTEGER])
			-- Fill chunk #51 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   96,   96,   96,   96,   84,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   84,   96,   84,   84,   84, yy_Dummy>>,
			1, 27, 68037)
		end

	yy_ec_template_52 (an_array: ARRAY [INTEGER])
			-- Fill chunk #52 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   84,   84,   96,   84, yy_Dummy>>,
			1, 19, 68683)
		end

	yy_ec_template_53 (an_array: ARRAY [INTEGER])
			-- Fill chunk #53 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   96,   84,   84,   84,   84,   84, yy_Dummy>>,
			1, 9, 70298)
		end

	yy_ec_template_54 (an_array: ARRAY [INTEGER])
			-- Fill chunk #54 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   84, yy_Dummy>>,
			1, 14, 71666)
		end

	yy_ec_template_55 (an_array: ARRAY [INTEGER])
			-- Fill chunk #55 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   96,
			   96,   96,   96,   84,   84, yy_Dummy>>,
			1, 15, 90935)
		end

	yy_ec_template_56 (an_array: ARRAY [INTEGER])
			-- Fill chunk #56 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   84, yy_Dummy>>,
			1, 4, 111772)
		end

	yy_ec_template_57 (an_array: ARRAY [INTEGER])
			-- Fill chunk #57 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   84,   84,   84,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   84,   84,   96,   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 39, 117093)
		end

	yy_ec_template_58 (an_array: ARRAY [INTEGER])
			-- Fill chunk #58 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   84, yy_Dummy>>,
			1, 4, 117314)
		end

	yy_ec_template_59 (an_array: ARRAY [INTEGER])
			-- Fill chunk #59 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   84,   84,   84,   84,   84,   84,   84,   96,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   96,   84,   84,   84,   84,   84,   84,
			   84, yy_Dummy>>,
			1, 31, 119405)
		end

	yy_ec_template_60 (an_array: ARRAY [INTEGER])
			-- Fill chunk #60 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   84,   96,   96,   96,   84, yy_Dummy>>,
			1, 5, 124076)
		end

	yy_ec_template_61 (an_array: ARRAY [INTEGER])
			-- Fill chunk #61 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   96,   96,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   96,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   96, yy_Dummy>>,
			1, 61, 125076)
		end

	yy_ec_template_62 (an_array: ARRAY [INTEGER])
			-- Fill chunk #62 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   96,   96,   96,   96,   96,   96,   96,
			   84,   84,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   84,   84,   84,   84,
			   84,   84, yy_Dummy>>,
			1, 42, 125500)
		end

	yy_ec_template_63 (an_array: ARRAY [INTEGER])
			-- Fill chunk #63 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   96,   96,   96,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   96,   96,   96, yy_Dummy>>,
			1, 40, 126680)
		end

	yy_ec_template_64 (an_array: ARRAY [INTEGER])
			-- Fill chunk #64 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   96,   96,   96,   96, yy_Dummy>>,
			1, 55, 126937)
		end

	yy_ec_template_65 (an_array: ARRAY [INTEGER])
			-- Fill chunk #65 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   96,   96,
			   96,   96,   96,   96, yy_Dummy>>,
			1, 24, 127048)
		end

	yy_ec_template_66 (an_array: ARRAY [INTEGER])
			-- Fill chunk #66 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   84,   84, yy_Dummy>>,
			1, 4, 127150)
		end

	yy_ec_template_67 (an_array: ARRAY [INTEGER])
			-- Fill chunk #67 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   96,   96,   84,   84,
			   84,   84,   84,   96,   96,   96,   84,   84,   84,   96,
			   96,   96,   96,   96,   84,   84,   84,   84,   84,   84,
			   84,   96,   96,   96,   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 60, 127572)
		end

	yy_ec_template_68 (an_array: ARRAY [INTEGER])
			-- Fill chunk #68 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   84,   84,   84,
			   84,   84,   84,   84,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   84,   84,   84,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   84,
			   84,   84,   84,   84,   84,   84, yy_Dummy>>,
			1, 46, 127657)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    1,    3,    4,    3,    5,    6,    3,
			    5,    5,    5,    3,    3,    5,    3,    5,    3,    7,
			    7,    7,    7,    5,    5,    3,    3,    1,    5,    7,
			    7,    7,    7,    7,    7,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    5,    3,    5,    3,    9,
			    3,    7,    7,    7,    7,    7,    7,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    5,    5,    3,
			    3,    5,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,   10,   10,    3,    3,   10, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 859)
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
			   61,   64,   67,   70,   73,   76,   81,   84,   87,   90,
			   93,   96,   99,  102,  105,  108,  111,  114,  117,  120,
			  123,  126,  129,  132,  135,  138,  141,  144,  148,  151,
			  156,  159,  162,  167,  172,  177,  182,  187,  192,  197,
			  202,  207,  210,  213,  218,  223,  225,  227,  229,  231,
			  233,  235,  237,  239,  241,  243,  245,  247,  249,  251,
			  253,  256,  258,  260,  261,  261,  263,  265,  265,  265,

			  265,  266,  267,  268,  269,  269,  270,  271,  272,  273,
			  274,  275,  276,  277,  278,  279,  280,  281,  283,  284,
			  285,  287,  290,  291,  292,  293,  294,  295,  296,  297,
			  300,  300,  303,  303,  304,  306,  307,  308,  309,  310,
			  313,  313,  316,  319,  322,  323,  324,  324,  324,  324,
			  324,  325,  326,  328,  329,  332,  335,  335,  336,  338,
			  341,  342,  343,  343,  344,  345,  346,  347,  348,  349,
			  351,  352,  353,  354,  355,  356,  357,  358,  360,  361,
			  362,  363,  364,  365,  366,  368,  369,  370,  372,  373,
			  374,  375,  376,  377,  378,  380,  381,  382,  383,  384, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  385,  386,  387,  388,  389,  390,  391,  392,  393,  394,
			  397,  400,  400,  403,  403,  406,  406,  409,  409,  412,
			  412,  415,  415,  418,  418,  421,  421,  424,  427,  427,
			  430,  433,  433,  434,  434,  435,  435,  438,  438,  441,
			  441,  442,  443,  443,  444,  445,  446,  447,  448,  448,
			  449,  450,  451,  452,  453,  454,  455,  456,  457,  458,
			  459,  460,  461,  462,  463,  464,  465,  466,  467,  468,
			  469,  471,  472,  473,  473,  474,  475,  476,  477,  479,
			  480,  482,  484,  486,  487,  490,  491,  494,  495,  496,
			  498,  499,  500,  501,  502,  505,  506,  507,  508,  509,

			  511,  512,  513,  516,  519,  521,  524,  525,  527,  528,
			  530,  531,  532,  533,  534,  535,  536,  537,  538,  539,
			  540,  543,  545,  548,  551,  554,  556,  560,  562,  566,
			  567,  569,  570,  571,  572,  573,  574,  575,  576,  577,
			  578,  579,  580,  581,  582,  583,  584,  585,  586,  587,
			  588,  589,  590,  591,  593,  595,  597,  598,  598,  599,
			  599,  601,  604,  605,  608,  609,  612,  613,  614,  615,
			  615,  616,  618,  619,  621,  622,  623,  623,  624,  625,
			  625,  628,  628,  630,  631,  634,  634,  635,  635,  636,
			  637,  638,  640,  642,  643,  644,  645,  646,  647,  648, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  649,  650,  651,  652,  653,  655,  656,  657,  658,  659,
			  660,  661,  662,  663,  664,  665,  666,  667,  668,  669,
			  671,  672,  674,  675,  676,  677,  678,  679,  680,  681,
			  682,  683,  684,  685,  686,  687,  688,  689,  690,  691,
			  692,  693,  694,  695,  696,  697,  699,  702,  703,  705,
			  707,  709,  711,  713,  715,  717,  719,  722,  723,  725,
			  728,  729,  731,  733,  735,  736,  736,  736,  737,  738,
			  739,  740,  741,  742,  743,  744,  744,  747,  747,  749,
			  749,  752,  752,  753,  754,  755,  756,  757,  758,  760,
			  760,  762,  765,  768,  771,  772,  773,  774,  775,  777,

			  778,  780,  783,  785,  787,  789,  790,  791,  792,  793,
			  794,  795,  796,  797,  798,  799,  800,  801,  802,  803,
			  804,  805,  806,  807,  808,  809,  810,  811,  812,  813,
			  814,  815,  816,  817,  817,  818,  820,  822,  824,  825,
			  825,  825,  826,  827,  827,  827,  827,  827,  827,  828,
			  829,  831,  833,  834,  835,  836,  837,  838,  839,  840,
			  841,  842,  843,  844,  845,  846,  847,  849,  850,  851,
			  852,  853,  854,  855,  857,  858,  859,  860,  861,  862,
			  863,  865,  866,  868,  870,  871,  873,  875,  876,  877,
			  878,  879,  880,  881,  882,  883,  884,  885,  886,  888, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  889,  891,  893,  894,  895,  896,  897,  898,  900,  902,
			  904,  906,  908,  909,  909,  909,  909,  909,  910,  911,
			  912,  914,  916,  917,  919,  920,  922,  923,  925,  927,
			  929,  932,  935,  936,  936,  936,  936,  936,  937,  937,
			  938,  938,  939,  940,  941,  942,  944,  946,  947,  948,
			  949,  951,  953,  954,  955,  956,  958,  959,  960,  961,
			  962,  963,  964,  965,  967,  968,  969,  970,  971,  972,
			  973,  974,  976,  977,  977,  978,  978,  979,  980,  981,
			  982,  983,  984,  985,  986,  988,  989,  990,  992,  994,
			  995,  996,  998,  999,  999,  999,  999, 1000, 1001, 1002,

			 1003, 1004, 1004, 1004, 1004, 1004, 1004, 1004, 1005, 1006,
			 1006, 1006, 1007, 1009, 1011, 1012, 1013, 1014, 1016, 1017,
			 1018, 1019, 1020, 1022, 1024, 1025, 1027, 1028, 1029, 1031,
			 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1038, 1039, 1040,
			 1041, 1042, 1044, 1045, 1047, 1049, 1051, 1052, 1053, 1055,
			 1056, 1057, 1057, 1058, 1058, 1059, 1059, 1060, 1061, 1062,
			 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1064, 1065, 1065, 1065, 1066, 1066, 1067, 1067, 1068,
			 1069, 1071, 1072, 1074, 1075, 1076, 1077, 1078, 1080, 1082,
			 1083, 1085, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1095, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1096, 1097, 1099, 1101, 1102, 1103, 1104, 1106, 1107, 1109,
			 1110, 1111, 1111, 1112, 1112, 1113, 1114, 1114, 1114, 1115,
			 1117, 1118, 1120, 1122, 1123, 1125, 1127, 1129, 1130, 1132,
			 1132, 1133, 1134, 1136, 1137, 1139, 1141, 1142, 1144, 1146,
			 1147, 1147, 1148, 1150, 1151, 1153, 1153, 1154, 1156, 1158,
			 1160, 1162, 1162, 1163, 1163, 1164, 1164, 1166, 1167, 1167, yy_Dummy>>,
			1, 60, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1166)
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
			    0,  235,  235,  237,  237,  271,  269,  270,    1,  269,
			  270,    1,  270,   88,  269,  270, -364,  238,  269,  270,
			   87,   88,  269,  270, -364,   16,  269,  270,  203,  269,
			  270,   33,  269,  270,   34,  269,  270,   43,   88,  269,
			  270, -364,   39,   88,  269,  270, -364,    9,  269,  270,
			   41,  269,  270,   15,  269,  270,   45,   88,  269,  270,
			 -364,  168,  269,  270,  168,  269,  270,    8,  269,  270,
			    7,  269,  270,   21,  269,  270,   19,   88,  269,  270,
			 -364,   23,  269,  270,   11,  269,  270,  167,  269,  270,
			  167,  269,  270,  167,  269,  270,  167,  269,  270,  167,

			  269,  270,  167,  269,  270,  167,  269,  270,  167,  269,
			  270,  167,  269,  270,  167,  269,  270,  167,  269,  270,
			  167,  269,  270,  167,  269,  270,  167,  269,  270,  167,
			  269,  270,  167,  269,  270,  167,  269,  270,  167,  269,
			  270,   37,  269,  270,   88,  269,  270, -364,   38,  269,
			  270,   47,   88,  269,  270, -364,   35,  269,  270,   36,
			  269,  270,   13,   88,  269,  270, -364,   63,   88,  269,
			  270, -364,   73,   88,  269,  270, -364,   83,   88,  269,
			  270, -364,   59,   88,  269,  270, -364,   61,   88,  269,
			  270, -364,   75,   88,  269,  270, -364,   79,   88,  269, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  270, -364,   85,   88,  269,  270, -364,   69,  269,  270,
			   71,  269,  270,   67,   88,  269,  270, -364,   65,   88,
			  269,  270, -364,  239,  270,  268,  270,  266,  270,  267,
			  270,  235,  270,  235,  270,  234,  270,  233,  270,  235,
			  270,  237,  270,  236,  270,  231,  270,  231,  270,  230,
			  270,    6,  270,    5,    6,  270,    5,  270,    6,  270,
			    1,   92,  -94,   88, -363,  238,  238,  227,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238, -499,  238,  238,  238, -499,   87,   88, -363,
			   87,   87,   87,   87,  203,  203,  203,   44,   92,  -94,

			   40,   92,  -94,   42,   88, -364,    2,   49,   10,  174,
			   46,   92,  -94,   55,   88, -363,   31,   88, -363,   29,
			   88, -363,  174,  168,   17,   22,   88, -364,   51,   25,
			   88, -364,   20,   92,  -94,   24,   88, -364,   27,   88,
			 -364,   53,   12,   18,  167,  167,  167,  167,  167,  100,
			  167,  167,  167,  167,  167,  167,  167,  167,  113,  167,
			  167,  167,  167,  167,  167,  167,  125,  167,  167,  167,
			  131,  167,  167,  167,  167,  167,  167,  167,  143,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,   57,   88, -363,   48,   92,  -94, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   14,   92,  -94,   64,   92,  -94,   74,   92,  -94,   84,
			   92,  -94,   60,   92,  -94,   62,   92,  -94,   76,   92,
			  -94,   77,   88, -363,   80,   92,  -94,   81,   88, -363,
			   86,   92,  -94,   70,   72,   68,   92,  -94,   66,   92,
			  -94,  239,  266,  256,  254,  255,  257,  258,  259,  260,
			  240,  241,  242,  243,  244,  245,  246,  247,  248,  249,
			  250,  251,  252,  253,  235,  234,  233,  235,  235,  232,
			  233,  237,  236,  230,    5,    4,    2,   92,  -93,   88,
			   88, -361,   88, -360,   88, -363,  -94,   88, -361, -363,
			   88,   88, -360, -363,  228,  238,  226,  228,  238,  238,

			  238,  238,  225,  226,  228,  238,  238,  238,  238,  238,
			 -499, -499,  238,  211,  226,  228,  209,  226,  228,  210,
			  228,  212,  226,  228,  238,  205,  228,  238,  206,  228,
			  238,  238,  238,  238,  238,  238,  238, -229,  238,  238,
			  213,  226,  228,   87,   88,   87,   88, -361,   87,   88,
			 -360,   87,   88, -363,   87,  -94,   87,   88, -361, -363,
			   87,   88,   87,   88, -360, -363,  203,  175,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  203,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  203,  203,  203,
			  203,  176,  203,   44,  -94,   40,  -94,   50,  174,   46, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  -94,   56,   92,  -93,   88,   32,   92,  -93,   88,   30,
			   92,  -93,   88,  169,  174,  168,  172,  173,  173,  171,
			  173,  170,  168,   22,   52,   26,   92,  -94,   20,  -94,
			   24,   28,   92,  -94,   54,  167,  167,  167,   98,  167,
			   99,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  116,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  135,
			  167,  167,  138,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  166,  167,   58,

			   92,  -93,   88,   48,  -94,   14,  -94,   64,  -94,   74,
			  -94,   84,  -94,   60,  -94,   62,  -94,   76,  -94,   78,
			   92,  -93,   88,   80,  -94,   82,   92,  -93,   88,   86,
			  -94,   68,  -94,   66,  -94,  265,    4,    4,   89,  -93,
			  -91,   88,  -90,   88,  -91,   92,  -93,   89,   92,  -90,
			   92,  -93,  238,  238,  238,  238,  238,  238,  225,  228,
			  217,  228,  214,  226,  228,  207,  226,  228,  208,  226,
			  228,  238,  238,  238,  238,  222,  228,  238,  216,  228,
			  215,  226,  228,   87,  -93,   87,   88,   87,   88,   87,
			   87,   87,   87,  193,  191,  192,  194,  195,  204,  204, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  196,  197,  177,  178,  179,  180,  181,  182,  183,  184,
			  185,  186,  187,  188,  189,  190,  174,  174,   56,  -93,
			   32,  -93,   30,  -93,  174,  174,  168,  168,  168,   26,
			  -94,   28,  -94,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  114,  167,  167,
			  167,  167,  167,  167,  167,  123,  167,  167,  167,  167,
			  167,  167,  167,  132,  167,  167,  134,  167,  136,  167,
			  167,  141,  167,  142,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  155,  167,  167,  157,
			  167,  158,  167,  167,  167,  167,  167,  167,  164,  167,

			  165,  167,   58,  -93,   78,  -93,   82,  -93,  261,    4,
			  -91,  -90,  -91,  -93,  -90,  -93,  238,  218,  228,  238,
			  221,  228,  238,  224,  228,   87,  -91,   87,  -90,   87,
			  -91,  -93,   87,  -90,  -93,  204,  174,  174,  174,  174,
			  168,  167,   96,  167,   97,  167,  167,  167,  167,  104,
			  167,  105,  167,  167,  167,  167,  110,  167,  167,  167,
			  167,  167,  167,  167,  167,  121,  167,  167,  167,  167,
			  167,  167,  167,  167,  133,  167,  167,  139,  167,  167,
			  167,  167,  167,  167,  167,  167,  152,  167,  167,  167,
			  156,  167,  159,  167,  167,  167,  162,  167,  167,    4, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  238,  238,  238,  198,  174,  174,  174,   95,  167,  101,
			  167,  167,  167,  167,  107,  167,  167,  167,  167,  167,
			  115,  167,  117,  167,  167,  119,  167,  167,  167,  124,
			  167,  167,  167,  167,  167,  167,  167,  140,  167,  167,
			  167,  167,  148,  167,  167,  150,  167,  151,  167,  153,
			  167,  167,  167,  161,  167,  167,  264,  263,  262,    4,
			  238,  238,  238,  174,  174,  174,  174,  167,  167,  106,
			  167,  167,  109,  167,  167,  167,  167,  167,  122,  167,
			  126,  167,  167,  128,  167,  129,  167,  167,  167,  167,
			  167,  167,  167,  149,  167,  167,  167,  163,  167,    3,

			    4,  238,  238,  238,  201,  202,  202,  200,  202,  199,
			  174,  174,  174,  174,  174,  102,  167,  167,  108,  167,
			  111,  167,  167,  118,  167,  120,  167,  127,  167,  167,
			  137,  167,  167,  167,  146,  167,  167,  154,  167,  160,
			  167,  238,  220,  228,  223,  228,  174,  174,  103,  167,
			  167,  130,  167,  167,  145,  167,  147,  167,  219,  228,
			  112,  167,  167,  167,  144,  167,  144, yy_Dummy>>,
			1, 167, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2451
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 858
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 859
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 96
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

	yyNb_rules: INTEGER = 270
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 271
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
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
