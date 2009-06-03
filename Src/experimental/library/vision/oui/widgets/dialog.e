note

	description:
		"A Dialog is a popup that is made up of widgets. These widgets %
		%are defined in the descendants"
	legal: "See notice at end of class."; 
	status: "See notice at end of class.";
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

	allow_resize
			-- Allow geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.allow_resize
		end;

	forbid_resize
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.forbid_resize
		end;

	is_cascade_grab: BOOLEAN
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		require
			exists: not destroyed
		do
			Result := implementation.is_cascade_grab
		end;

	is_exclusive_grab: BOOLEAN
			-- Is the shell popped up with exclusive grab ?
		require
			exists: not destroyed
		do
			Result := implementation.is_exclusive_grab
		end;

	is_no_grab: BOOLEAN
			-- Is the shell popped up with no grab ?
		require
			exists: not destroyed
		do
			Result := implementation.is_no_grab
		end;

	is_popped_up: BOOLEAN
			-- Is the popup widget popped up on screen ?
		require
			exists: not destroyed
		do
			Result := implementation.is_popped_up
		end;

feature -- feature setting

	lower
			-- Lower the dialog box in the stacking order.
		require
			exists: not destroyed
		do
			implementation.lower
		end;

	popdown
			-- Popdown dialog shell.
		require
			exists: not destroyed
		do
			implementation.popdown
		ensure
			not is_popped_up
		end;

	popup
			-- Popup a dialog shell with no grab on it.
		require
			exists: not destroyed
		do
			implementation.popup
		end;

	raise
			-- Raise the dialog box to the top of the stacking order.
		require
			exists: not destroyed
		do
			implementation.raise
		end;

	set_cascade_grab
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		require
			exists: not destroyed
		do
			implementation.set_cascade_grab
		ensure
			is_cascade_grab
		end;

	set_exclusive_grab
			-- Specifies that the shell would be popped up with exclusive grab.
		require
			exists: not destroyed
		do
			implementation.set_exclusive_grab
		ensure
			is_exclusive_grab
		end;

	set_no_grab
			-- Specifies that the shell would be popped up with no grab.
		require
			exists: not destroyed
		do
			implementation.set_no_grab
		ensure
			is_no_grab
		end

feature -- Element change

	set_parent_action (action: STRING; cmd: COMMAND; arg: ANY)
			-- Set the dialog shell action to `cmd' with `arg'
		require
			action_exists: action /= Void
			cmd_exists: cmd /= Void
		do
			implementation.set_parent_action (action, cmd, arg)
		end

	remove_parent_action (action: STRING)
			-- Remove `action' from the dialog shell 
		require
			action_exists: action /= Void
		do
			implementation.remove_parent_action (action)
		end

	dialog_command_target
			-- Set the command target to be the dialog shell
		obsolete
			"Use set_parent_action instead."
		require
			exists: not destroyed
		do
			implementation.dialog_command_target;
		end;

	widget_command_target
			-- Set the command target to be the widget
		obsolete
			"Not required when using set_parent_action."
		require
			exists: not destroyed
		do
			implementation.widget_command_target;
		end

feature {DIALOG_I} -- Implementation

	set_dialog_imp (a_dialog_imp: DIALOG_I)
			-- Set dialog implementation to `a_dialog_imp'.
		do
			implementation := a_dialog_imp
		end;
	
feature {NONE} -- Implementation

	implementation: DIALOG_I;;
			-- Implementation of dialog

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end  -- class DIALOG 

