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

				last_token := TE_ASSIGNMENT
			
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
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 299 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 299")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `note', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 80 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 308 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 308")
end

				last_token := TE_OBSOLETE
			
when 81 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 311 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 311")
end

				last_token := TE_OLD
			
when 82 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 326 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 326")
end

				last_token := TE_ONCE_STRING
			
when 83 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 329 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 329")
end

				last_token := TE_ONCE_STRING
			
when 84 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 332 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 332")
end

				last_token := TE_ONCE_STRING
			
when 85 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 335 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 335")
end

				last_token := TE_ONCE
			
when 86 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 338 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 338")
end

				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 87 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 347 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 347")
end

				last_token := TE_OR
			
when 88 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 350 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 350")
end

				last_token := TE_PRECURSOR
				last_location_as_value := ast_factory.new_location_as (line, column, position, 9)
			
when 89 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 354 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 354")
end

				last_token := TE_PREFIX
			
when 90 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 357 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 357")
end

				last_token := TE_REDEFINE
			
when 91 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 360 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 360")
end

				last_token := TE_REFERENCE
			
when 92 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 363 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 363")
end

				last_token := TE_RENAME
			
when 93 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 366 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 366")
end

				last_token := TE_REQUIRE
			
when 94 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 369 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 369")
end

				last_token := TE_RESCUE
			
when 95 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 372 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 372")
end

				last_token := TE_RESULT
				last_result_as_value := ast_factory.new_result_as (line, column, position, 6)
			
when 96 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 376 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 376")
end

				last_token := TE_RETRY
				last_retry_as_value := ast_factory.new_retry_as (line, column, position, 5)
			
when 97 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 380 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 380")
end

				last_token := TE_SELECT
			
when 98 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 383 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 383")
end

				last_token := TE_SEPARATE
			
when 99 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 386 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 386")
end

				last_token := TE_STRIP
			
when 100 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 389 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 389")
end

				last_token := TE_THEN
			
when 101 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 392 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 392")
end

				last_token := TE_TRUE
				last_bool_as_value := ast_factory.new_boolean_as (True, line, column, position, 4)
			
when 102 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 396 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 396")
end

				last_token := TE_UNDEFINE
			
when 103 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 399 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 399")
end

				last_token := TE_UNIQUE
				last_unique_as_value := ast_factory.new_unique_as (line, column, position, 6)
			
when 104 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 403 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 403")
end

				last_token := TE_UNTIL
			
when 105 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 406 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 406")
end

				last_token := TE_VARIANT
			
when 106 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 409 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 409")
end

				last_token := TE_VOID
				last_void_as_value := ast_factory.new_void_as (line, column, position, 4)
			
when 107 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 413 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 413")
end

				last_token := TE_WHEN
			
when 108 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 416 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 416")
end

				last_token := TE_XOR
			
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 423 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 423")
end

				last_token := TE_ID
				process_id_as
			
when 110 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 431 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 431")
end

				last_token := TE_A_BIT
				last_id_as_value := ast_factory.new_filled_id_as (line, column,
					position, text_count - 1)
				if last_id_as_value /= Void then
					append_text_substring_to_string (1, text_count - 1, last_id_as_value)
				end
			
when 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 443 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 443")
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
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
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
--|#line 456 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 456")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 462 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 462")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 470 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 470")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				last_token := TE_REAL
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 482 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 482")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
			
when 117 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 487 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 487")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 493 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 493")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 498 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 498")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 503 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 503")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 508 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 508")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 513 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 513")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 518 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 518")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 523 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 523")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 528 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 528")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 533 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 533")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 538 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 538")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 543 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 543")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 548 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 548")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 553 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 553")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 558 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 558")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 563 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 563")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 568 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 568")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 573 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 573")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 578 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 578")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 583 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 583")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 588 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 588")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
			
when 138 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 593 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 593")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
			
when 139 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 598 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 598")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 601 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 601")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 141 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 602 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 602")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 142 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 611 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 611")
end

				last_token := TE_STR_LT
			
when 143 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 614 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 614")
end

				last_token := TE_STR_GT
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 617 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 617")
end

				last_token := TE_STR_LE
			
when 145 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end

				last_token := TE_STR_GE
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 623 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 623")
end

				last_token := TE_STR_PLUS
			
when 147 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

				last_token := TE_STR_MINUS
			
when 148 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 629 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 629")
end

				last_token := TE_STR_STAR
			
when 149 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 632 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 632")
end

				last_token := TE_STR_SLASH
			
when 150 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 635 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 635")
end

				last_token := TE_STR_POWER
			
when 151 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 638 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 638")
end

				last_token := TE_STR_DIV
			
when 152 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 641 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 641")
end

				last_token := TE_STR_MOD
			
when 153 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 644 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 644")
end

				last_token := TE_STR_BRACKET
			
when 154 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 647 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 647")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 155 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 652 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 652")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 156 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 657 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 657")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 157 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 662 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 662")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 158 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 667 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 667")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 159 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 672 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 672")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 160 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 677 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 677")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 161 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 682 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 682")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 162 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 690 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 690")
end

					-- Empty string.
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 163 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 695 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 695")
end

					-- Regular string.
				string_position := position
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 164 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 705 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 705")
end

					-- Verbatim string.
				string_position := position
				token_buffer.clear_all
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				set_start_condition (VERBATIM_STR3)
			
when 165 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 721 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 721")
end

				set_start_condition (VERBATIM_STR1)
			
when 166 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 724 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 724")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 167 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
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
			
when 168 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 785 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 785")
end

				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 169 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 789 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 789")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 170 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 796 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 796")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 171 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 811 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 811")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 831 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 831")
end

					-- String with special characters.
				string_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 174 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

				append_text_to_string (token_buffer)
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 844 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 844")
end

				token_buffer.append_character ('%A')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 847 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 847")
end

				token_buffer.append_character ('%B')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 850 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 850")
end

				token_buffer.append_character ('%C')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 853 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 853")
end

				token_buffer.append_character ('%D')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 856 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 856")
end

				token_buffer.append_character ('%F')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 859 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 859")
end

				token_buffer.append_character ('%H')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 862 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 862")
end

				token_buffer.append_character ('%L')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 865 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 865")
end

				token_buffer.append_character ('%N')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 868 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 868")
end

				token_buffer.append_character ('%Q')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 871 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 871")
end

				token_buffer.append_character ('%R')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 874 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 874")
end

				token_buffer.append_character ('%S')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 877 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 877")
end

				token_buffer.append_character ('%T')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 880 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 880")
end

				token_buffer.append_character ('%U')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 883 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 883")
end

				token_buffer.append_character ('%V')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 886 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 886")
end

				token_buffer.append_character ('%%')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 889 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 889")
end

				token_buffer.append_character ('%'')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 892 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 892")
end

				token_buffer.append_character ('%"')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 895 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 895")
end

				token_buffer.append_character ('%(')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 898 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 898")
end

				token_buffer.append_character ('%)')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 901 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 901")
end

				token_buffer.append_character ('%<')
			
when 195 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 904 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 904")
end

				token_buffer.append_character ('%>')
			
when 196 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 907 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 907")
end

				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 197 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 910 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 910")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			
when 198 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 914 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 914")
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
			
when 199 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 929 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 929")
end

					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 200 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 934 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 934")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 201 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 952 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 952")
end

				report_unknown_token_error (text_item (1))
			
when 202 then
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

			   68,   69,   68,  545,   70,   68,   69,   68,  411,   70,
			   75,   76,   75,   75,   76,   75,   77,  100,   77,  101,
			  102,  104,  106,  105,  105,  105,  115,  116,  126,  107,
			  103,  146,  108,  151,  109,  109,  110,  108,  152,  109,
			  109,  110,  117,  118,  108,  111,  110,  110,  110,  132,
			  111,  137,  157,  160,  505,  138,   71,  153,  477,  133,
			  126,   71,  356,  146,  161,  151,  190,  112,  139,  194,
			  152,   77,  154,   77,  113,  356,  346,  111,  134,  113,
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

			  155,  147,  204,  483,  339,   82,  141,  142,  338,  337,
			  156,  148,  143,  149,  312,  312,  312,  150,  166,  166,
			  166,  205,  167,  193,   82,  168,  336,  169,  170,  171,
			  260,  199,  335,  334,   82,  172,   97,  206,  333,  332,
			   82,  173,  201,  174,   97,  113,  175,  176,  177,  178,
			  207,  179,   97,  180,  331,  208,  329,  181,   82,  182,
			  328,  261,  183,  184,  185,  186,  187,  188,   97,  214,
			  210,   97,  262,   82,  201,  209,   97,  199,  263,  199,
			   82,   97,   82,  199,   97,  199,   82,   97,   82,  199,
			  211,  221,   82,  261,   82,  217,  218,  217,  327,  199,

			  326,  214,   82,   97,  262,   97,  264,  247,  247,  247,
			  263,  265,  325,   97,  212,  213,  266,  196,  267,   97,
			   97,  248,  257,  216,  215,  258,  270,   97,  249,   97,
			  250,  250,  250,   97,  165,   97,  246,   97,  264,   97,
			  220,   97,  190,  265,  251,  194,  212,  213,  266,   97,
			  267,  219,   97,  248,  257,  216,  215,  258,  270,   97,
			  275,   97,  217,  218,  217,   97,  199,   97,  268,   82,
			  276,   97,  269,   97,  271,  108,  251,  252,  252,  253,
			  108,   97,  253,  253,  253,  223,  277,  273,  111,  272,
			   78,  274,  275,  278,  279,  284,  280,  287,  281,  285,

			  268,  288,  276,  289,  269,  290,  271,  292,  301,  282,
			  302,  286,  283,  303,  291,  196,   97,  113,  277,  273,
			  111,  272,  113,  274,  165,  278,  279,  284,  280,  287,
			  281,  285,  307,  288,  308,  289,  163,  290,  162,  292,
			  301,  282,  302,  286,  283,  303,  291,  299,   97,  224,
			  309,  300,  225,  119,  226,  227,  228,  192,  190,  192,
			  314,  191,  229,   82,  307,  310,  308,  114,  230,   78,
			  231,  358,  304,  232,  233,  234,  235,  305,  236,  299,
			  237,  590,  309,  300,  238,  293,  239,  294,  306,  240,
			  241,  242,  243,  244,  245,  295,  315,  310,  296,   82,

			  297,  298,   73,  358,  304,  166,  166,  166,  316,  305,
			   97,   82,  311,  193,  197,  198,  197,  293,   73,  294,
			  306,   79,  217,  218,  217,  199,  200,  295,   82,   82,
			  296,  590,  297,  298,  313,  218,  313,  323,  590,  590,
			   82,  199,   97,  590,   82,  193,   97,  359,  590,  320,
			  199,  321,  317,   82,   82,  590,  199,  360,   97,   82,
			  217,  218,  217,  324,  199,  590,   82,   82,  330,  330,
			  330,  347,  347,  347,  590,   97,  201,  361,   97,  359,
			  318,  350,  350,  350,  317,  248,  362,   97,  202,  360,
			   97,   97,  363,  319,  364,  351,  365,  322,  366,  367,

			   97,   97,  357,  357,  357,  368,   97,   97,  201,  361,
			  590,  369,  318,   97,   97,  590,  590,  248,  362,   97,
			  202,  590,  590,   97,  363,  319,  364,  351,  365,  322,
			  366,  367,   97,   97,  348,  370,  348,  368,   97,  349,
			  349,  349,  352,  369,  352,   97,   97,  353,  353,  353,
			  108,  373,  354,  354,  355,  108,  371,  355,  355,  355,
			  590,  374,  375,  111,  376,  590,  378,  370,  379,  380,
			  372,  381,  382,  383,  384,  385,  386,  377,  387,  388,
			  389,  390,  391,  373,  393,  392,  394,  395,  371,  396,
			  399,  400,  113,  374,  375,  111,  376,  113,  378,  401,

			  379,  380,  372,  381,  382,  383,  384,  385,  386,  377,
			  387,  388,  389,  390,  391,  397,  393,  392,  394,  395,
			  402,  396,  399,  400,  403,  404,  405,  406,  407,  408,
			  409,  401,  410,  398,  411,  412,  412,  412,  313,  218,
			  313,  413,  590,  414,  590,  199,   82,  397,   82,  590,
			  416,  199,  402,   82,   82,  427,  403,  404,  405,  406,
			  407,  408,  409,  418,  410,  398,   82,  419,  330,  330,
			  330,  349,  349,  349,  420,  420,  420,  590,  590,  417,
			  415,  349,  349,  349,  422,  422,  422,  427,  248,  353,
			  353,  353,  202,   97,  428,   97,  590,  423,  351,  423,

			   97,   97,  424,  424,  424,  353,  353,  353,  426,  426,
			  426,  417,  415,   97,  421,  425,  429,  354,  354,  355,
			  248,  430,  431,  432,  202,   97,  428,   97,  111,  433,
			  351,  434,   97,   97,  425,  435,  355,  355,  355,  436,
			  437,  438,  439,  440,  441,   97,  442,  443,  429,  444,
			  445,  446,  447,  430,  431,  432,  448,  449,  450,  451,
			  111,  433,  452,  434,  453,  590,  590,  435,  457,  590,
			  458,  436,  437,  438,  439,  440,  441,  459,  442,  443,
			  590,  444,  445,  446,  447,  460,  461,  462,  448,  449,
			  450,  451,  463,  464,  452,  465,  453,  454,  454,  454,

			  457,  455,  458,  466,  467,  468,  469,  470,  471,  459,
			  472,  590,  456,  411,  473,  473,  473,  460,  461,  462,
			  199,  590,  590,   82,  463,  464,  199,  465,  590,   82,
			  199,  590,  484,   82,  590,  466,  467,  468,  469,  470,
			  471,  590,  472,  420,  420,  420,  479,  479,  479,  424,
			  424,  424,  480,  480,  480,  485,  486,  478,  475,  424,
			  424,  424,  489,  474,  484,  476,  351,  490,  491,  249,
			   97,  480,  480,  480,  487,  492,   97,  493,  488,  494,
			   97,  495,  496,  497,  498,  482,  499,  485,  486,  478,
			  475,  500,  481,  501,  489,  474,  502,  476,  351,  490,

			  491,  503,   97,  590,  506,  507,  487,  492,   97,  493,
			  488,  494,   97,  495,  496,  497,  498,  482,  499,  508,
			  454,  454,  454,  500,  504,  501,  509,  510,  502,  511,
			  512,  513,  514,  503,  515,  456,  506,  507,  516,  517,
			  518,  199,  199,  199,   82,   82,   82,  522,  590,  522,
			  590,  508,  523,  523,  523,  527,  527,  527,  509,  510,
			  590,  511,  512,  513,  514,  590,  515,  590,  531,  520,
			  516,  517,  518,  519,  524,  524,  524,  590,  532,  533,
			  480,  480,  480,  534,  535,  521,  536,  537,  525,  590,
			  538,   97,   97,   97,  526,  539,  540,  528,  541,  528,

			  531,  520,  529,  529,  529,  519,  542,  527,  527,  527,
			  532,  533,  543,  544,  546,  534,  535,  521,  536,  537,
			  525,  530,  538,   97,   97,   97,  526,  539,  540,  547,
			  541,  548,  549,  550,  551,  552,  199,  590,  542,   82,
			  199,  565,  590,   82,  543,  544,  546,  199,  590,  590,
			   82,  590,  590,  530,  523,  523,  523,  523,  523,  523,
			  590,  547,  590,  548,  549,  550,  551,  552,  553,  556,
			  556,  556,  566,  565,  557,  555,  557,  567,  554,  558,
			  558,  558,  559,  525,  559,  568,   97,  560,  560,  560,
			   97,  561,  561,  561,  529,  529,  529,   97,  569,  570,

			  553,  529,  529,  529,  566,  562,  563,  555,  563,  567,
			  554,  564,  564,  564,  571,  525,  572,  568,   97,  545,
			  545,  545,   97,  573,  574,  575,  576,  577,  578,   97,
			  569,  570,  199,  580,  456,   82,   82,  562,  581,  525,
			  590,   82,  558,  558,  558,  590,  571,  585,  572,  558,
			  558,  558,  560,  560,  560,  586,  574,  575,  576,  577,
			  578,  560,  560,  560,  587,  421,  582,  582,  582,  579,
			  583,  525,  583,  588,  562,  584,  584,  584,  589,  585,
			  562,   82,   97,   97,  564,  564,  564,  586,   97,  564,
			  564,  564,  584,  584,  584,  590,  587,  584,  584,  584,

			  481,  579,  254,  254,  254,  588,  562,  590,  590,  590,
			  590,  590,  562,  590,   97,   97,  590,  590,  590,  590,
			   97,  590,  590,  590,  590,   98,  590,   98,   97,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			   97,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   72,   72,   72,   72,   72,   72,   72,   72,   72,

			   72,   72,   72,   72,   72,   72,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   79,  590,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   99,  590,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,  164,  590,  164,  164,  164,  590,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  195,  195,  195,  195,

			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,   81,  590,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   82,  590,   82,  590,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,  222,  590,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  102,  590,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  505,  505,  505,  505,  505,  505,  505,  505,  505,
			  505,  505,  505,  505,  505,  505,   11,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,

			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590, yy_Dummy>>)
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

			    5,    5,    5,  505,    5,    6,    6,    6,  473,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   38,   27,
			   25,   46,   28,   48,   28,   28,   28,   29,   49,   29,
			   29,   29,   35,   35,   30,   28,   30,   30,   30,   40,
			   29,   42,   52,   54,  456,   42,    5,   50,  419,   40,
			   38,    6,  356,   46,   55,   48,   71,   28,   42,   71,
			   49,   77,   50,   77,   28,  254,  245,   28,   41,   29,
			   41,   40,   29,   42,   52,   54,   30,   42,    5,   50,
			   41,   40,  244,    6,   16,   16,   55,   16,   16,   28,

			   42,  243,   16,   16,   50,   16,   82,   16,   45,  242,
			   41,   53,   41,   16,   45,   16,   37,   16,   16,  121,
			   39,   37,   41,   37,   39,   53,   16,   39,   37,   37,
			   39,   16,   16,   39,  123,   68,   68,   68,   82,   68,
			   45,   16,  241,   53,   16,   16,   45,   16,   37,  240,
			   16,  121,   39,   37,  239,   37,   39,   53,   16,   39,
			   37,   37,   39,   16,   16,   39,  123,   44,   51,   47,
			   75,   75,   75,   16,   44,   44,   16,   16,   51,   47,
			   44,   47,  113,  113,  113,   47,   79,   81,   81,   79,
			   81,   68,   81,  189,   83,   81,  189,   83,  124,   44,

			   51,   47,   84,  426,  238,   84,   44,   44,  237,  236,
			   51,   47,   44,   47,  172,  172,  172,   47,   66,   66,
			   66,   85,   66,   68,   85,   66,  235,   66,   66,   66,
			  124,   91,  234,  233,   91,   66,   79,   86,  232,  231,
			   86,   66,   81,   66,   83,  426,   66,   66,   66,   66,
			   86,   66,   84,   66,  230,   87,  228,   66,   87,   66,
			  227,  125,   66,   66,   66,   66,   66,   66,   79,   91,
			   88,   85,  126,   88,   81,   87,   83,   89,  127,   90,
			   89,   91,   90,   92,   84,   93,   92,   86,   93,   95,
			   88,   96,   95,  125,   96,   94,   94,   94,  226,   94,

			  225,   91,   94,   85,  126,   87,  128,  105,  105,  105,
			  127,  129,  224,   91,   89,   90,  130,  195,  131,   86,
			   88,  105,  122,   93,   92,  122,  134,   89,  108,   90,
			  108,  108,  108,   92,  164,   93,  101,   87,  128,   95,
			   95,   96,  193,  129,  108,  193,   89,   90,  130,   94,
			  131,   94,   88,  105,  122,   93,   92,  122,  134,   89,
			  137,   90,   97,   97,   97,   92,   97,   93,  132,   97,
			  138,   95,  132,   96,  135,  109,  108,  109,  109,  109,
			  110,   94,  110,  110,  110,   99,  139,  136,  109,  135,
			   78,  136,  137,  141,  142,  144,  142,  146,  142,  145,

			  132,  147,  138,  148,  132,  149,  135,  151,  154,  142,
			  155,  145,  142,  156,  149,   72,   97,  109,  139,  136,
			  109,  135,  110,  136,   63,  141,  142,  144,  142,  146,
			  142,  145,  158,  147,  159,  148,   61,  149,   57,  151,
			  154,  142,  155,  145,  142,  156,  149,  153,   97,  100,
			  160,  153,  100,   36,  100,  100,  100,  192,  192,  192,
			  207,  192,  100,  207,  158,  161,  159,   31,  100,   14,
			  100,  256,  157,  100,  100,  100,  100,  157,  100,  153,
			  100,   11,  160,  153,  100,  152,  100,  152,  157,  100,
			  100,  100,  100,  100,  100,  152,  209,  161,  152,  209,

			  152,  152,    8,  256,  157,  166,  166,  166,  211,  157,
			  207,  211,  166,  192,  197,  197,  197,  152,    7,  152,
			  157,  201,  201,  201,  201,  212,  201,  152,  212,  201,
			  152,    0,  152,  152,  202,  202,  202,  219,    0,    0,
			  219,  213,  207,    0,  213,  192,  209,  257,    0,  215,
			  214,  215,  212,  214,  215,    0,  216,  260,  211,  216,
			  217,  217,  217,  220,  217,    0,  220,  217,  229,  229,
			  229,  247,  247,  247,    0,  212,  201,  261,  209,  257,
			  213,  250,  250,  250,  212,  247,  263,  219,  202,  260,
			  211,  213,  264,  214,  265,  250,  266,  216,  267,  268,

			  214,  215,  255,  255,  255,  269,  216,  212,  201,  261,
			    0,  270,  213,  220,  217,    0,    0,  247,  263,  219,
			  202,    0,    0,  213,  264,  214,  265,  250,  266,  216,
			  267,  268,  214,  215,  248,  272,  248,  269,  216,  248,
			  248,  248,  251,  270,  251,  220,  217,  251,  251,  251,
			  252,  274,  252,  252,  252,  253,  273,  253,  253,  253,
			    0,  275,  276,  252,  277,    0,  278,  272,  279,  280,
			  273,  281,  282,  283,  284,  285,  286,  277,  287,  288,
			  290,  291,  292,  274,  293,  292,  294,  295,  273,  296,
			  298,  299,  252,  275,  276,  252,  277,  253,  278,  300,

			  279,  280,  273,  281,  282,  283,  284,  285,  286,  277,
			  287,  288,  290,  291,  292,  297,  293,  292,  294,  295,
			  301,  296,  298,  299,  302,  303,  304,  305,  306,  307,
			  308,  300,  309,  297,  312,  312,  312,  312,  313,  313,
			  313,  317,    0,  317,    0,  318,  317,  297,  318,    0,
			  319,  320,  301,  319,  320,  358,  302,  303,  304,  305,
			  306,  307,  308,  322,  309,  297,  322,  330,  330,  330,
			  330,  348,  348,  348,  347,  347,  347,    0,    0,  320,
			  318,  349,  349,  349,  350,  350,  350,  358,  347,  352,
			  352,  352,  313,  317,  359,  318,    0,  351,  350,  351,

			  319,  320,  351,  351,  351,  353,  353,  353,  357,  357,
			  357,  320,  318,  322,  347,  354,  360,  354,  354,  354,
			  347,  361,  362,  363,  313,  317,  359,  318,  354,  364,
			  350,  365,  319,  320,  355,  366,  355,  355,  355,  367,
			  368,  369,  370,  371,  372,  322,  373,  374,  360,  375,
			  377,  378,  379,  361,  362,  363,  380,  381,  382,  383,
			  354,  364,  385,  365,  388,    0,    0,  366,  391,    0,
			  392,  367,  368,  369,  370,  371,  372,  393,  373,  374,
			    0,  375,  377,  378,  379,  394,  395,  396,  380,  381,
			  382,  383,  397,  398,  385,  399,  388,  389,  389,  389,

			  391,  389,  392,  400,  401,  402,  405,  406,  407,  393,
			  408,    0,  389,  412,  412,  412,  412,  394,  395,  396,
			  413,    0,    0,  413,  397,  398,  415,  399,    0,  415,
			  417,    0,  429,  417,    0,  400,  401,  402,  405,  406,
			  407,    0,  408,  420,  420,  420,  421,  421,  421,  423,
			  423,  423,  422,  422,  422,  430,  433,  420,  415,  424,
			  424,  424,  435,  413,  429,  417,  422,  437,  438,  425,
			  413,  425,  425,  425,  434,  439,  415,  440,  434,  441,
			  417,  442,  444,  445,  446,  425,  447,  430,  433,  420,
			  415,  449,  422,  450,  435,  413,  451,  417,  422,  437,

			  438,  453,  413,    0,  457,  458,  434,  439,  415,  440,
			  434,  441,  417,  442,  444,  445,  446,  425,  447,  459,
			  454,  454,  454,  449,  454,  450,  460,  461,  451,  462,
			  463,  464,  466,  453,  467,  454,  457,  458,  469,  470,
			  472,  475,  474,  476,  475,  474,  476,  478,    0,  478,
			    0,  459,  478,  478,  478,  481,  481,  481,  460,  461,
			    0,  462,  463,  464,  466,    0,  467,    0,  485,  475,
			  469,  470,  472,  474,  479,  479,  479,    0,  486,  488,
			  480,  480,  480,  489,  490,  476,  493,  495,  479,    0,
			  496,  475,  474,  476,  480,  498,  499,  482,  500,  482,

			  485,  475,  482,  482,  482,  474,  501,  483,  483,  483,
			  486,  488,  502,  503,  506,  489,  490,  476,  493,  495,
			  479,  483,  496,  475,  474,  476,  480,  498,  499,  508,
			  500,  509,  511,  515,  516,  518,  520,    0,  501,  520,
			  519,  531,    0,  519,  502,  503,  506,  521,    0,    0,
			  521,    0,    0,  483,  522,  522,  522,  523,  523,  523,
			    0,  508,    0,  509,  511,  515,  516,  518,  519,  524,
			  524,  524,  533,  531,  525,  521,  525,  535,  520,  525,
			  525,  525,  526,  524,  526,  536,  520,  526,  526,  526,
			  519,  527,  527,  527,  528,  528,  528,  521,  537,  540,

			  519,  529,  529,  529,  533,  527,  530,  521,  530,  535,
			  520,  530,  530,  530,  543,  524,  544,  536,  520,  545,
			  545,  545,  519,  545,  546,  547,  548,  550,  551,  521,
			  537,  540,  553,  554,  545,  553,  554,  527,  555,  556,
			    0,  555,  557,  557,  557,    0,  543,  565,  544,  558,
			  558,  558,  559,  559,  559,  571,  546,  547,  548,  550,
			  551,  560,  560,  560,  574,  556,  561,  561,  561,  553,
			  562,  556,  562,  576,  582,  562,  562,  562,  579,  565,
			  561,  579,  553,  554,  563,  563,  563,  571,  555,  564,
			  564,  564,  583,  583,  583,    0,  574,  584,  584,  584,

			  582,  553,  607,  607,  607,  576,  582,    0,    0,    0,
			    0,    0,  561,    0,  553,  554,    0,    0,    0,    0,
			  555,    0,    0,    0,    0,  596,    0,  596,  579,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  579,  591,  591,  591,  591,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  591,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  593,  593,  593,  593,  593,  593,  593,  593,  593,

			  593,  593,  593,  593,  593,  593,  594,  594,  594,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  595,    0,  595,  595,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  597,    0,  597,  597,
			  597,  597,  597,  597,  597,  597,  597,  597,  597,  597,
			  597,  599,    0,  599,  599,  599,    0,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  600,
			  600,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  602,  602,  602,  602,

			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  603,    0,  603,  603,  603,  603,  603,  603,  603,
			  603,  603,  603,  603,  603,  603,  604,    0,  604,    0,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  605,    0,  605,  605,  605,  605,  605,  605,  605,
			  605,  605,  605,  605,  605,  605,  606,    0,  606,  606,
			  606,  606,  606,  606,  606,  606,  606,  606,  606,  606,
			  606,  608,  608,  608,  608,  608,  608,  608,  608,  608,
			  608,  608,  608,  608,  608,  608,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,

			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  615,  599,  108,
			  111,  581, 1686,  114,  566, 1686,  188,    0, 1686,  108,
			 1686, 1686, 1686, 1686, 1686,  103,  103,  103,  114,  119,
			  126,  541, 1686,  101, 1686,  116,  527,  180,   90,  183,
			  115,  137,  121,    0,  232,  170,   87,  238,   86,  104,
			  123,  231,  109,  181,  116,  120, 1686,  481, 1686, 1686,
			 1686,  445, 1686,  518, 1686, 1686,  316,   91,  233, 1686,
			 1686,  163,  512, 1686, 1686,  268, 1686,  169,  487,  280,
			 1686,  286,  150,  288,  296,  315,  331,  349,  364,  371,
			  373,  325,  377,  379,  393,  383,  385,  460,    0,  474,

			  543,  425,    0, 1686, 1686,  387, 1686, 1686,  410,  457,
			  462, 1686,    0,  262, 1686, 1686, 1686, 1686, 1686, 1686,
			    0,  185,  384,  201,  250,  312,  323,  344,  376,  368,
			  382,  371,  437,    0,  378,  441,  442,  419,  440,  442,
			    0,  448,  461,    0,  455,  467,  448,  453,  470,  473,
			    0,  473,  552,  506,  461,  476,  463,  539,  485,  496,
			  516,  518, 1686, 1686,  428, 1686,  603, 1686, 1686, 1686,
			 1686, 1686,  294, 1686, 1686, 1686, 1686, 1686, 1686, 1686,
			 1686, 1686, 1686, 1686, 1686, 1686, 1686, 1686, 1686,  290,
			 1686, 1686,  555,  439, 1686,  414, 1686,  612, 1686, 1686,

			 1686,  620,  632, 1686, 1686, 1686, 1686,  554, 1686,  590,
			 1686,  602,  619,  635,  644,  645,  650,  658, 1686,  631,
			  657, 1686, 1686, 1686,  401,  389,  387,  349,  345,  648,
			  343,  328,  327,  322,  321,  315,  298,  297,  293,  243,
			  238,  231,  198,  190,  181,  165, 1686,  651,  719, 1686,
			  661,  727,  732,  737,  115,  682,  528,  617,    0,    0,
			  619,  630,    0,  654,  644,  643,  666,  651,  649,  671,
			  677,    0,  685,  726,  717,  713,  713,  722,  725,  734,
			  731,  737,  727,  743,  740,  745,  731,  744,  735,    0,
			  746,  727,  750,  750,  752,  757,  739,  783,  743,  757,

			  769,  782,  781,  791,  792,  781,  790,  791,  797,  789,
			    0, 1686,  815,  836, 1686, 1686, 1686,  837,  839,  844,
			  845, 1686,  857, 1686, 1686, 1686, 1686, 1686, 1686, 1686,
			  848, 1686, 1686, 1686, 1686, 1686, 1686, 1686, 1686, 1686,
			 1686, 1686, 1686, 1686, 1686, 1686, 1686,  854,  851,  861,
			  864,  882,  869,  885,  897,  916,  102,  888,  806,  846,
			  880,  883,  882,  875,  895,  882,  901,  903,  893,  903,
			  895,  900,  897,  899,  913,  899,    0,  916,  913,  899,
			  903,  910,  924,  912,    0,  921,    0,    0,  923,  995,
			    0,  918,  932,  942,  938,  944,  949,  942,  952,  941,

			  971,  957,  960,    0,    0,  971,  957,  967,  980,    0,
			    0, 1686,  994, 1014, 1686, 1020, 1686, 1024, 1686,  147,
			 1023, 1026, 1032, 1029, 1039, 1051,  285,    0,    0,  989,
			 1024,    0,    0, 1009, 1040, 1019,    0, 1020, 1033, 1041,
			 1044, 1030, 1038,    0, 1035, 1040, 1050, 1048,    0, 1053,
			 1061, 1058,    0, 1067, 1118, 1686,  137, 1057, 1052, 1081,
			 1092, 1093, 1082, 1096, 1082,    0, 1083, 1104,    0, 1100,
			 1105,    0, 1097,   89, 1136, 1135, 1137, 1686, 1132, 1154,
			 1160, 1135, 1182, 1187,    0, 1118, 1129,    0, 1135, 1134,
			 1150,    0,    0, 1152,    0, 1157, 1156,    0, 1147, 1153,

			 1149, 1157, 1182, 1164, 1686,  100, 1166,    0, 1186, 1188,
			    0, 1198,    0,    0,    0, 1184, 1191,    0, 1186, 1234,
			 1230, 1241, 1234, 1237, 1249, 1259, 1267, 1271, 1274, 1281,
			 1291, 1192,    0, 1229,    0, 1244, 1252, 1257,    0,    0,
			 1263,    0,    0, 1271, 1282, 1317, 1280, 1291, 1294,    0,
			 1293, 1294,    0, 1326, 1327, 1332, 1305, 1322, 1329, 1332,
			 1341, 1346, 1355, 1364, 1369, 1313,    0,    0,    0,    0,
			    0, 1306,    0, 1686, 1317,    0, 1339,    0,    0, 1372,
			 1686, 1686, 1340, 1372, 1377,    0,    0,    0,    0, 1686,
			 1686, 1460, 1475, 1490, 1505, 1520, 1422, 1535, 1431, 1550,

			 1565, 1580, 1595, 1610, 1625, 1640, 1655, 1395, 1670, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  590,    1,  591,  591,  592,  592,  593,  593,  594,
			  594,  590,  590,  590,  590,  590,  595,  596,  590,  597,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  590,  590,  590,  590,
			  590,  590,  590,  599,  590,  590,  590,  600,  600,  590,
			  590,  601,  602,  590,  590,  590,  590,  590,  590,  595,
			  590,  603,  604,  595,  595,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  595,  595,  596,  605,

			  605,  605,  606,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  607,  590,  590,  590,  590,  590,  590,  590,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  590,  590,  599,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  600,
			  590,  590,  600,  601,  590,  602,  590,  590,  590,  590,

			  590,  603,  604,  590,  590,  590,  590,  595,  590,  595,
			  590,  595,  595,  595,  595,  595,  595,  595,  590,  595,
			  595,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  607,  590,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,

			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  590,  590,  604,  590,  590,  590,  595,  595,  595,
			  595,  590,  595,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  590,  607,  590,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,

			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  590,  590,  595,  590,  595,  590,  595,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  590,  590,  590,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  590,  595,  595,  595,  590,  590,  590,
			  590,  590,  590,  590,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  598,

			  598,  598,  598,  598,  590,  608,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  598,  595,
			  595,  595,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  590,  598,  598,  598,  598,
			  598,  598,  598,  595,  595,  595,  590,  590,  590,  590,
			  590,  590,  590,  590,  590,  598,  598,  598,  598,  598,
			  598,  598,  598,  590,  598,  598,  598,  598,  598,  595,
			  590,  590,  590,  590,  590,  598,  598,  598,  598,  590,
			    0,  590,  590,  590,  590,  590,  590,  590,  590,  590,

			  590,  590,  590,  590,  590,  590,  590,  590,  590, yy_Dummy>>)
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
			  440,  442,  443,  443,  443,  445,  447,  449,  450,  451,
			  452,  453,  455,  456,  458,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  474,
			  475,  476,  477,  478,  479,  480,  481,  482,  483,  483,
			  484,  485,  485,  485,  486,  487,  488,  488,  488,  489,
			  490,  491,  492,  493,  494,  495,  496,  497,  498,  499,
			  501,  502,  503,  504,  505,  506,  507,  509,  510,  511,
			  512,  513,  514,  515,  516,  518,  519,  521,  523,  524,
			  526,  528,  529,  530,  531,  532,  533,  534,  535,  536,

			  537,  538,  539,  540,  542,  544,  545,  546,  547,  548,
			  550,  552,  553,  553,  554,  556,  557,  559,  560,  562,
			  563,  564,  564,  565,  565,  566,  567,  568,  570,  572,
			  573,  574,  576,  578,  579,  580,  581,  583,  584,  585,
			  586,  587,  588,  589,  591,  592,  593,  594,  595,  597,
			  598,  599,  600,  602,  603,  603,  604,  604,  605,  606,
			  607,  608,  609,  610,  611,  612,  614,  615,  616,  618,
			  619,  620,  622,  623,  623,  624,  625,  626,  627,  627,
			  628,  629,  629,  629,  630,  632,  633,  634,  636,  637,
			  638,  639,  641,  643,  644,  646,  647,  648,  650,  651,

			  652,  653,  654,  655,  656,  658,  658,  659,  661,  662,
			  663,  665,  666,  668,  670,  672,  673,  674,  676,  677,
			  678,  679,  680,  680,  681,  682,  682,  682,  683,  683,
			  684,  684,  685,  687,  688,  690,  691,  692,  693,  695,
			  697,  698,  700,  702,  703,  704,  704,  705,  706,  707,
			  709,  710,  711,  713,  714,  715,  716,  717,  717,  718,
			  718,  719,  720,  720,  720,  721,  722,  724,  726,  728,
			  730,  732,  733,  735,  736,  737,  739,  740,  742,  744,
			  745,  747,  749,  750,  750,  751,  753,  755,  757,  759,
			  761,  761, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  170,  170,  172,  172,  203,  201,  202,    2,  201,
			  202,    3,  202,   33,  201,  202,  173,  201,  202,   38,
			  201,  202,   12,  201,  202,  140,  201,  202,   21,  201,
			  202,   22,  201,  202,   29,  201,  202,   27,  201,  202,
			    6,  201,  202,   28,  201,  202,   11,  201,  202,   30,
			  201,  202,  111,  113,  201,  202,  111,  113,  201,  202,
			  111,  113,  201,  202,    5,  201,  202,    4,  201,  202,
			   16,  201,  202,   15,  201,  202,   17,  201,  202,    8,
			  201,  202,  109,  201,  202,  109,  201,  202,  109,  201,
			  202,  109,  201,  202,  109,  201,  202,  109,  201,  202,

			  109,  201,  202,  109,  201,  202,  109,  201,  202,  109,
			  201,  202,  109,  201,  202,  109,  201,  202,  109,  201,
			  202,  109,  201,  202,  109,  201,  202,  109,  201,  202,
			  109,  201,  202,  109,  201,  202,  109,  201,  202,   25,
			  201,  202,  201,  202,   26,  201,  202,   31,  201,  202,
			   23,  201,  202,   24,  201,  202,    9,  201,  202,  174,
			  202,  200,  202,  198,  202,  199,  202,  170,  202,  170,
			  202,  169,  202,  168,  202,  170,  202,  172,  202,  171,
			  202,  166,  202,  166,  202,  165,  202,    2,    3,  173,
			  162,  173,  173,  173,  173,  173,  173,  173,  173,  173,

			  173,  173,  173,  173, -366,  173,  173,  173, -366,   38,
			  140,  140,  140,    1,   32,    7,  115,   36,   20,  115,
			  111,  113,  111,  113,  110,   13,   34,   18,   19,   35,
			   14,  109,  109,  109,  109,   43,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,   55,  109,  109,  109,  109,
			  109,  109,  109,   67,  109,  109,  109,   74,  109,  109,
			  109,  109,  109,  109,  109,   87,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,   37,   10,
			  174,  198,  191,  189,  190,  192,  193,  194,  195,  175,
			  176,  177,  178,  179,  180,  181,  182,  183,  184,  185,

			  186,  187,  188,  170,  169,  168,  170,  170,  167,  168,
			  172,  171,  165,  163,  161,  163,  173, -366, -366,  148,
			  163,  146,  163,  147,  163,  149,  163,  173,  142,  163,
			  173,  143,  163,  173,  173,  173,  173,  173,  173,  173,
			 -164,  173,  173,  150,  163,  140,  116,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  117,  140,  115,  112,  115,  111,  113,  111,  113,  114,
			  109,  109,   41,  109,   42,  109,  109,  109,   46,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,   58,  109,

			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,   78,  109,  109,   81,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  108,  109,  197,  151,  163,  144,  163,  145,  163,  173,
			  173,  173,  173,  158,  163,  173,  153,  163,  152,  163,
			  134,  132,  133,  135,  136,  141,  137,  138,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  115,  115,  115,  115,  111,  111,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,   56,

			  109,  109,  109,  109,  109,  109,  109,   65,  109,  109,
			  109,  109,  109,  109,  109,  109,   75,  109,  109,   77,
			  109,   79,  109,  109,   85,  109,   86,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  100,  109,  101,  109,  109,  109,  109,  109,  106,  109,
			  107,  109,  196,  173,  154,  163,  173,  157,  163,  173,
			  160,  163,  141,  115,  115,  115,  115,  113,   39,  109,
			   40,  109,  109,  109,   47,  109,   48,  109,  109,  109,
			  109,   53,  109,  109,  109,  109,  109,  109,  109,   63,
			  109,  109,  109,  109,  109,   70,  109,  109,  109,  109,

			   76,  109,  109,   82,  109,  109,  109,  109,  109,  109,
			  109,  109,   96,  109,  109,  109,   99,  109,  109,  109,
			  104,  109,  109,  173,  173,  173,  139,  115,  115,  115,
			   44,  109,  109,  109,   50,  109,  109,  109,  109,   57,
			  109,   59,  109,  109,   61,  109,  109,  109,   66,  109,
			  109,  109,  109,  109,  109,  109,   83,   84,  109,   89,
			  109,  109,  109,   92,  109,  109,   94,  109,   95,  109,
			   97,  109,  109,  109,  103,  109,  109,  173,  173,  173,
			  115,  115,  115,  115,  109,   49,  109,  109,   52,  109,
			  109,  109,  109,   64,  109,   68,  109,  109,   71,  109,

			   72,  109,  109,  109,  109,  109,  109,   93,  109,  109,
			  109,  105,  109,  173,  173,  173,  115,  115,  115,  115,
			  115,  109,   51,  109,   54,  109,   60,  109,   62,  109,
			   69,  109,  109,   80,  109,   84,  109,   90,  109,  109,
			   98,  109,  102,  109,  173,  156,  163,  159,  163,  115,
			  115,   45,  109,   73,  109,   88,  109,   91,  109,  155,
			  163, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1686
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 590
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 591
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

	yyNb_rules: INTEGER is 202
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 203
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
