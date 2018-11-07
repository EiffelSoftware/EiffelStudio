note
	description: "External iteration cursor for a file."

class
	FILE_ITERATION_CURSOR

inherit
	DISPOSABLE
		rename
			dispose as close
		end

	ITERATION_CURSOR [CHARACTER_8]
		rename
			item as character
		end

create {FILE}
	make_empty,
	make_open_read,
	make_open_stdin

feature {NONE} -- Creation

	make_empty
			-- Create an iterator without any items.
		do
				-- file_pointer := default_pointer
		ensure
			after
		end

	make_open_read (info: SYSTEM_FILE_INFO)
			-- Open a file identified by `name` to iterate over.
		do
				-- Initialize file stream.
			info.refresh
			stream := info.open_read
				-- Read first byte if possible.
			forth
		end

	make_open_stdin
			-- Open standard input.
		do
				-- Initialize file handle.
			stream := {SYSTEM_CONSOLE}.open_standard_input
				-- Read first byte if possible.
			forth
		end

feature -- Access

	character: CHARACTER_8
			-- <Precursor>
			-- See also `byte`.
		do
			Result := byte.to_character_8
		end

	byte: NATURAL_8
			-- <Precursor>
			-- See also `character`.

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := not attached stream
		end

feature -- Cursor movement

	forth
			-- <Precursor>
			-- Attempt to read a byte from the file and make it available in `byte` and `character`.
		local
			value: INTEGER_32
		do
			if attached stream as s then
				value := s.read_byte
				if value = -1 then
						-- End of file.
					close
				else
					byte := value.as_natural_8
				end
			end
		end

feature -- Disposal

	close
			-- <Precursor>
			-- Release resources associated with the file.
		do
			if attached stream as s then
				s.close
				stream := Void
			end
		end

feature {NONE} -- Access

	stream: detachable SYSTEM_STREAM
			-- File pointer used by low-level C operations.

invariant

	consistent_item: byte.to_character_8 = character

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
