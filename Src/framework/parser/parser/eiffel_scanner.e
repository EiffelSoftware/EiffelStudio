indexing

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
--|#line 40 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 40")
end
 ast_factory.create_break_as (Current)  
when 2 then
	yy_end := yy_end - 2
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 42 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 42")
end
 
				last_break_as_start_position := position
				last_break_as_start_line := line
				last_break_as_start_column := column
				ast_factory.set_buffer (token_buffer2, Current)
				set_start_condition (PRAGMA)					
		
when 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 51 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 51")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 56 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 56")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 5 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 60 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 60")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 64 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 64")
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
--|#line 86 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 86")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 90 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 90")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 94 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 94")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
when 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 98 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 98")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 102 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 102")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 106 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 106")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 13 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 110 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 110")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CURLYTILDE, Current)
				last_token := TE_CURLYTILDE
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 114 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 114")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 118 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 118")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 122 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 122")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 17 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 126 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 126")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
when 18 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 130 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 130")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 134 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 134")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 20 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 138 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 138")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 21 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 142 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 142")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 146 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 146")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 23 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 150 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 150")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 154 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 154")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 158 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 158")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 162 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 162")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 166 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 166")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 170 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 170")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 174")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 178 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 178")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 182 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 182")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 186 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 186")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 190 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 190")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 194 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 194")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 198")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 36 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 202 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 202")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 206 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 206")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 38 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 210 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 210")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 39 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 214 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 214")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 40 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 218 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 218")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 41 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 226 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 226")
end

				last_token := TE_FREE
				process_id_as
			
when 42 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 234 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 234")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 43 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 238 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 238")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 242 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 242")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 246 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 246")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 46 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 250 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 250")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 47 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 254 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 254")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_keyword_as_id_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
when 48 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 261 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 261")
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
--|#line 270 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 270")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
			
when 50 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 274 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 274")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 278 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 278")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 52 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 282 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 282")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 53 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 286 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 286")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 54 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 290 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 290")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
when 55 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 294 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 294")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 56 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 298 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 298")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 57 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 302 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 302")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
when 58 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 306 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 306")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 59 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 310 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 310")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 60 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 314 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 314")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 61 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 318 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 318")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 62 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 322 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 322")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 63 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 326 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 326")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 64 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 330 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 330")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 65 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 334 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 334")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 66 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 338 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 338")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 67 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 342 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 342")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 68 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 346 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 346")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 69 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 350 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 350")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 70 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 354 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 354")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 358 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 358")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 72 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 362 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 362")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
when 73 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 366 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 366")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 74 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 370 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 370")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 75 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 374 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 374")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 76 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 378 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 378")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 77 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 382 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 382")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
when 78 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 386 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 386")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 79 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 390 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 390")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 80 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 394 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 394")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 81 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 398 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 398")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 82 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 402 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 402")
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
--|#line 411 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 411")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 84 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 415 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 415")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 85 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 431 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 431")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 86 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 435 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 435")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
when 87 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 442 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 442")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 88 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 446 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 446")
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
--|#line 455 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 455")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 90 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 459 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 459")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 91 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 463 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 463")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 92 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 467 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 467")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 93 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 471 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 471")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 94 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 475 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 475")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 479 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 479")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 96 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 483 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 483")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 97 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 487 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 487")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 491 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 491")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 99 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 495 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 495")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 499 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 499")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 101 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 503 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 503")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 507 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 507")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 103 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 511 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 511")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 515 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 515")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 105 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 519 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 519")
end

				last_token := TE_TUPLE
				process_id_as
			
when 106 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 523 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 523")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 107 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 527 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 527")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 108 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 531 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 531")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 109 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 535 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 535")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 110 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 539 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 539")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 111 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 543 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 543")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 112 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 547 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 547")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 555 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 555")
end

				last_token := TE_ID
				process_id_as
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 562 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 562")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)
			
when 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 570 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 570")
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
--|#line 571 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 571")
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
--|#line 583 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 583")
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
		-- Recognizes octal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 595 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 595")
end
		-- Recognizes binary integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 601 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 601")
end
		-- Recognizes erronous binary numbers.
				report_invalid_integer_error (token_buffer)
			
when 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 608 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 608")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end				
				last_token := TE_REAL
			
when 122 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 123 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 633 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 633")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 639 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 639")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 645 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 645")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 651 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 651")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 657 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 657")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 663 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 663")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 669 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 669")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 675 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 675")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 681 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 681")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 687 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 687")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 693 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 693")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 699 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 699")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 705 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 705")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 711 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 711")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 717 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 717")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 723 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 723")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 729 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 729")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 735 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 735")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 741 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 741")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 747 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 747")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 753 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 753")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 145 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 759 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 759")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 146 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 760 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 760")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 147 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 761 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 761")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 148 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 762 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 762")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 149 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 769 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 769")
end

				report_invalid_integer_error (token_buffer)
			
when 150 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 774 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 774")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 151 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 775 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 775")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 152 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 784 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 784")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 153 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 788 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 788")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 154 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 792 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 792")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 796 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 796")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 156 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 800 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 800")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 157 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 804 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 804")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 158 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 808 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 808")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 159 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 812 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 812")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 160 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 816 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 816")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 161 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 820 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 820")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 162 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 824 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 824")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 163 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 828 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 828")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 164 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 832 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 832")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 165 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 838 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 838")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 166 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 844 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 844")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 167 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 850 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 850")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 168 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 856 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 856")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 169 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 862 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 862")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 170 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 868 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 868")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 874 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 874")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 172 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 883 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 883")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 889 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 889")
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
			
when 174 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 900 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 900")
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
			
when 175 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 918 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 918")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 176 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 922 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 922")
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
			
when 177 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 942 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 942")
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
			
when 178 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 985 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 985")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 179 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 990 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 990")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 180 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 998 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 998")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 181 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1014 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1014")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 182 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1023 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1023")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 183 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1036 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1036")
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
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1048 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1048")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1052 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1052")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%A")
				token_buffer.append_character ('%A')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1056 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1056")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%B")
				token_buffer.append_character ('%B')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1060 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1060")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%C")
				token_buffer.append_character ('%C')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1064 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1064")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%D")
				token_buffer.append_character ('%D')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1068 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1068")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%F")
				token_buffer.append_character ('%F')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1072 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1072")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%H")
				token_buffer.append_character ('%H')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1076 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1076")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%L")
				token_buffer.append_character ('%L')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1080 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1080")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%N")
				token_buffer.append_character ('%N')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1084 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1084")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%Q")
				token_buffer.append_character ('%Q')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1088 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1088")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%R")
				token_buffer.append_character ('%R')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1092 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1092")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%S")
				token_buffer.append_character ('%S')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1096 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1096")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%T")
				token_buffer.append_character ('%T')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1100 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1100")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%U")
				token_buffer.append_character ('%U')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1104 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1104")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%V")
				token_buffer.append_character ('%V')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1108 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1108")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%%")
				token_buffer.append_character ('%%')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1112 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1112")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%'")
				token_buffer.append_character ('%'')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1116 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1116")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%"")
				token_buffer.append_character ('%"')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1120 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1120")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%(")
				token_buffer.append_character ('%(')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1124 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1124")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%)")
				token_buffer.append_character ('%)')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1128 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1128")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%<")
				token_buffer.append_character ('%<')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1132 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1132")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%>")
				token_buffer.append_character ('%>')
			
when 206 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1136 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1136")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 207 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1140 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1140")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 208 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1145 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1145")
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
			
when 209 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1161 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1161")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 210 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1167 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1167")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 211 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1185 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1185")
end

				report_unknown_token_error (text_item (1))
			
when 212 then
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
			   30,   31,   32,   32,   33,   34,   35,   36,   37,   38,
			   19,   39,   40,   41,   42,   43,   44,   45,   45,   46,
			   45,   45,   47,   45,   48,   49,   50,   45,   51,   52,
			   53,   54,   55,   56,   57,   45,   45,   58,   59,   60,
			   61,   14,   14,   39,   40,   41,   42,   43,   44,   45,
			   45,   46,   45,   45,   47,   45,   48,   49,   50,   45,
			   51,   52,   53,   54,   55,   56,   57,   45,   45,   62,
			   19,   63,   64,   66,   66,  570,   67,   67,  108,   68,

			   68,   70,   71,   70,  609,   72,   70,   71,   70,  109,
			   72,   77,   78,   77,   77,   78,   77,   80,   81,   80,
			   80,   81,   80,   83,   83,   83,   83,   83,   83,  106,
			  134,  107,   82,  123,  124,   82,  125,  126,   84,  112,
			  110,   84,  111,  111,  111,  111,  114,  113,  115,  115,
			  116,  116,  154,  152,  159,  161,  140,  654,   73,  153,
			  117,  118,  134,   73,  608,  114,  141,  115,  115,  116,
			  116,  160,  114,  566,  116,  116,  116,  116,  607,  121,
			  167,  170,  119,  654,  154,  152,  159,  161,  140,  120,
			   73,  153,  117,  118,  606,   73,   86,   87,  141,   88,

			   87,  266,  266,  160,   89,   90,  171,   91,  120,   92,
			  162,  121,  167,  170,  119,  120,   93,  602,   94,  129,
			   87,   95,  486,  135,  130,  163,  131,  136,  214,   96,
			  137,  132,  133,  138,   97,   98,  139,  142,  171,  143,
			  168,  272,  162,  200,   99,  275,  201,  100,  101,  144,
			  102,  129,  559,   95,  169,  135,  130,  163,  131,  136,
			  214,   96,  137,  132,  133,  138,   97,   98,  139,  142,
			  145,  143,  168,  272,  146,  148,   99,  275,  439,  103,
			   87,  144,  149,  150,  155,  164,  169,  147,  151,  200,
			  513,  513,  204,  276,  156,  165,  157,  277,  166,  278,

			  158,  544,  145,  207,  208,  207,  146,  148,  512,  202,
			  200,  202,  508,  201,  149,  150,  155,  164,  565,  147,
			  151,  209,  209,  209,  279,  276,  156,  165,  157,  277,
			  166,  278,  158,  176,  176,  176,  211,  177,  215,   88,
			  178,   88,  179,  180,  181,  209,  209,  209,  216,  217,
			  182,   88,   88,   83,   83,   83,  279,  183,  200,  184,
			  566,  201,  185,  186,  187,  188,  203,  189,   84,  190,
			  280,  218,  261,  191,   88,  192,  380,  378,  193,  194,
			  195,  196,  197,  198,  219,   85,   85,  103,   85,  103,
			  212,  220,  222,   88,   88,   88,  281,  282,  203,  103,

			  103,  211,  280,  441,   88,  211,  211,  211,   88,   88,
			   88,  211,  221,  223,   88,  211,  283,  233,   88,  103,
			   88,  103,  103,  229,  230,  229,  380,  211,  281,  282,
			   88,  103,  103,  286,  259,  259,  259,  259,  287,  224,
			  378,  213,  103,  103,  225,  226,  367,  227,  283,  260,
			  228,  284,  103,  288,  103,  285,  103,  103,  103,  268,
			  268,  268,  103,  366,  365,  286,  103,  232,  103,  273,
			  287,  224,  274,  213,  103,  103,  225,  226,  103,  227,
			  231,  260,  228,  284,  103,  288,  291,  285,  103,  103,
			  103,  207,  208,  207,  103,  229,  230,  229,  103,  211,

			  103,  273,   88,  261,  274,  262,  262,  262,  262,  292,
			  103,  114,  293,  264,  264,  265,  265,  294,  291,  114,
			  263,  265,  265,  265,  265,  121,  270,  270,  270,  270,
			  364,  300,  289,  301,  303,  363,  290,  304,  305,  306,
			  308,  292,  309,  316,  293,  302,  318,  317,  307,  294,
			  103,  362,  263,  319,  120,  320,  569,  121,  361,  321,
			  325,  326,  120,  300,  289,  301,  303,  271,  290,  304,
			  305,  306,  308,  200,  309,  316,  204,  302,  318,  317,
			  307,  360,  103,  236,  327,  319,  237,  320,  238,  239,
			  240,  321,  325,  326,  266,  266,  241,  359,  570,  328,

			  358,  384,  295,  242,  296,  243,  297,  322,  244,  245,
			  246,  247,  323,  248,  357,  249,  327,  298,  356,  250,
			  299,  251,  385,  324,  252,  253,  254,  255,  256,  257,
			  310,  328,  311,  384,  295,  377,  296,  355,  297,  322,
			  312,  354,  386,  313,  323,  314,  315,  334,  335,  298,
			   88,   88,  299,  387,  385,  324,  176,  176,  176,  209,
			  209,  209,  310,  329,  311,  330,  330,  330,  330,  202,
			  200,  202,  312,  201,  386,  313,  353,  314,  315,   85,
			  229,  230,  229,  336,  212,  387,   88,   88,  333,  230,
			  333,  211,  388,  211,   88,  389,   88,  211,  103,  103,

			   88,  340,  343,  341,  211,   88,   88,   88,  229,  230,
			  229,  344,  211,  390,   88,   88,  268,  268,  268,  337,
			  350,  351,  351,  351,  388,  352,  203,  389,  391,  392,
			  103,  103,  393,  338,  103,  213,  349,  368,  368,  368,
			  368,  339,  103,  214,  103,  390,  342,  394,  103,  395,
			  396,  337,  260,  103,  103,  103,  399,  379,  203,  348,
			  391,  392,  103,  103,  393,  338,  103,  213,  371,  371,
			  371,  371,  400,  339,  103,  214,  103,  347,  342,  394,
			  103,  395,  396,  372,  260,  103,  103,  103,  399,  346,
			  345,  369,  332,  369,  103,  103,  370,  370,  370,  370,

			  373,  401,  373,  397,  400,  374,  374,  374,  374,  114,
			  404,  375,  375,  376,  376,  372,  114,  398,  376,  376,
			  376,  376,  381,  121,  382,  382,  382,  382,  383,  383,
			  383,  383,  402,  401,  405,  397,  406,  206,  407,  408,
			  409,  410,  404,  411,  412,  403,  413,  414,  415,  398,
			  416,  417,  120,  418,  420,  121,  419,  421,  422,  120,
			  423,  426,  427,  424,  402,  271,  405,  428,  406,  271,
			  407,  408,  409,  410,  429,  411,  412,  403,  413,  414,
			  415,  425,  416,  417,  430,  418,  420,  431,  419,  421,
			  422,  432,  423,  426,  427,  424,  433,  434,  435,  428,

			  436,  437,  438,  333,  230,  333,  429,  439,  440,  440,
			  440,  440,  442,  425,  443,  211,  430,   88,   88,  431,
			  175,  445,  447,  432,   88,   88,  266,  266,  433,  434,
			  435,  459,  436,  437,  438,  211,  460,  258,   88,  448,
			  351,  351,  351,  351,  448,  351,  351,  351,  351,  235,
			  108,  444,  449,  450,  452,  452,  452,  452,  214,  370,
			  370,  370,  370,  459,  446,  103,  103,  377,  460,  260,
			  461,  462,  103,  103,  451,  370,  370,  370,  370,  454,
			  454,  454,  454,  444,  449,  450,  103,  515,  515,  515,
			  214,  463,  464,  465,  372,  453,  446,  103,  103,  210,

			  466,  260,  461,  462,  103,  103,  451,  455,  206,  455,
			  175,  467,  456,  456,  456,  456,  173,  172,  103,  374,
			  374,  374,  374,  463,  464,  465,  372,  374,  374,  374,
			  374,  457,  466,  375,  375,  376,  376,  457,  468,  376,
			  376,  376,  376,  467,  381,  121,  458,  458,  458,  458,
			  381,  469,  383,  383,  383,  383,  470,  471,  472,  473,
			  474,  127,  475,  476,  477,  478,  479,  480,  481,  482,
			  468,  483,  484,  485,  271,  122,  654,  121,   75,  489,
			  271,  490,  491,  469,  492,  493,  494,  271,  470,  471,
			  472,  473,  474,  271,  475,  476,  477,  478,  479,  480,

			  481,  482,  495,  483,  484,  485,  486,  486,  486,  496,
			  487,  489,  497,  490,  491,  498,  492,  493,  494,  499,
			  500,  488,  501,  502,  503,  504,  505,  506,  439,  507,
			  507,  507,  507,  211,  495,  211,   88,  211,   88,   75,
			   88,  496,  523,  654,  497,  654,  654,  498,  654,  654,
			  524,  499,  500,  525,  501,  502,  503,  504,  505,  506,
			  452,  452,  452,  452,  518,  518,  518,  518,  510,  456,
			  456,  456,  456,  511,  523,  517,  528,  509,  519,  519,
			  519,  519,  524,  654,  103,  525,  103,  654,  103,  456,
			  456,  456,  456,  372,  261,  529,  519,  519,  519,  519,

			  510,  530,  526,  531,  532,  511,  527,  517,  528,  509,
			  522,  521,  383,  383,  383,  383,  103,  533,  103,  520,
			  103,  654,  534,  535,  536,  372,  537,  529,  538,  539,
			  540,  541,  542,  530,  526,  531,  532,  545,  527,  546,
			  547,  548,  549,  521,  486,  486,  486,  550,  543,  533,
			  551,  552,  553,  120,  534,  535,  536,  554,  537,  488,
			  538,  539,  540,  541,  542,  555,  556,  557,  558,  545,
			  654,  546,  547,  548,  549,  211,  654,  211,   88,  550,
			   88,  654,  551,  552,  553,  563,  513,  513,  654,  554,
			  211,  654,  654,   88,  267,  267,  267,  555,  556,  557,

			  558,  567,  515,  515,  515,  580,  561,  560,  571,  654,
			  571,  654,  654,  572,  572,  572,  572,  573,  573,  573,
			  573,  519,  519,  519,  519,  581,  103,  564,  103,  582,
			  583,  584,  574,  562,  585,  654,  575,  580,  561,  560,
			  654,  103,  586,  568,  576,  576,  576,  576,  577,  587,
			  577,  588,  654,  578,  578,  578,  578,  581,  103,  589,
			  103,  582,  583,  584,  574,  562,  585,  261,  575,  576,
			  576,  576,  576,  103,  586,  590,  591,  592,  593,  594,
			  595,  587,  596,  588,  579,  597,  598,  599,  600,  601,
			  654,  589,  211,  211,  211,   88,   88,   88,  572,  572,

			  572,  572,  572,  572,  572,  572,  619,  590,  591,  592,
			  593,  594,  595,  654,  596,  654,  579,  597,  598,  599,
			  600,  601,  603,  605,  610,  610,  610,  610,  578,  578,
			  578,  578,  654,  654,  620,  604,  621,  622,  619,  574,
			  623,  624,  625,  103,  103,  103,  615,  615,  615,  615,
			  626,  611,  654,  611,  603,  605,  612,  612,  612,  612,
			  629,  616,  578,  578,  578,  578,  620,  604,  621,  622,
			  630,  574,  623,  624,  625,  103,  103,  103,  613,  631,
			  613,  632,  626,  614,  614,  614,  614,  633,  574,  617,
			  654,  617,  629,  616,  618,  618,  618,  618,  627,  627,

			  627,  211,  630,  635,   88,  636,   88,  654,   88,  640,
			  641,  631,  654,  632,  453,  612,  612,  612,  612,  633,
			  574,  612,  612,  612,  612,  614,  614,  614,  614,  628,
			  614,  614,  614,  614,  637,  637,  637,  637,  638,  634,
			  638,  640,  641,  639,  639,  639,  639,  643,  644,  616,
			  645,  616,  103,  647,  103,  648,  103,  618,  618,  618,
			  618,  628,  618,  618,  618,  618,  627,  627,  627,  646,
			  649,  634,   88,  639,  639,  639,  639,  520,  650,  643,
			  644,  616,  645,  616,  103,  647,  103,  648,  103,  639,
			  639,  639,  639,  651,  652,  653,  654,  642,  269,  269,

			  269,  654,  649,  514,  514,  514,  654,  104,  654,  104,
			  650,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  103,  516,  516,  516,  654,  651,  652,  653,  654,  642,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  103,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   76,   76,

			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   85,  654,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,  105,  654,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  174,  654,
			  174,  174,  174,  654,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  199,  199,  199,  199,  199,  199,  199,
			  199,  199,  199,  199,  199,  199,  199,  199,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  203,  203,  203,

			  203,  203,  203,  205,  205,  205,  205,  205,  205,  205,
			  205,  205,  205,  205,  205,  205,  205,  205,   87,  654,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   88,  654,   88,  654,   88,   88,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,  234,  654,
			  234,  234,  234,  234,  234,  234,  234,  234,  234,  234,
			  234,  234,  234,  331,  654,  331,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  544,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  544,  544,
			  544,  544,  544,  602,  654,  602,  602,  602,  602,  602,

			  602,  602,  602,  602,  602,  602,  602,  602,   13,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,

			  654, yy_Dummy>>)
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
			    1,    1,    1,    3,    4,  570,    3,    4,   27,    3,

			    4,    5,    5,    5,  569,    5,    6,    6,    6,   27,
			    6,    9,    9,    9,   10,   10,   10,   11,   11,   11,
			   12,   12,   12,   15,   15,   15,   16,   16,   16,   21,
			   40,   21,   11,   35,   35,   12,   37,   37,   15,   29,
			   28,   16,   28,   28,   28,   28,   30,   29,   30,   30,
			   30,   30,   48,   47,   50,   51,   42,  568,    5,   47,
			   30,   30,   40,    6,  567,   31,   42,   31,   31,   31,
			   31,   50,   32,  566,   32,   32,   32,   32,  565,   31,
			   54,   56,   30,  564,   48,   47,   50,   51,   42,   30,
			    5,   47,   30,   30,  563,    6,   18,   18,   42,   18,

			   18,  117,  117,   50,   18,   18,   57,   18,   31,   18,
			   52,   31,   54,   56,   30,   32,   18,  559,   18,   39,
			   18,   18,  544,   41,   39,   52,   39,   41,   88,   18,
			   41,   39,   39,   41,   18,   18,   41,   43,   57,   43,
			   55,  129,   52,   69,   18,  131,   69,   18,   18,   43,
			   18,   39,  508,   18,   55,   41,   39,   52,   39,   41,
			   88,   18,   41,   39,   39,   41,   18,   18,   41,   43,
			   44,   43,   55,  129,   44,   46,   18,  131,  507,   18,
			   18,   43,   46,   46,   49,   53,   55,   44,   46,   73,
			  449,  449,   73,  132,   49,   53,   49,  133,   53,  134,

			   49,  488,   44,   77,   77,   77,   44,   46,  448,   70,
			   70,   70,  441,   70,   46,   46,   49,   53,  514,   44,
			   46,   80,   80,   80,  135,  132,   49,   53,   49,  133,
			   53,  134,   49,   68,   68,   68,   85,   68,   89,   85,
			   68,   89,   68,   68,   68,   81,   81,   81,   90,   91,
			   68,   90,   91,   83,   83,   83,  135,   68,  199,   68,
			  514,  199,   68,   68,   68,   68,   70,   68,   83,   68,
			  136,   92,  381,   68,   92,   68,  380,  378,   68,   68,
			   68,   68,   68,   68,   92,   87,   87,   85,   87,   89,
			   87,   93,   94,   87,   93,   94,  137,  138,   70,   90,

			   91,   95,  136,  332,   95,   98,   97,   96,   98,   97,
			   96,   99,   93,   94,   99,  101,  139,  102,  101,   85,
			  102,   89,   92,  100,  100,  100,  269,  100,  137,  138,
			  100,   90,   91,  142,  111,  111,  111,  111,  143,   95,
			  267,   87,   93,   94,   96,   97,  257,   98,  139,  111,
			   99,  140,   95,  143,   92,  140,   98,   97,   96,  118,
			  118,  118,   99,  256,  255,  142,  101,  101,  102,  130,
			  143,   95,  130,   87,   93,   94,   96,   97,  100,   98,
			  100,  111,   99,  140,   95,  143,  145,  140,   98,   97,
			   96,  207,  207,  207,   99,  103,  103,  103,  101,  103,

			  102,  130,  103,  114,  130,  114,  114,  114,  114,  146,
			  100,  115,  147,  115,  115,  115,  115,  149,  145,  116,
			  114,  116,  116,  116,  116,  115,  120,  120,  120,  120,
			  254,  152,  144,  153,  154,  253,  144,  155,  156,  157,
			  159,  146,  160,  162,  147,  153,  163,  162,  157,  149,
			  103,  252,  114,  164,  115,  165,  516,  115,  251,  166,
			  168,  169,  116,  152,  144,  153,  154,  120,  144,  155,
			  156,  157,  159,  203,  160,  162,  203,  153,  163,  162,
			  157,  250,  103,  106,  170,  164,  106,  165,  106,  106,
			  106,  166,  168,  169,  266,  266,  106,  249,  516,  171,

			  248,  272,  150,  106,  150,  106,  150,  167,  106,  106,
			  106,  106,  167,  106,  247,  106,  170,  150,  246,  106,
			  150,  106,  273,  167,  106,  106,  106,  106,  106,  106,
			  161,  171,  161,  272,  150,  266,  150,  245,  150,  167,
			  161,  244,  276,  161,  167,  161,  161,  219,  221,  150,
			  219,  221,  150,  277,  273,  167,  176,  176,  176,  209,
			  209,  209,  161,  176,  161,  182,  182,  182,  182,  202,
			  202,  202,  161,  202,  276,  161,  243,  161,  161,  213,
			  213,  213,  213,  223,  213,  277,  223,  213,  214,  214,
			  214,  224,  279,  225,  224,  280,  225,  226,  219,  221,

			  226,  227,  231,  227,  228,  231,  227,  228,  229,  229,
			  229,  232,  229,  281,  232,  229,  268,  268,  268,  224,
			  241,  241,  241,  241,  279,  242,  202,  280,  282,  283,
			  219,  221,  284,  225,  223,  213,  240,  259,  259,  259,
			  259,  226,  224,  214,  225,  281,  228,  285,  226,  286,
			  288,  224,  259,  231,  227,  228,  290,  268,  202,  239,
			  282,  283,  232,  229,  284,  225,  223,  213,  262,  262,
			  262,  262,  291,  226,  224,  214,  225,  238,  228,  285,
			  226,  286,  288,  262,  259,  231,  227,  228,  290,  237,
			  236,  260,  210,  260,  232,  229,  260,  260,  260,  260,

			  263,  292,  263,  289,  291,  263,  263,  263,  263,  264,
			  294,  264,  264,  264,  264,  262,  265,  289,  265,  265,
			  265,  265,  270,  264,  270,  270,  270,  270,  271,  271,
			  271,  271,  293,  292,  295,  289,  296,  205,  297,  298,
			  299,  300,  294,  301,  302,  293,  303,  304,  306,  289,
			  307,  308,  264,  309,  310,  264,  309,  311,  312,  265,
			  313,  315,  316,  314,  293,  270,  295,  317,  296,  271,
			  297,  298,  299,  300,  318,  301,  302,  293,  303,  304,
			  306,  314,  307,  308,  319,  309,  310,  320,  309,  311,
			  312,  321,  313,  315,  316,  314,  322,  323,  324,  317,

			  325,  326,  327,  333,  333,  333,  318,  330,  330,  330,
			  330,  330,  337,  314,  337,  338,  319,  337,  338,  320,
			  174,  339,  342,  321,  339,  342,  377,  377,  322,  323,
			  324,  384,  325,  326,  327,  340,  385,  107,  340,  350,
			  350,  350,  350,  350,  351,  351,  351,  351,  351,  105,
			   84,  338,  350,  350,  368,  368,  368,  368,  333,  369,
			  369,  369,  369,  384,  340,  337,  338,  377,  385,  368,
			  386,  387,  339,  342,  350,  370,  370,  370,  370,  371,
			  371,  371,  371,  338,  350,  350,  340,  450,  450,  450,
			  333,  388,  389,  390,  371,  368,  340,  337,  338,   82,

			  391,  368,  386,  387,  339,  342,  350,  372,   74,  372,
			   65,  392,  372,  372,  372,  372,   63,   59,  340,  373,
			  373,  373,  373,  388,  389,  390,  371,  374,  374,  374,
			  374,  375,  391,  375,  375,  375,  375,  376,  393,  376,
			  376,  376,  376,  392,  382,  375,  382,  382,  382,  382,
			  383,  394,  383,  383,  383,  383,  395,  396,  397,  398,
			  399,   38,  400,  401,  403,  404,  405,  406,  407,  408,
			  393,  409,  411,  414,  375,   33,   13,  375,    8,  417,
			  376,  418,  419,  394,  420,  421,  422,  382,  395,  396,
			  397,  398,  399,  383,  400,  401,  403,  404,  405,  406,

			  407,  408,  423,  409,  411,  414,  415,  415,  415,  424,
			  415,  417,  425,  418,  419,  426,  420,  421,  422,  427,
			  428,  415,  429,  432,  433,  434,  435,  436,  440,  440,
			  440,  440,  440,  442,  423,  444,  442,  446,  444,    7,
			  446,  424,  461,    0,  425,    0,    0,  426,    0,    0,
			  462,  427,  428,  465,  429,  432,  433,  434,  435,  436,
			  452,  452,  452,  452,  453,  453,  453,  453,  444,  455,
			  455,  455,  455,  446,  461,  452,  467,  442,  454,  454,
			  454,  454,  462,    0,  442,  465,  444,    0,  446,  456,
			  456,  456,  456,  454,  457,  469,  457,  457,  457,  457,

			  444,  470,  466,  471,  472,  446,  466,  452,  467,  442,
			  458,  457,  458,  458,  458,  458,  442,  473,  444,  454,
			  446,    0,  474,  476,  477,  454,  478,  469,  479,  481,
			  482,  483,  485,  470,  466,  471,  472,  489,  466,  490,
			  491,  492,  493,  457,  486,  486,  486,  494,  486,  473,
			  495,  496,  497,  458,  474,  476,  477,  499,  478,  486,
			  479,  481,  482,  483,  485,  500,  503,  504,  506,  489,
			    0,  490,  491,  492,  493,  509,    0,  510,  509,  494,
			  510,    0,  495,  496,  497,  513,  513,  513,    0,  499,
			  511,    0,    0,  511,  671,  671,  671,  500,  503,  504,

			  506,  515,  515,  515,  515,  524,  510,  509,  517,    0,
			  517,    0,    0,  517,  517,  517,  517,  518,  518,  518,
			  518,  519,  519,  519,  519,  525,  509,  513,  510,  527,
			  528,  529,  518,  511,  532,    0,  519,  524,  510,  509,
			    0,  511,  534,  515,  520,  520,  520,  520,  521,  535,
			  521,  537,    0,  521,  521,  521,  521,  525,  509,  538,
			  510,  527,  528,  529,  518,  511,  532,  522,  519,  522,
			  522,  522,  522,  511,  534,  539,  540,  541,  542,  545,
			  546,  535,  548,  537,  522,  549,  551,  555,  556,  558,
			    0,  538,  561,  560,  562,  561,  560,  562,  571,  571,

			  571,  571,  572,  572,  572,  572,  580,  539,  540,  541,
			  542,  545,  546,    0,  548,    0,  522,  549,  551,  555,
			  556,  558,  560,  562,  573,  573,  573,  573,  577,  577,
			  577,  577,    0,    0,  582,  561,  584,  585,  580,  573,
			  586,  589,  592,  561,  560,  562,  576,  576,  576,  576,
			  593,  574,    0,  574,  560,  562,  574,  574,  574,  574,
			  595,  576,  578,  578,  578,  578,  582,  561,  584,  585,
			  596,  573,  586,  589,  592,  561,  560,  562,  575,  597,
			  575,  599,  593,  575,  575,  575,  575,  600,  610,  579,
			    0,  579,  595,  576,  579,  579,  579,  579,  594,  594,

			  594,  603,  596,  604,  603,  605,  604,    0,  605,  619,
			  625,  597,    0,  599,  610,  611,  611,  611,  611,  600,
			  610,  612,  612,  612,  612,  613,  613,  613,  613,  594,
			  614,  614,  614,  614,  615,  615,  615,  615,  616,  603,
			  616,  619,  625,  616,  616,  616,  616,  628,  629,  615,
			  631,  637,  603,  642,  604,  643,  605,  617,  617,  617,
			  617,  594,  618,  618,  618,  618,  627,  627,  627,  634,
			  647,  603,  634,  638,  638,  638,  638,  637,  648,  628,
			  629,  615,  631,  637,  603,  642,  604,  643,  605,  639,
			  639,  639,  639,  649,  650,  651,    0,  627,  672,  672,

			  672,    0,  647,  674,  674,  674,    0,  661,    0,  661,
			  648,  661,  661,  661,  661,  661,  661,  661,  661,  661,
			  634,  675,  675,  675,    0,  649,  650,  651,    0,  627,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  634,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  656,  656,
			  656,  656,  656,  656,  656,  656,  656,  656,  656,  656,
			  656,  656,  656,  657,  657,  657,  657,  657,  657,  657,
			  657,  657,  657,  657,  657,  657,  657,  657,  658,  658,

			  658,  658,  658,  658,  658,  658,  658,  658,  658,  658,
			  658,  658,  658,  659,  659,  659,  659,  659,  659,  659,
			  659,  659,  659,  659,  659,  659,  659,  659,  660,    0,
			  660,  660,  660,  660,  660,  660,  660,  660,  660,  660,
			  660,  660,  660,  662,    0,  662,  662,  662,  662,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  664,    0,
			  664,  664,  664,    0,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  665,  665,  665,  665,  665,  665,  665,
			  665,  665,  665,  665,  665,  665,  665,  665,  666,  666,
			  666,  666,  666,  666,  666,  666,  666,  666,  666,  666,

			  666,  666,  666,  667,  667,  667,  667,  667,  667,  667,
			  667,  667,  667,  667,  667,  667,  667,  667,  668,    0,
			  668,  668,  668,  668,  668,  668,  668,  668,  668,  668,
			  668,  668,  668,  669,    0,  669,    0,  669,  669,  669,
			  669,  669,  669,  669,  669,  669,  669,  669,  670,    0,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  670,  670,  670,  673,    0,  673,  673,  673,  673,  673,
			  673,  673,  673,  673,  673,  673,  673,  673,  676,  676,
			  676,  676,  676,  676,  676,  676,  676,  676,  676,  676,
			  676,  676,  676,  677,    0,  677,  677,  677,  677,  677,

			  677,  677,  677,  677,  677,  677,  677,  677,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,

			  654, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   90,   91,   99,  104, 1136, 1075,  109,
			  112,  115,  118, 1076, 1908,  121,  124, 1908,  190,    0,
			 1908,  120, 1908, 1908, 1908, 1908, 1908,   81,  122,  120,
			  128,  147,  154, 1048, 1908,  107, 1908,  109, 1034,  182,
			   91,  185,  121,  195,  239,    0,  239,  114,  107,  252,
			  123,  120,  175,  247,  136,  209,  143,  161, 1908,  959,
			 1908, 1908, 1908,  924, 1908, 1004, 1908, 1908,  331,  240,
			  307, 1908, 1908,  286, 1005, 1908, 1908,  301, 1908, 1908,
			  319,  343,  982,  351,  933,  330, 1908,  384,  171,  332,
			  342,  343,  365,  385,  386,  395,  401,  400,  399,  405,

			  421,  409,  411,  493,    0,  938,  577,  926, 1908, 1908,
			 1908,  414, 1908, 1908,  485,  493,  501,  181,  439,    0,
			  506, 1908, 1908, 1908, 1908, 1908, 1908, 1908,    0,  206,
			  430,  211,  244,  247,  249,  289,  339,  352,  362,  368,
			  419,    0,  384,  404,  486,  444,  478,  467,    0,  471,
			  568,    0,  490,  500,  484,  488,  504,  506,    0,  492,
			  507,  596,  501,  498,  518,  504,  513,  573,  512,  522,
			  549,  551, 1908, 1908,  914, 1908,  654, 1908, 1908, 1908,
			 1908, 1908,  645, 1908, 1908, 1908, 1908, 1908, 1908, 1908,
			 1908, 1908, 1908, 1908, 1908, 1908, 1908, 1908, 1908,  355,

			 1908, 1908,  667,  570, 1908,  834, 1908,  489, 1908,  657,
			  785, 1908, 1908,  678,  686, 1908, 1908, 1908, 1908,  641,
			 1908,  642, 1908,  677,  685,  687,  691,  697,  698,  706,
			 1908,  696,  705, 1908, 1908, 1908,  779,  778,  766,  748,
			  725,  700,  714,  665,  630,  626,  607,  603,  589,  586,
			  570,  547,  540,  524,  519,  453,  452,  435, 1908,  717,
			  776, 1908,  748,  785,  791,  798,  574,  379,  696,  365,
			  804,  808,  557,  591,    0,    0,  603,  605,    0,  659,
			  646,  661,  697,  681,  681,  712,  714,    0,  699,  772,
			  721,  723,  751,  789,  768,  799,  797,  803,  793,  809,

			  806,  812,  798,  811,  802,    0,  813,  795,  801,  820,
			  819,  822,  827,  809,  830,  813,  827,  836,  835,  840,
			  852,  849,  861,  850,  859,  861,  867,  858,    0, 1908,
			  888,    0,  329,  901, 1908, 1908, 1908,  908,  909,  915,
			  929, 1908,  916, 1908, 1908, 1908, 1908, 1908, 1908, 1908,
			  920,  925, 1908, 1908, 1908, 1908, 1908, 1908, 1908, 1908,
			 1908, 1908, 1908, 1908, 1908, 1908, 1908, 1908,  934,  939,
			  955,  959,  992,  999, 1007, 1013, 1019,  906,  316,    0,
			  315,  354, 1026, 1032,  881,  887,  933,  932,  950,  943,
			  958,  950,  976, 1001, 1003, 1017, 1009, 1014, 1011, 1012,

			 1027, 1012,    0, 1029, 1026, 1012, 1013, 1020, 1034, 1023,
			    0, 1030,    0,    0, 1031, 1104,    0, 1040, 1030, 1043,
			 1048, 1037, 1043, 1063, 1058, 1070, 1060, 1086, 1072, 1076,
			    0,    0, 1088, 1088, 1074, 1084, 1096,    0,    0, 1908,
			 1109,  241, 1127, 1908, 1129, 1908, 1131, 1908,  297,  270,
			  967,    0, 1140, 1144, 1158, 1149, 1169, 1176, 1192,    0,
			    0, 1098, 1118,    0,    0, 1105, 1167, 1132,    0, 1147,
			 1165, 1168, 1170, 1167, 1178,    0, 1175, 1180, 1191, 1189,
			    0, 1190, 1197, 1192,    0, 1197, 1242, 1908,  284, 1206,
			 1191, 1186, 1202, 1207, 1212, 1202, 1216, 1202,    0, 1207,

			 1234,    0,    0, 1227, 1232,    0, 1224,  259,  176, 1269,
			 1271, 1284, 1908, 1266,  299, 1282,  537, 1293, 1297, 1301,
			 1324, 1333, 1349,    0, 1254, 1275,    0, 1284, 1280, 1296,
			    0,    0, 1299,    0, 1311, 1314,    0, 1302, 1315, 1325,
			 1326, 1346, 1328, 1908,  219, 1337, 1331,    0, 1338, 1341,
			    0, 1351,    0,    0,    0, 1337, 1344,    0, 1339,  150,
			 1387, 1386, 1388,  183,  164,  167,  112,  153,  138,   93,
			   34, 1378, 1382, 1404, 1436, 1463, 1426, 1408, 1442, 1474,
			 1356,    0, 1390,    0, 1402, 1403, 1398,    0,    0, 1404,
			    0,    0, 1398, 1415, 1496, 1415, 1435, 1446,    0, 1446,

			 1452,    0,    0, 1495, 1497, 1499, 1908, 1908, 1908, 1908,
			 1453, 1495, 1501, 1505, 1510, 1514, 1523, 1537, 1542, 1474,
			    0,    0,    0,    0,    0, 1460,    0, 1564, 1505, 1500,
			    0, 1515,    0,    0, 1563, 1908, 1908, 1516, 1553, 1569,
			    0,    0, 1511, 1524,    0,    0, 1908, 1539, 1529, 1544,
			 1545, 1546,    0, 1908, 1908, 1652, 1667, 1682, 1697, 1712,
			 1727, 1604, 1742, 1623, 1757, 1772, 1787, 1802, 1817, 1832,
			 1847, 1287, 1591, 1862, 1596, 1614, 1877, 1892, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  654,    1,  655,  655,  656,  656,  657,  657,  658,
			  658,  659,  659,  654,  654,  654,  654,  654,  660,  661,
			  654,  662,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  654,  654,
			  654,  654,  654,  654,  654,  664,  654,  654,  654,  665,
			  665,  654,  654,  666,  667,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  660,  654,  668,  669,  660,
			  660,  660,  660,  660,  660,  660,  660,  660,  660,  660,

			  660,  660,  660,  660,  661,  670,  670,  670,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  671,  671,  672,
			  654,  654,  654,  654,  654,  654,  654,  654,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  654,  654,  664,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  665,

			  654,  654,  665,  666,  654,  667,  654,  654,  654,  654,
			  673,  654,  654,  668,  669,  654,  654,  654,  654,  660,
			  654,  660,  654,  660,  660,  660,  660,  660,  660,  660,
			  654,  660,  660,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  671,  671,  671,  672,
			  654,  654,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,

			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  654,
			  654,  673,  673,  669,  654,  654,  654,  660,  660,  660,
			  660,  654,  660,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  671,  671,  268,
			  672,  654,  654,  654,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,

			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  654,
			  654,  673,  660,  654,  660,  654,  660,  654,  654,  674,
			  674,  675,  654,  654,  654,  654,  654,  654,  654,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  654,  654,  654,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,

			  663,  663,  663,  663,  663,  663,  663,  654,  673,  660,
			  660,  660,  654,  674,  674,  674,  675,  654,  654,  654,
			  654,  654,  654,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  654,  676,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  673,
			  660,  660,  660,  654,  513,  654,  674,  654,  515,  654,
			  675,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,

			  663,  663,  677,  660,  660,  660,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  663,
			  663,  663,  663,  663,  663,  663,  663,  654,  663,  663,
			  663,  663,  663,  663,  660,  654,  654,  654,  654,  654,
			  663,  663,  654,  663,  663,  663,  654,  654,  663,  654,
			  663,  654,  663,  654,    0,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654,  654,  654,
			  654,  654,  654,  654,  654,  654,  654,  654, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
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
			   86,   87,   88,   89,   90,   91,   92,    1,    1,    1,
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
			    7,    7,    8,    9,    3,    3,    3,    3,    3,    3,
			    3,    7,    7,    7,    7,    7,    7,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   11,   12,    3,    3,    3,
			    3,   13,    3,    7,    7,    7,    7,    7,    7,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   14,   15,    3,
			    3,    3,    3, yy_Dummy>>)
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
			  228,  228,  229,  230,  231,  232,  233,  234,  235,  236,
			  237,  238,  239,  241,  242,  243,  244,  245,  246,  247,
			  248,  249,  251,  252,  253,  254,  255,  256,  257,  259,
			  260,  261,  263,  264,  265,  266,  267,  268,  269,  271,
			  272,  273,  274,  275,  276,  277,  278,  279,  280,  281,
			  282,  283,  284,  285,  286,  287,  288,  288,  289,  290,
			  291,  292,  293,  293,  294,  295,  296,  297,  298,  299,
			  300,  301,  302,  303,  304,  305,  306,  307,  308,  309,

			  310,  311,  312,  313,  314,  316,  317,  318,  318,  319,
			  320,  321,  322,  324,  326,  327,  329,  331,  333,  335,
			  336,  338,  339,  341,  342,  343,  344,  345,  346,  347,
			  348,  349,  350,  351,  353,  354,  356,  357,  358,  359,
			  360,  361,  362,  363,  364,  365,  366,  367,  368,  369,
			  370,  371,  372,  373,  374,  375,  376,  377,  378,  380,
			  381,  381,  382,  383,  383,  384,  385,  387,  388,  390,
			  391,  392,  392,  393,  394,  396,  398,  399,  400,  402,
			  403,  404,  405,  406,  407,  408,  409,  410,  412,  413,
			  414,  415,  416,  417,  418,  419,  420,  421,  422,  423,

			  424,  425,  426,  427,  429,  430,  432,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,
			  446,  447,  448,  449,  450,  451,  452,  453,  454,  456,
			  457,  457,  458,  459,  459,  461,  463,  465,  466,  467,
			  468,  469,  471,  472,  474,  476,  477,  478,  479,  480,
			  481,  482,  483,  484,  485,  486,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  499,  500,
			  500,  501,  502,  502,  502,  503,  504,  505,  505,  505,
			  505,  505,  505,  506,  507,  508,  509,  510,  511,  512,
			  513,  514,  515,  516,  517,  518,  520,  521,  522,  523,

			  524,  525,  526,  528,  529,  530,  531,  532,  533,  534,
			  535,  537,  538,  540,  542,  543,  545,  547,  548,  549,
			  550,  551,  552,  553,  554,  555,  556,  557,  558,  559,
			  560,  562,  564,  565,  566,  567,  568,  569,  571,  573,
			  574,  574,  575,  576,  578,  579,  581,  582,  584,  585,
			  585,  585,  585,  586,  586,  587,  587,  588,  589,  590,
			  592,  594,  595,  596,  598,  600,  601,  602,  603,  605,
			  606,  607,  608,  609,  610,  611,  613,  614,  615,  616,
			  617,  619,  620,  621,  622,  624,  625,  625,  626,  626,
			  627,  628,  629,  630,  631,  632,  633,  634,  635,  637,

			  638,  639,  641,  643,  644,  645,  647,  648,  648,  649,
			  650,  651,  652,  653,  653,  653,  653,  653,  653,  654,
			  655,  655,  655,  656,  658,  659,  660,  662,  663,  664,
			  665,  667,  669,  670,  672,  673,  674,  676,  677,  678,
			  679,  680,  681,  682,  683,  683,  684,  685,  687,  688,
			  689,  691,  692,  694,  696,  698,  699,  700,  702,  703,
			  704,  705,  706,  707,  707,  707,  707,  707,  707,  707,
			  707,  707,  707,  708,  709,  709,  709,  710,  710,  711,
			  711,  712,  714,  715,  717,  718,  719,  720,  722,  724,
			  725,  727,  729,  730,  731,  732,  733,  734,  735,  737,

			  738,  739,  741,  743,  744,  745,  746,  748,  749,  751,
			  752,  753,  753,  754,  754,  755,  756,  756,  756,  757,
			  758,  760,  762,  764,  766,  768,  769,  771,  771,  772,
			  773,  775,  776,  778,  780,  781,  783,  785,  786,  786,
			  787,  789,  791,  791,  792,  794,  796,  798,  798,  799,
			  799,  800,  800,  802,  803,  803, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  180,  180,  182,  182,  213,  211,  212,    1,  211,
			  212,    1,  212,   36,  211,  212,  183,  211,  212,   41,
			  211,  212,   15,  211,  212,  150,  211,  212,   24,  211,
			  212,   25,  211,  212,   32,  211,  212,   30,  211,  212,
			    9,  211,  212,   31,  211,  212,   14,  211,  212,   33,
			  211,  212,  115,  211,  212,  115,  211,  212,  115,  211,
			  212,    8,  211,  212,    7,  211,  212,   19,  211,  212,
			   18,  211,  212,   20,  211,  212,   11,  211,  212,  113,
			  211,  212,  113,  211,  212,  113,  211,  212,  113,  211,
			  212,  113,  211,  212,  113,  211,  212,  113,  211,  212,

			  113,  211,  212,  113,  211,  212,  113,  211,  212,  113,
			  211,  212,  113,  211,  212,  113,  211,  212,  113,  211,
			  212,  113,  211,  212,  113,  211,  212,  113,  211,  212,
			  113,  211,  212,  113,  211,  212,   28,  211,  212,  211,
			  212,   29,  211,  212,   34,  211,  212,   26,  211,  212,
			   27,  211,  212,   12,  211,  212,  184,  212,  210,  212,
			  208,  212,  209,  212,  180,  212,  180,  212,  179,  212,
			  178,  212,  180,  212,  182,  212,  181,  212,  176,  212,
			  176,  212,  175,  212,    6,  212,    5,    6,  212,    5,
			  212,    6,  212,    1,  183,  172,  183,  183,  183,  183,

			  183,  183,  183,  183,  183,  183,  183,  183,  183, -386,
			  183,  183,  183, -386,   41,  150,  150,  150,    2,   35,
			   10,  121,   39,   23,  121,  115,  115,  114,  114,   16,
			   37,   21,   22,   38,   17,  113,  113,  113,  113,   46,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,   58,
			  113,  113,  113,  113,  113,  113,  113,   70,  113,  113,
			  113,   77,  113,  113,  113,  113,  113,  113,  113,   89,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,   40,   13,  184,  208,  201,  199,
			  200,  202,  203,  204,  205,  185,  186,  187,  188,  189,

			  190,  191,  192,  193,  194,  195,  196,  197,  198,  180,
			  179,  178,  180,  180,  177,  178,  182,  181,  175,    5,
			    4,  173,  171,  173,  183, -386, -386,  158,  173,  156,
			  173,  157,  173,  159,  173,  183,  152,  173,  183,  153,
			  173,  183,  183,  183,  183,  183,  183,  183, -174,  183,
			  183,  160,  173,  150,  122,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  123,  150,
			  121,  116,  121,  115,  115,  119,  120,  120,  118,  120,
			  117,  115,  113,  113,   44,  113,   45,  113,  113,  113,

			   49,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			   61,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,   81,  113,  113,
			   84,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  112,  113,  207,    4,    4,  161,
			  173,  154,  173,  155,  173,  183,  183,  183,  183,  168,
			  173,  183,  163,  173,  162,  173,  140,  138,  139,  141,
			  142,  151,  151,  143,  144,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  121,

			  121,  121,  121,  115,  115,  115,  115,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,   59,  113,
			  113,  113,  113,  113,  113,  113,   68,  113,  113,  113,
			  113,  113,  113,  113,  113,   78,  113,  113,   80,  113,
			   82,  113,  113,   87,  113,   88,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  103,  113,  104,  113,  113,  113,  113,  113,  113,  110,
			  113,  111,  113,  206,    4,  183,  164,  173,  183,  167,
			  173,  183,  170,  173,  151,  121,  121,  121,  121,  115,
			   42,  113,   43,  113,  113,  113,   50,  113,   51,  113,

			  113,  113,  113,   56,  113,  113,  113,  113,  113,  113,
			  113,   66,  113,  113,  113,  113,  113,   73,  113,  113,
			  113,  113,   79,  113,  113,   85,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,   99,  113,  113,  113,  102,
			  113,  105,  113,  113,  113,  108,  113,  113,    4,  183,
			  183,  183,  145,  121,  121,  121,   47,  113,  113,  113,
			   53,  113,  113,  113,  113,   60,  113,   62,  113,  113,
			   64,  113,  113,  113,   69,  113,  113,  113,  113,  113,
			  113,  113,   86,  113,  113,   92,  113,  113,  113,   95,
			  113,  113,   97,  113,   98,  113,  100,  113,  113,  113,

			  107,  113,  113,    4,  183,  183,  183,  121,  121,  121,
			  121,  113,   52,  113,  113,   55,  113,  113,  113,  113,
			   67,  113,   71,  113,  113,   74,  113,   75,  113,  113,
			  113,  113,  113,  113,  113,   96,  113,  113,  113,  109,
			  113,    3,    4,  183,  183,  183,  148,  149,  149,  147,
			  149,  146,  121,  121,  121,  121,  121,  113,   54,  113,
			   57,  113,   63,  113,   65,  113,   72,  113,  113,   83,
			  113,  113,  113,   93,  113,  113,  101,  113,  106,  113,
			  183,  166,  173,  169,  173,  121,  121,   48,  113,   76,
			  113,  113,   91,  113,   94,  113,  165,  173,  113,  113,

			   90,  113,   90, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1908
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 654
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 655
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

	yyNb_rules: INTEGER is 212
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 213
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



indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_SCANNER
