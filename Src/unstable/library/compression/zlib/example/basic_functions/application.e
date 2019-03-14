note
	description: "basic_functions application: show proper use of zlib's inflate() and deflate()"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name:zpipe", "src=http://www.zlib.net/zpipe.c", "protocol=uri"
	EIS: "name:Zlib how-to", "src=http://www.zlib.net/zlib_how.html", "protocol=uri"

class
	APPLICATION

inherit

	ARGUMENTS
	ZLIB_CONSTANTS
	UTIL_EXTERNALS
	PAYLOAD_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
--		local
--			l_start_time, l_finish_time: TIME
		do
--			basic_example_without_streams
--			stream_example_memory
--			create l_start_time.make_now
--			stream_example_file_to_file2
--			create l_finish_time.make_now
--			print ("%NNew version using MANAGED_POINTERS: ")
--			print ((l_finish_time - l_start_time).duration.out)
--			stream_example_string_2
--			stream_example_string_ws
--			perfomance_8192
--			io.read_line
--			perfomance_16384
			stream_example_string_ws2
			io.read_line
		end

feature -- Basic Example Using the ZLIB API

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
			print (if l_ret = z_ok then "%NCompress OK" else "%NError:" + l_ret.out end)
			l_ret := inflate (l_new_read, l_new_source)
			print (if l_ret = z_ok then "%NDempress OK" else "%NError:" + l_ret.out end)
		end

feature -- Basic Examples using ZLIB STREAMS 		

	stream_example_file_to_file2
		local
			zi: ZLIB_IO_MEDIUM_UNCOMPRESS
			zo: ZLIB_IO_MEDIUM_COMPRESS
			l_file: FILE
			l_src_file: FILE
			l_new_file: FILE
		do
			create {RAW_FILE}l_file.make_create_read_write ("new_test2.txt")
			create {RAW_FILE}l_src_file.make_open_read (source_file)
			create {RAW_FILE}l_new_file.make_create_read_write ("new_file2.txt")
			create zo.io_medium_stream (l_file)
			zo.put_io_medium (l_src_file)
			create {RAW_FILE}l_file.make_open_read ("new_test2.txt")
			create zi.io_medium_stream (l_file)
			zi.to_medium (l_new_file)

			print ("%NBytes compresses:" + zo.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + zi.total_bytes_uncompressed.out)
		end

	stream_example_memory
		local
			zi: ZLIB_MEMORY_UNCOMPRESS
			zo: ZLIB_MEMORY_COMPRESS
			input_buffer: ARRAY[NATURAL_8]
			output_buffer: MANAGED_POINTER
			new_buffer: ARRAY[NATURAL_8]
			output: MANAGED_POINTER
		do
			input_buffer := {ARRAY [NATURAL_8]} <<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90,
				1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,49,90
			>>
			create output_buffer.make (128)
			create zo.memory_stream (output_buffer)
			zo.put_memory (create {MANAGED_POINTER}.make_from_array (input_buffer))
			create zi.memory_stream (output_buffer)
			output := zi.to_memory
			new_buffer := output.read_array (0, output.count)
			new_buffer.compare_objects
			input_buffer.compare_objects
			check
				same_content: new_buffer.is_equal (input_buffer)
			end
			print ("%NBytes compresses:" + zo.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + zi.total_bytes_uncompressed.out)
		end


	stream_example_string_2
		local
			di: ZLIB_STRING_UNCOMPRESS
			dc: ZLIB_STRING_COMPRESS
			input_string: STRING
			output_string: STRING
		do
			input_string:= "[
				zlib is designed to be a free, general-purpose, legally unencumbered -- that is, not covered by any patents -- lossless data-compression library for use on virtually any computer hardware and operating system. The zlib data format is itself portable across platforms. Unlike the LZW compression method used in Unix compress(1) and in the GIF image format, the compression method currently used in zlib essentially never expands the data. (LZW can double or triple the file size in extreme cases.) zlib's memory footprint is also independent of the input data and can be reduced, if necessary, at some cost in compression. A more precise, technical discussion of both points is available on another page.
				zlib was written by Jean-loup Gailly (compression) and Mark Adler (decompression). Jean-loup is also the primary author/maintainer of gzip(1), the author of the comp.compression FAQ list and the former maintainer of Info-ZIP's Zip; Mark is also the author of gzip's and UnZip's main decompression routines and was the original author of Zip. Not surprisingly, the compression algorithm used in zlib is essentially the same as that in gzip and Zip, namely, the `deflate' method that originated in PKWARE's PKZIP 2.x.
				Mark and Jean-loup can be reached by e-mail at zlib email address. Please read the FAQ and the manual before asking us for help. We are getting too many questions which already have an answer in the zlib documentation.
				Greg, Mark and/or Jean-loup will add some more stuff here when they think of something to add. For now this page is mainly a pointer to zlib itself and to related links. Note that the deflate and zlib specifications both achieved official Internet RFC status in May 1996, and zlib itself was adopted in version 1.1 of the Java Development Kit (JDK), both as a raw class and as a component of the JAR archive format.
				The lovely zlib-vise image above was provided courtesy of Bruce Gardner, art director of Dr. Dobb's Journal. It appears in Mark Nelson's article in the January 1997 issue (see below).
			]"
			create output_string.make_empty
			create dc.string_stream (output_string)
			dc.put_string (input_string)

			create di.string_stream (output_string)
			check
				same_string: input_string.same_string (di.to_string)
			end
			print ("%NBytes compresses:" + dc.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + di.total_bytes_uncompressed.out)
		end

	stream_example_string_ws
			-- Using PPP defate.
		local
			di: ZLIB_STRING_UNCOMPRESS
			dc: ZLIB_STRING_COMPRESS
			input_string: STRING
			output_string: STRING
		do
			input_string:= "Hello"
			create output_string.make_empty
			create dc.string_stream (output_string)
			dc.mark_full_flush
			dc.put_string (input_string)
			create di.string_stream (output_string)
			check
				same_string: input_string.same_string (di.to_string)
			end
			print ("%NBytes compresses:" + dc.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + di.total_bytes_uncompressed.out)
		end

		stream_example_string_ws2
				-- Using PPP defate.
			local
				di: ZLIB_STRING_UNCOMPRESS
				dc: ZLIB_STRING_COMPRESS
				input_string: STRING
				output_string: STRING
			do
				input_string:= payload_size_131072
				create output_string.make_empty
				create dc.string_stream (output_string)
				dc.mark_full_flush
				dc.put_string (input_string)
				create di.string_stream (output_string)
				check
					same_string: input_string.same_string (di.to_string)
				end
				print ("%NBytes compresses: " + dc.total_bytes_compressed.out)
				print ("%NBytes uncompresses: " + di.total_bytes_uncompressed.out)
				print ("%NCompressed size: " + output_string.count.out)
			end

feature -- Performance

		perfomance_16384
			local
				di: ZLIB_STRING_UNCOMPRESS
				dc: ZLIB_STRING_COMPRESS
				input_string: STRING
				output_string: STRING
				sw: DT_STOPWATCH
				i: INTEGER
			do
				create sw.make
				sw.start
				from
					i := 1
				until
					i > 1000
				loop
					input_string:= payload_size_16384
					create output_string.make_empty
					create dc.string_stream (output_string)
					dc.mark_full_flush
					dc.put_string (input_string)
					create di.string_stream (output_string)
					check
						same_string: input_string.same_string (di.to_string)
					end
					print ("%NBytes compresses:" + dc.total_bytes_compressed.out)
					print ("%NBytes uncompresses:" + di.total_bytes_uncompressed.out)
					i := i + 1
				end
				sw.stop
				print ("Elapsed time:" + sw.elapsed_time.precise_time_out)
			end

		perfomance_8192
			local
				di: ZLIB_STRING_UNCOMPRESS
				dc: ZLIB_STRING_COMPRESS
				input_string: STRING
				output_string: STRING
				sw: DT_STOPWATCH
				i: INTEGER
			do
				create sw.make
				sw.start
				from
					i := 1
				until
					i > 1000
				loop
					create input_string.make_from_string (payload_size_8192)
					create output_string.make_empty
					create dc.string_stream (output_string)
					dc.mark_full_flush
					dc.put_string (input_string)
					create di.string_stream (output_string)
					check
						same_string: input_string.same_string (di.to_string)
					end
					print ("%NBytes compresses:" + dc.total_bytes_compressed.out)
					print ("%NBytes uncompresses:" + di.total_bytes_uncompressed.out)
					i := i + 1
				end
				sw.stop
				print ("Elapsed time:" + sw.elapsed_time.precise_time_out)
			end

feature -- Custom Deflate Implementation

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
				-- Output buffer
		do
				-- Initialize zlib for compression.
				-- Initialize zstream structure, default state.
			create l_stream.make
			create l_zlib
			l_zlib.deflate_init (l_stream, a_level)

			if l_zlib.last_operation /= z_ok then
				Result := l_zlib.last_operation
			else
					-- Compress until the end of file.
				create l_in.make_filled (create {CHARACTER}, 1, chunk)
				create l_out.make_filled (create {CHARACTER}, 1, chunk)

					-- Compress until the end of the file.
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
						-- Run deflate on input until output buffer not full, finish compression if all of source has been read in.
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
					-- Clean up and return.
				l_zlib.deflate_end (l_stream)
				Result := l_zlib.last_operation
			end
		end

feature -- Custom Inflate Implementation

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
						l_zlib.inflate (l_stream, {ZLIB_CONSTANTS}.z_no_flush) -- False
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
						l_zlib.inflate (l_stream, {ZLIB_CONSTANTS}.z_no_flush) -- False
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

	source_file: STRING = "file_to_compress.txt"

	dest_file: STRING = "output.txt"

	new_source: STRING = "new_compress_file.txt"

	chunk: INTEGER = 128

end
