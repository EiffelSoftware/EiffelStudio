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
			Result := char_to_string (char, False).twin
		ensure
			char_text_not_void: Result /= Void
			refactoring_correct: Result.is_equal (old_char_text (char))
		end

	eiffel_string (s: STRING): STRING is
			-- "eiffel" representation of `s'
			-- Translation of special characters
		require
			s_not_void: s /= Void
		local
			value_area: SPECIAL [CHARACTER];
			i, value_count: INTEGER;
		do
			from
				value_area := s.area;
				value_count := s.count
				create Result.make (value_count);
			until
				i >= value_count
			loop
				Result.append (char_to_string (value_area.item (i), True));
				i := i + 1
			end
		ensure
			eiffel_string_not_void: Result /= Void
		end

feature {NONE} -- Implementation

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
				or else char = '%R' or else char = '%F'
				or else char = '%B' or else char = esc_char
			then
				Result := special_chars.item (char)
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
			char_to_string_not_void: Result /= Void
		end

	special_chars: HASH_TABLE [STRING, CHARACTER] is
			-- List of characters that need escaping.
		once
			create Result.make (8)
			Result.put ("%%N", '%N')
			Result.put ("%%T", '%T')
			Result.put ("%%%%", '%%')
			Result.put ("%%R", '%R')
			Result.put ("%%F", '%F')
			Result.put ("%%B", '%B')
			Result.put ("%%'", '%'')
			Result.put ("%%%"", '"')
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
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
