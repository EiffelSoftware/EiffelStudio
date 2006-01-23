indexing

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

	make (a_path : STRING) is
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

	cleanup is
			-- Clean close
		do
			in.close;
			if in.address /= Void then
				in.unlink
			end
		end;

	receive is
			-- Receive activity of server
		do
			in.accept;
			outflow ?= in.accepted;
			received ?= outflow.retrieved
		end;
	
	close is
			-- Close socket.
		do
			if outflow /= Void and then not outflow.is_closed then
				outflow.close
			end
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




end -- class UNIX_SERVER

