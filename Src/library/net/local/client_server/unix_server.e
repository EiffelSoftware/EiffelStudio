indexing

	description:
		"A server for a Unix socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class UNIX_SERVER

inherit

	SERVER
		redefine
			in
		end

feature -- Access

	in: UNIX_STREAM_SOCKET
		-- Receive socket.

	make (a : STRING) is
		do
			!!in.make_server (a)
			if queued = 0 then
				in.listen (5)
			else
				in.listen (queued)
			end
		end

	cleanup is
		do
			in.close
			if in.address /= Void then
				in.unlink
			end
		end

	receive is
		do
			in.accept
			outflow ?= in.accepted
			received ?= retrieved (outflow)
		end
	
	close is
		do
			if outflow /= Void and then not outflow.is_closed then
				outflow.close
			end
		end

end -- class UNIX_SERVER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

