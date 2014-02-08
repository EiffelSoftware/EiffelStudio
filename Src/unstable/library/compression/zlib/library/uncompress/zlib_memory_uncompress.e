note
	description: "[
			Implements basic input stream as a stream filtered by the zlib compression
		algorithms. Source the results of a previous zlib compression. Target Memory.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_MEMORY_UNCOMPRESS

inherit

	ZLIB_UNCOMPRESS

create
	memory_stream

feature {NONE} -- Initialization

	memory_stream (a_memory: MANAGED_POINTER)
		require
			not_connected: not is_connected
			non_void_memory: a_memory /= Void
		do
			make
			intialize
			memory := a_memory
		ensure
			memory_set: attached memory
		end

feature -- Access

	is_connected: BOOLEAN
		do
			Result := attached memory
		end

feature -- Inflate

	to_memory: MANAGED_POINTER
			--  Inflate the compress data to memory content.
		do
			create Result.make (Chunk)
			create user_output_memory.make_empty
			inflate
			if attached user_output_memory as l_buffer then
				create Result.make_from_array (l_buffer)
			end
			close
		end

feature	{NONE} -- Inflate Implementation

	read: INTEGER
			-- <Precursor>
		do
			if attached memory as l_input_memory then
				Result := memory_read (l_input_memory)
			end
		end

	write (a_amount: INTEGER): INTEGER
			-- Write the `a_amount' of elements to the user_output_file or
			-- user_output_buffer.
		do
			if attached user_output_memory as l_memory then
				Result := memory_write (output_buffer,a_amount, l_memory)
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
				l_index > a_buffer.count or else l_index > chunk
			loop
				input_buffer.put_character(a_buffer.read_character (l_index - 1), l_index - 1)
				l_index := l_index + 1
			end
			if l_index > a_buffer.count then
				end_of_input := True
			else
				if attached user_output_memory as l_memory then
					l_memory.copy (a_buffer.read_array (l_index, a_buffer.count))
				end
			end
			Result := l_index - 1
		end

	memory_write (a_buffer: MANAGED_POINTER ; a_amount: INTEGER; a_dest: ARRAY[NATURAL_8]): INTEGER
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_amount or l_index > a_buffer.count
			loop
				a_dest.force (a_buffer.read_natural_8 (l_index - 1),l_index)
				l_index := l_index + 1
			end
			Result := l_index - 1
		end

feature {NONE}-- Implementation

	memory: detachable MANAGED_POINTER
		-- Memory used to read the compressed output

	user_output_memory: detachable ARRAY[NATURAL_8]
		-- Content to inflate	

end
