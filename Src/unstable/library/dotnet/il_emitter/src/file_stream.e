note
	description: "Wrapper around FILE interface to enable in memory streamd for debugging"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_STREAM

create
	make,
	make_binary,
	make_temp,
	make_stream

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

	make_stream (a_pe_writer: PE_WRITER; a_pe_lib: PE_LIB)
		do
			create debug_output.make_empty
			pe_writer := a_pe_writer
			pe_lib := a_pe_lib
		end

	output_stream: detachable FILE
			-- Stream to write the content.

feature -- Access

	pe_writer: detachable PE_WRITER

	pe_lib: detachable PE_LIB

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


feature -- PE_LIB	

	find (a_name: STRING_32): detachable ANY
		local
			l_res: TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
		do
			if attached pe_lib as l_pe_lib then
				l_res := l_pe_lib.find (a_name, Void, l_pe_lib.mscorlib_assembly)
				Result := l_res.resource
			end
		end


	add_method (a_method: CIL_METHOD)
		do
			if attached pe_lib as l_pe_lib then
				l_pe_lib.all_method.force (a_method)
			end
		end

end
