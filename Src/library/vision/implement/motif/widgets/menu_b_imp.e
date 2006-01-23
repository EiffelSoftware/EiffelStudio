indexing

	description: 
		"EiffelVision implementation of a Motif menu cascade button."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	MENU_B_IMP

inherit

	MENU_B_I;

	BUTTON_IMP
		redefine
			parent
		end;

	FONTABLE_IMP;

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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		redefine
			parent
		end


create

	make

feature {NONE} -- Initialization

	make (a_menu_b: MENU_B; man: BOOLEAN; oui_parent: MENU) is
			-- Create a motif menu button.
		local
			mc: MEL_ROW_COLUMN
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_cascade_make (a_menu_b.identifier, mc, man);
			a_menu_b.set_font_imp (Current);
			set_mnemonic_from_text (a_menu_b.identifier, False)
		end

feature -- Access

	parent: MEL_ROW_COLUMN
			-- Parent of menu button

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MENU_B_IMP

