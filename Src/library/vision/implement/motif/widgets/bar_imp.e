indexing

	description: 
		"EiffelVision implementation of a Motif menu bar.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BAR_IMP

inherit

	BAR_I;

	MENU_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_title, remove_title, title
		end;

	MEL_MENU_BAR
		rename
			make as bar_make,
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
		end

creation

	make

feature {NONE} -- Initialization

	make (a_bar: BAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif bar menu.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			bar_make (a_bar.identifier, mc, man)
		end;

feature -- Status report

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
		local
			widget_m: WIDGET_IMP
		do
			widget_m ?= menu_help_widget;
			if widget_m /= Void then
				Result ?= widget_m.widget_oui
			end;
		end;

	title: STRING is
			-- Title of current menu
		do
			Result := ""
		end;

	remove_title is
			-- Remove current menu title if any.
		do
			-- Do nothing
		end;

feature -- Status setting

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		do
		end;

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		local
			mel_cb: MEL_CASCADE_BUTTON
		do
			mel_cb ?= button.implementation;
			set_menu_help_widget (mel_cb)
		end;

	allow_recompute_size  is
			-- Enable the recompute size.
		do
			enable_resize_height;
			enable_resize_width
		end;

	forbid_recompute_size  is
			-- Disable the recompute size.
		do
			disable_resize_height;
			disable_resize_width
		end;

end -- class BAR_IMP


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

