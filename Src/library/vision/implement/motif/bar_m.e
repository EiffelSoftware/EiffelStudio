indexing

	description: 
		"EiffelVision implementation of a Motif menu bar.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BAR_M 

inherit

	BAR_I;

	MANAGER_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
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
			screen as mel_screen,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_bar: BAR; man: BOOLEAN) is
			-- Create a motif bar menu.
		do
			widget_index := widget_manager.last_inserted_position;
			bar_make (a_bar.identifier,
					mel_parent (a_bar, widget_index),
					man);
		end;

feature -- Status report

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
		local
			widget_m: WIDGET_M
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
			set_resize_height (True);
			set_resize_width (True)
		end;

	forbid_recompute_size  is
			-- Disable the recompute size.
		do
			set_resize_height (False);
			set_resize_width (False)
		end;

end -- class BAR_M

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
