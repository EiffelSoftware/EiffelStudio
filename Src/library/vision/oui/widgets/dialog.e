
-- A Dialog is a popup that is made up of widgets. These widgets 
-- are defined in the descendents.  

indexing

	date: "$Date$";
	revision: "$Revision$"

class DIALOG 

inherit

	WM_SHELL
		redefine
			implementation
		end
	
feature -- Windowing

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			implementation.allow_resize
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			implementation.forbid_resize
		end;

	is_cascade_grab: BOOLEAN is
			-- Is the shell poped up with cascade grab (allowing the other
			-- shells poped up with grab to receive events) ?
		do
			Result := implementation.is_cascade_grab
		end;

	is_exclusive_grab: BOOLEAN is
			-- Is the shell poped up with exclusive grab ?
		do
			Result := implementation.is_exclusive_grab
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell poped up with no grab ?
		do
			Result := implementation.is_no_grab
		end;

	is_poped_up: BOOLEAN is
			-- Is the popup widget poped up on screen ?
		do
			Result := implementation.is_poped_up
		end;

	lower is
			-- Lower the dialog box in the stacking order.
		do
			implementation.lower
		end;

	popdown is
			-- Popdown dialog shell.
		do
			implementation.popdown
		ensure
			not is_poped_up
		end;

	popup is
			-- Popup a dialog shell with no grab on it.
		do
			implementation.popup
		ensure
			is_poped_up
		end;

	raise is
			-- Raise the dialog box to the top of the stacking order.
		do
			implementation.raise
		end;

	set_cascade_grab is
			-- Specifies that the shell would be poped up with cascade grab
			-- (allowing the other shells poped up with grab to receive events).
		do
			implementation.set_cascade_grab
		ensure
			is_cascade_grab
		end;

	set_exclusive_grab is
			-- Specifies that the shell would be poped up with exclusive grab.
		do
			implementation.set_exclusive_grab
		ensure
			is_exclusive_grab
		end;

	set_no_grab is
			-- Specifies that the shell would be poped up with no grab.
		do
			implementation.set_no_grab
		ensure
			is_no_grab
		end

feature

	dialog_command_target is
			-- set the command target to be the dialog shell
		do
			implementation.dialog_command_target;
		end;

	widget_command_target is
			-- set the command target to be the widget
		do
			implementation.widget_command_target;
		end

feature {DIALOG_I}

	set_dialog_imp (a_dialog_imp: DIALOG_I) is
			-- Set dialog implementation to `a_dialog_imp'.
		do
			implementation := a_dialog_imp
		end;

	
feature {NONE}

	implementation: DIALOG_I;
			-- Implementation of dialog

end 


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
