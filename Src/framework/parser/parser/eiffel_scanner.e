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
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 213 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 214 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 215 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_as_value (text_substring (3, text_count - 1))
			
when 216 then
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
			
when 217 then
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
			
when 218 then
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
			
when 219 then
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
			
when 220 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line <not available>")
end

				update_character_locations
				report_unknown_token_error (text_item (1))
			
when 221 then
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
			create an_array.make_filled (0, 0, 4057)
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
			  833,   77,   77,  198,   78,   78,   80,   81,   80,   80,
			  154,   82,   80,   81,   80,   80,  205,   82,   91,   92,
			   91,   91,  167,  168,   91,   92,   91,   91,  169,  170,
			   98,   99,   98,   98,  203,  198,   98,   99,   98,   98,
			  184,  212,  105,  105,  105,  105,  100,  833,  205,  213,
			  185,  204,  100,  105,  105,  105,  105,  155,  106,  156,
			  156,  156,  156,  214,   83,  196,  203,  157,  215,  106,
			   83,  197,  184,  212,  160,  158,  161,  161,  161,  161, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  833,  213,  185,  204,  216,  218,  218,  218,  218,  218,
			  218,  218,  219,  218,  218,  214,   83,  196,  283,  284,
			  215,  858,   83,  197,  220,  220,  220,  261,  369,   84,
			  855,  262,   85,   86,   87,   84,  216,  165,   85,   86,
			   87,   93,  293,  294,   94,   95,   96,   93,  297,  298,
			   94,   95,   96,  101,  833,  303,  102,  103,  104,  101,
			  159,  758,  102,  103,  104,  107,  699,  390,  108,  109,
			  110,  230,  230,  230,  230,  813,  107,  468,  469,  108,
			  109,  110,  112,  113,  812,  114,  113,  303,  115,  811,
			  116,  117,  189,  118,  261,  119,  190,  261,  269,  390,

			  810,  262,  120,  759,  121,  806,  113,  122,  160,  191,
			  161,  161,  161,  161,  186,  123,  187,  371,  371,  371,
			  124,  125,  162,  163,  189,  179,  188,  206,  190,  180,
			  126,  391,  181,  127,  128,  182,  129,  207,  183,  122,
			  392,  191,  208,  393,  164,  394,  186,  123,  187,  283,
			  284,  165,  124,  125,  162,  163,  261,  179,  188,  206,
			  262,  180,  126,  391,  181,  130,  113,  182,  395,  207,
			  183,  667,  392,  667,  208,  393,  164,  394,  293,  294,
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
			  211,  465,  466,  466,  466,  173,  396,  261,  397,  174,
			  192,  269,  692,  692,  175,  199,  176,  193,  194,  209,
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
			  233,  233,  233,  667,  234,  410,  667,  235,  261,  236,
			  237,  238,  262,  263,  261,  263,  263,  239,  262,  261,
			  766,  261,  760,  262,  240,  262,  241,  737,  738,  242,
			  243,  244,  245,  739,  246,  300,  247,  410,  114,  736, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  248,  305,  249,  667,  114,  250,  251,  252,  253,  254,
			  255,  276,  277,  276,  276,  369,  735,  286,  286,  286,
			  286,  699,  767,  286,  286,  286,  286,  388,  388,  388,
			  388,  264,  105,  105,  105,  105,  695,  411,  300,  306,
			  380,  114,  114,  611,  307,  304,  130,  114,  106,  276,
			  276,  276,  130,  310,  312,  408,  114,  114,  276,  409,
			  412,  413,  256,  264,  270,  257,  258,  259,  389,  411,
			  271,  272,  273,  233,  311,  313,  265,  233,  130,  266,
			  267,  268,  327,  308,  130,  114,  114,  408,  233,  130,
			  130,  409,  412,  413,  527,  130,  309,  373,  373,  373,

			  373,  373,  373,  373,  130,  130,  300,  526,  300,  114,
			  300,  114,  300,  114,  278,  114,  525,  279,  280,  281,
			  287,  130,  130,  288,  289,  290,  287,  130,  419,  288,
			  289,  290,  422,  130,  130,  107,  130,  130,  108,  109,
			  110,  111,  111,  315,  111,  111,  314,  301,  300,  316,
			  114,  114,  856,  857,  317,  524,  420,  130,  406,  130,
			  419,  130,  423,  130,  422,  130,  130,  770,  421,  319,
			  320,  319,  319,  407,  300,  315,  369,  114,  314,  424,
			  523,  316,  378,  378,  378,  378,  317,  318,  420,  130,
			  406,  130,  425,  130,  423,  130,  427,  379,  302,  130, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  421,  426,  369,  522,  261,  407,  521,  300,  262,  771,
			  114,  424,  319,  320,  319,  319,  520,  300,  300,  318,
			  114,  114,  519,  518,  425,  130,  517,  321,  427,  379,
			  302,  130,  516,  426,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  130,  130,  326,
			  428,  437,  375,  375,  375,  375,  375,  375,  130,  130,
			  300,  438,  322,  114,  515,  323,  324,  325,  514,  513,
			  300,  512,  509,  114,  377,  377,  377,  377,  508,  507,
			  130,  439,  428,  437,  300,  271,  272,  114,  506,  505,

			  130,  130,  440,  438,  441,  328,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  322,  105,  105,  323,  324,
			  325,  130,  445,  439,  435,  446,  105,  300,  436,  447,
			  114,  130,  286,  261,  440,  261,  441,  262,  261,  262,
			  286,  300,  262,  286,  114,  130,  160,  448,  383,  383,
			  383,  383,  472,  130,  445,  300,  435,  446,  114,  337,
			  436,  447,  295,  130,  329,  329,  329,  330,  330,  330,
			  330,  330,  330,  330,  330,  330,  330,  130,  130,  448,
			  547,  331,  331,  331,  331,  331,  331,  331,  300,  165,
			  292,  114,  130,  338,  338,  339,  340,  340,  340,  340, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  341,  342,  343,  344,  345,  261,  130,  261,  286,  262,
			  130,  262,  547,  276,  332,  332,  332,  332,  332,  332,
			  332,  332,  332,  332,  130,  276,  273,  276,  285,  263,
			  282,  263,  333,  333,  333,  333,  333,  333,  130,  130,
			  368,  548,  334,  334,  334,  334,  334,  334,  334,  334,
			  334,  334,  338,  338,  339,  340,  340,  340,  340,  341,
			  342,  343,  344,  345,  369,  442,  498,  498,  498,  276,
			  443,  130,  275,  548,  369,  335,  335,  335,  335,  346,
			  549,  444,  347,  470,  348,  349,  350,  550,  467,  286,
			  286,  286,  351,  220,  220,  220,  263,  442,  286,  352,

			  233,  353,  443,  270,  354,  355,  356,  357,  369,  358,
			  232,  359,  549,  444,  369,  360,  299,  361,  369,  550,
			  362,  363,  364,  365,  366,  367,  500,  500,  500,  500,
			  500,  500,  500,  338,  338,  339,  340,  340,  340,  340,
			  341,  342,  343,  344,  345,  296,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  372,  372,  372,  372,
			  372,  372,  372,  372,  372,  372,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  105,  338,  338,  339,
			  340,  340,  340,  340,  341,  342,  343,  344,  345,  553,
			  374,  374,  374,  374,  374,  374,  374,  374,  374,  374, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  380,  153,  381,  381,  381,  381,  295,  384,  384,  385,
			  385,  553,  292,  386,  386,  386,  385,  382,  385,  385,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,
			  387,  387,  387,  387,  261,  286,  554,  291,  262,  285,
			  282,  387,  387,  387,  387,  387,  387,  555,  276,  382,
			  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,
			  385,  385,  402,  105,  105,  105,  403,  414,  554,  415,
			  275,  416,  105,  387,  387,  387,  387,  387,  387,  555,
			  404,  556,  417,  557,  558,  418,  105,  105,  105,  105,

			  504,  504,  504,  504,  402,  429,  559,  430,  403,  414,
			  232,  415,  106,  416,  560,  431,  561,  562,  432,  565,
			  433,  434,  404,  556,  417,  557,  558,  418,  502,  502,
			  502,  502,  502,  502,  693,  693,  693,  429,  559,  430,
			  217,  263,  510,  511,  511,  511,  560,  431,  561,  562,
			  432,  565,  433,  434,  449,  449,  450,  451,  451,  451,
			  451,  452,  453,  454,  455,  456,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  219,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  219,  219,  219,  218,
			  218,  218,  218,  218,  218,  219,  171,  166,  870,  457, yy_Dummy>>,
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
			  463,  233,  233,  233,  233,  478,   89,   89,  114,  464,
			  263,  261,  263,  263,  479,  262,  870,  114,  480,  261,

			  870,  114,  566,  262,  276,  277,  276,  276,  870,  870,
			  286,  286,  286,  286,  230,  230,  230,  230,  481,  300,
			  870,  114,  114,  870,  567,  870,  473,  320,  473,  473,
			  870,  568,  300,  870,  566,  114,  130,  546,  546,  546,
			  546,  485,  570,  486,  569,  130,  114,  482,  264,  130,
			  870,  870,  319,  320,  319,  319,  567,  300,  488,  870,
			  114,  114,  160,  568,  539,  539,  539,  539,  130,  130,
			  130,  870,  483,  870,  570,  870,  569,  130,  389,  482,
			  264,  130,  303,  130,  256,  870,  870,  257,  258,  259,
			  263,  263,  263,  265,  130,  870,  266,  267,  268,  263, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  870,  130,  130,  300,  483,  165,  114,  278,  130,  130,
			  279,  280,  281,  287,  303,  130,  288,  289,  290,  111,
			  319,  320,  319,  319,  300,  301,  130,  114,  114,  474,
			  870,  551,  475,  476,  477,  532,  532,  532,  532,  571,
			  130,  130,  572,  870,  870,  573,  574,  484,  552,  575,
			  379,  576,  870,  300,  130,  322,  114,  870,  323,  324,
			  325,  870,  533,  551,  533,  870,  487,  534,  534,  534,
			  534,  571,  870,  577,  572,  130,  302,  573,  574,  484,
			  552,  575,  379,  576,  300,  870,  130,  114,  300,  493,
			  300,  114,  114,  114,  233,  233,  233,  494,  487,  870,

			  114,  870,  870,  233,  130,  577,  578,  130,  302,  870,
			  870,  579,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  322,  111,  111,  323,  324,  325,  111,
			  111,  111,  111,  111,  111,  130,  130,  580,  578,  130,
			  130,  130,  300,  579,  537,  114,  537,  319,  130,  538,
			  538,  538,  538,  581,  582,  583,  300,  870,  586,  114,
			  870,  870,  587,  534,  534,  534,  534,  130,  870,  580,
			  870,  130,  130,  130,  870,  492,  489,  490,  491,  544,
			  130,  545,  545,  545,  545,  581,  582,  583,  870,  300,
			  586,  870,  114,  130,  587,  131,  131,  132,  133,  133, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  133,  133,  134,  135,  136,  137,  138,  130,  300,  588,
			  563,  114,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  389,  300,  564,  130,  114,  870,  870,  328,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  130,
			  130,  588,  563,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  870,  300,  584,  564,  114,  585,  130,
			  499,  499,  499,  499,  499,  499,  499,  499,  499,  499,
			  300,  870,  130,  114,  130,  589,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  528,  584,  592,  870,
			  585,  130,  870,  870,  870,  328,  328,  328,  328,  328,

			  328,  328,  328,  328,  328,  130,  130,  589,  593,  870,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
			  592,  130,  501,  501,  501,  501,  501,  501,  501,  501,
			  501,  501,  534,  534,  534,  534,  870,  130,  870,  870,
			  593,  496,  496,  496,  496,  496,  496,  496,  496,  496,
			  496,  870,  870,  130,  870,  870,  870,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  503,  503,  503,
			  503,  503,  503,  503,  503,  503,  503,  870,  870,  338,
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
			  370,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  530,  530,  530,  530,  530,  530,  530,  530,  530,
			  530,  531,  531,  531,  531,  531,  531,  531,  531,  531,
			  531,  535,  535,  535,  535,  870,  384,  384,  385,  385,
			  590,  594,  595,  596,  597,  870,  536,  385,  385,  385,
			  385,  385,  385,  385,  385,  385,  385,  598,  591,  599,
			  600,  601,  870,  602,  385,  385,  385,  385,  385,  385,

			  870,  870,  590,  594,  595,  596,  597,  540,  536,  385,
			  385,  385,  385,  385,  385,  538,  538,  538,  538,  598,
			  591,  599,  600,  601,  541,  602,  385,  385,  385,  385,
			  385,  385,  386,  386,  386,  385,  603,  604,  605,  538,
			  538,  538,  538,  385,  385,  385,  385,  385,  385,  387,
			  387,  387,  387,  226,  226,  226,  226,  226,  226,  226,
			  387,  387,  387,  387,  387,  387,  870,  870,  603,  604,
			  605,  870,  870,  542,  870,  385,  385,  385,  385,  385,
			  385,  228,  228,  228,  228,  228,  228,  870,  870,  870,
			  543,  870,  387,  387,  387,  387,  387,  387,  218,  218, yy_Dummy>>,
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

			  218,  218,  218,  218,  218,  218,  218,  218,  606,  466,
			  466,  466,  466,  606,  466,  466,  466,  466,  870,  303,
			  303,  607,  608,  473,  320,  473,  473,  303,  870,  616,
			  870,  617,  300,  303,  114,  114,  619,  300,  621,  114,
			  114,  114,  637,  609,  300,  300,  638,  114,  114,  639,
			  610,  303,  303,  607,  608,  610,  870,  300,  870,  303,
			  114,  612,  473,  613,  614,  303,  620,  300,  618,  615,
			  114,  640,  870,  300,  637,  609,  114,  641,  638,  303,
			  642,  639,  130,  130,  643,  644,  870,  130,  130,  130,
			  300,  645,  870,  114,  870,  130,  130,  870,  620,  870, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  618,  646,  647,  640,  300,  870,  648,  114,  130,  641,
			  649,  303,  642,  870,  130,  130,  643,  644,  130,  130,
			  130,  130,  870,  645,  130,  650,  474,  130,  130,  475,
			  476,  477,  319,  646,  647,  692,  692,  319,  648,  651,
			  130,  130,  649,  652,  319,  319,  319,  754,  692,  692,
			  130,  870,  870,  319,  319,  130,  130,  650,  653,  870,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  328,
			  870,  651,  870,  130,  870,  652,  755,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  328,  130,  870,  755,
			  653,  328,  328,  328,  328,  328,  328,  328,  328,  328,

			  328,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  622,  622,  622,  622,  622,  622,  622,  622,  622,
			  622,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  624,  624,  624,  624,  624,  624,  624,  624,  624,
			  624,  625,  511,  511,  511,  511,  625,  511,  511,  511,
			  511,  870,  654,  655,  626,  627,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  370,  370,  370,  370,  370,  370,  628,  656,  657,  658,
			  659,  660,  870,  629,  654,  655,  626,  627,  629,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  630,
			  630,  630,  630,  632,  632,  632,  632,  661,  628,  656,
			  657,  658,  659,  660,  379,  633,  662,  633,  536,  663,
			  634,  634,  634,  634,  635,  870,  539,  539,  539,  539,
			  664,  665,  544,  666,  636,  636,  636,  636,  870,  661,
			  631,  384,  384,  385,  385,  674,  379,  675,  662,  676,
			  536,  663,  385,  385,  385,  385,  385,  385,  385,  385,
			  385,  385,  664,  665,  677,  666,  678,  389,  679,  385,

			  385,  385,  385,  385,  385,  389,  870,  674,  870,  675,
			  870,  676,  540,  870,  385,  385,  385,  385,  385,  385,
			  544,  870,  546,  546,  546,  546,  677,  680,  678,  541,
			  679,  385,  385,  385,  385,  385,  385,  386,  386,  386,
			  385,  681,  667,  667,  667,  667,  870,  668,  385,  385,
			  385,  385,  385,  385,  387,  387,  387,  387,  669,  680,
			  682,  683,  684,  389,  685,  387,  387,  387,  387,  387,
			  387,  686,  687,  681,  688,  689,  690,  691,  542,  870,
			  385,  385,  385,  385,  385,  385,  466,  466,  466,  466,
			  870,  870,  682,  683,  684,  543,  685,  387,  387,  387, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  387,  387,  387,  686,  687,  303,  688,  689,  690,  691,
			  694,  694,  694,  694,  706,  706,  706,  706,  870,  303,
			  711,  694,  694,  694,  694,  694,  694,  610,  303,  870,
			  668,  303,  300,  870,  870,  114,  300,  303,  712,  114,
			  713,  473,  714,  300,  870,  670,  114,  870,  671,  672,
			  673,  303,  711,  694,  694,  694,  694,  694,  694,  870,
			  303,  473,  870,  303,  473,  473,  473,  473,  715,  697,
			  712,  716,  713,  473,  714,  717,  696,  718,  719,  698,
			  720,  721,  722,  130,  723,  724,  725,  130,  634,  634,
			  634,  634,  726,  727,  130,  634,  634,  634,  634,  870,

			  715,  697,  870,  716,  870,  870,  870,  717,  696,  718,
			  719,  698,  720,  721,  722,  130,  723,  724,  725,  130,
			  704,  704,  704,  704,  726,  727,  130,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  700,  700,  701,
			  701,  629,  870,  702,  702,  702,  701,  870,  701,  701,
			  701,  701,  701,  701,  701,  701,  701,  701,  701,  701,
			  703,  703,  703,  703,  630,  630,  630,  630,  728,  729,
			  730,  703,  703,  703,  703,  703,  703,  870,  870,  705, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  701,  701,  701,  701,  701,  701,  701,  701,  701,  701,
			  701,  701,  731,  732,  707,  707,  707,  707,  733,  870,
			  728,  729,  730,  703,  703,  703,  703,  703,  703,  536,
			  380,  705,  707,  707,  707,  707,  740,  710,  741,  546,
			  546,  546,  546,  742,  731,  732,  743,  709,  870,  744,
			  733,  667,  667,  667,  667,  708,  734,  745,  746,  747,
			  748,  536,  749,  750,  751,  752,  753,  669,  740,  782,
			  741,  756,  693,  693,  693,  742,  870,  870,  743,  709,
			  165,  744,  300,  300,  783,  114,  114,  870,  870,  745,
			  746,  747,  748,  870,  749,  750,  751,  752,  753,  300,

			  784,  782,  114,  764,  700,  700,  768,  702,  702,  702,
			  870,  785,  762,  757,  761,  786,  783,  787,  772,  704,
			  704,  704,  704,  773,  788,  773,  870,  870,  774,  774,
			  774,  774,  784,  130,  130,  778,  778,  778,  778,  734,
			  789,  870,  763,  785,  762,  765,  761,  786,  769,  787,
			  130,  870,  870,  790,  670,  870,  788,  671,  672,  673,
			  629,  775,  775,  775,  775,  130,  130,  791,  707,  707,
			  707,  707,  789,  779,  763,  779,  776,  792,  780,  780,
			  780,  780,  130,  777,  380,  790,  778,  778,  778,  778,
			  793,  794,  795,  796,  797,  667,  667,  667,  798,  791, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  799,  781,  800,  801,  667,  802,  803,  804,  776,  792,
			  805,  693,  693,  693,  870,  777,  870,  300,  300,  870,
			  114,  114,  793,  794,  795,  796,  797,  833,  833,  833,
			  798,  870,  799,  781,  800,  801,  833,  802,  803,  804,
			  870,  870,  805,  694,  694,  694,  694,  807,  300,  870,
			  870,  114,  757,  823,  694,  694,  694,  694,  694,  694,
			  808,  774,  774,  774,  774,  824,  825,  870,  130,  130,
			  774,  774,  774,  774,  826,  827,  828,  809,  829,  807,
			  814,  814,  814,  814,  759,  823,  694,  694,  694,  694,
			  694,  694,  808,  830,  831,  776,  832,  824,  825,  130,

			  130,  130,  700,  700,  701,  701,  826,  827,  828,  809,
			  829,  870,  839,  701,  701,  701,  701,  701,  701,  870,
			  840,  701,  701,  701,  701,  830,  831,  776,  832,  841,
			  870,  130,  701,  701,  701,  701,  701,  701,  780,  780,
			  780,  780,  842,  765,  839,  701,  701,  701,  701,  701,
			  701,  815,  840,  815,  870,  870,  816,  816,  816,  816,
			  870,  841,  767,  870,  701,  701,  701,  701,  701,  701,
			  702,  702,  702,  701,  842,  870,  819,  819,  819,  819,
			  843,  701,  701,  701,  701,  701,  701,  703,  703,  703,
			  703,  820,  780,  780,  780,  780,  870,  870,  703,  703, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  703,  703,  703,  703,  870,  833,  833,  833,  833,  870,
			  870,  769,  843,  701,  701,  701,  701,  701,  701,  817,
			  870,  817,  870,  820,  818,  818,  818,  818,  771,  776,
			  703,  703,  703,  703,  703,  703,  821,  834,  821,  870,
			  870,  822,  822,  822,  822,  300,  845,  846,  114,  114,
			  114,  816,  816,  816,  816,  631,  816,  816,  816,  816,
			  870,  776,  818,  818,  818,  818,  870,  870,  870,  834,
			  818,  818,  818,  818,  847,  847,  847,  847,  850,  848,
			  870,  848,  851,  844,  849,  849,  849,  849,  852,  820,
			  822,  822,  822,  822,  854,  859,  130,  130,  130,  822,

			  822,  822,  822,  833,  833,  833,  833,  860,  835,  862,
			  850,  836,  837,  838,  851,  844,  820,  863,  864,  861,
			  852,  820,  114,  865,  866,  867,  854,  859,  130,  130,
			  130,  849,  849,  849,  849,  853,  868,  869,  870,  860,
			  870,  862,  708,  849,  849,  849,  849,  870,  820,  863,
			  864,  870,  870,  870,  870,  865,  866,  867,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  853,  868,  869,
			  130,  139,  870,  870,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  694,  694,  694,  694,
			  870,  870,  870,  694,  701,  701,  701,  701,  870,  870, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  870,  701,  130,  870,  870,  870,  835,  870,  870,  836,
			  837,  838,   75,   75,   75,   75,   75,   75,   75,   75,
			   75,   75,   75,   75,   75,   75,   75,   75,   75,   75,
			   75,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,

			   97,   97,   97,   97,   97,   97,   97,  111,  870,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  231,  870,  231,  231,  870,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  260,  260,  260,  260,  260,  260,
			  260,  260,  260,  260,  260,  260,  260,  260,  260,  260,
			  260,  260,  260,  264,  264,  264,  264,  264,  264,  264,
			  264,  264,  264,  264,  264,  264,  264,  264,  264,  264, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  264,  264,  274,  274,  274,  274,  274,  274,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  274,  274,  274,
			  274,  113,  870,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  114,  870,  114,  870,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  471,  870,  471,  471,
			  471,  471,  471,  471,  471,  471,  471,  471,  471,  471,
			  471,  471,  471,  471,  471,  703,  703,  703,  703,  870,

			  870,  870,  703,  735,  735,  735,  735,  735,  735,  735,
			  735,  735,  735,  735,  735,  735,  735,  735,  735,  735,
			  735,  735,  806,  870,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,   13,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870, yy_Dummy>>,
			1, 58, 4000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4057)
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
			  858,    3,    4,   46,    3,    4,    5,    5,    5,    5,
			   27,    5,    6,    6,    6,    6,   49,    6,    9,    9,
			    9,    9,   34,   34,   10,   10,   10,   10,   36,   36,
			   11,   11,   11,   11,   48,   46,   12,   12,   12,   12,
			   41,   52,   15,   15,   15,   15,   11,  857,   49,   53,
			   41,   48,   12,   16,   16,   16,   16,   28,   15,   28,
			   28,   28,   28,   53,    5,   45,   48,   29,   54,   16,
			    6,   45,   41,   52,   31,   29,   31,   31,   31,   31, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  855,   53,   41,   48,   55,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   53,    5,   45,   95,   95,
			   54,  838,    6,   45,   65,   65,   65,   79,  146,    5,
			  836,   79,    5,    5,    5,    6,   55,   31,    6,    6,
			    6,    9,  103,  103,    9,    9,    9,   10,  109,  109,
			   10,   10,   10,   11,  835,  114,   11,   11,   11,   12,
			   29,  694,   12,   12,   12,   15,  772,  173,   15,   15,
			   15,   74,   74,   74,   74,  770,   16,  258,  258,   16,
			   16,   16,   18,   18,  768,   18,   18,  114,   18,  766,
			   18,   18,   43,   18,   83,   18,   43,   84,   83,  173,

			  764,   84,   18,  694,   18,  760,   18,   18,   30,   43,
			   30,   30,   30,   30,   42,   18,   42,  146,  146,  146,
			   18,   18,   30,   30,   43,   40,   42,   50,   43,   40,
			   18,  174,   40,   18,   18,   40,   18,   50,   40,   18,
			  175,   43,   50,  175,   30,  176,   42,   18,   42,  280,
			  280,   30,   18,   18,   30,   30,  260,   40,   42,   50,
			  260,   40,   18,  174,   40,   18,   18,   40,  177,   50,
			   40,  739,  175,  738,   50,  175,   30,  176,  289,  289,
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
			   44,  264,  607,  607,   38,   47,   38,   44,   44,   51,
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
			   78,   78,   78,  736,   78,  189,  735,   78,   85,   78,
			   78,   78,   85,   80,   80,   80,   80,   78,   80,   86,
			  701,   87,  695,   86,   78,   87,   78,  672,  672,   78,
			   78,   78,   78,  673,   78,  111,   78,  189,  111,  671, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   78,  116,   78,  670,  116,   78,   78,   78,   78,   78,
			   78,   91,   91,   91,   91,  148,  669,   98,   98,   98,
			   98,  625,  701,   99,   99,   99,   99,  165,  165,  165,
			  165,   80,  105,  105,  105,  105,  611,  190,  115,  117,
			  544,  115,  117,  472,  118,  115,  111,  118,  105,  283,
			  283,  283,  116,  120,  121,  188,  120,  121,  283,  188,
			  191,  193,   78,   80,   85,   78,   78,   78,  165,  190,
			   86,   86,   87,  470,  120,  121,   80,  469,  111,   80,
			   80,   80,  129,  119,  116,  129,  119,  188,  467,  115,
			  117,  188,  191,  193,  367,  118,  119,  148,  148,  148,

			  148,  148,  148,  148,  120,  121,  123,  366,  122,  123,
			  124,  122,  125,  124,   91,  125,  365,   91,   91,   91,
			   98,  115,  117,   98,   98,   98,   99,  118,  196,   99,
			   99,   99,  198,  129,  119,  105,  120,  121,  105,  105,
			  105,  113,  113,  123,  113,  113,  122,  113,  126,  124,
			  113,  126,  837,  837,  125,  364,  197,  123,  187,  122,
			  196,  124,  199,  125,  198,  129,  119,  703,  197,  127,
			  127,  127,  127,  187,  127,  123,  150,  127,  122,  200,
			  363,  124,  156,  156,  156,  156,  125,  126,  197,  123,
			  187,  122,  201,  124,  199,  125,  203,  156,  113,  126, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  197,  201,  152,  362,  267,  187,  361,  128,  267,  703,
			  128,  200,  130,  130,  130,  130,  360,  130,  131,  126,
			  130,  131,  359,  358,  201,  127,  357,  127,  203,  156,
			  113,  126,  356,  201,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  127,  128,  128,
			  204,  207,  150,  150,  150,  150,  150,  150,  130,  131,
			  132,  208,  127,  132,  355,  127,  127,  127,  354,  353,
			  133,  352,  350,  133,  152,  152,  152,  152,  349,  348,
			  128,  209,  204,  207,  134,  267,  267,  134,  347,  346,

			  130,  131,  210,  208,  211,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  130,  299,  298,  130,  130,
			  130,  132,  213,  209,  206,  214,  296,  135,  206,  215,
			  135,  133,  295,  265,  210,  268,  211,  265,  270,  268,
			  294,  136,  270,  292,  136,  134,  161,  216,  161,  161,
			  161,  161,  291,  132,  213,  137,  206,  214,  137,  140,
			  206,  215,  290,  133,  132,  132,  132,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  134,  135,  216,
			  390,  134,  134,  134,  134,  134,  134,  134,  138,  161,
			  288,  138,  136,  141,  141,  141,  141,  141,  141,  141, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  141,  141,  141,  141,  141,  273,  137,  266,  287,  273,
			  135,  266,  390,  285,  135,  135,  135,  135,  135,  135,
			  135,  135,  135,  135,  136,  284,  268,  282,  281,  270,
			  279,  265,  136,  136,  136,  136,  136,  136,  137,  138,
			  143,  391,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  145,  212,  339,  339,  339,  278,
			  212,  138,  274,  391,  147,  138,  138,  138,  138,  142,
			  392,  212,  142,  259,  142,  142,  142,  395,  257,  293,
			  293,  293,  142,  450,  450,  450,  273,  212,  293,  142,

			  256,  142,  212,  266,  142,  142,  142,  142,  149,  142,
			  231,  142,  392,  212,  144,  142,  110,  142,  151,  395,
			  142,  142,  142,  142,  142,  142,  341,  341,  341,  341,
			  341,  341,  341,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  108,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  220,  220,  220,  220,
			  220,  220,  220,  220,  220,  220,  107,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  397,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  149, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  160,  106,  160,  160,  160,  160,  104,  162,  162,  162,
			  162,  397,  102,  163,  163,  163,  163,  160,  162,  162,
			  162,  162,  162,  162,  163,  163,  163,  163,  163,  163,
			  164,  164,  164,  164,  272,  101,  398,  100,  272,   96,
			   94,  164,  164,  164,  164,  164,  164,  399,   93,  160,
			  162,  162,  162,  162,  162,  162,  163,  163,  163,  163,
			  163,  163,  184,  297,  297,  297,  184,  194,  398,  194,
			   88,  194,  297,  164,  164,  164,  164,  164,  164,  399,
			  184,  400,  194,  401,  402,  194,  219,  219,  219,  219,

			  345,  345,  345,  345,  184,  205,  403,  205,  184,  194,
			   75,  194,  219,  194,  404,  205,  405,  407,  205,  409,
			  205,  205,  184,  400,  194,  401,  402,  194,  343,  343,
			  343,  343,  343,  343,  608,  608,  608,  205,  403,  205,
			   57,  272,  351,  351,  351,  351,  404,  205,  405,  407,
			  205,  409,  205,  205,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  218,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,   37,   32,   13,  219, yy_Dummy>>,
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
			  230,  233,  233,  233,  233,  304,    8,    7,  304,  233,
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
			  324,  325,  326,  324,  468,  468,  468,  328,  318,    0,

			  328,    0,    0,  468,  322,  420,  421,  318,  302,    0,
			    0,  422,  302,  302,  302,  302,  302,  302,  302,  302,
			  302,  302,  302,  302,  302,  302,  302,  302,  302,  302,
			  302,  302,  302,  302,  302,  323,  322,  423,  421,  325,
			  326,  324,  329,  422,  382,  329,  382,  322,  328,  382,
			  382,  382,  382,  425,  426,  427,  330,    0,  429,  330,
			    0,    0,  430,  533,  533,  533,  533,  323,    0,  423,
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
			  342,  342,  534,  534,  534,  534,    0,  334,    0,    0,
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
			  384,  384,  384,  384,  384,  537,  537,  537,  537,  440,
			  433,  441,  442,  443,  385,  444,  385,  385,  385,  385,
			  385,  385,  386,  386,  386,  386,  445,  446,  447,  538,
			  538,  538,  538,  386,  386,  386,  386,  386,  386,  387,
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

			  463,  463,  463,  463,  463,  463,  463,  463,  465,  465,
			  465,  465,  465,  466,  466,  466,  466,  466,    0,  474,
			  475,  465,  465,  473,  473,  473,  473,  476,    0,  482,
			    0,  482,  483,  477,  482,  483,  484,  485,  487,  484,
			  485,  487,  547,  465,  491,  489,  548,  491,  489,  549,
			  465,  474,  475,  465,  465,  466,    0,  490,    0,  476,
			  490,  475,  474,  476,  476,  477,  485,  492,  483,  477,
			  492,  550,    0,  495,  547,  465,  495,  551,  548,  473,
			  552,  549,  482,  483,  553,  554,    0,  484,  485,  487,
			  496,  555,    0,  496,    0,  491,  489,    0,  485,    0, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  483,  556,  557,  550,  497,    0,  558,  497,  490,  551,
			  559,  473,  552,    0,  482,  483,  553,  554,  492,  484,
			  485,  487,    0,  555,  495,  560,  473,  491,  489,  473,
			  473,  473,  489,  556,  557,  755,  755,  491,  558,  561,
			  490,  496,  559,  562,  490,  490,  490,  692,  692,  692,
			  492,    0,    0,  490,  492,  497,  495,  560,  563,    0,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
			    0,  561,    0,  496,    0,  562,  755,  496,  496,  496,
			  496,  496,  496,  496,  496,  496,  496,  497,    0,  692,
			  563,  497,  497,  497,  497,  497,  497,  497,  497,  497,

			  497,  498,  498,  498,  498,  498,  498,  498,  498,  498,
			  498,  499,  499,  499,  499,  499,  499,  499,  499,  499,
			  499,  500,  500,  500,  500,  500,  500,  500,  500,  500,
			  500,  501,  501,  501,  501,  501,  501,  501,  501,  501,
			  501,  502,  502,  502,  502,  502,  502,  502,  502,  502,
			  502,  503,  503,  503,  503,  503,  503,  503,  503,  503,
			  503,  504,  504,  504,  504,  504,  504,  504,  504,  504,
			  504,  510,  510,  510,  510,  510,  511,  511,  511,  511,
			  511,    0,  564,  565,  510,  510,  529,  529,  529,  529,
			  529,  529,  529,  529,  529,  529,  530,  530,  530,  530, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  530,  530,  530,  530,  530,  530,  510,  566,  567,  569,
			  570,  571,    0,  510,  564,  565,  510,  510,  511,  531,
			  531,  531,  531,  531,  531,  531,  531,  531,  531,  532,
			  532,  532,  532,  535,  535,  535,  535,  572,  510,  566,
			  567,  569,  570,  571,  532,  536,  573,  536,  535,  574,
			  536,  536,  536,  536,  539,    0,  539,  539,  539,  539,
			  575,  577,  545,  580,  545,  545,  545,  545,    0,  572,
			  532,  540,  540,  540,  540,  583,  532,  584,  573,  585,
			  535,  574,  540,  540,  540,  540,  540,  540,  541,  541,
			  541,  541,  575,  577,  586,  580,  587,  539,  588,  541,

			  541,  541,  541,  541,  541,  545,    0,  583,    0,  584,
			    0,  585,  540,    0,  540,  540,  540,  540,  540,  540,
			  546,    0,  546,  546,  546,  546,  586,  589,  587,  541,
			  588,  541,  541,  541,  541,  541,  541,  542,  542,  542,
			  542,  590,  581,  581,  581,  581,    0,  581,  542,  542,
			  542,  542,  542,  542,  543,  543,  543,  543,  581,  589,
			  591,  592,  593,  546,  594,  543,  543,  543,  543,  543,
			  543,  596,  599,  590,  600,  601,  602,  603,  542,    0,
			  542,  542,  542,  542,  542,  542,  610,  610,  610,  610,
			    0,    0,  591,  592,  593,  543,  594,  543,  543,  543, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  543,  543,  543,  596,  599,  612,  600,  601,  602,  603,
			  609,  609,  609,  609,  631,  631,  631,  631,    0,  614,
			  637,  609,  609,  609,  609,  609,  609,  610,  613,    0,
			  581,  615,  616,    0,    0,  616,  618,  612,  640,  618,
			  641,  612,  642,  620,    0,  581,  620,    0,  581,  581,
			  581,  614,  637,  609,  609,  609,  609,  609,  609,    0,
			  613,  614,    0,  615,  613,  613,  613,  615,  645,  618,
			  640,  646,  641,  613,  642,  646,  616,  647,  649,  620,
			  650,  651,  652,  616,  653,  654,  655,  618,  633,  633,
			  633,  633,  657,  658,  620,  634,  634,  634,  634,    0,

			  645,  618,    0,  646,    0,    0,    0,  646,  616,  647,
			  649,  620,  650,  651,  652,  616,  653,  654,  655,  618,
			  629,  629,  629,  629,  657,  658,  620,  622,  622,  622,
			  622,  622,  622,  622,  622,  622,  622,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  624,  624,  624,
			  624,  624,  624,  624,  624,  624,  624,  626,  626,  626,
			  626,  629,    0,  627,  627,  627,  627,    0,  626,  626,
			  626,  626,  626,  626,  627,  627,  627,  627,  627,  627,
			  628,  628,  628,  628,  630,  630,  630,  630,  659,  660,
			  662,  628,  628,  628,  628,  628,  628,    0,    0,  630, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  626,  626,  626,  626,  626,  626,  627,  627,  627,  627,
			  627,  627,  663,  664,  632,  632,  632,  632,  666,    0,
			  659,  660,  662,  628,  628,  628,  628,  628,  628,  632,
			  635,  630,  635,  635,  635,  635,  674,  636,  675,  636,
			  636,  636,  636,  676,  663,  664,  677,  635,    0,  678,
			  666,  667,  667,  667,  667,  632,  667,  679,  680,  681,
			  682,  632,  684,  685,  688,  689,  691,  667,  674,  713,
			  675,  693,  693,  693,  693,  676,    0,    0,  677,  635,
			  636,  678,  696,  697,  714,  696,  697,    0,    0,  679,
			  680,  681,  682,    0,  684,  685,  688,  689,  691,  698,

			  715,  713,  698,  700,  700,  700,  702,  702,  702,  702,
			    0,  717,  697,  693,  696,  718,  714,  719,  704,  704,
			  704,  704,  704,  705,  720,  705,    0,    0,  705,  705,
			  705,  705,  715,  696,  697,  708,  708,  708,  708,  667,
			  723,    0,  698,  717,  697,  700,  696,  718,  702,  719,
			  698,    0,    0,  725,  667,    0,  720,  667,  667,  667,
			  704,  706,  706,  706,  706,  696,  697,  726,  707,  707,
			  707,  707,  723,  709,  698,  709,  706,  728,  709,  709,
			  709,  709,  698,  707,  710,  725,  710,  710,  710,  710,
			  729,  730,  731,  732,  733,  737,  737,  737,  740,  726, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  741,  710,  743,  744,  737,  746,  750,  751,  706,  728,
			  753,  757,  757,  757,    0,  707,    0,  762,  761,    0,
			  762,  761,  729,  730,  731,  732,  733,  856,  856,  856,
			  740,    0,  741,  710,  743,  744,  856,  746,  750,  751,
			    0,    0,  753,  759,  759,  759,  759,  761,  763,    0,
			    0,  763,  757,  782,  759,  759,  759,  759,  759,  759,
			  762,  773,  773,  773,  773,  783,  785,    0,  762,  761,
			  774,  774,  774,  774,  787,  788,  789,  763,  790,  761,
			  775,  775,  775,  775,  759,  782,  759,  759,  759,  759,
			  759,  759,  762,  793,  796,  775,  797,  783,  785,  763,

			  762,  761,  765,  765,  765,  765,  787,  788,  789,  763,
			  790,    0,  799,  765,  765,  765,  765,  765,  765,    0,
			  800,  767,  767,  767,  767,  793,  796,  775,  797,  801,
			    0,  763,  767,  767,  767,  767,  767,  767,  779,  779,
			  779,  779,  803,  765,  799,  765,  765,  765,  765,  765,
			  765,  776,  800,  776,    0,    0,  776,  776,  776,  776,
			    0,  801,  767,    0,  767,  767,  767,  767,  767,  767,
			  769,  769,  769,  769,  803,    0,  778,  778,  778,  778,
			  804,  769,  769,  769,  769,  769,  769,  771,  771,  771,
			  771,  778,  780,  780,  780,  780,    0,    0,  771,  771, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  771,  771,  771,  771,    0,  798,  798,  798,  798,    0,
			    0,  769,  804,  769,  769,  769,  769,  769,  769,  777,
			    0,  777,    0,  778,  777,  777,  777,  777,  771,  814,
			  771,  771,  771,  771,  771,  771,  781,  798,  781,    0,
			    0,  781,  781,  781,  781,  807,  808,  809,  807,  808,
			  809,  815,  815,  815,  815,  814,  816,  816,  816,  816,
			    0,  814,  817,  817,  817,  817,    0,    0,    0,  798,
			  818,  818,  818,  818,  819,  819,  819,  819,  824,  820,
			    0,  820,  827,  807,  820,  820,  820,  820,  831,  819,
			  821,  821,  821,  821,  834,  839,  807,  808,  809,  822,

			  822,  822,  822,  833,  833,  833,  833,  841,  798,  851,
			  824,  798,  798,  798,  827,  807,  847,  853,  854,  844,
			  831,  819,  844,  863,  864,  865,  834,  839,  807,  808,
			  809,  848,  848,  848,  848,  833,  866,  867,    0,  841,
			    0,  851,  847,  849,  849,  849,  849,    0,  847,  853,
			  854,    0,    0,    0,    0,  863,  864,  865,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  833,  866,  867,
			  844,  877,    0,    0,  877,  877,  877,  877,  877,  877,
			  877,  877,  877,  877,  877,  877,  888,  888,  888,  888,
			    0,    0,    0,  888,  889,  889,  889,  889,    0,    0, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  889,  844,    0,    0,    0,  833,    0,    0,  833,
			  833,  833,  871,  871,  871,  871,  871,  871,  871,  871,
			  871,  871,  871,  871,  871,  871,  871,  871,  871,  871,
			  871,  872,  872,  872,  872,  872,  872,  872,  872,  872,
			  872,  872,  872,  872,  872,  872,  872,  872,  872,  872,
			  873,  873,  873,  873,  873,  873,  873,  873,  873,  873,
			  873,  873,  873,  873,  873,  873,  873,  873,  873,  874,
			  874,  874,  874,  874,  874,  874,  874,  874,  874,  874,
			  874,  874,  874,  874,  874,  874,  874,  874,  875,  875,
			  875,  875,  875,  875,  875,  875,  875,  875,  875,  875,

			  875,  875,  875,  875,  875,  875,  875,  876,    0,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  878,  878,  878,  878,
			  878,  878,  878,  878,  878,  878,  878,  878,  878,  878,
			  878,  878,  878,  878,  878,  880,    0,  880,  880,    0,
			  880,  880,  880,  880,  880,  880,  880,  880,  880,  880,
			  880,  880,  880,  880,  881,  881,  881,  881,  881,  881,
			  881,  881,  881,  881,  881,  881,  881,  881,  881,  881,
			  881,  881,  881,  882,  882,  882,  882,  882,  882,  882,
			  882,  882,  882,  882,  882,  882,  882,  882,  882,  882, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  882,  882,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  883,  883,  883,  883,  883,  883,  883,  883,  883,
			  883,  884,    0,  884,  884,  884,  884,  884,  884,  884,
			  884,  884,  884,  884,  884,  884,  884,  884,  884,  884,
			  885,    0,  885,    0,  885,  885,  885,  885,  885,  885,
			  885,  885,  885,  885,  885,  885,  885,  885,  885,  886,
			  886,  886,  886,  886,  886,  886,  886,  886,  886,  886,
			  886,  886,  886,  886,  886,  886,  887,    0,  887,  887,
			  887,  887,  887,  887,  887,  887,  887,  887,  887,  887,
			  887,  887,  887,  887,  887,  890,  890,  890,  890,    0,

			    0,    0,  890,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  891,  891,  891,  891,  891,  891,  891,  891,
			  891,  891,  892,    0,  892,  892,  892,  892,  892,  892,
			  892,  892,  892,  892,  892,  892,  892,  892,  892,  892,
			  892,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870, yy_Dummy>>,
			1, 58, 4000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 892)
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
			    0,    0,    0,  114,  115,  124,  130, 1484, 1483,  136,
			  142,  148,  154, 1398, 3941,  160,  171, 3941,  275,    0,
			 3941,  389, 3941, 3941, 3941, 3941, 3941,  101,  158,  167,
			  289,  175, 1369, 3941,  115, 3941,  120, 1368,  359,    0,
			  286,  124,  271,  260,  361,  145,   77,  370,  122,  100,
			  291,  368,  116,  137,  149,  158, 3941, 1281, 3941, 3941,
			 3941, 3941, 3941,  111,  359,  123,  369,  379,  412,  422,
			  432,  439,  445,  455,  177, 1303, 3941, 3941,  557,  224,
			  571, 3941, 3941,  291,  294,  565,  576,  578, 1277, 3941,
			 3941,  609, 3941, 1157, 1151,  124, 1155, 3941,  615,  621,

			 1229, 1144, 1123,  148, 1122,  630, 1193, 1075, 1046,  154,
			 1022,  588, 3941,  740,  197,  631,  594,  632,  637,  676,
			  646,  647,  701,  699,  703,  705,  741,  767,  800,  675,
			  810,  811,  863,  873,  887,  920,  934,  948,  981,    0,
			  947,  888, 1072, 1028, 1102, 1052,  216, 1062,  603, 1096,
			  764, 1106,  790, 3941, 3941, 3941,  761, 3941, 3941, 3941,
			 1191,  927, 1196, 1202, 1219,  606, 3941, 3941, 3941, 3941,
			 3941, 3941,    0,  218,  295,  300,  310,  318,  343,  360,
			  376,  367,  378,  367, 1239,    0,  368,  723,  608,  522,
			  605,  614,    0,  614, 1242,    0,  686,  722,  681,  712, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  744,  758,    0,  747,  824, 1270,  881,  817,  822,  855,
			  850,  857, 1030,  873,  885,  893,  898, 3941, 1249, 1294,
			 1072, 1272, 1282, 1292, 1317, 1327, 1337, 1347, 1357, 1367,
			 1377, 1103, 3941, 1479, 3941, 3941, 3941, 3941, 3941,  400,
			 3941, 3941, 3941, 3941, 3941, 3941, 3941, 3941, 3941, 3941,
			 3941, 3941, 3941, 3941, 3941, 3941,  999,  989,  183,  989,
			  353, 3941, 3941, 1488,  424,  930, 1004,  801,  932, 3941,
			  935, 1496, 1241, 1002, 1069, 3941, 1502, 3941,  968,  931,
			  255,  934,  933,  555,  925,  919, 1508,  907,  891,  284,
			  868,  944,  849,  995,  840,  838,  832, 1179,  817,  822,

			 3941, 3941, 1618, 1524, 1478, 3941, 3941, 3941, 3941, 1487,
			 3941, 1491, 3941, 1511, 1512, 1525, 1596, 1536, 1617, 1550,
			 3941, 1551, 1646, 1677, 1683, 1681, 1682, 3941, 1690, 1735,
			 1749, 1782, 1801, 1816, 1847, 1863, 3941, 3941, 1718,  965,
			 1766, 1032, 1828, 1230, 1873, 1206,  887,  886,  877,  876,
			  870, 1321,  869,  867,  866,  862,  820,  814,  811,  810,
			  804,  794,  791,  768,  743,  704,  695,  682, 3941, 3941,
			 1874, 1897, 1907, 1917, 1927, 1937, 1947, 1957, 1614, 1646,
			 3941, 2040, 1728, 1543, 2045, 2062, 2111, 2128, 1760, 1516,
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
			 2174, 2184, 2194, 2204, 3941, 2288, 2293,  594, 1600,  577,
			  579,    0,  568, 2321, 2261, 2262, 2269, 2275, 3941, 3941,
			 3941, 3941, 2324, 2325, 2329, 2330, 3941, 2331, 3941, 2338,
			 2350, 2337, 2360, 3941, 3941, 2366, 2383, 2397, 2407, 2417,

			 2427, 2437, 2447, 2457, 2467, 3941, 3941, 3941, 3941, 3941,
			 2551, 2556, 3941, 3941, 3941, 3941, 3941, 3941, 3941, 3941,
			 3941, 3941, 3941, 3941, 3941, 3941, 3941, 3941, 3941, 2492,
			 2502, 2525, 2608, 1742, 1911, 2612, 2629, 2094, 2118, 2635,
			 2650, 2667, 2716, 2733,  621, 2643, 2701, 2292, 2295, 2299,
			 2333, 2343, 2340, 2342, 2335, 2355, 2350, 2366, 2368, 2361,
			 2391, 2399, 2394, 2413, 2533, 2534, 2571, 2556,    0, 2573,
			 2570, 2556, 2582, 2597, 2613, 2611,    0, 2618,    0,    0,
			 2620, 2740,    0, 2635, 2625, 2639, 2657, 2647, 2654, 2687,
			 2689, 2717, 2705, 2728, 2715,    0, 2724,    0,    0, 2736, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2737, 2723, 2733, 2745,    0,    0, 3941,  411, 1313, 2789,
			 2765,  564, 2747, 2770, 2761, 2773, 2825, 3941, 2829, 3941,
			 2836, 3941, 2833, 2843, 2853,  609, 2936, 2942, 2959, 2899,
			 2963, 2793, 2993, 2867, 2874, 3011, 3018, 2770,    0,    0,
			 2793, 2801, 2809,    0,    0, 2819, 2835, 2832,    0, 2829,
			 2841, 2844, 2846, 2849, 2834, 2841,    0, 2843, 2848, 2952,
			 2949,    0, 2950, 2978, 2973,    0, 2982, 3049, 3941,  598,
			  502,  500,  493,  499, 3004, 2989, 2988, 3006, 3013, 3021,
			 3009, 3023, 3009,    0, 3011, 3031,    0,    0, 3024, 3029,
			    0, 3021, 2427, 3051,  241,  505, 3075, 3076, 3092, 3941,

			 3083,  560, 3086,  747, 3098, 3107, 3140, 3147, 3114, 3157,
			 3165,    0,    0, 3033, 3032, 3049,    0, 3065, 3064, 3081,
			 3092,    0,    0, 3104,    0, 3121, 3131,    0, 3127, 3145,
			 3140, 3141, 3161, 3143, 3941,  563,  469, 3101,  273,  277,
			 3155, 3150,    0, 3157, 3158,    0, 3169,    0,    0,    0,
			 3155, 3162,    0, 3159, 3941, 2414, 3941, 3190, 3941, 3222,
			  237, 3211, 3210, 3241,  288, 3281,  277, 3300,  272, 3349,
			  263, 3366,  254, 3240, 3249, 3259, 3335, 3403, 3355, 3317,
			 3371, 3420, 3218, 3214,    0, 3221,    0, 3239, 3242, 3241,
			 3235,    0,    0, 3255,    0,    0, 3249, 3260, 3403, 3266, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3284, 3295,    0, 3306, 3344,    0,    0, 3438, 3439, 3440,
			 3941, 3941, 3941, 3941, 3393, 3430, 3435, 3441, 3449, 3453,
			 3463, 3469, 3478,    0, 3442,    0,    0, 3439,    0,    0,
			    0, 3437,    0, 3501, 3451,  153,  131,  658,  127, 3446,
			    0, 3471,    0,    0, 3512, 3941, 3941, 3480, 3510, 3522,
			    0, 3473,    0, 3474, 3486,  106, 3133,   67,   26,    0,
			    0, 3941,    0, 3491, 3474, 3475, 3486, 3487,    0, 3941,
			 3941, 3611, 3630, 3649, 3668, 3687, 3706, 3568, 3725, 3551,
			 3744, 3763, 3782, 3801, 3820, 3839, 3858, 3875, 3580, 3588,
			 3889, 3902, 3921, yy_Dummy>>,
			1, 93, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 892)
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
			    0,  870,    1,  871,  871,  872,  872,  873,  873,  874,
			  874,  875,  875,  870,  870,  870,  870,  870,  876,  877,
			  870,  878,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  880,  870,  870,  870,  881,
			  881,  870,  870,  882,  881,  881,  881,  881,  883,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,

			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  876,  870,  884,  885,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  876,  876,  877,
			  886,  886,  886,  886,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  880,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  881,  870,  870,  881,  882,  881,  881,  881,  881,  870,
			  881,  881,  881,  881,  883,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  887,  870,  870,  870,  870,  870,  870,  870,  870,

			  870,  870,  884,  885,  876,  870,  870,  870,  870,  876,
			  870,  876,  870,  876,  876,  876,  876,  876,  876,  876,
			  870,  876,  876,  876,  876,  876,  876,  870,  876,  876,
			  876,  876,  876,  876,  876,  876,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  886,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  887,  887,  885,  885,  885,  885,  885,  870,  870,
			  870,  870,  876,  876,  876,  876,  870,  876,  870,  876,
			  876,  876,  876,  870,  870,  876,  876,  876,  870,  870,

			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  879,  879,  879,  879,  879,  879,  870,  870,  870,  870,
			  870,  887,  885,  885,  885,  885,  876,  870,  876,  870,
			  876,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  870,  870,  870,
			  870,  870,  870,  870,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  870,  870,  888,  887,  876,  876,  876,  870,

			  889,  889,  889,  890,  870,  870,  870,  870,  870,  870,
			  870,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  870,  891,  870,  870,  870,  870,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  870,  870,  870,  870,  870,  870,
			  887,  876,  876,  876,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  879,  879,  879,  879,  879,  879,  892,  876,  876,  876,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  870,  879,  870,  870,  870,  870,  879,
			  879,  879,  879,  879,  876,  870,  870,  870,  870,  870,
			  879,  879,  879,  870,  879,  870,  870,  870,  870,  879,
			  879,  870,  879,  870,  879,  870,  879,  870,  879,  870,
			    0,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  870,  870, yy_Dummy>>,
			1, 93, 800)
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
			create an_array.make_filled (0, 0, 871)
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
			  533,  533,  534,  535,  535,  535,  535,  535,  535,  537,
			  539,  541,  543,  544,  545,  546,  547,  549,  550,  552,
			  553,  554,  555,  556,  558,  560,  561,  562,  563,  563,

			  563,  563,  563,  563,  563,  563,  564,  565,  566,  567,
			  568,  569,  570,  571,  572,  573,  574,  575,  576,  577,
			  578,  579,  580,  581,  582,  583,  584,  585,  586,  588,
			  588,  588,  588,  589,  589,  590,  591,  591,  591,  592,
			  593,  593,  593,  593,  593,  593,  594,  595,  596,  597,
			  598,  599,  600,  601,  602,  603,  604,  605,  606,  607,
			  608,  609,  611,  612,  613,  614,  615,  616,  617,  619,
			  620,  621,  622,  623,  624,  625,  626,  628,  629,  631,
			  633,  634,  636,  638,  639,  640,  641,  642,  643,  644,
			  645,  646,  647,  648,  649,  650,  652,  653,  655,  657, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  658,  659,  660,  661,  662,  664,  666,  667,  667,  667,
			  667,  667,  668,  668,  668,  668,  668,  669,  671,  672,
			  674,  675,  677,  677,  677,  677,  678,  678,  678,  678,
			  678,  679,  679,  680,  680,  681,  682,  683,  684,  686,
			  688,  689,  690,  691,  693,  695,  696,  697,  698,  700,
			  701,  702,  703,  704,  705,  706,  707,  709,  710,  711,
			  712,  713,  715,  716,  717,  718,  720,  721,  721,  722,
			  722,  722,  722,  722,  722,  723,  724,  725,  726,  727,
			  728,  729,  730,  731,  733,  734,  735,  737,  739,  740,
			  741,  743,  744,  744,  744,  744,  745,  746,  747,  748,

			  749,  749,  749,  749,  749,  749,  749,  750,  751,  751,
			  751,  752,  754,  756,  757,  758,  759,  761,  762,  763,
			  764,  765,  767,  769,  770,  772,  773,  774,  776,  777,
			  778,  779,  780,  781,  782,  783,  783,  783,  783,  783,
			  783,  784,  785,  787,  788,  789,  791,  792,  794,  796,
			  798,  799,  800,  802,  803,  804,  804,  805,  805,  806,
			  806,  807,  808,  809,  810,  810,  810,  810,  810,  810,
			  810,  810,  810,  810,  810,  811,  812,  812,  812,  813,
			  813,  814,  814,  815,  816,  818,  819,  821,  822,  823,
			  824,  825,  827,  829,  830,  832,  834,  835,  836,  837, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  838,  839,  840,  842,  843,  844,  846,  848,  849,  850,
			  851,  853,  854,  856,  857,  858,  858,  859,  859,  860,
			  861,  861,  861,  862,  864,  865,  867,  869,  870,  872,
			  874,  876,  877,  879,  879,  880,  880,  880,  880,  880,
			  881,  883,  884,  886,  888,  889,  891,  893,  894,  894,
			  895,  897,  898,  900,  900,  901,  901,  901,  901,  901,
			  903,  905,  907,  909,  909,  910,  910,  911,  911,  913,
			  914,  914, yy_Dummy>>,
			1, 72, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 913)
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
			    0,  186,  186,  188,  188,  222,  220,  221,    1,  220,
			  221,    1,  221,   36,  220,  221,  189,  220,  221,   41,
			  220,  221,   14,  220,  221,  154,  220,  221,   24,  220,
			  221,   25,  220,  221,   32,  220,  221,   30,  220,  221,
			    9,  220,  221,   31,  220,  221,   13,  220,  221,   33,
			  220,  221,  118,  220,  221,  118,  220,  221,    8,  220,
			  221,    7,  220,  221,   18,  220,  221,   17,  220,  221,
			   19,  220,  221,   11,  220,  221,  117,  220,  221,  117,
			  220,  221,  117,  220,  221,  117,  220,  221,  117,  220,
			  221,  117,  220,  221,  117,  220,  221,  117,  220,  221,

			  117,  220,  221,  117,  220,  221,  117,  220,  221,  117,
			  220,  221,  117,  220,  221,  117,  220,  221,  117,  220,
			  221,  117,  220,  221,  117,  220,  221,  117,  220,  221,
			   28,  220,  221,  220,  221,   29,  220,  221,   34,  220,
			  221,   26,  220,  221,   27,  220,  221,   12,  220,  221,
			  220,  221,  220,  221,  220,  221,  220,  221,  220,  221,
			  220,  221,  220,  221,  220,  221,  220,  221,  220,  221,
			  220,  221,  220,  221,  190,  221,  219,  221,  217,  221,
			  218,  221,  186,  221,  186,  221,  185,  221,  184,  221,
			  186,  221,  186,  221,  186,  221,  186,  221,  186,  221, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  188,  221,  187,  221,  182,  221,  182,  221,  181,  221,
			  182,  221,  182,  221,  182,  221,  182,  221,    6,  221,
			    5,    6,  221,    5,  221,    6,  221,    6,  221,    6,
			  221,    6,  221,    6,  221,    1,  189,  178,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189, -401,  189,  189,  189, -401,  189,  189,  189,
			  189,  189,  189,  189,  189,   41,  154,  154,  154,  154,
			    2,   35,   10,  124,   39,   23,   22,  124,  118,   15,
			   37,   20,   21,   38,   16,  117,  117,  117,  117,  117,
			   48,  117,  117,  117,  117,  117,  117,  117,  117,   61,

			  117,  117,  117,  117,  117,  117,  117,   73,  117,  117,
			  117,   80,  117,  117,  117,  117,  117,  117,  117,   92,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,   40,   42,    1,   42,  190,
			  217,  207,  205,  206,  208,  209,  210,  211,  191,  192,
			  193,  194,  195,  196,  197,  198,  199,  200,  201,  202,
			  203,  204,  186,  185,  184,  186,  186,  186,  186,  186,
			  186,  183,  184,  186,  186,  186,  186,  188,  187,  181,
			    5,    4,  179,  176,  179,  189, -401, -401,  189,  162,
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
			  116,  117,  216,    4,    4,  168,  179,  165,  179,  158,
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
			  111,  117,  117,  215,  214,  213,    4,  189,  189,  189,
			  124,  124,  124,  124,  117,  117,   54,  117,  117,   57,
			  117,  117,  117,  117,  117,   70,  117,   74,  117,  117,
			   77,  117,   78,  117,  117,  117,  117,  117,  117,  117,
			   99,  117,  117,  117,  113,  117,    3,    4,  189,  189,
			  189,  152,  153,  153,  151,  153,  150,  124,  124,  124,
			  124,  124,   50,  117,  117,   56,  117,   59,  117,  117,
			   66,  117,   68,  117,   75,  117,  117,   86,  117,  117,
			  117,   96,  117,  117,  104,  117,  110,  117,  189,  171,
			  179,  174,  179,  124,  124,   51,  117,  117,   79,  117,

			  117,   94,  117,   97,  117,  170,  179,   60,  117,  117,
			  117,   93,  117,   93, yy_Dummy>>,
			1, 114, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 3941
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 870
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 871
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

	yyNb_rules: INTEGER = 221
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 222
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
