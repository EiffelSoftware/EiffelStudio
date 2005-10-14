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
			close, dispose, end_of_file, writer, next_line,
			read_integer_with_no_type, internal_leading_separators,
			read_double, readdouble			
		end

create {STD_FILES}
	make_open_stdin, make_open_stdout, make_open_stderr

feature -- Initialization

	make_open_stdin (fn: STRING) is
			-- Create an unix standard input file.
		local
			a: INTEGER
		do
			make (fn)
			internal_stream := feature {SYSTEM_CONSOLE}.open_standard_input
			set_read_mode			
		end

	make_open_stdout (fn: STRING) is
			-- Create an unix standard output file.
		do
			make (fn)
			internal_stream := feature {SYSTEM_CONSOLE}.open_standard_output
			set_write_mode
		end

	make_open_stderr (fn: STRING) is
			-- Create an unix standard error file.
		do
			make (fn)
			internal_stream := feature {SYSTEM_CONSOLE}.open_standard_error
			set_write_mode
		end

feature -- Cursor movement

	next_line is
			-- Move to next input line.
		local
			a_code: INTEGER
		do
			a_code := internal_stream.read_byte
			if a_code /= -1 then
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

feature -- Input

	read_double, readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
			-- Taken from the SmallEiffel distribution:
			--		Copyright (C) 1994-98 LORIA - UHP - CRIN - INRIA - FRANCE
			--		Dominique COLNET and Suzanne COLLIN - colnet@loria.fr
			--		http://SmallEiffel.loria.fr
		local
			state: INTEGER
			sign: BOOLEAN
			l_buf, blanks: STRING
		do
				-- state = 0 : waiting sign or first digit.
				-- state = 1 : sign read, waiting first digit.
				-- state = 2 : in the integral part.
				-- state = 3 : in the fractional part.
				-- state = 4 : end state.
				-- state = 5 : error state.

			from
				blanks := internal_separators
				create l_buf.make (20)
			until
				state >= 4
			loop
				read_character
				inspect
					state
				when 0 then
					if blanks.has (last_character) then
					elseif last_character.is_digit then
						l_buf.extend (last_character)
						state := 2
					elseif last_character = '-' then
						sign := True
						state := 1
					elseif last_character = '+' then
						state := 1
					elseif last_character = '.' then
						l_buf.extend (last_character)
						state := 3
					else
						state := 5
					end
				when 1 then
					if blanks.has (last_character) then
					elseif last_character.is_digit then
						l_buf.extend (last_character)
						state := 2
					else
						state := 5
					end
				when 2 then
					if last_character.is_digit then
						l_buf.extend (last_character)
					elseif last_character = '.' then
						l_buf.extend (last_character)
						state := 3
					else
						state := 4
					end
				else
					if last_character.is_digit then
						l_buf.extend (last_character)
					else
						state := 4
					end
				end
				if end_of_file then
					inspect
						state
					when 2 .. 4 then
						state := 4
					else
						state := 5
					end
				end
			end
				-- Consume all left characters.
			from
				
			until
				end_of_file or last_character = '%N'
			loop
				read_character
			end
			if state = 5 then
				-- FIXME: Generate an exception here
			end

			if l_buf.count > 0 then
				last_double := l_buf.to_double
			else
				last_double := 0; -- NaN
			end
			if sign then
				last_double := - last_double
			end
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

feature {NONE} -- Inapplicable

	internal_leading_separators: STRING is
			-- 
		do
			Result := " %N%T"
		end	
		
	internal_trailing_separators: STRING is
			-- 
		do
			Result := " %T"
		end
		
	read_integer_with_no_type is
			-- Read a ASCII representation of number of `type'
			-- at current position.
		local
			l_is_integer: BOOLEAN
		do
			l_is_integer := True
			ctoi_state_machine.reset ({INTEGER_NATURAL_INFORMATION}.type_no_limitation )
			ctoi_state_machine.set_leading_separators (internal_leading_separators)
			ctoi_state_machine.set_trailing_separators (internal_trailing_separators)
			from			
				l_is_integer := True

			until
				end_of_file or else not l_is_integer
			loop
				read_character
				if not end_of_file then
					ctoi_state_machine.parse_character (last_character)
					l_is_integer := ctoi_state_machine.is_part_of_integer
				end
			end
				-- Consume all left characters.
			from
				
			until
				end_of_file or last_character = '%N' 
			loop
				read_character
			end
		end

	count: INTEGER is 1
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

	is_empty: BOOLEAN is False;
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

	writer: STREAM_WRITER is
			-- Stream writer used to write in `Current' (if possible).
		do
			if internal_swrite = Void and internal_stream.can_write then
				create internal_swrite.make_from_stream_and_encoding (
					internal_stream, feature {ENCODING}.default)
				internal_swrite.set_auto_flush (True)
			end
			Result := internal_swrite
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


