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
		local
			nothing: ANY
		do
-- FIXME
		end

end -- class QUIT_APP_D 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

