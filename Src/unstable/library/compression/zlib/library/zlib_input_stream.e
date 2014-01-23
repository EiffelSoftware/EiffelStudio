note
	description: "[
		Implements basic INPUT_STREAM as a stream filtered by the zlib compression
		algorithms. Source can be a file or an array of character, the buffer or
		file must be the results of a previous zlib compression.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_INPUT_STREAM

inherit

	UTIL_EXTERNALS

create
	make, make_default, connect_to_buffer, connect_to_file

feature {NONE}

	make (a_buffer_size: INTEGER)
		require
			meaningful_buffer_size: a_buffer_size > 0
		do
			create name.make (0)
			buffer_size := a_buffer_size
			create zlib
			create zstream.make
			create area.make_empty
		end -- make

	make_default
		do
			create name.make (0)
			make (2048)
		end -- make_default

	initialize
		do
			out_position := 0
			create area.make( 1, buffer_size)
			create zlib
			create zstream.make
			zstream.set_available_input (0)
			zlib.inflate_init (zstream)
			end_of_input := False
		end

feature

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
			end -- if

			initialize
			name.copy ("##BUFFER_ONLY##")
			zstream.set_next_input (character_array_to_external (a_buffer))
			zstream.set_available_input (a_buffer.count)
		ensure
			connected: is_connected
		end

	connect_to_file (a_file: STRING)
		require
			not_connected: not is_connected
			non_void_file: a_file /= Void
		do
			make_default
			create file.make_open_read (a_file)
			if attached file as l_file and then l_file.is_open_read then
				if buffer_size = 0 then
					buffer_size := 2048
				end -- id

				create buffer.make (1, buffer_size)
				initialize
				name.copy (a_file)
			else
				file := Void
			end -- if
		end

	close
		do
			buffer := Void
			if attached file as l_file then
				l_file.close
				file := Void
				name.copy ("")
			end -- if
		end -- close

feature

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
			Result := buffer /= Void
		end -- is_connected

	last_item: CHARACTER

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

	name: STRING

	total_bytes_uncompressed: INTEGER
		do
			if zstream /= Void then
				Result := zstream.total_output
			end -- if
		end

	valid_unread_item (item_: CHARACTER): BOOLEAN
		do
			Result := not push_back_flag
		end

feature {NONE}

	read_character_from_buffer
		do
			if not area.valid_index (out_position) then
				if zlib.last_operation = zlib.gz_header_end then
					end_of_input := True
					zlib.inflate_end (zstream)
				else
					resize_array (area, 1, buffer_size)
					zstream.set_next_output (character_array_to_external (area))
					zstream.set_available_output (area.count)
					zlib.inflate (zstream, False)
					resize_array (area, 1, buffer_size - zstream.available_output)
					out_position := area.lower
				end -- if
			end -- if

			if area.valid_index (out_position) then
				last_item := area.item (out_position)
				out_position := out_position + 1
			end -- if
		end -- read_character_from_buffer

	read_character_from_file
		local
			idx: INTEGER
		do
			if not area.valid_index (out_position) and then attached buffer as l_buffer then
				if zlib.last_operation = zlib.gz_header_end then
					zlib.inflate_end (zstream)
					end_of_input := True
				else
					resize_array (area, 1, buffer_size)
					zstream.set_next_output (character_array_to_external (area))
					zstream.set_available_output (area.count)
					if zstream.available_input = 0 and then attached file as l_file and then not l_file.end_of_file then
						from
							resize_array (l_buffer, 1, buffer_size)
							idx := 1
						until
							l_file.end_of_file or else idx > buffer_size
						loop
							l_file.read_character
							if not l_file.end_of_file then
								l_buffer.put (l_file.last_character, idx)
								idx := idx + 1
							end -- if
						end -- loop

						zstream.set_next_input (character_array_to_external (l_buffer))
						zstream.set_available_input (idx - 1)
					end -- if

					zlib.inflate (zstream, False)
					resize_array (area, 1, buffer_size - zstream.available_output)
					out_position := area.lower
				end -- if
			end -- if

			if area.valid_index (out_position) then
				last_item := area.item (out_position)
				out_position := out_position + 1
			end -- if
		end -- read_character_from_file

feature

	read
		do
			if push_back_flag then
				push_back_flag := False
			else
				if file = Void then
					read_character_from_buffer
				else
					read_character_from_file
				end
			end
		end -- read

	read_line_in (a_buffer: STRING)
		do
			a_buffer.wipe_out
			from
				read
			until
				end_of_input or else last_item = '%N'
			loop
				a_buffer.extend (last_item)
				read
			end -- loop
		end -- read_line_in

	unread (item_: CHARACTER)
		do
			push_back_flag := True
		end

feature {NONE}

	area: ARRAY [CHARACTER]

	buffer: detachable ARRAY [CHARACTER]

	buffer_size: INTEGER

	file: detachable RAW_FILE

	out_position: INTEGER

	push_back_flag: BOOLEAN

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

end -- class Z_INPUT_STREAM
