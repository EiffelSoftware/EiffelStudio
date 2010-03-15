note

	description:
		"A server for a Unix socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	UNIX_SERVER

inherit

	SERVER
		redefine
			in
		end

feature -- Access

	in: UNIX_STREAM_SOCKET;
			-- Receive socket

	make (a_path : STRING)
			-- Create an unix socket server bound to address
			-- `a_path'.
		do
			create in.make_server (a_path);
			if queued = 0 then
				in.listen (5)
			else
				in.listen (queued)
			end
		end;

	cleanup
			-- Clean close
		do
			in.close;
			if in.address /= Void then
				in.unlink
			end
		end;

	receive
			-- Receive activity of server
		do
			in.accept;
			outflow ?= in.accepted;
			if attached outflow as l_outflow then
				received ?= l_outflow.retrieved
			else
				received := Void
			end
		end;

	close
			-- Close socket.
		do
			if attached outflow as l_outflow and then not l_outflow.is_closed then
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




end -- class UNIX_SERVER

