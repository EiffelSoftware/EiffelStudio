indexing
	description: "Routines for use by classes that need to print eiffel strings and characters."
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_ROUTINES

inherit
	ASCII

feature -- Access

	char_text (char: CHARACTER): STRING is
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
		do
			Result := clone (char_to_string (char, False))
		ensure
			refactoring_correct: Result.is_equal (old_char_text (char))
		end

	eiffel_string (s: STRING): STRING is
			-- "eiffel" representation of `s'
			-- Translation of special characters
		local
			value_area: SPECIAL [CHARACTER];
			i, value_count: INTEGER;
		do
			from
				value_area := s.area;
				value_count := s.count
				!! Result.make (value_count);
			until
				i >= value_count
			loop
				Result.append (char_to_string (value_area.item (i), True));
				i := i + 1
			end;
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
				if code < First_printable then
					create Result.make (6)
					Result.append ("%%/")
					Result.append_integer (code)
					Result.extend ('/')
				else
					Result := char.out
				end
			end
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
				if code < First_printable then
					!! Result.make (6);
					Result.append ("%%/");
					Result.append_integer (code);
					Result.extend ('/')
				else
					Result := char.out
				end
			end
		end

end -- class CHARACTER_ROUTINES
