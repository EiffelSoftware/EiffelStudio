
-- OPT_PULL_M: implementation of pulldown menu for an option button.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPT_PULL_M 

inherit
	OPT_PULL_I
		export
			{NONE} all
		end;

	MENU_M
		rename
			set_foreground as menu_set_foreground,
			set_background_color as menu_set_background_color,
			set_size as menu_set_size,
			set_width as menu_set_width,
			set_height as menu_set_height,
			set_managed as menu_set_managed,
			managed as menu_managed
		redefine
			set_x_y, real_x, real_y, x, y, set_x, set_y, height, width
		end;

	MENU_M
		redefine
			set_x_y, set_size, set_width, set_height, real_x, real_y, x, y,
			set_x, set_y, height, width, managed, set_managed,
			set_foreground, set_background_color
		select
			set_size, set_width, set_height, 
			set_foreground, set_background_color,
			set_managed, managed
		end;
creation

	make

feature -- Creation

	make (a_pulldown: OPT_PULL) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			ext_name: ANY
		do
			pulldown_identifier := clone (a_pulldown.identifier);
			pulldown_identifier.append ("_pull");
			!! option_button.make (a_pulldown.identifier,a_pulldown.parent);
			ext_name := pulldown_identifier.to_c;
			screen_object := create_pulldown ($ext_name,
					a_pulldown.parent.implementation.screen_object);
			abstract_menu := a_pulldown;
			xm_attach_menu (xm_option_button_gadget (option_button.implementation.screen_object), screen_object)
		end;

feature

	managed: BOOLEAN is
		do
			Result := option_button.managed;
		end;

	set_managed (flag: BOOLEAN) is
		do
			option_button.set_managed (flag);
		end;

	caption: STRING is
		do
			Result := option_button.title;
		end;

	set_caption (new_title: STRING) is
		do
			option_button.set_title (new_title);
		end;
	
	remove_caption is
		do
			option_button.remove_title;
		end;

	
	set_x (new_x: INTEGER) is
		do
			option_button.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
		do
			option_button.set_y (new_y);
		end;

	height: INTEGER is
		do
			Result := option_button.height;
		end;

	width: INTEGER is
		do
			Result := option_button.width;
		end;


	real_x: INTEGER is
		do
			Result := option_button.real_x;
		end;

	real_y: INTEGER is
		do
			Result := option_button.real_y;
		end;

	x: INTEGER is
		do
			Result := option_button.x;
		end;

	y: INTEGER is
		do
			Result := option_button.y;
		end;

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
			option_button.set_selected_button(button);	
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
			option_button.set_text (a_text)
		end;

	set_size (new_width, new_height: INTEGER) is
		local
			nw: INTEGER;
		do
			nw := new_width;
			if option_button.title.empty then
				menu_set_size (nw, new_height);
			else
				menu_set_size (nw - option_button.title_width, new_height);
			end;
			option_button.set_size (new_width, new_height);
		end;

	set_width (new_width: INTEGER) is
		local
			nw: INTEGER;
		do
			nw := new_width;
			if option_button.title.empty then
				menu_set_width (nw - option_button.title_width);
			else
				menu_set_width (nw);
			end;
			option_button.set_width (new_width);
		end;

	set_height (new_height: INTEGER) is
		do
			menu_set_height (new_height);
			option_button.set_height (new_height);
		end;

	set_foreground (a_color: COLOR) is
		do
			option_button.set_foreground (a_color);
			menu_set_foreground (a_color);
		end;

	set_background_color (a_color: COLOR) is
		do
			option_button.set_background_color (a_color);
			menu_set_background_color (a_color);
		end;

	allow_recompute_size  is
		do
			option_button.allow_recompute_size;
			set_xt_boolean (screen_object, True, MresizeWidth);
			set_xt_boolean (screen_object, True, MresizeHeight);
		end;

	forbid_recompute_size  is
		do
			option_button.forbid_recompute_size;
			set_xt_boolean (screen_object, False, MresizeHeight);
			set_xt_boolean (screen_object, False, MresizeWidth);
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

	xm_option_label_gadget (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
