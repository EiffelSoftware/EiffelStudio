note

	description:

		"Lexical analyzer input file buffers"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class YY_FILE_BUFFER

inherit

	YY_BUFFER
		rename
			make as make_from_string
		redefine
			name,
			fill,
			wipe_out
		end

create

	make,
	make_with_size

feature {NONE} -- Initialization

	make (a_file: like file)
			-- Create a new buffer for `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			make_with_size (a_file, default_capacity)
		ensure
			count_set: count = 0
			file_set: file = a_file
			beginning_of_line: beginning_of_line
		end

	make_with_size (a_file: like file; size: INTEGER)
			-- Create a new buffer of capacity `size' for `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
			size_positive: size >= 0
		do
			capacity := size
				-- `content' has to be 2 characters longer
				-- than the size given because we need to
				-- put in 2 end-of-buffer characters.
			content := new_default_buffer (size + 2)
			set_file (a_file)
		ensure
			capacity_set: capacity = size
			count_set: count = 0
			file_set: file = a_file
			beginning_of_line: beginning_of_line
		end

feature -- Access

	name: STRING
			-- Name of buffer
		do
			Result := file.name
		end

	file: KI_CHARACTER_INPUT_STREAM
			-- Input file

feature -- Status report

	end_of_file: BOOLEAN
			-- Has end-of-file been reached?

feature -- Setting

	set_file (a_file: like file)
			-- Set `file' to `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			end_of_file := a_file.end_of_input
			flush
			file := a_file
		ensure
			count_set: count = 0
			file_set: file = a_file
			beginning_of_line: beginning_of_line
		end

feature -- Status setting

	set_end_of_file
			-- Set `end_of_file' to True.
		do
			end_of_file := True
		ensure
			end_of_file_set: end_of_file
		end

feature -- Element change

	fill
			-- Fill buffer with characters from `file'.
			-- Do not lose unprocessed characters in buffer.
			-- Resize buffer if necessary. Set `filled' to True
			-- if characters have been added to buffer.
		local
			nb, nb2: INTEGER
			buff: like content
		do
				-- If the last call to `fill' failed to add
				-- more characters, this means that the end of
				-- file has already been reached. Do not attempt
				-- to fill again the buffer in that case.
			if filled and not end_of_file then
					-- First move last characters to start of buffer
					-- and eventually resize `content' if necessary.
				compact_left
				buff := content
				nb := capacity - count
					-- Read in more data.
				if interactive then
					file.read_character
					if not file.end_of_input then
						count := count + 1
						buff.put (file.last_character, count)
						filled := True
					else
						filled := False
						end_of_file := True
					end
				else
--					if nb > Read_buffer_capacity then
--						nb := Read_buffer_capacity
--					end
					nb2 := buff.fill_from_stream (file, count + 1, nb)
					if nb2 < nb then
						end_of_file := file.end_of_input
					end
					if nb2 > 0 then
						filled := True
					else
						filled := False
					end
					count := count + nb2
				end
				buff.put (End_of_buffer_character, count + 1)
				buff.put (End_of_buffer_character, count + 2)
			else
				filled := False
			end
		end

	wipe_out
			-- Wipe out buffer.
		do
			flush
			filled := False
			end_of_file := True
		ensure then
			end_of_file: end_of_file
		end

feature {NONE} -- Constants

	Read_buffer_capacity: INTEGER = 8192
			-- Maximum number of characters to
			-- be read at a time

invariant

	file_not_void: file /= Void
	file_open_read: not end_of_file implies file.is_open_read

end
