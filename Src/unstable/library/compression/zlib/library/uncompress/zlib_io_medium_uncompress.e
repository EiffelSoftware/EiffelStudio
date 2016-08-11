note
	description: "[
			Implements basic input stream as a stream filtered by the zlib compression
		algorithms. Source the results of a previous zlib compression. Target IO_MEDIUM.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_IO_MEDIUM_UNCOMPRESS

inherit

	ZLIB_UNCOMPRESS

create
	io_medium_stream,
	io_medium_stream_with_size

feature {NONE} -- Initialization

	io_medium_stream (a_medium: IO_MEDIUM)
		require
			not_connected: not is_connected
			non_void_medium: a_medium /= Void
			medium_open_read: a_medium.is_open_read
		do
			make
			intialize
			io_medium := a_medium
		ensure
			medium_set: attached io_medium
		end

	io_medium_stream_with_size (a_medium: IO_MEDIUM; a_size: INTEGER)
		require
			not_connected: not is_connected
			non_void_medium: a_medium /= Void
			medium_open_read: a_medium.is_open_read
			valid_size: a_size > 0
		do
			make_with_chunk_size (a_size)
			intialize
			io_medium := a_medium
		ensure
			medium_set: attached io_medium
		end

feature -- Access

	is_connected: BOOLEAN
		do
			Result := attached io_medium
		end

feature -- Inflate

	to_medium (a_medium: IO_MEDIUM)
			-- Inflate the compress data to medium `a_medium'
		require
			not_null_medium: a_medium /= Void
			open_write: a_medium.is_open_write
		do
			user_output_io_medium := a_medium
			inflate
			if attached user_output_io_medium as l_medium then
				l_medium.close
			end
			close
		ensure
			 user_output_medium_closed: attached user_output_io_medium as l_output_medium implies l_output_medium.is_closed
		end

feature	{NONE} -- Inflate Implementation

	read
			-- <Precursor>
		do
			if attached io_medium as l_input_medium then
				last_read_elements := io_medium_read (l_input_medium)
			end
		end

	write (a_amount: INTEGER)
			-- <Precursor>
		do
			if attached user_output_io_medium as l_medium then
				last_write_elements := io_medium_write (output_buffer,a_amount,l_medium)
			end
		end

	close
			-- <Precursor>
		do
			if attached io_medium as l_medium then
				l_medium.close
			end
		end

	io_medium_read (a_medium: IO_MEDIUM): INTEGER
			-- Read the a_string by character until end of string or the number of elements (Chunk) was reached.
			-- Return the number of elements read.
		local
			l_index: INTEGER
			l_string: STRING
		do
			a_medium.read_stream (chunk_size)
			l_string := a_medium.last_string
			from
				l_index := 1
			until
				l_index > l_string.count
			loop
				input_buffer.put_character (l_string.at (l_index), l_index - 1)
				l_index := l_index + 1
			end
			if l_string.count < chunk_size then
				end_of_input := True
			end
			Result := l_index - 1
		end

	io_medium_write  (a_buffer: MANAGED_POINTER; a_amount: INTEGER; a_dest: IO_MEDIUM): INTEGER
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_amount or l_index > a_buffer.count
			loop
				a_dest.put_character (a_buffer.read_character (l_index - 1))
				l_index := l_index + 1
			end
			Result := l_index - 1
		end

feature {NONE}-- Implementation

	io_medium: detachable IO_MEDIUM
		-- used to read the compressed output

	user_output_io_medium: detachable IO_MEDIUM
		-- Content to inflate	

end
