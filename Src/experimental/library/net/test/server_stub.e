note
	description: "A server stub."
	date: "$Date$"
	revision: "$Revision$"

class
	SERVER_STUB

create
	make

feature -- Access

	port: INTEGER

	socket: NETWORK_STREAM_SOCKET

feature {NONE} -- Initialization

	make (a_port: INTEGER)
			-- Initialization for `Current'.
		do
			create socket.make_server_by_port (a_port)
			port := socket.port

				-- Disable lingering in order to re-execute tests.
			socket.set_linger_off

			socket.listen(1)
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
