note
	description: "[
		A JSON_STRING represent a string in JSON.
		A string is a collection of zero or more Unicodes characters, wrapped in double
		quotes, using blackslash espaces.
	]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	license: "MIT (see http://www.opensource.org/licenses/mit-license.php)"

class
	JSON_STRING

inherit

	JSON_VALUE
		redefine
			is_equal
		end

create
	make_from_string, make_from_string_32, make_from_string_general,
	make_from_escaped_json_string,
	make_with_escaped_json, make_json, make_json_from_string_32

convert
	make_from_string ({READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8}),
	make_from_string_32 ({READABLE_STRING_32, STRING_32, IMMUTABLE_STRING_32}),
	make_from_string_general ({READABLE_STRING_GENERAL, STRING_GENERAL, IMMUTABLE_STRING_GENERAL})

feature {NONE} -- Initialization

	make_from_string (s: READABLE_STRING_8)
			-- Initialize from ascii string `s'.
		require
			s_not_void: s /= Void
		do
			make_from_escaped_json_string (escaped_json_string (s))
		end

	make_from_string_32 (s: READABLE_STRING_32)
			-- Initialize from unicode string `s'.
		require
			s_not_void: s /= Void
		do
			make_from_escaped_json_string (escaped_json_string (s))
		end

	make_from_string_general (s: READABLE_STRING_GENERAL)
			-- Initialize from string `s'.
		require
			s_not_void: s /= Void
		do
			if attached {READABLE_STRING_8} s as s8 then
				make_from_string (s8)
			else
				make_from_string_32 (s.as_string_32)
			end
		end

	make_from_escaped_json_string (a_escaped_string: READABLE_STRING_8)
			-- Initialize with `a_escaped_string' already JSON escaped.
		require
			a_escaped_string_not_void: a_escaped_string /= Void
		do
			item := a_escaped_string
		end

	make_with_escaped_json (a_escaped_string: READABLE_STRING_8)
			-- Initialize with `a_escaped_string' already JSON escaped.
		obsolete
			"Use `make_from_escaped_json_string' Sept/2014"
		require
			a_escaped_string_not_void: a_escaped_string /= Void
		do
			make_from_escaped_json_string (a_escaped_string)
		end

	make_from_json_string (a_json: JSON_STRING)
			-- Initialize with `a_json' string value.
		do
			make_from_escaped_json_string (a_json.item)
		end

	make_json (s: READABLE_STRING_8)
			-- Initialize.
		obsolete
			"Use `make_from_string' Sept/2014"
		require
			item_not_void: s /= Void
		do
			make_with_escaped_json (escaped_json_string (s))
		end

	make_json_from_string_32 (s: READABLE_STRING_32)
			-- Initialize from STRING_32 `s'.
		obsolete
			"Use `make_from_string_32' Sept/2014"
		require
			item_not_void: s /= Void
		do
			make_with_escaped_json (escaped_json_string (s))
		end

feature -- Access

	item: STRING
			-- Contents with escaped entities if any

feature -- Conversion

	unescaped_string_8: STRING_8
			-- Unescaped ascii string from `item'.
			--| note: valid only if `item' does not encode any unicode character.
		local
			s: like item
		do
			s := item
			create Result.make (s.count)
			unescape_to_string_8 (Result)
		end

	unescaped_string_32: STRING_32
			-- Unescaped uncode string from `item'
			--| some encoders uses UTF-8 , and not the recommended pure json encoding
			--| thus, let's support the UTF-8 encoding during decoding.
		local
			s: READABLE_STRING_8
		do
			s := item
			create Result.make (s.count)
			unescape_to_string_32 (Result)
		end

	representation: STRING
			-- String representation of `item' with escaped entities if any.
		do
			create Result.make (item.count + 2)
			Result.append_character ('%"')
			Result.append (item)
			Result.append_character ('%"')
		end

	unescape_to_string_8 (a_output: STRING_8)
			-- Unescape string `item' into `a_output'.
			--| note: valid only if `item' does not encode any unicode character.
		local
			s: like item
			i, n: INTEGER
			c: CHARACTER
		do
			s := item
			n := s.count
			from
				i := 1
			until
				i > n
			loop
				c := s [i]
				if c = '\' then
					if i < n then
						inspect s [i + 1]
						when '%"' then
							a_output.append_character ('%"')
							i := i + 2
						when '\' then
							a_output.append_character ('\')
							i := i + 2
						when '/' then
							a_output.append_character ('/')
							i := i + 2
						when 'b' then
							a_output.append_character ('%B')
							i := i + 2
						when 'f' then
							a_output.append_character ('%F')
							i := i + 2
						when 'n' then
							a_output.append_character ('%N')
							i := i + 2
						when 'r' then
							a_output.append_character ('%R')
							i := i + 2
						when 't' then
							a_output.append_character ('%T')
							i := i + 2
						when 'u' then
								--| Leave unicode \uXXXX unescaped
							a_output.append_character (c) -- '\'
							i := i + 1
						else
							a_output.append_character (c) -- '\'
							i := i + 1
						end
					else
						a_output.append_character (c) -- '\'
						i := i + 1
					end
				else
					a_output.append_character (c)
					i := i + 1
				end
			end
		end

	unescape_to_string_32 (a_output: STRING_32)
			-- Unescape string `item' into `a_output' string 32.
			--| some encoders uses UTF-8 , and not the recommended pure json encoding
			--| thus, let's support the UTF-8 encoding during decoding.	
		local
			s: READABLE_STRING_8
			i, n: INTEGER
			c: NATURAL_32
			ch: CHARACTER_8
			hex: READABLE_STRING_8
		do
			s := item
			n := s.count
			from
				i := 1
			until
				i > n
			loop
				ch := s.item (i)
				if ch = '\' then
					if i < n then
						inspect s [i + 1]
						when '%"' then
							a_output.append_character ('%"')
							i := i + 2
						when '\' then
							a_output.append_character ('\')
							i := i + 2
						when '/' then
							a_output.append_character ('/')
							i := i + 2
						when 'b' then
							a_output.append_character ('%B')
							i := i + 2
						when 'f' then
							a_output.append_character ('%F')
							i := i + 2
						when 'n' then
							a_output.append_character ('%N')
							i := i + 2
						when 'r' then
							a_output.append_character ('%R')
							i := i + 2
						when 't' then
							a_output.append_character ('%T')
							i := i + 2
						when 'u' then
							hex := s.substring (i + 2, i + 5) -- i+2 , i+2+4-1
							if hex.count = 4 then
								a_output.append_code (hexadecimal_to_natural_32 (hex))
							end
							i := i + 6 -- i+2+4
						else
							a_output.append_character (ch) -- '\'
							i := i + 1
						end
					else
						a_output.append_character (ch) -- '\'
						i := i + 1
					end
				else
					c := ch.natural_32_code
					if c <= 0x7F then
							-- 0xxxxxxx
						check
							ch = c.to_character_32
						end
						a_output.append_character (ch)
					elseif c <= 0xDF then
							-- 110xxxxx 10xxxxxx
						i := i + 1
						if i <= n then
							a_output.append_code (((c & 0x1F) |<< 6) | (s.code (i) & 0x3F))
						end
					elseif c <= 0xEF then
							-- 1110xxxx 10xxxxxx 10xxxxxx
						i := i + 2
						if i <= n then
							a_output.append_code (((c & 0xF) |<< 12) | ((s.code (i - 1) & 0x3F) |<< 6) | (s.code (i) & 0x3F))
						end
					elseif c <= 0xF7 then
							-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
						i := i + 3
						if i <= n then
							a_output.append_code (((c & 0x7) |<< 18) | ((s.code (i - 2) & 0x3F) |<< 12) | ((s.code (i - 1) & 0x3F) |<< 6) | (s.code (i) & 0x3F))
						end
					end
					i := i + 1
				end
			end
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_json_string' procedure on `a_visitor'.)
		do
			a_visitor.visit_json_string (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is JSON_STRING  made of same character sequence as `other'
			-- (possibly with a different capacity)?
		do
			Result := item.same_string (other.item)
		end

feature -- Change Element

	append (a_escaped_string: READABLE_STRING_8)
			-- Add JSON escaped string `a_escaped_string'
		require
			a_escaped_string_not_void: a_escaped_string /= Void
		do
			item.append_string (a_escaped_string)
		end

	append_json_string (a_json_string: JSON_STRING)
			-- Add JSON string `a_json_string'
		require
			a_json_string_not_void: a_json_string /= Void
		do
			append (a_json_string.item)
		end

	append_string (s: READABLE_STRING_8)
			-- Add ascii string `s'
		require
			s_not_void: s /= Void
		do
			append (escaped_json_string (s))
		end

	append_string_32 (s: READABLE_STRING_32)
			-- Add unicode string `s'
		require
			s_not_void: s /= Void
		do
			append (escaped_json_string (s))
		end

	append_string_general (s: READABLE_STRING_GENERAL)
			-- Add unicode string `s'
		require
			s_not_void: s /= Void
		do
			if attached {READABLE_STRING_8} s as s8 then
				append_string (s.as_string_8)
			else
				append_string_32 (s.as_string_32)
			end
		end

feature -- Status report

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item.hash_code
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := item
		end

feature {NONE} -- Implementation

 	is_hexadecimal (s: READABLE_STRING_8): BOOLEAN
 			-- Is `s' an hexadecimal value?
		local
			i: INTEGER
 		do
			from
				Result := True
				i := 1
			until
				i > s.count or not Result
			loop
				Result := s [i].is_hexa_digit
				i := i + 1
			end
 		end

	hexadecimal_to_natural_32 (s: READABLE_STRING_8): NATURAL_32
			-- Hexadecimal string `s' converted to NATURAL_32 value
		require
			s_not_void: s /= Void
			is_hexadecimal: is_hexadecimal (s)
		local
			i, nb: INTEGER
			char: CHARACTER
		do
			nb := s.count
			if nb >= 2 and then s.item (2) = 'x' then
				i := 3
			else
				i := 1
			end
			from
			until
				i > nb
			loop
				Result := Result * 16
				char := s.item (i)
				if char >= '0' and then char <= '9' then
					Result := Result + (char |-| '0').to_natural_32
				else
					Result := Result + (char.lower |-| 'a' + 10).to_natural_32
				end
				i := i + 1
			end
		end

	escaped_json_string (s: READABLE_STRING_GENERAL): STRING_8
			-- JSON string with '"' and '\' characters and unicode escaped
		require
			s_not_void: s /= Void
		local
			i, j, n: INTEGER
			uc: CHARACTER_32
			c: CHARACTER_8
			h: STRING_8
		do
			n := s.count
			create Result.make (n + n // 10)
			from
				i := 1
			until
				i > n
			loop
				uc := s.item (i)
				if uc.is_character_8 then
					c := uc.to_character_8
					inspect c
					when '%"' then
						Result.append_string ("\%"")
					when '\' then
						Result.append_string ("\\")
					when '/' then
							-- To avoid issue with Javascript  </script> ...
							-- escape only  </  to <\/
						if s.valid_index (i - 1) and then s.item (i - 1) = '<' then
							Result.append_string ("\/")
						else
							Result.append_string ("/")
						end
					when '%B' then
						Result.append_string ("\b")
					when '%F' then
						Result.append_string ("\f")
					when '%N' then
						Result.append_string ("\n")
					when '%R' then
						Result.append_string ("\r")
					when '%T' then
						Result.append_string ("\t")
					else
						Result.extend (c)
					end
				else
					Result.append ("\u")
					h := uc.code.to_hex_string
						-- Remove first 0 and keep 4 hexa digit
					from
						j := 1
					until
						h.count = 4 or (j <= h.count and then h.item (j) /= '0')
					loop
						j := j + 1
					end
					h := h.substring (j, h.count)
					from
					until
						h.count >= 4
					loop
						h.prepend_integer (0)
					end
					check
						hexastring_has_4_chars: h.count = 4
					end
					Result.append (h)
				end
				i := i + 1
			end
		end

invariant
	item_not_void: item /= Void

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
