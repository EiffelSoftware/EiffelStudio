note
	description: "Summary description for {WGI_META_NAMES}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_META_NAMES

feature -- Access

	request_uri: STRING = "REQUEST_URI"

	request_method: STRING = "REQUEST_METHOD"

	query_string: STRING = "QUERY_STRING"

	content_type: STRING = "CONTENT_TYPE"

	content_length: STRING = "CONTENT_LENGTH"

	path_info: STRING = "PATH_INFO"

	path_translated: STRING = "PATH_TRANSLATED"

	http_user_agent: STRING = "HTTP_USER_AGENT"

	http_authorization: STRING = "HTTP_AUTHORIZATION"

	http_host: STRING = "HTTP_HOST"

	http_cookie: STRING = "HTTP_COOKIE"

	http_from: STRING = "HTTP_FROM"

	http_accept: STRING = "HTTP_ACCEPT"

	http_accept_charset: STRING = "HTTP_ACCEPT_CHARSET"

	http_accept_encoding: STRING = "HTTP_ACCEPT_ENCODING"

	http_accept_language: STRING = "HTTP_ACCEPT_LANGUAGE"

	http_connection: STRING = "HTTP_CONNECTION"

	http_expect: STRING = "HTTP_EXPECT"

	http_referer: STRING = "HTTP_REFERER"

	http_transfer_encoding: STRING = "HTTP_TRANSFER_ENCODING"

	http_access_control_request_headers: STRING = "HTTP_ACCESS_CONTROL_REQUEST_HEADERS"

	http_if_match: STRING = "HTTP_IF_MATCH"
	
	gateway_interface: STRING = "GATEWAY_INTERFACE"

	auth_type: STRING = "AUTH_TYPE"

	remote_host: STRING = "REMOTE_HOST"

	remote_addr: STRING = "REMOTE_ADDR"

	remote_ident: STRING = "REMOTE_IDENT"

	remote_user: STRING = "REMOTE_USER"

	script_name: STRING = "SCRIPT_NAME"

	server_name: STRING = "SERVER_NAME"

	server_port: STRING = "SERVER_PORT"

	server_protocol: STRING = "SERVER_PROTOCOL"

	server_software: STRING = "SERVER_SOFTWARE"

feature -- Extra names

	request_time: STRING = "REQUEST_TIME"

	self: STRING = "SELF"

	orig_path_info: STRING = "ORIG_PATH_INFO"

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
