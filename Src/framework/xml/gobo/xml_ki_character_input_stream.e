note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XML_KI_CHARACTER_INPUT_STREAM

inherit
	XML_INPUT_STREAM

create
	make

feature {NONE} -- Initialization

	make (a_stream: KI_CHARACTER_INPUT_STREAM)
			-- Initialize `Current'.
		require
			a_stream_attached: a_stream /= Void
		do
			source := a_stream
			name := a_stream.generator

			create current_chunk.make_empty
			chunk_size := default_chunk_size
		end

feature -- Status

	name: STRING

feature -- Status report	

	end_of_input: BOOLEAN
		do
			Result := (chunk_source_upper > 0) and then --| started reading
					index >= chunk_source_upper and ((chunk_source_upper - chunk_source_lower + 1) < chunk_size)
--			Result := source.end_of_input
		end

	is_open_read: BOOLEAN
		do
			Result := source.is_open_read
		end

feature -- Access

	index: INTEGER

	line: INTEGER

	column: INTEGER

	last_character: CHARACTER

feature -- Chunk

	chunk_size: INTEGER
			-- Size of buffer to read at once	

feature -- Element change

	set_chunk_size (v: like chunk_size)
			-- Set `chunk_size' to `v'
		require
			chunk_size_positive: chunk_size > 0
		do
			chunk_size := v
		end

	compute_smart_chunk_size (a_count: INTEGER; a_maximum_chunk_size: INTEGER)
			-- Compute a optimized chunk size under `a_maximum_chunk_size' (if not zero)
			-- given a estimated count of `a_count'
		require
			maximum_chunk_size_positive_or_zero: a_maximum_chunk_size >= 0
		local
			n: INTEGER
		do
			n := a_count // 100
			if n > chunk_size then
				chunk_size := chunk_size.max (n - (n \\ default_chunk_size))
				if a_maximum_chunk_size > 0 and chunk_size > a_maximum_chunk_size then
					chunk_size := a_maximum_chunk_size
				end
			end
		end

feature -- Basic operation		

	start
		do
			chunk_source_upper := -1
			chunk_source_lower := -1
			index := 0
			line := 1
			column := 0
		end

	close
		do
			chunk_source_upper := -1
			chunk_source_lower := -1
			create current_chunk.make_empty
		end

	read_character
		local
			c: CHARACTER
		do
			index := index + 1
			if index > chunk_source_upper then
				source.read_string (chunk_size)
				current_chunk := source.last_string
				chunk_source_lower := index
				chunk_source_upper := chunk_source_lower + current_chunk.count - 1
			end
			if index < chunk_source_lower then
				c := '%U'
			else
				c := current_chunk.item (1 + index - chunk_source_lower)
			end

			if last_character = '%N' then
				line := line + 1
				column := 0
			else
				column := column + 1
			end

			last_character := c
		end

feature {NONE} -- Implementation

	chunk_source_lower: INTEGER
			-- Lower index of current chunk

	chunk_source_upper: INTEGER
			-- Upper index of current chunk

	current_chunk: STRING
			-- Current chunk

	default_chunk_size: INTEGER = 4096
			-- default chunk_size

	source: KI_CHARACTER_INPUT_STREAM
			-- Source for the stream

invariant

	source_attached: source /= Void

note
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
