note
	description : "basic_functions application: show proper use of zlib's inflate() and deflate()"
	date        : "$Date$"
	revision    : "$Revision$"
	EIS: "name:zpipe", "src=http://www.zlib.net/zpipe.c", "protocol=uri"
	EIS: "name:Zlib how-to", "src=http://www.zlib.net/zlib_how.html", "protocol=uri"

class
	APPLICATION

inherit

	ARGUMENTS

	ZLIB_CONSTANTS

	UTIL_EXTERNALS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			basic_example_without_streams
			stream_example_file_to_file
			stream_example_buffer
		end

	basic_example_without_streams
		local
			l_source: RAW_FILE
			l_dest: RAW_FILE
			l_new_source: RAW_FILE
			l_ret: INTEGER
			l_new_read: RAW_FILE
		do
			create l_source.make_open_read (source_file)
			create l_dest.make_create_read_write (dest_file)
			create l_new_source.make_create_read_write (new_source)
			l_ret := deflate (l_source, l_dest, z_default_compression)
			l_dest.close
			create l_new_read.make_open_read (dest_file)
			if l_ret /= z_ok then
				print ("%NError:" + l_ret.out)
			else
				print ("%NCompress OK")
			end
			l_ret := inflate (l_new_read, l_new_source)
			if l_ret /= z_ok then
				print ("%NError:" + l_ret.out)
			else
				print ("%NDempress OK")
			end
		end

	stream_example_file_to_file
		local
			zi: ZLIB_DATA_INFLATE
			zo: ZLIB_DATA_COMPRESSION
			l_file: FILE
		do
			create {RAW_FILE}l_file.make_create_read_write ("new_test.txt")
			create zo.file_stream (l_file)
			zo.put_file (source_file)
			create {RAW_FILE}l_file.make_open_read ("new_test.txt")
			create zi.file_stream (l_file)
			zi.to_file ("new_file.txt")

			print ("%NBytes compresses:" + zo.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + zi.total_bytes_uncompressed.out)
		end


	stream_example_buffer
		local
			zi: ZLIB_DATA_INFLATE
			zo: ZLIB_DATA_COMPRESSION
			input_buffer: ARRAY[CHARACTER]
			output_buffer: ARRAY[CHARACTER]
			new_buffer: ARRAY[CHARACTER]
		do
			input_buffer := <<'a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
						'a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
						'a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','a','b','c','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
						>>
			create output_buffer.make_empty
			create zo.buffer_stream (output_buffer)
			zo.put_buffer (input_buffer)
			create zi.buffer_stream (output_buffer)
			new_buffer := zi.to_buffer
			new_buffer.compare_objects
			input_buffer.compare_objects
			check
				same_content: new_buffer.is_equal (input_buffer)
			end
			print ("%NBytes compresses:" + zo.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + zi.total_bytes_uncompressed.out)
		end

	deflate (a_source: RAW_FILE; a_dest: RAW_FILE; a_level: INTEGER): INTEGER
			--		 Compress from file `a_source' to file `a_dest' until EOF on `a_source'.
			--   returns Z_OK on success, Z_MEM_ERROR if memory could not be
			--   allocated for processing, Z_STREAM_ERROR if an invalid compression
			--   level is supplied, Z_VERSION_ERROR if the version of zlib.h and the
			--   version of the library linked do not match, or Z_ERRNO if there is
			--   an error reading or writing the files.
		local
			l_flush: NATURAL
				-- current flushing state deflate.
			l_have: INTEGER
				-- amount of data return by deflate.
			l_zlib: ZLIB
			l_stream: ZLIB_STREAM
				-- structured used to pass information to zlib routines
			l_in: ARRAY [CHARACTER]
				-- Input buffer
			l_out: ARRAY [CHARACTER]
			-- output buffer

		do
				-- Initialize zlib for compression
				-- Initialize zstream structure, default state
			create l_stream.make
			create l_zlib
			l_zlib.deflate_init (l_stream, a_level)

			if l_zlib.last_operation /= z_ok then
				Result := l_zlib.last_operation
			else
					-- Compress until the end of file.
				create l_in.make_filled (create {CHARACTER}, 1, chunk)
				create l_out.make_filled (create {CHARACTER}, 1, chunk)

					--Compress until the end of the file
				from
				until
					a_source.end_of_file or Result = z_errno
				loop
					l_stream.set_available_input (file_read (l_in, a_source))
					l_stream.set_next_input (character_array_to_external (l_in))
					if a_source.end_of_file then
						l_flush := z_finish
					else
						l_flush := z_no_flush
					end

						-- run deflate on input until output buffer not full, finish compression if all of source has been read in
					from
						l_stream.set_available_output (Chunk)
						l_stream.set_next_output (character_array_to_external (l_out))
						l_zlib.deflate (l_stream, l_flush)
						check
							l_zlib_ok: l_zlib.last_operation /= l_zlib.Z_stream_error
						end
						l_have := Chunk - l_stream.available_output
						if file_write (l_out, l_have, a_dest) /= l_have then
							l_zlib.deflate_end (l_stream)
							Result := Z_errno
						end
					until
						l_stream.available_output /= 0 or Result = z_errno
					loop
						l_stream.set_available_output (chunk)
						l_stream.set_next_output (character_array_to_external (l_out))
						l_zlib.deflate (l_stream, l_flush)
						check
							l_zlib_ok: l_zlib.last_operation /= l_zlib.z_stream_error
						end
						l_have := Chunk - l_stream.available_output
						if file_write (l_out, l_have, a_dest) /= l_have then
							l_zlib.deflate_end (l_stream)
							Result := z_errno
						end
					end
						-- All input will be used
					check
						all_input: l_stream.available_input = 0
					end
				end
					-- -- All input will be completed
				check
					stream_end: l_zlib.last_operation = z_stream_end
				end

					-- clean up and return
				l_zlib.deflate_end (l_stream)
				Result := l_zlib.last_operation
			end
		end

	inflate (a_source: RAW_FILE; a_dest: RAW_FILE): INTEGER
			--		Decompress from file `a_source' to file `a_dest' until stream ends or EOF.
			--   returns Z_OK on success, Z_MEM_ERROR if memory could not be
			--   allocated for processing, Z_DATA_ERROR if the deflate data is
			--   invalid or incomplete, Z_VERSION_ERROR if the version of zlib.h and
			--   the version of the library linked do not match, or Z_ERRNO if there
			--   is an error reading or writing the files.
		local
			l_have: INTEGER
				-- amount of data return by inflate.
			l_zlib: ZLIB
			l_stream: ZLIB_STREAM
				-- structured used to pass information to zlib routines
			l_in: ARRAY [CHARACTER]
				-- Input buffer
			l_out: ARRAY [CHARACTER]
				-- output buffer
			l_break: BOOLEAN
		do
				-- Initialize zlib for decompression
				-- Initialize zstream structure, inflate state
			create l_stream.make
			l_stream.set_available_input (0)
			create l_zlib
			l_zlib.inflate_init (l_stream)

			if l_zlib.last_operation /= z_ok then
				Result := l_zlib.last_operation
			else
					-- decompress until deflate stream ends or end of file
				from
					create l_in.make_filled (create {CHARACTER}, 1, chunk)
					create l_out.make_filled (create {CHARACTER}, 1, chunk)
				until
					a_source.end_of_file or l_break or Result = z_errno or Result = z_mem_error
				loop
						-- run inflate on input until output buffer not full
					from
						l_stream.set_available_input (file_read (l_in, a_source))
						if l_stream.available_input = 0 then
							l_break := True
						end
						l_stream.set_next_input (character_array_to_external (l_in))
						l_stream.set_available_output (Chunk)
						l_stream.set_next_output (character_array_to_external (l_out))
						l_zlib.inflate (l_stream, False)
						inspect l_zlib.last_operation
						when z_need_dict, z_data_error then
							Result := z_data_error
						when z_mem_error then
							l_zlib.inflate_end (l_stream)
							Result := l_zlib.last_operation
						else
							-- Ok
						end
						l_have := Chunk - l_stream.available_output
						if file_write (l_out, l_have, a_dest) /= l_have then
							l_zlib.inflate_end (l_stream)
							Result := z_errno
						end
					until
						l_stream.available_output /= 0 or Result = z_errno or Result = z_mem_error
					loop
						l_stream.set_available_output (Chunk)
						l_stream.set_next_output (character_array_to_external (l_out))
						l_zlib.inflate (l_stream, False)
						inspect l_zlib.last_operation
						when z_need_dict, z_data_error then
							Result := z_data_error
						when z_mem_error then
							l_zlib.inflate_end (l_stream)
							Result := l_zlib.last_operation
						else
							-- Ok
						end
						l_have := Chunk - l_stream.available_output
						if file_write (l_out, l_have, a_dest) /= l_have then
							l_zlib.inflate_end (l_stream)
							Result := z_errno
						end
					end
				end
					-- Clean up and return
				l_zlib.inflate_end (l_stream)
				Result := l_zlib.last_operation
			end
		end

feature -- Implementation

	file_read (a_buffer: ARRAY [CHARACTER]; a_file: RAW_FILE): INTEGER
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
				a_buffer.put (a_file.last_character, l_index)
				l_index := l_index + 1
				if l_index <= chunk then
					a_file.read_character
				end
			end
			Result := l_index - 1
		end

	file_write (a_buffer: ARRAY [CHARACTER]; a_amount: INTEGER; a_file: RAW_FILE): INTEGER
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

	source_file: STRING = "ssleay.txt"

	dest_file: STRING = "output.txt"

	new_source: STRING = "new_ssleay.txt"

	chunk: INTEGER = 128

end
