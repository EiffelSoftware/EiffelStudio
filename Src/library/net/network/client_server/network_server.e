indexing

	description:
		"A server for a network socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class INET_SERVER

inherit
	SERVER
		redefine
			in, make
		end

feature -- Access

	in: NETWORK_SOCKET_STREAM
		-- Receive socket.

	make (a : SOCKET_ADDRESS_NETWORK; queueing : INTEGER) is
		do
			!!in.make
			in.set_address (a);
			in.bind
			in.listen (queueing)
		end

	close is
		do
			in.close
		end

	receive is
		do
			outflow ?= in.accept;
			received ?= socket_retrieved (outflow);
		end;
	
	clean_up is
		do
		end;



end -- class INET_SERVER

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
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
