indexing

	description:
		"A Dialog is a popup that is made up of widgets. These widgets %
		%are defined in the descendants"; 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	DIALOG 

inherit

	WM_SHELL
		redefine
			implementation
		end
	
feature -- Status setting

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.allow_resize
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.forbid_resize
		end;

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		require
			exists: not destroyed
		do
			Result := implementation.is_cascade_grab
		end;

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		require
			exists: not destroyed
		do
			Result := implementation.is_exclusive_grab
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		require
			exists: not destroyed
		do
			Result := implementation.is_no_grab
		end;

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		require
			exists: not destroyed
		do
			Result := implementation.is_popped_up
		end;

feature -- feature setting

	lower is
			-- Lower the dialog box in the stacking order.
		require
			exists: not destroyed
		do
			implementation.lower
		end;

	popdown is
			-- Popdown dialog shell.
		require
			exists: not destroyed
		do
			implementation.popdown
		ensure
			not is_popped_up
		end;

	popup is
			-- Popup a dialog shell with no grab on it.
		require
			exists: not destroyed
		do
			implementation.popup
		end;

	raise is
			-- Raise the dialog box to the top of the stacking order.
		require
			exists: not destroyed
		do
			implementation.raise
		end;

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		require
			exists: not destroyed
		do
			implementation.set_cascade_grab
		ensure
			is_cascade_grab
		end;

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		require
			exists: not destroyed
		do
			implementation.set_exclusive_grab
		ensure
			is_exclusive_grab
		end;

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		require
			exists: not destroyed
		do
			implementation.set_no_grab
		ensure
			is_no_grab
		end

feature -- Element change

	set_parent_action (action: STRING; cmd: COMMAND; arg: ANY) is
			-- Set the dialog shell action to `cmd' with `arg'
		require
			action_exists: action /= Void
			cmd_exists: cmd /= Void
		do
			implementation.set_parent_action (action, cmd, arg)
		end

	remove_parent_action (action: STRING) is
			-- Remove `action' from the dialog shell 
		require
			action_exists: action /= Void
		do
			implementation.remove_parent_action (action)
		end

	dialog_command_target is
			-- Set the command target to be the dialog shell
		obsolete
			"Use set_parent_action instead."
		require
			exists: not destroyed
		do
			implementation.dialog_command_target;
		end;

	widget_command_target is
			-- Set the command target to be the widget
		obsolete
			"Not required when using set_parent_action."
		require
			exists: not destroyed
		do
			implementation.widget_command_target;
		end

feature {DIALOG_I} -- Implementation

	set_dialog_imp (a_dialog_imp: DIALOG_I) is
			-- Set dialog implementation to `a_dialog_imp'.
		do
			implementation := a_dialog_imp
		end;
	
feature {NONE} -- Implementation

	implementation: DIALOG_I;
			-- Implementation of dialog

end  -- class DIALOG 



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

