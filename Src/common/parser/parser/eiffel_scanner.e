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
			yy_nxt ?= yy_nxt_template
			yy_chk ?= yy_chk_template
			yy_base ?= yy_base_template
			yy_def ?= yy_def_template
			yy_ec ?= yy_ec_template
			yy_meta ?= yy_meta_template
			yy_accept ?= yy_accept_template
			yy_acclist ?= yy_acclist_template
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
			
when 108 then
--|#line 537 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 537")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 109 then
--|#line 547 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 547")
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
--|#line 548 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 548")
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
--|#line 561 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 561")
end

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 112 then
--|#line 568 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 568")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 113 then
--|#line 577 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 577")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 114 then
--|#line 590 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 590")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 115 then
--|#line 596 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 596")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 116 then
--|#line 603 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 603")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 117 then
--|#line 609 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 609")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 118 then
--|#line 615 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 615")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 119 then
--|#line 621 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 621")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 627 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 627")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 633 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 633")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 639 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 639")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 645 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 645")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 651 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 651")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 657 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 657")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 663 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 663")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 669 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 669")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 675 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 675")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 681 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 681")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 687 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 687")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 693 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 693")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 699 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 699")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 133 then
--|#line 705 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 705")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 134 then
--|#line 711 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 711")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 135 then
--|#line 717 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 717")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 136 then
--|#line 723 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 723")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 137 then
--|#line 729 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 729")
end

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 138, 139 then
--|#line 733 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 733")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 140 then
--|#line 744 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 744")
end

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 141 then
--|#line 748 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 748")
end

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 142 then
--|#line 752 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 752")
end

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 143 then
--|#line 756 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 756")
end

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 144 then
--|#line 760 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 760")
end

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 145 then
--|#line 764 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 764")
end

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 146 then
--|#line 768 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 768")
end

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 147 then
--|#line 772 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 772")
end

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 148 then
--|#line 776 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 776")
end

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 149 then
--|#line 780 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 780")
end

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 150 then
--|#line 784 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 784")
end

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 151 then
--|#line 788 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 788")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 152 then
--|#line 794 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 794")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 153 then
--|#line 800 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 800")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 154 then
--|#line 806 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 806")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 155 then
--|#line 812 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 812")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 156 then
--|#line 818 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 818")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 157 then
--|#line 824 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 824")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 158 then
--|#line 830 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 830")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
when 159 then
--|#line 836 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 836")
end

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 160 then
--|#line 841 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 841")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 161 then
--|#line 848 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 848")
end

					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			
when 162 then
--|#line 859 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 859")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			
when 163 then
--|#line 866 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 866")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 164 then
--|#line 882 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 882")
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
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
					end
				else
					current_position.go_to (text_count)
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			
when 165 then
--|#line 912 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 912")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 166 then
--|#line 917 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 917")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
			
when 167 then
--|#line 924 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 924")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 168 then
--|#line 940 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 940")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR1)
			
when 169 then
--|#line 948 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 948")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 170 then
--|#line 961 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 961")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			
when 171 then
--|#line 971 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 971")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 172 then
--|#line 975 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 975")
end

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 173 then
--|#line 979 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 979")
end

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 174 then
--|#line 983 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 983")
end

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 175 then
--|#line 987 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 987")
end

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 176 then
--|#line 991 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 991")
end

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 177 then
--|#line 995 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 995")
end

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 178 then
--|#line 999 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 999")
end

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 179 then
--|#line 1003 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1003")
end

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 180 then
--|#line 1007 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1007")
end

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 181 then
--|#line 1011 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1011")
end

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 182 then
--|#line 1015 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1015")
end

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 183 then
--|#line 1019 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1019")
end

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 184 then
--|#line 1023 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1023")
end

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 185 then
--|#line 1027 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1027")
end

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 186 then
--|#line 1031 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1031")
end

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 187 then
--|#line 1035 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1035")
end

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 188 then
--|#line 1039 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1039")
end

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 189 then
--|#line 1043 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1043")
end

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 190 then
--|#line 1047 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1047")
end

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 191 then
--|#line 1051 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1051")
end

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 192 then
--|#line 1055 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1055")
end

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 193 then
--|#line 1059 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1059")
end

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 194 then
--|#line 1063 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1063")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.reset_column_positions	
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 195 then
--|#line 1071 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1071")
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
				end
			
when 196 then
--|#line 1084 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1084")
end

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 197 then
--|#line 1090 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1090")
end

					-- No final double-quote.
				line_number := line_number + 1
				current_position.reset_column_positions	
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 198 then
--|#line 1117 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1117")
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

	yy_nxt_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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
			   61,   62,   64,   64,  188,   65,   65,  189,   66,   66,

			   68,   69,   68,  124,   70,   68,   69,   68,  144,   70,
			   75,   76,   75,   75,   76,   75,   77,   98,   77,   99,
			  100,  102,  104,  103,  103,  103,  113,  114,  149,  105,
			  101,  115,  116,  150,  106,  124,  107,  107,  108,   77,
			  144,   77,  106,  535,  107,  107,  108,  109,  106,  401,
			  108,  108,  108,  495,  467,  109,   71,  195,  196,  195,
			  149,   71,   80,   81,  188,  150,   81,  189,  339,  110,
			   82,   83,  338,   84,  151,   85,  111,  337,  155,  109,
			  336,   86,  335,   87,  111,   81,   88,  109,  334,  152,
			  111,  119,  130,  132,   89,  133,  120,  158,  121,   90,

			   91,  110,  131,  122,  123,  134,  151,  125,  197,   92,
			  155,  126,   93,   94,  127,   95,  188,  128,   88,  192,
			  129,  152,  187,  119,  130,  132,   89,  133,  120,  158,
			  121,   90,   91,  159,  131,  122,  123,  134,  135,  125,
			  138,   92,  136,  126,  142,   81,  127,  139,  140,  128,
			  143,  145,  129,  141,  153,  137,  333,  156,   93,  200,
			  201,  146,  202,  147,  154,  159,  332,  148,  252,  331,
			  135,  157,  138,  330,  136,  203,  142,  329,  205,  139,
			  140,  207,  143,  145,  473,  141,  153,  137,  204,  156,
			  190,  188,  190,  146,  189,  147,  154,  197,  206,  148,

			  252,  208,  328,  157,  164,  164,  164,  197,  165,   93,
			   93,  166,   93,  167,  168,  169,  197,   79,   79,  197,
			   79,  170,  198,  197,  197,   93,  111,  171,   93,  172,
			  217,   93,  173,  174,  175,  176,  327,  177,  212,  178,
			  251,  251,  251,  179,  209,  180,  191,   93,  181,  182,
			  183,  184,  185,  186,  211,  210,  326,   93,  214,  215,
			  214,  213,  197,  243,  243,  243,   93,  255,  253,   93,
			  212,  254,  199,   93,   93,  216,  209,  244,  256,  245,
			   93,  246,  246,  246,  325,  257,  211,  210,  106,  258,
			  248,  248,  249,  213,  106,  247,  249,  249,  249,  255,

			  253,  109,  324,  254,  307,  307,  307,  322,  321,  244,
			  256,  259,   93,  220,  260,  261,  221,  257,  222,  223,
			  224,  258,  195,  196,  195,  320,  225,  247,  262,  263,
			  111,  264,  226,  109,  227,  265,  111,  228,  229,  230,
			  231,  266,  232,  259,  233,  271,  260,  261,  234,  267,
			  235,  272,  273,  236,  237,  238,  239,  240,  241,  274,
			  262,  263,  269,  264,  268,  280,  270,  265,  281,  283,
			  275,  284,  276,  266,  277,  285,  286,  271,  287,  308,
			  282,  267,  294,  272,  273,  278,  295,  188,  279,  296,
			  192,  274,  309,  187,  269,  297,  268,  280,  270,  298,

			  281,  283,  275,  284,  276,  302,  277,  285,  286,  288,
			  287,  289,  282,  303,  294,  304,  305,  278,  295,  290,
			  279,  296,  291,  299,  292,  293,  310,  297,  300,   93,
			  197,  298,  197,  164,  164,  164,  197,  302,  197,  301,
			  306,  288,   93,  289,  314,  303,  315,  304,  305,  317,
			  319,  290,  318,  194,  291,  299,  292,  293,  350,  311,
			  300,  190,  188,  190,  163,  189,  351,   79,  214,  215,
			  214,  301,  198,  313,  242,  312,   93,  219,   78,  316,
			   93,  194,   93,  214,  215,  214,   93,  197,   93,  352,
			  350,  311,  323,  323,  323,  163,   93,  161,  351,   93,

			  340,  340,  340,  353,  354,  313,  106,  312,  348,  348,
			  348,  316,  355,  341,  244,  341,  160,  191,  342,  342,
			  342,  352,  199,  356,  343,  343,  343,  345,  357,  345,
			  358,  359,  346,  346,  346,  353,  354,   93,  344,  106,
			  360,  347,  347,  348,  355,  361,  244,  362,  111,  349,
			  349,  349,  109,  363,  365,  356,  366,  367,  368,  370,
			  357,  371,  358,  359,  372,  373,  374,  364,  375,  376,
			  344,  369,  360,  377,  378,  379,  380,  361,  383,  362,
			  381,  111,  384,  382,  109,  363,  365,  385,  366,  367,
			  368,  370,  386,  371,  389,  387,  372,  373,  374,  364,

			  375,  376,  390,  369,  391,  377,  378,  379,  380,  392,
			  383,  393,  381,  388,  384,  382,  394,  395,  396,  385,
			  397,  398,  399,  400,  386,  197,  389,  387,  401,  402,
			  402,  402,  406,  403,  390,  404,  391,  197,  408,  117,
			  112,  392,   78,  393,  580,  388,   73,   73,  394,  395,
			  396,  417,  397,  398,  399,  400,  409,  323,  323,  323,
			  405,  418,  410,  410,  410,  407,  342,  342,  342,  342,
			  342,  342,  412,  412,  412,   93,  244,  346,  346,  346,
			  419,  420,   93,  417,  580,   93,  344,   93,   93,  413,
			  421,  413,  405,  418,  414,  414,  414,  407,  346,  346,

			  346,  415,  411,  347,  347,  348,  422,  415,  244,  348,
			  348,  348,  419,  420,  109,  416,  416,  416,  344,  423,
			  424,  425,  421,  426,  427,  428,  429,  430,  431,  432,
			  433,  434,  435,  436,  437,  438,  439,  440,  422,  441,
			  442,  443,  469,  469,  469,  447,  109,  448,  449,  450,
			  451,  423,  424,  425,  452,  426,  427,  428,  429,  430,
			  431,  432,  433,  434,  435,  436,  437,  438,  439,  440,
			  453,  441,  442,  443,  444,  444,  444,  447,  445,  448,
			  449,  450,  451,  454,  455,  456,  452,  457,  458,  446,
			  459,  460,  461,  462,  401,  463,  463,  463,  197,  197,

			  197,  580,  453,  414,  414,  414,  474,  410,  410,  410,
			  475,  476,  470,  470,  470,  454,  455,  456,  580,  457,
			  458,  468,  459,  460,  461,  462,  344,  414,  414,  414,
			  245,  465,  470,  470,  470,  466,  477,  479,  474,  480,
			  478,  464,  475,  476,  481,  482,  472,  483,   93,   93,
			   93,  484,  471,  468,  485,  486,  487,  488,  344,  489,
			  490,  491,  492,  465,  493,  496,  497,  466,  477,  479,
			  498,  480,  478,  464,  499,  500,  481,  482,  472,  483,
			  444,  444,  444,  484,  494,  501,  485,  486,  487,  488,
			  502,  489,  490,  491,  492,  446,  493,  496,  497,  503,

			  504,  505,  498,  506,  507,  508,  499,  500,  197,  197,
			  197,  580,  521,  512,  522,  512,  523,  501,  513,  513,
			  513,  580,  502,  517,  517,  517,  514,  514,  514,  580,
			  580,  503,  504,  505,  524,  506,  507,  508,  510,  509,
			  515,  470,  470,  470,  521,  525,  522,  518,  523,  518,
			  526,  511,  519,  519,  519,  516,  527,  528,   93,   93,
			   93,  517,  517,  517,  529,  530,  524,  531,  532,  533,
			  510,  509,  515,  534,  536,  520,  537,  525,  538,  539,
			  540,  541,  526,  511,  542,  197,  197,  516,  527,  528,
			  197,  513,  513,  513,  555,  580,  529,  530,  580,  531,

			  532,  533,  513,  513,  513,  534,  536,  520,  537,  580,
			  538,  539,  540,  541,  543,  580,  542,  580,  545,  546,
			  546,  546,  556,  547,  580,  547,  555,  544,  548,  548,
			  548,  570,  549,  515,  549,   93,   93,  550,  550,  550,
			   93,  551,  551,  551,  557,  558,  543,  519,  519,  519,
			  545,  519,  519,  519,  556,  552,  553,  559,  553,  544,
			  560,  554,  554,  554,  561,  515,  562,  535,  535,  535,
			  564,  563,  565,  566,  567,  568,  557,  558,  197,  571,
			  580,   93,  446,  579,  515,  580,  580,  552,  580,  559,
			  580,  575,  560,  548,  548,  548,  561,  580,  562,  548,

			  548,  548,  564,  580,  565,  566,  567,  568,  580,  576,
			  411,  550,  550,  550,  577,  569,  515,  550,  550,  550,
			  572,  572,  572,  575,  578,  573,  552,  573,   93,   93,
			  574,  574,  574,   93,  552,  554,  554,  554,  554,  554,
			  554,  576,  574,  574,  574,  580,  577,  569,  574,  574,
			  574,  580,  471,  250,  250,  250,  578,  580,  552,  580,
			  580,  580,  580,  580,  580,  580,  552,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   72,   72,   72,   72,   72,   72,   72,

			   72,   72,   72,   72,   72,   72,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   79,
			  580,   79,  580,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   96,  580,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   97,  580,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  162,  580,  162,  580,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  187,  187,  187,
			  187,  191,  191,  191,  191,  191,  191,  191,  191,  191,

			  191,  191,  191,  191,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,   81,  580,   81,
			  580,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			  218,  580,  218,  218,  218,  218,  218,  218,  218,  218,
			  218,  218,  218,  100,  580,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  495,  495,  495,  495,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,   11,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,

			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580>>)
		end

	yy_chk_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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

			    5,    5,    5,   38,    5,    6,    6,    6,   46,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   48,   27,
			   25,   35,   35,   49,   28,   38,   28,   28,   28,   77,
			   46,   77,   29,  495,   29,   29,   29,   28,   30,  463,
			   30,   30,   30,  446,  409,   29,    5,   75,   75,   75,
			   48,    6,   16,   16,  187,   49,   16,  187,  241,   28,
			   16,   16,  240,   16,   50,   16,   28,  239,   52,   28,
			  238,   16,  237,   16,   29,   16,   16,   29,  236,   50,
			   30,   37,   40,   41,   16,   41,   37,   54,   37,   16,

			   16,   28,   40,   37,   37,   41,   50,   39,   79,   16,
			   52,   39,   16,   16,   39,   16,   71,   39,   16,   71,
			   39,   50,   71,   37,   40,   41,   16,   41,   37,   54,
			   37,   16,   16,   55,   40,   37,   37,   41,   42,   39,
			   44,   16,   42,   39,   45,   16,   39,   44,   44,   39,
			   45,   47,   39,   44,   51,   42,  235,   53,   79,   82,
			   83,   47,   84,   47,   51,   55,  234,   47,  119,  233,
			   42,   53,   44,  232,   42,   85,   45,  231,   86,   44,
			   44,   87,   45,   47,  416,   44,   51,   42,   85,   53,
			   68,   68,   68,   47,   68,   47,   51,   91,   86,   47,

			  119,   87,  230,   53,   66,   66,   66,   88,   66,   82,
			   83,   66,   84,   66,   66,   66,   90,   81,   81,   89,
			   81,   66,   81,   92,   94,   85,  416,   66,   86,   66,
			   95,   87,   66,   66,   66,   66,  229,   66,   91,   66,
			  111,  111,  111,   66,   88,   66,   68,   91,   66,   66,
			   66,   66,   66,   66,   90,   89,  228,   88,   93,   93,
			   93,   92,   93,  103,  103,  103,   90,  121,  120,   89,
			   91,  120,   81,   92,   94,   94,   88,  103,  122,  106,
			   95,  106,  106,  106,  227,  123,   90,   89,  107,  124,
			  107,  107,  107,   92,  108,  106,  108,  108,  108,  121,

			  120,  107,  226,  120,  170,  170,  170,  224,  223,  103,
			  122,  125,   93,   98,  126,  127,   98,  123,   98,   98,
			   98,  124,  195,  195,  195,  222,   98,  106,  128,  129,
			  107,  130,   98,  107,   98,  130,  108,   98,   98,   98,
			   98,  132,   98,  125,   98,  135,  126,  127,   98,  133,
			   98,  136,  137,   98,   98,   98,   98,   98,   98,  139,
			  128,  129,  134,  130,  133,  142,  134,  130,  143,  144,
			  140,  145,  140,  132,  140,  146,  147,  135,  149,  204,
			  143,  133,  151,  136,  137,  140,  151,  191,  140,  152,
			  191,  139,  206,  191,  134,  153,  133,  142,  134,  154,

			  143,  144,  140,  145,  140,  156,  140,  146,  147,  150,
			  149,  150,  143,  157,  151,  158,  159,  140,  151,  150,
			  140,  152,  150,  155,  150,  150,  208,  153,  155,  204,
			  211,  154,  209,  164,  164,  164,  210,  156,  213,  155,
			  164,  150,  206,  150,  212,  157,  212,  158,  159,  216,
			  221,  150,  220,  193,  150,  155,  150,  150,  252,  209,
			  155,  190,  190,  190,  162,  190,  253,  199,  199,  199,
			  199,  155,  199,  211,   99,  210,  208,   97,   78,  213,
			  211,   72,  209,  214,  214,  214,  210,  214,  213,  256,
			  252,  209,  225,  225,  225,   63,  212,   61,  253,  216,

			  243,  243,  243,  257,  259,  211,  249,  210,  249,  249,
			  249,  213,  260,  244,  243,  244,   57,  190,  244,  244,
			  244,  256,  199,  261,  246,  246,  246,  247,  262,  247,
			  263,  264,  247,  247,  247,  257,  259,  214,  246,  248,
			  265,  248,  248,  248,  260,  266,  243,  268,  249,  251,
			  251,  251,  248,  269,  270,  261,  271,  272,  273,  274,
			  262,  275,  263,  264,  276,  277,  278,  269,  279,  280,
			  246,  273,  265,  281,  282,  284,  286,  266,  288,  268,
			  287,  248,  289,  287,  248,  269,  270,  290,  271,  272,
			  273,  274,  291,  275,  293,  292,  276,  277,  278,  269,

			  279,  280,  294,  273,  295,  281,  282,  284,  286,  296,
			  288,  297,  287,  292,  289,  287,  298,  299,  300,  290,
			  301,  302,  303,  304,  291,  312,  293,  292,  307,  307,
			  307,  307,  313,  311,  294,  311,  295,  314,  316,   36,
			   31,  296,   14,  297,   11,  292,    8,    7,  298,  299,
			  300,  350,  301,  302,  303,  304,  323,  323,  323,  323,
			  312,  351,  340,  340,  340,  314,  341,  341,  341,  342,
			  342,  342,  343,  343,  343,  312,  340,  345,  345,  345,
			  352,  353,  313,  350,    0,  311,  343,  314,  316,  344,
			  354,  344,  312,  351,  344,  344,  344,  314,  346,  346,

			  346,  347,  340,  347,  347,  347,  355,  348,  340,  348,
			  348,  348,  352,  353,  347,  349,  349,  349,  343,  356,
			  357,  358,  354,  359,  360,  361,  362,  363,  364,  365,
			  366,  367,  369,  370,  371,  372,  373,  374,  355,  375,
			  377,  379,  411,  411,  411,  381,  347,  382,  383,  384,
			  385,  356,  357,  358,  386,  359,  360,  361,  362,  363,
			  364,  365,  366,  367,  369,  370,  371,  372,  373,  374,
			  387,  375,  377,  379,  380,  380,  380,  381,  380,  382,
			  383,  384,  385,  388,  389,  390,  386,  391,  392,  380,
			  395,  396,  397,  398,  402,  402,  402,  402,  403,  405,

			  407,    0,  387,  413,  413,  413,  419,  410,  410,  410,
			  420,  423,  412,  412,  412,  388,  389,  390,    0,  391,
			  392,  410,  395,  396,  397,  398,  412,  414,  414,  414,
			  415,  405,  415,  415,  415,  407,  424,  425,  419,  427,
			  424,  403,  420,  423,  428,  429,  415,  430,  403,  405,
			  407,  431,  412,  410,  432,  434,  435,  436,  412,  437,
			  439,  440,  441,  405,  443,  447,  448,  407,  424,  425,
			  449,  427,  424,  403,  450,  451,  428,  429,  415,  430,
			  444,  444,  444,  431,  444,  452,  432,  434,  435,  436,
			  453,  437,  439,  440,  441,  444,  443,  447,  448,  454,

			  456,  457,  449,  459,  460,  462,  450,  451,  464,  466,
			  465,    0,  475,  468,  476,  468,  478,  452,  468,  468,
			  468,    0,  453,  471,  471,  471,  469,  469,  469,    0,
			    0,  454,  456,  457,  479,  459,  460,  462,  465,  464,
			  469,  470,  470,  470,  475,  480,  476,  472,  478,  472,
			  483,  466,  472,  472,  472,  470,  485,  486,  464,  466,
			  465,  473,  473,  473,  488,  489,  479,  490,  491,  492,
			  465,  464,  469,  493,  496,  473,  498,  480,  499,  501,
			  505,  506,  483,  466,  508,  510,  509,  470,  485,  486,
			  511,  512,  512,  512,  521,    0,  488,  489,    0,  490,

			  491,  492,  513,  513,  513,  493,  496,  473,  498,    0,
			  499,  501,  505,  506,  509,    0,  508,    0,  511,  514,
			  514,  514,  523,  515,    0,  515,  521,  510,  515,  515,
			  515,  544,  516,  514,  516,  510,  509,  516,  516,  516,
			  511,  517,  517,  517,  525,  526,  509,  518,  518,  518,
			  511,  519,  519,  519,  523,  517,  520,  527,  520,  510,
			  530,  520,  520,  520,  533,  514,  534,  535,  535,  535,
			  536,  535,  537,  538,  540,  541,  525,  526,  543,  545,
			    0,  544,  535,  569,  546,    0,    0,  517,    0,  527,
			    0,  555,  530,  547,  547,  547,  533,    0,  534,  548,

			  548,  548,  536,    0,  537,  538,  540,  541,    0,  561,
			  546,  549,  549,  549,  564,  543,  546,  550,  550,  550,
			  551,  551,  551,  555,  566,  552,  572,  552,  543,  545,
			  552,  552,  552,  569,  551,  553,  553,  553,  554,  554,
			  554,  561,  573,  573,  573,    0,  564,  543,  574,  574,
			  574,    0,  572,  596,  596,  596,  566,    0,  572,    0,
			    0,    0,    0,    0,    0,    0,  551,  581,  581,  581,
			  581,  581,  581,  581,  581,  581,  581,  581,  581,  581,
			  582,  582,  582,  582,  582,  582,  582,  582,  582,  582,
			  582,  582,  582,  583,  583,  583,  583,  583,  583,  583,

			  583,  583,  583,  583,  583,  583,  584,  584,  584,  584,
			  584,  584,  584,  584,  584,  584,  584,  584,  584,  585,
			    0,  585,    0,  585,  585,  585,  585,  585,  585,  585,
			  585,  585,  586,    0,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  587,    0,  587,  587,  587,  587,  587,
			  587,  587,  587,  587,  587,  587,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  589,    0,  589,    0,  589,
			  589,  589,  589,  589,  589,  589,  589,  589,  590,  590,
			  590,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  591,  591,  591,  591,  591,  591,  591,  591,  591,

			  591,  591,  591,  591,  592,  592,  592,  592,  592,  592,
			  592,  592,  592,  592,  592,  592,  592,  593,    0,  593,
			    0,  593,  593,  593,  593,  593,  593,  593,  593,  593,
			  594,    0,  594,  594,  594,  594,  594,  594,  594,  594,
			  594,  594,  594,  595,    0,  595,  595,  595,  595,  595,
			  595,  595,  595,  595,  595,  595,  597,  597,  597,  597,
			  597,  597,  597,  597,  597,  597,  597,  597,  597,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,

			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  744,  743,  108,
			  111,  744, 1469,  114,  739, 1469,  156,    0, 1469,  108,
			 1469, 1469, 1469, 1469, 1469,  103,  103,  103,  116,  124,
			  130,  714, 1469,  101, 1469,  105,  713,  155,   65,  170,
			  158,  152,  208,    0,  205,  206,   64,  220,   81,   99,
			  140,  217,  135,  227,  160,  189, 1469,  559, 1469, 1469,
			 1469,  506, 1469,  589, 1469, 1469,  302,   91,  288, 1469,
			 1469,  213,  578, 1469, 1469,  155, 1469,  137,  575,  202,
			 1469,  316,  253,  254,  256,  269,  272,  275,  301,  313,
			  310,  291,  317,  356,  318,  324,    0,  566,  407,  563,

			    0, 1469, 1469,  343, 1469, 1469,  361,  370,  376, 1469,
			    0,  320, 1469, 1469, 1469, 1469, 1469, 1469,    0,  234,
			  330,  334,  330,  336,  340,  377,  384,  372,  394,  382,
			  400,    0,  393,  416,  417,  404,  421,  408,    0,  414,
			  437,    0,  425,  436,  420,  423,  442,  444,    0,  444,
			  476,  441,  442,  461,  449,  490,  458,  475,  481,  469,
			 1469, 1469,  558, 1469,  531, 1469, 1469, 1469, 1469, 1469,
			  384, 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469,
			 1469, 1469, 1469, 1469, 1469, 1469, 1469,  161, 1469, 1469,
			  559,  484, 1469,  550, 1469,  420, 1469, 1469, 1469,  566,

			 1469, 1469, 1469, 1469,  473, 1469,  486, 1469,  520,  526,
			  530,  524,  540,  532,  581, 1469,  543, 1469, 1469, 1469,
			  541,  539,  414,  397,  396,  572,  391,  373,  345,  325,
			  291,  266,  262,  258,  255,  245,  177,  171,  169,  166,
			  161,  157, 1469,  580,  598, 1469,  604,  612,  621,  588,
			    0,  629,  515,  536,    0,    0,  551,  556,    0,  572,
			  564,  572,  598,  583,  581,  606,  611,    0,  597,  623,
			  620,  608,  608,  616,  618,  627,  626,  631,  621,  638,
			  635,  643,  629,    0,  631,    0,  642,  648,  644,  648,
			  657,  642,  663,  647,  668,  674,  671,  668,  682,  683,

			  672,  682,  683,  689,  680,    0, 1469,  709, 1469, 1469,
			 1469,  729,  719,  726,  731, 1469,  732, 1469, 1469, 1469,
			 1469, 1469, 1469,  737, 1469, 1469, 1469, 1469, 1469, 1469,
			 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469, 1469,
			  742,  746,  749,  752,  774,  757,  778,  783,  789,  795,
			  702,  713,  744,  743,  750,  758,  785,  771,  787,  787,
			  777,  787,  779,  784,  781,  782,  796,  781,    0,  798,
			  795,  781,  782,  789,  803,  792,    0,  799,    0,  800,
			  872,  795,  809,  813,  802,  808,  816,  820,  842,  830,
			  853,  840,  843,    0,    0,  855,  841,  851,  863,    0,

			    0, 1469,  875,  892, 1469,  893, 1469,  894, 1469,  143,
			  887,  822,  892,  883,  907,  912,  266,    0,    0,  863,
			  879,    0,    0,  864,  902,  894,    0,  892,  909,  911,
			  914,  902,  911,    0,  908,  913,  923,  921,    0,  922,
			  929,  924,    0,  930,  978, 1469,  136,  918,  913,  932,
			  940,  941,  938,  956,  950,    0,  951,  971,    0,  965,
			  970,    0,  962,  130, 1002, 1004, 1003, 1469,  998, 1006,
			 1021, 1003, 1032, 1041,    0,  962,  965,    0,  972,  985,
			 1011,    0,    0, 1016,    0, 1026, 1023,    0, 1016, 1022,
			 1018, 1019, 1039, 1024, 1469,  140, 1026,    0, 1033, 1035,

			    0, 1045,    0,    0,    0, 1031, 1038,    0, 1035, 1080,
			 1079, 1084, 1071, 1082, 1099, 1108, 1117, 1121, 1127, 1131,
			 1141, 1045,    0, 1079,    0, 1111, 1112, 1116,    0,    0,
			 1124,    0,    0, 1121, 1132, 1165, 1126, 1138, 1141,    0,
			 1140, 1141,    0, 1172, 1125, 1173, 1150, 1173, 1179, 1191,
			 1197, 1200, 1210, 1215, 1218, 1157,    0,    0,    0,    0,
			    0, 1160,    0, 1469, 1167,    0, 1190,    0,    0, 1177,
			 1469, 1469, 1192, 1222, 1228,    0,    0,    0,    0, 1469,
			 1469, 1266, 1279, 1292, 1305, 1318, 1329, 1342, 1351, 1364,
			 1377, 1390, 1403, 1416, 1429, 1442, 1248, 1455>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  580,    1,  581,  581,  582,  582,  583,  583,  584,
			  584,  580,  580,  580,  580,  580,  585,  586,  580,  587,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  580,  580,  580,  580,
			  580,  580,  580,  589,  580,  580,  580,  590,  590,  580,
			  580,  591,  592,  580,  580,  580,  580,  580,  580,  585,
			  580,  593,  585,  585,  585,  585,  585,  585,  585,  585,
			  585,  585,  585,  585,  585,  585,  586,  594,  594,  594,

			  595,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  596,  580,  580,  580,  580,  580,  580,  580,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  580,  580,  589,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  590,  580,  580,
			  590,  591,  580,  592,  580,  580,  580,  580,  580,  593,

			  580,  580,  580,  580,  585,  580,  585,  580,  585,  585,
			  585,  585,  585,  585,  585,  580,  585,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  596,  580,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,

			  588,  588,  588,  588,  588,  588,  580,  580,  580,  580,
			  580,  585,  585,  585,  585,  580,  585,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,

			  588,  580,  580,  585,  580,  585,  580,  585,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  580,  580,  580,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  580,  585,  585,  585,  580,  580,  580,
			  580,  580,  580,  580,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  580,  597,  588,  588,  588,  588,

			  588,  588,  588,  588,  588,  588,  588,  588,  588,  585,
			  585,  585,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  588,  588,  588,  588,  588,  588,  588,  588,  588,
			  588,  588,  588,  588,  588,  580,  588,  588,  588,  588,
			  588,  588,  588,  585,  585,  585,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  588,  588,  588,  588,  588,
			  588,  588,  588,  580,  588,  588,  588,  588,  588,  585,
			  580,  580,  580,  580,  580,  588,  588,  588,  588,  580,
			    0,  580,  580,  580,  580,  580,  580,  580,  580,  580,
			  580,  580,  580,  580,  580,  580,  580,  580>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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
			    1,    1,    1,    1,    1,    1,    1>>)
		end

	yy_meta_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    1,    3,    3,    4,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    5,    6,    7,    3,    3,    3,    3,    3,    3,    3,
			    5,    5,    5,    5,    5,    5,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    9,   10,    3,    3,    3,    3,
			   11,    3,    5,    5,    5,    5,    5,    5,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,   12,   13,    3,    3,
			    3,    3>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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
			  190,  191,  192,  193,  194,  195,  196,  197,  198,  199,
			  200,  201,  202,  203,  205,  206,  207,  208,  209,  210,

			  211,  212,  213,  214,  215,  216,  217,  218,  220,  222,
			  223,  223,  223,  224,  225,  226,  227,  228,  229,  230,
			  231,  232,  233,  235,  236,  237,  238,  239,  240,  241,
			  242,  243,  245,  246,  247,  248,  249,  250,  251,  253,
			  254,  255,  257,  258,  259,  260,  261,  262,  263,  265,
			  266,  267,  268,  269,  270,  271,  272,  273,  274,  275,
			  276,  277,  278,  279,  280,  280,  281,  282,  283,  284,
			  285,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  306,  308,  309,  310,  310,  311,  312,  314,

			  316,  318,  320,  322,  324,  325,  327,  328,  330,  331,
			  332,  333,  334,  335,  336,  337,  338,  339,  341,  342,
			  344,  345,  346,  347,  348,  349,  350,  351,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  365,  366,  368,  369,  369,  370,  371,  371,  373,
			  375,  376,  376,  377,  378,  380,  382,  383,  384,  386,
			  387,  388,  389,  390,  391,  392,  393,  394,  396,  397,
			  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,
			  408,  409,  410,  411,  413,  414,  416,  417,  418,  419,
			  420,  421,  422,  423,  424,  425,  426,  427,  428,  429,

			  430,  431,  432,  433,  434,  435,  437,  438,  438,  440,
			  442,  444,  445,  446,  447,  448,  450,  451,  453,  454,
			  455,  456,  457,  458,  459,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  474,
			  475,  476,  476,  477,  478,  478,  478,  479,  480,  481,
			  481,  482,  483,  484,  485,  486,  487,  488,  489,  490,
			  491,  492,  494,  495,  496,  497,  498,  499,  500,  502,
			  503,  504,  505,  506,  507,  508,  509,  511,  512,  514,
			  515,  517,  518,  519,  520,  521,  522,  523,  524,  525,
			  526,  527,  528,  529,  531,  533,  534,  535,  536,  537,

			  539,  541,  542,  542,  543,  545,  546,  548,  549,  551,
			  552,  553,  553,  554,  554,  555,  556,  557,  559,  561,
			  562,  563,  565,  567,  568,  569,  570,  572,  573,  574,
			  575,  576,  577,  578,  580,  581,  582,  583,  584,  586,
			  587,  588,  589,  591,  592,  592,  593,  593,  594,  595,
			  596,  597,  598,  599,  600,  601,  603,  604,  605,  607,
			  608,  609,  611,  612,  612,  613,  614,  615,  616,  616,
			  617,  618,  618,  618,  619,  621,  622,  623,  625,  626,
			  627,  628,  630,  632,  633,  635,  636,  637,  639,  640,
			  641,  642,  643,  644,  645,  647,  647,  648,  650,  651,

			  652,  654,  655,  657,  659,  661,  662,  663,  665,  666,
			  667,  668,  669,  669,  670,  671,  671,  671,  672,  672,
			  673,  673,  674,  676,  677,  679,  680,  681,  682,  684,
			  686,  687,  689,  691,  692,  693,  693,  694,  695,  696,
			  698,  699,  700,  702,  703,  704,  705,  706,  706,  707,
			  707,  708,  709,  709,  709,  710,  711,  713,  715,  717,
			  719,  721,  722,  724,  725,  726,  728,  729,  731,  733,
			  734,  736,  738,  739,  739,  740,  742,  744,  746,  748,
			  750,  750>>)
		end

	yy_acclist_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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
			  162,  160,  158,  160,  170, -360,  146,  160,  144,  160,
			  145,  160,  147,  160,  170,  140,  160,  170,  141,  160,
			  170,  170,  170,  170,  170,  170,  170, -161,  170,  148,
			  160,  138,  114,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  115,  138,  113,  110,
			  113,  109,  111,  109,  111,  112,  107,  107,   41,  107,
			   42,  107,  107,  107,   46,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,   58,  107,  107,  107,  107,  107,

			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,   78,  107,  107,   80,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  106,  107,  194,  149,  160,
			  142,  160,  143,  160,  170,  170,  170,  170,  155,  160,
			  170,  150,  160,  132,  130,  131,  133,  134,  139,  135,
			  136,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  113,  113,  113,  113,  109,
			  109,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,   56,  107,  107,  107,  107,  107,  107,  107,

			   65,  107,  107,  107,  107,  107,  107,  107,  107,   75,
			  107,  107,   77,  107,  107,   84,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,   98,
			  107,   99,  107,  107,  107,  107,  107,  104,  107,  105,
			  107,  193,  170,  151,  160,  170,  154,  160,  170,  157,
			  160,  139,  113,  113,  113,  113,  111,   39,  107,   40,
			  107,  107,  107,   47,  107,   48,  107,  107,  107,  107,
			   53,  107,  107,  107,  107,  107,  107,  107,   63,  107,
			  107,  107,  107,  107,   70,  107,  107,  107,  107,   76,
			  107,  107,   81,  107,  107,  107,  107,  107,  107,  107,

			  107,   94,  107,  107,  107,   97,  107,  107,  107,  102,
			  107,  107,  170,  170,  170,  137,  113,  113,  113,   44,
			  107,  107,  107,   50,  107,  107,  107,  107,   57,  107,
			   59,  107,  107,   61,  107,  107,  107,   66,  107,  107,
			  107,  107,  107,  107,  107,   82,   83,  107,   87,  107,
			  107,  107,   90,  107,  107,   92,  107,   93,  107,   95,
			  107,  107,  107,  101,  107,  107,  170,  170,  170,  113,
			  113,  113,  113,  107,   49,  107,  107,   52,  107,  107,
			  107,  107,   64,  107,   68,  107,  107,   71,  107,   72,
			  107,  107,  107,  107,  107,  107,   91,  107,  107,  107,

			  103,  107,  170,  170,  170,  113,  113,  113,  113,  113,
			  107,   51,  107,   54,  107,   60,  107,   62,  107,   69,
			  107,  107,   79,  107,   83,  107,   88,  107,  107,   96,
			  107,  100,  107,  170,  153,  160,  156,  160,  113,  113,
			   45,  107,   73,  107,   86,  107,   89,  107,  152,  160>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1469
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 580
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 581
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
