indexing

	description: 
		"EiffelVision implementation of Motif pulldown menu for an option button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	OPT_PULL_IMP

inherit

	OPT_PULL_I;

	MENU_IMP
		rename
			set_foreground_color as menu_set_foreground_color,
			set_background_color as menu_set_background_color,
			set_size as menu_set_size,
			set_width as menu_set_width,
			set_height as menu_set_height,
			set_managed as menu_set_managed,
			managed as menu_managed,
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_x_y, real_x, real_y, x, y, set_x, set_y, height, width,
			set_insensitive, insensitive, children_has_accelerators,
			parent
		end;

	MENU_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_x_y, set_size, set_width, set_height, real_x, real_y, x, y,
			set_x, set_y, height, width, managed, set_managed,
			set_foreground_color, set_background_color,
			set_insensitive, insensitive, children_has_accelerators,
			parent
		select
			set_size, set_width, set_height, 
			set_foreground_color, set_background_color,
			set_managed, managed
		end;

	MEL_PULLDOWN_MENU
		rename
			make as mel_make_menu_pull,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		redefine
			set_size, set_width, set_height, 
			set_x, set_x_y, set_y, real_x, real_y,
			x, y, height, width, parent
		end

creation

	make

feature {NONE} -- Initialization

	make (a_pulldown: OPT_PULL; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif pulldown menu.
		local
			pulldown_identifier: STRING;
			mel_opt_menu: MEL_OPTION_MENU
		do
				-- The widget index is incremented by one since
				-- the option_button will be inserted before Current
				-- in the widget_manager
			widget_index := widget_manager.last_inserted_position + 1;
			pulldown_identifier := clone (a_pulldown.identifier);
			pulldown_identifier.append ("_pull");
			if man then
				!! option_button.make (a_pulldown.identifier, oui_parent);
			else
				!! option_button.make_unmanaged (a_pulldown.identifier, oui_parent);
			end;
			mel_opt_menu ?= option_button.implementation;
			mel_make_menu_pull (pulldown_identifier, mel_opt_menu);
			mel_opt_menu.set_sub_menu (Current)		
			abstract_menu := a_pulldown;
		end;

feature -- Access

	parent: MEL_MENU_SHELL;
			-- Parent of option pull

	children_has_accelerators: BOOLEAN is
			-- Can children have accelerators?
			-- (No it can't)
		do
		end;

feature -- Status report

	managed: BOOLEAN is
			-- Pass the manage test to the option button as it is
			-- the screen object
		do
			Result := option_button.managed;
		end;

	caption: STRING is
			-- the title on the option label gadget
		do
			Result := option_button.title;
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
	
	height: INTEGER is
			-- Height of the option button
		do
			Result := option_button.height;
		end;

	width: INTEGER is
			-- Width of the option button
		do
			Result := option_button.width;
		end;

	real_x: INTEGER is
			-- Screen x position of the option button
		do
			Result := option_button.real_x;
		end;

	real_y: INTEGER is
			-- Screen y position of the option button
		do
			Result := option_button.real_y;
		end;

	x: INTEGER is
			-- Window x position of the option button
		do
			Result := option_button.x;
		end;

	y: INTEGER is
			-- Window y position of the option button
		do
			Result := option_button.y;
		end;

	selected_button: BUTTON is
	   		-- Current Push Button selected in the option menu
		do
			Result := option_button.selected_button
		end;

	text: STRING is
			-- Label of option button
		do
			Result := option_button.text
		end;

feature -- Status setting

	set_managed (flag: BOOLEAN) is
			-- Pass the set_manage test to the option button as it is
			-- the screen object
		do
			option_button.set_managed (flag);
		end;

	set_caption (new_title: STRING) is
			-- Set the label of the option label gadget.
		do
			option_button.set_title (new_title);
		end;

	set_x (new_x: INTEGER) is
			-- Set the x position of the option button.
		do
			option_button.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
			-- Set the y position of the option button.
		do
			option_button.set_y (new_y);
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Window  position of the option button
		do
			option_button.set_x_y (new_x, new_y);
		end;

   	set_selected_button (button: BUTTON) is
		   	-- Set `selected_button' to `button'
		do
			option_button.set_selected_button (button);	
		end;

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		do
			option_button.set_text (a_text)
		end;

	set_size (new_width, new_height: INTEGER) is
			-- Set the size of the option button.
		local
			nw: INTEGER;
		do
			nw := new_width;
			if option_button.title.is_empty then
				menu_set_size (nw, new_height);
			else
				menu_set_size (nw - option_button.title_width, new_height);
			end;
			option_button.set_size (new_width, new_height);
		end;

	set_width (new_width: INTEGER) is
			-- Set the width of the option button.
		local
			nw: INTEGER;
		do
			nw := new_width;
			if option_button.title.is_empty then
				menu_set_width (nw - option_button.title_width);
			else
				menu_set_width (nw);
			end;
			option_button.set_width (new_width);
		end;

	set_height (new_height: INTEGER) is
			-- Set the height of the option button.
		do
			menu_set_height (new_height);
			option_button.set_height (new_height);
		end;

	set_foreground_color (a_color: COLOR) is
			-- Set foreground_color color on both option button and menu pane.
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
			-- Allow resize for pull down.
		do
			option_button.allow_recompute_size;
			enable_resize_width;
			enable_resize_height
		end;

	forbid_recompute_size  is
			-- Allow resize for pull down.
		do
			option_button.forbid_recompute_size;
			disable_resize_width;
			disable_resize_height 
		end;

feature -- Removal
	
	remove_caption is
			-- Remove the label of the option label gadget.
		do
			option_button.remove_title;
		end;

end -- class OPT_PULL_IMP


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

