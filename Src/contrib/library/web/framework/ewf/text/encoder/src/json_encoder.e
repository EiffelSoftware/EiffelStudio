note
	description: "[
				Summary description for {JSON_ENCODER}.

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ENCODER

inherit
	ENCODER [READABLE_STRING_32, READABLE_STRING_8]

	PLATFORM
		export
			{NONE} all
		end

feature -- Access

	name: READABLE_STRING_8
		do
			create {IMMUTABLE_STRING_8} Result.make_from_string ("JSON-encoded")
		end

feature -- Status report

	has_error: BOOLEAN

feature -- Encoder

	encoded_string (s: READABLE_STRING_32): STRING_8
			-- JSON-encoded value of `s'.
		local
			i, j, n: INTEGER
			uc: CHARACTER_32
			c: CHARACTER_8
			h: STRING_8
		do
			has_error := False
			n := s.count
			create Result.make (n + n // 10)
			from i := 1 until i > n loop
				uc := s.item (i)
				if uc.is_character_8 then
					c := uc.to_character_8
					inspect c
					when '%U' then Result.append_string ("\u0000")
					when '%"' then Result.append_string ("\%"")
					when '\' then Result.append_string ("\\")
					when '%B' then Result.append_string ("\b")
					when '%F' then Result.append_string ("\f")
					when '%N' then Result.append_string ("\n")
					when '%R' then Result.append_string ("\r")
					when '%T' then Result.append_string ("\t")
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
					check h.count = 4 end
					Result.append (h)
				end
				i := i + 1
			end
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING_32
			-- The JSON-encoded equivalent of the given string
		local
			i, n: INTEGER
			c: CHARACTER
			hex: STRING
		do
			has_error := False
			n := v.count
			create Result.make (n)
			from i := 1 until i > n loop
				c := v.item (i)
				if c = '\' then
					if i < n then
						inspect v.item (i+1)
						when '\' then
							Result.append_character ('\')
							i := i + 2
						when '%"' then
							Result.append_character ('%"')
							i := i + 2
						when 'b' then
							Result.append_character ('%B')
							i := i + 2
						when 'f' then
							Result.append_character ('%F')
							i := i + 2
						when 'n' then
							Result.append_character ('%N')
							i := i + 2
						when 'r' then
							Result.append_character ('%R')
							i := i + 2
						when 't' then
							Result.append_character ('%T')
							i := i + 2
						when 'u' then
							hex := v.substring (i+2, i+2+4 - 1)
							if hex.count = 4 then
								Result.append_code (hexadecimal_to_natural_32 (hex))
							end
							i := i + 2 + 4
						else
							Result.append_character ('\')
							i := i + 1
						end
					else
						Result.append_character ('\')
						i := i + 1
					end
				else
					Result.append_character (c.to_character_32)
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	is_hexadecimal (s: READABLE_STRING_8): BOOLEAN
		do
			Result := across s as scur all scur.item.is_hexa_digit end
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
