indexing

	description: "Message dialog to ensure that the user really wants to quit the application";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	QUIT_APP_D 

inherit

	STD_COMMANDS
		export
			{NONE} all
		end;

	QUESTION_D
		rename
			make as question_d_make
		end

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a predefined question dialog with `a_name' as identifier,
			-- `a_parent' as parent. When `execute' is called, popup the
			-- question dialog and ask the user if he's sure to quit the
			-- application. Exit if OK is pressed.
		require
			name_not_void: a_name /= Void
			parent_not_void: a_parent /= Void
		do
-- FIXME
		end

end -- class QUIT_APP_D 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

