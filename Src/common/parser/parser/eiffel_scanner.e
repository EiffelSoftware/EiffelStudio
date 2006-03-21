indexing

	description: "Scanners for Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit
	EIFFEL_SCANNER_SKELETON

	STRING_HANDLER

create
	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= PRAGMA)
		end

feature {NONE} -- Implementation

	yy_build_tables is
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

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 38 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 38")
end
 ast_factory.create_break_as (Current)  
when 2 then
	yy_end := yy_end - 2
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 40 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 40")
end
 
				last_break_as_start_position := position
				last_break_as_start_line := line
				last_break_as_start_column := column
				ast_factory.set_buffer (token_buffer2, Current)
				set_start_condition (PRAGMA)					
		
when 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 49 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 49")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 54 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 54")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 58 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 58")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 62 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 62")
end

			less (0)
			ast_factory.create_break_as_with_data (token_buffer2, 
																last_break_as_start_line, 
																last_break_as_start_column, 
																last_break_as_start_position, 
																token_buffer2.count)
			set_start_condition (INITIAL)						
		
when 7 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 84 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 84")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 88 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 88")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 92 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 92")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
when 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 96 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 96")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 100 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 100")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 104 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 104")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 13 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 108 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 108")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CURLYTILDE, Current)
				last_token := TE_CURLYTILDE
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 112 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 112")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 116 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 116")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 120 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 120")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 17 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 124 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 124")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
when 18 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 128 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 128")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 132 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 132")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 20 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 136 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 136")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 21 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 140 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 140")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 144 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 144")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 23 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 148 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 148")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 152 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 152")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 156 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 156")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 160 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 160")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 164 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 164")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 168 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 168")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 172 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 172")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 176 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 176")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 180 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 180")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 184 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 184")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 188 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 188")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 192 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 192")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 196 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 196")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 36 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 200 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 200")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 204 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 204")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 38 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 208 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 208")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 39 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 212 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 212")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 40 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 216 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 216")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 41 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 224 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 224")
end

				last_token := TE_FREE
				process_id_as
			
when 42 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 232 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 232")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 43 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 236 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 236")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 240 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 240")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 244 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 244")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 46 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 248 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 248")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 47 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 252 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 252")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_keyword_as_id_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
when 48 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 259 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 259")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 49 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 268 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 268")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
			
when 50 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 272 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 272")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 276 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 276")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 52 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 280 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 280")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 53 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 284 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 284")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 54 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 288 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 288")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
when 55 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 292 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 292")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 56 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 296 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 296")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 57 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 300 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 300")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
when 58 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 304 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 304")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 59 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 308 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 308")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 60 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 312 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 312")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 61 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 316 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 316")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 62 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 320 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 320")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 63 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 324 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 324")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 64 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 328 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 328")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 65 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 332 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 332")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 336 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 336")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 67 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 340 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 340")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 68 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 344 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 344")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 69 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 348 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 348")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 70 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 352 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 352")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 356 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 356")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 72 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 360 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 360")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
when 73 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 364 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 364")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 74 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 368 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 368")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 75 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 372 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 372")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 76 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 376 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 376")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 77 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 380 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 380")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
when 78 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 384 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 384")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 79 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 388 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 388")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 80 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 392 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 392")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 81 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 396 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 396")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 82 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 400 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 400")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 83 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 409 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 409")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 84 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 413 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 413")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 85 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 429 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 429")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 86 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 433 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 433")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
when 87 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 440 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 440")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 88 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 89 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 453 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 453")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 90 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 457 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 457")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 91 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 461 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 461")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 92 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 465 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 465")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 93 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 469 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 469")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 94 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 473 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 473")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 477 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 477")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 96 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 481 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 481")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 97 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 485 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 485")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 489 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 489")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 99 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 493 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 493")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 497 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 497")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 101 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 501 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 501")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 505 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 505")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 103 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 509 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 509")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 513 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 513")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 105 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 517 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 517")
end

				last_token := TE_TUPLE
				process_id_as
			
when 106 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 521 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 521")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 107 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 525 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 525")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 108 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 529 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 529")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 109 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 533 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 533")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 110 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 537 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 537")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 111 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 541 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 541")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 112 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 545 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 545")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 553 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 553")
end

				last_token := TE_ID
				process_id_as
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 560 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 560")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)
			
when 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 568 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 568")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 116 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 569 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 569")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 581 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 581")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 118 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 589 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 589")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end				
				last_token := TE_REAL
			
when 119 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 601 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 601")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 120 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 607 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 607")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 614 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 614")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 632 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 632")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 638 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 638")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 644 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 644")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 650 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 650")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 656 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 656")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 662 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 662")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 668 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 668")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 674 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 674")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 680 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 680")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 686 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 686")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 692 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 692")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 698 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 698")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 704 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 704")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 710 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 710")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 716 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 716")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 722 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 722")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 728 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 728")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 734 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 734")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 142 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 740 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 740")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 143 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 144 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 744 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 744")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 753 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 753")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 757 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 757")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 147 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 761 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 761")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 148 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 765 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 765")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 149 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 769 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 769")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 150 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 773 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 773")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 151 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 777 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 777")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 152 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 781 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 781")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 153 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 785 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 785")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 154 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 789 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 789")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 793 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 793")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 156 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 797 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 797")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 157 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 801 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 801")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 158 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 807 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 807")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 159 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 813 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 813")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 160 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 161 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 825 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 825")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 162 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 831 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 831")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 163 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 164 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 843 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 843")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 165 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 852 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 852")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 166 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 858 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 858")
end

					-- Regular string.
				string_position := position
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 167 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 869 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 869")
end

					-- Verbatim string.
				string_position := position
				verbatim_start_position := position
				token_buffer.clear_all
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				ast_factory.set_buffer (token_buffer2, Current)				
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				set_start_condition (VERBATIM_STR3)
			
when 168 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 887 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 887")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 169 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 891 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 891")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 911 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 911")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if is_verbatim_string_closer then
					set_start_condition (INITIAL)
						-- Remove the trailing new-line.
					if token_buffer.count >= 2 then
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
						token_buffer.clear_all
					end
					if verbatim_marker.item (1) = ']' then
						if not has_old_verbatim_strings then
							align_left (token_buffer)
						end
						if has_old_verbatim_strings_warning then
							Error_handler.insert_warning (
								create {SYNTAX_WARNING}.make (line, column, filename,
									once "Default verbatim string handling is changed to follow standard semantics %
									%with alignment instead of previous non-standard one without alignment."))
						end
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
						if token_buffer.count > maximum_string_length then
							report_too_long_string (token_buffer)
						end
					end
				else
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 954 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 954")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 172 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 959 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 959")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 967 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 967")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 174 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 983 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 983")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 175 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 992 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 992")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 176 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1005 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1005")
end

					-- String with special characters.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				string_start_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1017 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1017")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1021 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1021")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%A")
				token_buffer.append_character ('%A')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1025 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1025")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%B")
				token_buffer.append_character ('%B')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1029 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1029")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%C")
				token_buffer.append_character ('%C')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1033 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1033")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%D")
				token_buffer.append_character ('%D')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1037 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1037")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%F")
				token_buffer.append_character ('%F')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1041 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1041")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%H")
				token_buffer.append_character ('%H')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1045 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1045")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%L")
				token_buffer.append_character ('%L')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1049 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1049")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%N")
				token_buffer.append_character ('%N')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1053 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1053")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%Q")
				token_buffer.append_character ('%Q')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1057 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1057")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%R")
				token_buffer.append_character ('%R')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1061 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1061")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%S")
				token_buffer.append_character ('%S')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1065 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1065")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%T")
				token_buffer.append_character ('%T')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1069 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1069")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%U")
				token_buffer.append_character ('%U')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1073 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1073")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%V")
				token_buffer.append_character ('%V')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1077 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1077")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%%")
				token_buffer.append_character ('%%')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1081 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1081")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%'")
				token_buffer.append_character ('%'')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1085 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1085")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%"")
				token_buffer.append_character ('%"')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1089 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1089")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%(")
				token_buffer.append_character ('%(')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1093 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1093")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%)")
				token_buffer.append_character ('%)')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1097 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1097")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%<")
				token_buffer.append_character ('%<')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1101 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1101")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%>")
				token_buffer.append_character ('%>')
			
when 199 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1105 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1105")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 200 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1109 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1109")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 201 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1114 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1114")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
			
when 202 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1130 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1130")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 203 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1136 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1136")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 204 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1154 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1154")
end

				report_unknown_token_error (text_item (1))
			
when 205 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

				terminate
			
when 1 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 2 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 3 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 4 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 5 then
--|#line 0 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 0")
end
					
			ast_factory.create_break_as_with_data (token_buffer2, 
																last_break_as_start_line, 
																last_break_as_start_column, 
																last_break_as_start_position, 
																token_buffer2.count)
			set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   14,   15,   16,   15,   17,   18,   19,   20,   14,
			   19,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   19,
			   39,   40,   41,   42,   43,   44,   45,   45,   46,   45,
			   45,   47,   45,   48,   49,   50,   45,   51,   52,   53,
			   54,   55,   56,   57,   45,   45,   58,   59,   60,   61,
			   14,   14,   39,   40,   41,   42,   43,   44,   45,   45,
			   46,   45,   45,   47,   45,   48,   49,   50,   45,   51,
			   52,   53,   54,   55,   56,   57,   45,   45,   62,   19,
			   63,   64,   66,   66,  198,   67,   67,  199,   68,   68,

			   70,   71,   70,  578,   72,   70,   71,   70,  474,   72,
			   77,   78,   77,   77,   78,   77,   80,   81,   80,   80,
			   81,   80,   83,   83,   83,   83,   83,   83,  106,  108,
			  107,   82,  121,  122,   82,  112,  543,   84,  132,  109,
			   84,  110,  113,  111,  111,  111,  152,  114,  138,  115,
			  115,  116,  123,  124,  159,  165,   73,  430,  139,  157,
			  117,   73,  198,  528,  114,  202,  115,  115,  116,  114,
			  132,  116,  116,  116,  500,  496,  158,  117,  152,  259,
			  138,  371,  118,  205,  206,  205,  159,  165,   73,  119,
			  139,  157,  117,   73,   86,   87,  432,   88,   87,  207,

			  207,  207,   89,   90,  371,   91,  119,   92,  158,  117,
			  168,  119,  361,   93,  118,   94,  127,   87,   95,  150,
			  133,  128,  160,  129,  134,  151,   96,  135,  130,  131,
			  136,   97,   98,  137,  140,  360,  141,  161,  169,  359,
			  358,   99,  168,  212,  100,  101,  142,  102,  127,  357,
			   95,  150,  133,  128,  160,  129,  134,  151,   96,  135,
			  130,  131,  136,   97,   98,  137,  140,  143,  141,  161,
			  169,  144,  146,   99,  166,  212,  103,   87,  142,  147,
			  148,  153,  162,  267,  145,  149,  209,  270,  167,   88,
			  356,  154,  163,  155,  271,  164,  272,  156,  355,  143,

			  207,  207,  207,  144,  146,  354,  166,   83,   83,   83,
			  353,  147,  148,  153,  162,  267,  145,  149,  198,  270,
			  167,  199,   84,  154,  163,  155,  271,  164,  272,  156,
			  174,  174,  174,  352,  175,  213,  103,  176,   88,  177,
			  178,  179,  200,  198,  200,  214,  199,  180,   88,   85,
			   85,  351,   85,  181,  210,  182,  350,   88,  183,  184,
			  185,  186,  349,  187,  215,  188,  348,   88,  103,  189,
			  216,  190,  347,   88,  191,  192,  193,  194,  195,  196,
			  346,  218,  344,  217,   88,  103,  343,  220,  209,  231,
			   88,   88,   88,  209,  209,  103,   88,   88,  201,  209,

			  342,  219,   88,  209,  211,  209,   88,  221,   88,  341,
			  273,  227,  228,  227,  103,  209,  268,  103,   88,  269,
			  103,  340,  265,  265,  265,  222,  274,  103,  275,  223,
			  201,  103,  224,  257,  257,  257,  211,  103,  103,  103,
			  225,  226,  273,  103,  103,  276,  103,  258,  268,  103,
			  327,  269,  103,  103,  204,  103,  230,  222,  274,  277,
			  275,  223,  266,  103,  224,  103,  173,  229,  256,  103,
			  103,  103,  225,  226,  233,  103,  103,  276,  278,  258,
			  281,  103,  227,  228,  227,  103,  209,  103,  282,   88,
			  259,  277,  260,  260,  260,  279,  286,  103,  114,  280,

			  262,  262,  263,  283,  108,  114,  261,  263,  263,  263,
			  278,  117,  281,  284,  287,  208,  288,  285,  289,  295,
			  282,  296,  298,  204,  299,  173,  300,  279,  286,  303,
			  301,  280,  304,  297,  313,  283,  103,  171,  261,  302,
			  119,  198,  170,  117,  202,  284,  287,  119,  288,  285,
			  289,  295,  314,  296,  298,  290,  299,  291,  300,  292,
			  315,  303,  301,  125,  304,  297,  313,  316,  103,  234,
			  293,  302,  235,  294,  236,  237,  238,  120,  174,  174,
			  174,  626,  239,   75,  314,  324,  320,  290,  240,  291,
			  241,  292,  315,  242,  243,  244,  245,  311,  246,  316,

			  247,  312,  293,  317,  248,  294,  249,  321,  318,  250,
			  251,  252,  253,  254,  255,  305,  322,  306,  320,  319,
			  323,  325,  325,  325,   75,  307,  626,  626,  308,  311,
			  309,  310,  626,  312,  626,  317,  205,  206,  205,  321,
			  318,  200,  198,  200,  626,  199,  626,  305,  322,  306,
			  626,  319,  323,  207,  207,  207,  329,  307,  330,   88,
			  308,   88,  309,  310,   85,  227,  228,  227,  331,  210,
			  375,   88,   88,  328,  228,  328,  209,  626,  209,   88,
			  209,   88,  335,   88,  336,  626,  626,   88,  227,  228,
			  227,  209,  209,  338,   88,   88,   88,  201,  339,  376,

			  626,   88,  375,  332,  377,  378,  103,  379,  103,  345,
			  345,  345,  114,  380,  369,  369,  370,  333,  103,  211,
			  381,  382,  626,  334,  383,  117,  103,  212,  103,  201,
			  103,  376,  337,  384,  103,  332,  377,  378,  103,  379,
			  103,  103,  103,  103,  385,  380,  386,  626,  103,  333,
			  103,  211,  381,  382,  119,  334,  383,  117,  103,  212,
			  103,  626,  103,  626,  337,  384,  103,  362,  362,  362,
			  374,  374,  374,  103,  103,  103,  385,  363,  386,  363,
			  103,  258,  364,  364,  364,  365,  365,  365,  367,  387,
			  367,  390,  391,  368,  368,  368,  392,  388,  114,  366,

			  370,  370,  370,  372,  393,  373,  373,  373,  626,  395,
			  266,  389,  396,  258,  397,  398,  399,  394,  400,  401,
			  402,  387,  403,  390,  391,  404,  405,  406,  392,  388,
			  407,  366,  408,  411,  409,  412,  393,  410,  413,  414,
			  119,  395,  415,  389,  396,  266,  397,  398,  399,  394,
			  400,  401,  402,  417,  403,  418,  419,  404,  405,  406,
			  416,  420,  407,  421,  408,  411,  409,  412,  422,  410,
			  413,  414,  423,  424,  415,  425,  426,  427,  428,  429,
			  430,  431,  431,  431,  626,  417,  626,  418,  419,  328,
			  228,  328,  416,  420,  433,  421,  434,  626,  209,   88,

			  422,   88,  447,  436,  423,  424,   88,  425,  426,  427,
			  428,  429,  209,  438,  626,   88,   88,  439,  345,  345,
			  345,  440,  440,  440,  364,  364,  364,  364,  364,  364,
			  442,  442,  442,  435,  447,  258,  368,  368,  368,  448,
			  437,  449,  450,  212,  366,  443,  103,  443,  103,  451,
			  444,  444,  444,  103,  368,  368,  368,  626,  452,  626,
			  626,  441,  103,  103,  626,  435,  445,  258,  369,  369,
			  370,  448,  437,  449,  450,  212,  366,  453,  103,  117,
			  103,  451,  454,  455,  445,  103,  370,  370,  370,  372,
			  452,  446,  446,  446,  103,  103,  372,  456,  374,  374,

			  374,  457,  458,  459,  460,  461,  626,  462,  266,  453,
			  463,  117,  464,  465,  454,  455,  466,  467,  468,  469,
			  470,  471,  472,  473,  626,  626,  266,  477,  626,  456,
			  478,  266,  479,  457,  458,  459,  460,  461,  266,  462,
			  480,  481,  463,  482,  464,  465,  483,  484,  466,  467,
			  468,  469,  470,  471,  472,  473,  474,  474,  474,  477,
			  475,  485,  478,  486,  479,  487,  488,  489,  490,  491,
			  492,  476,  480,  481,  493,  482,  494,  626,  483,  484,
			  430,  495,  495,  495,  209,  209,  209,   88,   88,   88,
			  502,  502,  502,  485,  626,  486,  626,  487,  488,  489,

			  490,  491,  492,  444,  444,  444,  493,  626,  494,  440,
			  440,  440,  503,  503,  503,  507,  508,  498,  444,  444,
			  444,  499,  509,  501,  512,  510,  366,  497,  259,  511,
			  503,  503,  503,  513,  103,  103,  103,  506,  514,  374,
			  374,  374,  515,  516,  505,  517,  518,  507,  508,  498,
			  519,  520,  504,  499,  509,  501,  512,  510,  366,  497,
			  521,  511,  522,  523,  524,  513,  103,  103,  103,  525,
			  514,  526,  529,  530,  515,  516,  505,  517,  518,  119,
			  531,  532,  519,  520,  474,  474,  474,  533,  527,  534,
			  535,  536,  521,  537,  522,  523,  524,  538,  539,  476,

			  540,  525,  541,  526,  529,  530,  542,  209,  209,  556,
			   88,   88,  531,  532,  209,  626,  626,   88,  626,  533,
			  626,  534,  535,  536,  626,  537,  552,  552,  552,  538,
			  539,  557,  540,  626,  541,  545,  626,  558,  542,  544,
			  547,  556,  547,  626,  626,  548,  548,  548,  549,  549,
			  549,  503,  503,  503,  559,  560,  546,  103,  103,  561,
			  626,  562,  550,  557,  103,  551,  563,  545,  553,  558,
			  553,  544,  564,  554,  554,  554,  259,  565,  552,  552,
			  552,  566,  567,  568,  569,  570,  559,  560,  546,  103,
			  103,  561,  555,  562,  550,  571,  103,  551,  563,  572,

			  573,  574,  575,  576,  564,  577,  626,  209,  209,  565,
			   88,   88,  591,  566,  567,  568,  569,  570,  592,  209,
			  626,  626,   88,  626,  555,  626,  626,  571,  548,  548,
			  548,  572,  573,  574,  575,  576,  579,  577,  548,  548,
			  548,  582,  582,  582,  591,  593,  583,  581,  583,  580,
			  592,  584,  584,  584,  585,  550,  585,  103,  103,  586,
			  586,  586,  587,  587,  587,  554,  554,  554,  579,  103,
			  554,  554,  554,  594,  595,  596,  588,  593,  589,  581,
			  589,  580,  597,  590,  590,  590,  598,  550,  601,  103,
			  103,  599,  599,  599,  602,  603,  604,  605,  550,  209,

			  607,  103,   88,   88,  626,  594,  595,  596,  588,  608,
			  618,  626,   88,   88,  597,  584,  584,  584,  598,  612,
			  601,  600,  613,  615,  441,  626,  602,  603,  604,  605,
			  550,  584,  584,  584,  626,  616,  606,  586,  586,  586,
			  586,  586,  586,  609,  609,  609,  590,  590,  590,  103,
			  103,  612,  617,  600,  613,  615,  610,  588,  610,  103,
			  103,  611,  611,  611,  590,  590,  590,  616,  606,  599,
			  599,  599,  588,  611,  611,  611,  611,  611,  611,  619,
			  620,  103,  103,  621,  617,  622,  623,  624,  625,  588,
			  626,  103,  103,  264,  264,  264,  626,  626,  504,  614,

			  626,  626,  626,  626,  588,  626,  626,  626,  626,  626,
			  626,  619,  620,  626,  626,  621,  626,  622,  623,  624,
			  625,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  626,  614,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   76,   76,   76,
			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   79,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   79,   79,   79,   79,   79,   85,  626,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,  104,  626,  104,  626,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  105,  626,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  172,  626,  172,  172,  172,  626,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  203,  203,  203,  203,  203,

			  203,  203,  203,  203,  203,  203,  203,  203,  203,  203,
			   87,  626,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   88,  626,   88,  626,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			  232,  626,  232,  232,  232,  232,  232,  232,  232,  232,
			  232,  232,  232,  232,  232,  326,  626,  326,  326,  326,
			  326,  326,  326,  326,  326,  326,  326,  326,  326,  326,
			  528,  528,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  578,  626,  578,  578,  578,
			  578,  578,  578,  578,  578,  578,  578,  578,  578,  578,

			   13,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    3,    4,   69,    3,    4,   69,    3,    4,

			    5,    5,    5,  543,    5,    6,    6,    6,  528,    6,
			    9,    9,    9,   10,   10,   10,   11,   11,   11,   12,
			   12,   12,   15,   15,   15,   16,   16,   16,   21,   27,
			   21,   11,   35,   35,   12,   29,  496,   15,   40,   27,
			   16,   28,   29,   28,   28,   28,   48,   30,   42,   30,
			   30,   30,   37,   37,   51,   54,    5,  495,   42,   50,
			   30,    6,   73,  476,   31,   73,   31,   31,   31,   32,
			   40,   32,   32,   32,  439,  432,   50,   31,   48,  372,
			   42,  371,   30,   77,   77,   77,   51,   54,    5,   30,
			   42,   50,   30,    6,   18,   18,  327,   18,   18,   80,

			   80,   80,   18,   18,  264,   18,   31,   18,   50,   31,
			   56,   32,  255,   18,   30,   18,   39,   18,   18,   47,
			   41,   39,   52,   39,   41,   47,   18,   41,   39,   39,
			   41,   18,   18,   41,   43,  254,   43,   52,   57,  253,
			  252,   18,   56,   88,   18,   18,   43,   18,   39,  251,
			   18,   47,   41,   39,   52,   39,   41,   47,   18,   41,
			   39,   39,   41,   18,   18,   41,   43,   44,   43,   52,
			   57,   44,   46,   18,   55,   88,   18,   18,   43,   46,
			   46,   49,   53,  127,   44,   46,   85,  129,   55,   85,
			  250,   49,   53,   49,  130,   53,  131,   49,  249,   44,

			   81,   81,   81,   44,   46,  248,   55,   83,   83,   83,
			  247,   46,   46,   49,   53,  127,   44,   46,  197,  129,
			   55,  197,   83,   49,   53,   49,  130,   53,  131,   49,
			   68,   68,   68,  246,   68,   89,   85,   68,   89,   68,
			   68,   68,   70,   70,   70,   90,   70,   68,   90,   87,
			   87,  245,   87,   68,   87,   68,  244,   87,   68,   68,
			   68,   68,  243,   68,   91,   68,  242,   91,   85,   68,
			   92,   68,  241,   92,   68,   68,   68,   68,   68,   68,
			  240,   93,  238,   92,   93,   89,  237,   94,   95,  102,
			   94,   95,  102,   96,   97,   90,   96,   97,   70,   98,

			  236,   93,   98,   99,   87,  101,   99,   94,  101,  235,
			  132,  100,  100,  100,   91,  100,  128,   89,  100,  128,
			   92,  234,  119,  119,  119,   95,  133,   90,  134,   96,
			   70,   93,   97,  111,  111,  111,   87,   94,   95,  102,
			   98,   99,  132,   96,   97,  135,   91,  111,  128,   98,
			  208,  128,   92,   99,  203,  101,  101,   95,  133,  136,
			  134,   96,  119,   93,   97,  100,  172,  100,  107,   94,
			   95,  102,   98,   99,  105,   96,   97,  135,  137,  111,
			  140,   98,  103,  103,  103,   99,  103,  101,  141,  103,
			  114,  136,  114,  114,  114,  138,  143,  100,  115,  138,

			  115,  115,  115,  141,   84,  116,  114,  116,  116,  116,
			  137,  115,  140,  142,  144,   82,  145,  142,  147,  150,
			  141,  151,  152,   74,  153,   65,  154,  138,  143,  157,
			  155,  138,  158,  151,  161,  141,  103,   63,  114,  155,
			  115,  201,   59,  115,  201,  142,  144,  116,  145,  142,
			  147,  150,  162,  151,  152,  148,  153,  148,  154,  148,
			  163,  157,  155,   38,  158,  151,  161,  164,  103,  106,
			  148,  155,  106,  148,  106,  106,  106,   33,  174,  174,
			  174,   13,  106,    8,  162,  174,  166,  148,  106,  148,
			  106,  148,  163,  106,  106,  106,  106,  160,  106,  164,

			  106,  160,  148,  165,  106,  148,  106,  167,  165,  106,
			  106,  106,  106,  106,  106,  159,  168,  159,  166,  165,
			  169,  180,  180,  180,    7,  159,    0,    0,  159,  160,
			  159,  159,    0,  160,    0,  165,  205,  205,  205,  167,
			  165,  200,  200,  200,    0,  200,    0,  159,  168,  159,
			    0,  165,  169,  207,  207,  207,  217,  159,  219,  217,
			  159,  219,  159,  159,  211,  211,  211,  211,  221,  211,
			  267,  221,  211,  212,  212,  212,  222,    0,  223,  222,
			  224,  223,  225,  224,  225,    0,    0,  225,  227,  227,
			  227,  226,  227,  229,  226,  227,  229,  200,  230,  268,

			    0,  230,  267,  222,  271,  272,  217,  274,  219,  239,
			  239,  239,  262,  275,  262,  262,  262,  223,  221,  211,
			  276,  277,    0,  224,  278,  262,  222,  212,  223,  200,
			  224,  268,  226,  279,  225,  222,  271,  272,  217,  274,
			  219,  226,  227,  229,  280,  275,  281,    0,  230,  223,
			  221,  211,  276,  277,  262,  224,  278,  262,  222,  212,
			  223,    0,  224,    0,  226,  279,  225,  257,  257,  257,
			  266,  266,  266,  226,  227,  229,  280,  258,  281,  258,
			  230,  257,  258,  258,  258,  260,  260,  260,  261,  283,
			  261,  285,  286,  261,  261,  261,  287,  284,  263,  260,

			  263,  263,  263,  265,  288,  265,  265,  265,    0,  289,
			  266,  284,  290,  257,  291,  292,  293,  288,  294,  295,
			  296,  283,  297,  285,  286,  298,  299,  301,  287,  284,
			  302,  260,  303,  305,  304,  306,  288,  304,  307,  308,
			  263,  289,  309,  284,  290,  265,  291,  292,  293,  288,
			  294,  295,  296,  310,  297,  311,  312,  298,  299,  301,
			  309,  313,  302,  314,  303,  305,  304,  306,  315,  304,
			  307,  308,  316,  317,  309,  318,  319,  320,  321,  322,
			  325,  325,  325,  325,    0,  310,    0,  311,  312,  328,
			  328,  328,  309,  313,  332,  314,  332,    0,  333,  332,

			  315,  333,  375,  334,  316,  317,  334,  318,  319,  320,
			  321,  322,  335,  337,    0,  335,  337,  345,  345,  345,
			  345,  362,  362,  362,  363,  363,  363,  364,  364,  364,
			  365,  365,  365,  333,  375,  362,  367,  367,  367,  376,
			  335,  377,  378,  328,  365,  366,  332,  366,  333,  379,
			  366,  366,  366,  334,  368,  368,  368,    0,  380,    0,
			    0,  362,  335,  337,    0,  333,  369,  362,  369,  369,
			  369,  376,  335,  377,  378,  328,  365,  381,  332,  369,
			  333,  379,  382,  383,  370,  334,  370,  370,  370,  373,
			  380,  373,  373,  373,  335,  337,  374,  384,  374,  374,

			  374,  385,  386,  387,  388,  389,    0,  390,  369,  381,
			  391,  369,  392,  394,  382,  383,  395,  396,  397,  398,
			  399,  400,  402,  405,    0,    0,  370,  408,    0,  384,
			  409,  373,  410,  385,  386,  387,  388,  389,  374,  390,
			  411,  412,  391,  413,  392,  394,  414,  415,  395,  396,
			  397,  398,  399,  400,  402,  405,  406,  406,  406,  408,
			  406,  416,  409,  417,  410,  418,  419,  420,  423,  424,
			  425,  406,  411,  412,  426,  413,  427,    0,  414,  415,
			  431,  431,  431,  431,  433,  435,  437,  433,  435,  437,
			  441,  441,  441,  416,    0,  417,    0,  418,  419,  420,

			  423,  424,  425,  443,  443,  443,  426,    0,  427,  440,
			  440,  440,  442,  442,  442,  449,  450,  435,  444,  444,
			  444,  437,  453,  440,  455,  454,  442,  433,  445,  454,
			  445,  445,  445,  457,  433,  435,  437,  446,  458,  446,
			  446,  446,  459,  460,  445,  461,  462,  449,  450,  435,
			  464,  465,  442,  437,  453,  440,  455,  454,  442,  433,
			  466,  454,  467,  469,  470,  457,  433,  435,  437,  471,
			  458,  473,  477,  478,  459,  460,  445,  461,  462,  446,
			  479,  480,  464,  465,  474,  474,  474,  481,  474,  482,
			  483,  484,  466,  485,  467,  469,  470,  487,  488,  474,

			  491,  471,  492,  473,  477,  478,  494,  498,  497,  508,
			  498,  497,  479,  480,  499,    0,    0,  499,    0,  481,
			    0,  482,  483,  484,    0,  485,  504,  504,  504,  487,
			  488,  509,  491,    0,  492,  498,    0,  511,  494,  497,
			  501,  508,  501,    0,    0,  501,  501,  501,  502,  502,
			  502,  503,  503,  503,  512,  513,  499,  498,  497,  516,
			    0,  518,  502,  509,  499,  503,  519,  498,  505,  511,
			  505,  497,  521,  505,  505,  505,  506,  522,  506,  506,
			  506,  523,  524,  525,  526,  529,  512,  513,  499,  498,
			  497,  516,  506,  518,  502,  530,  499,  503,  519,  532,

			  533,  535,  539,  540,  521,  542,    0,  545,  544,  522,
			  545,  544,  556,  523,  524,  525,  526,  529,  558,  546,
			    0,    0,  546,    0,  506,    0,    0,  530,  547,  547,
			  547,  532,  533,  535,  539,  540,  544,  542,  548,  548,
			  548,  549,  549,  549,  556,  560,  550,  546,  550,  545,
			  558,  550,  550,  550,  551,  549,  551,  545,  544,  551,
			  551,  551,  552,  552,  552,  553,  553,  553,  544,  546,
			  554,  554,  554,  561,  562,  565,  552,  560,  555,  546,
			  555,  545,  568,  555,  555,  555,  569,  549,  571,  545,
			  544,  570,  570,  570,  572,  573,  575,  576,  582,  579,

			  580,  546,  579,  580,    0,  561,  562,  565,  552,  581,
			  606,    0,  581,  606,  568,  583,  583,  583,  569,  591,
			  571,  570,  597,  600,  582,    0,  572,  573,  575,  576,
			  582,  584,  584,  584,    0,  601,  579,  585,  585,  585,
			  586,  586,  586,  587,  587,  587,  589,  589,  589,  579,
			  580,  591,  603,  570,  597,  600,  588,  587,  588,  581,
			  606,  588,  588,  588,  590,  590,  590,  601,  579,  599,
			  599,  599,  609,  610,  610,  610,  611,  611,  611,  614,
			  615,  579,  580,  619,  603,  620,  621,  622,  623,  587,
			    0,  581,  606,  643,  643,  643,    0,    0,  609,  599,

			    0,    0,    0,    0,  609,    0,    0,    0,    0,    0,
			    0,  614,  615,    0,    0,  619,    0,  620,  621,  622,
			  623,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			    0,  599,  627,  627,  627,  627,  627,  627,  627,  627,
			  627,  627,  627,  627,  627,  627,  627,  628,  628,  628,
			  628,  628,  628,  628,  628,  628,  628,  628,  628,  628,
			  628,  628,  629,  629,  629,  629,  629,  629,  629,  629,
			  629,  629,  629,  629,  629,  629,  629,  630,  630,  630,
			  630,  630,  630,  630,  630,  630,  630,  630,  630,  630,
			  630,  630,  631,  631,  631,  631,  631,  631,  631,  631,

			  631,  631,  631,  631,  631,  631,  631,  632,    0,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632,
			  632,  632,  633,    0,  633,    0,  633,  633,  633,  633,
			  633,  633,  633,  633,  633,  634,    0,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  636,    0,  636,  636,  636,    0,  636,  636,  636,  636,
			  636,  636,  636,  636,  636,  637,  637,  637,  637,  637,
			  637,  637,  637,  637,  637,  637,  637,  637,  637,  637,
			  638,  638,  638,  638,  638,  638,  638,  638,  638,  638,
			  638,  638,  638,  638,  638,  639,  639,  639,  639,  639,

			  639,  639,  639,  639,  639,  639,  639,  639,  639,  639,
			  640,    0,  640,  640,  640,  640,  640,  640,  640,  640,
			  640,  640,  640,  640,  640,  641,    0,  641,    0,  641,
			  641,  641,  641,  641,  641,  641,  641,  641,  641,  641,
			  642,    0,  642,  642,  642,  642,  642,  642,  642,  642,
			  642,  642,  642,  642,  642,  644,    0,  644,  644,  644,
			  644,  644,  644,  644,  644,  644,  644,  644,  644,  644,
			  645,  645,  645,  645,  645,  645,  645,  645,  645,  645,
			  645,  645,  645,  645,  645,  646,    0,  646,  646,  646,
			  646,  646,  646,  646,  646,  646,  646,  646,  646,  646,

			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  621,  580,  108,
			  111,  114,  117,  581, 1800,  120,  123, 1800,  188,    0,
			 1800,  119, 1800, 1800, 1800, 1800, 1800,  112,  123,  116,
			  129,  146,  151,  551, 1800,  107, 1800,  126,  537,  180,
			  100,  183,  114,  193,  237,    0,  237,  181,  102,  250,
			  129,  120,  188,  245,  112,  244,  173,  194, 1800,  485,
			 1800, 1800, 1800,  446, 1800,  519, 1800, 1800,  328,   91,
			  340, 1800, 1800,  159,  520, 1800, 1800,  181, 1800, 1800,
			  197,  298,  498,  305,  487,  280, 1800,  348,  187,  329,
			  339,  358,  364,  375,  381,  382,  387,  388,  393,  397,

			  409,  399,  383,  480,    0,  463,  563,  457, 1800, 1800,
			 1800,  413, 1800, 1800,  472,  480,  487, 1800,    0,  402,
			 1800, 1800, 1800, 1800, 1800, 1800,    0,  249,  378,  254,
			  246,  247,  361,  392,  398,  402,  425,  431,  464,    0,
			  432,  455,  468,  455,  484,  472,    0,  473,  522,    0,
			  479,  489,  473,  476,  493,  498,    0,  482,  498,  582,
			  556,  487,  518,  510,  522,  570,  539,  569,  582,  573,
			 1800, 1800,  460, 1800,  576, 1800, 1800, 1800, 1800, 1800,
			  601, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800,
			 1800, 1800, 1800, 1800, 1800, 1800, 1800,  315, 1800, 1800,

			  639,  538, 1800,  451, 1800,  634, 1800,  651,  443, 1800,
			 1800,  663,  671, 1800, 1800, 1800, 1800,  650, 1800,  652,
			 1800,  662,  670,  672,  674,  678,  685,  686, 1800,  687,
			  692, 1800, 1800, 1800,  410,  398,  389,  375,  371,  689,
			  369,  361,  355,  351,  345,  340,  322,  299,  294,  287,
			  279,  238,  229,  228,  224,  201, 1800,  747,  762, 1800,
			  765,  773,  694,  780,  144,  785,  750,  627,  669,    0,
			    0,  666,  658,    0,  675,  665,  669,  691,  677,  683,
			  710,  712,    0,  739,  767,  757,  744,  747,  762,  768,
			  778,  776,  781,  771,  788,  785,  790,  777,  791,  782,

			    0,  793,  776,  783,  802,  799,  801,  808,  789,  810,
			  806,  821,  826,  823,  820,  834,  831,  839,  829,  838,
			  839,  845,  836,    0, 1800,  861,    0,  123,  887, 1800,
			 1800, 1800,  890,  892,  897,  906, 1800,  907, 1800, 1800,
			 1800, 1800, 1800, 1800, 1800,  898, 1800, 1800, 1800, 1800,
			 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800,
			 1800, 1800,  901,  904,  907,  910,  930,  916,  934,  948,
			  966,  121,  161,  971,  978,  853,  891,  905,  904,  909,
			  910,  943,  933,  949,  961,  954,  964,  956,  961,  958,
			  960,  976,  962,    0,  979,  978,  964,  965,  972,  986,

			  974,    0,  981,    0,    0,  982, 1054,    0,  989,  980,
			  994, 1005,  994, 1001, 1008,  997, 1020, 1009, 1033, 1019,
			 1022,    0,    0, 1034, 1034, 1020, 1033, 1046,    0,    0,
			 1800, 1061,  105, 1078, 1800, 1079, 1800, 1080, 1800,  163,
			 1089, 1070, 1092, 1083, 1098, 1110, 1119,    0,    0, 1072,
			 1085,    0,    0, 1075, 1091, 1081,    0, 1086, 1103, 1108,
			 1110, 1096, 1103,    0, 1103, 1108, 1126, 1124,    0, 1125,
			 1132, 1131,    0, 1137, 1182, 1800,  146, 1142, 1126, 1127,
			 1143, 1153, 1155, 1143, 1157, 1144,    0, 1148, 1168,    0,
			    0, 1162, 1168,    0, 1163,  138,   61, 1202, 1201, 1208,

			 1800, 1225, 1228, 1231, 1206, 1253, 1258,    0, 1159, 1182,
			    0, 1193, 1205, 1221,    0,    0, 1225,    0, 1231, 1232,
			    0, 1224, 1234, 1232, 1233, 1253, 1235, 1800,  105, 1244,
			 1247,    0, 1256, 1257,    0, 1267,    0,    0,    0, 1253,
			 1260,    0, 1256,   37, 1302, 1301, 1313, 1308, 1318, 1321,
			 1331, 1339, 1342, 1345, 1350, 1363, 1263,    0, 1275,    0,
			 1312, 1340, 1333,    0,    0, 1339,    0,    0, 1339, 1352,
			 1389, 1344, 1360, 1363,    0, 1362, 1363,    0,    0, 1393,
			 1394, 1403, 1364, 1395, 1411, 1417, 1420, 1423, 1441, 1426,
			 1444, 1385,    0,    0,    0,    0,    0, 1373,    0, 1467,

			 1382, 1388,    0, 1418,    0,    0, 1404, 1800, 1800, 1438,
			 1453, 1456,    0,    0, 1438, 1450,    0,    0, 1800, 1453,
			 1437, 1438, 1439, 1440,    0, 1800, 1800, 1531, 1546, 1561,
			 1576, 1591, 1606, 1619, 1634, 1514, 1649, 1664, 1679, 1694,
			 1709, 1724, 1739, 1486, 1754, 1769, 1784, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  626,    1,  627,  627,  628,  628,  629,  629,  630,
			  630,  631,  631,  626,  626,  626,  626,  626,  632,  633,
			  626,  634,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  626,  626,
			  626,  626,  626,  626,  626,  636,  626,  626,  626,  637,
			  637,  626,  626,  638,  639,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  632,  626,  640,  641,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632,

			  632,  632,  632,  632,  633,  642,  642,  642,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  643,  626,
			  626,  626,  626,  626,  626,  626,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  626,  626,  636,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  637,  626,  626,

			  637,  638,  626,  639,  626,  626,  626,  626,  644,  626,
			  626,  640,  641,  626,  626,  626,  626,  632,  626,  632,
			  626,  632,  632,  632,  632,  632,  632,  632,  626,  632,
			  632,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  643,  626,  626,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,

			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  626,  626,  644,  644,  641,  626,
			  626,  626,  632,  632,  632,  632,  626,  632,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  643,  626,  626,  626,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,

			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  626,  626,  644,  632,  626,  632,  626,  632,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  626,  626,  626,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  626,  644,  632,  632,  632,

			  626,  626,  626,  626,  626,  626,  626,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  626,  645,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  644,  632,  632,  632,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  635,  635,  646,  632,
			  632,  632,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  635,  635,  635,  635,  635,  635,  635,  635,  626,

			  635,  635,  635,  635,  635,  635,  632,  626,  626,  626,
			  626,  626,  635,  635,  626,  635,  635,  635,  626,  626,
			  635,  626,  635,  626,  635,  626,    0,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   22,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,    1,    1,    1,
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    4,    3,    5,    6,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    7,    8,    9,    3,    3,    3,    3,    3,    3,    3,
			    7,    7,    7,    7,    7,    7,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   11,   12,    3,    3,    3,    3,
			   13,    3,    7,    7,    7,    7,    7,    7,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   14,   15,    3,    3,
			    3,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    2,    3,    4,    5,
			    5,    5,    5,    5,    6,    8,   11,   13,   16,   19,
			   22,   25,   28,   31,   34,   37,   40,   43,   46,   49,
			   52,   55,   58,   61,   64,   67,   70,   73,   76,   79,
			   82,   85,   88,   91,   94,   97,  100,  103,  106,  109,
			  112,  115,  118,  121,  124,  127,  130,  133,  136,  139,
			  141,  144,  147,  150,  153,  156,  158,  160,  162,  164,
			  166,  168,  170,  172,  174,  176,  178,  180,  182,  184,
			  186,  189,  191,  193,  194,  194,  195,  196,  197,  197,
			  198,  199,  200,  201,  202,  203,  204,  205,  206,  207,

			  208,  210,  211,  212,  214,  215,  216,  217,  218,  219,
			  220,  221,  222,  223,  224,  225,  226,  227,  228,  228,
			  228,  229,  230,  231,  232,  233,  234,  235,  236,  237,
			  238,  240,  241,  242,  243,  244,  245,  246,  247,  248,
			  250,  251,  252,  253,  254,  255,  256,  258,  259,  260,
			  262,  263,  264,  265,  266,  267,  268,  270,  271,  272,
			  273,  274,  275,  276,  277,  278,  279,  280,  281,  282,
			  283,  284,  285,  286,  287,  287,  288,  289,  290,  291,
			  292,  292,  293,  294,  295,  296,  297,  298,  299,  300,
			  301,  302,  303,  304,  305,  306,  307,  308,  309,  310,

			  311,  312,  313,  315,  316,  317,  317,  318,  319,  320,
			  321,  323,  325,  326,  328,  330,  332,  334,  335,  337,
			  338,  340,  341,  342,  343,  344,  345,  346,  347,  348,
			  349,  350,  352,  353,  355,  356,  357,  358,  359,  360,
			  361,  362,  363,  364,  365,  366,  367,  368,  369,  370,
			  371,  372,  373,  374,  375,  376,  377,  379,  380,  380,
			  381,  382,  382,  383,  384,  385,  386,  386,  387,  388,
			  390,  392,  393,  394,  396,  397,  398,  399,  400,  401,
			  402,  403,  404,  406,  407,  408,  409,  410,  411,  412,
			  413,  414,  415,  416,  417,  418,  419,  420,  421,  423,

			  424,  426,  427,  428,  429,  430,  431,  432,  433,  434,
			  435,  436,  437,  438,  439,  440,  441,  442,  443,  444,
			  445,  446,  447,  448,  450,  451,  451,  452,  453,  453,
			  455,  457,  459,  460,  461,  462,  463,  465,  466,  468,
			  470,  471,  472,  473,  474,  475,  476,  477,  478,  479,
			  480,  481,  482,  483,  484,  485,  486,  487,  488,  489,
			  490,  491,  492,  493,  493,  494,  495,  495,  495,  496,
			  497,  498,  498,  498,  499,  500,  501,  502,  503,  504,
			  505,  506,  507,  508,  509,  510,  511,  513,  514,  515,
			  516,  517,  518,  519,  521,  522,  523,  524,  525,  526,

			  527,  528,  530,  531,  533,  535,  536,  538,  540,  541,
			  542,  543,  544,  545,  546,  547,  548,  549,  550,  551,
			  552,  553,  555,  557,  558,  559,  560,  561,  562,  564,
			  566,  567,  567,  568,  569,  571,  572,  574,  575,  577,
			  578,  579,  579,  580,  580,  581,  582,  583,  585,  587,
			  588,  589,  591,  593,  594,  595,  596,  598,  599,  600,
			  601,  602,  603,  604,  606,  607,  608,  609,  610,  612,
			  613,  614,  615,  617,  618,  618,  619,  619,  620,  621,
			  622,  623,  624,  625,  626,  627,  628,  630,  631,  632,
			  634,  636,  637,  638,  640,  641,  641,  642,  643,  644,

			  645,  646,  646,  647,  648,  648,  648,  649,  651,  652,
			  653,  655,  656,  657,  658,  660,  662,  663,  665,  666,
			  667,  669,  670,  671,  672,  673,  674,  675,  676,  676,
			  677,  678,  680,  681,  682,  684,  685,  687,  689,  691,
			  692,  693,  695,  696,  697,  698,  699,  700,  700,  701,
			  702,  702,  702,  703,  703,  704,  704,  705,  707,  708,
			  710,  711,  712,  713,  715,  717,  718,  720,  722,  723,
			  724,  725,  726,  727,  728,  730,  731,  732,  734,  736,
			  737,  738,  739,  740,  740,  741,  741,  742,  743,  743,
			  743,  744,  745,  747,  749,  751,  753,  755,  756,  758,

			  758,  759,  760,  762,  763,  765,  767,  768,  770,  772,
			  773,  773,  774,  776,  778,  778,  779,  781,  783,  785,
			  785,  786,  786,  787,  787,  789,  790,  790, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  173,  173,  175,  175,  206,  204,  205,    1,  204,
			  205,    1,  205,   36,  204,  205,  176,  204,  205,   41,
			  204,  205,   15,  204,  205,  143,  204,  205,   24,  204,
			  205,   25,  204,  205,   32,  204,  205,   30,  204,  205,
			    9,  204,  205,   31,  204,  205,   14,  204,  205,   33,
			  204,  205,  115,  204,  205,  115,  204,  205,  115,  204,
			  205,    8,  204,  205,    7,  204,  205,   19,  204,  205,
			   18,  204,  205,   20,  204,  205,   11,  204,  205,  113,
			  204,  205,  113,  204,  205,  113,  204,  205,  113,  204,
			  205,  113,  204,  205,  113,  204,  205,  113,  204,  205,

			  113,  204,  205,  113,  204,  205,  113,  204,  205,  113,
			  204,  205,  113,  204,  205,  113,  204,  205,  113,  204,
			  205,  113,  204,  205,  113,  204,  205,  113,  204,  205,
			  113,  204,  205,  113,  204,  205,   28,  204,  205,  204,
			  205,   29,  204,  205,   34,  204,  205,   26,  204,  205,
			   27,  204,  205,   12,  204,  205,  177,  205,  203,  205,
			  201,  205,  202,  205,  173,  205,  173,  205,  172,  205,
			  171,  205,  173,  205,  175,  205,  174,  205,  169,  205,
			  169,  205,  168,  205,    6,  205,    5,    6,  205,    5,
			  205,    6,  205,    1,  176,  165,  176,  176,  176,  176,

			  176,  176,  176,  176,  176,  176,  176,  176,  176, -372,
			  176,  176,  176, -372,   41,  143,  143,  143,    2,   35,
			   10,  118,   39,   23,  118,  115,  115,  114,   16,   37,
			   21,   22,   38,   17,  113,  113,  113,  113,   46,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,   58,  113,
			  113,  113,  113,  113,  113,  113,   70,  113,  113,  113,
			   77,  113,  113,  113,  113,  113,  113,  113,   89,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,   40,   13,  177,  201,  194,  192,  193,
			  195,  196,  197,  198,  178,  179,  180,  181,  182,  183,

			  184,  185,  186,  187,  188,  189,  190,  191,  173,  172,
			  171,  173,  173,  170,  171,  175,  174,  168,    5,    4,
			  166,  164,  166,  176, -372, -372,  151,  166,  149,  166,
			  150,  166,  152,  166,  176,  145,  166,  176,  146,  166,
			  176,  176,  176,  176,  176,  176,  176, -167,  176,  176,
			  153,  166,  143,  119,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  120,  143,  118,
			  116,  118,  115,  115,  117,  115,  113,  113,   44,  113,
			   45,  113,  113,  113,   49,  113,  113,  113,  113,  113,

			  113,  113,  113,  113,   61,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,   81,  113,  113,   84,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  112,  113,
			  200,    4,    4,  154,  166,  147,  166,  148,  166,  176,
			  176,  176,  176,  161,  166,  176,  156,  166,  155,  166,
			  137,  135,  136,  138,  139,  144,  140,  141,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  118,  118,  118,  118,  115,  115,  115,  115,

			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,   59,  113,  113,  113,  113,  113,  113,  113,   68,
			  113,  113,  113,  113,  113,  113,  113,  113,   78,  113,
			  113,   80,  113,   82,  113,  113,   87,  113,   88,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  103,  113,  104,  113,  113,  113,  113,
			  113,  113,  110,  113,  111,  113,  199,    4,  176,  157,
			  166,  176,  160,  166,  176,  163,  166,  144,  118,  118,
			  118,  118,  115,   42,  113,   43,  113,  113,  113,   50,
			  113,   51,  113,  113,  113,  113,   56,  113,  113,  113,

			  113,  113,  113,  113,   66,  113,  113,  113,  113,  113,
			   73,  113,  113,  113,  113,   79,  113,  113,   85,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,   99,  113,
			  113,  113,  102,  113,  105,  113,  113,  113,  108,  113,
			  113,    4,  176,  176,  176,  142,  118,  118,  118,   47,
			  113,  113,  113,   53,  113,  113,  113,  113,   60,  113,
			   62,  113,  113,   64,  113,  113,  113,   69,  113,  113,
			  113,  113,  113,  113,  113,   86,  113,  113,   92,  113,
			  113,  113,   95,  113,  113,   97,  113,   98,  113,  100,
			  113,  113,  113,  107,  113,  113,    4,  176,  176,  176,

			  118,  118,  118,  118,  113,   52,  113,  113,   55,  113,
			  113,  113,  113,   67,  113,   71,  113,  113,   74,  113,
			   75,  113,  113,  113,  113,  113,  113,  113,   96,  113,
			  113,  113,  109,  113,    3,    4,  176,  176,  176,  118,
			  118,  118,  118,  118,  113,   54,  113,   57,  113,   63,
			  113,   65,  113,   72,  113,  113,   83,  113,  113,  113,
			   93,  113,  113,  101,  113,  106,  113,  176,  159,  166,
			  162,  166,  118,  118,   48,  113,   76,  113,  113,   91,
			  113,   94,  113,  158,  166,  113,  113,   90,  113,   90, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1800
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 626
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 627
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 205
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 206
			-- End of buffer rule code

	yyLine_used: BOOLEAN is true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is true
			-- Is `position' used?

	INITIAL: INTEGER is 0
	SPECIAL_STR: INTEGER is 1
	VERBATIM_STR1: INTEGER is 2
	VERBATIM_STR2: INTEGER is 3
	VERBATIM_STR3: INTEGER is 4
	PRAGMA: INTEGER is 5
			-- Start condition codes

feature -- User-defined features



end -- class EIFFEL_SCANNER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
