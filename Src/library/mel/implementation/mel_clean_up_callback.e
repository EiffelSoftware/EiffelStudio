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

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
