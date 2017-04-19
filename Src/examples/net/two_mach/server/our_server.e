note

	description:
		"Server root-class for the two_mach example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OUR_SERVER

inherit

	SOCKET_RESOURCES

	SED_STORABLE_FACILITIES

create

	make

feature


	make (argv: ARRAY [STRING])
			-- Accept communication with client and exchange messages
		local
			count: INTEGER
			soc1: detachable NETWORK_STREAM_SOCKET
		do
			if argv.count /= 2 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" portnumber%N")
			else
				create soc1.make_server_by_port (argv.item (1).to_integer)
				from
					soc1.listen (5)
					count := 0
				until
					count = 3
				loop
					process (soc1) -- See below
					count := count + 1
				end
				soc1.cleanup
			end
		rescue
			if soc1 /= Void then
				soc1.cleanup
			end
		end

	process (soc1: NETWORK_STREAM_SOCKET)
			-- Receive a message, extend it, and send it back.
		local
			l_medium: SED_MEDIUM_READER_WRITER
		do
			soc1.accept
			if attached {NETWORK_STREAM_SOCKET} soc1.accepted as soc2 then
				create l_medium.make (soc2)
				l_medium.set_for_reading
				if attached {OUR_MESSAGE} retrieved (l_medium, True) as our_new_list then
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
					l_medium.set_for_writing
					store (our_new_list, l_medium)
				else
					io.put_string ("Failed retrieving list.")
					io.new_line
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

