note
	description: "[
			Converter from/to UTF-8, UTF-16 and UTF-32 encodings.

			Handling of invalid encodings
			=============================

			Whenever a UTF-8 or UTF-16 sequence is decoded, the decoding routines also check
			that the sequence is valid. If it is not, it will replace the invalid unit (e.g. a byte
			for UTF-8 and a 2-byte for UTF-16 by the replacement character U+FFFD as described by
			variant #3 of the recommended practice for replacement character in Unicode (see
			http://www.unicode.org/review/pr-121.html for more details).

			However it means that you cannot roundtrip incorrectly encoded sequence back and forth
			between the encoded version and the decoded STRING_32 version. To allow roundtrip, an
			escaped representation of a bad encoded sequence has been introduced. It is adding a
			a fourth variant (which is a slight modification of variant #3) to the recommended
			practice where the replacement character is followed by the printed hexadecimal value
			of the invalid byte or the invalid 2-byte sequence.
			
			To provide an example (assuming that the Unicode character U+FFFD is represented as
			? textually):
			1 - on UNIX, any invalid UTF-8 byte sequence such as 0x8F 0x8F is encoded as the
			following Unicode sequence: U+FFFD U+0038 U+0046 U+FFFF U+0038 U+0046, and textually
			it looks like "?8F?8F".
			2 - on Windows, any invalid UTF-16 2-byte sequence such as 0xD800 0x0054 is encoded as the
			following Unicode sequence: U+FFFD U+0075 U+0044 U+0038 U+0030 U+0030 U+FFFD U+0035 U+0033,
			and textually it looks like "?uD800?54". The rule is that if the 2-byte sequence does not fit
			into 1 byte, it uses the letter `u' followed by the hexadecimal value of the 2-byte sequence,
			otherwise it simply uses the 1-byte hexadecimal representation.
		]"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	UTF_CONVERTER

feature -- Access

	escape_character: CHARACTER_32 = '%/0xFFFD/'
			-- Unicode replacement character to escape invalid UTF-8 or UTF-16 encoding.

feature -- Status report

	is_valid_utf_8_string_8 (s: READABLE_STRING_8): BOOLEAN
			-- Is `s' a valid UTF-8 Unicode sequence?
		local
			c: NATURAL_32
			i, nb: INTEGER
		do
			from
				nb := s.count
				Result := True
			until
				i >= nb or not Result
			loop
				i := i + 1
				c := s.code (i)
				if c <= 127 then
						-- Form 0xxxxxxx.
				elseif (c & 0xE0) = 0xC0 and then i < nb then
						-- Form 110xxxxx 10xxxxxx.
					Result := (s.code (i + 1) & 0xC0) = 0x80
					i := i + 1
				elseif (c & 0xF0) = 0xE0 and then i + 1 < nb then
					-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					Result := (s.code (i + 1) & 0xC0) = 0x80 and
						(s.code (i + 2) & 0xC0) = 0x80
					i := i + 2
				elseif (c & 0xF8) = 0xF0 and then i + 2 < nb then
					-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					Result := (s.code (i + 1) & 0xC0) = 0x80 and
						(s.code (i + 2) & 0xC0) = 0x80 and
						(s.code (i + 3) & 0xC0) = 0x80
					i := i + 3
				else
						-- Anything else is not a valid UTF-8 sequence that would yield a valid Unicode character.
					Result := False
				end
			end
		end

	is_valid_utf_16le_string_8 (s: READABLE_STRING_8): BOOLEAN
			-- Is `s' a valid UTF-16LE Unicode sequence?
		local
			c1, c2: NATURAL_32
			i, nb: INTEGER
		do
			nb := s.count
				-- If `nb' is not even, then clearly not a valid UTF-16 string.
			if (nb \\ 2) = 0 then
				from
					Result := True
				until
					i >= nb or not Result
				loop
					i := i + 2
					c1 := s.code (i - 1) | (s.code (i) |<< 8)
					if c1 < 0xD800 or else c1 >= 0xE000 then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit, this is valid Unicode.
					elseif c1 <= 0xDBFF then
						i := i + 2
						if i <= nb then
							c2 := s.code (i - 1) | (s.code (i) |<< 8)
							Result := 0xDC00 <= c2 and c2 <= 0xDFF
						else
								-- Surrogate pair is incomplete, clearly not a valid UTF-16 sequence.
							Result := False
						end
					else
							-- Invalid starting surrogate pair which should be between 0xD800 and 0xDBFF.
						Result := False
					end
				end
			end
		end

feature -- UTF-32 to UTF-8

	string_32_to_utf_8_string_8 (s: READABLE_STRING_32): STRING_8
			-- UTF-8 sequence corresponding to `s'.
		do
			Result := utf_32_string_to_utf_8_string_8 (s)
		end

	utf_32_string_to_utf_8_string_8 (s: READABLE_STRING_GENERAL): STRING_8
			-- UTF-8 sequence corresponding to `s' interpreted as a UTF-32 sequence
		local
			i: like {STRING_32}.count
			n: like {STRING_32}.count
			c: NATURAL_32
		do
			from
				n := s.count
				create Result.make (n)
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx
					Result.extend (c.to_character_8)
				elseif c <= 0x7FF then
						-- 110xxxxx 10xxxxxx
					Result.extend (((c |>> 6) | 0xC0).to_character_8)
					Result.extend (((c & 0x3F) | 0x80).to_character_8)
				elseif c <= 0xFFFF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					Result.extend (((c |>> 12) | 0xE0).to_character_8)
					Result.extend ((((c |>> 6) & 0x3F) | 0x80).to_character_8)
					Result.extend (((c & 0x3F) | 0x80).to_character_8)
				else
						-- c <= 1FFFFF - there are no higher code points
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					Result.extend (((c |>> 18) | 0xF0).to_character_8)
					Result.extend ((((c |>> 12) & 0x3F) | 0x80).to_character_8)
					Result.extend ((((c |>> 6) & 0x3F) | 0x80).to_character_8)
					Result.extend (((c & 0x3F) | 0x80).to_character_8)
				end
			end
		end

	escaped_utf_32_string_to_utf_8_string_8 (s: READABLE_STRING_GENERAL): STRING_8
			-- UTF-8 sequence corresponding to `s' interpreted as an UTF-32 sequence that could be escaped.
			-- If `s' contains the `escape_character' followed by either "HH" or "uHHHH" where H stands
			-- for an hexadecimal digit, then `s' has been escaped and will be converted to what is
			-- expected by the current platform.
			-- Otherwise it will be ignored and it will be left as is.
			-- See the note clause for the class for more details on the encoding.
		local
			i: like {STRING_32}.count
			n: like {STRING_32}.count
			c: NATURAL_32
			l_encoded_value: READABLE_STRING_GENERAL
			l_decoded: BOOLEAN
		do
			from
				n := s.count
				create Result.make (n)
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)

				if c = escape_character.natural_32_code then
						-- We might be facing a character that was escaped.
						-- In the Unix case, we only accept the 1-byte encoded format.
					if i < n and then s.item (i + 1) = escape_character then
							-- The `escape_character' was escaped, it meant they really wanted an `escape_character'.
						i := i + 1
					elseif i + 1 < n then
							-- We have at least 2 characters to read, make sure they represent an hexadecimal
							-- value.
						l_encoded_value := s.substring (i + 1, i + 2)
						if is_hexa_decimal (l_encoded_value) then
							c := to_natural_32 (l_encoded_value)
							l_decoded := True
						else
								-- Not an hexadecimal value, it was not escaped.
						end
					else
						-- Not enough to read to make it valid, it was not escaped.
					end
				else
						-- Nothing more to read, clearly it was not encoded.
				end

				if not l_decoded then
					if c <= 0x7F then
							-- 0xxxxxxx
						Result.extend (c.to_character_8)
					elseif c <= 0x7FF then
							-- 110xxxxx 10xxxxxx
						Result.extend (((c |>> 6) | 0xC0).to_character_8)
						Result.extend (((c & 0x3F) | 0x80).to_character_8)
					elseif c <= 0xFFFF then
							-- 1110xxxx 10xxxxxx 10xxxxxx
						Result.extend (((c |>> 12) | 0xE0).to_character_8)
						Result.extend ((((c |>> 6) & 0x3F) | 0x80).to_character_8)
						Result.extend (((c & 0x3F) | 0x80).to_character_8)
					else
							-- c <= 1FFFFF - there are no higher code points
							-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
						Result.extend (((c |>> 18) | 0xF0).to_character_8)
						Result.extend ((((c |>> 12) & 0x3F) | 0x80).to_character_8)
						Result.extend ((((c |>> 6) & 0x3F) | 0x80).to_character_8)
						Result.extend (((c & 0x3F) | 0x80).to_character_8)
					end
				else
					l_decoded := False
						-- Simply put decoded value directly in stream.
					Result.extend (c.to_character_8)
				end
			end
		end

	string_32_into_utf_8_0_pointer (s: READABLE_STRING_32; p: MANAGED_POINTER)
			-- Write UTF-8 sequence corresponding to `s' with terminating zero
			-- to address `p' and update the size of `p' to the number of written bytes.
			-- The sequence is zero-terminated.
		do
			utf_32_string_into_utf_8_0_pointer (s, p)
		end

	utf_32_string_into_utf_8_0_pointer (s: READABLE_STRING_GENERAL; p: MANAGED_POINTER)
			-- Write UTF-8 sequence corresponding to `s', interpreted as a UTF-32 sequence,
			-- with terminating zero to address `p' and update the size of `p' to the
			-- number of written bytes.
			-- The sequence is zero-terminated.
		local
			m: INTEGER
			i, n: like {STRING_32}.count
			c: NATURAL_32
		do
			n := s.count

				-- First compute how many bytes we need to convert `s' to UTF-8.
			from
				i := n
				m := 0
			until
				i = 0
			loop
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx.
					m := m + 1
				elseif c <= 0x7FF then
						-- 110xxxxx 10xxxxxx
					m := m + 2
				elseif c <= 0xFFFF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					m := m + 3
				else
						-- c <= 1FFFFF - there are no higher code points
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					m := m + 4
				end
				i := i - 1
			end

				-- Fill `p' with the converted data.
			from
				i := 0
				if p.count < m then
						-- Reserve more memory as we need more than what was given to us.
					p.resize (m + 1)
				end
				m := 0
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx.
					p.put_natural_8 (c.to_natural_8, m)
					m := m + 1
				elseif c <= 0x7FF then
						-- 110xxxxx 10xxxxxx.
					p.put_natural_8 (((c |>> 6) | 0xC0).to_natural_8, m)
					p.put_natural_8 (((c & 0x3F) | 0x80).to_natural_8, m + 1)
					m := m + 2
				elseif c <= 0xFFFF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					p.put_natural_8 (((c |>> 12) | 0xE0).to_natural_8, m)
					p.put_natural_8 ((((c |>> 6) & 0x3F) | 0x80).to_natural_8, m + 1)
					p.put_natural_8 (((c & 0x3F) | 0x80).to_natural_8, m + 2)
					m := m + 3
				else
						-- c <= 1FFFFF - there are no higher code points
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					p.put_natural_8 (((c |>> 18) | 0xF0).to_natural_8, m)
					p.put_natural_8 ((((c |>> 12) & 0x3F) | 0x80).to_natural_8, m + 1)
					p.put_natural_8 ((((c |>> 6) & 0x3F) | 0x80).to_natural_8, m + 2)
					p.put_natural_8 (((c & 0x3F) | 0x80).to_natural_8, m + 3)
					m := m + 4
				end
			end
			p.put_natural_8 (0, m)
		end

	utf_32_string_to_utf_8 (s: READABLE_STRING_GENERAL): SPECIAL [NATURAL_8]
			-- UTF-8 sequence corresponding to `s', interpreted as a UTF-32 sequence.
			-- The sequence is not zero-terminated.
		do
			Result := utf_32_string_to_utf_8_0 (s)
			Result := Result.aliased_resized_area_with_default (0, Result.count - 1)
		end

	utf_32_string_to_utf_8_0 (s: READABLE_STRING_GENERAL): SPECIAL [NATURAL_8]
			-- UTF-8 sequence corresponding to `s', interpreted as a UTF-32 sequence.
			-- The sequence is zero-terminated.
		local
			m: INTEGER
			i, n: like {STRING_32}.count
			c: NATURAL_32
		do
			n := s.count

				-- First compute how many bytes we need to convert `s' to UTF-8.
			from
				i := n
				m := 0
			until
				i = 0
			loop
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx.
					m := m + 1
				elseif c <= 0x7FF then
						-- 110xxxxx 10xxxxxx
					m := m + 2
				elseif c <= 0xFFFF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					m := m + 3
				else
						-- c <= 1FFFFF - there are no higher code points
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					m := m + 4
				end
				i := i - 1
			end

				-- Fill `Result' with the converted data.
			from
				create Result.make_filled (0, m + 1)
				i := 0
				m := 0
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx.
					Result.put (c.to_natural_8, m)
					m := m + 1
				elseif c <= 0x7FF then
						-- 110xxxxx 10xxxxxx.
					Result.put (((c |>> 6) | 0xC0).to_natural_8, m)
					Result.put (((c & 0x3F) | 0x80).to_natural_8, m + 1)
					m := m + 2
				elseif c <= 0xFFFF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					Result.put (((c |>> 12) | 0xE0).to_natural_8, m)
					Result.put ((((c |>> 6) & 0x3F) | 0x80).to_natural_8, m + 1)
					Result.put (((c & 0x3F) | 0x80).to_natural_8, m + 2)
					m := m + 3
				else
						-- c <= 1FFFFF - there are no higher code points
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					Result.put (((c |>> 18) | 0xF0).to_natural_8, m)
					Result.put ((((c |>> 12) & 0x3F) | 0x80).to_natural_8, m + 1)
					Result.put ((((c |>> 6) & 0x3F) | 0x80).to_natural_8, m + 2)
					Result.put (((c & 0x3F) | 0x80).to_natural_8, m + 3)
					m := m + 4
				end
			end
			Result.put (0, m)
		end

feature -- UTF-8 to UTF-32

	utf_8_string_8_to_string_32 (s: READABLE_STRING_8): STRING_32
			-- STRING_32 corresponding to UTF-8 sequence `s'.
		local
			i: like {STRING_8}.count
			n: like {STRING_8}.count
			c: NATURAL_32
		do
			from
				n := s.count
				create Result.make (n)
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx
					Result.extend (c.to_character_32)
				elseif c <= 0xDF then
						-- 110xxxxx 10xxxxxx
					i := i + 1
					if i <= n then
						Result.extend ((
							((c & 0x1F) |<< 6) |
							(s.code (i) & 0x3F)
						).to_character_32)
					end
				elseif c <= 0xEF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					i := i + 2
					if i <= n then
						Result.extend ((
							((c & 0xF) |<< 12) |
							((s.code (i - 1) & 0x3F) |<< 6) |
							(s.code (i) & 0x3F)
						).to_character_32)
					end
				elseif c <= 0xF7 then
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					i := i + 3
					if i <= n then
						Result.extend ((
							((c & 0x7) |<< 18) |
							((s.code (i - 2) & 0x3F) |<< 12) |
							((s.code (i - 1) & 0x3F) |<< 6) |
							(s.code (i) & 0x3F)
						).to_character_32)
					end
				end
			end
		end

	utf_8_string_8_to_escaped_string_32 (s: READABLE_STRING_8): STRING_32
			-- STRING_32 corresponding to UTF-8 sequence `s', where invalid UTF-8 sequences are escaped.
		local
			i: like {STRING_8}.count
			n: like {STRING_8}.count
			c1, c2, c3, c4: NATURAL_8
		do
			from
				n := s.count
				create Result.make (n)
			until
				i >= n
			loop
				i := i + 1
				c1 := s.code (i).as_natural_8
				if c1 <= 0x7F then
						-- 0xxxxxxx
					Result.extend (c1.to_character_32)
				elseif (c1 & 0xE0) = 0xC0 then
					if i < n then
						c2 := s.code (i + 1).as_natural_8
						if (c2 & 0xC0) = 0x80 then
								-- Valid UTF-8 sequence:
								-- 110xxxxx 10xxxxxx
							Result.extend ((
								((c1.as_natural_32 & 0x1F) |<< 6) |
								(c2.as_natural_32 & 0x3F)
								).to_character_32)
							i := i + 1
						else
								-- Invalid UTF-8 sequence, we escape the first byte
								-- and try with the next one to see if it is the starting
								-- byte of a valid UTF-8 sequence.
							escape_code_into (Result, c1)
						end
					else
							-- Invalid UTF-8 sequence, we escape the first byte.
						escape_code_into (Result, c1)
					end
				elseif (c1 & 0xF0) = 0xE0 then
					if i + 1 < n then
						c2 := s.code (i + 1).as_natural_8
						c3 := s.code (i + 2).as_natural_8
						if (c2 & 0xC0) = 0x80 and (c3 & 0xC0) = 0x80 then
								-- Valid UTF-8 sequence:
								-- 1110xxxx 10xxxxxx 10xxxxxx
							Result.extend ((
								((c1.as_natural_32 & 0xF) |<< 12) |
								((c2.as_natural_32 & 0x3F) |<< 6) |
								(c3.as_natural_32 & 0x3F)
								).to_character_32)
							i := i + 2
						else
								-- Invalid UTF-8 sequence, we escape the first byte
								-- and try with the next one to see if it is the starting
								-- byte of a valid UTF-8 sequence.
							escape_code_into (Result, c1)
						end
					else
							-- Invalid UTF-8 sequence.
						escape_code_into (Result, c1)
					end
				elseif (c1 & 0xF8) = 0xF0 then
					if i + 2 < n then
						c2 := s.code (i + 1).as_natural_8
						c3 := s.code (i + 2).as_natural_8
						c4 := s.code (i + 3).as_natural_8
						if (c2 & 0xC0) = 0x80 and (c3 & 0xC0) = 0x80 and (c4 & 0xC0) = 0x80 then
								-- Valid UTF-8 sequence:
								-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
							Result.extend ((
								((c1.as_natural_32 & 0x7) |<< 18) |
								((c2.as_natural_32 & 0x3F) |<< 12) |
								((c3.as_natural_32 & 0x3F) |<< 6) |
								(c4.as_natural_32 & 0x3F)
								).to_character_32)
							i := i + 3
						else
								-- Invalid UTF-8 sequence, we escape the first byte
								-- and try with the next one to see if it is the starting
								-- byte of a valid UTF-8 sequence.
							escape_code_into (Result, c1)
						end
					else
							-- Invalid UTF-8 sequence.
						escape_code_into (Result, c1)
					end

				else
						-- Clearly invalid UTF-8
					escape_code_into (Result, c1)
				end
			end
		end

feature -- UTF-32 to UTF-16

	string_32_to_utf_16 (s: READABLE_STRING_32): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to `s'.
			-- The sequence is not zero-terminated.
		do
			Result := utf_32_string_to_utf_16 (s)
		end

	utf_32_string_to_utf_16 (s: READABLE_STRING_GENERAL): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to `s' interpreted as a UTF-32 sequence.
			-- The sequence is not zero-terminated.
		do
			Result := utf_32_string_to_utf_16_0 (s)
			Result := Result.aliased_resized_area_with_default (0, Result.count - 1)
		end

	string_32_to_utf_16_0 (s: READABLE_STRING_32): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to `s' with terminating zero.
		do
			Result := utf_32_string_to_utf_16_0 (s)
		end

	utf_32_string_to_utf_16_0 (s: READABLE_STRING_GENERAL): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to `s', interpreted as a UTF-32 sequence,
			-- with terminating zero.
		local
			i: like {STRING_32}.count
			n: like {STRING_32}.count
			m: like {STRING_32}.count
			p: like {STRING_32}.count
			c: NATURAL_32
		do
			from
				m := 0
				n := s.count
				p := n
				create Result.make_empty (p + 1)
			invariant
				m = Result.count
				p = Result.capacity
			until
				i >= n
			loop
				i := i + 1
					-- Make sure there is sufficient room for at least 2 code units.
				if p < m + 2 then
					p := m + (n - i) + 2
					Result := Result.aliased_resized_area (p + 1)
				end
				c := s.code (i)
				if c <= 0xFFFF then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					Result.extend (c.to_natural_16)
					m := m + 1
				else
						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					Result.extend ((0xD7C0 + (c |>> 10)).to_natural_16)
					Result.extend ((0xDC00 + (c & 0x3FF)).to_natural_16)
					m := m + 2
				end
			end
			Result.extend (0)
		end

	string_32_into_utf_16_pointer (s: READABLE_STRING_32; p: MANAGED_POINTER)
			-- Write UTF-16 sequence corresponding to `s' to address `p'
			-- and update the size of `p' to the number of written bytes.
			-- The sequence is not zero-terminated.
		do
			utf_32_substring_into_utf_16_pointer (s, 1, s.count, p)
		end

	string_32_into_utf_16_0_pointer (s: READABLE_STRING_32; p: MANAGED_POINTER)
			-- Write UTF-16 sequence corresponding to `s' with terminating zero
			-- to address `p' and update the size of `p' to the number of written bytes.
			-- The sequence is zero-terminated.
		do
			utf_32_substring_into_utf_16_0_pointer (s, 1, s.count, p)
		end

	utf_32_substring_into_utf_16_pointer
			(s: READABLE_STRING_GENERAL;
			start_pos, end_pos: like {READABLE_STRING_32}.count;
			p: MANAGED_POINTER)
			-- Write UTF-16 sequence corresponding to the substring of `s',
			-- interpreted as a UTF-32 sequence, starting at index `start_pos'
			-- and ending at index `end_pos' to address `p' and update the
			-- size of `p' to the number of written bytes.
			-- The sequence is not zero-terminated.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_pos_small_enough: end_pos <= s.count
		local
			i: like {READABLE_STRING_GENERAL}.count
			c: NATURAL_32
			m, l_count: like {MANAGED_POINTER}.count
		do
			from
				i := end_pos - start_pos + 1
				l_count := p.count
				if l_count < (i * 2)  then
					l_count := i * 2
					p.resize (l_count)
				end
				i := start_pos - 1
			until
				i >= end_pos
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0xFFFF then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					p.put_natural_16 (c.to_natural_16, m)
					m := m + 2
				else
						-- Make sure there is sufficient room for at least 2 code units of 2 bytes each.
					if l_count < m + 4 then
							-- Additionally reserve memory for items after currently written code points
							-- to avoid reallocation on every iteration.
						l_count := (end_pos - i) * 2 + m + 4
						p.resize (l_count)
					end

						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					p.put_natural_16 ((0xD7C0 + (c |>> 10)).to_natural_16, m)
					p.put_natural_16 ((0xDC00 + (c & 0x3FF)).to_natural_16, m + 2)
					m := m + 4
				end
			end
				-- Adjust number of written bytes.
			p.resize (m)
		ensure
			p_count_may_increase: p.count >= old p.count
		end

	utf_32_substring_into_utf_16_0_pointer
			(s: READABLE_STRING_GENERAL;
			start_pos, end_pos: like {READABLE_STRING_32}.count;
			p: MANAGED_POINTER)
			-- Write UTF-16 sequence corresponding to the substring of `s',
			-- interpreted as a UTF-32 sequence, starting at index `start_pos'
			-- and ending at index `end_pos' to address `p' and update the
			-- size of `p' to the number of written bytes.
			-- The sequence is zero-terminated.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_pos_small_enough: end_pos <= s.count
		local
			i: like {READABLE_STRING_GENERAL}.count
			c: NATURAL_32
			m, l_count: like {MANAGED_POINTER}.count
			l_resized: BOOLEAN
		do
				-- Write UTF-16 sequence.
			from
				i := end_pos - start_pos + 1
				l_count := p.count
				if l_count < (i + 1) * 2  then
					l_count := (i + 1) * 2
					p.resize (l_count)
				end
				i := start_pos - 1
			until
				i >= end_pos
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0xFFFF then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					p.put_natural_16 (c.to_natural_16, m)
					m := m + 2
				else
						-- Make sure there is sufficient room for at least 2 code units of 2 bytes each.
					if l_count < m + 4 then
							-- Additionally reserve memory for items after currently written code points
							-- to avoid reallocation on every iteration.
						l_count := (end_pos - i) * 2 + m + 4
						p.resize (l_count)
						l_resized := True
					end

						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					p.put_natural_16 ((0xD7C0 + (c |>> 10)).to_natural_16, m)
					p.put_natural_16 ((0xDC00 + (c & 0x3FF)).to_natural_16, m + 2)
					m := m + 4
				end
			end
				-- Adjust number of written bytes and add terminating zero at the end.
			if l_resized then
					-- We had to add a code unit on 4 bytes. We adjust the size.
				p.resize (m + 2)
			end
			p.put_natural_16 (0, m)
		ensure
			p_count_may_increase: p.count >= old p.count
		end

	utf_32_string_to_utf_16le_string_8 (s: READABLE_STRING_GENERAL): STRING_8
			-- UTF-16LE sequence corresponding to `s' interpreted as a UTF-32 sequence
		local
			i: like {STRING_32}.count
			n: like {STRING_32}.count
			c: NATURAL_32
			l_nat16: NATURAL_16
		do
			from
				n := s.count
					-- We would need at least 2-bytes per characters in `s'.
				create Result.make (n * 2)
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0xFFFF then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					Result.extend ((c & 0x00FF).to_character_8)
					Result.extend (((c & 0xFF00) |>> 8).to_character_8)
				else
						-- Write the lead surrogate pair.
					l_nat16 := (0xD7C0 + (c |>> 10)).to_natural_16
					Result.extend ((l_nat16 & 0x00FF).to_character_8)
					Result.extend (((l_nat16 & 0xFF00) |>> 8).to_character_8)

						-- Write the trail surrogate pair.
					l_nat16 := (0xDC00 + (c & 0x3FF)).to_natural_16
					Result.extend ((l_nat16 & 0x00FF).to_character_8)
					Result.extend (((l_nat16 & 0xFF00) |>> 8).to_character_8)
				end
			end
		end

	escaped_utf_32_string_to_utf_16le_string_8 (s: READABLE_STRING_GENERAL): STRING_8
			-- UTF-16LE sequence corresponding to `s' interpreted as an UTF-32 sequence that could be escaped.
			-- If `s' contains the `escape_character' followed by either "HH" or "uHHHH" where H stands
			-- for an hexadecimal digit, then `s' has been escaped and will be converted to what is
			-- expected by the current platform.
			-- Otherwise it will be ignored and it will be left as is.
			-- See the note clause for the class for more details on the encoding.
		local
			i: like {STRING_32}.count
			n: like {STRING_32}.count
			c: NATURAL_32
			l_nat16: NATURAL_16
			l_encoded_value: READABLE_STRING_GENERAL
			l_decoded: BOOLEAN
		do
			from
				n := s.count
					-- We would need at least 2-bytes per characters in `s'.
				create Result.make (n * 2)
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c = escape_character.natural_32_code then
						-- We might be facing a character that was escaped.
					if i < n then
						if s.item (i + 1) = escape_character then
								-- The `escape_character' was escaped, it meant they really wanted an `escape_character'.
							i := i + 1
						elseif s.item (i + 1) = 'u' then
							if i + 4 < n then
								l_encoded_value := s.substring (i + 2, i + 5)
								if is_hexa_decimal (l_encoded_value) then
									c := to_natural_32 (l_encoded_value)
									l_decoded := True
									i := i + 5
								else
										-- Not an hexadecimal value, it was not escaped.
								end
							else
									-- Not enough characters to make a 2-byte value, it was not escaped.
							end
						elseif i + 1 < n then
								-- We have at least 2 characters to read, make sure they represent an hexadecimal
								-- value.
							l_encoded_value := s.substring (i + 1, i + 2)
							if is_hexa_decimal (l_encoded_value) then
								c := to_natural_32 (l_encoded_value)
								l_decoded := True
								i := i + 2
							else
									-- Not an hexadecimal value, it was not escaped.
							end
						else
							-- Not enough to read to make it valid, it was not escaped.
						end
					else
							-- Nothing more to read, clearly it was not encoded.
					end
				end

				if not l_decoded then
					if c <= 0xFFFF then
							-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
						Result.extend ((c & 0x00FF).to_character_8)
						Result.extend (((c & 0xFF00) |>> 8).to_character_8)
					else
							-- Write the lead surrogate pair.
						l_nat16 := (0xD7C0 + (c |>> 10)).to_natural_16
						Result.extend ((l_nat16 & 0x00FF).to_character_8)
						Result.extend (((l_nat16 & 0xFF00) |>> 8).to_character_8)

								-- Write the trail surrogate pair.
						l_nat16 := (0xDC00 + (c & 0x3FF)).to_natural_16
						Result.extend ((l_nat16 & 0x00FF).to_character_8)
						Result.extend (((l_nat16 & 0xFF00) |>> 8).to_character_8)
					end
				else
					l_decoded := False
						-- Simply put decoded value directly in stream.
					Result.extend ((c & 0x00FF).to_character_8)
					Result.extend (((c & 0xFF00) |>> 8).to_character_8)
				end
			end
		end

feature -- UTF-16 to UTF-32

	utf_16_0_pointer_to_string_32 (p: MANAGED_POINTER): STRING_32
			-- {STRING_32} object corresponding to UTF-16 sequence `p' which is zero-terminated.
		require
			minimum_size: p.count >= 2
		local
			i, n: INTEGER
			c: NATURAL_32
		do
			from
					-- Allocate Result with the same number of bytes as `p'.
				n := p.count
				create Result.make (n)
			until
				i >= n
			loop
				c := p.read_natural_16 (i)
				if c = 0 then
						-- We hit our null terminating character, we can stop
					i := n
				else
					i := i + 2
					if c < 0xD800 or else c >= 0xE000 then
							-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
						Result.extend (c.to_character_32)
					else
							-- Supplementary Planes: surrogate pair with lead and trail surrogates.
						if i < n then
							Result.extend (((c.as_natural_32 |<< 10) + p.read_natural_16 (i) - 0x35FDC00).to_character_32)
							i := i + 2
						end
					end
				end
			end
		end

	utf_16_to_string_32 (s: SPECIAL [NATURAL_16]): STRING_32
			-- {STRING_32} object corresponding to UTF-16 sequence `s'.
		local
			i: like {SPECIAL [NATURAL_16]}.count
			n: like {SPECIAL [NATURAL_16]}.count
			c: NATURAL_32
		do
			from
				n := s.count
				create Result.make (n)
			until
				i >= n
			loop
				c := s [i]
				i := i + 1
				if c < 0xD800 or else c >= 0xE000 then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					Result.extend (c.to_character_32)
				else
						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					if i < n then
						Result.extend (((c |<< 10) + s [i] - 0x35FDC00).to_character_32)
						i := i + 1
					end
				end
			end
		end

	utf_16le_string_8_to_string_32 (s: READABLE_STRING_8): STRING_32
			-- {STRING_32} object corresponding to UTF-16LE sequence `s'.
		local
			i, nb: INTEGER
			c1, c2: NATURAL_32
		do
			from
				nb := s.count
					-- There is at least half the characters of `s'.
				create Result.make (nb |>> 1)
			until
				i + 1 >= nb
			loop
				i := i + 2
					-- Extract the first 2-bytes
				c1 := s.code (i - 1) | (s.code (i) |<< 8)
				if c1 < 0xD800 or else c1 >= 0xE000 then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit, this is valid Unicode.						
					Result.extend (c1.to_character_32)
				else
					i := i + 2
					if i <= nb then
						c2 := s.code (i - 1) | (s.code (i) |<< 8)
						Result.extend (((c1 |<< 10) + c2 - 0x35FDC00).to_character_32)
					end
				end
			end
		end

	utf_16le_string_8_to_escaped_string_32 (s: READABLE_STRING_8): STRING_32
			-- {STRING_32} object corresponding to UTF-16LE sequence `s', where invalid UTF-16LE sequences are escaped.
		local
			i, nb: INTEGER
			c1, c2: NATURAL_16
		do
			from
				nb := s.count
					-- There is at least half the characters of `s'.
				create Result.make (nb |>> 1)
			until
				i + 1 >= nb
			loop
				i := i + 2
					-- Extract the first 2-bytes
				c1 := s.code (i - 1).as_natural_16 | (s.code (i).as_natural_16 |<< 8)
				if c1 < 0xD800 or else c1 >= 0xE000 then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit, this is valid Unicode.						
					Result.extend (c1.to_character_32)
				elseif c1 <= 0xDBFF then
						-- Only check the trailing code unit if the leading one is valid.
					i := i + 2
					if i <= nb then
						c2 := s.code (i - 1).as_natural_16 | (s.code (i).as_natural_16 |<< 8)
						if c2 >= 0xDC00 and c2 <= 0xDFFF then
								-- This is a valid code unit, we combine the leading and trailing
								-- code unit to form a Unicode character.
							Result.extend (((c1 |<< 10) + c2 - 0x35FDC00).to_character_32)
						else
								-- This is an invalid unicode code unit, we escape the leading code unit.
							escape_code_into (Result, c1)
								-- However we reset, decrement `i' so that if `c2' is a valid
								-- character we simply encode it as is, or if it is a leading code
								-- unit, maybe it is followed by a trailing code unit which would make
								-- a valid Unicode character.
							i := i - 2
						end
					else
							-- Case of a leading code unit not followed by a trailing one.
							-- We simply escape the leading code unit.
						escape_code_into (Result, c1)
					end
				else
						-- Case of an invalid leading code unit, we escape the leading code unit.
					escape_code_into (Result, c1)
				end
			end
		end

feature -- UTF-16 to UTF-8

	utf_16_to_utf_8_string_8 (s: SPECIAL [NATURAL_16]): STRING_8
			-- UTF-8 sequence corresponding to UTF-16 sequence `s'.
		do
			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Convert directly from UTF-16 to UTF-8.")
			end
			Result := string_32_to_utf_8_string_8 (utf_16_to_string_32 (s))
		end

	utf_16le_string_8_to_utf_8_string_8 (s: READABLE_STRING_8): STRING_8
			-- UTF-8 sequence corresponding to UTF-16LE sequence `s'.
		require
			even_count: (s.count & 1) = 0
		local
			v: SPECIAL [NATURAL_16]
			i: like {STRING_8}.count
			n: like {STRING_8}.count
		do
			from
				n := s.count
				create v.make_empty (n |>> 1)
			until
				i >= n
			loop
				i := i + 2
				check
					valid_index: 1 <= i - 1 and i <= s.count
				end
				v.extend (s [i - 1].code.as_natural_16 | (s [i].code.as_natural_16 |<< 8))
			end
			Result := utf_16_to_utf_8_string_8 (v)
		end

feature -- UTF-8 to UTF-16

	utf_8_string_8_to_utf_16 (s: READABLE_STRING_8): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to UTF-8 sequence `s'.
		do
			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Convert directly from UTF-8 to UTF-16.")
			end
			Result := string_32_to_utf_16 (utf_8_string_8_to_string_32 (s))
		end

	utf_8_string_8_to_utf_16_0 (s: READABLE_STRING_8): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to UTF-8 sequence `s' with terminating zero.
		do
			Result := utf_8_string_8_to_utf_16 (s)
			Result := Result.aliased_resized_area_with_default (0, Result.count + 1)
		end

feature -- Byte Order Mark (BOM)

	utf_8_bom_to_string_8: STRING_8 = "%/239/%/187/%/191/"
			-- UTF-8 BOM sequence.

	utf_16be_bom_to_string_8: STRING_8 = "%/254/%/255/"
			-- UTF-16BE BOM sequence.

	utf_16le_bom_to_string_8: STRING_8 = "%/255/%/254/"
			-- UTF-16LE BOM sequence.

	utf_32be_bom_to_string_8: STRING_8 = "%U%U%/254/%/255/"
			-- UTF-32BE BOM sequence.

	utf_32le_bom_to_string_8: STRING_8 = "%/255/%/254/%U%U"
			-- UTF-32LE BOM sequence.

feature {NONE} -- Implementation

	escape_code_into (a_string: STRING_32; a_code: NATURAL_16)
			-- Escape `a_code' as documented in the note clause of the class into `a_string'.
			-- If `a_code' fits into a NATURAL_8, it will be just the `escape_character' followed
			-- by the 2-digit hexadecimal representation, otherwise `escape_character' followed
			-- by the letter `u' followed by the 4-digit hexadecimal representation.
		do
			a_string.append_character (escape_character)
			if a_code <= {NATURAL_8}.max_value then
				a_string.append_string_general (a_code.as_natural_8.to_hex_string)
			else
				a_string.append_character ('u')
				a_string.append_string_general (a_code.to_hex_string)
			end
		end

	is_hexa_decimal (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' a valid hexadecimal sequence?
		local
			l_convertor: like ctoi_convertor
		do
			l_convertor := ctoi_convertor
			l_convertor.reset ({NUMERIC_INFORMATION}.type_natural_32)
			l_convertor.parse_string_with_type (a_string, {NUMERIC_INFORMATION}.type_natural_32)
			Result := l_convertor.is_integral_integer
		end

	to_natural_32 (a_hex_string: READABLE_STRING_GENERAL): NATURAL_32
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
			-- Convertor used to convert string to integer or natural
		once
			create Result.make
			Result.set_leading_separators_acceptable (False)
			Result.set_trailing_separators_acceptable (False)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
