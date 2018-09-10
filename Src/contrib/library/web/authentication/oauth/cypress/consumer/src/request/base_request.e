note
	description: "Summary description for {BASE_REQUEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASE_REQUEST

inherit
	HTTP_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_method: READABLE_STRING_8; a_uri: READABLE_STRING_8)
		require
			valid_http_method: is_http_method (a_method)
			valid_uri: is_valid_uri (a_uri)
		do
			verb := a_method
			uri := a_uri
			create query_string_parameters.make (5)
			create body_parameters.make (5)
			create headers.make (5)
			create form_parameters.make (1)
			add_query_parameters
		ensure
			ver_set: verb = a_method
			uri_set: uri = a_uri
		end

feature -- Status Report

	is_valid_uri (a_uri: READABLE_STRING_GENERAL): BOOLEAN
		local
			l_uri: URI
		do
			if a_uri.is_valid_as_string_8 then
				create l_uri.make_from_string (a_uri.to_string_8)
				Result := l_uri.is_valid
			end
		end

	query_string: detachable READABLE_STRING_8
		local
			l_uri: URI
		do
			create l_uri.make_from_string (uri)
			Result := l_uri.query
		end

	sanitized_url: STRING_8
			-- Returns the URL without the query string part	
		local
			l_uri: URI
		do
			create l_uri.make_from_string (uri)
			l_uri.remove_query
			Result := l_uri.string
		ensure
			sanitized: not as_uri (Result).has_query
		end

	is_http_method (a_method: READABLE_STRING_GENERAL): BOOLEAN
		do
			if a_method.same_string (method_connect) then
				Result := True
			elseif a_method.same_string (method_delete) then
				Result := True
			elseif a_method.same_string (method_get) then
				Result := True
			elseif a_method.same_string (method_head) then
				Result := True
			elseif a_method.same_string (method_options) then
				Result := True
			elseif a_method.same_string (method_patch) then
				Result := True
			elseif a_method.same_string (method_post) then
				Result := True
			elseif a_method.same_string (method_put) then
				Result := True
			elseif a_method.same_string (method_trace) then
				Result := True
			end
		end

feature -- Constants

	content_type_header_name: STRING_8 = "Content-Type"

	content_length: STRING_8 = "Content-Length"

	default_content_type: STRING
		once
			Result := "application/x-www-form-urlencoded"
		end

feature -- Access

	uri: READABLE_STRING_8

	verb: READABLE_STRING_8

	query_string_parameters: OAUTH_PARAMETER_LIST

	body_parameters: OAUTH_PARAMETER_LIST

	headers: HASH_TABLE [STRING_8, STRING_8]

	payload: detachable STRING

	executor: detachable REQUEST_EXECUTOR

	upload_file: detachable READABLE_STRING_GENERAL
			-- File to be uploaded.

	form_parameters: HASH_TABLE [STRING_8, STRING_8]

feature -- Change Element

	add_body_parameter (a_key: READABLE_STRING_8; a_value: READABLE_STRING_8)
		do
			body_parameters.add_parameter (a_key, a_value)
		end

	add_payload (a_payload: like payload)
		do
			payload := a_payload
		ensure
			payload_set: attached payload as l_payload implies l_payload = a_payload
		end

	add_query_string_parameter (key: READABLE_STRING_8; value: READABLE_STRING_8)
			-- Add a query string parameter
		do
			query_string_parameters.add_parameter (key, value)
		ensure
			one_more_parameter: old query_string_parameters.count + 1 = query_string_parameters.count
		end

	add_header (key: READABLE_STRING_8; value: READABLE_STRING_8)
		do
			headers.force (value, key)
		end

	add_form_parameter (key: READABLE_STRING_8; value: READABLE_STRING_8)
		do
			form_parameters.force (value, key)
		end

	set_upload_filename (a_fn: detachable READABLE_STRING_GENERAL)
		do
			upload_file := a_fn
		end

feature -- Execute

	execute: detachable OAUTH_RESPONSE
		do
			initialize_executor
			Result := do_execute
		end

	initialize_executor
		local
			l_uri: STRING
		do
			create l_uri.make_from_string (uri)
			query_string_parameters.append_to_url (l_uri)
			create executor.make (l_uri, verb)
		end

feature {NONE} -- Implementation

	do_execute: detachable OAUTH_RESPONSE
		do
			if attached executor as l_executor then
					-- add headers
				add_headers (l_executor)
				if verb.same_string (method_put) or else verb.same_string (method_post) then
					if not body_contents.is_empty then
						l_executor.set_body (body_contents.as_string_8)
						l_executor.context_executor.add_header (content_length, body_contents.count.out)
					end
					if attached  upload_file then
						l_executor.context_executor.set_upload_filename (upload_file)
					end
					if attached payload then
						l_executor.context_executor.set_upload_data (payload)
					end
					if not form_parameters.is_empty then
						across
							form_parameters as ic
						loop
							l_executor.context_executor.add_form_parameter (ic.key, ic.item)
						end

					end
				end
				if not l_executor.context_executor.headers.has (content_type_header_name) then
					l_executor.context_executor.add_header (content_type_header_name, default_content_type)
				end
				if attached l_executor.execute as l_response then
					create Result.make (l_response)
				end
			end
		end

feature {NONE} -- Implementation

	add_headers (a_executor: REQUEST_EXECUTOR)
		do
			across
				headers as ic
			loop
				a_executor.context_executor.add_header (ic.key, ic.item)
			end
		end

	body_contents: READABLE_STRING_8
		do
			Result := body_parameters.as_form_url_encoded_string
		end

	add_query_parameters
		do
			if attached query_string as l_query then
				query_string_parameters.add_query_string (l_query)
			end
		end

	as_uri (a_string: READABLE_STRING_GENERAL): URI
		require
			is_valid_uri : is_valid_uri (a_string)
		do
			create Result.make_from_string (a_string.as_string_8)
		end

note
	copyright: "2013-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
