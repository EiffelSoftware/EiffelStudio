note
	description: "Summary description for {XML_FILE_INPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FILE_INPUT_STREAM

inherit
	XML_CHARACTER_8_INPUT_STREAM

	DEBUG_OUTPUT

create
	make,
	make_with_path,
	make_with_filename

feature {NONE} -- Initialization

	make (a_file: FILE)
			-- Create current stream for file `a_file'
		require
			a_file_attached: a_file /= Void
		do
			set_name (a_file.path.name)
			create current_chunk.make_empty
			chunk_size := default_chunk_size
			count := a_file.count
			source := a_file
		end

	make_with_path (a_path: PATH)
		require
			a_path_not_empty: a_path /= Void and then not a_path.is_empty
		local
			f: RAW_FILE
		do
			set_inner_source (True)
			create f.make_with_path (a_path)
			make (f)
		end

	make_with_filename (a_filename: READABLE_STRING_GENERAL)
		require
			a_filename_not_empty: a_filename /= Void and then not a_filename.is_empty
		local
			f: RAW_FILE
		do
			set_inner_source (True)
			create f.make_with_name (a_filename)
			make (f)
		end

feature -- Access

	name: READABLE_STRING_32

feature -- Change

	set_name (v: READABLE_STRING_32)
			-- Set associated name to `v'
		do
			name := v
		ensure
			v.same_string (name)
		end

feature -- Status report

	count: INTEGER

	is_started: BOOLEAN
			-- Current stream started?

	end_of_input: BOOLEAN
			-- Has the end of input stream been reached?
			-- i.e: cursor is out of stream range.
			-- i.e: EOF reached
		do
			Result := is_started and then (
						index > chunk_source_upper and --| After the last available input
						(chunk_source_upper - chunk_source_lower + 1 < chunk_size) --| indeed the last chunk maybe smaller than `chunk_size'
					)
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
			chunk_size_positive: v > 0
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
			if a_count > 0 then
				n := a_count // 100
			else
				n := count // 100
			end
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
			if is_inner_source and not source.is_open_read then
				source.open_read
			end
			source.start
			index := 0
			line := 1
			column := 0
			get_next_chunk
			is_started := True
		end

	close
		do
			chunk_source_upper := -1
			chunk_source_lower := -1
			create current_chunk.make_empty
			if is_inner_source then
				source.close
			end
		end

	read_character
		local
			c: CHARACTER
			i: INTEGER
		do
			index := index + 1
			if not is_started then
				start
			end
			if index <= chunk_source_upper then
				i := 1 + index - chunk_source_lower
				if current_chunk.valid_index (i) then
					c := current_chunk.item (i)
				else
						-- Internal error
					check should_not_occur: False end
					c := '%U'
				end

				if index = chunk_source_upper then
					get_next_chunk
				end
				if last_character = '%N' then
					line := line + 1
					column := 0
				else
					column := column + 1
				end
			else
					-- End of input ?
				check current_chunk.is_empty and end_of_input end
				c := '%U'
			end
			last_character := c
		end

	open_read
		do
			source.open_read
		end

feature {NONE} -- Implementation

	get_next_chunk
			-- Get next `current_chunk'.
		require
			is_open_read: source.is_open_read and source.is_readable
		do
			if source.file_readable then
				source.read_stream (chunk_size)
				current_chunk := source.last_string
			else
				create current_chunk.make_empty
			end
			chunk_source_lower := index + 1
			chunk_source_upper := chunk_source_lower + current_chunk.count - 1
		end

	chunk_source_lower: INTEGER
			-- Lower index of current chunk

	chunk_source_upper: INTEGER
			-- Upper index of current chunk

	current_chunk: STRING
			-- Current chunk

	default_chunk_size: INTEGER = 4096
			-- default chunk_size

	source: FILE
			-- Source for the stream

	is_inner_source: BOOLEAN
			-- Is source created by the stream?
			-- i.e: not provided by caller

	set_inner_source (b: like is_inner_source)
			-- Set `inner_source' to `b'
		do
			is_inner_source := b
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append_integer (index)
			Result.append (" - chunk [")
			Result.append_integer (chunk_source_lower)
			Result.append_character (':')
			Result.append_integer (chunk_source_upper)
			Result.append_character (']')
			Result.append_character (' ')
			Result.append_character ('@')
			Result.append (name)
		end

invariant
	source_attached: source /= Void

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
