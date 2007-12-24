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

				last_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			
when 24 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 154 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 154")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 158 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 158")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 162 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 162")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 166 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 166")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 170 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 170")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 174")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 178 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 178")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 182 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 182")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 186 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 186")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 190 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 190")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 34 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 194 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 194")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 35 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 198")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 36 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 202 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 202")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 37 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 206 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 206")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 38 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 210 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 210")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 39 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 214 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 214")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 40 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 218 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 218")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 41 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 222 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 222")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 42 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 230 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 230")
end

				last_token := TE_FREE
				process_id_as
			
when 43 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 238 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 238")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 242 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 242")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 246 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 246")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 250 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 250")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 47 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 254 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 254")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 48 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 258 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 258")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_keyword_as_id_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
when 49 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 265 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 265")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 50 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 274 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 274")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "The `bit' keyword will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 283 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 283")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 52 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 287 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 287")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 53 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 291 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 291")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 54 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 295 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 295")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 55 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 299 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 299")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
when 56 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 303 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 303")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 57 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 307 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 307")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 58 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 311 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 311")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
when 59 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 315 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 315")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 60 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 319 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 319")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 61 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 323 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 323")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 62 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 327 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 327")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 63 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 331 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 331")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 64 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 335 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 335")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 65 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 339 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 339")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 66 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 343 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 343")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 67 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 347 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 347")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 68 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 351 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 351")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 69 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 355 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 355")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 70 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 359 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 359")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 71 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 363 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 363")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 72 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 367 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 367")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 73 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 371 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 371")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
when 74 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 375 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 375")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 75 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 379 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 379")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 76 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 383 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 383")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 77 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 387 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 387")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 78 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 391 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 391")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
when 79 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 395 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 395")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 80 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 399 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 399")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 81 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 403 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 403")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 82 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 407 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 407")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 83 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 411 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 411")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 84 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 420 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 420")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 85 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 424 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 424")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 86 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 440 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 440")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 87 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
when 88 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 451 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 451")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 89 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 455 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 455")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 90 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 464 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 464")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 91 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 468 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 468")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 92 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 472 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 472")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 93 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 476 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 476")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 94 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 480 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 480")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 95 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 484 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 484")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 96 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 488 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 488")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 97 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 492 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 492")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 98 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 496 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 496")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 99 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 500 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 500")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 100 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 504 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 504")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 508 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 508")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 102 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 512 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 512")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 103 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 516 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 516")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 520 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 520")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 524 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 524")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 106 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 528 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 528")
end

				last_token := TE_TUPLE
				process_id_as
			
when 107 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 532 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 532")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 108 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 536 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 536")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 109 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 540 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 540")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 110 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 544 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 544")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 111 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 548 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 548")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 112 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 552 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 552")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 113 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 556 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 556")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 564 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 564")
end

				last_token := TE_ID
				process_id_as
			
when 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 571 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 571")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of bit syntax will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			
when 116 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 585 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 585")
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
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 586 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 586")
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
			
when 118 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 598 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 598")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 604 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 604")
end
		-- Recognizes octal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 610 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 610")
end
		-- Recognizes binary integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 616 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 616")
end
		-- Recognizes erronous binary and octal numbers.
				report_invalid_integer_error (token_buffer)
			
when 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 623 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 623")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			
when 123 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 633 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 633")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 124 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 639 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 639")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 646 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 646")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 652 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 652")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 658 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 658")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 664 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 664")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 670 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 670")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 676 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 676")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 682 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 682")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 688 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 688")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 694 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 694")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 700 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 700")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 706 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 706")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 712 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 712")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 718 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 718")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 724 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 724")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 139 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 730 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 730")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 736 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 736")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 742 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 742")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 748 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 748")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 754 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 754")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 760 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 760")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 145 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 766 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 766")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 146 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 772 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 772")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 147 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 773 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 773")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 148 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 774 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 774")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 149 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 775 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 775")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 150 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 782 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 782")
end

				report_invalid_integer_error (token_buffer)
			
when 151 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 787 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 787")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 152 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 788 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 788")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 153 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 797 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 797")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 154 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 801 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 801")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 805 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 805")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 156 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 809 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 809")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 157 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 813 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 813")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 158 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 817 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 817")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 159 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 821 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 821")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 160 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 825 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 825")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 161 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 829 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 829")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 162 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 833 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 833")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 163 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 164 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 165 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 845 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 845")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 166 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 851 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 851")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 167 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 857 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 857")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 168 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 863 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 863")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 169 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 869 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 869")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 170 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 875 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 875")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 171 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 881 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 881")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 887 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 887")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 173 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 896 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 896")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 174 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 902 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 902")
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
			
when 175 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 913 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 913")
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
			
when 176 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 931 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 931")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 177 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 935 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 935")
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
			
when 178 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 955 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 955")
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
							report_one_warning (
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
			
when 179 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 998 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 998")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 180 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1003 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1003")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 181 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1011 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1011")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 182 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1027 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1027")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 183 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1036 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1036")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 184 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1049 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1049")
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
			
when 185 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1061 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1061")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1065 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1065")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%A")
				token_buffer.append_character ('%A')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1069 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1069")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%B")
				token_buffer.append_character ('%B')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1073 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1073")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%C")
				token_buffer.append_character ('%C')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1077 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1077")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%D")
				token_buffer.append_character ('%D')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1081 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1081")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%F")
				token_buffer.append_character ('%F')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1085 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1085")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%H")
				token_buffer.append_character ('%H')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1089 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1089")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%L")
				token_buffer.append_character ('%L')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1093 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1093")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%N")
				token_buffer.append_character ('%N')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1097 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1097")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%Q")
				token_buffer.append_character ('%Q')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1101 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1101")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%R")
				token_buffer.append_character ('%R')
			
when 196 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1105 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1105")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%S")
				token_buffer.append_character ('%S')
			
when 197 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1109 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1109")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%T")
				token_buffer.append_character ('%T')
			
when 198 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1113 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1113")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%U")
				token_buffer.append_character ('%U')
			
when 199 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1117 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1117")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%V")
				token_buffer.append_character ('%V')
			
when 200 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1121 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1121")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%%")
				token_buffer.append_character ('%%')
			
when 201 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1125 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1125")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%'")
				token_buffer.append_character ('%'')
			
when 202 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1129 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1129")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%%"")
				token_buffer.append_character ('%"')
			
when 203 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1133 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1133")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%(")
				token_buffer.append_character ('%(')
			
when 204 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1137 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1137")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%)")
				token_buffer.append_character ('%)')
			
when 205 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1141 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1141")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%<")
				token_buffer.append_character ('%<')
			
when 206 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1145 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1145")
end

				ast_factory.append_string_to_buffer (token_buffer2, once "%%>")
				token_buffer.append_character ('%>')
			
when 207 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1149 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1149")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 208 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1153 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1153")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 209 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1158 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1158")
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
			
when 210 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1174")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 211 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1180 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1180")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 212 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1198")
end

				report_unknown_token_error (text_item (1))
			
when 213 then
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
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2002)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,   14,   15,   16,   15,   17,   18,   19,   20,   14,
			   19,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   32,   33,   34,   35,   36,   37,   38,
			   19,   39,   40,   41,   42,   43,   44,   45,   45,   46,
			   45,   45,   47,   45,   48,   49,   50,   45,   51,   52,
			   53,   54,   55,   56,   57,   45,   45,   58,   59,   60,
			   61,   14,   14,   39,   40,   41,   42,   43,   44,   45,
			   45,   46,   45,   45,   47,   45,   48,   49,   50,   45,
			   51,   52,   53,   54,   55,   56,   57,   45,   45,   62,
			   19,   63,   64,   66,   66,  571,   67,   67,  108,   68,

			   68,   70,   71,   70,  610,   72,   70,   71,   70,  109,
			   72,   77,   78,   77,   77,   78,   77,   80,   81,   80,
			   80,   81,   80,   83,   83,   83,   83,   83,   83,  106,
			  135,  107,   82,  124,  125,   82,  126,  127,   84,  112,
			  110,   84,  111,  111,  111,  111,  115,  113,  116,  116,
			  117,  117,  155,  153,  160,  162,  141,  655,   73,  154,
			  118,  119,  135,   73,  609,  115,  142,  116,  116,  117,
			  117,  161,  115,  567,  117,  117,  117,  117,  608,  122,
			  201,  168,  120,  202,  155,  153,  160,  162,  141,  121,
			   73,  154,  118,  119,  655,   73,   86,   87,  142,   88,

			   87,  267,  267,  161,   89,   90,  171,   91,  121,   92,
			  163,  122,  114,  168,  120,  121,   93,  607,   94,  130,
			   87,   95,  603,  136,  131,  164,  132,  137,  172,   96,
			  138,  133,  134,  139,   97,   98,  140,  143,  171,  144,
			  169,  215,  163,  201,   99,  273,  205,  100,  101,  145,
			  102,  130,  487,   95,  170,  136,  131,  164,  132,  137,
			  172,   96,  138,  133,  134,  139,   97,   98,  140,  143,
			  146,  144,  169,  215,  147,  149,   99,  273,  560,  103,
			   87,  145,  150,  151,  156,  165,  170,  148,  152,  208,
			  209,  208,  276,  277,  157,  166,  158,  278,  167,  279,

			  159,  440,  146,  210,  210,  210,  147,  149,  545,  203,
			  201,  203,  513,  202,  150,  151,  156,  165,  509,  148,
			  152,  210,  210,  210,  276,  277,  157,  166,  158,  278,
			  167,  279,  159,  177,  177,  177,  212,  178,  216,   88,
			  179,   88,  180,  181,  182,   83,   83,   83,   85,   85,
			  183,   85,  217,  213,  280,   88,   88,  184,  218,  185,
			   84,   88,  186,  187,  188,  189,  204,  190,  262,  191,
			  381,  219,  379,  192,   88,  193,  514,  514,  194,  195,
			  196,  197,  198,  199,  220,  201,  280,  103,  202,  103,
			  442,  221,  223,  212,   88,   88,   88,  212,  204,  212,

			   88,  381,   88,  103,  214,  212,  379,  212,   88,  103,
			   88,  234,  222,  224,   88,  368,  230,  231,  230,  103,
			  212,  103,  103,   88,  367,  281,  230,  231,  230,  366,
			  212,  225,  282,   88,  226,  103,  214,  274,  227,  365,
			  275,  103,  103,  103,  103,  283,  229,  228,  103,  212,
			  103,  566,   88,  364,  103,  284,  103,  281,  103,  269,
			  269,  269,  103,  225,  282,  287,  226,  267,  267,  274,
			  227,  103,  275,  232,  103,  103,  103,  283,  229,  228,
			  103,  103,  103,  260,  260,  260,  260,  284,  103,  201,
			  103,  363,  205,  567,  103,  285,  288,  287,  261,  286,

			  103,  233,  262,  103,  263,  263,  263,  263,  378,  292,
			  293,  289,  294,  103,  362,  271,  271,  271,  271,  264,
			  295,  115,  301,  265,  265,  266,  266,  285,  288,  361,
			  261,  286,  103,  237,  360,  122,  238,  359,  239,  240,
			  241,  292,  293,  289,  294,  115,  242,  266,  266,  266,
			  266,  264,  295,  243,  301,  244,  272,  304,  245,  246,
			  247,  248,  290,  249,  121,  250,  291,  122,  296,  251,
			  297,  252,  298,  302,  253,  254,  255,  256,  257,  258,
			  305,  306,  307,  299,  309,  303,  300,  310,  121,  304,
			  319,  308,  317,  311,  290,  312,  318,  320,  291,  321,

			  296,  322,  297,  313,  298,  302,  314,  326,  315,  316,
			  327,  328,  305,  306,  307,  299,  309,  303,  300,  310,
			  329,  323,  319,  308,  317,  311,  324,  312,  318,  320,
			  358,  321,  357,  322,  356,  313,  355,  325,  314,  326,
			  315,  316,  327,  328,  177,  177,  177,  331,  331,  331,
			  331,  330,  329,  323,  354,  203,  201,  203,  324,  202,
			  208,  209,  208,  210,  210,  210,  334,  231,  334,  325,
			   85,  230,  231,  230,  335,  213,  336,   88,   88,   88,
			  337,  212,  212,   88,   88,   88,  212,  385,  344,   88,
			  341,   88,  342,  353,  212,   88,  345,   88,  350,   88,

			  230,  231,  230,  386,  212,  349,  387,   88,  388,  338,
			  389,  348,  204,  351,  352,  352,  352,  390,  391,  385,
			  392,  215,  339,  347,  393,  103,  214,  103,  394,  395,
			  340,  103,  103,  103,  396,  386,  343,  103,  387,  103,
			  388,  338,  389,  103,  204,  103,  397,  103,  346,  390,
			  391,  333,  392,  215,  339,  103,  393,  103,  214,  103,
			  394,  395,  340,  103,  103,  103,  396,  207,  343,  103,
			  176,  103,  400,  259,  236,  103,  108,  103,  397,  103,
			  369,  369,  369,  369,  370,  401,  370,  103,  211,  371,
			  371,  371,  371,  402,  405,  261,  372,  372,  372,  372,

			  374,  207,  374,  176,  400,  375,  375,  375,  375,  398,
			  115,  373,  376,  376,  377,  377,  115,  401,  377,  377,
			  377,  377,  406,  399,  122,  402,  405,  261,  269,  269,
			  269,  382,  403,  383,  383,  383,  383,  384,  384,  384,
			  384,  398,  174,  373,  407,  404,  173,  408,  409,  410,
			  411,  412,  413,  121,  406,  399,  122,  414,  415,  121,
			  416,  417,  418,  419,  403,  421,  420,  422,  423,  380,
			  424,  427,  428,  425,  272,  429,  407,  404,  272,  408,
			  409,  410,  411,  412,  413,  430,  431,  432,  433,  414,
			  415,  426,  416,  417,  418,  419,  434,  421,  420,  422,

			  423,  435,  424,  427,  428,  425,  436,  429,  437,  438,
			  439,  440,  441,  441,  441,  441,  460,  430,  431,  432,
			  433,  267,  267,  426,  334,  231,  334,  443,  434,  444,
			  128,  212,   88,  435,   88,  123,  446,  655,  436,   88,
			  437,  438,  439,  212,  448,  461,   88,   88,  460,  462,
			   75,  449,  352,  352,  352,  352,  449,  352,  352,  352,
			  352,  463,  378,   75,  450,  451,  464,  445,  453,  453,
			  453,  453,  447,  371,  371,  371,  371,  461,  465,  215,
			  103,  462,  103,  261,  466,  467,  452,  103,  371,  371,
			  371,  371,  468,  463,  103,  103,  450,  451,  464,  445, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  375,  375,  447,  455,  455,  455,  455,  454,
			  465,  215,  103,  655,  103,  261,  466,  467,  452,  103,
			  373,  655,  655,  456,  468,  456,  103,  103,  457,  457,
			  457,  457,  375,  375,  375,  375,  458,  469,  376,  376,
			  377,  377,  458,  470,  377,  377,  377,  377,  471,  472,
			  122,  382,  373,  459,  459,  459,  459,  382,  473,  384,
			  384,  384,  384,  474,  475,  476,  477,  478,  655,  469,
			  479,  480,  481,  482,  483,  470,  484,  485,  486,  272,
			  471,  472,  122,  655,  490,  272,  491,  492,  493,  494,
			  473,  495,  496,  497,  272,  474,  475,  476,  477,  478,

			  272,  498,  479,  480,  481,  482,  483,  499,  484,  485,
			  486,  487,  487,  487,  500,  488,  490,  501,  491,  492,
			  493,  494,  502,  495,  496,  497,  489,  503,  504,  505,
			  506,  507,  655,  498,  440,  508,  508,  508,  508,  499,
			  212,  212,  212,   88,   88,   88,  500,  655,  655,  501,
			  516,  516,  516,  655,  502,  453,  453,  453,  453,  503,
			  504,  505,  506,  507,  519,  519,  519,  519,  524,  525,
			  518,  526,  527,  529,  511,  530,  528,  655,  512,  520,
			  520,  520,  520,  531,  510,  457,  457,  457,  457,  532,
			  533,  103,  103,  103,  373,  457,  457,  457,  457,  655,

			  524,  525,  518,  526,  527,  529,  511,  530,  528,  523,
			  512,  384,  384,  384,  384,  531,  510,  534,  535,  536,
			  521,  532,  533,  103,  103,  103,  373,  262,  537,  520,
			  520,  520,  520,  538,  539,  540,  541,  542,  543,  487,
			  487,  487,  546,  544,  522,  547,  548,  549,  550,  534,
			  535,  536,  121,  551,  489,  552,  553,  554,  555,  556,
			  537,  557,  558,  559,  570,  538,  539,  540,  541,  542,
			  543,  581,  212,  582,  546,   88,  522,  547,  548,  549,
			  550,  212,  655,  212,   88,  551,   88,  552,  553,  554,
			  555,  556,  583,  557,  558,  559,  564,  514,  514,  568,

			  516,  516,  516,  581,  561,  582,  571,  572,  584,  572,
			  562,  585,  573,  573,  573,  573,  574,  574,  574,  574,
			  586,  587,  588,  103,  583,  589,  563,  577,  577,  577,
			  577,  575,  103,  655,  103,  655,  561,  590,  565,  655,
			  584,  569,  562,  585,  520,  520,  520,  520,  655,  591,
			  592,  593,  586,  587,  588,  103,  594,  589,  563,  576,
			  655,  595,  596,  575,  103,  578,  103,  578,  597,  590,
			  579,  579,  579,  579,  598,  262,  599,  577,  577,  577,
			  577,  591,  592,  593,  600,  601,  602,  212,  594,  655,
			   88,  576,  580,  595,  596,  655,  212,  620,  212,   88,

			  597,   88,  573,  573,  573,  573,  598,  621,  599,  573,
			  573,  573,  573,  622,  655,  655,  600,  601,  602,  611,
			  611,  611,  611,  623,  580,  604,  624,  606,  625,  620,
			  605,  626,  627,  630,  575,  612,  655,  612,  103,  621,
			  613,  613,  613,  613,  655,  622,  614,  103,  614,  103,
			  655,  615,  615,  615,  615,  623,  631,  604,  624,  606,
			  625,  655,  605,  626,  627,  630,  575,  628,  628,  628,
			  103,  616,  616,  616,  616,  579,  579,  579,  579,  103,
			  632,  103,  579,  579,  579,  579,  617,  618,  631,  618,
			  633,  634,  619,  619,  619,  619,  212,  636,  629,   88,

			   88,  637,  655,  575,   88,  613,  613,  613,  613,  268,
			  268,  268,  632,  613,  613,  613,  613,  641,  617,  628,
			  628,  628,  633,  634,  615,  615,  615,  615,  655,  454,
			  629,  655,  642,  644,  635,  575,  615,  615,  615,  615,
			  638,  638,  638,  638,  645,  646,  617,  103,  103,  641,
			  643,  639,  103,  639,  648,  617,  640,  640,  640,  640,
			  619,  619,  619,  619,  642,  644,  635,  619,  619,  619,
			  619,  647,  521,  649,   88,  650,  645,  646,  617,  103,
			  103,  651,  643,  652,  103,  653,  648,  617,  640,  640,
			  640,  640,  640,  640,  640,  640,  654,  270,  270,  270,

			  515,  515,  515,  655,  655,  649,  655,  650,  517,  517,
			  517,  655,  655,  651,  655,  652,  655,  653,  655,  655,
			  655,  655,  103,  655,  655,  104,  655,  104,  654,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  655,  655,  655,
			  655,  655,  655,  655,  103,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,

			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   76,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   85,  655,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,  105,  655,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  175,  655,  175,  175,  175,  655,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  204,

			  204,  204,  204,  204,  204,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			   87,  655,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   88,  655,   88,  655,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			  235,  655,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  332,  655,  332,  332,  332,
			  332,  332,  332,  332,  332,  332,  332,  332,  332,  332,
			  545,  545,  545,  545,  545,  545,  545,  545,  545,  545,
			  545,  545,  545,  545,  545,  603,  655,  603,  603,  603,

			  603,  603,  603,  603,  603,  603,  603,  603,  603,  603,
			   13,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  655,  655,  655, yy_Dummy>>,
			1, 3, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2002)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER]) is
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
			    1,    1,    1,    3,    4,  571,    3,    4,   27,    3,

			    4,    5,    5,    5,  570,    5,    6,    6,    6,   27,
			    6,    9,    9,    9,   10,   10,   10,   11,   11,   11,
			   12,   12,   12,   15,   15,   15,   16,   16,   16,   21,
			   40,   21,   11,   35,   35,   12,   37,   37,   15,   29,
			   28,   16,   28,   28,   28,   28,   30,   29,   30,   30,
			   30,   30,   48,   47,   50,   51,   42,  569,    5,   47,
			   30,   30,   40,    6,  568,   31,   42,   31,   31,   31,
			   31,   50,   32,  567,   32,   32,   32,   32,  566,   31,
			   69,   54,   30,   69,   48,   47,   50,   51,   42,   30,
			    5,   47,   30,   30,  565,    6,   18,   18,   42,   18,

			   18,  118,  118,   50,   18,   18,   56,   18,   31,   18,
			   52,   31,   29,   54,   30,   32,   18,  564,   18,   39,
			   18,   18,  560,   41,   39,   52,   39,   41,   57,   18,
			   41,   39,   39,   41,   18,   18,   41,   43,   56,   43,
			   55,   88,   52,   73,   18,  130,   73,   18,   18,   43,
			   18,   39,  545,   18,   55,   41,   39,   52,   39,   41,
			   57,   18,   41,   39,   39,   41,   18,   18,   41,   43,
			   44,   43,   55,   88,   44,   46,   18,  130,  509,   18,
			   18,   43,   46,   46,   49,   53,   55,   44,   46,   77,
			   77,   77,  132,  133,   49,   53,   49,  134,   53,  135,

			   49,  508,   44,   80,   80,   80,   44,   46,  489,   70,
			   70,   70,  449,   70,   46,   46,   49,   53,  442,   44,
			   46,   81,   81,   81,  132,  133,   49,   53,   49,  134,
			   53,  135,   49,   68,   68,   68,   85,   68,   89,   85,
			   68,   89,   68,   68,   68,   83,   83,   83,   87,   87,
			   68,   87,   90,   87,  136,   90,   87,   68,   91,   68,
			   83,   91,   68,   68,   68,   68,   70,   68,  382,   68,
			  381,   92,  379,   68,   92,   68,  450,  450,   68,   68,
			   68,   68,   68,   68,   92,  200,  136,   85,  200,   89,
			  333,   93,   94,   95,   93,   94,   95,   96,   70,   97,

			   96,  270,   97,   90,   87,   98,  268,   99,   98,   91,
			   99,  102,   93,   94,  102,  258,  100,  100,  100,   85,
			  100,   89,   92,  100,  257,  137,  103,  103,  103,  256,
			  103,   95,  138,  103,   96,   90,   87,  131,   97,  255,
			  131,   91,   93,   94,   95,  139,   99,   98,   96,  101,
			   97,  515,  101,  254,   92,  140,   98,  137,   99,  119,
			  119,  119,  102,   95,  138,  143,   96,  267,  267,  131,
			   97,  100,  131,  100,   93,   94,   95,  139,   99,   98,
			   96,  103,   97,  111,  111,  111,  111,  140,   98,  204,
			   99,  253,  204,  515,  102,  141,  144,  143,  111,  141,

			  101,  101,  115,  100,  115,  115,  115,  115,  267,  146,
			  147,  144,  148,  103,  252,  121,  121,  121,  121,  115,
			  150,  116,  153,  116,  116,  116,  116,  141,  144,  251,
			  111,  141,  101,  106,  250,  116,  106,  249,  106,  106,
			  106,  146,  147,  144,  148,  117,  106,  117,  117,  117,
			  117,  115,  150,  106,  153,  106,  121,  155,  106,  106,
			  106,  106,  145,  106,  116,  106,  145,  116,  151,  106,
			  151,  106,  151,  154,  106,  106,  106,  106,  106,  106,
			  156,  157,  158,  151,  160,  154,  151,  161,  117,  155,
			  164,  158,  163,  162,  145,  162,  163,  165,  145,  166,

			  151,  167,  151,  162,  151,  154,  162,  169,  162,  162,
			  170,  171,  156,  157,  158,  151,  160,  154,  151,  161,
			  172,  168,  164,  158,  163,  162,  168,  162,  163,  165,
			  248,  166,  247,  167,  246,  162,  245,  168,  162,  169,
			  162,  162,  170,  171,  177,  177,  177,  183,  183,  183,
			  183,  177,  172,  168,  244,  203,  203,  203,  168,  203,
			  208,  208,  208,  210,  210,  210,  215,  215,  215,  168,
			  214,  214,  214,  214,  220,  214,  222,  220,  214,  222,
			  224,  225,  226,  224,  225,  226,  227,  273,  232,  227,
			  228,  232,  228,  243,  229,  228,  233,  229,  241,  233,

			  230,  230,  230,  274,  230,  240,  277,  230,  278,  225,
			  280,  239,  203,  242,  242,  242,  242,  281,  282,  273,
			  283,  215,  226,  238,  284,  220,  214,  222,  285,  286,
			  227,  224,  225,  226,  287,  274,  229,  227,  277,  232,
			  278,  225,  280,  228,  203,  229,  289,  233,  237,  281,
			  282,  211,  283,  215,  226,  230,  284,  220,  214,  222,
			  285,  286,  227,  224,  225,  226,  287,  206,  229,  227,
			  175,  232,  291,  107,  105,  228,   84,  229,  289,  233,
			  260,  260,  260,  260,  261,  292,  261,  230,   82,  261,
			  261,  261,  261,  293,  295,  260,  263,  263,  263,  263,

			  264,   74,  264,   65,  291,  264,  264,  264,  264,  290,
			  265,  263,  265,  265,  265,  265,  266,  292,  266,  266,
			  266,  266,  296,  290,  265,  293,  295,  260,  269,  269,
			  269,  271,  294,  271,  271,  271,  271,  272,  272,  272,
			  272,  290,   63,  263,  297,  294,   59,  298,  299,  300,
			  301,  302,  303,  265,  296,  290,  265,  304,  305,  266,
			  307,  308,  309,  310,  294,  311,  310,  312,  313,  269,
			  314,  316,  317,  315,  271,  318,  297,  294,  272,  298,
			  299,  300,  301,  302,  303,  319,  320,  321,  322,  304,
			  305,  315,  307,  308,  309,  310,  323,  311,  310,  312,

			  313,  324,  314,  316,  317,  315,  325,  318,  326,  327,
			  328,  331,  331,  331,  331,  331,  385,  319,  320,  321,
			  322,  378,  378,  315,  334,  334,  334,  338,  323,  338,
			   38,  339,  338,  324,  339,   33,  340,   13,  325,  340,
			  326,  327,  328,  341,  343,  386,  341,  343,  385,  387,
			    8,  351,  351,  351,  351,  351,  352,  352,  352,  352,
			  352,  388,  378,    7,  351,  351,  389,  339,  369,  369,
			  369,  369,  341,  370,  370,  370,  370,  386,  390,  334,
			  338,  387,  339,  369,  391,  392,  351,  340,  371,  371,
			  371,  371,  393,  388,  341,  343,  351,  351,  389,  339, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  374,  374,  374,  374,  341,  372,  372,  372,  372,  369,
			  390,  334,  338,    0,  339,  369,  391,  392,  351,  340,
			  372,    0,    0,  373,  393,  373,  341,  343,  373,  373,
			  373,  373,  375,  375,  375,  375,  376,  394,  376,  376,
			  376,  376,  377,  395,  377,  377,  377,  377,  396,  397,
			  376,  383,  372,  383,  383,  383,  383,  384,  398,  384,
			  384,  384,  384,  399,  400,  401,  402,  404,    0,  394,
			  405,  406,  407,  408,  409,  395,  410,  412,  415,  376,
			  396,  397,  376,    0,  418,  377,  419,  420,  421,  422,
			  398,  423,  424,  425,  383,  399,  400,  401,  402,  404,

			  384,  426,  405,  406,  407,  408,  409,  427,  410,  412,
			  415,  416,  416,  416,  428,  416,  418,  429,  419,  420,
			  421,  422,  430,  423,  424,  425,  416,  433,  434,  435,
			  436,  437,    0,  426,  441,  441,  441,  441,  441,  427,
			  443,  445,  447,  443,  445,  447,  428,    0,    0,  429,
			  451,  451,  451,    0,  430,  453,  453,  453,  453,  433,
			  434,  435,  436,  437,  454,  454,  454,  454,  462,  463,
			  453,  466,  467,  468,  445,  470,  467,    0,  447,  455,
			  455,  455,  455,  471,  443,  456,  456,  456,  456,  472,
			  473,  443,  445,  447,  455,  457,  457,  457,  457,    0,

			  462,  463,  453,  466,  467,  468,  445,  470,  467,  459,
			  447,  459,  459,  459,  459,  471,  443,  474,  475,  477,
			  455,  472,  473,  443,  445,  447,  455,  458,  478,  458,
			  458,  458,  458,  479,  480,  482,  483,  484,  486,  487,
			  487,  487,  490,  487,  458,  491,  492,  493,  494,  474,
			  475,  477,  459,  495,  487,  496,  497,  498,  500,  501,
			  478,  504,  505,  507,  517,  479,  480,  482,  483,  484,
			  486,  525,  510,  526,  490,  510,  458,  491,  492,  493,
			  494,  511,    0,  512,  511,  495,  512,  496,  497,  498,
			  500,  501,  528,  504,  505,  507,  514,  514,  514,  516,

			  516,  516,  516,  525,  510,  526,  517,  518,  529,  518,
			  511,  530,  518,  518,  518,  518,  519,  519,  519,  519,
			  533,  535,  536,  510,  528,  538,  512,  521,  521,  521,
			  521,  519,  511,    0,  512,    0,  510,  539,  514,    0,
			  529,  516,  511,  530,  520,  520,  520,  520,    0,  540,
			  541,  542,  533,  535,  536,  510,  543,  538,  512,  520,
			    0,  546,  547,  519,  511,  522,  512,  522,  549,  539,
			  522,  522,  522,  522,  550,  523,  552,  523,  523,  523,
			  523,  540,  541,  542,  556,  557,  559,  562,  543,    0,
			  562,  520,  523,  546,  547,    0,  561,  581,  563,  561,

			  549,  563,  572,  572,  572,  572,  550,  583,  552,  573,
			  573,  573,  573,  585,    0,    0,  556,  557,  559,  574,
			  574,  574,  574,  586,  523,  561,  587,  563,  590,  581,
			  562,  593,  594,  596,  574,  575,    0,  575,  562,  583,
			  575,  575,  575,  575,    0,  585,  576,  561,  576,  563,
			    0,  576,  576,  576,  576,  586,  597,  561,  587,  563,
			  590,    0,  562,  593,  594,  596,  574,  595,  595,  595,
			  562,  577,  577,  577,  577,  578,  578,  578,  578,  561,
			  598,  563,  579,  579,  579,  579,  577,  580,  597,  580,
			  600,  601,  580,  580,  580,  580,  604,  605,  595,  604,

			  605,  606,    0,  611,  606,  612,  612,  612,  612,  672,
			  672,  672,  598,  613,  613,  613,  613,  620,  577,  628,
			  628,  628,  600,  601,  614,  614,  614,  614,    0,  611,
			  595,    0,  626,  629,  604,  611,  615,  615,  615,  615,
			  616,  616,  616,  616,  630,  632,  638,  604,  605,  620,
			  628,  617,  606,  617,  643,  616,  617,  617,  617,  617,
			  618,  618,  618,  618,  626,  629,  604,  619,  619,  619,
			  619,  635,  638,  644,  635,  648,  630,  632,  638,  604,
			  605,  649,  628,  650,  606,  651,  643,  616,  639,  639,
			  639,  639,  640,  640,  640,  640,  652,  673,  673,  673,

			  675,  675,  675,    0,    0,  644,    0,  648,  676,  676,
			  676,    0,    0,  649,    0,  650,    0,  651,    0,    0,
			    0,    0,  635,    0,    0,  662,    0,  662,  652,  662,
			  662,  662,  662,  662,  662,  662,  662,  662,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,    0,    0,    0,
			    0,    0,    0,    0,  635,  656,  656,  656,  656,  656,
			  656,  656,  656,  656,  656,  656,  656,  656,  656,  656,
			  657,  657,  657,  657,  657,  657,  657,  657,  657,  657,
			  657,  657,  657,  657,  657,  658,  658,  658,  658,  658,
			  658,  658,  658,  658,  658,  658,  658,  658,  658,  658,

			  659,  659,  659,  659,  659,  659,  659,  659,  659,  659,
			  659,  659,  659,  659,  659,  660,  660,  660,  660,  660,
			  660,  660,  660,  660,  660,  660,  660,  660,  660,  660,
			  661,    0,  661,  661,  661,  661,  661,  661,  661,  661,
			  661,  661,  661,  661,  661,  663,    0,  663,  663,  663,
			  663,  663,  663,  663,  663,  663,  663,  663,  663,  663,
			  665,    0,  665,  665,  665,    0,  665,  665,  665,  665,
			  665,  665,  665,  665,  665,  666,  666,  666,  666,  666,
			  666,  666,  666,  666,  666,  666,  666,  666,  666,  666,
			  667,  667,  667,  667,  667,  667,  667,  667,  667,  667,

			  667,  667,  667,  667,  667,  668,  668,  668,  668,  668,
			  668,  668,  668,  668,  668,  668,  668,  668,  668,  668,
			  669,    0,  669,  669,  669,  669,  669,  669,  669,  669,
			  669,  669,  669,  669,  669,  670,    0,  670,    0,  670,
			  670,  670,  670,  670,  670,  670,  670,  670,  670,  670,
			  671,    0,  671,  671,  671,  671,  671,  671,  671,  671,
			  671,  671,  671,  671,  671,  674,    0,  674,  674,  674,
			  674,  674,  674,  674,  674,  674,  674,  674,  674,  674,
			  677,  677,  677,  677,  677,  677,  677,  677,  677,  677,
			  677,  677,  677,  677,  677,  678,    0,  678,  678,  678,

			  678,  678,  678,  678,  678,  678,  678,  678,  678,  678,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  655,  655,  655, yy_Dummy>>,
			1, 3, 2000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   90,   91,   99,  104,  960,  947,  109,
			  112,  115,  118,  937, 1910,  121,  124, 1910,  190,    0,
			 1910,  120, 1910, 1910, 1910, 1910, 1910,   81,  122,  120,
			  128,  147,  154,  908, 1910,  107, 1910,  109,  903,  182,
			   91,  185,  121,  195,  239,    0,  239,  114,  107,  252,
			  123,  120,  175,  247,  137,  209,  168,  183, 1910,  788,
			 1910, 1910, 1910,  750, 1910,  797, 1910, 1910,  331,  177,
			  307, 1910, 1910,  240,  798, 1910, 1910,  287, 1910, 1910,
			  301,  319,  771,  343,  759,  330, 1910,  347,  184,  332,
			  346,  352,  365,  385,  386,  387,  391,  393,  399,  401,

			  414,  443,  405,  424,    0,  763,  527,  762, 1910, 1910,
			 1910,  463, 1910, 1910, 1910,  484,  503,  527,  181,  439,
			    0,  495, 1910, 1910, 1910, 1910, 1910, 1910, 1910,    0,
			  210,  398,  258,  244,  247,  249,  319,  394,  388,  410,
			  407,  463,    0,  416,  462,  516,  467,  479,  467,    0,
			  474,  534,    0,  481,  540,  507,  531,  547,  549,    0,
			  536,  552,  559,  550,  542,  562,  548,  555,  587,  559,
			  571,  576,  572, 1910, 1910,  764, 1910,  642, 1910, 1910,
			 1910, 1910, 1910,  627, 1910, 1910, 1910, 1910, 1910, 1910,
			 1910, 1910, 1910, 1910, 1910, 1910, 1910, 1910, 1910, 1910,

			  382, 1910, 1910,  653,  486, 1910,  764, 1910,  658, 1910,
			  661,  744, 1910, 1910,  669,  664, 1910, 1910, 1910, 1910,
			  668, 1910,  670, 1910,  674,  675,  676,  680,  686,  688,
			  698, 1910,  682,  690, 1910, 1910, 1910,  737,  712,  700,
			  694,  687,  693,  682,  643,  625,  623,  621,  619,  526,
			  523,  518,  503,  480,  442,  428,  418,  413,  404, 1910,
			  760,  769, 1910,  776,  785,  792,  798,  447,  345,  808,
			  340,  813,  817,  643,  672,    0,    0,  667,  660,    0,
			  677,  668,  666,  689,  676,  677,  694,  699,    0,  695,
			  778,  737,  736,  743,  789,  752,  787,  805,  812,  802,

			  818,  815,  820,  806,  822,  813,    0,  825,  806,  812,
			  830,  830,  832,  837,  819,  840,  823,  837,  844,  846,
			  842,  852,  846,  861,  854,  867,  869,  875,  866,    0,
			 1910,  892,    0,  316,  922, 1910, 1910, 1910,  923,  925,
			  930,  937, 1910,  938, 1910, 1910, 1910, 1910, 1910, 1910,
			 1910,  932,  937, 1910, 1910, 1910, 1910, 1910, 1910, 1910,
			 1910, 1910, 1910, 1910, 1910, 1910, 1910, 1910, 1910,  948,
			  953,  968,  985, 1008,  980, 1012, 1018, 1024,  901,  311,
			    0,  309,  350, 1033, 1039,  866,  896,  912,  922,  925,
			  929,  949,  935,  957, 1000,  995, 1009, 1001, 1014, 1015,

			 1016, 1030, 1015,    0, 1032, 1031, 1017, 1018, 1025, 1039,
			 1028,    0, 1035,    0,    0, 1036, 1109,    0, 1045, 1035,
			 1048, 1052, 1041, 1048, 1053, 1042, 1059, 1052, 1081, 1069,
			 1076,    0,    0, 1092, 1092, 1078, 1088, 1100,    0,    0,
			 1910, 1115,  247, 1134, 1910, 1135, 1910, 1136, 1910,  301,
			  356, 1130,    0, 1135, 1144, 1159, 1165, 1175, 1209, 1191,
			    0,    0, 1124, 1137,    0,    0, 1123, 1137, 1129,    0,
			 1127, 1147, 1154, 1156, 1167, 1174,    0, 1171, 1184, 1198,
			 1195,    0, 1196, 1203, 1198,    0, 1203, 1237, 1910,  291,
			 1211, 1197, 1192, 1208, 1213, 1218, 1207, 1221, 1207,    0,

			 1208, 1228,    0,    0, 1222, 1227,    0, 1219,  282,  202,
			 1266, 1275, 1277, 1910, 1277,  432, 1280, 1245, 1292, 1296,
			 1324, 1307, 1350, 1357,    0, 1220, 1223,    0, 1247, 1258,
			 1276,    0,    0, 1285,    0, 1290, 1287,    0, 1276, 1293,
			 1299, 1300, 1320, 1306, 1910,  249, 1319, 1313,    0, 1324,
			 1330,    0, 1341,    0,    0,    0, 1334, 1341,    0, 1336,
			  155, 1390, 1381, 1392,  206,  175,  167,  112,  153,  138,
			   93,   34, 1382, 1389, 1399, 1420, 1431, 1451, 1455, 1462,
			 1472, 1347,    0, 1363,    0, 1379, 1389, 1384,    0,    0,
			 1391,    0,    0, 1387, 1397, 1465, 1388, 1421, 1447,    0,

			 1455, 1456,    0,    0, 1490, 1491, 1495, 1910, 1910, 1910,
			 1910, 1468, 1485, 1493, 1504, 1516, 1520, 1536, 1540, 1547,
			 1482,    0,    0,    0,    0,    0, 1482,    0, 1517, 1491,
			 1496,    0, 1510,    0,    0, 1565, 1910, 1910, 1511, 1568,
			 1572,    0,    0, 1512, 1542,    0,    0, 1910, 1544, 1532,
			 1534, 1536, 1547,    0, 1910, 1910, 1654, 1669, 1684, 1699,
			 1714, 1729, 1622, 1744, 1631, 1759, 1774, 1789, 1804, 1819,
			 1834, 1849, 1502, 1590, 1864, 1593, 1601, 1879, 1894, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  655,    1,  656,  656,  657,  657,  658,  658,  659,
			  659,  660,  660,  655,  655,  655,  655,  655,  661,  662,
			  655,  663,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  655,  655,
			  655,  655,  655,  655,  655,  665,  655,  655,  655,  666,
			  666,  655,  655,  667,  668,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  661,  655,  669,  670,  661,
			  661,  661,  661,  661,  661,  661,  661,  661,  661,  661,

			  661,  661,  661,  661,  662,  671,  671,  671,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  672,  672,
			  673,  655,  655,  655,  655,  655,  655,  655,  655,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  655,  655,  665,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,

			  666,  655,  655,  666,  667,  655,  668,  655,  655,  655,
			  655,  674,  655,  655,  669,  670,  655,  655,  655,  655,
			  661,  655,  661,  655,  661,  661,  661,  661,  661,  661,
			  661,  655,  661,  661,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  672,  672,  672,
			  673,  655,  655,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,

			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  655,  655,  674,  674,  670,  655,  655,  655,  661,  661,
			  661,  661,  655,  661,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  672,  672,
			  269,  673,  655,  655,  655,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,

			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  655,  655,  674,  661,  655,  661,  655,  661,  655,  655,
			  675,  675,  676,  655,  655,  655,  655,  655,  655,  655,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  655,  655,  655,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,

			  664,  664,  664,  664,  664,  664,  664,  664,  655,  674,
			  661,  661,  661,  655,  675,  675,  675,  676,  655,  655,
			  655,  655,  655,  655,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  655,  677,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  674,  661,  661,  661,  655,  514,  655,  675,  655,  516,
			  655,  676,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  664,  664,  664,  664,  664,  664,  664,  664,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,

			  664,  664,  664,  678,  661,  661,  661,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  664,  664,  664,  664,  664,  664,  664,  664,  655,  664,
			  664,  664,  664,  664,  664,  661,  655,  655,  655,  655,
			  655,  664,  664,  655,  664,  664,  664,  655,  655,  664,
			  655,  664,  655,  664,  655,    0,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655,  655,
			  655,  655,  655,  655,  655,  655,  655,  655,  655, yy_Dummy>>)
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
			  220,  221,  222,  223,  224,  225,  226,  227,  228,  229,
			  229,  229,  229,  230,  231,  232,  233,  234,  235,  236,
			  237,  238,  239,  240,  242,  243,  244,  245,  246,  247,
			  248,  249,  250,  252,  253,  254,  255,  256,  257,  258,
			  260,  261,  262,  264,  265,  266,  267,  268,  269,  270,
			  272,  273,  274,  275,  276,  277,  278,  279,  280,  281,
			  282,  283,  284,  285,  286,  287,  288,  289,  289,  290,
			  291,  292,  293,  294,  294,  295,  296,  297,  298,  299,
			  300,  301,  302,  303,  304,  305,  306,  307,  308,  309,

			  310,  311,  312,  313,  314,  315,  317,  318,  319,  319,
			  320,  321,  322,  323,  325,  327,  328,  330,  332,  334,
			  336,  337,  339,  340,  342,  343,  344,  345,  346,  347,
			  348,  349,  350,  351,  352,  354,  355,  357,  358,  359,
			  360,  361,  362,  363,  364,  365,  366,  367,  368,  369,
			  370,  371,  372,  373,  374,  375,  376,  377,  378,  379,
			  381,  382,  382,  383,  384,  384,  385,  386,  388,  389,
			  391,  392,  393,  393,  394,  395,  397,  399,  400,  401,
			  403,  404,  405,  406,  407,  408,  409,  410,  411,  413,
			  414,  415,  416,  417,  418,  419,  420,  421,  422,  423,

			  424,  425,  426,  427,  428,  430,  431,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,
			  446,  447,  448,  449,  450,  451,  452,  453,  454,  455,
			  457,  458,  458,  459,  460,  460,  462,  464,  466,  467,
			  468,  469,  470,  472,  473,  475,  477,  478,  479,  480,
			  481,  482,  483,  484,  485,  486,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  499,  500,
			  501,  501,  502,  503,  503,  503,  504,  505,  506,  506,
			  506,  506,  506,  506,  507,  508,  509,  510,  511,  512,
			  513,  514,  515,  516,  517,  518,  519,  521,  522,  523,

			  524,  525,  526,  527,  529,  530,  531,  532,  533,  534,
			  535,  536,  538,  539,  541,  543,  544,  546,  548,  549,
			  550,  551,  552,  553,  554,  555,  556,  557,  558,  559,
			  560,  561,  563,  565,  566,  567,  568,  569,  570,  572,
			  574,  575,  575,  576,  577,  579,  580,  582,  583,  585,
			  586,  586,  586,  586,  587,  587,  588,  588,  589,  590,
			  591,  593,  595,  596,  597,  599,  601,  602,  603,  604,
			  606,  607,  608,  609,  610,  611,  612,  614,  615,  616,
			  617,  618,  620,  621,  622,  623,  625,  626,  626,  627,
			  627,  628,  629,  630,  631,  632,  633,  634,  635,  636,

			  638,  639,  640,  642,  644,  645,  646,  648,  649,  649,
			  650,  651,  652,  653,  654,  654,  654,  654,  654,  654,
			  655,  656,  656,  656,  657,  659,  660,  661,  663,  664,
			  665,  666,  668,  670,  671,  673,  674,  675,  677,  678,
			  679,  680,  681,  682,  683,  684,  684,  685,  686,  688,
			  689,  690,  692,  693,  695,  697,  699,  700,  701,  703,
			  704,  705,  706,  707,  708,  708,  708,  708,  708,  708,
			  708,  708,  708,  708,  709,  710,  710,  710,  711,  711,
			  712,  712,  713,  715,  716,  718,  719,  720,  721,  723,
			  725,  726,  728,  730,  731,  732,  733,  734,  735,  736,

			  738,  739,  740,  742,  744,  745,  746,  747,  749,  750,
			  752,  753,  754,  754,  755,  755,  756,  757,  757,  757,
			  758,  759,  761,  763,  765,  767,  769,  770,  772,  772,
			  773,  774,  776,  777,  779,  781,  782,  784,  786,  787,
			  787,  788,  790,  792,  792,  793,  795,  797,  799,  799,
			  800,  800,  801,  801,  803,  804,  804, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  181,  181,  183,  183,  214,  212,  213,    1,  212,
			  213,    1,  213,   37,  212,  213,  184,  212,  213,   42,
			  212,  213,   15,  212,  213,  151,  212,  213,   25,  212,
			  213,   26,  212,  213,   33,  212,  213,   31,  212,  213,
			    9,  212,  213,   32,  212,  213,   14,  212,  213,   34,
			  212,  213,  116,  212,  213,  116,  212,  213,  116,  212,
			  213,    8,  212,  213,    7,  212,  213,   19,  212,  213,
			   18,  212,  213,   20,  212,  213,   11,  212,  213,  114,
			  212,  213,  114,  212,  213,  114,  212,  213,  114,  212,
			  213,  114,  212,  213,  114,  212,  213,  114,  212,  213,

			  114,  212,  213,  114,  212,  213,  114,  212,  213,  114,
			  212,  213,  114,  212,  213,  114,  212,  213,  114,  212,
			  213,  114,  212,  213,  114,  212,  213,  114,  212,  213,
			  114,  212,  213,  114,  212,  213,   29,  212,  213,  212,
			  213,   30,  212,  213,   35,  212,  213,   27,  212,  213,
			   28,  212,  213,   12,  212,  213,  185,  213,  211,  213,
			  209,  213,  210,  213,  181,  213,  181,  213,  180,  213,
			  179,  213,  181,  213,  183,  213,  182,  213,  177,  213,
			  177,  213,  176,  213,    6,  213,    5,    6,  213,    5,
			  213,    6,  213,    1,  184,  173,  184,  184,  184,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184, -388,
			  184,  184,  184, -388,   42,  151,  151,  151,    2,   36,
			   10,  122,   40,   24,   23,  122,  116,  116,  115,  115,
			   16,   38,   21,   22,   39,   17,  114,  114,  114,  114,
			   47,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			   59,  114,  114,  114,  114,  114,  114,  114,   71,  114,
			  114,  114,   78,  114,  114,  114,  114,  114,  114,  114,
			   90,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,   41,   13,  185,  209,  202,
			  200,  201,  203,  204,  205,  206,  186,  187,  188,  189,

			  190,  191,  192,  193,  194,  195,  196,  197,  198,  199,
			  181,  180,  179,  181,  181,  178,  179,  183,  182,  176,
			    5,    4,  174,  172,  174,  184, -388, -388,  159,  174,
			  157,  174,  158,  174,  160,  174,  184,  153,  174,  184,
			  154,  174,  184,  184,  184,  184,  184,  184,  184, -175,
			  184,  184,  161,  174,  151,  123,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  124,
			  151,  122,  117,  122,  116,  116,  120,  121,  121,  119,
			  121,  118,  116,  114,  114,   45,  114,   46,  114,  114,

			  114,   50,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,   62,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,   82,  114,
			  114,   85,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  113,  114,  208,    4,    4,
			  162,  174,  155,  174,  156,  174,  184,  184,  184,  184,
			  169,  174,  184,  164,  174,  163,  174,  141,  139,  140,
			  142,  143,  152,  152,  144,  145,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,

			  122,  122,  122,  122,  116,  116,  116,  116,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,   60,
			  114,  114,  114,  114,  114,  114,  114,   69,  114,  114,
			  114,  114,  114,  114,  114,  114,   79,  114,  114,   81,
			  114,   83,  114,  114,   88,  114,   89,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  104,  114,  105,  114,  114,  114,  114,  114,  114,
			  111,  114,  112,  114,  207,    4,  184,  165,  174,  184,
			  168,  174,  184,  171,  174,  152,  122,  122,  122,  122,
			  116,   43,  114,   44,  114,  114,  114,   51,  114,   52,

			  114,  114,  114,  114,   57,  114,  114,  114,  114,  114,
			  114,  114,   67,  114,  114,  114,  114,  114,   74,  114,
			  114,  114,  114,   80,  114,  114,   86,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  100,  114,  114,  114,
			  103,  114,  106,  114,  114,  114,  109,  114,  114,    4,
			  184,  184,  184,  146,  122,  122,  122,   48,  114,  114,
			  114,   54,  114,  114,  114,  114,   61,  114,   63,  114,
			  114,   65,  114,  114,  114,   70,  114,  114,  114,  114,
			  114,  114,  114,   87,  114,  114,   93,  114,  114,  114,
			   96,  114,  114,   98,  114,   99,  114,  101,  114,  114,

			  114,  108,  114,  114,    4,  184,  184,  184,  122,  122,
			  122,  122,  114,   53,  114,  114,   56,  114,  114,  114,
			  114,   68,  114,   72,  114,  114,   75,  114,   76,  114,
			  114,  114,  114,  114,  114,  114,   97,  114,  114,  114,
			  110,  114,    3,    4,  184,  184,  184,  149,  150,  150,
			  148,  150,  147,  122,  122,  122,  122,  122,  114,   55,
			  114,   58,  114,   64,  114,   66,  114,   73,  114,  114,
			   84,  114,  114,  114,   94,  114,  114,  102,  114,  107,
			  114,  184,  167,  174,  170,  174,  122,  122,   49,  114,
			   77,  114,  114,   92,  114,   95,  114,  166,  174,  114,

			  114,   91,  114,   91, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1910
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 655
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 656
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

	yyNb_rules: INTEGER is 213
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 214
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
