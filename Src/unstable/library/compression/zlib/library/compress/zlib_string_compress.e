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
	string_stream

feature -- Initialization

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

feature -- Deflate

	put_string (a_string: READABLE_STRING_GENERAL)
			-- Deflate the buffer content.
		do
			create user_input_string.make_from_string (a_string.as_string_8)
			deflate
			close
		end

feature -- Access

	is_connected: BOOLEAN
			-- <Precursor>
		do
			Result := attached string
		end

feature {NONE} -- Deflate implementation		

	read: INTEGER
			-- <Precursor>
		do
			if attached user_input_string as l_input_string then
				Result := string_read (l_input_string)
			end
		end

	write (a_amount: INTEGER): INTEGER
			-- <Precursor>
		do
			if attached string as l_string then
				Result := string_write (output_buffer,a_amount, l_string)
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
				l_index > a_string.count or else l_index > chunk
			loop
				input_buffer.put_character(a_string.at (l_index), l_index - 1)
				l_index := l_index + 1
			end
			if l_index > a_string.count then
				end_of_input := True
			else
				if attached user_input_string as l_string then
				   string := l_string.substring (l_index, l_string.count)
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
