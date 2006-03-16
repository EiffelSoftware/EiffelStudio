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
			Result := (INITIAL <= sc and sc <= VERBATIM_STR3)
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
 last_line_pragma := ast_factory.new_line_pragma (Current) 
when 2 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 39 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 39")
end
 ast_factory.create_break_as (Current) 
when 3 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 43 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 43")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
when 4 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 47 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 47")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
when 5 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 51 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 51")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
when 6 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 55 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 55")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
when 7 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 59 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 59")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 63 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 63")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 9 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 67 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 67")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CURLYTILDE, Current)
				last_token := TE_CURLYTILDE
			
when 10 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 71 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 71")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 75 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 75")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 12 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 79 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 79")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 13 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 83 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 83")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 87 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 87")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 91 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 91")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 16 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 95 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 95")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 17 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 99 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 99")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 18 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 103 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 103")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 19 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 107 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 107")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 20 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 111 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 111")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 21 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 115 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 115")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 22 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 119 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 119")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 23 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 123 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 123")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 127 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 127")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 131 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 131")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 135 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 135")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 139 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 139")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 143 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 143")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 147 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 147")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 151 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 151")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 31 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 155 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 155")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 32 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 159 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 159")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 33 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 163 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 163")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 34 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 167 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 167")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 171 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 171")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 36 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 175 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 175")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 37 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 183 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 183")
end

				last_token := TE_FREE
				process_id_as
			
when 38 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 191 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 191")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 39 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 195 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 195")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 40 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 199 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 199")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 41 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 203 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 203")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 42 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 207 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 207")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 43 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 211 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 211")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_keyword_as_id_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
when 44 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 218 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 218")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 227 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 227")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
			
when 46 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 231 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 231")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 47 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 235 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 235")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 48 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 239 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 239")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 49 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 243 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 243")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 50 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 247 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 247")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
when 51 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 251 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 251")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			
when 52 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 255 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 255")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 53 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 259 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 259")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED			
			
when 54 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 263 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 263")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 55 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 267 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 267")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 56 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 271 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 271")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 57 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 275 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 275")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			
when 58 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 279 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 279")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 59 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 283 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 283")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 60 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 287 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 287")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 61 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 291 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 291")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 62 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 295 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 295")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			
when 63 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 299 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 299")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 64 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 303 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 303")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 65 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 307 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 307")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			
when 66 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 311 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 311")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 67 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 315 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 315")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 68 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 319 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 319")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
when 69 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 323 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 323")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 327 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 327")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 331 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 331")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 72 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 335 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 335")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 73 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 339 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 339")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
when 74 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 343 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 343")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 75 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 347 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 347")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 76 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 351 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 351")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 77 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 355 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 355")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 78 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 359 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 359")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 79 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 368 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 368")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 80 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 372 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 372")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 81 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 388 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 388")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 82 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 392 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 392")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
when 83 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 399 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 399")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 84 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 403 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 403")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 85 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 412 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 412")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 86 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 416 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 416")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			
when 87 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 420 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 420")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 88 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 424 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 424")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			
when 89 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 428 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 428")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 90 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 432 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 432")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 91 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 436 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 436")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 92 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 440 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 440")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 93 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 94 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 448 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 448")
end
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 95 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 452 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 452")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			
when 96 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 456 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 456")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 97 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 460 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 460")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 98 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 464 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 464")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 99 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 468 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 468")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 100 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 472 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 472")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 101 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 476 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 476")
end

				last_token := TE_TUPLE
				process_id_as
			
when 102 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 480 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 480")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 103 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 484 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 484")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 104 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 488 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 488")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 105 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 492 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 492")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 106 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 496 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 496")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 107 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 500 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 500")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 108 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 504 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 504")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 512 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 512")
end

				last_token := TE_ID
				process_id_as
			
when 110 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 519 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 519")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)
			
when 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 527 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 527")
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
			
when 112 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 528 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 528")
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
			
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 540 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 540")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 548 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 548")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end				
				last_token := TE_REAL
			
when 115 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 560 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 560")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 566 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 566")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 117 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 573 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 573")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 579 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 579")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 585 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 585")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 591 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 591")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 597 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 597")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 603 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 603")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 609 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 609")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 615 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 615")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 621 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 621")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 627 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 627")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 633 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 633")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 639 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 639")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 645 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 645")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 651 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 651")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 657 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 657")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 663 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 663")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 669 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 669")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 675 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 675")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 681 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 681")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 687 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 687")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 693 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 693")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 138 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 699 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 699")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 139 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 702 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 702")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 703 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 703")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 141 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 712 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 712")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 142 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 716 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 716")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 720 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 720")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 724 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 724")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 728 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 728")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 732 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 732")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 147 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 736 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 736")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 148 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 740 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 740")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 149 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 744 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 744")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 150 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 748 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 748")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 151 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 752 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 752")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 152 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 756 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 756")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 153 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 760 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 760")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 154 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 766 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 766")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 155 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 772 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 772")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 156 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 778 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 778")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 157 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 784 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 784")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 158 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 790 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 790")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 159 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 796 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 796")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 802 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 802")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 161 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 811 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 811")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 162 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 817 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 817")
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
			
when 163 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 828 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 828")
end

					-- Verbatim string.
				string_position := position
				l_verbatim_start_position := position
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
			
when 164 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 846 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 846")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 165 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 850 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 850")
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
			
when 166 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 870 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 870")
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
									"Default verbatim string handling is changed to follow standard semantics %
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
			
when 167 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 913 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 913")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 168 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 918 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 918")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 169 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 926 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 926")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 942 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 942")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 951 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 951")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 964 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 964")
end

					-- String with special characters.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				l_string_start_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 976 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 976")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 980 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 980")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%A")
				token_buffer.append_character ('%A')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 984 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 984")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%B")
				token_buffer.append_character ('%B')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 988 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 988")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%C")
				token_buffer.append_character ('%C')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 992 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 992")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%D")
				token_buffer.append_character ('%D')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 996 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 996")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%F")
				token_buffer.append_character ('%F')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1000 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1000")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%H")
				token_buffer.append_character ('%H')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1004 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1004")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%L")
				token_buffer.append_character ('%L')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1008 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1008")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%N")
				token_buffer.append_character ('%N')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1012 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1012")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%Q")
				token_buffer.append_character ('%Q')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1016 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1016")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%R")
				token_buffer.append_character ('%R')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1020 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1020")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%S")
				token_buffer.append_character ('%S')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1024 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1024")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%T")
				token_buffer.append_character ('%T')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1028 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1028")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%U")
				token_buffer.append_character ('%U')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1032 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1032")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%V")
				token_buffer.append_character ('%V')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1036 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1036")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%%")
				token_buffer.append_character ('%%')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1040 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1040")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%'")
				token_buffer.append_character ('%'')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1044 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1044")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%"")
				token_buffer.append_character ('%"')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1048 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1048")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%(")
				token_buffer.append_character ('%(')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1052 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1052")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%)")
				token_buffer.append_character ('%)')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1056 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1056")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%<")
				token_buffer.append_character ('%<')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1060 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1060")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%>")
				token_buffer.append_character ('%>')
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1064 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1064")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 196 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1068 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1068")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 197 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1073 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1073")
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
			
when 198 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1089 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1089")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 199 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1095 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1095")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 200 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1113 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1113")
end

				report_unknown_token_error (text_item (1))
			
when 201 then
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
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   12,   13,   14,   13,   15,   16,   17,   18,   12,
			   17,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   17,
			   37,   38,   39,   40,   41,   42,   43,   43,   44,   43,
			   43,   45,   43,   46,   47,   48,   43,   49,   50,   51,
			   52,   53,   54,   55,   43,   43,   56,   57,   58,   59,
			   12,   12,   37,   38,   39,   40,   41,   42,   43,   43,
			   44,   43,   43,   45,   43,   46,   47,   48,   43,   49,
			   50,   51,   52,   53,   54,   55,   43,   43,   60,   17,
			   61,   62,   64,   64,  126,   65,   65,  470,   66,   66,

			   68,   69,   68,  426,   70,   68,   69,   68,  146,   70,
			   75,   76,   75,   75,   76,   75,   77,   77,   77,   77,
			   77,   77,  100,  102,  101,  104,  126,  105,  105,  105,
			  106,   78,  524,  103,   78,  115,  116,  107,  153,  108,
			  146,  109,  109,  110,  108,  132,  109,  109,  110,  117,
			  118,  151,  111,  144,  495,  133,   71,  111,  159,  145,
			  162,   71,  108,  255,  110,  110,  110,  134,  152,  135,
			  153,  367,  192,  192,  112,  193,  196,  132,  249,  136,
			  163,  113,  204,  151,  111,  144,  113,  133,   71,  111,
			  159,  145,  162,   71,   80,   81,  367,   82,   81,  134,

			  152,  135,   83,   84,  113,   85,  112,   86,  160,  355,
			  154,  136,  163,   87,  204,   88,  121,   81,   89,  354,
			  127,  122,  161,  123,  128,  155,   90,  129,  124,  125,
			  130,   91,   92,  131,  137,  199,  200,  199,  138,  263,
			  160,   93,  154,  192,   94,   95,  193,   96,  121,  353,
			   89,  139,  127,  122,  161,  123,  128,  155,   90,  129,
			  124,  125,  130,   91,   92,  131,  137,  140,  250,  147,
			  138,  263,  251,   93,  141,  142,   97,   81,  156,  148,
			  143,  149,  252,  139,  192,  150,  352,  196,  157,  266,
			  267,  158,  194,  192,  194,  201,  193,  264,   82,  140,

			  265,  147,  351,   77,   77,   77,  141,  142,  350,  349,
			  156,  148,  143,  149,  348,  347,  205,  150,   78,   82,
			  157,  266,  267,  158,  168,  168,  168,  346,  169,  264,
			  268,  170,  265,  171,  172,  173,  250,  206,  345,  207,
			   82,  174,   82,  208,  269,   97,   82,  175,  195,  176,
			  252,  344,  177,  178,  179,  180,  209,  181,  201,  182,
			  270,   82,  268,  183,  210,  184,   97,   82,  185,  186,
			  187,  188,  189,  190,  343,  342,  269,   97,   79,   79,
			  195,   79,  212,  202,  211,   82,   82,   97,  201,   97,
			  271,   82,  270,   97,  272,  214,  273,  201,   97,  274,

			   82,  201,  213,  201,   82,  277,   82,  201,   97,  223,
			   82,  282,   82,  283,   97,  253,  253,  253,  341,   97,
			  340,   97,  271,  338,  215,   97,  272,  214,  273,  254,
			  275,  274,   97,  203,  276,  216,  284,  277,   97,  285,
			   97,  218,  217,  282,  337,  283,   97,   97,  219,  220,
			  219,   97,  201,   97,  336,   82,  215,   97,  222,   97,
			  291,  254,  275,  294,   97,  203,  276,  216,  284,  278,
			   97,  285,  335,  218,  217,  261,  261,  261,  255,   97,
			  256,  256,  256,   97,  279,   97,  219,  220,  219,   97,
			  201,   97,  291,   82,  257,  294,  108,  295,  258,  258,

			  259,  278,   97,  108,  221,  259,  259,  259,  334,  111,
			  280,  292,  296,  198,  281,  262,  279,  286,  297,  287,
			  299,  288,  300,  293,  307,  309,  257,  298,  308,  295,
			  310,  311,  289,  312,   97,  290,  316,  317,  113,  318,
			   97,  111,  280,  292,  296,  113,  281,  250,  167,  286,
			  297,  287,  299,  288,  300,  293,  307,  309,  319,  298,
			  308,  252,  310,  311,  289,  312,  248,  290,  316,  317,
			  250,  318,   97,  226,  225,  102,  227,  198,  228,  229,
			  230,  168,  168,  168,  252,  167,  231,  577,  320,  371,
			  319,  313,  232,  165,  233,  372,  314,  234,  235,  236,

			  237,  578,  238,  323,  239,  164,   82,  315,  240,  301,
			  241,  302,  250,  242,  243,  244,  245,  246,  247,  303,
			  119,  371,  304,  313,  305,  306,  252,  372,  314,  321,
			  321,  321,  194,  192,  194,  114,  193,  324,  623,  315,
			   82,  301,  496,  302,  199,  200,  199,   79,  219,  220,
			  219,  303,  202,   97,  304,   82,  305,  306,  322,  220,
			  322,  325,   73,  201,   82,  201,   82,  201,   82,  329,
			   82,  330,   73,  201,   82,  623,   82,  219,  220,  219,
			  332,  201,  357,   82,   82,   97,  373,   97,  195,  333,
			  326,  623,   82,  339,  339,  339,  108,  374,  365,  365,

			  366,  359,  203,  359,  327,  375,  360,  360,  360,  111,
			  328,   97,  204,   97,  331,   97,  376,   97,  373,   97,
			  195,   97,  326,   97,  623,  250,  250,  250,  623,  374,
			   97,   97,  623,  377,  203,  623,  327,  375,  113,   97,
			  356,  111,  328,   97,  204,   97,  331,   97,  376,   97,
			  358,  358,  358,   97,  378,   97,  361,  361,  361,  370,
			  370,  370,   97,   97,  254,  377,  379,  363,  380,  363,
			  362,   97,  364,  364,  364,  108,  381,  366,  366,  366,
			  368,  382,  369,  369,  369,  623,  378,  383,  386,  384,
			  623,  387,  388,  389,  391,  392,  254,  393,  379,  262,

			  380,  394,  362,  385,  395,  396,  390,  397,  381,  398,
			  399,  400,  401,  382,  402,  403,  404,  113,  407,  383,
			  386,  384,  262,  387,  388,  389,  391,  392,  405,  393,
			  408,  406,  409,  394,  410,  385,  395,  396,  390,  397,
			  411,  398,  399,  400,  401,  413,  402,  403,  404,  414,
			  407,  415,  416,  417,  418,  419,  420,  421,  412,  422,
			  405,  423,  408,  406,  409,  424,  410,  425,  426,  427,
			  427,  427,  411,  322,  220,  322,  201,  413,  443,   82,
			  250,  414,  623,  415,  416,  417,  418,  419,  420,  421,
			  412,  422,  431,  423,  252,   82,  428,  424,  429,  425,

			  201,   82,  433,   82,  623,   82,  434,  339,  339,  339,
			  443,  430,  360,  360,  360,  436,  436,  436,  360,  360,
			  360,  438,  438,  438,  444,  445,   97,  204,  432,  254,
			  623,  439,  623,  439,  623,  362,  440,  440,  440,  364,
			  364,  364,   97,  430,  364,  364,  364,  435,   97,  446,
			   97,  623,   97,  623,  623,  437,  444,  445,   97,  204,
			  432,  254,  441,  447,  365,  365,  366,  362,  441,  448,
			  366,  366,  366,  449,   97,  111,  450,  451,  623,  452,
			   97,  446,   97,  368,   97,  442,  442,  442,  368,  453,
			  370,  370,  370,  623,  454,  447,  455,  456,  623,  457,

			  458,  448,  459,  460,  262,  449,  461,  111,  450,  451,
			  262,  452,  462,  463,  464,  465,  466,  467,  468,  469,
			  473,  453,  623,  474,  475,  262,  454,  476,  455,  456,
			  262,  457,  458,  477,  459,  460,  478,  479,  461,  470,
			  470,  470,  480,  471,  462,  463,  464,  465,  466,  467,
			  468,  469,  473,  481,  472,  474,  475,  482,  483,  476,
			  484,  485,  486,  487,  488,  477,  489,  490,  478,  479,
			  426,  491,  491,  491,  480,  201,  201,  201,   82,   82,
			   82,  498,  498,  498,  503,  481,  436,  436,  436,  482,
			  483,  504,  484,  485,  486,  487,  488,  505,  489,  490,

			  497,  499,  499,  499,  440,  440,  440,  508,  493,  440,
			  440,  440,  494,  509,  510,  362,  503,  255,  492,  499,
			  499,  499,  511,  504,  506,   97,   97,   97,  507,  505,
			  512,  513,  497,  501,  502,  514,  370,  370,  370,  508,
			  493,  500,  515,  516,  494,  509,  510,  362,  517,  518,
			  492,  519,  520,  521,  511,  522,  506,   97,   97,   97,
			  507,  525,  512,  513,  526,  501,  527,  514,  528,  529,
			  530,  623,  531,  532,  515,  516,  113,  533,  534,  535,
			  517,  518,  536,  519,  520,  521,  537,  522,  470,  470,
			  470,  538,  523,  525,  201,  623,  526,   82,  527,  623,

			  528,  529,  530,  472,  531,  532,  250,  577,  623,  533,
			  534,  535,  201,  201,  536,   82,   82,  623,  537,  552,
			  252,  578,  543,  538,  543,  539,  553,  544,  544,  544,
			  623,  545,  545,  545,  499,  499,  499,  548,  548,  548,
			  540,  554,  555,  556,   97,  546,  557,  549,  547,  549,
			  558,  552,  550,  550,  550,  541,  559,  539,  553,  560,
			  561,  562,   97,   97,  563,  623,  564,  565,  566,  542,
			  567,  568,  540,  554,  555,  556,   97,  546,  557,  569,
			  547,  255,  558,  548,  548,  548,  570,  541,  559,  571,
			  572,  560,  561,  562,   97,   97,  563,  551,  564,  565,

			  566,  573,  567,  568,  201,  201,  201,   82,   82,   82,
			  623,  569,  544,  544,  544,  544,  544,  544,  570,  623,
			  588,  571,  572,  579,  579,  579,  584,  584,  584,  551,
			  623,  589,  574,  573,  576,  590,  580,  546,  580,  591,
			  585,  581,  581,  581,  582,  592,  582,  575,  593,  583,
			  583,  583,  588,  594,   97,   97,   97,  550,  550,  550,
			  550,  550,  550,  589,  574,  595,  576,  590,  586,  546,
			  586,  591,  585,  587,  587,  587,  598,  592,  599,  575,
			  593,  596,  596,  596,  600,  594,   97,   97,   97,  601,
			  602,  201,  604,  546,   82,   82,  605,  595,  623,   82,

			  577,  577,  577,  581,  581,  581,  623,  623,  598,  623,
			  599,  597,  581,  581,  581,  356,  600,  615,  623,  437,
			   82,  601,  602,  623,  609,  546,  610,  612,  603,  583,
			  583,  583,  583,  583,  583,  606,  606,  606,  587,  587,
			  587,   97,   97,  597,  613,  607,   97,  607,  614,  585,
			  608,  608,  608,  587,  587,  587,  609,  585,  610,  612,
			  603,  596,  596,  596,  608,  608,  608,   97,  608,  608,
			  608,  616,  617,   97,   97,  618,  613,  619,   97,  620,
			  614,  585,  621,  500,  622,  260,  260,  260,  623,  585,
			  623,  611,  623,  623,  623,  623,  623,  623,  623,   97,

			  623,  623,  623,  616,  617,  623,  623,  618,  623,  619,
			  623,  620,  623,  623,  621,  623,  622,  623,  623,  623,
			  623,  623,  623,  611,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   79,  623,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   98,

			  623,   98,  623,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   99,  623,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  166,  623,  166,  166,
			  166,  623,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  191,  191,  191,  191,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  191,  191,  195,  195,  195,  195,
			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,   81,  623,   81,   81,

			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   82,  623,   82,  623,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,  224,  623,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  249,  249,  249,  249,  524,  524,  524,  524,
			  524,  524,  524,  524,  524,  524,  524,  524,  524,  524,
			  524,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,  542,  542,  542,  542,  542,   11,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,

			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623, yy_Dummy>>)
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
			    1,    1,    3,    4,   38,    3,    4,  524,    3,    4,

			    5,    5,    5,  491,    5,    6,    6,    6,   46,    6,
			    9,    9,    9,   10,   10,   10,   13,   13,   13,   14,
			   14,   14,   19,   25,   19,   26,   38,   26,   26,   26,
			   27,   13,  472,   25,   14,   33,   33,   27,   49,   28,
			   46,   28,   28,   28,   29,   40,   29,   29,   29,   35,
			   35,   48,   28,   45,  434,   40,    5,   29,   52,   45,
			   54,    6,   30,  368,   30,   30,   30,   41,   48,   41,
			   49,  367,   67,   71,   28,   67,   71,   40,  356,   41,
			   55,   28,   82,   48,   28,   45,   29,   40,    5,   29,
			   52,   45,   54,    6,   16,   16,  260,   16,   16,   41,

			   48,   41,   16,   16,   30,   16,   28,   16,   53,  247,
			   50,   41,   55,   16,   82,   16,   37,   16,   16,  246,
			   39,   37,   53,   37,   39,   50,   16,   39,   37,   37,
			   39,   16,   16,   39,   42,   75,   75,   75,   42,  121,
			   53,   16,   50,  191,   16,   16,  191,   16,   37,  245,
			   16,   42,   39,   37,   53,   37,   39,   50,   16,   39,
			   37,   37,   39,   16,   16,   39,   42,   44,  102,   47,
			   42,  121,  102,   16,   44,   44,   16,   16,   51,   47,
			   44,   47,  102,   42,  195,   47,  244,  195,   51,  123,
			  124,   51,   68,   68,   68,   79,   68,  122,   79,   44,

			  122,   47,  243,   77,   77,   77,   44,   44,  242,  241,
			   51,   47,   44,   47,  240,  239,   83,   47,   77,   83,
			   51,  123,  124,   51,   66,   66,   66,  238,   66,  122,
			  125,   66,  122,   66,   66,   66,  249,   84,  237,   85,
			   84,   66,   85,   86,  126,   79,   86,   66,   68,   66,
			  249,  236,   66,   66,   66,   66,   86,   66,   89,   66,
			  127,   89,  125,   66,   87,   66,   83,   87,   66,   66,
			   66,   66,   66,   66,  235,  234,  126,   79,   81,   81,
			   68,   81,   88,   81,   87,   88,   81,   84,   90,   85,
			  128,   90,  127,   86,  129,   89,  130,   91,   83,  131,

			   91,   92,   88,   93,   92,  134,   93,   95,   89,   96,
			   95,  137,   96,  138,   87,  105,  105,  105,  233,   84,
			  232,   85,  128,  230,   90,   86,  129,   89,  130,  105,
			  132,  131,   88,   81,  132,   91,  139,  134,   90,  141,
			   89,   93,   92,  137,  229,  138,   87,   91,   94,   94,
			   94,   92,   94,   93,  228,   94,   90,   95,   95,   96,
			  144,  105,  132,  146,   88,   81,  132,   91,  139,  135,
			   90,  141,  227,   93,   92,  113,  113,  113,  108,   91,
			  108,  108,  108,   92,  135,   93,   97,   97,   97,   95,
			   97,   96,  144,   97,  108,  146,  109,  147,  109,  109,

			  109,  135,   94,  110,   94,  110,  110,  110,  226,  109,
			  136,  145,  148,  197,  136,  113,  135,  142,  149,  142,
			  151,  142,  152,  145,  154,  155,  108,  149,  154,  147,
			  156,  157,  142,  158,   94,  142,  160,  161,  109,  162,
			   97,  109,  136,  145,  148,  110,  136,  252,  166,  142,
			  149,  142,  151,  142,  152,  145,  154,  155,  163,  149,
			  154,  252,  156,  157,  142,  158,  101,  142,  160,  161,
			  435,  162,   97,  100,   99,   78,  100,   72,  100,  100,
			  100,  168,  168,  168,  435,   63,  100,  542,  168,  263,
			  163,  159,  100,   61,  100,  264,  159,  100,  100,  100,

			  100,  542,  100,  209,  100,   57,  209,  159,  100,  153,
			  100,  153,  251,  100,  100,  100,  100,  100,  100,  153,
			   36,  263,  153,  159,  153,  153,  251,  264,  159,  174,
			  174,  174,  194,  194,  194,   31,  194,  211,   11,  159,
			  211,  153,  435,  153,  199,  199,  199,  203,  203,  203,
			  203,  153,  203,  209,  153,  203,  153,  153,  204,  204,
			  204,  213,    8,  214,  213,  215,  214,  216,  215,  217,
			  216,  217,    7,  218,  217,    0,  218,  219,  219,  219,
			  221,  219,  251,  221,  219,  209,  267,  211,  194,  222,
			  214,    0,  222,  231,  231,  231,  258,  268,  258,  258,

			  258,  254,  203,  254,  215,  270,  254,  254,  254,  258,
			  216,  213,  204,  214,  218,  215,  271,  216,  267,  211,
			  194,  217,  214,  218,    0,  250,  250,  250,    0,  268,
			  221,  219,    0,  272,  203,    0,  215,  270,  258,  222,
			  250,  258,  216,  213,  204,  214,  218,  215,  271,  216,
			  253,  253,  253,  217,  273,  218,  256,  256,  256,  262,
			  262,  262,  221,  219,  253,  272,  274,  257,  275,  257,
			  256,  222,  257,  257,  257,  259,  276,  259,  259,  259,
			  261,  277,  261,  261,  261,    0,  273,  279,  281,  280,
			    0,  282,  283,  284,  285,  286,  253,  287,  274,  262,

			  275,  288,  256,  280,  289,  290,  284,  291,  276,  292,
			  293,  294,  295,  277,  297,  298,  299,  259,  301,  279,
			  281,  280,  261,  282,  283,  284,  285,  286,  300,  287,
			  302,  300,  303,  288,  304,  280,  289,  290,  284,  291,
			  305,  292,  293,  294,  295,  306,  297,  298,  299,  307,
			  301,  308,  309,  310,  311,  312,  313,  314,  305,  315,
			  300,  316,  302,  300,  303,  317,  304,  318,  321,  321,
			  321,  321,  305,  322,  322,  322,  327,  306,  371,  327,
			  357,  307,    0,  308,  309,  310,  311,  312,  313,  314,
			  305,  315,  328,  316,  357,  328,  326,  317,  326,  318,

			  329,  326,  331,  329,    0,  331,  339,  339,  339,  339,
			  371,  327,  359,  359,  359,  358,  358,  358,  360,  360,
			  360,  361,  361,  361,  372,  373,  327,  322,  329,  358,
			    0,  362,    0,  362,    0,  361,  362,  362,  362,  363,
			  363,  363,  328,  327,  364,  364,  364,  357,  326,  374,
			  329,    0,  331,    0,    0,  358,  372,  373,  327,  322,
			  329,  358,  365,  375,  365,  365,  365,  361,  366,  376,
			  366,  366,  366,  377,  328,  365,  378,  379,    0,  380,
			  326,  374,  329,  369,  331,  369,  369,  369,  370,  381,
			  370,  370,  370,    0,  382,  375,  383,  384,    0,  385,

			  386,  376,  387,  388,  365,  377,  390,  365,  378,  379,
			  366,  380,  391,  392,  393,  394,  395,  396,  398,  401,
			  404,  381,    0,  405,  406,  369,  382,  407,  383,  384,
			  370,  385,  386,  408,  387,  388,  409,  410,  390,  402,
			  402,  402,  411,  402,  391,  392,  393,  394,  395,  396,
			  398,  401,  404,  412,  402,  405,  406,  413,  414,  407,
			  415,  416,  419,  420,  421,  408,  422,  423,  409,  410,
			  427,  427,  427,  427,  411,  428,  430,  432,  428,  430,
			  432,  437,  437,  437,  445,  412,  436,  436,  436,  413,
			  414,  446,  415,  416,  419,  420,  421,  449,  422,  423,

			  436,  438,  438,  438,  439,  439,  439,  451,  430,  440,
			  440,  440,  432,  453,  454,  438,  445,  441,  428,  441,
			  441,  441,  455,  446,  450,  428,  430,  432,  450,  449,
			  456,  457,  436,  441,  442,  458,  442,  442,  442,  451,
			  430,  438,  460,  461,  432,  453,  454,  438,  462,  463,
			  428,  465,  466,  467,  455,  469,  450,  428,  430,  432,
			  450,  473,  456,  457,  474,  441,  475,  458,  476,  477,
			  478,    0,  479,  480,  460,  461,  442,  481,  483,  484,
			  462,  463,  487,  465,  466,  467,  488,  469,  470,  470,
			  470,  490,  470,  473,  492,    0,  474,  492,  475,    0,

			  476,  477,  478,  470,  479,  480,  496,  578,    0,  481,
			  483,  484,  493,  494,  487,  493,  494,    0,  488,  504,
			  496,  578,  497,  490,  497,  492,  505,  497,  497,  497,
			    0,  498,  498,  498,  499,  499,  499,  500,  500,  500,
			  493,  507,  508,  509,  492,  498,  512,  501,  499,  501,
			  514,  504,  501,  501,  501,  494,  515,  492,  505,  517,
			  518,  519,  493,  494,  520,    0,  521,  522,  525,  496,
			  526,  528,  493,  507,  508,  509,  492,  498,  512,  529,
			  499,  502,  514,  502,  502,  502,  531,  494,  515,  535,
			  536,  517,  518,  519,  493,  494,  520,  502,  521,  522,

			  525,  538,  526,  528,  539,  540,  541,  539,  540,  541,
			    0,  529,  543,  543,  543,  544,  544,  544,  531,    0,
			  552,  535,  536,  545,  545,  545,  548,  548,  548,  502,
			    0,  554,  539,  538,  541,  556,  546,  545,  546,  557,
			  548,  546,  546,  546,  547,  558,  547,  540,  561,  547,
			  547,  547,  552,  564,  539,  540,  541,  549,  549,  549,
			  550,  550,  550,  554,  539,  565,  541,  556,  551,  545,
			  551,  557,  548,  551,  551,  551,  567,  558,  568,  540,
			  561,  566,  566,  566,  569,  564,  539,  540,  541,  571,
			  572,  574,  575,  579,  574,  575,  576,  565,    0,  576,

			  577,  577,  577,  580,  580,  580,    0,    0,  567,    0,
			  568,  566,  581,  581,  581,  577,  569,  603,    0,  579,
			  603,  571,  572,    0,  588,  579,  594,  597,  574,  582,
			  582,  582,  583,  583,  583,  584,  584,  584,  586,  586,
			  586,  574,  575,  566,  598,  585,  576,  585,  600,  584,
			  585,  585,  585,  587,  587,  587,  588,  606,  594,  597,
			  574,  596,  596,  596,  607,  607,  607,  603,  608,  608,
			  608,  611,  612,  574,  575,  616,  598,  617,  576,  618,
			  600,  584,  619,  606,  620,  640,  640,  640,    0,  606,
			    0,  596,    0,    0,    0,    0,    0,    0,    0,  603,

			    0,    0,    0,  611,  612,    0,    0,  616,    0,  617,
			    0,  618,    0,    0,  619,    0,  620,    0,    0,    0,
			    0,    0,    0,  596,  624,  624,  624,  624,  624,  624,
			  624,  624,  624,  624,  624,  624,  624,  624,  624,  625,
			  625,  625,  625,  625,  625,  625,  625,  625,  625,  625,
			  625,  625,  625,  625,  626,  626,  626,  626,  626,  626,
			  626,  626,  626,  626,  626,  626,  626,  626,  626,  627,
			  627,  627,  627,  627,  627,  627,  627,  627,  627,  627,
			  627,  627,  627,  627,  628,    0,  628,  628,  628,  628,
			  628,  628,  628,  628,  628,  628,  628,  628,  628,  629,

			    0,  629,    0,  629,  629,  629,  629,  629,  629,  629,
			  629,  629,  630,    0,  630,  630,  630,  630,  630,  630,
			  630,  630,  630,  630,  630,  630,  630,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  632,    0,  632,  632,
			  632,    0,  632,  632,  632,  632,  632,  632,  632,  632,
			  632,  633,  633,  633,  633,  633,  633,  633,  633,  633,
			  633,  633,  633,  633,  633,  633,  634,  634,  634,  634,
			  634,  634,  634,  634,  634,  634,  634,  634,  634,  634,
			  634,  635,  635,  635,  635,  635,  635,  635,  635,  635,
			  635,  635,  635,  635,  635,  635,  636,    0,  636,  636,

			  636,  636,  636,  636,  636,  636,  636,  636,  636,  636,
			  636,  637,    0,  637,    0,  637,  637,  637,  637,  637,
			  637,  637,  637,  637,  637,  637,  638,    0,  638,  638,
			  638,  638,  638,  638,  638,  638,  638,  638,  638,  638,
			  638,  639,  639,  639,  639,  639,  639,  639,  639,  639,
			  639,  639,  639,  639,  639,  639,  641,  641,  641,  641,
			  641,  641,  641,  641,  641,  641,  641,  641,  641,  641,
			  641,  642,  642,  642,  642,  642,  642,  642,  642,  642,
			  642,  642,  642,  642,  642,  642,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,

			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  669,  659,  108,
			  111,  638, 1786,  114,  117, 1786,  188,    0, 1786,  113,
			 1786, 1786, 1786, 1786, 1786,  106,  107,  111,  121,  126,
			  144,  609, 1786,  110, 1786,  123,  594,  180,   56,  183,
			  111,  126,  204,    0,  232,  115,   64,  238,  121,  104,
			  176,  241,  115,  178,  123,  136, 1786,  548, 1786, 1786,
			 1786,  502, 1786,  579, 1786, 1786,  322,  169,  290, 1786,
			 1786,  170,  574, 1786, 1786,  233, 1786,  301,  558,  289,
			 1786,  377,  126,  310,  331,  333,  337,  358,  376,  352,
			  382,  391,  395,  397,  446,  401,  403,  484,    0,  563,

			  567,  555,  265, 1786, 1786,  395, 1786, 1786,  460,  478,
			  485, 1786,    0,  455, 1786, 1786, 1786, 1786, 1786, 1786,
			    0,  205,  259,  256,  242,  281,  295,  326,  360,  351,
			  362,  352,  399,    0,  357,  436,  465,  370,  383,  392,
			    0,  394,  484,    0,  420,  479,  414,  449,  479,  486,
			    0,  473,  488,  576,  483,  478,  496,  481,  488,  558,
			  489,  499,  505,  511, 1786, 1786,  542, 1786,  579, 1786,
			 1786, 1786, 1786, 1786,  609, 1786, 1786, 1786, 1786, 1786,
			 1786, 1786, 1786, 1786, 1786, 1786, 1786, 1786, 1786, 1786,
			 1786,  240, 1786, 1786,  630,  281, 1786,  510, 1786,  642,

			 1786, 1786, 1786,  646,  656, 1786, 1786, 1786, 1786,  597,
			 1786,  631, 1786,  655,  657,  659,  661,  665,  667,  675,
			 1786,  674,  683, 1786, 1786, 1786,  497,  461,  443,  433,
			  412,  673,  409,  407,  364,  363,  340,  327,  316,  304,
			  303,  298,  297,  291,  275,  238,  208,  198, 1786,  333,
			  723,  609,  544,  730,  686, 1786,  736,  752,  678,  757,
			  136,  762,  739,  546,  565,    0,    0,  648,  650,    0,
			  673,  668,  682,  724,  719,  718,  742,  747,    0,  737,
			  759,  754,  743,  743,  751,  753,  761,  759,  767,  759,
			  775,  773,  779,  765,  777,  768,    0,  780,  761,  767,

			  796,  784,  796,  802,  784,  808,  798,  815,  821,  814,
			  810,  820,  814,  822,  811,  821,  823,  832,  824,    0,
			 1786,  849,  871, 1786, 1786, 1786,  892,  870,  886,  894,
			 1786,  896, 1786, 1786, 1786, 1786, 1786, 1786, 1786,  887,
			 1786, 1786, 1786, 1786, 1786, 1786, 1786, 1786, 1786, 1786,
			 1786, 1786, 1786, 1786, 1786, 1786,  161,  877,  895,  892,
			  898,  901,  916,  919,  924,  944,  950,  111,  145,  965,
			  970,  829,  876,  889,  911,  923,  921,  939,  927,  943,
			  943,  942,  956,  949,  954,  952,  953,  968,  953,    0,
			  972,  974,  960,  961,  968,  982,  970,    0,  977,    0,

			    0,  978, 1037,    0,  982,  973,  986,  992,  986,  994,
			  999,  992, 1012, 1003, 1026, 1013, 1016,    0,    0, 1028,
			 1028, 1014, 1025, 1037,    0,    0, 1786, 1051, 1069, 1786,
			 1070, 1786, 1071, 1786,  143,  567, 1066, 1061, 1081, 1084,
			 1089, 1099, 1116,    0,    0, 1041, 1060,    0,    0, 1050,
			 1090, 1064,    0, 1066, 1079, 1088, 1097, 1082, 1092,    0,
			 1095, 1100, 1114, 1111,    0, 1113, 1120, 1115,    0, 1121,
			 1186, 1786,  115, 1131, 1117, 1113, 1130, 1135, 1136, 1125,
			 1139, 1128,    0, 1129, 1149,    0,    0, 1144, 1152,    0,
			 1148,   84, 1188, 1206, 1207, 1786, 1203, 1207, 1211, 1214,

			 1217, 1232, 1263,    0, 1169, 1177,    0, 1197, 1193, 1209,
			    0,    0, 1212,    0, 1220, 1222,    0, 1211, 1217, 1212,
			 1215, 1236, 1218, 1786,   94, 1227, 1222,    0, 1228, 1236,
			    0, 1252,    0,    0,    0, 1240, 1247,    0, 1252, 1298,
			 1299, 1300,  584, 1292, 1295, 1303, 1321, 1329, 1306, 1337,
			 1340, 1353, 1271,    0, 1288,    0, 1302, 1306, 1304,    0,
			    0, 1312,    0,    0, 1310, 1331, 1379, 1332, 1344, 1352,
			    0, 1355, 1356,    0, 1385, 1386, 1390, 1398, 1204, 1359,
			 1383, 1392, 1409, 1412, 1415, 1430, 1418, 1433, 1390,    0,
			    0,    0,    0,    0, 1377,    0, 1459, 1386, 1397,    0,

			 1414,    0,    0, 1411, 1786, 1786, 1423, 1444, 1448,    0,
			    0, 1430, 1442,    0,    0, 1786, 1445, 1429, 1431, 1434,
			 1436,    0, 1786, 1786, 1523, 1538, 1553, 1568, 1583, 1596,
			 1611, 1620, 1635, 1650, 1665, 1680, 1695, 1710, 1725, 1740,
			 1478, 1755, 1770, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  623,    1,  624,  624,  625,  625,  626,  626,  627,
			  627,  623,  623,  623,  623,  623,  628,  629,  623,  630,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  623,  623,  623,  623,
			  623,  623,  623,  632,  623,  623,  623,  633,  633,  623,
			  623,  634,  635,  623,  623,  623,  623,  623,  623,  628,
			  623,  636,  637,  628,  628,  628,  628,  628,  628,  628,
			  628,  628,  628,  628,  628,  628,  628,  628,  629,  638,

			  638,  638,  639,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  640,  623,  623,  623,  623,  623,  623,  623,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  623,  623,  632,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  633,  623,  623,  633,  634,  623,  635,  623,  623,

			  623,  623,  623,  636,  637,  623,  623,  623,  623,  628,
			  623,  628,  623,  628,  628,  628,  628,  628,  628,  628,
			  623,  628,  628,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  639,
			  623,  639,  639,  623,  623,  623,  623,  623,  623,  623,
			  640,  623,  623,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,

			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  623,  623,  637,  623,  623,  623,  628,  628,  628,  628,
			  623,  628,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  639,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  640,  623,  623,
			  623,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,

			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  623,  623,  628,  623,
			  628,  623,  628,  623,  623,  639,  623,  623,  623,  623,
			  623,  623,  623,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  623,  623,  623,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  623,  628,  628,  628,  623,  639,  623,  623,  623,

			  623,  623,  623,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  623,  641,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  628,
			  628,  628,  642,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  631,  631,  631,  631,  631,  631,
			  631,  631,  631,  631,  628,  628,  628,  623,  642,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  631,  631,
			  631,  631,  631,  631,  631,  631,  623,  631,  631,  631,

			  631,  631,  631,  628,  623,  623,  623,  623,  623,  631,
			  631,  623,  631,  631,  631,  623,  623,  631,  623,  631,
			  623,  631,  623,    0,  623,  623,  623,  623,  623,  623,
			  623,  623,  623,  623,  623,  623,  623,  623,  623,  623,
			  623,  623,  623, yy_Dummy>>)
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
			    5,    5,    6,    8,   11,   13,   16,   19,   22,   25,
			   28,   31,   34,   37,   40,   43,   46,   49,   52,   55,
			   58,   61,   64,   67,   70,   73,   76,   79,   82,   85,
			   88,   91,   94,   97,  100,  103,  106,  109,  112,  115,
			  118,  121,  124,  127,  130,  133,  136,  139,  141,  144,
			  147,  150,  153,  156,  158,  160,  162,  164,  166,  168,
			  170,  172,  174,  176,  178,  180,  182,  184,  185,  185,
			  186,  187,  188,  188,  189,  190,  191,  192,  193,  194,
			  195,  196,  197,  198,  199,  201,  202,  203,  205,  206,

			  207,  208,  209,  210,  211,  212,  213,  214,  215,  216,
			  217,  218,  219,  219,  219,  220,  221,  222,  223,  224,
			  225,  226,  227,  228,  229,  231,  232,  233,  234,  235,
			  236,  237,  238,  239,  241,  242,  243,  244,  245,  246,
			  247,  249,  250,  251,  253,  254,  255,  256,  257,  258,
			  259,  261,  262,  263,  264,  265,  266,  267,  268,  269,
			  270,  271,  272,  273,  274,  275,  276,  277,  278,  278,
			  279,  280,  281,  282,  283,  283,  284,  285,  286,  287,
			  288,  289,  290,  291,  292,  293,  294,  295,  296,  297,
			  298,  299,  300,  301,  302,  303,  304,  306,  307,  308,

			  308,  309,  310,  312,  314,  315,  317,  319,  321,  323,
			  324,  326,  327,  329,  330,  331,  332,  333,  334,  335,
			  336,  337,  338,  339,  341,  342,  344,  345,  346,  347,
			  348,  349,  350,  351,  352,  353,  354,  355,  356,  357,
			  358,  359,  360,  361,  362,  363,  364,  365,  366,  368,
			  369,  370,  371,  372,  373,  373,  374,  375,  375,  376,
			  377,  378,  379,  379,  380,  381,  383,  385,  386,  387,
			  389,  390,  391,  392,  393,  394,  395,  396,  397,  399,
			  400,  401,  402,  403,  404,  405,  406,  407,  408,  409,
			  410,  411,  412,  413,  414,  416,  417,  419,  420,  421,

			  422,  423,  424,  425,  426,  427,  428,  429,  430,  431,
			  432,  433,  434,  435,  436,  437,  438,  439,  440,  441,
			  443,  444,  444,  444,  446,  448,  450,  451,  452,  453,
			  454,  456,  457,  459,  461,  462,  463,  464,  465,  466,
			  467,  468,  469,  470,  471,  472,  473,  474,  475,  476,
			  477,  478,  479,  480,  481,  482,  483,  483,  484,  485,
			  485,  486,  487,  487,  487,  488,  489,  490,  490,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  499,  500,
			  501,  502,  503,  505,  506,  507,  508,  509,  510,  511,
			  513,  514,  515,  516,  517,  518,  519,  520,  522,  523,

			  525,  527,  528,  530,  532,  533,  534,  535,  536,  537,
			  538,  539,  540,  541,  542,  543,  544,  545,  547,  549,
			  550,  551,  552,  553,  554,  556,  558,  559,  559,  560,
			  562,  563,  565,  566,  568,  569,  570,  571,  571,  572,
			  572,  573,  574,  575,  577,  579,  580,  581,  583,  585,
			  586,  587,  588,  590,  591,  592,  593,  594,  595,  596,
			  598,  599,  600,  601,  602,  604,  605,  606,  607,  609,
			  610,  610,  611,  611,  612,  613,  614,  615,  616,  617,
			  618,  619,  620,  622,  623,  624,  626,  628,  629,  630,
			  632,  633,  633,  634,  635,  636,  637,  638,  638,  639,

			  640,  640,  640,  641,  643,  644,  645,  647,  648,  649,
			  650,  652,  654,  655,  657,  658,  659,  661,  662,  663,
			  664,  665,  666,  667,  668,  668,  669,  670,  672,  673,
			  674,  676,  677,  679,  681,  683,  684,  685,  687,  688,
			  689,  690,  691,  693,  693,  694,  695,  695,  695,  696,
			  696,  697,  697,  698,  700,  701,  703,  704,  705,  706,
			  708,  710,  711,  713,  715,  716,  717,  718,  719,  720,
			  721,  723,  724,  725,  727,  728,  729,  730,  732,  734,
			  735,  735,  736,  736,  737,  738,  738,  738,  739,  740,
			  742,  744,  746,  748,  750,  751,  753,  753,  754,  755,

			  757,  758,  760,  762,  763,  765,  767,  768,  768,  769,
			  771,  773,  773,  774,  776,  778,  780,  780,  781,  781,
			  782,  782,  784,  785,  785, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  169,  169,  171,  171,  202,  200,  201,    2,  200,
			  201,    2,  201,   32,  200,  201,  172,  200,  201,   37,
			  200,  201,   11,  200,  201,  139,  200,  201,   20,  200,
			  201,   21,  200,  201,   28,  200,  201,   26,  200,  201,
			    5,  200,  201,   27,  200,  201,   10,  200,  201,   29,
			  200,  201,  111,  200,  201,  111,  200,  201,  111,  200,
			  201,    4,  200,  201,    3,  200,  201,   15,  200,  201,
			   14,  200,  201,   16,  200,  201,    7,  200,  201,  109,
			  200,  201,  109,  200,  201,  109,  200,  201,  109,  200,
			  201,  109,  200,  201,  109,  200,  201,  109,  200,  201,

			  109,  200,  201,  109,  200,  201,  109,  200,  201,  109,
			  200,  201,  109,  200,  201,  109,  200,  201,  109,  200,
			  201,  109,  200,  201,  109,  200,  201,  109,  200,  201,
			  109,  200,  201,  109,  200,  201,   24,  200,  201,  200,
			  201,   25,  200,  201,   30,  200,  201,   22,  200,  201,
			   23,  200,  201,    8,  200,  201,  173,  201,  199,  201,
			  197,  201,  198,  201,  169,  201,  169,  201,  168,  201,
			  167,  201,  169,  201,  171,  201,  170,  201,  165,  201,
			  165,  201,  164,  201,    2,  172,  161,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,

			 -364,  172,  172,  172, -364,   37,  139,  139,  139,    2,
			   31,    6,  114,   35,   19,  114,  111,  111,  110,   12,
			   33,   17,   18,   34,   13,  109,  109,  109,  109,   42,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,   54,
			  109,  109,  109,  109,  109,  109,  109,   66,  109,  109,
			  109,   73,  109,  109,  109,  109,  109,  109,  109,   85,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,   36,    9,  173,  197,  190,  188,
			  189,  191,  192,  193,  194,  174,  175,  176,  177,  178,
			  179,  180,  181,  182,  183,  184,  185,  186,  187,  169,

			  168,  167,  169,  169,  166,  167,  171,  170,  164,  162,
			  160,  162,  172, -364, -364,  147,  162,  145,  162,  146,
			  162,  148,  162,  172,  141,  162,  172,  142,  162,  172,
			  172,  172,  172,  172,  172,  172, -163,  172,  172,  149,
			  162,  139,  115,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  116,  139,    2,    2,
			    2,    2,  114,  112,  114,  111,  111,  113,  111,  109,
			  109,   40,  109,   41,  109,  109,  109,   45,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,   57,  109,  109,

			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,   77,  109,  109,   80,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  108,  109,  196,  150,  162,  143,  162,  144,  162,
			  172,  172,  172,  172,  157,  162,  172,  152,  162,  151,
			  162,  133,  131,  132,  134,  135,  140,  136,  137,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,    2,  114,  114,  114,  114,  111,  111,
			  111,  111,  109,  109,  109,  109,  109,  109,  109,  109,

			  109,  109,  109,   55,  109,  109,  109,  109,  109,  109,
			  109,   64,  109,  109,  109,  109,  109,  109,  109,  109,
			   74,  109,  109,   76,  109,   78,  109,  109,   83,  109,
			   84,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,   99,  109,  100,  109,  109,
			  109,  109,  109,  109,  106,  109,  107,  109,  195,  172,
			  153,  162,  172,  156,  162,  172,  159,  162,  140,    2,
			  114,  114,  114,  114,  111,   38,  109,   39,  109,  109,
			  109,   46,  109,   47,  109,  109,  109,  109,   52,  109,
			  109,  109,  109,  109,  109,  109,   62,  109,  109,  109,

			  109,  109,   69,  109,  109,  109,  109,   75,  109,  109,
			   81,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			   95,  109,  109,  109,   98,  109,  101,  109,  109,  109,
			  104,  109,  109,  172,  172,  172,  138,    2,  114,  114,
			  114,   43,  109,  109,  109,   49,  109,  109,  109,  109,
			   56,  109,   58,  109,  109,   60,  109,  109,  109,   65,
			  109,  109,  109,  109,  109,  109,  109,   82,  109,  109,
			   88,  109,  109,  109,   91,  109,  109,   93,  109,   94,
			  109,   96,  109,  109,  109,  103,  109,  109,  172,  172,
			  172,    1,    2,  114,  114,  114,  114,  109,   48,  109,

			  109,   51,  109,  109,  109,  109,   63,  109,   67,  109,
			  109,   70,  109,   71,  109,  109,  109,  109,  109,  109,
			  109,   92,  109,  109,  109,  105,  109,  172,  172,  172,
			    1,    2,    1,    2,  114,  114,  114,  114,  114,  109,
			   50,  109,   53,  109,   59,  109,   61,  109,   68,  109,
			  109,   79,  109,  109,  109,   89,  109,  109,   97,  109,
			  102,  109,  172,  155,  162,  158,  162,  114,  114,   44,
			  109,   72,  109,  109,   87,  109,   90,  109,  154,  162,
			  109,  109,   86,  109,   86, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1786
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 623
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 624
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

	yyNb_rules: INTEGER is 201
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 202
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
