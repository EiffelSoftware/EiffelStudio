indexing

	description:
		"Message transmitted in the advanced example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MESSAGE

inherit

	STORABLE

	LINKED_LIST [STRING]

create

	make_message

feature

	new: BOOLEAN

	over: BOOLEAN

	client_name: STRING

	make_message is
		do
			make
			extend ("-> ")
		end

	set_client_name (s: STRING) is
		require
			s_not_void: s /= Void
		do
			client_name := clone (s)
		end

	set_over (flag: BOOLEAN) is
		do
			over := flag
		end

	set_new (flag: BOOLEAN) is
		do
			new := flag
		end
	
	print_message is
		-- Prints the contents of the message to standard output
		do
			
			from
				start
			until
				after
			loop
				io.putstring (item)
				forth
			end
		end
	

end -- class MESSAGE

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

