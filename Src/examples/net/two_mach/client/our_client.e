note

	description:
		"Client root-class for the two_mach example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OUR_CLIENT

inherit

	SOCKET_RESOURCES

	SED_STORABLE_FACILITIES

create

	make

feature


	make (argv: ARRAY [STRING])
			-- Establish communication with server, and exchange messages.
		local
			soc1: detachable NETWORK_STREAM_SOCKET
		do
			if argv.count /= 3 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" hostname portnumber%N")
			else
				create soc1.make_client_by_port (argv.item (2).to_integer, argv.item (1))
				soc1.connect
				process (soc1) -- See below
				soc1.cleanup
			end
		rescue
			if soc1 /= Void then
				soc1.cleanup
			end
		end

	process (soc1: NETWORK_STREAM_SOCKET)
			-- Build a message to server, receive answer, build
			-- modified message from that answer, and print it.
		local
			our_list: OUR_MESSAGE
			l_medium: SED_MEDIUM_READER_WRITER
		do
			create our_list.make
			our_list.extend ("This ")
			our_list.extend ("is ")
			our_list.extend ("our ")
			our_list.extend ("test.")

			create l_medium.make (soc1)
			l_medium.set_for_writing
			store (our_list, l_medium)
			l_medium.set_for_reading
			if attached {OUR_MESSAGE} retrieved (l_medium, True) as our_new_list then
				from
					our_new_list.start
				until
					our_new_list.after
				loop
					io.putstring (our_new_list.item)
					our_new_list.forth
				end
			else
				io.put_string ("Failed retrieving list.")
			end
			io.new_line
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

