indexing

	description:
		"Client root-class for the two_mach example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OUR_CLIENT

inherit

	SOCKET_RESOURCES

creation

	make

feature

	soc1: NETWORK_STREAM_SOCKET

	make is
			-- Establish communication with server, and exchange messages.
			-- You need to replace "hostname" with the name of the machine
			-- running the server program.
		do
			!!soc1.make_client_by_port (2001, "prague")
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
			i: INTEGER
		do
			!!our_list.make
			our_list.extend ("This ")
			our_list.extend ("is ")
			our_list.extend ("our ")
			our_list.extend ("test.")
						
			our_list.independent_store (soc1)
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

end

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

