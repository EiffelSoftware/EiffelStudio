class

	CHARACTER_ROUTINES

inherit

	ASCII

feature

	char_text (char: CHARACTER): STRING is
			-- "Readable" representation of `char' using
			-- special character convention when necessary;
			-- Syntactically correct when quoted
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
			when '%"' then
				Result := "%%%""
			else
				code := char.code;
				if code < First_printable or code > Last_printable then
					!! Result.make (6);
					Result.append ("%%/");
					Result.append_integer (code);
					Result.extend ('/')
				else
					Result := char.out
				end
			end
		end;

end -- class CHARACTER_ROUTINES
