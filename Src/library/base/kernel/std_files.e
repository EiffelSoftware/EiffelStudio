indexing

	description: "[
		Commonly used input and output mechanisms.
		This class may be used as either ancestor or supplier
		by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	STD_FILES

feature -- Access

	input: PLAIN_TEXT_FILE is
			-- Standard input file
		once
			create {CONSOLE} Result.make_open_stdin ("stdin")
		end

	output: PLAIN_TEXT_FILE is
			-- Standard output file
		once
			create {CONSOLE} Result.make_open_stdout ("stdout")
		end

	error: PLAIN_TEXT_FILE is
			-- Standard error file
		once
			create {CONSOLE} Result.make_open_stderr ("stderr")
		end

	default_output: PLAIN_TEXT_FILE
			-- Default output

	standard_default: PLAIN_TEXT_FILE is
			-- Return the `default_output' or `output'
			-- if `default_output' is Void.
			--| Useful if a class inherits from STD_FILES and
			--| and a `putint' is applied without standard setting.
		do
			if default_output = Void then
				Result := output
			else
				Result := default_output
			end
		end

feature -- Status report

	last_character, lastchar: CHARACTER is
			-- Last character read by `read_character'
		do
			Result := input.last_character
		end

	last_integer, lastint: INTEGER is
			-- Last integer read by `read_integer'
		do
			Result := input.last_integer
		end

	last_real, lastreal: REAL is
			-- Last real read by `read_real'
		do
			Result := input.last_real
		end

	last_string, laststring: STRING is
			-- Last string read by `read_line',
			-- `read_stream', or `read_word'
		do
			Result := input.last_string
		end

	last_double, lastdouble: DOUBLE is
			-- Last double read by `read_double'
		do
			Result := input.last_double
		end

feature -- Element change

	set_error_default is
			-- Use standard error as default output.
		do
			default_output := error
		end

	set_file_default (f: PLAIN_TEXT_FILE) is
			-- Use `f' as default output.
		require
			valid_argument: f /= Void
			file_open_write: f.is_open_write
		do
			default_output := f
		end

	set_output_default is
			-- Use standard output as default output.
		do
			default_output := output
		end

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at end of default output.
		do
			standard_default.put_character (c)
		end

	put_string, putstring (s: STRING) is
			-- Write `s' at end of default output.
		require
			string_not_void: s /= Void
		do
			standard_default.put_string (s)
		end

	put_real, putreal (r: REAL) is
			-- Write `r' at end of default output.
		do
			standard_default.put_real (r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' at end of default output.
		do
			standard_default.put_double (d)
		end

	put_integer, putint (i: INTEGER) is
			-- Write `i' at end of default output.
		do
			standard_default.put_integer (i)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' at end of default output.
		do
			if b then
				put_string ("True")
			else
				put_string ("False")
			end
		end

	put_new_line, new_line is
			-- Write line feed at end of default output.
		do
			standard_default.new_line
		end

feature -- Input

	read_integer, readint is
			-- Read a new integer from standard input.
			-- Make result available in `last_integer'.
		do
			input.read_integer
		end

	read_real, readreal is
			-- Read a new real from standard input.
			-- Make result available in `last_real'.
		do
			input.read_real
		end

	read_double, readdouble is
			-- Read a new double from standard input.
			-- Make result available in `last_double'.
		do
			input.read_double
		end

	read_line, readline is
			-- Read a line from standard input.
			-- Make result available in `last_string'.
		do
			input.read_line
		end

	read_stream, readstream (nb_char: INTEGER) is
 			-- Read a string of at most `nb_char' bound characters
			-- from standard input.
			-- Make result available in `last_string'.
		do
			input.read_stream (nb_char)
		end

	read_word, readword is
			-- Read a new word from standard input.
			-- Make result available in `last_string'.
		do
			input.read_word
		end

	read_character, readchar is
			-- Read a new character from standard input.
			-- It will not return until read operation is
			-- terminated when enter key is pressed.
			-- Make result available in `last_character'.
			-- `last_character' will also contains platform
			-- specific newline character.
		do
			input.read_character
		end

	to_next_line, next_line is
			-- Move to next input line on standard input.
		do
			input.next_line
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class STD_FILES


