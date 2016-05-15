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
			create an_array.make_filled (0, 0, 2496)
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
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
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

			   66,   67,   68,   69,   71,   71,  516,   72,   72,  130,
			   73,   73,   75,   76,   75,  175,   77,   75,   76,   75,
			  131,   77,   82,   83,   82,   82,   83,   82,   85,   86,
			   85,   85,   86,   85,   88,   88,   88,   88,   88,   88,
			  144,  145,  656,   87,  146,  147,   87,  175,  161,   89,
			  182,  132,   89,  133,  133,  133,  133,  134,  162,  137,
			  698,  138,  138,  138,  138,  135,  189,  173,  192,   78,
			  749,  193,  302,  174,   78,  195,  195,  195,  198,  198,
			  161,  302,  182,  197,  197,  197,  199,  199,  199,  697,
			  162,  652,  163,  696,  164,  200,  200,  200,  189,  173, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  192,   78,  142,  193,  165,  174,   78,   91,   92,  228,
			   93,   92,  229,   94,  302,   95,   96,  119,   97,  228,
			   98,  180,  232,  120,  163,  121,  164,   99,  749,  100,
			  136,   92,  101,  150,  190,  166,  165,  151,  181,  167,
			  102,  242,  152,  322,  153,  103,  104,  156,  191,  154,
			  155,  157,  168,  180,  158,  105,  304,  159,  106,  107,
			  160,  108,  695,  309,  101,  150,  190,  166,  691,  151,
			  181,  167,  102,  242,  152,  322,  153,  103,  104,  156,
			  191,  154,  155,  157,  168,  228,  158,  105,  229,  159,
			  109,   92,  160,  235,  236,  235,  306,  306,  110,  111,

			  112,  113,  114,  115,  116,  316,  316,  122,  122,  122,
			  122,  123,  124,  125,  126,  127,  128,  129,  137,  568,
			  138,  138,  138,  138,  323,  326,  176,  169,  237,  237,
			  237,  183,  139,  140,  170,  171,  177,  186,  178,  327,
			  172,  184,  179,  237,  237,  237,  185,  187,  645,  328,
			  188,  230,  228,  230,  141,  229,  323,  326,  176,  169,
			  629,  142,  594,  183,  139,  140,  170,  171,  177,  186,
			  178,  327,  172,  184,  179,   88,   88,   88,  185,  187,
			  239,  328,  188,   93,  412,  412,  141,  204,  204,  204,
			   89,  205,  239,  590,  206,   93,  207,  208,  209,  243, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  244,  312,  245,   93,  210,   93,  246,  247,  231,   93,
			   93,  211,  228,  212,  453,  232,  213,  214,  215,  216,
			  248,  217,  302,  218,  451,  249,  518,  219,   93,  220,
			  201,  109,  221,  222,  223,  224,  225,  226,  198,  198,
			  231,  251,  239,  109,   93,   93,  250,  239,  196,  329,
			   93,  109,  239,  109,  330,   93,  239,  109,  109,   93,
			  595,  595,  252,  109,   90,   90,  302,   90,  239,  240,
			  239,   93,   93,   93,  453,  109,  109,  318,  318,  318,
			  253,  329,  331,  109,  254,  109,  330,  316,  316,  109,
			  109,  255,  109,  109,  262,  257,  239,   93,  109,   93,

			  451,  332,  333,  109,  303,  303,  303,  109,  109,  438,
			  256,  437,  253,  436,  331,  435,  254,  434,  433,  109,
			  241,  109,  261,  255,  109,  109,  432,  257,  450,  239,
			  109,  302,   93,  332,  333,  109,  258,  259,  258,  109,
			  239,  239,  256,   93,   93,  109,  337,  109,  305,  305,
			  305,  109,  241,  109,  651,  342,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,  258,  259,  258,
			  239,  239,  431,   93,   93,  271,  430,  109,  337,  109,
			  109,  429,  428,  263,  263,  263,  239,  342,  302,   93,
			  427,  109,  109,  260,  239,  343,  652,   93,  195,  195, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  195,  239,  426,  344,   93,  272,  273,  274,  275,  276,
			  277,  278,  109,  307,  307,  307,  324,  345,  264,  325,
			  425,  109,  109,  109,  109,  424,  423,  343,  265,  265,
			  265,  310,  310,  310,  310,  344,  351,  109,  312,  420,
			  313,  313,  313,  313,  338,  109,  311,  354,  324,  345,
			  301,  325,  109,  109,  109,  314,  419,  266,  266,  339,
			  418,  272,  273,  274,  275,  276,  277,  278,  351,  109,
			  308,  308,  308,  267,  267,  267,  338,  109,  311,  354,
			  355,  268,  268,  268,  109,  417,  340,  314,  269,  279,
			  341,  339,  280,  416,  281,  282,  283,  356,  195,  195,

			  195,  137,  284,  315,  315,  315,  315,  415,  655,  285,
			  410,  286,  355,  359,  287,  288,  289,  290,  340,  291,
			  360,  292,  341,  369,  393,  293,  234,  294,  203,  356,
			  295,  296,  297,  298,  299,  300,  272,  273,  274,  275,
			  276,  277,  278,  302,  142,  359,  320,  320,  320,  320,
			  656,  130,  360,  238,  234,  369,  334,  346,  352,  347,
			  335,  348,  357,  361,  367,  362,  370,  371,  368,  372,
			  353,  358,  349,  363,  336,  350,  364,  373,  365,  366,
			  272,  273,  274,  275,  276,  277,  278,  321,  334,  346,
			  352,  347,  335,  348,  357,  361,  367,  362,  370,  371, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  368,  372,  353,  358,  349,  363,  336,  350,  364,  373,
			  365,  366,  374,  377,  378,  379,  380,  375,  381,  382,
			  383,  384,  385,  386,  387,  195,  195,  195,  376,  195,
			  195,  195,  388,  388,  388,  389,  389,  389,  391,  391,
			  391,  391,  203,  201,  374,  377,  378,  379,  380,  375,
			  204,  204,  204,  196,  230,  228,  230,  390,  229,  194,
			  376,  235,  236,  235,  237,  237,  237,  394,  259,  394,
			  395,  148,  396,   93,  397,   93,  398,   93,  239,   93,
			  143,   93,  239,  457,  239,   93,  402,   93,  403,  239,
			  749,   93,   93,  258,  259,  258,  458,  239,  459,  405,

			   93,   80,   93,  270,  270,  270,  399,   80,  749,  406,
			  460,  231,   93,  407,  749,  457,   93,  411,  411,  411,
			  749,  109,  242,  109,  400,  109,  401,  109,  458,  109,
			  459,  404,  749,  109,  239,  109,  749,   93,  399,  109,
			  109,  749,  460,  231,   90,  258,  259,  258,  109,  240,
			  109,  749,   93,  109,  242,  109,  400,  109,  401,  109,
			  109,  109,  749,  404,  109,  109,  749,  109,  413,  413,
			  413,  109,  109,  239,  749,  749,   93,  414,  414,  414,
			  109,  463,  109,  239,  749,  109,   93,  421,  422,  422,
			  422,  749,  109,  303,  303,  303,  109,  749,  239,  749, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  241,   93,  439,  464,  110,  111,  112,  113,  114,  115,
			  116,  749,  239,  463,  749,   93,  461,  109,  303,  303,
			  303,  263,  263,  263,  109,  239,  749,  749,   93,  303,
			  303,  303,  241,  462,  109,  464,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,  749,  461,  109,
			  303,  303,  303,  440,  440,  440,  109,  441,  441,  441,
			  263,  263,  263,  109,  465,  462,  109,  195,  195,  195,
			  263,  263,  263,  749,  466,  467,  109,  468,  318,  318,
			  318,  109,  749,  469,  749,  263,  263,  263,  272,  273,
			  274,  275,  276,  277,  278,  109,  465,  749,  470,  408,

			  408,  408,  442,  442,  442,  442,  466,  467,  109,  468,
			  749,  749,  409,  409,  409,  469,  443,  311,  443,  452,
			  749,  444,  444,  444,  444,  445,  445,  445,  445,  447,
			  470,  447,  471,  472,  448,  448,  448,  448,  475,  137,
			  446,  449,  449,  449,  449,  476,  473,  477,  454,  311,
			  455,  455,  455,  455,  456,  456,  456,  456,  478,  749,
			  474,  480,  481,  749,  471,  472,  482,  483,  484,  485,
			  475,  479,  446,  486,  487,  488,  489,  476,  473,  477,
			  490,  491,  142,  492,  493,  494,  496,  497,  495,  498,
			  478,  321,  474,  480,  481,  321,  499,  502,  482,  483, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  484,  485,  503,  479,  500,  486,  487,  488,  489,  504,
			  505,  506,  490,  491,  507,  492,  493,  494,  496,  497,
			  495,  498,  501,  508,  509,  510,  511,  512,  499,  502,
			  513,  514,  515,  749,  503,  749,  500,  197,  197,  197,
			  749,  504,  505,  506,  749,  749,  507,  199,  199,  199,
			  200,  200,  200,  749,  501,  508,  509,  510,  511,  512,
			  749,  749,  513,  514,  515,  195,  195,  195,  195,  195,
			  195,  516,  517,  517,  517,  517,  394,  259,  394,  519,
			  749,  520,  239,  522,   93,   93,   93,  239,  524,  239,
			   93,   93,   93,  270,  270,  270,  239,  749,  538,   93,

			  270,  270,  270,  270,  270,  270,  270,  270,  270,  525,
			  525,  525,  526,  526,  526,  749,  523,  539,  521,  303,
			  303,  303,  527,  422,  422,  422,  422,  303,  303,  303,
			  538,  242,  109,  109,  109,  528,  529,  540,  109,  109,
			  109,  527,  422,  422,  422,  422,  749,  109,  523,  539,
			  521,  444,  444,  444,  444,  749,  541,  530,  531,  531,
			  531,  531,  749,  242,  109,  109,  109,  528,  529,  540,
			  109,  109,  109,  311,  749,  542,  263,  263,  263,  109,
			  270,  270,  270,  263,  263,  263,  316,  316,  541,  530,
			  444,  444,  444,  444,  533,  533,  533,  533,  749,  532, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  448,  448,  448,  448,  749,  311,  534,  542,  534,  446,
			  543,  535,  535,  535,  535,  448,  448,  448,  448,  536,
			  544,  449,  449,  449,  449,  545,  454,  450,  537,  537,
			  537,  537,  454,  546,  456,  456,  456,  456,  547,  548,
			  549,  446,  543,  749,  550,  551,  552,  553,  554,  555,
			  556,  557,  544,  558,  559,  560,  561,  545,  562,  563,
			  564,  565,  321,  566,  567,  546,  749,  749,  571,  321,
			  547,  548,  549,  572,  573,  321,  550,  551,  552,  553,
			  554,  555,  556,  557,  574,  558,  559,  560,  561,  575,
			  562,  563,  564,  565,  576,  566,  567,  568,  568,  568,

			  571,  569,  577,  578,  579,  572,  573,  580,  581,  582,
			  583,  584,  570,  585,  586,  587,  574,  588,  749,  239,
			  239,  575,   93,   93,  605,  749,  576,  516,  589,  589,
			  589,  589,  749,  749,  577,  578,  579,  606,  749,  580,
			  581,  582,  583,  584,  607,  585,  586,  587,  749,  588,
			  270,  270,  270,  592,  239,  749,  605,   93,  597,  597,
			  597,  749,  749,  591,  531,  531,  531,  531,  608,  606,
			  109,  109,  600,  600,  600,  600,  607,  749,  609,  599,
			  535,  535,  535,  535,  569,  592,  601,  601,  601,  601,
			  593,  535,  535,  535,  535,  591,  612,  613,  614,  615, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  608,  446,  109,  109,  312,  109,  601,  601,  601,  601,
			  609,  599,  604,  616,  456,  456,  456,  456,  617,  618,
			  610,  603,  593,  749,  611,  619,  620,  602,  612,  613,
			  614,  615,  621,  446,  622,  623,  624,  109,  625,  626,
			  627,  630,  749,  631,  632,  616,  633,  634,  635,  636,
			  617,  618,  610,  603,  637,  142,  611,  619,  620,  568,
			  568,  568,  638,  628,  621,  639,  622,  623,  624,  640,
			  625,  626,  627,  630,  570,  631,  632,  641,  633,  634,
			  635,  636,  642,  643,  749,  749,  637,  516,  644,  644,
			  644,  644,  239,  239,  638,   93,   93,  639,  666,  239,

			  749,  640,   93,  649,  595,  595,  749,  749,  667,  641,
			  653,  597,  597,  597,  642,  643,  659,  659,  659,  659,
			  749,  657,  647,  657,  646,  668,  658,  658,  658,  658,
			  666,  660,  601,  601,  601,  601,  662,  662,  662,  662,
			  667,  669,  648,  109,  109,  650,  628,  661,  670,  749,
			  109,  671,  654,  663,  647,  663,  646,  668,  664,  664,
			  664,  664,  672,  660,  312,  673,  662,  662,  662,  662,
			  674,  675,  676,  669,  648,  109,  109,  677,  678,  661,
			  670,  665,  109,  671,  679,  680,  681,  682,  683,  684,
			  685,  686,  687,  688,  672,  689,  239,  673,  749,   93, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  749,  708,  674,  675,  676,  239,  749,  749,   93,  677,
			  678,  239,  749,  665,   93,  749,  679,  680,  681,  682,
			  683,  684,  685,  686,  687,  688,  749,  689,  516,  690,
			  690,  690,  690,  708,  692,  658,  658,  658,  658,  693,
			  694,  658,  658,  658,  658,  709,  710,  109,  699,  699,
			  699,  699,  700,  711,  700,  712,  109,  701,  701,  701,
			  701,  713,  109,  660,  749,  749,  692,  749,  702,  749,
			  702,  693,  694,  703,  703,  703,  703,  709,  710,  109,
			  714,  704,  704,  704,  704,  711,  715,  712,  109,  664,
			  664,  664,  664,  713,  109,  660,  705,  664,  664,  664,

			  664,  706,  716,  706,  717,  720,  707,  707,  707,  707,
			  721,  722,  714,  718,  718,  718,  723,  724,  715,  516,
			  725,  725,  725,  725,  239,  660,  727,   93,  705,   93,
			  728,  749,  749,   93,  716,  749,  717,  720,  701,  701,
			  701,  701,  721,  722,  719,  749,  749,  732,  723,  724,
			  749,  532,  701,  701,  701,  701,  749,  660,  703,  703,
			  703,  703,  726,  703,  703,  703,  703,  729,  729,  729,
			  729,  707,  707,  707,  707,  109,  719,  109,  730,  732,
			  730,  109,  705,  731,  731,  731,  731,  707,  707,  707,
			  707,  733,  734,  736,  726,  718,  718,  718,  737,  738, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  516,  739,  739,  739,  739,  740,  705,  109,   93,  109,
			  741,  742,  743,  109,  705,  731,  731,  731,  731,  731,
			  731,  731,  731,  733,  734,  736,  735,  744,  745,  746,
			  737,  738,  602,  747,  748,  317,  317,  317,  705,  319,
			  319,  319,  741,  742,  743,  149,  149,  149,  149,  149,
			  149,  149,  149,  149,  749,  749,  109,  749,  735,  744,
			  745,  746,  749,  749,  117,  747,  748,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  596,  596,
			  596,  598,  598,  598,  749,  749,  749,  749,  109,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,

			   70,   70,   70,   70,   70,   70,   70,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   90,
			  749,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,  118,  118,  118, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  202,  749,  202,  202,  749,
			  202,  202,  202,  202,  202,  202,  202,  202,  202,  202,
			  202,  202,  202,  227,  227,  227,  227,  227,  227,  227,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  227,  231,  231,  231,  231,  231,  231,  231,  231,  231,
			  231,  231,  231,  231,  231,  231,  231,  231,  231,  233,
			  233,  233,  233,  233,  233,  233,  233,  233,  233,  233,
			  233,  233,  233,  233,  233,  233,  233,   92,  749,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,

			   92,   92,   92,   92,   92,   93,  749,   93,  749,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270,  270,  392,
			  749,  392,  392,  392,  392,  392,  392,  392,  392,  392,
			  392,  392,  392,  392,  392,  392,  392,  629,  629,  629,
			  629,  629,  629,  629,  629,  629,  629,  629,  629,  629,
			  629,  629,  629,  629,  629,  691,  749,  691,  691,  691,
			  691,  691,  691,  691,  691,  691,  691,  691,  691,  691,
			  691,  691,  691,   13,  749,  749,  749,  749,  749,  749, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749, yy_Dummy>>,
			1, 97, 2400)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2496)
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

			    1,    1,    1,    1,    3,    4,  739,    3,    4,   27,
			    3,    4,    5,    5,    5,   46,    5,    6,    6,    6,
			   27,    6,    9,    9,    9,   10,   10,   10,   11,   11,
			   11,   12,   12,   12,   15,   15,   15,   16,   16,   16,
			   34,   34,  656,   11,   36,   36,   12,   46,   41,   15,
			   49,   28,   16,   28,   28,   28,   28,   29,   41,   31,
			  655,   31,   31,   31,   31,   29,   52,   45,   54,    5,
			  654,   55,  124,   45,    6,   63,   63,   63,   66,   66,
			   41,  129,   49,   65,   65,   65,   67,   67,   67,  653,
			   41,  652,   42,  651,   42,   68,   68,   68,   52,   45, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   54,    5,   31,   55,   42,   45,    6,   18,   18,   74,
			   18,   18,   74,   18,  126,   18,   18,   21,   18,   78,
			   18,   48,   78,   21,   42,   21,   42,   18,  650,   18,
			   29,   18,   18,   38,   53,   43,   42,   38,   48,   43,
			   18,   93,   38,  150,   38,   18,   18,   40,   53,   38,
			   38,   40,   43,   48,   40,   18,  124,   40,   18,   18,
			   40,   18,  649,  129,   18,   38,   53,   43,  645,   38,
			   48,   43,   18,   93,   38,  150,   38,   18,   18,   40,
			   53,   38,   38,   40,   43,  227,   40,   18,  227,   40,
			   18,   18,   40,   82,   82,   82,  126,  126,   18,   18,

			   18,   18,   18,   18,   18,  139,  139,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   30,  629,
			   30,   30,   30,   30,  151,  153,   47,   44,   85,   85,
			   85,   50,   30,   30,   44,   44,   47,   51,   47,  154,
			   44,   50,   47,   86,   86,   86,   50,   51,  590,  155,
			   51,   75,   75,   75,   30,   75,  151,  153,   47,   44,
			  570,   30,  527,   50,   30,   30,   44,   44,   47,   51,
			   47,  154,   44,   50,   47,   88,   88,   88,   50,   51,
			   90,  155,   51,   90,  275,  275,   30,   73,   73,   73,
			   88,   73,   94,  518,   73,   94,   73,   73,   73,   94, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   95,  454,   96,   95,   73,   96,   97,   98,   75,   97,
			   98,   73,  231,   73,  453,  231,   73,   73,   73,   73,
			   98,   73,  123,   73,  451,   99,  393,   73,   99,   73,
			  387,   90,   73,   73,   73,   73,   73,   73,  384,  384,
			   75,  100,  101,   94,  100,  101,   99,  102,  382,  156,
			  102,   95,  103,   96,  157,  103,  105,   97,   98,  105,
			  528,  528,  100,   90,   92,   92,  125,   92,  104,   92,
			  107,  104,   92,  107,  319,   94,   99,  140,  140,  140,
			  101,  156,  158,   95,  102,   96,  157,  316,  316,   97,
			   98,  103,  100,  101,  108,  105,  110,  108,  102,  110,

			  317,  159,  160,  103,  123,  123,  123,  105,   99,  300,
			  104,  299,  101,  298,  158,  297,  102,  296,  295,  104,
			   92,  107,  107,  103,  100,  101,  294,  105,  316,  111,
			  102,  127,  111,  159,  160,  103,  106,  106,  106,  105,
			  106,  112,  104,  106,  112,  108,  163,  110,  125,  125,
			  125,  104,   92,  107,  596,  166,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,  109,  109,  109,
			  113,  109,  293,  113,  109,  118,  292,  108,  163,  110,
			  111,  291,  290,  110,  110,  110,  114,  166,  128,  114,
			  289,  106,  112,  106,  115,  167,  596,  115,  196,  196, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  196,  116,  288,  168,  116,  119,  119,  119,  119,  119,
			  119,  119,  111,  127,  127,  127,  152,  170,  111,  152,
			  287,  113,  109,  106,  112,  286,  285,  167,  112,  112,
			  112,  133,  133,  133,  133,  168,  173,  114,  137,  283,
			  137,  137,  137,  137,  164,  115,  133,  175,  152,  170,
			  121,  152,  116,  113,  109,  137,  282,  113,  113,  164,
			  281,  118,  118,  118,  118,  118,  118,  118,  173,  114,
			  128,  128,  128,  114,  114,  114,  164,  115,  133,  175,
			  176,  115,  115,  115,  116,  280,  165,  137,  116,  120,
			  165,  164,  120,  279,  120,  120,  120,  177,  197,  197,

			  197,  138,  120,  138,  138,  138,  138,  278,  598,  120,
			  273,  120,  176,  180,  120,  120,  120,  120,  165,  120,
			  181,  120,  165,  184,  238,  120,  233,  120,  202,  177,
			  120,  120,  120,  120,  120,  120,  121,  121,  121,  121,
			  121,  121,  121,  122,  138,  180,  142,  142,  142,  142,
			  598,   89,  181,   87,   79,  184,  161,  171,  174,  171,
			  161,  171,  178,  182,  183,  182,  185,  186,  183,  187,
			  174,  178,  171,  182,  161,  171,  182,  188,  182,  182,
			  120,  120,  120,  120,  120,  120,  120,  142,  161,  171,
			  174,  171,  161,  171,  178,  182,  183,  182,  185,  186, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  183,  187,  174,  178,  171,  182,  161,  171,  182,  188,
			  182,  182,  189,  190,  191,  192,  193,  189,  195,  195,
			  195,  195,  195,  195,  195,  198,  198,  198,  189,  199,
			  199,  199,  200,  200,  200,  201,  201,  201,  210,  210,
			  210,  210,   70,   69,  189,  190,  191,  192,  193,  189,
			  204,  204,  204,   64,  230,  230,  230,  204,  230,   57,
			  189,  235,  235,  235,  237,  237,  237,  242,  242,  242,
			  243,   37,  248,  243,  250,  248,  252,  250,  253,  252,
			   32,  253,  255,  322,  254,  255,  256,  254,  256,  257,
			   13,  256,  257,  258,  258,  258,  323,  258,  324,  260,

			  258,    8,  260,  272,  272,  272,  253,    7,    0,  261,
			  327,  230,  261,  263,    0,  322,  263,  274,  274,  274,
			    0,  243,  242,  248,  254,  250,  255,  252,  323,  253,
			  324,  257,    0,  255,  264,  254,    0,  264,  253,  256,
			  257,    0,  327,  230,  241,  241,  241,  241,  258,  241,
			  260,    0,  241,  243,  242,  248,  254,  250,  255,  252,
			  261,  253,    0,  257,  263,  255,    0,  254,  276,  276,
			  276,  256,  257,  265,    0,    0,  265,  277,  277,  277,
			  258,  329,  260,  266,    0,  264,  266,  284,  284,  284,
			  284,    0,  261,  304,  304,  304,  263,    0,  267,    0, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  241,  267,  303,  330,  263,  263,  263,  263,  263,  263,
			  263,    0,  268,  329,    0,  268,  328,  264,  305,  305,
			  305,  264,  264,  264,  265,  269,    0,    0,  269,  306,
			  306,  306,  241,  328,  266,  330,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,  241,    0,  328,  267,
			  307,  307,  307,  308,  308,  308,  265,  309,  309,  309,
			  265,  265,  265,  268,  331,  328,  266,  381,  381,  381,
			  266,  266,  266,    0,  332,  333,  269,  334,  318,  318,
			  318,  267,    0,  335,    0,  267,  267,  267,  303,  303,
			  303,  303,  303,  303,  303,  268,  331,    0,  336,  268,

			  268,  268,  310,  310,  310,  310,  332,  333,  269,  334,
			    0,    0,  269,  269,  269,  335,  311,  310,  311,  318,
			    0,  311,  311,  311,  311,  313,  313,  313,  313,  314,
			  336,  314,  337,  339,  314,  314,  314,  314,  341,  315,
			  313,  315,  315,  315,  315,  342,  340,  343,  320,  310,
			  320,  320,  320,  320,  321,  321,  321,  321,  344,    0,
			  340,  345,  346,    0,  337,  339,  347,  348,  349,  350,
			  341,  344,  313,  351,  352,  353,  354,  342,  340,  343,
			  355,  357,  315,  358,  359,  360,  361,  362,  360,  363,
			  344,  320,  340,  345,  346,  321,  364,  366,  347,  348, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  349,  350,  367,  344,  365,  351,  352,  353,  354,  368,
			  369,  370,  355,  357,  371,  358,  359,  360,  361,  362,
			  360,  363,  365,  372,  373,  374,  375,  376,  364,  366,
			  377,  378,  379,    0,  367,    0,  365,  383,  383,  383,
			    0,  368,  369,  370,    0,    0,  371,  385,  385,  385,
			  386,  386,  386,    0,  365,  372,  373,  374,  375,  376,
			    0,    0,  377,  378,  379,  388,  388,  388,  389,  389,
			  389,  391,  391,  391,  391,  391,  394,  394,  394,  399,
			    0,  399,  400,  401,  399,  400,  401,  402,  404,  408,
			  402,  404,  408,  410,  410,  410,  409,    0,  457,  409,

			  411,  411,  411,  412,  412,  412,  413,  413,  413,  414,
			  414,  414,  415,  415,  415,    0,  402,  458,  400,  440,
			  440,  440,  421,  421,  421,  421,  421,  441,  441,  441,
			  457,  394,  399,  400,  401,  421,  421,  459,  402,  404,
			  408,  422,  422,  422,  422,  422,    0,  409,  402,  458,
			  400,  443,  443,  443,  443,    0,  460,  421,  442,  442,
			  442,  442,    0,  394,  399,  400,  401,  421,  421,  459,
			  402,  404,  408,  442,    0,  461,  408,  408,  408,  409,
			  525,  525,  525,  409,  409,  409,  450,  450,  460,  421,
			  444,  444,  444,  444,  445,  445,  445,  445,    0,  442, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  447,  447,  447,  447,    0,  442,  446,  461,  446,  445,
			  462,  446,  446,  446,  446,  448,  448,  448,  448,  449,
			  463,  449,  449,  449,  449,  464,  455,  450,  455,  455,
			  455,  455,  456,  465,  456,  456,  456,  456,  466,  467,
			  468,  445,  462,    0,  469,  470,  471,  472,  473,  474,
			  475,  476,  463,  477,  479,  480,  481,  464,  482,  483,
			  484,  485,  449,  487,  490,  465,    0,    0,  493,  455,
			  466,  467,  468,  494,  495,  456,  469,  470,  471,  472,
			  473,  474,  475,  476,  496,  477,  479,  480,  481,  497,
			  482,  483,  484,  485,  498,  487,  490,  491,  491,  491,

			  493,  491,  499,  500,  501,  494,  495,  502,  503,  504,
			  506,  509,  491,  510,  511,  512,  496,  513,    0,  519,
			  521,  497,  519,  521,  538,    0,  498,  517,  517,  517,
			  517,  517,    0,    0,  499,  500,  501,  541,    0,  502,
			  503,  504,  506,  509,  542,  510,  511,  512,    0,  513,
			  526,  526,  526,  521,  523,    0,  538,  523,  529,  529,
			  529,    0,    0,  519,  531,  531,  531,  531,  543,  541,
			  519,  521,  532,  532,  532,  532,  542,    0,  546,  531,
			  534,  534,  534,  534,  491,  521,  533,  533,  533,  533,
			  523,  535,  535,  535,  535,  519,  548,  550,  551,  552, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  543,  533,  519,  521,  536,  523,  536,  536,  536,  536,
			  546,  531,  537,  553,  537,  537,  537,  537,  554,  555,
			  547,  536,  523,    0,  547,  556,  558,  533,  548,  550,
			  551,  552,  559,  533,  560,  561,  563,  523,  564,  565,
			  567,  571,    0,  572,  573,  553,  574,  575,  576,  577,
			  554,  555,  547,  536,  578,  537,  547,  556,  558,  568,
			  568,  568,  579,  568,  559,  581,  560,  561,  563,  582,
			  564,  565,  567,  571,  568,  572,  573,  585,  574,  575,
			  576,  577,  586,  588,    0,    0,  578,  589,  589,  589,
			  589,  589,  591,  592,  579,  591,  592,  581,  607,  593,

			    0,  582,  593,  595,  595,  595,    0,    0,  608,  585,
			  597,  597,  597,  597,  586,  588,  600,  600,  600,  600,
			    0,  599,  592,  599,  591,  609,  599,  599,  599,  599,
			  607,  600,  601,  601,  601,  601,  602,  602,  602,  602,
			  608,  611,  593,  591,  592,  595,  568,  601,  612,    0,
			  593,  613,  597,  603,  592,  603,  591,  609,  603,  603,
			  603,  603,  614,  600,  604,  617,  604,  604,  604,  604,
			  619,  620,  622,  611,  593,  591,  592,  623,  624,  601,
			  612,  604,  593,  613,  625,  626,  627,  630,  631,  633,
			  634,  636,  640,  641,  614,  643,  647,  617,    0,  647, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  666,  619,  620,  622,  646,    0,    0,  646,  623,
			  624,  648,    0,  604,  648,    0,  625,  626,  627,  630,
			  631,  633,  634,  636,  640,  641,    0,  643,  644,  644,
			  644,  644,  644,  666,  646,  657,  657,  657,  657,  647,
			  648,  658,  658,  658,  658,  667,  669,  647,  659,  659,
			  659,  659,  660,  671,  660,  672,  646,  660,  660,  660,
			  660,  673,  648,  659,    0,    0,  646,    0,  661,    0,
			  661,  647,  648,  661,  661,  661,  661,  667,  669,  647,
			  674,  662,  662,  662,  662,  671,  677,  672,  646,  663,
			  663,  663,  663,  673,  648,  659,  662,  664,  664,  664,

			  664,  665,  680,  665,  681,  683,  665,  665,  665,  665,
			  684,  685,  674,  682,  682,  682,  687,  688,  677,  690,
			  690,  690,  690,  690,  692,  699,  693,  692,  662,  693,
			  694,    0,    0,  694,  680,    0,  681,  683,  700,  700,
			  700,  700,  684,  685,  682,    0,    0,  709,  687,  688,
			    0,  699,  701,  701,  701,  701,    0,  699,  702,  702,
			  702,  702,  692,  703,  703,  703,  703,  704,  704,  704,
			  704,  706,  706,  706,  706,  692,  682,  693,  705,  709,
			  705,  694,  704,  705,  705,  705,  705,  707,  707,  707,
			  707,  712,  716,  719,  692,  718,  718,  718,  720,  722, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  725,  725,  725,  725,  725,  726,  729,  692,  726,  693,
			  733,  735,  736,  694,  704,  730,  730,  730,  730,  731,
			  731,  731,  731,  712,  716,  719,  718,  742,  743,  744,
			  720,  722,  729,  745,  746,  766,  766,  766,  729,  767,
			  767,  767,  733,  735,  736,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,    0,    0,  726,    0,  718,  742,
			  743,  744,    0,    0,  756,  745,  746,  756,  756,  756,
			  756,  756,  756,  756,  756,  756,  756,  756,  769,  769,
			  769,  770,  770,  770,    0,    0,    0,    0,  726,  750,
			  750,  750,  750,  750,  750,  750,  750,  750,  750,  750,

			  750,  750,  750,  750,  750,  750,  750,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  752,  752,  752,  752,  752,
			  752,  752,  752,  752,  752,  752,  752,  752,  752,  752,
			  752,  752,  752,  753,  753,  753,  753,  753,  753,  753,
			  753,  753,  753,  753,  753,  753,  753,  753,  753,  753,
			  753,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  755,
			    0,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  757,  757,  757, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  757,  757,  757,  757,  757,  757,  757,  757,  757,  757,
			  757,  757,  757,  757,  757,  759,    0,  759,  759,    0,
			  759,  759,  759,  759,  759,  759,  759,  759,  759,  759,
			  759,  759,  759,  760,  760,  760,  760,  760,  760,  760,
			  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
			  760,  761,  761,  761,  761,  761,  761,  761,  761,  761,
			  761,  761,  761,  761,  761,  761,  761,  761,  761,  762,
			  762,  762,  762,  762,  762,  762,  762,  762,  762,  762,
			  762,  762,  762,  762,  762,  762,  762,  763,    0,  763,
			  763,  763,  763,  763,  763,  763,  763,  763,  763,  763,

			  763,  763,  763,  763,  763,  764,    0,  764,    0,  764,
			  764,  764,  764,  764,  764,  764,  764,  764,  764,  764,
			  764,  764,  764,  765,  765,  765,  765,  765,  765,  765,
			  765,  765,  765,  765,  765,  765,  765,  765,  765,  768,
			    0,  768,  768,  768,  768,  768,  768,  768,  768,  768,
			  768,  768,  768,  768,  768,  768,  768,  771,  771,  771,
			  771,  771,  771,  771,  771,  771,  771,  771,  771,  771,
			  771,  771,  771,  771,  771,  772,    0,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  749,  749,  749,  749,  749,  749,  749, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749, yy_Dummy>>,
			1, 97, 2400)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 772)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			yy_base_template_4 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  101,  102,  110,  115,  904,  898,  120,
			  123,  126,  129,  890, 2393,  132,  135, 2393,  201,    0,
			 2393,  214, 2393, 2393, 2393, 2393, 2393,   92,  133,  138,
			  300,  141,  853, 2393,  114, 2393,  117,  844,  200,    0,
			  209,  113,  150,  204,  291,  128,   70,  294,  190,  115,
			  296,  299,  122,  203,  130,  126, 2393,  801, 2393, 2393,
			 2393, 2393, 2393,   82,  758,   90,   85,   93,  102,  750,
			  836, 2393, 2393,  385,  206,  349, 2393, 2393,  216,  751,
			 2393, 2393,  291, 2393, 2393,  326,  341,  736,  373,  734,
			  374, 2393,  463,  184,  386,  394,  396,  400,  401,  419,

			  435,  436,  441,  446,  462,  450,  534,  464,  488,  565,
			  490,  523,  535,  564,  580,  588,  595,    0,  564,  508,
			  683,  639,  732,  411,  161,  455,  203,  520,  577,  170,
			 2393, 2393, 2393,  611, 2393, 2393, 2393,  620,  683,  285,
			  457,    0,  726, 2393, 2393, 2393, 2393, 2393, 2393,    0,
			  195,  289,  577,  291,  290,  299,  414,  423,  438,  466,
			  454,  724,    0,  497,  610,  640,  513,  564,  558,    0,
			  571,  723,    0,  595,  725,  597,  631,  663,  729,    0,
			  665,  685,  729,  722,  680,  718,  732,  718,  731,  778,
			  765,  775,  780,  768, 2393,  721,  505,  605,  732,  736, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  739,  742,  722, 2393,  848, 2393, 2393, 2393, 2393, 2393,
			  818, 2393, 2393, 2393, 2393, 2393, 2393, 2393, 2393, 2393,
			 2393, 2393, 2393, 2393, 2393, 2393, 2393,  282, 2393, 2393,
			  852,  409, 2393,  723, 2393,  859, 2393,  862,  717, 2393,
			 2393,  943,  865,  864, 2393, 2393, 2393, 2393,  866, 2393,
			  868, 2393,  870,  872,  878,  876,  882,  883,  891, 2393,
			  893,  903, 2393,  907,  928,  967,  977,  992, 1006, 1019,
			 2393, 2393,  810,  615,  824,  291,  875,  884,  614,  682,
			  674,  649,  645,  628,  967,  615,  614,  609,  591,  579,
			  571,  570,  565,  561,  515,  507,  506,  504,  502,  500,

			  498, 2393, 2393,  991,  900,  925,  936,  957,  960,  964,
			 1082, 1101, 2393, 1105, 1114, 1121,  467,  439, 1058,  413,
			 1130, 1134,  838,  852,  867,    0,    0,  871,  985,  948,
			  954, 1012, 1043, 1027, 1026, 1048, 1067, 1097,    0, 1082,
			 1115, 1103, 1096, 1097, 1115, 1119, 1127, 1127, 1132, 1122,
			 1138, 1138, 1143, 1129, 1141, 1135,    0, 1146, 1128, 1134,
			 1152, 1151, 1152, 1158, 1145, 1171, 1149, 1167, 1178, 1175,
			 1172, 1170, 1188, 1182, 1190, 1179, 1188, 1191, 1197, 1188,
			    0,  974,  353, 1144,  345, 1154, 1157,  337, 1172, 1175,
			 2393, 1252,    0,  352, 1274, 2393, 2393, 2393, 2393, 1275, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1276, 1277, 1281, 2393, 1282, 2393, 2393, 2393, 1283, 1290,
			 1200, 1207, 1210, 1213, 1216, 1219, 2393, 2393, 2393, 2393,
			 2393, 1303, 1322, 2393, 2393, 2393, 2393, 2393, 2393, 2393,
			 2393, 2393, 2393, 2393, 2393, 2393, 2393, 2393, 2393, 2393,
			 1226, 1234, 1338, 1331, 1370, 1374, 1391, 1380, 1395, 1401,
			 1366,  363,    0,  353,  383, 1408, 1414, 1249, 1267, 1288,
			 1319, 1342, 1371, 1379, 1376, 1398, 1388, 1404, 1403, 1396,
			 1412, 1407, 1399, 1404, 1401, 1402, 1416, 1402,    0, 1419,
			 1416, 1402, 1404, 1411, 1425, 1413,    0, 1421,    0,    0,
			 1422, 1495,    0, 1429, 1422, 1435, 1448, 1441, 1451, 1463,

			 1452, 1462, 1452, 1475, 1461,    0, 1464,    0,    0, 1476,
			 1477, 1463, 1473, 1486,    0,    0, 2393, 1508,  322, 1513,
			 2393, 1514, 2393, 1548, 2393, 1287, 1457,  351,  440, 1538,
			    0, 1544, 1552, 1566, 1560, 1571, 1586, 1594, 1475,    0,
			    0, 1493, 1506, 1536,    0,    0, 1530, 1585, 1552,    0,
			 1549, 1560, 1563, 1578, 1584, 1569, 1581,    0, 1578, 1588,
			 1599, 1596,    0, 1597, 1605, 1600,    0, 1605, 1657, 2393,
			  343, 1610, 1595, 1590, 1607, 1612, 1613, 1601, 1619, 1612,
			    0, 1615, 1638,    0,    0, 1638, 1647,    0, 1639, 1668,
			  272, 1686, 1687, 1693, 2393, 1684,  535, 1691,  689, 1706, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1696, 1712, 1716, 1738, 1746,    0,    0, 1663, 1657, 1675,
			    0, 1696, 1698, 1716, 1731,    0,    0, 1730,    0, 1739,
			 1736,    0, 1723, 1733, 1728, 1734, 1754, 1736, 2393,  316,
			 1745, 1739,    0, 1745, 1746,    0, 1756,    0,    0,    0,
			 1742, 1749,    0, 1745, 1809,  201, 1799, 1790, 1805,  251,
			  209,  182,  130,  178,  151,  149,   81, 1815, 1821, 1828,
			 1837, 1853, 1861, 1869, 1877, 1886, 1767, 1795,    0, 1802,
			    0, 1819, 1823, 1827, 1838,    0,    0, 1849,    0,    0,
			 1858, 1869, 1911, 1860, 1875, 1878,    0, 1881, 1882,    0,
			 1900,    0, 1918, 1920, 1924, 2393, 2393, 2393, 2393, 1890,

			 1918, 1932, 1938, 1943, 1947, 1963, 1951, 1967,    0, 1912,
			    0,    0, 1949,    0,    0,    0, 1942,    0, 1993, 1951,
			 1950,    0, 1964,    0,    0, 1981, 1999, 2393, 2393, 1971,
			 1995, 1999,    0, 1975,    0, 1969, 1981,    0,    0,   87,
			 2393,    0, 1996, 1979, 1980, 1984, 1985,    0, 2393, 2393,
			 2088, 2106, 2124, 2142, 2160, 2178, 2061, 2196, 2039, 2214,
			 2232, 2250, 2268, 2286, 2304, 2322, 2029, 2033, 2338, 2072,
			 2075, 2356, 2374, yy_Dummy>>,
			1, 173, 600)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 772)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			yy_def_template_3 (an_array)
			yy_def_template_4 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  749,    1,  750,  750,  751,  751,  752,  752,  753,
			  753,  754,  754,  749,  749,  749,  749,  749,  755,  756,
			  749,  757,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  759,  749,  749,  749,  760,  760,  749,  749,  761,  762,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  755,  749,  763,  764,  755,  755,  755,  755,  755,  755,

			  755,  755,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  756,  765,  765,
			  765,  765,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  766,
			  766,  767,  749,  749,  749,  749,  749,  749,  749,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  749,  749,  749,  749,  749,  749, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  749,  749,  759,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  760,  749,  749,
			  760,  761,  749,  762,  749,  749,  749,  749,  768,  749,
			  749,  763,  764,  755,  749,  749,  749,  749,  755,  749,
			  755,  749,  755,  755,  755,  755,  755,  755,  755,  749,
			  755,  755,  749,  755,  755,  755,  755,  755,  755,  755,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,

			  749,  749,  749,  765,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  766,  766,  766,  767,
			  749,  749,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  768,  768,  764,  749,  749,  749,  749,  755, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  755,  755,  755,  749,  755,  749,  749,  749,  755,  755,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  766,  766,  318,  767,  749,  749,  749,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,

			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  749,  749,  768,  755,
			  749,  755,  749,  755,  749,  749,  749,  749,  769,  769,
			  770,  749,  749,  749,  749,  749,  749,  749,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  749,  749,
			  749,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  749,
			  768,  755,  755,  755,  749,  769,  769,  769,  770,  749, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  749,  749,  749,  749,  749,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  749,  771,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  749,  768,  755,  755,  755,  749,
			  595,  749,  769,  749,  597,  749,  770,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  749,  772,  755,  755,  755,  749,  749,  749,  749,  749,

			  749,  749,  749,  749,  749,  749,  749,  749,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  749,  758,
			  758,  758,  758,  758,  758,  749,  755,  749,  749,  749,
			  749,  749,  758,  758,  758,  749,  758,  758,  758,  749,
			  749,  758,  749,  758,  749,  758,  749,  758,  749,    0,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749, yy_Dummy>>,
			1, 173, 600)
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
			   95,   95,   96,   96,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   98,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  100,  101,  101,
			   96,  102,  102,  102,  103,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,    1, yy_Dummy>>,
			1, 57, 200)
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
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 750)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			yy_accept_template_4 (an_array)
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
			  184,  186,  188,  190,  192,  194,  197,  199,  201,  202,
			  202,  203,  204,  205,  205,  206,  207,  208,  209,  210,

			  211,  212,  213,  214,  215,  216,  217,  219,  220,  221,
			  223,  224,  225,  226,  227,  228,  229,  230,  231,  232,
			  233,  234,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  236,  237,  238,  239,  240,  241,  242,  243,  244,
			  244,  244,  244,  244,  245,  246,  247,  248,  249,  250,
			  251,  252,  253,  254,  255,  257,  258,  259,  260,  261,
			  262,  263,  264,  266,  267,  268,  269,  270,  271,  272,
			  274,  275,  276,  278,  279,  280,  281,  282,  283,  284,
			  286,  287,  288,  289,  290,  291,  292,  293,  294,  295,
			  296,  297,  298,  299,  300,  301,  302,  302,  302,  302, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  302,  302,  302,  303,  304,  304,  305,  306,  307,  308,
			  309,  309,  310,  311,  312,  313,  314,  315,  316,  317,
			  318,  319,  320,  321,  322,  323,  324,  325,  326,  327,
			  328,  329,  330,  332,  333,  334,  334,  335,  336,  337,
			  338,  340,  342,  343,  344,  346,  348,  350,  352,  353,
			  355,  356,  358,  359,  360,  361,  362,  363,  364,  365,
			  366,  367,  368,  370,  371,  372,  373,  374,  375,  376,
			  377,  378,  380,  380,  380,  380,  380,  380,  380,  380,
			  381,  382,  383,  384,  385,  386,  387,  388,  389,  390,
			  391,  392,  393,  394,  395,  396,  397,  398,  399,  400,

			  401,  402,  404,  405,  406,  406,  406,  406,  406,  406,
			  406,  407,  407,  408,  409,  409,  410,  412,  413,  415,
			  416,  417,  417,  418,  419,  420,  422,  424,  425,  426,
			  427,  428,  429,  430,  431,  432,  433,  434,  435,  437,
			  438,  439,  440,  441,  442,  443,  444,  445,  446,  447,
			  448,  449,  450,  451,  452,  454,  455,  457,  458,  459,
			  460,  461,  462,  463,  464,  465,  466,  467,  468,  469,
			  470,  471,  472,  473,  474,  475,  476,  477,  478,  479,
			  480,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  483,  483,  484,  485,  485,  487,  489,  491,  493, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  494,  495,  496,  497,  499,  500,  502,  504,  506,  507,
			  508,  508,  508,  508,  508,  508,  508,  509,  510,  511,
			  512,  513,  514,  515,  516,  517,  518,  519,  520,  521,
			  522,  523,  524,  525,  526,  527,  528,  529,  530,  531,
			  533,  533,  533,  534,  534,  535,  536,  536,  536,  537,
			  538,  538,  538,  538,  538,  538,  539,  540,  541,  542,
			  543,  544,  545,  546,  547,  548,  549,  550,  551,  552,
			  553,  554,  556,  557,  558,  559,  560,  561,  562,  564,
			  565,  566,  567,  568,  569,  570,  571,  573,  574,  576,
			  578,  579,  581,  583,  584,  585,  586,  587,  588,  589,

			  590,  591,  592,  593,  594,  595,  597,  598,  600,  602,
			  603,  604,  605,  606,  607,  609,  611,  612,  612,  613,
			  614,  616,  617,  619,  620,  622,  622,  622,  623,  623,
			  623,  623,  624,  624,  625,  625,  626,  627,  628,  629,
			  631,  633,  634,  635,  636,  638,  640,  641,  642,  643,
			  645,  646,  647,  648,  649,  650,  651,  652,  654,  655,
			  656,  657,  658,  660,  661,  662,  663,  665,  666,  666,
			  667,  667,  668,  669,  670,  671,  672,  673,  674,  675,
			  676,  678,  679,  680,  682,  684,  685,  686,  688,  689,
			  689,  690,  691,  692,  693,  694,  694,  694,  694,  694, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  694,  695,  696,  696,  696,  697,  699,  701,  702,  703,
			  704,  706,  707,  708,  709,  710,  712,  714,  715,  717,
			  718,  719,  721,  722,  723,  724,  725,  726,  727,  728,
			  728,  729,  730,  732,  733,  734,  736,  737,  739,  741,
			  743,  744,  745,  747,  748,  748,  749,  750,  751,  752,
			  752,  752,  752,  752,  752,  752,  752,  752,  752,  753,
			  754,  754,  754,  755,  755,  756,  756,  757,  758,  760,
			  761,  763,  764,  765,  766,  767,  769,  771,  772,  774,
			  776,  777,  778,  779,  780,  781,  782,  784,  785,  786,
			  788,  788,  790,  791,  792,  793,  795,  796,  798,  799,

			  800,  800,  801,  801,  802,  803,  803,  803,  804,  806,
			  807,  809,  811,  812,  814,  816,  818,  819,  821,  821,
			  822,  823,  825,  826,  828,  830,  830,  831,  833,  835,
			  836,  836,  837,  839,  840,  842,  842,  843,  845,  847,
			  847,  849,  851,  851,  852,  852,  853,  853,  855,  856,
			  856, yy_Dummy>>,
			1, 151, 600)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 855)
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
			  217,  218,  217,  218,  190,  218,  216,  218,  214,  218,
			  215,  218,  186,  218,  186,  218,  185,  218,  184,  218,
			  186,  218,  188,  218,  187,  218,  182,  218,  182,  218,
			  181,  218,    6,  218,    5,    6,  218,    5,  218,    6, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  218,    1,  189,  178,  189,  189,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189, -398,  189,
			  189,  189, -398,  189,  189,  189,  189,  189,  189,  189,
			   41,  154,  154,  154,  154,    2,   35,   10,  124,   39,
			   23,   22,  124,  118,   15,   37,   20,   21,   38,   16,
			  117,  117,  117,  117,  117,   48,  117,  117,  117,  117,
			  117,  117,  117,  117,   61,  117,  117,  117,  117,  117,
			  117,  117,   73,  117,  117,  117,   80,  117,  117,  117,
			  117,  117,  117,  117,   92,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,

			   40,   42,  190,  214,  207,  205,  206,  208,  209,  210,
			  211,  191,  192,  193,  194,  195,  196,  197,  198,  199,
			  200,  201,  202,  203,  204,  186,  185,  184,  186,  186,
			  183,  184,  188,  187,  181,    5,    4,  179,  176,  179,
			  189, -398, -398,  189,  162,  179,  160,  179,  161,  179,
			  163,  179,  189,  156,  179,  189,  157,  179,  189,  189,
			  189,  189,  189,  189,  189, -180,  189,  189,  164,  179,
			  189,  189,  189,  189,  189,  189,  189,  154,  125,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
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

			  167,  179,  166,  179,  177,  179,  189,  189,  144,  142,
			  143,  145,  146,  155,  155,  147,  148,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,  140,
			  141,  126,  154,  124,  124,  124,  124,  118,  118,  118,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,   62,  117,  117,  117,  117,  117,
			  117,  117,   71,  117,  117,  117,  117,  117,  117,  117,
			  117,   81,  117,  117,   83,  117,   85,  117,  117,   90,
			  117,   91,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  105,  117,  117,  107,  117, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  108,  117,  117,  117,  117,  117,  117,  114,  117,  115,
			  117,  212,    4,  189,  169,  179,  189,  172,  179,  189,
			  175,  179,  155,  124,  124,  124,  124,  118,  117,   44,
			  117,   45,  117,  117,  117,  117,   52,  117,   53,  117,
			  117,  117,  117,   58,  117,  117,  117,  117,  117,  117,
			  117,  117,   69,  117,  117,  117,  117,  117,   76,  117,
			  117,  117,  117,   82,  117,  117,   88,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  102,  117,  117,  117,
			  106,  117,  109,  117,  117,  117,  112,  117,  117,    4,
			  189,  189,  189,  149,  124,  124,  124,   43,  117,   49,

			  117,  117,  117,  117,   55,  117,  117,  117,  117,  117,
			   63,  117,   65,  117,  117,   67,  117,  117,  117,   72,
			  117,  117,  117,  117,  117,  117,  117,   89,  117,  117,
			   95,  117,  117,  117,   98,  117,  117,  100,  117,  101,
			  117,  103,  117,  117,  117,  111,  117,  117,    4,  189,
			  189,  189,  124,  124,  124,  124,  117,  117,   54,  117,
			  117,   57,  117,  117,  117,  117,  117,   70,  117,   74,
			  117,  117,   77,  117,   78,  117,  117,  117,  117,  117,
			  117,  117,   99,  117,  117,  117,  113,  117,    3,    4,
			  189,  189,  189,  152,  153,  153,  151,  153,  150,  124, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  124,  124,  124,  124,   50,  117,  117,   56,  117,   59,
			  117,  117,   66,  117,   68,  117,   75,  117,  117,   86,
			  117,  117,  117,   96,  117,  117,  104,  117,  110,  117,
			  189,  171,  179,  174,  179,  124,  124,   51,  117,  117,
			   79,  117,  117,   94,  117,   97,  117,  170,  179,   60,
			  117,  117,  117,   93,  117,   93, yy_Dummy>>,
			1, 56, 800)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2393
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 749
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 750
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
