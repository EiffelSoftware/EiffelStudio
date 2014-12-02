note
	description: "[
				Component to handle percent encoding
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Percent-encoding", "protocol=URI", "src=http://en.wikipedia.org/wiki/Percent-encoding"

class
	PERCENT_ENCODER

feature -- Status report

	has_error: BOOLEAN
			-- Error occurred
			--| For now this is not fully implemented, and thus not reliable.

feature -- Percent encoding

	percent_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
			-- Return `s' percent-encoded
		do
			create Result.make (s.count)
			append_percent_encoded_string_to (s, Result)
		end

	append_percent_encoded_string_to (s: READABLE_STRING_GENERAL; a_result: STRING_GENERAL)
			-- Append `s' as percent-encoded value to `a_result'
		local
			c: NATURAL_32
			i,n: INTEGER
		do
			has_error := False
			from
				i := 1
				n := s.count
			until
				i > n
			loop
				c := s.code (i)
				if
						--| unreserved ALPHA / DIGIT
					   (48 <= c and c <= 57)  -- DIGIT: 0 .. 9
					or (65 <= c and c <= 90)  -- ALPHA: A .. Z
					or (97 <= c and c <= 122) -- ALPHA: a .. z
				then
					a_result.append_code (c)
				else
					inspect c
					when
						45, 46, 95, 126 -- unreserved characters: -._~
					then
						a_result.append_code (c)
					when
						58, 64, -- reserved =+ gen-delims: :@
						33, 36, 38, 39, 40, 41, 42, -- reserved =+ sub-delims: !$&'()*
						43, 44, 59, 61, -- reserved = sub-delims: +,;=
						37 -- percent encoding: %
					then
						append_percent_encoded_character_code_to (c, a_result)
					else
						append_percent_encoded_character_code_to (c, a_result)
					end
				end
				i := i + 1
			end
		end

	partial_encoded_string (s: READABLE_STRING_GENERAL; a_ignore: ITERABLE [CHARACTER]): STRING_8
			-- Return  `s' as percent-encoded value,
			-- but does not escape character listed in `a_ignore'.
		do
			create Result.make (s.count)
			append_partial_percent_encoded_string_to (s, Result, a_ignore)
		end

	append_partial_percent_encoded_string_to (s: READABLE_STRING_GENERAL; a_result: STRING_GENERAL; a_ignore: ITERABLE [CHARACTER])
			-- Append `s' as percent-encoded value to `a_result',
			-- but does not escape character listed in `a_ignore'.
		local
			c: NATURAL_32
			ch: CHARACTER_8
			i,n: INTEGER
		do
			has_error := False
			from
				i := 1
				n := s.count
			until
				i > n
			loop
				c := s.code (i)
				if
						--| unreserved ALPHA / DIGIT
					   (48 <= c and c <= 57)  -- DIGIT: 0 .. 9
					or (65 <= c and c <= 90)  -- ALPHA: A .. Z
					or (97 <= c and c <= 122) -- ALPHA: a .. z
				then
					a_result.append_code (c)
				else
					inspect c
					when
						45, 46, 95, 126 -- unreserved characters: -._~
					then
						a_result.append_code (c)
					when
						58, 64, -- reserved =+ gen-delims: :@
						33, 36, 38, 39, 40, 41, 42, -- reserved =+ sub-delims: !$&'()*
						43, 44, 59, 61, -- reserved = sub-delims: +,;=
						37 -- percent encoding: %
					then
						check c.is_valid_character_8_code end
						ch := c.to_character_8
						if across a_ignore as ic some ic.item = ch end then
							a_result.append_code (c)
						else
							append_percent_encoded_character_code_to (c, a_result)
						end
					else
						if c.is_valid_character_8_code then
							ch := c.to_character_8
							if across a_ignore as ic some ic.item = ch end then
								a_result.append_code (c)
							else
								append_percent_encoded_character_code_to (c, a_result)
							end
						else
							append_percent_encoded_character_code_to (c, a_result)
						end
					end
				end
				i := i + 1
			end
		end

feature -- Percent encoding: character		

	append_percent_encoded_character_code_to (a_code: NATURAL_32; a_result: STRING_GENERAL)
			-- Append character code `a_code' as percent-encoded content into `a_result'
		do
			if a_code > 0xFF then
				-- Unicode
				append_percent_encoded_unicode_character_code_to (a_code, a_result)
			elseif a_code > 0x7F then
				-- Extended ASCII
				-- This requires percent-encoding on UTF-8 converted character.
				append_percent_encoded_unicode_character_code_to (a_code, a_result)
			else
				-- ASCII
				append_percent_encoded_ascii_character_code_to (a_code, a_result)
			end
		ensure
			appended: a_result.count > old a_result.count
		end

feature {NONE} -- Implementation: character encoding

	append_percent_encoded_ascii_character_code_to (a_code: NATURAL_32; a_result: STRING_GENERAL)
			-- Append extended ascii character code `a_code' as percent-encoded content into `a_result'
			-- Note: it does not UTF-8 convert this extended ASCII.
		require
			is_extended_ascii: a_code <= 0xFF
		local
			c: INTEGER
		do
			if a_code > 0xFF then
				-- Unicode
				append_percent_encoded_unicode_character_code_to (a_code, a_result)
			else
				-- Extended ASCII
				c := a_code.to_integer_32
				a_result.append_code (37) -- 37 '%%'
	 			a_result.append_code (hex_digit [c |>> 4])
	 			a_result.append_code (hex_digit [c & 0xF])
			end
		ensure
			appended: a_result.count > old a_result.count
		end

	append_percent_encoded_unicode_character_code_to (a_code: NATURAL_32; a_result: STRING_GENERAL)
			-- Append Unicode character code `a_code' as UTF-8 and percent-encoded content into `a_result'
			-- Note: it does include UTF-8 conversion of extended ASCII and Unicode.
		do
			if a_code <= 0x7F then
					-- 0xxxxxxx
				append_percent_encoded_ascii_character_code_to (a_code, a_result)
			elseif a_code <= 0x7FF then
					-- 110xxxxx 10xxxxxx
				append_percent_encoded_ascii_character_code_to ((a_code |>> 6) | 0xC0, a_result)
				append_percent_encoded_ascii_character_code_to ((a_code & 0x3F) | 0x80, a_result)
			elseif a_code <= 0xFFFF then
					-- 1110xxxx 10xxxxxx 10xxxxxx
				append_percent_encoded_ascii_character_code_to ((a_code |>> 12) | 0xE0, a_result)
				append_percent_encoded_ascii_character_code_to (((a_code |>> 6) & 0x3F) | 0x80, a_result)
				append_percent_encoded_ascii_character_code_to ((a_code & 0x3F) | 0x80, a_result)
			else
					-- c <= 1FFFFF - there are no higher code points
					-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
				append_percent_encoded_ascii_character_code_to ((a_code |>> 18) | 0xF0, a_result)
				append_percent_encoded_ascii_character_code_to (((a_code |>> 12) & 0x3F) | 0x80, a_result)
				append_percent_encoded_ascii_character_code_to (((a_code |>> 6) & 0x3F) | 0x80, a_result)
				append_percent_encoded_ascii_character_code_to ((a_code & 0x3F) | 0x80, a_result)
			end
		ensure
			appended: a_result.count > old a_result.count
		end

feature -- Percent decoding

	percent_decoded_string (v: READABLE_STRING_GENERAL): STRING_32
			-- Return the percent decoded unicode string equivalent to the percent-encoded string `v'
		do
			create Result.make (v.count)
			append_percent_decoded_string_to (v, Result)
		end

	percent_decoded_utf_8_string (v: READABLE_STRING_GENERAL): STRING_8
			-- Return the percent decoded UTF-8 string equivalent to the percent-encoded string `v'
			--| Note that any Unicode character will be kept as UTF-8
		do
			create Result.make (v.count)
			append_percent_decoded_string_to (v, Result)
		end

	append_percent_decoded_string_to (v: READABLE_STRING_GENERAL; a_result: STRING_GENERAL)
			-- Append to `a_result' a string equivalent to the percent-encoded string `v'
			--| Note that is `a_result' is a STRING_8, any Unicode character will be kept as UTF-8
		local
			i,n: INTEGER
			c: NATURAL_32
			pr: CELL [INTEGER]
			a_result_is_string_32: BOOLEAN
		do
			has_error := False
			a_result_is_string_32 := attached {STRING_32} a_result
			from
				i := 1
				create pr.put (i)
				n := v.count
			until
				i > n
			loop
				c := v.code (i)
				inspect c
				when 43 then -- 43 '+'
						-- Some implementation are replacing spaces with "+" instead of "%20"
					a_result.append_code (32) -- 32 ' '
				when 37 then -- 37 '%%'
						-- An escaped character ?
					if i = n then -- Error?
						has_error := True
						a_result.append_code (c)
					else
						if a_result_is_string_32 then
								-- Convert UTF-8 to UTF-32
							pr.replace (i)
							c := next_percent_decoded_unicode_character_code (v, pr)
							a_result.append_code (c)
							i := pr.item
						else
								-- Keep UTF-8
							pr.replace (i)
							c := next_percent_decoded_character_code (v, pr)
							a_result.append_code (c)
							i := pr.item
						end
					end
				else
					if c <= 0x7F then
						a_result.append_code (c)
					else
						if a_result_is_string_32 then
							a_result.append_code (c)
						else
							append_percent_encoded_character_code_to (c, a_result)
						end
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation: decoding

	next_percent_decoded_character_code (v: READABLE_STRING_GENERAL; a_position: CELL [INTEGER]): NATURAL_32
			-- Character decoded from string `v' starting from index `a_position.item'
			-- note: it also updates `a_position.item' to indicate the new index position.
		require
			valid_start: a_position.item <= v.count
			is_percent_char: v.code (a_position.item) = 37 -- 37 '%%'
		local
			c: NATURAL_32
			i, n: INTEGER
			not_a_digit: BOOLEAN
			ascii_pos: NATURAL_32
			ival: NATURAL_32
			pos: INTEGER
			c_is_digit: BOOLEAN
		do
				--| pos is index in stream of escape character ('%')
			pos := a_position.item
			c := v.code (pos + 1)
			if c = 85 or c = 117 then -- 117 'u'  85 'U'
					-- NOTE: this is not a standard, but it can occur, so use this for decoding only
					-- An escaped Unicode (ucs2) value, from ECMA scripts
					--   has the form: %u<n> where <n> is the UCS value
					--   of the character (two byte integer, one to 4 chars
					--   after escape sequence).
					-- See: http://en.wikipedia.org/wiki/Percent-encoding#Non-standard_implementations
					-- UTF-8 result can be 1 to 4 characters.
				from
					i := pos + 2
					n := v.count
				until
					(i > n) or not_a_digit
				loop
					c := v.code (i)
					c_is_digit := (48 <= c and c <= 57) -- DIGIT: 0 .. 9
					if
						   c_is_digit
						or (97 <= c and c <= 102)	-- ALPHA: a..f
						or (65 <= c and c <= 70)	-- ALPHA: A..F
					then
						ival := ival * 16
						if c_is_digit then
							ival := ival + (c - 48) -- 48 '0'
						else
							if c > 70 then -- a..f
								ival := ival + (c - 97) + 10 -- 97 'a'
							else -- A..F
								ival := ival + (c - 65) + 10 -- 65 'A'
							end
						end
						i := i + 1
					else
						not_a_digit := True
						i := i - 1
					end
				end
				a_position.replace (i)
				Result := ival
			else
					-- ASCII char?
				ascii_pos := hexadecimal_string_to_natural_32 (v.substring (pos + 1, pos + 2))
				Result := ascii_pos
				a_position.replace (pos + 2)
			end
		end

	next_percent_decoded_unicode_character_code (v: READABLE_STRING_GENERAL; a_position: CELL [INTEGER]): NATURAL_32
			-- Next decoded character from `v' at position `a_position.item'
			-- note: it also updates `a_position' to indicate the new index position.
		require
			valid_start: a_position.item <= v.count
			is_percent_char: v.code (a_position.item) = 37 -- 37 '%%'
		local
			n, j: INTEGER
			c: NATURAL_32
			c1, c2, c3, c4: NATURAL_32
			pr: CELL [INTEGER]
		do
			create pr.put (a_position.item)
			c1 := next_percent_decoded_character_code (v, pr)

			j := pr.item
			n := v.count

			Result := c1
			a_position.replace (j)

			if c1 <= 0x7F then
					-- 0xxxxxxx
				Result := c1
			elseif c1 <= 0xDF then
					-- 110xxxxx 10xxxxxx
				if j + 2 <= n then
					c := v.code (j + 1)
					if c = 37 then -- 37 '%%'
						pr.replace (j + 1)
						c2 := next_percent_decoded_character_code (v, pr)
						j := pr.item
						Result := (
									((c1 & 0x1F) |<< 6) |
									( c2 & 0x3F       )
								)
						a_position.replace (j)
					else
						-- Do not try to decode
					end
				end
			elseif c1 <= 0xEF then
					-- 1110xxxx 10xxxxxx 10xxxxxx
				if j + 2 <= n then
					c := v.code (j + 1)
					if c = 37 then -- 37 '%%'
						pr.replace (j + 1)
						c2 := next_percent_decoded_character_code (v, pr)
						j := pr.item
						if j + 2 <= n then
							c := v.code (j + 1)
							if c = 37 then -- 37 '%%'
								pr.replace (j + 1)
								c3 := next_percent_decoded_character_code (v, pr)
								j := pr.item

								Result := (
										((c1 & 0xF)  |<< 12) |
										((c2 & 0x3F) |<<  6) |
										( c3 & 0x3F        )
									)
								a_position.replace (j)
							else
								-- Do not try to decode
							end
						end
					else
						-- Do not try to decode
					end
				end
			elseif c1 <= 0xF7 then
					-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

				if j + 2 <= n then
					c := v.code (j + 1)
					if c = 37 then -- 37 '%%'
						pr.replace (j + 1)
						c2 := next_percent_decoded_character_code (v, pr)
						j := pr.item
						if j + 2 <= n then
							c := v.code (j + 1)
							if c = 37 then -- 37 '%%'
								pr.replace (j + 1)
								c3 := next_percent_decoded_character_code (v, pr)
								j := pr.item
								if j + 2 <= n then
									c := v.code (j + 1)
									if c = 37 then -- 37 '%%'
										pr.replace (j + 1)
										c4 := next_percent_decoded_character_code (v, pr)
										j := pr.item

										a_position.replace (j)

										Result := (
												((c1 & 0x7)  |<< 18 ) |
												((c2 & 0x3F) |<< 12) |
												((c3 & 0x3F) |<<  6) |
												( c4 & 0x3F        )
											)
									else
										-- Do not try to decode
									end
								end
							else
								-- Do not try to decode
							end
						end
					else
						-- Do not try to decode
					end
				end
			else
				Result := c1
			end
		end

feature -- RFC and characters

	is_hexa_decimal_character (c: CHARACTER_32): BOOLEAN
			-- Is hexadecimal character ?
		do
			Result :=  ('a' <= c and c <= 'f') or ('A' <= c and c <= 'F')	-- HEXA
					or ('0' <= c and c <= '9') 								-- DIGIT
		end

	is_alpha_or_digit_character (c: CHARACTER_32): BOOLEAN
			-- Is ALPHA or DIGIT character ?
		do
			Result :=  ('a' <= c and c <= 'z') or ('A' <= c and c <= 'Z')	-- ALPHA
					or ('0' <= c and c <= '9') 								-- DIGIT
		end

	is_alpha_character (c: CHARACTER_32): BOOLEAN
			-- Is ALPHA character ?
		do
			Result := ('a' <= c and c <= 'z') or ('A' <= c and c <= 'Z')
		end

	is_digit_character (c: CHARACTER_32): BOOLEAN
			-- Is DIGIT character ?
		do
			Result := ('0' <= c and c <= '9')
		end

	is_unreserved_character (c: CHARACTER_32): BOOLEAN
			-- unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
		do
			if
				   ('a' <= c and c <= 'z')	-- ALPHA
				or ('A' <= c and c <= 'Z')	-- ALPHA
				or ('0' <= c and c <= '9') 	-- DIGIT
			then
				Result := True
			else
				inspect c
				when '-', '_', '.', '~' then -- unreserved
					Result := True
				else
				end
			end
		end

	is_reserved_character (c: CHARACTER_32): BOOLEAN
			-- reserved    = gen-delims / sub-delims
		do
			Result := is_gen_delims_character (c) or is_sub_delims_character (c)
		end

	is_gen_delims_character (c: CHARACTER_32): BOOLEAN
			-- gen-delims  = ":" / "/" / "?" / "#" / "[" / "]" / "@"	
		do
			inspect c
			when ':' , '/', '?' , '#' , '[' , ']' , '@' then
				Result := True
			else
			end
		end

	is_sub_delims_character (c: CHARACTER_32): BOOLEAN
			-- sub-delims  = "!" / "$" / "&" / "'" / "(" / ")"
            --				   / "*" / "+" / "," / ";" / "="
		do
			inspect c
			when '!' , '$' , '&' , '%'' , '(' , ')' , '*' , '+' , ',' , ';' , '=' then -- sub-delims
				Result := True
			else
			end
		end

feature {NONE} -- Implementation

 	hex_digit: SPECIAL [NATURAL_32]
 			-- Hexadecimal digits.
 		once
 			create Result.make_filled (0, 16)
 			Result [0] := {NATURAL_32} 48 -- 48 '0'
 			Result [1] := {NATURAL_32} 49 -- 49 '1'
 			Result [2] := {NATURAL_32} 50 -- 50 '2'
 			Result [3] := {NATURAL_32} 51 -- 51 '3'
 			Result [4] := {NATURAL_32} 52 -- 52 '4'
 			Result [5] := {NATURAL_32} 53 -- 53 '5'
 			Result [6] := {NATURAL_32} 54 -- 54 '6'
 			Result [7] := {NATURAL_32} 55 -- 55 '7'
 			Result [8] := {NATURAL_32} 56 -- 56 '8'
 			Result [9] := {NATURAL_32} 57 -- 57 '9'
 			Result [10] := {NATURAL_32} 65 -- 65 'A'
 			Result [11] := {NATURAL_32} 66 -- 66 'B'
 			Result [12] := {NATURAL_32} 67 -- 67 'C'
 			Result [13] := {NATURAL_32} 68 -- 68 'D'
 			Result [14] := {NATURAL_32} 69 -- 69 'E'
 			Result [15] := {NATURAL_32} 70 -- 70 'F'
 		end

	is_hexa_decimal (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' a valid hexadecimal sequence?
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.parse_string_with_type (a_string, {NUMERIC_INFORMATION}.type_natural_32)
			Result := l_convertor.is_integral_integer
		end

	hexadecimal_string_to_natural_32 (a_hex_string: READABLE_STRING_GENERAL): NATURAL_32
			-- Convert hexadecimal value `a_hex_string' to its corresponding NATURAL_32 value.
		require
			is_hexa: is_hexa_decimal (a_hex_string)
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.parse_string_with_type (a_hex_string, {NUMERIC_INFORMATION}.type_no_limitation)
			Result := l_convertor.parsed_natural_32
		end

	ctoi_convertor: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
			-- Converter used to convert string to integer or natural.
		once
			create Result.make
			Result.set_leading_separators_acceptable (False)
			Result.set_trailing_separators_acceptable (False)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 2011-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
