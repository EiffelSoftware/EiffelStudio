note
	description: "[
				Summary description for {HTML_ENCODER}.
				
				see: http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
				see: http://en.wikipedia.org/wiki/Character_encodings_in_HTML
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_ENCODER

inherit
	ENCODER [READABLE_STRING_32, READABLE_STRING_8]

	PLATFORM
		export
			{NONE} all
		end

feature -- Access

	name: READABLE_STRING_8
		do
			create {IMMUTABLE_STRING_8} Result.make_from_string ("HTML-encoded")
		end

feature -- Status report

	has_error: BOOLEAN

feature -- Encoder

	encoded_string (s: READABLE_STRING_32): STRING_8
			-- HTML-encoded value of `s'.
		do
			Result := general_encoded_string (s)
		end

	general_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
			-- The HTML-encoded equivalent of the given string
			-- HTML-encoded value of `s'.
		local
			i, n: INTEGER
			l_code: NATURAL_32
			c: CHARACTER_8
		do
			has_error := False
			create Result.make (s.count + s.count // 10)
			n := s.count
			from i := 1 until i > n loop
				l_code := s.code (i)
				if l_code.is_valid_character_8_code then
					c := l_code.to_character_8

					inspect c
					when '%T', '%N', '%R' then
						Result.extend (c)
					when '%"' then Result.append_string ("&quot;")
					when '&' then Result.append_string ("&amp;")
					when '%'' then Result.append_string ("&apos;")
					when '<' then Result.append_string ("&lt;")
					when '>' then Result.append_string ("&gt;")
					else
						if
							l_code <= 31 or -- Hexa 1F
							l_code = 127 -- Hexa 7F
						then
							-- Ignore (forbidden in HTML, even by reference

						elseif l_code >= 128 then
							--| Tolerated
							Result.append ("&#")
							Result.append (l_code.out)
							Result.extend (';')
						else
							Result.extend (c)
						end
					end
				else
					Result.append ("&#")
					Result.append (l_code.out)
					Result.extend (';')
				end
				i := i + 1
			end
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_8): STRING_32
			-- The HTML-encoded equivalent of the given string
		local
			i, n: INTEGER
			c: CHARACTER
			cl_i: CELL [INTEGER]
		do
			has_error := False
			n := v.count
			create Result.make (n)
			create cl_i.put (0)
			from i := 1 until i > n loop
				c := v.item (i)
				if c = '&' then
					cl_i.replace (i)
					Result.append_string (next_entity (v, cl_i))
					i := cl_i.item
				else
					Result.append_character (c.to_character_32)
					i := i + 1
				end
			end
		end

	general_decoded_string (v: READABLE_STRING_GENERAL): STRING_32
			-- The HTML-encoded equivalent of the given string
		local
			i, n: INTEGER
			c: NATURAL_32
			cl_i: CELL [INTEGER]
			amp_code: NATURAL_32
		do
			has_error := False
			n := v.count
			create Result.make (n)
			create cl_i.put (0)
			amp_code := ('&').natural_32_code
			from i := 1 until i > n loop
				c := v.code (i)
				if c = amp_code then
					cl_i.replace (i)
					Result.append_string_general (next_entity (v, cl_i))
					i := cl_i.item
				else
					Result.append_character (c.to_character_32)
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation: decoder

	next_entity (v: READABLE_STRING_GENERAL; cl_i: CELL [INTEGER]): STRING_32
			-- Return next entity value
			-- move index
		local
			i: INTEGER
			l_code: NATURAL_32
			is_char: BOOLEAN
			is_hexa: BOOLEAN
			s: STRING_32
			sharp_code,
			x_code,
			semi_colon_code: NATURAL_32
		do
			sharp_code := ('#').natural_32_code
			x_code := ('x').natural_32_code
			semi_colon_code := (';').natural_32_code

			i := cl_i.item
			create s.make_empty
			i := i + 1
			l_code := v.code (i)
			if l_code = sharp_code then
				is_char := True
				i := i + 1
				l_code := v.code (i)
				if l_code = x_code then
					is_hexa := True
					i := i + 1
					l_code := v.code (i)
				end
			end

			if is_char then
				if is_hexa then
					from
					until
						not is_hexa_digit (l_code) or l_code = semi_colon_code
					loop
						s.append_code (l_code)
						i := i + 1
						l_code := v.code (i)
					end
				else
					from
					until
						not is_digit (l_code) or l_code = semi_colon_code
					loop
						s.append_code (l_code)
						i := i + 1
						l_code := v.code (i)
					end
				end
			else
				from
				until
					not valid_entity_character (l_code) or l_code = semi_colon_code
				loop
					s.append_code (l_code)
					i := i + 1
					l_code := v.code (i)
				end
			end
			if l_code = semi_colon_code then
				if is_char then
					if is_hexa then
						-- not yet implemented
						s.prepend_character ('x')
						s.prepend_character ('#')
						s.prepend_character ('&')
						s.append_character (';')
						Result := s
					elseif s.is_integer then
						create Result.make (1)
						Result.append_code (s.to_natural_32)
					else
						s.prepend_character ('&')
						s.append_character (';')
						Result := s
					end
				else
					resolve_entity (s)
					Result := s
				end
				cl_i.replace (i + 1)
			else
				cl_i.replace (cl_i.item + 1)
				s.prepend_character ('&')
				has_error := True -- ("Invalid entity syntax " + s)
				Result := s
			end
		end

	resolve_entity (s: STRING_32)
			-- Resolve `s' as an entity
			--| Hardcoding the xml entities &quot; &amp; &apos; &lt; and &gt;
		require
			s_attached: s /= Void
		local
			l_resolved: BOOLEAN
		do
			inspect s[1].as_lower
			when 'a' then
				if
					s.count = 3 and then
					s[2].as_lower = 'm' and then
					s[3].as_lower = 'p'
				then -- &amp;
					l_resolved := True
					s.wipe_out
					s.append_character ('&')
				elseif -- &apos;
					s.count = 4 and then
					s[2].as_lower = 'p' and then
					s[3].as_lower = 'o' and then
					s[4].as_lower = 's'
				then
					l_resolved := True
					s.wipe_out
					s.append_character ('%'')
				end
			when 'q' then
				if
					s.count = 4 and then
					s[2].as_lower = 'u' and then
					s[3].as_lower = 'o' and then
					s[4].as_lower = 't'
				then -- &quot;
					l_resolved := True
					s.wipe_out
					s.append_character ('%"')
				end
			when 'l' then
				if
					s.count = 2 and then
					s[2].as_lower = 't'
				then -- &quot;
					l_resolved := True
					s.wipe_out
					s.append_character ('<')
				end
			when 'g' then
				if
					s.count = 2 and then
					s[2].as_lower = 't'
				then -- &quot;
					l_resolved := True
					s.wipe_out
					s.append_character ('>')
				end
			else
			end
			if not l_resolved then
				s.prepend_character ('&')
				s.append_character (';')
			end
		end

	valid_entity_character	(a_code: NATURAL_32): BOOLEAN
			-- Is `c' a valid character in html entity value?
			--| such as &amp;	
		local
			c: CHARACTER_8
		do
			if a_code.is_valid_character_8_code then
				c := a_code.to_character_8
				inspect
					c
				when 'a'..'z' then
					Result := True
				when 'A'..'Z' then
					Result := True
				when '0'..'9' then
					Result := True
				else
				end
			end
		end

	is_hexa_digit (c: NATURAL_32): BOOLEAN
		do
			Result := c.is_valid_character_8_code and then c.to_character_8.is_hexa_digit
		end

	is_digit (c: NATURAL_32): BOOLEAN
		do
			Result := c.is_valid_character_8_code and then c.to_character_8.is_digit
		end

note
	copyright: "2011-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
