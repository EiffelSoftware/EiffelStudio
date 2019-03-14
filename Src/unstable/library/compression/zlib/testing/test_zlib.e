note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ZLIB

inherit
	EQA_TEST_SET
		select
			default_create
		end

	UTIL_EXTERNALS
		rename
			default_create as default_create_ut
		end

feature -- Test compress and uncompress

	test_compress_uncompress
		local
			l_zlib: ZLIB
			l_target: C_STRING
			l_length: C_STRING
			l_source: C_STRING
			l_buff_size: INTEGER
			l_string: STRING
		do
			l_string := "hello"
			create l_zlib
			create l_source.make (l_string)

			l_buff_size := l_zlib.compress_bound (l_source.capacity)

			create l_target.make_empty (l_buff_size)
			create l_length.make (l_buff_size.out)

			l_zlib.compress (l_target.item, l_length.item, l_source.item, l_source.capacity)

			if l_zlib.last_operation /= l_zlib.z_ok then
				assert ("Test failed",False)
			end

			if l_target.string.same_string ("hello") then
				assert ("Bad compress", False)
			else
				create l_source.make_empty (l_string.count)
				create l_length.make (l_string.count.out)
				l_zlib.uncompress (l_source.item, l_length.item, l_target.item, l_target.capacity)

				if l_zlib.last_operation /= l_zlib.z_ok then
					assert ("Test failed",False)
				end

				if l_source.string.same_string ("hello") then
					assert ("Good uncompress", True)
				end

			end

		end

feature -- Test deflate

	test_deflate_inflate
		local
			l_zlib: ZLIB
			l_def_zstream: ZLIB_STREAM
			l_inf_zstream: ZLIB_STREAM
			l_string : STRING
			l_buff_in: ARRAY[CHARACTER]
			l_buff_out: ARRAY[CHARACTER]
			l_buff_inf: ARRAY[CHARACTER]
			l_pointer_bo: POINTER
			l_inflated: STRING

		do
				-- Deflate
			l_string := "[
			class
   				 HELLO_WORLD
			create
    			make
			feature
    			make
       				 do
            			print ("Hello, world!%N")
        			 end
			end
			]"

				-- Initialize zlib
			create l_zlib
			create l_def_zstream.make -- Initialize z_stream


				-- create buffers
			create l_buff_in.make_filled (create {CHARACTER},1, 2048)
			create l_buff_out.make_filled (create {CHARACTER},1, 2048)

			fill_buffer (l_buff_in, l_string)

			l_def_zstream.set_available_input (l_string.capacity)
			l_def_zstream.set_available_output (l_buff_out.capacity)

			l_pointer_bo := character_array_to_external (l_buff_out)

			l_def_zstream.set_next_input (character_array_to_external (l_buff_in))
			l_def_zstream.set_next_output (l_pointer_bo)


			l_zlib.deflate_init (l_def_zstream, l_zlib.z_default_compression)
			if l_zlib.last_operation /= l_zlib.z_ok then
				assert ("Error deflate_init", False)
			end

			l_zlib.deflate (l_def_zstream, l_zlib.z_finish)
			if l_zlib.last_operation /= l_zlib.z_stream_end then
				assert ("Error deflate", False)
			end

			l_zlib.deflate_end (l_def_zstream)
			if l_zlib.last_operation /= l_zlib.z_ok then
				assert ("Error deflate_end", False)
			end


				-- Inflate
			create l_inf_zstream.make
			create l_buff_inf.make_filled (create {CHARACTER}, 1, 2048)


			l_inf_zstream.set_available_input (l_def_zstream.total_output)
			l_inf_zstream.set_available_output (l_buff_inf.capacity)

			l_inf_zstream.set_next_input (l_pointer_bo)
			l_inf_zstream.set_next_output (character_array_to_external (l_buff_inf))

			l_zlib.inflate_init (l_inf_zstream)
			l_zlib.inflate (l_inf_zstream, {ZLIB_CONSTANTS}.z_no_flush) -- False
			l_zlib.inflate_end (l_inf_zstream)

			l_inflated := buffer_to_string (l_buff_inf, l_inf_zstream.total_output)

			assert ("Expected same string:", l_string.same_string (l_inflated))
		end


feature {NONE} -- Implementation

	fill_buffer (a_buffer: ARRAY[CHARACTER]; a_string: STRING)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_string.count
			loop
				a_buffer.force (a_string.at (i), i)
				i := i + 1
			end
		end

	buffer_to_string (a_buffer: ARRAY[CHARACTER]; a_total: INTEGER_64) : STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			from
				i := 1
			until
				i > a_total
			loop
				Result.append_character (a_buffer[i])
				i := i + 1
			end
		end
end


