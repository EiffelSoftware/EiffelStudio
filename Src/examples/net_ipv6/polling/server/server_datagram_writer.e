indexing

	description:
		"Command executed by the polling server when the socket%
		%is ready for writing."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SERVER_DATAGRAM_WRITER

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
			i: INTEGER
		do
				-- Make packet with 10 characters `a' in successive positions
			create sen_pack.make (10)
			from i := 0 until i > 9 loop
				sen_pack.put_element ('a', i)
				i := i + 1
			end
			sen_pack.set_packet_number (2)
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


end -- SERVER_DATAGRAM_WRITER

