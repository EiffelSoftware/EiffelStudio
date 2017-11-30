note
	description: "[
		XSS request, redefine query_parameter and form_parameters filtering the data (using XSS protection)
		before return the value.
		The XSS protection pattern used is defined here :{WSF_PROTECTIONS}.XSS: WSF_PROTECTION

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_XSS_REQUEST

inherit
	WSF_REQUEST
		redefine
			query_parameter,
			form_parameter,
			meta_variable,
			http_accept,
			http_accept_charset,
			http_accept_encoding,
			http_accept_language,
			http_connection,
			http_expect,
			http_host,
			http_referer,
			http_user_agent,
			http_authorization,
			http_transfer_encoding,
			http_access_control_request_headers,
			http_if_match,
			http_if_modified_since,
			http_if_none_match,
			http_if_range,
			http_if_unmodified_since,
			http_last_modified,
			http_range,
			http_content_range,
			http_content_encoding
		end

	WSF_REQUEST_EXPORTER

	WSF_PROTECTION_POLICY

create
	make_from_request

feature {NONE} -- Creation

	make_from_request (req: WSF_REQUEST)
		do
			make_from_wgi (req.wgi_request)
		end

feature -- Query parameters

	query_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- <Precursor>
		do
			Result := xss_query_parameter (Current, a_name)
		end

feature -- Form Parameters

	form_parameter (a_name: READABLE_STRING_GENERAL): detachable WSF_VALUE
			-- <Precursor>
		do
			Result := xss_form_parameter (Current, a_name)
		end

feature -- Meta Variable

	meta_variable (a_name: READABLE_STRING_GENERAL): detachable WSF_STRING
			-- <Precursor>
		do
			Result := xss_meta_variable (Current, a_name)
		end

feature -- HTTP_*

	http_accept: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_accept (Current, <<l_protection.xss>>)
		end

	http_accept_charset: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_accept_charset (Current, <<l_protection.xss>>)
		end

	http_accept_encoding: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_accept_encoding (Current, <<l_protection.xss>>)
		end

	http_accept_language: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_accept_language (Current, <<l_protection.xss>>)
		end

	http_connection: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_connection (Current, <<l_protection.xss>>)
		end

	http_expect: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_expect (Current, <<l_protection.xss>>)
		end

	http_host: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_host (Current, <<l_protection.xss>>)
		end

	http_referer: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_referer (Current, <<l_protection.xss>>)
		end

	http_user_agent: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_user_agent (Current, <<l_protection.xss>>)
		end

	http_authorization: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_authorization (Current, <<l_protection.xss>>)
		end

	http_transfer_encoding: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_transfer_encoding (Current, <<l_protection.xss>>)
		end

	http_access_control_request_headers: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_access_control_request_headers (Current, <<l_protection.xss>>)
		end

	http_if_match: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_if_match (Current, <<l_protection.xss>>)
		end

	http_if_modified_since: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_if_modified_since (Current, <<l_protection.xss>>)
		end

	http_if_none_match: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_if_none_match (Current, <<l_protection.xss>>)
		end

	http_if_range: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_if_range (Current, <<l_protection.xss>>)
		end

	http_if_unmodified_since: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_if_unmodified_since (Current, <<l_protection.xss>>)
		end

	http_last_modified: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_last_modified (Current, <<l_protection.xss>>)
		end

	http_range: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_range (Current, <<l_protection.xss>>)
		end

	http_content_range: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_content_range (Current, <<l_protection.xss>>)
		end

	http_content_encoding: detachable READABLE_STRING_8
			-- <Precursor>
		local
			l_protection: WSF_PROTECTIONS
		do
			Result := custom_http_content_encoding (Current, <<l_protection.xss>>)
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
