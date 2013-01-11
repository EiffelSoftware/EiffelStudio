note
	description: "Routines for use by classes that need to print eiffel strings and characters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_ROUTINES

feature -- Access

	char_text (char: CHARACTER): STRING
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
		do
			Result := char_to_string (char, Void, False)
		ensure
			char_text_not_void: Result /= Void
		end

	wchar_text (char32: CHARACTER_32): STRING_32
			-- "Readable" representation of `wchar' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
		do
			Result := char32_to_string_32 (char32, Void, False)
		ensure
			char32_text_not_void: Result /= Void
		end

	eiffel_string (s: STRING): STRING
			-- "eiffel" representation of `s'
			-- Translation of special characters
			--| "%T" -> "%%T", "%N" -> "%%N", "%%" -> "%%%%"
			--| but for printable char: "%A" -> "@", "%(" -> "["
			--| follow ECMA 8.32.23				
		require
			s_not_void: s /= Void
		local
			l_area: SPECIAL [CHARACTER];
			i, l_count: INTEGER;
		do
			from
				l_area := s.area;
				l_count := s.count
				create Result.make (l_count);
			until
				i >= l_count
			loop
				Result := char_to_string (l_area.item (i), Result, True)
				i := i + 1
			end
		ensure
			eiffel_string_not_void: Result /= Void
		end

	eiffel_string_32 (s: STRING_32): STRING_32
			-- "eiffel" representation of `s'
			-- Translation of special characters
			--| "%T" -> "%%T", "%N" -> "%%N", "%%" -> "%%%%"
			--| but for printable char: "%A" -> "@", "%(" -> "["
			--| follow ECMA 8.32.23		
		require
			s_not_void: s /= Void
		local
			l_area: SPECIAL [CHARACTER_32];
			i, l_count: INTEGER;
		do
			from
				l_area := s.area;
				l_count := s.count
				create Result.make (l_count)
			until
				i >= l_count
			loop
				Result := char32_to_string_32 (l_area.item (i), Result, True)
				i := i + 1
			end
		ensure
			eiffel_string_32_not_void: Result /= Void
		end

feature -- Unescape

	last_unescaping_raised_error: BOOLEAN

	unescaped_string (s: STRING): STRING
			-- Unescaped Eiffel String.
			--| "%%T" -> "%T", "%%N" -> "%N", "%%%%" -> "%%"
			--| but for printable char "%%A" -> "@", "%%(" -> "["
			--| and "%/59/" -> ";"
			--| follow ECMA 8.32.23
		local
			i: INTEGER
			t: STRING
			c: CHARACTER
			error: BOOLEAN
			l_count: INTEGER
			l_area: SPECIAL [CHARACTER]
		do
			from
				last_unescaping_raised_error := False
				l_count := s.count
				l_area := s.area
				create Result.make (l_count)
				--| i := 0
			until
				i >= l_count
			loop
				c := l_area.item (i)
				if c = '%%' then
					if i = l_count - 1 then
						--| Is last character
						error := True
						Result.append_character (c)
					else
						i := i + 1
						c := l_area.item (i)
						inspect c
						when  'A' then Result.append_character ('%A') --| @
						when  'B' then Result.append_character ('%B') --| BS : BackSpace
						when  'C' then Result.append_character ('%C') --| ^
						when  'D' then Result.append_character ('%D') --| $
						when  'F' then Result.append_character ('%F') --| FF : Form Feed
						when  'H' then Result.append_character ('%H') --| \
						when  'L' then Result.append_character ('%L') --| ~
						when  'N' then Result.append_character ('%N') --| NL (LF) : Newline
						when  'Q' then Result.append_character ('%Q') --| `
						when  'R' then Result.append_character ('%R') --| CR
						when  'S' then Result.append_character ('%S') --| #
						when  'T' then Result.append_character ('%T') --| HT : Horizontal Tab
						when  'U' then Result.append_character ('%U') --| NUL : nUll
						when  'V' then Result.append_character ('%V') --| | : Vertical bar
						when '%%' then Result.append_character ('%%') --| %
						when '%'' then Result.append_character ('%'') --| '
						when '%"' then Result.append_character ('%"') --| "					
						when '%(' then Result.append_character ('%(') --| [
						when '%)' then Result.append_character ('%)') --| ]
						when '%<' then Result.append_character ('%<') --| {
						when '%>' then Result.append_character ('%>') --| }
						when '/' then
							from
								i := i + 1
								c := '%U'
								create t.make_empty
							until
								c = '/' or error
							loop
								if i > l_count - 1 then
									error := True
								else
									c := l_area.item (i)
									if c /= '/' then
										t.extend (c)
									end
								end
								i := i + 1
							end
							if error then
								Result.append_character ('%%')
								Result.append_character ('/')
								Result.append_string (t)
								Result.append_character ('/')
							elseif t.is_natural_32 then
									--| For now %/0x3B/ or %/b1001/ is not yet accepted
								Result.append_code (t.to_natural_32)
							else
								error := True
								Result.append_character ('%%')
								Result.append_character ('/')
								Result.append_string (t)
								Result.append_character ('/')
							end
						else
							error := True
							Result.append_character ('%%')
							Result.append_character (c)
						end
					end
				else
					Result.append_character (c)
				end
				i := i + 1
			end
			last_unescaping_raised_error := error
		end

	unescaped_string_32 (s: STRING_32): STRING_32
			-- Unescaped Eiffel String.
			--| "%%T" -> "%T", "%%N" -> "%N", "%%%%" -> "%%"
			--| but for printable char "%%A" -> "@", "%%(" -> "["
			--| and "%/59/" -> ";"
			--| follow ECMA 8.32.23
		local
			i: INTEGER
			t: STRING_32
			c: CHARACTER_32
			error: BOOLEAN
			l_count: INTEGER
			l_area: SPECIAL [CHARACTER_32]
		do
			from
				last_unescaping_raised_error := False
				l_count := s.count
				l_area := s.area
				create Result.make (l_count)
				--| i := 0
			until
				i >= l_count
			loop
				c := l_area.item (i)
				if c = '%%' then
					if i = l_count - 1 then
						--| Is last character
						error := True
						Result.append_character (c)
					else
						i := i + 1
						c := l_area.item (i)
						inspect c
						when  'A' then Result.append_character ('%A') --| @
						when  'B' then Result.append_character ('%B') --| BS : BackSpace
						when  'C' then Result.append_character ('%C') --| ^
						when  'D' then Result.append_character ('%D') --| $
						when  'F' then Result.append_character ('%F') --| FF : Form Feed
						when  'H' then Result.append_character ('%H') --| \
						when  'L' then Result.append_character ('%L') --| ~
						when  'N' then Result.append_character ('%N') --| NL (LF) : Newline
						when  'Q' then Result.append_character ('%Q') --| `
						when  'R' then Result.append_character ('%R') --| CR
						when  'S' then Result.append_character ('%S') --| #
						when  'T' then Result.append_character ('%T') --| HT : Horizontal Tab
						when  'U' then Result.append_character ('%U') --| NUL : nUll
						when  'V' then Result.append_character ('%V') --| | : Vertical bar
						when '%%' then Result.append_character ('%%') --| %
						when '%'' then Result.append_character ('%'') --| '
						when '%"' then Result.append_character ('%"') --| "					
						when '%(' then Result.append_character ('%(') --| [
						when '%)' then Result.append_character ('%)') --| ]
						when '%<' then Result.append_character ('%<') --| {
						when '%>' then Result.append_character ('%>') --| }
						when '/' then
							from
								i := i + 1
								c := '%U'
								create t.make_empty
							until
								c = '/' or error
							loop
								if i > l_count - 1 then
									error := True
								else
									c := l_area.item (i)
									t.extend (c)
								end
								i := i + 1
							end
							if error then
								Result.append_character ('%%')
								Result.append_character ('/')
								Result.append_string (t)
								Result.append_character ('/')
							elseif t.is_natural_32 then
									--| For now %/0x3B/ or %/b1001/ is not yet accepted
								Result.append_code (t.to_natural_32)
							else
								error := True
								Result.append_character ('%%')
								Result.append_character ('/')
								Result.append_string (t)
								Result.append_character ('/')
							end
						else
							error := True
							Result.append_character ('%%')
							Result.append_character (c)
						end
					end
				else
					Result.append_character (c)
				end
				i := i + 1
			end
			last_unescaping_raised_error := error
		end

feature {NONE} -- Implementation

	char32_to_string_32 (char: CHARACTER_32; a_result: detachable STRING_32; for_string: BOOLEAN): STRING_32
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
			-- If `for_string', do not escape '%'' else do not escape '"'.
			--| If `a_result' /= Void, append char32 representation to `a_result' and return it.
		local
			code: NATURAL_32
		do
			if a_result = Void then
				create Result.make_empty
			else
				Result := a_result
			end

			inspect char
			when '%B' then
				Result.append_character ('%%')
				Result.append_character ('B')
			when '%F' then
				Result.append_character ('%%')
				Result.append_character ('F')
			when '%N' then
				Result.append_character ('%%')
				Result.append_character ('N')
			when '%R' then
				Result.append_character ('%%')
				Result.append_character ('R')
			when '%T' then
				Result.append_character ('%%')
				Result.append_character ('T')
			when '%U' then
				Result.append_character ('%%')
				Result.append_character ('U')
			when '%%' then
				Result.append_character ('%%')
				Result.append_character ('%%')
			when '%'' then
				if for_string then
					Result.append_character (char)
				else
					Result.append_character ('%%')
					Result.append_character ('%'')
				end
			when '%"' then
				if for_string then
					Result.append_character ('%%')
					Result.append_character ('"')
				else
					Result.append_character (char)
				end
			else
				code := char.natural_32_code
				if
					code < {ASCII}.First_printable.to_natural_32 or
					(code > {ASCII}.Last_printable.to_natural_32 and code <= iso_8859_1_apc)
				then
					Result.grow (Result.count + 6)
					Result.append_string_general ("%%/")
					Result.append_natural_32 (code);
					Result.append_character ('/')
				else
					Result.append_code (code)
				end
			end
		ensure
			Result_not_void: Result /= Void
			Result_different: Result /= char32_to_string_32 (char, Void, for_string)
		end

	char_to_string (char: CHARACTER; a_result: detachable STRING; for_string: BOOLEAN): STRING
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
			-- If `for_string', do not escape '%'' else do not escape '"'.
			--| If `a_result' /= Void, append char32 representation to `a_result' and return it.			
		local
			code: INTEGER
		do
			if a_result = Void then
				create Result.make_empty
			else
				Result := a_result
			end

			inspect char
			when '%B' then
				Result.append_character ('%%')
				Result.append_character ('B')
			when '%F' then
				Result.append_character ('%%')
				Result.append_character ('F')
			when '%N' then
				Result.append_character ('%%')
				Result.append_character ('N')
			when '%R' then
				Result.append_character ('%%')
				Result.append_character ('R')
			when '%T' then
				Result.append_character ('%%')
				Result.append_character ('T')
			when '%U' then
				Result.append_character ('%%')
				Result.append_character ('U')
			when '%%' then
				Result.append_character ('%%')
				Result.append_character ('%%')
			when '%'' then
				if for_string then
					Result.append_character (char)
				else
					Result.append_character ('%%')
					Result.append_character ('%'')
				end
			when '%"' then
				if for_string then
					Result.append_character ('%%')
					Result.append_character ('"')
				else
					Result.append_character (char)
				end
			else
				code := char.code;
				if
					code < {ASCII}.First_printable or
					(code > {ASCII}.Last_printable and code <= iso_8859_1_apc.as_integer_32)
				then
					Result.grow (Result.count + 6)
					Result.append_string ("%%/")
					Result.append_integer (code);
					Result.append_character ('/')
				else
					Result.append_string (char.out)
				end
			end
		ensure
			Result_not_void: Result /= Void
			Result_different: Result /= char_to_string (char, Void, for_string)
		end

	iso_8859_1_del: NATURAL_32 = 127
			-- DEL, the first character in the second unprintable section in ISO-8859-1.

	iso_8859_1_apc: NATURAL_32 = 159
			-- APC, the last character in the second unprintable section in ISO-8859-1.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CHARACTER_ROUTINES
