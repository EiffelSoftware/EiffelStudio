indexing

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

	received : ANY;
			-- message received on `in'

	cleanup is
			-- Cleanup client.
		deferred
		end;

	send (msg : ANY) is
			-- Send `msg'.
		do
			in_out.independent_store (msg)
		end;

	receive is
			-- Receive message.
		do
			received ?= in_out.retrieved
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




end -- class CLIENT

