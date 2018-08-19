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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 42 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_FREE
				process_id_as
			
when 43 then
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
			
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 45 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 47 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 48 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 49 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			
when 50 then
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
			
when 51 then
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
			
when 52 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 53 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 54 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 55 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 56 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			
when 57 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 58 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 59 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			
when 60 then
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
			
when 61 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 62 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 63 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 64 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 65 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 66 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 67 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 68 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 69 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 71 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 72 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 73 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 74 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 75 then
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
			
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 77 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 78 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 79 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 80 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
				last_token := TE_IS
			
when 81 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 82 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 83 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 84 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 85 then
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
			
when 86 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 87 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 88 then
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
			
when 89 then
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
			
when 90 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 91 then
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
			
when 92 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 93 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 94 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 96 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 97 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 99 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 103 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 104 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 105 then
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
			
when 106 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 107 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 108 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_TUPLE
				process_id_as
			
when 110 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 111 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 112 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 113 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_detachable_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				last_token := TE_ID
				process_id_as
			
when 118 then
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
			
when 119 then
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
			
when 120 then
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
			
when 121 then
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
			
when 122 then
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
			
when 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end
		-- Recognizes erronous binary and octal numbers.
				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 124 then
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
			
when 125 then
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
			
when 126 then
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
			
when 127 then
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
			
when 128 then
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
			
when 129 then
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
			
when 130 then
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
			
when 131 then
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
			
when 132 then
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
			
when 133 then
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
			
when 134 then
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
			
when 135 then
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
			
when 136 then
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
			
when 137 then
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
			
when 138 then
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
			
when 139 then
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
			
when 140 then
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
			
when 141 then
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
			
when 142 then
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
			
when 143 then
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
			
when 144 then
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
			
when 145 then
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
			
when 146 then
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
			
when 147 then
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
			
when 148 then
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
			
when 149 then
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
			
when 150 then
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
			
when 151 then
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
			
when 152 then
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
			
when 153 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_invalid_integer_error (token_buffer)
			
when 154 then
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
			
when 155 then
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
			
when 156 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LT)
			
when 157 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GT)
			
when 158 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_LE)
			
when 159 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_GE)
			
when 160 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PLUS)
			
when 161 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MINUS)
			
when 162 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_STAR)
			
when 163 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_SLASH)
			
when 164 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_POWER)
			
when 165 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_DIV)
			
when 166 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_MOD)
			
when 167 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_BRACKET)
			
when 168 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_PARENTHESES)
			
when 169 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 170 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 171 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 172 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 173 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 174 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 175 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 176 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 179 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 180 then
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
			
when 181 then
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
			
when 182 then
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
			
when 183 then
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
			
when 184 then
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
			
when 185 then
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
			
when 186 then
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
				append_text_to_string (token_buffer)
				if token_buffer.count > 1 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 188 then
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
			
when 189 then
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
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 211 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 212 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_natural_32)
			
when 213 then
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
			
when 214 then
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
			
when 215 then
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
			
when 216 then
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
			
when 217 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 218 then
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
			create an_array.make_filled (0, 0, 4016)
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

			   14,   14,   14,   14,   14,   63,   64,   65,   66,   67,
			   68,   69,   70,   71,   72,   73,   74,   76,   76,  153,
			  605,   77,   77,  198,   78,   78,   80,   81,   80,   80,
			  154,   82,   80,   81,   80,   80,  205,   82,   91,   92,
			   91,   91,  167,  168,   91,   92,   91,   91,  169,  170,
			   98,   99,   98,   98,  203,  198,   98,   99,   98,   98,
			  184,  212,  105,  105,  105,  105,  100,  820,  205,  213,
			  185,  204,  100,  105,  105,  105,  105,  155,  106,  156,
			  156,  156,  156,  214,   83,  196,  203,  157,  215,  106,
			   83,  197,  184,  212,  160,  158,  161,  161,  161,  161, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  820,  213,  185,  204,  216,  218,  218,  218,  218,  218,
			  218,  218,  219,  218,  218,  214,   83,  196,  283,  284,
			  215,  820,   83,  197,  220,  220,  220,  261,  369,   84,
			  846,  262,   85,   86,   87,   84,  216,  165,   85,   86,
			   87,   93,  293,  294,   94,   95,   96,   93,  297,  298,
			   94,   95,   96,  101,  843,  303,  102,  103,  104,  101,
			  159,  753,  102,  103,  104,  107,  820,  390,  108,  109,
			  110,  230,  230,  230,  230,  800,  107,  467,  468,  108,
			  109,  110,  112,  113,  799,  114,  113,  303,  115,  798,
			  116,  117,  189,  118,  261,  119,  190,  261,  269,  390,

			  797,  262,  120,  754,  121,  793,  113,  122,  160,  191,
			  161,  161,  161,  161,  186,  123,  187,  371,  371,  371,
			  124,  125,  162,  163,  189,  179,  188,  206,  190,  180,
			  126,  391,  181,  127,  128,  182,  129,  207,  183,  122,
			  392,  191,  208,  393,  164,  394,  186,  123,  187,  283,
			  284,  165,  124,  125,  162,  163,  261,  179,  188,  206,
			  262,  180,  126,  391,  181,  130,  113,  182,  395,  207,
			  183,  662,  392,  662,  208,  393,  164,  394,  293,  294,
			  131,  131,  132,  133,  133,  133,  133,  134,  135,  136,
			  137,  138,  141,  173,  396,  263,  397,  174,  192,  142, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  395,  143,  175,  199,  176,  193,  194,  209,  398,  177,
			  178,  195,  399,  200,  400,  201,  401,  210,  405,  202,
			  211,  465,  465,  465,  465,  173,  396,  261,  397,  174,
			  192,  269,  729,  730,  175,  199,  176,  193,  194,  209,
			  398,  177,  178,  195,  399,  200,  400,  201,  401,  210,
			  405,  202,  211,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  221,  221,  221,  221,  221,  222,  221,
			  221,  221,  221,  223,  224,  221,  221,  221,  221,  221,
			  221,  221,  221,  144,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  145,  145,  146,  147,  147,  147,

			  147,  148,  149,  150,  151,  152,  225,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  226,  226,  226,  226,
			  226,  226,  226,  227,  227,  227,  227,  227,  227,  227,
			  227,  227,  227,  228,  228,  228,  228,  228,  228,  229,
			  229,  229,  229,  229,  229,  229,  229,  229,  229,  233,
			  233,  233,  233,  662,  234,  410,  662,  235,  261,  236,
			  237,  238,  262,  263,  261,  263,  263,  239,  262,  261,
			  757,  261,  747,  262,  240,  262,  241,  844,  845,  242,
			  243,  244,  245,  731,  246,  300,  247,  410,  114,  728, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  248,  305,  249,  662,  114,  250,  251,  252,  253,  254,
			  255,  276,  277,  276,  276,  369,  727,  286,  286,  286,
			  286,  692,  758,  286,  286,  286,  286,  388,  388,  388,
			  388,  264,  105,  105,  105,  105,  688,  411,  300,  306,
			  380,  114,  114,  607,  307,  304,  130,  114,  106,  276,
			  276,  276,  130,  310,  312,  408,  114,  114,  276,  409,
			  412,  413,  256,  264,  270,  257,  258,  259,  389,  411,
			  271,  272,  273,  233,  311,  313,  265,  233,  130,  266,
			  267,  268,  327,  308,  130,  114,  114,  408,  233,  130,
			  130,  409,  412,  413,  526,  130,  309,  373,  373,  373,

			  373,  373,  373,  373,  130,  130,  300,  525,  300,  114,
			  300,  114,  300,  114,  278,  114,  524,  279,  280,  281,
			  287,  130,  130,  288,  289,  290,  287,  130,  419,  288,
			  289,  290,  422,  130,  130,  107,  130,  130,  108,  109,
			  110,  111,  111,  315,  111,  111,  314,  301,  300,  316,
			  114,  114,  523,  522,  317,  521,  420,  130,  406,  130,
			  419,  130,  423,  130,  422,  130,  130,  520,  421,  319,
			  320,  319,  319,  407,  300,  315,  369,  114,  314,  424,
			  519,  316,  378,  378,  378,  378,  317,  318,  420,  130,
			  406,  130,  425,  130,  423,  130,  427,  379,  302,  130, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  421,  426,  369,  518,  261,  407,  517,  300,  262,  516,
			  114,  424,  319,  320,  319,  319,  515,  300,  300,  318,
			  114,  114,  514,  513,  425,  130,  512,  321,  427,  379,
			  302,  130,  511,  426,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  130,  130,  326,
			  428,  437,  375,  375,  375,  375,  375,  375,  130,  130,
			  300,  438,  322,  114,  508,  323,  324,  325,  507,  506,
			  300,  505,  504,  114,  377,  377,  377,  377,  105,  105,
			  130,  439,  428,  437,  300,  271,  272,  114,  105,  286,

			  130,  130,  440,  438,  441,  328,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  322,  286,  286,  323,  324,
			  325,  130,  445,  439,  435,  446,  471,  300,  436,  447,
			  114,  130,  295,  261,  440,  261,  441,  262,  261,  262,
			  292,  300,  262,  286,  114,  130,  160,  448,  383,  383,
			  383,  383,  276,  130,  445,  300,  435,  446,  114,  337,
			  436,  447,  276,  130,  329,  329,  329,  330,  330,  330,
			  330,  330,  330,  330,  330,  330,  330,  130,  130,  448,
			  546,  331,  331,  331,  331,  331,  331,  331,  300,  165,
			  276,  114,  130,  338,  338,  339,  340,  340,  340,  340, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  341,  342,  343,  344,  345,  261,  130,  261,  285,  262,
			  130,  262,  546,  282,  332,  332,  332,  332,  332,  332,
			  332,  332,  332,  332,  130,  276,  273,  275,  469,  263,
			  466,  263,  333,  333,  333,  333,  333,  333,  130,  130,
			  368,  547,  334,  334,  334,  334,  334,  334,  334,  334,
			  334,  334,  338,  338,  339,  340,  340,  340,  340,  341,
			  342,  343,  344,  345,  369,  442,  497,  497,  497,  233,
			  443,  130,  232,  547,  369,  335,  335,  335,  335,  346,
			  548,  444,  347,  369,  348,  349,  350,  549,  299,  286,
			  286,  286,  351,  220,  220,  220,  263,  442,  286,  352,

			  296,  353,  443,  270,  354,  355,  356,  357,  369,  358,
			  105,  359,  548,  444,  153,  360,  295,  361,  369,  549,
			  362,  363,  364,  365,  366,  367,  499,  499,  499,  499,
			  499,  499,  499,  338,  338,  339,  340,  340,  340,  340,
			  341,  342,  343,  344,  345,  292,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  372,  372,  372,  372,
			  372,  372,  372,  372,  372,  372,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  286,  338,  338,  339,
			  340,  340,  340,  340,  341,  342,  343,  344,  345,  552,
			  374,  374,  374,  374,  374,  374,  374,  374,  374,  374, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  380,  291,  381,  381,  381,  381,  285,  384,  384,  385,
			  385,  552,  282,  386,  386,  386,  385,  382,  385,  385,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,
			  387,  387,  387,  387,  261,  276,  553,  275,  262,  232,
			  217,  387,  387,  387,  387,  387,  387,  554,  171,  382,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,
			  385,  385,  402,  105,  105,  105,  403,  414,  553,  415,
			  166,  416,  105,  387,  387,  387,  387,  387,  387,  554,
			  404,  555,  417,  556,  557,  418,  105,  105,  105,  105,

			  503,  503,  503,  503,  402,  429,  558,  430,  403,  414,
			  859,  415,  106,  416,  559,  431,  560,  561,  432,  564,
			  433,  434,  404,  555,  417,  556,  557,  418,  501,  501,
			  501,  501,  501,  501,   89,   89,  859,  429,  558,  430,
			  859,  263,  509,  510,  510,  510,  559,  431,  560,  561,
			  432,  564,  433,  434,  449,  449,  450,  451,  451,  451,
			  451,  452,  453,  454,  455,  456,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  219,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  219,  219,  219,  218,
			  218,  218,  218,  218,  218,  219,  859,  859,  859,  457, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  449,  450,  458,  459,  460,  451,  452,  453,  454,  455,
			  456,  218,  218,  218,  218,  218,  218,  219,  218,  218,
			  218,  219,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  461,  461,  461,  461,  461,  461,  461,  461,  461,
			  461,  462,  462,  462,  462,  462,  462,  462,  462,  462,
			  462,  463,  463,  463,  463,  463,  463,  463,  463,  463,
			  463,  233,  233,  233,  233,  477,  859,  859,  114,  464,
			  263,  261,  263,  263,  478,  262,  859,  114,  479,  261,

			  859,  114,  565,  262,  276,  277,  276,  276,  859,  859,
			  286,  286,  286,  286,  230,  230,  230,  230,  480,  300,
			  859,  114,  114,  859,  566,  859,  472,  320,  472,  472,
			  859,  567,  300,  859,  565,  114,  130,  545,  545,  545,
			  545,  484,  569,  485,  568,  130,  114,  481,  264,  130,
			  859,  859,  319,  320,  319,  319,  566,  300,  487,  859,
			  114,  114,  160,  567,  538,  538,  538,  538,  130,  130,
			  130,  859,  482,  859,  569,  859,  568,  130,  389,  481,
			  264,  130,  303,  130,  256,  859,  859,  257,  258,  259,
			  263,  263,  263,  265,  130,  859,  266,  267,  268,  263, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  859,  130,  130,  300,  482,  165,  114,  278,  130,  130,
			  279,  280,  281,  287,  303,  130,  288,  289,  290,  111,
			  319,  320,  319,  319,  300,  301,  130,  114,  114,  473,
			  859,  550,  474,  475,  476,  531,  531,  531,  531,  570,
			  130,  130,  571,  859,  859,  572,  573,  483,  551,  574,
			  379,  575,  859,  300,  130,  322,  114,  859,  323,  324,
			  325,  859,  532,  550,  532,  859,  486,  533,  533,  533,
			  533,  570,  859,  576,  571,  130,  302,  572,  573,  483,
			  551,  574,  379,  575,  300,  859,  130,  114,  300,  492,
			  300,  114,  114,  114,  233,  233,  233,  493,  486,  859,

			  114,  859,  859,  233,  130,  576,  577,  130,  302,  859,
			  859,  578,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  322,  111,  111,  323,  324,  325,  111,
			  111,  111,  111,  111,  111,  130,  130,  579,  577,  130,
			  130,  130,  300,  578,  536,  114,  536,  319,  130,  537,
			  537,  537,  537,  580,  581,  582,  300,  859,  585,  114,
			  859,  859,  586,  533,  533,  533,  533,  130,  859,  579,
			  859,  130,  130,  130,  859,  491,  488,  489,  490,  543,
			  130,  544,  544,  544,  544,  580,  581,  582,  859,  300,
			  585,  859,  114,  130,  586,  131,  131,  132,  133,  133, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  133,  133,  134,  135,  136,  137,  138,  130,  300,  587,
			  562,  114,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  389,  300,  563,  130,  114,  859,  859,  328,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  130,
			  130,  587,  562,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  859,  300,  583,  563,  114,  584,  130,
			  498,  498,  498,  498,  498,  498,  498,  498,  498,  498,
			  300,  859,  130,  114,  130,  588,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  527,  583,  591,  859,
			  584,  130,  859,  859,  859,  328,  328,  328,  328,  328,

			  328,  328,  328,  328,  328,  130,  130,  588,  592,  859,
			  494,  494,  494,  494,  494,  494,  494,  494,  494,  494,
			  591,  130,  500,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  605,  606,  606,  606,  606,  130,  859,  859,
			  592,  495,  495,  495,  495,  495,  495,  495,  495,  495,
			  495,  859,  859,  130,  859,  859,  859,  496,  496,  496,
			  496,  496,  496,  496,  496,  496,  496,  502,  502,  502,
			  502,  502,  502,  502,  502,  502,  502,  859,  859,  338,
			  338,  339,  340,  340,  340,  340,  341,  342,  343,  344,
			  345,  370,  370,  370,  370,  370,  370,  370,  370,  370, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  528,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  530,  530,  530,  530,  530,  530,  530,  530,  530,
			  530,  534,  534,  534,  534,  859,  384,  384,  385,  385,
			  589,  593,  594,  595,  596,  859,  535,  385,  385,  385,
			  385,  385,  385,  385,  385,  385,  385,  597,  590,  598,
			  599,  600,  859,  601,  385,  385,  385,  385,  385,  385,

			  859,  859,  589,  593,  594,  595,  596,  539,  535,  385,
			  385,  385,  385,  385,  385,  533,  533,  533,  533,  597,
			  590,  598,  599,  600,  540,  601,  385,  385,  385,  385,
			  385,  385,  386,  386,  386,  385,  602,  603,  604,  537,
			  537,  537,  537,  385,  385,  385,  385,  385,  385,  387,
			  387,  387,  387,  226,  226,  226,  226,  226,  226,  226,
			  387,  387,  387,  387,  387,  387,  859,  859,  602,  603,
			  604,  859,  859,  541,  859,  385,  385,  385,  385,  385,
			  385,  228,  228,  228,  228,  228,  228,  859,  859,  859,
			  542,  859,  387,  387,  387,  387,  387,  387,  218,  218, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  218,  218,  218,  218,  218,  218,  218,  218,  221,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  227,  227,
			  227,  227,  227,  227,  227,  227,  227,  227,  229,  229,
			  229,  229,  229,  229,  229,  229,  229,  229,  218,  218,
			  218,  218,  218,  218,  218,  219,  218,  218,  221,  221,
			  221,  221,  221,  222,  221,  221,  221,  221,  223,  224,
			  221,  221,  221,  221,  221,  221,  221,  221,  225,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,

			  218,  218,  218,  218,  218,  218,  218,  218,  472,  320,
			  472,  472,  303,  303,  303,  612,  303,  613,  859,  615,
			  114,  300,  114,  617,  114,  300,  114,  300,  114,  859,
			  114,  632,  859,  633,  300,  300,  859,  114,  114,  621,
			  510,  510,  510,  510,  303,  303,  303,  634,  303,  635,
			  609,  610,  611,  859,  608,  472,  616,  614,  300,  859,
			  859,  114,  636,  632,  303,  633,  859,  637,  130,  638,
			  130,  639,  130,  859,  130,  640,  130,  859,  130,  634,
			  300,  635,  859,  114,  859,  130,  130,  641,  616,  614,
			  627,  627,  627,  627,  636,  300,  303,  859,  114,  637, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  130,  638,  130,  639,  130,  535,  130,  640,  130,  130,
			  130,  473,  319,  859,  474,  475,  476,  130,  130,  641,
			  859,  319,  319,  319,  859,  642,  300,  643,  319,  114,
			  319,  130,  537,  537,  537,  537,  859,  535,  859,  859,
			  859,  130,  859,  859,  859,  319,  130,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  642,  859,  643,
			  859,  859,  859,  130,  859,  859,  859,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  328,  130,  130,  644,
			  645,  859,  328,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  336,  336,  336,  336,  336,  336,  336,  336,

			  336,  336,  605,  687,  687,  687,  687,  859,  859,  130,
			  859,  644,  645,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  618,  618,  618,  618,  618,  618,  618,
			  618,  618,  618,  619,  619,  619,  619,  619,  619,  619,
			  619,  619,  619,  620,  620,  620,  620,  620,  620,  620,
			  620,  620,  620,  621,  510,  510,  510,  510,  646,  859,
			  647,  648,  698,  698,  698,  698,  622,  623,  370,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  370,  370,  370,  370,  370,  370,  370,  370,  624,  628,
			  646,  628,  647,  648,  629,  629,  629,  629,  622,  623,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  625,  625,  625,  625,  649,  650,  651,  652,  653,  630,
			  624,  538,  538,  538,  538,  379,  384,  384,  385,  385,
			  859,  654,  655,  656,  657,  859,  658,  385,  385,  385,
			  385,  385,  385,  859,  859,  859,  649,  650,  651,  652,
			  653,  626,  659,  660,  859,  859,  543,  379,  631,  631,
			  631,  631,  389,  654,  655,  656,  657,  539,  658,  385,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  661,

			  669,  670,  671,  672,  659,  660,  385,  385,  385,  385,
			  385,  385,  386,  386,  386,  385,  859,  859,  673,  389,
			  674,  859,  675,  385,  385,  385,  385,  385,  385,  859,
			  859,  661,  669,  670,  671,  672,  540,  676,  385,  385,
			  385,  385,  385,  385,  543,  859,  545,  545,  545,  545,
			  673,  677,  674,  541,  675,  385,  385,  385,  385,  385,
			  385,  387,  387,  387,  387,  662,  662,  662,  662,  676,
			  663,  678,  387,  387,  387,  387,  387,  387,  679,  680,
			  681,  664,  682,  677,  683,  684,  685,  389,  686,  303,
			  303,  303,  703,  300,  859,  859,  114,  859,  303,  704, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  859,  859,  542,  678,  387,  387,  387,  387,  387,  387,
			  679,  680,  681,  859,  682,  859,  683,  684,  685,  859,
			  686,  303,  303,  303,  703,  472,  472,  472,  472,  300,
			  303,  704,  114,  472,  472,  472,  859,  689,  300,  859,
			  859,  114,  859,  705,  130,  625,  625,  625,  625,  629,
			  629,  629,  629,  663,  629,  629,  629,  629,  706,  707,
			  697,  710,  690,  859,  699,  699,  699,  699,  665,  689,
			  859,  666,  667,  668,  691,  705,  130,  708,  711,  535,
			  130,  709,  712,  713,  714,  715,  716,  717,  718,  130,
			  706,  707,  697,  710,  690,  336,  336,  336,  336,  336,

			  336,  336,  336,  336,  336,  700,  691,  859,  859,  708,
			  711,  535,  130,  709,  712,  713,  714,  715,  716,  717,
			  718,  130,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  693,  693,  694,  694,  859,  859,  695,  695,
			  695,  694,  719,  694,  694,  694,  694,  694,  694,  694,
			  694,  694,  694,  694,  694,  696,  696,  696,  696,  859,
			  859,  720,  721,  722,  723,  724,  696,  696,  696,  696,
			  696,  696,  859,  859,  719,  694,  694,  694,  694,  694,
			  694,  694,  694,  694,  694,  694,  694,  380,  725,  699, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  699,  699,  699,  720,  721,  722,  723,  724,  696,  696,
			  696,  696,  696,  696,  701,  702,  732,  545,  545,  545,
			  545,  662,  662,  662,  662,  733,  726,  734,  735,  736,
			  725,  737,  738,  739,  740,  741,  742,  664,  743,  744,
			  745,  605,  746,  746,  746,  746,  701,  300,  732,  300,
			  114,  300,  114,  768,  114,  769,  770,  733,  165,  734,
			  735,  736,  859,  737,  738,  739,  740,  741,  742,  771,
			  743,  744,  745,  751,  693,  693,  772,  859,  749,  748,
			  755,  695,  695,  695,  759,  768,  759,  769,  770,  760,
			  760,  760,  760,  773,  750,  859,  859,  859,  130,  774,

			  130,  771,  130,  761,  761,  761,  761,  859,  772,  726,
			  749,  748,  775,  776,  777,  752,  778,  859,  762,  859,
			  859,  859,  756,  859,  665,  773,  750,  666,  667,  668,
			  130,  774,  130,  779,  130,  780,  699,  699,  699,  699,
			  764,  764,  764,  764,  775,  776,  777,  765,  778,  765,
			  762,  763,  766,  766,  766,  766,  380,  781,  764,  764,
			  764,  764,  782,  783,  784,  779,  785,  780,  662,  662,
			  662,  786,  787,  767,  788,  789,  790,  662,  791,  300,
			  859,  859,  114,  763,  605,  792,  792,  792,  792,  781,
			  300,  810,  811,  114,  782,  783,  784,  300,  785,  859, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  114,  859,  859,  786,  787,  767,  788,  789,  790,  859,
			  791,  760,  760,  760,  760,  760,  760,  760,  760,  794,
			  812,  813,  795,  810,  811,  814,  796,  859,  815,  859,
			  130,  693,  693,  694,  694,  766,  766,  766,  766,  859,
			  859,  130,  694,  694,  694,  694,  694,  694,  130,  859,
			  859,  794,  812,  813,  795,  859,  859,  814,  796,  802,
			  815,  802,  130,  859,  803,  803,  803,  803,  766,  766,
			  766,  766,  752,  130,  694,  694,  694,  694,  694,  694,
			  130,  694,  694,  694,  694,  816,  817,  801,  801,  801,
			  801,  818,  694,  694,  694,  694,  694,  694,  695,  695,

			  695,  694,  762,  859,  806,  806,  806,  806,  819,  694,
			  694,  694,  694,  694,  694,  859,  859,  816,  817,  807,
			  859,  859,  754,  818,  694,  694,  694,  694,  694,  694,
			  804,  859,  804,  826,  762,  805,  805,  805,  805,  756,
			  819,  694,  694,  694,  694,  694,  694,  696,  696,  696,
			  696,  807,  820,  820,  820,  820,  859,  827,  696,  696,
			  696,  696,  696,  696,  808,  826,  808,  828,  829,  809,
			  809,  809,  809,  830,  605,  831,  831,  831,  831,  300,
			  833,  762,  114,  114,  821,  859,  859,  859,  758,  827,
			  696,  696,  696,  696,  696,  696,  859,  859,  859,  828, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  829,  834,  859,  859,  114,  830,  859,  626,  803,  803,
			  803,  803,  859,  762,  838,  859,  821,  832,  803,  803,
			  803,  803,  805,  805,  805,  805,  805,  805,  805,  805,
			  130,  130,  835,  835,  835,  835,  836,  859,  836,  859,
			  839,  837,  837,  837,  837,  840,  838,  807,  842,  832,
			  847,  848,  130,  850,  859,  822,  114,  859,  823,  824,
			  825,  859,  130,  130,  809,  809,  809,  809,  809,  809,
			  809,  809,  839,  820,  820,  820,  820,  840,  851,  807,
			  842,  807,  847,  848,  130,  605,  849,  849,  849,  849,
			  837,  837,  837,  837,  837,  837,  837,  837,  852,  853,

			  820,  820,  820,  854,  130,  841,  855,  700,  856,  820,
			  851,  857,  858,  807,  139,  859,  859,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  859,
			  852,  853,  859,  859,  859,  854,  130,  841,  855,  859,
			  856,  859,  859,  857,  858,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  231,  859,  231,  231,  859,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  859,  859,  859,  822,  859,  859,  823,
			  824,  825,   75,   75,   75,   75,   75,   75,   75,   75,
			   75,   75,   75,   75,   75,   75,   75,   75,   75,   75, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   75,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,  111,  859,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  140,  140,  140,  140,

			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  260,  260,  260,  260,  260,
			  260,  260,  260,  260,  260,  260,  260,  260,  260,  260,
			  260,  260,  260,  260,  264,  264,  264,  264,  264,  264,
			  264,  264,  264,  264,  264,  264,  264,  264,  264,  264,
			  264,  264,  264,  274,  274,  274,  274,  274,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  274,  274,  274,
			  274,  274,  113,  859,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  114,  859,  114,  859,  114,  114,  114,  114,  114, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  470,  859,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  694,  694,  694,  694,
			  859,  859,  859,  694,  696,  696,  696,  696,  859,  859,
			  859,  696,  727,  727,  727,  727,  727,  727,  727,  727,
			  727,  727,  727,  727,  727,  727,  727,  727,  727,  727,
			  727,  793,  859,  793,  793,  793,  793,  793,  793,  793,
			  793,  793,  793,  793,  793,  793,  793,  793,  793,  793,

			   13,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859, yy_Dummy>>,
			1, 17, 4000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4016)
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
			    1,    1,    1,    1,    1,    1,    1,    3,    4,   27,
			  849,    3,    4,   46,    3,    4,    5,    5,    5,    5,
			   27,    5,    6,    6,    6,    6,   49,    6,    9,    9,
			    9,    9,   34,   34,   10,   10,   10,   10,   36,   36,
			   11,   11,   11,   11,   48,   46,   12,   12,   12,   12,
			   41,   52,   15,   15,   15,   15,   11,  846,   49,   53,
			   41,   48,   12,   16,   16,   16,   16,   28,   15,   28,
			   28,   28,   28,   53,    5,   45,   48,   29,   54,   16,
			    6,   45,   41,   52,   31,   29,   31,   31,   31,   31, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  845,   53,   41,   48,   55,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   53,    5,   45,   95,   95,
			   54,  843,    6,   45,   65,   65,   65,   79,  146,    5,
			  825,   79,    5,    5,    5,    6,   55,   31,    6,    6,
			    6,    9,  103,  103,    9,    9,    9,   10,  109,  109,
			   10,   10,   10,   11,  823,  114,   11,   11,   11,   12,
			   29,  694,   12,   12,   12,   15,  822,  173,   15,   15,
			   15,   74,   74,   74,   74,  757,   16,  258,  258,   16,
			   16,   16,   18,   18,  755,   18,   18,  114,   18,  753,
			   18,   18,   43,   18,   83,   18,   43,   84,   83,  173,

			  751,   84,   18,  694,   18,  747,   18,   18,   30,   43,
			   30,   30,   30,   30,   42,   18,   42,  146,  146,  146,
			   18,   18,   30,   30,   43,   40,   42,   50,   43,   40,
			   18,  174,   40,   18,   18,   40,   18,   50,   40,   18,
			  175,   43,   50,  175,   30,  176,   42,   18,   42,  280,
			  280,   30,   18,   18,   30,   30,  260,   40,   42,   50,
			  260,   40,   18,  174,   40,   18,   18,   40,  177,   50,
			   40,  731,  175,  730,   50,  175,   30,  176,  289,  289,
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   18,   18,   21,   38,  178,   84,  179,   38,   44,   21, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  177,   21,   38,   47,   38,   44,   44,   51,  180,   38,
			   38,   44,  181,   47,  182,   47,  183,   51,  186,   47,
			   51,  239,  239,  239,  239,   38,  178,  264,  179,   38,
			   44,  264,  667,  667,   38,   47,   38,   44,   44,   51,
			  180,   38,   38,   44,  181,   47,  182,   47,  183,   51,
			  186,   47,   51,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,

			   21,   21,   21,   21,   21,   21,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   70,   70,   70,   70,
			   70,   70,   70,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   72,   72,   72,   72,   72,   72,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   78,
			   78,   78,   78,  728,   78,  189,  727,   78,   85,   78,
			   78,   78,   85,   80,   80,   80,   80,   78,   80,   86,
			  696,   87,  688,   86,   78,   87,   78,  824,  824,   78,
			   78,   78,   78,  668,   78,  111,   78,  189,  111,  666, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   78,  116,   78,  665,  116,   78,   78,   78,   78,   78,
			   78,   91,   91,   91,   91,  148,  664,   98,   98,   98,
			   98,  621,  696,   99,   99,   99,   99,  165,  165,  165,
			  165,   80,  105,  105,  105,  105,  607,  190,  115,  117,
			  543,  115,  117,  471,  118,  115,  111,  118,  105,  283,
			  283,  283,  116,  120,  121,  188,  120,  121,  283,  188,
			  191,  193,   78,   80,   85,   78,   78,   78,  165,  190,
			   86,   86,   87,  469,  120,  121,   80,  468,  111,   80,
			   80,   80,  129,  119,  116,  129,  119,  188,  466,  115,
			  117,  188,  191,  193,  367,  118,  119,  148,  148,  148,

			  148,  148,  148,  148,  120,  121,  123,  366,  122,  123,
			  124,  122,  125,  124,   91,  125,  365,   91,   91,   91,
			   98,  115,  117,   98,   98,   98,   99,  118,  196,   99,
			   99,   99,  198,  129,  119,  105,  120,  121,  105,  105,
			  105,  113,  113,  123,  113,  113,  122,  113,  126,  124,
			  113,  126,  364,  363,  125,  362,  197,  123,  187,  122,
			  196,  124,  199,  125,  198,  129,  119,  361,  197,  127,
			  127,  127,  127,  187,  127,  123,  150,  127,  122,  200,
			  360,  124,  156,  156,  156,  156,  125,  126,  197,  123,
			  187,  122,  201,  124,  199,  125,  203,  156,  113,  126, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  197,  201,  152,  359,  267,  187,  358,  128,  267,  357,
			  128,  200,  130,  130,  130,  130,  356,  130,  131,  126,
			  130,  131,  355,  354,  201,  127,  353,  127,  203,  156,
			  113,  126,  352,  201,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  127,  128,  128,
			  204,  207,  150,  150,  150,  150,  150,  150,  130,  131,
			  132,  208,  127,  132,  350,  127,  127,  127,  349,  348,
			  133,  347,  346,  133,  152,  152,  152,  152,  299,  298,
			  128,  209,  204,  207,  134,  267,  267,  134,  296,  295,

			  130,  131,  210,  208,  211,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  130,  294,  292,  130,  130,
			  130,  132,  213,  209,  206,  214,  291,  135,  206,  215,
			  135,  133,  290,  265,  210,  268,  211,  265,  270,  268,
			  288,  136,  270,  287,  136,  134,  161,  216,  161,  161,
			  161,  161,  285,  132,  213,  137,  206,  214,  137,  140,
			  206,  215,  284,  133,  132,  132,  132,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  134,  135,  216,
			  390,  134,  134,  134,  134,  134,  134,  134,  138,  161,
			  282,  138,  136,  141,  141,  141,  141,  141,  141,  141, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  141,  141,  141,  141,  141,  273,  137,  266,  281,  273,
			  135,  266,  390,  279,  135,  135,  135,  135,  135,  135,
			  135,  135,  135,  135,  136,  278,  268,  274,  259,  270,
			  257,  265,  136,  136,  136,  136,  136,  136,  137,  138,
			  143,  391,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  145,  212,  339,  339,  339,  256,
			  212,  138,  231,  391,  147,  138,  138,  138,  138,  142,
			  392,  212,  142,  144,  142,  142,  142,  395,  110,  293,
			  293,  293,  142,  450,  450,  450,  273,  212,  293,  142,

			  108,  142,  212,  266,  142,  142,  142,  142,  149,  142,
			  107,  142,  392,  212,  106,  142,  104,  142,  151,  395,
			  142,  142,  142,  142,  142,  142,  341,  341,  341,  341,
			  341,  341,  341,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  102,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  220,  220,  220,  220,
			  220,  220,  220,  220,  220,  220,  101,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  397,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  149, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  160,  100,  160,  160,  160,  160,   96,  162,  162,  162,
			  162,  397,   94,  163,  163,  163,  163,  160,  162,  162,
			  162,  162,  162,  162,  163,  163,  163,  163,  163,  163,
			  164,  164,  164,  164,  272,   93,  398,   88,  272,   75,
			   57,  164,  164,  164,  164,  164,  164,  399,   37,  160,
			  162,  162,  162,  162,  162,  162,  163,  163,  163,  163,
			  163,  163,  184,  297,  297,  297,  184,  194,  398,  194,
			   32,  194,  297,  164,  164,  164,  164,  164,  164,  399,
			  184,  400,  194,  401,  402,  194,  219,  219,  219,  219,

			  345,  345,  345,  345,  184,  205,  403,  205,  184,  194,
			   13,  194,  219,  194,  404,  205,  405,  407,  205,  409,
			  205,  205,  184,  400,  194,  401,  402,  194,  343,  343,
			  343,  343,  343,  343,    8,    7,    0,  205,  403,  205,
			    0,  272,  351,  351,  351,  351,  404,  205,  405,  407,
			  205,  409,  205,  205,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,    0,    0,    0,  219, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  227,  228,  228,  228,  228,  228,  228,  228,  228,  228,
			  228,  229,  229,  229,  229,  229,  229,  229,  229,  229,
			  229,  230,  230,  230,  230,  230,  230,  230,  230,  230,
			  230,  233,  233,  233,  233,  304,    0,    0,  304,  233,
			  263,  263,  263,  263,  309,  263,    0,  309,  311,  271,

			    0,  311,  410,  271,  276,  276,  276,  276,    0,    0,
			  286,  286,  286,  286,  456,  456,  456,  456,  313,  314,
			    0,  313,  314,    0,  411,    0,  303,  303,  303,  303,
			    0,  412,  315,    0,  410,  315,  304,  389,  389,  389,
			  389,  317,  413,  317,  412,  309,  317,  314,  263,  311,
			    0,    0,  319,  319,  319,  319,  411,  319,  321,    0,
			  319,  321,  383,  412,  383,  383,  383,  383,  304,  313,
			  314,    0,  315,    0,  413,    0,  412,  309,  389,  314,
			  263,  311,  303,  315,  233,    0,    0,  233,  233,  233,
			  271,  271,  271,  263,  317,    0,  263,  263,  263,  271, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  313,  314,  316,  315,  383,  316,  276,  319,  321,
			  276,  276,  276,  286,  303,  315,  286,  286,  286,  302,
			  302,  302,  302,  302,  318,  302,  317,  318,  302,  303,
			    0,  396,  303,  303,  303,  378,  378,  378,  378,  414,
			  319,  321,  415,    0,    0,  416,  417,  316,  396,  418,
			  378,  419,    0,  322,  316,  319,  322,    0,  319,  319,
			  319,    0,  379,  396,  379,    0,  318,  379,  379,  379,
			  379,  414,    0,  420,  415,  318,  302,  416,  417,  316,
			  396,  418,  378,  419,  323,    0,  316,  323,  325,  326,
			  324,  325,  326,  324,  467,  467,  467,  328,  318,    0,

			  328,    0,    0,  467,  322,  420,  421,  318,  302,    0,
			    0,  422,  302,  302,  302,  302,  302,  302,  302,  302,
			  302,  302,  302,  302,  302,  302,  302,  302,  302,  302,
			  302,  302,  302,  302,  302,  323,  322,  423,  421,  325,
			  326,  324,  329,  422,  382,  329,  382,  322,  328,  382,
			  382,  382,  382,  425,  426,  427,  330,    0,  429,  330,
			    0,    0,  430,  532,  532,  532,  532,  323,    0,  423,
			    0,  325,  326,  324,    0,  325,  323,  324,  324,  388,
			  328,  388,  388,  388,  388,  425,  426,  427,    0,  331,
			  429,    0,  331,  329,  430,  328,  328,  328,  328,  328, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  328,  328,  328,  328,  328,  328,  328,  330,  332,  431,
			  408,  332,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  388,  333,  408,  329,  333,    0,    0,  329,
			  329,  329,  329,  329,  329,  329,  329,  329,  329,  330,
			  331,  431,  408,  330,  330,  330,  330,  330,  330,  330,
			  330,  330,  330,    0,  334,  428,  408,  334,  428,  332,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  335,    0,  331,  335,  333,  432,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  370,  428,  434,    0,
			  428,  332,    0,    0,    0,  332,  332,  332,  332,  332,

			  332,  332,  332,  332,  332,  334,  333,  432,  435,    0,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  434,  335,  342,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  465,  465,  465,  465,  465,  334,    0,    0,
			  435,  334,  334,  334,  334,  334,  334,  334,  334,  334,
			  334,    0,    0,  335,    0,    0,    0,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  344,  344,  344,
			  344,  344,  344,  344,  344,  344,  344,    0,    0,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  371,  371,  371,  371,  371,  371,  371,  371,  371, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  371,  372,  372,  372,  372,  372,  372,  372,  372,  372,
			  372,  373,  373,  373,  373,  373,  373,  373,  373,  373,
			  373,  374,  374,  374,  374,  374,  374,  374,  374,  374,
			  374,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  376,  377,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  381,  381,  381,  381,    0,  384,  384,  384,  384,
			  433,  436,  437,  438,  439,    0,  381,  384,  384,  384,
			  384,  384,  384,  385,  385,  385,  385,  440,  433,  441,
			  442,  443,    0,  444,  385,  385,  385,  385,  385,  385,

			    0,    0,  433,  436,  437,  438,  439,  384,  381,  384,
			  384,  384,  384,  384,  384,  533,  533,  533,  533,  440,
			  433,  441,  442,  443,  385,  444,  385,  385,  385,  385,
			  385,  385,  386,  386,  386,  386,  445,  446,  447,  536,
			  536,  536,  536,  386,  386,  386,  386,  386,  386,  387,
			  387,  387,  387,  452,  452,  452,  452,  452,  452,  452,
			  387,  387,  387,  387,  387,  387,    0,    0,  445,  446,
			  447,    0,    0,  386,    0,  386,  386,  386,  386,  386,
			  386,  454,  454,  454,  454,  454,  454,    0,    0,    0,
			  387,    0,  387,  387,  387,  387,  387,  387,  449,  449, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  449,  449,  449,  449,  449,  449,  449,  449,  451,  451,
			  451,  451,  451,  451,  451,  451,  451,  451,  453,  453,
			  453,  453,  453,  453,  453,  453,  453,  453,  455,  455,
			  455,  455,  455,  455,  455,  455,  455,  455,  457,  457,
			  457,  457,  457,  457,  457,  457,  457,  457,  458,  458,
			  458,  458,  458,  458,  458,  458,  458,  458,  459,  459,
			  459,  459,  459,  459,  459,  459,  459,  459,  460,  460,
			  460,  460,  460,  460,  460,  460,  460,  460,  461,  461,
			  461,  461,  461,  461,  461,  461,  461,  461,  462,  462,
			  462,  462,  462,  462,  462,  462,  462,  462,  463,  463,

			  463,  463,  463,  463,  463,  463,  463,  463,  472,  472,
			  472,  472,  473,  474,  475,  481,  476,  481,    0,  483,
			  481,  482,  483,  486,  482,  488,  486,  484,  488,    0,
			  484,  546,    0,  547,  489,  490,    0,  489,  490,  510,
			  510,  510,  510,  510,  473,  474,  475,  548,  476,  549,
			  475,  475,  476,    0,  474,  473,  484,  482,  491,    0,
			    0,  491,  550,  546,  472,  547,    0,  551,  481,  552,
			  483,  553,  482,    0,  486,  554,  488,    0,  484,  548,
			  494,  549,    0,  494,    0,  489,  490,  555,  484,  482,
			  534,  534,  534,  534,  550,  495,  472,    0,  495,  551, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  481,  552,  483,  553,  482,  534,  486,  554,  488,  491,
			  484,  472,  488,    0,  472,  472,  472,  489,  490,  555,
			    0,  489,  489,  489,    0,  556,  496,  557,  490,  496,
			  489,  494,  537,  537,  537,  537,    0,  534,    0,    0,
			    0,  491,    0,    0,    0,  491,  495,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  556,    0,  557,
			    0,    0,    0,  494,    0,    0,    0,  494,  494,  494,
			  494,  494,  494,  494,  494,  494,  494,  496,  495,  558,
			  559,    0,  495,  495,  495,  495,  495,  495,  495,  495,
			  495,  495,  498,  498,  498,  498,  498,  498,  498,  498,

			  498,  498,  606,  606,  606,  606,  606,    0,    0,  496,
			    0,  558,  559,  496,  496,  496,  496,  496,  496,  496,
			  496,  496,  496,  499,  499,  499,  499,  499,  499,  499,
			  499,  499,  499,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  500,  501,  501,  501,  501,  501,  501,  501,
			  501,  501,  501,  502,  502,  502,  502,  502,  502,  502,
			  502,  502,  502,  503,  503,  503,  503,  503,  503,  503,
			  503,  503,  503,  509,  509,  509,  509,  509,  560,    0,
			  561,  562,  626,  626,  626,  626,  509,  509,  528,  528,
			  528,  528,  528,  528,  528,  528,  528,  528,  529,  529, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  529,  529,  529,  529,  529,  529,  529,  529,  509,  535,
			  560,  535,  561,  562,  535,  535,  535,  535,  509,  509,
			  530,  530,  530,  530,  530,  530,  530,  530,  530,  530,
			  531,  531,  531,  531,  563,  564,  565,  566,  568,  538,
			  509,  538,  538,  538,  538,  531,  539,  539,  539,  539,
			    0,  569,  570,  571,  572,    0,  573,  539,  539,  539,
			  539,  539,  539,    0,    0,    0,  563,  564,  565,  566,
			  568,  531,  574,  576,    0,    0,  544,  531,  544,  544,
			  544,  544,  538,  569,  570,  571,  572,  539,  573,  539,
			  539,  539,  539,  539,  539,  540,  540,  540,  540,  579,

			  582,  583,  584,  585,  574,  576,  540,  540,  540,  540,
			  540,  540,  541,  541,  541,  541,    0,    0,  586,  544,
			  587,    0,  588,  541,  541,  541,  541,  541,  541,    0,
			    0,  579,  582,  583,  584,  585,  540,  589,  540,  540,
			  540,  540,  540,  540,  545,    0,  545,  545,  545,  545,
			  586,  590,  587,  541,  588,  541,  541,  541,  541,  541,
			  541,  542,  542,  542,  542,  580,  580,  580,  580,  589,
			  580,  591,  542,  542,  542,  542,  542,  542,  592,  593,
			  595,  580,  598,  590,  599,  600,  601,  545,  602,  608,
			  609,  610,  632,  612,    0,    0,  612,    0,  611,  635, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  542,  591,  542,  542,  542,  542,  542,  542,
			  592,  593,  595,    0,  598,    0,  599,  600,  601,    0,
			  602,  608,  609,  610,  632,  608,  609,  609,  609,  614,
			  611,  635,  614,  610,  611,  609,    0,  612,  616,    0,
			    0,  616,    0,  636,  612,  625,  625,  625,  625,  628,
			  628,  628,  628,  580,  629,  629,  629,  629,  637,  640,
			  625,  642,  614,    0,  627,  627,  627,  627,  580,  612,
			    0,  580,  580,  580,  616,  636,  612,  641,  644,  627,
			  614,  641,  645,  646,  647,  648,  649,  650,  652,  616,
			  637,  640,  625,  642,  614,  618,  618,  618,  618,  618,

			  618,  618,  618,  618,  618,  627,  616,    0,    0,  641,
			  644,  627,  614,  641,  645,  646,  647,  648,  649,  650,
			  652,  616,  619,  619,  619,  619,  619,  619,  619,  619,
			  619,  619,  620,  620,  620,  620,  620,  620,  620,  620,
			  620,  620,  622,  622,  622,  622,    0,    0,  623,  623,
			  623,  623,  653,  622,  622,  622,  622,  622,  622,  623,
			  623,  623,  623,  623,  623,  624,  624,  624,  624,    0,
			    0,  654,  655,  657,  658,  659,  624,  624,  624,  624,
			  624,  624,    0,    0,  653,  622,  622,  622,  622,  622,
			  622,  623,  623,  623,  623,  623,  623,  630,  661,  630, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  630,  630,  630,  654,  655,  657,  658,  659,  624,  624,
			  624,  624,  624,  624,  630,  631,  669,  631,  631,  631,
			  631,  662,  662,  662,  662,  670,  662,  671,  672,  673,
			  661,  674,  675,  676,  677,  679,  680,  662,  683,  684,
			  686,  687,  687,  687,  687,  687,  630,  689,  669,  690,
			  689,  691,  690,  705,  691,  706,  707,  670,  631,  671,
			  672,  673,    0,  674,  675,  676,  677,  679,  680,  709,
			  683,  684,  686,  693,  693,  693,  710,    0,  690,  689,
			  695,  695,  695,  695,  697,  705,  697,  706,  707,  697,
			  697,  697,  697,  711,  691,    0,    0,    0,  689,  712,

			  690,  709,  691,  698,  698,  698,  698,    0,  710,  662,
			  690,  689,  715,  717,  718,  693,  720,    0,  698,    0,
			    0,    0,  695,    0,  662,  711,  691,  662,  662,  662,
			  689,  712,  690,  721,  691,  722,  699,  699,  699,  699,
			  700,  700,  700,  700,  715,  717,  718,  701,  720,  701,
			  698,  699,  701,  701,  701,  701,  702,  723,  702,  702,
			  702,  702,  724,  725,  732,  721,  733,  722,  729,  729,
			  729,  735,  736,  702,  738,  742,  743,  729,  745,  749,
			    0,    0,  749,  699,  746,  746,  746,  746,  746,  723,
			  748,  768,  769,  748,  724,  725,  732,  750,  733,    0, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  750,    0,    0,  735,  736,  702,  738,  742,  743,    0,
			  745,  759,  759,  759,  759,  760,  760,  760,  760,  748,
			  771,  773,  749,  768,  769,  774,  750,    0,  775,    0,
			  749,  752,  752,  752,  752,  765,  765,  765,  765,    0,
			    0,  748,  752,  752,  752,  752,  752,  752,  750,    0,
			    0,  748,  771,  773,  749,    0,    0,  774,  750,  762,
			  775,  762,  749,    0,  762,  762,  762,  762,  766,  766,
			  766,  766,  752,  748,  752,  752,  752,  752,  752,  752,
			  750,  754,  754,  754,  754,  776,  779,  761,  761,  761,
			  761,  782,  754,  754,  754,  754,  754,  754,  756,  756,

			  756,  756,  761,    0,  764,  764,  764,  764,  783,  756,
			  756,  756,  756,  756,  756,    0,    0,  776,  779,  764,
			    0,    0,  754,  782,  754,  754,  754,  754,  754,  754,
			  763,    0,  763,  785,  761,  763,  763,  763,  763,  756,
			  783,  756,  756,  756,  756,  756,  756,  758,  758,  758,
			  758,  764,  784,  784,  784,  784,    0,  786,  758,  758,
			  758,  758,  758,  758,  767,  785,  767,  787,  789,  767,
			  767,  767,  767,  790,  792,  792,  792,  792,  792,  794,
			  795,  801,  794,  795,  784,    0,    0,    0,  758,  786,
			  758,  758,  758,  758,  758,  758,    0,    0,    0,  787, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  789,  796,    0,    0,  796,  790,    0,  801,  802,  802,
			  802,  802,    0,  801,  811,    0,  784,  794,  803,  803,
			  803,  803,  804,  804,  804,  804,  805,  805,  805,  805,
			  794,  795,  806,  806,  806,  806,  807,    0,  807,    0,
			  814,  807,  807,  807,  807,  818,  811,  806,  821,  794,
			  826,  828,  796,  832,    0,  784,  832,    0,  784,  784,
			  784,    0,  794,  795,  808,  808,  808,  808,  809,  809,
			  809,  809,  814,  820,  820,  820,  820,  818,  839,  806,
			  821,  835,  826,  828,  796,  831,  831,  831,  831,  831,
			  836,  836,  836,  836,  837,  837,  837,  837,  841,  842,

			  844,  844,  844,  852,  832,  820,  853,  835,  854,  844,
			  839,  855,  856,  835,  866,    0,    0,  866,  866,  866,
			  866,  866,  866,  866,  866,  866,  866,  866,  866,    0,
			  841,  842,    0,    0,    0,  852,  832,  820,  853,    0,
			  854,    0,    0,  855,  856,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  869,    0,  869,  869,    0,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,    0,    0,    0,  820,    0,    0,  820,
			  820,  820,  860,  860,  860,  860,  860,  860,  860,  860,
			  860,  860,  860,  860,  860,  860,  860,  860,  860,  860, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  860,  861,  861,  861,  861,  861,  861,  861,  861,  861,
			  861,  861,  861,  861,  861,  861,  861,  861,  861,  861,
			  862,  862,  862,  862,  862,  862,  862,  862,  862,  862,
			  862,  862,  862,  862,  862,  862,  862,  862,  862,  863,
			  863,  863,  863,  863,  863,  863,  863,  863,  863,  863,
			  863,  863,  863,  863,  863,  863,  863,  863,  864,  864,
			  864,  864,  864,  864,  864,  864,  864,  864,  864,  864,
			  864,  864,  864,  864,  864,  864,  864,  865,    0,  865,
			  865,  865,  865,  865,  865,  865,  865,  865,  865,  865,
			  865,  865,  865,  865,  865,  865,  867,  867,  867,  867,

			  867,  867,  867,  867,  867,  867,  867,  867,  867,  867,
			  867,  867,  867,  867,  867,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  871,  871,  871,  871,  871,  871,
			  871,  871,  871,  871,  871,  871,  871,  871,  871,  871,
			  871,  871,  871,  872,  872,  872,  872,  872,  872,  872,
			  872,  872,  872,  872,  872,  872,  872,  872,  872,  872,
			  872,  872,  873,    0,  873,  873,  873,  873,  873,  873,
			  873,  873,  873,  873,  873,  873,  873,  873,  873,  873,
			  873,  874,    0,  874,    0,  874,  874,  874,  874,  874, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  874,  874,  874,  874,  874,  874,  874,  874,  874,  874,
			  875,  875,  875,  875,  875,  875,  875,  875,  875,  875,
			  875,  875,  875,  875,  875,  875,  875,  876,    0,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  877,  877,  877,  877,
			    0,    0,    0,  877,  878,  878,  878,  878,    0,    0,
			    0,  878,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  880,    0,  880,  880,  880,  880,  880,  880,  880,
			  880,  880,  880,  880,  880,  880,  880,  880,  880,  880,

			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859, yy_Dummy>>,
			1, 17, 4000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 880)
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
			    0,    0,    0,  114,  115,  124,  130, 1332, 1331,  136,
			  142,  148,  154, 1310, 3900,  160,  171, 3900,  275,    0,
			 3900,  389, 3900, 3900, 3900, 3900, 3900,  101,  158,  167,
			  289,  175, 1252, 3900,  115, 3900,  120, 1230,  359,    0,
			  286,  124,  271,  260,  361,  145,   77,  370,  122,  100,
			  291,  368,  116,  137,  149,  158, 3900, 1191, 3900, 3900,
			 3900, 3900, 3900,  111,  359,  123,  369,  379,  412,  422,
			  432,  439,  445,  455,  177, 1242, 3900, 3900,  557,  224,
			  571, 3900, 3900,  291,  294,  565,  576,  578, 1244, 3900,
			 3900,  609, 3900, 1144, 1123,  124, 1122, 3900,  615,  621,

			 1193, 1075, 1046,  148, 1022,  630, 1096, 1009, 1001,  154,
			  994,  588, 3900,  740,  197,  631,  594,  632,  637,  676,
			  646,  647,  701,  699,  703,  705,  741,  767,  800,  675,
			  810,  811,  863,  873,  887,  920,  934,  948,  981,    0,
			  947,  888, 1072, 1028, 1071, 1052,  216, 1062,  603, 1096,
			  764, 1106,  790, 3900, 3900, 3900,  761, 3900, 3900, 3900,
			 1191,  927, 1196, 1202, 1219,  606, 3900, 3900, 3900, 3900,
			 3900, 3900,    0,  218,  295,  300,  310,  318,  343,  360,
			  376,  367,  378,  367, 1239,    0,  368,  723,  608,  522,
			  605,  614,    0,  614, 1242,    0,  686,  722,  681,  712, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  744,  758,    0,  747,  824, 1270,  881,  817,  822,  855,
			  850,  857, 1030,  873,  885,  893,  898, 3900, 1249, 1294,
			 1072, 1272, 1282, 1292, 1317, 1327, 1337, 1347, 1357, 1367,
			 1377, 1065, 3900, 1479, 3900, 3900, 3900, 3900, 3900,  400,
			 3900, 3900, 3900, 3900, 3900, 3900, 3900, 3900, 3900, 3900,
			 3900, 3900, 3900, 3900, 3900, 3900,  968,  931,  183,  934,
			  353, 3900, 3900, 1488,  424,  930, 1004,  801,  932, 3900,
			  935, 1496, 1241, 1002, 1024, 3900, 1502, 3900,  924,  914,
			  255,  914,  896,  555,  862,  858, 1508,  842,  841,  284,
			  838,  918,  823,  995,  816,  805,  804, 1179,  789,  794,

			 3900, 3900, 1618, 1524, 1478, 3900, 3900, 3900, 3900, 1487,
			 3900, 1491, 3900, 1511, 1512, 1525, 1596, 1536, 1617, 1550,
			 3900, 1551, 1646, 1677, 1683, 1681, 1682, 3900, 1690, 1735,
			 1749, 1782, 1801, 1816, 1847, 1863, 3900, 3900, 1718,  965,
			 1766, 1032, 1828, 1230, 1873, 1206,  870,  869,  867,  866,
			  862, 1321,  820,  814,  811,  810,  804,  797,  794,  791,
			  768,  755,  743,  741,  740,  704,  695,  682, 3900, 3900,
			 1874, 1897, 1907, 1917, 1927, 1937, 1947, 1957, 1614, 1646,
			 3900, 2040, 1728, 1543, 2045, 2062, 2111, 2128, 1760, 1516,
			  934,  996, 1048,    0,    0, 1047, 1599, 1155, 1196, 1204, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1259, 1244, 1242, 1270, 1282, 1280,    0, 1265, 1778, 1283,
			 1452, 1473, 1487, 1499, 1603, 1602, 1609, 1599, 1617, 1615,
			 1641, 1659, 1675, 1691,    0, 1717, 1698, 1704, 1821, 1722,
			 1726, 1777, 1823, 2036, 1839, 1872, 2039, 2036, 2033, 2029,
			 2051, 2046, 2054, 2043, 2053, 2096, 2102, 2093,    0, 2104,
			  992, 2114, 2059, 2124, 2083, 2134, 1420, 2144, 2154, 2164,
			 2174, 2184, 2194, 2204, 3900, 1912,  594, 1600,  577,  579,
			    0,  568, 2306, 2254, 2255, 2256, 2258, 3900, 3900, 3900,
			 3900, 2310, 2314, 2312, 2320, 3900, 2316, 3900, 2318, 2327,
			 2328, 2351, 3900, 3900, 2373, 2388, 2419, 2353, 2398, 2429,

			 2439, 2449, 2459, 2469, 3900, 3900, 3900, 3900, 3900, 2553,
			 2319, 3900, 3900, 3900, 3900, 3900, 3900, 3900, 3900, 3900,
			 3900, 3900, 3900, 3900, 3900, 3900, 3900, 3900, 2494, 2504,
			 2526, 2609, 1742, 2094, 2369, 2593, 2118, 2411, 2620, 2625,
			 2674, 2691, 2740,  621, 2657, 2725, 2281, 2282, 2297, 2311,
			 2328, 2327, 2327, 2321, 2339, 2336, 2389, 2389, 2430, 2446,
			 2538, 2531, 2536, 2585, 2586, 2600, 2585,    0, 2602, 2611,
			 2597, 2598, 2605, 2620, 2623,    0, 2630,    0,    0, 2656,
			 2763,    0, 2660, 2649, 2662, 2666, 2669, 2676, 2682, 2685,
			 2708, 2715, 2744, 2730,    0, 2733,    0,    0, 2746, 2747, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2733, 2743, 2756,    0,    0, 3900, 2482,  564, 2731, 2732,
			 2733, 2740, 2786, 3900, 2822, 3900, 2831, 3900, 2801, 2828,
			 2838,  609, 2921, 2927, 2944, 2824, 2561, 2843, 2828, 2833,
			 2978, 2996, 2742,    0,    0, 2754, 2804, 2825,    0,    0,
			 2810, 2841, 2816,    0, 2829, 2843, 2846, 2848, 2850, 2835,
			 2842,    0, 2839, 2907, 2935, 2932,    0, 2933, 2940, 2935,
			    0, 2962, 3019, 3900,  598,  502,  500,  338,  499, 2984,
			 2976, 2972, 2988, 2993, 2995, 2983, 2997, 2983,    0, 2984,
			 3004,    0,    0, 2998, 3003,    0, 2995, 3021,  505, 3040,
			 3042, 3044, 3900, 3053,  241, 3060,  560, 3068, 3082, 3115,

			 3119, 3131, 3137,    0,    0, 3017, 3003, 3005,    0, 3023,
			 3025, 3057, 3067,    0,    0, 3076,    0, 3081, 3078,    0,
			 3066, 3088, 3084, 3106, 3130, 3112, 3900,  563,  469, 3074,
			  273,  277, 3121, 3116,    0, 3126, 3127,    0, 3138,    0,
			    0,    0, 3124, 3131,    0, 3127, 3164,  237, 3183, 3172,
			 3190,  288, 3210,  277, 3260,  272, 3277,  263, 3326, 3190,
			 3194, 3266, 3243, 3314, 3283, 3214, 3247, 3348, 3156, 3141,
			    0, 3175,    0, 3186, 3192, 3193, 3242,    0,    0, 3248,
			    0,    0, 3246, 3272, 3350, 3287, 3321, 3333,    0, 3332,
			 3337,    0, 3354,    0, 3372, 3373, 3394, 3900, 3900, 3900, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3900, 3345, 3387, 3397, 3401, 3405, 3411, 3420, 3443, 3447,
			    0, 3378,    0,    0, 3397,    0,    0,    0, 3394,    0,
			 3471, 3405,  165,  155,  493,  136, 3401,    0, 3415,    0,
			    0, 3465, 3446, 3900, 3900, 3445, 3469, 3473,    0, 3442,
			    0, 3455, 3467,  127, 3406,  100,   73,    0,    0,  100,
			 3900,    0, 3471, 3456, 3458, 3461, 3462,    0, 3900, 3900,
			 3581, 3600, 3619, 3638, 3657, 3676, 3511, 3695, 3538, 3553,
			 3714, 3733, 3752, 3771, 3790, 3809, 3826, 3840, 3848, 3861,
			 3880, yy_Dummy>>,
			1, 81, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 880)
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
			    0,  859,    1,  860,  860,  861,  861,  862,  862,  863,
			  863,  864,  864,  859,  859,  859,  859,  859,  865,  866,
			  859,  867,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  869,  859,  859,  859,  870,
			  870,  859,  859,  871,  870,  870,  870,  870,  872,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,

			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  865,  859,  873,  874,  865,  865,  865,  865,  865,
			  865,  865,  865,  865,  865,  865,  865,  865,  865,  865,
			  865,  865,  865,  865,  865,  865,  865,  865,  865,  866,
			  875,  875,  875,  875,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  869,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  870,  859,  859,  870,  871,  870,  870,  870,  870,  859,
			  870,  870,  870,  870,  872,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  876,  859,  859,  859,  859,  859,  859,  859,  859,

			  859,  859,  873,  874,  865,  859,  859,  859,  859,  865,
			  859,  865,  859,  865,  865,  865,  865,  865,  865,  865,
			  859,  865,  865,  865,  865,  865,  865,  859,  865,  865,
			  865,  865,  865,  865,  865,  865,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  875,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  876,  876,  874,  874,  874,  874,  874,  859,  859,  859,
			  859,  865,  865,  865,  865,  859,  865,  859,  865,  865,
			  865,  865,  859,  859,  865,  865,  865,  859,  859,  859,

			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  868,  868,  868,  868,  868,  859,  859,  876,  874,  874,
			  874,  874,  865,  859,  865,  859,  865,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  859,  859,  859,  859,  859,  859,  859,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  859,  876,  865,
			  865,  865,  859,  877,  877,  877,  878,  859,  859,  859,

			  859,  859,  859,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  859,  879,  859,  859,
			  859,  859,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  859,  876,  865,  865,
			  865,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  868,  868,  859,  880,  865,  865,  865,  859,  859,  859, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  868,  868,  868,  868,  868,  868,  868,  868,  868,  868,
			  859,  868,  859,  859,  859,  859,  868,  868,  868,  868,
			  868,  859,  865,  859,  859,  859,  859,  859,  868,  868,
			  868,  859,  868,  859,  859,  859,  859,  868,  868,  859,
			  859,  868,  859,  868,  859,  868,  859,  868,  859,    0,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859,  859,  859,  859,  859,  859,  859,  859,  859,  859,
			  859, yy_Dummy>>,
			1, 81, 800)
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
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   97,
			   97,   97,   97,   97,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   99,   98,   98,   98,   98,  100,
			  101,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  103,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  104,  104,  105,  106,  106,  106,  106,  106, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  107,  108,  109,  110,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  112,  113,  113,
			  114,  115,  115,  115,  116,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    1,    3,    4,    3,    3,
			    5,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    6,    7,    7,    8,    9,    3,    3,    3,    3,    3,
			    3,    3,    7,    7,    7,    7,    7,    7,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   11,   12,    3,    3,
			    3,    3,   13,    3,    7,    7,    7,    7,    7,    7,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   14,   15,
			    3,    3,   16,   17,   18,   18,   18,   18,   18,   18,

			   18,   18,   18,   18,   19,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 860)
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
			  204,  206,  208,  210,  212,  214,  216,  218,  220,  223,

			  225,  227,  229,  231,  233,  235,  236,  236,  236,  236,
			  236,  236,  237,  238,  239,  239,  240,  241,  242,  243,
			  244,  245,  246,  247,  248,  249,  250,  251,  253,  254,
			  255,  257,  258,  259,  260,  261,  262,  263,  264,  265,
			  266,  267,  268,  269,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  271,  272,  273,  274,  275,  276,
			  277,  278,  279,  279,  279,  279,  279,  280,  281,  282,
			  283,  284,  285,  286,  287,  288,  289,  290,  292,  293,
			  294,  295,  296,  297,  298,  299,  301,  302,  303,  304,
			  305,  306,  307,  309,  310,  311,  313,  314,  315,  316, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  317,  318,  319,  321,  322,  323,  324,  325,  326,  327,
			  328,  329,  330,  331,  332,  333,  334,  335,  336,  337,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  340,  341,  341,  342,  343,  344,  345,  346,
			  346,  347,  348,  349,  350,  351,  352,  353,  354,  355,
			  356,  357,  358,  359,  360,  361,  362,  362,  362,  362,
			  362,  363,  364,  365,  366,  367,  368,  369,  370,  371,
			  373,  374,  375,  376,  377,  378,  379,  379,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  381,  381,  381,
			  381,  381,  382,  382,  382,  382,  382,  382,  382,  382,

			  382,  383,  385,  387,  388,  389,  391,  393,  395,  397,
			  398,  400,  401,  403,  404,  405,  406,  407,  408,  409,
			  410,  411,  412,  413,  414,  415,  416,  417,  419,  420,
			  421,  422,  423,  424,  425,  426,  427,  428,  430,  430,
			  430,  430,  430,  430,  430,  430,  430,  431,  432,  433,
			  434,  435,  436,  437,  438,  439,  440,  441,  442,  443,
			  444,  445,  446,  447,  448,  449,  450,  451,  452,  454,
			  455,  456,  456,  456,  456,  456,  456,  456,  456,  457,
			  457,  458,  459,  459,  460,  462,  463,  465,  466,  467,
			  467,  468,  469,  470,  472,  474,  475,  476,  477,  478, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  479,  480,  481,  482,  483,  484,  485,  487,  488,  489,
			  490,  491,  492,  493,  494,  495,  496,  497,  498,  499,
			  500,  501,  502,  504,  505,  507,  508,  509,  510,  511,
			  512,  513,  514,  515,  516,  517,  518,  519,  520,  521,
			  522,  523,  524,  525,  526,  527,  528,  529,  530,  532,
			  532,  532,  532,  532,  532,  532,  532,  532,  532,  532,
			  532,  532,  532,  532,  532,  533,  533,  533,  533,  533,
			  533,  534,  535,  535,  535,  535,  535,  535,  537,  539,
			  541,  543,  544,  545,  546,  547,  549,  550,  552,  553,
			  554,  555,  556,  558,  560,  561,  562,  563,  563,  563,

			  563,  563,  563,  563,  563,  564,  565,  566,  567,  568,
			  569,  570,  571,  572,  573,  574,  575,  576,  577,  578,
			  579,  580,  581,  582,  583,  584,  585,  586,  588,  588,
			  588,  588,  589,  589,  590,  591,  591,  591,  592,  593,
			  593,  593,  593,  593,  593,  594,  595,  596,  597,  598,
			  599,  600,  601,  602,  603,  604,  605,  606,  607,  608,
			  609,  611,  612,  613,  614,  615,  616,  617,  619,  620,
			  621,  622,  623,  624,  625,  626,  628,  629,  631,  633,
			  634,  636,  638,  639,  640,  641,  642,  643,  644,  645,
			  646,  647,  648,  649,  650,  652,  653,  655,  657,  658, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  659,  660,  661,  662,  664,  666,  667,  667,  668,  668,
			  668,  668,  668,  669,  671,  672,  674,  675,  677,  677,
			  677,  677,  678,  678,  678,  678,  679,  679,  680,  680,
			  681,  682,  683,  684,  686,  688,  689,  690,  691,  693,
			  695,  696,  697,  698,  700,  701,  702,  703,  704,  705,
			  706,  707,  709,  710,  711,  712,  713,  715,  716,  717,
			  718,  720,  721,  721,  722,  722,  722,  722,  722,  722,
			  723,  724,  725,  726,  727,  728,  729,  730,  731,  733,
			  734,  735,  737,  739,  740,  741,  743,  744,  744,  745,
			  746,  747,  748,  749,  749,  749,  749,  749,  749,  750,

			  751,  751,  751,  752,  754,  756,  757,  758,  759,  761,
			  762,  763,  764,  765,  767,  769,  770,  772,  773,  774,
			  776,  777,  778,  779,  780,  781,  782,  783,  783,  783,
			  783,  783,  783,  784,  785,  787,  788,  789,  791,  792,
			  794,  796,  798,  799,  800,  802,  803,  803,  804,  805,
			  806,  807,  807,  807,  807,  807,  807,  807,  807,  807,
			  807,  808,  809,  809,  809,  810,  810,  811,  811,  812,
			  813,  815,  816,  818,  819,  820,  821,  822,  824,  826,
			  827,  829,  831,  832,  833,  834,  835,  836,  837,  839,
			  840,  841,  843,  843,  845,  846,  847,  848,  850,  851, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  853,  854,  855,  855,  856,  856,  857,  858,  858,  858,
			  859,  861,  862,  864,  866,  867,  869,  871,  873,  874,
			  876,  876,  877,  877,  877,  877,  877,  878,  880,  881,
			  883,  885,  885,  886,  888,  890,  891,  891,  892,  894,
			  895,  897,  897,  898,  898,  898,  898,  898,  900,  902,
			  902,  904,  906,  906,  907,  907,  908,  908,  910,  911,
			  911, yy_Dummy>>,
			1, 61, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 910)
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
			    0,  186,  186,  188,  188,  219,  217,  218,    1,  217,
			  218,    1,  218,   36,  217,  218,  189,  217,  218,   41,
			  217,  218,   14,  217,  218,  154,  217,  218,   24,  217,
			  218,   25,  217,  218,   32,  217,  218,   30,  217,  218,
			    9,  217,  218,   31,  217,  218,   13,  217,  218,   33,
			  217,  218,  118,  217,  218,  118,  217,  218,    8,  217,
			  218,    7,  217,  218,   18,  217,  218,   17,  217,  218,
			   19,  217,  218,   11,  217,  218,  117,  217,  218,  117,
			  217,  218,  117,  217,  218,  117,  217,  218,  117,  217,
			  218,  117,  217,  218,  117,  217,  218,  117,  217,  218,

			  117,  217,  218,  117,  217,  218,  117,  217,  218,  117,
			  217,  218,  117,  217,  218,  117,  217,  218,  117,  217,
			  218,  117,  217,  218,  117,  217,  218,  117,  217,  218,
			   28,  217,  218,  217,  218,   29,  217,  218,   34,  217,
			  218,   26,  217,  218,   27,  217,  218,   12,  217,  218,
			  217,  218,  217,  218,  217,  218,  217,  218,  217,  218,
			  217,  218,  217,  218,  217,  218,  217,  218,  217,  218,
			  217,  218,  217,  218,  190,  218,  216,  218,  214,  218,
			  215,  218,  186,  218,  186,  218,  185,  218,  184,  218,
			  186,  218,  186,  218,  186,  218,  186,  218,  186,  218, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  188,  218,  187,  218,  182,  218,  182,  218,  181,  218,
			  182,  218,  182,  218,  182,  218,  182,  218,    6,  218,
			    5,    6,  218,    5,  218,    6,  218,    6,  218,    6,
			  218,    6,  218,    6,  218,    1,  189,  178,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189, -398,  189,  189,  189, -398,  189,  189,  189,
			  189,  189,  189,  189,  189,   41,  154,  154,  154,  154,
			    2,   35,   10,  124,   39,   23,   22,  124,  118,   15,
			   37,   20,   21,   38,   16,  117,  117,  117,  117,  117,
			   48,  117,  117,  117,  117,  117,  117,  117,  117,   61,

			  117,  117,  117,  117,  117,  117,  117,   73,  117,  117,
			  117,   80,  117,  117,  117,  117,  117,  117,  117,   92,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,   40,   42,    1,   42,  190,
			  214,  207,  205,  206,  208,  209,  210,  211,  191,  192,
			  193,  194,  195,  196,  197,  198,  199,  200,  201,  202,
			  203,  204,  186,  185,  184,  186,  186,  186,  186,  186,
			  186,  183,  184,  186,  186,  186,  186,  188,  187,  181,
			    5,    4,  179,  176,  179,  189, -398, -398,  189,  162,
			  179,  160,  179,  161,  179,  163,  179,  189,  156,  179, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  189,  157,  179,  189,  189,  189,  189,  189,  189,  189,
			 -180,  189,  189,  189,  189,  189,  189,  164,  179,  189,
			  189,  189,  189,  189,  189,  189,  189,  154,  125,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  127,  154,  125,  154,  124,  119,  124,  118,
			  122,  123,  123,  121,  123,  120,  118,  117,  117,  117,
			   46,  117,   47,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,   64,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,

			  117,  117,   84,  117,  117,   87,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  116,  117,  213,    4,    4,  168,  179,  165,  179,  158,
			  179,  159,  179,  189,  189,  189,  189,  173,  179,  189,
			  167,  179,  189,  189,  189,  189,  166,  179,  177,  179,
			  189,  189,  189,  144,  142,  143,  145,  146,  155,  155,
			  147,  148,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,  140,  141,  126,  154,  124,  124,
			  124,  124,  118,  118,  118,  117,  117,  117,  117,  117, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,  117,  117,  117,  117,  117,  117,  117,  117,   62,
			  117,  117,  117,  117,  117,  117,  117,   71,  117,  117,
			  117,  117,  117,  117,  117,  117,   81,  117,  117,   83,
			  117,   85,  117,  117,   90,  117,   91,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  105,  117,  117,  107,  117,  108,  117,  117,  117,  117,
			  117,  117,  114,  117,  115,  117,  212,    4,  189,  169,
			  179,  189,  172,  179,  189,  175,  179,  155,  124,  124,
			  124,  124,  118,  117,   44,  117,   45,  117,  117,  117,
			  117,   52,  117,   53,  117,  117,  117,  117,   58,  117,

			  117,  117,  117,  117,  117,  117,  117,   69,  117,  117,
			  117,  117,  117,   76,  117,  117,  117,  117,   82,  117,
			  117,   88,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  102,  117,  117,  117,  106,  117,  109,  117,  117,
			  117,  112,  117,  117,    4,  189,  189,  189,  149,  124,
			  124,  124,   43,  117,   49,  117,  117,  117,  117,   55,
			  117,  117,  117,  117,  117,   63,  117,   65,  117,  117,
			   67,  117,  117,  117,   72,  117,  117,  117,  117,  117,
			  117,  117,   89,  117,  117,   95,  117,  117,  117,   98,
			  117,  117,  100,  117,  101,  117,  103,  117,  117,  117, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  111,  117,  117,    4,  189,  189,  189,  124,  124,  124,
			  124,  117,  117,   54,  117,  117,   57,  117,  117,  117,
			  117,  117,   70,  117,   74,  117,  117,   77,  117,   78,
			  117,  117,  117,  117,  117,  117,  117,   99,  117,  117,
			  117,  113,  117,    3,    4,  189,  189,  189,  152,  153,
			  153,  151,  153,  150,  124,  124,  124,  124,  124,   50,
			  117,  117,   56,  117,   59,  117,  117,   66,  117,   68,
			  117,   75,  117,  117,   86,  117,  117,  117,   96,  117,
			  117,  104,  117,  110,  117,  189,  171,  179,  174,  179,
			  124,  124,   51,  117,  117,   79,  117,  117,   94,  117,

			   97,  117,  170,  179,   60,  117,  117,  117,   93,  117,
			   93, yy_Dummy>>,
			1, 111, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 3900
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 859
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 860
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

	yyNb_rules: INTEGER = 218
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 219
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
