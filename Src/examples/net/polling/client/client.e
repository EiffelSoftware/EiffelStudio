indexing

	description:
		"Client root-class for the polling example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POLLING_CLIENT

create

	make

feature

	make (argv: ARRAY [STRING]) is
		local
			soc: NETWORK_DATAGRAM_SOCKET
			ps: MEDIUM_POLLER
			readcomm: DATAGRAM_READER
			writecomm: CLIENT_DATAGRAM_WRITER
		do
			if argv.count /= 3 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" hostname portnumber%N")
			else
				create soc.make_targeted_to_hostname (argv.item (1), 
								 argv.item (2).to_integer)
				create ps.make_write_only
				create readcomm.make (soc)
				ps.put_read_command (readcomm)
				create writecomm.make (soc)
				ps.put_write_command (writecomm)
				ps.execute (15, 20000)
				ps.make_read_only
				ps.execute (15, 20000)
				soc.close
			end
		rescue
			if not soc.is_closed then
				soc.close
			end
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

