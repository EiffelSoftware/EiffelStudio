indexing

	description: "Command to quit the application immediately";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	QUIT_NOW_COM 

inherit

	COMMAND;

	GRAPHICS
		export
			{NONE} all
		end

feature -- Basic operations

	execute (argument: ANY) is
			-- Quit the application.
		do
			exit
		end

end -- class QUIT_NOW_COM

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

