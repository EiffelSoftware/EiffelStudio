indexing

	description:
		"A server for a socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class SERVER inherit

	SOCKET_RESOURCES

feature -- Access

	in : SOCKET;
			-- Listen socket

	outflow : like in;
			-- Service socket

	received: ANY;
			-- Last message from socket

	execute is
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

	resend (msg: ANY) is
			-- Resend `msg'.
		do
			outflow.independent_store (msg)
		end;

	set_queued (n: INTEGER) is
			-- Set `queued' to `n'.
		require
			valid_queue_number: n > 0 and n < 6
		do
			queued := n
		ensure 
			assigned_queued: queued = n
		end;

	cleanup is
			-- Cleanup server.
		deferred
		end;

	close is
			-- Close sockets.
		deferred
		end;

	process_message is 
			-- Process the received message.
		deferred
		end;

	respond is
			-- Respond to client.
		do
		end;

	receive is
			-- Receive message.
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SERVER

