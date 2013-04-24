note
	description: "Summary description for {XML_FILE_OUTPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FILE_OUTPUT_STREAM

inherit
	XML_CHARACTER_8_OUTPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (a_file: FILE)
			-- Create current stream for file `a_file'
		require
			a_file_attached: a_file /= Void
		do
			set_chunk_size (Default_chunk_size)
			target := a_file
		end

feature -- Status report

	is_open_write: BOOLEAN
		do
			Result := target.is_open_write
		end

feature -- Chunk

	chunk_size: INTEGER
			-- Size of buffer to write at once

feature -- Element change

	set_chunk_size (v: like chunk_size)
			-- Set `chunk_size' to `v'
		require
			chunk_size_positive: v > 0
		do
			create current_chunk.make (v)
			chunk_size := v
		end

feature -- Basic operation

	close
		do
			flush
			create current_chunk.make_empty
		end

	flush
			-- Flush buffered data to disk.
		do
			target.put_string (current_chunk)
			current_chunk.wipe_out
		ensure then
			current_chunk.count = 0
		end

feature -- Output

	put_character_8 (c: CHARACTER_8)
		local
			cn: INTEGER
		do
			cn := current_chunk.count
			if cn >= default_chunk_size - 1 then
				flush
			end
			current_chunk.append_character (c)
		end

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		local
			n: INTEGER
		do
			n := a_string.count
			if n >= default_chunk_size then
				flush
				target.put_string (a_string.to_string_8)
			else
				if current_chunk.count + n > default_chunk_size then
					flush
					check current_chunk.count = 0 end
				end
				current_chunk.append (a_string)
				check current_chunk.count < default_chunk_size end
			end
		end

feature {NONE} -- Implementation

	current_chunk: STRING
			-- Current chunk

	default_chunk_size: INTEGER = 4096
			-- default chunk_size

	target: FILE
			-- Target for the stream

invariant
	target_attached: target /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
