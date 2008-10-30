indexing

	description:
		"Command executed by the polling client when the socket%
		%is ready for writing."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CLIENT_DATAGRAM_WRITER

