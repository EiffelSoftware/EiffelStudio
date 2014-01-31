note
	description: "[
		Implements basic INPUT_STREAM as a stream filtered by the zlib compression
		algorithms. Source can be a file or an array of character, the buffer or
		file must be the results of a previous zlib compression.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_DATA_INFLATE

inherit
	UTIL_EXTERNALS

	ZLIB_CONSTANTS

create
	file_stream, file_stream_with_chunk,
	buffer_stream, buffer_stream_with_chunk


feature {NONE}--Initialization

	file_stream (a_file: FILE)
		require
			not_connected: not is_connected
			non_void_file: a_file /= Void
			file_open_read: a_file.is_open_read
		do
			make
			intialize
			file := a_file
		ensure
			file_set: attached file
		end

	file_stream_with_chunk (a_file: FILE; a_chunk: INTEGER)
		require
			greater_than_zero: a_chunk > 0
		do
			file_stream (a_file)
			chunk := a_chunk
		ensure
			chunk_set: chunk = a_chunk
		end

	buffer_stream (a_buffer: ARRAY[CHARACTER])
		require
			not_connected: not is_connected
			non_void_file: a_buffer /= Void
		do
			make
			intialize
			create buffer.make_from_array (a_buffer)
		ensure
			buffer_set: attached buffer
		end

	buffer_stream_with_chunk (a_buffer: ARRAY[CHARACTER]; a_chunk: INTEGER)
		require
			greater_than_zero: a_chunk > 0
		do
			buffer_stream (a_buffer)
			chunk := a_chunk
		ensure
			chunk_set: chunk = a_chunk
		end

	make
		do
				-- Initialize zlib for decompression
				-- Initialize zstream structure, inflate state
			create zstream.make
			zstream.set_available_input (0)
			create zlib

			  	-- Setup a default chunk size
			chunk := default_chunk
		end

	intialize
		do
				-- Initialize buffers
			create input_buffer.make_filled (create {CHARACTER}, 1, chunk)
			create output_buffer.make_filled (create {CHARACTER}, 1, chunk)
		end

feature -- Access		

	end_of_input: BOOLEAN

	has_error: BOOLEAN
		do
			Result := zlib.last_operation < 0
		end

	has_error_message: BOOLEAN
		do
			Result := zstream.message /= default_pointer
		end

	is_closable: BOOLEAN
		do
			Result := is_connected
		end

	is_connected: BOOLEAN
		do
			Result := file /= Void or else buffer /= Void
		end
		
	last_error_code: INTEGER
		do
			Result := zlib.last_operation
		end

	last_error_message: STRING
		require
			error_message: has_error_message
		do
			Result := string_from_external (zstream.message)
		end

	total_bytes_uncompressed: INTEGER
		do
			if zstream /= Void then
				Result := zstream.total_output
			end
		end

feature -- Intflate


	to_file (a_file: FILE)
			-- Inflate the compress data to file `a_file'
		require
			open_write: a_file.is_open_write
		do
			user_output_file := a_file
			inflate
			if attached user_output_file as l_file then
				l_file.close
			end
			close
		ensure
		 	user_output_file_closed: attached user_output_file as l_output_file implies l_output_file.is_closed
		end

	to_buffer : ARRAY[CHARACTER]
			--  Inflate the compress data to buffer content.
		do
			create Result.make_empty
			create user_output_buffer.make_empty
			inflate
			if attached user_output_buffer as l_buffer then
				Result.copy (l_buffer)
			end
			close
		end

feature {NONE} -- Inflate Implementation

	inflate
			--		Decompress from file `a_source' to file `a_dest' until stream ends or EOF.
			--   returns Z_OK on success, Z_MEM_ERROR if memory could not be
			--   allocated for processing, Z_DATA_ERROR if the deflate data is
			--   invalid or incomplete, Z_VERSION_ERROR if the version of zlib.h and
			--   the version of the library linked do not match, or Z_ERRNO if there
			--   is an error reading or writing the files.
		local
			l_have: INTEGER
				-- amount of data return by inflate.
			l_break: BOOLEAN
		do
			zlib.inflate_init (zstream)

			if not has_error then
					-- decompress until deflate stream ends or end of file
				from
				until
					end_of_input or l_break or has_error
				loop
						-- run inflate on input until output buffer not full
					from
						zstream.set_available_input (read)
						if zstream.available_input = 0 then
							l_break := True
						end
						zstream.set_next_input (character_array_to_external (input_buffer))
						zstream.set_available_output (Chunk)
						zstream.set_next_output (character_array_to_external (output_buffer))
						zlib.inflate (zstream, False)
						l_have := Chunk - zstream.available_output
						if write (l_have) /= l_have then
							zlib.inflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (Chunk)
						zstream.set_next_output (character_array_to_external (output_buffer))
						zlib.inflate (zstream, False)
						l_have := Chunk - zstream.available_output
						if write (l_have) /= l_have then
							zlib.inflate_end (zstream)
						end
					end
				end
					-- Clean up and return
				zlib.inflate_end (zstream)
			end
		end


	read: INTEGER
			-- Read data from file or buffer and
			-- put it into the input_buffer.
		do
			if attached file as l_file then
				Result := file_read (l_file)
			elseif attached buffer as l_input_buffer then
				Result := buffer_read (l_input_buffer)
			end
		end

	file_read (a_file: FILE): INTEGER
			-- Read the file by character until EOF or the number of elements (Chunk) was reached.
			-- Return the number of elements read.
			-- The `a_buffer' is updated with the file content.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
				a_file.read_character
			until
				a_file.end_of_file or else l_index > chunk
			loop
				input_buffer.force (a_file.last_character, l_index)
				l_index := l_index + 1
				if l_index <= chunk then
					a_file.read_character
				end
			end
			if a_file.end_of_file then
				end_of_input := True
			end
			Result := l_index - 1
		end

	buffer_read (a_buffer: ARRAY[CHARACTER]): INTEGER
			-- Read the buffer by character until end of buffer or the number of elements (Chunk) was reached.
			-- Return the number of elements read.
			-- The `a_buffer' is updated with the file content.
		local
			l_index: INTEGER
		do
			from
				l_index :=a_buffer.lower
			until
				l_index > a_buffer.upper or else l_index > chunk
			loop
				input_buffer.force (a_buffer[l_index], l_index)
				l_index := l_index + 1
			end
			if l_index > a_buffer.upper then
				end_of_input := True
			else
				if attached user_output_buffer  as l_buffer then
				  l_buffer.copy (a_buffer.subarray (l_index, a_buffer.upper))
				end
			end
			Result := l_index - 1

		end


	write (a_amount: INTEGER): INTEGER
			-- Write the `a_amount' of elements to the user_output_file or
			-- user_output_buffer.
		do
			if attached user_output_file as l_file then
				Result := file_write (output_buffer, a_amount, l_file)
			elseif attached user_output_buffer as l_buffer then
				Result := buffer_write (output_buffer,a_amount, l_buffer)
			end
		end

	file_write (a_buffer: ARRAY [CHARACTER]; a_amount: INTEGER; a_file: FILE): INTEGER
			-- Write the `a_amount' of elements from `a_buffer' to `a_file'.
			-- Return the number of elements written.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > a_amount
			loop
				a_file.put (a_buffer [l_index])
				l_index := l_index + 1
			end
			Result := l_index - 1
		end

	buffer_write (a_buffer: ARRAY [CHARACTER]; a_amount: INTEGER; a_dest: ARRAY[CHARACTER]): INTEGER
		local
			l_index: INTEGER
		do
			from
				l_index := a_buffer.lower
			until
				l_index > a_amount or l_index > a_buffer.upper
			loop
				a_dest.force (a_buffer[l_index], a_dest.upper + 1)
				l_index := l_index + 1
			end
			Result := l_index - 1
		end

	close
		require
			connected: is_connected
		do
			if attached file as ll_file then
				ll_file.close
				file := Void
			end
			if attached buffer as l_buffer then
				buffer := Void
			end
		end

feature {NONE} -- Implementation

	input_buffer: ARRAY[CHARACTER]
		-- Input buffer.

	output_buffer: ARRAY[CHARACTER]
		-- Output buffer

	chunk: INTEGER
		 -- the buffer size for feeding data to and pulling data from the zlib routines.

	default_chunk: INTEGER = 2048
		 -- default buffer size	

	zlib: ZLIB
		-- ZLIB Low level API

	zstream: ZLIB_STREAM
		-- structured used to pass information to zlib routines	

	file: detachable FILE
		-- file use to read the compressed output

	user_output_file: detachable FILE
		-- Output file, content to inflate

	buffer: detachable ARRAY[CHARACTER]
		-- Buffer used to read the compressed output

	user_output_buffer: detachable ARRAY [CHARACTER]
		-- Content to inflate	


end
