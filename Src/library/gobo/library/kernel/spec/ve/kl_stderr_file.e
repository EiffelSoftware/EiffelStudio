indexing

	description:

		"Standard error files containing extended ASCII characters %
		%(8-bit code between 0 and 255). The character '%N' is automatically %
		%converted to the line separtor of the underlying file system %
		%when written to the standard error file."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_STDERR_FILE

inherit

	KI_TEXT_OUTPUT_STREAM

		undefine
			copy
		end


	KL_OPERATING_SYSTEM
		export
			{NONE} all

		undefine
			copy

		end



































	FILE
		rename
			make as old_make,
			put_character as old_put_character,
			put_string as old_put_string,
			put_boolean as old_put_boolean,
			put_integer as old_put_integer,
			is_open_write as old_is_open_write,
			close as old_close
		export
			{NONE} all
		redefine
			dispose
		end


create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new standard error file.
		do








			make_open_stderr
			name := "stderr"

		ensure
			name_set: name.is_equal ("stderr")
			is_open_write: is_open_write
		end

feature -- Access

	eol: STRING is "%N"
			-- Line separator






feature -- Status report

	is_open_write: BOOLEAN is
			-- Is standard error file opened in write mode?
		do
			Result := old_is_open_write
		end

feature -- Output

	put_character (c: CHARACTER) is
			-- Write `c' to standard error file.
		do

			if is_windows and then c = '%N' then
					-- Windows.
				old_put_character ('%R')
			end

			old_put_character (c)
		end

	put_string (a_string: STRING) is
			-- Write `a_string' to standard error file.
			-- Note: If `a_string' is a UC_STRING or descendant, then
			-- write the bytes of its associated UTF unicode encoding.
		local
			a_string_string: STRING

			i, nb: INTEGER
			c: CHARACTER

		do
			a_string_string := STRING_.as_string (a_string)

			if is_windows then
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

feature -- Basic operations

	flush is
			-- Flush buffered data to disk.
		do



		end


feature {NONE} -- GC

	dispose is
			-- Do not close standard error file.
		do
			handle := INVALID_HANDLE_VALUE
		end


end
