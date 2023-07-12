note
	description: "[
		Commonly used input and output mechanisms.
		This class may be used as either ancestor or supplier
		by classes needing its facilities.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STD_FILES

inherit
	FILE

feature -- Status report

	last_character, lastchar: CHARACTER
			-- Last character read by `read_character'
		do
		end

	last_integer, lastint, last_integer_32: INTEGER
			-- Last integer read by `read_integer'
		do
		end

	last_integer_8: INTEGER_8
			-- Last 8-bit integer read by `read_integer_8'
		do
		end

	last_integer_16: INTEGER_16
			-- Last 16-bit integer read by `read_integer_16'
		do
		end

	last_integer_64: INTEGER_64
			-- Last 8-bit integer read by `read_integer_64'
		do
		end

	last_natural_8: NATURAL_8
			-- Last 8-bit natural read by `read_natural_8'
		do
		end

	last_natural_16: NATURAL_16
			-- Last 16-bit natural read by `read_natural_16'
		do
		end

	last_natural, last_natural_32: NATURAL_32
			-- Last 32-bit natural read by `read_natural_32'
		do
		end

	last_natural_64: NATURAL_64
			-- Last 64-bit natural read by `read_natural_64'
		do
		end

	last_real, lastreal: REAL
			-- Last real read by `read_real'
		do
		end

	last_string, laststring: STRING
			-- Last string read by `read_line',
			-- `read_stream', or `read_word'
		do
			create Result.make (10)
		end

	last_double, lastdouble: DOUBLE
			-- Last double read by `read_double'
		do
		end

feature -- Element change

	set_output_default
			-- Use standard output as default output.
		do
		end

	put_character, putchar (c: CHARACTER)
			-- Write `c' at end of default output.
		do
			put_string (c.out)
		end

	putstring (s: STRING)
			-- Write `s' at current position.
		do
			put_string (s)
		end		

	put_real, putreal (r: REAL)
			-- Write `r' at end of default output.
		do
			put_string (r.out)
		end

	put_double, putdouble (d: DOUBLE)
			-- Write `d' at end of default output.
		do
			put_string (d.out)
		end

	put_integer, putint, put_integer_32 (i: INTEGER)
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end

	put_integer_8 (i: INTEGER_8)
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end

	put_integer_16 (i: INTEGER_16)
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end

	put_integer_64 (i: INTEGER_64)
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end

	put_natural_8 (n: NATURAL_8)
			-- Write `n' at end of default output.
		do
			put_string (n.out)
		end

	put_natural_16 (n: NATURAL_16)
			-- Write `n' at end of default output.
		do
			put_string (n.out)
		end

	put_natural, put_natural_32 (n: NATURAL_32)
			-- Write `n' at end of default output.
		do
			put_string (n.out)
		end

	put_natural_64 (n: NATURAL_64)
			-- Write `n' at end of default output.
		do
			put_string (n.out)
		end

	put_boolean, putbool (b: BOOLEAN)
			-- Write `b' at end of default output.
		do
			if b then
				put_string ("True")
			else
				put_string ("False")
			end
		end

	put_new_line, new_line
			-- Write line feed at end of default output.
		do
			put_character ('%N')
		end

feature -- Input

	read_integer, readint, read_integer_32
			-- Read a new 32-bit integer from standard input.
			-- Make result available in `last_integer'.
		do
		end

	read_integer_8
			-- Read a new 8-bit integer from standard input.
			-- Make result available in `last_integer_8'.
		do
		end

	read_integer_16
			-- Read a new 16-bit integer from standard input.
			-- Make result available in `last_integer_16'.
		do
		end

	read_integer_64
			-- Read a new 64-bit integer from standard input.
			-- Make result available in `last_integer_64'.
		do
		end

	read_natural_8
			-- Read a new 8-bit natural from standard input.
			-- Make result available in `last_natural_8'.
		do
		end

	read_natural_16
			-- Read a new 16-bit natural from standard input.
			-- Make result available in `last_natural_16'.
		do
		end

	read_natural, read_natural_32
			-- Read a new 32-bit natural from standard input.
			-- Make result available in `last_natural'.
		do
		end

	read_natural_64
			-- Read a new 64-bit natural from standard input.
			-- Make result available in `last_natural_64'.
		do
		end

	read_real, readreal
			-- Read a new real from standard input.
			-- Make result available in `last_real'.
		do
		end

	read_double, readdouble
			-- Read a new double from standard input.
			-- Make result available in `last_double'.
		do
		end

	read_line, readline
			-- Read a line from standard input.
			-- Make result available in `last_string'.
		do
		ensure
			last_string_not_void: last_string /= Void
		end

	read_stream, readstream (nb_char: INTEGER)
 			-- Read a string of at most `nb_char' bound characters
			-- from standard input.
			-- Make result available in `last_string'.
		do
		ensure
			last_string_not_void: last_string /= Void
		end

	read_word, readword
			-- Read a new word from standard input.
			-- Make result available in `last_string'.
		do
		ensure
			last_string_not_void: last_string /= Void
		end

	read_character, readchar
			-- Read a new character from standard input.
			-- It will not return until read operation is
			-- terminated when enter key is pressed.
			-- Make result available in `last_character'.
			-- `last_character' will also contains platform
			-- specific newline character.
		do
		end

	to_next_line, next_line
			-- Move to next input line on standard input.
		do
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
