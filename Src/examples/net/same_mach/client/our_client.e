note

	description:
		"Client root-class for the same_mach example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OUR_CLIENT

inherit

	SOCKET_RESOURCES

create

	make

feature

	make
			-- Establish communication with server, and exchange messages.
		local
			soc1: detachable UNIX_STREAM_SOCKET
		do
			create soc1.make_client ("/tmp/here")
			soc1.connect
			process (soc1)
			soc1.cleanup
		rescue
			if soc1 /= Void then
				soc1.cleanup
			end
		end

	process (soc1: UNIX_STREAM_SOCKET)
			-- Build a message to server, receive answer, build
			-- modified message from that answer, and print it.
		local
			our_list: OUR_MESSAGE
		do
			create our_list.make
			our_list.extend ("This ")
			our_list.extend ("is ")
			our_list.extend ("our ")
			our_list.extend ("test.")
			our_list.independent_store (soc1)
			if attached {OUR_MESSAGE} our_list.retrieved (soc1) as our_new_list then
				from
					our_new_list.start
				until
					our_new_list.after
				loop
					io.putstring (our_new_list.item)
					our_new_list.forth
				end
				io.new_line
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

