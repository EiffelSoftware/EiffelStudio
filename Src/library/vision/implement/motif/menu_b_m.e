indexing

	description: 
		"EiffelVision implementation of a Motif menu cascade button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	MENU_B_M 

inherit

	MENU_B_I;

	BUTTON_M;

	FONTABLE_M;

	MEL_CASCADE_BUTTON
		rename
			make as mel_cascade_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			is_shown as shown
		select
			mel_cascade_make
		end


creation

	make

feature {NONE} -- Initialization

	make (a_menu_b: MENU_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif menu button.
		do
			widget_index := widget_manager.last_inserted_position;
				mel_cascade_make (a_menu_b.identifier,
						  mel_parent (a_menu_b, widget_index),
						  man);
			a_menu_b.set_font_imp (Current)
		end

feature -- Status setting

	allow_recompute_size is
			-- Allow Current to recompute its size
			-- according to the children.
		do
			set_recomputing_size_allowed (True)
		end;

	forbid_recompute_size is
			-- Forbid Current to recompute its size
			-- according to the children.
		do
			set_recomputing_size_allowed (False)
		end;

feature -- Element change

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		local
			mel_rc: MEL_ROW_COLUMN
		do
			mel_rc ?= a_menu.implementation;
			set_sub_menu (mel_rc);
		end;

feature {NONE} -- Implementation

	add_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

	add_release_action (a_command: COMMAND; argument: ANY) is
		do
		end

	add_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_release_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end

end -- class MENU_B_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|	Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
