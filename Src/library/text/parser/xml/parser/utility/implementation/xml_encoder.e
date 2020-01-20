note
	description: "[
				Escape and Unescape strings using XML entities
				
				see: http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ENCODER

inherit
	ANY

	PLATFORM
		export
			{NONE} all
		end

feature -- Status report

	has_error: BOOLEAN

feature -- Encoder

	encoded_string (s: READABLE_STRING_GENERAL): STRING_8
			-- `s' converted to ASCII string_8, by escaping some character with XML entities.
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
				if l_code <= {CHARACTER_8}.max_ascii_value.to_natural_32 then
					c := l_code.to_character_8
					inspect c
					when '%"' then Result.append_string ("&quot;")
					when '&' then Result.append_string ("&amp;")
					when '%'' then Result.append_string ("&apos;")
					when '<' then Result.append_string ("&lt;")
					when '>' then Result.append_string ("&gt;")
					else
						Result.append_character (c)
					end
				else
					Result.append_character ('&')
					Result.append_character ('#')
					Result.append_natural_32 (l_code)
					Result.append_character (';')
				end
				i := i + 1
			end
		end

	encoded_string_32 (s: READABLE_STRING_GENERAL): STRING_32
			-- `s' converted to escaped STRING_32 value, by escaping some character with XML entities
			-- but keeping Unicode character as they are
		local
			i, n: INTEGER
			l_code: NATURAL_32
			uc: CHARACTER_32
			c: CHARACTER_8
		do
			has_error := False
			create Result.make (s.count + s.count // 10)
			n := s.count
			from i := 1 until i > n loop
				l_code := s.code (i)
				uc := l_code.to_character_32
				if uc.is_character_8 then
					c := uc.to_character_8
					inspect c
					when '%"' then Result.append_string ({STRING_32} "&quot;")
					when '&' then Result.append_string ({STRING_32} "&amp;")
					when '%'' then Result.append_string ({STRING_32} "&apos;")
					when '<' then Result.append_string ({STRING_32} "&lt;")
					when '>' then Result.append_string ({STRING_32} "&gt;")
					else
						Result.append_character (c)
					end
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		end

feature -- Decoder

	decoded_string (v: READABLE_STRING_GENERAL): STRING_32
			-- unescaped string from `v'
			-- convert any XML entities from `v' into character_32 if possible.
		local
			i, n: INTEGER
			l_code: NATURAL_32
			uc: CHARACTER_32
			cl_i: CELL [INTEGER]
		do
			has_error := False
			n := v.count
			create Result.make (n)
			create cl_i.put (0)
			from i := 1 until i > n loop
				l_code := v.code (i)
				uc := l_code.to_character_32
				if uc = '&' then
					cl_i.replace (i)
					Result.append_string (next_entity (v, cl_i))
					i := cl_i.item
				else
					Result.append_character (uc)
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
			uc: CHARACTER_32
			is_char: BOOLEAN
			is_hexa: BOOLEAN
			s: STRING_32
		do
			i := cl_i.item
			create s.make_empty
			i := i + 1
			uc := v.item (i)
			if uc = '#' then
				is_char := True
				i := i + 1
				uc := v.item (i)
				if uc = 'x' then
					is_hexa := True
					i := i + 1
					uc := v.item (i)
				end
			end
			if is_char then
				if is_hexa then
					from
					until
						uc = ';' or not uc.is_hexa_digit
					loop
						s.append_character (uc)
						i := i + 1
						uc := v.item (i)
					end
				else
					from
					until
						uc = ';' or not uc.is_digit
					loop
						s.append_character (uc)
						i := i + 1
						uc := v.item (i)
					end
				end
			else
				from
				until
					not valid_entity_character (uc) or uc = ';'
				loop
					s.append_character (uc)
					i := i + 1
					uc := v.item (i)
				end
			end
			if uc = ';' then
				if is_char then
					if is_hexa then
						-- not yet implemented
						s.prepend_character ('x')
						s.prepend_character ('#')
						s.prepend_character ('&')
						s.append_character (';')
						Result := s
					elseif s.is_natural_32 then
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

	valid_entity_character	(c: CHARACTER_32): BOOLEAN
			-- Is `c' a valid character in html entity value?
			--| such as &amp;	
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z', '0'..'9' then
				Result := True
			else
			end
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
