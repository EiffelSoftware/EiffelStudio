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

feature {NONE} -- Initialization

	make
		do
				-- Initialize zlib for decompression
				-- Initialize zstream structure, inflate state
			create zstream.make
			zstream.set_available_input (0)
			create zlib

			  	-- Setup a default chunk size
			chunk_size := default_chunk
		end

	make_with_chunk_size (a_size: INTEGER)
		require
			valid_size: a_size > 0
		do
				-- Initialize zlib for decompression
				-- Initialize zstream structure, inflate state
			create zstream.make
			zstream.set_available_input (0)
			create zlib		-- Setup a user defined chunk size

				-- A valid stream can use any chunk size(>0).
			chunk_size := a_size
		ensure
			chunk_size_set: chunk_size = a_size
		end

	intialize
		do
				-- Initialize buffers
			create input_buffer.make_from_array (create {ARRAY[NATURAL_8]}.make_filled (0, 1, chunk_size))
			create output_buffer.make_from_array (create {ARRAY[NATURAL_8]}.make_filled (0, 1, chunk_size))
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

	total_bytes_uncompressed: INTEGER_64
			-- Number of bytes uncompressed.
		do
			if zstream /= Void then
				Result := zstream.total_output
			end
		end

	last_read_elements: INTEGER
			-- Number of elements read by `read'.

	last_write_elements: INTEGER
			-- Number of elements written by `write'.

feature {NONE} -- Inflate Implementation

	inflate_with_options (a_windows_bits: INTEGER)
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
			zlib.inflate_init_2 (zstream, a_windows_bits)

				-- Todo refactor inflate_common
			if not has_error then
					-- decompress until deflate stream ends or end of file
				from
				until
					end_of_input or l_break
				loop
						-- run inflate on input until output buffer not full
					from
						read
						zstream.set_available_input (last_read_elements)
						if zstream.available_input = 0 then
							l_break := True
						end
						zstream.set_next_input (input_buffer.item)
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.inflate (zstream, {ZLIB_CONSTANTS}.Z_no_flush) -- False
						l_have := chunk_size - zstream.available_output
						write (l_have)
						if last_write_elements /= l_have then
							zlib.inflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.inflate (zstream, {ZLIB_CONSTANTS}.Z_no_flush) -- False
							-- Z_BUF_ERROR is just an indication that there was nothing for inflate() to do on that call.
							-- Simply continue and provide more input data and more output space for the next inflate() call.
						if zlib.last_operation /= zlib.z_buf_error then
							l_have := chunk_size - zstream.available_output
							write (l_have)
							if last_write_elements /= l_have then
								zlib.inflate_end (zstream)
							end
						end
					end
				end
					-- Clean up and return
				zlib.inflate_end (zstream)
			end
		end


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
					end_of_input or l_break
				loop
						-- run inflate on input until output buffer not full
					from
						read
						zstream.set_available_input (last_read_elements)
						if zstream.available_input = 0 then
							l_break := True
						end
						zstream.set_next_input (input_buffer.item)
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.inflate (zstream, {ZLIB_CONSTANTS}.Z_no_flush)  -- False
						l_have := chunk_size - zstream.available_output
						write (l_have)
						if last_write_elements /= l_have then
							zlib.inflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.inflate (zstream, {ZLIB_CONSTANTS}.Z_no_flush) -- False
							-- Z_BUF_ERROR is just an indication that there was nothing for inflate() to do on that call.
							-- Simply continue and provide more input data and more output space for the next inflate() call.
						if zlib.last_operation /= zlib.z_buf_error then
							l_have := chunk_size - zstream.available_output
							write (l_have)
							if last_write_elements /= l_have then
								zlib.inflate_end (zstream)
							end
						end
					end
				end
					-- Clean up and return
				zlib.inflate_end (zstream)
			end
		end


	read
			-- Read data from the medium
			-- Make result available in `last_read_elements'.
		deferred
		end

	write (a_amount: INTEGER)
			-- Write the `a_amount' of elements to the user_output_file or
			-- Make result available in `last_write_elements'.
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

	chunk_size: INTEGER
		 -- the buffer size for feeding data to and pulling data from the zlib routines.

	default_chunk: INTEGER = 16384
		 -- default buffer size	

	zlib: ZLIB
		-- ZLIB Low level API

	zstream: ZLIB_STREAM
		-- structure used to pass information to zlib routines	

end
