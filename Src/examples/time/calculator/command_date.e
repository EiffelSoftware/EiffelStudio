indexing
    description: "notion of command to be executed by the calculator"
    status: "See notice at end of class"
    date: "$Date$"
    revision: "$Revision$"
    access: date, time

deferred class
	COMMAND_DATE

feature

	execute (d: DATE): DATE is
		require
			d_exists: d /= Void		 
		deferred
		ensure
			result_exists: Result /= Void
		end;

	display_help: STRING is
		deferred
		ensure
			result_exists: Result /= Void
		end;

end -- class COMMAND_DATE

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

