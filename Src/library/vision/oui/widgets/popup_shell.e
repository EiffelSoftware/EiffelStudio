--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General popup shell.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class POPUP_SHELL 

inherit

	SHELL
		redefine
			implementation
		end
	
feature -- Windowing

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

	popdown is
			-- Popdown popup shell.
		do
			implementation.popdown
		ensure
			Not_poped_up: not is_poped_up
		end;

	popup is
			-- Popup a popup shell with no grab on it.
		do
			implementation.popup
		ensure
			Poped_up: is_poped_up
		end;

	set_cascade_grab is
			-- Specifies that the shell would be poped up with cascade grab.
			-- (Allowing the other shells poped up with grab to receive events).
		do
			implementation.set_cascade_grab
		ensure
			Has_cascade_grab: is_cascade_grab
		end;

	set_exclusive_grab is
			-- Specifies that the shell would be poped up with exclusive grab.
			-- (Allowing only the current shell to receive events);
		do
			implementation.set_exclusive_grab
		ensure
			Has_exclusive_grab: is_exclusive_grab
		end; 

	set_no_grab is
			-- Specifies that the shell would be poped up with no grab.
		do
			implementation.set_no_grab
		ensure
			Has_no_grab: is_no_grab
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: POPUP_S_I;
			-- Implementation of popup shell
	
invariant

	Positive_depth: depth > 0;
	Valid_parent: parent /= Void

end 
