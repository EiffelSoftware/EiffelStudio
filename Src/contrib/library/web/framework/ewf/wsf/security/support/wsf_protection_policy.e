note
	description: "Return data for WSF_REQUEST query and form parameters using different types of protection policy"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_PROTECTION_POLICY

	-- TODO  add header protection.

feature -- Query parameters

	custom_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL; a_protections: ITERABLE [WSF_PROTECTION]): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with custom protections.
		do
			Result := custom_wsf_value (a_req.query_parameter (a_name), a_protections)
		end

	predefined_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with all predefined protections.
			-- check {WSF_PROTECTIONS} class.
		do
			Result := predefined_value (a_req.query_parameter (a_name))
		end

	xss_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with xss protection.
		do
			Result := xss_value (a_req.query_parameter (a_name))
		end

	xss_js_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with xss protection.
		do
			Result := xss_js_value (a_req.query_parameter (a_name))
		end

	sql_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with sql injection protection.
		do
			Result := sql_value (a_req.query_parameter (a_name))
		end

	server_side_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with server side injection protection.
		do
			Result := server_side_value (a_req.query_parameter (a_name))
		end

	xpath_abbreviated_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with XPath_abbreviated injection protection.
		do
			Result := xpath_abbreviated_value (a_req.query_parameter (a_name))
		end

	xpath_expanded_query_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Query parameter name `a_name' with XPath expanded injection protection.
		do
			Result := xpath_expanded_value (a_req.query_parameter (a_name))
		end

feature -- Form Parameters

	custom_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL; a_protections: ITERABLE [WSF_PROTECTION]): detachable WSF_VALUE
			-- Filtered Form parameter name `a_name' with custom protections.
		do
			Result := custom_wsf_value (a_req.form_parameter (a_name), a_protections)
		end

	predefined_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter name `a_name' with all predefined protections.
			-- check {WSF_PROTECTIONS} class.
		do
			Result := predefined_value (a_req.form_parameter (a_name))
		end

	xss_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter  name `a_name' with xss protection.
		do
			Result := xss_value (a_req.form_parameter (a_name))
		end

	xss_js_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter  name `a_name' with xss protection.
		do
			Result := xss_js_value (a_req.form_parameter (a_name))
		end

	sql_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter  name `a_name' with sql injection protection.
		do
			Result := sql_value (a_req.form_parameter (a_name))
		end

	server_side_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter  name `a_name' with server side injection protection.
		do
			Result := server_side_value (a_req.form_parameter (a_name))
		end

	xpath_abbreviated_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter  name `a_name' with server Xpath abbreviated injection protection.
		do
			Result := xpath_abbreviated_value (a_req.form_parameter (a_name))
		end

	xpath_expanded_form_parameter (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered Form parameter  name `a_name' with server Xpath expanded injection protection.
		do
			Result := xpath_expanded_value (a_req.form_parameter (a_name))
		end

feature -- Meta Variables

	custom_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL; a_protections: ITERABLE [WSF_PROTECTION]): detachable WSF_VALUE
			-- Filtered CGI Meta variable name `a_name' with custom protections.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} custom_wsf_value (a_req.meta_variable (a_name), a_protections) as l_result then
				Result := l_result
			end
		end

	predefined_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- Filtered CGI Meta variable name `a_name' with predefined protections.
			-- check {WSF_PROTECTIONS} class.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} predefined_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end

	xss_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- Filtered CGI Meta variable name `a_name' with xss protection.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} xss_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end

	xss_js_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- Filtered CGI Meta variable name `a_name' with xss protection.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} xss_js_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end

	sql_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- Filtered CGI Meta variable name `a_name' with sql injection protection.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} sql_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end

	server_side_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- Filtered CGI Meta variable name `a_name' with server side injection protection.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} server_side_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end

	xpath_abbreviated_side_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- Filtered CGI Meta variable name `a_name' with Xpath abbreviated injection protection.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} xpath_abbreviated_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end

	xpath_expanded_side_meta_variable (a_req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- Filtered CGI Meta variable name `a_name' with Xpath abbreviated injection protection.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			if attached {WSF_STRING} xpath_expanded_value (a_req.meta_variable (a_name)) as l_result then
				Result := l_result
			end
		end
feature -- HTTP_*

	custom_http_accept (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_accept header with custom protections `a_protections`.
			-- Contents of the Accept: header from the current wgi_request, if there is one.
			-- Example: 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
		do
			Result := custom_string_value (a_req.http_accept, a_protections)
		end

	custom_http_accept_charset (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_accept_charset header with custom protections `a_protections`.
			-- Contents of the Accept-Charset: header from the current wgi_request, if there is one.
			-- Example: 'iso-8859-1,*,utf-8'.

		do
			Result := custom_string_value (a_req.http_accept_charset, a_protections)
		end

	custom_http_accept_encoding (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_accept_encoding header with custom protections `a_protections`.
			-- Contents of the Accept-Encoding: header from the current wgi_request, if there is one.
			-- Example: 'gzip'.
		do
			Result := custom_string_value (a_req.http_accept_encoding, a_protections)
		end

	custom_http_accept_language (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_accept_language header with custom protections `a_protections`.
			-- Contents of the Accept-Language: header from the current wgi_request, if there is one.
			-- Example: 'en'.
		do
			Result := custom_string_value (a_req.http_accept_language, a_protections)
		end

	custom_http_connection (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_connection header with custom protections `a_protections`.
			-- Contents of the Connection: header from the current wgi_request, if there is one.
			-- Example: 'keep-alive'.
		do
			Result := custom_string_value (a_req.http_connection, a_protections)
		end

	custom_http_expect (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_expect header with custom protections `a_protections`.
			-- The Expect request-header field is used to indicate that particular server behaviors are required by the client.
			-- Example: '100-continue'.
		do
			Result := custom_string_value (a_req.http_expect, a_protections)
		end

	custom_http_host (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_host header with custom protections `a_protections`.
			-- Contents of the Host: header from the current wgi_request, if there is one.
		do
			Result := custom_string_value (a_req.http_host, a_protections)
		end

	custom_http_referer (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_referer header with custom protections `a_protections`.
			-- The address of the page (if any) which referred the user agent to the current page.
			-- This is set by the user agent.
			-- Not all user agents will set this, and some provide the ability to modify HTTP_REFERER as a feature.
			-- In short, it cannot really be trusted.
		do
			Result := custom_string_value (a_req.http_referer, a_protections)
		end

	custom_http_user_agent (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_user_agent header with custom protections `a_protections`.
			-- Contents of the User-Agent: header from the current wgi_request, if there is one.
			-- This is a string denoting the user agent being which is accessing the page.
			-- A typical example is: Mozilla/4.5 [en] (X11; U; Linux 2.2.9 i586).
			-- Among other things, you can use this value to tailor your page's
			-- output to the capabilities of the user agent.
		do
			Result := custom_string_value (a_req.http_user_agent, a_protections)
		end

	custom_http_authorization (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_authorization header with custom protections `a_protections`.
			-- Contents of the Authorization: header from the current wgi_request, if there is one.
		do
			Result := custom_string_value (a_req.http_authorization, a_protections)
		end

	custom_http_transfer_encoding (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_transfer_encoding header with custom protections `a_protections`.
			-- Transfer-Encoding
			-- for instance chunked.
		do
			Result := custom_string_value (a_req.http_transfer_encoding, a_protections)
		end

	custom_http_access_control_request_headers (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_access_control_request_headers header with custom protections `a_protections`.
			-- Indicates which headers will be used in the actual request
			-- as part of the preflight request
		do
			Result := custom_string_value (a_req.http_access_control_request_headers, a_protections)
		end

	custom_http_if_match (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_if_match header with custom protections `a_protections`.
			-- Existence check on resource.
		do
			Result := custom_string_value (a_req.http_if_match, a_protections)
		end

	custom_http_if_modified_since (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_if_modified_since header with custom protections `a_protections`.
			-- Modification check on resource.
		do
			Result := custom_string_value (a_req.http_if_modified_since, a_protections)
		end

	custom_http_if_none_match (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_if_none_match header with custom protections `a_protections`.
			-- Existence check on resource.
		do
			Result := custom_string_value (a_req.http_if_none_match, a_protections)
		end

	custom_http_if_range (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_if_range header with custom protections `a_protections`.
			-- Existence check on resource.
		do
			Result := custom_string_value (a_req.http_if_range, a_protections)
		end

	custom_http_if_unmodified_since (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_if_unmodified_since header with custom protections `a_protections`.
			-- Modification check on resource.
		do
			Result := custom_string_value (a_req.http_if_unmodified_since, a_protections)
		end

	custom_http_last_modified (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_last_modified header with custom protections `a_protections`.
			-- Modification check on resource.
		do
			Result := custom_string_value (a_req.http_last_modified, a_protections)
		end

	custom_http_range (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_range header with custom protections `a_protections`.
			-- Requested byte-range of resource.
		do
			Result := custom_string_value (a_req.http_range, a_protections)
		end

	custom_http_content_range (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_content_range header with custom protections `a_protections`.
			-- Partial range of selected representation enclosed in message payload.
		do
			Result := custom_string_value (a_req.http_content_range, a_protections)
		end

	custom_http_content_encoding (a_req: WSF_REQUEST; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Filtered http_content_encoding header with custom protections `a_protections`.
			-- Encoding (usually compression) of message payload.
		do
			Result := custom_string_value (a_req.http_content_encoding, a_protections)
		end

feature {NONE} -- Implementation

	custom_wsf_value (a_value: detachable WSF_VALUE; a_protections: ITERABLE [WSF_PROTECTION]): detachable WSF_VALUE
			-- Return value `a_value` filtered by all protections policy.
		do
			Result := filter_wsf_value (a_value, a_protections )
		end

	custom_string_value (a_value: detachable READABLE_STRING_8; a_protections: ITERABLE [WSF_PROTECTION]): detachable READABLE_STRING_8
			-- Return value `a_value` filtered by all protections policy.
		do
			Result := filter_string_value (a_value, a_protections )
		end

	predefined_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by all predefined protections policy.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value,
								<<
									l_wsf_xss.XSS,
									l_wsf_xss.server_side,
									l_wsf_xss.sql_injection,
									l_wsf_xss.xpath_abbreviated,
									l_wsf_xss.xpath_expanded
								>>)
		end

	xss_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by xss protection.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value, <<l_wsf_xss.XSS>>)
		end

	xss_js_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by xss-javascript protection.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value, <<l_wsf_xss.XSS_javascript>>)
		end

	sql_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by sql injection protection.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value, <<l_wsf_xss.SQL_injection>>)
		end

	server_side_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by server side injection protection.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value, <<l_wsf_xss.Server_side>>)
		end

	xpath_abbreviated_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by xpath_abbreviated injection protection.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value, <<l_wsf_xss.Xpath_abbreviated>>)
		end

	xpath_expanded_value (a_value: detachable WSF_VALUE): detachable WSF_VALUE
			-- Return value `a_value` filtered by Xpath expanded injection protection.
		local
			l_wsf_xss: WSF_PROTECTIONS
		do
			Result := filter_wsf_value (a_value, <<l_wsf_xss.Xpath_expanded>>)
		end

	filter_wsf_value (a_value: detachable WSF_VALUE; a_protections: ITERABLE [WSF_PROTECTION]): detachable WSF_VALUE
			-- Filter value `a_value` with an array of protections policy `a_protections`.
		require
			a_protections_valid: across a_protections as ic all ic.item.is_valid end
		local
			prot: WSF_PROTECTION
		do
			if a_value /= Void then
				Result := a_value
				across
					a_protections as ic
				until
					Result = Void
				loop
					prot := ic.item
					check is_valid: prot.is_valid end
					Result := prot.value (Result)
				end
			end
		end

	filter_string_value (a_value: detachable READABLE_STRING_8; a_protections: ITERABLE [WSF_PROTECTION] ): detachable READABLE_STRING_8
			-- Filter value `a_value` with an array of protections policy `a_protections`.
		require
			all_protections_valid: across a_protections as ic all ic.item.is_valid end
		local
			v: WSF_STRING
			prot: WSF_PROTECTION
		do
			if a_value /= Void then
				Result := a_value
				across
					a_protections as ic
				until
					Result = Void
				loop
					prot := ic.item
					check is_valid: prot.is_valid end
					Result := prot.string_8 (Result)
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
