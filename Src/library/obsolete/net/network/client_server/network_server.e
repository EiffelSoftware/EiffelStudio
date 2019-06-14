note

	description: "A server for a network socket."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class NETWORK_SERVER inherit

	SERVER
		redefine
			in, resend
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
			in.close
		end;

	receive
			-- Receive activity of server.
		do
			in.accept
			outflow := {like outflow} / in.accepted
			received := {like received} / outflow.retrieved
		end

	resend (msg: ANY)
			-- Send back message `msg'.
		do
			outflow.independent_store (msg)
		end

	close
			-- Close server socket.
		do
			if outflow /= Void and then not outflow.is_closed then
				outflow.close
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
