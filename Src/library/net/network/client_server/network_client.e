note

	description:
		"A client for a network socket."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NETWORK_CLIENT inherit

	CLIENT
		redefine
			in_out, send
		end

create
	make

feature -- Access

	in_out: NETWORK_STREAM_SOCKET;
			-- Receive and send sockets.

	make (a_peer_port: INTEGER; a_peer_name: STRING_8)
			-- Make client with port `a_peer_port' and host `a_peer_name'.
		require
			a_valid_port: a_peer_port > 0;
			a_valid_name: a_peer_name /= Void and then not a_peer_name.is_empty
		do
			create in_out.make_client_by_port (a_peer_port, a_peer_name);
			in_out.connect
		end;

	cleanup
			-- Shut down client.
		do
			if not in_out.is_closed then
				in_out.close
			end
		end;

	send (msg : ANY)
			-- Send `msg' to server.
		do
			in_out.independent_store (msg)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
