indexing

	description:
		"Command executed by the polling server when the socket%
		%is ready for writing.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SERVER_DATAGRAM_WRITER

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
			sen_pack: DATAGRAM_PACKET
			i: INTEGER
		do
				-- Make packet with 10 characters `a' in successive positions
			!!sen_pack.make (10)
			from i := 0 until i > 9 loop
				sen_pack.put_element ('a', i)
				i := i + 1
			end
			sen_pack.set_packet_number (2)
			active_medium.send (sen_pack, 0)
		end

end -- SERVER_DATAGRAM_WRITER

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

