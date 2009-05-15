note

	description:
		"Server root-class for the same_mach example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OUR_SERVER

inherit

	SOCKET_RESOURCES

	STORABLE

create

	make

feature

	make
			-- Accept communication with client and exchange messages
		local
			count: INTEGER
			soc1: detachable UNIX_STREAM_SOCKET
		do
			create soc1.make_server ("/tmp/here")
			from
				soc1.listen (5)
				count := 0
			until
				count = 3
			loop
				process (soc1)-- See below
				count := count + 1
			end
			soc1.cleanup
		rescue
			if soc1 /= Void then
				soc1.cleanup
			end
		end

	process (soc1: UNIX_STREAM_SOCKET)
			-- Receive a message, extend it, and send it back.
		do
			soc1.accept
			if attached soc1.accepted as soc2 then
				if attached {OUR_MESSAGE} retrieved (soc2) as our_new_list then
					from
						our_new_list.start
					until
						our_new_list.after
					loop
						io.putstring (our_new_list.item)
						our_new_list.forth
						io.new_line
					end
					our_new_list.extend ("%N I'm back.%N")
					our_new_list.independent_store (soc2)
				end
				soc2.close
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

