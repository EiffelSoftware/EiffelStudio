indexing

	description: "Command to popdown a shell";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	POPDOWN_COM 

inherit

	COMMAND

feature -- Basic operations

	execute (argument: ANY) is
			-- Popdown a shell.
		local
			shell: POPUP_SHELL;
			dialog: DIALOG
		do
			shell ?= argument;
			if (shell = Void) then
				dialog ?= argument;
				dialog.popdown;
			else
				shell.popdown;
			end
		end

end -- class POPDOWN_COM

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

