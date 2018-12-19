note
	description: "SSL enabled network socket."
	legal: "See notice at end of class"
	status: "See notice at end of class"
	date:	 "$Date$"
	revision: "$Revision$"

deferred class
	SSL_NETWORK_SOCKET

inherit
	NETWORK_SOCKET
		undefine
			error_number
		redefine
			connect, shutdown
		end

	SSL_SOCKET
		undefine
			send, put_character, putchar, put_string, putstring,
			put_integer, putint, put_integer_32,
			put_integer_8, put_integer_16, put_integer_64,
			put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
			put_boolean, putbool,
			put_real, putreal, put_double, putdouble, put_managed_pointer,
			set_blocking, set_non_blocking,
			exists, address_type, is_valid_peer_address, is_valid_family
		redefine
			shutdown
		end

feature

	connect
			-- Connect the socket, and setup the SSL context
		do
				--| Connect the socket, from NETWORK_SOCKET
			Precursor

			if is_connected then
					--| The NETWORK_SOCKET is connected, we can setup the SSL context
				initialize_client_ssl
			end
		end

feature {NONE} -- Implementation

	shutdown
			-- Send SSL/TLS close_notify
		do
			if
				attached context as l_context and then
				attached l_context.last_ssl as l_ssl
			then
				l_ssl.shutdown
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
