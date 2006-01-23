indexing

	description: "Implementation of a dialog"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	DIALOG_I 

inherit

	WM_SHELL_I
	
feature -- Access

	screen_object: POINTER is
		deferred
		end

	action_target: POINTER is
		deferred
		end

feature -- Status report

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		deferred
		end; 

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		deferred
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		deferred
		end;

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		deferred
		end;

feature -- Status setting

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

	lower is
			-- Lower the shell in the stacking order.
		deferred
		end; 

	popdown is
			-- Popdown current dialog shell.
		deferred
		ensure
			not_is_popped_up: not is_popped_up
		end; 

	popup is
			-- Popup current dialog shell with no grab on it.
		deferred
		end; 

	raise is
			-- Raise the shell to the top of the stacking order.
		deferred
		end;

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		deferred
		ensure
			is_cascade_grab:is_cascade_grab
		end;

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		deferred
		ensure
			is_exclusive_grab: is_exclusive_grab
		end;

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		deferred
		ensure
			is_no_grab: is_no_grab
		end

	dialog_command_target is
			-- set the command target to the dialog_shell
		deferred
		end;

	widget_command_target is
			-- set the command target to the widget
		deferred
		end;

feature -- Element change

	set_parent_action (action: STRING; cmd: COMMAND; arg: ANY) is
			-- Set the dialog shell action to `cmd' with `arg'
		require
			action_exists: action /= Void
			cmd_exists: cmd /= Void
		deferred
		end

feature -- Removal

	remove_parent_action (action: STRING) is
			-- Remove `action' from the dialog shell
		require
			action_exists: action /= Void
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DIALOG_I

