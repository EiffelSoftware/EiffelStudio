note
	description: "Summary description for {XML_FILE_INPUT_STREAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FILE_REWINDABLE_INPUT_STREAM

inherit
	XML_FILE_INPUT_STREAM
		redefine
			make, start, close, read_character
		end

	XML_REWINDABLE_INPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (a_file: FILE)
			-- Create current stream for file `a_file'
		do
			Precursor (a_file)
			create previous_chunk.make_empty
		end

feature -- Chunk

	rewind_chunk_size: INTEGER
			-- Size of rewind chunk, also known as `previous_chunk'
		do
			Result := internal_rewind_chunk_size
			if Result = 0 then
				Result := chunk_size
			end
		end

feature {NONE} -- Chunk: implementation

	internal_rewind_chunk_size: INTEGER
			-- Size of rewind chunk, also known as `previous_chunk'

feature -- Element change

	set_rewind_chunk_size (v: like rewind_chunk_size)
			-- Set `rewind_chunk_size' to `v' or to `chunk_size'
			--| if `internal_rewind_chunk_size' is zero, use `chunk_size' value
		require
			chunk_size_positive_or_zero: v >= 0
		do
			internal_rewind_chunk_size := v
		ensure
			rewind_chunk_size_set: rewind_chunk_size = v or rewind_chunk_size = chunk_size
		end

feature -- Basic operation

	start
		do
			Precursor
			previous_line_count := 0
		end

	close
		do
			Precursor
			create previous_chunk.make_empty
		end

	read_character
		local
			c: CHARACTER
		do
			index := index + 1
			if index > chunk_source_upper then
				set_previous_chunk (current_chunk)

				source.read_stream (chunk_size)
				current_chunk := source.last_string
				chunk_source_lower := index
				chunk_source_upper := chunk_source_lower + current_chunk.count - 1
			end
			if index < chunk_source_lower then
				if 1 + index - chunk_source_lower - rewind_chunk_size > 0 then
					c := previous_chunk.item (1 + index - chunk_source_lower - rewind_chunk_size)
				else
					c := '%U'
				end
			else
				c := current_chunk.item (1 + index - chunk_source_lower)
			end

			if last_character = '%N' then
				line := line + 1
				previous_line_count := column
				column := 0
			else
				column := column + 1
			end

			last_character := c
		end

	rewind
		do
			index := index - 1
			if index < chunk_source_lower then
				check previous_chunk.count = rewind_chunk_size end
				last_character := previous_chunk.item (1 + index - chunk_source_lower + rewind_chunk_size)
			else
				last_character := current_chunk.item (1 + index - chunk_source_lower)
			end
			if last_character = '%N' then
				line := line - 1
				column := previous_line_count
				previous_line_count := 0 --| if we rewind more than one line, too bad
			else
				column := column - 1
			end
		end

feature {NONE} -- Implementation

	set_previous_chunk (a_curr: like current_chunk)
		local
			n: INTEGER
			p: like previous_chunk
		do
			p := previous_chunk
			n := a_curr.count
			if n > 0 then
				check n >= rewind_chunk_size end
				check
					p.count = 0 or else p.count = rewind_chunk_size
				end
	--			p.wipe_out
				p.subcopy (a_curr, n - rewind_chunk_size + 1, n, 1)
			else
				p.wipe_out
			end
		end

	previous_chunk: STRING
			-- Previous chunk

	previous_line_count: INTEGER
			-- Keep previous line's length
			-- to set the `column' during `rewind'			

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
