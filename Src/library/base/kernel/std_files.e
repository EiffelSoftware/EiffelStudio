indexing

	description:
		"Commonly used input and output mechanisms. %
		%This class may be used as either ancestor or supplier %
		%by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	STD_FILES

feature -- Access

	input: PLAIN_TEXT_FILE is
			-- Standard input file
		once
			!CONSOLE! Result.make_open_stdin ("stdin");
		end;

	output: PLAIN_TEXT_FILE is
			-- Standard output file
		once
			!CONSOLE! Result.make_open_stdout ("stdout");
		end;

	error: PLAIN_TEXT_FILE is
			-- Standard error file
		once
			!CONSOLE! Result.make_open_stderr ("stderr");
		end;

	default_output: PLAIN_TEXT_FILE;
			-- Default output

	standard_default: PLAIN_TEXT_FILE is
			-- Return the `default_output' or `output'
			-- if `default_output' is Void.
			--| Useful if a class inherits from STD_FILES and
			--| and a `putint' is applied without standard setting.
		do
			if default_output = Void then
				Result := output;
			else
				Result := default_output;
			end;
		end;

feature -- Status report

	last_character, lastchar: CHARACTER is
			-- Last character read by `read_character'
		do
			Result := input.last_character
		end;

	last_integer, lastint: INTEGER is
			-- Last integer read by `read_integer'
		do
			Result := input.last_integer
		end;

	last_real, lastreal: REAL is
			-- Last real read by `read_real'
		do
			Result := input.last_real
		end;

	last_string, laststring: STRING is
			-- Last string read by `read_line',
			-- `read_stream', or `read_word'
		do
			Result := input.last_string
		end;

	last_double, lastdouble: DOUBLE is
			-- Last double read by `read_double'
		do
			Result := input.last_double
		end;

feature -- Element change

	set_output_default is
			-- Use standard output as default output.
		do
			default_output := output; 
		end;

	set_error_default is
			-- Use standard error as default output.
		do
			default_output := error;
		end;

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at end of default output.
		do
			console_pc (standard_default.file_pointer, $c)
		end;

	put_string, putstring (s: STRING) is
			-- Write `s' at end of default output.
		require
			s /= Void
		local
			external_s: ANY;
		do
			external_s := s.to_c;
			console_ps (standard_default.file_pointer, $external_s, s.count)
		end;

	put_real, putreal (r: REAL) is
			-- Write `r' at end of default output.
		do
			console_pr (standard_default.file_pointer, r)
		end;

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' at end of default output.
		do
			console_pd (standard_default.file_pointer, d)
		end;

	put_integer, putint (i: INTEGER) is
			-- Write `i' at end of default output.
		do
			console_pi (standard_default.file_pointer, i)
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
			console_tnwl (standard_default.file_pointer)
		end;

feature -- Input

	read_integer, readint is
			-- Read a new integer from standard input.
			-- Make result available in `last_integer'.
		do
			input.read_integer
		end;

	read_real, readreal is
			-- Read a new real from standard input.
			-- Make result available in `last_real'.
		do
			input.read_real
		end;

	read_double, readdouble is
			-- Read a new double from standard input.
			-- Make result available in `last_double'.
		do
			input.read_double
		end;

	read_line, readline is
			-- Read a line from standard input.
			-- Make result available in `last_string'.
		do
			input.read_line
		end;

	read_stream, readstream (nb_char: INTEGER) is
 			-- Read a string of at most `nb_char' bound characters
			-- from standard input.
			-- Make result available in `last_string'.
		do
			input.read_stream (nb_char)
		end;

	read_word, readword is
			-- Read a new word from standard input.
			-- Make result available in `last_string'.
		do
			input.read_word
		end;

	read_character, readchar is
			-- Read a new character from standard input.
			-- Make result available in `last_character'.
		do
			input.read_character
		end;


	next_line is
			-- Move to next input line on standard input.
		do
			input.next_line
		end;

feature {NONE} -- Implementation

	console_pc (file: POINTER; c: CHARACTER) is
			-- Write character `c' at end of `file'
		external
			"C"
		end;

	console_ps (file: POINTER; s_name: ANY; lenght: INTEGER) is
			-- Write string `s' at end of `file'
		external
			"C"
		end;

	console_pr (file: POINTER; r: REAL) is
			-- Write real `r' at end of `file'
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
	
end -- class STD_FILES


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
