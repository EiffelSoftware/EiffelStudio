indexing

	description: 
		"Callback to clean a widget after having called other destroy callbacks";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CLEAN_UP_CALLBACK

inherit

	MEL_COMMAND
		redefine
			execute
		end

feature -- Basic operations

	execute (argument: ANY) is
			-- Clean up the object.
		do
			callback_struct.widget.clean_up
		end;

end -- class MEL_CLEAN_UP_CALLBACK


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

