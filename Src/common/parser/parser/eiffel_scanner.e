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
--|#line 406 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 406")
end

				current_position.go_to (4)
				last_token := TE_ONCE
			
when 82 then
--|#line 410 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 410")
end

				current_position.go_to (2)
				last_token := TE_OR
			
when 83 then
--|#line 414 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 414")
end

				current_position.go_to (9)
				last_token := TE_PRECURSOR
			
when 84 then
--|#line 418 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 418")
end

				current_position.go_to (6)
				last_token := TE_PREFIX
			
when 85 then
--|#line 422 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 422")
end

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
when 86 then
--|#line 426 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 426")
end

				current_position.go_to (6)
				last_token := TE_RENAME
			
when 87 then
--|#line 430 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 430")
end

				current_position.go_to (7)
				last_token := TE_REQUIRE
			
when 88 then
--|#line 434 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 434")
end

				current_position.go_to (6)
				last_token := TE_RESCUE
			
when 89 then
--|#line 438 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 438")
end

				current_position.go_to (6)
				last_token := TE_RESULT
			
when 90 then
--|#line 442 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 442")
end

				current_position.go_to (5)
				last_token := TE_RETRY
			
when 91 then
--|#line 446 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 446")
end

				current_position.go_to (6)
				last_token := TE_SELECT
			
when 92 then
--|#line 450 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 450")
end

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
when 93 then
--|#line 454 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 454")
end

				current_position.go_to (5)
				last_token := TE_STRIP
			
when 94 then
--|#line 458 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 458")
end

				current_position.go_to (4)
				last_token := TE_THEN
			
when 95 then
--|#line 462 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 462")
end

				current_position.go_to (4)
				last_token := TE_TRUE
			
when 96 then
--|#line 466 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 466")
end

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
when 97 then
--|#line 470 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 470")
end

				current_position.go_to (6)
				last_token := TE_UNIQUE
			
when 98 then
--|#line 474 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 474")
end

				current_position.go_to (5)
				last_token := TE_UNTIL
			
when 99 then
--|#line 478 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 478")
end

				current_position.go_to (7)
				last_token := TE_VARIANT
			
when 100 then
--|#line 482 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 482")
end

				current_position.go_to (4)
				last_token := TE_WHEN
			
when 101 then
--|#line 486 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 486")
end

				current_position.go_to (3)
				last_token := TE_XOR
			
when 102 then
--|#line 494 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 494")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 103 then
--|#line 508 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 508")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 104 then
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
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 105 then
	yy_end := yy_end - 2
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
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			
when 106 then
--|#line 532 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 532")
end

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 107 then
--|#line 539 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 539")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 108 then
--|#line 548 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 548")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 109 then
--|#line 561 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 561")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 110 then
--|#line 567 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 567")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 111 then
--|#line 574 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 574")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 112 then
--|#line 580 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 580")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 113 then
--|#line 586 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 586")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 114 then
--|#line 592 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 592")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 115 then
--|#line 598 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 598")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 116 then
--|#line 604 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 604")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 117 then
--|#line 610 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 610")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 118 then
--|#line 616 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 616")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 119 then
--|#line 622 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 622")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 628 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 628")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 634 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 634")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 640 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 640")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 646 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 646")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 652 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 652")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 658 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 658")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 664 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 664")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 670 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 670")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 676 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 676")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 682 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 682")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 688 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 688")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 694 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 694")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 700 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 700")
end

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 133, 134 then
--|#line 704 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 704")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 135 then
--|#line 715 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 715")
end

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 136 then
--|#line 719 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 719")
end

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 137 then
--|#line 723 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 723")
end

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 138 then
--|#line 727 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 727")
end

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 139 then
--|#line 731 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 731")
end

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 140 then
--|#line 735 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 735")
end

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 141 then
--|#line 739 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 739")
end

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 142 then
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
end

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 143 then
--|#line 747 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 747")
end

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 144 then
--|#line 751 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 751")
end

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 145 then
--|#line 755 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 755")
end

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 146 then
--|#line 759 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 759")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 147 then
--|#line 765 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 765")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 148 then
--|#line 771 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 771")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 149 then
--|#line 777 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 777")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 150 then
--|#line 783 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 783")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 151 then
--|#line 789 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 789")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 152 then
--|#line 795 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 795")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 153 then
--|#line 801 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 801")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
when 154 then
--|#line 807 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 807")
end

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 155 then
--|#line 812 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 812")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 156 then
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
end

					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			
when 157 then
--|#line 830 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 830")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			
when 158 then
--|#line 837 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 837")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 159 then
--|#line 853 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 853")
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
			
when 160 then
--|#line 883 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 883")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 161 then
--|#line 888 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 888")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
			
when 162 then
--|#line 895 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 895")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 163 then
--|#line 911 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 911")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR1)
			
when 164 then
--|#line 919 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 919")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 165 then
--|#line 932 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 932")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			
when 166 then
--|#line 942 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 942")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 167 then
--|#line 946 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 946")
end

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 168 then
--|#line 950 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 950")
end

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 169 then
--|#line 954 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 954")
end

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 170 then
--|#line 958 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 958")
end

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 171 then
--|#line 962 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 962")
end

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 172 then
--|#line 966 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 966")
end

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 173 then
--|#line 970 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 970")
end

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 174 then
--|#line 974 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 974")
end

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 175 then
--|#line 978 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 978")
end

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 176 then
--|#line 982 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 982")
end

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 177 then
--|#line 986 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 986")
end

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 178 then
--|#line 990 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 990")
end

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 179 then
--|#line 994 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 994")
end

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 180 then
--|#line 998 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 998")
end

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 181 then
--|#line 1002 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1002")
end

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 182 then
--|#line 1006 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1006")
end

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 183 then
--|#line 1010 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1010")
end

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 184 then
--|#line 1014 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1014")
end

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 185 then
--|#line 1018 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1018")
end

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 186 then
--|#line 1022 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1022")
end

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 187 then
--|#line 1026 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1026")
end

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 188 then
--|#line 1030 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1030")
end

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 189 then
--|#line 1034 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1034")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.reset_column_positions	
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 190 then
--|#line 1042 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1042")
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
			
when 191 then
--|#line 1055 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1055")
end

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 192 then
--|#line 1061 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1061")
end

					-- No final double-quote.
				line_number := line_number + 1
				current_position.reset_column_positions	
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 193 then
--|#line 1088 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1088")
end

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 194 then
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
			   61,   62,   64,   64,  187,   65,   65,  188,   66,   66,

			   68,   69,   68,  124,   70,   68,   69,   68,  144,   70,
			   75,   76,   75,   75,   76,   75,   77,   98,   77,   99,
			  100,  102,  104,  103,  103,  103,  113,  114,  149,  105,
			  101,  115,  116,  150,  106,  124,  107,  107,  108,   77,
			  144,   77,  106,  396,  107,  107,  108,  109,  106,  458,
			  108,  108,  108,  336,  335,  109,   71,  194,  195,  194,
			  149,   71,   80,   81,  187,  150,   81,  188,  334,  110,
			   82,   83,  333,   84,  151,   85,  111,  332,  155,  109,
			  331,   86,  330,   87,  111,   81,   88,  109,  329,  152,
			  111,  119,  130,  132,   89,  133,  120,  156,  121,   90,

			   91,  110,  131,  122,  123,  134,  151,  125,  328,   92,
			  155,  126,   93,   94,  127,   95,  187,  128,   88,  191,
			  129,  152,  186,  119,  130,  132,   89,  133,  120,  156,
			  121,   90,   91,  157,  131,  122,  123,  134,  135,  125,
			  138,   92,  136,  126,  142,   81,  127,  139,  140,  128,
			  143,  145,  129,  141,  153,  137,  158,  327,  189,  187,
			  189,  146,  188,  147,  154,  157,  196,  148,  199,  326,
			  135,  200,  138,  325,  136,  187,  142,  201,  191,  139,
			  140,  186,  143,  145,  202,  141,  153,  137,  158,  250,
			  250,  250,  204,  146,  464,  147,  154,  203,  324,  148,

			  163,  163,  163,  196,  164,  196,  206,  165,  323,  166,
			  167,  168,  205,  196,  190,  196,   93,  169,   93,   79,
			   79,   93,   79,  170,  197,  171,  207,   93,  172,  173,
			  174,  175,  196,  176,   93,  177,  111,  196,  322,  178,
			  208,  179,   93,  210,  180,  181,  182,  183,  184,  185,
			  216,  209,  251,   93,  211,   93,   93,  213,  214,  213,
			  321,  196,  319,   93,  318,   93,  254,  242,  242,  242,
			  212,  317,  208,  316,  198,  210,  244,  255,  245,  245,
			  245,  243,   93,  209,  251,  315,  211,   93,  215,  256,
			  257,  252,  246,  106,  253,  248,  248,  248,  254,  193,

			   93,  162,  212,  106,  241,  247,  247,  248,  258,  255,
			  259,   93,  219,  243,  260,  220,  109,  221,  222,  223,
			  218,  256,  257,  252,  246,  224,  253,  261,  262,  265,
			  263,  225,  270,  226,  264,  111,  227,  228,  229,  230,
			  258,  231,  259,  232,  271,  111,  260,  233,  109,  234,
			  266,  272,  235,  236,  237,  238,  239,  240,  273,  261,
			  262,  265,  263,  268,  270,  267,  264,  269,  279,  274,
			  282,  275,  283,  276,  280,  284,  271,  285,  286,  305,
			  294,  306,  266,  272,  277,  292,  281,  278,  295,  293,
			  273,  296,  300,  301,  302,  268,   78,  267,  287,  269,

			  279,  274,  282,  275,  283,  276,  280,  284,  288,  285,
			  286,  289,  294,  290,  291,  193,  277,  292,  281,  278,
			  295,  293,  297,  296,  300,  301,  302,  298,  307,   93,
			  287,   93,  163,  163,  163,  304,  304,  304,  299,  303,
			  288,  196,  196,  289,  196,  290,  291,  189,  187,  189,
			  311,  188,  312,  347,  297,  194,  195,  194,  196,  298,
			   79,  213,  214,  213,  314,  197,  348,  162,  308,  349,
			  299,  213,  214,  213,  350,  196,  160,  159,   93,  117,
			  112,  309,  320,  320,  320,  347,   78,  310,  346,  346,
			  346,   93,   93,  563,   93,  337,  337,  337,  348,  313,

			  308,  349,   93,  190,   73,  338,  350,  338,   93,  243,
			  339,  339,  339,  309,   93,  198,  340,  340,  340,  310,
			  351,  342,  352,  342,  353,   93,  343,  343,  343,  354,
			  341,  313,  106,  355,  344,  344,  345,  356,  357,  358,
			  106,  243,  345,  345,  345,  109,  359,  362,  363,  360,
			   73,  364,  351,  365,  352,  367,  353,  368,  369,  370,
			  371,  354,  341,  361,  372,  355,  366,  373,  374,  356,
			  357,  358,  375,  376,  111,  377,  380,  109,  359,  362,
			  363,  360,  111,  364,  381,  365,  382,  367,  383,  368,
			  369,  370,  371,  385,  378,  361,  372,  379,  366,  373,

			  374,  386,  387,  388,  375,  376,  384,  377,  380,  389,
			  390,  391,  392,  393,  394,  395,  381,  398,  382,  399,
			  383,  396,  397,  397,  397,  385,  378,  196,  401,  379,
			  196,  403,  563,  386,  387,  388,  412,  563,  384,  563,
			  563,  389,  390,  391,  392,  393,  394,  395,  404,  320,
			  320,  320,  405,  405,  405,  339,  339,  339,  402,  339,
			  339,  339,  400,  343,  343,  343,  243,  413,  412,   93,
			  407,  407,  407,  343,  343,  343,  563,   93,   93,  414,
			   93,   93,  415,  410,  341,  344,  344,  345,  416,  417,
			  402,  418,  406,  419,  400,  408,  109,  408,  243,  413,

			  409,  409,  409,  410,  420,  345,  345,  345,  411,  411,
			  411,  414,  421,  422,  415,  423,  341,  424,  425,  426,
			  416,  417,  427,  418,  428,  419,  429,  430,  109,  431,
			  432,  433,  434,  435,  436,  437,  420,  438,  439,  440,
			  441,  442,  443,  444,  421,  422,  445,  423,  446,  424,
			  425,  426,  447,  448,  427,  449,  428,  450,  429,  430,
			  451,  431,  432,  433,  434,  435,  436,  437,  452,  438,
			  439,  440,  441,  442,  443,  444,  453,  196,  445,  196,
			  446,  196,  563,  563,  447,  448,  563,  449,  563,  450,
			  563,  563,  451,  396,  454,  454,  454,  460,  460,  460,

			  452,  405,  405,  405,  461,  461,  461,  465,  453,  466,
			  467,  456,  409,  409,  409,  459,  457,  470,  341,  471,
			  455,  409,  409,  409,  468,  472,  473,   93,  469,   93,
			  244,   93,  461,  461,  461,  474,  475,  476,  477,  465,
			  478,  466,  467,  456,  462,  479,  463,  459,  457,  470,
			  341,  471,  455,  480,  481,  482,  468,  472,  473,  483,
			  469,  484,  485,  486,  487,  488,  489,  474,  475,  476,
			  477,  490,  478,  491,  492,  493,  494,  479,  463,  495,
			  496,  196,  196,  196,  563,  480,  481,  482,  502,  502,
			  502,  483,  563,  484,  485,  486,  487,  488,  489,  505,

			  505,  505,  503,  490,  563,  491,  492,  493,  494,  498,
			  563,  495,  496,  497,  500,  509,  500,  510,  511,  501,
			  501,  501,  461,  461,  461,  499,  505,  505,  505,  512,
			  513,   93,   93,   93,  503,  514,  504,  506,  515,  506,
			  508,  498,  507,  507,  507,  497,  516,  509,  517,  510,
			  511,  518,  519,  520,  521,  522,  523,  499,  524,  525,
			  526,  512,  513,  527,  528,  196,  196,  514,  504,  196,
			  515,  563,  508,  501,  501,  501,  563,  563,  516,  541,
			  517,  563,  563,  518,  519,  520,  521,  522,  523,  563,
			  524,  525,  526,  529,  563,  527,  528,  531,  501,  501,

			  501,  563,  563,  532,  532,  532,  563,  533,  530,  533,
			  542,  541,  534,  534,  534,   93,   93,  503,  543,   93,
			  544,  535,  545,  535,  546,  529,  536,  536,  536,  531,
			  537,  537,  537,  507,  507,  507,  507,  507,  507,  547,
			  530,  539,  542,  539,  538,  548,  540,  540,  540,  503,
			  543,  549,  544,  550,  545,  551,  546,  552,  196,  554,
			  555,  559,  503,  534,  534,  534,  534,  534,  534,  562,
			  563,  547,  536,  536,  536,  563,  538,  548,  536,  536,
			  536,  563,  560,  549,  561,  550,  563,  551,  406,  552,
			  556,  556,  556,  559,  503,  553,  557,  538,  557,  563,

			  563,  558,  558,  558,  538,  540,  540,  540,   93,   93,
			   93,  540,  540,  540,  560,  563,  561,  563,  563,   93,
			  558,  558,  558,  462,  558,  558,  558,  553,  563,  538,
			  249,  249,  249,  563,  563,  563,  538,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   79,
			  563,   79,  563,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   96,  563,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   97,  563,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  161,  563,  161,  563,  161,
			  161,  161,  161,  161,  161,  161,  161,  161,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  190,  190,  190,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,   81,  563,   81,
			  563,   81,   81,   81,   81,   81,   81,   81,   81,   81,

			  217,  563,  217,  217,  217,  217,  217,  217,  217,  217,
			  217,  217,  217,  100,  563,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,   11,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,

			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563>>)
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
			   46,   77,   29,  454,   29,   29,   29,   28,   30,  404,
			   30,   30,   30,  240,  239,   29,    5,   75,   75,   75,
			   48,    6,   16,   16,  186,   49,   16,  186,  238,   28,
			   16,   16,  237,   16,   50,   16,   28,  236,   52,   28,
			  235,   16,  234,   16,   29,   16,   16,   29,  233,   50,
			   30,   37,   40,   41,   16,   41,   37,   53,   37,   16,

			   16,   28,   40,   37,   37,   41,   50,   39,  232,   16,
			   52,   39,   16,   16,   39,   16,   71,   39,   16,   71,
			   39,   50,   71,   37,   40,   41,   16,   41,   37,   53,
			   37,   16,   16,   54,   40,   37,   37,   41,   42,   39,
			   44,   16,   42,   39,   45,   16,   39,   44,   44,   39,
			   45,   47,   39,   44,   51,   42,   55,  231,   68,   68,
			   68,   47,   68,   47,   51,   54,   79,   47,   82,  230,
			   42,   83,   44,  229,   42,  190,   45,   84,  190,   44,
			   44,  190,   45,   47,   85,   44,   51,   42,   55,  111,
			  111,  111,   86,   47,  411,   47,   51,   85,  228,   47,

			   66,   66,   66,   88,   66,   90,   87,   66,  227,   66,
			   66,   66,   86,   91,   68,   89,   79,   66,   82,   81,
			   81,   83,   81,   66,   81,   66,   87,   84,   66,   66,
			   66,   66,   92,   66,   85,   66,  411,   94,  226,   66,
			   88,   66,   86,   90,   66,   66,   66,   66,   66,   66,
			   95,   89,  119,   88,   91,   90,   87,   93,   93,   93,
			  225,   93,  223,   91,  222,   89,  121,  103,  103,  103,
			   92,  221,   88,  220,   81,   90,  106,  122,  106,  106,
			  106,  103,   92,   89,  119,  219,   91,   94,   94,  123,
			  124,  120,  106,  108,  120,  108,  108,  108,  121,  192,

			   95,  161,   92,  107,   99,  107,  107,  107,  125,  122,
			  126,   93,   98,  103,  127,   98,  107,   98,   98,   98,
			   97,  123,  124,  120,  106,   98,  120,  128,  129,  132,
			  130,   98,  135,   98,  130,  108,   98,   98,   98,   98,
			  125,   98,  126,   98,  136,  107,  127,   98,  107,   98,
			  133,  137,   98,   98,   98,   98,   98,   98,  139,  128,
			  129,  132,  130,  134,  135,  133,  130,  134,  142,  140,
			  144,  140,  145,  140,  143,  146,  136,  147,  149,  203,
			  152,  205,  133,  137,  140,  151,  143,  140,  153,  151,
			  139,  154,  156,  157,  158,  134,   78,  133,  150,  134,

			  142,  140,  144,  140,  145,  140,  143,  146,  150,  147,
			  149,  150,  152,  150,  150,   72,  140,  151,  143,  140,
			  153,  151,  155,  154,  156,  157,  158,  155,  207,  203,
			  150,  205,  163,  163,  163,  169,  169,  169,  155,  163,
			  150,  208,  209,  150,  210,  150,  150,  189,  189,  189,
			  211,  189,  211,  251,  155,  194,  194,  194,  212,  155,
			  198,  198,  198,  198,  215,  198,  252,   63,  208,  255,
			  155,  213,  213,  213,  256,  213,   61,   57,  207,   36,
			   31,  209,  224,  224,  224,  251,   14,  210,  250,  250,
			  250,  208,  209,   11,  210,  242,  242,  242,  252,  212,

			  208,  255,  211,  189,    8,  243,  256,  243,  212,  242,
			  243,  243,  243,  209,  215,  198,  245,  245,  245,  210,
			  258,  246,  259,  246,  260,  213,  246,  246,  246,  261,
			  245,  212,  247,  262,  247,  247,  247,  263,  264,  265,
			  248,  242,  248,  248,  248,  247,  267,  269,  270,  268,
			    7,  271,  258,  272,  259,  273,  260,  274,  275,  276,
			  277,  261,  245,  268,  278,  262,  272,  279,  280,  263,
			  264,  265,  281,  283,  247,  285,  287,  247,  267,  269,
			  270,  268,  248,  271,  288,  272,  289,  273,  290,  274,
			  275,  276,  277,  291,  286,  268,  278,  286,  272,  279,

			  280,  292,  293,  294,  281,  283,  290,  285,  287,  295,
			  296,  297,  298,  299,  300,  301,  288,  308,  289,  308,
			  290,  304,  304,  304,  304,  291,  286,  309,  310,  286,
			  311,  313,    0,  292,  293,  294,  347,    0,  290,    0,
			    0,  295,  296,  297,  298,  299,  300,  301,  320,  320,
			  320,  320,  337,  337,  337,  338,  338,  338,  311,  339,
			  339,  339,  309,  342,  342,  342,  337,  348,  347,  308,
			  340,  340,  340,  343,  343,  343,    0,  309,  310,  349,
			  311,  313,  350,  344,  340,  344,  344,  344,  351,  352,
			  311,  353,  337,  354,  309,  341,  344,  341,  337,  348,

			  341,  341,  341,  345,  355,  345,  345,  345,  346,  346,
			  346,  349,  356,  357,  350,  358,  340,  359,  360,  361,
			  351,  352,  362,  353,  363,  354,  364,  366,  344,  367,
			  368,  369,  370,  371,  372,  374,  355,  376,  378,  379,
			  380,  381,  382,  383,  356,  357,  384,  358,  385,  359,
			  360,  361,  386,  387,  362,  388,  363,  391,  364,  366,
			  392,  367,  368,  369,  370,  371,  372,  374,  393,  376,
			  378,  379,  380,  381,  382,  383,  394,  398,  384,  400,
			  385,  402,    0,    0,  386,  387,    0,  388,    0,  391,
			    0,    0,  392,  397,  397,  397,  397,  406,  406,  406,

			  393,  405,  405,  405,  407,  407,  407,  414,  394,  415,
			  418,  400,  408,  408,  408,  405,  402,  420,  407,  422,
			  398,  409,  409,  409,  419,  423,  424,  398,  419,  400,
			  410,  402,  410,  410,  410,  425,  426,  427,  429,  414,
			  430,  415,  418,  400,  407,  431,  410,  405,  402,  420,
			  407,  422,  398,  432,  434,  435,  419,  423,  424,  436,
			  419,  438,  439,  440,  441,  442,  443,  425,  426,  427,
			  429,  444,  430,  445,  447,  448,  450,  431,  410,  451,
			  453,  456,  455,  457,    0,  432,  434,  435,  460,  460,
			  460,  436,    0,  438,  439,  440,  441,  442,  443,  462,

			  462,  462,  460,  444,    0,  445,  447,  448,  450,  456,
			    0,  451,  453,  455,  459,  466,  459,  467,  469,  459,
			  459,  459,  461,  461,  461,  457,  464,  464,  464,  470,
			  471,  456,  455,  457,  460,  474,  461,  463,  476,  463,
			  464,  456,  463,  463,  463,  455,  477,  466,  479,  467,
			  469,  480,  481,  482,  483,  484,  485,  457,  487,  489,
			  493,  470,  471,  494,  496,  497,  498,  474,  461,  499,
			  476,    0,  464,  500,  500,  500,    0,    0,  477,  509,
			  479,    0,    0,  480,  481,  482,  483,  484,  485,    0,
			  487,  489,  493,  497,    0,  494,  496,  499,  501,  501,

			  501,    0,    0,  502,  502,  502,    0,  503,  498,  503,
			  511,  509,  503,  503,  503,  497,  498,  502,  513,  499,
			  514,  504,  515,  504,  518,  497,  504,  504,  504,  499,
			  505,  505,  505,  506,  506,  506,  507,  507,  507,  521,
			  498,  508,  511,  508,  505,  522,  508,  508,  508,  502,
			  513,  523,  514,  524,  515,  526,  518,  527,  529,  530,
			  531,  541,  532,  533,  533,  533,  534,  534,  534,  553,
			    0,  521,  535,  535,  535,    0,  505,  522,  536,  536,
			  536,    0,  547,  523,  549,  524,    0,  526,  532,  527,
			  537,  537,  537,  541,  532,  529,  538,  556,  538,    0,

			    0,  538,  538,  538,  537,  539,  539,  539,  529,  530,
			  531,  540,  540,  540,  547,    0,  549,    0,    0,  553,
			  557,  557,  557,  556,  558,  558,  558,  529,    0,  556,
			  579,  579,  579,    0,    0,    0,  537,  564,  564,  564,
			  564,  564,  564,  564,  564,  564,  564,  564,  564,  564,
			  565,  565,  565,  565,  565,  565,  565,  565,  565,  565,
			  565,  565,  565,  566,  566,  566,  566,  566,  566,  566,
			  566,  566,  566,  566,  566,  566,  567,  567,  567,  567,
			  567,  567,  567,  567,  567,  567,  567,  567,  567,  568,
			    0,  568,    0,  568,  568,  568,  568,  568,  568,  568,

			  568,  568,  569,    0,  569,  569,  569,  569,  569,  569,
			  569,  569,  569,  570,    0,  570,  570,  570,  570,  570,
			  570,  570,  570,  570,  570,  570,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  572,    0,  572,    0,  572,
			  572,  572,  572,  572,  572,  572,  572,  572,  573,  573,
			  573,  573,  573,  573,  573,  573,  573,  573,  573,  573,
			  573,  574,  574,  574,  574,  574,  574,  574,  574,  574,
			  574,  574,  574,  574,  575,  575,  575,  575,  575,  575,
			  575,  575,  575,  575,  575,  575,  575,  576,    0,  576,
			    0,  576,  576,  576,  576,  576,  576,  576,  576,  576,

			  577,    0,  577,  577,  577,  577,  577,  577,  577,  577,
			  577,  577,  577,  578,    0,  578,  578,  578,  578,  578,
			  578,  578,  578,  578,  578,  578,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,

			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  647,  601,  108,
			  111,  593, 1426,  114,  583, 1426,  156,    0, 1426,  108,
			 1426, 1426, 1426, 1426, 1426,  103,  103,  103,  116,  124,
			  130,  554, 1426,  101, 1426,  105,  553,  155,   65,  170,
			  158,  152,  208,    0,  205,  206,   64,  220,   81,   99,
			  140,  217,  135,  167,  196,  212, 1426,  520, 1426, 1426,
			 1426,  485, 1426,  561, 1426, 1426,  298,   91,  256, 1426,
			 1426,  213,  512, 1426, 1426,  155, 1426,  137,  493,  260,
			 1426,  318,  262,  265,  271,  278,  286,  300,  297,  309,
			  299,  307,  326,  355,  331,  344,    0,  409,  406,  393,

			    0, 1426, 1426,  347, 1426, 1426,  358,  385,  375, 1426,
			    0,  269, 1426, 1426, 1426, 1426, 1426, 1426,    0,  318,
			  353,  333,  329,  340,  341,  374,  380,  371,  393,  381,
			  399,    0,  381,  417,  418,  391,  414,  407,    0,  413,
			  436,    0,  428,  442,  421,  424,  442,  445,    0,  444,
			  465,  444,  433,  454,  441,  489,  445,  459,  447, 1426,
			 1426,  395, 1426,  530, 1426, 1426, 1426, 1426, 1426,  515,
			 1426, 1426, 1426, 1426, 1426, 1426, 1426, 1426, 1426, 1426,
			 1426, 1426, 1426, 1426, 1426, 1426,  161, 1426, 1426,  545,
			  272, 1426,  396, 1426,  553, 1426, 1426, 1426,  559, 1426,

			 1426, 1426, 1426,  473, 1426,  475, 1426,  522,  535,  536,
			  538,  546,  552,  569, 1426,  558, 1426, 1426, 1426,  374,
			  362,  360,  353,  351,  562,  349,  327,  297,  287,  262,
			  258,  246,  197,  177,  171,  169,  166,  161,  157,  143,
			  142, 1426,  575,  590, 1426,  596,  606,  614,  622,    0,
			  568,  510,  536,    0,    0,  531,  527,    0,  588,  574,
			  573,  599,  586,  587,  604,  605,    0,  596,  619,  613,
			  600,  602,  611,  614,  623,  620,  625,  615,  634,  633,
			  638,  627,    0,  629,    0,  641,  662,  642,  654,  636,
			  656,  646,  667,  672,  665,  666,  676,  677,  666,  675,

			  676,  672,    0, 1426,  702, 1426, 1426, 1426,  713,  721,
			  722,  724, 1426,  725, 1426, 1426, 1426, 1426, 1426, 1426,
			  729, 1426, 1426, 1426, 1426, 1426, 1426, 1426, 1426, 1426,
			 1426, 1426, 1426, 1426, 1426, 1426, 1426,  732,  735,  739,
			  750,  780,  743,  753,  765,  785,  788,  687,  719,  743,
			  744,  748,  741,  757,  744,  770,  776,  766,  777,  770,
			  775,  772,  775,  790,  776,    0,  793,  791,  777,  778,
			  785,  799,  787,    0,  794,    0,  796,    0,  788,  801,
			  805,  799,  804,  793,  805,  794,  820,  806,  810,    0,
			    0,  822,  810,  827,  846,    0, 1426,  874,  871, 1426,

			  873, 1426,  875, 1426,  138,  881,  877,  884,  892,  901,
			  912,  276,    0,    0,  864,  878,    0,    0,  863,  890,
			  874,    0,  872,  890,  892,  902,  887,  894,    0,  891,
			  897,  911,  915,    0,  916,  923,  921,    0,  927,  915,
			  910,  926,  931,  919,  937,  924,    0,  925,  945,    0,
			  938,  945,    0,  937,  124,  976,  975,  977, 1426,  999,
			  968, 1002,  979, 1022, 1006,    0,  965,  968,    0,  974,
			  980,  996,    0,    0, 1001,    0, 1008, 1012,    0, 1000,
			 1008, 1003, 1004, 1024, 1006, 1008,    0, 1015,    0, 1025,
			    0,    0,    0, 1011, 1020,    0, 1015, 1059, 1060, 1063,

			 1053, 1078, 1083, 1092, 1106, 1110, 1113, 1116, 1126, 1030,
			    0, 1067,    0, 1085, 1087, 1081,    0,    0, 1088,    0,
			    0, 1096, 1111, 1107, 1119,    0, 1121, 1123,    0, 1152,
			 1153, 1154, 1128, 1143, 1146, 1152, 1158, 1170, 1181, 1185,
			 1191, 1127,    0,    0,    0,    0,    0, 1133,    0, 1137,
			    0,    0,    0, 1163, 1426, 1426, 1163, 1200, 1204,    0,
			    0,    0, 1426, 1426, 1236, 1249, 1262, 1275, 1288, 1299,
			 1312, 1321, 1334, 1347, 1360, 1373, 1386, 1399, 1412, 1225>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  563,    1,  564,  564,  565,  565,  566,  566,  567,
			  567,  563,  563,  563,  563,  563,  568,  569,  563,  570,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  563,  563,  563,  563,
			  563,  563,  563,  572,  563,  563,  563,  573,  573,  563,
			  563,  574,  575,  563,  563,  563,  563,  563,  563,  568,
			  563,  576,  568,  568,  568,  568,  568,  568,  568,  568,
			  568,  568,  568,  568,  568,  568,  569,  577,  577,  577,

			  578,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  579,  563,  563,  563,  563,  563,  563,  563,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  563,
			  563,  572,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  573,  563,  563,  573,
			  574,  563,  575,  563,  563,  563,  563,  563,  576,  563,

			  563,  563,  563,  568,  563,  568,  563,  568,  568,  568,
			  568,  568,  568,  568,  563,  568,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  579,
			  563,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,

			  571,  571,  571,  563,  563,  563,  563,  563,  568,  568,
			  568,  568,  563,  568,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  563,  563,  568,  563,

			  568,  563,  568,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  563,  568,  568,  568,  563,  563,
			  563,  563,  563,  563,  563,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  568,  568,  568,

			  563,  563,  563,  563,  563,  563,  563,  563,  563,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  571,  571,  571,  571,  571,  571,  568,
			  568,  568,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  571,  571,  571,  571,  571,  571,  571,  571,  571,
			  571,  571,  571,  568,  563,  563,  563,  563,  563,  571,
			  571,  571,  563,    0,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563>>)
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
			  276,  277,  278,  279,  279,  280,  281,  282,  283,  284,
			  284,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  307,  308,  309,  309,  310,  311,  313,  315,

			  317,  319,  321,  323,  324,  326,  327,  329,  330,  331,
			  332,  333,  334,  335,  336,  337,  338,  340,  341,  343,
			  344,  345,  346,  347,  348,  349,  350,  351,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  365,  367,  368,  368,  369,  370,  370,  372,  374,
			  375,  375,  376,  377,  379,  381,  382,  383,  385,  386,
			  387,  388,  389,  390,  391,  392,  393,  395,  396,  397,
			  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,
			  408,  409,  410,  412,  413,  415,  416,  417,  418,  419,
			  420,  421,  422,  423,  424,  425,  426,  427,  428,  429,

			  430,  431,  432,  434,  435,  435,  437,  439,  441,  442,
			  443,  444,  445,  447,  448,  450,  451,  452,  453,  454,
			  455,  456,  457,  458,  459,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  473,
			  474,  475,  475,  475,  476,  477,  478,  478,  479,  480,
			  481,  482,  483,  484,  485,  486,  487,  488,  489,  491,
			  492,  493,  494,  495,  496,  497,  499,  500,  501,  502,
			  503,  504,  505,  506,  508,  509,  511,  512,  514,  515,
			  516,  517,  518,  519,  520,  521,  522,  523,  524,  525,
			  527,  529,  530,  531,  532,  533,  535,  536,  536,  537,

			  539,  540,  542,  543,  545,  546,  547,  547,  548,  548,
			  549,  550,  551,  553,  555,  556,  557,  559,  561,  562,
			  563,  564,  566,  567,  568,  569,  570,  571,  572,  574,
			  575,  576,  577,  578,  580,  581,  582,  583,  585,  586,
			  587,  588,  589,  590,  591,  592,  593,  595,  596,  597,
			  599,  600,  601,  603,  604,  604,  605,  606,  607,  608,
			  608,  609,  610,  610,  610,  611,  613,  614,  615,  617,
			  618,  619,  620,  622,  624,  625,  627,  628,  629,  631,
			  632,  633,  634,  635,  636,  637,  638,  640,  641,  643,
			  644,  646,  648,  650,  651,  652,  654,  655,  656,  657,

			  658,  658,  659,  660,  660,  660,  661,  661,  662,  662,
			  663,  665,  666,  668,  669,  670,  671,  673,  675,  676,
			  678,  680,  681,  682,  683,  684,  686,  687,  688,  690,
			  691,  692,  693,  694,  694,  695,  695,  696,  697,  697,
			  697,  698,  699,  701,  703,  705,  707,  709,  710,  712,
			  713,  715,  717,  719,  720,  722,  724,  725,  725,  726,
			  728,  730,  732,  734,  734>>)
		end

	yy_acclist_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  162,  162,  164,  164,  195,  193,  194,    2,  193,
			  194,    3,  194,   33,  193,  194,  165,  193,  194,   38,
			  193,  194,   12,  193,  194,  133,  193,  194,   21,  193,
			  194,   22,  193,  194,   29,  193,  194,   27,  193,  194,
			    6,  193,  194,   28,  193,  194,   11,  193,  194,   30,
			  193,  194,  104,  106,  193,  194,  104,  106,  193,  194,
			  104,  106,  193,  194,    5,  193,  194,    4,  193,  194,
			   16,  193,  194,   15,  193,  194,   17,  193,  194,    8,
			  193,  194,  102,  193,  194,  102,  193,  194,  102,  193,
			  194,  102,  193,  194,  102,  193,  194,  102,  193,  194,

			  102,  193,  194,  102,  193,  194,  102,  193,  194,  102,
			  193,  194,  102,  193,  194,  102,  193,  194,  102,  193,
			  194,  102,  193,  194,  102,  193,  194,  102,  193,  194,
			  102,  193,  194,  102,  193,  194,  102,  193,  194,   25,
			  193,  194,  193,  194,   26,  193,  194,   31,  193,  194,
			   23,  193,  194,   24,  193,  194,    9,  193,  194,  166,
			  194,  192,  194,  190,  194,  191,  194,  162,  194,  162,
			  194,  161,  194,  160,  194,  162,  194,  164,  194,  163,
			  194,  158,  194,  158,  194,  157,  194,    2,    3,  165,
			  154,  165,  165,  165,  165,  165,  165,  165,  165,  165,

			  165,  165,  165,  165, -350,  165,  165,   38,  133,  133,
			  133,    1,   32,    7,  108,   36,   20,  108,  104,  106,
			  104,  106,  103,   13,   34,   18,   19,   35,   14,  102,
			  102,  102,  102,   43,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,   55,  102,  102,  102,  102,  102,  102,
			  102,   67,  102,  102,  102,   74,  102,  102,  102,  102,
			  102,  102,  102,   82,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,   37,   10,  166,  190,  183,
			  181,  182,  184,  185,  186,  187,  167,  168,  169,  170,
			  171,  172,  173,  174,  175,  176,  177,  178,  179,  180,

			  162,  161,  160,  162,  162,  159,  160,  164,  163,  157,
			  155,  153,  155,  165, -350,  141,  155,  139,  155,  140,
			  155,  142,  155,  165,  135,  155,  165,  136,  155,  165,
			  165,  165,  165,  165,  165,  165, -156,  165,  143,  155,
			  133,  109,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  110,  133,  108,  105,  108,
			  104,  106,  104,  106,  107,  102,  102,   41,  102,   42,
			  102,  102,  102,   46,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,   58,  102,  102,  102,  102,  102,  102,

			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			   78,  102,  102,   80,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  101,  102,  189,  144,  155,  137,  155,  138,
			  155,  165,  165,  165,  165,  150,  155,  165,  145,  155,
			  127,  125,  126,  128,  129,  134,  130,  131,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  108,  108,  108,  108,  104,  104,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,   56,
			  102,  102,  102,  102,  102,  102,  102,   65,  102,  102,

			  102,  102,  102,  102,  102,  102,   75,  102,  102,   77,
			  102,  102,   81,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,   94,  102,   95,  102,  102,
			  102,  102,  102,  100,  102,  188,  165,  146,  155,  165,
			  149,  155,  165,  152,  155,  134,  108,  108,  108,  108,
			  106,   39,  102,   40,  102,  102,  102,   47,  102,   48,
			  102,  102,  102,  102,   53,  102,  102,  102,  102,  102,
			  102,  102,   63,  102,  102,  102,  102,  102,   70,  102,
			  102,  102,  102,   76,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,   90,  102,  102,  102,   93,  102,  102,

			  102,   98,  102,  102,  165,  165,  165,  132,  108,  108,
			  108,   44,  102,  102,  102,   50,  102,  102,  102,  102,
			   57,  102,   59,  102,  102,   61,  102,  102,  102,   66,
			  102,  102,  102,  102,  102,  102,  102,  102,   84,  102,
			  102,   86,  102,  102,   88,  102,   89,  102,   91,  102,
			  102,  102,   97,  102,  102,  165,  165,  165,  108,  108,
			  108,  108,  102,   49,  102,  102,   52,  102,  102,  102,
			  102,   64,  102,   68,  102,  102,   71,  102,   72,  102,
			  102,  102,  102,  102,   87,  102,  102,  102,   99,  102,
			  165,  165,  165,  108,  108,  108,  108,  108,  102,   51,

			  102,   54,  102,   60,  102,   62,  102,   69,  102,  102,
			   79,  102,  102,   85,  102,   92,  102,   96,  102,  165,
			  148,  155,  151,  155,  108,  108,   45,  102,   73,  102,
			   83,  102,  147,  155>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1426
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 563
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 564
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

	yyNb_rules: INTEGER is 194
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 195
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
