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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 38 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 38")
end

when 2 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 43 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 43")
end

when 3 then
yy_set_line (0)
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 44 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 44")
end

when 4 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 48 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 48")
end

				last_token := TE_SEMICOLON
			
when 5 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 51 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 51")
end

				last_token := TE_COLON
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 54 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 54")
end

				last_token := TE_COMMA
			
when 7 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 57 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 57")
end

				last_token := TE_DOTDOT
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 60 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 60")
end

				last_token := TE_QUESTION
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 63 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 63")
end

				last_token := TE_TILDE
			
when 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 66 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 66")
end

				last_token := TE_CURLYTILDE
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 69 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 69")
end

				last_token := TE_DOT
			
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 72 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 72")
end

				last_token := TE_ADDRESS
			
when 13 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 75 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 75")
end

				last_token := TE_ASSIGN
			
when 14 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 78 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 78")
end

				last_token := TE_ACCEPT
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 81 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 81")
end

				last_token := TE_EQ
			
when 16 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 84 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 84")
end

				last_token := TE_LT
			
when 17 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 87 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 87")
end

				last_token := TE_GT
			
when 18 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 90 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 90")
end

				last_token := TE_LE
			
when 19 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 93 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 93")
end

				last_token := TE_GE
			
when 20 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 96 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 96")
end

				last_token := TE_NE
			
when 21 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 99 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 99")
end

				last_token := TE_LPARAN
			
when 22 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 102 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 102")
end

				last_token := TE_RPARAN
			
when 23 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 105 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 105")
end

				last_token := TE_LCURLY
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 108 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 108")
end

				last_token := TE_RCURLY
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 111 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 111")
end

				last_token := TE_LSQURE
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 114 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 114")
end

				last_token := TE_RSQURE
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 117 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 117")
end

				last_token := TE_PLUS
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 120 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 120")
end

				last_token := TE_MINUS
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 123 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 123")
end

				last_token := TE_STAR
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 126 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 126")
end

				last_token := TE_SLASH
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 129 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 129")
end

				last_token := TE_POWER
			
when 32 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 132 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 132")
end

				last_token := TE_CONSTRAIN
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 135 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 135")
end

				last_token := TE_BANG
			
when 34 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 138 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 138")
end

				last_token := TE_LARRAY
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 141 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 141")
end

				last_token := TE_RARRAY
			
when 36 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 144 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 144")
end

				last_token := TE_DIV
			
when 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 147 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 147")
end

				last_token := TE_MOD
			
when 38 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 154 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 154")
end

				last_token := TE_FREE
				process_id_as
			
when 39 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 162 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 162")
end

				last_token := TE_AGENT
			
when 40 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 165 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 165")
end

				last_token := TE_ALIAS
			
when 41 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 168 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 168")
end

				last_token := TE_ALL
			
when 42 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 171 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 171")
end

				last_token := TE_AND
			
when 43 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 174")
end

				last_token := TE_AS
			
when 44 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 177 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 177")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 45 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 186 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 186")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 46 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 195 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 195")
end

				last_token := TE_BIT
			
when 47 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 198")
end

				last_token := TE_CHECK
			
when 48 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 201 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 201")
end

				last_token := TE_CLASS
			
when 49 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 204 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 204")
end

				last_token := TE_CONVERT
			
when 50 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 207 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 207")
end

				last_token := TE_CREATE
			
when 51 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 210 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 210")
end

				last_token := TE_CREATION
				last_location_as_value := ast_factory.new_location_as (line, column, position, 8)
			
when 52 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 214 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 214")
end

				last_token := TE_CURRENT
				last_current_as_value := ast_factory.new_current_as (line, column, position, 7)
			
when 53 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 218 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 218")
end

				last_token := TE_DEBUG
			
when 54 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 221 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 221")
end

				last_token := TE_DEFERRED
				last_deferred_as_value := ast_factory.new_deferred_as (line, column, position, 8)
			
when 55 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 225 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 225")
end

				last_token := TE_DO
			
when 56 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 228 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 228")
end

				last_token := TE_ELSE
			
when 57 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 231 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 231")
end

				last_token := TE_ELSEIF
			
when 58 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 234 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 234")
end

				last_token := TE_END
				last_location_as_value := ast_factory.new_location_as (line, column, position, 3)
			
when 59 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 238 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 238")
end

				last_token := TE_ENSURE
			
when 60 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 241 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 241")
end

				last_token := TE_EXPANDED
			
when 61 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 244 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 244")
end

				last_token := TE_EXPORT
			
when 62 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 247 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 247")
end

				last_token := TE_EXTERNAL
			
when 63 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 250 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 250")
end

				last_token := TE_FALSE
				last_bool_as_value := ast_factory.new_boolean_as (False, line, column, position, 5)
			
when 64 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 254 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 254")
end

				last_token := TE_FEATURE
			
when 65 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 257 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 257")
end

				last_token := TE_FROM
			
when 66 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 260 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 260")
end

				last_token := TE_FROZEN
			
when 67 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 263 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 263")
end

				last_token := TE_IF
			
when 68 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 266 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 266")
end

				last_token := TE_IMPLIES
			
when 69 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 269 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 269")
end

				last_token := TE_INDEXING
			
when 70 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 272 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 272")
end

				last_token := TE_INFIX
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 275 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 275")
end

				last_token := TE_INHERIT
			
when 72 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 278 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 278")
end

				last_token := TE_INSPECT
			
when 73 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 281 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 281")
end

				last_token := TE_INVARIANT
			
when 74 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 284 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 284")
end

				last_token := TE_IS
			
when 75 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 287 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 287")
end

				last_token := TE_LIKE
			
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 290 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 290")
end

				last_token := TE_LOCAL
			
when 77 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 293 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 293")
end

				last_token := TE_LOOP
			
when 78 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 296 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 296")
end

				last_token := TE_NOT
			
when 79 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 299 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 299")
end

				last_token := TE_OBSOLETE
			
when 80 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 302 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 302")
end

				last_token := TE_OLD
			
when 81 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 317 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 317")
end

				last_token := TE_ONCE_STRING
			
when 82 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 320 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 320")
end

				last_token := TE_ONCE_STRING
			
when 83 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 323 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 323")
end

				last_token := TE_ONCE_STRING
			
when 84 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 326 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 326")
end

				last_token := TE_ONCE
			
when 85 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 329 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 329")
end

				last_token := TE_OR
			
when 86 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 332 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 332")
end

				last_token := TE_PRECURSOR
				last_location_as_value := ast_factory.new_location_as (line, column, position, 9)
			
when 87 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 336 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 336")
end

				last_token := TE_PREFIX
			
when 88 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 339 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 339")
end

				last_token := TE_REDEFINE
			
when 89 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 342 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 342")
end

				last_token := TE_REFERENCE
			
when 90 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 345 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 345")
end

				last_token := TE_RENAME
			
when 91 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 348 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 348")
end

				last_token := TE_REQUIRE
			
when 92 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 351 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 351")
end

				last_token := TE_RESCUE
			
when 93 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 354 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 354")
end

				last_token := TE_RESULT
				last_result_as_value := ast_factory.new_result_as (line, column, position, 6)
			
when 94 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 358 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 358")
end

				last_token := TE_RETRY
				last_retry_as_value := ast_factory.new_retry_as (line, column, position, 5)
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 362 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 362")
end

				last_token := TE_SELECT
			
when 96 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 365 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 365")
end

				last_token := TE_SEPARATE
			
when 97 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 368 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 368")
end

				last_token := TE_STRIP
			
when 98 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 371 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 371")
end

				last_token := TE_THEN
			
when 99 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 374 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 374")
end

				last_token := TE_TRUE
				last_bool_as_value := ast_factory.new_boolean_as (True, line, column, position, 4)
			
when 100 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 378 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 378")
end

				last_token := TE_UNDEFINE
			
when 101 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 381 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 381")
end

				last_token := TE_UNIQUE
				last_unique_as_value := ast_factory.new_unique_as (line, column, position, 6)
			
when 102 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 385 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 385")
end

				last_token := TE_UNTIL
			
when 103 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 388 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 388")
end

				last_token := TE_VARIANT
			
when 104 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 391 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 391")
end

				last_token := TE_VOID
				last_void_as_value := ast_factory.new_void_as (line, column, position, 4)
			
when 105 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 395 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 395")
end

				last_token := TE_WHEN
			
when 106 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 398 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 398")
end

				last_token := TE_XOR
			
when 107 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 405 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 405")
end

				last_token := TE_ID
				process_id_as
			
when 108 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 413 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 413")
end

				last_token := TE_A_BIT
				last_id_as_value := ast_factory.new_filled_id_as (line, column,
					position, text_count - 1)
				if last_id_as_value /= Void then
					append_text_substring_to_string (1, text_count - 1, last_id_as_value)
				end
			
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 425 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 425")
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
--|#line 426 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 426")
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
--|#line 438 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 438")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 112, 113 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 453 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 453")
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
--|#line 465 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 465")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 470 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 470")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 117 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 476 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 476")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 481 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 481")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 486 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 486")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 491 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 491")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 496 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 496")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 501 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 501")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 506 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 506")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 511 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 511")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 516 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 516")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 521 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 521")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 526 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 526")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 531 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 531")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 536 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 536")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 541 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 541")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 546 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 546")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 551 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 551")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 556 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 556")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 561 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 561")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 566 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 566")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 571 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 571")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 576 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 576")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
			
when 138 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 581 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 581")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 139, 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 584 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 584")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 141 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 594 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 594")
end

				last_token := TE_STR_LT
			
when 142 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 597 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 597")
end

				last_token := TE_STR_GT
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 600 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 600")
end

				last_token := TE_STR_LE
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 603 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 603")
end

				last_token := TE_STR_GE
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 606 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 606")
end

				last_token := TE_STR_PLUS
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 609 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 609")
end

				last_token := TE_STR_MINUS
			
when 147 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 612 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 612")
end

				last_token := TE_STR_STAR
			
when 148 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 615 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 615")
end

				last_token := TE_STR_SLASH
			
when 149 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 618 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 618")
end

				last_token := TE_STR_POWER
			
when 150 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 621 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 621")
end

				last_token := TE_STR_DIV
			
when 151 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 624 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 624")
end

				last_token := TE_STR_MOD
			
when 152 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 627 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 627")
end

				last_token := TE_STR_BRACKET
			
when 153 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 630 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 630")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 154 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 635 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 635")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 155 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 640 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 640")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 156 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 645 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 645")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 157 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 650 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 650")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 158 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 655 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 655")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 159 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 660 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 660")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 665 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 665")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 161 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 673 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 673")
end

					-- Empty string.
				last_token := TE_EMPTY_STRING
			
when 162 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 677 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 677")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 163 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 686 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 686")
end

					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				set_start_condition (VERBATIM_STR3)
			
when 164 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 701 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 701")
end

				set_start_condition (VERBATIM_STR1)
			
when 165 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 704 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 704")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 166 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 723 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 723")
end

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
--|#line 765 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 765")
end

				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 168 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 769 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 769")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 169 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 776 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 776")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 791 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 791")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 799 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 799")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 811 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 811")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 820 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 820")
end

				append_text_to_string (token_buffer)
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 823 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 823")
end

				token_buffer.append_character ('%A')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 826 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 826")
end

				token_buffer.append_character ('%B')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 829 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 829")
end

				token_buffer.append_character ('%C')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 832 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 832")
end

				token_buffer.append_character ('%D')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 835 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 835")
end

				token_buffer.append_character ('%F')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 838 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 838")
end

				token_buffer.append_character ('%H')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

				token_buffer.append_character ('%L')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 844 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 844")
end

				token_buffer.append_character ('%N')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 847 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 847")
end

				token_buffer.append_character ('%Q')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 850 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 850")
end

				token_buffer.append_character ('%R')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 853 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 853")
end

				token_buffer.append_character ('%S')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 856 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 856")
end

				token_buffer.append_character ('%T')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 859 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 859")
end

				token_buffer.append_character ('%U')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 862 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 862")
end

				token_buffer.append_character ('%V')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 865 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 865")
end

				token_buffer.append_character ('%%')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 868 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 868")
end

				token_buffer.append_character ('%'')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 871 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 871")
end

				token_buffer.append_character ('%"')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 874 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 874")
end

				token_buffer.append_character ('%(')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 877 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 877")
end

				token_buffer.append_character ('%)')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 880 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 880")
end

				token_buffer.append_character ('%<')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 883 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 883")
end

				token_buffer.append_character ('%>')
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 886 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 886")
end

				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 196 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 889 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 889")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			
when 197 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 893 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 893")
end

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
--|#line 908 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 908")
end

					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 199 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 913 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 913")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 200 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 931 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 931")
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
			   61,   62,   64,   64,  190,   65,   65,  191,   66,   66,

			   68,   69,   68,  543,   70,   68,   69,   68,  409,   70,
			   75,   76,   75,   75,   76,   75,   77,  100,   77,  101,
			  102,  104,  106,  105,  105,  105,  115,  116,  126,  107,
			  103,  146,  108,  151,  109,  109,  110,  108,  152,  109,
			  109,  110,  117,  118,  108,  111,  110,  110,  110,  132,
			  111,  137,  157,  160,  503,  138,   71,  153,  475,  133,
			  126,   71,  356,  146,  161,  151,  190,  112,  139,  194,
			  152,   77,  154,   77,  113,  356,  356,  111,  134,  113,
			  135,  132,  111,  137,  157,  160,  113,  138,   71,  153,
			  136,  133,  345,   71,   80,   81,  161,   82,   81,  112,

			  139,  344,   83,   84,  154,   85,  202,   86,  144,  343,
			  134,  158,  135,   87,  145,   88,  121,   81,   89,  256,
			  127,  122,  136,  123,  128,  159,   90,  129,  124,  125,
			  130,   91,   92,  131,  259,  192,  190,  192,  202,  191,
			  144,   93,  342,  158,   94,   95,  145,   96,  121,  341,
			   89,  256,  127,  122,  340,  123,  128,  159,   90,  129,
			  124,  125,  130,   91,   92,  131,  259,  140,  155,  147,
			  197,  198,  197,   93,  141,  142,   97,   81,  156,  148,
			  143,  149,  255,  255,  255,  150,  199,   79,   79,   82,
			   79,  193,  200,  190,  203,   82,  191,   82,  260,  140,

			  155,  147,  204,  481,  339,   82,  141,  142,  338,  337,
			  156,  148,  143,  149,  311,  311,  311,  150,  166,  166,
			  166,  205,  167,  193,   82,  168,  336,  169,  170,  171,
			  260,  199,  335,  334,   82,  172,   97,  206,  333,  332,
			   82,  173,  201,  174,   97,  113,  175,  176,  177,  178,
			  207,  179,   97,  180,  331,  208,  330,  181,   82,  182,
			  328,  261,  183,  184,  185,  186,  187,  188,   97,  214,
			  210,   97,  262,   82,  201,  209,   97,  199,  263,  199,
			   82,   97,   82,  199,   97,  199,   82,   97,   82,  199,
			  211,  221,   82,  261,   82,  217,  218,  217,  327,  199,

			  326,  214,   82,   97,  262,   97,  264,  247,  247,  247,
			  263,  265,  325,   97,  212,  213,  266,  324,  267,   97,
			   97,  248,  257,  216,  215,  258,  270,   97,  249,   97,
			  250,  250,  250,   97,  196,   97,  165,   97,  264,   97,
			  220,   97,  190,  265,  251,  194,  212,  213,  266,   97,
			  267,  219,   97,  248,  257,  216,  215,  258,  270,   97,
			  275,   97,  217,  218,  217,   97,  199,   97,  268,   82,
			  276,   97,  269,   97,  271,  108,  251,  252,  252,  253,
			  108,   97,  253,  253,  253,  246,  277,  273,  111,  272,
			  223,  274,  275,  278,  279,  284,  280,  287,  281,  285,

			  268,  288,  276,  289,  269,  290,  271,  291,  300,  282,
			  298,  286,  283,  301,  299,  302,   97,  113,  277,  273,
			  111,  272,  113,  274,   78,  278,  279,  284,  280,  287,
			  281,  285,  306,  288,  307,  289,  196,  290,  165,  291,
			  300,  282,  298,  286,  283,  301,  299,  302,   97,  224,
			  308,  163,  225,  162,  226,  227,  228,  192,  190,  192,
			  119,  191,  229,  114,  306,  309,  307,  303,  230,   78,
			  231,  358,  304,  232,  233,  234,  235,  588,  236,   73,
			  237,   73,  308,  305,  238,  292,  239,  293,  588,  240,
			  241,  242,  243,  244,  245,  294,  588,  309,  295,  303,

			  296,  297,  588,  358,  304,  166,  166,  166,  197,  198,
			  197,  313,  310,  193,   82,  305,  359,  292,  588,  293,
			   79,  217,  218,  217,  588,  200,  314,  294,   82,   82,
			  295,  588,  296,  297,  312,  218,  312,  315,  588,  199,
			   82,  199,   82,  588,   82,  193,  588,  199,  359,  319,
			   82,  320,  322,  199,   82,   82,   82,  588,  588,  323,
			  360,   97,   82,  217,  218,  217,  316,  199,  361,  588,
			   82,  329,  329,  329,  588,  201,   97,  357,  357,  357,
			  317,  346,  346,  346,  362,  588,  588,   97,  202,   97,
			  318,   97,  360,   97,  321,  248,  588,   97,  316,  588,

			  361,   97,   97,   97,  349,  349,  349,  201,   97,   97,
			  588,  588,  317,  363,  588,  364,  362,   97,  350,   97,
			  202,   97,  318,   97,  588,  588,  321,  248,  108,   97,
			  354,  354,  354,   97,   97,   97,  365,  347,  588,  347,
			  366,   97,  348,  348,  348,  363,  351,  364,  351,   97,
			  350,  352,  352,  352,  108,  367,  353,  353,  354,  368,
			  369,  370,  371,  373,  588,  374,  375,  111,  365,  376,
			  113,  378,  366,  379,  380,  381,  372,  382,  383,  384,
			  385,  386,  377,  387,  388,  389,  391,  367,  390,  392,
			  393,  368,  369,  370,  371,  373,  113,  374,  375,  111,

			  394,  376,  397,  378,  398,  379,  380,  381,  372,  382,
			  383,  384,  385,  386,  377,  387,  388,  389,  391,  395,
			  390,  392,  393,  399,  400,  401,  402,  403,  404,  405,
			  406,  407,  394,  408,  397,  588,  398,  396,  409,  410,
			  410,  410,  312,  218,  312,  411,  425,  412,  588,  199,
			   82,  395,   82,  588,  588,  399,  400,  401,  402,  403,
			  404,  405,  406,  407,  414,  408,  588,   82,  416,  396,
			  199,   82,  588,   82,  417,  329,  329,  329,  425,  418,
			  418,  418,  588,  588,  413,  348,  348,  348,  348,  348,
			  348,  588,  426,  248,  427,  428,  202,   97,  415,   97,

			  588,  420,  420,  420,  421,  588,  421,  588,  588,  422,
			  422,  422,  588,  429,   97,  350,  413,  430,   97,  419,
			   97,  352,  352,  352,  426,  248,  427,  428,  202,   97,
			  415,   97,  352,  352,  352,  423,  431,  353,  353,  354,
			  423,  432,  354,  354,  354,  429,   97,  350,  111,  430,
			   97,  433,   97,  424,  424,  424,  434,  435,  436,  437,
			  438,  439,  440,  441,  442,  443,  444,  445,  431,  446,
			  447,  448,  449,  432,  450,  451,  477,  477,  477,  455,
			  111,  456,  457,  433,  458,  459,  460,  461,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,

			  462,  446,  447,  448,  449,  463,  450,  451,  452,  452,
			  452,  455,  453,  456,  457,  464,  458,  459,  460,  461,
			  465,  466,  467,  454,  468,  469,  470,  409,  471,  471,
			  471,  199,  462,  199,   82,  199,   82,  463,   82,  482,
			  483,  418,  418,  418,  422,  422,  422,  464,  478,  478,
			  478,  588,  465,  466,  467,  476,  468,  469,  470,  422,
			  422,  422,  350,  484,  249,  473,  478,  478,  478,  485,
			  474,  482,  483,  486,  472,  487,  488,  489,  490,  491,
			  480,   97,  492,   97,  493,   97,  494,  476,  479,  495,
			  496,  497,  498,  499,  350,  484,  500,  473,  501,  588,

			  588,  485,  474,  588,  504,  486,  472,  487,  488,  489,
			  490,  491,  480,   97,  492,   97,  493,   97,  494,  505,
			  506,  495,  496,  497,  498,  499,  507,  508,  500,  509,
			  501,  452,  452,  452,  510,  502,  504,  511,  512,  513,
			  514,  515,  516,  588,  199,  199,  454,   82,   82,  529,
			  199,  505,  506,   82,  525,  525,  525,  588,  507,  508,
			  530,  509,  522,  522,  522,  588,  510,  531,  588,  511,
			  512,  513,  514,  515,  516,  517,  523,  520,  518,  520,
			  532,  529,  521,  521,  521,  588,  533,  519,  478,  478,
			  478,  526,  530,  526,   97,   97,  527,  527,  527,  531,

			   97,  534,  524,  525,  525,  525,  535,  517,  523,  536,
			  518,  537,  532,  538,  539,  540,  541,  528,  533,  519,
			  542,  544,  545,  546,  547,  548,   97,   97,  549,  550,
			  588,  563,   97,  534,  524,  588,  199,  199,  535,   82,
			   82,  536,  588,  537,  588,  538,  539,  540,  541,  528,
			  564,  588,  542,  544,  545,  546,  547,  548,  588,  565,
			  549,  550,  199,  563,  551,   82,  521,  521,  521,  521,
			  521,  521,  588,  588,  554,  554,  554,  566,  555,  552,
			  555,  567,  564,  556,  556,  556,   97,   97,  523,  588,
			  553,  565,  557,  568,  557,  588,  551,  558,  558,  558,

			  559,  559,  559,  527,  527,  527,  527,  527,  527,  566,
			  569,  552,   97,  567,  560,  570,  572,  573,   97,   97,
			  523,  561,  553,  561,  574,  568,  562,  562,  562,  575,
			  543,  543,  543,  576,  571,  199,  578,  579,   82,   82,
			   82,  523,  569,  583,   97,  454,  560,  570,  572,  573,
			  556,  556,  556,  556,  556,  556,  574,  558,  558,  558,
			  588,  575,  558,  558,  558,  576,  584,  419,  580,  580,
			  580,  585,  577,  523,  581,  583,  581,  586,  588,  582,
			  582,  582,  560,  588,  560,   97,   97,   97,  562,  562,
			  562,  562,  562,  562,  587,  588,  588,   82,  584,  582,

			  582,  582,  588,  585,  577,  582,  582,  582,  588,  586,
			  479,  254,  254,  254,  560,  588,  560,   97,   97,   97,
			   98,  588,   98,  588,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  588,  164,   97,  164,  164,  164,  588,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,   82,  588,
			   82,  588,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,  588,  588,  588,   97,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   67,   67,   67,   67,   67,   67,   67,   67,

			   67,   67,   67,   67,   67,   67,   67,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   79,  588,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   99,  588,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  195,  195,  195,

			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  195,   81,  588,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,  222,  588,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  102,  588,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  355,  355,  355,
			  588,  588,  588,  355,  503,  503,  503,  503,  503,  503,
			  503,  503,  503,  503,  503,  503,  503,  503,  503,   11,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,

			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588, yy_Dummy>>)
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
			    1,    1,    3,    4,   67,    3,    4,   67,    3,    4,

			    5,    5,    5,  503,    5,    6,    6,    6,  471,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   38,   27,
			   25,   46,   28,   48,   28,   28,   28,   29,   49,   29,
			   29,   29,   35,   35,   30,   28,   30,   30,   30,   40,
			   29,   42,   52,   54,  454,   42,    5,   50,  417,   40,
			   38,    6,  356,   46,   55,   48,   71,   28,   42,   71,
			   49,   77,   50,   77,   28,  355,  254,   28,   41,   29,
			   41,   40,   29,   42,   52,   54,   30,   42,    5,   50,
			   41,   40,  245,    6,   16,   16,   55,   16,   16,   28,

			   42,  244,   16,   16,   50,   16,   82,   16,   45,  243,
			   41,   53,   41,   16,   45,   16,   37,   16,   16,  121,
			   39,   37,   41,   37,   39,   53,   16,   39,   37,   37,
			   39,   16,   16,   39,  123,   68,   68,   68,   82,   68,
			   45,   16,  242,   53,   16,   16,   45,   16,   37,  241,
			   16,  121,   39,   37,  240,   37,   39,   53,   16,   39,
			   37,   37,   39,   16,   16,   39,  123,   44,   51,   47,
			   75,   75,   75,   16,   44,   44,   16,   16,   51,   47,
			   44,   47,  113,  113,  113,   47,   79,   81,   81,   79,
			   81,   68,   81,  189,   83,   81,  189,   83,  124,   44,

			   51,   47,   84,  424,  239,   84,   44,   44,  238,  237,
			   51,   47,   44,   47,  172,  172,  172,   47,   66,   66,
			   66,   85,   66,   68,   85,   66,  236,   66,   66,   66,
			  124,   91,  235,  234,   91,   66,   79,   86,  233,  232,
			   86,   66,   81,   66,   83,  424,   66,   66,   66,   66,
			   86,   66,   84,   66,  231,   87,  230,   66,   87,   66,
			  228,  125,   66,   66,   66,   66,   66,   66,   79,   91,
			   88,   85,  126,   88,   81,   87,   83,   89,  127,   90,
			   89,   91,   90,   92,   84,   93,   92,   86,   93,   95,
			   88,   96,   95,  125,   96,   94,   94,   94,  227,   94,

			  226,   91,   94,   85,  126,   87,  128,  105,  105,  105,
			  127,  129,  225,   91,   89,   90,  130,  224,  131,   86,
			   88,  105,  122,   93,   92,  122,  134,   89,  108,   90,
			  108,  108,  108,   92,  195,   93,  164,   87,  128,   95,
			   95,   96,  193,  129,  108,  193,   89,   90,  130,   94,
			  131,   94,   88,  105,  122,   93,   92,  122,  134,   89,
			  137,   90,   97,   97,   97,   92,   97,   93,  132,   97,
			  138,   95,  132,   96,  135,  109,  108,  109,  109,  109,
			  110,   94,  110,  110,  110,  101,  139,  136,  109,  135,
			   99,  136,  137,  141,  142,  144,  142,  146,  142,  145,

			  132,  147,  138,  148,  132,  149,  135,  151,  154,  142,
			  153,  145,  142,  155,  153,  156,   97,  109,  139,  136,
			  109,  135,  110,  136,   78,  141,  142,  144,  142,  146,
			  142,  145,  158,  147,  159,  148,   72,  149,   63,  151,
			  154,  142,  153,  145,  142,  155,  153,  156,   97,  100,
			  160,   61,  100,   57,  100,  100,  100,  192,  192,  192,
			   36,  192,  100,   31,  158,  161,  159,  157,  100,   14,
			  100,  256,  157,  100,  100,  100,  100,   11,  100,    8,
			  100,    7,  160,  157,  100,  152,  100,  152,    0,  100,
			  100,  100,  100,  100,  100,  152,    0,  161,  152,  157,

			  152,  152,    0,  256,  157,  166,  166,  166,  197,  197,
			  197,  207,  166,  192,  207,  157,  257,  152,    0,  152,
			  201,  201,  201,  201,    0,  201,  209,  152,  201,  209,
			  152,    0,  152,  152,  202,  202,  202,  211,    0,  212,
			  211,  213,  212,    0,  213,  192,    0,  214,  257,  215,
			  214,  215,  219,  216,  215,  219,  216,    0,    0,  220,
			  260,  207,  220,  217,  217,  217,  212,  217,  261,    0,
			  217,  229,  229,  229,    0,  201,  209,  255,  255,  255,
			  213,  247,  247,  247,  263,    0,    0,  211,  202,  212,
			  214,  213,  260,  207,  216,  247,    0,  214,  212,    0,

			  261,  215,  219,  216,  250,  250,  250,  201,  209,  220,
			    0,    0,  213,  264,    0,  265,  263,  217,  250,  211,
			  202,  212,  214,  213,    0,    0,  216,  247,  253,  214,
			  253,  253,  253,  215,  219,  216,  266,  248,    0,  248,
			  267,  220,  248,  248,  248,  264,  251,  265,  251,  217,
			  250,  251,  251,  251,  252,  268,  252,  252,  252,  269,
			  270,  272,  273,  274,    0,  275,  276,  252,  266,  277,
			  253,  278,  267,  279,  280,  281,  273,  282,  283,  284,
			  285,  286,  277,  288,  290,  291,  292,  268,  291,  293,
			  294,  269,  270,  272,  273,  274,  252,  275,  276,  252,

			  295,  277,  297,  278,  298,  279,  280,  281,  273,  282,
			  283,  284,  285,  286,  277,  288,  290,  291,  292,  296,
			  291,  293,  294,  299,  300,  301,  302,  303,  304,  305,
			  306,  307,  295,  308,  297,    0,  298,  296,  311,  311,
			  311,  311,  312,  312,  312,  316,  358,  316,    0,  317,
			  316,  296,  317,    0,    0,  299,  300,  301,  302,  303,
			  304,  305,  306,  307,  318,  308,    0,  318,  321,  296,
			  319,  321,    0,  319,  329,  329,  329,  329,  358,  346,
			  346,  346,    0,    0,  317,  347,  347,  347,  348,  348,
			  348,    0,  359,  346,  360,  361,  312,  316,  319,  317,

			    0,  349,  349,  349,  350,    0,  350,    0,    0,  350,
			  350,  350,    0,  362,  318,  349,  317,  363,  321,  346,
			  319,  351,  351,  351,  359,  346,  360,  361,  312,  316,
			  319,  317,  352,  352,  352,  353,  364,  353,  353,  353,
			  354,  365,  354,  354,  354,  362,  318,  349,  353,  363,
			  321,  366,  319,  357,  357,  357,  367,  368,  369,  370,
			  371,  372,  373,  374,  375,  377,  378,  379,  364,  380,
			  381,  382,  383,  365,  385,  387,  419,  419,  419,  389,
			  353,  390,  391,  366,  392,  393,  394,  395,  367,  368,
			  369,  370,  371,  372,  373,  374,  375,  377,  378,  379,

			  396,  380,  381,  382,  383,  397,  385,  387,  388,  388,
			  388,  389,  388,  390,  391,  398,  392,  393,  394,  395,
			  399,  400,  403,  388,  404,  405,  406,  410,  410,  410,
			  410,  411,  396,  413,  411,  415,  413,  397,  415,  427,
			  428,  418,  418,  418,  421,  421,  421,  398,  420,  420,
			  420,    0,  399,  400,  403,  418,  404,  405,  406,  422,
			  422,  422,  420,  431,  423,  413,  423,  423,  423,  432,
			  415,  427,  428,  432,  411,  433,  435,  436,  437,  438,
			  423,  411,  439,  413,  440,  415,  442,  418,  420,  443,
			  444,  445,  447,  448,  420,  431,  449,  413,  451,    0,

			    0,  432,  415,    0,  455,  432,  411,  433,  435,  436,
			  437,  438,  423,  411,  439,  413,  440,  415,  442,  456,
			  457,  443,  444,  445,  447,  448,  458,  459,  449,  460,
			  451,  452,  452,  452,  461,  452,  455,  462,  464,  465,
			  467,  468,  470,    0,  472,  474,  452,  472,  474,  483,
			  473,  456,  457,  473,  479,  479,  479,    0,  458,  459,
			  484,  460,  477,  477,  477,    0,  461,  486,    0,  462,
			  464,  465,  467,  468,  470,  472,  477,  476,  473,  476,
			  487,  483,  476,  476,  476,    0,  488,  474,  478,  478,
			  478,  480,  484,  480,  472,  474,  480,  480,  480,  486,

			  473,  491,  478,  481,  481,  481,  493,  472,  477,  494,
			  473,  496,  487,  497,  498,  499,  500,  481,  488,  474,
			  501,  504,  506,  507,  509,  513,  472,  474,  514,  516,
			    0,  529,  473,  491,  478,    0,  517,  518,  493,  517,
			  518,  494,    0,  496,    0,  497,  498,  499,  500,  481,
			  531,    0,  501,  504,  506,  507,  509,  513,    0,  533,
			  514,  516,  519,  529,  517,  519,  520,  520,  520,  521,
			  521,  521,    0,    0,  522,  522,  522,  534,  523,  518,
			  523,  535,  531,  523,  523,  523,  517,  518,  522,    0,
			  519,  533,  524,  538,  524,    0,  517,  524,  524,  524,

			  525,  525,  525,  526,  526,  526,  527,  527,  527,  534,
			  541,  518,  519,  535,  525,  542,  544,  545,  517,  518,
			  522,  528,  519,  528,  546,  538,  528,  528,  528,  548,
			  543,  543,  543,  549,  543,  551,  552,  553,  551,  552,
			  553,  554,  541,  563,  519,  543,  525,  542,  544,  545,
			  555,  555,  555,  556,  556,  556,  546,  557,  557,  557,
			    0,  548,  558,  558,  558,  549,  569,  554,  559,  559,
			  559,  572,  551,  554,  560,  563,  560,  574,    0,  560,
			  560,  560,  559,    0,  580,  551,  552,  553,  561,  561,
			  561,  562,  562,  562,  577,    0,    0,  577,  569,  581,

			  581,  581,    0,  572,  551,  582,  582,  582,    0,  574,
			  580,  605,  605,  605,  559,    0,  580,  551,  552,  553,
			  594,    0,  594,    0,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,    0,  597,  577,  597,  597,  597,    0,  597,
			  597,  597,  597,  597,  597,  597,  597,  597,  602,    0,
			  602,    0,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,    0,    0,    0,  577,  589,  589,  589,
			  589,  589,  589,  589,  589,  589,  589,  589,  589,  589,
			  589,  589,  590,  590,  590,  590,  590,  590,  590,  590,

			  590,  590,  590,  590,  590,  590,  590,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  593,    0,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  595,    0,  595,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  595,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  599,  599,  599,  599,  599,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  599,  600,  600,  600,

			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  601,    0,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  603,    0,  603,
			  603,  603,  603,  603,  603,  603,  603,  603,  603,  603,
			  603,  603,  604,    0,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  606,  606,  606,
			    0,    0,    0,  606,  607,  607,  607,  607,  607,  607,
			  607,  607,  607,  607,  607,  607,  607,  607,  607,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,

			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  578,  576,  108,
			  111,  577, 1679,  114,  566, 1679,  188,    0, 1679,  108,
			 1679, 1679, 1679, 1679, 1679,  103,  103,  103,  114,  119,
			  126,  537, 1679,  101, 1679,  116,  534,  180,   90,  183,
			  115,  137,  121,    0,  232,  170,   87,  238,   86,  104,
			  123,  231,  109,  181,  116,  120, 1679,  496, 1679, 1679,
			 1679,  460, 1679,  532, 1679, 1679,  316,   91,  233, 1679,
			 1679,  163,  533, 1679, 1679,  268, 1679,  169,  521,  280,
			 1679,  286,  150,  288,  296,  315,  331,  349,  364,  371,
			  373,  325,  377,  379,  393,  383,  385,  460,    0,  479,

			  543,  474,    0, 1679, 1679,  387, 1679, 1679,  410,  457,
			  462, 1679,    0,  262, 1679, 1679, 1679, 1679, 1679, 1679,
			    0,  185,  384,  201,  250,  312,  323,  344,  376,  368,
			  382,  371,  437,    0,  378,  441,  442,  419,  440,  442,
			    0,  448,  461,    0,  455,  467,  448,  453,  470,  473,
			    0,  473,  552,  469,  461,  479,  465,  534,  485,  496,
			  516,  518, 1679, 1679,  430, 1679,  603, 1679, 1679, 1679,
			 1679, 1679,  294, 1679, 1679, 1679, 1679, 1679, 1679, 1679,
			 1679, 1679, 1679, 1679, 1679, 1679, 1679, 1679, 1679,  290,
			 1679, 1679,  555,  439, 1679,  431, 1679,  606, 1679, 1679,

			 1679,  619,  632, 1679, 1679, 1679, 1679,  605, 1679,  620,
			 1679,  631,  633,  635,  641,  645,  647,  661, 1679,  646,
			  653, 1679, 1679, 1679,  406,  401,  389,  387,  349,  651,
			  345,  343,  328,  327,  322,  321,  315,  298,  297,  293,
			  243,  238,  231,  198,  190,  181, 1679,  661,  722, 1679,
			  684,  731,  736,  710,  116,  657,  528,  586,    0,    0,
			  622,  621,    0,  652,  665,  664,  706,  693,  705,  725,
			  726,    0,  711,  732,  729,  717,  717,  727,  730,  739,
			  736,  741,  732,  748,  745,  750,  736,    0,  739,    0,
			  750,  753,  752,  755,  760,  750,  787,  755,  770,  793,

			  786,  782,  792,  793,  782,  791,  792,  798,  790,    0,
			 1679,  819,  840, 1679, 1679, 1679,  841,  843,  858,  864,
			 1679,  862, 1679, 1679, 1679, 1679, 1679, 1679, 1679,  855,
			 1679, 1679, 1679, 1679, 1679, 1679, 1679, 1679, 1679, 1679,
			 1679, 1679, 1679, 1679, 1679, 1679,  859,  865,  868,  881,
			  889,  901,  912,  917,  922,  115,  102,  933,  797,  844,
			  858,  857,  873,  869,  902,  892,  917,  920,  910,  920,
			  912,  917,  914,  915,  929,  914,    0,  931,  928,  914,
			  916,  923,  937,  925,    0,  933,    0,  934, 1006,  929,
			  943,  947,  937,  943,  948,  937,  959,  951,  983,  973,

			  976,    0,    0,  987,  974,  984,  996,    0,    0, 1679,
			 1008, 1025, 1679, 1027, 1679, 1029, 1679,  147, 1021,  956,
			 1028, 1024, 1039, 1046,  285,    0,    0,  996, 1009,    0,
			    0, 1016, 1035, 1032,    0, 1029, 1042, 1044, 1046, 1033,
			 1041,    0, 1039, 1046, 1056, 1053,    0, 1054, 1061, 1058,
			    0, 1064, 1129, 1679,  137, 1057, 1066, 1082, 1092, 1093,
			 1082, 1100, 1088,    0, 1089, 1109,    0, 1102, 1107,    0,
			 1099,   89, 1138, 1144, 1139, 1679, 1162, 1142, 1168, 1134,
			 1176, 1183,    0, 1099, 1111,    0, 1123, 1131, 1152,    0,
			    0, 1167,    0, 1176, 1175,    0, 1163, 1170, 1165, 1166,

			 1186, 1171, 1679,  100, 1173,    0, 1179, 1180,    0, 1190,
			    0,    0,    0, 1176, 1185,    0, 1180, 1230, 1231, 1256,
			 1246, 1249, 1254, 1263, 1277, 1280, 1283, 1286, 1306, 1182,
			    0, 1207,    0, 1226, 1244, 1240,    0,    0, 1257,    0,
			    0, 1267, 1281, 1328, 1272, 1283, 1292,    0, 1295, 1299,
			    0, 1329, 1330, 1331, 1307, 1330, 1333, 1337, 1342, 1348,
			 1359, 1368, 1371, 1309,    0,    0,    0,    0,    0, 1317,
			    0, 1679, 1324,    0, 1343,    0,    0, 1388, 1679, 1679,
			 1350, 1379, 1385,    0,    0,    0,    0, 1679, 1679, 1476,
			 1491, 1506, 1521, 1536, 1417, 1551, 1426, 1442, 1566, 1581,

			 1596, 1611, 1457, 1626, 1641, 1404, 1650, 1663, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  588,    1,  589,  589,  590,  590,  591,  591,  592,
			  592,  588,  588,  588,  588,  588,  593,  594,  588,  595,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  588,  588,  588,  588,
			  588,  588,  588,  597,  588,  588,  588,  598,  598,  588,
			  588,  599,  600,  588,  588,  588,  588,  588,  588,  593,
			  588,  601,  602,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  594,  603,

			  603,  603,  604,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  605,  588,  588,  588,  588,  588,  588,  588,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  588,  588,  597,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  598,
			  588,  588,  598,  599,  588,  600,  588,  588,  588,  588,

			  588,  601,  602,  588,  588,  588,  588,  593,  588,  593,
			  588,  593,  593,  593,  593,  593,  593,  593,  588,  593,
			  593,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  606,  588,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  588,  588,  602,  588,  588,  588,  593,  593,  593,  593,
			  588,  593,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  606,  606,  588,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  596,  596,  596,  596,  596,  596,  596,  588,
			  588,  593,  588,  593,  588,  593,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  588,  588,  588,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  588,  593,  593,  593,  588,  588,  588,  588,  588,
			  588,  588,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,

			  596,  596,  588,  607,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  593,  593,  593,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  588,  596,  596,  596,  596,  596,  596,
			  596,  593,  593,  593,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  596,  596,  596,  596,  596,  596,  596,
			  596,  588,  596,  596,  596,  596,  596,  593,  588,  588,
			  588,  588,  588,  596,  596,  596,  596,  588,    0,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,

			  588,  588,  588,  588,  588,  588,  588,  588, yy_Dummy>>)
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
			   28,   31,   34,   37,   40,   43,   46,   49,   52,   56,
			   60,   64,   67,   70,   73,   76,   79,   82,   85,   88,
			   91,   94,   97,  100,  103,  106,  109,  112,  115,  118,
			  121,  124,  127,  130,  133,  136,  139,  142,  144,  147,
			  150,  153,  156,  159,  161,  163,  165,  167,  169,  171,
			  173,  175,  177,  179,  181,  183,  185,  187,  188,  189,
			  190,  191,  192,  192,  193,  194,  195,  196,  197,  198,
			  199,  200,  201,  202,  203,  205,  206,  207,  209,  210,

			  211,  212,  213,  214,  215,  216,  217,  218,  219,  220,
			  222,  224,  225,  225,  225,  226,  227,  228,  229,  230,
			  231,  232,  233,  234,  235,  237,  238,  239,  240,  241,
			  242,  243,  244,  245,  247,  248,  249,  250,  251,  252,
			  253,  255,  256,  257,  259,  260,  261,  262,  263,  264,
			  265,  267,  268,  269,  270,  271,  272,  273,  274,  275,
			  276,  277,  278,  279,  280,  281,  282,  282,  283,  284,
			  285,  286,  287,  287,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  306,  307,  308,  310,  311,  312,  312,  313,

			  314,  316,  318,  319,  321,  323,  325,  327,  328,  330,
			  331,  333,  334,  335,  336,  337,  338,  339,  340,  341,
			  342,  343,  345,  346,  348,  349,  350,  351,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  365,  366,  367,  368,  369,  370,  372,  373,  373,
			  374,  375,  375,  377,  379,  380,  380,  381,  382,  384,
			  386,  387,  388,  390,  391,  392,  393,  394,  395,  396,
			  397,  398,  400,  401,  402,  403,  404,  405,  406,  407,
			  408,  409,  410,  411,  412,  413,  414,  415,  417,  418,
			  420,  421,  422,  423,  424,  425,  426,  427,  428,  429,

			  430,  431,  432,  433,  434,  435,  436,  437,  438,  439,
			  441,  442,  442,  442,  444,  446,  448,  449,  450,  451,
			  452,  454,  455,  457,  459,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  474,
			  475,  476,  477,  478,  479,  480,  481,  482,  482,  483,
			  484,  484,  484,  485,  486,  487,  488,  488,  488,  489,
			  490,  491,  492,  493,  494,  495,  496,  497,  498,  499,
			  501,  502,  503,  504,  505,  506,  507,  509,  510,  511,
			  512,  513,  514,  515,  516,  518,  519,  521,  522,  524,
			  525,  526,  527,  528,  529,  530,  531,  532,  533,  534,

			  535,  536,  538,  540,  541,  542,  543,  544,  546,  548,
			  549,  549,  550,  552,  553,  555,  556,  558,  559,  560,
			  560,  561,  561,  562,  563,  564,  566,  568,  569,  570,
			  572,  574,  575,  576,  577,  579,  580,  581,  582,  583,
			  584,  585,  587,  588,  589,  590,  591,  593,  594,  595,
			  596,  598,  599,  599,  600,  600,  601,  602,  603,  604,
			  605,  606,  607,  608,  610,  611,  612,  614,  615,  616,
			  618,  619,  619,  620,  621,  622,  623,  623,  624,  625,
			  625,  625,  626,  628,  629,  630,  632,  633,  634,  635,
			  637,  639,  640,  642,  643,  644,  646,  647,  648,  649,

			  650,  651,  652,  654,  654,  655,  657,  658,  659,  661,
			  662,  664,  666,  668,  669,  670,  672,  673,  674,  675,
			  676,  676,  677,  678,  678,  678,  679,  679,  680,  680,
			  681,  683,  684,  686,  687,  688,  689,  691,  693,  694,
			  696,  698,  699,  700,  700,  701,  702,  703,  705,  706,
			  707,  709,  710,  711,  712,  713,  713,  714,  714,  715,
			  716,  716,  716,  717,  718,  720,  722,  724,  726,  728,
			  729,  731,  732,  733,  735,  736,  738,  740,  741,  743,
			  745,  746,  746,  747,  749,  751,  753,  755,  757,  757, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  169,  169,  171,  171,  202,  200,  201,    2,  200,
			  201,    3,  201,   33,  200,  201,  172,  200,  201,   38,
			  200,  201,   12,  200,  201,  139,  200,  201,   21,  200,
			  201,   22,  200,  201,   29,  200,  201,   27,  200,  201,
			    6,  200,  201,   28,  200,  201,   11,  200,  201,   30,
			  200,  201,  109,  111,  200,  201,  109,  111,  200,  201,
			  109,  111,  200,  201,    5,  200,  201,    4,  200,  201,
			   16,  200,  201,   15,  200,  201,   17,  200,  201,    8,
			  200,  201,  107,  200,  201,  107,  200,  201,  107,  200,
			  201,  107,  200,  201,  107,  200,  201,  107,  200,  201,

			  107,  200,  201,  107,  200,  201,  107,  200,  201,  107,
			  200,  201,  107,  200,  201,  107,  200,  201,  107,  200,
			  201,  107,  200,  201,  107,  200,  201,  107,  200,  201,
			  107,  200,  201,  107,  200,  201,  107,  200,  201,   25,
			  200,  201,  200,  201,   26,  200,  201,   31,  200,  201,
			   23,  200,  201,   24,  200,  201,    9,  200,  201,  173,
			  201,  199,  201,  197,  201,  198,  201,  169,  201,  169,
			  201,  168,  201,  167,  201,  169,  201,  171,  201,  170,
			  201,  165,  201,  165,  201,  164,  201,    2,    3,  172,
			  161,  172,  172,  172,  172,  172,  172,  172,  172,  172,

			  172,  172,  172,  172, -364,  172,  172,  172, -364,   38,
			  139,  139,  139,    1,   32,    7,  114,   36,   20,  114,
			  109,  111,  109,  111,  108,   13,   34,   18,   19,   35,
			   14,  107,  107,  107,  107,   43,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,   55,  107,  107,  107,  107,
			  107,  107,  107,   67,  107,  107,  107,   74,  107,  107,
			  107,  107,  107,  107,  107,   85,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,   37,   10,
			  173,  197,  190,  188,  189,  191,  192,  193,  194,  174,
			  175,  176,  177,  178,  179,  180,  181,  182,  183,  184,

			  185,  186,  187,  169,  168,  167,  169,  169,  166,  167,
			  171,  170,  164,  162,  160,  162,  172, -364, -364,  147,
			  162,  145,  162,  146,  162,  148,  162,  172,  141,  162,
			  172,  142,  162,  172,  172,  172,  172,  172,  172,  172,
			 -163,  172,  172,  149,  162,  139,  115,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  116,  139,  114,  110,  114,  109,  111,  109,  111,  112,
			  107,  107,   41,  107,   42,  107,  107,  107,   46,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,   58,  107,

			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,   78,  107,  107,   80,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  106,
			  107,  196,  150,  162,  143,  162,  144,  162,  172,  172,
			  172,  172,  157,  162,  172,  152,  162,  151,  162,  133,
			  131,  132,  134,  135,  140,  136,  137,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  114,  114,  114,  114,  109,  109,  113,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,   56,

			  107,  107,  107,  107,  107,  107,  107,   65,  107,  107,
			  107,  107,  107,  107,  107,  107,   75,  107,  107,   77,
			  107,  107,   84,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,   98,  107,   99,  107,
			  107,  107,  107,  107,  104,  107,  105,  107,  195,  172,
			  153,  162,  172,  156,  162,  172,  159,  162,  140,  114,
			  114,  114,  114,  111,   39,  107,   40,  107,  107,  107,
			   47,  107,   48,  107,  107,  107,  107,   53,  107,  107,
			  107,  107,  107,  107,  107,   63,  107,  107,  107,  107,
			  107,   70,  107,  107,  107,  107,   76,  107,  107,   81,

			  107,  107,  107,  107,  107,  107,  107,  107,   94,  107,
			  107,  107,   97,  107,  107,  107,  102,  107,  107,  172,
			  172,  172,  138,  114,  114,  114,   44,  107,  107,  107,
			   50,  107,  107,  107,  107,   57,  107,   59,  107,  107,
			   61,  107,  107,  107,   66,  107,  107,  107,  107,  107,
			  107,  107,   82,   83,  107,   87,  107,  107,  107,   90,
			  107,  107,   92,  107,   93,  107,   95,  107,  107,  107,
			  101,  107,  107,  172,  172,  172,  114,  114,  114,  114,
			  107,   49,  107,  107,   52,  107,  107,  107,  107,   64,
			  107,   68,  107,  107,   71,  107,   72,  107,  107,  107,

			  107,  107,  107,   91,  107,  107,  107,  103,  107,  172,
			  172,  172,  114,  114,  114,  114,  114,  107,   51,  107,
			   54,  107,   60,  107,   62,  107,   69,  107,  107,   79,
			  107,   83,  107,   88,  107,  107,   96,  107,  100,  107,
			  172,  155,  162,  158,  162,  114,  114,   45,  107,   73,
			  107,   86,  107,   89,  107,  154,  162, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1679
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 588
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 589
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
