note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_DOWNLOAD_RESPONSE

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
			base_name := basename (a_file_name)
			get_content_type
			initialize
		end

	make_with_content_type (a_content_type: READABLE_STRING_8; a_filename: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			set_status_code ({HTTP_STATUS_CODE}.ok)
			file_name := a_filename
			base_name := basename (a_filename)
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
			d: HTTP_DATE
		do
			create h.make
			header := h
			h.put_content_type (content_type)
			h.put_transfer_encoding_binary
			h.put_content_length (filesize (file_name))
			h.put_content_disposition ("attachment", "filename=%""+ base_name +"%"")
			if attached filedate (file_name) as dt then
				h.put_last_modified (dt)
			end
		end

feature -- Element change

	set_base_name (n: like base_name)
		do
			base_name := n
			header.put_content_disposition ("attachment", "filename=%""+ n +"%"")
		ensure
			base_name_set: n.same_string (base_name)
		end

	set_expires (t: INTEGER)
		do
			header.put_expires (t)
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

	header: HTTP_HEADER

	status_code: INTEGER assign set_status_code

	file_name: READABLE_STRING_8

	base_name: READABLE_STRING_8

	content_type: READABLE_STRING_8

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

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		do
			res.set_status_code (status_code)
			res.put_header_text (header.string)
			if not answer_head_request_method then
				send_file_content_to (file_name, res)
			end
		end

feature {NONE} -- Implementation: file system helper

	filesize (fn: STRING): INTEGER
			-- Size of the file `fn'.
		local
			f: RAW_FILE
		do
			create f.make (fn)
			if f.exists then
				Result := f.count
			end
		end

	filedate (fn: STRING): detachable DATE_TIME
			-- Size of the file `fn'.
		local
			f: RAW_FILE
			d: HTTP_DATE
		do
			create f.make (fn)
			if f.exists then
				create d.make_from_timestamp (f.date)
				Result := d.date_time
			end
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

	basename (fn: STRING): STRING
			-- Basename of `fn'.
		local
			p: INTEGER
		do
			p := fn.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, fn.count)
			if p > 0 then
				Result := fn.substring (p + 1, fn.count)
			else
				Result := fn
			end
		end

	dirname (fn: STRING): STRING
			-- Dirname of `fn'.	
		local
			p: INTEGER
		do
			p := fn.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, fn.count)
			if p > 0 then
				Result := fn.substring (1, p - 1)
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

feature -- Implementation: output

	send_file_content_to (fn: READABLE_STRING_8; res: WSF_RESPONSE)
			-- Send the content of file `fn'
		require
			string_not_empty: not fn.is_empty
			is_readable: (create {RAW_FILE}.make (fn)).is_readable
		local
			f: RAW_FILE
		do
			create f.make (fn)
			check f.exists and then f.is_readable end

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

invariant
	status_code_set: status_code /= 0

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
