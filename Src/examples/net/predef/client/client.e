indexing

	description:
		"Client root-class for the predef example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OUR_CLIENT

inherit

	NETWORK_CLIENT
		redefine
			received
		end

create

	make_client

feature

	our_list: OUR_MESSAGE

	received: OUR_MESSAGE -- Type redefinition

	make_client (argv: ARRAY [STRING]) is
			-- Build list, send it, receive modified list, and print it.
		do
			if argv.count /= 3 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" hostname portnumber%N")
			else
				make (argv.item (2).to_integer, argv.item (1))
				build_list
				send (our_list)
				receive
				process_received
				cleanup
			end
		rescue
			cleanup
		end

	build_list is
			-- Build list of strings `our_list' for transmission to server.
		do
			create our_list.make
			our_list.extend ("This ")
			our_list.extend ("is ")
			our_list.extend ("our ")
			our_list.extend ("test.")
		end

	process_received is
			-- Print the contents of received in sequence.
		do
			if received = Void then
				io.putstring ("No list received.")
			else
				from received.start until received.after loop
					io.putstring (received.item)
					received.forth
				end
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

