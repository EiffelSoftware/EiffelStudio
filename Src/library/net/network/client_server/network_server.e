note

	description:
		"A server for a network socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class NETWORK_SERVER inherit

	SERVER
		redefine
			in
		end

feature -- Access

	in: NETWORK_STREAM_SOCKET;
			-- Receive socket.

	make (a_port: INTEGER)
			-- Make a network server listening to `a_port'.
		require
			valid_port: a_port >= 0
		do
			create in.make_server_by_port (a_port);
			if queued = 0 then
				in.listen (5)
			else
				in.listen (queued)
			end
		end;

	cleanup
			-- Clean close of server.
		do
			if not in.is_closed then
				in.close
			end
		end;

	receive
			-- Receive activity of server.
		do
			in.accept
			if attached {like outflow} in.accepted as l_outflow then
				outflow := l_outflow
				if attached {like received} l_outflow.retrieved as l_received then
					received := l_received
				else
					received := Void
				end
			else
				outflow := Void
				received := Void
			end
		end;

	close
			-- Close server socket.
		local
			l_outflow: like outflow
		do
			l_outflow := outflow
			if l_outflow /= Void and then not l_outflow.is_closed then
				l_outflow.close
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NETWORK_SERVER

