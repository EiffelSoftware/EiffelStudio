indexing

	description:
		"Command executed by the polling client when the socket%
		%is ready for writing.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CLIENT_DATAGRAM_WRITER

inherit

	POLL_COMMAND
		redefine
			active_medium
		end

create

	make

feature

	active_medium: NETWORK_DATAGRAM_SOCKET

	execute (arg: ANY) is
		local
			sen_pack: DATAGRAM_PACKET
			char: CHARACTER
		do
				-- Make packet with characters `a' to `j' in successive positions
			create sen_pack.make (10)
			from char := 'a' until char > 'j' loop
				sen_pack.put_element (char, char |-| 'a')
				char := char.next
			end
			sen_pack.set_packet_number (1)
			active_medium.send (sen_pack, 0)
		end

end -- class CLIENT_DATAGRAM_WRITER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

