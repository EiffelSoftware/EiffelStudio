note
	description: "Socket connection information, used for peristent connection implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	NET_HTTP_CLIENT_CONNECTION

create
	make

feature {NONE} -- Initialization

	make (a_socket: HTTP_STREAM_SOCKET; a_host: READABLE_STRING_GENERAL; a_port: INTEGER)
		do
			socket := a_socket
			host := a_host
			port := a_port
		end

feature -- Access

	socket: HTTP_STREAM_SOCKET
			-- Persistent connection socket.

	host: READABLE_STRING_GENERAL
			-- Host used for this connection.

	port: INTEGER
		-- Port used for this connection.

feature -- Status report

	is_reusable (a_host: READABLE_STRING_GENERAL; a_port: INTEGER): BOOLEAN
			-- Is Current connection reusable for new connection `a_host:a_port'?
		do
			if a_host.same_string (host) and port = a_port then
				Result := socket.is_connected
			end
		end

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
