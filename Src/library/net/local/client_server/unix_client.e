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

end -- class UNIX_CLIENT

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

