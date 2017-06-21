note
	description: "Summary description for {HTTP_CLIENT_REQUEST_FILE_PARAMETER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_REQUEST_FILE_PARAMETER

inherit
	HTTP_CLIENT_REQUEST_PARAMETER

create
	make_with_path

feature {NONE} -- Initialization

	make_with_path (a_name: READABLE_STRING_GENERAL; a_path: PATH)
		do
			set_name (a_name)
			location := a_path
			if attached a_path.entry as e then
				file_name := e.name
			end
			set_content_type ("application/octet-stream") -- Default
		end

feature -- Access

	count: INTEGER
		local
			f: RAW_FILE
		do
			create f.make_with_path (location)
			if f.exists and then f.is_access_readable then
				Result := f.count
			end
		end

	location: PATH

	file_name: detachable READABLE_STRING_32

feature -- Element change

	set_file_name (fn: detachable READABLE_STRING_GENERAL)
		do
			if fn = Void then
				file_name := Void
			else
				file_name := fn.to_string_32
			end
		end

feature -- Status report	

	exists: BOOLEAN
		local
			fut: FILE_UTILITIES
		do
			Result := fut.file_path_exists (location)
		end

feature {NONE} -- Data

	file_content: detachable STRING_8
		require
			exists: exists
		local
			f: RAW_FILE
		do
			create f.make_with_path (location)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (2_048)
					Result.append (f.last_string)
				end
				f.close
			end
		end

feature -- Data

	append_file_content_to (a_output: STRING)
			-- Append content of file located at `location`to `a_output'.
		require
			exists: exists
		local
			f: RAW_FILE
			l_buffer_size: INTEGER
		do
			create f.make_with_path (location)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
					l_buffer_size := 2_048
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (l_buffer_size)
					a_output.append (f.last_string)
				end
				f.close
			end
		end

feature -- Conversion

	append_form_url_encoded_to (a_output: STRING_8)
			-- Append as form url encoded string to `a_output`.
		do
			if exists and then attached file_content as s then
				x_www_form_url_encoder.append_percent_encoded_string_to (s, a_output)
			else
				check exists: False end
			end
		end

	append_query_value_encoded_to (a_output: STRING_8)
		do
			if exists and then attached file_content as s then
				uri_percent_encoder.append_query_value_encoded_string_to (s, a_output)
			else
				check exists: False end
			end
		end

	append_as_mime_encoded_to (a_output: STRING_8)
			-- Encoded unicode string for mime value.
			-- For instance uploaded filename, or form data key or values.
		do
				-- FIXME: find the proper encoding!
			if exists then
				append_file_content_to (a_output)
			else
				check exists: False end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
