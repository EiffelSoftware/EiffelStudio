indexing

	description:
		"Server root-class for the same_mach example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OUR_SERVER

inherit

	SOCKET_RESOURCES

	STORABLE

creation

	make

feature

	soc1, soc2: UNIX_STREAM_SOCKET

	make is
			-- Accept communication with client and exchange messages
		local
			count: INTEGER
		do
			!!soc1.make_server ("/tmp/here")
			from
				soc1.listen (5)
				count := 0
			until
				count = 3
			loop
				process -- See below
				count := count + 1
			end
			soc1.cleanup
		rescue
			soc1.cleanup
		end

	process is
			-- Receive a message, extend it, and send it back.
		local
			our_new_list: OUR_MESSAGE
		do
			soc1.accept
			soc2 ?= soc1.accepted
			our_new_list ?= retrieved (soc2)
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
			our_new_list.general_store (soc2)
			soc2.close
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

