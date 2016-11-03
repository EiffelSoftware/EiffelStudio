note
	description: "[
			Implements basic input stream as a stream filtered by the zlib compression
		algorithms. Source the results of a previous zlib compression. Target String.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_STRING_UNCOMPRESS

inherit

	ZLIB_UNCOMPRESS

create
	string_stream,
	string_stream_with_size

feature {NONE} -- Initialization

	string_stream (a_string: READABLE_STRING_32)
		require
			not_connected: not is_connected
			non_void_file: a_string /= Void
		do
			make
			intialize
			create string.make_from_string (a_string.as_string_8)
		ensure
			string_set: attached string
		end

	string_stream_with_size (a_string: READABLE_STRING_32; a_size: INTEGER)
		require
			not_connected: not is_connected
			non_void_file: a_string /= Void
			valid_size: a_size > 0
		do
			make_with_chunk_size (a_size)
			intialize
			create string.make_from_string (a_string.as_string_8)
		ensure
			string_set: attached string
		end

feature -- Access

	is_connected: BOOLEAN
		do
			Result := attached string
		end

feature -- Change Element

	set_string (a_string: READABLE_STRING_32)
		do
			create string.make_from_string (a_string.as_string_8)
		ensure
			string_set: attached string
		end



feature -- Inflate

	to_string: STRING
		do
			create Result.make_empty
			create user_output_string.make_empty
			inflate
			if attached user_output_string as l_string then
				Result := l_string
			end
			close
		end

	to_string_with_options (a_windows_bits: INTEGER): STRING
		do
			create Result.make_empty
			create user_output_string.make_empty
			inflate_with_options (a_windows_bits)
			if attached user_output_string as l_string then
				Result := l_string
			end
			close
		end

feature	{NONE} -- Inflate Implementation

	read
			-- <Precursor>
		do
			if attached string as l_input_string then
				last_read_elements := string_read (l_input_string)
			end
		end

	write (a_amount: INTEGER)
			-- <Precursor>
		do
			if attached user_output_string as l_string then
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
				input_buffer.put_character (a_string.at (l_index), l_index - 1)
				l_index := l_index + 1
			end
			if l_index > a_string.count then
				end_of_input := True
			else
				if attached string as l_string then
				   string := l_string.substring (l_index, l_string.count)
				end
			end
			Result := l_index - 1
		end

	string_write (a_buffer: MANAGED_POINTER; a_amount: INTEGER; a_dest: STRING): INTEGER
			-- Write `a_amount' characters from `a_buffer' to `a_dest'
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

feature {NONE}-- Implementation

	string: detachable STRING
		-- STRING used to read the compressed output

	user_output_string: detachable STRING
		-- Content to inflate	

end
