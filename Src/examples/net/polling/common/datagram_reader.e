indexing

	description:
		"Command executed by both the polling client and the polling%
		%server when data is available for reading on the socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DATAGRAM_READER

inherit

	POLL_COMMAND
		redefine
			active_medium
		end

creation

	make

feature

	active_medium: NETWORK_DATAGRAM_SOCKET

	execute (arg: ANY) is
		local
			rec_pack: DATAGRAM_PACKET
			i: INTEGER
		do
			rec_pack := active_medium.received (10, 0)
			io.putint (rec_pack.packet_number)
			io.new_line
			from i := 0 until i > 9 loop
				io.putchar (rec_pack.element (i))
				i := i + 1
			end
			io.new_line
		end

end -- class DATAGRAM_READER

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

