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
 ast_factory.create_break_as (Current) 
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
				
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION				
			
when 50 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 250 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 250")
end
				
				last_current_as_value := ast_factory.new_current_as (Current)
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
				
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
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
				
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
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
				
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
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
				
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
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
				
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
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
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
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
				
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			
when 86 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 419 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 419")
end
				
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
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
					
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			
when 93 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 447 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 447")
end
				
				last_retry_as_value := ast_factory.new_retry_as (Current)
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
				
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			
when 99 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 471 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 471")
end

				last_token := TE_TUPLE
				process_id_as
			
when 100 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 475 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 475")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 479 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 479")
end
				
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 483 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 483")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			
when 103 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 487 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 487")
end
			
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 491 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 491")
end
				
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			
when 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 495 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 495")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			
when 106 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 499 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 499")
end
				
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
				last_token := TE_XOR
			
when 107 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 507 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 507")
end

				last_token := TE_ID
				process_id_as
			
when 108 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 514 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 514")
end

				last_token := TE_A_BIT			
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)
			
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 522 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 522")
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
	yy_end := yy_end - 2
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 523 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 523")
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
			
when 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 535 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 535")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)				
				last_token := TE_INTEGER
			
when 112 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 543 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 543")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end				
				last_token := TE_REAL
			
when 113 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 555 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 555")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 114 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 561 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 561")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 115 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 568 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 568")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 116 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 574 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 574")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 117 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 580 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 580")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 586 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 586")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 592 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 592")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 598 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 598")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 604 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 604")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 610 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 610")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 616 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 616")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 622 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 622")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 628 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 628")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 634 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 634")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 640 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 640")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 646 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 646")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR				
				ast_factory.set_buffer (token_buffer2, Current)
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 652 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 652")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 658 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 658")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 664 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 664")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 670 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 670")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 676 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 676")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 682 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 682")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 688 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 688")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
				ast_factory.set_buffer (token_buffer2, Current)
			
when 136 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 694 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 694")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 137 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 697 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 697")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 138 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 698 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 698")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 139 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 707 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 707")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LT
			
when 140 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 711 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 711")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GT
			
when 141 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 715 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 715")
end
				
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_LE
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 719 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 719")
end
			
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_GE
			
when 143 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 723 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 723")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_PLUS
			
when 144 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 727 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 727")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MINUS
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 731 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 731")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_STAR
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 735 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 735")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_SLASH
			
when 147 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 739 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 739")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_POWER
			
when 148 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_DIV
			
when 149 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 747 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 747")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_MOD
			
when 150 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 751 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 751")
end

				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_BRACKET
			
when 151 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 755 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 755")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND
			
when 152 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 761 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 761")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_AND_THEN
			
when 153 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 767 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 767")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_IMPLIES
			
when 154 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 773 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 773")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_NOT
			
when 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 779 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 779")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR
			
when 156 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 785 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 785")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_OR_ELSE
			
when 157 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 791 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 791")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_XOR
			
when 158 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 797 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 797")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				ast_factory.set_buffer (token_buffer2, Current)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 159 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 806 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 806")
end

					-- Empty string.
				ast_factory.set_buffer (token_buffer2, Current)
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 812 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 812")
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
			
when 161 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 823 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 823")
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
			
when 162 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (VERBATIM_STR1)
			
when 163 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 845 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 845")
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
			
when 164 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 865 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 865")
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
			
when 165 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 908 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 908")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 166 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 913 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 913")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 167 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 921 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 921")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 168 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 937 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 937")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 169 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 946 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 946")
end

					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 959 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 959")
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
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 971 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 971")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				append_text_to_string (token_buffer)
			
when 172 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 975 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 975")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%A")
				token_buffer.append_character ('%A')
			
when 173 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 979 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 979")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%B")
				token_buffer.append_character ('%B')
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 983 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 983")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%C")
				token_buffer.append_character ('%C')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 987 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 987")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%D")
				token_buffer.append_character ('%D')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 991 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 991")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%F")
				token_buffer.append_character ('%F')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 995 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 995")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%H")
				token_buffer.append_character ('%H')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 999 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 999")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%L")
				token_buffer.append_character ('%L')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1003 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1003")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%N")
				token_buffer.append_character ('%N')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1007 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1007")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%Q")
				token_buffer.append_character ('%Q')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1011 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1011")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%R")
				token_buffer.append_character ('%R')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1015 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1015")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%S")
				token_buffer.append_character ('%S')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1019 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1019")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%T")
				token_buffer.append_character ('%T')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1023 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1023")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%U")
				token_buffer.append_character ('%U')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1027 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1027")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%V")
				token_buffer.append_character ('%V')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1031 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1031")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%%")
				token_buffer.append_character ('%%')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1035 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1035")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%'")
				token_buffer.append_character ('%'')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1039 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1039")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%%"")
				token_buffer.append_character ('%"')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1043 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1043")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%(")
				token_buffer.append_character ('%(')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1047 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1047")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%)")
				token_buffer.append_character ('%)')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1051 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1051")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%<")
				token_buffer.append_character ('%<')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 1055 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1055")
end

				ast_factory.append_string_to_buffer (token_buffer2, "%%>")
				token_buffer.append_character ('%>')
			
when 193 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1059 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1059")
end

				ast_factory.append_text_to_buffer (token_buffer2, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 194 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1063 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1063")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (token_buffer2, Current)
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 1068 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1068")
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
			
when 196 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1084 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1084")
end

					-- Bad special character.
				ast_factory.append_text_to_buffer (token_buffer2, Current)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 197 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 1090 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1090")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 198 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 1108 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1108")
end

				report_unknown_token_error (text_item (1))
			
when 199 then
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
			   61,   62,   64,   64,  126,   65,   65,  461,   66,   66,

			   68,   69,   68,  418,   70,   68,   69,   68,  146,   70,
			   75,   76,   75,   75,   76,   75,   77,   77,   77,   77,
			   77,   77,  100,  102,  101,  104,  126,  105,  105,  105,
			  106,   78,  513,  103,   78,  115,  116,  107,  151,  108,
			  146,  109,  109,  110,  108,  132,  109,  109,  110,  117,
			  118,  152,  111,  144,  485,  133,   71,  111,  158,  145,
			  161,   71,  108,  251,  110,  110,  110,  134,  159,  135,
			  151,  360,  191,  360,  112,  192,  162,  132,  350,  136,
			  349,  113,  160,  152,  111,  144,  113,  133,   71,  111,
			  158,  145,  161,   71,   80,   81,  348,   82,   81,  134,

			  159,  135,   83,   84,  113,   85,  112,   86,  162,  191,
			  153,  136,  195,   87,  160,   88,  121,   81,   89,  347,
			  127,  122,  203,  123,  128,  154,   90,  129,  124,  125,
			  130,   91,   92,  131,  137,  198,  199,  198,  138,  259,
			  200,   93,  153,   82,   94,   95,  191,   96,  121,  192,
			   89,  139,  127,  122,  203,  123,  128,  154,   90,  129,
			  124,  125,  130,   91,   92,  131,  137,  140,   77,  147,
			  138,  259,   77,   93,  141,  142,   97,   81,  155,  148,
			  143,  149,  248,  139,  191,  150,  248,  195,  156,  262,
			   97,  157,  193,  191,  193,  346,  192,  345,  344,  140,

			  343,  147,  342,   77,   77,   77,  141,  142,  341,  340,
			  155,  148,  143,  149,  339,  338,  204,  150,   78,   82,
			  156,  262,   97,  157,  167,  167,  167,  205,  168,  206,
			   82,  169,   82,  170,  171,  172,  337,   79,   79,  336,
			   79,  173,  201,  207,  263,   82,   82,  174,  194,  175,
			  335,  264,  176,  177,  178,  179,  208,  180,  209,  181,
			  333,   82,  332,  182,  211,  183,   97,   82,  184,  185,
			  186,  187,  188,  189,  265,  331,  263,   97,  210,   97,
			  194,  266,  200,  264,  212,   82,  200,  200,  200,   82,
			   82,   82,  202,   97,  257,  257,  257,  200,   97,  200,

			   82,  267,   82,  218,  219,  218,  265,  200,   97,   97,
			   82,   97,  222,  266,   97,   82,  316,  316,  316,  213,
			  260,  268,  214,  261,  202,   97,  215,  330,  216,  269,
			  329,  270,   97,  267,  258,  217,   97,   97,   97,  197,
			   97,  218,  219,  218,  166,  200,   97,   97,   82,   97,
			  221,  213,  260,  268,  214,  261,  247,   97,  215,  220,
			  216,  269,   97,  270,   97,  224,  102,  217,   97,   97,
			   97,  249,  249,  249,  251,  273,  252,  252,  252,   97,
			  278,   97,  197,  279,  108,  250,  254,  254,  255,   97,
			  253,  280,  281,  287,   97,   97,  108,  111,  255,  255,

			  255,  198,  199,  198,  271,  290,  166,  273,  272,  164,
			  276,  291,  278,  163,  277,  279,  292,  250,  295,  304,
			  119,  114,  253,  280,  281,  287,  113,   97,  225,  111,
			  274,  226,  305,  227,  228,  229,  271,  290,  113,  596,
			  272,  230,  276,  291,   73,  275,  277,  231,  292,  232,
			  295,  304,  233,  234,  235,  236,  306,  237,   73,  238,
			  596,  596,  274,  239,  305,  240,  293,  288,  241,  242,
			  243,  244,  245,  246,  282,  294,  283,  275,  284,  289,
			  296,  302,  297,  307,  311,  303,  308,  312,  306,  285,
			  298,  309,  286,  299,  313,  300,  301,  314,  293,  288,

			  596,  596,  310,  317,  219,  317,  282,  294,  283,  364,
			  284,  289,  296,  302,  297,  307,  311,  303,  308,  312,
			  596,  285,  298,  309,  286,  299,  313,  300,  301,  314,
			  167,  167,  167,  318,  310,  365,   82,  315,  193,  191,
			  193,  364,  192,   79,  218,  219,  218,  319,  201,  320,
			   82,   82,   82,  200,  596,  366,   82,  203,  324,  200,
			  325,  200,   82,   82,   82,  596,  200,  365,  596,   82,
			  218,  219,  218,  327,  200,  328,   82,   82,   82,  596,
			  321,  367,  368,   97,  334,  334,  334,  366,  596,  203,
			  351,  351,  351,  596,  194,  369,  370,   97,  202,   97,

			  322,  596,  323,   97,  250,  371,  372,  326,  373,   97,
			   97,   97,  321,  367,  368,   97,   97,  596,  596,  354,
			  354,  354,  596,   97,   97,   97,  194,  369,  370,   97,
			  202,   97,  322,  355,  323,   97,  250,  371,  372,  326,
			  373,   97,   97,   97,  352,  596,  352,  374,   97,  353,
			  353,  353,  363,  363,  363,   97,   97,   97,  375,  376,
			  596,  356,  379,  356,  380,  355,  357,  357,  357,  108,
			  381,  358,  358,  359,  108,  377,  359,  359,  359,  374,
			  382,  361,  111,  362,  362,  362,  384,  385,  386,  378,
			  375,  376,  258,  383,  379,  387,  380,  388,  389,  390,

			  391,  392,  381,  393,  394,  395,  396,  377,  399,  400,
			  397,  113,  382,  398,  111,  401,  113,  402,  384,  385,
			  386,  378,  405,  258,  406,  383,  403,  387,  407,  388,
			  389,  390,  391,  392,  408,  393,  394,  395,  396,  409,
			  399,  400,  397,  410,  404,  398,  411,  401,  412,  402,
			  413,  414,  415,  416,  405,  417,  406,  596,  403,  596,
			  407,  418,  419,  419,  419,  596,  408,  317,  219,  317,
			  200,  409,  420,   82,  421,  410,  404,   82,  411,  596,
			  412,  596,  413,  414,  415,  416,  423,  417,  200,   82,
			  425,   82,  596,   82,  426,  334,  334,  334,  596,  427,

			  427,  427,  353,  353,  353,  422,  353,  353,  353,  429,
			  429,  429,  430,  250,  430,  596,  424,  431,  431,  431,
			   97,  203,  434,  355,   97,  357,  357,  357,  357,  357,
			  357,  432,  596,  358,  358,  359,   97,  422,   97,  428,
			   97,  596,  435,  436,  111,  250,  437,  432,  424,  359,
			  359,  359,   97,  203,  434,  355,   97,  361,  438,  433,
			  433,  433,  361,  439,  363,  363,  363,  596,   97,  440,
			   97,  441,   97,  258,  435,  436,  111,  442,  437,  443,
			  444,  445,  446,  447,  448,  449,  450,  451,  452,  258,
			  438,  453,  454,  455,  456,  439,  457,  458,  459,  258,

			  460,  440,  464,  441,  258,  465,  461,  461,  461,  442,
			  462,  443,  444,  445,  446,  447,  448,  449,  450,  451,
			  452,  463,  466,  453,  454,  455,  456,  467,  457,  458,
			  459,  468,  460,  469,  464,  470,  471,  465,  472,  473,
			  474,  475,  476,  477,  478,  479,  480,  418,  481,  481,
			  481,  596,  200,  200,  466,   82,   82,  200,  596,  467,
			   82,  596,  492,  468,  596,  469,  596,  470,  471,  493,
			  472,  473,  474,  475,  476,  477,  478,  479,  480,  427,
			  427,  427,  487,  487,  487,  483,  488,  488,  488,  431,
			  431,  431,  484,  486,  492,  482,  431,  431,  431,  494,

			  355,  493,   97,   97,  497,  498,  251,   97,  488,  488,
			  488,  491,  495,  363,  363,  363,  496,  483,  499,  500,
			  501,  596,  490,  502,  484,  486,  489,  482,  503,  504,
			  505,  494,  355,  506,   97,   97,  497,  498,  507,   97,
			  508,  509,  510,  511,  495,  514,  515,  516,  496,  517,
			  499,  500,  501,  113,  490,  502,  518,  519,  520,  521,
			  503,  504,  505,  522,  523,  506,  524,  461,  461,  461,
			  507,  512,  508,  509,  510,  511,  525,  514,  515,  516,
			  526,  517,  463,  200,  200,  596,   82,   82,  518,  519,
			  520,  521,  539,  596,  200,  522,  523,   82,  524,  530,

			  596,  530,  596,  596,  531,  531,  531,  596,  525,  532,
			  532,  532,  526,  540,  527,  488,  488,  488,  535,  535,
			  535,  541,  528,  533,  539,  536,  529,  536,  542,  534,
			  537,  537,  537,   97,   97,  251,  543,  535,  535,  535,
			  544,  545,  546,  547,   97,  540,  527,  548,  549,  550,
			  551,  538,  552,  541,  528,  533,  553,  554,  529,  555,
			  542,  534,  556,  557,  558,   97,   97,  559,  543,  531,
			  531,  531,  544,  545,  546,  547,   97,  596,  572,  548,
			  549,  550,  551,  538,  552,  596,  596,  200,  553,  554,
			   82,  555,  573,  596,  556,  557,  558,  596,  200,  559,

			  200,   82,  596,   82,  531,  531,  531,  563,  563,  563,
			  572,  564,  596,  564,  596,  560,  565,  565,  565,  596,
			  566,  533,  566,  596,  573,  567,  567,  567,  562,  568,
			  568,  568,  537,  537,  537,  574,  575,   97,  576,  577,
			  561,  578,  579,  569,  537,  537,  537,  560,   97,  570,
			   97,  570,  580,  533,  571,  571,  571,  581,  582,  583,
			  562,  584,  200,  586,  596,   82,   82,  574,  575,   97,
			  576,  577,  561,  578,  579,  569,  587,  533,  591,   82,
			   97,  596,   97,  596,  580,  565,  565,  565,  592,  581,
			  582,  583,  596,  584,  565,  565,  565,  593,  594,  585,

			  567,  567,  567,  428,  567,  567,  567,  596,  596,  533,
			  591,  596,   97,   97,  588,  588,  588,  589,  595,  589,
			  592,   82,  590,  590,  590,  569,   97,  596,  569,  593,
			  594,  585,  571,  571,  571,  571,  571,  571,  590,  590,
			  590,  590,  590,  590,   97,   97,  256,  256,  256,  596,
			  596,  489,  596,  596,  596,  596,  596,  569,   97,  596,
			  569,  596,  596,  596,  596,   98,  596,   98,   97,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			   97,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   79,  596,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   99,  596,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,  165,  596,  165,  165,  165,  596,  165,  165,  165,

			  165,  165,  165,  165,  165,  165,  190,  190,  190,  190,
			  190,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,
			  196,   81,  596,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   82,  596,   82,  596,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,  223,  596,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  102,  102,  102,  102,

			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,   11,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596, yy_Dummy>>)
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
			    1,    1,    3,    4,   38,    3,    4,  513,    3,    4,

			    5,    5,    5,  481,    5,    6,    6,    6,   46,    6,
			    9,    9,    9,   10,   10,   10,   13,   13,   13,   14,
			   14,   14,   19,   25,   19,   26,   38,   26,   26,   26,
			   27,   13,  463,   25,   14,   33,   33,   27,   48,   28,
			   46,   28,   28,   28,   29,   40,   29,   29,   29,   35,
			   35,   49,   28,   45,  426,   40,    5,   29,   52,   45,
			   54,    6,   30,  361,   30,   30,   30,   41,   53,   41,
			   48,  360,   67,  256,   28,   67,   55,   40,  246,   41,
			  245,   28,   53,   49,   28,   45,   29,   40,    5,   29,
			   52,   45,   54,    6,   16,   16,  244,   16,   16,   41,

			   53,   41,   16,   16,   30,   16,   28,   16,   55,   71,
			   50,   41,   71,   16,   53,   16,   37,   16,   16,  243,
			   39,   37,   82,   37,   39,   50,   16,   39,   37,   37,
			   39,   16,   16,   39,   42,   75,   75,   75,   42,  121,
			   79,   16,   50,   79,   16,   16,  190,   16,   37,  190,
			   16,   42,   39,   37,   82,   37,   39,   50,   16,   39,
			   37,   37,   39,   16,   16,   39,   42,   44,  102,   47,
			   42,  121,  248,   16,   44,   44,   16,   16,   51,   47,
			   44,   47,  102,   42,  194,   47,  248,  194,   51,  123,
			   79,   51,   68,   68,   68,  242,   68,  241,  240,   44,

			  239,   47,  238,   77,   77,   77,   44,   44,  237,  236,
			   51,   47,   44,   47,  235,  234,   83,   47,   77,   83,
			   51,  123,   79,   51,   66,   66,   66,   84,   66,   85,
			   84,   66,   85,   66,   66,   66,  233,   81,   81,  232,
			   81,   66,   81,   86,  124,   81,   86,   66,   68,   66,
			  231,  125,   66,   66,   66,   66,   86,   66,   87,   66,
			  229,   87,  228,   66,   88,   66,   83,   88,   66,   66,
			   66,   66,   66,   66,  126,  227,  124,   84,   87,   85,
			   68,  127,   89,  125,   88,   89,   90,   92,   91,   90,
			   92,   91,   81,   86,  113,  113,  113,   93,   83,   95,

			   93,  128,   95,   94,   94,   94,  126,   94,   87,   84,
			   94,   85,   96,  127,   88,   96,  173,  173,  173,   89,
			  122,  129,   90,  122,   81,   86,   91,  226,   92,  130,
			  225,  131,   89,  128,  113,   93,   90,   92,   91,  196,
			   87,   97,   97,   97,  165,   97,   88,   93,   97,   95,
			   95,   89,  122,  129,   90,  122,  101,   94,   91,   94,
			   92,  130,   96,  131,   89,   99,   78,   93,   90,   92,
			   91,  105,  105,  105,  108,  134,  108,  108,  108,   93,
			  137,   95,   72,  138,  109,  105,  109,  109,  109,   94,
			  108,  139,  141,  144,   96,   97,  110,  109,  110,  110,

			  110,  198,  198,  198,  132,  146,   63,  134,  132,   61,
			  136,  147,  137,   57,  136,  138,  148,  105,  151,  154,
			   36,   31,  108,  139,  141,  144,  109,   97,  100,  109,
			  135,  100,  155,  100,  100,  100,  132,  146,  110,   11,
			  132,  100,  136,  147,    8,  135,  136,  100,  148,  100,
			  151,  154,  100,  100,  100,  100,  156,  100,    7,  100,
			    0,    0,  135,  100,  155,  100,  149,  145,  100,  100,
			  100,  100,  100,  100,  142,  149,  142,  135,  142,  145,
			  152,  153,  152,  157,  159,  153,  158,  160,  156,  142,
			  152,  158,  142,  152,  161,  152,  152,  162,  149,  145,

			    0,    0,  158,  203,  203,  203,  142,  149,  142,  259,
			  142,  145,  152,  153,  152,  157,  159,  153,  158,  160,
			    0,  142,  152,  158,  142,  152,  161,  152,  152,  162,
			  167,  167,  167,  208,  158,  260,  208,  167,  193,  193,
			  193,  259,  193,  202,  202,  202,  202,  210,  202,  212,
			  210,  202,  212,  213,    0,  263,  213,  203,  216,  215,
			  216,  214,  215,  216,  214,    0,  217,  260,    0,  217,
			  218,  218,  218,  220,  218,  221,  220,  218,  221,    0,
			  213,  264,  266,  208,  230,  230,  230,  263,    0,  203,
			  249,  249,  249,    0,  193,  267,  268,  210,  202,  212,

			  214,    0,  215,  213,  249,  269,  270,  217,  271,  215,
			  216,  214,  213,  264,  266,  208,  217,    0,    0,  252,
			  252,  252,    0,  220,  218,  221,  193,  267,  268,  210,
			  202,  212,  214,  252,  215,  213,  249,  269,  270,  217,
			  271,  215,  216,  214,  250,    0,  250,  272,  217,  250,
			  250,  250,  258,  258,  258,  220,  218,  221,  273,  275,
			    0,  253,  277,  253,  278,  252,  253,  253,  253,  254,
			  279,  254,  254,  254,  255,  276,  255,  255,  255,  272,
			  280,  257,  254,  257,  257,  257,  281,  282,  283,  276,
			  273,  275,  258,  280,  277,  284,  278,  285,  286,  287,

			  288,  289,  279,  290,  291,  293,  294,  276,  296,  297,
			  295,  254,  280,  295,  254,  298,  255,  299,  281,  282,
			  283,  276,  301,  257,  302,  280,  300,  284,  303,  285,
			  286,  287,  288,  289,  304,  290,  291,  293,  294,  305,
			  296,  297,  295,  306,  300,  295,  307,  298,  308,  299,
			  309,  310,  311,  312,  301,  313,  302,    0,  300,    0,
			  303,  316,  316,  316,  316,    0,  304,  317,  317,  317,
			  322,  305,  321,  322,  321,  306,  300,  321,  307,    0,
			  308,    0,  309,  310,  311,  312,  323,  313,  324,  323,
			  326,  324,    0,  326,  334,  334,  334,  334,    0,  351,

			  351,  351,  352,  352,  352,  322,  353,  353,  353,  354,
			  354,  354,  355,  351,  355,    0,  324,  355,  355,  355,
			  322,  317,  364,  354,  321,  356,  356,  356,  357,  357,
			  357,  358,    0,  358,  358,  358,  323,  322,  324,  351,
			  326,    0,  365,  366,  358,  351,  367,  359,  324,  359,
			  359,  359,  322,  317,  364,  354,  321,  362,  368,  362,
			  362,  362,  363,  369,  363,  363,  363,    0,  323,  370,
			  324,  371,  326,  358,  365,  366,  358,  372,  367,  373,
			  374,  375,  376,  377,  378,  379,  380,  381,  383,  359,
			  368,  384,  385,  386,  387,  369,  388,  389,  391,  362,

			  394,  370,  397,  371,  363,  398,  395,  395,  395,  372,
			  395,  373,  374,  375,  376,  377,  378,  379,  380,  381,
			  383,  395,  399,  384,  385,  386,  387,  400,  388,  389,
			  391,  401,  394,  402,  397,  403,  404,  398,  405,  406,
			  407,  408,  411,  412,  413,  414,  415,  419,  419,  419,
			  419,    0,  420,  422,  399,  420,  422,  424,    0,  400,
			  424,    0,  436,  401,    0,  402,    0,  403,  404,  437,
			  405,  406,  407,  408,  411,  412,  413,  414,  415,  427,
			  427,  427,  428,  428,  428,  422,  429,  429,  429,  430,
			  430,  430,  424,  427,  436,  420,  431,  431,  431,  440,

			  429,  437,  420,  422,  442,  444,  432,  424,  432,  432,
			  432,  433,  441,  433,  433,  433,  441,  422,  445,  446,
			  447,    0,  432,  448,  424,  427,  429,  420,  449,  451,
			  452,  440,  429,  453,  420,  422,  442,  444,  454,  424,
			  456,  457,  458,  460,  441,  464,  465,  466,  441,  467,
			  445,  446,  447,  433,  432,  448,  468,  469,  470,  471,
			  449,  451,  452,  473,  474,  453,  477,  461,  461,  461,
			  454,  461,  456,  457,  458,  460,  478,  464,  465,  466,
			  480,  467,  461,  482,  484,    0,  482,  484,  468,  469,
			  470,  471,  493,    0,  483,  473,  474,  483,  477,  486,

			    0,  486,    0,    0,  486,  486,  486,    0,  478,  487,
			  487,  487,  480,  494,  482,  488,  488,  488,  489,  489,
			  489,  496,  483,  487,  493,  490,  484,  490,  497,  488,
			  490,  490,  490,  482,  484,  491,  498,  491,  491,  491,
			  501,  503,  504,  506,  483,  494,  482,  507,  508,  509,
			  510,  491,  511,  496,  483,  487,  514,  516,  484,  517,
			  497,  488,  519,  523,  524,  482,  484,  526,  498,  530,
			  530,  530,  501,  503,  504,  506,  483,    0,  539,  507,
			  508,  509,  510,  491,  511,    0,    0,  527,  514,  516,
			  527,  517,  541,    0,  519,  523,  524,    0,  528,  526,

			  529,  528,    0,  529,  531,  531,  531,  532,  532,  532,
			  539,  533,    0,  533,    0,  527,  533,  533,  533,    0,
			  534,  532,  534,    0,  541,  534,  534,  534,  529,  535,
			  535,  535,  536,  536,  536,  543,  544,  527,  545,  548,
			  528,  551,  552,  535,  537,  537,  537,  527,  528,  538,
			  529,  538,  553,  532,  538,  538,  538,  554,  555,  557,
			  529,  558,  560,  561,    0,  560,  561,  543,  544,  527,
			  545,  548,  528,  551,  552,  535,  562,  563,  572,  562,
			  528,    0,  529,    0,  553,  564,  564,  564,  578,  554,
			  555,  557,    0,  558,  565,  565,  565,  580,  582,  560,

			  566,  566,  566,  563,  567,  567,  567,    0,    0,  563,
			  572,    0,  560,  561,  568,  568,  568,  569,  585,  569,
			  578,  585,  569,  569,  569,  588,  562,    0,  568,  580,
			  582,  560,  570,  570,  570,  571,  571,  571,  589,  589,
			  589,  590,  590,  590,  560,  561,  613,  613,  613,    0,
			    0,  588,    0,    0,    0,    0,    0,  588,  562,    0,
			  568,    0,    0,    0,    0,  602,    0,  602,  585,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			  585,  597,  597,  597,  597,  597,  597,  597,  597,  597,
			  597,  597,  597,  597,  597,  597,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  599,  599,  599,  599,  599,  599,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  601,    0,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  603,    0,  603,  603,
			  603,  603,  603,  603,  603,  603,  603,  603,  603,  603,
			  603,  605,    0,  605,  605,  605,    0,  605,  605,  605,

			  605,  605,  605,  605,  605,  605,  606,  606,  606,  606,
			  606,  606,  606,  606,  606,  606,  606,  606,  606,  606,
			  606,  607,  607,  607,  607,  607,  607,  607,  607,  607,
			  607,  607,  607,  607,  607,  607,  608,  608,  608,  608,
			  608,  608,  608,  608,  608,  608,  608,  608,  608,  608,
			  608,  609,    0,  609,  609,  609,  609,  609,  609,  609,
			  609,  609,  609,  609,  609,  609,  610,    0,  610,    0,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  611,    0,  611,  611,  611,  611,  611,  611,  611,
			  611,  611,  611,  611,  611,  611,  612,  612,  612,  612,

			  612,  612,  612,  612,  612,  612,  612,  612,  612,  612,
			  612,  614,  614,  614,  614,  614,  614,  614,  614,  614,
			  614,  614,  614,  614,  614,  614,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  555,  541,  108,
			  111,  539, 1726,  114,  117, 1726,  188,    0, 1726,  113,
			 1726, 1726, 1726, 1726, 1726,  106,  107,  111,  121,  126,
			  144,  495, 1726,  110, 1726,  123,  494,  180,   56,  183,
			  111,  126,  204,    0,  232,  115,   64,  238,   91,  117,
			  176,  241,  115,  138,  123,  132, 1726,  456, 1726, 1726,
			 1726,  418, 1726,  500, 1726, 1726,  322,  169,  290, 1726,
			 1726,  206,  479, 1726, 1726,  233, 1726,  301,  449,  234,
			 1726,  336,  166,  310,  321,  323,  337,  352,  358,  376,
			  380,  382,  381,  391,  401,  393,  406,  439,    0,  454,

			  522,  445,  265, 1726, 1726,  451, 1726, 1726,  456,  466,
			  478, 1726,    0,  374, 1726, 1726, 1726, 1726, 1726, 1726,
			    0,  205,  382,  256,  296,  302,  325,  347,  371,  378,
			  395,  384,  473,    0,  427,  497,  465,  439,  453,  447,
			    0,  447,  541,    0,  453,  535,  456,  463,  483,  534,
			    0,  484,  547,  540,  472,  498,  506,  538,  553,  537,
			  549,  560,  550, 1726, 1726,  438, 1726,  628, 1726, 1726,
			 1726, 1726, 1726,  396, 1726, 1726, 1726, 1726, 1726, 1726,
			 1726, 1726, 1726, 1726, 1726, 1726, 1726, 1726, 1726, 1726,
			  243, 1726, 1726,  636,  281, 1726,  436, 1726,  499, 1726,

			 1726, 1726,  642,  601, 1726, 1726, 1726, 1726,  627, 1726,
			  641, 1726,  643,  647,  655,  653,  654,  660,  668, 1726,
			  667,  669, 1726, 1726, 1726,  419,  416,  364,  351,  349,
			  664,  339,  328,  325,  304,  303,  298,  297,  291,  289,
			  287,  286,  284,  208,  185,  169,  167, 1726,  269,  670,
			  729, 1726,  699,  746,  751,  756,  113,  763,  732,  566,
			  605,    0,    0,  617,  634,    0,  650,  647,  645,  675,
			  659,  658,  713,  724,    0,  709,  745,  728,  716,  721,
			  738,  745,  753,  750,  761,  752,  768,  765,  770,  756,
			  769,  760,    0,  771,  752,  778,  774,  775,  785,  767,

			  794,  775,  790,  798,  796,  796,  809,  805,  814,  804,
			  813,  814,  820,  812,    0, 1726,  842,  865, 1726, 1726,
			 1726,  868,  864,  880,  882, 1726,  884, 1726, 1726, 1726,
			 1726, 1726, 1726, 1726,  875, 1726, 1726, 1726, 1726, 1726,
			 1726, 1726, 1726, 1726, 1726, 1726, 1726, 1726, 1726, 1726,
			 1726,  879,  882,  886,  889,  897,  905,  908,  913,  929,
			  111,  145,  939,  944,  873,  894,  907,  908,  918,  915,
			  935,  922,  943,  943,  933,  943,  935,  940,  937,  938,
			  952,  937,    0,  954,  953,  939,  940,  947,  962,  950,
			    0,  957,    0,    0,  959, 1004,    0,  952,  967,  987,

			  980,  989,  995,  985,  995,  984, 1007,  993,  996,    0,
			    0, 1008, 1008,  994, 1004, 1016,    0,    0, 1726, 1028,
			 1046, 1726, 1047, 1726, 1051, 1726,  143, 1059, 1062, 1066,
			 1069, 1076, 1088, 1093,    0,    0, 1019, 1038,    0,    0,
			 1052, 1078, 1061,    0, 1058, 1083, 1085, 1087, 1074, 1085,
			    0, 1082, 1087, 1099, 1100,    0, 1102, 1109, 1104,    0,
			 1109, 1165, 1726,  115, 1098, 1093, 1109, 1115, 1122, 1110,
			 1124, 1110,    0, 1114, 1134,    0,    0, 1128, 1142,    0,
			 1137,   84, 1177, 1188, 1178, 1726, 1184, 1189, 1195, 1198,
			 1210, 1217,    0, 1142, 1164,    0, 1177, 1179, 1202,    0,

			    0, 1206,    0, 1211, 1208,    0, 1195, 1204, 1199, 1200,
			 1220, 1203, 1726,   94, 1208,    0, 1214, 1216,    0, 1228,
			    0,    0,    0, 1214, 1221,    0, 1218, 1281, 1292, 1294,
			 1249, 1284, 1287, 1296, 1305, 1309, 1312, 1324, 1334, 1229,
			    0, 1249,    0, 1302, 1303, 1297,    0,    0, 1303,    0,
			    0, 1298, 1308, 1308, 1323, 1326,    0, 1325, 1327,    0,
			 1356, 1357, 1370, 1343, 1365, 1374, 1380, 1384, 1394, 1402,
			 1412, 1415, 1344,    0,    0,    0,    0,    0, 1339,    0,
			 1350,    0, 1364,    0,    0, 1412, 1726, 1726, 1391, 1418,
			 1421,    0,    0,    0,    0, 1726, 1726, 1500, 1515, 1530,

			 1545, 1560, 1462, 1575, 1471, 1590, 1605, 1620, 1635, 1650,
			 1665, 1680, 1695, 1439, 1710, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  596,    1,  597,  597,  598,  598,  599,  599,  600,
			  600,  596,  596,  596,  596,  596,  601,  602,  596,  603,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  596,  596,  596,  596,
			  596,  596,  596,  605,  596,  596,  596,  606,  606,  596,
			  596,  607,  608,  596,  596,  596,  596,  596,  596,  601,
			  596,  609,  610,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  602,  611,

			  611,  611,  612,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  613,  596,  596,  596,  596,  596,  596,  596,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  596,  596,  605,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  606,  596,  596,  606,  607,  596,  608,  596,  596,  596,

			  596,  596,  609,  610,  596,  596,  596,  596,  601,  596,
			  601,  596,  601,  601,  601,  601,  601,  601,  601,  596,
			  601,  601,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  612,  596,
			  596,  596,  596,  596,  596,  596,  613,  596,  596,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,

			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  596,  596,  610,  596,  596,
			  596,  601,  601,  601,  601,  596,  601,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  613,  596,  596,  596,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,

			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  596,  596,
			  601,  596,  601,  596,  601,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  596,  596,  596,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  596,  601,  601,  601,  596,  596,  596,  596,  596,
			  596,  596,  604,  604,  604,  604,  604,  604,  604,  604,

			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  596,  614,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  601,  601,  601,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  601,  601,  601,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  601,  596,  596,  596,  596,
			  596,  604,  604,  604,  604,  596,    0,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596, yy_Dummy>>)
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
			  270,  271,  272,  273,  274,  275,  276,  277,  277,  278,
			  279,  280,  281,  282,  282,  283,  284,  285,  286,  287,
			  288,  289,  290,  291,  292,  293,  294,  295,  296,  297,
			  298,  299,  300,  301,  302,  303,  305,  306,  307,  307,

			  308,  309,  311,  313,  314,  316,  318,  320,  322,  323,
			  325,  326,  328,  329,  330,  331,  332,  333,  334,  335,
			  336,  337,  338,  340,  341,  343,  344,  345,  346,  347,
			  348,  349,  350,  351,  352,  353,  354,  355,  356,  357,
			  358,  359,  360,  361,  362,  363,  364,  365,  367,  368,
			  369,  369,  370,  371,  371,  372,  373,  374,  375,  375,
			  376,  377,  379,  381,  382,  383,  385,  386,  387,  388,
			  389,  390,  391,  392,  393,  395,  396,  397,  398,  399,
			  400,  401,  402,  403,  404,  405,  406,  407,  408,  409,
			  410,  412,  413,  415,  416,  417,  418,  419,  420,  421,

			  422,  423,  424,  425,  426,  427,  428,  429,  430,  431,
			  432,  433,  434,  435,  436,  438,  439,  439,  439,  441,
			  443,  445,  446,  447,  448,  449,  451,  452,  454,  456,
			  457,  458,  459,  460,  461,  462,  463,  464,  465,  466,
			  467,  468,  469,  470,  471,  472,  473,  474,  475,  476,
			  477,  478,  479,  479,  480,  481,  481,  481,  482,  483,
			  484,  484,  484,  485,  486,  487,  488,  489,  490,  491,
			  492,  493,  494,  495,  496,  497,  499,  500,  501,  502,
			  503,  504,  505,  507,  508,  509,  510,  511,  512,  513,
			  514,  516,  517,  519,  521,  522,  524,  526,  527,  528,

			  529,  530,  531,  532,  533,  534,  535,  536,  537,  538,
			  540,  542,  543,  544,  545,  546,  547,  549,  551,  552,
			  552,  553,  555,  556,  558,  559,  561,  562,  563,  563,
			  564,  564,  565,  566,  567,  569,  571,  572,  573,  575,
			  577,  578,  579,  580,  582,  583,  584,  585,  586,  587,
			  588,  590,  591,  592,  593,  594,  596,  597,  598,  599,
			  601,  602,  602,  603,  603,  604,  605,  606,  607,  608,
			  609,  610,  611,  613,  614,  615,  617,  619,  620,  621,
			  623,  624,  624,  625,  626,  627,  628,  628,  629,  630,
			  630,  630,  631,  633,  634,  635,  637,  638,  639,  640,

			  642,  644,  645,  647,  648,  649,  651,  652,  653,  654,
			  655,  656,  657,  658,  658,  659,  661,  662,  663,  665,
			  666,  668,  670,  672,  673,  674,  676,  677,  678,  679,
			  680,  680,  681,  682,  682,  682,  683,  683,  684,  684,
			  685,  687,  688,  690,  691,  692,  693,  695,  697,  698,
			  700,  702,  703,  704,  705,  706,  707,  709,  710,  711,
			  713,  714,  715,  716,  717,  717,  718,  718,  719,  720,
			  720,  720,  721,  722,  724,  726,  728,  730,  732,  733,
			  735,  736,  738,  739,  741,  743,  744,  746,  748,  749,
			  749,  750,  752,  754,  756,  758,  760,  760, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  167,  167,  169,  169,  200,  198,  199,    1,  198,
			  199,    1,  199,   31,  198,  199,  170,  198,  199,   36,
			  198,  199,   10,  198,  199,  137,  198,  199,   19,  198,
			  199,   20,  198,  199,   27,  198,  199,   25,  198,  199,
			    4,  198,  199,   26,  198,  199,    9,  198,  199,   28,
			  198,  199,  109,  198,  199,  109,  198,  199,  109,  198,
			  199,    3,  198,  199,    2,  198,  199,   14,  198,  199,
			   13,  198,  199,   15,  198,  199,    6,  198,  199,  107,
			  198,  199,  107,  198,  199,  107,  198,  199,  107,  198,
			  199,  107,  198,  199,  107,  198,  199,  107,  198,  199,

			  107,  198,  199,  107,  198,  199,  107,  198,  199,  107,
			  198,  199,  107,  198,  199,  107,  198,  199,  107,  198,
			  199,  107,  198,  199,  107,  198,  199,  107,  198,  199,
			  107,  198,  199,  107,  198,  199,   23,  198,  199,  198,
			  199,   24,  198,  199,   29,  198,  199,   21,  198,  199,
			   22,  198,  199,    7,  198,  199,  171,  199,  197,  199,
			  195,  199,  196,  199,  167,  199,  167,  199,  166,  199,
			  165,  199,  167,  199,  169,  199,  168,  199,  163,  199,
			  163,  199,  162,  199,    1,  170,  159,  170,  170,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,

			 -360,  170,  170,  170, -360,   36,  137,  137,  137,    1,
			   30,    5,  112,   34,   18,  112,  109,  109,  108,   11,
			   32,   16,   17,   33,   12,  107,  107,  107,  107,   41,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,   53,
			  107,  107,  107,  107,  107,  107,  107,   65,  107,  107,
			  107,   72,  107,  107,  107,  107,  107,  107,  107,   84,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,   35,    8,  171,  195,  188,  186,  187,
			  189,  190,  191,  192,  172,  173,  174,  175,  176,  177,
			  178,  179,  180,  181,  182,  183,  184,  185,  167,  166,

			  165,  167,  167,  164,  165,  169,  168,  162,  160,  158,
			  160,  170, -360, -360,  145,  160,  143,  160,  144,  160,
			  146,  160,  170,  139,  160,  170,  140,  160,  170,  170,
			  170,  170,  170,  170,  170, -161,  170,  170,  147,  160,
			  137,  113,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  114,  137,    1,  112,  110,
			  112,  109,  109,  111,  109,  107,  107,   39,  107,   40,
			  107,  107,  107,   44,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,   56,  107,  107,  107,  107,  107,  107,

			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			   76,  107,  107,   79,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  106,  107,  194,  148,
			  160,  141,  160,  142,  160,  170,  170,  170,  170,  155,
			  160,  170,  150,  160,  149,  160,  131,  129,  130,  132,
			  133,  138,  134,  135,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  112,  112,
			  112,  112,  109,  109,  109,  109,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,   54,  107,  107,

			  107,  107,  107,  107,  107,   63,  107,  107,  107,  107,
			  107,  107,  107,  107,   73,  107,  107,   75,  107,   77,
			  107,  107,   82,  107,   83,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,   97,  107,
			   98,  107,  107,  107,  107,  107,  107,  104,  107,  105,
			  107,  193,  170,  151,  160,  170,  154,  160,  170,  157,
			  160,  138,  112,  112,  112,  112,  109,   37,  107,   38,
			  107,  107,  107,   45,  107,   46,  107,  107,  107,  107,
			   51,  107,  107,  107,  107,  107,  107,  107,   61,  107,
			  107,  107,  107,  107,   68,  107,  107,  107,  107,   74,

			  107,  107,   80,  107,  107,  107,  107,  107,  107,  107,
			  107,   93,  107,  107,  107,   96,  107,   99,  107,  107,
			  107,  102,  107,  107,  170,  170,  170,  136,  112,  112,
			  112,   42,  107,  107,  107,   48,  107,  107,  107,  107,
			   55,  107,   57,  107,  107,   59,  107,  107,  107,   64,
			  107,  107,  107,  107,  107,  107,  107,   81,  107,   86,
			  107,  107,  107,   89,  107,  107,   91,  107,   92,  107,
			   94,  107,  107,  107,  101,  107,  107,  170,  170,  170,
			  112,  112,  112,  112,  107,   47,  107,  107,   50,  107,
			  107,  107,  107,   62,  107,   66,  107,  107,   69,  107,

			   70,  107,  107,  107,  107,  107,  107,   90,  107,  107,
			  107,  103,  107,  170,  170,  170,  112,  112,  112,  112,
			  112,  107,   49,  107,   52,  107,   58,  107,   60,  107,
			   67,  107,  107,   78,  107,  107,   87,  107,  107,   95,
			  107,  100,  107,  170,  153,  160,  156,  160,  112,  112,
			   43,  107,   71,  107,   85,  107,   88,  107,  152,  160, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1726
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 596
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 597
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

	yyNb_rules: INTEGER is 199
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 200
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
