indexing

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

	soc1: UNIX_STREAM_SOCKET

	make is
			-- Establish communication with server, and exchange messages.
		do
			create soc1.make_client ("/tmp/here")
			soc1.connect
			process -- See below
			soc1.cleanup
		rescue
			soc1.cleanup
		end

	process is
			-- Build a message to server, receive answer, build
			-- modified message from that answer, and print it.
		local
			our_list, our_new_list: OUR_MESSAGE
		do
			create our_list.make
			our_list.extend ("This ")
			our_list.extend ("is ")
			our_list.extend ("our ")
			our_list.extend ("test.")
			our_list.general_store (soc1)
			our_new_list ?= our_list.retrieved (soc1)
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


end

