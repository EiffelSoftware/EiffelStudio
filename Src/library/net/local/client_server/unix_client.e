indexing

	description:
		"A client with Unix socket.";

	status: "See notice at end of class";
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
			a_valid_name: a /= Void and then not a.empty
		do
			!!in_out.make_client (a);
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

end -- class UNIX_CLIENT



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
