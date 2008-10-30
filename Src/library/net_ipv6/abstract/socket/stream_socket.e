indexing

        description:
                "Connexion oriented socket."
	legal: "See notice at end of class.";

        status: "See notice at end of class.";
        date: "$Date$";
        revision: "$Revision$"

deferred class

	STREAM_SOCKET

inherit

	SOCKET
		redefine
			support_storable
		end

feature -- Status report

	support_storable: BOOLEAN is True
			-- Can medium be used to store an Eiffel structure?

feature

	listen (queue: INTEGER) is
			-- Listen on socket for at most `queue' connections.
		require
			socket_exists: exists
		deferred
		end

	accepted: like Current
			-- Last accepted socket.

	accept is
			-- Accept a new connection on listen socket.
			-- Accepted service socket available in `accepted'.
		require
			socket_exists: exists
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




end -- class STREAM_SOCKET

