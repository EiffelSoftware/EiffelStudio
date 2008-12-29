note

	description: "Scanners for Lace parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LACE_SCANNER

inherit

	LACE_SCANNER_SKELETON

create

	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= IN_STR)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 33 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 33")
end

				if {PLATFORM}.is_windows then
					comments.append (text_substring (1, text_count - 1) + "%N")
				else
					comments.append (text_substring (1, text_count) + "%N")
				end
			
when 2 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 43 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 43")
end

when 3 then
yy_set_line (0)
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 44 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 44")
end

when 4 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 49 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 49")
end

				last_token := LAC_SEMICOLON
			
when 5 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 52 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 52")
end

				last_token := LAC_COLON
			
when 6 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 55 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 55")
end

				last_token := LAC_COMMA
			
when 7 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 58 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 58")
end

				last_token := LAC_LEFT_PARAM
			
when 8 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 61 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 61")
end

				last_token := LAC_RIGHT_PARAM
			
when 9 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 68 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 68")
end

				last_token := LAC_ADAPT
			
when 10 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 71 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 71")
end

				last_token := LAC_ALL
			
when 11 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 74 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 74")
end

				last_token := LAC_AS
			
when 12 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 77 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 77")
end

				last_token := LAC_ASSEMBLY
			
when 13 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 80 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 80")
end

				last_token := LAC_ASSERTION
			
when 14 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 83 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 83")
end

				last_token := LAC_CHECK
			
when 15 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 86 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 86")
end

				last_token := LAC_CLUSTER
			
when 16 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 89 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 89")
end

				last_token := LAC_CREATION
			
when 17 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 92 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 92")
end

				last_token := LAC_CREATION
			
when 18 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 95 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 95")
end

				last_token := LAC_DEBUG
			
when 19 then
	yy_column := yy_column + 14
	yy_position := yy_position + 14
--|#line 98 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 98")
end

				last_token := LAC_DISABLED_DEBUG
			
when 20 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 101 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 101")
end

				last_token := LAC_DEFAULT
			
when 21 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 104 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 104")
end

				last_token := LAC_END
			
when 22 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 107 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 107")
end

				last_token := LAC_ENSURE
			
when 23 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 110 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 110")
end

				last_token := LAC_EXCLUDE
			
when 24 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 113 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 113")
end

				last_token := LAC_DEPEND
			
when 25 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 116 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 116")
end

				last_token := LAC_EXPORT
			
when 26 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 119 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 119")
end

				last_token := LAC_EXTERNAL
			
when 27 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 122 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 122")
end

				last_token := LAC_GENERATE
			
when 28 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 126 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 126")
end

				last_token := LAC_IGNORE
			
when 29 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 129 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 129")
end

				last_token := LAC_INCLUDE
			
when 30 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 132 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 132")
end

				last_token := LAC_INVARIANT
			
when 31 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 135 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 135")
end

				last_token := LAC_LIBRARY
			
when 32 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 138 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 138")
end

				last_token := LAC_LOOP
			
when 33 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 141 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 141")
end

				last_token := LAC_NO
			
when 34 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 144 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 144")
end

				last_token := LAC_OPTIMIZE
			
when 35 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 147 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 147")
end

				last_token := LAC_OPTION
			
when 36 then
	yy_column := yy_column + 11
	yy_position := yy_position + 11
--|#line 150 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 150")
end

				last_token := LAC_PRECOMPILED
			
when 37 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 153 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 153")
end

				last_token := LAC_PREFIX
			
when 38 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 156 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 156")
end

				last_token := LAC_RENAME
			
when 39 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 159 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 159")
end

				last_token := LAC_REQUIRE
			
when 40 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 162 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 162")
end

				last_token := LAC_ROOT
			
when 41 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 165 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 165")
end

				last_token := LAC_SYSTEM
			
when 42 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 168 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 168")
end

				last_token := LAC_TRACE
			
when 43 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 171 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 171")
end

				last_token := LAC_USE
			
when 44 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 174 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 174")
end

				last_token := LAC_VISIBLE
			
when 45 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 177 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 177")
end

				last_token := LAC_YES
			
when 46 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 184 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 184")
end

					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := LAC_IDENTIFIER
			
when 47 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 195 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 195")
end

					-- Empty string.
				report_string_empty_error
				last_token := LAC_STRING
			
when 48 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 200 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 200")
end

				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := LAC_STRING
			
when 49 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 205 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 205")
end

				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (IN_STR)
			
when 50 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 213 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 213")
end

				append_text_to_string (token_buffer)
			
when 51 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 216 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 216")
end

				token_buffer.append_character ('%A')
			
when 52 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 219 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 219")
end

				token_buffer.append_character ('%B')
			
when 53 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 222 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 222")
end

				token_buffer.append_character ('%C')
			
when 54 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 225 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 225")
end

				token_buffer.append_character ('%D')
			
when 55 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 228 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 228")
end

				token_buffer.append_character ('%F')
			
when 56 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 231 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 231")
end

				token_buffer.append_character ('%H')
			
when 57 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 234 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 234")
end

				token_buffer.append_character ('%L')
			
when 58 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 237 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 237")
end

				token_buffer.append_character ('%N')
			
when 59 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 240 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 240")
end

				token_buffer.append_character ('%Q')
			
when 60 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 243 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 243")
end

				token_buffer.append_character ('%R')
			
when 61 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 246 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 246")
end

				token_buffer.append_character ('%S')
			
when 62 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 249 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 249")
end

				token_buffer.append_character ('%T')
			
when 63 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 252 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 252")
end

				token_buffer.append_character ('%U')
			
when 64 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 255 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 255")
end

				token_buffer.append_character ('%V')
			
when 65 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 258 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 258")
end

				token_buffer.append_character ('%%')
			
when 66 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 261 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 261")
end

				token_buffer.append_character ('%'')
			
when 67 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 264 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 264")
end

				token_buffer.append_character ('%"')
			
when 68 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 267 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 267")
end

				token_buffer.append_character ('%(')
			
when 69 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 270 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 270")
end

				token_buffer.append_character ('%)')
			
when 70 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 273 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 273")
end

				token_buffer.append_character ('%<')
			
when 71 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 276 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 276")
end

				token_buffer.append_character ('%>')
			
when 72 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 279 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 279")
end

				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			
when 73 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 282 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 282")
end

					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			
when 74 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 286 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 286")
end

				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
					report_string_empty_error
				end
				last_token := LAC_STRING
			
when 75 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 296 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 296")
end

					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			
when 76 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + 1
--|#line 301 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 301")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
when 77 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 319 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 319")
end

				report_unknown_token_error (text_item (1))
			
when 78 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 0 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 0")
end

				terminate
			
when 1 then
--|#line 0 "lace.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lace.l' at line 0")
end

					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    6,    7,    8,    9,    6,    6,   10,   11,   12,
			   13,    6,    6,   14,   15,    6,    6,   16,   17,   18,
			   19,   20,   17,   21,   17,   22,   17,   17,   23,   17,
			   24,   25,   26,   17,   27,   28,   29,   30,   31,   17,
			   32,   17,    6,   16,   17,   18,   19,   20,   17,   21,
			   17,   22,   17,   17,   23,   17,   24,   25,   26,   17,
			   27,   28,   29,   30,   31,   17,   32,   17,   34,   35,
			   36,   34,   35,   36,   43,   46,   49,   51,   53,   47,
			   50,   54,   44,   58,   56,   48,   52,   59,   55,   45,
			   57,   60,   42,   63,   64,   65,   66,   67,   94,   95,

			   43,   46,   49,   51,   53,   47,   50,   54,   44,   58,
			   56,   48,   52,   59,   55,   45,   57,   60,   61,   63,
			   64,   65,   66,   67,   94,   95,   96,   97,   62,   70,
			   70,  237,  125,  155,  156,   39,   98,   99,   39,  103,
			  109,  155,  185,   68,   61,  155,   68,   41,  110,   41,
			   41,  126,   96,   97,   62,   70,   70,   71,   72,   73,
			   74,   75,   98,   99,   76,  103,  109,  106,   77,   78,
			   79,   80,   81,   82,  110,   83,  111,   84,  100,  104,
			  107,   85,  101,   86,  108,  113,   87,   88,   89,   90,
			   91,   92,  102,  106,  105,  112,  114,  115,  116,  119,

			  117,  120,  111,  118,  100,  104,  107,  121,  101,  122,
			  108,  113,  123,  124,  127,  128,  129,  130,  102,  131,
			  105,  112,  114,  115,  116,  119,  117,  120,  132,  118,
			  133,  134,  135,  121,  136,  122,  137,  138,  123,  124,
			  127,  128,  129,  130,  139,  131,  140,  141,  142,  143,
			  144,  145,  146,  149,  132,  150,  133,  134,  135,  151,
			  136,  147,  137,  138,  148,  152,  153,  154,  157,  160,
			  139,  161,  140,  141,  142,  143,  144,  145,  146,  149,
			  162,  150,  163,  158,  164,  151,  165,  147,  159,  166,
			  148,  152,  153,  154,  157,  160,  167,  161,  168,  169,

			  170,  171,  172,  173,  174,  175,  162,  178,  163,  158,
			  164,  176,  165,  177,  159,  166,  179,  180,  181,  182,
			  183,  184,  167,  186,  168,  169,  170,  171,  172,  173,
			  174,  175,  187,  178,  188,  191,  189,  176,  192,  177,
			  190,  193,  179,  180,  181,  182,  183,  184,  194,  186,
			  195,  196,  197,  198,  199,  200,  201,  202,  187,  203,
			  188,  191,  189,  204,  192,  205,  190,  193,  206,  207,
			  208,  209,  210,  211,  194,  212,  195,  196,  197,  198,
			  199,  200,  201,  202,  213,  203,  214,  215,  216,  204,
			  217,  205,  218,  219,  206,  207,  208,  209,  210,  211,

			  220,  212,  221,  222,  223,  224,  225,  226,  227,  228,
			  213,  229,  214,  215,  216,  230,  217,  231,  218,  219,
			  232,  233,  234,  235,  236,  238,  220,  239,  221,  222,
			  223,  224,  225,  226,  227,  228,  240,  229,  241,  242,
			  243,  230,  244,  231,  245,  246,  232,  233,  234,  235,
			  236,  238,   69,  239,   33,   33,   33,   33,   93,   38,
			   37,   69,  240,   41,  241,  242,  243,   40,  244,   38,
			  245,  246,   37,  247,    5,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,

			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    3,    3,
			    3,    4,    4,    4,   16,   18,   19,   20,   21,   18,
			   19,   22,   16,   24,   23,   18,   20,   25,   22,   16,
			   23,   26,  250,   28,   29,   30,   31,   32,   43,   44,

			   16,   18,   19,   20,   21,   18,   19,   22,   16,   24,
			   23,   18,   20,   25,   22,   16,   23,   26,   27,   28,
			   29,   30,   31,   32,   43,   44,   45,   46,   27,   70,
			   70,  230,   70,  126,  126,  249,   47,   48,  249,   50,
			   53,  156,  156,  251,   27,  185,  251,  252,   54,  252,
			  252,   76,   45,   46,   27,   36,   36,   36,   36,   36,
			   36,   36,   47,   48,   36,   50,   53,   52,   36,   36,
			   36,   36,   36,   36,   54,   36,   55,   36,   49,   51,
			   52,   36,   49,   36,   52,   56,   36,   36,   36,   36,
			   36,   36,   49,   52,   51,   55,   57,   59,   60,   62,

			   61,   63,   55,   61,   49,   51,   52,   64,   49,   65,
			   52,   56,   66,   67,   94,   96,   97,   98,   49,   99,
			   51,   55,   57,   59,   60,   62,   61,   63,  100,   61,
			  101,  102,  103,   64,  105,   65,  106,  107,   66,   67,
			   94,   96,   97,   98,  108,   99,  109,  110,  111,  112,
			  113,  114,  115,  117,  100,  118,  101,  102,  103,  119,
			  105,  116,  106,  107,  116,  120,  121,  123,  127,  129,
			  108,  130,  109,  110,  111,  112,  113,  114,  115,  117,
			  131,  118,  132,  128,  133,  119,  134,  116,  128,  135,
			  116,  120,  121,  123,  127,  129,  136,  130,  137,  138,

			  139,  140,  141,  142,  143,  144,  131,  147,  132,  128,
			  133,  146,  134,  146,  128,  135,  148,  149,  150,  152,
			  153,  154,  136,  158,  137,  138,  139,  140,  141,  142,
			  143,  144,  159,  147,  161,  164,  162,  146,  165,  146,
			  162,  166,  148,  149,  150,  152,  153,  154,  167,  158,
			  168,  169,  170,  171,  172,  173,  174,  175,  159,  176,
			  161,  164,  162,  177,  165,  178,  162,  166,  179,  180,
			  181,  182,  184,  186,  167,  187,  168,  169,  170,  171,
			  172,  173,  174,  175,  188,  176,  190,  191,  193,  177,
			  195,  178,  197,  198,  179,  180,  181,  182,  184,  186,

			  200,  187,  201,  202,  203,  205,  208,  210,  211,  212,
			  188,  214,  190,  191,  193,  216,  195,  218,  197,  198,
			  219,  221,  223,  224,  228,  233,  200,  235,  201,  202,
			  203,  205,  208,  210,  211,  212,  237,  214,  239,  240,
			  241,  216,  242,  218,  244,  245,  219,  221,  223,  224,
			  228,  233,   68,  235,  248,  248,  248,  248,   39,   38,
			   37,   33,  237,   13,  239,  240,  241,    9,  242,    8,
			  244,  245,    7,    5,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,

			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   65,   68,  473,  474,  470,  466,  463,
			  474,  474,  474,  453,  474,  474,   54,    0,   51,   55,
			   47,   57,   58,   59,   52,   55,   57,   97,   53,   60,
			   60,   71,   76,  457,  474,  474,  153,  458,  456,  454,
			  474,    0,    0,   81,   71,   91,  106,   99,  116,  160,
			  104,  159,  148,  110,  118,  157,  167,  165,    0,  161,
			  177,  170,  168,  166,  190,  188,  177,  178,  448,  474,
			  127,  474,  474,  474,  474,  474,  139,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  182,    0,  194,  197,  182,  202,

			  191,  213,  210,  215,    0,  197,  208,  206,  223,  225,
			  216,  220,  232,  216,  219,  227,  242,  236,  218,  223,
			  229,  247,    0,  242,    0,  474,  122,  232,  254,  242,
			  235,  244,  259,  247,  256,  271,  262,  261,  265,  266,
			  267,  268,  266,  270,  288,    0,  282,  276,  291,  288,
			  293,    0,  298,  299,  303,  474,  130,    0,  305,  296,
			    0,  313,  315,    0,  307,  318,  313,  327,  330,  315,
			  322,  336,  333,  335,  331,  323,  334,  333,  336,  329,
			  348,  336,  342,    0,  344,  134,  345,  350,  350,    0,
			  355,  351,    0,  367,    0,  369,    0,  375,  357,    0,

			  379,  385,  363,  363,    0,  373,    0,    0,  385,    0,
			  386,  368,  378,    0,  381,    0,  395,    0,  389,  399,
			    0,  391,    0,  401,  398,    0,    0,    0,  394,    0,
			   89,    0,    0,  389,    0,  399,    0,  416,    0,  417,
			  418,  420,  424,    0,  407,  422,    0,  474,  453,  134,
			   88,  142,  146, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  247,    1,  248,  248,  247,  247,  247,  247,  249,
			  247,  247,  247,  247,  247,  247,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  251,  247,  247,  247,  247,  247,  249,
			  247,  252,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  251,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  250,  250,  250,  250,  250,  250,

			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  247,  247,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  247,  247,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  247,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,

			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,    0,  247,  247,
			  247,  247,  247, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    4,    1,    1,    5,    1,    6,
			    7,    8,    1,    1,    9,   10,    1,   11,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   13,   14,
			   15,    1,   16,    1,    1,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   28,   29,   30,   31,
			   32,   33,   34,   35,   36,   37,   38,   26,   39,   40,
			   41,    1,    1,    1,    1,   42,    1,   43,   44,   45,

			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   52,
			   65,   66,   67,    1,    1,    1,    1,    1,    1,    1,
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

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    1,    3,    1,    1,    1,    1,
			    1,    1,    4,    1,    1,    1,    1,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   79,   77,    2,    3,   49,
			    7,    8,    6,   77,    5,    4,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   50,   76,   74,   75,    2,    3,   49,
			   47,    1,   46,   46,   46,   11,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   33,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   50,   74,
			    0,   67,   65,   66,   68,   69,    0,   70,   71,   51,
			   52,   53,   54,   55,   56,   57,   58,   59,   60,   61,
			   62,   63,   64,   48,   46,   10,   46,   46,   46,   46,

			   46,   46,   46,   46,   21,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   43,   46,   45,   73,    0,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   32,   46,   46,   46,   46,
			   46,   40,   46,   46,   46,   72,    0,    9,   46,   46,
			   14,   46,   46,   18,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   42,   46,    0,   46,   46,   46,   16,
			   46,   46,   24,   46,   22,   46,   25,   46,   46,   28,

			   46,   46,   46,   46,   35,   46,   37,   38,   46,   41,
			   46,   46,   46,   15,   46,   20,   46,   23,   46,   46,
			   29,   46,   31,   46,   46,   39,   44,   12,   46,   17,
			   46,   26,   27,   46,   34,   46,   13,   46,   30,   46,
			   46,   46,   46,   36,   46,   46,   19,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 474
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 247
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 248
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 78
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 79
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = true
			-- Is `position' used?

	INITIAL: INTEGER = 0
	IN_STR: INTEGER = 1
			-- Start condition codes

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class LACE_SCANNER
