note
	description: "[
			Status code constants pertaining to the HTTP protocol
			See http://en.wikipedia.org/wiki/List_of_HTTP_status_codes
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_STATUS_CODE_MESSAGES

inherit
	HTTP_STATUS_CODE

feature -- Status report

	is_valid_http_status_code (v: INTEGER): BOOLEAN
			-- Is the given value a valid http status code?
		do
			Result := v >= continue and v <= user_access_denied
		end

feature -- Status messages

	http_status_code_message (a_code: INTEGER): detachable STRING
			-- Header message related to HTTP status code `a_code'
		do
			inspect a_code
			when continue then
				Result := "Continue"
			when switching_protocols then
				Result := "Switching Protocols"
			when processing then
				Result := "Processing"
			when ok then
				Result := "OK"
			when created then
				Result := "Created"
			when accepted then
				Result := "Accepted"
			when nonauthoritative_info then
				Result := "Non-Authoritative Information"
			when no_content then
				Result := "No Content"
			when reset_content then
				Result := "Reset Content"
			when partial_content then
				Result := "Partial Content"
			when multistatus then
				Result := "Multi-Status"
			when multiple_choices then
				Result := "Multiple Choices"
			when moved_permanently then
				Result := "Moved Permanently"
			when found then
				Result := "Found"
			when see_other then
				Result := "See Other"
			when not_modified then
				Result := "Not Modified"
			when use_proxy then
				Result := "Use Proxy"
			when switch_proxy then
				Result := "Switch Proxy"
			when temp_redirect then
				Result := "Temporary Redirect"
			when bad_request then
				Result := "Bad Request"
			when unauthorized then
				Result := "Unauthorized"
			when payment_required then
				Result := "Payment Required"
			when forbidden then
				Result := "Forbidden"
			when not_found then
				Result := "Not Found"
			when method_not_allowed then
				Result := "Method Not Allowed"
			when not_acceptable then
				Result := "Not Acceptable"
			when proxy_auth_required then
				Result := "Proxy Authentication Required"
			when request_timeout then
				Result := "Request Timeout"
			when conflict then
				Result := "Conflict"
			when gone then
				Result := "Gone"
			when length_required then
				Result := "Length Required"
			when precondition_failed then
				Result := "Precondition Failed"
			when request_entity_too_large then
				Result := "Request Entity Too Large"
			when request_uri_too_long then
				Result := "Request-URI Too Long"
			when unsupported_media_type then
				Result := "Unsupported Media Type"
			when request_range_not_satisfiable then
				Result := "Requested Range Not Satisfiable"
			when expectation_failed then
				Result := "Expectation Failed"
			when teapot then
				Result := "I'm a teapot"
			when too_many_connections then
				Result := "There are too many connections from your internet address"
			when unprocessable_entity then
				Result := "Unprocessable Entity"
			when locked then
				Result := "Locked"
			when failed_dependency then
				Result := "Failed Dependency"
			when unordered_collection then
				Result := "Unordered Collection"
			when upgrade_required then
				Result := "Upgrade Required"
			when retry_with then
				Result := "Retry With"
			when blocked_parental then
				Result := "Blocked by Windows Parental Controls"
			when internal_server_error then
				Result := "Internal Server Error"
			when not_implemented then
				Result := "Not Implemented"
			when bad_gateway then
				Result := "Bad Gateway"
			when service_unavailable then
				Result := "Service Unavailable"
			when gateway_timeout then
				Result := "Gateway Timeout"
			when http_version_not_supported then
				Result := "HTTP Version Not Supported"
			when variant_also_negotiates then
				Result := "Variant Also Negotiates"
			when insufficient_storage then
				Result := "Insufficient Storage"
			when bandwidth_limit_exceeded then
				Result := "Bandwidth Limit Exceeded"
			when not_extended then
				Result := "Not Extended"
			when user_access_denied then
				Result := "User access denied"
			else
				Result := Void
			end
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
