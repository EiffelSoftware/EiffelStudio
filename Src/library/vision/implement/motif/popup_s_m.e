--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- POPUP_S_M: implementation of popup shell.

indexing

	date: "$Date$";
	revision: "$Revision$"

class POPUP_S_M 

inherit

	SHELL_M;

feature {NONE}

	grab_type: INTEGER;
			-- Type of grab

feature 

	is_cascade_grab: BOOLEAN is
			-- Is the shell poped up with cascade grab (allowing the other
			-- shells poped up with grab to receive events) ?
		do
			Result := grab_type = 2
		end; -- is_cascade_grab

	is_exclusive_grab: BOOLEAN is
			-- Is the shell poped up with exclusive grab ?
		do
			Result := grab_type = 1
		end; -- is_no_grab

	is_no_grab: BOOLEAN is
			-- Is the shell poped up with no grab ?
		do
			Result := grab_type = 0
		end; -- is_no_grab

feature {NONE}

	is_poped_up: BOOLEAN is
			-- Is the popup widget poped up on screen ?
		do
			Result := c_is_poped_up (xt_parent (screen_object))
		end;

feature 

	popdown is
			-- Popdown popup shell.
		do
			if is_poped_up then
				xt_unmanage_child (screen_object)
			end
		ensure
			not is_poped_up
		end; -- popdown

	popup is
			-- Popup a popup shell.
		do
			if not is_poped_up then
				xt_manage_child (screen_object);
				c_add_grab (screen_object, grab_type)
			end
		ensure
			is_poped_up
		end;

	set_cascade_grab is
			-- Specifies that the shell would be poped up with cascade grab
			-- (allowing the other shells poped up with grab to receive events).
		do
			grab_type := 2
		ensure
			is_cascade_grab
		end; -- set_cascade_grab

	set_exclusive_grab is
			-- Specifies that the shell would be poped up with exclusive grab.
		do
			grab_type := 1
		ensure
			is_exclusive_grab
		end; -- set_exclusive_grab

	set_no_grab is
			-- Specifies that the shell would be poped up with no grab.
		do
			grab_type := 0
		ensure
			is_no_grab
		end

feature {NONE} -- External features

	c_is_poped_up (value: POINTER): BOOLEAN is
		external
			"C"
		end;

	c_add_grab (scr_obj: POINTER; g_type: INTEGER) is
		external
			"C"
		end;

	xt_parent (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

