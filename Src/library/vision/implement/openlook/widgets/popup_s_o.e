--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- POPUP_S_O: implementation of popup shell.

indexing

	date: "$Date$";
	revision: "$Revision$"

class POPUP_S_O 

inherit

	SHELL_O
		rename
			OallowShellResize as shell_OallowShellResize
		end;

	COMMAND
		export
			{NONE} all
		end;

	POPUP_R_O
		export
			{NONE} all
		end;

feature {NONE}

 	initialize (a_widget: WIDGET) is
			-- Initialize the current dialog
		local
			true_ref, false_ref: BOOLEAN_REF
 		do
			!!popup_actions.make (xt_parent (screen_object), Opopup, a_widget);
			!!true_ref;
			true_ref.set_item (True);
			popup_actions.add (Current, true_ref);
			!!popdown_actions.make (xt_parent (screen_object), Opopdown, a_widget);
			!!false_ref;
			false_ref.set_item (False);
			popdown_actions.add (Current, false_ref)
 		end;

	execute (up: ANY) is
		local
			bool_ref: BOOLEAN_REF
		do
			bool_ref ?= up;
			is_poped_up_ref := bool_ref
		end;

	grab_type: INTEGER;
			-- Type of grab
	
feature 

	is_cascade_grab: BOOLEAN is
			-- Is the shell poped up with cascade grab (allowing the other
			-- shells poped up with grab to receive events) ?
		do
			Result := grab_type = 2
		end; 

	is_exclusive_grab: BOOLEAN is
			-- Is the shell poped up with exclusive grab ?
		do
			Result := grab_type = 1
		end; 

	is_no_grab: BOOLEAN is
			-- Is the shell poped up with no grab ?
		do
			Result := grab_type = 0
		end; 
	
feature {NONE}

	is_poped_up: BOOLEAN is
			-- Is the popup up ?
		do
			Result := is_poped_up_ref.item
		end;

	is_poped_up_ref: BOOLEAN_REF;

feature 

	popdown is
			-- Popdown popup shell.
		
		do
			if is_poped_up then
				xt_popdown (xt_parent (screen_object));
				is_poped_up_ref.set_item (False);
			end
		ensure then
			not is_poped_up
		end; 

	
feature {NONE}

	popdown_actions: EVENT_HAND_O;
	
feature 

	popup is
			-- Popup a popup shell.
		
		do
			if not is_poped_up then
				inspect
					grab_type
				when 0 then
					xt_popup_none (xt_parent (screen_object))
				when 1 then
					xt_popup_exclusive (xt_parent (screen_object))
				when 2 then
					xt_popup_non_ex (xt_parent (screen_object))
				end;
				is_poped_up_ref.set_item (True)
			end
		ensure then
			is_poped_up
		end; 

	
feature {NONE}

	popup_actions: EVENT_HAND_O;
	
feature 

	set_cascade_grab is
			-- Specifies that the shell would be poped up with cascade grab
			-- (allowing the other shells poped up with grab to receive events).
		do
			grab_type := 2
		ensure then
			is_cascade_grab
		end; 

	set_exclusive_grab is
			-- Specifies that the shell would be poped up with exclusive grab.
		do
			grab_type := 1
		ensure then
			is_exclusive_grab
		end; 

	set_no_grab is
			-- Specifies that the shell would be poped up with no grab.
		do
			grab_type := 0
		ensure then
			is_no_grab
		end;

feature {NONE} -- External features

	xt_popup_non_ex (a_popup: POINTER) is
		external
			"C"
		end; 

	xt_popup_exclusive (a_popup: POINTER) is
		external
			"C"
		end; 

	xt_popup_none (a_popup: POINTER) is
		external
			"C"
		end; 

	xt_popdown (scr_obj: POINTER) is
		external
			"C"
		end; 

	xt_parent  (scr_obj: POINTER): POINTER is
		external
			"C"
		end; 

	invariant

		Valid_poped_up_ref: is_poped_up_ref /= Void

end

