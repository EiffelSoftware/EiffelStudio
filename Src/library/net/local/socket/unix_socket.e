indexing

	description:
		"A unix socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class UNIX_SOCKET

	inherit

		SOCKET
			redefine
				address, name
		end;

creation {UNIX_SOCKET}

	create_from_descriptor

feature 	-- Status Report


	address: SOCKET_ADDRESS_UNIX;
			-- Local address of socket

	name: STRING is
			-- name of the socket
		require else
			valid_address: address /= Void;
		do
			!! Result.make (10);
			Result.append (address.path);
		end;

feature 	-- Status setting

	unlink is
			-- Remove associate name from file system
		require else
			name_address: address /= void;
		local
			ext: ANY;
		do
			ext := name.to_c;
			c_unlink ($ext);
		end;

end 	-- class UNIX_SOCKET

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


