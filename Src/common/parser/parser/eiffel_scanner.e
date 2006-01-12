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
 ast_factory.new_break_as (Current) 
when 2 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 42 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 42")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			
when 3 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 46 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 46")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			
when 4 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 50 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 50")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			
when 5 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 54 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 54")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 58 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 58")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			
when 7 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 62 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 62")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			
when 8 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 66 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 66")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CURLYTILDE, Current)
				last_token := TE_CURLYTILDE
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 70 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 70")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			
when 10 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 74 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 74")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			
when 11 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 78 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 78")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			
when 12 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 82 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 82")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			
when 13 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 86 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 86")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 90 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 90")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 94 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 94")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			
when 16 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 98 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 98")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			
when 17 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 102 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 102")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			
when 18 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 106 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 106")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 110 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 110")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			
when 20 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 114 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 114")
end

				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			
when 21 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 118 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 118")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			
when 22 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 122 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 122")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			
when 23 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 126 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 126")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 130 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 130")
end
				
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 134 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 134")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 138 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 138")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 142 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 142")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 146 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 146")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 150 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 150")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			
when 30 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 154 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 154")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 158 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 158")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			
when 32 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 162 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 162")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			
when 33 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 166 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 166")
end
			
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			
when 34 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 170 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 170")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 174")
end
				
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			
when 36 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 182 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 182")
end

				last_token := TE_FREE
				process_id_as
			
when 37 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 190 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 190")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			
when 38 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 194 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 194")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			
when 39 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 198")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			
when 40 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 202 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 202")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			
when 41 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 206 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 206")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			
when 42 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 210 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 210")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ASSIGN, Current)
				if last_keyword_as_value /= Void then
					last_assign_index := last_keyword_as_value.index
				end
				last_token := TE_ASSIGN
			
when 43 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 217 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 217")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 44 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 226 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 226")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
			
when 45 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 230 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 230")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			
when 46 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 234 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 234")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			
when 47 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 238 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 238")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			
when 48 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 242 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 242")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			
when 49 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 246 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 246")
end
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (line, column, position, 8, Current)
				last_token := TE_CREATION				
			
when 50 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 250 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 250")
end
				
				last_current_as_value := ast_factory.new_current_as (line, column, position, 7, Current)
				last_token := TE_CURRENT
			
when 51 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 254 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 254")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			
when 52 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 258 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 258")
end
				
				last_deferred_as_value := ast_factory.new_deferred_as (line, column, position, 8, Current)
				last_token := TE_DEFERRED			
			
when 53 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 262 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 262")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			
when 54 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 266 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 266")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			
when 55 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 270 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 270")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			
when 56 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 274 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 274")
end
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (line, column, position, 3, Current)
				last_token := TE_END
			
when 57 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 278 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 278")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			
when 58 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 282 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 282")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			
when 59 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 286 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 286")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			
when 60 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 290 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 290")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			
when 61 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 294 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 294")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (False, line, column, position, 5, Current)
				last_token := TE_FALSE
			
when 62 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 298 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 298")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			
when 63 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 302 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 302")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			
when 64 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 306 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 306")
end
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (line, column, position, 6, Current)
				last_token := TE_FROZEN
			
when 65 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 310 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 310")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			
when 66 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 314 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 314")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			
when 67 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 318 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 318")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
				last_token := TE_INDEXING
			
when 68 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 322 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 322")
end
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (line, column, position, 5, Current)
				last_token := TE_INFIX
			
when 69 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 326 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 326")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 330 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 330")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			
when 71 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 334 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 334")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			
when 72 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 338 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 338")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			
when 73 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 342 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 342")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			
when 74 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 346 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 346")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			
when 75 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 350 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 350")
end

				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			
when 76 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 354 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 354")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			
when 77 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 358 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 358")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 78 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 367 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 367")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			
when 79 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 371 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 371")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
				last_token := TE_OLD
			
when 80 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 387 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 387")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			
when 81 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 391 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 391")
end
				
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.new_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING			
			
when 82 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 398 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 398")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			
when 83 then
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
							"Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 84 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 411 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 411")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			
when 85 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 415 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 415")
end
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (line, column, position, 9, Current)
				last_token := TE_PRECURSOR
			
when 86 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 419 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 419")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (line, column, position, 6, Current)
				last_token := TE_PREFIX
			
when 87 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 423 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 423")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			
when 88 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 427 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 427")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			
when 89 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 431 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 431")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			
when 90 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 435 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 435")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			
when 91 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 439 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 439")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			
when 92 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 443 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 443")
end
					
				last_result_as_value := ast_factory.new_result_as (line, column, position, 6, Current)
				last_token := TE_RESULT
			
when 93 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 447 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 447")
end
				
				last_retry_as_value := ast_factory.new_retry_as (line, column, position, 5, Current)
				last_token := TE_RETRY
			
when 94 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 451 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 451")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			
when 95 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 455 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 455")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			
when 96 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 459 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 459")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			
when 97 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 463 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 463")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			
when 98 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 467 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 467")
end
				
				last_bool_as_value := ast_factory.new_boolean_as (True, line, column, position, 4, Current)
				last_token := TE_TRUE
			
when 99 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 471 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 471")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 100 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 475 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 475")
end
				
				last_unique_as_value := ast_factory.new_unique_as (line, column, position, 6, Current)
				last_token := TE_UNIQUE
			
when 101 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 479 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 479")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 102 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 483 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 483")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 103 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 487 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 487")
end
				
				last_void_as_value := ast_factory.new_void_as (line, column, position, 4, Current)
				last_token := TE_VOID
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 491 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 491")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 105 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 495 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 495")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 106 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 503 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 503")
end

				last_token := TE_ID
				process_id_as
			
when 107 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 510 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 510")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)
			
when 108 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 518 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 518")
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
			
when 109 then
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 519 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 519")
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
			
when 110 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 531 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 531")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 539 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 539")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end				
				last_token := TE_REAL
			
when 112 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 551 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 551")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 113 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 557 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 557")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 114 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 564 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 564")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 570 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 570")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 116 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 576 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 576")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 117 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 582 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 582")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 588 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 588")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 594 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 594")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 600 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 600")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 606 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 606")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 612 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 612")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 618 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 618")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 624 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 624")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 630 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 630")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 636 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 636")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 642 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 642")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 648 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 648")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 654 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 654")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 660 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 660")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 666 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 666")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 672 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 672")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 678 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 678")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 684 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 684")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 690 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 690")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 136 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 693 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 693")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 137 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 694 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 694")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 138 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 703 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 703")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 139 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 707 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 707")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 140 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 711 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 711")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 715 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 715")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 142 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 719 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 719")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 143 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 723 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 723")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 144 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 727 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 727")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 731 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 731")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 735 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 735")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 147 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 739 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 739")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 148 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 149 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 747 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 747")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 150 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 751 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 751")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 151 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 757 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 757")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 152 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 763 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 763")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 153 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 769 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 769")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 154 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 775 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 775")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 155 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 781 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 781")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 156 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 787 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 787")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 157 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 793 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 793")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 158 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 802 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 802")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 159 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 808 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 808")
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
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
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
			
when 161 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 162 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
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
			
when 163 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 861 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 861")
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
			
when 164 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 904 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 904")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 165 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 909 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 909")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 166 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 917 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 917")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 167 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 933 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 933")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 168 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 942 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 942")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 169 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 955 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 955")
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
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 967 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 967")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 171 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 971 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 971")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%A")
				token_buffer.append_character ('%A')
			
when 172 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 975 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 975")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%B")
				token_buffer.append_character ('%B')
			
when 173 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 979 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 979")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%C")
				token_buffer.append_character ('%C')
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 983 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 983")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%D")
				token_buffer.append_character ('%D')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 987 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 987")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%F")
				token_buffer.append_character ('%F')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 991 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 991")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%H")
				token_buffer.append_character ('%H')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 995 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 995")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%L")
				token_buffer.append_character ('%L')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 999 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 999")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%N")
				token_buffer.append_character ('%N')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1003 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1003")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%Q")
				token_buffer.append_character ('%Q')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1007 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1007")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%R")
				token_buffer.append_character ('%R')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1011 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1011")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%S")
				token_buffer.append_character ('%S')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1015 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1015")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%T")
				token_buffer.append_character ('%T')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1019 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1019")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%U")
				token_buffer.append_character ('%U')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1023 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1023")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%V")
				token_buffer.append_character ('%V')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1027 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1027")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%%")
				token_buffer.append_character ('%%')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1031 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1031")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%'")
				token_buffer.append_character ('%'')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1035 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1035")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%"")
				token_buffer.append_character ('%"')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1039 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1039")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%(")
				token_buffer.append_character ('%(')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1043 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1043")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%)")
				token_buffer.append_character ('%)')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1047 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1047")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%<")
				token_buffer.append_character ('%<')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1051 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1051")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%>")
				token_buffer.append_character ('%>')
			
when 192 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1055 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1055")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 193 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1059 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1059")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 194 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1064 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1064")
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
			
when 195 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1080 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1080")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 196 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1086 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1086")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 197 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1104 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1104")
end

				report_unknown_token_error (text_item (1))
			
when 198 then
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
			   61,   62,   64,   64,  126,   65,   65,  458,   66,   66,

			   68,   69,   68,  415,   70,   68,   69,   68,  146,   70,
			   75,   76,   75,   75,   76,   75,   77,   77,   77,   77,
			   77,   77,  100,  102,  101,  104,  126,  105,  105,  105,
			  106,   78,  509,  103,   78,  115,  116,  107,  151,  108,
			  146,  109,  109,  110,  108,  132,  109,  109,  110,  117,
			  118,  152,  111,  144,  481,  133,   71,  111,  155,  145,
			  157,   71,  108,  250,  110,  110,  110,  134,  156,  135,
			  151,  358,  190,  190,  112,  191,  194,  132,  358,  136,
			  160,  113,  161,  152,  111,  144,  113,  133,   71,  111,
			  155,  145,  157,   71,   80,   81,  348,   82,   81,  134,

			  156,  135,   83,   84,  113,   85,  112,   86,  158,  347,
			  153,  136,  160,   87,  161,   88,  121,   81,   89,  346,
			  127,  122,  159,  123,  128,  154,   90,  129,  124,  125,
			  130,   91,   92,  131,  137,  192,  190,  192,  138,  191,
			  158,   93,  153,  345,   94,   95,  202,   96,  121,  344,
			   89,  139,  127,  122,  159,  123,  128,  154,   90,  129,
			  124,  125,  130,   91,   92,  131,  137,  140,   77,  147,
			  138,  258,  261,   93,  141,  142,   97,   81,  202,  148,
			  143,  149,  247,  139,  343,  150,  197,  198,  197,  199,
			  342,  193,   82,   77,   77,   77,   77,   79,   79,  140,

			   79,  147,  200,  258,  261,   82,  141,  142,   78,  341,
			  247,  148,  143,  149,  256,  256,  256,  150,  166,  166,
			  166,  340,  167,  193,  262,  168,  339,  169,  170,  171,
			  203,  204,  338,   82,   82,  172,  263,  205,  337,   97,
			   82,  173,  206,  174,  264,   82,  175,  176,  177,  178,
			  336,  179,  201,  180,  257,  207,  262,  181,  208,  182,
			  335,   82,  183,  184,  185,  186,  187,  188,  263,  334,
			  210,   97,  199,   82,  265,   82,  264,  333,  209,  199,
			   97,   97,   82,  199,  201,  199,   82,   97,   82,  331,
			  211,  266,   97,  199,  199,  267,   82,   82,  221,  190,

			  268,   82,  191,  217,  218,  217,  265,  199,   97,  212,
			   82,  330,   97,   97,  269,  213,  248,  248,  248,   97,
			   97,  214,   97,  266,   97,  329,  215,  267,  272,   97,
			  249,  216,  268,   97,  250,   97,  251,  251,  251,  190,
			   97,  212,  194,   97,   97,  220,  269,  213,   97,  328,
			  252,  327,   97,  214,   97,  277,  196,   97,  215,  219,
			  272,   97,  249,  216,  270,   97,  259,   97,  271,  260,
			  217,  218,  217,  278,  199,   97,   97,   82,  273,  279,
			   97,  108,  252,  253,  253,  254,  280,  277,  108,   97,
			  254,  254,  254,  274,  111,  275,  270,  286,  259,  276,

			  271,  260,  281,  287,  282,  278,  283,  289,  290,  291,
			  273,  279,  292,  294,  303,  288,  304,  284,  280,  305,
			  285,  293,  309,  113,   97,  274,  111,  275,  165,  286,
			  113,  276,  246,  301,  281,  287,  282,  302,  283,  289,
			  290,  291,  310,  223,  292,  294,  303,  288,  304,  284,
			  102,  305,  285,  293,  309,  311,   97,  224,  312,  196,
			  225,  165,  226,  227,  228,  301,  166,  166,  166,  302,
			  229,  163,  362,  313,  310,  306,  230,  162,  231,  363,
			  307,  232,  233,  234,  235,  119,  236,  311,  237,  114,
			  312,  308,  238,  295,  239,  296,  592,  240,  241,  242,

			  243,  244,  245,  297,  362,  364,  298,  306,  299,  300,
			   73,  363,  307,  314,  314,  314,  192,  190,  192,  316,
			  191,  317,   82,  308,   82,  295,   73,  296,  197,  198,
			  197,   79,  217,  218,  217,  297,  200,  364,  298,   82,
			  299,  300,  315,  218,  315,  318,  592,  199,   82,  199,
			   82,  365,   82,  592,  592,  199,  592,  322,   82,  323,
			  325,  199,   82,   82,   82,  326,  592,  592,   82,   97,
			  592,   97,  193,  592,  319,  332,  332,  332,  217,  218,
			  217,  592,  199,  365,  366,   82,  201,  350,  320,  350,
			  592,  592,  351,  351,  351,   97,  202,   97,  321,   97,

			  592,   97,  324,   97,  193,   97,  319,  592,  592,   97,
			   97,   97,  349,  349,  349,   97,  366,  592,  201,  592,
			  320,  352,  352,  352,  592,  592,  249,   97,  202,   97,
			  321,   97,   97,  592,  324,  353,  108,   97,  357,  357,
			  357,   97,   97,   97,  354,  367,  354,   97,  368,  355,
			  355,  355,  108,  369,  356,  356,  357,  359,  249,  360,
			  360,  360,  592,  370,   97,  111,  371,  353,  361,  361,
			  361,  372,  373,  374,  375,  377,  592,  367,  113,  378,
			  368,  379,  382,  380,  383,  369,  384,  385,  376,  386,
			  387,  388,  389,  390,  113,  370,  381,  111,  371,  257,

			  391,  392,  393,  372,  373,  374,  375,  377,  257,  394,
			  397,  378,  398,  379,  382,  380,  383,  399,  384,  385,
			  376,  386,  387,  388,  389,  390,  395,  400,  381,  396,
			  401,  403,  391,  392,  393,  404,  405,  406,  407,  408,
			  409,  394,  397,  410,  398,  411,  412,  413,  402,  399,
			  414,  415,  416,  416,  416,  315,  218,  315,  395,  400,
			  592,  396,  401,  403,  351,  351,  351,  404,  405,  406,
			  407,  408,  409,  199,  431,  410,   82,  411,  412,  413,
			  402,  417,  414,  418,  420,  199,   82,   82,   82,  422,
			  432,  592,   82,  423,  332,  332,  332,  424,  424,  424,

			  351,  351,  351,  426,  426,  426,  431,  592,  419,  202,
			  433,  249,  592,  421,  427,  592,  427,  353,  592,  428,
			  428,  428,  432,   97,  355,  355,  355,  355,  355,  355,
			  434,  435,  436,   97,   97,   97,  437,  425,  592,   97,
			  419,  202,  433,  249,  429,  421,  356,  356,  357,  353,
			  429,  438,  357,  357,  357,   97,  359,  111,  430,  430,
			  430,  439,  434,  435,  436,   97,   97,   97,  437,  440,
			  359,   97,  361,  361,  361,  441,  442,  443,  444,  445,
			  592,  446,  447,  438,  448,  449,  257,  450,  451,  111,
			  452,  453,  257,  439,  454,  455,  456,  457,  257,  592,

			  592,  440,  592,  461,  462,  463,  464,  441,  442,  443,
			  444,  445,  257,  446,  447,  465,  448,  449,  466,  450,
			  451,  467,  452,  453,  468,  469,  454,  455,  456,  457,
			  458,  458,  458,  470,  459,  461,  462,  463,  464,  471,
			  472,  473,  474,  475,  476,  460,  199,  465,  199,   82,
			  466,   82,  199,  467,  488,   82,  468,  469,  415,  477,
			  477,  477,  483,  483,  483,  470,  592,  424,  424,  424,
			  592,  471,  472,  473,  474,  475,  476,  484,  484,  484,
			  479,  482,  428,  428,  428,  592,  488,  480,  592,  478,
			  489,  353,  428,  428,  428,  490,   97,  487,   97,  361,

			  361,  361,   97,  493,  250,  491,  484,  484,  484,  492,
			  494,  495,  479,  482,  496,  497,  498,  485,  499,  480,
			  486,  478,  489,  353,  500,  501,  502,  490,   97,  503,
			   97,  504,  505,  506,   97,  493,  507,  491,  592,  113,
			  510,  492,  494,  495,  511,  512,  496,  497,  498,  513,
			  499,  514,  486,  515,  516,  517,  500,  501,  502,  518,
			  519,  503,  520,  504,  505,  506,  521,  522,  507,  458,
			  458,  458,  510,  508,  592,  199,  511,  512,   82,  199,
			  592,  513,   82,  514,  460,  515,  516,  517,  592,  592,
			  199,  518,  519,   82,  520,  526,  535,  526,  521,  522,

			  527,  527,  527,  528,  528,  528,  523,  524,  484,  484,
			  484,  531,  531,  531,  532,  592,  532,  529,  536,  533,
			  533,  533,  530,  537,  538,   97,  539,  540,  535,   97,
			  541,  250,  525,  531,  531,  531,  542,  543,  523,  524,
			   97,  544,  545,  546,  547,  548,  549,  534,  550,  529,
			  536,  551,  552,  553,  530,  537,  538,   97,  539,  540,
			  554,   97,  541,  555,  525,  592,  592,  199,  542,  543,
			   82,  592,   97,  544,  545,  546,  547,  548,  549,  534,
			  550,  568,  592,  551,  552,  553,  199,  199,  592,   82,
			   82,  592,  554,  592,  592,  555,  527,  527,  527,  527,

			  527,  527,  559,  559,  559,  560,  569,  560,  592,  557,
			  561,  561,  561,  568,  556,  558,  529,   97,  562,  570,
			  562,  571,  572,  563,  563,  563,  564,  564,  564,  533,
			  533,  533,  533,  533,  533,  573,   97,   97,  569,  574,
			  565,  557,  575,  576,  577,  578,  556,  558,  529,   97,
			  566,  570,  566,  571,  572,  567,  567,  567,  579,  580,
			  199,  582,  583,   82,   82,   82,  529,  573,   97,   97,
			  587,  574,  565,  592,  575,  576,  577,  578,  561,  561,
			  561,  561,  561,  561,  563,  563,  563,  563,  563,  563,
			  579,  580,  425,  584,  584,  584,  588,  581,  529,  585,

			  589,  585,  587,  590,  586,  586,  586,  565,  565,  592,
			   97,   97,   97,  567,  567,  567,  567,  567,  567,  591,
			  592,  592,   82,  586,  586,  586,  592,  592,  588,  581,
			  592,  592,  589,  592,  485,  590,  586,  586,  586,  565,
			  565,  592,   97,   97,   97,   98,  592,   98,  592,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  592,  164,   97,
			  164,  164,  164,  592,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,   82,  592,   82,  592,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,  255,  255,

			  255,   97,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   79,  592,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   99,  592,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,  189,  189,  189,  189,  189,  189,  189,  189,

			  189,  189,  189,  189,  189,  189,  189,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  195,  195,  195,  195,  195,  195,   81,  592,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,  222,  592,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,   11,  592,  592,

			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592, yy_Dummy>>)
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
			    1,    1,    3,    4,   38,    3,    4,  509,    3,    4,

			    5,    5,    5,  477,    5,    6,    6,    6,   46,    6,
			    9,    9,    9,   10,   10,   10,   13,   13,   13,   14,
			   14,   14,   19,   25,   19,   26,   38,   26,   26,   26,
			   27,   13,  460,   25,   14,   33,   33,   27,   48,   28,
			   46,   28,   28,   28,   29,   40,   29,   29,   29,   35,
			   35,   49,   28,   45,  423,   40,    5,   29,   51,   45,
			   52,    6,   30,  359,   30,   30,   30,   41,   51,   41,
			   48,  358,   67,   71,   28,   67,   71,   40,  255,   41,
			   54,   28,   55,   49,   28,   45,   29,   40,    5,   29,
			   51,   45,   52,    6,   16,   16,  245,   16,   16,   41,

			   51,   41,   16,   16,   30,   16,   28,   16,   53,  244,
			   50,   41,   54,   16,   55,   16,   37,   16,   16,  243,
			   39,   37,   53,   37,   39,   50,   16,   39,   37,   37,
			   39,   16,   16,   39,   42,   68,   68,   68,   42,   68,
			   53,   16,   50,  242,   16,   16,   82,   16,   37,  241,
			   16,   42,   39,   37,   53,   37,   39,   50,   16,   39,
			   37,   37,   39,   16,   16,   39,   42,   44,  102,   47,
			   42,  121,  123,   16,   44,   44,   16,   16,   82,   47,
			   44,   47,  102,   42,  240,   47,   75,   75,   75,   79,
			  239,   68,   79,   77,   77,   77,  247,   81,   81,   44,

			   81,   47,   81,  121,  123,   81,   44,   44,   77,  238,
			  247,   47,   44,   47,  113,  113,  113,   47,   66,   66,
			   66,  237,   66,   68,  124,   66,  236,   66,   66,   66,
			   83,   84,  235,   83,   84,   66,  125,   85,  234,   79,
			   85,   66,   86,   66,  126,   86,   66,   66,   66,   66,
			  233,   66,   81,   66,  113,   86,  124,   66,   87,   66,
			  232,   87,   66,   66,   66,   66,   66,   66,  125,  231,
			   88,   79,   89,   88,  127,   89,  126,  230,   87,   90,
			   83,   84,   90,   91,   81,   92,   91,   85,   92,  228,
			   88,  128,   86,   93,   95,  129,   93,   95,   96,  189,

			  130,   96,  189,   94,   94,   94,  127,   94,   87,   89,
			   94,  227,   83,   84,  131,   90,  105,  105,  105,   85,
			   88,   91,   89,  128,   86,  226,   92,  129,  134,   90,
			  105,   93,  130,   91,  108,   92,  108,  108,  108,  193,
			   87,   89,  193,   93,   95,   95,  131,   90,   96,  225,
			  108,  224,   88,   91,   89,  137,  195,   94,   92,   94,
			  134,   90,  105,   93,  132,   91,  122,   92,  132,  122,
			   97,   97,   97,  138,   97,   93,   95,   97,  135,  139,
			   96,  109,  108,  109,  109,  109,  141,  137,  110,   94,
			  110,  110,  110,  135,  109,  136,  132,  144,  122,  136,

			  132,  122,  142,  145,  142,  138,  142,  146,  147,  148,
			  135,  139,  149,  151,  154,  145,  155,  142,  141,  156,
			  142,  149,  158,  109,   97,  135,  109,  136,  164,  144,
			  110,  136,  101,  153,  142,  145,  142,  153,  142,  146,
			  147,  148,  159,   99,  149,  151,  154,  145,  155,  142,
			   78,  156,  142,  149,  158,  160,   97,  100,  161,   72,
			  100,   63,  100,  100,  100,  153,  166,  166,  166,  153,
			  100,   61,  258,  166,  159,  157,  100,   57,  100,  259,
			  157,  100,  100,  100,  100,   36,  100,  160,  100,   31,
			  161,  157,  100,  152,  100,  152,   11,  100,  100,  100,

			  100,  100,  100,  152,  258,  262,  152,  157,  152,  152,
			    8,  259,  157,  172,  172,  172,  192,  192,  192,  207,
			  192,  209,  207,  157,  209,  152,    7,  152,  197,  197,
			  197,  201,  201,  201,  201,  152,  201,  262,  152,  201,
			  152,  152,  202,  202,  202,  211,    0,  212,  211,  213,
			  212,  263,  213,    0,    0,  214,    0,  215,  214,  215,
			  219,  216,  215,  219,  216,  220,    0,    0,  220,  207,
			    0,  209,  192,    0,  212,  229,  229,  229,  217,  217,
			  217,    0,  217,  263,  265,  217,  201,  249,  213,  249,
			    0,    0,  249,  249,  249,  211,  202,  212,  214,  213,

			    0,  207,  216,  209,  192,  214,  212,    0,    0,  215,
			  219,  216,  248,  248,  248,  220,  265,    0,  201,    0,
			  213,  251,  251,  251,    0,    0,  248,  211,  202,  212,
			  214,  213,  217,    0,  216,  251,  254,  214,  254,  254,
			  254,  215,  219,  216,  252,  266,  252,  220,  267,  252,
			  252,  252,  253,  268,  253,  253,  253,  256,  248,  256,
			  256,  256,    0,  269,  217,  253,  270,  251,  257,  257,
			  257,  271,  272,  274,  275,  276,    0,  266,  254,  277,
			  267,  278,  280,  279,  281,  268,  282,  283,  275,  284,
			  285,  286,  287,  288,  253,  269,  279,  253,  270,  256,

			  289,  290,  292,  271,  272,  274,  275,  276,  257,  293,
			  295,  277,  296,  278,  280,  279,  281,  297,  282,  283,
			  275,  284,  285,  286,  287,  288,  294,  298,  279,  294,
			  299,  300,  289,  290,  292,  301,  302,  303,  304,  305,
			  306,  293,  295,  307,  296,  308,  309,  310,  299,  297,
			  311,  314,  314,  314,  314,  315,  315,  315,  294,  298,
			    0,  294,  299,  300,  350,  350,  350,  301,  302,  303,
			  304,  305,  306,  320,  362,  307,  320,  308,  309,  310,
			  299,  319,  311,  319,  321,  322,  319,  321,  322,  324,
			  363,    0,  324,  332,  332,  332,  332,  349,  349,  349,

			  351,  351,  351,  352,  352,  352,  362,    0,  320,  315,
			  364,  349,    0,  322,  353,    0,  353,  352,    0,  353,
			  353,  353,  363,  320,  354,  354,  354,  355,  355,  355,
			  365,  366,  367,  319,  321,  322,  368,  349,    0,  324,
			  320,  315,  364,  349,  356,  322,  356,  356,  356,  352,
			  357,  369,  357,  357,  357,  320,  360,  356,  360,  360,
			  360,  370,  365,  366,  367,  319,  321,  322,  368,  371,
			  361,  324,  361,  361,  361,  372,  373,  374,  375,  376,
			    0,  377,  378,  369,  379,  381,  356,  382,  383,  356,
			  384,  385,  357,  370,  386,  387,  389,  392,  360,    0,

			    0,  371,    0,  395,  396,  397,  398,  372,  373,  374,
			  375,  376,  361,  377,  378,  399,  379,  381,  400,  382,
			  383,  401,  384,  385,  402,  403,  386,  387,  389,  392,
			  393,  393,  393,  404,  393,  395,  396,  397,  398,  405,
			  406,  409,  410,  411,  412,  393,  417,  399,  419,  417,
			  400,  419,  421,  401,  433,  421,  402,  403,  416,  416,
			  416,  416,  425,  425,  425,  404,    0,  424,  424,  424,
			    0,  405,  406,  409,  410,  411,  412,  426,  426,  426,
			  419,  424,  427,  427,  427,    0,  433,  421,    0,  417,
			  434,  426,  428,  428,  428,  437,  417,  430,  419,  430,

			  430,  430,  421,  439,  429,  438,  429,  429,  429,  438,
			  441,  442,  419,  424,  443,  444,  445,  426,  446,  421,
			  429,  417,  434,  426,  448,  449,  450,  437,  417,  451,
			  419,  453,  454,  455,  421,  439,  457,  438,    0,  430,
			  461,  438,  441,  442,  462,  463,  443,  444,  445,  464,
			  446,  465,  429,  466,  467,  468,  448,  449,  450,  470,
			  471,  451,  473,  453,  454,  455,  474,  476,  457,  458,
			  458,  458,  461,  458,    0,  478,  462,  463,  478,  479,
			    0,  464,  479,  465,  458,  466,  467,  468,    0,    0,
			  480,  470,  471,  480,  473,  482,  489,  482,  474,  476,

			  482,  482,  482,  483,  483,  483,  478,  479,  484,  484,
			  484,  485,  485,  485,  486,    0,  486,  483,  490,  486,
			  486,  486,  484,  492,  493,  478,  494,  497,  489,  479,
			  499,  487,  480,  487,  487,  487,  500,  502,  478,  479,
			  480,  503,  504,  505,  506,  507,  510,  487,  512,  483,
			  490,  513,  515,  519,  484,  492,  493,  478,  494,  497,
			  520,  479,  499,  522,  480,    0,    0,  524,  500,  502,
			  524,    0,  480,  503,  504,  505,  506,  507,  510,  487,
			  512,  535,    0,  513,  515,  519,  523,  525,    0,  523,
			  525,    0,  520,    0,    0,  522,  526,  526,  526,  527,

			  527,  527,  528,  528,  528,  529,  537,  529,    0,  524,
			  529,  529,  529,  535,  523,  525,  528,  524,  530,  539,
			  530,  540,  541,  530,  530,  530,  531,  531,  531,  532,
			  532,  532,  533,  533,  533,  544,  523,  525,  537,  547,
			  531,  524,  548,  549,  550,  551,  523,  525,  528,  524,
			  534,  539,  534,  540,  541,  534,  534,  534,  553,  554,
			  556,  557,  558,  556,  557,  558,  559,  544,  523,  525,
			  568,  547,  531,    0,  548,  549,  550,  551,  560,  560,
			  560,  561,  561,  561,  562,  562,  562,  563,  563,  563,
			  553,  554,  559,  564,  564,  564,  574,  556,  559,  565,

			  576,  565,  568,  578,  565,  565,  565,  564,  584,    0,
			  556,  557,  558,  566,  566,  566,  567,  567,  567,  581,
			    0,    0,  581,  585,  585,  585,    0,    0,  574,  556,
			    0,    0,  576,    0,  584,  578,  586,  586,  586,  564,
			  584,    0,  556,  557,  558,  598,    0,  598,    0,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,    0,  601,  581,
			  601,  601,  601,    0,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  606,    0,  606,    0,  606,  606,  606,
			  606,  606,  606,  606,  606,  606,  606,  606,  609,  609,

			  609,  581,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  595,  595,  595,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  595,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  597,    0,  597,  597,  597,  597,  597,  597,
			  597,  597,  597,  597,  597,  597,  597,  599,    0,  599,
			  599,  599,  599,  599,  599,  599,  599,  599,  599,  599,
			  599,  599,  602,  602,  602,  602,  602,  602,  602,  602,

			  602,  602,  602,  602,  602,  602,  602,  603,  603,  603,
			  603,  603,  603,  603,  603,  603,  603,  603,  603,  603,
			  603,  603,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  605,    0,  605,
			  605,  605,  605,  605,  605,  605,  605,  605,  605,  605,
			  605,  605,  607,    0,  607,  607,  607,  607,  607,  607,
			  607,  607,  607,  607,  607,  607,  607,  608,  608,  608,
			  608,  608,  608,  608,  608,  608,  608,  608,  608,  608,
			  608,  608,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  592,  592,  592,

			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  623,  607,  108,
			  111,  596, 1697,  114,  117, 1697,  188,    0, 1697,  113,
			 1697, 1697, 1697, 1697, 1697,  106,  107,  111,  121,  126,
			  144,  563, 1697,  110, 1697,  123,  559,  180,   56,  183,
			  111,  126,  204,    0,  232,  115,   64,  238,   91,  117,
			  176,  121,  117,  178,  143,  138, 1697,  520, 1697, 1697,
			 1697,  480, 1697,  555, 1697, 1697,  316,  169,  233, 1697,
			 1697,  170,  556, 1697, 1697,  284, 1697,  291,  533,  283,
			 1697,  296,  190,  324,  325,  331,  336,  352,  364,  366,
			  373,  377,  379,  387,  401,  388,  392,  468,    0,  532,

			  551,  521,  265, 1697, 1697,  396, 1697, 1697,  416,  463,
			  470, 1697,    0,  294, 1697, 1697, 1697, 1697, 1697, 1697,
			    0,  237,  428,  239,  276,  287,  295,  340,  361,  352,
			  366,  367,  433,    0,  380,  445,  450,  414,  443,  435,
			    0,  441,  469,    0,  457,  471,  458,  460,  476,  480,
			    0,  479,  560,  492,  467,  482,  469,  542,  475,  504,
			  521,  511, 1697, 1697,  522, 1697,  564, 1697, 1697, 1697,
			 1697, 1697,  593, 1697, 1697, 1697, 1697, 1697, 1697, 1697,
			 1697, 1697, 1697, 1697, 1697, 1697, 1697, 1697, 1697,  396,
			 1697, 1697,  614,  436, 1697,  453, 1697,  626, 1697, 1697,

			 1697,  630,  640, 1697, 1697, 1697, 1697,  613, 1697,  615,
			 1697,  639,  641,  643,  649,  653,  655,  676, 1697,  654,
			  659, 1697, 1697, 1697,  440,  438,  414,  400,  378,  655,
			  366,  358,  349,  339,  327,  321,  315,  310,  298,  279,
			  273,  238,  232,  208,  198,  185, 1697,  293,  692,  672,
			 1697,  701,  729,  734,  718,  118,  739,  748,  529,  549,
			    0,    0,  567,  604,    0,  652,  697,  697,  723,  716,
			  716,  737,  738,    0,  723,  744,  741,  731,  732,  741,
			  741,  750,  748,  753,  744,  760,  757,  762,  748,  766,
			  757,    0,  768,  755,  794,  776,  778,  787,  777,  798,

			  784,  801,  806,  799,  795,  805,  806,  797,  807,  808,
			  814,  807,    0, 1697,  832,  853, 1697, 1697, 1697,  877,
			  867,  878,  879, 1697,  883, 1697, 1697, 1697, 1697, 1697,
			 1697, 1697,  874, 1697, 1697, 1697, 1697, 1697, 1697, 1697,
			 1697, 1697, 1697, 1697, 1697, 1697, 1697, 1697, 1697,  877,
			  844,  880,  883,  899,  904,  907,  926,  932,  111,  145,
			  938,  952,  825,  842,  874,  892,  891,  884,  902,  902,
			  927,  933,  928,  938,  930,  935,  932,  934,  948,  934,
			    0,  951,  949,  935,  937,  944,  960,  948,    0,  955,
			    0,    0,  956, 1028,    0,  953,  966,  970,  959,  973,

			  980,  971,  983,  971, 1001,  992,  995,    0,    0, 1006,
			  992, 1002, 1014,    0,    0, 1697, 1039, 1040, 1697, 1042,
			 1697, 1046, 1697,  143, 1047, 1042, 1057, 1062, 1072, 1086,
			 1079,    0,    0, 1011, 1059,    0,    0, 1048, 1071, 1060,
			    0, 1063, 1076, 1080, 1082, 1067, 1075,    0, 1077, 1082,
			 1092, 1091,    0, 1093, 1100, 1095,    0, 1102, 1167, 1697,
			  115, 1093, 1091, 1107, 1115, 1117, 1106, 1120, 1106,    0,
			 1110, 1130,    0, 1124, 1132,    0, 1124,   84, 1169, 1173,
			 1184, 1697, 1180, 1183, 1188, 1191, 1199, 1213,    0, 1146,
			 1169,    0, 1179, 1175, 1192,    0,    0, 1193,    0, 1200,

			 1202,    0, 1189, 1198, 1193, 1194, 1214, 1196, 1697,   94,
			 1198,    0, 1205, 1208,    0, 1218,    0,    0,    0, 1204,
			 1217,    0, 1214, 1280, 1261, 1281, 1276, 1279, 1282, 1290,
			 1303, 1306, 1309, 1312, 1335, 1232,    0, 1263,    0, 1286,
			 1288, 1281,    0,    0, 1299,    0,    0, 1296, 1308, 1299,
			 1310, 1313,    0, 1324, 1325,    0, 1354, 1355, 1356, 1332,
			 1358, 1361, 1364, 1367, 1373, 1384, 1393, 1396, 1336,    0,
			    0,    0,    0,    0, 1347,    0, 1353,    0, 1369,    0,
			    0, 1413, 1697, 1697, 1374, 1403, 1416,    0,    0,    0,
			    0, 1697, 1697, 1501, 1516, 1531, 1546, 1561, 1442, 1576,

			 1451, 1467, 1591, 1606, 1621, 1636, 1482, 1651, 1666, 1491,
			 1681, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  592,    1,  593,  593,  594,  594,  595,  595,  596,
			  596,  592,  592,  592,  592,  592,  597,  598,  592,  599,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  592,  592,  592,  592,
			  592,  592,  592,  601,  592,  592,  592,  602,  602,  592,
			  592,  603,  604,  592,  592,  592,  592,  592,  592,  597,
			  592,  605,  606,  597,  597,  597,  597,  597,  597,  597,
			  597,  597,  597,  597,  597,  597,  597,  597,  598,  607,

			  607,  607,  608,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  609,  592,  592,  592,  592,  592,  592,  592,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  592,  592,  601,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  602,
			  592,  592,  602,  603,  592,  604,  592,  592,  592,  592,

			  592,  605,  606,  592,  592,  592,  592,  597,  592,  597,
			  592,  597,  597,  597,  597,  597,  597,  597,  592,  597,
			  597,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  608,  592,  592,
			  592,  592,  592,  592,  592,  609,  592,  592,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,

			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  592,  592,  606,  592,  592,  592,  597,
			  597,  597,  597,  592,  597,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  609,  592,
			  592,  592,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,

			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  592,  592,  597,  592,  597,
			  592,  597,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  592,  592,
			  592,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  592,  597,  597,
			  597,  592,  592,  592,  592,  592,  592,  592,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,

			  600,  600,  600,  600,  600,  600,  600,  600,  592,  610,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  597,  597,  597,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  597,  597,  597,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  597,  592,  592,  592,  592,  592,  600,  600,  600,
			  600,  592,    0,  592,  592,  592,  592,  592,  592,  592,

			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592, yy_Dummy>>)
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
			  270,  271,  272,  273,  274,  275,  276,  276,  277,  278,
			  279,  280,  281,  281,  282,  283,  284,  285,  286,  287,
			  288,  289,  290,  291,  292,  293,  294,  295,  296,  297,
			  298,  299,  300,  301,  302,  304,  305,  306,  306,  307,

			  308,  310,  312,  313,  315,  317,  319,  321,  322,  324,
			  325,  327,  328,  329,  330,  331,  332,  333,  334,  335,
			  336,  337,  339,  340,  342,  343,  344,  345,  346,  347,
			  348,  349,  350,  351,  352,  353,  354,  355,  356,  357,
			  358,  359,  360,  361,  362,  363,  364,  366,  367,  368,
			  368,  369,  370,  370,  371,  372,  373,  374,  374,  375,
			  376,  378,  380,  381,  382,  384,  385,  386,  387,  388,
			  389,  390,  391,  392,  394,  395,  396,  397,  398,  399,
			  400,  401,  402,  403,  404,  405,  406,  407,  408,  409,
			  411,  412,  414,  415,  416,  417,  418,  419,  420,  421,

			  422,  423,  424,  425,  426,  427,  428,  429,  430,  431,
			  432,  433,  434,  436,  437,  437,  437,  439,  441,  443,
			  444,  445,  446,  447,  449,  450,  452,  454,  455,  456,
			  457,  458,  459,  460,  461,  462,  463,  464,  465,  466,
			  467,  468,  469,  470,  471,  472,  473,  474,  475,  476,
			  477,  477,  478,  479,  479,  479,  480,  481,  482,  482,
			  482,  483,  484,  485,  486,  487,  488,  489,  490,  491,
			  492,  493,  494,  495,  497,  498,  499,  500,  501,  502,
			  503,  505,  506,  507,  508,  509,  510,  511,  512,  514,
			  515,  517,  519,  520,  522,  524,  525,  526,  527,  528,

			  529,  530,  531,  532,  533,  534,  535,  536,  538,  540,
			  541,  542,  543,  544,  546,  548,  549,  549,  550,  552,
			  553,  555,  556,  558,  559,  560,  560,  561,  561,  562,
			  563,  564,  566,  568,  569,  570,  572,  574,  575,  576,
			  577,  579,  580,  581,  582,  583,  584,  585,  587,  588,
			  589,  590,  591,  593,  594,  595,  596,  598,  599,  599,
			  600,  600,  601,  602,  603,  604,  605,  606,  607,  608,
			  610,  611,  612,  614,  615,  616,  618,  619,  619,  620,
			  621,  622,  623,  623,  624,  625,  625,  625,  626,  628,
			  629,  630,  632,  633,  634,  635,  637,  639,  640,  642,

			  643,  644,  646,  647,  648,  649,  650,  651,  652,  653,
			  653,  654,  656,  657,  658,  660,  661,  663,  665,  667,
			  668,  669,  671,  672,  673,  674,  675,  675,  676,  677,
			  677,  677,  678,  678,  679,  679,  680,  682,  683,  685,
			  686,  687,  688,  690,  692,  693,  695,  697,  698,  699,
			  700,  701,  702,  704,  705,  706,  708,  709,  710,  711,
			  712,  712,  713,  713,  714,  715,  715,  715,  716,  717,
			  719,  721,  723,  725,  727,  728,  730,  731,  733,  734,
			  736,  738,  739,  741,  743,  744,  744,  745,  747,  749,
			  751,  753,  755,  755, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  166,  166,  168,  168,  199,  197,  198,    1,  197,
			  198,    1,  198,   31,  197,  198,  169,  197,  198,   36,
			  197,  198,   10,  197,  198,  136,  197,  198,   19,  197,
			  198,   20,  197,  198,   27,  197,  198,   25,  197,  198,
			    4,  197,  198,   26,  197,  198,    9,  197,  198,   28,
			  197,  198,  108,  197,  198,  108,  197,  198,  108,  197,
			  198,    3,  197,  198,    2,  197,  198,   14,  197,  198,
			   13,  197,  198,   15,  197,  198,    6,  197,  198,  106,
			  197,  198,  106,  197,  198,  106,  197,  198,  106,  197,
			  198,  106,  197,  198,  106,  197,  198,  106,  197,  198,

			  106,  197,  198,  106,  197,  198,  106,  197,  198,  106,
			  197,  198,  106,  197,  198,  106,  197,  198,  106,  197,
			  198,  106,  197,  198,  106,  197,  198,  106,  197,  198,
			  106,  197,  198,  106,  197,  198,   23,  197,  198,  197,
			  198,   24,  197,  198,   29,  197,  198,   21,  197,  198,
			   22,  197,  198,    7,  197,  198,  170,  198,  196,  198,
			  194,  198,  195,  198,  166,  198,  166,  198,  165,  198,
			  164,  198,  166,  198,  168,  198,  167,  198,  162,  198,
			  162,  198,  161,  198,    1,  169,  158,  169,  169,  169,
			  169,  169,  169,  169,  169,  169,  169,  169,  169,  169,

			 -358,  169,  169,  169, -358,   36,  136,  136,  136,    1,
			   30,    5,  111,   34,   18,  111,  108,  108,  107,   11,
			   32,   16,   17,   33,   12,  106,  106,  106,  106,   41,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,   53,
			  106,  106,  106,  106,  106,  106,  106,   65,  106,  106,
			  106,   72,  106,  106,  106,  106,  106,  106,  106,   84,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   35,    8,  170,  194,  187,  185,  186,  188,
			  189,  190,  191,  171,  172,  173,  174,  175,  176,  177,
			  178,  179,  180,  181,  182,  183,  184,  166,  165,  164,

			  166,  166,  163,  164,  168,  167,  161,  159,  157,  159,
			  169, -358, -358,  144,  159,  142,  159,  143,  159,  145,
			  159,  169,  138,  159,  169,  139,  159,  169,  169,  169,
			  169,  169,  169,  169, -160,  169,  169,  146,  159,  136,
			  112,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  113,  136,    1,  111,  109,  111,
			  108,  108,  110,  108,  106,  106,   39,  106,   40,  106,
			  106,  106,   44,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,   56,  106,  106,  106,  106,  106,  106,  106,

			  106,  106,  106,  106,  106,  106,  106,  106,  106,   76,
			  106,  106,   79,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  105,  106,  193,  147,  159,  140,
			  159,  141,  159,  169,  169,  169,  169,  154,  159,  169,
			  149,  159,  148,  159,  130,  128,  129,  131,  132,  137,
			  133,  134,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  111,  111,  111,  111,
			  108,  108,  108,  108,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,   54,  106,  106,  106,  106,

			  106,  106,  106,   63,  106,  106,  106,  106,  106,  106,
			  106,  106,   73,  106,  106,   75,  106,   77,  106,  106,
			   82,  106,   83,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,   97,  106,   98,  106,
			  106,  106,  106,  106,  103,  106,  104,  106,  192,  169,
			  150,  159,  169,  153,  159,  169,  156,  159,  137,  111,
			  111,  111,  111,  108,   37,  106,   38,  106,  106,  106,
			   45,  106,   46,  106,  106,  106,  106,   51,  106,  106,
			  106,  106,  106,  106,  106,   61,  106,  106,  106,  106,
			  106,   68,  106,  106,  106,  106,   74,  106,  106,   80,

			  106,  106,  106,  106,  106,  106,  106,  106,   93,  106,
			  106,  106,   96,  106,  106,  106,  101,  106,  106,  169,
			  169,  169,  135,  111,  111,  111,   42,  106,  106,  106,
			   48,  106,  106,  106,  106,   55,  106,   57,  106,  106,
			   59,  106,  106,  106,   64,  106,  106,  106,  106,  106,
			  106,  106,   81,  106,   86,  106,  106,  106,   89,  106,
			  106,   91,  106,   92,  106,   94,  106,  106,  106,  100,
			  106,  106,  169,  169,  169,  111,  111,  111,  111,  106,
			   47,  106,  106,   50,  106,  106,  106,  106,   62,  106,
			   66,  106,  106,   69,  106,   70,  106,  106,  106,  106,

			  106,  106,   90,  106,  106,  106,  102,  106,  169,  169,
			  169,  111,  111,  111,  111,  111,  106,   49,  106,   52,
			  106,   58,  106,   60,  106,   67,  106,  106,   78,  106,
			  106,   87,  106,  106,   95,  106,   99,  106,  169,  152,
			  159,  155,  159,  111,  111,   43,  106,   71,  106,   85,
			  106,   88,  106,  151,  159, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1697
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 592
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 593
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

	yyNb_rules: INTEGER is 198
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 199
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
