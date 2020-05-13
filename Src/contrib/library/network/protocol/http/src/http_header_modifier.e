note
	description: "[
			The class provides an easy way to build and modify HTTP header text
			thanks to add_header (..) and put_header (..)
			
			You will also find some helper features to help coding most common usages
			
			Please, have a look at constants classes such as
				HTTP_MIME_TYPES
				HTTP_HEADER_NAMES
				HTTP_STATUS_CODE
				HTTP_REQUEST_METHODS
			(or HTTP_CONSTANTS which groups them for convenience)
			
			Note the return status code is not part of the HTTP header
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_HEADER_MODIFIER

inherit
	ITERABLE [READABLE_STRING_8]

feature -- Access: deferred

	new_cursor: INDEXABLE_ITERATION_CURSOR [READABLE_STRING_8]
			-- Fresh cursor associated with current structure.
		deferred
		end

feature -- Header change: deferred

	add_header (h: READABLE_STRING_8)
			-- Add header `h'
			-- if it already exists, there will be multiple header with same name
			-- which can also be valid
		require
			h_not_empty: h /= Void and then not h.is_empty
		deferred
		end

	put_header (h: READABLE_STRING_8)
			-- Add header `h' or replace existing header of same header name
		require
			h_not_empty: h /= Void and then not h.is_empty
		deferred
		end

feature -- Status report

	has, has_header_named (a_name: READABLE_STRING_8): BOOLEAN
			-- Has header item for `n'?
		local
			ic: like new_cursor
		do
			from
				ic := new_cursor
			until
				ic.after or Result
			loop
				Result := has_same_header_name (ic.item, a_name)
				ic.forth
			end
		end

	has_content_length: BOOLEAN
			-- Has header "Content-Length"
		do
			Result := has_header_named ({HTTP_HEADER_NAMES}.header_content_length)
		end

	has_content_type: BOOLEAN
			-- Has header "Content-Type"
		do
			Result := has_header_named ({HTTP_HEADER_NAMES}.header_content_type)
		end

	has_transfer_encoding_chunked: BOOLEAN
			-- Has "Transfer-Encoding: chunked" header
		do
			if has_header_named ({HTTP_HEADER_NAMES}.header_transfer_encoding) then
				Result := attached item ({HTTP_HEADER_NAMES}.header_transfer_encoding) as v and then v.same_string (str_chunked)
			end
		end

feature -- Access

	item alias "[]" (a_header_name: READABLE_STRING_8): detachable READABLE_STRING_8 assign force
			-- First header item found for `a_name' if any
		local
			res: STRING_8
			n: INTEGER
			l_line: READABLE_STRING_8
			ic: like new_cursor
		do
			n := a_header_name.count

			from
				ic := new_cursor
			until
				ic.after or Result /= Void
			loop
				l_line := ic.item
				if has_same_header_name (l_line, a_header_name) then
					res := l_line.substring (n + 2, l_line.count).to_string_8
					res.left_adjust
					res.right_adjust
					Result := res
				end
				ic.forth
			end
		end

	header_named_value (a_name: READABLE_STRING_8): like item
			-- First header item found for `a_name' if any	
		obsolete
			"Use `item' [2017-05-31]"
		do
			Result := item (a_name)
		end

feature -- Header change: general

	force (a_value: detachable READABLE_STRING_8; a_header_name: READABLE_STRING_8)
			-- Put header `a_header_name:a_value' or replace existing header of name `a_header_name'.
			--| this is used as assigner for `item'
		do
			if a_value = Void then
				put_header_key_value (a_header_name, "")
			else
				put_header_key_value (a_header_name, a_value)
			end
		end

	add_header_key_value (a_header_name, a_value: READABLE_STRING_8)
			-- Add header `a_header_name:a_value'.
			-- If it already exists, there will be multiple header with same name
			-- which can also be valid
		local
			s: STRING_8
		do
			create s.make (a_header_name.count + 2 + a_value.count)
			s.append (a_header_name)
			s.append (colon_space)
			s.append (a_value)
			add_header (s)
		ensure
			added: has_header_named (a_header_name)
		end

	put_header_key_value (a_header_name, a_value: READABLE_STRING_8)
			-- Add header `a_header_name:a_value', or replace existing header of same header name/key
		local
			s: STRING_8
		do
			create s.make (a_header_name.count + 2 + a_value.count)
			s.append (a_header_name)
			s.append (colon_space)
			s.append (a_value)
			put_header (s)
		ensure
			added: has_header_named (a_header_name)
		end

	put_header_key_values (a_header_name: READABLE_STRING_8; a_values: ITERABLE [READABLE_STRING_8]; a_separator: detachable READABLE_STRING_8)
			-- Add header `a_header_name: a_values', or replace existing header of same header values/key.
			-- Use `comma_space' as default separator if `a_separator' is Void or empty.
		local
			s: STRING_8
			l_separator: READABLE_STRING_8
		do
			if a_separator /= Void and then not a_separator.is_empty then
				l_separator := a_separator
			else
				l_separator := comma_space
			end
			create s.make_empty
			across
				a_values as c
			loop
				if not s.is_empty then
					s.append_string (l_separator)
				end
				s.append (c.item)
			end
			if not s.is_empty then
				put_header_key_value (a_header_name, s)
			end
		ensure
			added: has_header_named (a_header_name)
		end

feature -- Content related header

	put_content_type (a_content_type: READABLE_STRING_8)
			-- Put header line "Content-Type:" + type `a_content_type'
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_content_type, a_content_type)
		end

	add_content_type (a_content_type: READABLE_STRING_8)
			-- same as `put_content_type', but allow multiple definition of "Content-Type"
		do
			add_header_key_value ({HTTP_HEADER_NAMES}.header_content_type, a_content_type)
		end

	put_content_type_with_parameters (a_content_type: READABLE_STRING_8; a_params: detachable ARRAY [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Put header line "Content-Type:" + type `a_content_type' and extra paramaters `a_params'
			--| note: see `put_content_type_with_charset' for examples.
		local
			s: STRING_8
			v: READABLE_STRING_8
		do
			if a_params /= Void and then not a_params.is_empty then
				create s.make_from_string (a_content_type)
				across
					a_params as p
				loop
					if attached p.item as nv then
						s.append_character (';')
						s.append_character (' ')
						s.append (nv.name)
						s.append_character ('=')
						v := nv.value
						if v.has(' ') or v.has ('%T') or v.has ('=') then
							s.append_character ('%"')
							s.append (v)
							s.append_character ('%"')
						else
							s.append (v)
						end
					end
				end
				put_header_key_value ({HTTP_HEADER_NAMES}.header_content_type, s)
			else
				put_content_type (a_content_type)
			end
		end		

	add_content_type_with_parameters (a_content_type: READABLE_STRING_8; a_params: detachable ARRAY [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Add header line "Content-Type:" + type `a_content_type' and extra paramaters `a_params'.
			--| note: see `put_content_type_with_charset' for examples.
		local
			s: STRING_8
		do
			if a_params /= Void and then not a_params.is_empty then
				create s.make_from_string (a_content_type)
				across
					a_params as p
				loop
					if attached p.item as nv then
						s.append_character (';')
						s.append_character (' ')
						s.append (nv.name)
						s.append_character ('=')
						s.append_character ('%"')
						s.append (nv.value)
						s.append_character ('%"')
					end
				end
				add_header_key_value ({HTTP_HEADER_NAMES}.header_content_type, s)
			else
				add_content_type (a_content_type)
			end
		end

	put_content_type_with_charset (a_content_type: READABLE_STRING_8; a_charset: READABLE_STRING_8)
			-- Put content type `a_content_type' with `a_charset' as "charset" parameter.
		do
			put_content_type_with_parameters (a_content_type, {ARRAY [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]} <<["charset", a_charset]>>)
		end

	add_content_type_with_charset (a_content_type: READABLE_STRING_8; a_charset: READABLE_STRING_8)
			-- Same as `put_content_type_with_charset', but allow multiple definition of "Content-Type".
		do
			add_content_type_with_parameters (a_content_type, {ARRAY [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]} <<["charset", a_charset]>>)
		end

	put_content_type_with_name (a_content_type: READABLE_STRING_8; a_name: READABLE_STRING_8)
			-- Put content type `a_content_type' with `a_name' as "name" parameter.	
		do
			put_content_type_with_parameters (a_content_type, {ARRAY [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]} <<["name", a_name]>>)
		end

	add_content_type_with_name (a_content_type: READABLE_STRING_8; a_name: READABLE_STRING_8)
			-- same as `put_content_type_with_name', but allow multiple definition of "Content-Type"	
		do
			add_content_type_with_parameters (a_content_type, {ARRAY [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]} <<["name", a_name]>>)
		end

	put_content_length (a_length: INTEGER)
			-- Put "Content-Length:" + length `a_length'.
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_content_length, a_length.out)
		end

	put_content_transfer_encoding (a_mechanism: READABLE_STRING_8)
			-- Put "Content-Transfer-Encoding" header with `a_mechanism'
			--|   encoding := "Content-Transfer-Encoding" ":" mechanism
			--|
			--|   mechanism :=     "7bit"  ;  case-insensitive
			--|                  / "quoted-printable"
			--|                  / "base64"
			--|                  / "8bit"
			--|                  / "binary"
			--|                  / x-token
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_content_transfer_encoding, a_mechanism)
		end

	put_content_language (a_lang: READABLE_STRING_8)
			-- Put "Content-Language" header of value `a_lang'.
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_content_language, a_lang)
		end

	put_content_encoding (a_encoding: READABLE_STRING_8)
			-- Put "Content-Encoding" header of value `a_encoding'.
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_content_encoding, a_encoding)
		end

	put_transfer_encoding (a_encoding: READABLE_STRING_8)
			-- Put "Transfer-Encoding" header with `a_encoding' value.
			--| for instance "chunked"
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_transfer_encoding, a_encoding)
		end

	put_transfer_encoding_binary
			-- Put "Transfer-Encoding: binary" header
		do
			put_transfer_encoding (str_binary)
		end

	put_transfer_encoding_chunked
			-- Put "Transfer-Encoding: chunked" header
		do
			put_transfer_encoding (str_chunked)
		end

	put_content_disposition (a_type: READABLE_STRING_8; a_params: detachable READABLE_STRING_8)
			-- Put "Content-Disposition" header
			--| See RFC2183
			--|     disposition := "Content-Disposition" ":"
			--|                    disposition-type
			--|                    *(";" disposition-parm)
			--|     disposition-type := "inline"
			--|                       / "attachment"
			--|                       / extension-token
			--|                       ; values are not case-sensitive
			--|     disposition-parm := filename-parm
			--|                       / creation-date-parm
			--|                       / modification-date-parm
			--|                       / read-date-parm
			--|                       / size-parm
			--|                       / parameter
			--|     filename-parm := "filename" "=" value
			--|     creation-date-parm := "creation-date" "=" quoted-date-time
			--|     modification-date-parm := "modification-date" "=" quoted-date-time
			--|     read-date-parm := "read-date" "=" quoted-date-time
			--|     size-parm := "size" "=" 1*DIGIT
			--|     quoted-date-time := quoted-string
			--|                      ; contents MUST be an RFC 822 `date-time'
			--|                      ; numeric timezones (+HHMM or -HHMM) MUST be used
		do
			if a_params /= Void then
				put_header_key_value ({HTTP_HEADER_NAMES}.header_content_disposition, a_type + semi_colon_space + a_params)
			else
				put_header_key_value ({HTTP_HEADER_NAMES}.header_content_disposition, a_type)
			end
		end

feature -- Content-type helpers

	put_content_type_text_css				do put_content_type ({HTTP_MIME_TYPES}.text_css) end
	put_content_type_text_csv				do put_content_type ({HTTP_MIME_TYPES}.text_csv) end
	put_content_type_text_html				do put_content_type ({HTTP_MIME_TYPES}.text_html) end
	put_content_type_utf_8_text_html		do put_content_type_with_charset ({HTTP_MIME_TYPES}.text_html, "utf-8") end
	put_content_type_text_javascript		do put_content_type ({HTTP_MIME_TYPES}.text_javascript) end
	put_content_type_text_json				do put_content_type ({HTTP_MIME_TYPES}.text_json) end
	put_content_type_text_plain				do put_content_type ({HTTP_MIME_TYPES}.text_plain) end
	put_content_type_text_xml				do put_content_type ({HTTP_MIME_TYPES}.text_xml) end

	put_content_type_application_json		do put_content_type ({HTTP_MIME_TYPES}.application_json) end
	put_content_type_application_javascript	do put_content_type ({HTTP_MIME_TYPES}.application_javascript) end
	put_content_type_application_zip		do put_content_type ({HTTP_MIME_TYPES}.application_zip)	end
	put_content_type_application_pdf		do put_content_type ({HTTP_MIME_TYPES}.application_pdf) end

	put_content_type_image_gif				do put_content_type ({HTTP_MIME_TYPES}.image_gif) end
	put_content_type_image_png				do put_content_type ({HTTP_MIME_TYPES}.image_png) end
	put_content_type_image_jpg				do put_content_type ({HTTP_MIME_TYPES}.image_jpg) end
	put_content_type_image_svg_xml			do put_content_type ({HTTP_MIME_TYPES}.image_svg_xml) end

	put_content_type_message_http			do put_content_type ({HTTP_MIME_TYPES}.message_http) end

	put_content_type_multipart_mixed		do put_content_type ({HTTP_MIME_TYPES}.multipart_mixed) end
	put_content_type_multipart_alternative	do put_content_type ({HTTP_MIME_TYPES}.multipart_alternative) end
	put_content_type_multipart_related		do put_content_type ({HTTP_MIME_TYPES}.multipart_related) end
	put_content_type_multipart_form_data	do put_content_type ({HTTP_MIME_TYPES}.multipart_form_data) end
	put_content_type_multipart_signed		do put_content_type ({HTTP_MIME_TYPES}.multipart_signed) end
	put_content_type_multipart_encrypted	do put_content_type ({HTTP_MIME_TYPES}.multipart_encrypted) end
	put_content_type_application_x_www_form_encoded	do put_content_type ({HTTP_MIME_TYPES}.application_x_www_form_encoded) end

	put_content_type_utf_8_text_plain		do put_content_type_with_charset ({HTTP_MIME_TYPES}.text_plain, "utf-8") end

feature -- Cross-Origin Resource Sharing

	put_access_control_allow_origin (a_origin: READABLE_STRING_8)
			-- Put "Access-Control-Allow-Origin: " + `a_origin' header.
			-- `a_origin' specifies a URI that may access the resource
			--| for instance "http://example.com"
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_access_control_allow_origin, a_origin)
		end

	put_access_control_allow_all_origin
			-- Put "Access-Control-Allow-Origin: *" header.
		do
			put_access_control_allow_origin ("*")
		end

	put_access_control_allow_credentials (b: BOOLEAN)
			-- Indicates whether or not the response to the request can be exposed when the credentials flag is true.
			-- When used as part of a response to a preflight request, this indicates whether or not the actual request can be made using credentials.
			-- Note that simple GET requests are not preflighted, and so if a request is made for a resource with credentials,
			-- if this header is not returned with the resource, the response is ignored by the browser and not returned to web content.
			-- ex: Access-Control-Allow-Credentials: true | false
		do
			if b then
				put_header_key_value ({HTTP_HEADER_NAMES}.header_access_control_allow_Credentials, "true")
			else
				put_header_key_value ({HTTP_HEADER_NAMES}.header_access_control_allow_Credentials, "false")
			end
		end

	put_access_control_allow_methods (a_methods: ITERABLE [READABLE_STRING_8])
			-- If `a_methods' is not empty, put `Access-Control-Allow-Methods' header with list `a_methods' of methods
			-- `a_methods' specifies the method or methods allowed when accessing the resource.
			-- This is used in response to a preflight request.
			-- ex: Access-Control-Allow-Methods: <method>[, <method>]*
		do
			put_header_key_values ({HTTP_HEADER_NAMES}.header_access_control_allow_methods, a_methods, Void)
		end

	put_access_control_allow_headers (a_headers: READABLE_STRING_8)
			-- Put "Access-Control-Allow-Headers" header. with value `a_headers'
			-- Used in response to a preflight request to indicate which HTTP headers can be used when making the actual request.
			-- ex: Access-Control-Allow-Headers: <field-name>[, <field-name>]*
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_access_control_allow_headers, a_headers)
		end

	put_access_control_allow_iterable_headers (a_fields: ITERABLE [READABLE_STRING_8])
			-- Put "Access-Control-Allow-Headers" header. with value `a_headers'
			-- Used in response to a preflight request to indicate which HTTP headers can be used when making the actual request.
			-- ex: Access-Control-Allow-Headers: <field-name>[, <field-name>]*
		do
			put_header_key_values ({HTTP_HEADER_NAMES}.header_access_control_allow_headers, a_fields, Void)
		end

feature -- Method related

	put_allow (a_methods: ITERABLE [READABLE_STRING_8])
			-- If `a_methods' is not empty, put `Allow' header with list `a_methods' of methods
		do
			put_header_key_values ({HTTP_HEADER_NAMES}.header_allow, a_methods, Void)
		end

feature -- Date

	put_date (a_date: READABLE_STRING_8)
			-- Put "Date: " header
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_date, a_date)
		end

	put_current_date
			-- Put current date time with "Date" header
		do
			put_utc_date (create {DATE_TIME}.make_now_utc)
		end

	put_utc_date (a_utc_date: DATE_TIME)
			-- Put UTC date time `a_utc_date' with "Date" header
			-- using RFC1123 date formating.
		do
			put_date (date_to_rfc1123_http_date_format (a_utc_date))
		end

	put_last_modified (a_utc_date: DATE_TIME)
			-- Put UTC date time `dt' with "Last-Modified" header
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_last_modified, date_to_rfc1123_http_date_format (a_utc_date))
		end

feature -- Authorization

	put_authorization (a_authorization: READABLE_STRING_8)
			-- Put `a_authorization' with "Authorization" header
			-- The Authorization header is constructed as follows:
			--  1. Username and password are combined into a string "username:password".
			--  2. The resulting string literal is then encoded using Base64.
			--  3. The authorization method and a space, i.e. "Basic " is then put before the encoded string.
			-- ex: Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_authorization, a_authorization)
		end

feature -- Others	

	put_expires (a_seconds: INTEGER)
			-- Put "Expires" header to `a_seconds' seconds
			-- and also "Cache-Control: max-age=.." .
			-- To be supported by most browser.
		local
			dt: DATE_TIME
		do
			create dt.make_now_utc
			dt.second_add (a_seconds)
			put_expires_date (dt)
			put_cache_control ("max-age=" + a_seconds.out)
		end

	put_expires_string (a_expires: STRING)
			-- Put "Expires" header with `a_expires' string value
		do
			put_header_key_value ("Expires", a_expires)
		end

	put_expires_date (a_utc_date: DATE_TIME)
			-- Put "Expires" header with UTC date time value
			-- formatted following RFC1123 specification.
		do
			put_header_key_value ("Expires", date_to_rfc1123_http_date_format (a_utc_date))
		end

	put_cache_control (a_cache_control: READABLE_STRING_8)
			-- Put "Cache-Control" header with value `a_cache_control'
			--| note: ex "Cache-Control: no-cache, must-revalidate"
		do
			put_header_key_value ("Cache-Control", a_cache_control)
		end

	put_pragma (a_pragma: READABLE_STRING_8)
			-- Put "Pragma" header with value `a_pragma'
		do
			put_header_key_value ("Pragma", a_pragma)
		end

	put_pragma_no_cache
			-- Put "Pragma" header with "no-cache" a_pragma
		do
			put_pragma ("no-cache")
		end

feature -- Connection		

	put_connection (a_conn: READABLE_STRING_8)
			-- Put "Connection" header with `a_conn' value.
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_connection, a_conn)
		end

	put_connection_keep_alive
			-- Put "Connection" header with "keep-alive".
		do
			put_connection ("keep-alive")
		end

	put_connection_close
			-- Put "Connection" header with "close".
		do
			put_connection ("close")
		end

feature -- Redirection

	put_location (a_uri: READABLE_STRING_8)
			-- Tell the client the new location `a_uri'
			-- using "Location" header.
		require
			a_uri_valid: not a_uri.is_empty
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_location, a_uri)
		end

	put_refresh (a_uri: READABLE_STRING_8; a_timeout_in_seconds: INTEGER)
			-- Tell the client to refresh page with `a_uri' after `a_timeout_in_seconds' in seconds
			-- using "Refresh" header.
		require
			a_uri_valid: not a_uri.is_empty
		do
			put_header_key_value ({HTTP_HEADER_NAMES}.header_refresh, a_timeout_in_seconds.out + "; url=" + a_uri)
		end

feature -- Cookie

	put_cookie (key, value: READABLE_STRING_8; expiration, path, domain: detachable READABLE_STRING_8; secure, http_only: BOOLEAN)
			-- Set a cookie on the client's machine
			-- with key 'key' and value 'value'.
			-- Note: you should avoid using "localhost" as `domain' for local cookies
			--       since they are not always handled by browser (for instance Chrome)
		require
			make_sense: (key /= Void and value /= Void) and then (not key.is_empty and not value.is_empty)
			domain_without_port_info: domain /= Void implies domain.index_of (':', 1) = 0
		local
			s: STRING
		do
			s := {HTTP_HEADER_NAMES}.header_set_cookie + colon_space + key + "=" + value
			if
				domain /= Void and then not domain.same_string ("localhost")
			then
				s.append ("; Domain=")
				s.append (domain)
			end
			if path /= Void then
				s.append ("; Path=")
				s.append (path)
			end
			if expiration /= Void then
				s.append ("; Expires=")
				s.append (expiration)
			end
			if secure then
				s.append ("; Secure")
			end
			if http_only then
				s.append ("; HttpOnly")
			end
			add_header (s)
		end

	put_cookie_with_expiration_date (key, value: READABLE_STRING_8; expiration: DATE_TIME; path, domain: detachable READABLE_STRING_8; secure, http_only: BOOLEAN)
			-- Set a cookie on the client's machine
			-- with key 'key' and value 'value'.
		require
			make_sense: (key /= Void and value /= Void) and then (not key.is_empty and not value.is_empty)
		do
			put_cookie (key, value, date_to_rfc1123_http_date_format (expiration), path, domain, secure, http_only)
		end


feature -- Access

	date_to_rfc1123_http_date_format (dt: DATE_TIME): STRING_8
			-- String representation of `dt' using the RFC 1123
		local
			d: HTTP_DATE
		do
			create d.make_from_date_time (dt)
			Result := d.string
		end

feature {NONE} -- Implementation

	has_same_header_name (h: READABLE_STRING_8; a_name: READABLE_STRING_8): BOOLEAN
			-- Header line `h' has same name as `a_name' ?
		do
			if h.starts_with (a_name) then
				if h.valid_index (a_name.count + 1) then
					Result := h[a_name.count + 1] = ':'
				end
			end
		end

feature {NONE} -- Constants

	str_binary: STRING = "binary"
	str_chunked: STRING = "chunked"

	colon_space: IMMUTABLE_STRING_8
		once
			create Result.make_from_string (": ")
		end

	semi_colon_space: IMMUTABLE_STRING_8
		once
			create Result.make_from_string ("; ")
		end

	comma_space: IMMUTABLE_STRING_8
		once
			create Result.make_from_string (", ")
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
