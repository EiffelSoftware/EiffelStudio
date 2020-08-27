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
			create an_array.make_filled (0, 0, 2792)
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
			an_array.area.fill_with (858, 2687, 2792)
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
			   14,   38,   39,   40,   41,   42,   43,   39,   39,   44,
			   39,   39,   45,   39,   46,   47,   48,   39,   49,   50,
			   51,   52,   53,   54,   55,   39,   39,   60,   61,   62,
			   63,   14,   64,   14,   17,   17,   65,   66,   67,   68,

			   69,   70,   71,   72,   73,   74,   14,   76,   76,  266,
			   77,   77,  267,   78,   78,   80,   81,   80,  704,   82,
			   80,   81,   80,  702,   82,   87,   88,   87,   87,   88,
			   87,   90,   91,   90,   90,   91,   90,   93,   93,   93,
			   93,   93,   93,   95,   95,   95,   92,  283,  127,   92,
			  128,  266,   94,  695,  270,   94,  284,  285,   97,  129,
			  129,  129,  131,  131,  131,  374,  858,   98,  286,   99,
			  372,   83,  285,  190,  130,  354,   83,  132,  133,  133,
			  133,  284,  700,   98,  284,   99,   98,  137,   99,  138,
			  138,  138,  138,  135,  197,  204,  161,  161,  161,  139, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  139,  139,   83,  767,  136,  190,  305,   83,  101,  102,
			  103,  162,  104,  103,  140,  105,  141,  106,  107,  306,
			  108,  163,  109,   98,  142,   99,  197,  204,  809,  110,
			  101,  111,  144,  112,  145,  145,  145,  145,  176,  207,
			  144,  113,  145,  145,  145,  145,  114,  115,  177,  355,
			  287,  188,  208,  146,  147,  360,  116,  189,  284,  117,
			  118,  101,  119,  101,  284,  112,  155,  155,  155,  266,
			  176,  207,  267,  113,  149,  148,  371,  371,  114,  115,
			  177,  156,  149,  188,  208,  146,  147,  143,  116,  189,
			   98,  120,   99,  101,  101,  309,  101,  377,  101,  101,

			  101,  101,  101,  101,  101,  101,  101,  148,  101,  101,
			   95,   95,   95,  121,  287,  121,  310,  104,  121,  273,
			  274,  273,  121,  121,  858,  123,  205,  121,  151,  151,
			  151,  157,  157,  157,  124,  121,  125,   96,  165,  178,
			  206,  179,  166,  152,  181,  300,  158,  167,  182,  168,
			  201,  180,  153,  154,  169,  170,  159,  160,  205,  266,
			  202,  183,  270,  203,  120,  121,  382,  121,  121,  121,
			  165,  178,  206,  179,  166,  284,  181,  300,  289,  167,
			  182,  168,  201,  180,  171,  808,  169,  170,  172,  101,
			  388,  173,  202,  183,  174,  203,  120,  175,  121,  121, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  195,  121,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,  184,  389,   96,   96,  191,  171,  196,  185,  186,
			  172,  383,  388,  173,  187,  192,  174,  193,  392,  175,
			  198,  194,  195,  210,  210,  210,  282,  268,  266,  268,
			  199,  267,  282,  184,  389,  200,  763,  191,  211,  196,
			  185,  186,   95,   95,   95,  393,  187,  192,  807,  193,
			  392,   96,  198,  194,  212,  212,  212,   97,  214,  214,
			  214,  858,  199,  275,  275,  275,   98,  200,   99,  213,
			  216,  216,  216,  215,  218,  218,  218,  393,   96,  220,
			  220,  220,  806,  269,  394,  217,  222,  222,  222,  219,

			  224,  224,  224,  287,  221,  395,  104,  209,  275,  275,
			  275,  223,  227,  227,  227,  225,  230,  230,  230,   96,
			  373,  373,  373,   96,  269,  294,  394,  228,  232,  232,
			  232,  231,  234,  234,  234,   96,  103,  395,  802,   96,
			  755,  313,  396,  233,   96,  327,  673,  235,  236,  236,
			  236,   96,  756,  120,  122,   96,  328,  238,  238,  238,
			   93,   93,   93,  237,  278,  278,  278,   96,  356,  356,
			  356,   96,  239,  313,  396,   94,  397,  398,  307,  279,
			  273,  274,  273,  357,  287,  120,  399,  104,  280,  101,
			  281,  301,  754,  448,  226,  361,  361,  361,  100,  308, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  101,  287,  284,   96,  104,  736,  229,  449,  397,  398,
			  362,  700,   96,  242,  242,  242,  284,  243,  399,  280,
			  244,  281,  245,  246,  247,  316,  317,  316,  287,  287,
			  248,  104,  104,  755,  120,  762,  450,  249,  311,  250,
			  451,  251,  252,  253,  254,  284,  255,  122,  256,  284,
			  403,  120,  257,  287,  258,  408,  104,  259,  260,  261,
			  262,  263,  264,  288,  289,  288,  120,  104,  288,  314,
			  311,  452,  288,  288,  122,  290,  763,  288,  120,  120,
			  284,  318,  403,  120,  291,  288,  292,  408,  409,  312,
			  696,  453,  287,  410,  144,  104,  370,  370,  370,  370,

			  284,  314,  367,  120,  546,  411,  858,  858,  858,  390,
			  120,  120,  391,  416,  120,  288,  544,  288,  288,  288,
			  409,  312,  316,  317,  316,  410,  287,  693,  693,  104,
			  315,  375,  375,  375,  375,  120,  149,  411,  275,  275,
			  275,  390,  120,  406,  391,  416,  120,  407,  288,  288,
			  631,  288,  288,  288,  288,  288,  288,  288,  288,  288,
			  288,  122,  315,  288,  288,  100,  630,  100,  293,  294,
			  293,  376,  104,  293,  120,  406,  120,  293,  293,  407,
			  296,  502,  293,  358,  358,  358,  358,  701,  701,  297,
			  293,  298,  363,  363,  363,  419,  420,  359,  858,  858, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  858,  858,  858,  858,  364,  120,  858,
			  858,  365,  365,  365,  421,  424,  280,  425,  281,  299,
			  293,  294,  293,  293,  293,  454,  366,  419,  420,  359,
			  378,  378,  378,  289,  284,  280,  367,  281,  368,  368,
			  368,  368,  434,  435,  617,  379,  421,  424,  386,  425,
			  436,  299,  369,  293,  293,  378,  293,  288,  288,  288,
			  288,  288,  288,  288,  288,  288,  100,  100,  288,  288,
			  100,  101,  304,  101,  434,  435,  101,  437,  546,  438,
			  101,  101,  436,  100,  369,  101,  380,  380,  380,  384,
			  384,  384,  101,  101,  100,  386,  386,  386,  400,  404,

			  442,  381,  401,  412,  385,  417,  422,  413,  443,  437,
			  387,  438,  544,  444,  405,  423,  402,  418,  414,  455,
			  445,  415,  552,  101,  458,  101,  101,  101,  284,  356,
			  400,  404,  442,  284,  401,  412,  766,  417,  422,  413,
			  443,   96,  371,  371,   96,  444,  405,  423,  402,  418,
			  414,  432,  445,  415,  552,  433,  101,  101,  531,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  530,
			  553,  101,  101,  278,  278,  278,  121,  767,  121,  439,
			  461,  121,  543,  432,  440,  121,  121,  433,  321,  284,
			  121,  426,  529,  427,  462,  441,  463,  322,  121,  323, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  528,  428,  553,  284,  429,  284,  430,  431,  242,  242,
			  242,  439,  554,  482,  527,  464,  440,  526,  555,  446,
			  446,  446,  483,  426,  484,  427,  103,  441,  121,  525,
			  121,  121,  121,  428,  447,  295,  429,  103,  430,  431,
			  489,  317,  489,  280,  554,  281,  465,  466,  466,  466,
			  555,  268,  266,  268,  283,  267,  514,  515,  515,  515,
			  558,  121,  121,  284,  121,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,  524,  550,   96,   96,  858,  858,
			  858,  324,  490,  324,  284,  104,  324,  694,  694,  694,
			  324,  324,  558,  325,  300,  324,  456,  456,  456,  459,

			  459,  459,  326,  324,  469,  469,  469,  269,  559,  523,
			  522,  457,  283,  521,  460,  471,  471,  471,  505,  470,
			  280,  284,  281,  280,  520,  281,  300,  124,  284,  125,
			  472,  287,  120,  324,  519,  324,  324,  324,  269,  858,
			  559,  286,  101,  491,  473,  473,  473,  278,  278,  278,
			  533,  100,  533,  101,  482,  534,  534,  534,  534,  474,
			  518,  517,  475,  483,  120,  484,  324,  324,  284,  324,
			  282,  282,  282,  282,  282,  282,  282,  282,  282,  516,
			  513,  282,  282,  331,  287,  551,  332,  104,  333,  334,
			  335,  476,  476,  476,  284,  512,  336,  560,  478,  478, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  478,  511,   96,  337,  561,  338,  477,  339,  340,  341,
			  342,  494,  343,  479,  344,  480,  480,  480,  345,  287,
			  346,  510,  104,  347,  348,  349,  350,  351,  352,  560,
			  481,  509,  493,  497,  120,  498,  561,  287,  104,  500,
			  104,  287,  104,  494,  104,  501,   96,  492,  316,  317,
			  316,  470,  287,   96,  103,  104,  482,  287,  495,  620,
			  284,  468,  469,  469,  469,  483,  120,  484,  284,  120,
			   96,  100,  858,  100,  293,  294,  293,  502,  104,  293,
			  496,  284,  499,  293,  293,  120,  485,  120,  293,  120,
			  495,  120,  471,  471,  471,  486,  293,  487,  473,  473,

			  473,  120,  120,  858,  858,  858,  621,  503,  272,  476,
			  476,  476,  496,  504,  499,  284,  122,  120,  328,  120,
			  562,  120,  858,  120,  506,  299,  293,  241,  293,  293,
			  293,  284,  234,  124,  120,  125,  532,  532,  532,  532,
			  538,  538,  538,  538,  858,  373,  373,  373,  563,  232,
			  359,  564,  562,  284,  539,  565,  566,  299,  161,  293,
			  293,  567,  293,  288,  288,  288,  288,  288,  288,  288,
			  288,  288,  100,  100,  288,  288,  100,  100,  133,  100,
			  563,  488,  359,  564,  104,  545,  539,  565,  566,  478,
			  478,  478,   96,  567,  353,  858,  858,  858,  858,  858, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  858,  507,  570,  858,  858,  480,  480,
			  480,  330,  571,  124,  572,  125,  327,  320,  469,  469,
			  469,  568,  319,  508,  469,  469,  469,  303,  469,  469,
			  469,  299,  124,  535,  125,  569,  575,  570,  302,  536,
			  277,  276,  284,  537,  571,  272,  572,  241,  284,  540,
			  150,  540,  284,  568,  541,  541,  541,  541,  576,  549,
			  549,  549,  549,  299,  703,  703,  703,  569,  575,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  103,  488,  103,  577,  578,  103,  579,
			  576,  580,  103,  103,  581,  295,  556,  103,  144,  376,

			  542,  542,  542,  542,  103,  103,  295,  547,  858,  548,
			  548,  548,  548,  557,  573,  582,  583,   85,  577,  578,
			  584,  579,  585,  580,  586,  587,  581,  574,  556,  588,
			  589,  590,  591,  592,  595,  103,   85,  103,  103,  103,
			  149,  534,  534,  534,  534,  557,  573,  582,  583,  376,
			  596,  858,  584,  858,  585,  858,  586,  587,  597,  574,
			  858,  588,  589,  590,  591,  592,  595,  598,  103,  103,
			  593,  103,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  599,  596,  101,  101,  316,  317,  316,  594,  488,
			  597,  600,  104,  601,  602,  603,  604,  605,  606,  598, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  607,  608,  593,  534,  534,  534,  534,  469,  469,  469,
			  858,  644,  858,  599,  858,  612,  466,  466,  466,  466,
			  594,  645,  609,  600,  858,  601,  602,  603,  604,  605,
			  606,  284,  607,  608,  469,  469,  469,  646,  858,  299,
			  469,  469,  469,  644,  478,  478,  478,  858,  858,  610,
			  478,  478,  478,  645,  858,  611,  616,  858,  284,  618,
			  489,  317,  489,  287,  284,  619,  104,  858,  622,  646,
			  623,  299,  625,  104,  858,  104,  858,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  612,  466,  466,  466,  466,  289,  294,  624,   96,

			  858,  647,  858,  613,  614,   96,  287,  101,  103,  104,
			  648,  858,  627,  120,  300,  104,  100,  295,  101,  103,
			  120,  649,  120,  650,  858,  615,  858,  858,  858,  651,
			  624,  858,  616,  647,  626,  613,  614,  632,  515,  515,
			  515,  515,  648,  371,  371,  120,  300,  858,  478,  478,
			  478,  858,  120,  649,  120,  650,  120,  615,  478,  478,
			  478,  651,  120,  628,  858,  858,  626,  632,  515,  515,
			  515,  515,  124,  629,  125,  652,  858,  858,  636,  633,
			  634,  858,  124,  543,  125,  653,  858,  858,  120,  858,
			  639,  639,  639,  639,  120,  637,  637,  637,  637,  654, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  858,  635,  858,  858,  539,  858,  858,  652,  636,  359,
			  858,  633,  634,  541,  541,  541,  541,  653,  858,  858,
			  858,  858,  858,  858,  858,  858,  858,  655,  858,  858,
			  858,  654,  640,  635,  640,  638,  539,  641,  641,  641,
			  641,  359,  541,  541,  541,  541,  642,  656,  542,  542,
			  542,  542,  547,  657,  643,  643,  643,  643,  547,  655,
			  549,  549,  549,  549,  658,  659,  660,  661,  858,  662,
			  663,  664,  665,  666,  667,  668,  669,  670,  671,  656,
			  672,  164,  164,  164,  676,  657,  677,  678,  376,  679,
			  680,  681,  682,  683,  376,  684,  658,  659,  660,  661,

			  376,  662,  663,  664,  665,  666,  667,  668,  669,  670,
			  671,  685,  672,  673,  673,  673,  676,  674,  677,  678,
			  686,  679,  680,  681,  682,  683,  687,  684,  675,  688,
			  689,  690,  691,  692,  466,  466,  466,  466,  287,  287,
			  712,  104,  104,  685,  287,  858,  858,  104,  858,  858,
			  858,  858,  686,  705,  705,  705,  705,  858,  687,  713,
			  714,  688,  689,  690,  691,  692,  858,  858,  858,  715,
			  716,  698,  712,  858,  616,  707,  707,  707,  707,  699,
			  719,  697,  637,  637,  637,  637,  717,  720,  120,  120,
			  718,  713,  714,  636,  120,  721,  706,  858,  722,  674, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  858,  715,  716,  698,  641,  641,  641,  641,  858,  858,
			  858,  699,  719,  697,  641,  641,  641,  641,  717,  720,
			  120,  120,  718,  723,  724,  725,  120,  721,  706,  711,
			  722,  549,  549,  549,  549,  708,  708,  708,  708,  858,
			  858,  858,  858,  858,  858,  858,  858,  858,  858,  539,
			  726,  858,  858,  727,  728,  723,  724,  725,  858,  858,
			  858,  858,  858,  858,  858,  858,  858,  729,  730,  858,
			  858,  149,  731,  732,  367,  709,  708,  708,  708,  708,
			  733,  539,  726,  734,  737,  727,  728,  673,  673,  673,
			  710,  735,  738,  739,  740,  741,  742,  743,  744,  729,

			  730,  745,  675,  746,  731,  732,  747,  748,  749,  750,
			  693,  693,  733,  858,  858,  734,  737,  752,  694,  694,
			  694,  858,  710,  858,  738,  739,  740,  741,  742,  743,
			  744,  287,  858,  745,  104,  746,  778,  858,  747,  748,
			  749,  287,  287,  858,  104,  104,  760,  701,  701,  858,
			  751,  779,  764,  703,  703,  703,  780,  781,  753,  693,
			  693,  858,  757,  768,  705,  705,  705,  705,  778,  758,
			  769,  782,  769,  735,  858,  770,  770,  770,  770,  783,
			  784,  120,  785,  779,  759,  786,  787,  761,  780,  781,
			  788,  120,  120,  765,  757,  771,  771,  771,  771,  751, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  789,  758,  858,  782,  636,  708,  708,  708,  708,  772,
			  858,  783,  784,  120,  785,  790,  759,  786,  787,  773,
			  791,  792,  788,  120,  120,  774,  774,  774,  774,  775,
			  793,  775,  789,  794,  776,  776,  776,  776,  795,  796,
			  367,  772,  774,  774,  774,  774,  797,  790,  798,  799,
			  800,  773,  791,  792,  801,  819,  777,  694,  694,  694,
			  287,  287,  793,  104,  104,  794,  287,  858,  858,  104,
			  795,  796,  770,  770,  770,  770,  820,  821,  797,  858,
			  798,  799,  800,  822,  858,  858,  801,  819,  777,  803,
			  770,  770,  770,  770,  805,  823,  824,  753,  810,  810,

			  810,  810,  804,  858,  815,  815,  815,  815,  820,  821,
			  120,  120,  772,  825,  826,  822,  120,  811,  816,  811,
			  858,  803,  812,  812,  812,  812,  805,  823,  824,  858,
			  813,  827,  813,  858,  804,  814,  814,  814,  814,  828,
			  831,  832,  120,  120,  772,  825,  826,  833,  120,  834,
			  816,  776,  776,  776,  776,  776,  776,  776,  776,  817,
			  835,  817,  772,  827,  818,  818,  818,  818,  829,  829,
			  829,  828,  831,  832,  287,  837,  858,  104,  104,  833,
			  858,  834,  838,  858,  842,  104,  858,  858,  638,  858,
			  843,  858,  835,  858,  772,  858,  858,  858,  830,  812, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  812,  812,  812,  812,  812,  812,  812,  814,  814,  814,
			  814,  836,  814,  814,  814,  814,  842,  839,  839,  839,
			  839,  840,  843,  840,  120,  120,  841,  841,  841,  841,
			  830,  816,  120,  818,  818,  818,  818,  818,  818,  818,
			  818,  844,  858,  836,  829,  829,  829,  846,  847,  848,
			  849,  816,  850,  104,  851,  852,  120,  120,  841,  841,
			  841,  841,  853,  816,  120,  841,  841,  841,  841,  854,
			  855,  856,  857,  844,  845,  858,  858,  709,  858,  846,
			  847,  848,  858,  816,  850,  858,  851,  852,   96,   96,
			   96,  122,  122,  122,  853,  122,   96,  122,  122,  122,

			  120,  854,  855,  856,  857,  858,  845,   75,   75,   75,
			   75,   75,   75,   75,   75,   75,   75,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,  858,  858,  858,
			  858,  858,  120,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   89,   89,   89,   89,   89,   89,   89,
			   89,   89,   89,  100,  858,  100,  100,  100,  100,  100,
			  100,  100,  100,  126,  858,  126,  126,  126,  126,  126,
			  126,  126,  126,  134,  134,  134,  240,  858,  240,  240,
			  240,  134,  240,  240,  240,  240,  265,  265,  265,  265, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  265,  265,  265,  265,  265,  265,  269,  269,  269,  269,
			  269,  269,  269,  269,  269,  269,  271,  271,  271,  271,
			  271,  271,  271,  271,  271,  271,  295,  858,  295,  295,
			  295,  295,  295,  295,  295,  295,  104,  858,  104,  858,
			  104,  104,  104,  104,  104,  104,  329,  858,  329,  329,
			  329,  329,  329,  329,  329,  329,  467,  858,  467,  467,
			  467,  467,  467,  467,  467,  467,  736,  736,  736,  736,
			  736,  736,  736,  736,  736,  736,  802,  858,  802,  802,
			  802,  802,  802,  802,  802,  802,   13, yy_Dummy>>,
			1, 87, 2600)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2792)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 106)
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
			an_array.area.fill_with (858, 2686, 2792)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    4,   79,    3,    4,   79,    3,    4,    5,    5,
			    5,  883,    5,    6,    6,    6,  882,    6,    9,    9,
			    9,   10,   10,   10,   11,   11,   11,   12,   12,   12,
			   15,   15,   15,   16,   16,   16,   17,   17,   17,   11,
			   97,   21,   12,   21,   83,   15,  881,   83,   16,   97,
			   98,   17,   24,   24,   24,   25,   25,   25,  879,   98,
			   17,   98,   17,  878,    5,   99,   46,   24,  130,    6,
			   25,   27,   27,   27,   99,  768,   24,  130,   24,   25,
			   28,   25,   28,   28,   28,   28,   27,   49,   52,   37,
			   37,   37,   29,   29,   29,    5,  767,   27,   46,  109,

			    6,   18,   18,   18,   37,   18,   18,   29,   18,   29,
			   18,   18,  109,   18,   37,   18,   29,   29,   29,   49,
			   52,  766,   18,   18,   18,   31,   18,   31,   31,   31,
			   31,   41,   54,   30,   18,   30,   30,   30,   30,   18,
			   18,   41,  132,  292,   45,   55,   30,   30,  140,   18,
			   45,  132,   18,   18,  292,   18,   18,  140,   18,   35,
			   35,   35,  265,   41,   54,  265,   18,   31,   30,  146,
			  146,   18,   18,   41,   35,   30,   45,   55,   30,   30,
			   29,   18,   45,   35,   18,   35,   18,   18,  111,   18,
			  152,   18,   18,   18,   18,   18,   18,   18,   18,  111, yy_Dummy>>,
			1, 200, 107)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   30,   18,   18,   19,   19,   19,   19,  100,   19,  111,
			  100,   19,   87,   87,   87,   19,   19,  765,   19,   53,
			   19,   34,   34,   34,   36,   36,   36,   19,   19,   19,
			  152,   38,   42,   53,   42,   38,   34,   43,  104,   36,
			   38,   43,   38,   51,   42,   34,   34,   38,   38,   36,
			   36,   53,  269,   51,   43,  269,   51,  100,   19,  156,
			   19,   19,   19,   38,   42,   53,   42,   38,  156,   43,
			  104,  484,   38,   43,   38,   51,   42,   40,  764,   38,
			   38,   40,  484,  165,   40,   51,   43,   40,   51,  100,
			   40,   19,   19,   48,   19,   19,   19,   19,   19,   19,

			   19,   19,   19,   19,   44,  166,   19,   19,   47,   40,
			   48,   44,   44,   40,  158,  165,   40,   44,   47,   40,
			   47,  168,   40,   50,   47,   48,   59,   59,   59,  874,
			   80,   80,   80,   50,   80,  874,   44,  166,   50,  763,
			   47,   59,   48,   44,   44,   57,   57,   57,  169,   44,
			   47,  762,   47,  168,  158,   50,   47,   62,   62,   62,
			   57,   63,   63,   63,  761,   50,   90,   90,   90,   57,
			   50,   57,   62,   64,   64,   64,   63,   65,   65,   65,
			  169,   59,   66,   66,   66,  760,   80,  170,   64,   67,
			   67,   67,   65,   68,   68,   68,  114,   66,  171,  114, yy_Dummy>>,
			1, 200, 307)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   57,   91,   91,   91,   67,   69,   69,   69,   68,   70,
			   70,   70,   62,  147,  147,  147,   63,   80,  487,  170,
			   69,   71,   71,   71,   70,   72,   72,   72,   64,  487,
			  171,  756,   65,  755,  114,  172,   71,   66,  124,  736,
			   72,   73,   73,   73,   67,  696,  114,  124,   68,  124,
			   74,   74,   74,   93,   93,   93,   73,   96,   96,   96,
			   69,  136,  136,  136,   70,   74,  114,  172,   93,  173,
			  174,  110,   96,  273,  273,  273,  136,  105,  114,  175,
			  105,   96,  110,   96,  105,  695,  211,   68,  141,  141,
			  141,  110,  110,  110,  112,  211,   73,  112,  675,   69,

			  213,  173,  174,  141,  632,   74,   78,   78,   78,  213,
			   78,  175,  141,   78,  141,   78,   78,   78,  117,  117,
			  117,  115,  117,   78,  115,  117,  695,  105,  702,  215,
			   78,  112,   78,  217,   78,   78,   78,   78,  215,   78,
			  629,   78,  217,  178,  112,   78,  113,   78,  181,  113,
			   78,   78,   78,   78,   78,   78,  101,  101,  101,  105,
			  101,  101,  115,  112,  219,  101,  101,  628,  101,  702,
			  101,  115,  117,  219,  117,  178,  112,  101,  101,  101,
			  181,  182,  113,  617,  221,  116,  183,  145,  116,  145,
			  145,  145,  145,  221,  115,  547,  113,  546,  185,  122, yy_Dummy>>,
			1, 200, 507)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  122,  122,  167,  115,  117,  167,  188,  101,  101,  544,
			  101,  101,  101,  182,  113,  120,  120,  120,  183,  120,
			  613,  613,  120,  116,  149,  149,  149,  149,  113,  145,
			  185,  275,  275,  275,  167,  116,  180,  167,  188,  101,
			  180,  101,  101,  508,  101,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  507,  116,  101,  101,  103,  506,
			  103,  103,  103,  103,  149,  103,  103,  116,  180,  120,
			  103,  103,  180,  103,  505,  103,  138,  138,  138,  138,
			  633,  633,  103,  103,  103,  142,  142,  142,  190,  191,
			  138,  122,  122,  122,  122,  122,  122,  122,  122,  122,

			  142,  120,  122,  122,  143,  143,  143,  192,  195,  142,
			  196,  142,  103,  103,  485,  103,  103,  103,  223,  143,
			  190,  191,  138,  153,  153,  153,  482,  223,  143,  144,
			  143,  144,  144,  144,  144,  199,  200,  468,  153,  192,
			  195,  387,  196,  201,  103,  144,  103,  103,  379,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  108,  108,  108,  199,  200,  108,
			  202,  374,  203,  108,  108,  201,  108,  144,  108,  154,
			  154,  154,  159,  159,  159,  108,  108,  108,  160,  160,
			  160,  176,  179,  205,  154,  176,  186,  159,  189,  193, yy_Dummy>>,
			1, 200, 707)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  186,  206,  202,  160,  203,  372,  207,  179,  193,  176,
			  189,  186,  225,  208,  186,  388,  108,  228,  108,  108,
			  108,  225,  357,  176,  179,  205,  228,  176,  186,  704,
			  189,  193,  186,  206,  154,  371,  371,  159,  207,  179,
			  193,  176,  189,  186,  198,  208,  186,  388,  198,  108,
			  108,  352,  108,  108,  108,  108,  108,  108,  108,  108,
			  108,  108,  351,  389,  108,  108,  121,  121,  121,  121,
			  704,  121,  204,  231,  121,  371,  198,  204,  121,  121,
			  198,  121,  231,  121,  197,  350,  197,  237,  204,  239,
			  121,  121,  121,  349,  197,  389,  237,  197,  239,  197,

			  197,  242,  242,  242,  204,  390,  288,  348,  242,  204,
			  347,  393,  209,  209,  209,  288,  197,  288,  197,  297,
			  204,  121,  346,  121,  121,  121,  197,  209,  297,  197,
			  297,  197,  197,  300,  300,  300,  209,  390,  209,  248,
			  248,  248,  248,  393,  268,  268,  268,  377,  268,  336,
			  336,  336,  336,  395,  121,  121,  377,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  345,  381,  121,
			  121,  123,  123,  123,  123,  301,  123,  381,  301,  123,
			  614,  614,  614,  123,  123,  395,  123,  300,  123,  226,
			  226,  226,  229,  229,  229,  123,  123,  279,  279,  279, yy_Dummy>>,
			1, 200, 907)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  268,  396,  344,  343,  226,  383,  342,  229,  280,  280,
			  280,  324,  279,  226,  383,  226,  229,  341,  229,  300,
			  324,  279,  324,  280,  291,  301,  123,  340,  123,  123,
			  123,  268,  280,  396,  280,  291,  306,  281,  281,  281,
			  282,  282,  282,  359,  291,  359,  291,  306,  359,  359,
			  359,  359,  281,  339,  338,  282,  306,  301,  306,  123,
			  123,  281,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  337,  335,  123,  123,  127,  311,  385,  127,
			  311,  127,  127,  127,  284,  284,  284,  385,  334,  127,
			  397,  285,  285,  285,  333,  282,  127,  398,  127,  284,

			  127,  127,  127,  127,  311,  127,  285,  127,  286,  286,
			  286,  127,  312,  127,  332,  312,  127,  127,  127,  127,
			  127,  127,  397,  286,  331,  310,  314,  311,  314,  398,
			  313,  314,  318,  313,  315,  318,  311,  315,  319,  284,
			  308,  316,  316,  316,  475,  316,  285,  298,  316,  319,
			  290,  312,  477,  475,  276,  321,  321,  321,  319,  311,
			  319,  477,  312,  286,  293,  479,  293,  293,  293,  293,
			  321,  293,  293,  313,  479,  315,  293,  293,  314,  293,
			  313,  293,  318,  312,  315,  322,  322,  322,  293,  293,
			  293,  323,  323,  323,  312,  316,  325,  325,  325,  481, yy_Dummy>>,
			1, 200, 1107)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  322,  271,  326,  326,  326,  313,  323,  315,  481,  322,
			  314,  322,  313,  399,  318,  618,  315,  326,  293,  293,
			  240,  293,  293,  293,  618,  235,  326,  316,  326,  358,
			  358,  358,  358,  368,  368,  368,  368,  619,  373,  373,
			  373,  400,  233,  358,  401,  399,  619,  368,  402,  403,
			  293,  162,  293,  293,  405,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  295,  135,  295,  400,  295,  358,  401,  295,  373,  368,
			  402,  403,  327,  327,  327,  134,  405,  128,  325,  325,
			  325,  325,  325,  325,  325,  325,  325,  327,  407,  325,

			  325,  328,  328,  328,  126,  408,  327,  409,  327,  125,
			  119,  362,  362,  362,  406,  118,  328,  364,  364,  364,
			  107,  366,  366,  366,  295,  328,  362,  328,  406,  411,
			  407,  106,  364,   94,   92,  362,  366,  408,   84,  409,
			   75,  364,  369,   32,  369,  366,  406,  369,  369,  369,
			  369,  412,  376,  376,  376,  376,  295,  634,  634,  634,
			  406,  411,  295,  295,  295,  295,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  295,  296,  296,  296,  413,
			  414,  296,  415,  412,  416,  296,  296,  417,  296,  394,
			  296,  370,  376,  370,  370,  370,  370,  296,  296,  296, yy_Dummy>>,
			1, 200, 1307)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  375,   13,  375,  375,  375,  375,  394,  410,  418,  419,
			    8,  413,  414,  420,  415,  422,  416,  423,  424,  417,
			  410,  394,  425,  426,  427,  428,  429,  431,  296,    7,
			  296,  296,  296,  370,  533,  533,  533,  533,  394,  410,
			  418,  419,  375,  432,    0,  420,    0,  422,    0,  423,
			  424,  433,  410,    0,  425,  426,  427,  428,  429,  431,
			  434,  296,  296,  430,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,  296,  435,  432,  296,  296,  299,  299,
			  299,  430,  299,  433,  436,  299,  437,  438,  439,  440,
			  441,  442,  434,  443,  444,  430,  534,  534,  534,  534,

			  447,  447,  447,    0,  552,    0,  435,    0,  466,  466,
			  466,  466,  466,  430,  553,  447,  436,    0,  437,  438,
			  439,  440,  441,  442,  447,  443,  444,  457,  457,  457,
			  554,    0,  299,  460,  460,  460,  552,  472,  472,  472,
			    0,    0,  457,  474,  474,  474,  553,    0,  460,  466,
			    0,  457,  472,  489,  489,  489,  495,  460,  474,  495,
			    0,  494,  554,  494,  299,  496,  494,    0,  496,    0,
			  299,  299,  299,  299,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  465,  465,  465,  465,  465,  483,
			  486,  495,  472,    0,  555,    0,  465,  465,  474,  497, yy_Dummy>>,
			1, 200, 1507)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  483,  486,  497,  556,    0,  499,  495,  489,  499,  483,
			  486,  483,  486,  494,  557,  496,  558,    0,  465,  502,
			  502,  502,  559,  495,    0,  465,  555,  497,  465,  465,
			  515,  515,  515,  515,  515,  556,  543,  543,  495,  489,
			    0,  503,  503,  503,    0,  494,  557,  496,  558,  497,
			  465,  504,  504,  504,  559,  499,  503,    0,    0,  497,
			  514,  514,  514,  514,  514,  503,  504,  503,  560,    0,
			    0,  515,  514,  514,    0,  504,  543,  504,  561,    0,
			    0,  497,    0,  538,  538,  538,  538,  499,  532,  532,
			  532,  532,  562,    0,  514,    0,    0,  538,    0,    0,

			  560,  514,  532,    0,  514,  514,  540,  540,  540,  540,
			  561,  502,  502,  502,  502,  502,  502,  502,  502,  502,
			  563,    0,  502,  502,  562,  539,  514,  539,  532,  538,
			  539,  539,  539,  539,  532,  541,  541,  541,  541,  542,
			  564,  542,  542,  542,  542,  548,  565,  548,  548,  548,
			  548,  549,  563,  549,  549,  549,  549,  566,  567,  568,
			  569,    0,  570,  571,  572,  574,  575,  576,  577,  578,
			  579,  581,  564,  584,  869,  869,  869,  587,  565,  588,
			  589,  542,  590,  591,  592,  593,  594,  548,  595,  566,
			  567,  568,  569,  549,  570,  571,  572,  574,  575,  576, yy_Dummy>>,
			1, 200, 1707)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  577,  578,  579,  581,  596,  584,  585,  585,  585,  587,
			  585,  588,  589,  597,  590,  591,  592,  593,  594,  599,
			  595,  585,  602,  603,  604,  605,  606,  616,  616,  616,
			  616,  622,  624,  644,  622,  624,  596,  626,    0,    0,
			  626,  630,  630,  630,    0,  597,  636,  636,  636,  636,
			    0,  599,  647,  648,  602,  603,  604,  605,  606,  631,
			  631,  631,  649,  652,  624,  644,    0,  616,  638,  638,
			  638,  638,  626,  654,  622,  637,  637,  637,  637,  653,
			  656,  622,  624,  653,  647,  648,  636,  626,  657,  637,
			    0,  658,  585,    0,  649,  652,  624,  640,  640,  640,

			  640,    0,    0,    0,  626,  654,  622,  641,  641,  641,
			  641,  653,  656,  622,  624,  653,  659,  660,  661,  626,
			  657,  637,  643,  658,  643,  643,  643,  643,  639,  639,
			  639,  639,    0,  630,  630,  630,  630,  630,  630,  630,
			  630,  630,  639,  662,  630,  630,  664,  665,  659,  660,
			  661,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  666,  667,  631,  631,  643,  668,  669,  642,  639,  642,
			  642,  642,  642,  670,  639,  662,  672,  676,  664,  665,
			  673,  673,  673,  642,  673,  677,  678,  679,  680,  681,
			  682,  683,  666,  667,  685,  673,  686,  668,  669,  689, yy_Dummy>>,
			1, 200, 1907)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  690,  692,  693,  693,  693,  670,    0,    0,  672,  676,
			  694,  694,  694,  694,    0,  642,    0,  677,  678,  679,
			  680,  681,  682,  683,  697,    0,  685,  697,  686,  714,
			    0,  689,  690,  692,  698,  699,    0,  698,  699,  701,
			  701,  701,    0,  693,  715,  703,  703,  703,  703,  716,
			  718,  694,  751,  751,    0,  697,  705,  705,  705,  705,
			  705,  714,  698,  706,  719,  706,  673,    0,  706,  706,
			  706,  706,  720,  721,  697,  724,  715,  699,  726,  727,
			  701,  716,  718,  729,  698,  699,  703,  697,  707,  707,
			  707,  707,  751,  730,  698,    0,  719,  705,  708,  708,

			  708,  708,  707,    0,  720,  721,  697,  724,  731,  699,
			  726,  727,  708,  732,  733,  729,  698,  699,  709,  709,
			  709,  709,  710,  734,  710,  730,  737,  710,  710,  710,
			  710,  738,  739,  711,  707,  711,  711,  711,  711,  740,
			  731,  742,  746,  747,  708,  732,  733,  749,  778,  711,
			  753,  753,  753,  758,  757,  734,  758,  757,  737,  759,
			    0,    0,  759,  738,  739,  769,  769,  769,  769,  779,
			  781,  740,    0,  742,  746,  747,  783,    0,    0,  749,
			  778,  711,  757,  770,  770,  770,  770,  759,  784,  785,
			  753,  771,  771,  771,  771,  758,    0,  774,  774,  774, yy_Dummy>>,
			1, 200, 2107)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  774,  779,  781,  758,  757,  771,  786,  789,  783,  759,
			  772,  774,  772,    0,  757,  772,  772,  772,  772,  759,
			  784,  785,    0,  773,  792,  773,    0,  758,  773,  773,
			  773,  773,  793,  795,  796,  758,  757,  771,  786,  789,
			  797,  759,  799,  774,  775,  775,  775,  775,  776,  776,
			  776,  776,  777,  800,  777,  810,  792,  777,  777,  777,
			  777,  794,  794,  794,  793,  795,  796,  803,  804,    0,
			  803,  804,  797,    0,  799,  805,    0,  820,  805,    0,
			    0,  810,    0,  823,    0,  800,    0,  810,    0,    0,
			    0,  794,  811,  811,  811,  811,  812,  812,  812,  812,

			  813,  813,  813,  813,  803,  814,  814,  814,  814,  820,
			  815,  815,  815,  815,  816,  823,  816,  803,  804,  816,
			  816,  816,  816,  794,  815,  805,  817,  817,  817,  817,
			  818,  818,  818,  818,  827,    0,  803,  829,  829,  829,
			  830,  831,  833,  836,  839,  843,  836,  845,  846,  803,
			  804,  840,  840,  840,  840,  851,  815,  805,  841,  841,
			  841,  841,  852,  853,  854,  855,  827,  829,    0,    0,
			  839,    0,  830,  831,  833,    0,  839,  843,    0,  845,
			  846,  864,  864,  864,  866,  866,  866,  851,  866,  864,
			  866,  866,  866,  836,  852,  853,  854,  855,    0,  829, yy_Dummy>>,
			1, 200, 2307)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  860,  860,  860,  860,  860,  860,  860,  860,  860,  860,
			    0,    0,    0,    0,    0,  836,  861,  861,  861,  861,
			  861,  861,  861,  861,  861,  861,  862,  862,  862,  862,
			  862,  862,  862,  862,  862,  862,  863,  863,  863,  863,
			  863,  863,  863,  863,  863,  863,  865,    0,  865,  865,
			  865,  865,  865,  865,  865,  865,  867,    0,  867,  867,
			  867,  867,  867,  867,  867,  867,  868,  868,  868,  870,
			    0,  870,  870,  870,  868,  870,  870,  870,  870,  871,
			  871,  871,  871,  871,  871,  871,  871,  871,  871,  872,

			  872,  872,  872,  872,  872,  872,  872,  872,  872,  873,
			  873,  873,  873,  873,  873,  873,  873,  873,  873,  875,
			    0,  875,  875,  875,  875,  875,  875,  875,  875,  876,
			    0,  876,    0,  876,  876,  876,  876,  876,  876,  877,
			    0,  877,  877,  877,  877,  877,  877,  877,  877,  880,
			    0,  880,  880,  880,  880,  880,  880,  880,  880,  884,
			  884,  884,  884,  884,  884,  884,  884,  884,  884,  885,
			    0,  885,  885,  885,  885,  885,  885,  885,  885, yy_Dummy>>,
			1, 179, 2507)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 885)
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
			    0,    0,    0,  105,  106,  114,  119, 1534, 1515,  124,
			  127,  130,  133, 1508, 2686,  136,  139,  142,  204,  309,
			 2686,  140, 2686, 2686,  158,  161, 2686,  177,  170,  198,
			  223,  215, 1424, 2686,  327,  265,  330,  195,  307,    0,
			  348,  205,  299,  315,  377,  214,  130,  385,  371,  161,
			  397,  314,  153,  297,  203,  209, 2686,  451, 2686,  432,
			 2686, 2686,  463,  467,  479,  483,  488,  495,  499,  511,
			  515,  527,  531,  547,  556, 1442, 2686, 2686,  612,  107,
			  436, 2686, 2686,  149, 1443, 2686, 2686,  318, 2686, 2686,
			  472,  507, 1425,  559, 1424, 2686,  563,  131,  141,  156,

			  309,  659, 2686,  764,  290,  579, 1433, 1422,  867,  201,
			  573,  290,  596,  648,  498,  623,  687,  624, 1366, 1412,
			  721,  972,  705, 1077,  529, 1400, 1401, 1178, 1384, 2686,
			  159, 2686,  233, 2686, 1336, 1362,  567, 2686,  764, 2686,
			  239,  594,  791,  810,  819,  677,  257,  501,    0,  712,
			 2686, 2686,  281,  829,  885, 2686,  350, 2686,  405,  888,
			  894, 2686, 1342, 2686,    0,  344,  379,  672,  396,  408,
			  446,  472,  513,  534,  544,  540,  868,    0,  603,  867,
			  699,  615,  659,  650,    0,  661,  871,    0,  674,  874,
			  747,  749,  782,  875,    0,  769,  784,  959,  911,  801, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  797,  817,  828,  835,  947,  854,  871,  880,  874, 1018,
			 2686,  577, 2686,  591, 2686,  620, 2686,  624, 2686,  655,
			 2686,  675, 2686,  809, 2686,  903, 1095, 2686,  908, 1098,
			 2686,  964, 2686, 1333, 2686, 1316, 2686,  978, 2686,  980,
			 1322, 2686, 1007, 2686, 2686, 2686, 2686, 2686, 1027, 2686,
			 2686, 2686, 2686, 2686, 2686, 2686, 2686, 2686, 2686, 2686,
			 2686, 2686, 2686, 2686, 2686,  267, 2686, 2686, 1050,  357,
			 2686, 1306, 2686,  579, 2686,  737, 1255, 2686, 2686, 1103,
			 1114, 1143, 1146, 2686, 1190, 1197, 1214, 2686,  997, 2686,
			 1252, 1126,  245, 1270, 2686, 1376, 1479, 1010, 1238, 1584,

			 1039, 1077, 2686, 2686, 2686, 2686, 1138, 2686, 1242, 2686,
			 1227, 1179, 1214, 1232, 1230, 1236, 1247, 2686, 1234, 1240,
			 2686, 1261, 1291, 1297, 1102, 1302, 1308, 1388, 1407, 2686,
			 2686, 1221, 1211, 1191, 1185, 1170, 1037, 1169, 1151, 1150,
			 1124, 1114, 1103, 1100, 1099, 1064, 1019, 1007, 1004,  990,
			  982,  959,  948, 2686, 2686, 2686, 2686,  913, 1317, 1136,
			 2686, 2686, 1417, 2686, 1423, 2686, 1427, 2686, 1321, 1435,
			 1481,  923,  853, 1326,  819, 1490, 1440, 1038, 2686,  839,
			 2686, 1059, 2686, 1096, 2686, 1169, 2686,  832,  879,  928,
			  983,    0,    0,  981, 1467, 1029, 1061, 1147, 1175, 1274, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1299, 1318, 1326, 1323,    0, 1312, 1392, 1372, 1365, 1366,
			 1473, 1396, 1425, 1453, 1443, 1460, 1458, 1465, 1471, 1483,
			 1477,    0, 1489, 1471, 1477, 1498, 1497, 1498, 1503, 1484,
			 1539, 1488, 1517, 1529, 1534, 1544, 1549, 1560, 1554, 1562,
			 1551, 1560, 1561, 1568, 1559,    0, 2686, 1606, 2686, 2686,
			 2686, 2686, 2686, 2686, 2686, 2686, 2686, 1633, 2686, 2686,
			 1639, 2686, 2686, 2686, 2686, 1673, 1597,    0,  772, 2686,
			 2686, 2686, 1643, 2686, 1649, 1235, 2686, 1243, 2686, 1256,
			 2686, 1290,  828, 1691,  373,  816, 1692,  520, 2686, 1659,
			 2686, 2686, 2686, 2686, 1665, 1658, 1667, 1701, 2686, 1707,

			 2686, 2686, 1725, 1747, 1757,  765,  750,  745,  734, 2686,
			 2686, 2686, 2686, 2686, 1749, 1719, 2686, 2686, 2686, 2686,
			 2686, 2686, 2686, 2686, 2686, 2686, 2686, 2686, 2686, 2686,
			 2686, 2686, 1776, 1522, 1584, 2686, 2686, 2686, 1771, 1818,
			 1794, 1823, 1829, 1724,  657,    0,  645,  685, 1835, 1841,
			 2686, 2686, 1564, 1573, 1590, 1666, 1679, 1684, 1684, 1682,
			 1742, 1737, 1766, 1792, 1801, 1822, 1827, 1819, 1824, 1821,
			 1823, 1837, 1822,    0, 1839, 1836, 1822, 1829, 1843, 1831,
			    0, 1838,    0,    0, 1840, 1912,    0, 1847, 1837, 1853,
			 1843, 1849, 1854, 1843, 1853, 1842, 1880, 1874,    0, 1882, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0, 1896, 1896, 1882, 1892, 1904,    0,    0, 2686,
			 2686, 2686, 2686,  708, 1068,    0, 1915,  621, 1306, 1328,
			 2686, 2686, 1933, 2686, 1934, 2686, 1939, 2686,  658,  631,
			 1947, 1965,  601,  768, 1445,    0, 1934, 1963, 1956, 2016,
			 1985, 1995, 2057, 2012, 1893,    0,    0, 1917, 1924, 1939,
			    0,    0, 1924, 1953, 1938,    0, 1941, 1959, 1964, 1990,
			 1992, 1977, 2008,    0, 2007, 2012, 2034, 2031, 2035, 2042,
			 2043,    0, 2050, 2086, 2686,  589, 2055, 2046, 2056, 2061,
			 2062, 2050, 2064, 2050,    0, 2053, 2074,    0,    0, 2069,
			 2074,    0, 2066, 2091, 2099,  574,  478, 2126, 2136, 2137,

			 2686, 2128,  617, 2134,  918, 2145, 2156, 2176, 2186, 2206,
			 2215, 2223,    0,    0, 2103, 2102, 2108,    0, 2114, 2123,
			 2146, 2151,    0,    0, 2149,    0, 2156, 2153,    0, 2143,
			 2158, 2167, 2172, 2192, 2182, 2686,  544, 2193, 2191, 2197,
			 2204,    0, 2215,    0,    0,    0, 2201, 2208,    0, 2206,
			 2686, 2140, 2686, 2238, 2686,  481,  473, 2256, 2255, 2261,
			  482,  453,  448,  387,  375,  306,  218,  144,  172, 2253,
			 2271, 2279, 2303, 2316, 2285, 2332, 2336, 2345, 2223, 2228,
			    0, 2235,    0, 2251, 2265, 2264, 2273,    0,    0, 2279,
			    0,    0, 2289, 2306, 2367, 2297, 2308, 2316,    0, 2316, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2327,    0,    0, 2369, 2370, 2377, 2686, 2686, 2686, 2686,
			 2329, 2380, 2384, 2388, 2393, 2398, 2407, 2414, 2418,    0,
			 2351,    0,    0, 2350,    0,    0,    0, 2393,    0, 2443,
			 2407, 2402,    0, 2416,    0,    0, 2445, 2686, 2686, 2418,
			 2439, 2446,    0, 2419,    0, 2414, 2426,    0,    0, 2686,
			    0, 2433, 2422, 2423, 2424, 2425,    0, 2686, 2686, 2506,
			 2516, 2532, 2542, 2552, 2487, 2562, 2490, 2572, 2582, 1874,
			 2585, 2595, 2605, 2615,  433, 2625, 2635, 2645,  163,  158,
			 2655,  146,  116,  111, 2665, 2675, yy_Dummy>>,
			1, 86, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 885)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (869, 164, 208)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (858, 329, 361)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (869, 388, 445)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (858, 509, 542)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (869, 552, 608)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (869, 644, 672)
			yy_def_template_7 (an_array)
			an_array.area.fill_with (858, 859, 885)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  858,    1,  859,  859,  860,  860,  861,  861,  862,
			  862,  863,  863,  858,  858,  858,  858,  864,  865,  866,
			  858,  867,  858,  858,  864,  864,  858,  868,  858,  864,
			  858,  858,  858,  858,  868,  864,  868,  858,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  858,  864,  858,   57,
			  858,  858,   57,   57,   57,   57,   57,   57,   57,   57,
			   57,  858,  858,   57,   57,  870,  858,  858,  858,  871,
			  871,  858,  858,  872,  873,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  864,  874,  874,  874,

			  865,  865,  858,  875,  876,  865,  101,  101,  101,  101,
			  108,  108,  865,  865,  865,  865,  865,  865,  101,  101,
			  865,  866,  866,  866,  123,  123,  877,  877,  877,  858,
			  874,  858,  874,  858,   57,  858,  858,  858,  858,  858,
			  874,  864,  864,  864,  858,  858,  878,  878,  879,  858,
			  858,  858,   57,  858,   57,  858,  874,  858,   57,   57,
			  858,  858,  858,  858, yy_Dummy>>,
			1, 164, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  864,  858,  874,  858,  874,  858,  874,  858,  874,  858,
			  874,  858,  874,  858,  874,  858,  874,  864,  858,  874,
			  864,  858,  874,  858,  858,  858,  858,  858,  874,  858,
			  874,  870,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  871,  858,  858,  871,
			  872,  858,  873,  858,  858,  858,  858,  880,  858,  858,
			  874,  874,  874,   57,  858,   57,   57,   57,  858,  101,
			  858,  108,  108,  108,  875,  858,  875,  293,  296,  296,
			  875,  876,  865,  858,  858,  858,  858,  101,  858,  101,

			  858,  101,  865,  865,  865,  865,  865,  865,  858,  865,
			  101,  858,  123,  123,  123,  121,  866,  121,  121,  121, yy_Dummy>>,
			1, 120, 209)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  874,  858,  874,  858,  874,  858,  858,  858,  858,  878,
			  878,  878,  879,  858,  858,  874,  858,  858,  858,  874,
			  858,  874,  858,  874,  858,  858, yy_Dummy>>,
			1, 26, 362)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  858,  874,  858,  858,  858,  858,  858,  858,  858,  858,
			  858,  874,  858,  858,  874,  858,  858,  858,  858,  858,
			  858,  880,  880,  858,  858,  858,   57,  858,   57,  874,
			  858,  874,  858,  874,  858,  874,  108,  108,  108,  296,
			  296,  296,  858,  876,  858,  858,  858,  858,  865,  865,
			  865,  865,  858,  865,  858,  858,  866,  121,  121,  123,
			  123,  123,  123, yy_Dummy>>,
			1, 63, 446)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  878,  878,  373,  879,  858,  858,  858,  858,  858, yy_Dummy>>,
			1, 9, 543)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  858,  858,  858,  881,  858,  880,  874,
			  874,  858,  858,  865,  858,  865,  858,  865,  858,  123,
			  123,  866,  866,  858,  882,  882,  883,  858,  858,  858,
			  858,  858,  858,  858,  858, yy_Dummy>>,
			1, 35, 609)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  858,  858,  858,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  858,  858,  881,  880,  865,  865,  865,  858,  882,  882,
			  882,  883,  858,  858,  858,  858,  858,  858,  858,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  858,  884,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  858,  858,  858,
			  858,  858,  881,  880,  865,  865,  865,  858,  701,  858,
			  882,  858,  703,  858,  883,  858,  858,  858,  858,  858,

			  858,  858,  858,  858,  858,  869,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  885,
			  865,  865,  865,  858,  858,  858,  858,  858,  858,  858,
			  858,  858,  858,  858,  858,  858,  869,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  858,  869,  869,  869,
			  869,  869,  869,  865,  858,  858,  858,  858,  858,  869,
			  869,  869,  858,  869,  869,  869,  858,  869,  858,  869,
			  858,  869,  858,  869,  858,    0, yy_Dummy>>,
			1, 186, 673)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 127948)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (106, 127, 159)
			yy_ec_template_2 (an_array)
			an_array.area.fill_with (91, 216, 246)
			yy_ec_template_3 (an_array)
			an_array.area.fill_with (106, 256, 705)
			yy_ec_template_4 (an_array)
			an_array.area.fill_with (106, 768, 884)
			yy_ec_template_5 (an_array)
			an_array.area.fill_with (106, 904, 1013)
			an_array.put (94, 1014)
			an_array.area.fill_with (106, 1015, 1153)
			an_array.put (94, 1154)
			an_array.area.fill_with (106, 1155, 1369)
			an_array.area.fill_with (94, 1370, 1375)
			an_array.area.fill_with (106, 1376, 1416)
			yy_ec_template_6 (an_array)
			an_array.area.fill_with (106, 1424, 1469)
			yy_ec_template_7 (an_array)
			an_array.area.fill_with (106, 1479, 1522)
			yy_ec_template_8 (an_array)
			an_array.area.fill_with (106, 1568, 1641)
			an_array.area.fill_with (94, 1642, 1645)
			an_array.area.fill_with (106, 1646, 1747)
			yy_ec_template_9 (an_array)
			an_array.area.fill_with (106, 1806, 2037)
			yy_ec_template_10 (an_array)
			an_array.area.fill_with (106, 2048, 2095)
			an_array.area.fill_with (94, 2096, 2110)
			an_array.area.fill_with (106, 2111, 2141)
			an_array.put (94, 2142)
			an_array.area.fill_with (106, 2143, 2403)
			yy_ec_template_11 (an_array)
			an_array.area.fill_with (106, 2417, 2545)
			yy_ec_template_12 (an_array)
			an_array.area.fill_with (106, 2558, 2677)
			an_array.put (94, 2678)
			an_array.area.fill_with (106, 2679, 2799)
			an_array.area.fill_with (94, 2800, 2801)
			an_array.area.fill_with (106, 2802, 2927)
			an_array.put (94, 2928)
			an_array.area.fill_with (106, 2929, 3058)
			an_array.area.fill_with (94, 3059, 3066)
			an_array.area.fill_with (106, 3067, 3190)
			yy_ec_template_13 (an_array)
			an_array.area.fill_with (106, 3205, 3406)
			an_array.put (94, 3407)
			an_array.area.fill_with (106, 3408, 3448)
			an_array.put (94, 3449)
			an_array.area.fill_with (106, 3450, 3571)
			an_array.put (94, 3572)
			an_array.area.fill_with (106, 3573, 3646)
			yy_ec_template_14 (an_array)
			an_array.area.fill_with (106, 3676, 3840)
			yy_ec_template_15 (an_array)
			an_array.area.fill_with (106, 3897, 3972)
			an_array.put (94, 3973)
			an_array.area.fill_with (106, 3974, 4029)
			yy_ec_template_16 (an_array)
			an_array.area.fill_with (106, 4059, 4169)
			an_array.area.fill_with (94, 4170, 4175)
			an_array.area.fill_with (106, 4176, 4253)
			an_array.area.fill_with (94, 4254, 4255)
			an_array.area.fill_with (106, 4256, 4346)
			an_array.put (94, 4347)
			an_array.area.fill_with (106, 4348, 4959)
			an_array.area.fill_with (94, 4960, 4968)
			an_array.area.fill_with (106, 4969, 5007)
			an_array.area.fill_with (94, 5008, 5017)
			an_array.area.fill_with (106, 5018, 5119)
			an_array.put (94, 5120)
			an_array.area.fill_with (106, 5121, 5740)
			yy_ec_template_17 (an_array)
			an_array.area.fill_with (106, 5761, 5866)
			an_array.area.fill_with (94, 5867, 5869)
			an_array.area.fill_with (106, 5870, 5940)
			an_array.area.fill_with (94, 5941, 5942)
			an_array.area.fill_with (106, 5943, 6099)
			yy_ec_template_18 (an_array)
			an_array.area.fill_with (106, 6108, 6143)
			an_array.area.fill_with (94, 6144, 6154)
			an_array.area.fill_with (106, 6155, 6463)
			yy_ec_template_19 (an_array)
			an_array.area.fill_with (106, 6470, 6621)
			an_array.area.fill_with (94, 6622, 6655)
			an_array.area.fill_with (106, 6656, 6685)
			an_array.area.fill_with (94, 6686, 6687)
			an_array.area.fill_with (106, 6688, 6815)
			yy_ec_template_20 (an_array)
			an_array.area.fill_with (106, 6830, 7001)
			yy_ec_template_21 (an_array)
			an_array.area.fill_with (106, 7037, 7163)
			an_array.area.fill_with (94, 7164, 7167)
			an_array.area.fill_with (106, 7168, 7226)
			an_array.area.fill_with (94, 7227, 7231)
			an_array.area.fill_with (106, 7232, 7293)
			an_array.area.fill_with (94, 7294, 7295)
			an_array.area.fill_with (106, 7296, 7359)
			yy_ec_template_22 (an_array)
			an_array.area.fill_with (106, 7380, 8124)
			yy_ec_template_23 (an_array)
			an_array.area.fill_with (106, 8288, 8313)
			yy_ec_template_24 (an_array)
			an_array.area.fill_with (94, 8352, 8383)
			an_array.area.fill_with (106, 8384, 8447)
			yy_ec_template_25 (an_array)
			an_array.area.fill_with (106, 8528, 8585)
			yy_ec_template_26 (an_array)
			an_array.area.fill_with (94, 8592, 8657)
			an_array.put (96, 8658)
			an_array.area.fill_with (94, 8659, 8703)
			yy_ec_template_27 (an_array)
			an_array.area.fill_with (94, 8708, 8742)
			yy_ec_template_28 (an_array)
			an_array.area.fill_with (94, 8745, 8890)
			an_array.put (101, 8891)
			an_array.area.fill_with (94, 8892, 8967)
			an_array.area.fill_with (106, 8968, 8971)
			an_array.area.fill_with (94, 8972, 9000)
			an_array.area.fill_with (106, 9001, 9002)
			an_array.area.fill_with (94, 9003, 9254)
			an_array.area.fill_with (106, 9255, 9279)
			an_array.area.fill_with (94, 9280, 9290)
			an_array.area.fill_with (106, 9291, 9371)
			an_array.area.fill_with (94, 9372, 9449)
			an_array.area.fill_with (106, 9450, 9471)
			an_array.area.fill_with (94, 9472, 10087)
			an_array.area.fill_with (106, 10088, 10131)
			an_array.area.fill_with (94, 10132, 10180)
			an_array.area.fill_with (106, 10181, 10182)
			an_array.area.fill_with (94, 10183, 10213)
			yy_ec_template_29 (an_array)
			an_array.area.fill_with (94, 10228, 10626)
			an_array.area.fill_with (106, 10627, 10648)
			an_array.area.fill_with (94, 10649, 10711)
			an_array.area.fill_with (106, 10712, 10715)
			an_array.area.fill_with (94, 10716, 10747)
			an_array.area.fill_with (106, 10748, 10749)
			an_array.area.fill_with (94, 10750, 11123)
			an_array.area.fill_with (106, 11124, 11125)
			an_array.area.fill_with (94, 11126, 11157)
			an_array.put (106, 11158)
			an_array.area.fill_with (94, 11159, 11263)
			an_array.area.fill_with (106, 11264, 11492)
			yy_ec_template_30 (an_array)
			an_array.area.fill_with (106, 11520, 11631)
			an_array.put (94, 11632)
			an_array.area.fill_with (106, 11633, 11775)
			yy_ec_template_31 (an_array)
			an_array.area.fill_with (106, 11859, 11903)
			an_array.area.fill_with (94, 11904, 11929)
			an_array.put (106, 11930)
			an_array.area.fill_with (94, 11931, 12019)
			an_array.area.fill_with (106, 12020, 12031)
			an_array.area.fill_with (94, 12032, 12245)
			an_array.area.fill_with (106, 12246, 12271)
			yy_ec_template_32 (an_array)
			an_array.area.fill_with (106, 12352, 12442)
			yy_ec_template_33 (an_array)
			an_array.area.fill_with (106, 12449, 12538)
			an_array.put (94, 12539)
			an_array.area.fill_with (106, 12540, 12687)
			yy_ec_template_34 (an_array)
			an_array.area.fill_with (106, 12704, 12735)
			an_array.area.fill_with (94, 12736, 12771)
			an_array.area.fill_with (106, 12772, 12799)
			an_array.area.fill_with (94, 12800, 12830)
			an_array.area.fill_with (106, 12831, 12841)
			an_array.area.fill_with (94, 12842, 12871)
			yy_ec_template_35 (an_array)
			an_array.area.fill_with (94, 12896, 12927)
			an_array.area.fill_with (106, 12928, 12937)
			an_array.area.fill_with (94, 12938, 12976)
			an_array.area.fill_with (106, 12977, 12991)
			an_array.area.fill_with (94, 12992, 13311)
			an_array.area.fill_with (106, 13312, 19903)
			an_array.area.fill_with (94, 19904, 19967)
			an_array.area.fill_with (106, 19968, 42127)
			an_array.area.fill_with (94, 42128, 42182)
			an_array.area.fill_with (106, 42183, 42237)
			an_array.area.fill_with (94, 42238, 42239)
			an_array.area.fill_with (106, 42240, 42508)
			an_array.area.fill_with (94, 42509, 42511)
			an_array.area.fill_with (106, 42512, 42610)
			yy_ec_template_36 (an_array)
			an_array.area.fill_with (106, 42623, 42737)
			yy_ec_template_37 (an_array)
			an_array.area.fill_with (106, 42786, 42888)
			an_array.area.fill_with (93, 42889, 42890)
			an_array.area.fill_with (106, 42891, 43047)
			yy_ec_template_38 (an_array)
			an_array.area.fill_with (106, 43066, 43123)
			an_array.area.fill_with (94, 43124, 43127)
			an_array.area.fill_with (106, 43128, 43213)
			an_array.area.fill_with (94, 43214, 43215)
			an_array.area.fill_with (106, 43216, 43255)
			yy_ec_template_39 (an_array)
			an_array.area.fill_with (106, 43261, 43309)
			an_array.area.fill_with (94, 43310, 43311)
			an_array.area.fill_with (106, 43312, 43358)
			an_array.put (94, 43359)
			an_array.area.fill_with (106, 43360, 43456)
			yy_ec_template_40 (an_array)
			an_array.area.fill_with (106, 43488, 43611)
			yy_ec_template_41 (an_array)
			an_array.area.fill_with (106, 43642, 43741)
			yy_ec_template_42 (an_array)
			an_array.area.fill_with (106, 43762, 43866)
			yy_ec_template_43 (an_array)
			an_array.area.fill_with (106, 43884, 44010)
			an_array.put (94, 44011)
			an_array.area.fill_with (106, 44012, 62248)
			an_array.put (94, 62249)
			an_array.area.fill_with (106, 62250, 62385)
			an_array.area.fill_with (93, 62386, 62401)
			an_array.area.fill_with (106, 62402, 62971)
			yy_ec_template_44 (an_array)
			an_array.area.fill_with (106, 63084, 63232)
			yy_ec_template_45 (an_array)
			an_array.area.fill_with (106, 63265, 63291)
			yy_ec_template_46 (an_array)
			an_array.area.fill_with (106, 63297, 63323)
			yy_ec_template_47 (an_array)
			an_array.area.fill_with (106, 63334, 63455)
			yy_ec_template_48 (an_array)
			an_array.area.fill_with (106, 63486, 63743)
			an_array.area.fill_with (94, 63744, 63746)
			an_array.area.fill_with (106, 63747, 63798)
			an_array.area.fill_with (94, 63799, 63807)
			an_array.area.fill_with (106, 63808, 63864)
			yy_ec_template_49 (an_array)
			an_array.area.fill_with (106, 63905, 63951)
			an_array.area.fill_with (94, 63952, 63996)
			an_array.area.fill_with (106, 63997, 64414)
			an_array.put (94, 64415)
			an_array.area.fill_with (106, 64416, 64463)
			an_array.put (94, 64464)
			an_array.area.fill_with (106, 64465, 64878)
			an_array.put (94, 64879)
			an_array.area.fill_with (106, 64880, 65622)
			an_array.put (94, 65623)
			an_array.area.fill_with (106, 65624, 65654)
			an_array.area.fill_with (94, 65655, 65656)
			an_array.area.fill_with (106, 65657, 65822)
			an_array.put (94, 65823)
			an_array.area.fill_with (106, 65824, 65854)
			an_array.put (94, 65855)
			an_array.area.fill_with (106, 65856, 66127)
			an_array.area.fill_with (94, 66128, 66136)
			an_array.area.fill_with (106, 66137, 66174)
			an_array.put (94, 66175)
			an_array.area.fill_with (106, 66176, 66247)
			an_array.put (94, 66248)
			an_array.area.fill_with (106, 66249, 66287)
			an_array.area.fill_with (94, 66288, 66294)
			an_array.area.fill_with (106, 66295, 66360)
			an_array.area.fill_with (94, 66361, 66367)
			an_array.area.fill_with (106, 66368, 66456)
			an_array.area.fill_with (94, 66457, 66460)
			an_array.area.fill_with (106, 66461, 67244)
			an_array.put (94, 67245)
			an_array.area.fill_with (106, 67246, 67412)
			an_array.area.fill_with (94, 67413, 67417)
			an_array.area.fill_with (106, 67418, 67654)
			an_array.area.fill_with (94, 67655, 67661)
			an_array.area.fill_with (106, 67662, 67770)
			yy_ec_template_50 (an_array)
			an_array.area.fill_with (106, 67778, 67903)
			an_array.area.fill_with (94, 67904, 67907)
			an_array.area.fill_with (106, 67908, 67955)
			an_array.area.fill_with (94, 67956, 67957)
			an_array.area.fill_with (106, 67958, 68036)
			yy_ec_template_51 (an_array)
			an_array.area.fill_with (106, 68064, 68151)
			an_array.area.fill_with (94, 68152, 68157)
			an_array.area.fill_with (106, 68158, 68264)
			an_array.put (94, 68265)
			an_array.area.fill_with (106, 68266, 68682)
			yy_ec_template_52 (an_array)
			an_array.area.fill_with (106, 68702, 68805)
			an_array.put (94, 68806)
			an_array.area.fill_with (106, 68807, 69056)
			an_array.area.fill_with (94, 69057, 69079)
			an_array.area.fill_with (106, 69080, 69184)
			an_array.area.fill_with (94, 69185, 69187)
			an_array.area.fill_with (106, 69188, 69215)
			an_array.area.fill_with (94, 69216, 69228)
			an_array.area.fill_with (106, 69229, 69435)
			an_array.area.fill_with (94, 69436, 69439)
			an_array.area.fill_with (106, 69440, 69690)
			an_array.put (94, 69691)
			an_array.area.fill_with (106, 69692, 69955)
			an_array.area.fill_with (94, 69956, 69958)
			an_array.area.fill_with (106, 69959, 70113)
			an_array.put (94, 70114)
			an_array.area.fill_with (106, 70115, 70206)
			an_array.area.fill_with (94, 70207, 70214)
			an_array.area.fill_with (106, 70215, 70297)
			yy_ec_template_53 (an_array)
			an_array.area.fill_with (106, 70307, 70720)
			an_array.area.fill_with (94, 70721, 70725)
			an_array.area.fill_with (106, 70726, 70767)
			an_array.area.fill_with (94, 70768, 70769)
			an_array.area.fill_with (106, 70770, 71414)
			an_array.area.fill_with (94, 71415, 71416)
			an_array.area.fill_with (106, 71417, 71636)
			an_array.area.fill_with (94, 71637, 71665)
			yy_ec_template_54 (an_array)
			an_array.area.fill_with (106, 71680, 72815)
			an_array.area.fill_with (94, 72816, 72820)
			an_array.area.fill_with (106, 72821, 90733)
			an_array.area.fill_with (94, 90734, 90735)
			an_array.area.fill_with (106, 90736, 90868)
			an_array.put (94, 90869)
			an_array.area.fill_with (106, 90870, 90934)
			yy_ec_template_55 (an_array)
			an_array.area.fill_with (106, 90950, 91798)
			an_array.area.fill_with (94, 91799, 91802)
			an_array.area.fill_with (106, 91803, 92129)
			an_array.put (94, 92130)
			an_array.area.fill_with (106, 92131, 111771)
			yy_ec_template_56 (an_array)
			an_array.area.fill_with (106, 111776, 116735)
			an_array.area.fill_with (94, 116736, 116981)
			an_array.area.fill_with (106, 116982, 116991)
			an_array.area.fill_with (94, 116992, 117030)
			an_array.area.fill_with (106, 117031, 117032)
			an_array.area.fill_with (94, 117033, 117092)
			yy_ec_template_57 (an_array)
			an_array.area.fill_with (94, 117132, 117161)
			an_array.area.fill_with (106, 117162, 117165)
			an_array.area.fill_with (94, 117166, 117224)
			an_array.area.fill_with (106, 117225, 117247)
			an_array.area.fill_with (94, 117248, 117313)
			yy_ec_template_58 (an_array)
			an_array.area.fill_with (106, 117318, 117503)
			an_array.area.fill_with (94, 117504, 117590)
			an_array.area.fill_with (106, 117591, 118464)
			an_array.put (94, 118465)
			an_array.area.fill_with (106, 118466, 118490)
			an_array.put (94, 118491)
			an_array.area.fill_with (106, 118492, 118522)
			an_array.put (94, 118523)
			an_array.area.fill_with (106, 118524, 118548)
			an_array.put (94, 118549)
			an_array.area.fill_with (106, 118550, 118580)
			an_array.put (94, 118581)
			an_array.area.fill_with (106, 118582, 118606)
			an_array.put (94, 118607)
			an_array.area.fill_with (106, 118608, 118638)
			an_array.put (94, 118639)
			an_array.area.fill_with (106, 118640, 118664)
			an_array.put (94, 118665)
			an_array.area.fill_with (106, 118666, 118696)
			an_array.put (94, 118697)
			an_array.area.fill_with (106, 118698, 118722)
			an_array.put (94, 118723)
			an_array.area.fill_with (106, 118724, 118783)
			an_array.area.fill_with (94, 118784, 119295)
			an_array.area.fill_with (106, 119296, 119350)
			an_array.area.fill_with (94, 119351, 119354)
			an_array.area.fill_with (106, 119355, 119404)
			yy_ec_template_59 (an_array)
			an_array.area.fill_with (106, 119436, 121166)
			an_array.put (94, 121167)
			an_array.area.fill_with (106, 121168, 121598)
			an_array.put (94, 121599)
			an_array.area.fill_with (106, 121600, 123229)
			an_array.area.fill_with (94, 123230, 123231)
			an_array.area.fill_with (106, 123232, 124075)
			yy_ec_template_60 (an_array)
			an_array.area.fill_with (106, 124081, 124205)
			an_array.put (94, 124206)
			an_array.area.fill_with (106, 124207, 124655)
			an_array.area.fill_with (94, 124656, 124657)
			an_array.area.fill_with (106, 124658, 124927)
			an_array.area.fill_with (94, 124928, 124971)
			an_array.area.fill_with (106, 124972, 124975)
			an_array.area.fill_with (94, 124976, 125075)
			yy_ec_template_61 (an_array)
			an_array.area.fill_with (94, 125137, 125173)
			an_array.area.fill_with (106, 125174, 125196)
			an_array.area.fill_with (94, 125197, 125357)
			an_array.area.fill_with (106, 125358, 125413)
			an_array.area.fill_with (94, 125414, 125442)
			an_array.area.fill_with (106, 125443, 125455)
			an_array.area.fill_with (94, 125456, 125499)
			yy_ec_template_62 (an_array)
			an_array.area.fill_with (106, 125542, 125695)
			an_array.area.fill_with (94, 125696, 125946)
			an_array.area.fill_with (93, 125947, 125951)
			an_array.area.fill_with (94, 125952, 126679)
			yy_ec_template_63 (an_array)
			an_array.area.fill_with (94, 126720, 126835)
			an_array.area.fill_with (106, 126836, 126847)
			an_array.area.fill_with (94, 126848, 126936)
			yy_ec_template_64 (an_array)
			an_array.area.fill_with (94, 126992, 127047)
			yy_ec_template_65 (an_array)
			an_array.area.fill_with (94, 127072, 127111)
			an_array.area.fill_with (106, 127112, 127119)
			an_array.area.fill_with (94, 127120, 127149)
			yy_ec_template_66 (an_array)
			an_array.area.fill_with (106, 127154, 127231)
			an_array.area.fill_with (94, 127232, 127352)
			an_array.put (106, 127353)
			an_array.area.fill_with (94, 127354, 127435)
			an_array.put (106, 127436)
			an_array.area.fill_with (94, 127437, 127571)
			yy_ec_template_67 (an_array)
			an_array.area.fill_with (94, 127632, 127656)
			yy_ec_template_68 (an_array)
			an_array.area.fill_with (106, 127703, 127743)
			an_array.area.fill_with (94, 127744, 127890)
			an_array.put (106, 127891)
			an_array.area.fill_with (94, 127892, 127946)
			an_array.area.fill_with (106, 127947, 127948)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,  106,  106,  106,  106,  106,  106,  106,  106,    1,
			    2,    1,    1,    1,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,    3,    4,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   21,   21,   21,   21,   21,   22,   22,   23,   24,
			   25,   26,   27,   28,    9,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
			   54,   55,   56,   57,   58,   59,   60,   61,   62,   63,

			   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,
			   74,   75,   76,   77,   78,   79,   80,   81,   82,   83,
			   84,   85,   86,   87,    9,   88,   89, yy_Dummy>>,
			1, 127, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    4,    4,    4,    4,    4,   90,    4,   60,    4,
			   91,   91,   92,   91,    4,   60,    4,    4,   91,   91,
			   60,   91,    4,    4,   60,   91,   91,   91,   91,   91,
			   91,    4,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,    4, yy_Dummy>>,
			1, 56, 160)
		end

	yy_ec_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    4,   91,   91,   91,   91,   91,   91,   91,   91, yy_Dummy>>,
			1, 9, 247)
		end

	yy_ec_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   93,   93,   93,   93,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			  106,  106,  106,  106,  106,   93,   93,   93,   93,   93,
			   93,   93,  106,   93,  106,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93, yy_Dummy>>,
			1, 62, 706)
		end

	yy_ec_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   93,  106,  106,  106,  106,  106,  106,  106,  106,   94,
			  106,  106,  106,  106,  106,   93,   93,  106,   94, yy_Dummy>>,
			1, 19, 885)
		end

	yy_ec_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,   94,   94,   94, yy_Dummy>>,
			1, 7, 1417)
		end

	yy_ec_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,   94,  106,  106,   94,  106,  106,   94, yy_Dummy>>,
			1, 9, 1470)
		end

	yy_ec_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,  106,  106,   94,   94, yy_Dummy>>,
			1, 45, 1523)
		end

	yy_ec_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,   94,   94,  106,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 58, 1748)
		end

	yy_ec_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,  106,  106,  106,  106,   94,   94, yy_Dummy>>,
			1, 10, 2038)
		end

	yy_ec_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   94, yy_Dummy>>,
			1, 13, 2404)
		end

	yy_ec_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,  106,  106,   94,   94,
			  106,   94, yy_Dummy>>,
			1, 12, 2546)
		end

	yy_ec_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,  106,  106,  106,  106,  106,   94,  106,
			  106,  106,  106,   94, yy_Dummy>>,
			1, 14, 3191)
		end

	yy_ec_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   94,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,   94,   94, yy_Dummy>>,
			1, 29, 3647)
		end

	yy_ec_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,  106,  106,   94,   94,   94,   94,   94,
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,   94,  106,   94,  106,   94, yy_Dummy>>,
			1, 56, 3841)
		end

	yy_ec_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,  106,   94,
			   94,   94,   94,   94,   94,  106,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 29, 4030)
		end

	yy_ec_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,    1, yy_Dummy>>,
			1, 20, 5741)
		end

	yy_ec_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,  106,   94,   94,   94,   94, yy_Dummy>>,
			1, 8, 6100)
		end

	yy_ec_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,  106,   94,   94, yy_Dummy>>,
			1, 6, 6464)
		end

	yy_ec_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,  106,   94,   94,
			   94,   94,   94,   94, yy_Dummy>>,
			1, 14, 6816)
		end

	yy_ec_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   94,   94,   94,   94,
			   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 35, 7002)
		end

	yy_ec_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,   94, yy_Dummy>>,
			1, 20, 7360)
		end

	yy_ec_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   93,  106,   93,   93,   93,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   93,   93,   93,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   93,   93,   93,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,   93,   93,
			   93,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,   93,   93,  106,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,  106,  106,
			  106,  106,  106,   94,   94,   94,   94,   94,   94,   94,
			   94,  106,  106,  106,  106,  106,  106,  106,  106,   94,

			   94,   94,   94,   94,   94,   95,   94,  106,  106,  106,
			  106,  106,  106,  106,    1,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,  106,  106,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,  106,  106,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,    1, yy_Dummy>>,
			1, 163, 8125)
		end

	yy_ec_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   94,   94,   94,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106, yy_Dummy>>,
			1, 38, 8314)
		end

	yy_ec_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,   94,   94,   94,   94,  106,   94,   94,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,  106,   94,   94,   94,  106,  106,  106,  106,  106,
			   94,   94,   94,   94,   94,   94,  106,   94,  106,   94,
			  106,   94,  106,  106,  106,  106,   94,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,   94,   94,
			  106,  106,  106,  106,   94,   94,   94,   94,   94,  106,
			  106,  106,  106,  106,   94,   94,   94,   94,  106,   94, yy_Dummy>>,
			1, 80, 8448)
		end

	yy_ec_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106, yy_Dummy>>,
			1, 6, 8586)
		end

	yy_ec_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   94,   94,   98, yy_Dummy>>,
			1, 4, 8704)
		end

	yy_ec_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   99,  100, yy_Dummy>>,
			1, 2, 8743)
		end

	yy_ec_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  102,  103,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,   94,  104,  105, yy_Dummy>>,
			1, 14, 10214)
		end

	yy_ec_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,   94,   94,   94,  106,   94,   94, yy_Dummy>>,
			1, 27, 11493)
		end

	yy_ec_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,   94,   94,   94,  106,
			  106,   94,  106,  106,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,  106,  106,
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   94,   94,   94,   94,   94,  106,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,  106,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94, yy_Dummy>>,
			1, 83, 11776)
		end

	yy_ec_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,  106,  106,  106,  106,    1,   94,   94,   94,
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,   94,   94,  106,  106,  106,  106,
			  106,  106,  106,  106,   94,  106,  106,  106,   94,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,   94,  106,  106,  106,  106,  106,
			   94,   94,  106,  106,  106,  106,  106,   94,   94,   94, yy_Dummy>>,
			1, 80, 12272)
		end

	yy_ec_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   93,   93,  106,  106,  106,   94, yy_Dummy>>,
			1, 6, 12443)
		end

	yy_ec_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 16, 12688)
		end

	yy_ec_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,   94,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106, yy_Dummy>>,
			1, 24, 12872)
		end

	yy_ec_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,   94, yy_Dummy>>,
			1, 12, 42611)
		end

	yy_ec_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,  106,  106,  106,  106,
			  106,  106,  106,  106,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   93,   93, yy_Dummy>>,
			1, 48, 42738)
		end

	yy_ec_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,   94,   94,   94,   94, yy_Dummy>>,
			1, 18, 43048)
		end

	yy_ec_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,  106,   94, yy_Dummy>>,
			1, 5, 43256)
		end

	yy_ec_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,   94,
			   94, yy_Dummy>>,
			1, 31, 43457)
		end

	yy_ec_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,   94,   94,   94, yy_Dummy>>,
			1, 30, 43612)
		end

	yy_ec_template_42 (an_array: ARRAY [INTEGER])
			-- Fill chunk #42 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,   94,   94, yy_Dummy>>,
			1, 20, 43742)
		end

	yy_ec_template_43 (an_array: ARRAY [INTEGER])
			-- Fill chunk #43 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   93,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,   93,   93, yy_Dummy>>,
			1, 17, 43867)
		end

	yy_ec_template_44 (an_array: ARRAY [INTEGER])
			-- Fill chunk #44 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,   94,   94,   94,   94,   94,   94,  106,  106,   94,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   94,   94,   94,   94,   94,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,   94,   94,  106,  106,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,  106,   94,   94,
			   94,   94,   94,  106,  106,  106,  106,  106,  106,   94,

			   94,   94,   94,   94,   94,   94,   94,  106,   94,   94,
			   94,   94, yy_Dummy>>,
			1, 112, 62972)
		end

	yy_ec_template_45 (an_array: ARRAY [INTEGER])
			-- Fill chunk #45 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,  106,  106,   94,
			   94,   94,   94,   94,   94,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,   94,   94,   94,   94,   94,
			   94,   94, yy_Dummy>>,
			1, 32, 63233)
		end

	yy_ec_template_46 (an_array: ARRAY [INTEGER])
			-- Fill chunk #46 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,   93,   94,   93, yy_Dummy>>,
			1, 5, 63292)
		end

	yy_ec_template_47 (an_array: ARRAY [INTEGER])
			-- Fill chunk #47 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,   94,  106,  106,   94,  106,  106,   94,   94, yy_Dummy>>,
			1, 10, 63324)
		end

	yy_ec_template_48 (an_array: ARRAY [INTEGER])
			-- Fill chunk #48 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   93,   94,   94,   94,  106,   94,   94,
			   94,   94,   94,   94,   94,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,   94,   94, yy_Dummy>>,
			1, 30, 63456)
		end

	yy_ec_template_49 (an_array: ARRAY [INTEGER])
			-- Fill chunk #49 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,  106,  106,   94,
			   94,   94,  106,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,  106,  106,  106,   94, yy_Dummy>>,
			1, 40, 63865)
		end

	yy_ec_template_50 (an_array: ARRAY [INTEGER])
			-- Fill chunk #50 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,  106,   94,   94,   94,   94, yy_Dummy>>,
			1, 7, 67771)
		end

	yy_ec_template_51 (an_array: ARRAY [INTEGER])
			-- Fill chunk #51 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,  106,  106,  106,  106,   94,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   94,  106,   94,   94,   94, yy_Dummy>>,
			1, 27, 68037)
		end

	yy_ec_template_52 (an_array: ARRAY [INTEGER])
			-- Fill chunk #52 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,   94,   94,  106,   94, yy_Dummy>>,
			1, 19, 68683)
		end

	yy_ec_template_53 (an_array: ARRAY [INTEGER])
			-- Fill chunk #53 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,  106,   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 9, 70298)
		end

	yy_ec_template_54 (an_array: ARRAY [INTEGER])
			-- Fill chunk #54 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,   94, yy_Dummy>>,
			1, 14, 71666)
		end

	yy_ec_template_55 (an_array: ARRAY [INTEGER])
			-- Fill chunk #55 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,  106,
			  106,  106,  106,   94,   94, yy_Dummy>>,
			1, 15, 90935)
		end

	yy_ec_template_56 (an_array: ARRAY [INTEGER])
			-- Fill chunk #56 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,   94, yy_Dummy>>,
			1, 4, 111772)
		end

	yy_ec_template_57 (an_array: ARRAY [INTEGER])
			-- Fill chunk #57 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,   94,   94,   94,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			   94,   94,  106,  106,  106,  106,  106,  106,  106, yy_Dummy>>,
			1, 39, 117093)
		end

	yy_ec_template_58 (an_array: ARRAY [INTEGER])
			-- Fill chunk #58 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,   94, yy_Dummy>>,
			1, 4, 117314)
		end

	yy_ec_template_59 (an_array: ARRAY [INTEGER])
			-- Fill chunk #59 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,  106,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,  106,   94,   94,   94,   94,   94,   94,
			   94, yy_Dummy>>,
			1, 31, 119405)
		end

	yy_ec_template_60 (an_array: ARRAY [INTEGER])
			-- Fill chunk #60 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,  106,  106,  106,   94, yy_Dummy>>,
			1, 5, 124076)
		end

	yy_ec_template_61 (an_array: ARRAY [INTEGER])
			-- Fill chunk #61 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,  106,  106,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,  106,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			  106, yy_Dummy>>,
			1, 61, 125076)
		end

	yy_ec_template_62 (an_array: ARRAY [INTEGER])
			-- Fill chunk #62 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,  106,  106,  106,  106,  106,  106,  106,
			   94,   94,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   94,   94,   94,   94,
			   94,   94, yy_Dummy>>,
			1, 42, 125500)
		end

	yy_ec_template_63 (an_array: ARRAY [INTEGER])
			-- Fill chunk #63 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,  106,  106,  106,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,  106,  106,  106, yy_Dummy>>,
			1, 40, 126680)
		end

	yy_ec_template_64 (an_array: ARRAY [INTEGER])
			-- Fill chunk #64 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,  106,  106,  106,  106, yy_Dummy>>,
			1, 55, 126937)
		end

	yy_ec_template_65 (an_array: ARRAY [INTEGER])
			-- Fill chunk #65 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,  106,  106,
			  106,  106,  106,  106, yy_Dummy>>,
			1, 24, 127048)
		end

	yy_ec_template_66 (an_array: ARRAY [INTEGER])
			-- Fill chunk #66 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,   94,   94, yy_Dummy>>,
			1, 4, 127150)
		end

	yy_ec_template_67 (an_array: ARRAY [INTEGER])
			-- Fill chunk #67 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,  106,  106,   94,   94,
			   94,   94,   94,  106,  106,  106,   94,   94,   94,  106,
			  106,  106,  106,  106,   94,   94,   94,   94,   94,   94,
			   94,  106,  106,  106,  106,  106,  106,  106,  106,  106, yy_Dummy>>,
			1, 60, 127572)
		end

	yy_ec_template_68 (an_array: ARRAY [INTEGER])
			-- Fill chunk #68 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,   94,   94,   94,
			   94,   94,   94,   94,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,   94,   94,   94,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,   94,
			   94,   94,   94,   94,   94,   94, yy_Dummy>>,
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
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
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

	yyJam_base: INTEGER = 2686
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 858
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 859
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 106
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
