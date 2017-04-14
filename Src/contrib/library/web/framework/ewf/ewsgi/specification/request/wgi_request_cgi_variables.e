note
	description: "[
			Object containing the CGI variable for a specific WGI request.
			This is mainly used for debugging purpose.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_REQUEST_CGI_VARIABLES

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (req: WGI_REQUEST)
			-- Initialize Current from `req'.
		local
			utf: UTF_CONVERTER
		do
			content_length := req.content_length
			if attached req.content_type as ct then
				content_type := ct.string
			else
				content_type := Void
			end
			auth_type := req.auth_type
			gateway_interface := req.gateway_interface
			path_info := req.path_info
			path_translated := req.path_translated
			query_string := req.query_string
			remote_addr := req.remote_addr
			remote_host := req.remote_host
			remote_ident := req.remote_ident
			remote_user := req.remote_user
			request_method := req.request_method
			script_name := req.script_name
			server_name := req.server_name
			server_port := req.server_port
			server_protocol := req.server_protocol
			server_software := req.server_software

			create http_meta_variables.make (0)
			across
				req.meta_variables as ic
			loop
				if ic.key.starts_with ("HTTP_") then
					if ic.key.is_valid_as_string_8 then
						http_meta_variables.force (ic.item, ic.key.as_string_8)
					else
						http_meta_variables.force (ic.item, utf.escaped_utf_32_string_to_utf_8_string_8 (ic.key))
					end
				end
			end
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make (1_024)
			append_variable_to_debug_output ("AUTH_TYPE", auth_type, Result)
			append_variable_to_debug_output ("CONTENT_LENGTH", content_length, Result)
			append_variable_to_debug_output ("CONTENT_TYPE", content_type, Result)
			append_required_variable_to_debug_output ("GATEWAY_INTERFACE", gateway_interface, Result)
			across
				http_meta_variables as ic
			loop
				append_variable_to_debug_output (ic.key, ic.item, Result)
			end
			append_required_variable_to_debug_output ("PATH_INFO", path_info, Result)
			append_variable_to_debug_output ("PATH_TRANSLATED", path_translated, Result)
			append_required_variable_to_debug_output ("QUERY_STRING", query_string, Result)
			append_required_variable_to_debug_output ("REMOTE_ADDR", remote_addr, Result)
			append_variable_to_debug_output ("REMOTE_HOST", remote_host, Result)
			append_variable_to_debug_output ("REMOTE_IDENT", remote_ident, Result)
			append_variable_to_debug_output ("REMOTE_USER", remote_user, Result)
			append_required_variable_to_debug_output ("REQUEST_METHOD", request_method, Result)
			append_variable_to_debug_output ("SCRIPT_NAME", script_name, Result)
			append_required_variable_to_debug_output ("SERVER_NAME", server_name, Result)
			append_variable_to_debug_output ("SERVER_PORT", server_port.out, Result)
			append_variable_to_debug_output ("SERVER_PROTOCOL", request_method, Result)
			append_variable_to_debug_output ("SERVER_SOFTWARE", server_software, Result)
		end

feature {NONE} -- Implementation

	append_required_variable_to_debug_output (a_name: READABLE_STRING_8; a_value: READABLE_STRING_GENERAL; a_output: STRING_32)
		require
			a_value_not_is_empty: a_value /= Void
		do
			a_output.append_string_general (a_name)
			a_output.append_character ('=')
			a_output.append_string_general (a_value)
			a_output.append_character ('%N')
		end

	append_variable_to_debug_output (a_name: READABLE_STRING_8; a_value: detachable READABLE_STRING_GENERAL; a_output: STRING_32)
		do
			if a_value /= Void then
				a_output.append_string_general (a_name)
				a_output.append_character ('=')
				a_output.append_string_general (a_value)
				a_output.append_character ('%N')
			end
		end

feature -- Access: meta variable

	auth_type: detachable READABLE_STRING_8
			-- The variable is specific to requests made with HTTP.
			--
			-- If the script URI would require access authentication for external
			-- access, then this variable is found from the `auth-scheme' token
			-- in the request, otherwise NULL.
			--
			-- 	auth-scheme = "Basic" | token
			--
			-- HTTP access authentication schemes are described in section 11 of
			-- the HTTP/1.0 specification [3]. The auth-scheme is not
			-- case-sensitive.	

	content_length: detachable READABLE_STRING_8
			-- The size of the entity attached to the request, if any, in decimal
			-- number of octets. If no data is attached, then NULL. The syntax is
			-- the same as the HTTP Content-Length header (section 10, HTTP/1.0
			-- specification [3]).
			--
			-- 	 CONTENT_LENGTH = "" | [ 1*digit ]

	content_type: detachable READABLE_STRING_8
			-- The Internet Media Type [9] of the attached entity. The syntax is
			-- the same as the HTTP Content-Type header.
			--
			--  CONTENT_TYPE = "" | media-type
			--  media-type   = type "/" subtype *( ";" parameter)
			--  type         = token
			--  subtype      = token
			--  parameter    = attribute "=" value
			--  attribute    = token
			--  value        = token | quoted-string
			--
			-- The type, subtype and parameter attribute names are not
			-- case-sensitive. Parameter values may be case sensitive.  Media
			-- types and their use in HTTP are described section 3.6 of the
			-- HTTP/1.0 specification [3]. Example:
			--
			-- 	application/x-www-form-urlencoded
			--
			-- There is no default value for this variable. If and only if it is
			-- unset, then the script may attempt to determine the media type
			-- from the data received. If the type remains unknown, then
			-- application/octet-stream should be assumed.	

	gateway_interface: READABLE_STRING_8
			-- The version of the CGI specification to which this server
			-- complies.  Syntax:
			--
			--  GATEWAY_INTERFACE =  "CGI" "/" 1*digit "." 1*digit
			--
			-- Note that the major and minor numbers are treated as separate
			-- integers and that each may be incremented higher than a single
			-- digit.  Thus CGI/2.4 is a lower version than CGI/2.13 which in
			-- turn is lower than CGI/12.3. Leading zeros must be ignored by
			-- scripts and should never be generated by servers.

	http_meta_variables: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			-- These variables are specific to requests made with HTTP.
			-- Interpretation of these variables may depend on the value of
			-- SERVER_PROTOCOL.
			--
			-- Environment variables with names beginning with "HTTP_" contain
			-- header data read from the client, if the protocol used was HTTP.
			-- The HTTP header name is converted to upper case, has all
			-- occurrences of "-" replaced with "_" and has "HTTP_" prepended to
			-- give the environment variable name. The header data may be
			-- presented as sent by the client, or may be rewritten in ways which
			-- do not change its semantics. If multiple headers with the same
			-- field-name are received then they must be rewritten as a single
			-- header having the same semantics. Similarly, a header that is
			-- received on more than one line must be merged onto a single line.
			-- The server must, if necessary, change the representation of the
			-- data (for example, the character set) to be appropriate for a CGI
			-- environment variable.
			--
			-- The server is not required to create environment variables for all
			-- the headers that it receives. In particular, it may remove any
			-- headers carrying authentication information, such as
			-- "Authorization"; it may remove headers whose value is available to
			-- the script via other variables, such as "Content-Length" and
			-- "Content-Type".

	path_info: READABLE_STRING_GENERAL
			-- A path to be interpreted by the CGI script. It identifies the
			-- resource or sub-resource to be returned by the CGI script. The
			-- syntax and semantics are similar to a decoded HTTP URL `hpath'
			-- token (defined in RFC 1738 [4]), with the exception that a
			-- PATH_INFO of "/" represents a single void path segment. Otherwise,
			-- the leading "/" character is not part of the path.
			--
			--  PATH_INFO = "" | "/" path
			--  path      = segment *( "/" segment )
			--  segment   = *pchar
			--  pchar     = <any CHAR except "/">
			--
			-- The PATH_INFO string is the trailing part of the <path> component
			-- of the script URI that follows the SCRIPT_NAME part of the path.	

	path_translated: detachable READABLE_STRING_GENERAL
			-- The OS path to the file that the server would attempt to access
			-- were the client to request the absolute URL containing the path
			-- PATH_INFO.  i.e for a request of
			--
			--  protocol "://" SERVER_NAME ":" SERVER_PORT enc-path-info
			--
			-- where `enc-path-info' is a URL-encoded version of PATH_INFO. If
			-- PATH_INFO is NULL then PATH_TRANSLATED is set to NULL.
			--
			--  PATH_TRANSLATED = *CHAR
			--
			-- PATH_TRANSLATED need not be supported by the server. The server
			-- may choose to set PATH_TRANSLATED to NULL for reasons of security,
			-- or because the path would not be interpretable by a CGI script;
			-- such as the object it represented was internal to the server and
			-- not visible in the file-system; or for any other reason.
			--
			-- The algorithm the server uses to derive PATH_TRANSLATED is
			-- obviously implementation defined; CGI scripts which use this
			-- variable may suffer limited portability.	

	query_string: READABLE_STRING_GENERAL
			-- A URL-encoded search string; the <query> part of the script URI.
			--
			--  QUERY_STRING = query-string
			--  query-string = *qchar
			--  qchar        = unreserved | escape | reserved
			--  unreserved   = alpha | digit | safe | extra
			--  reserved     = ";" | "/" | "?" | ":" | "@" | "&" | "="
			--  safe         = "$" | "-" | "_" | "." | "+"
			--  extra        = "!" | "*" | "'" | "(" | ")" | ","
			--  escape       = "%" hex hex
			--  hex          = digit | "A" | "B" | "C" | "D" | "E" | "F" | "a"
			-- 			  | "b" | "c" | "d" | "e" | "f"
			--
			-- The URL syntax for a search string is described in RFC 1738 [4].	

	remote_addr: READABLE_STRING_GENERAL
			-- The IP address of the agent sending the request to the server. Not
			-- necessarily that of the client.
			--
			--  REMOTE_ADDR = hostnumber
			--  hostnumber  = digits "." digits "." digits "." digits
			--  digits      = 1*digit	

	remote_host: detachable READABLE_STRING_GENERAL
			-- The fully qualified domain name of the agent sending the request
			-- to the server, if available, otherwise NULL. Not necessarily that
			-- of the client. Fully qualified domain names take the form as
			-- described in section 3.5 of RFC 1034 [8] and section 2.1 of RFC
			-- 1123 [5]; a sequence of domain labels separated by ".", each
			-- domain label starting and ending with an alphanumerical character
			-- and possibly also containing "-" characters. The rightmost domain
			-- label will never start with a digit. Domain names are not case
			-- sensitive.
			--
			--  REMOTE_HOST   = "" | hostname
			--  hostname      = *( domainlabel ".") toplabel
			--  domainlabel   = alphadigit [ *alphahypdigit alphadigit ]
			--  toplabel      = alpha [ *alphahypdigit alphadigit ]
			--  alphahypdigit = alphadigit | "-"
			--  alphadigit    = alpha | digit	

	remote_ident: detachable READABLE_STRING_GENERAL
			-- The identity information reported about the connection by a RFC
			-- 931 [10] request to the remote agent, if available. The server may
			-- choose not to support this feature, or not to request the data for
			-- efficiency reasons.
			--
			--  REMOTE_IDENT = *CHAR
			--
			-- The data returned is not appropriate for use as authentication
			-- information.	

	remote_user: detachable READABLE_STRING_GENERAL
			-- This variable is specific to requests made with HTTP.
			--
			-- If AUTH_TYPE is "Basic", then the user-ID sent by the client. If
			-- AUTH_TYPE is NULL, then NULL, otherwise undefined.
			--
			--  userid      = token	

	request_method: READABLE_STRING_GENERAL
			-- This variable is specific to requests made with HTTP.
			--
			-- The method with which the request was made, as described in
			-- section 5.1.1 of the HTTP/1.0 specification [3].
			--
			--  http-method      = "GET" | "HEAD" | "POST" | extension-method
			--  extension-method = token
			--
			-- The method is case sensitive.	

	script_name: READABLE_STRING_GENERAL
			-- A URL path that could identify the CGI script (rather then the
			-- particular CGI output). The syntax and semantics are identical to
			-- a decoded HTTP URL `hpath' token [4].
			--
			--  SCRIPT_NAME = "" | "/" [ path ]
			--
			-- The leading "/" is not part of the path. It is optional if the
			-- path is NULL.
			--
			-- The SCRIPT_NAME string is some leading part of the <path>
			-- component of the script URI derived in some implementation defined
			-- manner.	

	server_name: READABLE_STRING_GENERAL
			-- The name for this server, as used in the <host> part of the script
			-- URI. Thus either a fully qualified domain name, or an IP address.
			--
			--  SERVER_NAME = hostname | hostnumber	

	server_port: INTEGER
			-- The port on which this request was received, as used in the <port>
			-- part of the script URI.
			--
			--  SERVER_PORT = 1*digit	

	server_protocol: READABLE_STRING_GENERAL
			-- The name and revision of the information protocol this request
			-- came in with.
			--
			--  SERVER_PROTOCOL   = HTTP-Version | extension-version
			--  HTTP-Version      = "HTTP" "/" 1*digit "." 1*digit
			--  extension-version = protocol "/" 1*digit "." 1*digit
			--  protocol          = 1*( alpha | digit | "+" | "-" | "." )
			--
			-- `protocol' is a version of the <scheme> part of the script URI,
			-- and is not case sensitive. By convention, `protocol' is in upper
			-- case.	

	server_software: READABLE_STRING_GENERAL
			-- The name and version of the information server software answering
			-- the request (and running the gateway).
			--
			--  SERVER_SOFTWARE = *CHAR	

invariant
	request_method_set: not request_method.is_empty

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
