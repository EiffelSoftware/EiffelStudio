indexing

	description:
		"A unix socket stream.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class UNIX_SOCKET_STREAM

	inherit

		UNIX_SOCKET

creation {UNIX_SOCKET_STREAM}

	create_from_descriptor

creation

	make

feature 	-- Initialization

	make is
			-- Make a unix socket stream
		do
			family := af_unix;
			type := sock_stream;			
			make_socket;
		end;

end

--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

