indexing

	description:
		"Commonly used console input and output mechanisms. % 
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CONSOLE inherit

	PLAIN_TEXT_FILE
		rename
			make_open_read as make_open_stdin,
			make_open_write as make_open_stdout
		export
			{NONE} 
				all;
			{ANY}
				separator, append, file_pointer, last_character, last_integer, 
				last_real, last_string, last_double, file_readable,
				lastchar, lastint, lastreal, laststring, lastdouble 
		redefine
			make_open_stdin, make_open_stdout, count, empty, exists,
			read_integer, read_real, read_double, read_character,
			read_line, read_stream, read_word, next_line, put_integer, 
			put_boolean, put_real, put_double, put_string, put_character, 
			new_line, end_of_file, file_close,
			readint, readreal, readdouble, readchar, readline, readstream, 
			readword, putint, putbool, putreal, putdouble, putstring, putchar
		end

creation
	make_open_stdin, make_open_stdout, make_open_stderr

feature -- Initialization

	make_open_stdin (fn: STRING) is
			-- Create an unix standard input file.
		do
			make (fn);
			file_pointer := console_def (0);
			set_read_mode
			!! last_string.make (256)
		end;

	make_open_stdout (fn: STRING) is
			-- Create an unix standard output file.
		do
			make (fn);
			file_pointer := console_def (1);
			set_write_mode;
		end;

	make_open_stderr (fn: STRING) is
			-- Create an unix standard error file.
		do
			make (fn);
			file_pointer := console_def (2);
			set_write_mode;
		end;

feature -- Status report

	end_of_file: BOOLEAN is
			-- Have we reached the end of file?
		do
			Result := console_eof (file_pointer)
		end

	exists: BOOLEAN is
			-- Does file exist?
		do
			Result := true
		end

feature -- Input

	read_integer, readint is
			-- Read a new integer from standard input.
			-- Make result available in `last_integer'.
		do
			last_integer := console_readint (file_pointer)
		end;

	read_real, readreal is
			-- Read a new real from standard input.
			-- Make result available in `last_real'.
		do
			last_real := console_readreal (file_pointer)
		end;

	read_double, readdouble is
			-- Read a new double from standard input.
			-- Make result available in `last_double'.
		do
			last_double := console_readdouble (file_pointer)
		end;

  read_line, readline is
			-- Read a string until new line or end of file.
			-- Make result available in `last_string'.
			-- New line will be consumed but not part of `last_string'.
		require else
			is_readable: file_readable
		local
			str_cap: INTEGER;
			read: INTEGER;  -- Amount of bytes already read
			str_area: ANY
			done: BOOLEAN
		do
			from
				str_area := last_string.to_c;
				str_cap := last_string.capacity;
			until
				done
			loop
				read := read +
					console_readline (file_pointer, $str_area, str_cap, read);
				if read > str_cap then
						-- End of line not reached yet
						--|The string must be consistently set before
						--|resizing.
					last_string.set_count (str_cap);
					last_string.resize (str_cap + 1024);
					str_cap := last_string.capacity;
					read := read - 1;	   -- True amount of byte read
					str_area := last_string.to_c;
				else
					last_string.set_count (read);
					done := true
				end;
			end;
				-- Ensure fair amount of garbage.
			if read < 1024 then
				last_string.resize (read);
			end;
		end;

	read_stream, readstream (nb_char: INTEGER) is
 			-- Read a string of at most `nb_char' bound characters
			-- from standard input.
			-- Make result available in `last_string'.
		local
			new_count: INTEGER
			str_area: ANY
		do
			last_string.resize (nb_char)
			str_area := last_string.to_c
			new_count := console_readstream (file_pointer, $str_area,
nb_char)
			last_string.set_count (new_count)
		end;

	read_word, readword is
			-- Read a new word from standard input.
			-- Make result available in `last_string'.
		local
			str_area: ANY;
			str_cap: INTEGER;
			done: BOOLEAN;
			read: INTEGER;
		do
			from
				str_area := last_string.to_c;
				str_cap := last_string.capacity;
			until
				done
			loop
				read := read +
					console_readword (file_pointer, $str_area, str_cap, read);
				if read > str_cap then
						-- End of word not reached yet
					last_string.resize (str_cap + 1024);
					str_cap := last_string.capacity;
					read := read - 1;	   -- True amount of byte read
			   else
					last_string.set_count (read);
					done := true
				end;
			end;
				-- Ensure fair amount of garbage.
			if read < 1024 then
				last_string.resize (read);
			end;
			separator := console_separator (file_pointer); -- Look ahead
		end;

	read_character, readchar is
			-- Read a new character from standard input.
			-- Make result available in `last_character'.
		do
			last_character := console_readchar (file_pointer)
		end;


	next_line is
			-- Move to next input line on standard input.
		do
			console_next_line (file_pointer)
		end;

feature -- Output 

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at end of default output.
		do
			console_pc (file_pointer, c)
		end;

	put_string, putstring (s: STRING) is
			-- Write `s' at end of default output.
		local
			external_s: ANY;
		do
			if s.count /= 0 then
				external_s := s.to_c;
				console_ps (file_pointer, $external_s, s.count)
			end
		end;

	put_real, putreal (r: REAL) is
			-- Write `r' at end of default output.
		do
			console_pr (file_pointer, r)
		end;

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' at end of default output.
		do
			console_pd (file_pointer, d)
		end;

	put_integer, putint (i: INTEGER) is
			-- Write `i' at end of default output.
		do
			console_pi (file_pointer, i)
		end;

	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' at end of default output.
		do
			if b then
				put_string ("true")
			else
				put_string ("false")
			end 
		end; 

	new_line is
			-- Write line feed at end of default output.
		do
			console_tnwl (file_pointer)
		end;

feature {NONE} -- Implementation

	count: INTEGER is 1;
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

	empty: BOOLEAN is false;
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

	console_def (number: INTEGER): POINTER is
			-- Convert `number' to the corresponding
			-- file descriptor.
		external
			"C"
		end;

	console_eof (file: POINTER): BOOLEAN is
		external
			"C"
		end;

	console_separator (file: POINTER): CHARACTER is
			-- ASCII code of character following last word read
		external
			"C"
		end;

	console_ps (file: POINTER; s_name: POINTER; length: INTEGER) is
			-- Write string `s' at end of `file'
		external
			"C"
		end;

	console_pr (file: POINTER; r: REAL) is
			-- Write real `r' at end of `file'
		external
			"C"
		end;

	console_pc (file: POINTER; c: CHARACTER) is
			-- Write character `c' at end of `file'
		external
			"C"
		end;

	console_pd (file: POINTER; d: DOUBLE) is
			-- Write double `d' at end of `file'
		external
			"C"
		end;

	console_pi (file: POINTER; i: INTEGER) is
			-- Write integer `i' at end of `file'
		external
			"C"
		end;

	console_tnwl (file: POINTER) is
			-- Write a new_line to `file'
		external
			"C"
		end;

	console_readreal (file: POINTER): REAL is
			-- Read a real number from the console
		external
			"C"
		end;
	
	console_readchar (file: POINTER): CHARACTER is
			-- Read a character from the console
		external
			"C"
		end;
	
	console_readint (file: POINTER): INTEGER is
			-- Read an integer from the console
		external
			"C"
		end;
	
	console_readdouble (file: POINTER): DOUBLE is
			-- Read a double from the console
		external
			"C"
		end;
	
	console_readword (file: POINTER; a_string: POINTER; length, begin: INTEGER):
INTEGER is
			-- Read a string excluding white space and stripping
			-- leading white space from `file' into `a_string'.
			-- White space characters are: blank, new_line,
			-- tab, vertical tab, formfeed or end of file.
			-- If it does not fit, result is `length' - `begin' + 1,
			-- otherwise result is number of characters read.
		external
			"C"
		end;

	console_readline (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER is
			-- Read a stream from the console
		external
			"C"
		end;

	console_next_line (file: POINTER) is
			-- Move to next input line on standard input.
		external
			"C"
		end;

	console_readstream (file: POINTER; a_string: POINTER; length: INTEGER): INTEGER is
			-- Read a stream from the console
		external
			"C"
		end;

	file_close (file: POINTER) is
			-- Close `file'
		external
			"C"
		alias
			"console_file_close"
		end
	
end -- class CONSOLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

