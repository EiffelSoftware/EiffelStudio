note
	description: "Represent an HTTP request."
	date: "$Date$"
	revision: "$Revision$"

class
	REQUEST

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
			create headers.make (5)
		ensure
			ver_set: verb = a_method
			uri_set: uri = a_uri
		end

feature -- Status Report

	is_valid_uri (a_uri: READABLE_STRING_8): BOOLEAN
		local
			l_uri: URI
		do
			create l_uri.make_from_string (a_uri)
			Result := l_uri.is_valid
		end

	query_string: detachable READABLE_STRING_8
		local
			l_uri: URI
		do
			create l_uri.make_from_string (uri)
			Result := l_uri.query
		end

	sanitized_url: READABLE_STRING_8
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

	content_type_header_name: STRING_8 = "Content-Type";

	default_content_type: STRING
		once
			Result := application_json
		end

feature -- Access

	uri: READABLE_STRING_8

	verb: READABLE_STRING_8

	headers: STRING_TABLE [READABLE_STRING_8]

	payload: detachable READABLE_STRING_8

	executor: detachable REQUEST_EXECUTOR

feature -- Change Element

	add_payload (a_payload: like payload)
		do
			payload := a_payload
		ensure
			payload_set: attached payload as l_payload implies l_payload = a_payload
		end

	add_header (key: READABLE_STRING_8; value: READABLE_STRING_8)
		do
			headers.force (value, key)
		end

feature -- Execute

	execute: detachable RESPONSE
		do
			initialize_executor
			Result := execute_request
		end

	initialize_executor
		do
			create executor.make (uri, verb)
		end

feature {NONE} -- Implementation

	execute_request: detachable RESPONSE
		do
			if attached executor as l_executor then
					-- add headers
				add_headers (l_executor)
				if verb.same_string (method_put) or else verb.same_string (method_post) or else verb.same_string (method_patch) then
					l_executor.set_body (body_contents)
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
		local
			l_context_executor: HTTP_CLIENT_REQUEST_CONTEXT
			s: READABLE_STRING_GENERAL
			utf: UTF_CONVERTER
		do
			l_context_executor := a_executor.context_executor
			across
				headers as ic
			loop
				s := ic.key
				if s.is_valid_as_string_8 then
					l_context_executor.add_header (s.as_string_8, ic.item)
				else
					l_context_executor.add_header (utf.utf_32_string_to_utf_8_string_8 (s), ic.item)
				end
			end
		end

	body_contents: READABLE_STRING_8
		do
			if attached payload as l_payload then
				Result := l_payload
			else
				Result := ""
			end
		end

	as_uri (a_string: READABLE_STRING_8): URI
		require
			is_valid_uri: is_valid_uri (a_string)
		do
			create Result.make_from_string (a_string)
		end

note
	copyright: "2011-2015 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		5949 Hollister Ave., Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end
