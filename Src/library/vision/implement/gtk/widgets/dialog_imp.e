indexing

	description: 
		"EiffelVision dialog, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
deferred class
	DIALOG_IMP

inherit

	DIALOG_I	

feature -- Access

	screen_object: POINTER is
		deferred
		end

	
	is_stackable: BOOLEAN is False
	
	is_popped_up: BOOLEAN
			-- Is the popup widget popped up on screen ?
		
feature -- Status report

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab
			-- (allowing the other shells popped up with
			-- grab to receive events) ?
			-- (primary application modal)
		do
			check
				not_yet_implemented: False
			end
		end 

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
			-- (full_application_modal)
		do
			check
				not_yet_implemented: False
			end
		end

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
			-- (modeless)
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Element change

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			check
				not_yet_implemented: False
			end
		end

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			check
				not_yet_implemented: False
			end
		end
	

	popdown is
			-- Popdown current dialog shell.
		do
			if is_popped_up then
				unmanage
				is_popped_up := False
			end
		end 

	popup is
			-- Popup current dialog shell with no grab on it.
		do
			if not is_popped_up then
				manage
				is_popped_up := True
			end
		end 

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		do
			check
				not_yet_implemented: False
			end
		end

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		do
			check
				not_yet_implemented: False
			end
		end

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		do
			check
				not_yet_implemented: False
			end
		end

	dialog_command_target is
			-- set the command target to the dialog_shell
		do
			check
				not_yet_implemented: False
			end
		end

	widget_command_target is
			-- set the command target to the widget
		do
			check
				not_yet_implemented: False
			end
		end
	
	
	manage is
			-- Manage dialog
		deferred
		end;

	unmanage is
			-- Unmanage dialog
		deferred
		end;

	
feature -- Element change

	set_parent_action (action: STRING; cmd: COMMAND; arg: ANY) is
			-- Set the dialog shell action to `cmd' with `arg'
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Removal

	remove_parent_action (action: STRING) is
			-- Remove `action' from the dialog shell
		do
			check
				not_yet_implemented: False
			end
		end
	
	
feature {NONE} -- Implementation


	action_target: POINTER is do end


end

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
