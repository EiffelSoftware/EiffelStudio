class TEST

create
	make

feature

	make
		local
			s: STRING_32
		do
				-- U+0009 character tabulation
			-- U+000A line feed
			-- U+000B line tabulation
			-- U+000C form feed
			-- U+000D carriage return
			 -- U+0020 space
			 -- U+00A0 no-break space
			 -- U+1680 ogham space mark
			 -- U+2000 en quad
			 -- U+2001 em quad
			 -- U+2002 en space
			 -- U+2003 em space
			 -- U+2004 three-per-em space
			 -- U+2005 four-per-em space
			 -- U+2006 six-per-em space
			 -- U+2007 figure space
			 -- U+2008 punctuation space
			 -- U+2009 thin space
			 -- U+200A hair space
			 -- U+202F narrow no-break space
			 -- U+205F medium mathematical space
			　-- U+3000 ideographic space
			s := {STRING_32} "	                　"
			report_string (0x0009, s, 1)
			report_string (0x000B, s, 2)
			report_string (0x000C, s, 3)
			report_string (0x0020, s, 4)
			report_string (0x00A0, s, 5)
			report_string (0x1680, s, 6)
			report_string (0x2000, s, 7)
			report_string (0x2001, s, 8)
			report_string (0x2002, s, 9)
			report_string (0x2003, s, 10)
			report_string (0x2004, s, 11)
			report_string (0x2005, s, 12)
			report_string (0x2006, s, 13)
			report_string (0x2007, s, 14)
			report_string (0x2008, s, 15)
			report_string (0x2009, s, 16)
			report_string (0x200A, s, 17)
			report_string (0x202F, s, 18)
			report_string (0x205F, s, 19)
			report_string (0x3000, s, 20)
			report_character (0x0009, {CHARACTER_32} '	', 1)
			report_character (0x000B, {CHARACTER_32} '', 2)
			report_character (0x000C, {CHARACTER_32} '', 3)
			report_character (0x0020, {CHARACTER_32} ' ', 4)
			report_character (0x00A0, {CHARACTER_32} ' ', 5)
			report_character (0x1680, {CHARACTER_32} ' ', 6)
			report_character (0x2000, {CHARACTER_32} ' ', 7)
			report_character (0x2001, {CHARACTER_32} ' ', 8)
			report_character (0x2002, {CHARACTER_32} ' ', 9)
			report_character (0x2003, {CHARACTER_32} ' ', 10)
			report_character (0x2004, {CHARACTER_32} ' ', 11)
			report_character (0x2005, {CHARACTER_32} ' ', 12)
			report_character (0x2006, {CHARACTER_32} ' ', 13)
			report_character (0x2007, {CHARACTER_32} ' ', 14)
			report_character (0x2008, {CHARACTER_32} ' ', 15)
			report_character (0x2009, {CHARACTER_32} ' ', 16)
			report_character (0x200A, {CHARACTER_32} ' ', 17)
			report_character (0x202F, {CHARACTER_32} ' ', 18)
			report_character (0x205F, {CHARACTER_32} ' ', 19)
			report_character (0x3000, {CHARACTER_32} '　', 20)
		end

feature {NONE} -- Output

	report_string (c: NATURAL_32; s: STRING_32; n: like {STRING_32}.lower)
			-- Report if character with code `c` is at position `n` in string `s`.
		do
			io.put_string ("Test string #")
			io.put_integer (n)
			io.put_string (": ")
			io.put_boolean (s [n].natural_32_code = c)
			io.put_new_line
		end

	report_character (n: NATURAL_32; c: CHARACTER_32; t: INTEGER)
			-- Report if character `c` has code `n` in test `t`.
		do
			io.put_string ("Test character #")
			io.put_integer (t)
			io.put_string (": ")
			io.put_boolean (c.natural_32_code = n)
			io.put_new_line
		end

end
