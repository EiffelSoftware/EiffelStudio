indexing

	description:
		"Client root-class for the two_mach example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OUR_CLIENT

inherit

	SOCKET_RESOURCES

create

	make

feature

	soc1: NETWORK_STREAM_SOCKET

	make (argv: ARRAY [STRING]) is
			-- Establish communication with server, and exchange messages.
		do
			if argv.count /= 3 then
                                io.error.putstring ("Usage: ")
                                io.error.putstring (argv.item (0))
                                io.error.putstring (" hostname portnumber%N")
                        else
				create soc1.make_client_by_port (argv.item (2).to_integer, argv.item (1))
				soc1.connect
				process -- See below
				soc1.cleanup
			end
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
			create our_list.make
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

