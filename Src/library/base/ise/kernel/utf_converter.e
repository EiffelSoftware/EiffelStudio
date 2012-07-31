note
	description: "Converter from/to UTF-8, UTF-16 and UTF-32 encodings."
	date: "$Date$"
	revision: "$Revision$"

expanded class
	UTF_CONVERTER

feature -- UTF-32 to UTF-8

	string_32_to_utf_8_string_8 (s: READABLE_STRING_32): STRING_8
			-- UTF-8 sequence corresponding to `s'.
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

feature -- UTF-32 to UTF-16

	string_32_to_utf_16 (s: READABLE_STRING_32): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to `s'.
			-- The sequence is not zero-terminated.
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
				create Result.make_empty (p)
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
					Result := Result.aliased_resized_area (p)
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
		end

	string_32_to_utf_16_0 (s: READABLE_STRING_32): SPECIAL [NATURAL_16]
			-- UTF-16 sequence corresponding to `s' with terminating zero.
		do
			Result := string_32_to_utf_16 (s)
			Result := Result.aliased_resized_area_with_default (0, Result.count + 1)
		end

	string_32_to_utf_16_pointer (s: READABLE_STRING_32; p: MANAGED_POINTER)
			-- Write UTF-16 sequence corresponding to `s' to address `p'
			-- and update the size of `p' to the number of written bytes.
			-- The sequence is not zero-terminated.
		do
			utf_32_substring_to_utf_16_pointer (s, 1, s.count, p)
		end

	utf_32_substring_to_utf_16_pointer
			(s: READABLE_STRING_GENERAL;
			start_pos, end_pos: like {READABLE_STRING_32}.count;
			p: MANAGED_POINTER)
			-- Write UTF-16 sequence corresponding to the substring of `s'
			-- starting at index `start_pos' and ending at index `end_pos'
			-- to address `p' and update the size of `p' to the number of
			-- written bytes.
			-- The sequence is not zero-terminated.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_pos_small_enough: end_pos <= s.count
		local
			i: like {READABLE_STRING_GENERAL}.count
			c: NATURAL_32
			m: like {MANAGED_POINTER}.count
		do
			from
				i := end_pos - start_pos + 1
				if p.count < i  then
					p.resize (i * 2)
				end
				i := start_pos - 1
			until
				i >= end_pos
			loop
				i := i + 1
					-- Make sure there is sufficient room for at least 2 code units of 2 bytes each.
				if p.count < m + 4 then
						-- Additionally reserve memory for items after currently written code points
						-- to avoid reallocation on every iteration.
					p.resize ((end_pos - i) * 2 + m + 4)
				end
				c := s.code (i)
				if c <= 0xFFFF then
						-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
					p.put_natural_16 (c.to_natural_16, m)
					m := m + 2
				else
						-- Supplementary Planes: surrogate pair with lead and trail surrogates.
					p.put_natural_16 ((0xD7C0 + (c |>> 10)).to_natural_16, m)
					p.put_natural_16 ((0xDC00 + (c & 0x3FF)).to_natural_16, m + 2)
					m := m + 4
				end
			end
				-- Adjust number of written bytes.
			p.resize (m)
		end

feature -- UTF-16 to UTF-32

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
						Result.extend (((c.as_natural_32 |<< 10) + s [i] - 0x35FDC00).to_character_32)
						i := i + 1
					end
				end
			end
		end

	utf_16le_string_8_to_string_32 (s: READABLE_STRING_8): STRING_32
			-- {STRING_32} object corresponding to UTF-16LE sequence `s'.
		do
			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Convert directly from UTF-16LE to UTF-32.")
			end
			Result := utf_8_string_8_to_string_32
				(utf_16le_string_8_to_utf_8_string_8 (s))
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
