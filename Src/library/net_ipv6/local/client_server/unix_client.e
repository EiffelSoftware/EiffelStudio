indexing

	description:
		"A client with Unix socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_CLIENT

inherit

	CLIENT
		redefine
			in_out
		end

feature -- Access

	in_out: UNIX_STREAM_SOCKET
			-- Receive and send sockets.

feature -- Initialization

	make (a : STRING) is
			-- Create an unix socket client.
		require
			a_valid_name: a /= Void and then not a.is_empty
		do
			create in_out.make_client (a);
			in_out.connect
		end

feature -- Status setting

	cleanup is
			-- Clean close
		do
			in_out.close;
			if in_out.address /= void then
				in_out.unlink
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




end -- class UNIX_CLIENT

