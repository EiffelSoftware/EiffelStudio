indexing

	description: "Delayed command to popup the label for focusables."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DELAYED_FOCUS_COMMAND

inherit
	COMMAND

creation
	make

feature -- Initialization

	make (a_command: FOCUS_COMMAND) is
			-- Initialize Current with `parent_command' as `a_command'.
		require
			non_void_command: a_command /= Void
		do
			parent_command := a_command;
		ensure
			parent_command_set: parent_command = a_command;
		end;

feature -- Execution

	execute (arg: FOCUSABLE) is
		do
			if arg /= Void then
				parent_command.popup_label (arg);
			else
				parent_command.uninitialize_timer;
			end;
		end;

feature {NONE} -- Properties

	parent_command: FOCUS_COMMAND
			-- Parent of Current.

end -- class DELAYED_FOCUS_COMMAND

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
