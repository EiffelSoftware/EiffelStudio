note
	description: "[
				Component to handle percent encoding
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Percent-encoding", "protocol=URI", "src=http://en.wikipedia.org/wiki/Percent-encoding"

class
	PERCENT_ENCODER

feature -- Percent encoding

	percent_encoded_string (a_string: READABLE_STRING_GENERAL): STRING_8
			-- query = *( pchar / "/" / "?" )
			-- pchar = unreserved / pct-encoded / sub-delims / ":" / "@"
			-- unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
			-- pct-encoded   = "%" HEXDIG HEXDIG
			-- sub-delims    = "!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="
		local
			s: STRING_8
			c: CHARACTER_32
			utf: UTF_CONVERTER
			i,n: INTEGER
		do
			s := utf.utf_32_string_to_utf_8_string_8 (a_string)
			from
				i := 1
				n := s.count
				create Result.make (n)
			until
				i > n
			loop
				c := s[i]

				if
					c.is_digit -- unreserved characters
					or ('a' <= c and c <= 'z') -- unreserved characters
					or ('A' <= c and c <= 'Z') -- unreserved characters
				then
					Result.extend (c.to_character_8)
				else
					inspect c
					when
						'~', -- unreserved characters
						':', '@', -- reserved =+ gen-delims
						'!', '$', '&', '%'', '(', ')', '*', -- reserved =+ sub-delims
						'+', ',', ';', '=', -- reserved = sub-delims
						'%%' -- percent encoding ...
					then
						Result.append (percent_encoded_char (c))
					when
						'-', '.', '_' -- unreserved characters
					then
						Result.extend (c.to_character_8)
					else
						Result.append (percent_encoded_char (c))
					end
				end
				i := i + 1
			end
		end

	percent_encoded_char (a_code: CHARACTER_32): STRING_8
		do
			create Result.make (3)
			Result.extend ('%%')
			Result.append (a_code.natural_32_code.to_hex_string)
			from
			until
				Result.count < 2 or else Result[2] /= '0'
			loop
				Result.remove (2)
			end
		ensure
			exists: Result /= Void
		end

feature -- Percent decoding		

	percent_decoded_string (v: READABLE_STRING_8): STRING_32
			-- The URL-decoded equivalent of the given string
		local
			s: STRING_8
			i, n: INTEGER
			c: CHARACTER
			pr: CELL [INTEGER]
			changed: BOOLEAN
			has_error: BOOLEAN -- useless
			utf: UTF_CONVERTER
		do
			has_error := False
			n := v.count
			create s.make (n)
			from i := 1
			until i > n
			loop
				c := v.item (i)
				inspect c
				when '%%' then
					-- An escaped character ?
					if i = n then
						s.append_character (c)
					else
						changed := True
						create pr.put (i)
						s.append (percent_decoded_char (v, pr))
						i := pr.item
					end
				else
					s.append_character (c)
				end
				i := i + 1
			end
			Result := utf.utf_8_string_8_to_string_32 (s)
		end

	percent_decoded_char (buf: READABLE_STRING_8; posr: CELL [INTEGER]): STRING_8
			-- Character(s) resulting from decoding the URL-encoded string
		require
			stream_exists: buf /= Void
			posr_exists: posr /= Void
			valid_start: posr.item <= buf.count
		local
			c: CHARACTER
			i, n: INTEGER
			not_a_digit: BOOLEAN
			ascii_pos: NATURAL_32
			ival: INTEGER_32
			pos: INTEGER
			uc_s32: STRING_32
			utf: UTF_CONVERTER
		do
				--| pos is index in stream of escape character ('%')
			pos := posr.item
			create Result.make (4)
			if buf.item (pos + 1) = 'u' then
				-- NOTE: this is not a standard, but it can occurs, so use this for decoding only
				-- An escaped Unicode (ucs2) value, from ECMA scripts
				-- Has the form: %u<n> where <n> is the UCS value
				-- of the character (two byte integer, one to 4 chars
				-- after escape sequence).
				-- UTF-8 result can be 1 to 4 characters
				n := buf.count
				from i := pos + 2
				until (i > n) or not_a_digit
				loop
					c := buf.item (i)
					if c.is_hexa_digit then
						ival := ival * 16
						if c.is_digit then
							ival := ival + (c |-| '0')
						else
							ival := ival + (c.upper |-| 'A') + 10
						end
						i := i + 1
					else
						not_a_digit := True
						i := i - 1
					end
				end
				posr.replace (i)
				-- ival is now UCS2 value; needs conversion to UTF8
				create uc_s32.make (1)
				uc_s32.append_character (ival.to_character_32)
				Result.append (utf.utf_32_string_to_utf_8_string_8 (uc_s32))
			else
				-- ASCII char?
				ascii_pos := hexadecimal_string_to_natural_32 (buf.substring (pos+1, pos+2))
				if {NATURAL_32} 0x80 <= ascii_pos and ascii_pos <= {NATURAL_32} 0xff then
					-- Might be improperly escaped
					Result.append_code (ascii_pos)
					posr.replace (pos + 2)
				else
					Result.append_code (ascii_pos)
					posr.replace (pos + 2)
				end
			end
		ensure
			exists: Result /= Void
		end

feature {NONE} -- Implementation

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
			-- Convertor used to convert string to integer or natural
		once
			create Result.make
			Result.set_leading_separators_acceptable (False)
			Result.set_trailing_separators_acceptable (False)
		ensure
			ctoi_convertor_not_void: Result /= Void
		end

end
