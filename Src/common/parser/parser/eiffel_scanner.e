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
--|#line 39 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 39")
end

when 2 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 44 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 44")
end

when 3 then
yy_set_line (0)
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 45 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 45")
end

when 4 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 49 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 49")
end

				last_token := TE_SEMICOLON
			
when 5 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 52 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 52")
end

				last_token := TE_COLON
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 55 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 55")
end

				last_token := TE_COMMA
			
when 7 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 58 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 58")
end

				last_token := TE_DOTDOT
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 61 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 61")
end

				last_token := TE_QUESTION
			
when 9 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 64 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 64")
end

				last_token := TE_TILDE
			
when 10 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 67 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 67")
end

				last_token := TE_CURLYTILDE
			
when 11 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 70 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 70")
end

				last_token := TE_DOT
			
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 73 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 73")
end

				last_token := TE_ADDRESS
			
when 13 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 76 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 76")
end

				last_token := TE_ASSIGNMENT
			
when 14 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 79 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 79")
end

				last_token := TE_ACCEPT
			
when 15 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 82 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 82")
end

				last_token := TE_EQ
			
when 16 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 85 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 85")
end

				last_token := TE_LT
			
when 17 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 88 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 88")
end

				last_token := TE_GT
			
when 18 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 91 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 91")
end

				last_token := TE_LE
			
when 19 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 94 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 94")
end

				last_token := TE_GE
			
when 20 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 97 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 97")
end

				last_token := TE_NE
			
when 21 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 100 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 100")
end

				last_token := TE_LPARAN
			
when 22 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 103 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 103")
end

				last_token := TE_RPARAN
			
when 23 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 106 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 106")
end

				last_token := TE_LCURLY
			
when 24 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 109 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 109")
end

				last_token := TE_RCURLY
			
when 25 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 112 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 112")
end

				last_token := TE_LSQURE
				last_location_as_value := ast_factory.new_location_as (line, column, position, 1)
			
when 26 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 116 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 116")
end

				last_token := TE_RSQURE
				last_location_as_value := ast_factory.new_location_as (line, column, position, 1)
			
when 27 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 120 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 120")
end

				last_token := TE_PLUS
			
when 28 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 123 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 123")
end

				last_token := TE_MINUS
			
when 29 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 126 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 126")
end

				last_token := TE_STAR
			
when 30 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 129 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 129")
end

				last_token := TE_SLASH
			
when 31 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 132 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 132")
end

				last_token := TE_POWER
			
when 32 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 135 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 135")
end

				last_token := TE_CONSTRAIN
			
when 33 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 138 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 138")
end

				last_token := TE_BANG
			
when 34 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 141 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 141")
end

				last_token := TE_LARRAY
			
when 35 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 144 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 144")
end

				last_token := TE_RARRAY
			
when 36 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 147 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 147")
end

				last_token := TE_DIV
			
when 37 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 150 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 150")
end

				last_token := TE_MOD
			
when 38 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 157 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 157")
end

				last_token := TE_FREE
				process_id_as
			
when 39 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 165 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 165")
end

				last_token := TE_AGENT
			
when 40 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 168 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 168")
end

				last_token := TE_ALIAS
			
when 41 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 171 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 171")
end

				last_token := TE_ALL
			
when 42 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 174 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 174")
end

				last_token := TE_AND
			
when 43 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 177 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 177")
end

				last_token := TE_AS
			
when 44 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 180 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 180")
end

				last_token := TE_ASSIGN
			
when 45 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 183 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 183")
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
--|#line 192 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 192")
end

				last_token := TE_BIT
			
when 47 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 195 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 195")
end

				last_token := TE_CHECK
			
when 48 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 198 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 198")
end

				last_token := TE_CLASS
			
when 49 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 201 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 201")
end

				last_token := TE_CONVERT
			
when 50 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 204 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 204")
end

				last_token := TE_CREATE
			
when 51 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 207 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 207")
end

				last_token := TE_CREATION
				last_location_as_value := ast_factory.new_location_as (line, column, position, 8)
			
when 52 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 211 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 211")
end

				last_token := TE_CURRENT
				last_current_as_value := ast_factory.new_current_as (line, column, position, 7)
			
when 53 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 215 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 215")
end

				last_token := TE_DEBUG
			
when 54 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 218 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 218")
end

				last_token := TE_DEFERRED
				last_deferred_as_value := ast_factory.new_deferred_as (line, column, position, 8)
			
when 55 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 222 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 222")
end

				last_token := TE_DO
			
when 56 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 225 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 225")
end

				last_token := TE_ELSE
			
when 57 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 228 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 228")
end

				last_token := TE_ELSEIF
			
when 58 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 231 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 231")
end

				last_token := TE_END
				last_location_as_value := ast_factory.new_location_as (line, column, position, 3)
			
when 59 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 235 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 235")
end

				last_token := TE_ENSURE
			
when 60 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 238 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 238")
end

				last_token := TE_EXPANDED
			
when 61 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 241 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 241")
end

				last_token := TE_EXPORT
			
when 62 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 244 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 244")
end

				last_token := TE_EXTERNAL
			
when 63 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 247 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 247")
end

				last_token := TE_FALSE
				last_bool_as_value := ast_factory.new_boolean_as (False, line, column, position, 5)
			
when 64 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 251 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 251")
end

				last_token := TE_FEATURE
			
when 65 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 254 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 254")
end

				last_token := TE_FROM
			
when 66 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 257 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 257")
end

				last_token := TE_FROZEN
				last_location_as_value := ast_factory.new_location_as (line, column, position, 6)
			
when 67 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 261 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 261")
end

				last_token := TE_IF
			
when 68 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 264 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 264")
end

				last_token := TE_IMPLIES
			
when 69 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 267 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 267")
end

				last_token := TE_INDEXING
			
when 70 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 270 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 270")
end

				last_token := TE_INFIX
				last_location_as_value := ast_factory.new_location_as (line, column, position, 5)
			
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 274 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 274")
end

				last_token := TE_INHERIT
			
when 72 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 277 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 277")
end

				last_token := TE_INSPECT
			
when 73 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 280 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 280")
end

				last_token := TE_INVARIANT
			
when 74 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 283 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 283")
end

				last_token := TE_IS
			
when 75 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 286 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 286")
end

				last_token := TE_LIKE
			
when 76 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 289 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 289")
end

				last_token := TE_LOCAL
			
when 77 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 292 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 292")
end

				last_token := TE_LOOP
			
when 78 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 295 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 295")
end

				last_token := TE_NOT
			
when 79 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 298 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 298")
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
--|#line 307 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 307")
end

				last_token := TE_OBSOLETE
			
when 81 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 310 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 310")
end

				last_token := TE_OLD
			
when 82 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 325 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 325")
end

				last_token := TE_ONCE_STRING
			
when 83 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 328 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 328")
end

				last_token := TE_ONCE_STRING
			
when 84 then
	yy_end := yy_end - 1
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 331 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 331")
end

				last_token := TE_ONCE_STRING
			
when 85 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 334 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 334")
end

				last_token := TE_ONCE
			
when 86 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 337 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 337")
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
--|#line 346 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 346")
end

				last_token := TE_OR
			
when 88 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 349 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 349")
end

				last_token := TE_PRECURSOR
				last_location_as_value := ast_factory.new_location_as (line, column, position, 9)
			
when 89 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 353 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 353")
end

				last_token := TE_PREFIX
				last_location_as_value := ast_factory.new_location_as (line, column, position, 6)
			
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
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 464 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 464")
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
--|#line 476 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 476")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
			
when 116 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 481 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 481")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 117 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 487 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 487")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
			
when 118 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 492 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 492")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
			
when 119 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 497 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 497")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
			
when 120 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 502 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 502")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
			
when 121 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 507 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 507")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
			
when 122 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 512 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 512")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
			
when 123 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 517 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 517")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
			
when 124 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 522 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 522")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR
			
when 125 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 527 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 527")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
			
when 126 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 532 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 532")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
			
when 127 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 537 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 537")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
			
when 128 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 542 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 542")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
			
when 129 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 547 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 547")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
			
when 130 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 552 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 552")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR
			
when 131 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 557 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 557")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
			
when 132 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 562 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 562")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			
when 133 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 567 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 567")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
			
when 134 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 572 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 572")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
			
when 135 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 577 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 577")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
			
when 136 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 582 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 582")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
			
when 137 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 587 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 587")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
			
when 138 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 592 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 592")
end

				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 139 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 595 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 595")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 596 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 596")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			
when 141 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 605 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 605")
end

				last_token := TE_STR_LT
			
when 142 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 608 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 608")
end

				last_token := TE_STR_GT
			
when 143 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 611 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 611")
end

				last_token := TE_STR_LE
			
when 144 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 614 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 614")
end

				last_token := TE_STR_GE
			
when 145 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 617 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 617")
end

				last_token := TE_STR_PLUS
			
when 146 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end

				last_token := TE_STR_MINUS
			
when 147 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 623 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 623")
end

				last_token := TE_STR_STAR
			
when 148 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

				last_token := TE_STR_SLASH
			
when 149 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 629 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 629")
end

				last_token := TE_STR_POWER
			
when 150 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 632 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 632")
end

				last_token := TE_STR_DIV
			
when 151 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 635 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 635")
end

				last_token := TE_STR_MOD
			
when 152 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 638 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 638")
end

				last_token := TE_STR_BRACKET
			
when 153 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 641 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 641")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			
when 154 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 646 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 646")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			
when 155 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 651 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 651")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			
when 156 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 656 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 656")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			
when 157 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 661 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 661")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			
when 158 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 666 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 666")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			
when 159 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 671 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 671")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			
when 160 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 676 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 676")
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
--|#line 684 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 684")
end

					-- Empty string.
				string_position := position
				last_token := TE_EMPTY_STRING
			
when 162 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 689 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 689")
end

					-- Regular string.
				string_position := position
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			
when 163 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 699 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 699")
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
			
when 164 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 715 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 715")
end

				set_start_condition (VERBATIM_STR1)
			
when 165 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 718 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 718")
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
--|#line 737 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 737")
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
--|#line 779 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 779")
end

				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 168 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 783 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 783")
end

				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 169 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 790 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 790")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 805 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 805")
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
--|#line 813 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 813")
end

					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 172 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 825 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 825")
end

					-- String with special characters.
				string_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			
when 173 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 835 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 835")
end

				append_text_to_string (token_buffer)
			
when 174 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 838 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 838")
end

				token_buffer.append_character ('%A')
			
when 175 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

				token_buffer.append_character ('%B')
			
when 176 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 844 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 844")
end

				token_buffer.append_character ('%C')
			
when 177 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 847 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 847")
end

				token_buffer.append_character ('%D')
			
when 178 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 850 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 850")
end

				token_buffer.append_character ('%F')
			
when 179 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 853 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 853")
end

				token_buffer.append_character ('%H')
			
when 180 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 856 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 856")
end

				token_buffer.append_character ('%L')
			
when 181 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 859 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 859")
end

				token_buffer.append_character ('%N')
			
when 182 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 862 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 862")
end

				token_buffer.append_character ('%Q')
			
when 183 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 865 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 865")
end

				token_buffer.append_character ('%R')
			
when 184 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 868 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 868")
end

				token_buffer.append_character ('%S')
			
when 185 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 871 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 871")
end

				token_buffer.append_character ('%T')
			
when 186 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 874 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 874")
end

				token_buffer.append_character ('%U')
			
when 187 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 877 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 877")
end

				token_buffer.append_character ('%V')
			
when 188 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 880 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 880")
end

				token_buffer.append_character ('%%')
			
when 189 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 883 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 883")
end

				token_buffer.append_character ('%'')
			
when 190 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 886 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 886")
end

				token_buffer.append_character ('%"')
			
when 191 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 889 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 889")
end

				token_buffer.append_character ('%(')
			
when 192 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 892 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 892")
end

				token_buffer.append_character ('%)')
			
when 193 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 895 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 895")
end

				token_buffer.append_character ('%<')
			
when 194 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 898 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 898")
end

				token_buffer.append_character ('%>')
			
when 195 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 901 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 901")
end

				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 196 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 904 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 904")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			
when 197 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 908 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 908")
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
--|#line 923 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 923")
end

					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 199 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 928 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 928")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 200 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 946 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 946")
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

			   68,   69,   68,  548,   70,   68,   69,   68,  414,   70,
			   75,   76,   75,   75,   76,   75,   77,  100,   77,  101,
			  102,  104,  106,  105,  105,  105,  115,  116,  126,  107,
			  103,  146,  108,  151,  109,  109,  110,  108,  152,  109,
			  109,  110,  117,  118,  108,  111,  110,  110,  110,  132,
			  111,  137,  157,  160,  508,  138,   71,  153,  480,  133,
			  126,   71,  249,  146,  161,  151,  190,  112,  139,  194,
			  152,   77,  154,   77,  113,  357,  357,  111,  134,  113,
			  135,  132,  111,  137,  157,  160,  113,  138,   71,  153,
			  136,  133,  347,   71,   80,   81,  161,   82,   81,  112,

			  139,  346,   83,   84,  154,   85,  202,   86,  144,  345,
			  134,  158,  135,   87,  145,   88,  121,   81,   89,  257,
			  127,  122,  136,  123,  128,  159,   90,  129,  124,  125,
			  130,   91,   92,  131,  260,  192,  190,  192,  202,  191,
			  144,   93,  344,  158,   94,   95,  145,   96,  121,  343,
			   89,  257,  127,  122,  342,  123,  128,  159,   90,  129,
			  124,  125,  130,   91,   92,  131,  260,  140,  155,  147,
			  197,  198,  197,   93,  141,  142,   97,   81,  156,  148,
			  143,  149,  313,  313,  313,  150,  199,   79,   79,   82,
			   79,  193,  200,  190,  203,   82,  191,   82,  261,  140,

			  155,  147,  204,  341,  340,   82,  141,  142,  339,  338,
			  156,  148,  143,  149,  255,  255,  255,  150,  166,  166,
			  166,  205,  167,  193,   82,  168,  337,  169,  170,  171,
			  261,  199,  336,  335,   82,  172,   97,  206,  334,  333,
			   82,  173,  201,  174,   97,  332,  175,  176,  177,  178,
			  207,  179,   97,  180,  256,  208,  330,  181,   82,  182,
			  329,  262,  183,  184,  185,  186,  187,  188,   97,  214,
			  210,   97,  263,   82,  201,  209,   97,  199,  264,  199,
			   82,   97,   82,  199,   97,  199,   82,   97,   82,  199,
			  211,  221,   82,  262,   82,  217,  218,  217,  328,  199,

			  327,  214,   82,   97,  263,   97,  265,  247,  247,  247,
			  264,  266,  326,   97,  212,  213,  267,  196,  268,   97,
			   97,  248,  258,  216,  215,  259,  271,   97,  249,   97,
			  250,  250,  250,   97,  165,   97,  246,   97,  265,   97,
			  220,   97,  190,  266,  251,  194,  212,  213,  267,   97,
			  268,  219,   97,  248,  258,  216,  215,  259,  271,   97,
			  276,   97,  217,  218,  217,   97,  199,   97,  269,   82,
			  277,   97,  270,   97,  272,  108,  251,  252,  252,  253,
			  108,   97,  253,  253,  253,  223,  278,  274,  111,  273,
			   78,  275,  276,  279,  280,  285,  281,  288,  282,  286,

			  269,  289,  277,  290,  270,  291,  272,  293,  302,  283,
			  303,  287,  284,  304,  292,  196,   97,  113,  278,  274,
			  111,  273,  113,  275,  165,  279,  280,  285,  281,  288,
			  282,  286,  308,  289,  309,  290,  163,  291,  162,  293,
			  302,  283,  303,  287,  284,  304,  292,  300,   97,  224,
			  310,  301,  225,  119,  226,  227,  228,  192,  190,  192,
			  315,  191,  229,   82,  308,  311,  309,  114,  230,   78,
			  231,  361,  305,  232,  233,  234,  235,  306,  236,  300,
			  237,  593,  310,  301,  238,  294,  239,  295,  307,  240,
			  241,  242,  243,  244,  245,  296,  316,  311,  297,   82,

			  298,  299,   73,  361,  305,  166,  166,  166,  317,  306,
			   97,   82,  312,  193,  197,  198,  197,  294,   73,  295,
			  307,   79,  217,  218,  217,  199,  200,  296,   82,   82,
			  297,  593,  298,  299,  314,  218,  314,  324,  593,  593,
			   82,  199,   97,  593,   82,  193,   97,  362,  593,  321,
			  199,  322,  318,   82,   82,  593,  199,  363,   97,   82,
			  217,  218,  217,  325,  199,  593,   82,   82,  331,  331,
			  331,  348,  348,  348,  593,   97,  201,  364,   97,  362,
			  319,  351,  351,  351,  318,  248,  365,   97,  202,  363,
			   97,   97,  366,  320,  367,  352,  368,  323,  369,  370,

			   97,   97,  593,  360,  360,  360,   97,   97,  201,  364,
			  593,  593,  319,   97,   97,  593,  593,  248,  365,   97,
			  202,  593,  593,   97,  366,  320,  367,  352,  368,  323,
			  369,  370,   97,   97,  349,  371,  349,  372,   97,  350,
			  350,  350,  353,  256,  353,   97,   97,  354,  354,  354,
			  108,  373,  355,  355,  356,  108,  374,  356,  356,  356,
			  593,  376,  358,  111,  359,  359,  359,  371,  377,  372,
			  375,  378,  593,  379,  381,  382,  383,  384,  385,  386,
			  387,  388,  389,  373,  390,  391,  380,  392,  374,  393,
			  396,  394,  113,  376,  395,  111,  397,  113,  398,  399,

			  377,  593,  375,  378,  256,  379,  381,  382,  383,  384,
			  385,  386,  387,  388,  389,  400,  390,  391,  380,  392,
			  402,  393,  396,  394,  403,  404,  395,  405,  397,  406,
			  398,  399,  407,  401,  408,  409,  410,  411,  412,  413,
			  414,  415,  415,  415,  314,  218,  314,  400,  416,  593,
			  417,  199,  402,   82,   82,  419,  403,  404,   82,  405,
			  199,  406,  593,   82,  407,  401,  408,  409,  410,  411,
			  412,  413,  421,  593,  593,   82,  422,  331,  331,  331,
			  593,  423,  423,  423,  593,  430,  418,  431,  420,  350,
			  350,  350,  350,  350,  350,  248,  432,  433,  202,  434,

			   97,   97,  425,  425,  425,   97,  426,  435,  426,  436,
			   97,  427,  427,  427,  593,  593,  352,  430,  418,  431,
			  420,  424,   97,  354,  354,  354,  593,  248,  432,  433,
			  202,  434,   97,   97,  354,  354,  354,   97,  437,  435,
			  438,  436,   97,  428,  439,  355,  355,  356,  352,  428,
			  440,  356,  356,  356,   97,  358,  111,  429,  429,  429,
			  358,  441,  360,  360,  360,  593,  442,  443,  444,  445,
			  437,  446,  438,  447,  448,  449,  439,  450,  451,  452,
			  453,  454,  440,  455,  456,  256,  593,  593,  111,  593,
			  460,  256,  461,  441,  462,  463,  464,  256,  442,  443,

			  444,  445,  256,  446,  465,  447,  448,  449,  466,  450,
			  451,  452,  453,  454,  467,  455,  456,  457,  457,  457,
			  468,  458,  460,  469,  461,  470,  462,  463,  464,  471,
			  472,  473,  459,  474,  475,  199,  465,  593,   82,  487,
			  466,  414,  476,  476,  476,  199,  467,  199,   82,  593,
			   82,  488,  468,  593,  489,  469,  593,  470,  423,  423,
			  423,  471,  472,  473,  593,  474,  475,  482,  482,  482,
			  492,  487,  481,  483,  483,  483,  493,  478,  477,  427,
			  427,  427,  479,  488,  494,   97,  489,  352,  427,  427,
			  427,  495,  496,  497,  498,   97,  249,   97,  483,  483,

			  483,  499,  492,  486,  481,  360,  360,  360,  493,  478,
			  477,  490,  485,  484,  479,  491,  494,   97,  500,  352,
			  501,  502,  503,  495,  496,  497,  498,   97,  504,   97,
			  505,  506,  509,  499,  457,  457,  457,  510,  507,  511,
			  512,  513,  514,  490,  485,  113,  515,  491,  516,  459,
			  500,  517,  501,  502,  503,  518,  519,  520,  521,  534,
			  504,  535,  505,  506,  509,  199,  593,  199,   82,  510,
			   82,  511,  512,  513,  514,  593,  199,  536,  515,   82,
			  516,  537,  593,  517,  530,  530,  530,  518,  519,  520,
			  521,  534,  525,  535,  525,  523,  522,  526,  526,  526,

			  527,  527,  527,  593,  593,  483,  483,  483,  249,  536,
			  530,  530,  530,  537,  528,   97,  538,   97,  524,  529,
			  539,  540,  541,  542,  533,  543,   97,  523,  522,  531,
			  544,  531,  545,  546,  532,  532,  532,  547,  549,  550,
			  551,  552,  553,  554,  555,  593,  528,   97,  538,   97,
			  524,  529,  539,  540,  541,  542,  533,  543,   97,  593,
			  199,  568,  544,   82,  545,  546,  526,  526,  526,  547,
			  549,  550,  551,  552,  553,  554,  555,  199,  199,  593,
			   82,   82,  526,  526,  526,  559,  559,  559,  556,  560,
			  569,  560,  570,  568,  561,  561,  561,  571,  562,  528,

			  562,  572,  573,  563,  563,  563,  558,  564,  564,  564,
			   97,  532,  532,  532,  532,  532,  532,  574,  575,  557,
			  556,  565,  569,  577,  570,  578,  579,   97,   97,  571,
			  566,  528,  566,  572,  573,  567,  567,  567,  558,  548,
			  548,  548,   97,  576,  580,  581,  528,  593,  593,  574,
			  575,  557,  593,  565,  459,  577,  593,  578,  579,   97,
			   97,  199,  583,  584,   82,   82,   82,  561,  561,  561,
			  593,  593,  424,  561,  561,  561,  580,  581,  528,  563,
			  563,  563,  563,  563,  563,  585,  585,  585,  586,  588,
			  586,  589,  590,  587,  587,  587,  591,  593,  582,  565,

			  567,  567,  567,  567,  567,  567,  592,  565,  593,   82,
			  593,   97,   97,   97,  587,  587,  587,  587,  587,  587,
			  593,  588,  593,  589,  590,  254,  254,  254,  591,  593,
			  582,  565,  593,  484,  593,  593,  593,  593,  593,  565,
			  593,  593,  593,   97,   97,   97,  593,  593,  593,  593,
			  593,  593,  593,   98,  593,   98,   97,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,  120,  120,  120,  120,
			  120,  120,  120,  120,  120,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,   97,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   79,
			  593,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   99,  593,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,  164,
			  593,  164,  164,  164,  593,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  189,  189,  189,  189,  189,  189,

			  189,  189,  189,  189,  189,  189,  189,  189,  189,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  195,  195,  195,  195,  195,  195,
			  195,  195,  195,  195,  195,  195,  195,  195,  195,   81,
			  593,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   82,  593,   82,  593,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,  222,
			  593,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  102,  593,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  508,

			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,   11,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,

			  593,  593,  593,  593,  593,  593, yy_Dummy>>)
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

			    5,    5,    5,  508,    5,    6,    6,    6,  476,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   38,   27,
			   25,   46,   28,   48,   28,   28,   28,   29,   49,   29,
			   29,   29,   35,   35,   30,   28,   30,   30,   30,   40,
			   29,   42,   52,   54,  459,   42,    5,   50,  422,   40,
			   38,    6,  358,   46,   55,   48,   71,   28,   42,   71,
			   49,   77,   50,   77,   28,  357,  254,   28,   41,   29,
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
			   44,   47,  172,  172,  172,   47,   79,   81,   81,   79,
			   81,   68,   81,  189,   83,   81,  189,   83,  124,   44,

			   51,   47,   84,  239,  238,   84,   44,   44,  237,  236,
			   51,   47,   44,   47,  113,  113,  113,   47,   66,   66,
			   66,   85,   66,   68,   85,   66,  235,   66,   66,   66,
			  124,   91,  234,  233,   91,   66,   79,   86,  232,  231,
			   86,   66,   81,   66,   83,  230,   66,   66,   66,   66,
			   86,   66,   84,   66,  113,   87,  228,   66,   87,   66,
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
			  100,  257,  157,  100,  100,  100,  100,  157,  100,  153,
			  100,   11,  160,  153,  100,  152,  100,  152,  157,  100,
			  100,  100,  100,  100,  100,  152,  209,  161,  152,  209,

			  152,  152,    8,  257,  157,  166,  166,  166,  211,  157,
			  207,  211,  166,  192,  197,  197,  197,  152,    7,  152,
			  157,  201,  201,  201,  201,  212,  201,  152,  212,  201,
			  152,    0,  152,  152,  202,  202,  202,  219,    0,    0,
			  219,  213,  207,    0,  213,  192,  209,  258,    0,  215,
			  214,  215,  212,  214,  215,    0,  216,  261,  211,  216,
			  217,  217,  217,  220,  217,    0,  220,  217,  229,  229,
			  229,  247,  247,  247,    0,  212,  201,  262,  209,  258,
			  213,  250,  250,  250,  212,  247,  264,  219,  202,  261,
			  211,  213,  265,  214,  266,  250,  267,  216,  268,  269,

			  214,  215,    0,  256,  256,  256,  216,  212,  201,  262,
			    0,    0,  213,  220,  217,    0,    0,  247,  264,  219,
			  202,    0,    0,  213,  265,  214,  266,  250,  267,  216,
			  268,  269,  214,  215,  248,  270,  248,  271,  216,  248,
			  248,  248,  251,  256,  251,  220,  217,  251,  251,  251,
			  252,  273,  252,  252,  252,  253,  274,  253,  253,  253,
			    0,  275,  255,  252,  255,  255,  255,  270,  276,  271,
			  274,  277,    0,  278,  279,  280,  281,  282,  283,  284,
			  285,  286,  287,  273,  288,  289,  278,  291,  274,  292,
			  294,  293,  252,  275,  293,  252,  295,  253,  296,  297,

			  276,    0,  274,  277,  255,  278,  279,  280,  281,  282,
			  283,  284,  285,  286,  287,  298,  288,  289,  278,  291,
			  299,  292,  294,  293,  300,  301,  293,  302,  295,  303,
			  296,  297,  304,  298,  305,  306,  307,  308,  309,  310,
			  313,  313,  313,  313,  314,  314,  314,  298,  318,    0,
			  318,  319,  299,  318,  319,  320,  300,  301,  320,  302,
			  321,  303,    0,  321,  304,  298,  305,  306,  307,  308,
			  309,  310,  323,    0,    0,  323,  331,  331,  331,  331,
			    0,  348,  348,  348,    0,  361,  319,  362,  321,  349,
			  349,  349,  350,  350,  350,  348,  363,  364,  314,  365,

			  318,  319,  351,  351,  351,  320,  352,  366,  352,  367,
			  321,  352,  352,  352,    0,    0,  351,  361,  319,  362,
			  321,  348,  323,  353,  353,  353,    0,  348,  363,  364,
			  314,  365,  318,  319,  354,  354,  354,  320,  368,  366,
			  369,  367,  321,  355,  370,  355,  355,  355,  351,  356,
			  371,  356,  356,  356,  323,  359,  355,  359,  359,  359,
			  360,  372,  360,  360,  360,    0,  373,  374,  375,  376,
			  368,  377,  369,  378,  380,  381,  370,  382,  383,  384,
			  385,  386,  371,  388,  391,  355,    0,    0,  355,    0,
			  394,  356,  395,  372,  396,  397,  398,  359,  373,  374,

			  375,  376,  360,  377,  399,  378,  380,  381,  400,  382,
			  383,  384,  385,  386,  401,  388,  391,  392,  392,  392,
			  402,  392,  394,  403,  395,  404,  396,  397,  398,  405,
			  408,  409,  392,  410,  411,  416,  399,    0,  416,  432,
			  400,  415,  415,  415,  415,  418,  401,  420,  418,    0,
			  420,  433,  402,    0,  436,  403,    0,  404,  423,  423,
			  423,  405,  408,  409,    0,  410,  411,  424,  424,  424,
			  438,  432,  423,  425,  425,  425,  440,  418,  416,  426,
			  426,  426,  420,  433,  441,  416,  436,  425,  427,  427,
			  427,  442,  443,  444,  445,  418,  428,  420,  428,  428,

			  428,  447,  438,  429,  423,  429,  429,  429,  440,  418,
			  416,  437,  428,  425,  420,  437,  441,  416,  448,  425,
			  449,  450,  452,  442,  443,  444,  445,  418,  453,  420,
			  454,  456,  460,  447,  457,  457,  457,  461,  457,  462,
			  463,  464,  465,  437,  428,  429,  466,  437,  467,  457,
			  448,  469,  449,  450,  452,  470,  472,  473,  475,  488,
			  453,  489,  454,  456,  460,  477,    0,  478,  477,  461,
			  478,  462,  463,  464,  465,    0,  479,  491,  466,  479,
			  467,  492,    0,  469,  484,  484,  484,  470,  472,  473,
			  475,  488,  481,  489,  481,  478,  477,  481,  481,  481,

			  482,  482,  482,    0,    0,  483,  483,  483,  486,  491,
			  486,  486,  486,  492,  482,  477,  493,  478,  479,  483,
			  496,  498,  499,  501,  486,  502,  479,  478,  477,  485,
			  503,  485,  504,  505,  485,  485,  485,  506,  509,  511,
			  512,  514,  518,  519,  521,    0,  482,  477,  493,  478,
			  479,  483,  496,  498,  499,  501,  486,  502,  479,    0,
			  522,  534,  503,  522,  504,  505,  525,  525,  525,  506,
			  509,  511,  512,  514,  518,  519,  521,  523,  524,    0,
			  523,  524,  526,  526,  526,  527,  527,  527,  522,  528,
			  536,  528,  538,  534,  528,  528,  528,  539,  529,  527,

			  529,  540,  543,  529,  529,  529,  524,  530,  530,  530,
			  522,  531,  531,  531,  532,  532,  532,  546,  547,  523,
			  522,  530,  536,  549,  538,  550,  551,  523,  524,  539,
			  533,  527,  533,  540,  543,  533,  533,  533,  524,  548,
			  548,  548,  522,  548,  553,  554,  559,    0,    0,  546,
			  547,  523,    0,  530,  548,  549,    0,  550,  551,  523,
			  524,  556,  557,  558,  556,  557,  558,  560,  560,  560,
			    0,    0,  559,  561,  561,  561,  553,  554,  559,  562,
			  562,  562,  563,  563,  563,  564,  564,  564,  565,  568,
			  565,  574,  577,  565,  565,  565,  579,    0,  556,  564,

			  566,  566,  566,  567,  567,  567,  582,  585,    0,  582,
			    0,  556,  557,  558,  586,  586,  586,  587,  587,  587,
			    0,  568,    0,  574,  577,  610,  610,  610,  579,    0,
			  556,  564,    0,  585,    0,    0,    0,    0,    0,  585,
			    0,    0,    0,  556,  557,  558,    0,    0,    0,    0,
			    0,    0,    0,  599,    0,  599,  582,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  582,  594,
			  594,  594,  594,  594,  594,  594,  594,  594,  594,  594,

			  594,  594,  594,  594,  595,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  595,  595,  595,  596,
			  596,  596,  596,  596,  596,  596,  596,  596,  596,  596,
			  596,  596,  596,  596,  597,  597,  597,  597,  597,  597,
			  597,  597,  597,  597,  597,  597,  597,  597,  597,  598,
			    0,  598,  598,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  600,    0,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,  600,  600,  602,
			    0,  602,  602,  602,    0,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  603,  603,  603,  603,  603,  603,

			  603,  603,  603,  603,  603,  603,  603,  603,  603,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  605,  605,  605,  605,  605,  605,
			  605,  605,  605,  605,  605,  605,  605,  605,  605,  606,
			    0,  606,  606,  606,  606,  606,  606,  606,  606,  606,
			  606,  606,  606,  606,  607,    0,  607,    0,  607,  607,
			  607,  607,  607,  607,  607,  607,  607,  607,  607,  608,
			    0,  608,  608,  608,  608,  608,  608,  608,  608,  608,
			  608,  608,  608,  608,  609,    0,  609,  609,  609,  609,
			  609,  609,  609,  609,  609,  609,  609,  609,  609,  611,

			  611,  611,  611,  611,  611,  611,  611,  611,  611,  611,
			  611,  611,  611,  611,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,

			  593,  593,  593,  593,  593,  593, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  615,  599,  108,
			  111,  581, 1714,  114,  566, 1714,  188,    0, 1714,  108,
			 1714, 1714, 1714, 1714, 1714,  103,  103,  103,  114,  119,
			  126,  541, 1714,  101, 1714,  116,  527,  180,   90,  183,
			  115,  137,  121,    0,  232,  170,   87,  238,   86,  104,
			  123,  231,  109,  181,  116,  120, 1714,  481, 1714, 1714,
			 1714,  445, 1714,  518, 1714, 1714,  316,   91,  233, 1714,
			 1714,  163,  512, 1714, 1714,  268, 1714,  169,  487,  280,
			 1714,  286,  150,  288,  296,  315,  331,  349,  364,  371,
			  373,  325,  377,  379,  393,  383,  385,  460,    0,  474,

			  543,  425,    0, 1714, 1714,  387, 1714, 1714,  410,  457,
			  462, 1714,    0,  294, 1714, 1714, 1714, 1714, 1714, 1714,
			    0,  185,  384,  201,  250,  312,  323,  344,  376,  368,
			  382,  371,  437,    0,  378,  441,  442,  419,  440,  442,
			    0,  448,  461,    0,  455,  467,  448,  453,  470,  473,
			    0,  473,  552,  506,  461,  476,  463,  539,  485,  496,
			  516,  518, 1714, 1714,  428, 1714,  603, 1714, 1714, 1714,
			 1714, 1714,  262, 1714, 1714, 1714, 1714, 1714, 1714, 1714,
			 1714, 1714, 1714, 1714, 1714, 1714, 1714, 1714, 1714,  290,
			 1714, 1714,  555,  439, 1714,  414, 1714,  612, 1714, 1714,

			 1714,  620,  632, 1714, 1714, 1714, 1714,  554, 1714,  590,
			 1714,  602,  619,  635,  644,  645,  650,  658, 1714,  631,
			  657, 1714, 1714, 1714,  401,  389,  387,  349,  345,  648,
			  334,  328,  327,  322,  321,  315,  298,  297,  293,  292,
			  243,  238,  231,  198,  190,  181, 1714,  651,  719, 1714,
			  661,  727,  732,  737,  116,  744,  683,  528,  617,    0,
			    0,  619,  630,    0,  654,  644,  643,  666,  651,  649,
			  701,  703,    0,  701,  726,  727,  720,  722,  731,  733,
			  741,  738,  743,  733,  749,  746,  751,  737,  750,  741,
			    0,  753,  735,  759,  756,  762,  768,  749,  783,  773,

			  790,  795,  789,  786,  798,  800,  789,  798,  799,  805,
			  796,    0, 1714,  821,  842, 1714, 1714, 1714,  844,  845,
			  849,  854, 1714,  866, 1714, 1714, 1714, 1714, 1714, 1714,
			 1714,  857, 1714, 1714, 1714, 1714, 1714, 1714, 1714, 1714,
			 1714, 1714, 1714, 1714, 1714, 1714, 1714, 1714,  861,  869,
			  872,  882,  891,  903,  914,  925,  931,  115,  144,  937,
			  942,  836,  839,  860,  859,  859,  859,  875,  889,  906,
			  908,  903,  923,  919,  924,  921,  922,  937,  923,    0,
			  940,  937,  924,  925,  932,  946,  934,    0,  942,    0,
			    0,  943, 1015,    0,  940,  954,  959,  948,  954,  966,

			  958,  973,  966,  991,  978,  984,    0,    0,  995,  981,
			  992, 1004,    0,    0, 1714, 1022, 1029, 1714, 1039, 1714,
			 1041, 1714,  147, 1038, 1047, 1053, 1059, 1068, 1078, 1085,
			    0,    0,  996, 1020,    0,    0, 1007, 1077, 1027,    0,
			 1029, 1049, 1057, 1059, 1044, 1051,    0, 1054, 1075, 1086,
			 1083,    0, 1084, 1096, 1092,    0, 1097, 1132, 1714,  137,
			 1085, 1084, 1101, 1106, 1107, 1095, 1112, 1099,    0, 1102,
			 1125,    0, 1118, 1123,    0, 1115,   89, 1159, 1161, 1170,
			 1714, 1177, 1180, 1185, 1164, 1214, 1190,    0, 1109, 1112,
			    0, 1133, 1132, 1182,    0,    0, 1186,    0, 1191, 1188,

			    0, 1175, 1182, 1181, 1183, 1203, 1188, 1714,  100, 1190,
			    0, 1196, 1197,    0, 1207,    0,    0,    0, 1193, 1200,
			    0, 1195, 1254, 1271, 1272, 1246, 1262, 1265, 1274, 1283,
			 1287, 1291, 1294, 1315, 1212,    0, 1247,    0, 1259, 1264,
			 1260,    0,    0, 1266,    0,    0, 1274, 1284, 1337, 1279,
			 1291, 1294,    0, 1310, 1311,    0, 1355, 1356, 1357, 1312,
			 1347, 1353, 1359, 1362, 1365, 1373, 1380, 1383, 1355,    0,
			    0,    0,    0,    0, 1342,    0, 1714, 1345,    0, 1362,
			    0,    0, 1400, 1714, 1714, 1373, 1394, 1397,    0,    0,
			    0,    0, 1714, 1714, 1488, 1503, 1518, 1533, 1548, 1450,

			 1563, 1459, 1578, 1593, 1608, 1623, 1638, 1653, 1668, 1683,
			 1418, 1698, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  593,    1,  594,  594,  595,  595,  596,  596,  597,
			  597,  593,  593,  593,  593,  593,  598,  599,  593,  600,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  593,  593,  593,  593,
			  593,  593,  593,  602,  593,  593,  593,  603,  603,  593,
			  593,  604,  605,  593,  593,  593,  593,  593,  593,  598,
			  593,  606,  607,  598,  598,  598,  598,  598,  598,  598,
			  598,  598,  598,  598,  598,  598,  598,  598,  599,  608,

			  608,  608,  609,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  610,  593,  593,  593,  593,  593,  593,  593,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  593,  593,  602,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  603,
			  593,  593,  603,  604,  593,  605,  593,  593,  593,  593,

			  593,  606,  607,  593,  593,  593,  593,  598,  593,  598,
			  593,  598,  598,  598,  598,  598,  598,  598,  593,  598,
			  598,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  610,  593,  593,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,

			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  593,  593,  607,  593,  593,  593,  598,  598,
			  598,  598,  593,  598,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  610,  593,  593,
			  593,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,

			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  593,  593,  598,  593,  598,  593,
			  598,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  593,  593,  593,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  593,  598,  598,  598,
			  593,  593,  593,  593,  593,  593,  593,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,

			  601,  601,  601,  601,  601,  601,  601,  593,  611,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  601,
			  601,  601,  598,  598,  598,  593,  593,  593,  593,  593,
			  593,  593,  593,  593,  601,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  593,  601,
			  601,  601,  601,  601,  601,  601,  598,  598,  598,  593,
			  593,  593,  593,  593,  593,  593,  593,  593,  601,  601,
			  601,  601,  601,  601,  601,  601,  593,  601,  601,  601,
			  601,  601,  598,  593,  593,  593,  593,  593,  601,  601,
			  601,  601,  593,    0,  593,  593,  593,  593,  593,  593,

			  593,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  593,  593, yy_Dummy>>)
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
			  170,  172,  174,  176,  178,  180,  182,  184,  185,  186,
			  187,  188,  189,  189,  190,  191,  192,  193,  194,  195,
			  196,  197,  198,  199,  200,  202,  203,  204,  206,  207,

			  208,  209,  210,  211,  212,  213,  214,  215,  216,  217,
			  218,  219,  220,  220,  220,  221,  222,  223,  224,  225,
			  226,  227,  228,  229,  230,  232,  233,  234,  235,  236,
			  237,  238,  239,  240,  242,  243,  244,  245,  246,  247,
			  248,  250,  251,  252,  254,  255,  256,  257,  258,  259,
			  260,  262,  263,  264,  265,  266,  267,  268,  269,  270,
			  271,  272,  273,  274,  275,  276,  277,  277,  278,  279,
			  280,  281,  282,  282,  283,  284,  285,  286,  287,  288,
			  289,  290,  291,  292,  293,  294,  295,  296,  297,  298,
			  299,  300,  301,  302,  303,  305,  306,  307,  307,  308,

			  309,  311,  313,  314,  316,  318,  320,  322,  323,  325,
			  326,  328,  329,  330,  331,  332,  333,  334,  335,  336,
			  337,  338,  340,  341,  343,  344,  345,  346,  347,  348,
			  349,  350,  351,  352,  353,  354,  355,  356,  357,  358,
			  359,  360,  361,  362,  363,  364,  365,  367,  368,  368,
			  369,  370,  370,  371,  372,  373,  374,  374,  375,  376,
			  378,  380,  381,  382,  384,  385,  386,  387,  388,  389,
			  390,  391,  392,  394,  395,  396,  397,  398,  399,  400,
			  401,  402,  403,  404,  405,  406,  407,  408,  409,  411,
			  412,  414,  415,  416,  417,  418,  419,  420,  421,  422,

			  423,  424,  425,  426,  427,  428,  429,  430,  431,  432,
			  433,  434,  436,  437,  437,  437,  439,  441,  443,  444,
			  445,  446,  447,  449,  450,  452,  454,  455,  456,  457,
			  458,  459,  460,  461,  462,  463,  464,  465,  466,  467,
			  468,  469,  470,  471,  472,  473,  474,  475,  476,  477,
			  477,  478,  479,  479,  479,  480,  481,  482,  482,  482,
			  483,  484,  485,  486,  487,  488,  489,  490,  491,  492,
			  493,  494,  495,  497,  498,  499,  500,  501,  502,  503,
			  505,  506,  507,  508,  509,  510,  511,  512,  514,  515,
			  517,  519,  520,  522,  524,  525,  526,  527,  528,  529,

			  530,  531,  532,  533,  534,  535,  536,  538,  540,  541,
			  542,  543,  544,  546,  548,  549,  549,  550,  552,  553,
			  555,  556,  558,  559,  560,  560,  561,  561,  562,  563,
			  564,  566,  568,  569,  570,  572,  574,  575,  576,  577,
			  579,  580,  581,  582,  583,  584,  585,  587,  588,  589,
			  590,  591,  593,  594,  595,  596,  598,  599,  599,  600,
			  600,  601,  602,  603,  604,  605,  606,  607,  608,  610,
			  611,  612,  614,  615,  616,  618,  619,  619,  620,  621,
			  622,  623,  623,  624,  625,  625,  625,  626,  628,  629,
			  630,  632,  633,  634,  635,  637,  639,  640,  642,  643,

			  644,  646,  647,  648,  649,  650,  651,  652,  654,  654,
			  655,  657,  658,  659,  661,  662,  664,  666,  668,  669,
			  670,  672,  673,  674,  675,  676,  676,  677,  678,  678,
			  678,  679,  679,  680,  680,  681,  683,  684,  686,  687,
			  688,  689,  691,  693,  694,  696,  698,  699,  700,  700,
			  701,  702,  703,  705,  706,  707,  709,  710,  711,  712,
			  713,  713,  714,  714,  715,  716,  716,  716,  717,  718,
			  720,  722,  724,  726,  728,  729,  731,  732,  733,  735,
			  736,  738,  740,  741,  743,  745,  746,  746,  747,  749,
			  751,  753,  755,  757,  757, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  169,  169,  171,  171,  202,  200,  201,    2,  200,
			  201,    3,  201,   33,  200,  201,  172,  200,  201,   38,
			  200,  201,   12,  200,  201,  139,  200,  201,   21,  200,
			  201,   22,  200,  201,   29,  200,  201,   27,  200,  201,
			    6,  200,  201,   28,  200,  201,   11,  200,  201,   30,
			  200,  201,  111,  200,  201,  111,  200,  201,  111,  200,
			  201,    5,  200,  201,    4,  200,  201,   16,  200,  201,
			   15,  200,  201,   17,  200,  201,    8,  200,  201,  109,
			  200,  201,  109,  200,  201,  109,  200,  201,  109,  200,
			  201,  109,  200,  201,  109,  200,  201,  109,  200,  201,

			  109,  200,  201,  109,  200,  201,  109,  200,  201,  109,
			  200,  201,  109,  200,  201,  109,  200,  201,  109,  200,
			  201,  109,  200,  201,  109,  200,  201,  109,  200,  201,
			  109,  200,  201,  109,  200,  201,   25,  200,  201,  200,
			  201,   26,  200,  201,   31,  200,  201,   23,  200,  201,
			   24,  200,  201,    9,  200,  201,  173,  201,  199,  201,
			  197,  201,  198,  201,  169,  201,  169,  201,  168,  201,
			  167,  201,  169,  201,  171,  201,  170,  201,  165,  201,
			  165,  201,  164,  201,    2,    3,  172,  161,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,

			  172, -364,  172,  172,  172, -364,   38,  139,  139,  139,
			    1,   32,    7,  114,   36,   20,  114,  111,  111,  110,
			   13,   34,   18,   19,   35,   14,  109,  109,  109,  109,
			   43,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			   55,  109,  109,  109,  109,  109,  109,  109,   67,  109,
			  109,  109,   74,  109,  109,  109,  109,  109,  109,  109,
			   87,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,   37,   10,  173,  197,  190,  188,  189,
			  191,  192,  193,  194,  174,  175,  176,  177,  178,  179,
			  180,  181,  182,  183,  184,  185,  186,  187,  169,  168,

			  167,  169,  169,  166,  167,  171,  170,  164,  162,  160,
			  162,  172, -364, -364,  147,  162,  145,  162,  146,  162,
			  148,  162,  172,  141,  162,  172,  142,  162,  172,  172,
			  172,  172,  172,  172,  172, -163,  172,  172,  149,  162,
			  139,  115,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  116,  139,  114,  112,  114,
			  111,  111,  113,  111,  109,  109,   41,  109,   42,  109,
			  109,  109,   46,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,   58,  109,  109,  109,  109,  109,  109,  109,

			  109,  109,  109,  109,  109,  109,  109,  109,  109,   78,
			  109,  109,   81,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  108,  109,  196,  150,  162,  143,
			  162,  144,  162,  172,  172,  172,  172,  157,  162,  172,
			  152,  162,  151,  162,  133,  131,  132,  134,  135,  140,
			  136,  137,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  114,  114,  114,  114,
			  111,  111,  111,  111,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,   56,  109,  109,  109,  109,

			  109,  109,  109,   65,  109,  109,  109,  109,  109,  109,
			  109,  109,   75,  109,  109,   77,  109,   79,  109,  109,
			   85,  109,   86,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  100,  109,  101,  109,
			  109,  109,  109,  109,  106,  109,  107,  109,  195,  172,
			  153,  162,  172,  156,  162,  172,  159,  162,  140,  114,
			  114,  114,  114,  111,   39,  109,   40,  109,  109,  109,
			   47,  109,   48,  109,  109,  109,  109,   53,  109,  109,
			  109,  109,  109,  109,  109,   63,  109,  109,  109,  109,
			  109,   70,  109,  109,  109,  109,   76,  109,  109,   82,

			  109,  109,  109,  109,  109,  109,  109,  109,   96,  109,
			  109,  109,   99,  109,  109,  109,  104,  109,  109,  172,
			  172,  172,  138,  114,  114,  114,   44,  109,  109,  109,
			   50,  109,  109,  109,  109,   57,  109,   59,  109,  109,
			   61,  109,  109,  109,   66,  109,  109,  109,  109,  109,
			  109,  109,   83,   84,  109,   89,  109,  109,  109,   92,
			  109,  109,   94,  109,   95,  109,   97,  109,  109,  109,
			  103,  109,  109,  172,  172,  172,  114,  114,  114,  114,
			  109,   49,  109,  109,   52,  109,  109,  109,  109,   64,
			  109,   68,  109,  109,   71,  109,   72,  109,  109,  109,

			  109,  109,  109,   93,  109,  109,  109,  105,  109,  172,
			  172,  172,  114,  114,  114,  114,  114,  109,   51,  109,
			   54,  109,   60,  109,   62,  109,   69,  109,  109,   80,
			  109,   84,  109,   90,  109,  109,   98,  109,  102,  109,
			  172,  155,  162,  158,  162,  114,  114,   45,  109,   73,
			  109,   88,  109,   91,  109,  154,  162, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1714
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 593
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 594
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
