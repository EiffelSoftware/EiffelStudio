indexing

	description:

		"Text output files containing extended ASCII characters %
		%(8-bit code between 0 and 255). The character '%%N' is %
		%automatically converted to the line separtor of %
		%the underlying file system when written to the file."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_TEXT_OUTPUT_FILE

inherit

	KI_TEXT_OUTPUT_FILE

		undefine
			copy
		end


	KL_OUTPUT_FILE

		redefine




			put_character,
			put_string

		end




























































create

	make

feature -- Access

	eol: STRING is "%N"
			-- Line separator


feature -- Output

	put_character (c: CHARACTER) is
			-- Write `c' to output file.
		do
			if c = '%N' and then operating_system.is_windows then
					-- Windows.
				old_put_character ('%R')
			end
			old_put_character (c)
		end

	put_string (a_string: STRING) is
			-- Write `a_string' to output file.
		local
			i, nb: INTEGER
			c: CHARACTER
			a_string_string: STRING
		do
			a_string_string := STRING_.as_string (a_string)
			if operating_system.is_windows then
					-- Windows.
				nb := a_string_string.count
				from i := 1 until i > nb loop
					c := a_string_string.item (i)
					if c = '%N' then
						old_put_character ('%R')
					end
					old_put_character (c)
					i := i + 1
				end
			else
				old_put_string (a_string_string)
			end
		end





















































end
