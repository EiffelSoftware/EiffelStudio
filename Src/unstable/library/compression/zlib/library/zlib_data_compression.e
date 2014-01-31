note
	description: "[
			Implements basic OUTPUT_STREAM as a stream filtered by the zlib compression
			algorithms. Target can be a file or an buffer of character
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_DATA_COMPRESSION

inherit

	UTIL_EXTERNALS

	ZLIB_CONSTANTS

create
	file_stream, file_stream_with_chunk, file_stream_with_level, file_stream_with_level_and_chunk,
	buffer_stream, buffer_stream_with_chunk, buffer_stream_with_level, buffer_stream_with_level_and_chunk


feature {NONE}--Initialization

	file_stream (a_file: FILE)
		require
			not_connected: not is_connected
			non_void_file: a_file /= Void
			file_open_read_write: a_file.is_open_read and then a_file.is_open_write
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

	file_stream_with_level (a_file: FILE; a_level: INTEGER)
		require
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			file_stream (a_file)
			compression_level := a_level
		ensure
			compression_level_set: compression_level = a_level
		end

	file_stream_with_level_and_chunk (a_file: FILE; a_level: INTEGER; a_chunk: INTEGER)
		require
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			file_stream (a_file)
			compression_level := a_level
			chunk := a_chunk
		ensure
			compression_level_set: compression_level = a_level
			chunk_set: chunk = a_chunk
		end

	buffer_stream (a_buffer: ARRAY[CHARACTER])
		require
			not_connected: not is_connected
			non_void_file: a_buffer /= Void
		do
			make
			intialize
			buffer := a_buffer
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

	buffer_stream_with_level (a_buffer: ARRAY[CHARACTER]; a_level: INTEGER)
		require
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			buffer_stream (a_buffer)
			compression_level := a_level
		ensure
			compression_level_set: compression_level = a_level
		end

	buffer_stream_with_level_and_chunk (a_buffer: ARRAY[CHARACTER]; a_level: INTEGER; a_chunk: INTEGER)
		require
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			buffer_stream (a_buffer)
			compression_level := a_level
			chunk := a_chunk
		ensure
			compression_level_set: compression_level = a_level
			chunk_set: chunk = a_chunk
		end


	make
		do
				-- Initialize zlib and zstream structure, default state
			create zstream.make
			create zlib

			  	-- Setup a default chunk size
			chunk := default_chunk

				-- Setup a default compression level
			compression_level := {ZLIB_CONSTANTS}.Z_default_compression
		end

	intialize
		do
				-- Initialize buffers
			create input_buffer.make_filled (create {CHARACTER}, 1, chunk)
			create output_buffer.make_filled (create {CHARACTER}, 1, chunk)
		end


feature --Access

	has_error: BOOLEAN
			-- is there an error?
		do
			Result := zlib.last_operation < 0
		end

	is_connected: BOOLEAN
		do
			Result := file /= Void or else buffer /= Void
		end

	has_error_message: BOOLEAN
		do
			Result := zstream.message /= default_pointer
		end

	is_closed: BOOLEAN
		do
			Result := is_connected
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

	total_bytes_compressed: INTEGER
			-- number of bytes compressed.
		do
			Result := zstream.total_input
		end


feature -- Deflate

	put_file (a_file: STRING)
			-- Defalte the file content.
		do
			create user_input_file.make_open_read (a_file)
			deflate
			if attached user_input_file as l_file then
				l_file.close
			end
			if attached file as ll_file then
				ll_file.close
			end
		end

	put_buffer (a_buffer: ARRAY[CHARACTER])
			-- Deflate the buffer content.
		do
			create user_input_buffer.make_from_array (a_buffer)
			deflate
			user_input_buffer := Void
		end


feature {NONE} -- Deflate implementation

	deflate
		local
			l_flush: NATURAL
				-- current flushing state deflate.
			l_have: INTEGER
				-- amount of data return by deflate.
		do
			zlib.deflate_init (zstream, compression_level)
			if not has_error then
				from
				until
					end_of_input or has_error
				loop
					zstream.set_available_input (read)
					zstream.set_next_input (character_array_to_external (input_buffer))
					if end_of_input then
						l_flush := z_finish
					else
						l_flush := z_no_flush
					end

						-- run deflate on input until output buffer not full, finish compression if all of source has been read in
					from
						zstream.set_available_output (Chunk)
						zstream.set_next_output (character_array_to_external (output_buffer))
						zlib.deflate (zstream, l_flush)
						check
							zlib_ok: zlib.last_operation /= Z_stream_error
						end
						l_have := Chunk - zstream.available_output
						if write (l_have) /= l_have then
							zlib.deflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (Chunk)
						zstream.set_next_output (character_array_to_external (output_buffer))
						zlib.deflate (zstream, l_flush)
						check
							l_zlib_ok: zlib.last_operation /= Z_stream_error
						end
						l_have := Chunk - zstream.available_output
						if write (l_have) /= l_have then
							zlib.deflate_end (zstream)
						end
					end
						-- All input will be used
					check
						all_input: zstream.available_input = 0
					end
				end
					-- -- All input will be completed
				check
					stream_end: zlib.last_operation = z_stream_end
				end

					-- clean up and return
				zlib.deflate_end (zstream)
			end
		end


	read: INTEGER
		do
			if attached user_input_file as l_file then
				Result := file_read (l_file)
			elseif attached user_input_buffer as l_input_buffer then
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
				if attached user_input_buffer  as l_buffer then
				  l_buffer.copy (a_buffer.subarray (l_index, a_buffer.upper))
				end
			end
			Result := l_index - 1

		end


	write (a_amount: INTEGER): INTEGER
		do
			if attached file as l_file then
				Result := file_write (output_buffer, a_amount, l_file)
			elseif attached buffer as l_buffer then
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

feature {NONE} -- Implementation

	end_of_input: BOOLEAN

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

	compression_level: INTEGER
		-- Zlib compression, by default is set to
		-- Z_default_compression level.

	file: detachable FILE
		-- file use to write the compressed output

	user_input_file: detachable RAW_FILE
		-- Input file, content to compress

	buffer: detachable ARRAY[CHARACTER]
		-- Buffer used to write the compressed output

	user_input_buffer: detachable ARRAY [CHARACTER]
		-- Content to compress	
end
