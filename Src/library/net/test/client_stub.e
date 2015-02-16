note
	description: "A client stub."
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT_STUB

create
	make

feature {NONE} -- Initialization

	make (a_message: detachable separate STRING; a_port: INTEGER)
			-- Initialization for `Current'.
		local
			l_message: separate STRING
		do
			if a_message /= Void then
				l_message := a_message
			else
				l_message := default_message
			end

			create message.make_from_separate (l_message)
			port := a_port
		end

feature -- Access

	default_message: STRING = "a_default_message"

	message: STRING

	host: STRING = "127.0.0.1"

	port: INTEGER

feature -- Basic operations

	send_message
			-- Send a message
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			create l_socket.make_client_by_port (port, host)
			l_socket.connect
			l_socket.put_string (message)
			l_socket.close
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
