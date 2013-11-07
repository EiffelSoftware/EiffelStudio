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
				if syntax_version = ecma_syntax or else syntax_version = provisional_syntax then
					process_id_as
					last_token := TE_ID
				else
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_IS, Current)
					last_token := TE_IS
					if has_syntax_warning and then syntax_version /= obsolete_syntax then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Usage of `is' has now been deprecated."))
					end
				end

			
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
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND)
			
when 169 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_AND_THEN)
			
when 170 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_IMPLIES)
			
when 171 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_NOT)
			
when 172 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR)
			
when 173 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_OR_ELSE)
			
when 174 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_XOR)
			
when 175 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_STR_FREE)
			
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
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				process_simple_string_as (TE_EMPTY_STRING)
			
when 178 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
					-- Regular string.
				process_simple_string_as (TE_STRING)
			
when 179 then
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
			
when 180 then
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
			
when 181 then
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
			
when 182 then
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
			
when 183 then
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
			
when 184 then
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
			
when 185 then
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
			
when 186 then
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
			
when 187 then
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
			
when 188 then
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
			
when 189 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			
when 207 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			
when 208 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			
when 209 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			
when 210 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			
when 211 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_natural_32)
			
when 212 then
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
			
when 213 then
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
			
when 214 then
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
			
when 215 then
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
			
when 216 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 217 then
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
			create an_array.make_filled (0, 0, 2477)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,   14,   15,   16,   15,   17,   18,   19,   20,   14,
			   19,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   31,   31,   32,   33,   34,   35,   36,   37,
			   19,   38,   39,   40,   41,   42,   43,   39,   39,   44,
			   39,   39,   45,   39,   46,   47,   48,   39,   49,   50,
			   51,   52,   53,   54,   55,   39,   39,   56,   57,   58,
			   59,   14,   14,   38,   39,   40,   41,   42,   43,   39,
			   39,   44,   39,   39,   45,   39,   46,   47,   48,   39,
			   49,   50,   51,   52,   53,   54,   55,   39,   39,   60,
			   19,   61,   62,   14,   14,   14,   14,   63,   64,   65,

			   66,   67,   68,   69,   71,   71,  513,   72,   72,  129,
			   73,   73,   75,   76,   75,  174,   77,   75,   76,   75,
			  130,   77,   82,   83,   82,   82,   83,   82,   85,   86,
			   85,   85,   86,   85,   88,   88,   88,   88,   88,   88,
			  133,  143,  144,   87,  145,  146,   87,  174,  134,   89,
			  653,  131,   89,  132,  132,  132,  132,  136,  172,  137,
			  137,  137,  137,  160,  173,  162,  695,  163,  746,   78,
			  179,  181,  188,  161,   78,  197,  197,  164,  227,  300,
			  191,  228,  175,  194,  194,  194,  300,  180,  227,  192,
			  172,  231,  176,  694,  177,  160,  173,  162,  178,  163,

			  141,   78,  179,  181,  188,  161,   78,   91,   92,  164,
			   93,   92,  191,  135,  175,   94,   95,  118,   96,  180,
			   97,  192,  649,  119,  176,  120,  177,   98,  693,   99,
			  178,   92,  100,  149,  241,  165,  746,  150,  182,  166,
			  101,  320,  151,  321,  152,  102,  103,  155,  183,  153,
			  154,  156,  167,  184,  157,  104,  324,  158,  105,  106,
			  159,  107,  692,  302,  100,  149,  241,  165,  307,  150,
			  182,  166,  101,  320,  151,  321,  152,  102,  103,  155,
			  183,  153,  154,  156,  167,  184,  157,  104,  324,  158,
			  108,   92,  159,  196,  196,  196,  314,  314,  109,  110,

			  111,  112,  113,  114,  115,  189,  325,  121,  121,  121,
			  121,  122,  123,  124,  125,  126,  127,  128,  136,  190,
			  137,  137,  137,  137,  409,  409,  185,  168,  198,  198,
			  198,  326,  138,  139,  169,  170,  186,  189,  325,  187,
			  171,  199,  199,  199,  234,  235,  234,  236,  236,  236,
			  688,  190,  327,  328,  140,  236,  236,  236,  185,  168,
			  565,  141,  642,  326,  138,  139,  169,  170,  186,  329,
			  626,  187,  171,  229,  227,  229,  591,  228,   88,   88,
			   88,  316,  316,  316,  327,  328,  140,  203,  203,  203,
			  587,  204,  238,   89,  205,   93,  206,  207,  208,  242,

			  243,  329,   93,   93,  209,  244,  227,  245,   93,  228,
			   93,  210,  227,  211,  310,  231,  212,  213,  214,  215,
			  246,  216,  238,  217,  450,   93,  448,  218,  648,  219,
			  230,  300,  220,  221,  222,  223,  224,  225,  247,  197,
			  197,   93,  249,  108,  238,   93,  238,   93,  515,   93,
			  108,  108,  238,  200,  300,   93,  108,  195,  108,  248,
			  251,  238,  230,  250,   93,  256,  257,  256,  260,  238,
			  649,   93,   93,  108,  450,  108,   90,   90,  330,   90,
			  300,  239,  108,  108,   93,  253,  254,  448,  108,  108,
			  108,  255,  251,  108,  331,  108,  238,  108,  252,   93,

			  256,  257,  256,  108,  238,  108,  238,   93,  238,   93,
			  330,   93,  108,  301,  301,  301,  269,  253,  254,  108,
			  108,  108,  258,  255,  335,  108,  331,  108,  300,  108,
			  252,  238,  240,  300,   93,  108,  303,  303,  303,  238,
			  592,  592,   93,  435,  108,  434,  652,  108,  259,  433,
			  238,  108,  108,   93,  340,  108,  335,  108,  238,  108,
			  432,   93,  304,  304,  240,  431,  336,  341,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,  108,
			  238,  337,  108,   93,  314,  314,  340,  108,  653,  108,
			  108,  108,  338,  261,  261,  261,  339,  262,  336,  341,

			  342,  108,  270,  271,  272,  273,  274,  275,  276,  108,
			  305,  305,  305,  337,  108,  306,  306,  306,  263,  263,
			  263,  430,  108,  429,  338,  447,  264,  264,  339,  299,
			  343,  108,  342,  108,  349,  428,  427,  265,  265,  265,
			  352,  108,  426,  425,  353,  266,  266,  266,  270,  271,
			  272,  273,  274,  275,  276,  308,  308,  308,  308,  354,
			  355,  424,  343,  108,  423,  422,  349,  267,  277,  356,
			  309,  278,  352,  279,  280,  281,  353,  194,  194,  194,
			  310,  282,  311,  311,  311,  311,  421,  420,  283,  417,
			  284,  354,  355,  285,  286,  287,  288,  312,  289,  416,

			  290,  356,  309,  357,  291,  322,  292,  358,  323,  293,
			  294,  295,  296,  297,  298,  270,  271,  272,  273,  274,
			  275,  276,  367,  136,  415,  313,  313,  313,  313,  312,
			  318,  318,  318,  318,  414,  357,  350,  322,  332,  358,
			  323,  368,  333,  194,  194,  194,  413,  412,  351,  365,
			  369,  370,  371,  366,  367,  375,  334,  314,  314,  270,
			  271,  272,  273,  274,  275,  276,  141,  376,  350,  407,
			  332,  319,  377,  368,  333,  344,  359,  345,  360,  346,
			  351,  365,  369,  370,  371,  366,  361,  375,  334,  362,
			  347,  363,  364,  348,  378,  454,  372,  391,  447,  376,

			  455,  373,  233,  202,  377,  300,  129,  344,  359,  345,
			  360,  346,  374,  194,  194,  194,  393,  237,  361,   93,
			  233,  362,  347,  363,  364,  348,  378,  454,  372,  194,
			  194,  194,  455,  373,  379,  380,  381,  382,  383,  384,
			  385,  386,  386,  386,  374,  387,  387,  387,  203,  203,
			  203,  389,  389,  389,  389,  388,  229,  227,  229,  202,
			  228,  234,  235,  234,  236,  236,  236,  108,  392,  257,
			  392,  200,  195,  394,  395,  238,   93,   93,   93,  399,
			  238,  400,  456,   93,   93,  238,  238,  402,   93,   93,
			   93,  403,  404,  238,   93,   93,   93,  193,  147,  108,

			  268,  268,  268,  396,  256,  257,  256,  142,  238,  746,
			   80,   93,   80,  230,  456,  746,  238,  746,  457,   93,
			  397,  460,  746,  241,  108,  108,  108,  238,  401,  398,
			   93,  108,  108,  461,  462,  396,  108,  108,  108,  408,
			  408,  408,  108,  108,  108,  230,   90,  256,  257,  256,
			  457,  239,  397,  460,   93,  241,  108,  108,  108,  108,
			  401,  398,  746,  108,  108,  461,  462,  108,  108,  108,
			  108,  410,  410,  410,  108,  108,  108,  746,  108,  746,
			  261,  261,  261,  109,  110,  111,  112,  113,  114,  115,
			  746,  108,  411,  411,  411,  301,  301,  301,  238,  108, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  463,   93,  240,  261,  261,  261,  238,  746,  746,   93,
			  108,  301,  301,  301,  261,  261,  261,  238,  746,  746,
			   93,  418,  419,  419,  419,  436,  301,  301,  301,  301,
			  301,  301,  463,  464,  240,  437,  437,  437,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,  108,
			  438,  438,  438,  194,  194,  194,  465,  108,  466,  746,
			  439,  439,  439,  439,  440,  464,  440,  467,  108,  441,
			  441,  441,  441,  746,  746,  309,  442,  442,  442,  442,
			  746,  108,  196,  196,  196,  261,  261,  261,  465,  108,
			  466,  443,  746,  405,  405,  405,  316,  316,  316,  467,

			  108,  746,  468,  458,  406,  406,  406,  309,  198,  198,
			  198,  270,  271,  272,  273,  274,  275,  276,  469,  444,
			  459,  444,  472,  443,  445,  445,  445,  445,  136,  473,
			  446,  446,  446,  446,  468,  458,  451,  449,  452,  452,
			  452,  452,  453,  453,  453,  453,  470,  746,  474,  475,
			  469,  746,  459,  477,  472,  478,  479,  480,  481,  482,
			  471,  473,  476,  483,  484,  485,  486,  487,  488,  489,
			  490,  141,  491,  493,  494,  492,  495,  496,  470,  319,
			  474,  475,  499,  319,  500,  477,  501,  478,  479,  480,
			  481,  482,  471,  497,  476,  483,  484,  485,  486,  487,

			  488,  489,  490,  502,  491,  493,  494,  492,  495,  496,
			  503,  498,  504,  505,  499,  506,  500,  507,  501,  508,
			  509,  510,  511,  512,  746,  497,  199,  199,  199,  194,
			  194,  194,  194,  194,  194,  502,  513,  514,  514,  514,
			  514,  746,  503,  498,  504,  505,  535,  506,  746,  507,
			  746,  508,  509,  510,  511,  512,  392,  257,  392,  516,
			  746,  517,  238,  519,   93,   93,   93,  238,  521,  238,
			   93,   93,   93,  268,  268,  268,  238,  746,  535,   93,
			  268,  268,  268,  268,  268,  268,  268,  268,  268,  522,
			  522,  522,  523,  523,  523,  746,  520,  536,  518,  301,

			  301,  301,  524,  419,  419,  419,  419,  301,  301,  301,
			  537,  241,  108,  108,  108,  525,  526,  538,  108,  108,
			  108,  524,  419,  419,  419,  419,  746,  108,  520,  536,
			  518,  441,  441,  441,  441,  539,  540,  527,  528,  528,
			  528,  528,  537,  241,  108,  108,  108,  525,  526,  538,
			  108,  108,  108,  309,  746,  541,  261,  261,  261,  108,
			  268,  268,  268,  261,  261,  261,  746,  539,  540,  527,
			  441,  441,  441,  441,  530,  530,  530,  530,  746,  529,
			  445,  445,  445,  445,  746,  309,  531,  541,  531,  443,
			  542,  532,  532,  532,  532,  445,  445,  445,  445,  533,

			  543,  446,  446,  446,  446,  451,  544,  534,  534,  534,
			  534,  451,  545,  453,  453,  453,  453,  546,  547,  548,
			  549,  443,  542,  550,  551,  552,  553,  554,  555,  556,
			  557,  558,  543,  559,  560,  561,  562,  563,  544,  564,
			  746,  746,  319,  568,  545,  569,  570,  571,  319,  546,
			  547,  548,  549,  572,  319,  550,  551,  552,  553,  554,
			  555,  556,  557,  558,  573,  559,  560,  561,  562,  563,
			  574,  564,  565,  565,  565,  568,  566,  569,  570,  571,
			  575,  576,  577,  578,  579,  572,  580,  567,  581,  582,
			  583,  584,  585,  268,  268,  268,  573,  513,  586,  586,

			  586,  586,  574,  238,  238,  238,   93,   93,   93,  594,
			  594,  594,  575,  576,  577,  578,  579,  746,  580,  746,
			  581,  582,  583,  584,  585,  528,  528,  528,  528,  597,
			  597,  597,  597,  598,  598,  598,  598,  589,  602,  603,
			  596,  590,  532,  532,  532,  532,  604,  588,  443,  532,
			  532,  532,  532,  605,  108,  108,  108,  746,  310,  566,
			  598,  598,  598,  598,  606,  609,  610,  611,  612,  589,
			  602,  603,  596,  590,  599,  600,  613,  607,  604,  588,
			  443,  608,  614,  615,  616,  605,  108,  108,  108,  601,
			  617,  453,  453,  453,  453,  618,  606,  609,  610,  611,

			  612,  619,  620,  621,  622,  623,  624,  600,  613,  607,
			  627,  628,  629,  608,  614,  615,  616,  630,  631,  632,
			  633,  634,  617,  635,  565,  565,  565,  618,  625,  636,
			  637,  638,  141,  619,  620,  621,  622,  623,  624,  567,
			  639,  640,  627,  628,  629,  238,  746,  746,   93,  630,
			  631,  632,  633,  634,  746,  635,  513,  641,  641,  641,
			  641,  636,  637,  638,  238,  238,  746,   93,   93,  315,
			  315,  315,  639,  640,  663,  664,  746,  643,  646,  592,
			  592,  650,  594,  594,  594,  746,  656,  656,  656,  656,
			  665,  746,  654,  644,  654,  666,  108,  655,  655,  655,

			  655,  657,  598,  598,  598,  598,  663,  664,  645,  643,
			  746,  625,  746,  667,  668,  108,  108,  658,  746,  669,
			  647,  746,  665,  651,  670,  644,  671,  666,  108,  659,
			  659,  659,  659,  657,  672,  746,  660,  673,  660,  674,
			  645,  661,  661,  661,  661,  667,  668,  108,  108,  658,
			  310,  669,  659,  659,  659,  659,  670,  675,  671,  676,
			  677,  678,  679,  680,  681,  682,  672,  662,  683,  673,
			  684,  674,  685,  686,  513,  687,  687,  687,  687,  238,
			  238,  238,   93,   93,   93,  655,  655,  655,  655,  675,
			  705,  676,  677,  678,  679,  680,  681,  682,  746,  662,

			  683,  746,  684,  746,  685,  686,  706,  746,  689,  746,
			  691,  655,  655,  655,  655,  746,  707,  746,  696,  696,
			  696,  696,  705,  690,  661,  661,  661,  661,  708,  709,
			  108,  108,  108,  657,  701,  701,  701,  701,  706,  697,
			  689,  697,  691,  746,  698,  698,  698,  698,  707,  702,
			  710,  699,  711,  699,  712,  690,  700,  700,  700,  700,
			  708,  709,  108,  108,  108,  657,  661,  661,  661,  661,
			  703,  713,  703,  714,  717,  704,  704,  704,  704,  718,
			  719,  702,  710,  720,  711,  721,  712,  715,  715,  715,
			  513,  722,  722,  722,  722,  238,  724,  725,   93,   93,

			   93,  746,  657,  713,  746,  714,  717,  698,  698,  698,
			  698,  718,  719,  729,  746,  720,  746,  721,  716,  698,
			  698,  698,  698,  700,  700,  700,  700,  746,  529,  700,
			  700,  700,  700,  723,  657,  730,  726,  726,  726,  726,
			  704,  704,  704,  704,  731,  729,  108,  108,  108,  733,
			  716,  702,  727,  734,  727,  735,  702,  728,  728,  728,
			  728,  704,  704,  704,  704,  723,  738,  730,  715,  715,
			  715,  513,  736,  736,  736,  736,  731,  739,  108,  108,
			  108,  733,  599,  702,  740,  734,  737,  735,  702,   93,
			  728,  728,  728,  728,  728,  728,  728,  728,  738,  732, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  741,  742,  743,  744,  745,  317,  317,  317,  746,  739,
			  593,  593,  593,  746,  116,  746,  740,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  595,  595,
			  595,  732,  741,  742,  743,  744,  745,  108,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  108,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,

			   74,   74,   74,   74,   74,   74,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   90,  746,   90,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  201,  746,  201,  201,

			  746,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  230,  230,  230,  230,  230,  230,  230,  230,
			  230,  230,  230,  230,  230,  230,  230,  230,  230,  230,
			  232,  232,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  232,  232,  232,   92,  746,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   93,  746,   93,  746,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,

			   93,   93,   93,   93,  268,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,  268,  268,  268,
			  390,  746,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  688,  746,  688,  688,
			  688,  688,  688,  688,  688,  688,  688,  688,  688,  688,
			  688,  688,  688,  688,   13,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,

			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746, yy_Dummy>>,
			1, 478, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2477)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
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

			    1,    1,    1,    1,    3,    4,  736,    3,    4,   27,
			    3,    4,    5,    5,    5,   46,    5,    6,    6,    6,
			   27,    6,    9,    9,    9,   10,   10,   10,   11,   11,
			   11,   12,   12,   12,   15,   15,   15,   16,   16,   16,
			   29,   34,   34,   11,   36,   36,   12,   46,   29,   15,
			  653,   28,   16,   28,   28,   28,   28,   31,   45,   31,
			   31,   31,   31,   41,   45,   42,  652,   42,  651,    5,
			   48,   49,   52,   41,    6,   66,   66,   42,   74,  123,
			   54,   74,   47,   63,   63,   63,  128,   48,   78,   55,
			   45,   78,   47,  650,   47,   41,   45,   42,   47,   42,

			   31,    5,   48,   49,   52,   41,    6,   18,   18,   42,
			   18,   18,   54,   29,   47,   18,   18,   21,   18,   48,
			   18,   55,  649,   21,   47,   21,   47,   18,  648,   18,
			   47,   18,   18,   38,   93,   43,  647,   38,   50,   43,
			   18,  149,   38,  150,   38,   18,   18,   40,   50,   38,
			   38,   40,   43,   50,   40,   18,  152,   40,   18,   18,
			   40,   18,  646,  123,   18,   38,   93,   43,  128,   38,
			   50,   43,   18,  149,   38,  150,   38,   18,   18,   40,
			   50,   38,   38,   40,   43,   50,   40,   18,  152,   40,
			   18,   18,   40,   65,   65,   65,  138,  138,   18,   18,

			   18,   18,   18,   18,   18,   53,  153,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   30,   53,
			   30,   30,   30,   30,  273,  273,   51,   44,   67,   67,
			   67,  154,   30,   30,   44,   44,   51,   53,  153,   51,
			   44,   68,   68,   68,   82,   82,   82,   85,   85,   85,
			  642,   53,  155,  156,   30,   86,   86,   86,   51,   44,
			  626,   30,  587,  154,   30,   30,   44,   44,   51,  157,
			  567,   51,   44,   75,   75,   75,  524,   75,   88,   88,
			   88,  139,  139,  139,  155,  156,   30,   73,   73,   73,
			  515,   73,   90,   88,   73,   90,   73,   73,   73,   94,

			   95,  157,   94,   95,   73,   96,  226,   97,   96,  226,
			   97,   73,  230,   73,  451,  230,   73,   73,   73,   73,
			   97,   73,  100,   73,  450,  100,  448,   73,  593,   73,
			   75,  122,   73,   73,   73,   73,   73,   73,   98,  382,
			  382,   98,   99,   90,  103,   99,  102,  103,  391,  102,
			   94,   95,  104,  385,  124,  104,   96,  380,   97,   98,
			  100,  101,   75,   99,  101,  105,  105,  105,  107,  105,
			  593,  107,  105,  100,  317,   90,   92,   92,  158,   92,
			  125,   92,   94,   95,   92,  102,  103,  315,   96,   98,
			   97,  104,  100,   99,  159,  103,  106,  102,  101,  106,

			  108,  108,  108,  104,  108,  100,  109,  108,  110,  109,
			  158,  110,  101,  122,  122,  122,  117,  102,  103,  107,
			  105,   98,  105,  104,  162,   99,  159,  103,  126,  102,
			  101,  111,   92,  127,  111,  104,  124,  124,  124,  112,
			  525,  525,  112,  298,  101,  297,  595,  106,  106,  296,
			  113,  107,  105,  113,  165,  108,  162,  109,  114,  110,
			  295,  114,  125,  125,   92,  294,  163,  166,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,  106,
			  115,  163,  111,  115,  314,  314,  165,  108,  595,  109,
			  112,  110,  164,  109,  109,  109,  164,  110,  163,  166,

			  167,  113,  117,  117,  117,  117,  117,  117,  117,  114,
			  126,  126,  126,  163,  111,  127,  127,  127,  111,  111,
			  111,  293,  112,  292,  164,  314,  112,  112,  164,  120,
			  169,  115,  167,  113,  172,  291,  290,  113,  113,  113,
			  174,  114,  289,  288,  175,  114,  114,  114,  118,  118,
			  118,  118,  118,  118,  118,  132,  132,  132,  132,  176,
			  177,  287,  169,  115,  286,  285,  172,  115,  119,  177,
			  132,  119,  174,  119,  119,  119,  175,  195,  195,  195,
			  136,  119,  136,  136,  136,  136,  284,  283,  119,  281,
			  119,  176,  177,  119,  119,  119,  119,  136,  119,  280,

			  119,  177,  132,  179,  119,  151,  119,  180,  151,  119,
			  119,  119,  119,  119,  119,  120,  120,  120,  120,  120,
			  120,  120,  183,  137,  279,  137,  137,  137,  137,  136,
			  141,  141,  141,  141,  278,  179,  173,  151,  160,  180,
			  151,  184,  160,  196,  196,  196,  277,  276,  173,  182,
			  185,  186,  187,  182,  183,  189,  160,  447,  447,  119,
			  119,  119,  119,  119,  119,  119,  137,  190,  173,  271,
			  160,  141,  191,  184,  160,  170,  181,  170,  181,  170,
			  173,  182,  185,  186,  187,  182,  181,  189,  160,  181,
			  170,  181,  181,  170,  192,  320,  188,  237,  447,  190,

			  321,  188,  232,  201,  191,  121,   89,  170,  181,  170,
			  181,  170,  188,  197,  197,  197,  246,   87,  181,  246,
			   79,  181,  170,  181,  181,  170,  192,  320,  188,  198,
			  198,  198,  321,  188,  194,  194,  194,  194,  194,  194,
			  194,  199,  199,  199,  188,  200,  200,  200,  203,  203,
			  203,  209,  209,  209,  209,  203,  229,  229,  229,   70,
			  229,  234,  234,  234,  236,  236,  236,  246,  241,  241,
			  241,   69,   64,  248,  250,  251,  248,  250,  251,  254,
			  252,  254,  322,  252,  254,  253,  255,  258,  253,  255,
			  258,  259,  261,  262,  259,  261,  262,   57,   37,  246,

			  270,  270,  270,  251,  256,  256,  256,   32,  256,   13,
			    8,  256,    7,  229,  322,    0,  263,    0,  325,  263,
			  252,  327,    0,  241,  248,  250,  251,  264,  255,  253,
			  264,  252,  254,  328,  329,  251,  253,  255,  258,  272,
			  272,  272,  259,  261,  262,  229,  240,  240,  240,  240,
			  325,  240,  252,  327,  240,  241,  248,  250,  251,  256,
			  255,  253,    0,  252,  254,  328,  329,  263,  253,  255,
			  258,  274,  274,  274,  259,  261,  262,    0,  264,    0,
			  262,  262,  262,  261,  261,  261,  261,  261,  261,  261,
			    0,  256,  275,  275,  275,  302,  302,  302,  265,  263, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  330,  265,  240,  263,  263,  263,  266,    0,    0,  266,
			  264,  303,  303,  303,  264,  264,  264,  267,    0,    0,
			  267,  282,  282,  282,  282,  301,  304,  304,  304,  305,
			  305,  305,  330,  331,  240,  306,  306,  306,  240,  240,
			  240,  240,  240,  240,  240,  240,  240,  240,  240,  265,
			  307,  307,  307,  379,  379,  379,  332,  266,  333,    0,
			  308,  308,  308,  308,  309,  331,  309,  334,  267,  309,
			  309,  309,  309,    0,    0,  308,  311,  311,  311,  311,
			    0,  265,  381,  381,  381,  265,  265,  265,  332,  266,
			  333,  311,    0,  266,  266,  266,  316,  316,  316,  334,

			  267,    0,  335,  326,  267,  267,  267,  308,  383,  383,
			  383,  301,  301,  301,  301,  301,  301,  301,  337,  312,
			  326,  312,  339,  311,  312,  312,  312,  312,  313,  340,
			  313,  313,  313,  313,  335,  326,  318,  316,  318,  318,
			  318,  318,  319,  319,  319,  319,  338,    0,  341,  342,
			  337,    0,  326,  343,  339,  344,  345,  346,  347,  348,
			  338,  340,  342,  349,  350,  351,  352,  353,  355,  356,
			  357,  313,  358,  359,  360,  358,  361,  362,  338,  318,
			  341,  342,  364,  319,  365,  343,  366,  344,  345,  346,
			  347,  348,  338,  363,  342,  349,  350,  351,  352,  353,

			  355,  356,  357,  367,  358,  359,  360,  358,  361,  362,
			  368,  363,  369,  370,  364,  371,  365,  372,  366,  373,
			  374,  375,  376,  377,    0,  363,  384,  384,  384,  386,
			  386,  386,  387,  387,  387,  367,  389,  389,  389,  389,
			  389,    0,  368,  363,  369,  370,  454,  371,    0,  372,
			    0,  373,  374,  375,  376,  377,  392,  392,  392,  396,
			    0,  396,  397,  398,  396,  397,  398,  399,  401,  405,
			  399,  401,  405,  407,  407,  407,  406,    0,  454,  406,
			  408,  408,  408,  409,  409,  409,  410,  410,  410,  411,
			  411,  411,  412,  412,  412,    0,  399,  455,  397,  437,

			  437,  437,  418,  418,  418,  418,  418,  438,  438,  438,
			  456,  392,  396,  397,  398,  418,  418,  457,  399,  401,
			  405,  419,  419,  419,  419,  419,    0,  406,  399,  455,
			  397,  440,  440,  440,  440,  458,  459,  418,  439,  439,
			  439,  439,  456,  392,  396,  397,  398,  418,  418,  457,
			  399,  401,  405,  439,    0,  460,  405,  405,  405,  406,
			  522,  522,  522,  406,  406,  406,    0,  458,  459,  418,
			  441,  441,  441,  441,  442,  442,  442,  442,    0,  439,
			  444,  444,  444,  444,    0,  439,  443,  460,  443,  442,
			  461,  443,  443,  443,  443,  445,  445,  445,  445,  446,

			  462,  446,  446,  446,  446,  452,  463,  452,  452,  452,
			  452,  453,  464,  453,  453,  453,  453,  465,  466,  467,
			  468,  442,  461,  469,  470,  471,  472,  473,  474,  476,
			  477,  478,  462,  479,  480,  481,  482,  484,  463,  487,
			    0,    0,  446,  490,  464,  491,  492,  493,  452,  465,
			  466,  467,  468,  494,  453,  469,  470,  471,  472,  473,
			  474,  476,  477,  478,  495,  479,  480,  481,  482,  484,
			  496,  487,  488,  488,  488,  490,  488,  491,  492,  493,
			  497,  498,  499,  500,  501,  494,  503,  488,  506,  507,
			  508,  509,  510,  523,  523,  523,  495,  514,  514,  514,

			  514,  514,  496,  516,  518,  520,  516,  518,  520,  526,
			  526,  526,  497,  498,  499,  500,  501,    0,  503,    0,
			  506,  507,  508,  509,  510,  528,  528,  528,  528,  529,
			  529,  529,  529,  530,  530,  530,  530,  518,  535,  538,
			  528,  520,  531,  531,  531,  531,  539,  516,  530,  532,
			  532,  532,  532,  540,  516,  518,  520,    0,  533,  488,
			  533,  533,  533,  533,  543,  545,  547,  548,  549,  518,
			  535,  538,  528,  520,  530,  533,  550,  544,  539,  516,
			  530,  544,  551,  552,  553,  540,  516,  518,  520,  534,
			  555,  534,  534,  534,  534,  556,  543,  545,  547,  548,

			  549,  557,  558,  560,  561,  562,  564,  533,  550,  544,
			  568,  569,  570,  544,  551,  552,  553,  571,  572,  573,
			  574,  575,  555,  576,  565,  565,  565,  556,  565,  578,
			  579,  582,  534,  557,  558,  560,  561,  562,  564,  565,
			  583,  585,  568,  569,  570,  588,    0,    0,  588,  571,
			  572,  573,  574,  575,    0,  576,  586,  586,  586,  586,
			  586,  578,  579,  582,  589,  590,    0,  589,  590,  763,
			  763,  763,  583,  585,  604,  605,    0,  588,  592,  592,
			  592,  594,  594,  594,  594,    0,  597,  597,  597,  597,
			  606,    0,  596,  589,  596,  608,  588,  596,  596,  596,

			  596,  597,  598,  598,  598,  598,  604,  605,  590,  588,
			    0,  565,    0,  609,  610,  589,  590,  598,    0,  611,
			  592,    0,  606,  594,  614,  589,  616,  608,  588,  599,
			  599,  599,  599,  597,  617,    0,  600,  619,  600,  620,
			  590,  600,  600,  600,  600,  609,  610,  589,  590,  598,
			  601,  611,  601,  601,  601,  601,  614,  621,  616,  622,
			  623,  624,  627,  628,  630,  631,  617,  601,  633,  619,
			  637,  620,  638,  640,  641,  641,  641,  641,  641,  643,
			  644,  645,  643,  644,  645,  654,  654,  654,  654,  621,
			  663,  622,  623,  624,  627,  628,  630,  631,    0,  601,

			  633,    0,  637,    0,  638,  640,  664,    0,  643,    0,
			  645,  655,  655,  655,  655,    0,  666,    0,  656,  656,
			  656,  656,  663,  644,  660,  660,  660,  660,  668,  669,
			  643,  644,  645,  656,  659,  659,  659,  659,  664,  657,
			  643,  657,  645,    0,  657,  657,  657,  657,  666,  659,
			  670,  658,  671,  658,  674,  644,  658,  658,  658,  658,
			  668,  669,  643,  644,  645,  656,  661,  661,  661,  661,
			  662,  677,  662,  678,  680,  662,  662,  662,  662,  681,
			  682,  659,  670,  684,  671,  685,  674,  679,  679,  679,
			  687,  687,  687,  687,  687,  689,  690,  691,  689,  690,

			  691,    0,  696,  677,    0,  678,  680,  697,  697,  697,
			  697,  681,  682,  706,    0,  684,    0,  685,  679,  698,
			  698,  698,  698,  699,  699,  699,  699,    0,  696,  700,
			  700,  700,  700,  689,  696,  709,  701,  701,  701,  701,
			  703,  703,  703,  703,  713,  706,  689,  690,  691,  716,
			  679,  701,  702,  717,  702,  719,  726,  702,  702,  702,
			  702,  704,  704,  704,  704,  689,  730,  709,  715,  715,
			  715,  722,  722,  722,  722,  722,  713,  732,  689,  690,
			  691,  716,  726,  701,  733,  717,  723,  719,  726,  723,
			  727,  727,  727,  727,  728,  728,  728,  728,  730,  715, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  739,  740,  741,  742,  743,  764,  764,  764,    0,  732,
			  766,  766,  766,    0,  753,    0,  733,  753,  753,  753,
			  753,  753,  753,  753,  753,  753,  753,  753,  767,  767,
			  767,  715,  739,  740,  741,  742,  743,  723,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  723,
			  747,  747,  747,  747,  747,  747,  747,  747,  747,  747,
			  747,  747,  747,  747,  747,  747,  747,  747,  748,  748,
			  748,  748,  748,  748,  748,  748,  748,  748,  748,  748,

			  748,  748,  748,  748,  748,  748,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  750,  750,  750,  750,  750,  750,
			  750,  750,  750,  750,  750,  750,  750,  750,  750,  750,
			  750,  750,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  752,    0,  752,  752,  752,  752,  752,  752,  752,  752,
			  752,  752,  752,  752,  752,  752,  752,  752,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  756,    0,  756,  756,

			    0,  756,  756,  756,  756,  756,  756,  756,  756,  756,
			  756,  756,  756,  756,  757,  757,  757,  757,  757,  757,
			  757,  757,  757,  757,  757,  757,  757,  757,  757,  757,
			  757,  757,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  759,  759,  759,  759,  759,  759,  759,  759,  759,  759,
			  759,  759,  759,  759,  759,  759,  759,  759,  760,    0,
			  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
			  760,  760,  760,  760,  760,  760,  761,    0,  761,    0,
			  761,  761,  761,  761,  761,  761,  761,  761,  761,  761,

			  761,  761,  761,  761,  762,  762,  762,  762,  762,  762,
			  762,  762,  762,  762,  762,  762,  762,  762,  762,  762,
			  765,    0,  765,  765,  765,  765,  765,  765,  765,  765,
			  765,  765,  765,  765,  765,  765,  765,  765,  768,  768,
			  768,  768,  768,  768,  768,  768,  768,  768,  768,  768,
			  768,  768,  768,  768,  768,  768,  769,    0,  769,  769,
			  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,
			  769,  769,  769,  769,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,

			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746, yy_Dummy>>,
			1, 478, 2000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  101,  102,  110,  115,  909,  907,  120,
			  123,  126,  129,  909, 2374,  132,  135, 2374,  201,    0,
			 2374,  214, 2374, 2374, 2374, 2374, 2374,   92,  133,  121,
			  300,  139,  880, 2374,  115, 2374,  117,  871,  200,    0,
			  209,  128,  123,  204,  291,  119,   70,  150,  139,  136,
			  203,  288,  128,  274,  142,  144, 2374,  839, 2374, 2374,
			 2374, 2374, 2374,   90,  777,  200,   82,  235,  248,  778,
			  853, 2374, 2374,  385,  175,  371, 2374, 2374,  185,  817,
			 2374, 2374,  342, 2374, 2374,  345,  353,  800,  376,  789,
			  386, 2374,  475,  177,  393,  394,  399,  401,  432,  436,

			  416,  455,  440,  438,  446,  463,  490,  462,  498,  500,
			  502,  525,  533,  544,  552,  574,    0,  505,  551,  662,
			  618,  794,  420,  168,  443,  469,  517,  522,  175, 2374,
			 2374, 2374,  635, 2374, 2374, 2374,  662,  705,  276,  361,
			    0,  710, 2374, 2374, 2374, 2374, 2374, 2374,    0,  193,
			  208,  666,  222,  257,  281,  317,  322,  325,  443,  446,
			  706,    0,  475,  532,  546,  512,  536,  555,    0,  584,
			  741,    0,  593,  703,  590,  595,  625,  627,    0,  655,
			  672,  742,  707,  679,  693,  715,  700,  706,  762,  707,
			  728,  737,  746, 2374,  737,  584,  650,  720,  736,  748,

			  752,  797, 2374,  846, 2374, 2374, 2374, 2374, 2374,  831,
			 2374, 2374, 2374, 2374, 2374, 2374, 2374, 2374, 2374, 2374,
			 2374, 2374, 2374, 2374, 2374, 2374,  403, 2374, 2374,  854,
			  409, 2374,  799, 2374,  859, 2374,  862,  790, 2374, 2374,
			  945,  866, 2374, 2374, 2374, 2374,  810, 2374,  867, 2374,
			  868,  869,  874,  879,  875,  880,  902, 2374,  881,  885,
			 2374,  886,  887,  910,  921,  992, 1000, 1011, 2374, 2374,
			  807,  674,  846,  231,  878,  899,  654,  735,  723,  713,
			  688,  678, 1001,  676,  675,  654,  653,  650,  632,  631,
			  625,  624,  612,  610,  554,  549,  538,  534,  532, 2374,

			 2374, 1014,  902,  918,  933,  936,  942,  957, 1040, 1049,
			 2374, 1056, 1104, 1110,  564,  426, 1076,  413, 1118, 1122,
			  750,  756,  851,    0,    0,  879, 1072,  888,  884,  882,
			  969,  985, 1005, 1023, 1036, 1067,    0, 1067, 1115, 1087,
			 1080, 1098, 1106, 1111, 1120, 1117, 1122, 1112, 1128, 1128,
			 1133, 1119, 1131, 1122,    0, 1133, 1114, 1120, 1139, 1138,
			 1139, 1145, 1126, 1160, 1134, 1149, 1155, 1168, 1171, 1168,
			 1178, 1173, 1182, 1172, 1181, 1182, 1188, 1179,    0,  960,
			  362,  989,  346, 1015, 1133,  360, 1136, 1139, 2374, 1217,
			    0,  374, 1254, 2374, 2374, 2374, 1255, 1256, 1257, 1261,

			 2374, 1262, 2374, 2374, 2374, 1263, 1270, 1180, 1187, 1190,
			 1193, 1196, 1199, 2374, 2374, 2374, 2374, 2374, 1283, 1302,
			 2374, 2374, 2374, 2374, 2374, 2374, 2374, 2374, 2374, 2374,
			 2374, 2374, 2374, 2374, 2374, 2374, 2374, 1206, 1214, 1318,
			 1311, 1350, 1354, 1371, 1360, 1375, 1381,  737,  365,    0,
			  363,  396, 1387, 1393, 1197, 1247, 1261, 1280, 1302, 1297,
			 1314, 1341, 1365, 1356, 1377, 1380, 1370, 1386, 1381, 1375,
			 1380, 1377, 1378, 1392, 1377,    0, 1394, 1391, 1377, 1379,
			 1386, 1400, 1388,    0, 1395,    0,    0, 1397, 1470,    0,
			 1404, 1394, 1407, 1411, 1405, 1421, 1431, 1429, 1439, 1427,

			 1450, 1436,    0, 1440,    0,    0, 1453, 1453, 1439, 1449,
			 1461,    0,    0, 2374, 1478,  319, 1497, 2374, 1498, 2374,
			 1499, 2374, 1267, 1400,  365,  520, 1489,    0, 1505, 1509,
			 1513, 1522, 1529, 1540, 1571, 1489,    0,    0, 1495, 1508,
			 1521,    0,    0, 1516, 1542, 1521,    0, 1518, 1529, 1532,
			 1541, 1548, 1533, 1540,    0, 1542, 1551, 1566, 1563,    0,
			 1564, 1571, 1566,    0, 1571, 1622, 2374,  353, 1579, 1563,
			 1558, 1578, 1583, 1584, 1572, 1586, 1573,    0, 1579, 1599,
			    0,    0, 1592, 1605,    0, 1597, 1637,  286, 1639, 1658,
			 1659, 2374, 1659,  409, 1662,  527, 1677, 1666, 1682, 1709,

			 1721, 1732,    0,    0, 1639, 1624, 1640,    0, 1650, 1663,
			 1679, 1688,    0,    0, 1689,    0, 1695, 1699,    0, 1688,
			 1695, 1707, 1709, 1729, 1711, 2374,  357, 1720, 1714,    0,
			 1720, 1721,    0, 1733,    0,    0,    0, 1720, 1728,    0,
			 1723, 1755,  283, 1773, 1774, 1775,  251,  217,  217,  161,
			  182,  149,  155,   89, 1765, 1791, 1798, 1824, 1836, 1814,
			 1804, 1846, 1855, 1756, 1756,    0, 1772,    0, 1794, 1797,
			 1816, 1810,    0,    0, 1817,    0,    0, 1827, 1838, 1885,
			 1829, 1844, 1847,    0, 1848, 1850,    0, 1871,    0, 1889,
			 1890, 1891, 2374, 2374, 2374, 2374, 1867, 1887, 1899, 1903,

			 1909, 1916, 1937, 1920, 1941,    0, 1878,    0,    0, 1893,
			    0,    0,    0, 1894,    0, 1966, 1907, 1905,    0, 1920,
			    0,    0, 1952, 1980, 2374, 2374, 1921, 1970, 1974,    0,
			 1931,    0, 1935, 1953,    0,    0,   87, 2374,    0, 1969,
			 1952, 1953, 1954, 1955,    0, 2374, 2374, 2069, 2087, 2105,
			 2123, 2141, 2159, 2011, 2177, 2032, 2195, 2213, 2231, 2249,
			 2267, 2285, 2303, 1663, 1999, 2319, 2004, 2022, 2337, 2355, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		once
			Result := yy_fixed_array (<<
			    0,  746,    1,  747,  747,  748,  748,  749,  749,  750,
			  750,  751,  751,  746,  746,  746,  746,  746,  752,  753,
			  746,  754,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  756,  746,  746,  746,  757,  757,  746,  746,  758,  759,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  752,  746,  760,  761,  752,  752,  752,  752,  752,  752,

			  752,  752,  752,  752,  752,  752,  752,  752,  752,  752,
			  752,  752,  752,  752,  752,  752,  753,  762,  762,  762,
			  762,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  763,  763,
			  764,  746,  746,  746,  746,  746,  746,  746,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  746,  746,  746,  746,  746,  746,  746,

			  746,  756,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  757,  746,  746,  757,
			  758,  746,  759,  746,  746,  746,  746,  765,  746,  746,
			  760,  761,  746,  746,  746,  746,  752,  746,  752,  746,
			  752,  752,  752,  752,  752,  752,  752,  746,  752,  752,
			  746,  752,  752,  752,  752,  752,  752,  752,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,

			  746,  762,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  763,  763,  763,  764,  746,  746,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  765,  765,  761,  746,  746,  746,  752,  752,  752,  752,

			  746,  752,  746,  746,  746,  752,  752,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  763,  763,  316,
			  764,  746,  746,  746,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,

			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  746,  746,  765,  752,  746,  752,  746,
			  752,  746,  746,  746,  746,  766,  766,  767,  746,  746,
			  746,  746,  746,  746,  746,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  746,  746,  746,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  746,  765,  752,  752,
			  752,  746,  766,  766,  766,  767,  746,  746,  746,  746,

			  746,  746,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  746,  768,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  746,  765,  752,  752,  752,  746,  592,  746,  766,
			  746,  594,  746,  767,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  746,  769,  752,
			  752,  752,  746,  746,  746,  746,  746,  746,  746,  746,

			  746,  746,  746,  746,  746,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  746,  755,  755,  755,  755,
			  755,  755,  746,  752,  746,  746,  746,  746,  746,  755,
			  755,  755,  746,  755,  755,  755,  746,  746,  755,  746,
			  755,  746,  755,  746,  755,  746,    0,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,

			   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,    1,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   96,   96,   97,   97,   97,   97,   97,   97,

			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   98,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  100,  101,  101,
			   96,  102,  102,  102,  103,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    4,    3,    3,    5,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    6,    6,    7,    8,    3,    3,    3,    3,    3,    3,
			    3,    6,    6,    6,    6,    6,    6,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,   10,   11,    3,    3,    3,
			    3,   12,    3,    6,    6,    6,    6,    6,    6,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,   13,   14,    3,
			    3,   15,   16,   17,   17,   17,   18,    1,    1,    1,

			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    2,    3,    4,    5,
			    5,    5,    5,    5,    6,    8,   11,   13,   16,   19,
			   22,   25,   28,   31,   34,   37,   40,   43,   46,   49,
			   52,   55,   58,   61,   64,   67,   70,   73,   76,   79,
			   82,   85,   88,   91,   94,   97,  100,  103,  106,  109,
			  112,  115,  118,  121,  124,  127,  130,  133,  135,  138,
			  141,  144,  147,  150,  152,  154,  156,  158,  160,  162,
			  164,  166,  168,  170,  172,  174,  176,  178,  180,  182,
			  184,  186,  188,  190,  192,  194,  197,  199,  201,  202,
			  202,  203,  204,  205,  205,  206,  207,  208,  209,  210,

			  211,  212,  213,  214,  215,  216,  218,  219,  220,  222,
			  223,  224,  225,  226,  227,  228,  229,  230,  231,  232,
			  233,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  235,  236,  237,  238,  239,  240,  241,  242,  243,  243,
			  243,  243,  243,  244,  245,  246,  247,  248,  249,  250,
			  251,  252,  253,  254,  256,  257,  258,  259,  260,  261,
			  262,  263,  265,  266,  267,  268,  269,  270,  271,  273,
			  274,  275,  277,  278,  279,  280,  281,  282,  283,  285,
			  286,  287,  288,  289,  290,  291,  292,  293,  294,  295,
			  296,  297,  298,  299,  300,  301,  301,  301,  301,  301,

			  301,  301,  302,  303,  303,  304,  305,  306,  307,  308,
			  308,  309,  310,  311,  312,  313,  314,  315,  316,  317,
			  318,  319,  320,  321,  322,  323,  324,  325,  326,  327,
			  328,  329,  331,  332,  333,  333,  334,  335,  336,  337,
			  339,  341,  342,  344,  346,  348,  350,  351,  353,  354,
			  356,  357,  358,  359,  360,  361,  362,  363,  364,  365,
			  366,  368,  369,  370,  371,  372,  373,  374,  375,  376,
			  378,  378,  378,  378,  378,  378,  378,  378,  379,  380,
			  381,  382,  383,  384,  385,  386,  387,  388,  389,  390,
			  391,  392,  393,  394,  395,  396,  397,  398,  399,  400,

			  402,  403,  404,  404,  404,  404,  404,  404,  404,  405,
			  405,  406,  407,  407,  408,  410,  411,  413,  414,  415,
			  415,  416,  417,  418,  420,  422,  423,  424,  425,  426,
			  427,  428,  429,  430,  431,  432,  433,  435,  436,  437,
			  438,  439,  440,  441,  442,  443,  444,  445,  446,  447,
			  448,  449,  450,  452,  453,  455,  456,  457,  458,  459,
			  460,  461,  462,  463,  464,  465,  466,  467,  468,  469,
			  470,  471,  472,  473,  474,  475,  476,  477,  478,  480,
			  480,  480,  480,  480,  480,  480,  480,  480,  480,  481,
			  481,  482,  483,  483,  485,  487,  489,  490,  491,  492,

			  493,  495,  496,  498,  500,  502,  503,  504,  504,  504,
			  504,  504,  504,  504,  505,  506,  507,  508,  509,  510,
			  511,  512,  513,  514,  515,  516,  517,  518,  519,  520,
			  521,  522,  523,  524,  525,  526,  527,  529,  529,  529,
			  530,  530,  531,  532,  532,  532,  533,  534,  534,  534,
			  534,  534,  534,  535,  536,  537,  538,  539,  540,  541,
			  542,  543,  544,  545,  546,  547,  548,  549,  550,  552,
			  553,  554,  555,  556,  557,  558,  560,  561,  562,  563,
			  564,  565,  566,  567,  569,  570,  572,  574,  575,  577,
			  579,  580,  581,  582,  583,  584,  585,  586,  587,  588,

			  589,  590,  591,  593,  594,  596,  598,  599,  600,  601,
			  602,  603,  605,  607,  608,  608,  609,  610,  612,  613,
			  615,  616,  618,  618,  618,  619,  619,  619,  619,  620,
			  620,  621,  621,  622,  623,  624,  625,  627,  629,  630,
			  631,  632,  634,  636,  637,  638,  639,  641,  642,  643,
			  644,  645,  646,  647,  648,  650,  651,  652,  653,  654,
			  656,  657,  658,  659,  661,  662,  662,  663,  663,  664,
			  665,  666,  667,  668,  669,  670,  671,  672,  674,  675,
			  676,  678,  680,  681,  682,  684,  685,  685,  686,  687,
			  688,  689,  690,  690,  690,  690,  690,  690,  691,  692,

			  692,  692,  693,  695,  697,  698,  699,  700,  702,  703,
			  704,  705,  706,  708,  710,  711,  713,  714,  715,  717,
			  718,  719,  720,  721,  722,  723,  724,  724,  725,  726,
			  728,  729,  730,  732,  733,  735,  737,  739,  740,  741,
			  743,  744,  744,  745,  746,  747,  748,  748,  748,  748,
			  748,  748,  748,  748,  748,  748,  749,  750,  750,  750,
			  751,  751,  752,  752,  753,  754,  756,  757,  759,  760,
			  761,  762,  763,  765,  767,  768,  770,  772,  773,  774,
			  775,  776,  777,  778,  780,  781,  782,  784,  784,  786,
			  787,  788,  789,  791,  792,  794,  795,  796,  796,  797,

			  797,  798,  799,  799,  799,  800,  802,  803,  805,  807,
			  808,  810,  812,  814,  815,  817,  817,  818,  819,  821,
			  822,  824,  826,  826,  827,  829,  831,  832,  832,  833,
			  835,  836,  838,  838,  839,  841,  843,  843,  845,  847,
			  847,  848,  848,  849,  849,  851,  852,  852, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		once
			Result := yy_fixed_array (<<
			    0,  185,  185,  187,  187,  218,  216,  217,    1,  216,
			  217,    1,  217,   36,  216,  217,  188,  216,  217,   41,
			  216,  217,   14,  216,  217,  154,  216,  217,   24,  216,
			  217,   25,  216,  217,   32,  216,  217,   30,  216,  217,
			    9,  216,  217,   31,  216,  217,   13,  216,  217,   33,
			  216,  217,  118,  216,  217,  118,  216,  217,    8,  216,
			  217,    7,  216,  217,   18,  216,  217,   17,  216,  217,
			   19,  216,  217,   11,  216,  217,  117,  216,  217,  117,
			  216,  217,  117,  216,  217,  117,  216,  217,  117,  216,
			  217,  117,  216,  217,  117,  216,  217,  117,  216,  217,

			  117,  216,  217,  117,  216,  217,  117,  216,  217,  117,
			  216,  217,  117,  216,  217,  117,  216,  217,  117,  216,
			  217,  117,  216,  217,  117,  216,  217,  117,  216,  217,
			   28,  216,  217,  216,  217,   29,  216,  217,   34,  216,
			  217,   26,  216,  217,   27,  216,  217,   12,  216,  217,
			  216,  217,  216,  217,  216,  217,  216,  217,  216,  217,
			  216,  217,  216,  217,  189,  217,  215,  217,  213,  217,
			  214,  217,  185,  217,  185,  217,  184,  217,  183,  217,
			  185,  217,  187,  217,  186,  217,  181,  217,  181,  217,
			  180,  217,    6,  217,    5,    6,  217,    5,  217,    6,

			  217,    1,  188,  177,  188,  188,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188, -396,  188,  188,
			  188, -396,  188,  188,  188,  188,  188,  188,  188,   41,
			  154,  154,  154,  154,    2,   35,   10,  124,   39,   23,
			   22,  124,  118,   15,   37,   20,   21,   38,   16,  117,
			  117,  117,  117,  117,   48,  117,  117,  117,  117,  117,
			  117,  117,  117,   61,  117,  117,  117,  117,  117,  117,
			  117,   73,  117,  117,  117,   80,  117,  117,  117,  117,
			  117,  117,  117,   92,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,   40,

			   42,  189,  213,  206,  204,  205,  207,  208,  209,  210,
			  190,  191,  192,  193,  194,  195,  196,  197,  198,  199,
			  200,  201,  202,  203,  185,  184,  183,  185,  185,  182,
			  183,  187,  186,  180,    5,    4,  178,  175,  178,  188,
			 -396, -396,  162,  178,  160,  178,  161,  178,  163,  178,
			  188,  156,  178,  188,  157,  178,  188,  188,  188,  188,
			  188,  188,  188, -179,  188,  188,  164,  178,  188,  188,
			  188,  188,  188,  188,  188,  154,  125,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,

			  127,  154,  125,  154,  124,  119,  124,  118,  122,  123,
			  123,  121,  123,  120,  118,  117,  117,  117,   46,  117,
			   47,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,   64,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			   84,  117,  117,   87,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  116,  117,
			  212,    4,    4,  165,  178,  158,  178,  159,  178,  188,
			  188,  188,  188,  172,  178,  188,  167,  178,  166,  178,

			  176,  178,  188,  188,  144,  142,  143,  145,  146,  155,
			  155,  147,  148,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  139,  140,  141,  126,  154,  124,
			  124,  124,  124,  118,  118,  118,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			   62,  117,  117,  117,  117,  117,  117,  117,   71,  117,
			  117,  117,  117,  117,  117,  117,  117,   81,  117,  117,
			   83,  117,   85,  117,  117,   90,  117,   91,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  105,  117,  117,  107,  117,  108,  117,  117,  117,

			  117,  117,  117,  114,  117,  115,  117,  211,    4,  188,
			  168,  178,  188,  171,  178,  188,  174,  178,  155,  124,
			  124,  124,  124,  118,  117,   44,  117,   45,  117,  117,
			  117,  117,   52,  117,   53,  117,  117,  117,  117,   58,
			  117,  117,  117,  117,  117,  117,  117,  117,   69,  117,
			  117,  117,  117,  117,   76,  117,  117,  117,  117,   82,
			  117,  117,   88,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  102,  117,  117,  117,  106,  117,  109,  117,
			  117,  117,  112,  117,  117,    4,  188,  188,  188,  149,
			  124,  124,  124,   43,  117,   49,  117,  117,  117,  117,

			   55,  117,  117,  117,  117,  117,   63,  117,   65,  117,
			  117,   67,  117,  117,  117,   72,  117,  117,  117,  117,
			  117,  117,  117,   89,  117,  117,   95,  117,  117,  117,
			   98,  117,  117,  100,  117,  101,  117,  103,  117,  117,
			  117,  111,  117,  117,    4,  188,  188,  188,  124,  124,
			  124,  124,  117,  117,   54,  117,  117,   57,  117,  117,
			  117,  117,  117,   70,  117,   74,  117,  117,   77,  117,
			   78,  117,  117,  117,  117,  117,  117,  117,   99,  117,
			  117,  117,  113,  117,    3,    4,  188,  188,  188,  152,
			  153,  153,  151,  153,  150,  124,  124,  124,  124,  124,

			   50,  117,  117,   56,  117,   59,  117,  117,   66,  117,
			   68,  117,   75,  117,  117,   86,  117,  117,  117,   96,
			  117,  117,  104,  117,  110,  117,  188,  170,  178,  173,
			  178,  124,  124,   51,  117,  117,   79,  117,  117,   94,
			  117,   97,  117,  169,  178,   60,  117,  117,  117,   93,
			  117,   93, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2374
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 746
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 747
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

	yyNb_rules: INTEGER = 217
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 218
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
