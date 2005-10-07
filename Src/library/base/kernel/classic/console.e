indexing

	description: "[
		Commonly used console input and output mechanisms. 
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CONSOLE inherit

	PLAIN_TEXT_FILE
		rename
			make_open_read as make_open_stdin,
			make_open_write as make_open_stdout
		export
			{NONE}
				all
			{CONSOLE} open_read, close
			{ANY}
				separator, append, file_pointer, last_character, last_integer,
				last_integer_32, last_integer_8, last_integer_16, last_integer_64,
				last_natural_8, last_natural_16, last_natural, last_natural_32,
				last_natural_64,
				last_real, last_string, last_double, file_readable,
				lastchar, lastint, lastreal, laststring, lastdouble,
				readable, is_closed, extendible, is_open_write,
				last_read_number_overflowed, last_read_number_above_range, 
				last_read_number_below_range, last_read_number_correct
		redefine
			make_open_stdin, make_open_stdout, count, is_empty, exists,
			 read_real, read_double, read_character,
			read_line, read_stream, read_word, next_line, 
			put_boolean, put_real, put_double, put_string, put_character,
			put_new_line, new_line, end_of_file, file_close,
			readreal, readdouble, readchar, readline, readstream,
			readword, putbool, putreal, putdouble, putstring, putchar,
			dispose, read_to_string,
			read_integer_8, read_integer_16, readint, read_integer, read_integer_32, read_integer_64,
			read_natural_8, read_natural_16, read_natural, read_natural_32, read_natural_64,
			put_integer_8, put_integer_16, putint, put_integer, put_integer_32, put_integer_64,
			put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64

			
		end

	ANY

create {STD_FILES}
	make_open_stdin, make_open_stdout, make_open_stderr

feature -- Initialization

	make_open_stdin (fn: STRING) is
			-- Create an unix standard input file.
		do
			make (fn)
			file_pointer := console_def (0)
			set_read_mode
		end

	make_open_stdout (fn: STRING) is
			-- Create an unix standard output file.
		do
			make (fn)
			file_pointer := console_def (1)
			set_write_mode
		end

	make_open_stderr (fn: STRING) is
			-- Create an unix standard error file.
		do
			make (fn)
			file_pointer := console_def (2)
			set_write_mode
		end

feature -- Status report

	end_of_file: BOOLEAN is
			-- Have we reached the end of file?
		do
			Result := console_eof (file_pointer)
		end

	exists: BOOLEAN is
			-- Does file exist?
		do
			Result := True
		end

	count: INTEGER is 1
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

feature -- Removal

	dispose is
			-- This is closed by the operating system at completion.
		do
			-- file_close (file_pointer)
		end

feature -- Input

--	read_integer, readint is
--			-- Read a new integer from standard input.
--			-- Make result available in `last_integer'.
--		do
--			last_integer := console_readint (file_pointer)
--		end
		
	read_integer_8 is
			-- Read a new 8-bit integer from standard input.
			-- Make result available in `last_integer_8'. 
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_integer_8 := str.to_integer_8			
			set_flags_after_conversion (str)
		end		
		
	read_integer_16 is
			-- Read a new 16-bit integer from standard input.
			-- Make result available in `last_integer_16'. 
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_integer_16 := str.to_integer_16
			set_flags_after_conversion (str)
		end	
		
	read_integer, readint, read_integer_32 is
			-- Read a new 32-bit integer from standard input.
			-- Make result available in `last_integer'. 
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_integer := str.to_integer_32
			set_flags_after_conversion (str)
		end	
		
	read_integer_64 is
			-- Read a new 64-bit integer from standard input.
			-- Make result available in `last_integer_64'. 
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_integer_64 := str.to_integer_64
			set_flags_after_conversion (str)
		end	
		
	read_natural_64 is
			-- Read a new 64-bit natural from standard input.
			-- Make result available in `last_natural_64'. 
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_natural_64 := str.to_natural_64
			set_flags_after_conversion (str)
		end		

	read_natural, read_natural_32 is
			-- Read a new 32-bit natural from standard input.
			-- Make result available in `last_natural'. 
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_natural := str.to_natural_32
			set_flags_after_conversion (str)
		end				

	read_natural_16 is
			-- Read a new 16-bit natural from standard input.
			-- Make result available in `last_natural_16'.  
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_natural_16 := str.to_natural_16
			set_flags_after_conversion (str)
		end	
		
	read_natural_8 is
			-- Read a new 8-bit natural from standard input.
			-- Make result available in `last_natural_8'.  
		local
			str: STRING
		do
			str := read_console_integer_with_no_type
			last_natural_8 := str.to_natural_8
			set_flags_after_conversion (str)
		end			

	read_real, readreal is
			-- Read a new real from standard input.
			-- Make result available in `last_real'.
		do
			last_real := console_readreal (file_pointer)
		end

	read_double, readdouble is
			-- Read a new double from standard input.
			-- Make result available in `last_double'.
		do
			last_double := console_readdouble (file_pointer)
		end

	read_line, readline is
			-- Read a string until new line or end of file.
			-- Make result available in `last_string'.
			-- New line will be consumed but not part of `last_string'.
		require else
			is_readable: file_readable
		local
			str_cap: INTEGER
			read: INTEGER -- Amount of bytes already read
			str_area: ANY
			done: BOOLEAN
		do
			from
				if last_string = Void then
					create_last_string (0)
				end
				str_area := last_string.area
				str_cap := last_string.capacity
			until
				done
			loop
				read := read +
					console_readline (file_pointer, $str_area, str_cap, read)
				if read > str_cap then
						-- End of line not reached yet
						--|The string must be consistently set before
						--|resizing.
					last_string.set_count (str_cap)
					if str_cap < 2048 then
						last_string.grow (str_cap + 1024)
					else
							-- Increase capacity by `Growth_percentage' as
							-- defined in RESIZABLE.
						last_string.automatic_grow
					end
					str_area := last_string.area
					str_cap := last_string.capacity
					read := read - 1	-- True amount of byte read
				else
					last_string.set_count (read)
					done := True
				end
			end
				-- Ensure fair amount of garbage.
			if read < 1024 then
				last_string.resize (read)
			end
		end

	read_stream, readstream (nb_char: INTEGER) is
 			-- Read a string of at most `nb_char' bound characters
			-- from standard input.
			-- Make result available in `last_string'.
		local
			new_count: INTEGER
			str_area: ANY
		do
			if last_string = Void then
				create_last_string (nb_char)
			else
				last_string.grow (nb_char)
			end
			str_area := last_string.area
			new_count := console_readstream (file_pointer, $str_area, nb_char)
			last_string.set_count (new_count)
		end

	read_word, readword is
			-- Read a new word from standard input.
			-- Make result available in `last_string'.
		local
			str_area: ANY
			str_cap: INTEGER
			done: BOOLEAN
			read: INTEGER
		do
			from
				if last_string = Void then
					create_last_string (0)
				end
				str_area := last_string.area
				str_cap := last_string.capacity
			until
				done
			loop
				read := read +
					console_readword (file_pointer, $str_area, str_cap, read)
				if read > str_cap then
						-- End of word not reached yet
					if str_cap < 2048 then
						last_string.grow (str_cap + 1024)
					else
							-- Increase capacity by `Growth_percentage' as
							-- defined in RESIZABLE.
						last_string.automatic_grow
					end
					str_area := last_string.area
					str_cap := last_string.capacity
					read := read - 1	-- True amount of byte read
				else
					last_string.set_count (read)
					done := True
				end
			end
				-- Ensure fair amount of garbage.
			if read < 1024 then
				last_string.resize (read)
			end
			separator := console_separator (file_pointer) -- Look ahead
		end

	read_character, readchar is
			-- Read a new character from standard input.
			-- Make result available in `last_character'.
		do
			last_character := console_readchar (file_pointer)
		end


	next_line is
			-- Move to next input line on standard input.
		do
			console_next_line (file_pointer)
		end

feature -- Output

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at end of default output.
		do
			console_pc (file_pointer, c)
		end

	put_string, putstring (s: STRING) is
			-- Write `s' at end of default output.
		local
			external_s: ANY
		do
			if s.count /= 0 then
				external_s := s.area
				console_ps (file_pointer, $external_s, s.count)
			end
		end

	put_real, putreal (r: REAL) is
			-- Write `r' at end of default output.
		do
			console_pr (file_pointer, r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' at end of default output.
		do
			console_pd (file_pointer, d)
		end
		
	put_integer_64 (i: INTEGER_64) is
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end
		
	put_integer, put_integer_32, putint (i: INTEGER) is
			-- Write `i' at end of default output. 
		do
			put_string (i.out)
		end
		
				
	put_integer_16 (i: INTEGER_16) is
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end
		
	put_integer_8 (i: INTEGER_8) is
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end
	
	put_natural_8 (i: NATURAL_8) is		
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end
		
	put_natural_16 (i: NATURAL_16) is		
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end
		
	put_natural, put_natural_32 (i: NATURAL_32) is		
			-- Write `i' at end of default output.
		do
			put_string (i.out)
		end

	put_natural_64 (i: NATURAL_64) is		
			-- Write `i' at end of default output. 
		do
			put_string (i.out)
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
			console_tnwl (file_pointer)
		end

feature {NONE} -- Inapplicable


	is_empty: BOOLEAN is False
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

feature {NONE} -- Implementation

	read_console_integer_with_no_type: STRING is
			-- Read a number which is at most `number_length' bytes long 
			-- from console. 
		local
			read: INTEGER -- Amount of bytes already read
			str_area: ANY
		do
			create Result.make (100)
			str_area := Result.area

			read := console_readline (file_pointer, $str_area, number_length, 0)
			if read > number_length then
				Result.set_count (number_length)
			else	
				Result.set_count (read)
			end
		end
		
	number_length: INTEGER is 100
			-- Maximum bytes used when read an integer or natural from console

	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER is
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		do
			Result := file_gss (file_pointer, a_string.area.item_address (pos - 1), nb)
		end

	console_def (number: INTEGER): POINTER is
			-- Convert `number' to the corresponding
			-- file descriptor.
		external
			"C | %"eif_console.h%""
		end

	console_eof (file: POINTER): BOOLEAN is
		external
			"C (FILE *): EIF_BOOLEAN | %"eif_console.h%""
		end

	console_separator (file: POINTER): CHARACTER is
			-- ASCII code of character following last word read
		external
			"C (FILE *): EIF_CHARACTER | %"eif_console.h%""
		end

	console_ps (file: POINTER; s_name: POINTER; length: INTEGER) is
			-- Write string `s' at end of `file'
		external
			"C (FILE *, char *, EIF_INTEGER) | %"eif_console.h%""
		end

	console_pr (file: POINTER; r: REAL) is
			-- Write real `r' at end of `file'
		external
			"C (FILE *, EIF_REAL) | %"eif_console.h%""
		end

	console_pc (file: POINTER; c: CHARACTER) is
			-- Write character `c' at end of `file'
		external
			"C (FILE *, EIF_CHARACTER) | %"eif_console.h%""
		end

	console_pd (file: POINTER; d: DOUBLE) is
			-- Write double `d' at end of `file'
		external
			"C (FILE *, EIF_DOUBLE) | %"eif_console.h%""
		end

	console_pi (file: POINTER; i: INTEGER) is
			-- Write integer `i' at end of `file'
		external
			"C (FILE *, EIF_INTEGER) | %"eif_console.h%""
		end

	console_tnwl (file: POINTER) is
			-- Write a new_line to `file'
		external
			"C (FILE *) | %"eif_console.h%""
		end

	console_readreal (file: POINTER): REAL is
			-- Read a real number from the console
		external
			"C blocking signature (FILE *): EIF_REAL use %"eif_console.h%""
		end

	console_readchar (file: POINTER): CHARACTER is
			-- Read a character from the console
		external
			"C blocking signature (FILE *): EIF_CHARACTER use %"eif_console.h%""
		end

	console_readint (file: POINTER): INTEGER is
			-- Read an integer from the console
		external
			"C blocking signature (FILE *): EIF_INTEGER use %"eif_console.h%""
		end

	console_readdouble (file: POINTER): DOUBLE is
			-- Read a double from the console
		external
			"C blocking signature (FILE *): EIF_DOUBLE use %"eif_console.h%""
		end

	console_readword (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER is
			-- Read a string excluding white space and stripping
			-- leading white space from `file' into `a_string'.
			-- White space characters are: blank, new_line,
			-- tab, vertical tab, formfeed or end of file.
			-- If it does not fit, result is `length' - `begin' + 1,
			-- otherwise result is number of characters read.
		external
			"C blocking signature (FILE *, char *, EIF_INTEGER, EIF_INTEGER): EIF_INTEGER use %"eif_console.h%""
		end

	console_readline (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER is
			-- Read a stream from the console
		external
			"C blocking signature (FILE *, char *, EIF_INTEGER, EIF_INTEGER): EIF_INTEGER use %"eif_console.h%""
		end

	console_next_line (file: POINTER) is
			-- Move to next input line on standard input.
		external
			"C blocking signature (FILE *) use %"eif_console.h%""
		end

	console_readstream (file: POINTER; a_string: POINTER; length: INTEGER): INTEGER is
			-- Read a stream from the console
		external
			"C blocking signature (FILE *, char *, EIF_INTEGER): EIF_INTEGER use %"eif_console.h%""
		end

	file_close (file: POINTER) is
			-- Close `file'
		external
			"C (FILE *) | %"eif_console.h%""
		alias
			"console_file_close"
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

end -- class CONSOLE


