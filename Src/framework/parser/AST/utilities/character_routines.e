indexing
	description: "Routines for use by classes that need to print eiffel strings and characters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_ROUTINES

feature -- Access

	char_text (char: CHARACTER): STRING is
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
		do
			Result := char_to_string (char, False)
		ensure
			char_text_not_void: Result /= Void
			refactoring_correct: Result.is_equal (old_char_text (char))
		end

	wchar_text (wchar: WIDE_CHARACTER): STRING_32 is
			-- "Readable" representation of `wchar' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
		do
			Result := code_to_string_32 (wchar.natural_32_code, False)
		ensure
			wchar_text_not_void: Result /= Void
		end

	eiffel_string (s: STRING): STRING is
			-- "eiffel" representation of `s'
			-- Translation of special characters
		require
			s_not_void: s /= Void
		local
			value_char_area: SPECIAL [CHARACTER];
			i, value_count: INTEGER;
		do
			from
				value_char_area := s.area;
				value_count := s.count
				create Result.make (value_count);
			until
				i >= value_count
			loop
				Result.append (char_to_string (value_char_area.item (i), True));
				i := i + 1
			end
		ensure
			eiffel_string_not_void: Result /= Void
		end

	eiffel_string_32 (s: STRING_32): STRING_32 is
			-- "eiffel" representation of `s'
			-- Translation of special characters
		require
			s_not_void: s /= Void
		local
			value_wchar_area: SPECIAL [WIDE_CHARACTER];
			i, value_count: INTEGER;
		do
			from
				value_wchar_area := s.area;
				value_count := s.count
				create Result.make (value_count)
			until
				i >= value_count
			loop
				Result.append (code_to_string_32 (value_wchar_area.item (i).natural_32_code, True));
				i := i + 1
			end
		ensure
			eiffel_string_32_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	code_to_string_32 (code: NATURAL_32; for_string: BOOLEAN): STRING_32 is
			-- "Readable" representation of `code' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
			-- If `for_string', do not escape '%'' else do not escape '"'.
		local
			esc_char: CHARACTER
		do
			if for_string then
				esc_char := '"'
			else
				esc_char := '%''
			end
			if
				code = ('%N').natural_32_code
				or else code = ('%T').natural_32_code
				or else code = ('%%').natural_32_code
				or else code = ('%R').natural_32_code
				or else code = ('%F').natural_32_code
				or else code = ('%B').natural_32_code
				or else code = esc_char.natural_32_code
			then
					-- Conversion is taking place here, no need for twin.
				Result := special_chars.item (code)
			elseif code = ('%U').natural_32_code then
				Result := "%%U"
			else
				if code < {ASCII}.First_printable.to_natural_32 then
					create Result.make (6)
					Result.append ("%%/")
					Result.append_code (code)
					Result.extend ('/')
				else
					create Result.make (1)
					Result.append_code (code)
				end
			end
		ensure
			Result_not_void: Result /= Void
			Result_different: Result /= code_to_string_32 (code, for_string)
		end

	char_to_string (char: CHARACTER; for_string: BOOLEAN): STRING is
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
			-- If `for_string', do not escape '%'' else do not escape '"'.
		local
			code: INTEGER
			esc_char: CHARACTER
		do
			if for_string then
				esc_char := '"'
			else
				esc_char := '%''
			end
			if
				char = '%N' or else char = '%T'
				or else char = '%%'
				or else char = '%R'
				or else char = '%F'
				or else char = '%B'
				or else char = esc_char
			then
				create Result.make_from_string (special_chars.item (char.natural_32_code))
			elseif char = '%U' then
				Result := "%%U"
			else
				code := char.code;
				if code < {ASCII}.First_printable then
					create Result.make (6)
					Result.append ("%%/")
					Result.append_integer (code)
					Result.extend ('/')
				else
					Result := char.out
				end
			end
		ensure
			Result_not_void: Result /= Void
			Result_different: Result /= char_to_string (char, for_string)
		end

	special_chars: HASH_TABLE [STRING, NATURAL_32] is
			-- List of characters that need escaping.
		once
			create Result.make (8)
			Result.put ("%%N", ('%N').natural_32_code)
			Result.put ("%%T", ('%T').natural_32_code)
			Result.put ("%%%%",('%%').natural_32_code)
			Result.put ("%%R", ('%R').natural_32_code)
			Result.put ("%%F", ('%F').natural_32_code)
			Result.put ("%%B", ('%B').natural_32_code)
			Result.put ("%%'", ('%'').natural_32_code)
			Result.put ("%%%"", ('"').natural_32_code)
		ensure
			special_chars_not_void: Result /= Void
		end

	old_char_text (char: CHARACTER): STRING is
			-- Kept for checking the new implementation.
		local
			code: INTEGER
		do
			inspect char
			when '%B' then
				Result := "%%B"
			when '%F' then
				Result := "%%F"
			when '%N' then
				Result := "%%N"
			when '%R' then
				Result := "%%R"
			when '%T' then
				Result := "%%T"
			when '%U' then
				Result := "%%U"
			when '%%' then
				Result := "%%%%"
			when '%'' then
				Result := "%%%'"
--			when '%"' then
--				Result := "%%%""
			else
				code := char.code;
				if code < {ASCII}.First_printable then
					create Result.make (6);
					Result.append ("%%/");
					Result.append_integer (code);
					Result.extend ('/')
				else
					Result := char.out
				end
			end
		ensure
			old_char_text_not_void: Result /= Void
		end

indexing
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

end -- class CHARACTER_ROUTINES
