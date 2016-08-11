note
	description: "[
				Implements basic output stream as a stream filtered by the zlib compression
				algorithms. Target Memory.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_MEMORY_COMPRESS

inherit

	ZLIB_COMPRESS

create
	memory_stream,
	memory_stream_with_size

feature {NONE} -- Initialization

	memory_stream (a_memory: MANAGED_POINTER)
		require
			not_connected: not is_connected
		do
			make
			intialize
			memory := a_memory
		ensure
			memory_set: attached memory
		end

	memory_stream_with_size (a_memory: MANAGED_POINTER; a_size: INTEGER)
		require
			not_connected: not is_connected
			valid_size: a_size > 0
		do
			make_with_chunk_size (a_size)
			intialize
			memory := a_memory
		ensure
			memory_set: attached memory
		end

feature -- Deflate

	put_memory (a_memory: MANAGED_POINTER)
			-- Deflate the memory content.
		do
			user_input_memory := a_memory
			deflate
			close
		end

feature -- Access

	is_connected: BOOLEAN
			-- <Precursor>
		do
			Result := attached memory
		end

feature {NONE} -- Deflate implementation		

	read
			-- <Precursor>
		do
			if attached user_input_memory as l_input_memory then
				last_read_elements := memory_read (l_input_memory)
			end
		end

	write (a_amount: INTEGER)
			-- <Precursor>
		do
			if attached memory as l_memory then
				last_write_elements := memory_write (output_buffer,a_amount,l_memory)
			end
		end

	close
			-- <Precursor>
		do
			if attached memory as l_memory then
				memory := Void
			end
		end

	memory_read (a_buffer: MANAGED_POINTER): INTEGER
			-- Read the `a_buffer' by character until end of it or the number of elements (Chunk) was reached.
			-- Return the number of elements read.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_buffer.count or else l_index > chunk_size
			loop
				input_buffer.put_character(a_buffer.read_character (l_index - 1), l_index - 1)
				l_index := l_index + 1
			end
			if l_index > a_buffer.count then
				end_of_input := True
			else
				if attached user_input_memory as l_memory then
					l_memory.copy (create {MANAGED_POINTER}.make_from_array (a_buffer.read_array (l_index, a_buffer.count)))
				end
			end
			Result := l_index - 1
		end

	memory_write (a_buffer: MANAGED_POINTER ; a_amount: INTEGER; a_dest: MANAGED_POINTER): INTEGER
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_amount or l_index > a_buffer.count
			loop
				a_dest.put_character (a_buffer.read_character (l_index - 1),l_index - 1)
				l_index := l_index + 1
			end
			Result := l_index - 1
		end

feature {NONE} -- Implementation

	memory: detachable MANAGED_POINTER
		-- Memory used to write the compressed ouput

	user_input_memory: detachable MANAGED_POINTER
		-- Content to compress	

end

