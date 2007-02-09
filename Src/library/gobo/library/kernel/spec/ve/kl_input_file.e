indexing

	description:

		"Input files containing extended ASCII characters %
		%(8-bit code between 0 and 255)"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class KL_INPUT_FILE

inherit

	KI_INPUT_FILE

		undefine
			copy,
				-- Make sure that this deferred class
				-- has a deferred routine.
			valid_unread_character

		redefine

			read_to_string,

			read_to_buffer
		end

	KL_FILE
		rename
			open as open_read,
			is_open as is_open_read
		redefine



			close
		end





	KL_IMPORTED_ANY_ROUTINES

		undefine
			copy
		end
















feature -- Status report

























	is_open_read: BOOLEAN is
			-- Is file opened in read mode?
		do
			Result := old_is_open_read
		end

	end_of_file: BOOLEAN
			-- Has the end of file been reached?

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
				old_read_character
				end_of_file := old_end_of_file





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
			-- Read at most `nb' characters from input stream.
			-- Make the characters that have actually been read
			-- available in `last_string'.
			-- (Note that even if at least `nb' characters are available
			-- in the input file, there is no guarantee that they
			-- will all be read.)

















































		local
			i: INTEGER
		do
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

			end_of_file := (last_string.count = 0)
		end


	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER is
			-- Fill `a_string', starting at position `pos' with
			-- at most `nb' characters read from input file.
			-- Return the number of characters actually read.
			-- (Note that even if at least `nb' characters are available
			-- in the input file, there is no guarantee that they
			-- will all be read.)
		local

			end_pos: INTEGER
			memory_threshold: INTEGER
			a_memory: expanded MEMORY









			i: INTEGER
		do

			if not string_postconditions_enabled then
				Result := precursor (a_string, pos, nb)
			else
				memory_threshold := 10000000
				if nb * a_string.count < memory_threshold then
					Result := precursor (a_string, pos, nb)
				else
					end_pos := pos + nb - 1
					from i := pos until i > end_pos loop
						read_character
						if not end_of_file then
							if i \\ 100 = 0 then
									-- Give a chance to the GC to run a cycle. This
									-- is because in Visual Eiffel the GC is off in
									-- assertions, which causes problems because the
									-- postconditions of STRING.put create garbage
									-- which would never be collected before memory
									-- exhaustion if `nb' is relatively large.
								a_memory.full_collect
							end
							a_string.put (last_character, i)
							i := i + 1
						else
							Result := i - pos - nb
							i := end_pos + 1 -- Jump out of the loop.
						end
					end
					Result := Result + i - pos
				end
			end



















































		end


	read_to_buffer (a_buffer: KI_BUFFER [CHARACTER]; pos, nb: INTEGER): INTEGER is
			-- Fill `a_buffer', starting at position `pos', with
			-- at most `nb' characters read from input file.
			-- Return the number of characters actually read.
			-- (Note that even if at least `nb' characters are available
			-- in the input file, there is no guarantee that they
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

feature -- Basic operations

	open_read is
			-- Open current file in read-only mode if
			-- it can be opened, let it closed otherwise.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if string_name /= Empty_name then
					character_buffer := Void
					end_of_file := False




					if old_exists then
						eof := False

						old_open_read

					end

				end
			elseif not is_closed then
				close
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	close is
			-- Close current file if it is closable,
			-- let it open otherwise.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				old_close
				character_buffer := Void
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

feature {NONE} -- Implementation

	character_buffer: KL_LINKABLE [CHARACTER]
			-- Unread characters


















































	string_postconditions_enabled: BOOLEAN is
			-- Are postconditions in class STRING enabled?
		local
			rts_server: RTS_SERVER
			rts_class_info: RTS_CLASS_INFO
		once
			create rts_server
			rts_class_info := rts_server.class_info_by_name ("STRING")
			if rts_class_info /= Void then
				Result := rts_class_info.is_ensure_on
			end
		end
















































































end
