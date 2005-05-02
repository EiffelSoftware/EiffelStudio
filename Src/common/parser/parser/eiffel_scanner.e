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
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

				last_token := TE_STR_BRACKET
			
when 152 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 629 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 629")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 153 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 634 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 634")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 154 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 639 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 639")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 155 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 644 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 644")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 156 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 649 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 649")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 157 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 654 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 654")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 158 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 659 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 659")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 159 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 664 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 664")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 160 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 672 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 672")
end

					-- Empty string.
				last_token := TE_EMPTY_STRING
			
when 161 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 676 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 676")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 162 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 685 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 685")
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
			
when 163 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 700 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 700")
end

				set_start_condition (VERBATIM_STR1)
			
when 164 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 703 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 703")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 165 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 722 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 722")
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
			
when 166 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 764 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 764")
end

				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 167 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 768 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 768")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 168 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 775 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 775")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 169 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 790 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 790")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 798 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 798")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 171 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 810 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 810")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
end

				append_text_to_string (token_buffer)
			
when 173 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 822 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 822")
end

				token_buffer.append_character ('%A')
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 825 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 825")
end

				token_buffer.append_character ('%B')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 828 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 828")
end

				token_buffer.append_character ('%C')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 831 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 831")
end

				token_buffer.append_character ('%D')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 834 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 834")
end

				token_buffer.append_character ('%F')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

				token_buffer.append_character ('%H')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 840 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 840")
end

				token_buffer.append_character ('%L')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 843 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 843")
end

				token_buffer.append_character ('%N')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 846 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 846")
end

				token_buffer.append_character ('%Q')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 849 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 849")
end

				token_buffer.append_character ('%R')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 852 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 852")
end

				token_buffer.append_character ('%S')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 855 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 855")
end

				token_buffer.append_character ('%T')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 858 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 858")
end

				token_buffer.append_character ('%U')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 861 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 861")
end

				token_buffer.append_character ('%V')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 864 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 864")
end

				token_buffer.append_character ('%%')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 867 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 867")
end

				token_buffer.append_character ('%'')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 870 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 870")
end

				token_buffer.append_character ('%"')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 873 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 873")
end

				token_buffer.append_character ('%(')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 876 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 876")
end

				token_buffer.append_character ('%)')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 879 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 879")
end

				token_buffer.append_character ('%<')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 882 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 882")
end

				token_buffer.append_character ('%>')
			
when 194 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 885 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 885")
end

				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 195 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 888 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 888")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			
when 196 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 892 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 892")
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
			
when 197 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 907 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 907")
end

					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 198 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 912 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 912")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 199 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 930 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 930")
end

				report_unknown_token_error (text_item (1))
			
when 200 then
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

			   68,   69,   68,  541,   70,   68,   69,   68,  407,   70,
			   75,   76,   75,   75,   76,   75,   77,  100,   77,  101,
			  102,  104,  106,  105,  105,  105,  115,  116,  126,  107,
			  103,  146,  108,  151,  109,  109,  110,  108,  152,  109,
			  109,  110,  117,  118,  108,  111,  110,  110,  110,  132,
			  111,  137,  157,  160,  501,  138,   71,  153,  473,  133,
			  126,   71,  345,  146,  161,  151,  190,  112,  139,  194,
			  152,   77,  154,   77,  113,  344,  343,  111,  134,  113,
			  135,  132,  111,  137,  157,  160,  113,  138,   71,  153,
			  136,  133,  342,   71,   80,   81,  161,   82,   81,  112,

			  139,  341,   83,   84,  154,   85,  202,   86,  144,  340,
			  134,  158,  135,   87,  145,   88,  121,   81,   89,  256,
			  127,  122,  136,  123,  128,  159,   90,  129,  124,  125,
			  130,   91,   92,  131,  259,  192,  190,  192,  202,  191,
			  144,   93,  339,  158,   94,   95,  145,   96,  121,  338,
			   89,  256,  127,  122,  337,  123,  128,  159,   90,  129,
			  124,  125,  130,   91,   92,  131,  259,  140,  155,  147,
			  197,  198,  197,   93,  141,  142,   97,   81,  156,  148,
			  143,  149,  255,  255,  255,  150,  199,   79,   79,   82,
			   79,  193,  200,  190,  203,   82,  191,   82,  260,  140,

			  155,  147,  204,  479,  336,   82,  141,  142,  335,  334,
			  156,  148,  143,  149,  311,  311,  311,  150,  166,  166,
			  166,  205,  167,  193,   82,  168,  333,  169,  170,  171,
			  260,  199,  332,  331,   82,  172,   97,  206,  330,  328,
			   82,  173,  201,  174,   97,  113,  175,  176,  177,  178,
			  207,  179,   97,  180,  327,  208,  326,  181,   82,  182,
			  325,  261,  183,  184,  185,  186,  187,  188,   97,  214,
			  210,   97,  262,   82,  201,  209,   97,  199,  263,  199,
			   82,   97,   82,  199,   97,  199,   82,   97,   82,  199,
			  211,  221,   82,  261,   82,  217,  218,  217,  324,  199,

			  196,  214,   82,   97,  262,   97,  264,  247,  247,  247,
			  263,  265,  165,   97,  212,  213,  266,  246,  267,   97,
			   97,  248,  257,  216,  215,  258,  270,   97,  249,   97,
			  250,  250,  250,   97,  223,   97,   78,   97,  264,   97,
			  220,   97,  190,  265,  251,  194,  212,  213,  266,   97,
			  267,  219,   97,  248,  257,  216,  215,  258,  270,   97,
			  275,   97,  217,  218,  217,   97,  199,   97,  268,   82,
			  276,   97,  269,   97,  271,  108,  251,  252,  252,  253,
			  108,   97,  253,  253,  253,  196,  277,  273,  111,  272,
			  165,  274,  275,  278,  279,  284,  280,  287,  281,  285,

			  268,  288,  276,  289,  269,  290,  271,  291,  300,  282,
			  298,  286,  283,  301,  299,  302,   97,  113,  277,  273,
			  111,  272,  113,  274,  163,  278,  279,  284,  280,  287,
			  281,  285,  306,  288,  307,  289,  162,  290,  119,  291,
			  300,  282,  298,  286,  283,  301,  299,  302,   97,  224,
			  308,  114,  225,   78,  226,  227,  228,  192,  190,  192,
			  586,  191,  229,   73,  306,  309,  307,  303,  230,   73,
			  231,  356,  304,  232,  233,  234,  235,  586,  236,  586,
			  237,  586,  308,  305,  238,  292,  239,  293,  586,  240,
			  241,  242,  243,  244,  245,  294,  586,  309,  295,  303,

			  296,  297,  586,  356,  304,  166,  166,  166,  197,  198,
			  197,  313,  310,  193,   82,  305,  357,  292,  586,  293,
			   79,  217,  218,  217,  586,  200,  314,  294,   82,   82,
			  295,  586,  296,  297,  312,  218,  312,  315,  586,  199,
			   82,  199,   82,  586,   82,  193,  586,  199,  357,  319,
			   82,  320,  322,  199,   82,   82,   82,  586,  586,  323,
			  358,   97,   82,  217,  218,  217,  316,  199,  359,  586,
			   82,  329,  329,  329,  586,  201,   97,  355,  355,  355,
			  317,  346,  346,  346,  360,  586,  586,   97,  202,   97,
			  318,   97,  358,   97,  321,  248,  586,   97,  316,  586,

			  359,   97,   97,   97,  349,  349,  349,  201,   97,   97,
			  586,  586,  317,  361,  586,  362,  360,   97,  350,   97,
			  202,   97,  318,   97,  586,  586,  321,  248,  108,   97,
			  354,  354,  354,   97,   97,   97,  363,  347,  586,  347,
			  364,   97,  348,  348,  348,  361,  351,  362,  351,   97,
			  350,  352,  352,  352,  108,  365,  353,  353,  354,  366,
			  367,  368,  369,  371,  586,  372,  373,  111,  363,  374,
			  113,  376,  364,  377,  378,  379,  370,  380,  381,  382,
			  383,  384,  375,  385,  386,  387,  389,  365,  388,  390,
			  391,  366,  367,  368,  369,  371,  113,  372,  373,  111,

			  392,  374,  395,  376,  396,  377,  378,  379,  370,  380,
			  381,  382,  383,  384,  375,  385,  386,  387,  389,  393,
			  388,  390,  391,  397,  398,  399,  400,  401,  402,  403,
			  404,  405,  392,  406,  395,  586,  396,  394,  407,  408,
			  408,  408,  312,  218,  312,  409,  423,  410,  586,  199,
			   82,  393,   82,  586,  586,  397,  398,  399,  400,  401,
			  402,  403,  404,  405,  412,  406,  586,   82,  414,  394,
			  199,   82,  586,   82,  415,  329,  329,  329,  423,  416,
			  416,  416,  586,  586,  411,  348,  348,  348,  348,  348,
			  348,  586,  424,  248,  425,  426,  202,   97,  413,   97,

			  586,  418,  418,  418,  419,  586,  419,  586,  586,  420,
			  420,  420,  586,  427,   97,  350,  411,  428,   97,  417,
			   97,  352,  352,  352,  424,  248,  425,  426,  202,   97,
			  413,   97,  352,  352,  352,  421,  429,  353,  353,  354,
			  421,  430,  354,  354,  354,  427,   97,  350,  111,  428,
			   97,  431,   97,  422,  422,  422,  432,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  429,  444,
			  445,  446,  447,  430,  448,  449,  475,  475,  475,  453,
			  111,  454,  455,  431,  456,  457,  458,  459,  432,  433,
			  434,  435,  436,  437,  438,  439,  440,  441,  442,  443,

			  460,  444,  445,  446,  447,  461,  448,  449,  450,  450,
			  450,  453,  451,  454,  455,  462,  456,  457,  458,  459,
			  463,  464,  465,  452,  466,  467,  468,  407,  469,  469,
			  469,  199,  460,  199,   82,  199,   82,  461,   82,  480,
			  481,  416,  416,  416,  420,  420,  420,  462,  476,  476,
			  476,  586,  463,  464,  465,  474,  466,  467,  468,  420,
			  420,  420,  350,  482,  249,  471,  476,  476,  476,  483,
			  472,  480,  481,  484,  470,  485,  486,  487,  488,  489,
			  478,   97,  490,   97,  491,   97,  492,  474,  477,  493,
			  494,  495,  496,  497,  350,  482,  498,  471,  499,  586,

			  586,  483,  472,  586,  502,  484,  470,  485,  486,  487,
			  488,  489,  478,   97,  490,   97,  491,   97,  492,  503,
			  504,  493,  494,  495,  496,  497,  505,  506,  498,  507,
			  499,  450,  450,  450,  508,  500,  502,  509,  510,  511,
			  512,  513,  514,  586,  199,  199,  452,   82,   82,  527,
			  199,  503,  504,   82,  523,  523,  523,  586,  505,  506,
			  528,  507,  520,  520,  520,  586,  508,  529,  586,  509,
			  510,  511,  512,  513,  514,  515,  521,  518,  516,  518,
			  530,  527,  519,  519,  519,  586,  531,  517,  476,  476,
			  476,  524,  528,  524,   97,   97,  525,  525,  525,  529,

			   97,  532,  522,  523,  523,  523,  533,  515,  521,  534,
			  516,  535,  530,  536,  537,  538,  539,  526,  531,  517,
			  540,  542,  543,  544,  545,  546,   97,   97,  547,  548,
			  586,  561,   97,  532,  522,  586,  199,  199,  533,   82,
			   82,  534,  586,  535,  586,  536,  537,  538,  539,  526,
			  562,  586,  540,  542,  543,  544,  545,  546,  586,  563,
			  547,  548,  199,  561,  549,   82,  519,  519,  519,  519,
			  519,  519,  586,  586,  552,  552,  552,  564,  553,  550,
			  553,  565,  562,  554,  554,  554,   97,   97,  521,  586,
			  551,  563,  555,  566,  555,  586,  549,  556,  556,  556,

			  557,  557,  557,  525,  525,  525,  525,  525,  525,  564,
			  567,  550,   97,  565,  558,  568,  570,  571,   97,   97,
			  521,  559,  551,  559,  572,  566,  560,  560,  560,  573,
			  541,  541,  541,  574,  569,  199,  576,  577,   82,   82,
			   82,  521,  567,  581,   97,  452,  558,  568,  570,  571,
			  554,  554,  554,  554,  554,  554,  572,  556,  556,  556,
			  586,  573,  556,  556,  556,  574,  582,  417,  578,  578,
			  578,  583,  575,  521,  579,  581,  579,  584,  586,  580,
			  580,  580,  558,  586,  558,   97,   97,   97,  560,  560,
			  560,  560,  560,  560,  585,  586,  586,   82,  582,  580,

			  580,  580,  586,  583,  575,  580,  580,  580,  586,  584,
			  477,  254,  254,  254,  558,  586,  558,   97,   97,   97,
			   98,  586,   98,  586,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  586,  164,   97,  164,  164,  164,  586,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,   82,  586,
			   82,  586,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,  586,  586,  586,   97,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   67,   67,   67,   67,   67,   67,   67,   67,

			   67,   67,   67,   67,   67,   67,   67,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   79,  586,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   99,  586,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  195,  195,  195,

			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  195,   81,  586,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,  222,  586,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  102,  586,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  501,  501,  501,
			  501,  501,  501,  501,  501,  501,  501,  501,  501,  501,
			  501,  501,   11,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,

			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586, yy_Dummy>>)
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

			    5,    5,    5,  501,    5,    6,    6,    6,  469,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   38,   27,
			   25,   46,   28,   48,   28,   28,   28,   29,   49,   29,
			   29,   29,   35,   35,   30,   28,   30,   30,   30,   40,
			   29,   42,   52,   54,  452,   42,    5,   50,  415,   40,
			   38,    6,  245,   46,   55,   48,   71,   28,   42,   71,
			   49,   77,   50,   77,   28,  244,  243,   28,   41,   29,
			   41,   40,   29,   42,   52,   54,   30,   42,    5,   50,
			   41,   40,  242,    6,   16,   16,   55,   16,   16,   28,

			   42,  241,   16,   16,   50,   16,   82,   16,   45,  240,
			   41,   53,   41,   16,   45,   16,   37,   16,   16,  121,
			   39,   37,   41,   37,   39,   53,   16,   39,   37,   37,
			   39,   16,   16,   39,  123,   68,   68,   68,   82,   68,
			   45,   16,  239,   53,   16,   16,   45,   16,   37,  238,
			   16,  121,   39,   37,  237,   37,   39,   53,   16,   39,
			   37,   37,   39,   16,   16,   39,  123,   44,   51,   47,
			   75,   75,   75,   16,   44,   44,   16,   16,   51,   47,
			   44,   47,  113,  113,  113,   47,   79,   81,   81,   79,
			   81,   68,   81,  189,   83,   81,  189,   83,  124,   44,

			   51,   47,   84,  422,  236,   84,   44,   44,  235,  234,
			   51,   47,   44,   47,  172,  172,  172,   47,   66,   66,
			   66,   85,   66,   68,   85,   66,  233,   66,   66,   66,
			  124,   91,  232,  231,   91,   66,   79,   86,  230,  228,
			   86,   66,   81,   66,   83,  422,   66,   66,   66,   66,
			   86,   66,   84,   66,  227,   87,  226,   66,   87,   66,
			  225,  125,   66,   66,   66,   66,   66,   66,   79,   91,
			   88,   85,  126,   88,   81,   87,   83,   89,  127,   90,
			   89,   91,   90,   92,   84,   93,   92,   86,   93,   95,
			   88,   96,   95,  125,   96,   94,   94,   94,  224,   94,

			  195,   91,   94,   85,  126,   87,  128,  105,  105,  105,
			  127,  129,  164,   91,   89,   90,  130,  101,  131,   86,
			   88,  105,  122,   93,   92,  122,  134,   89,  108,   90,
			  108,  108,  108,   92,   99,   93,   78,   87,  128,   95,
			   95,   96,  193,  129,  108,  193,   89,   90,  130,   94,
			  131,   94,   88,  105,  122,   93,   92,  122,  134,   89,
			  137,   90,   97,   97,   97,   92,   97,   93,  132,   97,
			  138,   95,  132,   96,  135,  109,  108,  109,  109,  109,
			  110,   94,  110,  110,  110,   72,  139,  136,  109,  135,
			   63,  136,  137,  141,  142,  144,  142,  146,  142,  145,

			  132,  147,  138,  148,  132,  149,  135,  151,  154,  142,
			  153,  145,  142,  155,  153,  156,   97,  109,  139,  136,
			  109,  135,  110,  136,   61,  141,  142,  144,  142,  146,
			  142,  145,  158,  147,  159,  148,   57,  149,   36,  151,
			  154,  142,  153,  145,  142,  155,  153,  156,   97,  100,
			  160,   31,  100,   14,  100,  100,  100,  192,  192,  192,
			   11,  192,  100,    8,  158,  161,  159,  157,  100,    7,
			  100,  256,  157,  100,  100,  100,  100,    0,  100,    0,
			  100,    0,  160,  157,  100,  152,  100,  152,    0,  100,
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
			  311,  311,  312,  312,  312,  316,  356,  316,    0,  317,
			  316,  296,  317,    0,    0,  299,  300,  301,  302,  303,
			  304,  305,  306,  307,  318,  308,    0,  318,  321,  296,
			  319,  321,    0,  319,  329,  329,  329,  329,  356,  346,
			  346,  346,    0,    0,  317,  347,  347,  347,  348,  348,
			  348,    0,  357,  346,  358,  359,  312,  316,  319,  317,

			    0,  349,  349,  349,  350,    0,  350,    0,    0,  350,
			  350,  350,    0,  360,  318,  349,  317,  361,  321,  346,
			  319,  351,  351,  351,  357,  346,  358,  359,  312,  316,
			  319,  317,  352,  352,  352,  353,  362,  353,  353,  353,
			  354,  363,  354,  354,  354,  360,  318,  349,  353,  361,
			  321,  364,  319,  355,  355,  355,  365,  366,  367,  368,
			  369,  370,  371,  372,  373,  375,  376,  377,  362,  378,
			  379,  380,  381,  363,  383,  385,  417,  417,  417,  387,
			  353,  388,  389,  364,  390,  391,  392,  393,  365,  366,
			  367,  368,  369,  370,  371,  372,  373,  375,  376,  377,

			  394,  378,  379,  380,  381,  395,  383,  385,  386,  386,
			  386,  387,  386,  388,  389,  396,  390,  391,  392,  393,
			  397,  398,  401,  386,  402,  403,  404,  408,  408,  408,
			  408,  409,  394,  411,  409,  413,  411,  395,  413,  425,
			  426,  416,  416,  416,  419,  419,  419,  396,  418,  418,
			  418,    0,  397,  398,  401,  416,  402,  403,  404,  420,
			  420,  420,  418,  429,  421,  411,  421,  421,  421,  430,
			  413,  425,  426,  430,  409,  431,  433,  434,  435,  436,
			  421,  409,  437,  411,  438,  413,  440,  416,  418,  441,
			  442,  443,  445,  446,  418,  429,  447,  411,  449,    0,

			    0,  430,  413,    0,  453,  430,  409,  431,  433,  434,
			  435,  436,  421,  409,  437,  411,  438,  413,  440,  454,
			  455,  441,  442,  443,  445,  446,  456,  457,  447,  458,
			  449,  450,  450,  450,  459,  450,  453,  460,  462,  463,
			  465,  466,  468,    0,  470,  472,  450,  470,  472,  481,
			  471,  454,  455,  471,  477,  477,  477,    0,  456,  457,
			  482,  458,  475,  475,  475,    0,  459,  484,    0,  460,
			  462,  463,  465,  466,  468,  470,  475,  474,  471,  474,
			  485,  481,  474,  474,  474,    0,  486,  472,  476,  476,
			  476,  478,  482,  478,  470,  472,  478,  478,  478,  484,

			  471,  489,  476,  479,  479,  479,  491,  470,  475,  492,
			  471,  494,  485,  495,  496,  497,  498,  479,  486,  472,
			  499,  502,  504,  505,  507,  511,  470,  472,  512,  514,
			    0,  527,  471,  489,  476,    0,  515,  516,  491,  515,
			  516,  492,    0,  494,    0,  495,  496,  497,  498,  479,
			  529,    0,  499,  502,  504,  505,  507,  511,    0,  531,
			  512,  514,  517,  527,  515,  517,  518,  518,  518,  519,
			  519,  519,    0,    0,  520,  520,  520,  532,  521,  516,
			  521,  533,  529,  521,  521,  521,  515,  516,  520,    0,
			  517,  531,  522,  536,  522,    0,  515,  522,  522,  522,

			  523,  523,  523,  524,  524,  524,  525,  525,  525,  532,
			  539,  516,  517,  533,  523,  540,  542,  543,  515,  516,
			  520,  526,  517,  526,  544,  536,  526,  526,  526,  546,
			  541,  541,  541,  547,  541,  549,  550,  551,  549,  550,
			  551,  552,  539,  561,  517,  541,  523,  540,  542,  543,
			  553,  553,  553,  554,  554,  554,  544,  555,  555,  555,
			    0,  546,  556,  556,  556,  547,  567,  552,  557,  557,
			  557,  570,  549,  552,  558,  561,  558,  572,    0,  558,
			  558,  558,  557,    0,  578,  549,  550,  551,  559,  559,
			  559,  560,  560,  560,  575,    0,    0,  575,  567,  579,

			  579,  579,    0,  570,  549,  580,  580,  580,    0,  572,
			  578,  603,  603,  603,  557,    0,  578,  549,  550,  551,
			  592,    0,  592,    0,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,    0,  595,  575,  595,  595,  595,    0,  595,
			  595,  595,  595,  595,  595,  595,  595,  595,  600,    0,
			  600,    0,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  600,  600,    0,    0,    0,  575,  587,  587,  587,
			  587,  587,  587,  587,  587,  587,  587,  587,  587,  587,
			  587,  587,  588,  588,  588,  588,  588,  588,  588,  588,

			  588,  588,  588,  588,  588,  588,  588,  589,  589,  589,
			  589,  589,  589,  589,  589,  589,  589,  589,  589,  589,
			  589,  589,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  591,    0,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  593,    0,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  596,  596,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  597,  597,  597,  597,  597,  597,  597,  597,
			  597,  597,  597,  597,  597,  597,  597,  598,  598,  598,

			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  599,    0,  599,  599,  599,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  599,  601,    0,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  602,    0,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,

			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  566,  560,  108,
			  111,  560, 1672,  114,  550, 1672,  188,    0, 1672,  108,
			 1672, 1672, 1672, 1672, 1672,  103,  103,  103,  114,  119,
			  126,  525, 1672,  101, 1672,  116,  512,  180,   90,  183,
			  115,  137,  121,    0,  232,  170,   87,  238,   86,  104,
			  123,  231,  109,  181,  116,  120, 1672,  479, 1672, 1672,
			 1672,  433, 1672,  484, 1672, 1672,  316,   91,  233, 1672,
			 1672,  163,  482, 1672, 1672,  268, 1672,  169,  433,  280,
			 1672,  286,  150,  288,  296,  315,  331,  349,  364,  371,
			  373,  325,  377,  379,  393,  383,  385,  460,    0,  423,

			  543,  406,    0, 1672, 1672,  387, 1672, 1672,  410,  457,
			  462, 1672,    0,  262, 1672, 1672, 1672, 1672, 1672, 1672,
			    0,  185,  384,  201,  250,  312,  323,  344,  376,  368,
			  382,  371,  437,    0,  378,  441,  442,  419,  440,  442,
			    0,  448,  461,    0,  455,  467,  448,  453,  470,  473,
			    0,  473,  552,  469,  461,  479,  465,  534,  485,  496,
			  516,  518, 1672, 1672,  406, 1672,  603, 1672, 1672, 1672,
			 1672, 1672,  294, 1672, 1672, 1672, 1672, 1672, 1672, 1672,
			 1672, 1672, 1672, 1672, 1672, 1672, 1672, 1672, 1672,  290,
			 1672, 1672,  555,  439, 1672,  397, 1672,  606, 1672, 1672,

			 1672,  619,  632, 1672, 1672, 1672, 1672,  605, 1672,  620,
			 1672,  631,  633,  635,  641,  645,  647,  661, 1672,  646,
			  653, 1672, 1672, 1672,  387,  349,  345,  343,  328,  651,
			  327,  322,  321,  315,  298,  297,  293,  243,  238,  231,
			  198,  190,  181,  165,  164,  151, 1672,  661,  722, 1672,
			  684,  731,  736,  710,    0,  657,  528,  586,    0,    0,
			  622,  621,    0,  652,  665,  664,  706,  693,  705,  725,
			  726,    0,  711,  732,  729,  717,  717,  727,  730,  739,
			  736,  741,  732,  748,  745,  750,  736,    0,  739,    0,
			  750,  753,  752,  755,  760,  750,  787,  755,  770,  793,

			  786,  782,  792,  793,  782,  791,  792,  798,  790,    0,
			 1672,  819,  840, 1672, 1672, 1672,  841,  843,  858,  864,
			 1672,  862, 1672, 1672, 1672, 1672, 1672, 1672, 1672,  855,
			 1672, 1672, 1672, 1672, 1672, 1672, 1672, 1672, 1672, 1672,
			 1672, 1672, 1672, 1672, 1672, 1672,  859,  865,  868,  881,
			  889,  901,  912,  917,  922,  933,  797,  844,  858,  857,
			  873,  869,  902,  892,  917,  920,  910,  920,  912,  917,
			  914,  915,  929,  914,    0,  931,  928,  914,  916,  923,
			  937,  925,    0,  933,    0,  934, 1006,  929,  943,  947,
			  937,  943,  948,  937,  959,  951,  983,  973,  976,    0,

			    0,  987,  974,  984,  996,    0,    0, 1672, 1008, 1025,
			 1672, 1027, 1672, 1029, 1672,  147, 1021,  956, 1028, 1024,
			 1039, 1046,  285,    0,    0,  996, 1009,    0,    0, 1016,
			 1035, 1032,    0, 1029, 1042, 1044, 1046, 1033, 1041,    0,
			 1039, 1046, 1056, 1053,    0, 1054, 1061, 1058,    0, 1064,
			 1129, 1672,  137, 1057, 1066, 1082, 1092, 1093, 1082, 1100,
			 1088,    0, 1089, 1109,    0, 1102, 1107,    0, 1099,   89,
			 1138, 1144, 1139, 1672, 1162, 1142, 1168, 1134, 1176, 1183,
			    0, 1099, 1111,    0, 1123, 1131, 1152,    0,    0, 1167,
			    0, 1176, 1175,    0, 1163, 1170, 1165, 1166, 1186, 1171,

			 1672,  100, 1173,    0, 1179, 1180,    0, 1190,    0,    0,
			    0, 1176, 1185,    0, 1180, 1230, 1231, 1256, 1246, 1249,
			 1254, 1263, 1277, 1280, 1283, 1286, 1306, 1182,    0, 1207,
			    0, 1226, 1244, 1240,    0,    0, 1257,    0,    0, 1267,
			 1281, 1328, 1272, 1283, 1292,    0, 1295, 1299,    0, 1329,
			 1330, 1331, 1307, 1330, 1333, 1337, 1342, 1348, 1359, 1368,
			 1371, 1309,    0,    0,    0,    0,    0, 1317,    0, 1672,
			 1324,    0, 1343,    0,    0, 1388, 1672, 1672, 1350, 1379,
			 1385,    0,    0,    0,    0, 1672, 1672, 1476, 1491, 1506,
			 1521, 1536, 1417, 1551, 1426, 1442, 1566, 1581, 1596, 1611,

			 1457, 1626, 1641, 1404, 1656, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  586,    1,  587,  587,  588,  588,  589,  589,  590,
			  590,  586,  586,  586,  586,  586,  591,  592,  586,  593,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  586,  586,  586,  586,
			  586,  586,  586,  595,  586,  586,  586,  596,  596,  586,
			  586,  597,  598,  586,  586,  586,  586,  586,  586,  591,
			  586,  599,  600,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  591,  591,  592,  601,

			  601,  601,  602,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  603,  586,  586,  586,  586,  586,  586,  586,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  586,  586,  595,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  596,
			  586,  586,  596,  597,  586,  598,  586,  586,  586,  586,

			  586,  599,  600,  586,  586,  586,  586,  591,  586,  591,
			  586,  591,  591,  591,  591,  591,  591,  591,  586,  591,
			  591,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  603,  586,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,

			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  586,  586,  600,  586,  586,  586,  591,  591,  591,  591,
			  586,  591,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,

			  594,  594,  594,  594,  594,  594,  594,  586,  586,  591,
			  586,  591,  586,  591,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  586,  586,  586,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  586,
			  591,  591,  591,  586,  586,  586,  586,  586,  586,  586,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,

			  586,  604,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  591,  591,  591,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  586,  594,  594,  594,  594,  594,  594,  594,  591,
			  591,  591,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  594,  594,  594,  594,  594,  594,  594,  594,  586,
			  594,  594,  594,  594,  594,  591,  586,  586,  586,  586,
			  586,  594,  594,  594,  594,  586,    0,  586,  586,  586,
			  586,  586,  586,  586,  586,  586,  586,  586,  586,  586,

			  586,  586,  586,  586,  586, yy_Dummy>>)
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
			  484,  484,  484,  485,  486,  487,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  500,  501,
			  502,  503,  504,  505,  506,  508,  509,  510,  511,  512,
			  513,  514,  515,  517,  518,  520,  521,  523,  524,  525,
			  526,  527,  528,  529,  530,  531,  532,  533,  534,  535,

			  537,  539,  540,  541,  542,  543,  545,  547,  548,  548,
			  549,  551,  552,  554,  555,  557,  558,  559,  559,  560,
			  560,  561,  562,  563,  565,  567,  568,  569,  571,  573,
			  574,  575,  576,  578,  579,  580,  581,  582,  583,  584,
			  586,  587,  588,  589,  590,  592,  593,  594,  595,  597,
			  598,  598,  599,  599,  600,  601,  602,  603,  604,  605,
			  606,  607,  609,  610,  611,  613,  614,  615,  617,  618,
			  618,  619,  620,  621,  622,  622,  623,  624,  624,  624,
			  625,  627,  628,  629,  631,  632,  633,  634,  636,  638,
			  639,  641,  642,  643,  645,  646,  647,  648,  649,  650,

			  651,  653,  653,  654,  656,  657,  658,  660,  661,  663,
			  665,  667,  668,  669,  671,  672,  673,  674,  675,  675,
			  676,  677,  677,  677,  678,  678,  679,  679,  680,  682,
			  683,  685,  686,  687,  688,  690,  692,  693,  695,  697,
			  698,  699,  699,  700,  701,  702,  704,  705,  706,  708,
			  709,  710,  711,  712,  712,  713,  713,  714,  715,  715,
			  715,  716,  717,  719,  721,  723,  725,  727,  728,  730,
			  731,  732,  734,  735,  737,  739,  740,  742,  744,  745,
			  745,  746,  748,  750,  752,  754,  756,  756, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  168,  168,  170,  170,  201,  199,  200,    2,  199,
			  200,    3,  200,   33,  199,  200,  171,  199,  200,   38,
			  199,  200,   12,  199,  200,  138,  199,  200,   21,  199,
			  200,   22,  199,  200,   29,  199,  200,   27,  199,  200,
			    6,  199,  200,   28,  199,  200,   11,  199,  200,   30,
			  199,  200,  109,  111,  199,  200,  109,  111,  199,  200,
			  109,  111,  199,  200,    5,  199,  200,    4,  199,  200,
			   16,  199,  200,   15,  199,  200,   17,  199,  200,    8,
			  199,  200,  107,  199,  200,  107,  199,  200,  107,  199,
			  200,  107,  199,  200,  107,  199,  200,  107,  199,  200,

			  107,  199,  200,  107,  199,  200,  107,  199,  200,  107,
			  199,  200,  107,  199,  200,  107,  199,  200,  107,  199,
			  200,  107,  199,  200,  107,  199,  200,  107,  199,  200,
			  107,  199,  200,  107,  199,  200,  107,  199,  200,   25,
			  199,  200,  199,  200,   26,  199,  200,   31,  199,  200,
			   23,  199,  200,   24,  199,  200,    9,  199,  200,  172,
			  200,  198,  200,  196,  200,  197,  200,  168,  200,  168,
			  200,  167,  200,  166,  200,  168,  200,  170,  200,  169,
			  200,  164,  200,  164,  200,  163,  200,    2,    3,  171,
			  160,  171,  171,  171,  171,  171,  171,  171,  171,  171,

			  171,  171,  171,  171, -362,  171,  171,  171, -362,   38,
			  138,  138,  138,    1,   32,    7,  113,   36,   20,  113,
			  109,  111,  109,  111,  108,   13,   34,   18,   19,   35,
			   14,  107,  107,  107,  107,   43,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,   55,  107,  107,  107,  107,
			  107,  107,  107,   67,  107,  107,  107,   74,  107,  107,
			  107,  107,  107,  107,  107,   85,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,   37,   10,
			  172,  196,  189,  187,  188,  190,  191,  192,  193,  173,
			  174,  175,  176,  177,  178,  179,  180,  181,  182,  183,

			  184,  185,  186,  168,  167,  166,  168,  168,  165,  166,
			  170,  169,  163,  161,  159,  161,  171, -362, -362,  146,
			  161,  144,  161,  145,  161,  147,  161,  171,  140,  161,
			  171,  141,  161,  171,  171,  171,  171,  171,  171,  171,
			 -162,  171,  171,  148,  161,  138,  114,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  115,  138,  113,  110,  113,  109,  111,  109,  111,  112,
			  107,  107,   41,  107,   42,  107,  107,  107,   46,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,   58,  107,

			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,   78,  107,  107,   80,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  106,
			  107,  195,  149,  161,  142,  161,  143,  161,  171,  171,
			  171,  171,  156,  161,  171,  151,  161,  150,  161,  132,
			  130,  131,  133,  134,  139,  135,  136,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  113,  113,  113,  113,  109,  109,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,   56,  107,

			  107,  107,  107,  107,  107,  107,   65,  107,  107,  107,
			  107,  107,  107,  107,  107,   75,  107,  107,   77,  107,
			  107,   84,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,   98,  107,   99,  107,  107,
			  107,  107,  107,  104,  107,  105,  107,  194,  171,  152,
			  161,  171,  155,  161,  171,  158,  161,  139,  113,  113,
			  113,  113,  111,   39,  107,   40,  107,  107,  107,   47,
			  107,   48,  107,  107,  107,  107,   53,  107,  107,  107,
			  107,  107,  107,  107,   63,  107,  107,  107,  107,  107,
			   70,  107,  107,  107,  107,   76,  107,  107,   81,  107,

			  107,  107,  107,  107,  107,  107,  107,   94,  107,  107,
			  107,   97,  107,  107,  107,  102,  107,  107,  171,  171,
			  171,  137,  113,  113,  113,   44,  107,  107,  107,   50,
			  107,  107,  107,  107,   57,  107,   59,  107,  107,   61,
			  107,  107,  107,   66,  107,  107,  107,  107,  107,  107,
			  107,   82,   83,  107,   87,  107,  107,  107,   90,  107,
			  107,   92,  107,   93,  107,   95,  107,  107,  107,  101,
			  107,  107,  171,  171,  171,  113,  113,  113,  113,  107,
			   49,  107,  107,   52,  107,  107,  107,  107,   64,  107,
			   68,  107,  107,   71,  107,   72,  107,  107,  107,  107,

			  107,  107,   91,  107,  107,  107,  103,  107,  171,  171,
			  171,  113,  113,  113,  113,  113,  107,   51,  107,   54,
			  107,   60,  107,   62,  107,   69,  107,  107,   79,  107,
			   83,  107,   88,  107,  107,   96,  107,  100,  107,  171,
			  154,  161,  157,  161,  113,  113,   45,  107,   73,  107,
			   86,  107,   89,  107,  153,  161, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1672
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 586
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 587
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

	yyNb_rules: INTEGER is 200
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 201
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
