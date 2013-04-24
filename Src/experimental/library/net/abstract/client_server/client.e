note

	description:
		"A client for a socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class CLIENT inherit

	SOCKET_RESOURCES

feature -- Access

	in_out: SOCKET;
			-- Receive and send socket.

	received: detachable ANY;
			-- message received on `in'

	cleanup
			-- Cleanup client.
		deferred
		end;

	send (msg : ANY)
			-- Send `msg'.
		do
			in_out.independent_store (msg)
		end;

	receive
			-- Receive message.
		do
			if attached {like received} in_out.retrieved as l_received then
				received := l_received
			else
				received := Void
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class CLIENT

