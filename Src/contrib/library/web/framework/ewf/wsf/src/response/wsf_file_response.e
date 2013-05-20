note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_FILE_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make,
	make_with_content_type,
	make_html

feature {NONE} -- Initialization

	make (a_file_name: READABLE_STRING_8)
		do
			set_status_code ({HTTP_STATUS_CODE}.ok)
			file_name := a_file_name
			get_content_type
			initialize
		end

	make_with_content_type (a_content_type: READABLE_STRING_8; a_filename: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			set_status_code ({HTTP_STATUS_CODE}.ok)
			file_name := a_filename
			content_type := a_content_type
			initialize
		end

	make_html (a_filename: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			make_with_content_type ({HTTP_MIME_TYPES}.text_html, a_filename)
		end

	initialize
		local
			h: like header
		do
			get_file_exists
			create h.make
			header := h
			h.put_content_type (content_type)

			if file_exists then
				if attached file_last_modified as dt then
					h.put_last_modified (dt)
				end
				get_file_size
				if file_size = 0 then
					set_status_code ({HTTP_STATUS_CODE}.not_found)
				else
					set_status_code ({HTTP_STATUS_CODE}.ok)
				end
			else
				set_status_code ({HTTP_STATUS_CODE}.not_found)
			end
			update_content_length
		end

	update_content_length
		local
			n: INTEGER
		do
			if file_exists then
				n := file_size
				if attached head as h then
					n := n + h.count
				end
				if attached bottom as b then
					n := n + b.count
				end
			else
				n := 0
			end
			content_length := n
			header.put_content_length (n)
		end

feature -- Element change

	set_expires_in_seconds (sec: INTEGER)
		do
			set_expires (sec.out)
		end

	set_expires (s: STRING)
		do
			header.put_expires_string (s)
		end

	set_no_cache
		local
			h: like header
		do
			h := header
			h.put_expires (0)
			h.put_cache_control ("no-cache, must-revalidate")
			h.put_pragma_no_cache
		end

feature -- Access

	status_code: INTEGER assign set_status_code

	header: HTTP_HEADER

	content_length: INTEGER
			-- Content-Length of the response

	content_type: READABLE_STRING_8
			-- Content-Type of the response

	file_name: READABLE_STRING_8

	file_exists: BOOLEAN
			-- File exists?

	file_size: INTEGER
			-- Size of file named `file_name'

	head, bottom: detachable READABLE_STRING_8
			-- Eventual head and bottom part
			-- before and after the file content.

feature -- Settings

	answer_head_request_method: BOOLEAN assign set_answer_head_request_method
			-- For HEAD request method, only http header should be sent

feature -- Element change

	set_status_code (c: like status_code)
			-- Set `status_code' to `c'.
		require
			valid_status_code: c > 0
		do
			status_code := c
		ensure
			status_code_set: status_code = c
		end

	set_answer_head_request_method (b: BOOLEAN)
			-- Set answer_head_request_method' to `b'.
		do
			answer_head_request_method := b
		end

	set_head (s: like head)
			-- Set `head' to `s'
			-- it also change the `content_length' and associated value in `header'
		do
			head := s
			update_content_length
		end

	set_bottom (s: like bottom)
			-- Set `bottom' to `s'	
			-- it also change the `content_length' and associated value in `header'
		do
			bottom := s
			update_content_length
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			s: detachable READABLE_STRING_8
		do
			res.set_status_code (status_code)
			if status_code = {HTTP_STATUS_CODE}.not_found then
			else
				res.put_header_text (header.string)
				s := head
				if s /= Void then
					res.put_string (s)
				end
				if not answer_head_request_method then
					send_file_content_to (file_name, res)
				end
				s := bottom
				if s /= Void then
					res.put_string (s)
				end
			end
		end

feature {NONE} -- Implementation: file system helper

	get_file_exists
			-- Get `file_exists'
		local
			f: RAW_FILE
		do
			create f.make (file_name)
			file_exists := f.exists
		end

	get_file_size
			-- Get `file_size' from file named `file_name'
		require
			file_exists: file_exists
		local
			f: RAW_FILE
		do
			create f.make (file_name)
			file_size := f.count
		end

	file_last_modified: detachable DATE_TIME
			-- Get `file_size' from file named `file_name'
		require
			file_exists: file_exists
		local
			f: RAW_FILE
		do
			create f.make (file_name)
			create Result.make_from_epoch (f.change_date)
		end

	file_extension (fn: STRING): STRING
			-- Extension of file `fn'.
		local
			p: INTEGER
		do
			p := fn.last_index_of ('.', fn.count)
			if p > 0 then
				Result := fn.substring (p + 1, fn.count)
			else
				create Result.make_empty
			end
		end

feature -- Content-type related

	get_content_type
			-- Content type associated with `file_name'
		local
			m_map: HTTP_FILE_EXTENSION_MIME_MAPPING
			m: detachable READABLE_STRING_8
		do
			create m_map.make_default
			m := m_map.mime_type (file_extension (file_name).as_lower)
			if m = Void then
				m := {HTTP_MIME_TYPES}.application_force_download
			end
			content_type := m
		end

feature {NONE} -- Implementation: output

	send_file_content_to (fn: READABLE_STRING_8; res: WSF_RESPONSE)
			-- Send the content of file `fn'
		require
			string_not_empty: not fn.is_empty
			is_readable: (create {RAW_FILE}.make (fn)).is_readable
			file_exists: file_exists
		local
			f: RAW_FILE
		do
			create f.make (fn)
			check f.is_readable end

			f.open_read
			from
			until
				f.exhausted
			loop
				f.read_stream (4_096)
				res.put_string (f.last_string)
			end
			f.close
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
