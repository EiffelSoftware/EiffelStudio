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
--| EiffelVision: library of reusable components for ISE Eiffel.
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

