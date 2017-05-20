note
	description: "[
		Abstract class representing basic output stream as a stream filtered by the zlib compression
		algorithms.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ZLIB_COMPRESS

inherit

	UTIL_EXTERNALS

feature {NONE} -- Initialization

	make
		do
				-- Initialize zlib and zstream structure, default state
			create zstream.make
			create zlib

				-- Setup a default chunk size
			chunk_size := default_chunk

				-- Setup a default compression level
			compression_level := {ZLIB_CONSTANTS}.Z_default_compression
			mark_default_flush
		end

	make_with_chunk_size (a_size: INTEGER)
		require
			valid_size: a_size > 0
		do
				-- Initialize zlib and zstream structure, default state
			create zstream.make
			create zlib

				-- Setup a user defined chunk size
				-- A valid stream can use any chunk size(>0).
			chunk_size := a_size

				-- Setup a default compression level
			compression_level := {ZLIB_CONSTANTS}.Z_default_compression
			mark_default_flush
		ensure
			chunk_size_set: chunk_size = a_size
		end

	intialize
		do
				-- Initialize buffers
			create input_buffer.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, chunk_size))
			create output_buffer.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, chunk_size))
		end


feature -- Flush Modes

	last_chunk: NATURAL
			-- Has no more output.

	no_last_chunk: NATURAL
			-- To indicate we are not yet at the end of the input.

	mark_default_flush
			-- Default flush mode.
		note
			EIS: "name=default flush", "src=http://www.zlib.net/zlib_how.html", "protocol=URI"
		do
			last_chunk := {ZLIB_CONSTANTS}.z_finish
			no_last_chunk:= {ZLIB_CONSTANTS}.z_no_flush
		ensure
			set_last_chunk : last_chunk = {ZLIB_CONSTANTS}.z_finish
			set_not_last_chunk: no_last_chunk = {ZLIB_CONSTANTS}.z_no_flush
		end

	mark_full_flush
			-- Full flush mode
			-- Flush mode for PPP protocol.
		note
			EIS: "name=Flush modes", "http://www.bolet.org/~pornin/deflate-flush-fr.html", "protocol=uri"
			EIS: "name=PPP protocol", "https://www.ietf.org/rfc/rfc1979.txt", "protocol=uri"
			EIS: "name=Zlib flush", "https://github.com/madler/zlib/issues/149", "protocol=uri"
		do
			last_chunk := {ZLIB_CONSTANTS}.z_full_flush
			no_last_chunk:= {ZLIB_CONSTANTS}.Z_block
		ensure
			set_last_chunk : last_chunk = {ZLIB_CONSTANTS}.z_full_flush
			set_no_last_chunk: no_last_chunk = {ZLIB_CONSTANTS}.Z_block
		end

	mark_sync_flush
			-- Default flush mode.
			-- Flush mode for PPP protocol.
		note
			EIS: "name=Flush modes", "http://www.bolet.org/~pornin/deflate-flush-fr.html", "protocol=uri"
			EIS: "name=PPP protocol", "https://www.ietf.org/rfc/rfc1979.txt", "protocol=uri"
		do
			last_chunk := {ZLIB_CONSTANTS}.z_finish
			no_last_chunk:= {ZLIB_CONSTANTS}.z_sync_flush
		ensure
			set_last_chunk : last_chunk = {ZLIB_CONSTANTS}.z_finish
			set_no_last_chunk: no_last_chunk = {ZLIB_CONSTANTS}.z_sync_flush
		end

feature --Access

	has_error: BOOLEAN
			-- is there an error?
		do
			Result := zlib.last_operation < 0
		end

	is_connected: BOOLEAN
			-- Is the corresponding medium to write the compressed output, attached?
		deferred
		end

	has_error_message: BOOLEAN
			-- Is there a message error?
		do
			Result := zstream.message /= default_pointer
		end

	is_closed: BOOLEAN
			-- Is not connected.
		do
			Result := is_connected
		end

	last_error_code: INTEGER
			-- Last error code from zlib.
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

	total_bytes_compressed: INTEGER_64
			-- number of bytes compressed.
		do
			Result := zstream.total_input
		end

	last_read_elements: INTEGER
			-- Number of elements read by `read'.

	last_write_elements: INTEGER
			-- Number of elements written by `write'.

feature -- Change Element

	set_compression_level (a_level: INTEGER)
			-- Set `compression_level' to `a_compression_level'
		require
			known_level: a_level >= {ZLIB_CONSTANTS}.Z_default_compression and then a_level <= {ZLIB_CONSTANTS}.Z_best_compression
		do
			compression_level := a_level
		ensure
			compression_level_set: compression_level = a_level
		end

feature {NONE} -- Deflate implementation

	deflate_with_options (a_level, a_window_bits, a_mem_level, a_strategy: INTEGER_32)
			-- `a_level': The compression level must be Z_DEFAULT_COMPRESSION, or between 0 and 9
			-- 1 gives best speed, 9 gives best compression, 0 gives no compression at all Compression level 0..9
			-- `a_windows_bits': Higher values use more memory, but produce smaller output. The default is 15.  It should be in the range 8..15.
			-- `a_mem_level':Higher values use more memory, but are faster and produce smaller output. The default is 8.
		local
			l_flush: NATURAL
				-- current flushing state deflate.
			l_have: INTEGER
			-- amount of data return by deflate.
		do
				-- The compression method is Z_DEFLATED for the current version.
			zlib.deflate_init_2 (zstream, a_level, {ZLIB_CONSTANTS}.z_deflated.to_integer_32, a_window_bits, a_mem_level, a_strategy)

				-- Refactor to deflate_common.
			if not has_error then
				from
				until
					end_of_input or has_error
				loop
					read
					zstream.set_available_input (last_read_elements)
					zstream.set_next_input (input_buffer.item)
					if end_of_input then
						l_flush := last_chunk
					else
						l_flush := no_last_chunk
					end

						-- run deflate on input until output buffer not full, finish compression if all of source has been read in
					from
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.deflate (zstream, l_flush)
						check
							zlib_ok: zlib.last_operation /= {ZLIB_CONSTANTS}.Z_stream_error
						end
						l_have := chunk_size - zstream.available_output
						write (l_have)
						if last_write_elements /= l_have then
							zlib.deflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.deflate (zstream, l_flush)
						check
							l_zlib_ok: zlib.last_operation /= {ZLIB_CONSTANTS}.Z_stream_error
						end
						l_have := chunk_size - zstream.available_output
						write (l_have)
						if last_write_elements /= l_have then
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
					stream_end: zlib.last_operation = {ZLIB_CONSTANTS}.z_stream_end or else zlib.last_operation = {ZLIB_CONSTANTS}.z_ok
				end
					-- clean up and return
				zlib.deflate_end (zstream)
			end
		end

	deflate
			--	 Compress from `a_source' to `a_dest' until EOF on `a_source'.
			--   set the result in Zlib.last_operation with Z_OK on success, Z_MEM_ERROR if memory could not be
			--   allocated for processing, Z_STREAM_ERROR if an invalid compression
			--   level is supplied, Z_VERSION_ERROR if the version of zlib.h and the
			--   version of the library linked do not match, or Z_ERRNO if there is
			--   an error reading or writing the files.
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
					read
					zstream.set_available_input (last_read_elements)
					zstream.set_next_input (input_buffer.item)
					if end_of_input then
						l_flush := last_chunk
					else
						l_flush := no_last_chunk
					end

						-- run deflate on input until output buffer not full, finish compression if all of source has been read in
					from
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.deflate (zstream, l_flush)
						check
							zlib_ok: zlib.last_operation /= {ZLIB_CONSTANTS}.Z_stream_error
						end
						l_have := chunk_size - zstream.available_output
						write (l_have)
						if last_write_elements /= l_have then
							zlib.deflate_end (zstream)
						end
					until
						zstream.available_output /= 0 or has_error
					loop
						zstream.set_available_output (chunk_size)
						zstream.set_next_output (output_buffer.item)
						zlib.deflate (zstream, l_flush)
						check
							l_zlib_ok: zlib.last_operation /= {ZLIB_CONSTANTS}.Z_stream_error
						end
						l_have := chunk_size - zstream.available_output
						write (l_have)
						if last_write_elements /= l_have then
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
					stream_end: zlib.last_operation = {ZLIB_CONSTANTS}.z_stream_end or else zlib.last_operation = {ZLIB_CONSTANTS}.z_ok
				end
					-- clean up and return
				zlib.deflate_end (zstream)
			end
		end

	read
			-- Read the medium by character until end of it or the number of elements (Chunk) was reached.
			-- Make result available in `last_read_elements'.
		deferred
		end

	write (a_amount: INTEGER)
			-- Write the `a_amount' of elements from `output_buffer' to a corresponding medium
			-- Make the result available in `last_write_elements'.
		deferred
		end

	close
		require
			connected: is_connected
		deferred
		end

feature {NONE} -- Implementation

	end_of_input: BOOLEAN
			-- Has end of input been detected?

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

	compression_level: INTEGER
			-- Zlib compression, by default is set to
			-- Z_default_compression level.

end
