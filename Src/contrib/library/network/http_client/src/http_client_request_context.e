note
	description: "[
				Context for HTTP client request
				This is used to hold 
					- headers
					- query_parameters
					- form parameters
					- upload_data xor upload_filename
				And in addition it has 
					- credentials_required
					- proxy
					
				Note that any value set in this context class overrides conflicting value eventually
				     set in associated HTTP_CLIENT_SESSION.
			
				Warning: for now [2012-05-31], you can have only one of the following data
						- form_parameters
						- or upload_data 
						- or upload_filename 
						If you set more than one, the priority is then upload_data, then upload_filename, then form_parameters
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_REQUEST_CONTEXT

create
	make,
	make_with_credentials_required

feature {NONE} -- Initialization

	make
		do
			create headers.make (2)
			create query_parameters.make (5)
			create form_parameters.make (10)
		end

	make_with_credentials_required
		do
			make
			set_credentials_required (True)
		end

feature -- Settings

	credentials_required: BOOLEAN
			-- If True, the request will precise the HTTP_AUTHORIZATION.

	proxy: detachable TUPLE [host: READABLE_STRING_8; port: INTEGER]
			-- Optional proxy, see {HTTP_CLIENT_SESSION}.proxy

feature -- Access

	headers: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- Specific headers to use in addition to the one set in the related HTTP_CLIENT_SESSION
			--| note: the value from Current context override the one from the session in case of conflict

	query_parameters: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			-- Query parameters to be appended to the url
			--| note: if the url already contains a query_string, the `query_parameters' will be appended to the url

	form_parameters: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			-- Form parameters

	upload_data: detachable READABLE_STRING_8
			-- Upload data
			--| Note: make sure to precise the Content-Type header

	upload_filename: detachable IMMUTABLE_STRING_32
			-- Upload data read from `upload_filename'
			--| Note: make sure to precise the Content-Type header

	write_agent: detachable PROCEDURE [READABLE_STRING_8]
			-- Use this agent to hook the write of the response.
			--| could be used to save the response directly in a file		

	output_file: detachable FILE
			-- Optional output file to get downloaded content and header

	output_content_file: detachable FILE
			-- Optional output file to get downloaded content

	http_version: detachable IMMUTABLE_STRING_8
			-- Overwrite default http version if set.

feature -- Status report

	has_form_data: BOOLEAN
			-- Has any form parameters?
			--| i.e coming from POST or PUT content.
		do
			Result := not form_parameters.is_empty
		end

	has_upload_data: BOOLEAN
			-- Has associated upload_data?
		do
			Result := attached upload_data as d and then not d.is_empty
		end

	has_upload_filename: BOOLEAN
			-- Has associated upload_filename?
		do
			Result := attached upload_filename as fn and then not fn.is_empty
		end

	has_write_option: BOOLEAN
			-- Has non default write behavior?
		do
			Result := write_agent /= Void or output_file /= Void or output_content_file /= Void
		end

feature -- Element change

	add_header (k: READABLE_STRING_8; v: READABLE_STRING_8)
			-- Add http header line `k:v'.
		do
			headers.force (v, k)
		end

	add_header_line (s: READABLE_STRING_8)
			-- Add http header line `s'.
		local
			i: INTEGER
		do
			i := s.index_of (':', 1)
			if i > 0 then
				add_header (s.substring (1, i - 1), s.substring (i + 1, s.count))
			end
		end

	add_header_lines (lst: ITERABLE [READABLE_STRING_8])
			-- Add collection of http header lines `lst'
		do
			across
				lst as c
			loop
				add_header_line (c.item)
			end
		end

	add_query_parameter (k: READABLE_STRING_GENERAL; v: READABLE_STRING_GENERAL)
			-- Add a query parameter `k=v'.
		do
			query_parameters.force (v.to_string_32, k.to_string_32)
		end

	add_form_parameter (k: READABLE_STRING_GENERAL; v: READABLE_STRING_GENERAL)
			-- Add a form parameter `k'= `v'.
		do
			form_parameters.force (v.to_string_32, k.to_string_32)
		end

	set_credentials_required (b: BOOLEAN)
			-- If b is True, credentials are required, otherwise just optional.
		do
			credentials_required := b
		end

	set_upload_data (a_data: like upload_data)
			-- Set `upload_data' to `a_data'
			--| note: the Current context can have upload_data XOR upload_filename, but not both.
		require
			has_upload_filename: (a_data /= Void and then not a_data.is_empty) implies not has_upload_filename
		do
			if a_data = Void or else a_data.is_empty then
				upload_data := Void
			else
				upload_data := a_data
			end
		ensure
			(a_data /= Void and then not a_data.is_empty) implies (has_upload_data and not has_upload_filename)
		end

	set_upload_filename (a_fn: detachable READABLE_STRING_GENERAL)
			-- Set `upload_filename' to `a_fn'
			--| note: the Current context can have upload_data XOR upload_filename, but not both.	
		require
			has_no_upload_data: (a_fn /= Void and then not a_fn.is_empty) implies not has_upload_data
		do
			if a_fn = Void or else a_fn.is_empty then
				upload_filename := Void
			else
				create upload_filename.make_from_string_general (a_fn)
			end
		ensure
			(a_fn /= Void and then not a_fn.is_empty) implies (has_upload_filename and not has_upload_data)
		end

	set_write_agent (agt: like write_agent)
			-- Set `write_agent' to `agt'.
		do
			write_agent := agt
		end

	set_output_file (f: FILE)
			-- Set `output_file' to `f'.
		require
			f_is_open_write: f.is_open_write
		do
			output_file := f
		end

	set_output_content_file (f: FILE)
			-- Set `output_content_file' to `f'.
		require
			f_is_open_write: f.is_open_write
		do
			output_content_file := f
		end

	set_http_version (v: detachable READABLE_STRING_8)
		require
			valid_version: v = Void or else v.starts_with_general ("HTTP/")
		do
			if v = Void then
				http_version := Void
			else
				create http_version.make_from_string (v)
			end
		end

feature -- Status setting

	set_proxy (a_host: detachable READABLE_STRING_8; a_port: INTEGER)
			-- Set proxy to `a_host:a_port'.
			--| this can be used for instance with "http://fiddler2.com/" web debugging proxy.
		do
			if a_host = Void then
				proxy := Void
			else
				proxy := [a_host, a_port]
			end
		end

feature -- URL helpers

	append_query_parameters_to_url (a_url: STRING)
			-- Append parameters `a_parameters' to `a_url'
		require
			a_url_attached: a_url /= Void
		local
			l_first_param: BOOLEAN
		do
			if
				attached query_parameters as l_query_parameters and then
				not l_query_parameters.is_empty
			then
				if a_url.index_of ('?', 1) > 0 then
					l_first_param := False
				elseif a_url.index_of ('&', 1) > 0 then
					l_first_param := False
				else
					l_first_param := True
				end

				across
					query_parameters as ic
				loop
					if l_first_param then
						a_url.append_character ('?')
					else
						a_url.append_character ('&')
					end
					l_first_param := False
					uri_percent_encoder.append_query_name_encoded_string_to (ic.key, a_url)
					a_url.append_character ('=')
					uri_percent_encoder.append_query_value_encoded_string_to (ic.item, a_url)
				end
			end
		end

feature -- Conversion helpers

	query_parameters_to_url_encoded_string: STRING_8
			-- `query_parameters' as url-encoded string.
		do
			Result := parameters_to_uri_percent_encoded_string (query_parameters)
		end

	form_parameters_to_x_www_form_url_encoded_string: STRING_8
			-- `form_parameters' as x-www-form-urlencoded string.	
		do
			Result := parameters_to_x_www_form_urlencoded_string (form_parameters)
		end

	form_parameters_to_url_encoded_string: STRING_8
			-- `form_parameters' as url-encoded string.	
		obsolete "Use form_parameters_to_x_www_form_url_encoded_string [2017-05-31]"
		do
			Result := form_parameters_to_x_www_form_url_encoded_string
		end

feature {NONE} -- Implementation

	parameters_to_url_encoded_string (ht: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]): STRING_8
			-- Build url encoded string using parameters from `ht'.
		do
			create Result.make (64)
			from
				ht.start
			until
				ht.after
			loop
				if not Result.is_empty then
					Result.append_character ('&')
				end
				Result.append (url_encoder.encoded_string (ht.key_for_iteration))
				Result.append_character ('=')
				Result.append (url_encoder.encoded_string (ht.item_for_iteration))
				ht.forth
			end
		end

	parameters_to_uri_percent_encoded_string (ht: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]): STRING_8
			-- Build query urlencoded string using parameters from `ht'.
		do
			create Result.make (64)
			across
				ht as ic
			loop
				if not Result.is_empty then
					Result.append_character ('&')
				end
				uri_percent_encoder.append_query_name_encoded_string_to (ic.key, Result)
				Result.append_character ('=')
				uri_percent_encoder.append_query_value_encoded_string_to (ic.item, Result)
			end
		end

	parameters_to_x_www_form_urlencoded_string (ht: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]): STRING_8
			-- Build x-www-form-urlencoded string using parameters from `ht'.
		do
			create Result.make (64)
			from
				ht.start
			until
				ht.after
			loop
				if not Result.is_empty then
					Result.append_character ('&')
				end
				Result.append (x_www_form_url_encoder.encoded_string (ht.key_for_iteration))
				Result.append_character ('=')
				Result.append (x_www_form_url_encoder.encoded_string (ht.item_for_iteration))
				ht.forth
			end
		end

	x_www_form_url_encoder: X_WWW_FORM_URL_ENCODER
			-- Shared x-www-form-urlencoded encoder.
		once
			create Result
		end

	uri_percent_encoder: URI_PERCENT_ENCODER
		once
			create Result
		end

	url_encoder: URL_ENCODER
			-- Shared URL encoder.
		once
			create Result
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
