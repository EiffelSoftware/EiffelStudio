indexing

	description: "[
		Commonly used console input and output mechanisms. 
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
			{CONSOLE} open_read, close, internal_stream
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
				dispose, before, readable, is_closed, extendible, is_open_write
		redefine
			make_open_stdin, make_open_stdout, count, is_empty, exists,
			close, dispose, end_of_file, next_line,
			read_integer_with_no_type, read_double, readdouble,
			read_character, readchar,
			read_line, readline,
			back
		end

	ANY

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

	count: INTEGER is 1
			-- Useless for CONSOLE class.
			--| `count' is non null not to invalidate invariant clauses.

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
				last_character := a_code.to_character_8
			end
		end

	read_double, readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			read_number_sequence (ctor_convertor, {NUMERIC_INFORMATION}.type_double)
			last_double := ctor_convertor.parsed_double
				-- Consume all left characters until we meet a new-line character.
			consume_characters
		end

	read_line, readline is
			-- Read a string until new line or end of file.
			-- Make result available in `last_string'.
			-- New line will be consumed but not part of `last_string'.
		local
			i, c, p: INTEGER
			str_cap: INTEGER
			p_fetched: BOOLEAN
			done: BOOLEAN
		do
			from
				if last_string = Void then
					create_last_string (1024)
				else
					last_string.clear_all
				end
				done := False
				i := 0
				str_cap := last_string.capacity
			until
				done
			loop
				if p_fetched then
					c := p
				else
					c := internal_stream.read_byte
				end
				if c = 13 then
					p := internal_stream.read_byte
					p_fetched := True
				end
				if c = 13 and then p = 10 then
						-- Discard end of line in the form "%R%N".
					c := p -- internal_stream.read_byte
					p_fetched := False
					done := True
				elseif c = 10 then
						-- Discard end of line in the form "%N".
					done := True
				elseif c = -1 then
					internal_end_of_file := True
					done := True
				else
					i := i + 1
					if i > str_cap then
						if str_cap < 2048 then
							last_string.grow (str_cap + 1024)
							str_cap := str_cap + 1024
						else
							last_string.automatic_grow
							str_cap := last_string.capacity
						end
					end
					last_string.append_character (c.to_character_8)
				end
			end
		end

feature {NONE} -- Implementation	

	read_integer_with_no_type is
			-- Read a ASCII representation of number of `type'
			-- at current position.
		do
			read_number_sequence (ctoi_convertor, {NUMERIC_INFORMATION}.type_no_limitation)
				-- Consume all left characters until we meet a new-line character.
			consume_characters
		end

	consume_characters is
			-- Consume all characters from current position
			-- until we meet a new-line character.
		do
			from

			until
				end_of_file or last_character = '%N'
			loop
				read_character
			end
		end


feature {NONE} -- Inapplicable

	is_empty: BOOLEAN is False;
			-- Useless for CONSOLE class.
			--| `empty' is false not to invalidate invariant clauses.

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class CONSOLE


