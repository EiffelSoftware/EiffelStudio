indexing

	description:
		"Server root-class for the two_mach example.";

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

	soc1, soc2: NETWORK_STREAM_SOCKET

	make (argv: ARRAY [STRING]) is
			-- Accept communication with client and exchange messages
		local
			count: INTEGER
		do
			if argv.count /= 2 then
                                io.error.putstring ("Usage: ")
                                io.error.putstring (argv.item (0))
                                io.error.putstring (" portnumber%N")
                        else
                                !!soc1.make_server_by_port (argv.item (1).to_integer)
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
			end
		rescue
			soc1.cleanup
		end

	process is
			-- Receive a message, extend it, and send it back.
		local
			our_new_list: OUR_MESSAGE
			str: STRING
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
			our_new_list.independent_store (soc2)
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

