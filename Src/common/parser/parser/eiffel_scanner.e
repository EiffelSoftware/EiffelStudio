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

				current_position.go_to (7)
				last_token := TE_BOOLEAN_ID
			
when 101 then
--|#line 464 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 464")
end

				current_position.go_to (9)
				last_token := TE_CHARACTER_ID
			
when 102 then
--|#line 468 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 468")
end

				current_position.go_to (6)
				last_token := TE_DOUBLE_ID
			
when 103 then
--|#line 472 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 472")
end

				current_position.go_to (9)
				last_token := TE_INTEGER_8_ID
			
when 104 then
--|#line 476 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 476")
end

				current_position.go_to (10)
				last_token := TE_INTEGER_16_ID
			
when 105 then
--|#line 480 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 480")
end

				current_position.go_to (7)
				last_token := TE_INTEGER_ID
			
when 106 then
--|#line 484 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 484")
end

				current_position.go_to (10)
				last_token := TE_INTEGER_64_ID
			
when 107 then
--|#line 488 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 488")
end

				current_position.go_to (4)
				last_token := TE_NONE_ID
			
when 108 then
--|#line 492 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 492")
end

				current_position.go_to (7)
				last_token := TE_POINTER_ID
			
when 109 then
--|#line 496 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 496")
end

				current_position.go_to (4)
				last_token := TE_REAL_ID
			
when 110 then
--|#line 500 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 500")
end

				current_position.go_to (14)
				last_token := TE_WIDE_CHAR_ID
			
when 111 then
--|#line 504 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 504")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			
when 112 then
--|#line 518 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 518")
end

				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			
when 113 then
--|#line 528 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 528")
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
			
when 114 then
	yy_end := yy_end - 2
--|#line 529 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 529")
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
			
when 115 then
--|#line 542 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 542")
end

				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 116 then
--|#line 549 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 549")
end
		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			
when 117 then
--|#line 558 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 558")
end

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				current_position.go_to (text_count)
				last_token := TE_REAL
			
when 118 then
--|#line 571 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 571")
end

				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 119 then
--|#line 577 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 577")
end

					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			
when 120 then
--|#line 584 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 584")
end

				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 121 then
--|#line 590 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 590")
end

				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 122 then
--|#line 596 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 596")
end

				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 123 then
--|#line 602 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 602")
end

				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 124 then
--|#line 608 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 608")
end

				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 125 then
--|#line 614 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 614")
end

				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 126 then
--|#line 620 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 620")
end

				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 127 then
--|#line 626 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 626")
end

				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 128 then
--|#line 632 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 632")
end

				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 129 then
--|#line 638 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 638")
end

				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 130 then
--|#line 644 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 644")
end

				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 131 then
--|#line 650 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 650")
end

				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 132 then
--|#line 656 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 656")
end

				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 133 then
--|#line 662 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 662")
end

				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 134 then
--|#line 668 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 668")
end

				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 135 then
--|#line 674 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 674")
end

				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 136 then
--|#line 680 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 680")
end

				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 137 then
--|#line 686 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 686")
end

				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 138 then
--|#line 692 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 692")
end

				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 139 then
--|#line 698 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 698")
end

				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 140 then
--|#line 704 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 704")
end

				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			
when 141 then
--|#line 710 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 710")
end

				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			
when 142, 143 then
--|#line 714 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 714")
end

					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			
when 144 then
--|#line 725 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 725")
end

				current_position.go_to (3)
				last_token := TE_STR_LT
			
when 145 then
--|#line 729 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 729")
end

				current_position.go_to (3)
				last_token := TE_STR_GT
			
when 146 then
--|#line 733 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 733")
end

				current_position.go_to (4)
				last_token := TE_STR_LE
			
when 147 then
--|#line 737 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 737")
end

				current_position.go_to (4)
				last_token := TE_STR_GE
			
when 148 then
--|#line 741 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 741")
end

				current_position.go_to (3)
				last_token := TE_STR_PLUS
			
when 149 then
--|#line 745 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 745")
end

				current_position.go_to (3)
				last_token := TE_STR_MINUS
			
when 150 then
--|#line 749 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 749")
end

				current_position.go_to (3)
				last_token := TE_STR_STAR
			
when 151 then
--|#line 753 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 753")
end

				current_position.go_to (3)
				last_token := TE_STR_SLASH
			
when 152 then
--|#line 757 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 757")
end

				current_position.go_to (3)
				last_token := TE_STR_POWER
			
when 153 then
--|#line 761 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 761")
end

				current_position.go_to (4)
				last_token := TE_STR_DIV
			
when 154 then
--|#line 765 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 765")
end

				current_position.go_to (4)
				last_token := TE_STR_MOD
			
when 155 then
--|#line 769 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 769")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			
when 156 then
--|#line 775 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 775")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			
when 157 then
--|#line 781 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 781")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			
when 158 then
--|#line 787 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 787")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			
when 159 then
--|#line 793 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 793")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			
when 160 then
--|#line 799 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 799")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			
when 161 then
--|#line 805 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 805")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			
when 162 then
--|#line 811 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 811")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			
when 163 then
--|#line 817 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 817")
end

					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			
when 164 then
--|#line 822 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 822")
end

					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			
when 165 then
--|#line 829 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 829")
end

					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			
when 166 then
--|#line 840 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 840")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			
when 167 then
--|#line 847 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 847")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 168 then
--|#line 863 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 863")
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
			
when 169 then
--|#line 893 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 893")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			
when 170 then
--|#line 898 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 898")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
			
when 171 then
--|#line 905 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 905")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 172 then
--|#line 921 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 921")
end

				line_number := line_number + 1
				current_position.reset_column_positions
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR1)
			
when 173 then
--|#line 929 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 929")
end

					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			
when 174 then
--|#line 942 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 942")
end

					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			
when 175 then
--|#line 952 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 952")
end

				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			
when 176 then
--|#line 956 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 956")
end

				current_position.go_to (2)
				token_buffer.append_character ('%A')
			
when 177 then
--|#line 960 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 960")
end

				current_position.go_to (2)
				token_buffer.append_character ('%B')
			
when 178 then
--|#line 964 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 964")
end

				current_position.go_to (2)
				token_buffer.append_character ('%C')
			
when 179 then
--|#line 968 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 968")
end

				current_position.go_to (2)
				token_buffer.append_character ('%D')
			
when 180 then
--|#line 972 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 972")
end

				current_position.go_to (2)
				token_buffer.append_character ('%F')
			
when 181 then
--|#line 976 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 976")
end

				current_position.go_to (2)
				token_buffer.append_character ('%H')
			
when 182 then
--|#line 980 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 980")
end

				current_position.go_to (2)
				token_buffer.append_character ('%L')
			
when 183 then
--|#line 984 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 984")
end

				current_position.go_to (2)
				token_buffer.append_character ('%N')
			
when 184 then
--|#line 988 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 988")
end

				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			
when 185 then
--|#line 992 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 992")
end

				current_position.go_to (2)
				token_buffer.append_character ('%R')
			
when 186 then
--|#line 996 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 996")
end

				current_position.go_to (2)
				token_buffer.append_character ('%S')
			
when 187 then
--|#line 1000 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1000")
end

				current_position.go_to (2)
				token_buffer.append_character ('%T')
			
when 188 then
--|#line 1004 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1004")
end

				current_position.go_to (2)
				token_buffer.append_character ('%U')
			
when 189 then
--|#line 1008 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1008")
end

				current_position.go_to (2)
				token_buffer.append_character ('%V')
			
when 190 then
--|#line 1012 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1012")
end

				current_position.go_to (2)
				token_buffer.append_character ('%%')
			
when 191 then
--|#line 1016 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1016")
end

				current_position.go_to (2)
				token_buffer.append_character ('%'')
			
when 192 then
--|#line 1020 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1020")
end

				current_position.go_to (2)
				token_buffer.append_character ('%"')
			
when 193 then
--|#line 1024 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1024")
end

				current_position.go_to (2)
				token_buffer.append_character ('%(')
			
when 194 then
--|#line 1028 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1028")
end

				current_position.go_to (2)
				token_buffer.append_character ('%)')
			
when 195 then
--|#line 1032 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1032")
end

				current_position.go_to (2)
				token_buffer.append_character ('%<')
			
when 196 then
--|#line 1036 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1036")
end

				current_position.go_to (2)
				token_buffer.append_character ('%>')
			
when 197 then
--|#line 1040 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1040")
end

				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 198 then
--|#line 1044 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1044")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.reset_column_positions	
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			
when 199 then
--|#line 1052 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1052")
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
			
when 200 then
--|#line 1065 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1065")
end

					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 201 then
--|#line 1071 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1071")
end

					-- No final double-quote.
				line_number := line_number + 1
				current_position.reset_column_positions	
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 202 then
--|#line 1098 "eiffel.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel.l' at line 1098")
end

				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			
when 203 then
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
			   28,   29,   30,   30,   30,   30,   31,   32,   33,   34,
			   35,   36,   17,   37,   38,   39,   40,   41,   42,   43,
			   43,   44,   43,   43,   45,   43,   46,   47,   48,   43,
			   49,   50,   51,   52,   53,   54,   55,   43,   43,   56,
			   57,   58,   59,   12,   12,   37,   38,   39,   40,   41,
			   42,   43,   43,   44,   43,   43,   45,   43,   46,   47,
			   48,   43,   49,   50,   51,   52,   53,   54,   55,   43,
			   43,   60,   17,   61,   62,   64,   64,  189,   65,   65,

			  190,   66,   66,   68,   69,   68,  144,   70,   68,   69,
			   68,  100,   70,   75,   76,   75,   75,   76,   75,   77,
			   98,   77,   99,  102,  101,  103,  103,  103,  103,  103,
			  103,  104,  113,  114,  115,  116,  596,  595,  144,  151,
			  106,  105,  107,  107,  108,  108,  108,  108,  106,  573,
			  107,  107,  108,  108,  108,  108,  109,  156,   77,  123,
			   77,  410,   71,  476,  109,  124,  157,   71,   80,   81,
			  160,  151,   81,  130,  154,  119,   82,   83,  110,   84,
			  120,   85,  121,  131,  155,  111,  198,  122,  109,  156,
			   86,  123,   87,  111,   81,   88,  109,  124,  157,  196,

			  197,  196,  160,   89,  471,  130,  154,  119,   90,   91,
			  110,  344,  120,  343,  121,  131,  155,  189,   92,  122,
			  193,   93,   94,  188,   95,  342,  106,   88,  108,  108,
			  108,  108,  108,  108,  132,   89,  133,  341,  125,   93,
			   90,   91,  126,  135,  152,  127,  134,  136,  128,  138,
			   92,  129,  142,  145,   81,  253,  139,  140,  143,  153,
			  137,  149,  141,  146,  150,  147,  132,  482,  133,  148,
			  125,  111,  158,  159,  126,  135,  152,  127,  134,  136,
			  128,  138,  201,  129,  142,  145,  340,  253,  139,  140,
			  143,  153,  137,  149,  141,  146,  150,  147,  202,  203,

			  189,  148,  339,  190,  158,  159,  165,  165,  165,  218,
			  166,  338,  111,  167,  337,  168,  169,  170,  191,  189,
			  191,  198,  190,  171,   79,   79,  206,   79,  204,  199,
			  198,  198,  172,  336,  173,   93,  208,  174,  175,  176,
			  177,  205,  178,  198,  179,  198,  198,  335,  180,  207,
			  181,   93,   93,  182,  183,  184,  185,  186,  187,  209,
			  256,  210,   93,  215,  216,  215,  334,  198,  333,  211,
			  257,  258,  212,  332,   93,  331,  330,  192,  329,   93,
			  327,   93,  200,   93,   93,  261,  214,  213,  326,   93,
			  325,  262,  256,  210,  324,  323,   93,  263,   93,   93,

			  217,  211,  257,  258,  212,  244,  244,  244,  244,  244,
			  244,  252,  252,  252,  252,  252,  252,  261,  214,  213,
			   93,  221,  245,  262,  222,  264,  223,  224,  225,  263,
			  267,  268,  195,  246,  226,  247,  247,  247,  247,  247,
			  247,  189,  164,  227,  193,  228,  243,  188,  229,  230,
			  231,  232,  248,  233,  245,  234,  313,  264,  220,  235,
			   78,  236,  267,  268,  237,  238,  239,  240,  241,  242,
			  106,  273,  249,  249,  250,  250,  250,  250,  254,  269,
			  274,  255,  275,  195,  248,  106,  109,  250,  250,  250,
			  250,  250,  250,  259,  270,  265,  271,  260,  164,  266,

			  272,  276,  283,  273,  277,  284,  278,  288,  279,   93,
			  254,  269,  274,  255,  275,  111,  289,  285,  109,  280,
			  281,  290,  282,  291,  292,  259,  270,  265,  271,  260,
			  111,  266,  272,  276,  283,  286,  277,  284,  278,  288,
			  279,  287,  299,  301,  293,  302,  300,  294,  289,  285,
			  303,  280,  281,  290,  282,  291,  292,  295,  307,  308,
			  296,  309,  297,  298,  304,  310,  314,  286,  315,  305,
			  196,  197,  196,  287,  299,  301,  293,  302,  300,  294,
			  306,  198,  303,  312,  312,  312,  312,  312,  312,  295,
			  307,  308,  296,  309,  297,  298,  304,  310,  165,  165,

			  165,  305,  191,  189,  191,  311,  190,  198,   79,  215,
			  216,  215,  306,  199,  198,  322,  319,  198,  320,   93,
			  355,   93,  356,  317,  215,  216,  215,  357,  198,  251,
			  251,  251,  358,  359,   93,  162,  161,  316,  328,  328,
			  328,  328,  328,  328,  360,  345,  345,  345,  345,  345,
			  345,  117,  355,  112,  356,  317,  361,  362,  321,  357,
			   93,  192,  245,  318,  358,  359,  200,   93,   93,  316,
			   93,   93,   78,  363,  364,  602,  360,  346,   73,  346,
			   73,   93,  347,  347,  347,  347,  347,  347,  361,  362,
			  321,  365,  602,  602,  245,  318,  348,  348,  348,  348,

			  348,  348,  350,  602,  350,  363,  364,  351,  351,  351,
			  351,  351,  351,  349,  106,  366,  352,  352,  353,  353,
			  353,  353,  106,  365,  353,  353,  353,  353,  353,  353,
			  109,  354,  354,  354,  354,  354,  354,  367,  368,  369,
			  371,  372,  373,  374,  376,  349,  377,  366,  378,  379,
			  380,  381,  382,  370,  383,  384,  375,  385,  386,  111,
			  387,  388,  109,  389,  392,  390,  393,  111,  391,  367,
			  368,  369,  371,  372,  373,  374,  376,  394,  377,  395,
			  378,  379,  380,  381,  382,  370,  383,  384,  375,  385,
			  386,  398,  387,  388,  396,  389,  392,  390,  393,  399,

			  391,  400,  401,  402,  403,  404,  405,  406,  407,  394,
			  408,  395,  397,  409,  410,  411,  411,  411,  411,  411,
			  411,  198,  412,  398,  413,  415,  396,  198,  417,  426,
			  602,  399,  602,  400,  401,  402,  403,  404,  405,  406,
			  407,  602,  408,  427,  397,  409,  418,  328,  328,  328,
			  328,  328,  328,  582,  583,  602,  428,  429,  416,  414,
			  602,  426,  419,  419,  419,  419,  419,  419,  347,  347,
			  347,  347,  347,  347,   93,  427,  602,   93,   93,  245,
			   93,   93,  347,  347,  347,  347,  347,  347,  428,  429,
			  416,  414,  421,  421,  421,  421,  421,  421,  351,  351,

			  351,  351,  351,  351,  602,  420,   93,   93,  422,  349,
			  422,  245,  430,  423,  423,  423,  423,  423,  423,  351,
			  351,  351,  351,  351,  351,  431,  424,  432,  352,  352,
			  353,  353,  353,  353,  425,  425,  425,  425,  425,  425,
			  433,  349,  109,  424,  430,  353,  353,  353,  353,  353,
			  353,  434,  435,  436,  437,  438,  439,  431,  440,  432,
			  441,  442,  443,  444,  445,  446,  447,  448,  449,  450,
			  451,  452,  433,  453,  109,  454,  455,  456,  457,  458,
			  459,  460,  461,  434,  435,  436,  437,  438,  439,  462,
			  440,  463,  441,  442,  443,  444,  445,  446,  447,  448,

			  449,  450,  451,  452,  464,  453,  465,  454,  455,  456,
			  457,  458,  459,  460,  461,  466,  467,  468,  469,  470,
			  198,  462,  198,  463,  410,  472,  472,  472,  472,  472,
			  472,  198,  483,  484,  602,  485,  464,  602,  465,  419,
			  419,  419,  419,  419,  419,  602,  594,  466,  467,  468,
			  469,  470,  602,  488,  602,  489,  477,  474,  478,  478,
			  478,  478,  478,  478,  483,  484,  473,  485,  490,  475,
			  602,  602,  602,   93,  602,   93,  479,  479,  479,  479,
			  479,  479,  486,  491,   93,  488,  487,  489,  477,  474,
			  492,  493,  588,  349,  602,  589,  590,  602,  473,   93,

			  490,  475,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  486,  491,  494,  495,  487,  480,
			  496,  497,  492,  493,  246,  349,  479,  479,  479,  479,
			  479,  479,  498,  499,  500,  501,  502,  503,  504,  505,
			  506,  507,  508,  481,  509,  510,  511,  512,  494,  495,
			  513,  514,  496,  497,  515,  516,  517,  518,  198,  198,
			  198,  602,  531,  532,  498,  499,  500,  501,  502,  503,
			  504,  505,  506,  507,  508,  481,  509,  510,  511,  512,
			  602,  602,  513,  514,  602,  602,  515,  516,  517,  518,
			  520,  522,  519,  522,  531,  532,  523,  523,  523,  523,

			  523,  523,  533,  534,  535,  521,  536,  537,  538,  539,
			  602,   93,   93,   93,  524,  524,  524,  524,  524,  524,
			  540,  541,  520,  602,  519,  479,  479,  479,  479,  479,
			  479,  525,  602,  602,  533,  534,  535,  521,  536,  537,
			  538,  539,  526,  527,  527,  527,  527,  527,  527,  528,
			  542,  528,  540,  541,  529,  529,  529,  529,  529,  529,
			  543,  544,  545,  525,  527,  527,  527,  527,  527,  527,
			  546,  547,  548,  549,  526,  550,  551,  552,  553,  554,
			  198,  530,  542,  198,  198,  523,  523,  523,  523,  523,
			  523,  567,  543,  544,  545,  523,  523,  523,  523,  523,

			  523,  602,  546,  547,  548,  549,  568,  550,  551,  552,
			  553,  554,  602,  530,  555,  557,  602,  558,  558,  558,
			  558,  558,  558,  567,  602,  556,  569,  563,  563,  563,
			  563,  563,  563,   93,  525,  602,   93,   93,  568,  602,
			  602,  570,  571,  559,  564,  559,  555,  557,  560,  560,
			  560,  560,  560,  560,  561,  572,  561,  556,  569,  562,
			  562,  562,  562,  562,  562,  574,  525,  529,  529,  529,
			  529,  529,  529,  570,  571,  575,  564,  529,  529,  529,
			  529,  529,  529,  565,  576,  565,  577,  572,  566,  566,
			  566,  566,  566,  566,  578,  579,  580,  574,  198,  525,

			  560,  560,  560,  560,  560,  560,  602,  575,  560,  560,
			  560,  560,  560,  560,  602,  602,  576,  602,  577,  562,
			  562,  562,  562,  562,  562,  420,  578,  579,  580,  602,
			  602,  525,  562,  562,  562,  562,  562,  562,  581,  584,
			  584,  584,  584,  584,  584,  566,  566,  566,  566,  566,
			  566,   93,  585,  587,  585,  591,  564,  586,  586,  586,
			  586,  586,  586,  566,  566,  566,  566,  566,  566,  592,
			  581,  593,  564,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  586,  586,  586,  587,  597,  591,  564,  598,
			  599,  600,  601,  602,  602,  602,  602,  602,  480,  602,

			  602,  592,  602,  593,  564,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  597,  602,
			  602,  598,  599,  600,  601,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   79,  602,   79,  602,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   96,  602,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   97,  602,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,

			   97,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  163,  602,  163,  602,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  188,  188,  188,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  194,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  194,   81,  602,   81,  602,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,  219,  602,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  100,  602,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,   11,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602>>)
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
			    1,    1,    1,    1,    1,    3,    4,   67,    3,    4,

			   67,    3,    4,    5,    5,    5,   46,    5,    6,    6,
			    6,   25,    6,    9,    9,    9,   10,   10,   10,   13,
			   19,   13,   19,   26,   25,   26,   26,   26,   26,   26,
			   26,   27,   33,   33,   35,   35,  589,  588,   46,   49,
			   28,   27,   28,   28,   28,   28,   28,   28,   29,  544,
			   29,   29,   29,   29,   29,   29,   28,   52,   77,   38,
			   77,  472,    5,  418,   29,   38,   53,    6,   16,   16,
			   55,   49,   16,   40,   51,   37,   16,   16,   28,   16,
			   37,   16,   37,   40,   51,   28,   79,   37,   28,   52,
			   16,   38,   16,   29,   16,   16,   29,   38,   53,   75,

			   75,   75,   55,   16,  409,   40,   51,   37,   16,   16,
			   28,  242,   37,  241,   37,   40,   51,   71,   16,   37,
			   71,   16,   16,   71,   16,  240,   30,   16,   30,   30,
			   30,   30,   30,   30,   41,   16,   41,  239,   39,   79,
			   16,   16,   39,   42,   50,   39,   41,   42,   39,   44,
			   16,   39,   45,   47,   16,  119,   44,   44,   45,   50,
			   42,   48,   44,   47,   48,   47,   41,  425,   41,   47,
			   39,   30,   54,   54,   39,   42,   50,   39,   41,   42,
			   39,   44,   82,   39,   45,   47,  238,  119,   44,   44,
			   45,   50,   42,   48,   44,   47,   48,   47,   83,   84,

			  188,   47,  237,  188,   54,   54,   66,   66,   66,   95,
			   66,  236,  425,   66,  235,   66,   66,   66,   68,   68,
			   68,   88,   68,   66,   81,   81,   86,   81,   85,   81,
			   89,   90,   66,  234,   66,   82,   87,   66,   66,   66,
			   66,   85,   66,   91,   66,   92,   94,  233,   66,   86,
			   66,   83,   84,   66,   66,   66,   66,   66,   66,   87,
			  121,   88,   95,   93,   93,   93,  232,   93,  231,   89,
			  123,  124,   90,  230,   88,  229,  228,   68,  227,   86,
			  225,   85,   81,   89,   90,  126,   92,   91,  224,   87,
			  223,  127,  121,   88,  222,  221,   91,  128,   92,   94,

			   94,   89,  123,  124,   90,  103,  103,  103,  103,  103,
			  103,  111,  111,  111,  111,  111,  111,  126,   92,   91,
			   93,   98,  103,  127,   98,  129,   98,   98,   98,  128,
			  131,  132,  194,  106,   98,  106,  106,  106,  106,  106,
			  106,  192,  163,   98,  192,   98,   99,  192,   98,   98,
			   98,   98,  106,   98,  103,   98,  205,  129,   97,   98,
			   78,   98,  131,  132,   98,   98,   98,   98,   98,   98,
			  107,  135,  107,  107,  107,  107,  107,  107,  120,  133,
			  136,  120,  137,   72,  106,  108,  107,  108,  108,  108,
			  108,  108,  108,  125,  133,  130,  134,  125,   63,  130,

			  134,  139,  142,  135,  140,  143,  140,  145,  140,  205,
			  120,  133,  136,  120,  137,  107,  146,  143,  107,  140,
			  140,  147,  140,  149,  150,  125,  133,  130,  134,  125,
			  108,  130,  134,  139,  142,  144,  140,  143,  140,  145,
			  140,  144,  152,  153,  151,  154,  152,  151,  146,  143,
			  155,  140,  140,  147,  140,  149,  150,  151,  157,  158,
			  151,  159,  151,  151,  156,  160,  207,  144,  209,  156,
			  196,  196,  196,  144,  152,  153,  151,  154,  152,  151,
			  156,  211,  155,  171,  171,  171,  171,  171,  171,  151,
			  157,  158,  151,  159,  151,  151,  156,  160,  165,  165,

			  165,  156,  191,  191,  191,  165,  191,  210,  200,  200,
			  200,  200,  156,  200,  214,  217,  213,  212,  213,  207,
			  253,  209,  254,  211,  215,  215,  215,  258,  215,  618,
			  618,  618,  259,  260,  211,   61,   57,  210,  226,  226,
			  226,  226,  226,  226,  261,  244,  244,  244,  244,  244,
			  244,   36,  253,   31,  254,  211,  262,  263,  214,  258,
			  210,  191,  244,  212,  259,  260,  200,  214,  217,  210,
			  212,  213,   14,  264,  265,   11,  261,  245,    8,  245,
			    7,  215,  245,  245,  245,  245,  245,  245,  262,  263,
			  214,  266,    0,    0,  244,  212,  247,  247,  247,  247,

			  247,  247,  248,    0,  248,  264,  265,  248,  248,  248,
			  248,  248,  248,  247,  249,  267,  249,  249,  249,  249,
			  249,  249,  250,  266,  250,  250,  250,  250,  250,  250,
			  249,  252,  252,  252,  252,  252,  252,  268,  270,  271,
			  272,  273,  274,  275,  276,  247,  277,  267,  278,  279,
			  280,  281,  282,  271,  283,  284,  275,  285,  286,  249,
			  288,  290,  249,  291,  293,  292,  294,  250,  292,  268,
			  270,  271,  272,  273,  274,  275,  276,  295,  277,  296,
			  278,  279,  280,  281,  282,  271,  283,  284,  275,  285,
			  286,  298,  288,  290,  297,  291,  293,  292,  294,  299,

			  292,  300,  301,  302,  303,  304,  305,  306,  307,  295,
			  308,  296,  297,  309,  312,  312,  312,  312,  312,  312,
			  312,  317,  316,  298,  316,  318,  297,  319,  321,  355,
			    0,  299,    0,  300,  301,  302,  303,  304,  305,  306,
			  307,    0,  308,  356,  297,  309,  328,  328,  328,  328,
			  328,  328,  328,  556,  557,    0,  357,  358,  319,  317,
			    0,  355,  345,  345,  345,  345,  345,  345,  346,  346,
			  346,  346,  346,  346,  317,  356,    0,  316,  318,  345,
			  319,  321,  347,  347,  347,  347,  347,  347,  357,  358,
			  319,  317,  348,  348,  348,  348,  348,  348,  350,  350,

			  350,  350,  350,  350,    0,  345,  556,  557,  349,  348,
			  349,  345,  359,  349,  349,  349,  349,  349,  349,  351,
			  351,  351,  351,  351,  351,  360,  352,  361,  352,  352,
			  352,  352,  352,  352,  354,  354,  354,  354,  354,  354,
			  362,  348,  352,  353,  359,  353,  353,  353,  353,  353,
			  353,  363,  364,  365,  366,  367,  368,  360,  369,  361,
			  370,  371,  372,  373,  375,  376,  377,  378,  379,  380,
			  381,  382,  362,  384,  352,  387,  389,  390,  391,  393,
			  394,  395,  396,  363,  364,  365,  366,  367,  368,  397,
			  369,  398,  370,  371,  372,  373,  375,  376,  377,  378,

			  379,  380,  381,  382,  399,  384,  400,  387,  389,  390,
			  391,  393,  394,  395,  396,  401,  404,  405,  406,  407,
			  412,  397,  414,  398,  411,  411,  411,  411,  411,  411,
			  411,  416,  428,  429,    0,  432,  399,    0,  400,  419,
			  419,  419,  419,  419,  419,    0,  581,  401,  404,  405,
			  406,  407,    0,  434,    0,  436,  419,  414,  420,  420,
			  420,  420,  420,  420,  428,  429,  412,  432,  437,  416,
			    0,    0,    0,  412,    0,  414,  421,  421,  421,  421,
			  421,  421,  433,  438,  416,  434,  433,  436,  419,  414,
			  439,  440,  573,  421,    0,  573,  573,    0,  412,  581,

			  437,  416,  422,  422,  422,  422,  422,  422,  423,  423,
			  423,  423,  423,  423,  433,  438,  441,  442,  433,  421,
			  444,  445,  439,  440,  424,  421,  424,  424,  424,  424,
			  424,  424,  446,  447,  449,  450,  451,  452,  454,  455,
			  456,  457,  458,  424,  459,  460,  461,  462,  441,  442,
			  464,  465,  444,  445,  467,  468,  470,  471,  473,  474,
			  475,    0,  483,  484,  446,  447,  449,  450,  451,  452,
			  454,  455,  456,  457,  458,  424,  459,  460,  461,  462,
			    0,    0,  464,  465,    0,    0,  467,  468,  470,  471,
			  474,  477,  473,  477,  483,  484,  477,  477,  477,  477,

			  477,  477,  485,  487,  488,  475,  489,  493,  495,  496,
			    0,  473,  474,  475,  478,  478,  478,  478,  478,  478,
			  498,  499,  474,    0,  473,  479,  479,  479,  479,  479,
			  479,  478,    0,    0,  485,  487,  488,  475,  489,  493,
			  495,  496,  479,  480,  480,  480,  480,  480,  480,  481,
			  500,  481,  498,  499,  481,  481,  481,  481,  481,  481,
			  501,  502,  503,  478,  482,  482,  482,  482,  482,  482,
			  504,  505,  506,  508,  479,  510,  514,  515,  517,  518,
			  520,  482,  500,  519,  521,  522,  522,  522,  522,  522,
			  522,  532,  501,  502,  503,  523,  523,  523,  523,  523,

			  523,    0,  504,  505,  506,  508,  534,  510,  514,  515,
			  517,  518,    0,  482,  519,  521,    0,  524,  524,  524,
			  524,  524,  524,  532,    0,  520,  536,  527,  527,  527,
			  527,  527,  527,  520,  524,    0,  519,  521,  534,    0,
			    0,  537,  538,  525,  527,  525,  519,  521,  525,  525,
			  525,  525,  525,  525,  526,  541,  526,  520,  536,  526,
			  526,  526,  526,  526,  526,  545,  524,  528,  528,  528,
			  528,  528,  528,  537,  538,  546,  527,  529,  529,  529,
			  529,  529,  529,  530,  548,  530,  549,  541,  530,  530,
			  530,  530,  530,  530,  551,  552,  554,  545,  555,  558,

			  559,  559,  559,  559,  559,  559,    0,  546,  560,  560,
			  560,  560,  560,  560,    0,    0,  548,    0,  549,  561,
			  561,  561,  561,  561,  561,  558,  551,  552,  554,    0,
			    0,  558,  562,  562,  562,  562,  562,  562,  555,  563,
			  563,  563,  563,  563,  563,  565,  565,  565,  565,  565,
			  565,  555,  564,  567,  564,  574,  563,  564,  564,  564,
			  564,  564,  564,  566,  566,  566,  566,  566,  566,  576,
			  555,  580,  584,  585,  585,  585,  585,  585,  585,  586,
			  586,  586,  586,  586,  586,  567,  593,  574,  563,  597,
			  598,  599,  600,    0,    0,    0,    0,    0,  584,    0,

			    0,  576,    0,  580,  584,  603,  603,  603,  603,  603,
			  603,  603,  603,  603,  603,  603,  603,  603,  593,    0,
			    0,  597,  598,  599,  600,  604,  604,  604,  604,  604,
			  604,  604,  604,  604,  604,  604,  604,  604,  605,  605,
			  605,  605,  605,  605,  605,  605,  605,  605,  605,  605,
			  605,  606,  606,  606,  606,  606,  606,  606,  606,  606,
			  606,  606,  606,  606,  607,    0,  607,    0,  607,  607,
			  607,  607,  607,  607,  607,  607,  607,  608,    0,  608,
			  608,  608,  608,  608,  608,  608,  608,  608,  609,    0,
			  609,  609,  609,  609,  609,  609,  609,  609,  609,  609,

			  609,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  611,    0,  611,    0,  611,  611,  611,  611,  611,  611,
			  611,  611,  611,  612,  612,  612,  612,  612,  612,  612,
			  612,  612,  612,  612,  612,  612,  613,  613,  613,  613,
			  613,  613,  613,  613,  613,  613,  613,  613,  613,  614,
			  614,  614,  614,  614,  614,  614,  614,  614,  614,  614,
			  614,  614,  615,    0,  615,    0,  615,  615,  615,  615,
			  615,  615,  615,  615,  615,  616,    0,  616,  616,  616,
			  616,  616,  616,  616,  616,  616,  616,  616,  617,    0,
			  617,  617,  617,  617,  617,  617,  617,  617,  617,  617,

			  617,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   92,   93,  101,  106,  677,  675,  111,
			  114,  675, 1701,  117,  669, 1701,  162,    0, 1701,  111,
			 1701, 1701, 1701, 1701, 1701,   94,  105,  112,  122,  130,
			  208,  624, 1701,  104, 1701,  105,  622,  136,  118,  198,
			  136,  190,  210,    0,  211,  211,   59,  219,  214,  102,
			  207,  134,  111,  133,  232,  123, 1701,  576, 1701, 1701,
			 1701,  541, 1701,  492, 1701, 1701,  304,   94,  316, 1701,
			 1701,  214,  480, 1701, 1701,  197, 1701,  156,  457,  180,
			 1701,  323,  276,  292,  293,  322,  320,  330,  315,  324,
			  325,  337,  339,  361,  340,  303,    0,  447,  415,  435,

			    0, 1701, 1701,  385, 1701, 1701,  415,  452,  467, 1701,
			    0,  391, 1701, 1701, 1701, 1701, 1701, 1701,    0,  218,
			  437,  324,    0,  318,  324,  460,  352,  345,  360,  375,
			  461,  377,  380,  443,  448,  427,  447,  435,    0,  453,
			  468,    0,  459,  470,  489,  456,  480,  486,    0,  482,
			  487,  511,  498,  493,  508,  497,  528,  508,  522,  525,
			  515, 1701, 1701,  436, 1701,  596, 1701, 1701, 1701, 1701,
			 1701,  563, 1701, 1701, 1701, 1701, 1701, 1701, 1701, 1701,
			 1701, 1701, 1701, 1701, 1701, 1701, 1701, 1701,  297, 1701,
			 1701,  600,  438, 1701,  429, 1701,  568, 1701, 1701, 1701,

			  607, 1701, 1701, 1701, 1701,  450, 1701,  560, 1701,  562,
			  601,  575,  611,  612,  608,  622, 1701,  609, 1701, 1701,
			 1701,  384,  383,  379,  377,  369,  618,  367,  365,  364,
			  362,  357,  355,  336,  322,  303,  300,  291,  275,  226,
			  214,  202,  200, 1701,  625,  662, 1701,  676,  687,  696,
			  704,    0,  711,  574,  589,    0,    0,    0,  583,  582,
			  598,  593,  602,  624,  623,  621,  654,  681,  700,    0,
			  685,  706,  703,  690,  690,  698,  700,  709,  707,  712,
			  702,  714,  719,  717,  722,  709,  721,    0,  713,    0,
			  724,  717,  730,  720,  729,  744,  726,  759,  741,  762,

			  768,  761,  757,  767,  768,  757,  766,  767,  764,  776,
			    0, 1701,  795, 1701, 1701, 1701,  818,  815,  819,  821,
			 1701,  822, 1701, 1701, 1701, 1701, 1701, 1701,  827, 1701,
			 1701, 1701, 1701, 1701, 1701, 1701, 1701, 1701, 1701, 1701,
			 1701, 1701, 1701, 1701, 1701,  842,  848,  862,  872,  893,
			  878,  899,  908,  925,  914,  777,  792,  819,  824,  869,
			  874,  890,  888,  914,  913,  903,  910,  914,  906,  912,
			  910,  911,  925,  910,    0,  927,  924,  910,  911,  918,
			  932,  931,  921,    0,  929,    0,    0,  931,    0,  924,
			  924,  937,    0,  941,  935,  940,  929,  945,  934,  969,

			  956,  967,    0,    0,  978,  964,  974,  986,    0,  141,
			 1701, 1005, 1014, 1701, 1016, 1701, 1025, 1701,  152, 1019,
			 1038, 1056, 1082, 1088, 1106,  249,    0,    0,  999,  998,
			    0,    0,  985, 1045, 1007,    0, 1005, 1031, 1045, 1053,
			 1055, 1064, 1071,    0, 1070, 1075, 1095, 1092,    0, 1093,
			 1100, 1099, 1096,    0, 1101, 1102, 1090, 1085, 1101, 1107,
			 1095, 1109, 1095,    0, 1098, 1118,    0, 1113, 1118,    0,
			 1110, 1122,  142, 1152, 1153, 1154, 1701, 1176, 1194, 1205,
			 1223, 1234, 1244, 1116, 1111, 1150,    0, 1156, 1152, 1169,
			    0,    0,    0, 1170,    0, 1175, 1172,    0, 1169, 1175,

			 1198, 1208, 1211, 1229, 1218, 1221, 1221,    0, 1227,    0,
			 1238,    0,    0,    0, 1224, 1231,    0, 1226, 1239, 1277,
			 1274, 1278, 1265, 1275, 1297, 1328, 1339, 1307, 1347, 1357,
			 1368,    0, 1254,    0, 1260,    0, 1290, 1305, 1298,    0,
			    0, 1316,    0,    0,   86, 1319, 1338,    0, 1337, 1349,
			    0, 1357, 1358,    0, 1363, 1392,  847,  848, 1362, 1380,
			 1388, 1399, 1412, 1419, 1437, 1425, 1443, 1403,    0,    0,
			    0,    0,    0, 1071, 1403,    0, 1419,    0,    0,    0,
			 1421, 1040, 1701, 1701, 1435, 1453, 1459,    0,  113,  113,
			    0,    0,    0, 1453, 1701,    0,    0, 1454, 1438, 1454,

			 1442,    0, 1701, 1504, 1524, 1537, 1550, 1563, 1574, 1587,
			 1596, 1609, 1622, 1635, 1648, 1661, 1674, 1687,  624>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  602,    1,  603,  603,  604,  604,  605,  605,  606,
			  606,  602,  602,  602,  602,  602,  607,  608,  602,  609,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  602,  602,  602,  602,
			  602,  602,  602,  611,  602,  602,  602,  612,  612,  602,
			  602,  613,  614,  602,  602,  602,  602,  602,  602,  607,
			  602,  615,  607,  607,  607,  607,  607,  607,  607,  607,
			  607,  607,  607,  607,  607,  607,  608,  616,  616,  616,

			  617,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  618,  602,  602,  602,  602,  602,  602,  602,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  602,  602,  611,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  612,  602,
			  602,  612,  613,  602,  614,  602,  602,  602,  602,  602,

			  615,  602,  602,  602,  602,  607,  602,  607,  602,  607,
			  607,  607,  607,  607,  607,  607,  602,  607,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  618,  602,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,

			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  602,  602,  602,  602,  602,  607,  607,  607,  607,
			  602,  607,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,

			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  602,  602,  607,  602,  607,  602,  607,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  602,  607,  607,  607,  602,  602,  602,  602,
			  602,  602,  602,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,

			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  607,
			  607,  607,  602,  602,  602,  602,  602,  602,  602,  602,
			  602,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  610,  610,  610,  610,  607,  607,  607,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  610,  610,  610,
			  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,
			  610,  607,  602,  602,  602,  602,  602,  610,  610,  610,
			  610,  610,  610,  610,  602,  610,  610,  610,  610,  610,

			  610,  610,    0,  602,  602,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  602>>)
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
			   22,   22,   23,   22,   24,   22,   25,   22,   26,   27,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   43,   44,   45,   46,   47,
			   48,   49,   50,   51,   52,   53,   54,   55,   56,   57,
			   58,   59,   60,   61,   62,   63,   64,   65,   66,   67,

			   68,   69,   70,   71,   72,   73,   74,   75,   76,   77,
			   78,   79,   80,   81,   82,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,    1,    1,    1,
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
			    5,    5,    5,    5,    6,    7,    3,    3,    3,    3,
			    3,    3,    3,    5,    5,    5,    5,    5,    5,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    9,   10,    3,
			    3,    3,    3,   11,    3,    5,    5,    5,    5,    5,
			    5,    8,    8,    8,    8,    8,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,   12,
			   13,    3,    3,    3,    3>>)
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
			  276,  277,  278,  279,  280,  281,  281,  282,  283,  284,
			  285,  286,  286,  287,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  306,  307,  309,  310,  311,  311,  312,  313,

			  315,  317,  319,  321,  323,  325,  326,  328,  329,  331,
			  332,  333,  334,  335,  336,  337,  338,  339,  340,  342,
			  343,  345,  346,  347,  348,  349,  350,  351,  352,  353,
			  354,  355,  356,  357,  358,  359,  360,  361,  362,  363,
			  364,  365,  366,  367,  369,  370,  370,  371,  372,  372,
			  374,  376,  377,  377,  378,  379,  381,  383,  385,  386,
			  387,  388,  389,  390,  391,  392,  393,  394,  395,  396,
			  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,
			  408,  409,  410,  411,  412,  413,  414,  415,  417,  418,
			  420,  421,  422,  423,  424,  425,  426,  427,  428,  429,

			  430,  431,  432,  433,  434,  435,  436,  437,  438,  439,
			  440,  442,  443,  443,  445,  447,  449,  450,  451,  452,
			  453,  455,  456,  458,  459,  460,  461,  462,  463,  464,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  474,
			  475,  476,  477,  478,  479,  480,  481,  481,  482,  483,
			  483,  483,  484,  485,  486,  486,  487,  488,  489,  490,
			  491,  492,  493,  494,  495,  496,  497,  498,  500,  501,
			  502,  503,  504,  505,  506,  508,  509,  510,  511,  512,
			  513,  514,  515,  516,  518,  519,  521,  523,  524,  526,
			  527,  528,  529,  531,  532,  533,  534,  535,  536,  537,

			  538,  539,  540,  542,  544,  545,  546,  547,  548,  550,
			  551,  552,  552,  553,  555,  556,  558,  559,  561,  562,
			  563,  563,  564,  564,  565,  566,  567,  569,  571,  572,
			  573,  575,  577,  578,  579,  580,  582,  583,  584,  585,
			  586,  587,  588,  589,  591,  592,  593,  594,  595,  597,
			  598,  599,  600,  601,  603,  604,  605,  606,  607,  608,
			  609,  610,  611,  612,  614,  615,  616,  618,  619,  620,
			  622,  623,  624,  624,  625,  626,  627,  628,  628,  629,
			  630,  630,  630,  631,  632,  633,  634,  636,  637,  638,
			  639,  641,  643,  645,  646,  648,  649,  650,  652,  653,

			  654,  655,  656,  657,  658,  659,  660,  661,  663,  664,
			  666,  667,  669,  671,  673,  674,  675,  677,  678,  679,
			  680,  681,  682,  682,  683,  684,  684,  684,  685,  685,
			  686,  686,  688,  689,  691,  692,  694,  695,  696,  697,
			  699,  701,  702,  704,  706,  708,  709,  710,  712,  713,
			  714,  716,  717,  718,  720,  721,  722,  723,  724,  725,
			  725,  726,  726,  727,  728,  728,  728,  729,  730,  732,
			  734,  736,  738,  740,  741,  742,  744,  745,  747,  749,
			  751,  752,  753,  755,  757,  758,  758,  759,  761,  762,
			  763,  765,  767,  769,  770,  772,  774,  776,  777,  778,

			  779,  780,  782,  782>>)
		end

	yy_acclist_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  171,  171,  173,  173,  204,  202,  203,    2,  202,
			  203,    3,  203,   33,  202,  203,  174,  202,  203,   38,
			  202,  203,   12,  202,  203,  142,  202,  203,   21,  202,
			  203,   22,  202,  203,   29,  202,  203,   27,  202,  203,
			    6,  202,  203,   28,  202,  203,   11,  202,  203,   30,
			  202,  203,  113,  115,  202,  203,  113,  115,  202,  203,
			  113,  115,  202,  203,    5,  202,  203,    4,  202,  203,
			   16,  202,  203,   15,  202,  203,   17,  202,  203,    8,
			  202,  203,  111,  202,  203,  111,  202,  203,  111,  202,
			  203,  111,  202,  203,  111,  202,  203,  111,  202,  203,

			  111,  202,  203,  111,  202,  203,  111,  202,  203,  111,
			  202,  203,  111,  202,  203,  111,  202,  203,  111,  202,
			  203,  111,  202,  203,  111,  202,  203,  111,  202,  203,
			  111,  202,  203,  111,  202,  203,  111,  202,  203,   25,
			  202,  203,  202,  203,   26,  202,  203,   31,  202,  203,
			   23,  202,  203,   24,  202,  203,    9,  202,  203,  175,
			  203,  201,  203,  199,  203,  200,  203,  171,  203,  171,
			  203,  170,  203,  169,  203,  171,  203,  173,  203,  172,
			  203,  167,  203,  167,  203,  166,  203,    2,    3,  174,
			  163,  174,  174,  174,  174,  174,  174,  174,  174,  174,

			  174,  174,  174,  174, -368,  174,  174,   38,  142,  142,
			  142,    1,   32,    7,  117,   36,   20,  117,  113,  115,
			  113,  115,  112,   13,   34,   18,   19,   35,   14,  111,
			  111,  111,  111,   43,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,   53,  111,  111,  111,  111,  111,  111,
			  111,   65,  111,  111,  111,   72,  111,  111,  111,  111,
			  111,  111,  111,   80,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,   37,   10,  175,
			  199,  192,  190,  191,  193,  194,  195,  196,  176,  177,
			  178,  179,  180,  181,  182,  183,  184,  185,  186,  187,

			  188,  189,  171,  170,  169,  171,  171,  168,  169,  173,
			  172,  166,  164,  162,  164,  174, -368,  150,  164,  148,
			  164,  149,  164,  151,  164,  174,  144,  164,  174,  145,
			  164,  174,  174,  174,  174,  174,  174,  174, -165,  174,
			  152,  164,  142,  118,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  119,  142,  117,
			  114,  117,  113,  115,  113,  115,  116,  111,  111,   41,
			  111,   42,  111,   44,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,   56,  111,  111,  111,

			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,   76,  111,  111,   78,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			   99,  111,  198,  153,  164,  146,  164,  147,  164,  174,
			  174,  174,  174,  159,  164,  174,  154,  164,  136,  134,
			  135,  137,  138,  143,  139,  140,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  117,  117,  117,  117,  113,  113,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,   54,  111,

			  111,  111,  111,  111,  111,  111,   63,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,   73,  111,  111,   75,
			  111,  107,  111,  111,   79,  111,  111,  111,  111,  109,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			   92,  111,   93,  111,  111,  111,  111,  111,   98,  111,
			  111,  197,  174,  155,  164,  174,  158,  164,  174,  161,
			  164,  143,  117,  117,  117,  117,  115,   39,  111,   40,
			  111,  111,  111,   45,  111,   46,  111,  111,  111,  111,
			   51,  111,  111,  111,  111,  111,  111,  111,  111,   61,
			  111,  111,  111,  111,  111,   68,  111,  111,  111,  111,

			  111,   74,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,   88,  111,  111,  111,   91,  111,  111,  111,
			   96,  111,  111,  111,  174,  174,  174,  141,  117,  117,
			  117,  111,  111,  111,   48,  111,  111,  111,  111,  102,
			  111,   55,  111,   57,  111,  111,   59,  111,  111,  111,
			   64,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,   82,  111,  111,   84,  111,  111,   86,  111,   87,
			  111,   89,  111,  111,  111,   95,  111,  111,  111,  174,
			  174,  174,  117,  117,  117,  117,  100,  111,  111,   47,
			  111,  111,   50,  111,  111,  111,  111,   62,  111,   66,

			  111,  111,   69,  111,   70,  111,  105,  111,  111,  111,
			  108,  111,  111,  111,   85,  111,  111,  111,   97,  111,
			  111,  174,  174,  174,  117,  117,  117,  117,  117,  111,
			   49,  111,   52,  111,   58,  111,   60,  111,   67,  111,
			  111,  111,   77,  111,  111,   83,  111,   90,  111,   94,
			  111,  111,  174,  157,  164,  160,  164,  117,  117,  101,
			  111,  111,  111,  103,  111,   71,  111,   81,  111,  111,
			  156,  164,  104,  111,  106,  111,  111,  111,  111,  111,
			  110,  111>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1701
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 602
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 603
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

	yyNb_rules: INTEGER is 203
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 204
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
