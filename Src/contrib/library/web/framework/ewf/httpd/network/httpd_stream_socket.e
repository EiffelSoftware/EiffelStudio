note
	description: "[
			Socket for HTTPD networking.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_STREAM_SOCKET

inherit
	HTTP_STREAM_SOCKET

create
	make, make_empty,
	make_client_by_port, make_client_by_address_and_port,
	make_server_by_port, make_server_by_address_and_port, make_loopback_server_by_port

create {NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
