note
	description: "[
		Implements basic OUTPUT_STREAM as a stream filtered by the zlib compression
		algorithms. Target can be a file or an array of character
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_OUTPUT_STREAM

inherit

	UTIL_EXTERNALS

create
	make, make_default, connect_to_buffer, connect_to_file

feature {NONE} -- Initialization

	make (a_buffer_size: INTEGER; a_level: INTEGER)
		require
			meaningful_buffer_size: a_buffer_size > 0
			known_level: a_level >= -1 and then a_level <= 9
		do
			create name.make (0)
			buffer_size := a_buffer_size
			compress_level := a_level
			create zlib
			create zstream.make
			create tmp.make_empty
			create area.make_empty
		end

	make_default
		do
			create name.make (0)
			make (2048, {ZLIB_CONSTANTS}.z_default_compression)
		end

	initialize
		do
			create tmp.make (1, buffer_size)
			create area.make (1, buffer_size)
			create zlib
			create zstream.make
			zlib.deflate_init (zstream, compress_level)
			zstream.set_next_output (character_array_to_external (tmp))
			zstream.set_available_output (tmp.count)
		end

feature -- Deflate

	connect_to_buffer (a_buffer: ARRAY [CHARACTER])
		require
			not_connected: not is_connected
			non_void_buffer: a_buffer /= Void
			non_empty_buffer: a_buffer.count > 0
		do
			make_default
			buffer := a_buffer
			if buffer_size = 0 then
				buffer_size := 2048
				compress_level := {ZLIB_CONSTANTS}.z_default_compression
			end -- if

			initialize
			name.copy ("##BUFFER_ONLY##")
		ensure
			connected: is_connected
		end

	connect_to_file (a_file: STRING)
		require
			not_connected: not is_connected
			non_void_file: a_file /= Void
		do
			make_default
			create file.make_create_read_write (a_file)
			if attached file as l_file and then l_file.is_open_read then
				if buffer_size = 0 then
					buffer_size := 2048
					compress_level := -1
				end -- id

				initialize
				name.copy (a_file)
			end
		end

	close
		do
			flush
			buffer := Void
			if attached file as l_file then
				l_file.close
				file := Void
				name.copy ("")
			end
		end

feature -- Access

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
			Result := buffer /= Void or else file /= Void
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
		do
			if zstream /= Void then
				Result := zstream.total_input
			end -- if
		end -- total_bytes_compressed

feature {NONE} -- Implementation

	flush_temp_to_buffer
		local
			idx: INTEGER
		do
			from
				idx := tmp.lower
			until
				idx > tmp.upper
			loop
				if attached buffer as l_buffer then
					l_buffer.force (tmp.item (idx), l_buffer.upper + 1)
				end
				idx := idx + 1
			end -- loop
		end

	flush_temp_to_file
		local
			idx: INTEGER
		do
			from
				idx := tmp.lower
			until
				idx > tmp.upper
			loop
				if attached file as l_file then
					l_file.put (tmp.item (idx))
				end
				idx := idx + 1
			end -- loop
		end

feature -- Zlib Operations

	flush
		do
			if zlib.last_operation = zlib.Z_ok then
				from
					zstream.set_next_input (character_array_to_external (area))
					zstream.set_available_input (in_position)
					if zstream.available_output = 0 then
						if file /= Void then
							flush_temp_to_file
						else
							flush_temp_to_buffer
						end -- if

						zstream.set_next_output (character_array_to_external (tmp))
						zstream.set_available_output (tmp.count)
					end -- if

					zlib.deflate (zstream, zlib.Z_finish)
				until
					zlib.last_operation /= zlib.Z_ok
				loop
					if zstream.available_output = 0 then
						if file /= Void then
							flush_temp_to_file
						else
							flush_temp_to_buffer
						end -- if

						zstream.set_next_output (character_array_to_external (tmp))
						zstream.set_available_output (tmp.count)
					end -- if

					zlib.deflate (zstream, zlib.Z_finish)
				end -- loop

				if zlib.last_operation = zlib.Z_stream_end then
					resize_array (tmp, 1, tmp.upper - zstream.available_output)
					if file /= Void then
						flush_temp_to_file
					else
						flush_temp_to_buffer
					end -- if
				end -- if
			end -- if
		end -- flush

	put (a_char: CHARACTER)
		do
			in_position := in_position + 1
			if in_position <= area.upper then
				area.put (a_char, in_position)
			else
				from
					zstream.set_next_input (character_array_to_external (area))
					zstream.set_available_input (area.count)
				until
					zstream.available_input = 0
				loop
					if zstream.available_output = 0 then
						if file /= Void then
							flush_temp_to_file
						else
							flush_temp_to_buffer
						end -- if

						zstream.set_next_output (character_array_to_external (tmp))
						zstream.set_available_output (tmp.count)
					end -- if

					zlib.deflate (zstream, zlib.Z_no_flush)
				end -- loop

				in_position := 1
				area.put (a_char, in_position)
			end -- if
		end

feature {NONE}

	area: ARRAY [CHARACTER]

	buffer: detachable ARRAY [CHARACTER]

	buffer_size: INTEGER

	compress_level: INTEGER

	file: detachable RAW_FILE

	in_position: INTEGER

	name: STRING

	tmp: ARRAY [CHARACTER]

	zlib: ZLIB

	zstream: ZLIB_STREAM

feature {NONE}

	resize_array (array_: ARRAY [CHARACTER]; lower_, upper_: INTEGER)
		local
			buf: ARRAY [CHARACTER]
		do
			if lower_ > array_.lower or else upper_ < array_.upper then
				buf := array_.subarray (lower_, upper_)
				array_.make (lower_, upper_)
				array_.copy (buf)
			end -- if
		end -- resize_array

end
