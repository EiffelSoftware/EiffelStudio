note
	description: "Wrapper around FILE interface to enable in memory streamd for debugging"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_STREAM

create
	make,
	make_binary,
	make_temp

feature {NONE} -- Initialiation


	make (a_file_name: STRING_32)
		do
			create {PLAIN_TEXT_FILE} output_stream.make_create_read_write (a_file_name)
			create debug_output.make_empty
			on_debug := False
		end


	make_binary (a_file_name: STRING_32)
		do
			create {RAW_FILE} output_stream.make_create_read_write (a_file_name)
			create debug_output.make_empty
			on_debug := False
		end

	make_temp
		do
			create debug_output.make_empty
			on_debug := True
		end

	output_stream: detachable FILE
			-- Stream to write the content.

feature -- Access

	on_debug: BOOLEAN
			-- Genereate in memory stream.
			-- by default false.
			-- call enable_debug

	debug_output: STRING_32
			-- In memory string
			-- iff debug is enabled.

feature -- Element change

	enable_debug
		do
			on_debug := True
		ensure
			on_debug_enabled:  on_debug = True
		end

	disable_debug
		do
			on_debug := False
		ensure
			on_debug_disabled: on_debug = False
		end

	put_integer (i: INTEGER)
		do
			if attached output_stream as l_stream then
				l_stream.put_integer (i)
			end
			if on_debug then
				debug_output.append_integer (i)
			end
		end

	put_integer_64 (i: INTEGER_64)
		do
			if attached output_stream as l_stream then
				l_stream.put_integer_64 (i)
			end
			if on_debug then
				debug_output.append_integer_64 (i)
			end
		end

	put_string (s: READABLE_STRING_8)
		do
			if attached output_stream as l_stream then
				l_stream.put_string (s)
			end
			if on_debug then
				debug_output.append_string (s)
			end
		end

	put_new_line
		do
			if attached output_stream as l_stream then
				l_stream.put_new_line
			end
			if on_debug then
				debug_output.append ("%N")
			end
		end

	flush
		do
			if attached output_stream as l_stream then
				l_stream.flush
			end
		end

	close
		do
			if attached output_stream as l_stream then
				l_stream.close
			end
		end

	text: STRING
		do
			Result := debug_output
		end

end
