indexing

	description:

		"Windows-like text input files containing extended ASCII %
		%characters (8-bit code between 0 and 255)"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_WINDOWS_INPUT_FILE

inherit

	KI_TEXT_INPUT_FILE
		undefine

			read_to_string,




			read_to_buffer
		end

	KL_BINARY_INPUT_FILE
		export




			{ANY} close;
			{NONE} all



		end

create

	make

feature -- Input

	read_line is
			-- Read characters from input file until a line separator
			-- or end of file is reached. Make the characters that have
			-- been read available in `last_string' and discard the line
			-- separator characters from the input file.
		local
			done: BOOLEAN
			a_target: STRING
			c: CHARACTER
			has_carriage: BOOLEAN
			is_eof: BOOLEAN
		do
			if last_string = Void then



				create last_string.make (256)

			else




				last_string.wipe_out

			end
			is_eof := True
			a_target := last_string
			from until done loop
				read_character
				if end_of_file then
					if has_carriage then
						a_target.append_character ('%R')
					end
					done := True
				else
					is_eof := False
					c := last_character
					inspect c
					when '%N' then
						if has_carriage then
							done := True
						else
							a_target.append_character (c)
						end
					when '%R' then
						if has_carriage then
							a_target.append_character (c)
						else
							has_carriage := True
						end
					else
						if has_carriage then
							a_target.append_character ('%R')
							has_carriage := False
						end
						last_string.append_character (c)
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
		do
			if last_string = Void then



				create last_string.make (256)

			else




				last_string.wipe_out

			end
			read_character
			if not end_of_file then
				if last_character = '%R' then
					read_character
					if not end_of_file then
						if last_character = '%N' then
							last_string.append_string (eol)
						else
								-- Put characters back to input file.
							unread_character (last_character)
							unread_character ('%R')
						end
					else
							-- Put character back to input file.
						unread_character ('%R')
					end
				else
						-- Put character back to input file.
					unread_character (last_character)
				end
			end
			end_of_file := False
		end

feature -- Access

	eol: STRING is "%R%N"
			-- Line separator

end
