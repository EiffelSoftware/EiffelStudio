indexing

	description: "General popup shell";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	POPUP_SHELL 

inherit

	SHELL
		redefine
			implementation
		end
	
feature -- Status report

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

feature -- Status setting

	popdown is
			-- Popdown popup shell.
		require
			exists: not destroyed
		do
			implementation.popdown
		ensure
			not_popped_up: not is_popped_up
		end;

	popup is
			-- Popup a popup shell with no grab on it.
		require
			exists: not destroyed
		do
			implementation.popup
		end;

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab.
			-- (Allowing the other shells popped up with grab to receive events).
		require
			exists: not destroyed
		do
			implementation.set_cascade_grab
		ensure
			Has_cascade_grab: is_cascade_grab
		end;

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
			-- (Allowing only the current shell to receive events);
		require
			exists: not destroyed
		do
			implementation.set_exclusive_grab
		ensure
			Has_exclusive_grab: is_exclusive_grab
		end; 

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		require
			exists: not destroyed
		do
			implementation.set_no_grab
		ensure
			Has_no_grab: is_no_grab
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: POPUP_SHELL_I;
			-- Implementation of popup shell
	
invariant

	Positive_depth: depth > 0;
	Valid_parent: parent /= Void

end -- class POPUP_SHELL



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

