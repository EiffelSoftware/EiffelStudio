indexing

	description:
		"Describe a connection for the advanced example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CONNECTION

inherit

	POLL_COMMAND

create

	make

feature

	is_waiting: BOOLEAN

	client_name: STRING

	execute (arg: ANY) is
		do
			is_waiting := True
		end

	initialize is
		do
			is_waiting := False
		end

	set_client_name (s: STRING) is
		require
			s_exists: s /= Void
		do
			client_name := clone (s)
		end

end -- class CONNECTION

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

