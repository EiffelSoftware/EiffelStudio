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

