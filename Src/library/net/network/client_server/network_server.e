indexing

	description:
		"A server for a network socket.";

	status: "See notice at end of class";
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

	make (a_port: INTEGER) is
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

	cleanup is
			-- Clean close of server.
		do
			in.close
		end;

	receive is
			-- Receive activity of server.
		do
			in.accept;
			outflow ?= in.accepted;
			received ?= outflow.retrieved
		end;

	resend (msg: ANY) is
			-- Send back message `msg'.
		do
			outflow.independent_store (msg)
		end;
	
	close is
			-- Close server socket.
		do
			if outflow /= Void and then not outflow.is_closed then
				outflow.close
			end
		end

end -- class NETWORK_SERVER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

