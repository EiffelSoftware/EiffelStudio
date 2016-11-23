note
	description: "[
				Implements basic output stream as a stream filtered by the zlib compression
				algorithms. Target String.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_STRING_COMPRESS

inherit

	ZLIB_COMPRESS

create
	string_stream,
	string_stream_with_size

feature {NONE} -- Initialization

	string_stream (a_string: STRING)
		require
			not_connected: not is_connected
		do
			make
			intialize
			string := a_string
		ensure
			string_set: attached string
		end

	string_stream_with_size (a_string: STRING; a_size: INTEGER)
		require
			not_connected: not is_connected
			valid_size: a_size > 0
		do
			make_with_chunk_size (a_size)
			intialize
			string := a_string
		ensure
			string_set: attached string
		end

feature -- Change element

	set_string (a_string: STRING)
		do
			string := a_string
		ensure
			string_set: attached string
		end

feature -- Deflate

	put_string (a_string: READABLE_STRING_GENERAL)
			-- Deflate the buffer content.
		do
			create user_input_string.make_from_string (a_string.as_string_8)
			deflate
			close
		end

	put_string_with_options (a_string: READABLE_STRING_GENERAL; a_level, a_windows_bits, a_mem_level, a_strategy: INTEGER )
			-- Deflate the buffer content.
		do
			create user_input_string.make_from_string (a_string.as_string_8)
			deflate_with_options (a_level, a_windows_bits, a_mem_level, a_strategy)
			close
		end

feature -- Access

	is_connected: BOOLEAN
			-- <Precursor>
		do
			Result := attached string
		end

feature {NONE} -- Deflate implementation		

	read
			-- <Precursor>
		do
			if attached user_input_string as l_input_string then
				last_read_elements := string_read (l_input_string)
			end
		end

	write (a_amount: INTEGER)
			-- <Precursor>
		do
			if attached string as l_string then
				last_write_elements := string_write (output_buffer,a_amount, l_string)
			end
		end

	close
			-- <Precursor>
		do
			if attached string as l_string then
				string := Void
			end
		end

	string_read (a_string: STRING): INTEGER
			-- Read the `a_string' by character until end of string or the number of elements (Chunk) was reached.
			-- Return the number of elements read.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_string.count or else l_index > chunk_size
			loop
				input_buffer.put_character(a_string.at (l_index), l_index - 1)
				l_index := l_index + 1
			end
			if l_index > a_string.count then
				end_of_input := True
			else
				if attached user_input_string as l_string then
				   user_input_string := l_string.substring (l_index , l_string.count)
				end
			end
			Result := l_index - 1
		end


	string_write (a_buffer: MANAGED_POINTER ; a_amount: INTEGER; a_dest: STRING): INTEGER
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_amount or l_index > a_buffer.count
			loop
				a_dest.append_character (a_buffer.read_character (l_index - 1))
				l_index := l_index + 1
			end
			Result := l_index - 1
		end


feature {NONE} -- Implementation

	string: detachable STRING
		-- String used to write the compressed ouput

	user_input_string: detachable STRING
		-- Content to compress	

end
