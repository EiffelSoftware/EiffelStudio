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
				append_without_underscores (text, token_buffer)
				last_token := TE_INTEGER
			
when 112 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 452 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 452")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				last_token := TE_REAL
			
when 114 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 464 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 464")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
			
when 115 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 469 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 469")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 116 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 475 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 475")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
			
when 117 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 480 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 480")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 485 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 485")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 490 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 490")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 495 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 495")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 500 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 500")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 505 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 505")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 510 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 510")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 515 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 515")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 520 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 520")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 525 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 525")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 530 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 530")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 535 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 535")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 540 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 540")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 545 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 545")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 550 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 550")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 555 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 555")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 560 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 560")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 565 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 565")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 570 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 570")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 575 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 575")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 580 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 580")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 138, 139 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 583 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 583")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 140 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 593 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 593")
end

				last_token := TE_STR_LT
			
when 141 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 596 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 596")
end

				last_token := TE_STR_GT
			
when 142 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 599 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 599")
end

				last_token := TE_STR_LE
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 602 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 602")
end

				last_token := TE_STR_GE
			
when 144 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 605 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 605")
end

				last_token := TE_STR_PLUS
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 608 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 608")
end

				last_token := TE_STR_MINUS
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 611 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 611")
end

				last_token := TE_STR_STAR
			
when 147 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 614 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 614")
end

				last_token := TE_STR_SLASH
			
when 148 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 617 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 617")
end

				last_token := TE_STR_POWER
			
when 149 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end

				last_token := TE_STR_DIV
			
when 150 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 623 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 623")
end

				last_token := TE_STR_MOD
			
when 151 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 152 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 631 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 631")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 153 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 636 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 636")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 154 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 641 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 641")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 155 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 646 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 646")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 156 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 651 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 651")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 157 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 656 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 656")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 158 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 661 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 661")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 159 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 669 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 669")
end

					-- Empty string.
				last_token := TE_EMPTY_STRING
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 673 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 673")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 161 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 682 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 682")
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
			
when 162 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 697 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 697")
end

				set_start_condition (VERBATIM_STR1)
			
when 163 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 700 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 700")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 164 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 719 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 719")
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
			
when 165 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 761 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 761")
end

				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 166 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 765 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 765")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 167 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 772 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 772")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 168 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 787 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 787")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 169 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 795 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 795")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 807 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 807")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 816 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 816")
end

				append_text_to_string (token_buffer)
			
when 172 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
end

				token_buffer.append_character ('%A')
			
when 173 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 822 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 822")
end

				token_buffer.append_character ('%B')
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 825 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 825")
end

				token_buffer.append_character ('%C')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 828 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 828")
end

				token_buffer.append_character ('%D')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 831 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 831")
end

				token_buffer.append_character ('%F')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 834 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 834")
end

				token_buffer.append_character ('%H')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

				token_buffer.append_character ('%L')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 840 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 840")
end

				token_buffer.append_character ('%N')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 843 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 843")
end

				token_buffer.append_character ('%Q')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 846 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 846")
end

				token_buffer.append_character ('%R')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 849 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 849")
end

				token_buffer.append_character ('%S')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 852 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 852")
end

				token_buffer.append_character ('%T')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 855 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 855")
end

				token_buffer.append_character ('%U')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 858 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 858")
end

				token_buffer.append_character ('%V')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 861 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 861")
end

				token_buffer.append_character ('%%')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 864 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 864")
end

				token_buffer.append_character ('%'')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 867 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 867")
end

				token_buffer.append_character ('%"')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 870 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 870")
end

				token_buffer.append_character ('%(')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 873 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 873")
end

				token_buffer.append_character ('%)')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 876 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 876")
end

				token_buffer.append_character ('%<')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 879 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 879")
end

				token_buffer.append_character ('%>')
			
when 193 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 882 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 882")
end

				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 194 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 885 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 885")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 889 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 889")
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
			
when 196 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 904 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 904")
end

					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 197 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 909 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 909")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 198 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 927 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 927")
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
			   61,   62,   64,   64,  189,   65,   65,  190,   66,   66,

			   68,   69,   68,  538,   70,   68,   69,   68,  404,   70,
			   75,   76,   75,   75,   76,   75,   77,   99,   77,  100,
			  101,  103,  105,  104,  104,  104,  114,  115,  125,  106,
			  102,  145,  107,  150,  108,  108,  109,  107,  151,  108,
			  108,  109,  116,  117,  107,  110,  109,  109,  109,  131,
			  110,  136,  156,  159,  498,  137,   71,  152,  470,  132,
			  125,   71,  342,  145,  160,  150,  189,  111,  138,  193,
			  151,   77,  153,   77,  112,  341,  340,  110,  133,  112,
			  134,  131,  110,  136,  156,  159,  112,  137,   71,  152,
			  135,  132,  339,   71,   80,   81,  160,   82,   81,  111,

			  138,  338,   83,   84,  153,   85,  201,   86,  143,  337,
			  133,  157,  134,   87,  144,   88,  120,   81,   89,  254,
			  126,  121,  135,  122,  127,  158,   90,  128,  123,  124,
			  129,   91,   92,  130,  257,  191,  189,  191,  201,  190,
			  143,   93,  336,  157,   94,   95,  144,   96,  120,  335,
			   89,  254,  126,  121,  334,  122,  127,  158,   90,  128,
			  123,  124,  129,   91,   92,  130,  257,  139,  154,  146,
			  196,  197,  196,   93,  140,  141,   94,   81,  155,  147,
			  142,  148,  253,  253,  253,  149,  198,   79,   79,   82,
			   79,  192,  199,  189,  202,   82,  190,   82,  258,  139,

			  154,  146,  203,  476,  333,   82,  140,  141,  332,  331,
			  155,  147,  142,  148,  309,  309,  309,  149,  165,  165,
			  165,  204,  166,  192,   82,  167,  330,  168,  169,  170,
			  258,  198,  329,  328,   82,  171,   94,  205,  327,  325,
			   82,  172,  200,  173,   94,  112,  174,  175,  176,  177,
			  206,  178,   94,  179,  324,  207,  323,  180,   82,  181,
			  322,  321,  182,  183,  184,  185,  186,  187,   94,  213,
			  209,   94,  259,   82,  200,  208,   94,  198,  260,  198,
			   82,   94,   82,  198,   94,  198,   82,   94,   82,  195,
			  210,  216,  217,  216,  219,  198,  164,   82,   82,  198,

			  244,  213,   82,   94,  259,   94,  221,  245,  245,  245,
			  260,  261,   78,   94,  211,  212,  262,  195,  164,   94,
			   94,  246,  162,  215,  214,  263,  264,   94,  107,   94,
			  251,  251,  251,   94,  265,   94,  255,   94,  247,  256,
			  248,  248,  248,  261,   94,   94,  211,  212,  262,   94,
			  218,  268,   94,  246,  249,  215,  214,  263,  264,   94,
			  107,   94,  250,  250,  251,   94,  265,   94,  255,  161,
			  112,  256,  273,  110,  118,  113,   94,   94,  274,   78,
			  266,   94,  222,  268,  267,  223,  249,  224,  225,  226,
			  189,  583,   73,  193,   73,  227,  271,  275,  276,  269,

			  272,  228,  112,  229,  273,  110,  230,  231,  232,  233,
			  274,  234,  266,  235,  270,  282,  267,  236,  583,  237,
			  285,  286,  238,  239,  240,  241,  242,  243,  271,  275,
			  276,  269,  272,  277,  287,  278,  288,  279,  283,  289,
			  583,  298,  299,  583,  300,  583,  270,  282,  280,  304,
			  284,  281,  285,  286,  296,  305,  306,  307,  297,  191,
			  189,  191,  290,  190,  291,  277,  287,  278,  288,  279,
			  283,  289,  292,  298,  299,  293,  300,  294,  295,  301,
			  280,  304,  284,  281,  302,  583,  296,  305,  306,  307,
			  297,  165,  165,  165,  290,  303,  291,  583,  308,  196,

			  197,  196,  311,  312,  292,   82,   82,  293,  583,  294,
			  295,  301,  310,  217,  310,  192,  302,   79,  216,  217,
			  216,  313,  199,  198,   82,   82,   82,  303,  198,  198,
			  583,   82,   82,  198,  583,  317,   82,  318,  583,  583,
			   82,  216,  217,  216,  583,  198,  320,  192,   82,   82,
			  314,  583,   94,   94,  326,  326,  326,  352,  352,  352,
			  343,  343,  343,  346,  346,  346,  201,  315,  353,  354,
			  319,   94,  200,   94,  246,  355,  316,  347,   94,   94,
			  356,  357,  314,   94,   94,   94,  344,   94,  344,  583,
			  583,  345,  345,  345,  358,   94,   94,  583,  201,  315,

			  353,  354,  319,   94,  200,   94,  246,  355,  316,  347,
			   94,   94,  356,  357,  359,   94,  348,  360,  348,   94,
			  361,  349,  349,  349,  362,  363,  358,   94,   94,  107,
			  364,  350,  350,  351,  107,  365,  351,  351,  351,  583,
			  366,  368,  110,  369,  583,  370,  359,  371,  373,  360,
			  374,  375,  361,  376,  367,  377,  362,  363,  378,  379,
			  372,  380,  364,  381,  382,  383,  384,  365,  386,  385,
			  387,  112,  366,  368,  110,  369,  112,  370,  388,  371,
			  373,  389,  374,  375,  392,  376,  367,  377,  390,  393,
			  378,  379,  372,  380,  394,  381,  382,  383,  384,  395,

			  386,  385,  387,  396,  397,  398,  391,  399,  400,  401,
			  388,  402,  403,  389,  583,  420,  392,  310,  217,  310,
			  390,  393,  404,  405,  405,  405,  394,  406,  583,  407,
			  198,  395,   82,   82,  421,  396,  397,  398,  391,  399,
			  400,  401,  409,  402,  403,   82,  198,  420,  411,   82,
			  583,   82,  412,  326,  326,  326,  345,  345,  345,  413,
			  413,  413,  345,  345,  345,  408,  421,  415,  415,  415,
			  416,  201,  416,  246,  410,  417,  417,  417,  422,   94,
			   94,  347,  349,  349,  349,  349,  349,  349,  419,  419,
			  419,  418,   94,  350,  350,  351,   94,  408,   94,  414,

			  423,  424,  425,  201,  110,  246,  410,  426,  427,  428,
			  422,   94,   94,  347,  418,  429,  351,  351,  351,  430,
			  431,  432,  433,  434,   94,  435,  436,  437,   94,  438,
			   94,  439,  423,  424,  425,  440,  110,  441,  442,  426,
			  427,  428,  443,  444,  445,  446,  450,  429,  451,  452,
			  453,  430,  431,  432,  433,  434,  454,  435,  436,  437,
			  455,  438,  456,  439,  447,  447,  447,  440,  448,  441,
			  442,  457,  458,  459,  443,  444,  445,  446,  450,  449,
			  451,  452,  453,  460,  461,  462,  463,  464,  454,  465,
			  198,  583,  455,   82,  456,  404,  466,  466,  466,  198,

			  477,  583,   82,  457,  458,  459,  198,  583,  583,   82,
			  583,  413,  413,  413,  583,  460,  461,  462,  463,  464,
			  478,  465,  472,  472,  472,  471,  479,  583,  473,  473,
			  473,  468,  477,  467,  417,  417,  417,  417,  417,  417,
			   94,  469,  347,  247,  480,  473,  473,  473,  481,   94,
			  482,  483,  478,  484,  485,  486,   94,  471,  479,  475,
			  487,  488,  489,  468,  490,  467,  491,  492,  474,  493,
			  494,  495,   94,  469,  347,  496,  480,  499,  500,  501,
			  481,   94,  482,  483,  502,  484,  485,  486,   94,  503,
			  504,  475,  487,  488,  489,  505,  490,  506,  491,  492,

			  507,  493,  494,  495,  447,  447,  447,  496,  497,  499,
			  500,  501,  508,  509,  510,  511,  502,  198,  524,  449,
			   82,  503,  504,  198,  583,  583,   82,  505,  198,  506,
			  525,   82,  507,  515,  583,  515,  526,  583,  516,  516,
			  516,  517,  517,  517,  508,  509,  510,  511,  512,  527,
			  524,  513,  473,  473,  473,  518,  520,  520,  520,  528,
			  529,  530,  525,  520,  520,  520,  519,   94,  526,  521,
			  514,  521,  531,   94,  522,  522,  522,  523,   94,  532,
			  512,  527,  533,  513,  534,  535,  536,  518,  537,  539,
			  540,  528,  529,  530,  541,  542,  543,  544,  519,   94,

			  545,  583,  514,  198,  531,   94,   82,  583,  583,  523,
			   94,  532,  198,  583,  533,   82,  534,  535,  536,  583,
			  537,  539,  540,  516,  516,  516,  541,  542,  543,  544,
			  198,  546,  545,   82,  516,  516,  516,  549,  549,  549,
			  550,  583,  550,  583,  583,  551,  551,  551,  583,  558,
			  552,  518,  552,   94,  547,  553,  553,  553,  548,  554,
			  554,  554,   94,  546,  522,  522,  522,  522,  522,  522,
			  556,  559,  556,  555,  560,  557,  557,  557,  561,  562,
			   94,  558,  563,  518,  564,   94,  547,  565,  567,  568,
			  548,  569,  570,  571,   94,  578,  518,  583,  538,  538,

			  538,  198,  566,  559,   82,  555,  560,  551,  551,  551,
			  561,  562,   94,  449,  563,  573,  564,  583,   82,  565,
			  567,  568,  414,  569,  570,  571,  574,  578,  518,   82,
			  551,  551,  551,  553,  553,  553,  579,  580,  572,  553,
			  553,  553,  575,  575,  575,  581,  555,  576,  583,  576,
			  583,   94,  577,  577,  577,  583,  555,  557,  557,  557,
			  557,  557,  557,  582,  583,   94,   82,  583,  579,  580,
			  572,  583,  474,  577,  577,  577,   94,  581,  555,  577,
			  577,  577,  583,   94,  252,  252,  252,  583,  555,  583,
			  583,  583,  583,  583,   97,  583,   97,   94,   97,   97,

			   97,   97,   97,   97,   97,   97,   97,  583,   94,  583,
			  583,  583,  583,   94,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  163,  583,  163,  163,  163,  583,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,  583,  583,
			  583,  583,  583,  583,  583,   94,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   74,   74,   74,   74,   74,   74,   74,   74,   74,

			   74,   74,   74,   74,   74,   74,   79,  583,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   98,  583,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  188,
			  188,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  194,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,   81,  583,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   82,  583,   82,  583,

			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,  220,  583,  220,  220,  220,  220,  220,  220,  220,
			  220,  220,  220,  220,  220,  220,  101,  583,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  498,  498,  498,  498,  498,  498,  498,  498,  498,
			  498,  498,  498,  498,  498,  498,   11,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,

			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583, yy_Dummy>>)
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

			    5,    5,    5,  498,    5,    6,    6,    6,  466,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   38,   27,
			   25,   46,   28,   48,   28,   28,   28,   29,   49,   29,
			   29,   29,   35,   35,   30,   28,   30,   30,   30,   40,
			   29,   42,   52,   54,  449,   42,    5,   50,  412,   40,
			   38,    6,  243,   46,   55,   48,   71,   28,   42,   71,
			   49,   77,   50,   77,   28,  242,  241,   28,   41,   29,
			   41,   40,   29,   42,   52,   54,   30,   42,    5,   50,
			   41,   40,  240,    6,   16,   16,   55,   16,   16,   28,

			   42,  239,   16,   16,   50,   16,   82,   16,   45,  238,
			   41,   53,   41,   16,   45,   16,   37,   16,   16,  120,
			   39,   37,   41,   37,   39,   53,   16,   39,   37,   37,
			   39,   16,   16,   39,  122,   68,   68,   68,   82,   68,
			   45,   16,  237,   53,   16,   16,   45,   16,   37,  236,
			   16,  120,   39,   37,  235,   37,   39,   53,   16,   39,
			   37,   37,   39,   16,   16,   39,  122,   44,   51,   47,
			   75,   75,   75,   16,   44,   44,   16,   16,   51,   47,
			   44,   47,  112,  112,  112,   47,   79,   81,   81,   79,
			   81,   68,   81,  188,   83,   81,  188,   83,  123,   44,

			   51,   47,   84,  419,  234,   84,   44,   44,  233,  232,
			   51,   47,   44,   47,  171,  171,  171,   47,   66,   66,
			   66,   85,   66,   68,   85,   66,  231,   66,   66,   66,
			  123,   91,  230,  229,   91,   66,   79,   86,  228,  226,
			   86,   66,   81,   66,   83,  419,   66,   66,   66,   66,
			   86,   66,   84,   66,  225,   87,  224,   66,   87,   66,
			  223,  222,   66,   66,   66,   66,   66,   66,   79,   91,
			   88,   85,  124,   88,   81,   87,   83,   89,  125,   90,
			   89,   91,   90,   92,   84,   93,   92,   86,   93,  194,
			   88,   94,   94,   94,   96,   94,  163,   96,   94,   95,

			  100,   91,   95,   85,  124,   87,   98,  104,  104,  104,
			  125,  126,   78,   91,   89,   90,  127,   72,   63,   86,
			   88,  104,   61,   93,   92,  128,  129,   89,  109,   90,
			  109,  109,  109,   92,  130,   93,  121,   87,  107,  121,
			  107,  107,  107,  126,   96,   94,   89,   90,  127,   95,
			   95,  133,   88,  104,  107,   93,   92,  128,  129,   89,
			  108,   90,  108,  108,  108,   92,  130,   93,  121,   57,
			  109,  121,  136,  108,   36,   31,   96,   94,  137,   14,
			  131,   95,   99,  133,  131,   99,  107,   99,   99,   99,
			  192,   11,    8,  192,    7,   99,  135,  138,  140,  134,

			  135,   99,  108,   99,  136,  108,   99,   99,   99,   99,
			  137,   99,  131,   99,  134,  143,  131,   99,    0,   99,
			  145,  146,   99,   99,   99,   99,   99,   99,  135,  138,
			  140,  134,  135,  141,  147,  141,  148,  141,  144,  150,
			    0,  153,  154,    0,  155,    0,  134,  143,  141,  157,
			  144,  141,  145,  146,  152,  158,  159,  160,  152,  191,
			  191,  191,  151,  191,  151,  141,  147,  141,  148,  141,
			  144,  150,  151,  153,  154,  151,  155,  151,  151,  156,
			  141,  157,  144,  141,  156,    0,  152,  158,  159,  160,
			  152,  165,  165,  165,  151,  156,  151,    0,  165,  196,

			  196,  196,  206,  208,  151,  206,  208,  151,    0,  151,
			  151,  156,  201,  201,  201,  191,  156,  200,  200,  200,
			  200,  210,  200,  211,  210,  200,  211,  156,  212,  215,
			    0,  212,  215,  213,    0,  214,  213,  214,    0,    0,
			  214,  216,  216,  216,    0,  216,  218,  191,  216,  218,
			  211,    0,  206,  208,  227,  227,  227,  253,  253,  253,
			  245,  245,  245,  248,  248,  248,  201,  212,  254,  255,
			  215,  210,  200,  211,  245,  258,  213,  248,  212,  215,
			  259,  261,  211,  213,  206,  208,  246,  214,  246,    0,
			    0,  246,  246,  246,  262,  216,  218,    0,  201,  212,

			  254,  255,  215,  210,  200,  211,  245,  258,  213,  248,
			  212,  215,  259,  261,  263,  213,  249,  264,  249,  214,
			  265,  249,  249,  249,  266,  267,  262,  216,  218,  250,
			  268,  250,  250,  250,  251,  270,  251,  251,  251,    0,
			  271,  272,  250,  273,    0,  274,  263,  275,  276,  264,
			  277,  278,  265,  279,  271,  280,  266,  267,  281,  282,
			  275,  283,  268,  284,  286,  288,  289,  270,  290,  289,
			  291,  250,  271,  272,  250,  273,  251,  274,  292,  275,
			  276,  293,  277,  278,  295,  279,  271,  280,  294,  296,
			  281,  282,  275,  283,  297,  284,  286,  288,  289,  298,

			  290,  289,  291,  299,  300,  301,  294,  302,  303,  304,
			  292,  305,  306,  293,    0,  353,  295,  310,  310,  310,
			  294,  296,  309,  309,  309,  309,  297,  314,    0,  314,
			  315,  298,  314,  315,  354,  299,  300,  301,  294,  302,
			  303,  304,  316,  305,  306,  316,  317,  353,  319,  317,
			    0,  319,  326,  326,  326,  326,  344,  344,  344,  343,
			  343,  343,  345,  345,  345,  315,  354,  346,  346,  346,
			  347,  310,  347,  343,  317,  347,  347,  347,  355,  314,
			  315,  346,  348,  348,  348,  349,  349,  349,  352,  352,
			  352,  350,  316,  350,  350,  350,  317,  315,  319,  343,

			  356,  357,  358,  310,  350,  343,  317,  359,  360,  361,
			  355,  314,  315,  346,  351,  362,  351,  351,  351,  363,
			  364,  365,  366,  367,  316,  368,  369,  370,  317,  372,
			  319,  373,  356,  357,  358,  374,  350,  375,  376,  359,
			  360,  361,  377,  378,  380,  382,  384,  362,  385,  386,
			  387,  363,  364,  365,  366,  367,  388,  368,  369,  370,
			  389,  372,  390,  373,  383,  383,  383,  374,  383,  375,
			  376,  391,  392,  393,  377,  378,  380,  382,  384,  383,
			  385,  386,  387,  394,  395,  398,  399,  400,  388,  401,
			  406,    0,  389,  406,  390,  405,  405,  405,  405,  408,

			  422,    0,  408,  391,  392,  393,  410,    0,    0,  410,
			    0,  413,  413,  413,    0,  394,  395,  398,  399,  400,
			  423,  401,  414,  414,  414,  413,  426,    0,  415,  415,
			  415,  408,  422,  406,  416,  416,  416,  417,  417,  417,
			  406,  410,  415,  418,  427,  418,  418,  418,  427,  408,
			  428,  430,  423,  431,  432,  433,  410,  413,  426,  418,
			  434,  435,  437,  408,  438,  406,  439,  440,  415,  442,
			  443,  444,  406,  410,  415,  446,  427,  450,  451,  452,
			  427,  408,  428,  430,  453,  431,  432,  433,  410,  454,
			  455,  418,  434,  435,  437,  456,  438,  457,  439,  440,

			  459,  442,  443,  444,  447,  447,  447,  446,  447,  450,
			  451,  452,  460,  462,  463,  465,  453,  467,  478,  447,
			  467,  454,  455,  468,    0,    0,  468,  456,  469,  457,
			  479,  469,  459,  471,    0,  471,  481,    0,  471,  471,
			  471,  472,  472,  472,  460,  462,  463,  465,  467,  482,
			  478,  468,  473,  473,  473,  472,  474,  474,  474,  483,
			  486,  488,  479,  476,  476,  476,  473,  467,  481,  475,
			  469,  475,  489,  468,  475,  475,  475,  476,  469,  491,
			  467,  482,  492,  468,  493,  494,  495,  472,  496,  499,
			  501,  483,  486,  488,  502,  504,  508,  509,  473,  467,

			  511,    0,  469,  512,  489,  468,  512,    0,    0,  476,
			  469,  491,  513,    0,  492,  513,  493,  494,  495,    0,
			  496,  499,  501,  515,  515,  515,  502,  504,  508,  509,
			  514,  512,  511,  514,  516,  516,  516,  517,  517,  517,
			  518,    0,  518,    0,    0,  518,  518,  518,    0,  524,
			  519,  517,  519,  512,  513,  519,  519,  519,  514,  520,
			  520,  520,  513,  512,  521,  521,  521,  522,  522,  522,
			  523,  526,  523,  520,  528,  523,  523,  523,  529,  530,
			  514,  524,  533,  517,  536,  512,  513,  537,  539,  540,
			  514,  541,  543,  544,  513,  558,  549,    0,  538,  538,

			  538,  546,  538,  526,  546,  520,  528,  550,  550,  550,
			  529,  530,  514,  538,  533,  547,  536,    0,  547,  537,
			  539,  540,  549,  541,  543,  544,  548,  558,  549,  548,
			  551,  551,  551,  552,  552,  552,  564,  567,  546,  553,
			  553,  553,  554,  554,  554,  569,  575,  555,    0,  555,
			    0,  546,  555,  555,  555,    0,  554,  556,  556,  556,
			  557,  557,  557,  572,    0,  547,  572,    0,  564,  567,
			  546,    0,  575,  576,  576,  576,  548,  569,  575,  577,
			  577,  577,    0,  546,  600,  600,  600,    0,  554,    0,
			    0,    0,    0,    0,  589,    0,  589,  547,  589,  589,

			  589,  589,  589,  589,  589,  589,  589,    0,  548,    0,
			    0,    0,    0,  572,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  592,    0,  592,  592,  592,    0,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,    0,    0,
			    0,    0,    0,    0,    0,  572,  584,  584,  584,  584,
			  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,
			  584,  585,  585,  585,  585,  585,  585,  585,  585,  585,
			  585,  585,  585,  585,  585,  585,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  587,  587,  587,  587,  587,  587,  587,  587,  587,

			  587,  587,  587,  587,  587,  587,  588,    0,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  590,    0,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  595,  595,  595,  595,
			  595,  596,    0,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  597,    0,  597,    0,

			  597,  597,  597,  597,  597,  597,  597,  597,  597,  597,
			  597,  598,    0,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  599,    0,  599,  599,
			  599,  599,  599,  599,  599,  599,  599,  599,  599,  599,
			  599,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,

			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  491,  489,  108,
			  111,  491, 1656,  114,  476, 1656,  188,    0, 1656,  108,
			 1656, 1656, 1656, 1656, 1656,  103,  103,  103,  114,  119,
			  126,  449, 1656,  101, 1656,  116,  448,  180,   90,  183,
			  115,  137,  121,    0,  232,  170,   87,  238,   86,  104,
			  123,  231,  109,  181,  116,  120, 1656,  412, 1656, 1656,
			 1656,  331, 1656,  412, 1656, 1656,  316,   91,  233, 1656,
			 1656,  163,  414, 1656, 1656,  268, 1656,  169,  409,  280,
			 1656,  286,  150,  288,  296,  315,  331,  349,  364,  371,
			  373,  325,  377,  379,  389,  393,  388,    0,  395,  476,

			  389,    0, 1656, 1656,  387, 1656, 1656,  420,  442,  410,
			 1656,    0,  262, 1656, 1656, 1656, 1656, 1656, 1656,    0,
			  185,  398,  201,  250,  323,  329,  377,  386,  382,  392,
			  387,  449,    0,  403,  466,  451,  431,  448,  453,    0,
			  453,  500,    0,  475,  506,  471,  473,  501,  504,    0,
			  505,  529,  513,  494,  508,  494,  546,  502,  517,  522,
			  510, 1656, 1656,  390, 1656,  589, 1656, 1656, 1656, 1656,
			 1656,  294, 1656, 1656, 1656, 1656, 1656, 1656, 1656, 1656,
			 1656, 1656, 1656, 1656, 1656, 1656, 1656, 1656,  290, 1656,
			 1656,  557,  487, 1656,  386, 1656,  597, 1656, 1656, 1656,

			  616,  610, 1656, 1656, 1656, 1656,  596, 1656,  597, 1656,
			  615,  617,  622,  627,  631,  623,  639, 1656,  640, 1656,
			 1656, 1656,  350,  349,  345,  343,  328,  634,  327,  322,
			  321,  315,  298,  297,  293,  243,  238,  231,  198,  190,
			  181,  165,  164,  151, 1656,  640,  671, 1656,  643,  701,
			  711,  716,    0,  637,  625,  639,    0,    0,  637,  633,
			    0,  649,  646,  663,  687,  673,  674,  691,  696,    0,
			  685,  710,  707,  695,  696,  705,  707,  716,  713,  719,
			  710,  728,  725,  731,  718,    0,  720,    0,  731,  734,
			  734,  736,  748,  731,  756,  737,  755,  764,  761,  760,

			  770,  771,  761,  770,  771,  778,  769,    0, 1656,  803,
			  815, 1656, 1656, 1656,  823,  824,  836,  840, 1656,  842,
			 1656, 1656, 1656, 1656, 1656, 1656,  833, 1656, 1656, 1656,
			 1656, 1656, 1656, 1656, 1656, 1656, 1656, 1656, 1656, 1656,
			 1656, 1656, 1656,  839,  836,  842,  847,  855,  862,  865,
			  873,  896,  868,  766,  786,  842,  862,  861,  854,  873,
			  859,  875,  879,  872,  882,  874,  879,  876,  878,  892,
			  877,    0,  895,  893,  882,  884,  891,  908,  896,    0,
			  903,    0,  904,  962,  896,  910,  914,  903,  914,  922,
			  912,  930,  918,  941,  936,  939,    0,    0,  950,  936,

			  946,  959,    0,    0, 1656,  976,  984, 1656,  993, 1656,
			 1000, 1656,  147,  991, 1002, 1008, 1014, 1017, 1025,  285,
			    0,    0,  957,  989,    0,    0,  979, 1010, 1007,    0,
			 1004, 1018, 1020, 1022, 1011, 1018,    0, 1015, 1021, 1032,
			 1029,    0, 1031, 1038, 1033,    0, 1041, 1102, 1656,  137,
			 1030, 1025, 1041, 1050, 1055, 1043, 1061, 1048,    0, 1051,
			 1082,    0, 1075, 1080,    0, 1072,   89, 1111, 1117, 1122,
			 1656, 1118, 1121, 1132, 1136, 1154, 1143,    0, 1068, 1081,
			    0, 1092, 1100, 1125,    0,    0, 1126,    0, 1131, 1138,
			    0, 1131, 1139, 1135, 1136, 1156, 1139, 1656,  100, 1141,

			    0, 1147, 1151,    0, 1161,    0,    0,    0, 1147, 1154,
			    0, 1151, 1197, 1206, 1224, 1203, 1214, 1217, 1225, 1235,
			 1239, 1244, 1247, 1255, 1200,    0, 1228,    0, 1241, 1245,
			 1238,    0,    0, 1246,    0,    0, 1241, 1253, 1296, 1244,
			 1255, 1259,    0, 1258, 1259,    0, 1295, 1309, 1320, 1262,
			 1287, 1310, 1313, 1319, 1322, 1332, 1337, 1340, 1261,    0,
			    0,    0,    0,    0, 1287,    0, 1656, 1290,    0, 1311,
			    0,    0, 1357, 1656, 1656, 1312, 1353, 1359,    0,    0,
			    0,    0, 1656, 1656, 1445, 1460, 1475, 1490, 1505, 1391,
			 1520, 1407, 1422, 1535, 1550, 1565, 1580, 1595, 1610, 1625,

			 1377, 1640, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  583,    1,  584,  584,  585,  585,  586,  586,  587,
			  587,  583,  583,  583,  583,  583,  588,  589,  583,  590,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  583,  583,  583,  583,
			  583,  583,  583,  592,  583,  583,  583,  593,  593,  583,
			  583,  594,  595,  583,  583,  583,  583,  583,  583,  588,
			  583,  596,  597,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  589,  598,  598,

			  598,  599,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  600,  583,  583,  583,  583,  583,  583,  583,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  583,  583,  592,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  593,  583,
			  583,  593,  594,  583,  595,  583,  583,  583,  583,  583,

			  596,  597,  583,  583,  583,  583,  588,  583,  588,  583,
			  588,  588,  588,  588,  588,  588,  588,  583,  588,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  600,  583,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,

			  591,  591,  591,  591,  591,  591,  591,  591,  583,  583,
			  597,  583,  583,  583,  588,  588,  588,  588,  583,  588,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,

			  591,  591,  591,  591,  583,  583,  588,  583,  588,  583,
			  588,  583,  583,  583,  583,  583,  583,  583,  583,  583,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  583,  583,  583,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  583,  588,  588,  588,
			  583,  583,  583,  583,  583,  583,  583,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  583,  601,  591,

			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  588,  588,  588,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  583,  591,
			  591,  591,  591,  591,  591,  591,  588,  588,  588,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  591,  591,
			  591,  591,  591,  591,  591,  591,  583,  591,  591,  591,
			  591,  591,  588,  583,  583,  583,  583,  583,  591,  591,
			  591,  591,  583,    0,  583,  583,  583,  583,  583,  583,
			  583,  583,  583,  583,  583,  583,  583,  583,  583,  583,

			  583,  583, yy_Dummy>>)
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
			  199,  200,  201,  202,  203,  205,  206,  207,  208,  209,

			  210,  211,  212,  213,  214,  215,  216,  217,  218,  220,
			  222,  223,  223,  223,  224,  225,  226,  227,  228,  229,
			  230,  231,  232,  233,  235,  236,  237,  238,  239,  240,
			  241,  242,  243,  245,  246,  247,  248,  249,  250,  251,
			  253,  254,  255,  257,  258,  259,  260,  261,  262,  263,
			  265,  266,  267,  268,  269,  270,  271,  272,  273,  274,
			  275,  276,  277,  278,  279,  280,  280,  281,  282,  283,
			  284,  285,  285,  286,  287,  288,  289,  290,  291,  292,
			  293,  294,  295,  296,  297,  298,  299,  300,  301,  302,
			  303,  304,  305,  306,  308,  309,  310,  310,  311,  312,

			  314,  316,  317,  319,  321,  323,  325,  326,  328,  329,
			  331,  332,  333,  334,  335,  336,  337,  338,  339,  340,
			  342,  343,  345,  346,  347,  348,  349,  350,  351,  352,
			  353,  354,  355,  356,  357,  358,  359,  360,  361,  362,
			  363,  364,  365,  366,  367,  369,  370,  370,  371,  372,
			  372,  374,  376,  377,  377,  378,  379,  381,  383,  384,
			  385,  387,  388,  389,  390,  391,  392,  393,  394,  395,
			  397,  398,  399,  400,  401,  402,  403,  404,  405,  406,
			  407,  408,  409,  410,  411,  412,  414,  415,  417,  418,
			  419,  420,  421,  422,  423,  424,  425,  426,  427,  428,

			  429,  430,  431,  432,  433,  434,  435,  436,  438,  439,
			  439,  439,  441,  443,  445,  446,  447,  448,  449,  451,
			  452,  454,  455,  456,  457,  458,  459,  460,  461,  462,
			  463,  464,  465,  466,  467,  468,  469,  470,  471,  472,
			  473,  474,  475,  476,  477,  477,  478,  479,  479,  479,
			  480,  481,  482,  482,  483,  484,  485,  486,  487,  488,
			  489,  490,  491,  492,  493,  495,  496,  497,  498,  499,
			  500,  501,  503,  504,  505,  506,  507,  508,  509,  510,
			  512,  513,  515,  516,  518,  519,  520,  521,  522,  523,
			  524,  525,  526,  527,  528,  529,  530,  532,  534,  535,

			  536,  537,  538,  540,  542,  543,  543,  544,  546,  547,
			  549,  550,  552,  553,  554,  554,  555,  555,  556,  557,
			  558,  560,  562,  563,  564,  566,  568,  569,  570,  571,
			  573,  574,  575,  576,  577,  578,  579,  581,  582,  583,
			  584,  585,  587,  588,  589,  590,  592,  593,  593,  594,
			  594,  595,  596,  597,  598,  599,  600,  601,  602,  604,
			  605,  606,  608,  609,  610,  612,  613,  613,  614,  615,
			  616,  617,  617,  618,  619,  619,  619,  620,  622,  623,
			  624,  626,  627,  628,  629,  631,  633,  634,  636,  637,
			  638,  640,  641,  642,  643,  644,  645,  646,  648,  648,

			  649,  651,  652,  653,  655,  656,  658,  660,  662,  663,
			  664,  666,  667,  668,  669,  670,  670,  671,  672,  672,
			  672,  673,  673,  674,  674,  675,  677,  678,  680,  681,
			  682,  683,  685,  687,  688,  690,  692,  693,  694,  694,
			  695,  696,  697,  699,  700,  701,  703,  704,  705,  706,
			  707,  707,  708,  708,  709,  710,  710,  710,  711,  712,
			  714,  716,  718,  720,  722,  723,  725,  726,  727,  729,
			  730,  732,  734,  735,  737,  739,  740,  740,  741,  743,
			  745,  747,  749,  751,  751, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  167,  167,  169,  169,  200,  198,  199,    2,  198,
			  199,    3,  199,   33,  198,  199,  170,  198,  199,   38,
			  198,  199,   12,  198,  199,  138,  198,  199,   21,  198,
			  199,   22,  198,  199,   29,  198,  199,   27,  198,  199,
			    6,  198,  199,   28,  198,  199,   11,  198,  199,   30,
			  198,  199,  109,  111,  198,  199,  109,  111,  198,  199,
			  109,  111,  198,  199,    5,  198,  199,    4,  198,  199,
			   16,  198,  199,   15,  198,  199,   17,  198,  199,    8,
			  198,  199,  107,  198,  199,  107,  198,  199,  107,  198,
			  199,  107,  198,  199,  107,  198,  199,  107,  198,  199,

			  107,  198,  199,  107,  198,  199,  107,  198,  199,  107,
			  198,  199,  107,  198,  199,  107,  198,  199,  107,  198,
			  199,  107,  198,  199,  107,  198,  199,  107,  198,  199,
			  107,  198,  199,  107,  198,  199,  107,  198,  199,   25,
			  198,  199,  198,  199,   26,  198,  199,   31,  198,  199,
			   23,  198,  199,   24,  198,  199,    9,  198,  199,  171,
			  199,  197,  199,  195,  199,  196,  199,  167,  199,  167,
			  199,  166,  199,  165,  199,  167,  199,  169,  199,  168,
			  199,  163,  199,  163,  199,  162,  199,    2,    3,  170,
			  159,  170,  170,  170,  170,  170,  170,  170,  170,  170,

			  170,  170,  170,  170, -360,  170,  170,   38,  138,  138,
			  138,    1,   32,    7,  113,   36,   20,  113,  109,  111,
			  109,  111,  108,   13,   34,   18,   19,   35,   14,  107,
			  107,  107,  107,   43,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,   55,  107,  107,  107,  107,  107,  107,
			  107,   67,  107,  107,  107,   74,  107,  107,  107,  107,
			  107,  107,  107,   85,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,   37,   10,  171,  195,
			  188,  186,  187,  189,  190,  191,  192,  172,  173,  174,
			  175,  176,  177,  178,  179,  180,  181,  182,  183,  184,

			  185,  167,  166,  165,  167,  167,  164,  165,  169,  168,
			  162,  160,  158,  160,  170, -360, -360,  146,  160,  144,
			  160,  145,  160,  147,  160,  170,  140,  160,  170,  141,
			  160,  170,  170,  170,  170,  170,  170,  170, -161,  170,
			  148,  160,  138,  114,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  115,  138,  113,
			  110,  113,  109,  111,  109,  111,  112,  107,  107,   41,
			  107,   42,  107,  107,  107,   46,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,   58,  107,  107,  107,  107,

			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,   78,  107,  107,   80,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  106,  107,  194,  149,
			  160,  142,  160,  143,  160,  170,  170,  170,  170,  155,
			  160,  170,  150,  160,  132,  130,  131,  133,  134,  139,
			  135,  136,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  113,  113,  113,  113,
			  109,  109,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,   56,  107,  107,  107,  107,  107,  107,

			  107,   65,  107,  107,  107,  107,  107,  107,  107,  107,
			   75,  107,  107,   77,  107,  107,   84,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			   98,  107,   99,  107,  107,  107,  107,  107,  104,  107,
			  105,  107,  193,  170,  151,  160,  170,  154,  160,  170,
			  157,  160,  139,  113,  113,  113,  113,  111,   39,  107,
			   40,  107,  107,  107,   47,  107,   48,  107,  107,  107,
			  107,   53,  107,  107,  107,  107,  107,  107,  107,   63,
			  107,  107,  107,  107,  107,   70,  107,  107,  107,  107,
			   76,  107,  107,   81,  107,  107,  107,  107,  107,  107,

			  107,  107,   94,  107,  107,  107,   97,  107,  107,  107,
			  102,  107,  107,  170,  170,  170,  137,  113,  113,  113,
			   44,  107,  107,  107,   50,  107,  107,  107,  107,   57,
			  107,   59,  107,  107,   61,  107,  107,  107,   66,  107,
			  107,  107,  107,  107,  107,  107,   82,   83,  107,   87,
			  107,  107,  107,   90,  107,  107,   92,  107,   93,  107,
			   95,  107,  107,  107,  101,  107,  107,  170,  170,  170,
			  113,  113,  113,  113,  107,   49,  107,  107,   52,  107,
			  107,  107,  107,   64,  107,   68,  107,  107,   71,  107,
			   72,  107,  107,  107,  107,  107,  107,   91,  107,  107,

			  107,  103,  107,  170,  170,  170,  113,  113,  113,  113,
			  113,  107,   51,  107,   54,  107,   60,  107,   62,  107,
			   69,  107,  107,   79,  107,   83,  107,   88,  107,  107,
			   96,  107,  100,  107,  170,  153,  160,  156,  160,  113,
			  113,   45,  107,   73,  107,   86,  107,   89,  107,  152,
			  160, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1656
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 583
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 584
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
