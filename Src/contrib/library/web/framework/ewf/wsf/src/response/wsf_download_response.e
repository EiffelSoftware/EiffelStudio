note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_DOWNLOAD_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

	SHARED_UTF8_URL_ENCODER

create
	make,
	make_with_content_type,
	make_html

feature {NONE} -- Initialization

	make (a_file_name: READABLE_STRING_GENERAL)
		do
			set_status_code ({HTTP_STATUS_CODE}.ok)
			create file_path.make_from_string (a_file_name)
			base_name := basename (file_path)
			get_content_type
			initialize
		end

	make_with_content_type (a_content_type: READABLE_STRING_8; a_filename: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			set_status_code ({HTTP_STATUS_CODE}.ok)
			create file_path.make_from_string (a_filename)
			base_name := basename (file_path)
			content_type := a_content_type
			initialize
		end

	make_html (a_filename: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			make_with_content_type ({HTTP_MIME_TYPES}.text_html, a_filename)
		end

	initialize
		local
			h: like header
		do
			create h.make
			header := h
			h.put_content_type (content_type)
			h.put_content_length (filesize (file_path))
			h.put_content_disposition ("attachment", "filename=%""+ base_name +"%"")
			if attached filedate (file_path) as dt then
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

	file_path: PATH

	file_name: READABLE_STRING_8
		obsolete
			"Use `file_path.name' for unicode support [2017-05-31]"
		do
			Result := file_path.utf_8_name
		end

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
				send_file_content_to (file_path, res)
			end
		end

feature {NONE} -- Implementation: file system helper

	filesize (fn: PATH): INTEGER
			-- Size of the file `fn'.
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			if f.exists then
				Result := f.count
			end
		end

	filedate (fn: PATH): detachable DATE_TIME
			-- Size of the file `fn'.
		local
			f: RAW_FILE
			d: HTTP_DATE
		do
			create f.make_with_path (fn)
			if f.exists then
				create d.make_from_timestamp (f.date)
				Result := d.date_time
			end
		end

	file_extension (fn: PATH): STRING_32
			-- Extension of file `fn'.
		do
			if attached fn.extension as ext then
				Result := ext
			else
				create Result.make_empty
			end
		end

	basename (fn: PATH): STRING
			-- Basename of `fn'.
		local
			s: READABLE_STRING_32
		do
			if attached fn.entry as p then
				s := p.name
			else
				s := fn.name
			end
			Result := url_encoder.encoded_string (s)
		end

feature -- Content-type related

	get_content_type
			-- Content type associated with `file_name'
		local
			m_map: HTTP_FILE_EXTENSION_MIME_MAPPING
			m: detachable READABLE_STRING_8
		do
			create m_map.make_default
			m := m_map.mime_type (file_extension (file_path).as_lower)
			if m = Void then
				m := {HTTP_MIME_TYPES}.application_force_download
			end
			content_type := m
		end

feature -- Implementation: output

	send_file_content_to (fn: PATH; res: WSF_RESPONSE)
			-- Send the content of file `fn'
		require
			string_not_empty: not fn.is_empty
			is_readable: (create {RAW_FILE}.make_with_path (fn)).is_readable
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			check f.exists and then f.is_readable end

			res.put_file_content (f, 0, f.count)
		end

invariant
	status_code_set: status_code /= 0

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
