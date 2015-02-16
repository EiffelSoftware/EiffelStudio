note
	description: "SCOOP helper features for the stub classes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCOOP_UTILS

inherit

	ANY
		undefine
			default_create
		end

feature -- Client stub helpers

	client_stub_send_message (stub: separate CLIENT_STUB)
		do
			stub.send_message
		end

feature -- Server stub helpers

	server_stub_port (stub: separate SERVER_STUB): INTEGER
		do
			Result := stub.port
		end

	server_stub_accept (stub: separate SERVER_STUB)
		do
			stub.socket.accept
		end

	server_stub_close (stub: separate SERVER_STUB)
		do
			stub.socket.close
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
