--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OVERRIDE_S_M: implementation of override shell

indexing

	date: "$Date$";
	revision: "$Revision$"

class OVERRIDE_S_M 

inherit

	OVERRIDE_S_I
		export
			{NONE} all
		end;

	POPUP_S_M
		redefine
			popup, popdown, is_poped_up
		end

creation

	make

feature 

	make (an_override_shell: OVERRIDE_S) is
			-- Create an override shell.
		local
			ext_name: ANY
		do
			ext_name := an_override_shell.identifier.to_c;
			screen_object := xt_create_override_shell ($ext_name,
					an_override_shell.parent.implementation.screen_object)
		end;

	
feature {NONE}

	is_poped_up: BOOLEAN;
			-- Is the popup widget poped up on screen ?

feature 

	popdown is
			-- Popdown an override shell.
		do
			if is_poped_up then
				xt_popdown (screen_object)
			end;
			is_poped_up := false
		ensure then
			not is_poped_up
		end; -- popdown

	popup is
			-- Popup an override shell.
		do
			if not is_poped_up then
				inspect
					grab_type
				when 0 then
					xt_popup_none (screen_object)
				when 1 then
					xt_popup_exclusive (screen_object)
				when 2 then
					xt_popup_non_ex (screen_object)
				end;
				is_poped_up := true
			end
		ensure then
			is_poped_up
		end

feature {NONE} -- External features

	xt_create_override_shell (o_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xt_popup_non_ex (scr_obj: POINTER) is
		external
			"C"
		end;

	xt_popup_exclusive (scr_obj: POINTER) is
		external
			"C"
		end;

	xt_popup_none (scr_obj: POINTER) is
		external
			"C"
		end;

	xt_popdown (scr_obj: POINTER) is
		external
			"C"
		end;

end

