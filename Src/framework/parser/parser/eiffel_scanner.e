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
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_REPEAT, Current)
					last_token := TE_REPEAT
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
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_BLOCK_OPEN, Current)
					last_token := TE_BLOCK_OPEN
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
					last_symbol_id_value := ast_factory.new_symbol_id_as (TE_BLOCK_CLOSE, Current)
					last_token := TE_BLOCK_CLOSE
				else
					process_id_as
					last_token := TE_FREE
				end
			
when 47 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
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
			
when 50 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 52 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 53 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 54 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 55 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 56 then
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
			
when 57 then
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
			
when 58 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 59 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 60 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 61 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 62 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 63 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 64 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 65 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 66 then
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
			
when 67 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 68 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 69 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 70 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 71 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 72 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 73 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 74 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 75 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 76 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 77 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 78 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 79 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 80 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 81 then
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
			
when 82 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
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
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 102 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 103 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 104 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 105 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 106 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 107 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 108 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 109 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 110 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 111 then
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
			
when 112 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 113 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 115 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 116 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 117 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 118 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 119 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 122 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 124 then
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
			
when 126 then
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
			
when 127 then
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
			
when 128 then
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
			
when 129 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 130 then
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
			
when 131 then
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
			
when 132 then
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
			
when 133 then
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
			
when 134 then
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
			
when 135 then
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
			
when 136 then
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
			
when 137 then
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
			
when 138 then
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
			
when 139 then
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
			
when 140 then
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
			
when 141 then
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
			
when 142 then
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
			
when 143 then
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
			
when 144 then
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
			
when 145 then
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
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
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
			
when 154 then
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
				report_invalid_integer_error (token_buffer)
			
when 160 then
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
			
when 161 then
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
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 164 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 166 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 167 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 168 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 169 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 170 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 171 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 172 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 173 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 174 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 175 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 176 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 177 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 178 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 179 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 180 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 181 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 185 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 186 then
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
			
when 187 then
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
			
when 188 then
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
			
when 189 then
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
			
when 190 then
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
			
when 191 then
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
			
when 192 then
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
				append_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 194 then
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
			
when 195 then
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
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 212 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 213 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 214 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 215 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 216 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 217 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
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
			
when 223 then
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
			
when 224 then
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
			
when 225 then
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
			
when 226 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 227 then
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
			create an_array.make_filled (0, 0, 4591)
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
			   14,   64,   65,   66,   67,   68,   69,   70,   71,   72,
			   73,   74,   75,   77,   77,  154,  173,   78,   78,  199,
			   79,   79,   81,   82,   81,   81,  155,   83,   81,   82,
			   81,   81,  845,   83,   92,   93,   92,   92,  168,  169,
			   92,   93,   92,   92,  170,  171,   99,  100,   99,   99,
			  845,  199,   99,  100,   99,   99,  158,  185,  106,  106,
			  106,  106,  101,  140,  159,  206,  140,  186,  101,  106,
			  106,  106,  106,  156,  107,  157,  157,  157,  157,  161,
			   84,  162,  162,  162,  162,  107,   84,  197,  180,  185, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  845,  213,  181,  198,  187,  182,  188,  206,  183,  186,
			  216,  184,  288,  289,  266,  266,  189,  217,  267,  274,
			  870,  266,   84,  298,  299,  267,  302,  303,   84,  197,
			  180,  867,  166,  213,  181,  198,  187,  182,  188,  160,
			  183,   85,  216,  184,   86,   87,   88,   85,  189,  217,
			   86,   87,   88,   94,  308,  204,   95,   96,   97,   94,
			  480,  481,   95,   96,   97,  102,  288,  289,  103,  104,
			  105,  102,  205,  845,  103,  104,  105,  108,  395,  190,
			  109,  110,  111,  191,  711,  214,  308,  204,  108,  298,
			  299,  109,  110,  111,  113,  114,  192,  115,  114,  215,

			  116,  825,  117,  118,  205,  119,  824,  120,  823,  305,
			  395,  190,  115,  822,  121,  191,  122,  214,  114,  123,
			  161,  268,  162,  162,  162,  162,  207,  124,  192,  818,
			  193,  215,  125,  126,  163,  164,  208,  194,  195,  396,
			  210,  209,  127,  196,  679,  128,  129,  679,  130,  399,
			  211,  123,  679,  212,  400,  401,  165,  266,  207,  124,
			  131,  267,  193,  166,  125,  126,  163,  164,  208,  194,
			  195,  396,  210,  209,  127,  196,  305,  131,  114,  115,
			  174,  399,  211,  309,  175,  212,  400,  401,  165,  176,
			  397,  177,  131,  398,  704,  704,  178,  179,  132,  132, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  133,  134,  134,  134,  134,  135,  136,  137,  138,  139,
			  142,  402,  174,  403,  200,  679,  175,  143,  772,  144,
			  751,  176,  397,  177,  201,  398,  202,  131,  178,  179,
			  203,  748,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  402,  679,  403,  200,  219,  222,  222,
			  222,  222,  222,  222,  222,  275,  201,  266,  202,  131,
			  747,  267,  203,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  220,  219,  221,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  235,  235,  235,  235,  235,

			  235,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  146,  146,
			  147,  148,  148,  148,  148,  149,  150,  151,  152,  153,
			  223,  223,  223,  223,  223,  223,  223,  224,  223,  223,
			  223,  223,  223,  223,  223,  223,  225,  226,  227,  227,
			  228,  227,  227,  227,  229,  227,  227,  227,  227,  227,
			  227,  227,  230,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  231,  231,  231,  231,  231,  231, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  231,  231,  231,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  238,  238,  238,  238,  711,
			  239,  404,  707,  240,  266,  241,  242,  243,  267,  268,
			  266,  268,  268,  244,  267,  266,  385,  470,  471,  267,
			  245,  472,  246,  749,  750,  247,  248,  249,  250,  623,
			  251,  310,  252,  404,  115,  266,  253,  311,  254,  274,
			  115,  255,  256,  257,  258,  259,  260,  281,  282,  281,

			  281,  868,  869,  291,  291,  291,  291,  405,  238,  291,
			  291,  291,  291,  383,  383,  383,  383,  269,  106,  106,
			  106,  106,  238,  406,  312,  238,  539,  115,  384,  410,
			  313,  538,  131,  115,  107,  415,  537,  305,  131,  405,
			  115,  315,  416,  314,  115,  276,  277,  536,  161,  269,
			  388,  388,  388,  388,  261,  406,  278,  262,  263,  264,
			  384,  410,  316,  317,  131,  535,  115,  415,  270,  534,
			  131,  271,  272,  273,  416,  131,  321,  305,  266,  374,
			  115,  131,  267,  533,  318,  266,  532,  305,  131,  267,
			  115,  166,  131,  305,  417,  531,  115,  332,  305,  266, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  115,  115,  305,  267,  530,  115,  283,  131,  321,  284,
			  285,  286,  292,  131,  131,  293,  294,  295,  292,  322,
			  131,  293,  294,  295,  131,  319,  417,  108,  131,  529,
			  109,  110,  111,  112,  112,  320,  112,  112,  131,  306,
			  411,  323,  115,  413,  131,  331,  131,  414,  131,  131,
			  418,  322,  424,  131,  427,  412,  428,  319,  528,  425,
			  131,  382,  382,  382,  382,  382,  382,  320,  527,  526,
			  131,  426,  411,  323,  374,  413,  131,  525,  268,  414,
			  131,  131,  418,  275,  424,  131,  427,  412,  428,  429,
			  307,  425,  432,  433,  477,  478,  478,  478,  268,  324,

			  325,  324,  324,  426,  305,  524,  521,  115,  324,  325,
			  324,  324,  305,  305,  520,  115,  115,  393,  393,  393,
			  393,  429,  307,  519,  432,  433,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  131,  305,  326,  394,  115,
			  518,  517,  442,  131,  131,  376,  376,  376,  376,  376,
			  376,  376,  106,  443,  440,  106,  305,  430,  441,  115,
			  385,  106,  386,  386,  386,  386,  431,  131,  291,  305,
			  704,  704,  115,  342,  442,  131,  131,  387,  444,  340, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  340,  340,  340,  340,  340,  443,  440,  131,  327,  430,
			  441,  328,  329,  330,  705,  705,  705,  327,  431,  445,
			  328,  329,  330,  305,  291,  291,  115,  131,  446,  387,
			  444,  767,  484,  389,  389,  390,  390,  266,  300,  131,
			  131,  267,  297,  373,  390,  390,  390,  390,  390,  390,
			  291,  445,  334,  334,  334,  334,  334,  334,  334,  131,
			  446,  281,  281,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  131,  374,  131,  450,  390,  390,  390,  390,
			  390,  390,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  343,  343,  344,  345,  345,  345,  345,  346,

			  347,  348,  349,  350,  374,  281,  131,  450,  290,  287,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  305,  281,  278,  115,
			  343,  343,  344,  345,  345,  345,  345,  346,  347,  348,
			  349,  350,  343,  343,  344,  345,  345,  345,  345,  346,
			  347,  348,  349,  350,  374,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  374,  451,  452,  453,  559,  560,  131,  561,  562,
			  565,  374,  522,  523,  523,  523,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  377, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  377,  377,  374,  566,  451,  452,  453,  559,  560,  131,
			  561,  562,  565,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  305,
			  490,  280,  115,  115,  482,  566,  378,  378,  378,  378,
			  378,  378,  378,  378,  378,  266,  479,  238,  237,  267,
			  567,  374,  304,  379,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  266,
			  131,  131,  567,  267,  381,  381,  381,  381,  381,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,

			  510,  510,  510,  510,  510,  510,  510,  301,  106,  154,
			  266,  266,  131,  131,  267,  267,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  305,  300,  568,  115,  268,  238,  238,  238,
			  238,  391,  391,  391,  390,  476,  297,  392,  392,  392,
			  392,  291,  390,  390,  390,  390,  390,  390,  392,  392,
			  392,  392,  392,  392,  407,  434,  568,  435,  408,  296,
			  276,  277,  290,  287,  281,  436,  569,  570,  437,  571,
			  438,  439,  409,  131,  390,  390,  390,  390,  390,  390,
			  392,  392,  392,  392,  392,  392,  407,  434,  280,  435, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  408,  268,  268,  268,  268,  268,  268,  436,  569,  570,
			  437,  571,  438,  439,  409,  131,  268,  237,  218,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  351,  572,  172,  352,  167,
			  353,  354,  355,  882,   90,   90,  261,  882,  356,  262,
			  263,  264,  882,  882,  419,  357,  420,  358,  421,  447,
			  359,  360,  361,  362,  448,  363,  882,  364,  572,  422,
			  882,  365,  423,  366,  573,  449,  367,  368,  369,  370,
			  371,  372,  106,  106,  106,  106,  419,  545,  420,  545,
			  421,  447,  546,  546,  546,  546,  448,  882,  107,  454,

			  882,  422,  491,  882,  423,  115,  573,  449,  455,  455,
			  456,  457,  458,  457,  457,  459,  460,  461,  462,  463,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  882,  882,  882,  343,
			  343,  344,  345,  345,  345,  345,  346,  347,  348,  349,
			  350,  454,  574,  131,  516,  516,  516,  516,  516,  516,
			  455,  455,  456,  457,  458,  457,  457,  459,  460,  461,
			  462,  463,  281,  281,  281,  281,  281,  546,  546,  546,
			  546,  882,  454,  882,  574,  131,  281,  546,  546,  546,
			  546,  464,  455,  456,  465,  466,  467,  457,  459,  460, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  461,  462,  463,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  220,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  220,  220,  220,  220,  220,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  220,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  220,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  468,  219,  219,  469,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  220,

			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  268,  266,  268,  268,  882, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  267,  281,  282,  281,  281,  882,  882,  291,  291,  291,
			  291,  291,  291,  291,  291,  291,  106,  106,  106,  106,
			  106,  882,  882,  492,  577,  291,  115,  578,  493,  305,
			  106,  115,  115,  161,  882,  551,  551,  551,  551,  485,
			  325,  485,  485,  563,  882,  497,  305,  498,  882,  115,
			  115,  500,  579,  269,  115,  580,  577,  494,  582,  578,
			  564,  324,  325,  324,  324,  549,  305,  549,  581,  115,
			  550,  550,  550,  550,  131,  563,  166,  882,  882,  131,
			  131,  882,  882,  882,  579,  269,  495,  580,  305,  494,
			  582,  115,  564,  305,  882,  308,  115,  131,  131,  882,

			  581,  583,  131,  882,  270,  584,  131,  271,  272,  273,
			  283,  131,  131,  284,  285,  286,  292,  131,  495,  293,
			  294,  295,  112,  324,  325,  324,  324,  308,  306,  131,
			  131,  115,  496,  583,  131,  499,  585,  584,  882,  131,
			  586,  882,  882,  882,  131,  587,  575,  882,  486,  131,
			  882,  487,  488,  489,  556,  882,  557,  557,  557,  557,
			  576,  882,  305,  305,  496,  115,  115,  499,  585,  882,
			  327,  131,  586,  328,  329,  330,  131,  587,  575,  307,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  882,
			  882,  882,  576,  305,  882,  882,  115,  394,  882,  305, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  505,  506,  115,  115,  115,  882,  558,  558,  558,  558,
			  882,  307,  882,  131,  131,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  327,  112,  112,  328,  329,  330,  112,  112,
			  112,  112,  112,  112,  131,  131,  131,  394,  882,  882,
			  131,  131,  131,  588,  882,  882,  882,  501,  324,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  540,  131,  766,  704,  704,
			  502,  503,  131,  131,  131,  588,  504,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,

			  511,  511,  511,  882,  882,  132,  132,  133,  134,  134,
			  134,  134,  135,  136,  137,  138,  139,  305,  882,  767,
			  115,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  589,  590,  591,  592,  593,  131,  594,
			  595,  598,  882,  882,  343,  343,  344,  345,  345,  345,
			  345,  346,  347,  348,  349,  350,  645,  882,  645,  599,
			  600,  646,  646,  646,  646,  589,  590,  591,  592,  593, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  594,  595,  598,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  305,  599,  600,  115,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  596,  601,  604,  597,
			  605,  606,  607,  608,  609,  610,  611,  612,  613,  614,
			  615,  131,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  596,  601,
			  604,  597,  605,  606,  607,  608,  609,  610,  611,  612,

			  613,  614,  615,  131,  882,  882,  882,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  305,  882,  882,  115,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  541,  541,  541,  541,  616,
			  617,  222,  222,  222,  222,  222,  222,  222,  235,  235,
			  235,  235,  235,  235,  131,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  616,  617,  219,  219,  219,  219,  219,  219,  219, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  219,  219,  219,  219,  882,  882,  131,  882,  219,  882,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  305,  649,  308,  115,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  544,  544,  544,  544,
			  547,  547,  547,  547,  602,  389,  389,  390,  390,  649,
			  308,  384,  882,  308,  882,  548,  390,  390,  390,  390,
			  390,  390,  603,  485,  882,  308,  650,  131,  882,  882,
			  238,  238,  238,  238,  238,  882,  602,  882,  618,  478,
			  478,  478,  478,  384,  238,  308,  552,  548,  390,  390,

			  390,  390,  390,  390,  603,  882,  624,  308,  650,  131,
			  308,  625,  626,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  305,
			  622,  651,  115,  637,  523,  523,  523,  523,  390,  390,
			  390,  390,  308,  882,  652,  653,  627,  882,  882,  390,
			  390,  390,  390,  390,  390,  391,  391,  391,  390,  882,
			  628,  882,  629,  651,  882,  115,  390,  390,  390,  390,
			  390,  390,  882,  882,  882,  641,  652,  653,  882,  553,
			  131,  390,  390,  390,  390,  390,  390,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  554,  882,  390,  390, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  390,  390,  390,  390,  550,  550,  550,  550,  550,  550,
			  550,  550,  131,  131,  654,  655,  507,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  305,  882,  647,  115,  551,  551,  551,  551,
			  882,  392,  392,  392,  392,  131,  654,  655,  656,  657,
			  882,  882,  392,  392,  392,  392,  392,  392,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  658,  659,  660,  394,  661,  662,
			  656,  657,  555,  131,  392,  392,  392,  392,  392,  392,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,

			  223,  223,  223,  223,  223,  223,  658,  659,  660,  882,
			  661,  662,  115,  882,  115,  131,  115,  115,  115,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  305,  882,  882,  115,  227,
			  227,  227,  227,  227,  227,  227,  227,  882,  227,  227,
			  227,  227,  227,  227,  227,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  233,  663,  664,  665,  666,  667,  131,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  234,  234,  234,  718,  718,  718,  718,  646,  646,  646,
			  646,  882,  882,  663,  664,  665,  666,  667,  131,  882,
			  882,  882,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  220,  219,  219,
			  219,  219,  219,  219,  223,  223,  223,  223,  223,  223,
			  223,  224,  223,  223,  223,  223,  223,  223,  223,  223,
			  225,  226,  227,  227,  227,  227,  227,  227,  668,  227,
			  227,  227,  227,  227,  227,  227,  230,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,

			  223,  223,  454,  646,  646,  646,  646,  882,  882,  882,
			  668,  455,  455,  456,  457,  458,  457,  457,  459,  460,
			  461,  462,  463,  454,  790,  790,  790,  790,  786,  786,
			  786,  786,  455,  455,  456,  457,  458,  457,  457,  459,
			  460,  461,  462,  463,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  618,  478,  478,  478,  478,  485,  325,  485, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  485,  669,  882,  670,  305,  619,  620,  115,  882,  631,
			  305,  633,  115,  115,  115,  305,  305,  882,  115,  115,
			  882,  644,  644,  644,  644,  305,  671,  621,  115,  882,
			  882,  672,  882,  669,  622,  670,  548,  619,  620,  632,
			  630,  673,  674,  882,  305,  882,  882,  115,  882,  642,
			  642,  642,  642,  308,  675,  131,  676,  677,  671,  621,
			  131,  131,  131,  672,  384,  678,  131,  131,  548,  686,
			  882,  632,  630,  673,  674,  556,  131,  648,  648,  648,
			  648,  478,  478,  478,  478,  308,  675,  131,  676,  677,
			  643,  687,  131,  131,  131,  131,  384,  678,  131,  131,

			  688,  686,  324,  324,  882,  882,  486,  882,  131,  487,
			  488,  489,  324,  324,  324,  324,  324,  882,  394,  882,
			  882,  882,  622,  687,  882,  882,  324,  131,  786,  786,
			  786,  786,  688,  556,  882,  558,  558,  558,  558,  324,
			  305,  882,  882,  115,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  394,  689,  690,  691,
			  692,  693,  694,  695,  696,  697,  698,  699,  700,  701,
			  702,  131,  341,  341,  341,  341,  341,  341,  341,  341, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  341,  341,  341,  341,  341,  341,  341,  341,  882,  689,
			  690,  691,  692,  693,  694,  695,  696,  697,  698,  699,
			  700,  701,  702,  131,  882,  882,  882,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  305,  882,  882,  115,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  634,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  703,
			  308,  308,  308,  716,  716,  716,  716,  723,  724,  725,
			  726,  727,  882,  882,  131,  635,  635,  635,  635,  635,

			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  703,  308,  308,  308,  730,  485,  882,  485,  723,
			  724,  725,  726,  727,  641,  485,  131,  882,  882,  882,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  305,  730,  882,  115,
			  636,  636,  636,  636,  636,  636,  636,  636,  636,  636,
			  636,  636,  636,  636,  636,  636,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  637,  523,  523,  523,  523,  722,  731,  558,
			  558,  558,  558,  732,  733,  638,  639,  131,  375,  375, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  882,  882,  236,  640,  236,  236,
			  731,  236,  236,  882,  641,  732,  733,  638,  639,  131,
			  166,  882,  882,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  640,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  389,  389,  390,  390,
			  305,  305,  882,  115,  115,  882,  734,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  728,  735,  882,
			  882,  729,  882,  736,  390,  390,  390,  390,  390,  390,

			  679,  679,  679,  679,  709,  680,  710,  552,  734,  390,
			  390,  390,  390,  390,  390,  882,  681,  882,  882,  728,
			  735,  131,  131,  729,  553,  736,  390,  390,  390,  390,
			  390,  390,  391,  391,  391,  390,  709,  882,  710,  882,
			  737,  882,  738,  390,  390,  390,  390,  390,  390,  392,
			  392,  392,  392,  131,  131,  706,  706,  706,  706,  739,
			  392,  392,  392,  392,  392,  392,  706,  706,  706,  706,
			  706,  706,  737,  554,  738,  390,  390,  390,  390,  390,
			  390,  305,  882,  308,  115,  740,  741,  882,  680,  882,
			  555,  739,  392,  392,  392,  392,  392,  392,  706,  706, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  706,  706,  706,  706,  792,  792,  792,  792,  882,  682,
			  882,  882,  683,  684,  685,  308,  882,  740,  741,  485,
			  485,  485,  485,  485,  742,  708,  743,  744,  745,  752,
			  753,  754,  131,  485,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  792,  792,  792,  792,  882,  882,  742,  708,  743,  744,
			  745,  752,  753,  754,  131,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  712,  712,  713,

			  713,  882,  882,  714,  714,  714,  713,  882,  713,  713,
			  713,  713,  713,  713,  713,  713,  713,  713,  713,  713,
			  715,  715,  715,  715,  642,  642,  642,  642,  755,  756,
			  757,  715,  715,  715,  715,  715,  715,  882,  882,  717,
			  713,  713,  713,  713,  713,  713,  713,  713,  713,  713,
			  713,  713,  758,  759,  719,  719,  719,  719,  760,  761,
			  755,  756,  757,  715,  715,  715,  715,  715,  715,  548,
			  385,  717,  719,  719,  719,  719,  679,  679,  679,  679,
			  762,  746,  763,  764,  758,  759,  765,  721,  882,  882,
			  760,  761,  681,  794,  795,  720,  768,  705,  705,  705, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  796,  548,  797,  305,  305,  798,  115,  115,  305,  882,
			  882,  115,  762,  799,  763,  764,  800,  801,  765,  721,
			  784,  716,  716,  716,  716,  794,  795,  770,  706,  706,
			  706,  706,  796,  774,  797,  773,  802,  798,  769,  706,
			  706,  706,  706,  706,  706,  799,  803,  804,  800,  801,
			  805,  775,  806,  882,  131,  131,  882,  882,  882,  131,
			  882,  882,  641,  882,  746,  774,  807,  773,  802,  771,
			  808,  706,  706,  706,  706,  706,  706,  882,  803,  804,
			  882,  882,  805,  775,  806,  682,  131,  131,  683,  684,
			  685,  131,  776,  712,  712,  713,  713,  809,  807,  810,

			  811,  882,  808,  812,  713,  713,  713,  713,  713,  713,
			  778,  713,  713,  713,  713,  882,  882,  882,  787,  787,
			  787,  787,  713,  713,  713,  713,  713,  713,  882,  809,
			  882,  810,  811,  788,  777,  812,  713,  713,  713,  713,
			  713,  713,  785,  882,  785,  882,  882,  786,  786,  786,
			  786,  882,  779,  813,  713,  713,  713,  713,  713,  713,
			  780,  714,  714,  714,  713,  788,  882,  882,  719,  719,
			  719,  719,  713,  713,  713,  713,  713,  713,  782,  715,
			  715,  715,  715,  789,  385,  813,  790,  790,  790,  790,
			  715,  715,  715,  715,  715,  715,  679,  679,  679,  679, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  679,  793,  781,  814,  713,  713,  713,  713,  713,  713,
			  679,  791,  815,  791,  816,  789,  792,  792,  792,  792,
			  783,  817,  715,  715,  715,  715,  715,  715,  705,  705,
			  705,  882,  882,  793,  835,  814,  706,  706,  706,  706,
			  836,  837,  305,  838,  815,  115,  816,  706,  706,  706,
			  706,  706,  706,  817,  305,  839,  305,  115,  882,  115,
			  882,  826,  826,  826,  826,  882,  835,  882,  882,  769,
			  882,  819,  836,  837,  840,  838,  788,  771,  882,  706,
			  706,  706,  706,  706,  706,  821,  841,  839,  882,  831,
			  831,  831,  831,  131,  842,  843,  844,  820,  882,  712,

			  712,  713,  713,  819,  832,  131,  840,  131,  788,  851,
			  713,  713,  713,  713,  713,  713,  882,  821,  841,  713,
			  713,  713,  713,  882,  882,  131,  842,  843,  844,  820,
			  713,  713,  713,  713,  713,  713,  832,  131,  882,  131,
			  777,  851,  713,  713,  713,  713,  713,  713,  827,  882,
			  827,  882,  882,  828,  828,  828,  828,  852,  853,  854,
			  779,  855,  713,  713,  713,  713,  713,  713,  714,  714,
			  714,  713,  862,  845,  845,  845,  845,  882,  882,  713,
			  713,  713,  713,  713,  713,  715,  715,  715,  715,  852,
			  853,  854,  857,  855,  882,  115,  715,  715,  715,  715, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  715,  715,  882,  863,  862,  846,  864,  305,  882,  781,
			  115,  713,  713,  713,  713,  713,  713,  829,  858,  829,
			  788,  115,  830,  830,  830,  830,  783,  882,  715,  715,
			  715,  715,  715,  715,  833,  863,  833,  846,  864,  834,
			  834,  834,  834,  131,  866,  856,  643,  828,  828,  828,
			  828,  871,  788,  828,  828,  828,  828,  882,  131,  830,
			  830,  830,  830,  830,  830,  830,  830,  872,  874,  131,
			  834,  834,  834,  834,  882,  131,  866,  856,  859,  859,
			  859,  859,  847,  871,  882,  848,  849,  850,  832,  860,
			  131,  860,  882,  832,  861,  861,  861,  861,  875,  872,

			  874,  131,  834,  834,  834,  834,  845,  845,  845,  845,
			  873,  876,  877,  115,  720,  861,  861,  861,  861,  878,
			  832,  861,  861,  861,  861,  832,  879,  880,  881,  882,
			  875,  845,  845,  845,  845,  845,  882,  882,  865,  882,
			  882,  882,  882,  876,  877,  845,  882,  882,  882,  882,
			  112,  878,  112,  112,  112,  112,  112,  882,  879,  880,
			  881,  131,   76,   76,   76,   76,   76,   76,   76,  882,
			  865,   80,   80,   80,   80,   80,   80,   80,   89,   89,
			   89,   89,   89,   89,   89,   91,   91,   91,   91,   91,
			   91,   91,  882,  131,   98,   98,   98,   98,   98,   98, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   98,  141,  141,  141,  141,  141,  141,  141,  265,  265,
			  265,  265,  265,  265,  265,  847,  882,  882,  848,  849,
			  850,  269,  269,  269,  269,  269,  269,  269,  279,  279,
			  279,  279,  279,  279,  279,  114,  882,  114,  114,  114,
			  114,  114,  341,  341,  341,  341,  341,  341,  483,  882,
			  483,  483,  483,  483,  483,  747,  747,  747,  747,  747,
			  747,  747,  818,  882,  818,  818,  818,  818,  818,   13,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,

			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882, yy_Dummy>>,
			1, 192, 4400)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4591)
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
			    1,    1,    1,    3,    4,   27,  891,    3,    4,   46,
			    3,    4,    5,    5,    5,    5,   27,    5,    6,    6,
			    6,    6,  870,    6,    9,    9,    9,    9,   34,   34,
			   10,   10,   10,   10,   36,   36,   11,   11,   11,   11,
			  869,   46,   12,   12,   12,   12,   29,   41,   15,   15,
			   15,   15,   11,  889,   29,   49,  889,   41,   12,   16,
			   16,   16,   16,   28,   15,   28,   28,   28,   28,   31,
			    5,   31,   31,   31,   31,   16,    6,   45,   40,   41, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  867,   52,   40,   45,   42,   40,   42,   49,   40,   41,
			   54,   40,   96,   96,   80,   84,   42,   55,   80,   84,
			  850,   85,    5,  104,  104,   85,  110,  110,    6,   45,
			   40,  848,   31,   52,   40,   45,   42,   40,   42,   29,
			   40,    5,   54,   40,    5,    5,    5,    6,   42,   55,
			    6,    6,    6,    9,  115,   48,    9,    9,    9,   10,
			  263,  263,   10,   10,   10,   11,  285,  285,   11,   11,
			   11,   12,   48,  847,   12,   12,   12,   15,  174,   43,
			   15,   15,   15,   43,  784,   53,  115,   48,   16,  294,
			  294,   16,   16,   16,   18,   18,   43,   18,   18,   53,

			   18,  782,   18,   18,   48,   18,  780,   18,  778,  112,
			  174,   43,  112,  776,   18,   43,   18,   53,   18,   18,
			   30,   85,   30,   30,   30,   30,   50,   18,   43,  772,
			   44,   53,   18,   18,   30,   30,   50,   44,   44,  175,
			   51,   50,   18,   44,  751,   18,   18,  750,   18,  177,
			   51,   18,  748,   51,  178,  179,   30,   86,   50,   18,
			  112,   86,   44,   30,   18,   18,   30,   30,   50,   44,
			   44,  175,   51,   50,   18,   44,  116,   18,   18,  116,
			   38,  177,   51,  116,   38,   51,  178,  179,   30,   38,
			  176,   38,  112,  176,  619,  619,   38,   38,   18,   18, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   21,  180,   38,  181,   47,  747,   38,   21,  707,   21,
			  685,   38,  176,   38,   47,  176,   47,  116,   38,   38,
			   47,  683,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  180,  682,  181,   47,   63,   66,   66,
			   66,   66,   66,   66,   66,   86,   47,  265,   47,  116,
			  681,  265,   47,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   75,   75,   75,   75,   75,

			   75,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   71,   71,   71,   71,   71,   71, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   71,   71,   71,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   79,   79,   79,   79,  637,
			   79,  182,  623,   79,   87,   79,   79,   79,   87,   81,
			   81,   81,   81,   79,   81,   88,  556,  229,  229,   88,
			   79,  229,   79,  684,  684,   79,   79,   79,   79,  484,
			   79,  117,   79,  182,  117,  269,   79,  118,   79,  269,
			  118,   79,   79,   79,   79,   79,   79,   92,   92,   92,

			   92,  849,  849,   99,   99,   99,   99,  183,  482,  100,
			  100,  100,  100,  157,  157,  157,  157,   81,  106,  106,
			  106,  106,  481,  184,  119,  479,  372,  119,  157,  187,
			  120,  371,  117,  120,  106,  190,  370,  125,  118,  183,
			  125,  121,  191,  120,  121,   87,   87,  369,  162,   81,
			  162,  162,  162,  162,   79,  184,   88,   79,   79,   79,
			  157,  187,  121,  122,  117,  368,  122,  190,   81,  367,
			  118,   81,   81,   81,  191,  119,  125,  126,  270,  153,
			  126,  120,  270,  366,  122,  271,  365,  123,  125,  271,
			  123,  162,  121,  129,  192,  364,  129,  130,  124,  277, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  130,  124,  127,  277,  363,  127,   92,  119,  125,   92,
			   92,   92,   99,  120,  122,   99,   99,   99,  100,  126,
			  125,  100,  100,  100,  121,  123,  192,  106,  126,  362,
			  106,  106,  106,  114,  114,  124,  114,  114,  123,  114,
			  188,  127,  114,  189,  129,  129,  122,  189,  130,  124,
			  194,  126,  197,  127,  199,  188,  200,  123,  361,  198,
			  126,  153,  153,  153,  153,  153,  153,  124,  360,  359,
			  123,  198,  188,  127,  147,  189,  129,  358,  270,  189,
			  130,  124,  194,  271,  197,  127,  199,  188,  200,  201,
			  114,  198,  204,  205,  244,  244,  244,  244,  277,  128,

			  128,  128,  128,  198,  128,  357,  355,  128,  131,  131,
			  131,  131,  139,  131,  354,  139,  131,  166,  166,  166,
			  166,  201,  114,  353,  204,  205,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  128,  133,  128,  166,  133,
			  352,  351,  208,  139,  131,  147,  147,  147,  147,  147,
			  147,  147,  304,  209,  207,  303,  135,  202,  207,  135,
			  161,  301,  161,  161,  161,  161,  202,  128,  300,  137,
			  767,  767,  137,  141,  208,  139,  131,  161,  210,  139, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  139,  139,  139,  139,  139,  209,  207,  133,  128,  202,
			  207,  128,  128,  128,  620,  620,  620,  131,  202,  211,
			  131,  131,  131,  132,  299,  297,  132,  135,  212,  161,
			  210,  767,  296,  163,  163,  163,  163,  273,  295,  133,
			  137,  273,  293,  144,  163,  163,  163,  163,  163,  163,
			  292,  211,  133,  133,  133,  133,  133,  133,  133,  135,
			  212,  290,  289,  135,  135,  135,  135,  135,  135,  135,
			  135,  135,  137,  146,  132,  214,  163,  163,  163,  163,
			  163,  163,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  141,  141,  141,  141,  141,  141,  141,  141,

			  141,  141,  141,  141,  148,  287,  132,  214,  286,  284,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  134,  283,  273,  134,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  144,  144,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  149,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  146,  146,  146,  146,  146,
			  146,  150,  215,  216,  217,  395,  396,  134,  397,  400,
			  402,  151,  356,  356,  356,  356,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  148,  148,  152,  403,  215,  216,  217,  395,  396,  134,
			  397,  400,  402,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  136,
			  309,  279,  136,  309,  264,  403,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  275,  262,  261,  236,  275,
			  404,  145,  111,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  272,
			  136,  309,  404,  272,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,

			  344,  344,  344,  344,  344,  344,  344,  109,  108,  107,
			  278,  276,  136,  309,  278,  276,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  138,  105,  405,  138,  275,  238,  238,  238,
			  238,  164,  164,  164,  164,  238,  103,  165,  165,  165,
			  165,  102,  164,  164,  164,  164,  164,  164,  165,  165,
			  165,  165,  165,  165,  185,  206,  405,  206,  185,  101,
			  272,  272,   97,   95,   94,  206,  406,  407,  206,  408,
			  206,  206,  185,  138,  164,  164,  164,  164,  164,  164,
			  165,  165,  165,  165,  165,  165,  185,  206,   89,  206, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  185,  278,  276,  276,  276,  276,  276,  206,  406,  407,
			  206,  408,  206,  206,  185,  138,  276,   76,   57,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  143,  409,   37,  143,   32,
			  143,  143,  143,   13,    8,    7,  238,    0,  143,  238,
			  238,  238,    0,    0,  195,  143,  195,  143,  195,  213,
			  143,  143,  143,  143,  213,  143,    0,  143,  409,  195,
			    0,  143,  195,  143,  410,  213,  143,  143,  143,  143,
			  143,  143,  220,  220,  220,  220,  195,  384,  195,  384,
			  195,  213,  384,  384,  384,  384,  213,    0,  220,  219,

			    0,  195,  314,    0,  195,  314,  410,  213,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,    0,    0,    0,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  221,  412,  314,  350,  350,  350,  350,  350,  350,
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  288,  288,  288,  288,  288,  545,  545,  545,
			  545,    0,  220,    0,  412,  314,  288,  546,  546,  546,
			  546,  220,  220,  220,  220,  220,  220,  220,  220,  220, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  220,  220,  220,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  227,  227,  227,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  227,  227,  227,  228,  228,  228,  228,  228,  228,  228,
			  228,  228,  228,  228,  228,  228,  228,  228,  228,  230,

			  230,  230,  230,  230,  230,  230,  230,  230,  230,  230,
			  230,  230,  230,  230,  230,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  233,  233,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  233,  233,  233,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  268,  268,  268,  268,    0, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  268,  281,  281,  281,  281,    0,    0,  291,  291,  291,
			  291,  298,  298,  298,  298,  298,  302,  302,  302,  302,
			  302,    0,    0,  316,  414,  298,  316,  415,  318,  319,
			  302,  318,  319,  388,    0,  388,  388,  388,  388,  308,
			  308,  308,  308,  401,    0,  322,  320,  322,    0,  320,
			  322,  326,  416,  268,  326,  417,  414,  319,  418,  415,
			  401,  324,  324,  324,  324,  387,  324,  387,  417,  324,
			  387,  387,  387,  387,  316,  401,  388,    0,    0,  318,
			  319,    0,    0,    0,  416,  268,  320,  417,  321,  319,
			  418,  321,  401,  323,    0,  308,  323,  320,  322,    0,

			  417,  419,  326,    0,  268,  420,  316,  268,  268,  268,
			  281,  318,  319,  281,  281,  281,  291,  324,  320,  291,
			  291,  291,  307,  307,  307,  307,  307,  308,  307,  320,
			  322,  307,  321,  419,  326,  323,  421,  420,    0,  321,
			  422,    0,    0,    0,  323,  423,  413,    0,  308,  324,
			    0,  308,  308,  308,  393,    0,  393,  393,  393,  393,
			  413,    0,  327,  328,  321,  327,  328,  323,  421,    0,
			  324,  321,  422,  324,  324,  324,  323,  423,  413,  307,
			  346,  346,  346,  346,  346,  346,  346,  346,  346,    0,
			    0,    0,  413,  329,    0,    0,  329,  393,    0,  330, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  331,  333,  330,  331,  333,    0,  394,  394,  394,  394,
			    0,  307,    0,  327,  328,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  329,  327,  328,  394,    0,    0,
			  330,  331,  333,  424,    0,    0,    0,  328,  327,  343,
			  343,  343,  343,  343,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  343,  343,  375,  329,  704,  704,  704,
			  329,  329,  330,  331,  333,  424,  330,  345,  345,  345,
			  345,  345,  345,  345,  345,  345,  345,  345,  345,  345,

			  345,  345,  345,    0,    0,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  334,    0,  704,
			  334,  347,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  347,  347,  347,  347,  347,  348,  348,  348,
			  348,  348,  348,  348,  348,  348,  348,  349,  349,  349,
			  349,  349,  349,  349,  349,  349,  349,  349,  349,  349,
			  349,  349,  349,  425,  426,  427,  428,  430,  334,  431,
			  432,  434,    0,    0,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  548,    0,  548,  435,
			  436,  548,  548,  548,  548,  425,  426,  427,  428,  430, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  334,  431,  432,  434,  334,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  334,  334,
			  335,  435,  436,  335,  376,  376,  376,  376,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  377,  377,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  433,  437,  439,  433,
			  440,  441,  442,  443,  444,  445,  446,  447,  448,  449,
			  450,  335,  378,  378,  378,  378,  378,  378,  378,  378,
			  378,  378,  378,  378,  378,  378,  378,  378,  433,  437,
			  439,  433,  440,  441,  442,  443,  444,  445,  446,  447,

			  448,  449,  450,  335,    0,    0,    0,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  335,  336,    0,    0,  336,  379,  379,  379,
			  379,  379,  379,  379,  379,  379,  379,  379,  379,  379,
			  379,  379,  379,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  451,
			  452,  456,  456,  456,  456,  456,  456,  456,  463,  463,
			  463,  463,  463,  463,  336,  381,  381,  381,  381,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  451,  452,  454,  454,  454,  454,  454,  454,  454, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  454,  454,  454,  454,    0,    0,  336,    0,  454,    0,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  337,  559,  486,  337,
			  382,  382,  382,  382,  382,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  383,  383,  383,  383,
			  386,  386,  386,  386,  438,  389,  389,  389,  389,  559,
			  486,  383,    0,  487,    0,  386,  389,  389,  389,  389,
			  389,  389,  438,  486,    0,  488,  560,  337,    0,    0,
			  480,  480,  480,  480,  480,    0,  438,    0,  478,  478,
			  478,  478,  478,  383,  480,  487,  389,  386,  389,  389,

			  389,  389,  389,  389,  438,    0,  487,  488,  560,  337,
			  489,  488,  488,  337,  337,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  338,
			  478,  561,  338,  523,  523,  523,  523,  523,  390,  390,
			  390,  390,  489,    0,  562,  563,  489,    0,    0,  390,
			  390,  390,  390,  390,  390,  391,  391,  391,  391,    0,
			  494,    0,  494,  561,    0,  494,  391,  391,  391,  391,
			  391,  391,    0,    0,    0,  523,  562,  563,    0,  390,
			  338,  390,  390,  390,  390,  390,  390,  459,  459,  459,
			  459,  459,  459,  459,  459,  459,  391,    0,  391,  391, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  391,  391,  391,  391,  549,  549,  549,  549,  550,  550,
			  550,  550,  338,  494,  564,  565,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  339,    0,  551,  339,  551,  551,  551,  551,
			    0,  392,  392,  392,  392,  494,  564,  565,  566,  567,
			    0,    0,  392,  392,  392,  392,  392,  392,  455,  455,
			  455,  455,  455,  455,  455,  455,  455,  455,  455,  455,
			  455,  455,  455,  455,  568,  569,  570,  551,  571,  572,
			  566,  567,  392,  339,  392,  392,  392,  392,  392,  392,
			  457,  457,  457,  457,  457,  457,  457,  457,  457,  457,

			  457,  457,  457,  457,  457,  457,  568,  569,  570,    0,
			  571,  572,  897,    0,  897,  339,  897,  897,  897,  339,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  340,    0,    0,  340,  458,
			  458,  458,  458,  458,  458,  458,  458,    0,  458,  458,
			  458,  458,  458,  458,  458,  460,  460,  460,  460,  460,
			  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,
			  460,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  573,  574,  575,  576,  577,  340,  462,  462,  462,
			  462,  462,  462,  462,  462,  462,  462,  462,  462,  462, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  462,  462,  462,  643,  643,  643,  643,  645,  645,  645,
			  645,    0,    0,  573,  574,  575,  576,  577,  340,    0,
			    0,    0,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  464,  464,
			  464,  464,  464,  464,  464,  464,  464,  464,  464,  464,
			  464,  464,  464,  464,  465,  465,  465,  465,  465,  465,
			  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,
			  466,  466,  466,  466,  466,  466,  466,  466,  578,  466,
			  466,  466,  466,  466,  466,  466,  467,  467,  467,  467,
			  467,  467,  467,  467,  467,  467,  467,  467,  467,  467,

			  467,  467,  468,  646,  646,  646,  646,    0,    0,    0,
			  578,  468,  468,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468,  469,  720,  720,  720,  720,  785,  785,
			  785,  785,  469,  469,  469,  469,  469,  469,  469,  469,
			  469,  469,  469,  469,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  477,  477,  477,  477,  477,  485,  485,  485, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  485,  579,    0,  581,  495,  477,  477,  495,    0,  496,
			  497,  499,  496,  497,  499,  501,  504,    0,  501,  504,
			    0,  547,  547,  547,  547,  502,  582,  477,  502,    0,
			    0,  583,    0,  579,  477,  581,  547,  477,  477,  497,
			  495,  584,  585,    0,  503,    0,    0,  503,    0,  544,
			  544,  544,  544,  485,  586,  495,  587,  589,  582,  477,
			  496,  497,  499,  583,  544,  592,  501,  504,  547,  595,
			    0,  497,  495,  584,  585,  557,  502,  557,  557,  557,
			  557,  622,  622,  622,  622,  485,  586,  495,  587,  589,
			  544,  596,  496,  497,  499,  503,  544,  592,  501,  504,

			  597,  595,  501,  504,    0,    0,  485,    0,  502,  485,
			  485,  485,  502,  502,  502,  502,  502,    0,  557,    0,
			    0,    0,  622,  596,    0,    0,  502,  503,  786,  786,
			  786,  786,  597,  558,    0,  558,  558,  558,  558,  503,
			  507,    0,    0,  507,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  558,  598,  599,  600,
			  601,  602,  603,  604,  605,  606,  608,  611,  612,  613,
			  614,  507,  512,  512,  512,  512,  512,  512,  512,  512, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  512,  512,  512,  512,  512,  512,  512,  512,    0,  598,
			  599,  600,  601,  602,  603,  604,  605,  606,  608,  611,
			  612,  613,  614,  507,    0,    0,    0,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  507,  508,    0,    0,  508,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  615,
			  624,  626,  627,  641,  641,  641,  641,  649,  652,  653,
			  654,  657,    0,    0,  508,  515,  515,  515,  515,  515,

			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  615,  624,  626,  627,  659,  624,    0,  627,  649,
			  652,  653,  654,  657,  641,  626,  508,    0,    0,    0,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  509,  659,    0,  509,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  522,  522,  522,  522,  522,  648,  661,  648,
			  648,  648,  648,  662,  663,  522,  522,  509,  542,  542, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,    0,    0,  892,  522,  892,  892,
			  661,  892,  892,    0,  522,  662,  663,  522,  522,  509,
			  648,    0,    0,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  522,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  552,  552,  552,  552,
			  632,  630,    0,  632,  630,    0,  664,  552,  552,  552,
			  552,  552,  552,  553,  553,  553,  553,  658,  665,    0,
			    0,  658,    0,  666,  553,  553,  553,  553,  553,  553,

			  593,  593,  593,  593,  630,  593,  632,  552,  664,  552,
			  552,  552,  552,  552,  552,    0,  593,    0,    0,  658,
			  665,  632,  630,  658,  553,  666,  553,  553,  553,  553,
			  553,  553,  554,  554,  554,  554,  630,    0,  632,    0,
			  667,    0,  669,  554,  554,  554,  554,  554,  554,  555,
			  555,  555,  555,  632,  630,  621,  621,  621,  621,  670,
			  555,  555,  555,  555,  555,  555,  621,  621,  621,  621,
			  621,  621,  667,  554,  669,  554,  554,  554,  554,  554,
			  554,  628,    0,  625,  628,  671,  672,    0,  593,    0,
			  555,  670,  555,  555,  555,  555,  555,  555,  621,  621, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  621,  621,  621,  621,  791,  791,  791,  791,    0,  593,
			    0,    0,  593,  593,  593,  625,    0,  671,  672,  625,
			  625,  625,  625,  625,  674,  628,  675,  676,  678,  686,
			  687,  688,  628,  625,  634,  634,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  792,  792,  792,  792,    0,    0,  674,  628,  675,  676,
			  678,  686,  687,  688,  628,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  636,  636,  636,  636,  636,  636,  636,  636,  636,
			  636,  636,  636,  636,  636,  636,  636,  638,  638,  638,

			  638,    0,    0,  639,  639,  639,  639,    0,  638,  638,
			  638,  638,  638,  638,  639,  639,  639,  639,  639,  639,
			  640,  640,  640,  640,  642,  642,  642,  642,  689,  690,
			  691,  640,  640,  640,  640,  640,  640,    0,    0,  642,
			  638,  638,  638,  638,  638,  638,  639,  639,  639,  639,
			  639,  639,  692,  693,  644,  644,  644,  644,  694,  696,
			  689,  690,  691,  640,  640,  640,  640,  640,  640,  644,
			  647,  642,  647,  647,  647,  647,  679,  679,  679,  679,
			  697,  679,  700,  701,  692,  693,  703,  647,    0,    0,
			  694,  696,  679,  725,  726,  644,  705,  705,  705,  705, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  727,  644,  729,  708,  709,  730,  708,  709,  710,    0,
			    0,  710,  697,  731,  700,  701,  732,  735,  703,  647,
			  716,  716,  716,  716,  716,  725,  726,  706,  706,  706,
			  706,  706,  727,  709,  729,  708,  737,  730,  705,  706,
			  706,  706,  706,  706,  706,  731,  738,  740,  732,  735,
			  741,  710,  742,    0,  708,  709,    0,    0,    0,  710,
			    0,    0,  716,    0,  679,  709,  743,  708,  737,  706,
			  744,  706,  706,  706,  706,  706,  706,    0,  738,  740,
			    0,    0,  741,  710,  742,  679,  708,  709,  679,  679,
			  679,  710,  712,  712,  712,  712,  712,  745,  743,  752,

			  753,    0,  744,  755,  712,  712,  712,  712,  712,  712,
			  713,  713,  713,  713,  713,    0,    0,    0,  718,  718,
			  718,  718,  713,  713,  713,  713,  713,  713,    0,  745,
			    0,  752,  753,  718,  712,  755,  712,  712,  712,  712,
			  712,  712,  717,    0,  717,    0,    0,  717,  717,  717,
			  717,    0,  713,  756,  713,  713,  713,  713,  713,  713,
			  714,  714,  714,  714,  714,  718,    0,    0,  719,  719,
			  719,  719,  714,  714,  714,  714,  714,  714,  715,  715,
			  715,  715,  715,  719,  722,  756,  722,  722,  722,  722,
			  715,  715,  715,  715,  715,  715,  749,  749,  749,  749, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  749,  722,  714,  758,  714,  714,  714,  714,  714,  714,
			  749,  721,  762,  721,  763,  719,  721,  721,  721,  721,
			  715,  765,  715,  715,  715,  715,  715,  715,  769,  769,
			  769,    0,    0,  722,  794,  758,  771,  771,  771,  771,
			  795,  797,  773,  799,  762,  773,  763,  771,  771,  771,
			  771,  771,  771,  765,  774,  800,  775,  774,    0,  775,
			    0,  787,  787,  787,  787,    0,  794,    0,    0,  769,
			    0,  773,  795,  797,  801,  799,  787,  771,    0,  771,
			  771,  771,  771,  771,  771,  775,  802,  800,    0,  790,
			  790,  790,  790,  773,  805,  808,  809,  774,    0,  777,

			  777,  777,  777,  773,  790,  774,  801,  775,  787,  811,
			  777,  777,  777,  777,  777,  777,    0,  775,  802,  779,
			  779,  779,  779,    0,    0,  773,  805,  808,  809,  774,
			  779,  779,  779,  779,  779,  779,  790,  774,    0,  775,
			  777,  811,  777,  777,  777,  777,  777,  777,  788,    0,
			  788,    0,    0,  788,  788,  788,  788,  812,  813,  815,
			  779,  816,  779,  779,  779,  779,  779,  779,  781,  781,
			  781,  781,  836,  810,  810,  810,  810,    0,    0,  781,
			  781,  781,  781,  781,  781,  783,  783,  783,  783,  812,
			  813,  815,  820,  816,    0,  820,  783,  783,  783,  783, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  783,  783,    0,  839,  836,  810,  843,  819,    0,  781,
			  819,  781,  781,  781,  781,  781,  781,  789,  821,  789,
			  826,  821,  789,  789,  789,  789,  783,    0,  783,  783,
			  783,  783,  783,  783,  793,  839,  793,  810,  843,  793,
			  793,  793,  793,  820,  846,  819,  826,  827,  827,  827,
			  827,  851,  826,  828,  828,  828,  828,    0,  819,  829,
			  829,  829,  829,  830,  830,  830,  830,  853,  863,  821,
			  833,  833,  833,  833,    0,  820,  846,  819,  831,  831,
			  831,  831,  810,  851,    0,  810,  810,  810,  859,  832,
			  819,  832,    0,  831,  832,  832,  832,  832,  865,  853,

			  863,  821,  834,  834,  834,  834,  845,  845,  845,  845,
			  856,  866,  875,  856,  859,  860,  860,  860,  860,  876,
			  859,  861,  861,  861,  861,  831,  877,  878,  879,    0,
			  865,  868,  868,  868,  868,  868,    0,    0,  845,    0,
			    0,    0,    0,  866,  875,  868,    0,    0,    0,    0,
			  888,  876,  888,  888,  888,  888,  888,    0,  877,  878,
			  879,  856,  883,  883,  883,  883,  883,  883,  883,    0,
			  845,  884,  884,  884,  884,  884,  884,  884,  885,  885,
			  885,  885,  885,  885,  885,  886,  886,  886,  886,  886,
			  886,  886,    0,  856,  887,  887,  887,  887,  887,  887, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  887,  890,  890,  890,  890,  890,  890,  890,  893,  893,
			  893,  893,  893,  893,  893,  845,    0,    0,  845,  845,
			  845,  894,  894,  894,  894,  894,  894,  894,  895,  895,
			  895,  895,  895,  895,  895,  896,    0,  896,  896,  896,
			  896,  896,  898,  898,  898,  898,  898,  898,  899,    0,
			  899,  899,  899,  899,  899,  900,  900,  900,  900,  900,
			  900,  900,  901,    0,  901,  901,  901,  901,  901,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,

			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882, yy_Dummy>>,
			1, 192, 4400)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 901)
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
			    0,    0,    0,  120,  121,  130,  136, 1442, 1441,  142,
			  148,  154,  160, 1443, 4469,  166,  177, 4469,  287,    0,
			 4469,  407, 4469, 4469, 4469, 4469, 4469,  107,  164,  146,
			  301,  170, 1411, 4469,  121, 4469,  126, 1409,  346,    0,
			  159,  131,  161,  247,  293,  157,   83,  381,  223,  139,
			  290,  301,  156,  253,  171,  171, 4469, 1359, 4469, 4469,
			 4469, 4469, 4469,  338,  369,  385,  345,  436,  452,  468,
			  484,  500,  509,  519,  535,  401, 1410, 4469, 4469,  643,
			  211,  657, 4469, 4469,  212,  218,  354,  651,  662, 1395,
			 4469, 4469,  695, 4469, 1271, 1272,  118, 1278, 4469,  701,

			  707, 1351, 1248, 1245,  129, 1239,  716, 1291, 1205, 1206,
			  132, 1158,  302, 4469,  832,  196,  369,  674,  680,  717,
			  723,  734,  756,  780,  791,  730,  770,  795,  897,  786,
			  790,  906, 1016,  949, 1119,  969, 1222,  982, 1325,  905,
			    0,  981, 1019, 1428, 1031, 1239, 1061,  862, 1092, 1142,
			 1159, 1169, 1190,  767, 4469, 4469, 4469,  692, 4469, 4469,
			 4469,  961,  729, 1012, 1320, 1326,  896, 4469, 4469, 4469,
			 4469, 4469, 4469,    0,  229,  303,  350,  314,  304,  304,
			  375,  381,  606,  671,  674, 1331,    0,  679,  805,  796,
			  692,  710,  748,    0,  803, 1419,    0,  810,  825,  803, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  806,  854,  943,    0,  843,  857, 1330,  931,  918,  924,
			  962,  967,  981, 1424, 1026, 1132, 1137, 1125, 4469, 1397,
			 1480, 1449, 1426, 1509, 1525, 1541, 1557, 1573, 1589,  562,
			 1605, 1621, 1637, 1653, 1669, 1685, 1241, 4469, 1335, 4469,
			 4469, 4469, 4469, 4469,  873, 4469, 4469, 4469, 4469, 4469,
			 4469, 4469, 4469, 4469, 4469, 4469, 4469, 4469, 4469, 4469,
			 4469, 1144, 1145,  166, 1140,  454, 4469, 4469, 1793,  682,
			  775,  782, 1276, 1034, 4469, 1242, 1308,  796, 1307, 1228,
			 4469, 1799, 4469, 1024, 1008,  172, 1014, 1011, 1478,  960,
			  967, 1805,  947,  941,  195,  944, 1024,  931, 1717,  922,

			  894,  887, 1722,  873,  878, 4469, 4469, 1921, 1837, 1223,
			 4469, 4469, 4469, 4469, 1495, 4469, 1816, 4469, 1821, 1822,
			 1839, 1881, 1840, 1886, 1859, 4469, 1844, 1955, 1956, 1986,
			 1992, 1993, 4469, 1994, 2110, 2213, 2316, 2419, 2522, 2625,
			 2728, 4469, 4469, 1965, 1197, 1993, 1886, 2027, 2037, 2053,
			 1460,  949,  948,  911,  902,  894, 1161,  893,  865,  857,
			  856,  846,  817,  792,  783,  774,  771,  757,  753,  735,
			  724,  719,  714, 4469, 4469, 2063, 2130, 2146, 2178, 2233,
			 2249, 2281, 2336, 2425, 1471, 4469, 2429, 1849, 1814, 2434,
			 2517, 2534, 2620, 1935, 1985, 1129, 1131, 1146,    0,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1139, 1811, 1146, 1153, 1197, 1302, 1327, 1325, 1343, 1404,
			 1438,    0, 1500, 1914, 1788, 1777, 1801, 1811, 1815, 1865,
			 1865, 1900, 1893, 1913, 2017, 2131, 2117, 2129, 2120,    0,
			 2131, 2113, 2119, 2222, 2135, 2153, 2158, 2205, 2420, 2209,
			 2224, 2229, 2226, 2223, 2219, 2229, 2223, 2231, 2220, 2229,
			 2230, 2324, 2315,    0, 2299, 2564, 2258, 2596, 2645, 2493,
			 2661, 2671, 2693, 2274, 2744, 2760, 2776, 2792, 2800, 2821,
			 4469, 4469, 4469, 2850, 2866, 2882, 4469, 2972, 2468,  631,
			 2386,  620,  614,    0,  604, 2995, 2370, 2405, 2417, 2452,
			 4469, 4469, 4469, 4469, 2555, 2997, 3002, 3003, 4469, 3004,

			 4469, 3008, 3018, 3037, 3009, 4469, 4469, 3133, 3236, 3339,
			 3050, 3066, 3098, 3153, 3169, 3201, 3256, 4469, 4469, 4469,
			 4469, 4469, 3362, 2513, 4469, 4469, 4469, 4469, 4469, 4469,
			 4469, 4469, 4469, 4469, 4469, 4469, 4469, 4469, 4469, 4469,
			 4469, 3272, 3304, 3356, 3028, 1556, 1566, 3000, 2170, 2583,
			 2587, 2615, 3445, 3462, 3511, 3528,  647, 3056, 3114, 2377,
			 2425, 2481, 2506, 2511, 2574, 2573, 2598, 2613, 2623, 2639,
			 2638, 2629, 2645, 2741, 2733, 2738, 2735, 2736, 2842, 2949,
			    0, 2967, 2986, 2976, 2986, 2993, 3018, 3007,    0, 3014,
			    0,    0, 3022, 3498,    0, 3029, 3039, 3060, 3140, 3129, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3135, 3140, 3129, 3139, 3127, 3150, 3136,    0, 3139,    0,
			    0, 3151, 3151, 3137, 3147, 3247,    0,    0, 4469,  373,
			  993, 3534, 3060,  580, 3222, 3525, 3223, 3224, 3574, 4469,
			 3464, 4469, 3463, 4469, 3540, 3571, 3587,  637, 3676, 3682,
			 3699, 3262, 3703, 2782, 3733, 2786, 2882, 3751, 3368, 3237,
			    0,    0, 3243, 3250, 3257,    0,    0, 3242, 3451, 3270,
			    0, 3339, 3354, 3357, 3440, 3453, 3442, 3495,    0, 3493,
			 3514, 3549, 3546,    0, 3584, 3592, 3587,    0, 3592, 3774,
			 4469,  442,  341,  330,  579,  326, 3597, 3581, 3576, 3688,
			 3693, 3694, 3703, 3717, 3707,    0, 3708, 3748,    0,    0,

			 3742, 3747,    0, 3741, 2057, 3776, 3807,  341, 3796, 3797,
			 3801, 4469, 3872, 3890, 3940, 3958, 3800, 3926, 3897, 3947,
			 2903, 3995, 3965,    0,    0, 3757, 3742, 3749,    0, 3756,
			 3754, 3777, 3784,    0,    0, 3781,    0, 3804, 3810,    0,
			 3797, 3805, 3801, 3815, 3838, 3846, 4469,  412,  258, 3902,
			  245,  250, 3856, 3850,    0, 3858, 3908,    0, 3967,    0,
			    0,    0, 3961, 3969,    0, 3970, 4469,  969, 4469, 4007,
			 4469, 4015,  261, 4035, 4047, 4049,  301, 4078,  296, 4098,
			  294, 4147,  289, 4164,  272, 2907, 3107, 4040, 4132, 4201,
			 4068, 3583, 3629, 4218, 3999, 3989,    0, 3996,    0, 4008, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 4022, 4039, 4043,    0,    0, 4056,    0,    0, 4050, 4060,
			 4171, 4063, 4121, 4124,    0, 4123, 4125,    0,    0, 4200,
			 4185, 4211, 4469, 4469, 4469, 4469, 4184, 4226, 4232, 4238,
			 4242, 4257, 4273, 4249, 4281,    0, 4136,    0,    0, 4160,
			    0,    0,    0, 4155,    0, 4304, 4201,  170,  130,  607,
			  126, 4202,    0, 4231,    0,    0, 4303, 4469, 4469, 4252,
			 4294, 4300,    0, 4232,    0, 4255, 4279,  106, 4237,   58,
			   48,    0,    0, 4469,    0, 4280, 4269, 4276, 4277, 4278,
			    0, 4469, 4469, 4361, 4370, 4377, 4384, 4393, 4349,  170,
			 4400,  120, 3415, 4407, 4420, 4427, 4434, 2711, 4441, 4447,

			 4454, 4461, yy_Dummy>>,
			1, 102, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 901)
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
			    0,  882,    1,  883,  883,  884,  884,  885,  885,  886,
			  886,  887,  887,  882,  882,  882,  882,  882,  888,  889,
			  882,  890,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  892,  882,  882,  882,
			  893,  893,  882,  882,  894,  893,  893,  893,  893,  895,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,

			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  888,  882,  896,  897,  888,  888,  888,  888,
			  888,  888,  888,  888,  888,  888,  888,  888,  888,  888,
			  888,  888,  888,  888,  888,  888,  888,  888,  888,  888,
			  889,  898,  898,  898,  898,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  892,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  893,  882,  882,  893,  894,
			  893,  893,  893,  893,  882,  893,  893,  893,  893,  895,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  899,  882,  882,  882,

			  882,  882,  882,  882,  882,  882,  882,  896,  897,  888,
			  882,  882,  882,  882,  888,  882,  888,  882,  888,  888,
			  888,  888,  888,  888,  888,  882,  888,  888,  888,  888,
			  888,  888,  882,  888,  888,  888,  888,  888,  888,  888,
			  888,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  898,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  891,  891,  891,  891,  891, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  899,  899,  897,  897,  897,  897,  897,
			  882,  882,  882,  882,  888,  888,  888,  888,  882,  888,

			  882,  888,  888,  888,  888,  882,  882,  888,  888,  888,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  882,  882,
			  882,  882,  882,  899,  897,  897,  897,  897,  888,  882,
			  888,  882,  888,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  882,
			  882,  882,  882,  882,  882,  882,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,

			  891,  891,  891,  891,  882,  882,  882,  899,  888,  888,
			  888,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  882,  900,  882,  882,
			  882,  882,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  882,  882,  882,  882,
			  882,  882,  899,  888,  888,  888,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  891,  891,  891,  891,  891,  891, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  901,  888,
			  888,  888,  882,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  882,  891,  882,  882,  882,
			  882,  891,  891,  891,  891,  891,  888,  882,  882,  882,
			  882,  882,  891,  891,  891,  882,  891,  882,  882,  882,
			  882,  891,  891,  882,  891,  882,  891,  882,  891,  882,
			  891,  882,    0,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882,

			  882,  882, yy_Dummy>>,
			1, 102, 800)
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
			  107,  107,  107,  107,  107,  108,  104,  104,  104,  109,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  110,  110,  111,  112,  112,  112,  112,  112, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  113,  114,  115,  116,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  118,  119,  119,
			  120,  121,  121,  121,  122,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,    1, yy_Dummy>>,
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
			    7,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 883)
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
			  628,  630,  631,  632,  633,  634,  635,  636,  637,  639,
			  640,  642,  644,  645,  647,  649,  650,  651,  652,  653, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  654,  655,  656,  657,  658,  659,  660,  661,  663,  664,
			  666,  668,  669,  670,  671,  672,  673,  675,  677,  678,
			  678,  678,  678,  678,  679,  679,  679,  679,  679,  680,
			  682,  683,  685,  686,  688,  688,  688,  688,  689,  689,
			  689,  689,  689,  690,  690,  691,  691,  692,  693,  694,
			  695,  697,  699,  700,  701,  702,  704,  706,  707,  708,
			  709,  711,  712,  713,  714,  715,  716,  717,  718,  720,
			  721,  722,  723,  724,  726,  727,  728,  729,  731,  732,
			  732,  733,  733,  733,  733,  733,  733,  734,  735,  736,
			  737,  738,  739,  740,  741,  742,  744,  745,  746,  748,

			  750,  751,  752,  754,  755,  755,  755,  755,  756,  757,
			  758,  759,  760,  760,  760,  760,  760,  760,  760,  761,
			  762,  762,  762,  763,  765,  767,  768,  769,  770,  772,
			  773,  774,  775,  776,  778,  780,  781,  783,  784,  785,
			  787,  788,  789,  790,  791,  792,  793,  794,  794,  794,
			  794,  794,  794,  795,  796,  798,  799,  800,  802,  803,
			  805,  807,  809,  810,  811,  813,  814,  815,  815,  816,
			  816,  817,  817,  818,  819,  820,  821,  821,  821,  821,
			  821,  821,  821,  821,  821,  821,  821,  822,  823,  823,
			  823,  824,  824,  825,  825,  826,  827,  829,  830,  832, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  833,  834,  835,  836,  838,  840,  841,  843,  845,  846,
			  847,  848,  849,  850,  851,  853,  854,  855,  857,  859,
			  860,  861,  862,  864,  865,  867,  868,  869,  869,  870,
			  870,  871,  872,  872,  872,  873,  875,  876,  878,  880,
			  881,  883,  885,  887,  888,  890,  890,  891,  891,  891,
			  891,  891,  892,  894,  895,  897,  899,  900,  902,  904,
			  905,  905,  906,  908,  909,  911,  911,  912,  912,  912,
			  912,  912,  914,  916,  918,  920,  920,  921,  921,  922,
			  922,  924,  925,  925, yy_Dummy>>,
			1, 84, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 924)
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
			    0,  192,  192,  194,  194,  228,  226,  227,    1,  226,
			  227,    1,  227,   36,  226,  227,  195,  226,  227,   47,
			  226,  227,   14,  226,  227,  160,  226,  227,   24,  226,
			  227,   25,  226,  227,   32,  226,  227,   30,  226,  227,
			    9,  226,  227,   31,  226,  227,   13,  226,  227,   33,
			  226,  227,  124,  226,  227,  124,  226,  227,    8,  226,
			  227,    7,  226,  227,   18,  226,  227,   17,  226,  227,
			   19,  226,  227,   11,  226,  227,  123,  226,  227,  123,
			  226,  227,  123,  226,  227,  123,  226,  227,  123,  226,
			  227,  123,  226,  227,  123,  226,  227,  123,  226,  227,

			  123,  226,  227,  123,  226,  227,  123,  226,  227,  123,
			  226,  227,  123,  226,  227,  123,  226,  227,  123,  226,
			  227,  123,  226,  227,  123,  226,  227,  123,  226,  227,
			   28,  226,  227,  226,  227,   29,  226,  227,   34,  226,
			  227,   26,  226,  227,   27,  226,  227,   12,  226,  227,
			  226,  227,  226,  227,  226,  227,  226,  227,  226,  227,
			  226,  227,  226,  227,  226,  227,  226,  227,  226,  227,
			  226,  227,  226,  227,  226,  227,  196,  227,  225,  227,
			  223,  227,  224,  227,  192,  227,  192,  227,  191,  227,
			  190,  227,  192,  227,  192,  227,  192,  227,  192,  227, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  192,  227,  194,  227,  193,  227,  188,  227,  188,  227,
			  187,  227,  188,  227,  188,  227,  188,  227,  188,  227,
			    6,  227,    5,    6,  227,    5,  227,    6,  227,    6,
			  227,    6,  227,    6,  227,    6,  227,    1,  195,  184,
			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  195,  195,  195, -413,  195,  195,  195, -413,  195,
			  195,  195,  195,  195,  195,  195,  195,   47,  160,  160,
			  160,  160,    2,   35,   10,  130,   39,   23,   22,  130,
			  124,   15,   37,   20,   21,   38,   16,  123,  123,  123,
			  123,  123,   54,  123,  123,  123,  123,  123,  123,  123,

			  123,   67,  123,  123,  123,  123,  123,  123,  123,   79,
			  123,  123,  123,   86,  123,  123,  123,  123,  123,  123,
			  123,   98,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,   40,   48,    1,
			   48,   43,   48,  196,  223,  213,  211,  212,  214,  215,
			  216,  217,  197,  198,  199,  200,  201,  202,  203,  204,
			  205,  206,  207,  208,  209,  210,  192,  191,  190,  192,
			  192,  192,  192,  192,  192,  189,  190,  192,  192,  192,
			  192,  194,  193,  187,    5,    4,  185,  182,  185,  195,
			 -413, -413,  195,  168,  185,  166,  185,  167,  185,  169, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  185,  195,  162,  185,  195,  163,  185,  195,  195,  195,
			  195,  195,  195,  195, -186,  195,  195,  195,  195,  195,
			  195,  170,  185,  195,  195,  195,  195,  195,  195,  195,
			  195,  160,  131,  160,  160,  160,  160,  160,  160,  160,
			  160,  160,  160,  160,  160,  160,  160,  160,  160,  160,
			  160,  160,  160,  160,  160,  160,  133,  160,  131,  160,
			  130,  125,  130,  124,  128,  129,  129,  127,  129,  126,
			  124,  123,  123,  123,   52,  123,   53,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,   70,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,

			  123,  123,  123,  123,  123,  123,   90,  123,  123,   93,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  122,  123,   41,   48,   42,   48,
			   45,   46,   44,  222,    4,    4,  174,  185,  171,  185,
			  164,  185,  165,  185,  195,  195,  195,  195,  179,  185,
			  195,  173,  185,  195,  195,  195,  195,  172,  185,  183,
			  185,  195,  195,  195,  150,  148,  149,  151,  152,  161,
			  161,  153,  154,  134,  135,  136,  137,  138,  139,  140,
			  141,  142,  143,  144,  145,  146,  147,  132,  160,  130, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  130,  130,  130,  124,  124,  124,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			   68,  123,  123,  123,  123,  123,  123,  123,   77,  123,
			  123,  123,  123,  123,  123,  123,  123,   87,  123,  123,
			   89,  123,   91,  123,  123,   96,  123,   97,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  111,  123,  123,  113,  123,  114,  123,  123,  123,
			  123,  123,  123,  120,  123,  121,  123,  218,    4,  195,
			  175,  185,  195,  178,  185,  195,  181,  185,  161,  130,
			  130,  130,  130,  124,  123,   50,  123,   51,  123,  123,

			  123,  123,   58,  123,   59,  123,  123,  123,  123,   64,
			  123,  123,  123,  123,  123,  123,  123,  123,   75,  123,
			  123,  123,  123,  123,   82,  123,  123,  123,  123,   88,
			  123,  123,   94,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  108,  123,  123,  123,  112,  123,  115,  123,
			  123,  123,  118,  123,  123,    4,  195,  195,  195,  155,
			  130,  130,  130,   49,  123,   55,  123,  123,  123,  123,
			   61,  123,  123,  123,  123,  123,   69,  123,   71,  123,
			  123,   73,  123,  123,  123,   78,  123,  123,  123,  123,
			  123,  123,  123,   95,  123,  123,  101,  123,  123,  123, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  104,  123,  123,  106,  123,  107,  123,  109,  123,  123,
			  123,  117,  123,  123,  221,  220,  219,    4,  195,  195,
			  195,  130,  130,  130,  130,  123,  123,   60,  123,  123,
			   63,  123,  123,  123,  123,  123,   76,  123,   80,  123,
			  123,   83,  123,   84,  123,  123,  123,  123,  123,  123,
			  123,  105,  123,  123,  123,  119,  123,    3,    4,  195,
			  195,  195,  158,  159,  159,  157,  159,  156,  130,  130,
			  130,  130,  130,   56,  123,  123,   62,  123,   65,  123,
			  123,   72,  123,   74,  123,   81,  123,  123,   92,  123,
			  123,  123,  102,  123,  123,  110,  123,  116,  123,  195,

			  177,  185,  180,  185,  130,  130,   57,  123,  123,   85,
			  123,  123,  100,  123,  103,  123,  176,  185,   66,  123,
			  123,  123,   99,  123,   99, yy_Dummy>>,
			1, 125, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 4469
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 882
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 883
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

	yyNb_rules: INTEGER = 227
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 228
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
