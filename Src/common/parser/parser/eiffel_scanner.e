indexing

	description: "Scanners for Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit
	EIFFEL_SCANNER_SKELETON
		redefine
			read_token
		end

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
--|#line 41 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 41")
end
current_position.go_to (text_count)
when 2 then
--|#line 46 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 46")
end
current_position.go_to (text_count)
when 3 then
--|#line 47 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 47")
end

				line_number := line_number + text_count
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 4 then
--|#line 57 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 57")
end

				current_position.go_to (1)
				last_token := TE_SEMICOLON
			
when 5 then
--|#line 61 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 61")
end

				current_position.go_to (1)
				last_token := TE_COLON
			
when 6 then
--|#line 65 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 65")
end

				current_position.go_to (1)
				last_token := TE_COMMA
			
when 7 then
--|#line 69 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 69")
end

				current_position.go_to (2)
				last_token := TE_DOTDOT
			
when 8 then
--|#line 73 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 73")
end

				current_position.go_to (1)
				last_token := TE_QUESTION
			
when 9 then
--|#line 77 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 77")
end

				current_position.go_to (1)
				last_token := TE_TILDE
			
when 10 then
--|#line 81 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 81")
end

				current_position.go_to (2)
				last_token := TE_CURLYTILDE
			
when 11 then
--|#line 85 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 85")
end

				current_position.go_to (1)
				last_token := TE_DOT
			
when 12 then
--|#line 89 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 89")
end

				current_position.go_to (1)
				last_token := TE_ADDRESS
			
when 13 then
--|#line 93 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 93")
end

				current_position.go_to (2)
				last_token := TE_ASSIGN
			
when 14 then
--|#line 97 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 97")
end

				current_position.go_to (2)
				last_token := TE_ACCEPT
			
when 15 then
--|#line 101 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 101")
end

				current_position.go_to (1)
				last_token := TE_EQ
			
when 16 then
--|#line 105 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 105")
end

				current_position.go_to (1)
				last_token := TE_LT
			
when 17 then
--|#line 109 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 109")
end

				current_position.go_to (1)
				last_token := TE_GT
			
when 18 then
--|#line 113 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 113")
end

				current_position.go_to (2)
				last_token := TE_LE
			
when 19 then
--|#line 117 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 117")
end

				current_position.go_to (2)
				last_token := TE_GE
			
when 20 then
--|#line 121 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 121")
end

				current_position.go_to (2)
				last_token := TE_NE
			
when 21 then
--|#line 125 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 125")
end

				current_position.go_to (1)
				last_token := TE_LPARAN
			
when 22 then
--|#line 129 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 129")
end

				current_position.go_to (1)
				last_token := TE_RPARAN
			
when 23 then
--|#line 133 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 133")
end

				current_position.go_to (1)
				last_token := TE_LCURLY
			
when 24 then
--|#line 137 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 137")
end

				current_position.go_to (1)
				last_token := TE_RCURLY
			
when 25 then
--|#line 141 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 141")
end

				current_position.go_to (1)
				last_token := TE_LSQURE
			
when 26 then
--|#line 145 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 145")
end

				current_position.go_to (1)
				last_token := TE_RSQURE
			
when 27 then
--|#line 149 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 149")
end

				current_position.go_to (1)
				last_token := TE_PLUS
			
when 28 then
--|#line 153 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 153")
end

				current_position.go_to (1)
				last_token := TE_MINUS
			
when 29 then
--|#line 157 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 157")
end

				current_position.go_to (1)
				last_token := TE_STAR
			
when 30 then
--|#line 161 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 161")
end

				current_position.go_to (1)
				last_token := TE_SLASH
			
when 31 then
--|#line 165 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 165")
end

				current_position.go_to (1)
				last_token := TE_POWER
			
when 32 then
--|#line 169 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 169")
end

				current_position.go_to (2)
				last_token := TE_CONSTRAIN
			
when 33 then
--|#line 173 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 173")
end

				current_position.go_to (1)
				last_token := TE_BANG
			
when 34 then
--|#line 177 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 177")
end

				current_position.go_to (2)
				last_token := TE_LARRAY
			
when 35 then
--|#line 181 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 181")
end

				current_position.go_to (2)
				last_token := TE_RARRAY
			
when 36 then
--|#line 185 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 185")
end

				current_position.go_to (2)
				last_token := TE_DIV
			
when 37 then
--|#line 189 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 189")
end

				current_position.go_to (2)
				last_token := TE_MOD
			
when 38 then
--|#line 197 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 197")
end


					-- Note: Free operators are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (token_buffer.count)
				last_token := TE_FREE
			
when 39 then
--|#line 212 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 212")
end

				current_position.go_to (5)
				last_token := TE_AGENT
			
when 40 then
--|#line 216 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 216")
end

				current_position.go_to (5)
				last_token := TE_ALIAS
			
when 41 then
--|#line 220 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 220")
end

				current_position.go_to (3)
				last_token := TE_ALL
			
when 42 then
--|#line 224 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 224")
end

				current_position.go_to (3)
				last_token := TE_AND
			
when 43 then
--|#line 228 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 228")
end

				current_position.go_to (2)
				last_token := TE_AS
			
when 44 then
--|#line 232 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 232")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end

				current_position.go_to (6)
				last_token := TE_ID
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
							current_position.end_position, filename, 0,
							"Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 45 then
--|#line 249 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 249")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end

				current_position.go_to (9)
				last_token := TE_ID
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
							current_position.end_position, filename, 0,
							"Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			
when 46 then
--|#line 266 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 266")
end

				current_position.go_to (3)
				last_token := TE_BIT
			
when 47 then
--|#line 270 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 270")
end

				current_position.go_to (5)
				last_token := TE_CHECK
			
when 48 then
--|#line 274 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 274")
end

				current_position.go_to (5)
				last_token := TE_CLASS
			
when 49 then
--|#line 278 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 278")
end

				current_position.go_to (7)
				last_token := TE_CONVERT
			
when 50 then
--|#line 282 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 282")
end

				current_position.go_to (6)
				last_token := TE_CREATE
			
when 51 then
--|#line 286 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 286")
end

				current_position.go_to (8)
				last_token := TE_CREATION
			
when 52 then
--|#line 290 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 290")
end

				current_position.go_to (7)
				last_token := TE_CURRENT
			
when 53 then
--|#line 294 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 294")
end

				current_position.go_to (5)
				last_token := TE_DEBUG
			
when 54 then
--|#line 298 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 298")
end

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 55 then
--|#line 302 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 302")
end

				current_position.go_to (2)
				last_token := TE_DO
			
when 56 then
--|#line 306 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 306")
end

				current_position.go_to (4)
				last_token := TE_ELSE
			
when 57 then
--|#line 310 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 310")
end

				current_position.go_to (6)
				last_token := TE_ELSEIF
			
when 58 then
--|#line 314 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 314")
end

				current_position.go_to (3)
				last_token := TE_END
			
when 59 then
--|#line 318 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 318")
end

				current_position.go_to (6)
				last_token := TE_ENSURE
			
when 60 then
--|#line 322 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 322")
end

				current_position.go_to (8)
				last_token := TE_EXPANDED
			
when 61 then
--|#line 326 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 326")
end

				current_position.go_to (6)
				last_token := TE_EXPORT
			
when 62 then
--|#line 330 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 330")
end

				current_position.go_to (8)
				last_token := TE_EXTERNAL
			
when 63 then
--|#line 334 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 334")
end

				current_position.go_to (5)
				last_token := TE_FALSE
			
when 64 then
--|#line 338 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 338")
end

				current_position.go_to (7)
				last_token := TE_FEATURE
			
when 65 then
--|#line 342 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 342")
end

				current_position.go_to (4)
				last_token := TE_FROM
			
when 66 then
--|#line 346 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 346")
end

				current_position.go_to (6)
				last_token := TE_FROZEN
			
when 67 then
--|#line 350 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 350")
end

				current_position.go_to (2)
				last_token := TE_IF
			
when 68 then
--|#line 354 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 354")
end

				current_position.go_to (7)
				last_token := TE_IMPLIES
			
when 69 then
--|#line 358 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 358")
end

				current_position.go_to (8)
				last_token := TE_INDEXING
			
when 70 then
--|#line 362 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 362")
end

				current_position.go_to (5)
				last_token := TE_INFIX
			
when 71 then
--|#line 366 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 366")
end

				current_position.go_to (7)
				last_token := TE_INHERIT
			
when 72 then
--|#line 370 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 370")
end

				current_position.go_to (7)
				last_token := TE_INSPECT
			
when 73 then
--|#line 374 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 374")
end

				current_position.go_to (9)
				last_token := TE_INVARIANT
			
when 74 then
--|#line 378 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 378")
end

				current_position.go_to (2)
				last_token := TE_IS
			
when 75 then
--|#line 382 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 382")
end

				current_position.go_to (4)
				last_token := TE_LIKE
			
when 76 then
--|#line 386 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 386")
end

				current_position.go_to (5)
				last_token := TE_LOCAL
			
when 77 then
--|#line 390 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 390")
end

				current_position.go_to (4)
				last_token := TE_LOOP
			
when 78 then
--|#line 394 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 394")
end

				current_position.go_to (3)
				last_token := TE_NOT
			
when 79 then
--|#line 398 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 398")
end

				current_position.go_to (8)
				last_token := TE_OBSOLETE
			
when 80 then
--|#line 402 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 402")
end

				current_position.go_to (3)
				last_token := TE_OLD
			
when 81 then
	yy_end := yy_end - 1
--|#line 418 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 418")
end

				current_position.go_to (text_count)
				last_token := TE_ONCE_STRING
			
when 82 then
	yy_end := yy_end - 1
--|#line 422 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 422")
end

				current_position.go_to (text_count)
				last_token := TE_ONCE_STRING
			
when 83 then
	yy_end := yy_end - 1
--|#line 426 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 426")
end

				current_position.go_to (text_count)
				last_token := TE_ONCE_STRING
			
when 84 then
--|#line 430 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 430")
end

				current_position.go_to (4)
				last_token := TE_ONCE
			
when 85 then
--|#line 434 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 434")
end

				current_position.go_to (2)
				last_token := TE_OR
			
when 86 then
--|#line 438 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 438")
end

				current_position.go_to (9)
				last_token := TE_PRECURSOR
			
when 87 then
--|#line 442 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 442")
end

				current_position.go_to (6)
				last_token := TE_PREFIX
			
when 88 then
--|#line 446 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 446")
end

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
when 89 then
--|#line 450 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 450")
end

				current_position.go_to (9)
				last_token := TE_REFERENCE
			
when 90 then
--|#line 454 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 454")
end

				current_position.go_to (6)
				last_token := TE_RENAME
			
when 91 then
--|#line 458 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 458")
end

				current_position.go_to (7)
				last_token := TE_REQUIRE
			
when 92 then
--|#line 462 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 462")
end

				current_position.go_to (6)
				last_token := TE_RESCUE
			
when 93 then
--|#line 466 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 466")
end

				current_position.go_to (6)
				last_token := TE_RESULT
			
when 94 then
--|#line 470 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 470")
end

				current_position.go_to (5)
				last_token := TE_RETRY
			
when 95 then
--|#line 474 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 474")
end

				current_position.go_to (6)
				last_token := TE_SELECT
			
when 96 then
--|#line 478 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 478")
end

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
when 97 then
--|#line 482 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 482")
end

				current_position.go_to (5)
				last_token := TE_STRIP
			
when 98 then
--|#line 486 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 486")
end

				current_position.go_to (4)
				last_token := TE_THEN
			
when 99 then
--|#line 490 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 490")
end

				current_position.go_to (4)
				last_token := TE_TRUE
			
when 100 then
--|#line 494 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 494")
end

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
when 101 then
--|#line 498 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 498")
end

				current_position.go_to (6)
				last_token := TE_UNIQUE
			
when 102 then
--|#line 502 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 502")
end

				current_position.go_to (5)
				last_token := TE_UNTIL
			
when 103 then
--|#line 506 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 506")
end

				current_position.go_to (7)
				last_token := TE_VARIANT
			
when 104 then
--|#line 510 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 510")
end

				current_position.go_to (4)
				last_token := TE_VOID
			
when 105 then
--|#line 514 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 514")
end

				current_position.go_to (4)
				last_token := TE_WHEN
			
when 106 then
--|#line 518 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 518")
end

				current_position.go_to (3)
				last_token := TE_XOR
			
when 107 then
--|#line 526 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 526")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
				if token_buffer.count > maximum_string_length then
					report_too_long_string
				end
			
when 108 then
--|#line 540 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 540")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 109 then
--|#line 550 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 550")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 110 then
	yy_end := yy_end - 2
--|#line 551 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 551")
end
		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 111 then
--|#line 564 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 564")
end

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 112 then
--|#line 571 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 571")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 113 then
--|#line 580 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 580")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 114 then
--|#line 593 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 593")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 115 then
--|#line 599 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 599")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 116 then
--|#line 606 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 606")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 117 then
--|#line 612 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 612")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 118 then
--|#line 618 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 618")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 119 then
--|#line 624 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 624")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 630 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 630")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 636 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 636")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 642 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 642")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 648 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 648")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 654 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 654")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 660 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 660")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 666 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 666")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 672 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 672")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 678 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 678")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 684 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 684")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 690 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 690")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 696 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 696")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 702 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 702")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 133 then
--|#line 708 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 708")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 134 then
--|#line 714 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 714")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 135 then
--|#line 720 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 720")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 136 then
--|#line 726 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 726")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 137 then
--|#line 732 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 732")
end

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 138, 139 then
--|#line 736 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 736")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 140 then
--|#line 747 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 747")
end

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 141 then
--|#line 751 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 751")
end

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 142 then
--|#line 755 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 755")
end

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 143 then
--|#line 759 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 759")
end

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 144 then
--|#line 763 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 763")
end

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 145 then
--|#line 767 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 767")
end

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 146 then
--|#line 771 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 771")
end

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 147 then
--|#line 775 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 775")
end

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 148 then
--|#line 779 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 779")
end

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 149 then
--|#line 783 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 783")
end

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 150 then
--|#line 787 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 787")
end

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 151 then
--|#line 791 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 791")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 152 then
--|#line 797 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 797")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 153 then
--|#line 803 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 803")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 154 then
--|#line 809 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 809")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 155 then
--|#line 815 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 815")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 156 then
--|#line 821 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 821")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 157 then
--|#line 827 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 827")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 158 then
--|#line 833 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 833")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string
				end
			
when 159 then
--|#line 842 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 842")
end

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 160 then
--|#line 847 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 847")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string
				end
			
when 161 then
--|#line 857 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 857")
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
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			
when 162 then
--|#line 873 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 873")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			
when 163 then
--|#line 880 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 880")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 164 then
--|#line 900 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 900")
end

				if is_verbatim_string_closer then
					current_position.go_to (text_count)
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
								create {SYNTAX_WARNING}.make (
									current_position.start_position,
									current_position.end_position,
									filename,
									0,
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
							report_too_long_string
						end
					end
				else
					current_position.go_to (text_count)
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 165 then
--|#line 948 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 948")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 166 then
--|#line 953 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 953")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			
when 167 then
--|#line 964 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 964")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 168 then
--|#line 980 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 980")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			
when 169 then
--|#line 992 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 992")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
--|#line 1005 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1005")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			
when 171 then
--|#line 1015 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1015")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 172 then
--|#line 1019 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1019")
end

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 173 then
--|#line 1023 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1023")
end

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 174 then
--|#line 1027 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1027")
end

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 175 then
--|#line 1031 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1031")
end

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 176 then
--|#line 1035 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1035")
end

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 177 then
--|#line 1039 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1039")
end

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 178 then
--|#line 1043 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1043")
end

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 179 then
--|#line 1047 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1047")
end

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 180 then
--|#line 1051 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1051")
end

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 181 then
--|#line 1055 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1055")
end

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 182 then
--|#line 1059 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1059")
end

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 183 then
--|#line 1063 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1063")
end

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 184 then
--|#line 1067 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1067")
end

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 185 then
--|#line 1071 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1071")
end

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 186 then
--|#line 1075 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1075")
end

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 187 then
--|#line 1079 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1079")
end

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 188 then
--|#line 1083 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1083")
end

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 189 then
--|#line 1087 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1087")
end

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 190 then
--|#line 1091 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1091")
end

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 191 then
--|#line 1095 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1095")
end

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 192 then
--|#line 1099 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1099")
end

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 193 then
--|#line 1103 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1103")
end

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 194 then
--|#line 1107 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1107")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.reset_column_positions	
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 195 then
--|#line 1115 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1115")
end

				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string
					end
				end
			
when 196 then
--|#line 1131 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1131")
end

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 197 then
--|#line 1137 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1137")
end

					-- No final double-quote.
				line_number := line_number + 1
				current_position.reset_column_positions	
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 198 then
--|#line 1164 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1164")
end

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 199 then
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

				if inherit_context then
					inherit_context := False
					last_token := TE_END
				else
					terminate
				end
			
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

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	SPECIAL_STR: INTEGER is 1
	VERBATIM_STR1: INTEGER is 2
	VERBATIM_STR2: INTEGER is 3
	VERBATIM_STR3: INTEGER is 4
			-- Start condition codes

feature -- User-defined features



feature -- Scanning

	read_token is
			-- Read a token from `input_buffer'.
			-- Make result available in `last_token'.
			--| Redefined for performance reasons.
		local
			yy_cp, yy_bp: INTEGER
			yy_current_state: INTEGER
			yy_next_state: INTEGER
			yy_matched_count: INTEGER
			yy_act: INTEGER
			yy_goto: INTEGER
			yy_c: INTEGER
			yy_found: BOOLEAN
			yy_rejected_line: INTEGER
			yy_rejected_column: INTEGER
			yy_rejected_position: INTEGER
		do
				-- This routine is implemented with a loop whose body
				-- is a big inspect instruction. This is a mere
				-- translation of C gotos into Eiffel. Needless to
				-- say that I'm not very proud of this piece of code.
				-- However I performed some benchmarks and the results
				-- were that this implementation runs amazingly faster
				-- than an alternative implementation with no loop nor
				-- inspect instructions and where every branch of the
				-- old inspect instruction was written in a separate
				-- routine. I think that the performance penalty is due
				-- to the routine call overhead and the depth of the call
				-- stack. Anyway, I prefer to provide you with a big and
				-- ugly but fast scanning routine rather than a nice and
				-- slow version. I hope you won't blame me for that! :-)
			from
				last_token := yyUnknown_token
				yy_goto := yyNext_token
			until
				last_token /= yyUnknown_token
			loop
				inspect yy_goto
				when yyNext_token then
					if yy_more_flag then
						yy_more_len := yy_end - yy_start
						yy_more_flag := False
					else
						yy_more_len := 0
						line := yy_line
						column := yy_column
						position := yy_position
					end
					yy_cp := yy_end
						-- `yy_bp' is the position of the first
						-- character of the current token.
					yy_bp := yy_cp
						-- Find the start state.
					yy_current_state := yy_start_state + yy_at_beginning_of_line
					if yyReject_or_variable_trail_context then
							-- Set up for storing up states.
						yy_state_stack.put (yy_current_state, 0)
						yy_state_count := 1
					end
					yy_goto := yyMatch
				when yyMatch then
						-- Find the next match.
					from
						if yy_ec /= Void then
							yy_c := yy_ec.item (yy_content.item (yy_cp).code)
						else
							yy_c := yy_content.item (yy_cp).code
						end
						if
							not yyReject_or_variable_trail_context and then
							yy_accept.item (yy_current_state) /= 0
						then
								-- Save the backing-up info before computing
								-- the next state because we always compute one
								-- more state than needed - we always proceed
								-- until we reach a jam state.
							yy_last_accepting_state := yy_current_state
							yy_last_accepting_cpos := yy_cp
						end
						from until
							yy_chk.item (yy_base.item (yy_current_state) + yy_c) = yy_current_state
						loop
							yy_current_state := yy_def.item (yy_current_state)
							if
								yy_meta /= Void and then
								yy_current_state >= yyTemplate_mark
							then
									-- We've arranged it so that templates are
									-- never chained to one another. This means
									-- we can afford to make a very simple test
									-- to see if we need to convert to `yy_c''s
									-- meta-equivalence class without worrying
									-- about erroneously looking up the meta
									-- equivalence class twice.
								yy_c := yy_meta.item (yy_c)
							end
						end
						yy_current_state := yy_nxt.item (yy_base.item (yy_current_state) + yy_c)
						if yyReject_or_variable_trail_context then
							yy_state_stack.put (yy_current_state, yy_state_count)
							yy_state_count := yy_state_count + 1
						end
						yy_cp := yy_cp + 1
					until
						yy_current_state = yyJam_state
					loop
						if yy_ec /= Void then
							yy_c := yy_ec.item (yy_content.item (yy_cp).code)
						else
							yy_c := yy_content.item (yy_cp).code
						end
						if
							not yyReject_or_variable_trail_context and then
							yy_accept.item (yy_current_state) /= 0
						then
								-- Save the backing-up info before computing
								-- the next state because we always compute one
								-- more state than needed - we always proceed
								-- until we reach a jam state.
							yy_last_accepting_state := yy_current_state
							yy_last_accepting_cpos := yy_cp
						end
						from until
							yy_chk.item (yy_base.item (yy_current_state) + yy_c) = yy_current_state
						loop
							yy_current_state := yy_def.item (yy_current_state)
							if
								yy_meta /= Void and then
								yy_current_state >= yyTemplate_mark
							then
									-- We've arranged it so that templates are
									-- never chained to one another. This means
									-- we can afford to make a very simple test
									-- to see if we need to convert to `yy_c''s
									-- meta-equivalence class without worrying
									-- about erroneously looking up the meta
									-- equivalence class twice.
								yy_c := yy_meta.item (yy_c)
							end
						end
						yy_current_state := yy_nxt.item (yy_base.item (yy_current_state) + yy_c)
						if yyReject_or_variable_trail_context then
							yy_state_stack.put (yy_current_state, yy_state_count)
							yy_state_count := yy_state_count + 1
						end
						yy_cp := yy_cp + 1
					end
					if not yyReject_or_variable_trail_context then
							-- Do the guaranteed-needed backing up
							-- to find out the match.
						yy_cp := yy_last_accepting_cpos
						yy_current_state := yy_last_accepting_state
					end
					yy_goto := yyFind_action
				when yyFind_action then
						-- Find the action number.
					if not yyReject_or_variable_trail_context then
						yy_act := yy_accept.item (yy_current_state)
						yy_goto := yyDo_action
					else
						yy_state_count := yy_state_count - 1
						yy_current_state := yy_state_stack.item (yy_state_count)
						yy_lp := yy_accept.item (yy_current_state)
						yy_goto := yyFind_rule
					end
				when yyFind_rule then
						-- We branch here when backing up.
					check reject_used: yyReject_or_variable_trail_context end
					from yy_found := False until yy_found loop
						if
							yy_lp /= 0 and
							yy_lp < yy_accept.item (yy_current_state + 1)
						then
							yy_act := yy_acclist.item (yy_lp)
							if yyVariable_trail_context then
								if
									yy_act < - yyNb_rules or
									yy_looking_for_trail_begin /= 0
								then
									if yy_act = yy_looking_for_trail_begin then
										yy_looking_for_trail_begin := 0
										yy_act := - yy_act - yyNb_rules
										yy_found := True
									else
										yy_lp := yy_lp + 1
									end
								elseif yy_act < 0 then
									yy_looking_for_trail_begin := yy_act - yyNb_rules
									if yyReject_used then
											-- Remember matched text in case
											-- we back up due to `reject'.
										yy_full_match := yy_cp
										yy_full_state := yy_state_count
										yy_full_lp := yy_lp
									end
									yy_lp := yy_lp + 1
								else
									yy_full_match := yy_cp
									yy_full_state := yy_state_count
									yy_full_lp := yy_lp
									yy_found := True
								end
							else
								yy_full_match := yy_cp
								yy_found := True
							end
						else
							yy_cp := yy_cp - 1
							yy_state_count := yy_state_count - 1
							yy_current_state := yy_state_stack.item (yy_state_count)
							yy_lp := yy_accept.item (yy_current_state)
						end
					end
					yy_rejected_line := yy_line
					yy_rejected_column := yy_column
					yy_rejected_position := yy_position
					yy_goto := yyDo_action
				when yyDo_action then
						-- Set up `text' before action.
					yy_bp := yy_bp - yy_more_len
					yy_start := yy_bp
					yy_end := yy_cp
					debug ("GELEX")
					end
					yy_goto := yyNext_token
						-- Semantic actions.
					if yy_act = 0 then
							-- Must back up.
						if not yyReject_or_variable_trail_context then
								-- Backing-up info for compressed tables is
								-- taken after `yy_cp' has been incremented
								-- for the next state.
							yy_cp := yy_last_accepting_cpos
							yy_bp := yy_bp + yy_more_len
							yy_current_state := yy_last_accepting_state
							yy_goto := yyFind_action
						else
							last_token := yyError_token
							fatal_error ("fatal scanner internal error: no action found")
						end
					elseif yy_act = yyEnd_of_buffer then
							-- Amount of text matched not including
							-- the EOB character.
						yy_matched_count := yy_cp - yy_bp - 1
							-- Note that here we test for `yy_end' "<="
							-- to the position of the first EOB in the buffer,
							-- since `yy_end' will already have been 
							-- incremented past the NULL character (since all
							-- states make transitions on EOB to the 
							-- end-of-buffer state). Contrast this with the
							-- test in `read_character'.
						if yy_end <= input_buffer.count + 1 then
								-- This was really a NULL character.
							yy_end := yy_bp + yy_matched_count
							yy_current_state := yy_previous_state
								-- We're now positioned to make the NULL
								-- transition. We couldn't have
								-- `yy_previous_state' go ahead and do it
								-- for us because it doesn't know how to deal
								-- with the possibility of jamming (and we
								-- don't want to build jamming into it because
								-- then it will run more slowly).
							yy_next_state := yy_null_trans_state (yy_current_state)
							yy_bp := yy_bp + yy_more_len
							if yy_next_state /= 0 then
									-- Consume the NULL character.
								yy_cp := yy_end + 1
								yy_end := yy_cp
								yy_current_state := yy_next_state
								yy_goto := yyMatch
							else
								if yyReject_or_variable_trail_context then
										-- Still need to initialize `yy_cp',
										-- though `yy_current_state' was set
										-- up by `yy_previous_state'.
									yy_cp := yy_end
										-- Remove the state which was inserted
										-- in `yy_state_stack' by the call to
										-- `yy_null_trans_state'.
									yy_state_count := yy_state_count - 1
								else
										-- Do the guaranteed-needed backing up
										-- then figure out the match.
									yy_cp := yy_last_accepting_cpos
									yy_current_state := yy_last_accepting_state
								end
								yy_goto := yyFind_action
							end
						else
								-- Do not take the EOB character
								-- into account.
							yy_end := yy_end - 1
							yy_refill_input_buffer
							if input_buffer.filled then
								yy_current_state := yy_previous_state
								yy_cp := yy_end
								yy_bp := yy_start + yy_more_len
								yy_goto := yyMatch
							elseif
								yy_end - yy_start - yy_more_len /= 0
							then
									-- Some text has been matched prior to
									-- the EOB. First process it.
								yy_current_state := yy_previous_state
								yy_cp := yy_end
								yy_bp := yy_start + yy_more_len
								yy_goto := yyFind_action
							else
									-- Only the EOB character has been matched, 
									-- so treat this as a final EOF.
								if wrap then
									yy_bp := yy_start
									yy_cp := yy_end
									yy_execute_eof_action ((yy_start_state - 1) // 2)
								end
							end
						end
					else
						yy_execute_action (yy_act)
						if yy_rejected then
							yy_rejected := False
							yy_line := yy_rejected_line
							yy_column := yy_rejected_column
							yy_position := yy_rejected_position
								-- Restore position backed-over text.
							yy_cp := yy_full_match
							if yyVariable_trail_context then
									-- Restore original accepting position.
								yy_lp := yy_full_lp
									-- Restore original state.
								yy_state_count := yy_full_state
									-- Restore current state.
								yy_current_state := yy_state_stack.item (yy_state_count - 1)
							end
							yy_lp := yy_lp + 1
							yy_goto := yyFind_rule
						end
					end
				end
			end
			debug ("GELEX")
				print_last_token
			end
		end

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
