note

	description:
		"A server for a socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class SERVER inherit

	SOCKET_RESOURCES

feature -- Access

	in: SOCKET;
			-- Listen socket

	outflow: detachable like in;
			-- Service socket

	received: detachable ANY;
			-- Last message from socket

	execute
			-- Execute transfer loop.
		do
			from
			until
				False
			loop
				receive;
				process_message;
				respond;
				close
			end
		end;

	queued: INTEGER;

	resend (msg: ANY)
			-- Resend `msg'.
		do
			if attached outflow as l_outflow then
				l_outflow.independent_store (msg)
			end
		end;

	set_queued (n: INTEGER)
			-- Set `queued' to `n'.
		require
			valid_queue_number: n > 0 and n < 6
		do
			queued := n
		ensure
			assigned_queued: queued = n
		end;

	cleanup
			-- Cleanup server.
		deferred
		end;

	close
			-- Close sockets.
		deferred
		end;

	process_message
			-- Process the received message.
		deferred
		end;

	respond
			-- Respond to client.
		do
		end;

	receive
			-- Receive message.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class SERVER

