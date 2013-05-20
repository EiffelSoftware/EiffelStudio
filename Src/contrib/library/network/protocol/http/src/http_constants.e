note
	description: "[
			Constants class providing most common constants used in HTTP communication
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CONSTANTS

inherit
	HTTP_MIME_TYPES

	HTTP_HEADER_NAMES

	HTTP_STATUS_CODE

	HTTP_REQUEST_METHODS

feature -- Ports

	default_http_port: INTEGER = 80
	default_https_port: INTEGER = 443

feature -- Server, header

	http_version_1_0: STRING = "HTTP/1.0"
	http_version_1_1: STRING = "HTTP/1.1"

feature -- Misc

	crlf: STRING = "%R%N"

	default_bufsize: INTEGER = 16384 --| 16K

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
