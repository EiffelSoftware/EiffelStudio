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
			{ANY}
				separator, append, file_pointer, last_character, last_integer,
				last_real, last_string, last_double, file_readable,
				lastchar, lastint, lastreal, laststring, lastdouble,
				read_character, readchar, read_real, 
				last_integer_32, last_integer_8, last_integer_16, last_integer_64,
				last_natural_8, last_natural_16, last_natural, last_natural_32,
				last_natural_64,
				read_line, read_stream, read_word, 
				put_boolean, put_real, put_double, put_string, put_character,
				put_new_line, new_line, readint, readreal, readline, readstream,
				readword,  putbool, putreal, putdouble, putstring, putchar,
				read_integer_8, read_integer_16, read_integer, read_integer_32, read_integer_64,
				read_natural_8, read_natural_16, read_natural, read_natural_32, read_natural_64,
				put_integer_8, put_integer_16, putint, put_integer, put_integer_32, put_integer_64,
				put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
				dispose
		redefine
			make_open_stdin, make_open_stdout, count, is_empty, exists,
			close, dispose, end_of_file, next_line,
			read_integer_with_no_type, read_double, readdouble,
			read_character, readchar, back
		end

create {STD_FILES}
	make_open_stdin, make_open_stdout, make_open_stderr

feature -- Initialization

	make_open_stdin (fn: STRING) is
			-- Create an unix standard input file.
		do
			make (fn)
			internal_stream := {SYSTEM_CONSOLE}.open_standard_input
			set_read_mode
		end

	make_open_stdout (fn: STRING) is
			-- Create an unix standard output file.
		do
			make (fn)
			internal_stream := {SYSTEM_CONSOLE}.open_standard_output
			set_write_mode
		end

	make_open_stderr (fn: STRING) is
			-- Create an unix standard error file.
		do
			make (fn)
			internal_stream := {SYSTEM_CONSOLE}.open_standard_error
			set_write_mode
		end

feature -- Cursor movement

	next_line is
			-- Move to next input line.
		do
			if peek /= -1 then
				Precursor {PLAIN_TEXT_FILE}
			end
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does file exist?
		do
			Result := True
		end

	end_of_file: BOOLEAN is False
			-- Has an EOF been detected?
			-- Always false for a console.

feature -- Cursor movement

	back is
			-- Not supported on console
		do
		end
		
feature -- Removal

	close is
			-- Do not close the streams.
		do
		end

	dispose is
			-- This is closed by the operating system at completion.
		do
		end
		
feature -- Input

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		local
			a_code: INTEGER
		do
			a_code := internal_stream.read_byte
			if a_code = - 1 then
				internal_end_of_file := True
			else
					-- FIXME: If %R is not followed by %N,
					--        we will lost the following character.
					--        we always assume that %R is followed by %N.
				if a_code = 13 then
						a_code := internal_stream.read_byte
						if a_code = -1 then
							internal_end_of_file := True
						end
						a_code := 10	
				end
				last_character := a_code.to_character
			end
		end

	read_double, readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		local
			l_is_double: BOOLEAN
		do
			ctor_convertor.reset ({NUMERIC_INFORMATION}.type_double)
			from
				l_is_double := True
			until
				end_of_file or not l_is_double
			loop
				read_character
				if not end_of_file then
					ctor_convertor.parse_character (last_character)
					l_is_double := ctor_convertor.is_part_of_double					
				end
			end
				-- Consume all left characters until we meet a new-line character.
			from
				
			until
				end_of_file or last_character = '%N' 
			loop
				read_character
			end
			last_double := ctor_convertor.parsed_double
		end
		
feature {NONE} -- Implementation	
		
	read_integer_with_no_type is
			-- Read a ASCII representation of number of `type'
			-- at current position.
		local
			l_is_integer: BOOLEAN
		do
			l_is_integer := True
			ctoi_convertor.reset ({NUMERIC_INFORMATION}.type_no_limitation )
			from			
				l_is_integer := True
			until
				end_of_file or not l_is_integer
			loop
				read_character
				if not end_of_file then
					ctoi_convertor.parse_character (last_character)
					l_is_integer := ctoi_convertor.is_part_of_integer
				end
			end
				-- Consume all left characters until we meet a new-line character.
			from
				
			until
				end_of_file or last_character = '%N' 
			loop
				read_character
			end
		end

feature {NONE} -- Inapplicable

	count: INTEGER is 1
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

	is_empty: BOOLEAN is False;
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

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


