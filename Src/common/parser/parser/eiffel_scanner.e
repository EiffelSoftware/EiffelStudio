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

				current_position.go_to (3)
				last_token := TE_BIT
			
when 45 then
--|#line 236 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 236")
end

				current_position.go_to (5)
				last_token := TE_CHECK
			
when 46 then
--|#line 240 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 240")
end

				current_position.go_to (5)
				last_token := TE_CLASS
			
when 47 then
--|#line 244 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 244")
end

				current_position.go_to (7)
				last_token := TE_CONVERT
			
when 48 then
--|#line 248 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 248")
end

				current_position.go_to (6)
				last_token := TE_CREATE
			
when 49 then
--|#line 252 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 252")
end

				current_position.go_to (8)
				last_token := TE_CREATION
			
when 50 then
--|#line 256 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 256")
end

				current_position.go_to (7)
				last_token := TE_CURRENT
			
when 51 then
--|#line 260 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 260")
end

				current_position.go_to (5)
				last_token := TE_DEBUG
			
when 52 then
--|#line 264 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 264")
end

				current_position.go_to (8)
				last_token := TE_DEFERRED
			
when 53 then
--|#line 268 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 268")
end

				current_position.go_to (2)
				last_token := TE_DO
			
when 54 then
--|#line 272 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 272")
end

				current_position.go_to (4)
				last_token := TE_ELSE
			
when 55 then
--|#line 276 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 276")
end

				current_position.go_to (6)
				last_token := TE_ELSEIF
			
when 56 then
--|#line 280 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 280")
end

				current_position.go_to (3)
				last_token := TE_END
			
when 57 then
--|#line 284 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 284")
end

				current_position.go_to (6)
				last_token := TE_ENSURE
			
when 58 then
--|#line 288 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 288")
end

				current_position.go_to (8)
				last_token := TE_EXPANDED
			
when 59 then
--|#line 292 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 292")
end

				current_position.go_to (6)
				last_token := TE_EXPORT
			
when 60 then
--|#line 296 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 296")
end

				current_position.go_to (8)
				last_token := TE_EXTERNAL
			
when 61 then
--|#line 300 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 300")
end

				current_position.go_to (5)
				last_token := TE_FALSE
			
when 62 then
--|#line 304 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 304")
end

				current_position.go_to (7)
				last_token := TE_FEATURE
			
when 63 then
--|#line 308 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 308")
end

				current_position.go_to (4)
				last_token := TE_FROM
			
when 64 then
--|#line 312 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 312")
end

				current_position.go_to (6)
				last_token := TE_FROZEN
			
when 65 then
--|#line 316 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 316")
end

				current_position.go_to (2)
				last_token := TE_IF
			
when 66 then
--|#line 320 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 320")
end

				current_position.go_to (7)
				last_token := TE_IMPLIES
			
when 67 then
--|#line 324 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 324")
end

				current_position.go_to (8)
				last_token := TE_INDEXING
			
when 68 then
--|#line 328 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 328")
end

				current_position.go_to (5)
				last_token := TE_INFIX
			
when 69 then
--|#line 332 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 332")
end

				current_position.go_to (7)
				last_token := TE_INHERIT
			
when 70 then
--|#line 336 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 336")
end

				current_position.go_to (7)
				last_token := TE_INSPECT
			
when 71 then
--|#line 340 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 340")
end

				current_position.go_to (9)
				last_token := TE_INVARIANT
			
when 72 then
--|#line 344 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 344")
end

				current_position.go_to (2)
				last_token := TE_IS
			
when 73 then
--|#line 348 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 348")
end

				current_position.go_to (4)
				last_token := TE_LIKE
			
when 74 then
--|#line 352 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 352")
end

				current_position.go_to (5)
				last_token := TE_LOCAL
			
when 75 then
--|#line 356 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 356")
end

				current_position.go_to (4)
				last_token := TE_LOOP
			
when 76 then
--|#line 360 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 360")
end

				current_position.go_to (3)
				last_token := TE_NOT
			
when 77 then
--|#line 364 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 364")
end

				current_position.go_to (8)
				last_token := TE_OBSOLETE
			
when 78 then
--|#line 368 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 368")
end

				current_position.go_to (3)
				last_token := TE_OLD
			
when 79 then
--|#line 372 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 372")
end

				current_position.go_to (4)
				last_token := TE_ONCE
			
when 80 then
--|#line 376 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 376")
end

				current_position.go_to (2)
				last_token := TE_OR
			
when 81 then
--|#line 380 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 380")
end

				current_position.go_to (9)
				last_token := TE_PRECURSOR
			
when 82 then
--|#line 384 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 384")
end

				current_position.go_to (6)
				last_token := TE_PREFIX
			
when 83 then
--|#line 388 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 388")
end

				current_position.go_to (8)
				last_token := TE_REDEFINE
			
when 84 then
--|#line 392 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 392")
end

				current_position.go_to (6)
				last_token := TE_RENAME
			
when 85 then
--|#line 396 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 396")
end

				current_position.go_to (7)
				last_token := TE_REQUIRE
			
when 86 then
--|#line 400 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 400")
end

				current_position.go_to (6)
				last_token := TE_RESCUE
			
when 87 then
--|#line 404 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 404")
end

				current_position.go_to (6)
				last_token := TE_RESULT
			
when 88 then
--|#line 408 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 408")
end

				current_position.go_to (5)
				last_token := TE_RETRY
			
when 89 then
--|#line 412 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 412")
end

				current_position.go_to (6)
				last_token := TE_SELECT
			
when 90 then
--|#line 416 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 416")
end

				current_position.go_to (8)
				last_token := TE_SEPARATE
			
when 91 then
--|#line 420 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 420")
end

				current_position.go_to (5)
				last_token := TE_STRIP
			
when 92 then
--|#line 424 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 424")
end

				current_position.go_to (4)
				last_token := TE_THEN
			
when 93 then
--|#line 428 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 428")
end

				current_position.go_to (4)
				last_token := TE_TRUE
			
when 94 then
--|#line 432 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 432")
end

				current_position.go_to (8)
				last_token := TE_UNDEFINE
			
when 95 then
--|#line 436 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 436")
end

				current_position.go_to (6)
				last_token := TE_UNIQUE
			
when 96 then
--|#line 440 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 440")
end

				current_position.go_to (5)
				last_token := TE_UNTIL
			
when 97 then
--|#line 444 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 444")
end

				current_position.go_to (7)
				last_token := TE_VARIANT
			
when 98 then
--|#line 448 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 448")
end

				current_position.go_to (4)
				last_token := TE_WHEN
			
when 99 then
--|#line 452 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 452")
end

				current_position.go_to (3)
				last_token := TE_XOR
			
when 100 then
--|#line 460 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 460")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 101 then
--|#line 474 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 474")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 102 then
--|#line 484 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 484")
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
			
when 103 then
	yy_end := yy_end - 2
--|#line 485 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 485")
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
			
when 104 then
--|#line 498 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 498")
end

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 105 then
--|#line 505 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 505")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 106 then
--|#line 514 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 514")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 107 then
--|#line 527 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 527")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 108 then
--|#line 533 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 533")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 109 then
--|#line 540 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 540")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 110 then
--|#line 546 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 546")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 111 then
--|#line 552 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 552")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 112 then
--|#line 558 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 558")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 113 then
--|#line 564 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 564")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 114 then
--|#line 570 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 570")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 115 then
--|#line 576 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 576")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 116 then
--|#line 582 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 582")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 117 then
--|#line 588 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 588")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 118 then
--|#line 594 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 594")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 119 then
--|#line 600 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 600")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 120 then
--|#line 606 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 606")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 612 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 612")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 618 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 618")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 624 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 624")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 630 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 630")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 636 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 636")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 642 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 642")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 648 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 648")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 654 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 654")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 660 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 660")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 666 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 666")
end

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 131, 132 then
--|#line 670 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 670")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 133 then
--|#line 681 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 681")
end

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 134 then
--|#line 685 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 685")
end

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 135 then
--|#line 689 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 689")
end

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 136 then
--|#line 693 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 693")
end

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 137 then
--|#line 697 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 697")
end

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 138 then
--|#line 701 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 701")
end

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 139 then
--|#line 705 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 705")
end

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 140 then
--|#line 709 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 709")
end

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 141 then
--|#line 713 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 713")
end

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 142 then
--|#line 717 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 717")
end

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 143 then
--|#line 721 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 721")
end

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 144 then
--|#line 725 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 725")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 145 then
--|#line 731 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 731")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 146 then
--|#line 737 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 737")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 147 then
--|#line 743 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 743")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 148 then
--|#line 749 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 749")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 149 then
--|#line 755 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 755")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 150 then
--|#line 761 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 761")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 151 then
--|#line 767 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 767")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
when 152 then
--|#line 773 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 773")
end

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 153 then
--|#line 778 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 778")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 154 then
--|#line 785 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 785")
end

					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			
when 155 then
--|#line 796 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 796")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			
when 156 then
--|#line 803 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 803")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 157 then
--|#line 819 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 819")
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
			
when 158 then
--|#line 849 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 849")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 159 then
--|#line 854 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 854")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
			
when 160 then
--|#line 861 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 861")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 161 then
--|#line 877 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 877")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR1)
			
when 162 then
--|#line 885 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 885")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 163 then
--|#line 898 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 898")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			
when 164 then
--|#line 908 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 908")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 165 then
--|#line 912 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 912")
end

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 166 then
--|#line 916 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 916")
end

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 167 then
--|#line 920 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 920")
end

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 168 then
--|#line 924 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 924")
end

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 169 then
--|#line 928 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 928")
end

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 170 then
--|#line 932 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 932")
end

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 171 then
--|#line 936 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 936")
end

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 172 then
--|#line 940 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 940")
end

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 173 then
--|#line 944 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 944")
end

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 174 then
--|#line 948 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 948")
end

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 175 then
--|#line 952 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 952")
end

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 176 then
--|#line 956 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 956")
end

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 177 then
--|#line 960 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 960")
end

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 178 then
--|#line 964 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 964")
end

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 179 then
--|#line 968 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 968")
end

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 180 then
--|#line 972 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 972")
end

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 181 then
--|#line 976 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 976")
end

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 182 then
--|#line 980 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 980")
end

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 183 then
--|#line 984 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 984")
end

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 184 then
--|#line 988 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 988")
end

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 185 then
--|#line 992 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 992")
end

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 186 then
--|#line 996 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 996")
end

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 187 then
--|#line 1000 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1000")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.reset_column_positions	
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 188 then
--|#line 1008 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1008")
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
			
when 189 then
--|#line 1021 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1021")
end

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 190 then
--|#line 1027 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1027")
end

					-- No final double-quote.
				line_number := line_number + 1
				current_position.reset_column_positions	
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 191 then
--|#line 1054 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1054")
end

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 192 then
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
			   61,   62,   64,   64,  186,   65,   65,  187,   66,   66,

			   68,   69,   68,  195,   70,   68,   69,   68,  198,   70,
			   75,   76,   75,   75,   76,   75,   77,   98,   77,   99,
			  100,  102,  104,  103,  103,  103,  113,  114,  119,  105,
			  101,  115,  116,  120,  106,  121,  107,  107,  108,   77,
			  122,   77,  106,  391,  107,  107,  108,  109,  106,  451,
			  108,  108,  108,   93,  333,  109,   71,  123,   93,  332,
			  119,   71,   80,   81,  129,  120,   81,  121,  331,  110,
			   82,   83,  122,   84,  130,   85,  111,  186,  134,  109,
			  187,   86,  135,   87,  111,   81,   88,  109,  143,  123,
			  111,  131,  148,  132,   89,  136,  129,  149,  124,   90,

			   91,  110,  125,  133,  150,  126,  130,  330,  127,   92,
			  134,  128,   93,   94,  135,   95,  141,  199,   88,  151,
			  143,  154,  142,  131,  148,  132,   89,  136,  152,  149,
			  124,   90,   91,  200,  125,  133,  150,  126,  153,  137,
			  127,   92,  155,  128,  156,   81,  138,  139,  141,  144,
			  157,  151,  140,  154,  142,  193,  194,  193,  329,  145,
			  152,  146,  188,  186,  188,  147,  187,   93,  328,  186,
			  153,  137,  190,  327,  155,  185,  156,  326,  138,  139,
			  457,  144,  157,   93,  140,   79,   79,  250,   79,  325,
			  196,  145,  324,  146,  249,  249,  249,  147,  162,  162,

			  162,  201,  163,  195,  203,  164,  215,  165,  166,  167,
			  205,  195,  195,  195,  202,  168,  195,  195,  189,  250,
			  323,  169,  111,  170,  204,  322,  171,  172,  173,  174,
			  206,  175,  253,  176,  212,  213,  212,  177,  195,  178,
			  197,  209,  179,  180,  181,  182,  183,  184,  207,  208,
			  211,   93,  251,   93,   93,  252,   93,  210,  321,  320,
			   93,   93,   93,   93,  253,  319,   93,   93,  214,  254,
			  301,  301,  301,  209,  318,  255,  256,  241,  241,  241,
			  207,  208,  211,  316,  251,  315,  314,  252,   93,  210,
			  218,  242,  257,  219,  258,  220,  221,  222,  193,  194,

			  193,  254,  243,  223,  244,  244,  244,  255,  256,  224,
			  259,  225,  313,  312,  226,  227,  228,  229,  245,  230,
			  192,  231,  262,  242,  257,  232,  258,  233,  267,  268,
			  234,  235,  236,  237,  238,  239,  106,  269,  246,  246,
			  247,  106,  259,  247,  247,  247,  161,  263,  260,  109,
			  245,  240,  261,  265,  262,  270,  217,  266,  276,   78,
			  267,  268,  264,  279,  277,  280,  281,  282,  283,  269,
			  289,  291,  292,  271,  290,  272,  278,  273,  111,  263,
			  260,  109,  302,  111,  261,  265,  293,  270,  274,  266,
			  276,  275,  297,  298,  264,  279,  277,  280,  281,  282,

			  283,  284,  289,  291,  292,  271,  290,  272,  278,  273,
			  294,  285,  299,  303,  286,  295,  287,  288,  293,  304,
			  274,  311,  195,  275,  297,  298,  296,  162,  162,  162,
			  195,  195,   93,  284,  300,  188,  186,  188,  308,  187,
			  309,  192,  294,  285,  299,  195,  286,  295,  287,  288,
			  186,  396,  161,  190,  159,  344,  185,  305,  296,   79,
			  212,  213,  212,   93,  196,  307,  317,  317,  317,   93,
			  306,   93,   93,  212,  213,  212,  158,  195,  117,  345,
			   93,   93,  334,  334,  334,  112,  310,  344,  346,  305,
			   93,  189,  337,  337,  337,   93,  242,  307,  335,   78,

			  335,   93,  306,  336,  336,  336,  338,  343,  343,  343,
			  339,  345,  339,  347,  197,  340,  340,  340,  310,  106,
			  346,  341,  341,  342,  348,  349,  350,   93,  242,  551,
			  351,  106,  109,  342,  342,  342,  352,  353,  338,  354,
			  355,   73,  357,  358,  359,  347,  360,  362,  363,  364,
			  365,  366,  367,  368,  356,  369,  348,  349,  350,  361,
			  370,  111,  351,  371,  109,  372,  375,  373,  352,  353,
			  374,  354,  355,  111,  357,  358,  359,  376,  360,  362,
			  363,  364,  365,  366,  367,  368,  356,  369,  377,  378,
			  380,  361,  370,  381,  382,  371,  383,  372,  375,  373,

			  384,  385,  374,  386,  387,  388,  389,  379,  390,  376,
			  391,  392,  392,  392,  393,  195,  394,  195,  398,   73,
			  377,  378,  380,  551,  551,  381,  382,  407,  383,  336,
			  336,  336,  384,  385,  551,  386,  387,  388,  389,  379,
			  390,  399,  317,  317,  317,  397,  400,  400,  400,  551,
			  395,  336,  336,  336,  551,  402,  402,  402,  551,  407,
			  242,  340,  340,  340,  551,   93,   93,   93,   93,  338,
			  340,  340,  340,  403,  408,  403,  409,  397,  404,  404,
			  404,  405,  395,  341,  341,  342,  401,  405,  410,  342,
			  342,  342,  242,  411,  109,  406,  406,  406,  412,  413,

			  414,  338,  415,  416,  417,  418,  408,  419,  409,  420,
			  421,  422,  423,  424,  425,  426,  427,  428,  429,  430,
			  410,  431,  432,  433,  434,  411,  109,  435,  436,  437,
			  412,  413,  414,  438,  415,  416,  417,  418,  439,  419,
			  440,  420,  421,  422,  423,  424,  425,  426,  427,  428,
			  429,  430,  441,  431,  432,  433,  434,  442,  443,  435,
			  436,  437,  444,  445,  446,  438,  391,  447,  447,  447,
			  439,  195,  440,  195,  195,  453,  453,  453,  458,  400,
			  400,  400,  551,  551,  441,  461,  454,  454,  454,  442,
			  443,  551,  551,  452,  444,  445,  446,  404,  404,  404,

			  338,  404,  404,  404,  243,  449,  454,  454,  454,  450,
			  458,  459,  462,  463,  448,  460,  464,  461,  465,  466,
			  456,   93,  467,   93,   93,  452,  455,  468,  469,  470,
			  471,  472,  338,  473,  474,  475,  476,  449,  477,  478,
			  479,  450,  480,  459,  462,  463,  448,  460,  464,  481,
			  465,  466,  456,  482,  467,  483,  484,  485,  486,  468,
			  469,  470,  471,  472,  487,  473,  474,  475,  476,  195,
			  477,  478,  479,  195,  480,  195,  500,  491,  501,  491,
			  551,  481,  492,  492,  492,  482,  502,  483,  484,  485,
			  486,  493,  493,  493,  503,  504,  487,  454,  454,  454,

			  488,  489,  496,  496,  496,  494,  505,  497,  500,  497,
			  501,  495,  498,  498,  498,  506,  507,  490,  502,   93,
			  496,  496,  496,   93,  508,   93,  503,  504,  509,  510,
			  511,  512,  488,  489,  499,  513,  514,  494,  505,  515,
			  516,  517,  518,  495,  195,  551,  551,  506,  507,  490,
			  195,  195,  492,  492,  492,  551,  508,  492,  492,  492,
			  509,  510,  511,  512,  531,  551,  499,  513,  514,  551,
			  551,  515,  516,  517,  518,  522,  522,  522,  519,  521,
			  551,  527,  527,  527,  532,  523,  520,  523,  533,  494,
			  524,  524,  524,  534,   93,  528,  531,  525,  535,  525,

			   93,   93,  526,  526,  526,  498,  498,  498,  536,  537,
			  519,  521,  498,  498,  498,  538,  532,  529,  520,  529,
			  533,  494,  530,  530,  530,  534,  539,  528,  540,  541,
			  535,  195,  543,  544,  524,  524,  524,  494,  550,  548,
			  536,  537,  524,  524,  524,  551,  551,  538,  526,  526,
			  526,  526,  526,  526,  530,  530,  530,  549,  539,  551,
			  540,  541,  551,  401,  545,  545,  545,  528,  542,  494,
			  546,  548,  546,  551,  551,  547,  547,  547,  528,  551,
			  551,   93,   93,   93,  530,  530,  530,  551,   93,  549,
			  547,  547,  547,  455,  547,  547,  547,  551,  551,  528,

			  542,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  528,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   79,  551,   79,  551,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   96,  551,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   97,  551,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,

			  160,  551,  160,  551,  160,  160,  160,  160,  160,  160,
			  160,  160,  160,  185,  185,  185,  185,  185,  185,  185,
			  185,  185,  185,  185,  185,  185,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  191,
			  191,  191,  191,  191,  191,  191,  191,  191,  191,  191,
			  191,  191,   81,  551,   81,  551,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,  216,  551,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  216,  100,  551,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  248,  248,  248,   11,  551,  551,  551,  551,  551,

			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551>>)
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

			    5,    5,    5,   79,    5,    6,    6,    6,   82,    6,
			    9,    9,    9,   10,   10,   10,   13,   19,   13,   19,
			   25,   26,   27,   26,   26,   26,   33,   33,   37,   27,
			   25,   35,   35,   37,   28,   37,   28,   28,   28,   77,
			   37,   77,   29,  447,   29,   29,   29,   28,   30,  399,
			   30,   30,   30,   79,  239,   29,    5,   38,   82,  238,
			   37,    6,   16,   16,   40,   37,   16,   37,  237,   28,
			   16,   16,   37,   16,   40,   16,   28,  185,   42,   28,
			  185,   16,   42,   16,   29,   16,   16,   29,   46,   38,
			   30,   41,   48,   41,   16,   42,   40,   49,   39,   16,

			   16,   28,   39,   41,   50,   39,   40,  236,   39,   16,
			   42,   39,   16,   16,   42,   16,   45,   83,   16,   50,
			   46,   52,   45,   41,   48,   41,   16,   42,   51,   49,
			   39,   16,   16,   84,   39,   41,   50,   39,   51,   44,
			   39,   16,   53,   39,   54,   16,   44,   44,   45,   47,
			   55,   50,   44,   52,   45,   75,   75,   75,  235,   47,
			   51,   47,   68,   68,   68,   47,   68,   83,  234,   71,
			   51,   44,   71,  233,   53,   71,   54,  232,   44,   44,
			  406,   47,   55,   84,   44,   81,   81,  119,   81,  231,
			   81,   47,  230,   47,  111,  111,  111,   47,   66,   66,

			   66,   85,   66,   90,   86,   66,   95,   66,   66,   66,
			   87,   88,   92,   89,   85,   66,   91,   94,   68,  119,
			  229,   66,  406,   66,   86,  228,   66,   66,   66,   66,
			   87,   66,  121,   66,   93,   93,   93,   66,   93,   66,
			   81,   90,   66,   66,   66,   66,   66,   66,   88,   89,
			   92,   85,  120,   90,   86,  120,   95,   91,  227,  226,
			   87,   88,   92,   89,  121,  225,   91,   94,   94,  123,
			  168,  168,  168,   90,  224,  124,  125,  103,  103,  103,
			   88,   89,   92,  222,  120,  221,  220,  120,   93,   91,
			   98,  103,  126,   98,  127,   98,   98,   98,  193,  193,

			  193,  123,  106,   98,  106,  106,  106,  124,  125,   98,
			  128,   98,  219,  218,   98,   98,   98,   98,  106,   98,
			  191,   98,  131,  103,  126,   98,  127,   98,  134,  135,
			   98,   98,   98,   98,   98,   98,  107,  136,  107,  107,
			  107,  108,  128,  108,  108,  108,  160,  132,  129,  107,
			  106,   99,  129,  133,  131,  138,   97,  133,  141,   78,
			  134,  135,  132,  143,  142,  144,  145,  146,  148,  136,
			  150,  151,  152,  139,  150,  139,  142,  139,  107,  132,
			  129,  107,  202,  108,  129,  133,  153,  138,  139,  133,
			  141,  139,  155,  156,  132,  143,  142,  144,  145,  146,

			  148,  149,  150,  151,  152,  139,  150,  139,  142,  139,
			  154,  149,  157,  204,  149,  154,  149,  149,  153,  206,
			  139,  214,  209,  139,  155,  156,  154,  162,  162,  162,
			  207,  208,  202,  149,  162,  188,  188,  188,  210,  188,
			  210,   72,  154,  149,  157,  211,  149,  154,  149,  149,
			  189,  307,   63,  189,   61,  250,  189,  207,  154,  197,
			  197,  197,  197,  204,  197,  209,  223,  223,  223,  206,
			  208,  214,  209,  212,  212,  212,   57,  212,   36,  251,
			  207,  208,  241,  241,  241,   31,  211,  250,  255,  207,
			  210,  188,  244,  244,  244,  211,  241,  209,  242,   14,

			  242,  307,  208,  242,  242,  242,  244,  249,  249,  249,
			  245,  251,  245,  256,  197,  245,  245,  245,  211,  246,
			  255,  246,  246,  246,  257,  258,  259,  212,  241,   11,
			  260,  247,  246,  247,  247,  247,  261,  262,  244,  264,
			  265,    8,  266,  267,  268,  256,  269,  270,  271,  272,
			  273,  274,  275,  276,  265,  277,  257,  258,  259,  269,
			  278,  246,  260,  280,  246,  282,  284,  283,  261,  262,
			  283,  264,  265,  247,  266,  267,  268,  285,  269,  270,
			  271,  272,  273,  274,  275,  276,  265,  277,  286,  287,
			  288,  269,  278,  289,  290,  280,  291,  282,  284,  283,

			  292,  293,  283,  294,  295,  296,  297,  287,  298,  285,
			  301,  301,  301,  301,  305,  306,  305,  308,  310,    7,
			  286,  287,  288,    0,    0,  289,  290,  344,  291,  335,
			  335,  335,  292,  293,    0,  294,  295,  296,  297,  287,
			  298,  317,  317,  317,  317,  308,  334,  334,  334,    0,
			  306,  336,  336,  336,    0,  337,  337,  337,    0,  344,
			  334,  339,  339,  339,    0,  306,  305,  308,  310,  337,
			  340,  340,  340,  338,  345,  338,  346,  308,  338,  338,
			  338,  341,  306,  341,  341,  341,  334,  342,  347,  342,
			  342,  342,  334,  348,  341,  343,  343,  343,  349,  350,

			  351,  337,  352,  353,  354,  355,  345,  356,  346,  357,
			  358,  359,  361,  362,  363,  364,  365,  366,  367,  369,
			  347,  371,  373,  374,  375,  348,  341,  376,  377,  378,
			  349,  350,  351,  379,  352,  353,  354,  355,  380,  356,
			  381,  357,  358,  359,  361,  362,  363,  364,  365,  366,
			  367,  369,  382,  371,  373,  374,  375,  383,  386,  376,
			  377,  378,  387,  388,  389,  379,  392,  392,  392,  392,
			  380,  393,  381,  395,  397,  401,  401,  401,  411,  400,
			  400,  400,    0,    0,  382,  413,  402,  402,  402,  383,
			  386,    0,    0,  400,  387,  388,  389,  403,  403,  403,

			  402,  404,  404,  404,  405,  395,  405,  405,  405,  397,
			  411,  412,  415,  416,  393,  412,  417,  413,  418,  419,
			  405,  393,  420,  395,  397,  400,  402,  422,  423,  424,
			  425,  427,  402,  428,  429,  431,  432,  395,  433,  434,
			  435,  397,  436,  412,  415,  416,  393,  412,  417,  437,
			  418,  419,  405,  438,  420,  440,  441,  443,  444,  422,
			  423,  424,  425,  427,  446,  428,  429,  431,  432,  448,
			  433,  434,  435,  449,  436,  450,  458,  452,  460,  452,
			    0,  437,  452,  452,  452,  438,  461,  440,  441,  443,
			  444,  453,  453,  453,  462,  465,  446,  454,  454,  454,

			  448,  449,  455,  455,  455,  453,  467,  456,  458,  456,
			  460,  454,  456,  456,  456,  468,  470,  450,  461,  448,
			  457,  457,  457,  449,  471,  450,  462,  465,  472,  473,
			  474,  475,  448,  449,  457,  476,  478,  453,  467,  480,
			  484,  485,  487,  454,  489,    0,    0,  468,  470,  450,
			  488,  490,  491,  491,  491,    0,  471,  492,  492,  492,
			  472,  473,  474,  475,  501,    0,  457,  476,  478,    0,
			    0,  480,  484,  485,  487,  493,  493,  493,  488,  490,
			    0,  496,  496,  496,  503,  494,  489,  494,  504,  493,
			  494,  494,  494,  505,  489,  496,  501,  495,  508,  495,

			  488,  490,  495,  495,  495,  497,  497,  497,  511,  512,
			  488,  490,  498,  498,  498,  513,  503,  499,  489,  499,
			  504,  493,  499,  499,  499,  505,  514,  496,  516,  517,
			  508,  519,  520,  521,  523,  523,  523,  522,  542,  536,
			  511,  512,  524,  524,  524,    0,    0,  513,  525,  525,
			  525,  526,  526,  526,  529,  529,  529,  538,  514,    0,
			  516,  517,    0,  522,  527,  527,  527,  545,  519,  522,
			  528,  536,  528,    0,    0,  528,  528,  528,  527,    0,
			    0,  519,  520,  521,  530,  530,  530,    0,  542,  538,
			  546,  546,  546,  545,  547,  547,  547,    0,    0,  545,

			  519,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  527,  552,  552,  552,  552,  552,  552,  552,  552,  552,
			  552,  552,  552,  552,  553,  553,  553,  553,  553,  553,
			  553,  553,  553,  553,  553,  553,  553,  554,  554,  554,
			  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,
			  555,  555,  555,  555,  555,  555,  555,  555,  555,  555,
			  555,  555,  555,  556,    0,  556,    0,  556,  556,  556,
			  556,  556,  556,  556,  556,  556,  557,    0,  557,  557,
			  557,  557,  557,  557,  557,  557,  557,  558,    0,  558,
			  558,  558,  558,  558,  558,  558,  558,  558,  558,  558,

			  560,    0,  560,    0,  560,  560,  560,  560,  560,  560,
			  560,  560,  560,  561,  561,  561,  561,  561,  561,  561,
			  561,  561,  561,  561,  561,  561,  562,  562,  562,  562,
			  562,  562,  562,  562,  562,  562,  562,  562,  562,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  564,    0,  564,    0,  564,  564,  564,  564,
			  564,  564,  564,  564,  564,  565,    0,  565,  565,  565,
			  565,  565,  565,  565,  565,  565,  565,  565,  566,    0,
			  566,  566,  566,  566,  566,  566,  566,  566,  566,  566,
			  566,  567,  567,  567,  551,  551,  551,  551,  551,  551,

			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   89,   90,   98,  103,  716,  638,  108,
			  111,  629, 1394,  114,  596, 1394,  156,    0, 1394,  108,
			 1394, 1394, 1394, 1394, 1394,  103,  103,  103,  116,  124,
			  130,  559, 1394,  101, 1394,  105,  552,   92,  119,  161,
			  130,  150,  148,    0,  204,  178,  144,  218,  145,  163,
			  170,  191,  178,  212,  207,  206, 1394,  519, 1394, 1394,
			 1394,  463, 1394,  546, 1394, 1394,  296,   91,  260, 1394,
			 1394,  266,  538, 1394, 1394,  253, 1394,  137,  456,   97,
			 1394,  284,  102,  211,  227,  295,  298,  304,  305,  307,
			  297,  310,  306,  332,  311,  300,    0,  445,  384,  440,

			    0, 1394, 1394,  357, 1394, 1394,  384,  418,  423, 1394,
			    0,  274, 1394, 1394, 1394, 1394, 1394, 1394,    0,  253,
			  314,  299,    0,  320,  341,  346,  349,  360,  363,  417,
			    0,  374,  414,  408,  387,  399,  393,    0,  410,  440,
			    0,  418,  432,  414,  417,  433,  435,    0,  434,  468,
			  429,  424,  438,  436,  477,  445,  459,  465, 1394, 1394,
			  440, 1394,  525, 1394, 1394, 1394, 1394, 1394,  350, 1394,
			 1394, 1394, 1394, 1394, 1394, 1394, 1394, 1394, 1394, 1394,
			 1394, 1394, 1394, 1394, 1394,  174, 1394, 1394,  533,  547,
			 1394,  417, 1394,  396, 1394, 1394, 1394,  558, 1394, 1394,

			 1394, 1394,  476, 1394,  507, 1394,  513,  524,  525,  516,
			  534,  539,  571, 1394,  515, 1394, 1394, 1394,  402,  401,
			  375,  374,  372,  546,  363,  354,  348,  347,  314,  309,
			  281,  278,  266,  262,  257,  247,  196,  157,  148,  143,
			 1394,  562,  583, 1394,  572,  595,  601,  613,    0,  587,
			  512,  549,    0,    0,    0,  556,  565,  573,  595,  579,
			  580,  602,  603,    0,  589,  610,  608,  595,  595,  604,
			  606,  614,  611,  616,  606,  622,  619,  625,  615,    0,
			  619,    0,  631,  635,  632,  647,  638,  657,  643,  659,
			  664,  658,  657,  667,  669,  658,  667,  668,  665,    0,

			 1394,  691, 1394, 1394, 1394,  710,  709,  545,  711, 1394,
			  712, 1394, 1394, 1394, 1394, 1394, 1394,  722, 1394, 1394,
			 1394, 1394, 1394, 1394, 1394, 1394, 1394, 1394, 1394, 1394,
			 1394, 1394, 1394, 1394,  726,  709,  731,  735,  758,  741,
			  750,  763,  769,  775,  678,  726,  736,  740,  759,  749,
			  765,  764,  755,  765,  757,  762,  760,  762,  776,  761,
			    0,  778,  775,  761,  762,  769,  783,  771,    0,  778,
			    0,  780,    0,  772,  785,  789,  785,  790,  779,  792,
			  784,  808,  805,  812,    0,    0,  823,  812,  822,  834,
			    0, 1394,  847,  865, 1394,  867, 1394,  868, 1394,  138,

			  859,  855,  866,  877,  881,  886,  262,    0,    0,    0,
			    0,  831,  877,  842,    0,  865,  878,  882,  885,  870,
			  879,    0,  880,  885,  895,  892,    0,  893,  901,  896,
			    0,  901,  889,  885,  901,  906,  895,  915,  904,    0,
			  906,  926,    0,  919,  924,    0,  921,  124,  963,  967,
			  969, 1394,  962,  971,  977,  982,  992, 1000,  927,    0,
			  934,  937,  960,    0,    0,  961,    0,  976,  981,    0,
			  968,  981,  979,  980, 1000,  982,  987,    0,  993,    0,
			 1005,    0,    0,    0,  991,  998,    0,  993, 1044, 1038,
			 1045, 1032, 1037, 1055, 1070, 1082, 1061, 1085, 1092, 1102,

			    0, 1021,    0, 1051, 1055, 1052,    0,    0, 1062,    0,
			    0, 1065, 1075, 1071, 1092,    0, 1094, 1095,    0, 1125,
			 1126, 1127, 1103, 1114, 1122, 1128, 1131, 1144, 1155, 1134,
			 1164,    0,    0,    0,    0,    0, 1090,    0, 1110,    0,
			    0,    0, 1132, 1394, 1394, 1133, 1170, 1174,    0,    0,
			 1394, 1394, 1210, 1223, 1236, 1249, 1262, 1273, 1286, 1196,
			 1299, 1312, 1325, 1338, 1351, 1364, 1377, 1386>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  551,    1,  552,  552,  553,  553,  554,  554,  555,
			  555,  551,  551,  551,  551,  551,  556,  557,  551,  558,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  551,  551,  551,  551,
			  551,  551,  551,  560,  551,  551,  551,  561,  561,  551,
			  551,  562,  563,  551,  551,  551,  551,  551,  551,  556,
			  551,  564,  556,  556,  556,  556,  556,  556,  556,  556,
			  556,  556,  556,  556,  556,  556,  557,  565,  565,  565,

			  566,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  567,  551,  551,  551,  551,  551,  551,  551,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  551,  551,
			  560,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  561,  551,  551,  561,  562,
			  551,  563,  551,  551,  551,  551,  551,  564,  551,  551,

			  551,  551,  556,  551,  556,  551,  556,  556,  556,  556,
			  556,  556,  556,  551,  556,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  567,  551,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,

			  551,  551,  551,  551,  551,  556,  556,  556,  556,  551,
			  556,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  551,  551,  556,  551,  556,  551,  556,  551,  551,

			  551,  551,  551,  551,  551,  551,  551,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  551,  556,  556,
			  556,  551,  551,  551,  551,  551,  551,  551,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  556,  556,
			  556,  551,  551,  551,  551,  551,  551,  551,  551,  551,

			  559,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  559,  556,
			  556,  556,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  559,  559,  559,  559,  559,  559,  559,  559,  559,
			  559,  559,  556,  551,  551,  551,  551,  551,  559,  559,
			  551,    0,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  551,  551>>)
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
			  242,  244,  245,  246,  247,  248,  249,  250,  252,  253,
			  254,  256,  257,  258,  259,  260,  261,  262,  264,  265,
			  266,  267,  268,  269,  270,  271,  272,  273,  274,  275,
			  276,  277,  278,  278,  279,  280,  281,  282,  283,  283,
			  284,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  306,  307,  308,  308,  309,  310,  312,  314,  316,

			  318,  320,  322,  323,  325,  326,  328,  329,  330,  331,
			  332,  333,  334,  335,  336,  337,  339,  340,  342,  343,
			  344,  345,  346,  347,  348,  349,  350,  351,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  366,  367,  367,  368,  369,  369,  371,  373,  374,
			  374,  375,  376,  378,  380,  382,  383,  384,  385,  386,
			  387,  388,  389,  390,  392,  393,  394,  395,  396,  397,
			  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,
			  409,  410,  412,  413,  414,  415,  416,  417,  418,  419,
			  420,  421,  422,  423,  424,  425,  426,  427,  428,  429,

			  431,  432,  432,  434,  436,  438,  439,  440,  441,  442,
			  444,  445,  447,  448,  449,  450,  451,  452,  453,  454,
			  455,  456,  457,  458,  459,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  470,  471,  472,  472,
			  472,  473,  474,  475,  475,  476,  477,  478,  479,  480,
			  481,  482,  483,  484,  486,  487,  488,  489,  490,  491,
			  492,  494,  495,  496,  497,  498,  499,  500,  501,  503,
			  504,  506,  507,  509,  510,  511,  512,  513,  514,  515,
			  516,  517,  518,  519,  520,  522,  524,  525,  526,  527,
			  528,  530,  531,  531,  532,  534,  535,  537,  538,  540,

			  541,  542,  542,  543,  543,  544,  545,  546,  548,  550,
			  552,  554,  555,  556,  557,  559,  560,  561,  562,  563,
			  564,  565,  567,  568,  569,  570,  571,  573,  574,  575,
			  576,  578,  579,  580,  581,  582,  583,  584,  585,  586,
			  588,  589,  590,  592,  593,  594,  596,  597,  597,  598,
			  599,  600,  601,  601,  602,  603,  603,  603,  604,  605,
			  607,  608,  609,  610,  612,  614,  615,  617,  618,  619,
			  621,  622,  623,  624,  625,  626,  627,  628,  630,  631,
			  633,  634,  636,  638,  640,  641,  642,  644,  645,  646,
			  647,  648,  648,  649,  650,  650,  650,  651,  651,  652,

			  652,  654,  655,  657,  658,  659,  660,  662,  664,  665,
			  667,  669,  670,  671,  672,  673,  675,  676,  677,  679,
			  680,  681,  682,  683,  683,  684,  684,  685,  686,  686,
			  686,  687,  689,  691,  693,  695,  697,  698,  700,  701,
			  703,  705,  707,  708,  710,  712,  713,  713,  714,  716,
			  718,  720,  720>>)
		end

	yy_acclist_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  160,  160,  162,  162,  193,  191,  192,    2,  191,
			  192,    3,  192,   33,  191,  192,  163,  191,  192,   38,
			  191,  192,   12,  191,  192,  131,  191,  192,   21,  191,
			  192,   22,  191,  192,   29,  191,  192,   27,  191,  192,
			    6,  191,  192,   28,  191,  192,   11,  191,  192,   30,
			  191,  192,  102,  104,  191,  192,  102,  104,  191,  192,
			  102,  104,  191,  192,    5,  191,  192,    4,  191,  192,
			   16,  191,  192,   15,  191,  192,   17,  191,  192,    8,
			  191,  192,  100,  191,  192,  100,  191,  192,  100,  191,
			  192,  100,  191,  192,  100,  191,  192,  100,  191,  192,

			  100,  191,  192,  100,  191,  192,  100,  191,  192,  100,
			  191,  192,  100,  191,  192,  100,  191,  192,  100,  191,
			  192,  100,  191,  192,  100,  191,  192,  100,  191,  192,
			  100,  191,  192,  100,  191,  192,  100,  191,  192,   25,
			  191,  192,  191,  192,   26,  191,  192,   31,  191,  192,
			   23,  191,  192,   24,  191,  192,    9,  191,  192,  164,
			  192,  190,  192,  188,  192,  189,  192,  160,  192,  160,
			  192,  159,  192,  158,  192,  160,  192,  162,  192,  161,
			  192,  156,  192,  156,  192,  155,  192,    2,    3,  163,
			  152,  163,  163,  163,  163,  163,  163,  163,  163,  163,

			  163,  163,  163,  163, -346,  163,  163,   38,  131,  131,
			  131,    1,   32,    7,  106,   36,   20,  106,  102,  104,
			  102,  104,  101,   13,   34,   18,   19,   35,   14,  100,
			  100,  100,  100,   43,  100,  100,  100,  100,  100,  100,
			  100,  100,   53,  100,  100,  100,  100,  100,  100,  100,
			   65,  100,  100,  100,   72,  100,  100,  100,  100,  100,
			  100,  100,   80,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,   37,   10,  164,  188,  181,  179,
			  180,  182,  183,  184,  185,  165,  166,  167,  168,  169,
			  170,  171,  172,  173,  174,  175,  176,  177,  178,  160,

			  159,  158,  160,  160,  157,  158,  162,  161,  155,  153,
			  151,  153,  163, -346,  139,  153,  137,  153,  138,  153,
			  140,  153,  163,  133,  153,  163,  134,  153,  163,  163,
			  163,  163,  163,  163,  163, -154,  163,  141,  153,  131,
			  107,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  108,  131,  106,  103,  106,  102,
			  104,  102,  104,  105,  100,  100,   41,  100,   42,  100,
			   44,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			   56,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,   76,  100,  100,
			   78,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,   99,
			  100,  187,  142,  153,  135,  153,  136,  153,  163,  163,
			  163,  163,  148,  153,  163,  143,  153,  125,  123,  124,
			  126,  127,  132,  128,  129,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  106,
			  106,  106,  106,  102,  102,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,   54,  100,  100,  100,  100,  100,
			  100,  100,   63,  100,  100,  100,  100,  100,  100,  100,

			  100,   73,  100,  100,   75,  100,  100,   79,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			   92,  100,   93,  100,  100,  100,  100,  100,   98,  100,
			  186,  163,  144,  153,  163,  147,  153,  163,  150,  153,
			  132,  106,  106,  106,  106,  104,   39,  100,   40,  100,
			   45,  100,   46,  100,  100,  100,  100,   51,  100,  100,
			  100,  100,  100,  100,  100,   61,  100,  100,  100,  100,
			  100,   68,  100,  100,  100,  100,   74,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,   88,  100,  100,  100,
			   91,  100,  100,  100,   96,  100,  100,  163,  163,  163,

			  130,  106,  106,  106,  100,   48,  100,  100,  100,  100,
			   55,  100,   57,  100,  100,   59,  100,  100,  100,   64,
			  100,  100,  100,  100,  100,  100,  100,  100,   82,  100,
			  100,   84,  100,  100,   86,  100,   87,  100,   89,  100,
			  100,  100,   95,  100,  100,  163,  163,  163,  106,  106,
			  106,  106,   47,  100,  100,   50,  100,  100,  100,  100,
			   62,  100,   66,  100,  100,   69,  100,   70,  100,  100,
			  100,  100,  100,   85,  100,  100,  100,   97,  100,  163,
			  163,  163,  106,  106,  106,  106,  106,   49,  100,   52,
			  100,   58,  100,   60,  100,   67,  100,  100,   77,  100,

			  100,   83,  100,   90,  100,   94,  100,  163,  146,  153,
			  149,  153,  106,  106,   71,  100,   81,  100,  145,  153>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1394
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 551
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 552
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

	yyNb_rules: INTEGER is 192
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 193
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
