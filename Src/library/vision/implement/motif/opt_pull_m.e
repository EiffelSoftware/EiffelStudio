indexing

	description: "Implementation of pulldown menu for an option button";
	status: "See notice at end of class";
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
			set_foreground_color as menu_set_foreground_color,
			set_background_color as menu_set_background_color,
			set_size as menu_set_size,
			set_width as menu_set_width,
			set_height as menu_set_height,
			set_managed as menu_set_managed,
			managed as menu_managed
		redefine
			set_x_y, real_x, real_y, x, y, set_x, set_y, height, width,
			set_insensitive, insensitive
		end;

	MENU_M
		redefine
			set_x_y, set_size, set_width, set_height, real_x, real_y, x, y,
			set_x, set_y, height, width, managed, set_managed,
			set_foreground_color, set_background_color,
			set_insensitive, insensitive
		select
			set_size, set_width, set_height, 
			set_foreground_color, set_background_color,
			set_managed, managed
		end;
creation

	make

feature -- Creation

	make (a_pulldown: OPT_PULL; man: BOOLEAN) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			ext_name: ANY;
			parent: COMPOSITE
		do
				-- The widget index is incremented by one since
				-- the option_button will be inserted before Current
				-- in the widget_manager
			widget_index := widget_manager.last_inserted_position + 1;
			pulldown_identifier := clone (a_pulldown.identifier);
			pulldown_identifier.append ("_pull");
			parent ?= widget_manager.parent_using_index (a_pulldown, 
							widget_index - 1);
			check
				intern: parent /= Void
			end;
			if man then
				!! option_button.make (a_pulldown.identifier, parent);
			else
				!! option_button.make_unmanaged (a_pulldown.identifier, parent);
			end;
			ext_name := pulldown_identifier.to_c;
			screen_object := create_pulldown ($ext_name,
					parent.implementation.screen_object);
			abstract_menu := a_pulldown;
			xm_attach_menu (xm_option_button_gadget 
					(option_button.implementation.screen_object), 
					screen_object)
		end;

feature

	managed: BOOLEAN is
			--pass the manage test to the option button as it is
			-- the screen object
		do
			Result := option_button.managed;
		end;

	set_managed (flag: BOOLEAN) is
			--pass the set_manage test to the option button as it is
			-- the screen object
		do
			option_button.set_managed (flag);
		end;

	caption: STRING is
			-- the title on the option label gadget
		do
			Result := option_button.title;
		end;

	set_caption (new_title: STRING) is
			-- set the label of the option label gadget
		do
			option_button.set_title (new_title);
		end;
	
	remove_caption is
			-- remove the label of the option label gadget
		do
			option_button.remove_title;
		end;

	insensitive: BOOLEAN is
			-- check the sensitivity of the option button
		do
			Result := option_button.insensitive;
		end;

	set_insensitive (flag: BOOLEAN) is
			-- set the sensitivity of the option button
		do
			if flag then
				option_button.set_insensitive;
			else
				option_button.set_sensitive
			end;
		end;
	
	set_x (new_x: INTEGER) is
			-- set the x position of the option button
		do
			option_button.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
			-- set the y position of the option button
		do
			option_button.set_y (new_y);
		end;

	height: INTEGER is
			-- set the height of the option button
		do
			Result := option_button.height;
		end;

	width: INTEGER is
			-- set the width of the option button
		do
			Result := option_button.width;
		end;


	real_x: INTEGER is
			-- screen x position of the option button
		do
			Result := option_button.real_x;
		end;

	real_y: INTEGER is
			-- screen y position of the option button
		do
			Result := option_button.real_y;
		end;

	x: INTEGER is
			-- window x position of the option button
		do
			Result := option_button.x;
		end;

	y: INTEGER is
			-- window y position of the option button
		do
			Result := option_button.y;
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- window  position of the option button
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
			-- set the size of the option button
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
			-- set the width of the option button
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
			-- set the height of the option button
		do
			menu_set_height (new_height);
			option_button.set_height (new_height);
		end;

	set_foreground_color (a_color: COLOR) is
			--set foreground_color color on both option button and menu pane
		do
			option_button.set_foreground_color (a_color);
			menu_set_foreground_color (a_color);
		end;

	set_background_color (a_color: COLOR) is
			--set background color on both option button and menu pane
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

	create_pulldown (i_name: POINTER; scr_obj: POINTER): POINTER is
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
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
