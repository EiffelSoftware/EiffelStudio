indexing

	description:

		"Standard input files containing extended ASCII characters %
		%(8-bit code between 0 and 255). The line separtor of the %
		%underlying file system is automatically converted to %%N %
		%when read from the satndard input file. However `read_line' %
		%and `read_new_line' are able to recognize '%%N', '%%R%%N' %
		%and '%%R' as line separators."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_STDIN_FILE

inherit

	KI_TEXT_INPUT_STREAM
		rename
			end_of_input as end_of_file

		undefine
			copy

		redefine



			read_to_buffer
		end

	KL_OPERATING_SYSTEM
		export
			{NONE} all

		undefine
			copy

		end

	KL_IMPORTED_ANY_ROUTINES
		export
			{NONE} all

		undefine
			copy

		end





































	FILE
		rename
			make as old_make,
			read_character as old_read_character,
			read_stream as old_read_stream,
			read_line as old_read_line,
			is_open_read as old_is_open_read,
			end_of_file as old_end_of_file,
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
			-- Create a new standard input file.
		do








			make_open_stdin
			name := "stdin"

			end_of_file := False
		ensure
			name_set: name.is_equal ("stdin")
			is_open_read: is_open_read
			not_end_of_file: not end_of_file
		end

feature -- Access

	eol: STRING is "%N"
			-- Line separator
















feature -- Status report

	is_open_read: BOOLEAN is
			-- Is standard input file opened in read mode?
		do
			Result := old_is_open_read
		end

	end_of_file: BOOLEAN
			-- Has the end of file been reached?

feature -- Input

	read_character is
			-- Read the next character in standard input file.
			-- Make the result available in `last_character'.
		do
			if character_buffer /= Void then
				last_character := character_buffer.item
				character_buffer := character_buffer.right
			elseif old_end_of_file then
				end_of_file := True
			else

				if is_windows then
						-- Windows.
					old_read_character
					if not old_end_of_file then
						if last_character = '%R' then
							old_read_character
							if old_end_of_file then
								last_character := '%R'
							elseif last_character /= '%N' then
								unread_character (last_character)
								last_character := '%R'
							end
						end
					else
						end_of_file := True
					end
				else
					old_read_character
					end_of_file := old_end_of_file
				end









			end
		end

	unread_character (a_character: CHARACTER) is
			-- Put `a_character' back in input file.
			-- This character will be read first by the next
			-- call to a read routine.
		local
			a_cell: like character_buffer
		do
			create a_cell.make (a_character)
			if character_buffer /= Void then
				a_cell.put_right (character_buffer)
			end
			character_buffer := a_cell
			last_character := a_character
			end_of_file := False
		end

	read_string (nb: INTEGER) is
			-- Read at most `nb' characters from standard input file.
			-- Make the characters that have actually been read
			-- available in `last_string'.
			-- (Note that even if at least `nb' characters are available
			-- in standard input file, there is no guarantee that they
			-- will all be read.)

















































		local
			i, j: INTEGER
			a_target: STRING
		do
			if is_windows then
					-- Windows.
				if last_string = Void then
					create last_string.make_filled ('%U', nb)
				elseif last_string.count < nb then
					last_string.resize (nb)
				end
				a_target := last_string
				from i := nb until i < 1 loop
					read_character
					if not end_of_file then
						j := j + 1
						a_target.put (last_character, j)
						i := i - 1
					else
						i := 0 -- Jump out of the loop.
					end
				end
				a_target.resize (j)
			else
				if last_string = Void then
					create last_string.make_filled ('%U', nb)
				elseif last_string.count < nb then
					last_string.resize (nb)
				end
				if character_buffer = Void then
					if not old_end_of_file then
						old_read_stream (nb)
					else
						last_string.wipe_out
					end
				else
					i := read_to_string (last_string, 1, nb)
					last_string.resize (i)
				end
			end

			end_of_file := (last_string.count = 0)
		end

	read_line is
			-- Read characters from standard input file until a line separator
			-- or end of file is reached. Make the characters that have
			-- been read available in `last_string' and discard the line
			-- separator characters from the standard input file.
			-- Line separators recognized by current standard input
			-- file are: '%N', '%R%N and '%R'.
		local
			done: BOOLEAN
			a_target: STRING
			c: CHARACTER
			is_eof: BOOLEAN
			has_carriage: BOOLEAN
		do
			if last_string = Void then

				create last_string.make_empty



			else




				last_string.wipe_out

			end
			is_eof := True
			a_target := last_string
			from until done loop
				read_character
				if end_of_file then
					done := True
				else
					is_eof := False
					c := last_character
					inspect c
					when '%N' then
						done := True
					when '%R' then
						has_carriage := True
					else
						if has_carriage then
								-- Put character back to input file.
							unread_character (c)
							done := True
						else
							last_string.append_character (c)
						end
					end
				end
			end
			end_of_file := is_eof
		end

	read_new_line is
			-- Read a line separator from standard input file.
			-- Make the characters making up the recognized
			-- line separator available in `last_string',
			-- or make `last_string' empty and leave the
			-- standard input file unchanged if no line
			-- separator was found.
			-- Line separators recognized by current standard
			-- input file are: '%N', '%R%N and '%R'.
		do
			if last_string = Void then

				create last_string.make_empty



			else




				last_string.wipe_out

			end
			read_character
			if not end_of_file then
				inspect last_character
				when '%N' then
					last_string.append_character ('%N')
				when '%R' then
					last_string.append_character ('%R')
					read_character
					if not end_of_file then
						if last_character = '%N' then
							last_string.append_character ('%N')
						else
								-- Put character back to input file.
							unread_character (last_character)
						end
					end
				else
						-- Put character back to input file.
					unread_character (last_character)
				end
			end
			end_of_file := False
		end



















































	read_to_buffer (a_buffer: KI_BUFFER [CHARACTER]; pos, nb: INTEGER): INTEGER is
			-- Fill `a_buffer', starting at position `pos', with
			-- at most `nb' characters read from standard input file.
			-- Return the number of characters actually read.
			-- (Note that even if at least `nb' characters are available
			-- in standard input file, there is no guarantee that they
			-- will all be read.)
		local
			char_buffer: KL_CHARACTER_BUFFER
		do
			char_buffer ?= a_buffer
			if char_buffer /= Void then
				Result := char_buffer.fill_from_stream (Current, pos, nb)
			else
				Result := precursor (a_buffer, pos, nb)
			end
		end


feature {NONE} -- GC

	dispose is
			-- Do not close standard input file.
		do
			handle := INVALID_HANDLE_VALUE
		end


feature {NONE} -- Implementation

	character_buffer: KL_LINKABLE [CHARACTER]
			-- Unread characters












end
