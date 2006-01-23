indexing

	description:
		"Command executed by both the polling client and the polling%
		%server when data is available for reading on the socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class DATAGRAM_READER

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


end -- class DATAGRAM_READER

