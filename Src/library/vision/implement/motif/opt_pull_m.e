--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OPT_PULL_M: implementation of pulldown menu for an option button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class OPT_PULL_M 

inherit
	OPT_PULL_I
		export
			{NONE} all
		end;

	MENU_M
		redefine
			set_x_y
		end

creation

	make

feature -- Creation

	make (a_pulldown: OPT_PULL) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			ext_name: ANY
		do
			pulldown_identifier := a_pulldown.identifier.duplicate;
			pulldown_identifier.append ("_pull");
			!! option_button.make (a_pulldown.identifier,a_pulldown.parent);
			ext_name := pulldown_identifier.to_c;
			screen_object := create_pulldown ($ext_name,
					a_pulldown.parent.implementation.screen_object);
			abstract_menu := a_pulldown;
			xm_attach_menu (xm_option_button_gadget (option_button.implementation.screen_object), screen_object)
		end;

feature

	set_x_y (new_x, new_y: INTEGER) is
		do
			option_button.set_x_y (new_x, new_y);
		end;

	selected_button: BUTTON is
            		-- Current Push Button selected in the option menu
		do
			Result := option_button.selected_button
		end;

   	set_selected_button (button: BUTTON) is
            		-- Set `selected_button' to `button'
		do
			option_button.set_selected_button(button)				
	        ensure then
		        button.same (selected_button)
	        end;

	text: STRING is
			-- Label of option button
		do
			Result := option_button.text
		end;

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		do
			option_button.set_text(a_text)
		end;

feature {NONE} -- External features

	create_pulldown (i_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_option_button_gadget (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_attach_menu (value, scr_obj: POINTER) is
		external
			"C"
		end;

end

