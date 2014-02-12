note
	description: "[
			Abstract class, representing basic input stream as a stream filtered by the zlib compression
			algorithms. Source: the results of a previous zlib compression.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ZLIB_UNCOMPRESS
inherit

	UTIL_EXTERNALS

feature -- Initialization

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
			create input_buffer.make_from_array (create {ARRAY[NATURAL_8]}.make_filled (0, 1, chunk))
			create output_buffer.make_from_array (create {ARRAY[NATURAL_8]}.make_filled (0, 1, chunk))
		end


feature -- Access		

	end_of_input: BOOLEAN

	has_error: BOOLEAN
			-- Is there an error?
		do
			Result := zlib.last_operation < 0
		end

	has_error_message: BOOLEAN
			-- Is there an error message?
		do
			Result := zstream.message /= default_pointer
		end

	is_closable: BOOLEAN
		do
			Result := is_connected
		end

	is_connected: BOOLEAN
		deferred
		end

	last_error_code: INTEGER
			-- Last error code from ZLib.
		do
			Result := zlib.last_operation
		end

	last_error_message: STRING
			-- Message for the last error.
		require
			error_message: has_error_message
		do
			Result := string_from_external (zstream.message)
		end

	total_bytes_uncompressed: INTEGER
			-- Number of bytes uncompressed.
		do
			if zstream /= Void then
				Result := zstream.total_output
			end
		end

feature -- Change Element

	set_chunk (a_chunk: INTEGER)
			-- Set `a_chunk' to `chunk'
		do
			chunk := a_chunk
		ensure
			chunk_set: chunk = a_chunk
		end


feature {NONE} -- Inflate Implementation

	inflate
			--		Decompress from file `a_source' to `a_dest' until stream ends.
			--   set the result in Zlib.last_operation with Z_OK on success, Z_MEM_ERROR if memory could not be
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
						zstream.set_next_input (input_buffer.item)
						zstream.set_available_output (Chunk)
						zstream.set_next_output (output_buffer.item)
						zlib.inflate (zstream, False)
						l_have := Chunk - zstream.available_output
						if write (l_have) /= l_have then
							zlib.inflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (Chunk)
						zstream.set_next_output (output_buffer.item)
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
			-- Read data from the medium
			-- put it into the input_buffer.
		deferred
		end

	write (a_amount: INTEGER): INTEGER
			-- Write the `a_amount' of elements to the user_output_file or
			-- user_output_buffer.
		deferred
		end

	close
		require
			connected: is_connected
		deferred
		end

feature {NONE} -- Implementation

	input_buffer: MANAGED_POINTER
		-- Input buffer.

	output_buffer: MANAGED_POINTER
		-- Output buffer

	chunk: INTEGER
		 -- the buffer size for feeding data to and pulling data from the zlib routines.

	default_chunk: INTEGER = 2048
		 -- default buffer size	

	zlib: ZLIB
		-- ZLIB Low level API

	zstream: ZLIB_STREAM
		-- structure used to pass information to zlib routines	

end
