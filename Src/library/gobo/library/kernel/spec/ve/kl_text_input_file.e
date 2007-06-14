indexing

	description:

		"Text input files containing extended ASCII characters %
		%(8-bit code between 0 and 255). The line separtor of the %
		%underlying file system is automatically converted to %%N %
		%when read from the file. However `read_line' and `read_new_line' %
		%are able to recognize '%%N', '%%R%%N' and '%%R' as line separators."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_TEXT_INPUT_FILE

inherit

	KI_TEXT_INPUT_FILE
		undefine

			read_to_string,


			copy,

			read_to_buffer
		end

	KL_INPUT_FILE

		redefine






			read_character,
			read_string

		end


































































create

	make

feature -- Access













	eol: STRING is "%N"
			-- Line separator

feature -- Input


	read_character is
			-- Read the next character in input file.
			-- Make the result available in `last_character'.
		do
			if character_buffer /= Void then
				last_character := character_buffer.item
				character_buffer := character_buffer.right
			elseif old_end_of_file then
				end_of_file := True
			else
				if operating_system.is_windows then
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



	read_string (nb: INTEGER) is
			-- Read at most `nb' characters from input file.
			-- Make the characters that have actually been read
			-- available in `last_string'.
		local
			i, j: INTEGER
			a_target: STRING
		do
			if operating_system.is_windows then
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
			-- Read characters from input file until a line separator
			-- or end of file is reached. Make the characters that have
			-- been read available in `last_string' and discard the line
			-- separator characters from the input file.
			-- Line separators recognized by current file are: '%N',
			-- '%R%N and '%R'.
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
							a_target.append_character (c)
						end
					end
				end
			end
			end_of_file := is_eof
		end

	read_new_line is
			-- Read a line separator from input file.
			-- Make the characters making up the recognized
			-- line separator available in `last_string',
			-- or make `last_string' empty and leave the
			-- input file unchanged if no line separator
			-- was found.
			-- Line separators recognized by current file are:
			-- '%N', '%R%N and '%R'.
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


































end
