indexing

	description:
		"EiffelVision implementation of a font box dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FONT_BOX_D_IMP

inherit

	FONT_BOX_D_I;

	DIALOG_IMP;

	FONT_BOX_IMP
		rename
			make as fb_m_make
		undefine
			lower, raise, hide, show, destroy,
			define_cursor_if_shell,
			undefine_cursor_if_shell,
			is_stackable, created_dialog_automatically,
			create_widget, set_background, set_foreground,
			mel_set_background_color, mel_set_foreground_color
		redefine
			parent
		select
			fb_make_no_auto_unmanage, fb_make
		end;

	MEL_FONT_DIALOG
		rename
			make as mel_fb_d_make,
			make_no_auto_unmanage as mel_fb_d_no_auto,
			foreground_color as mel_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_foreground_color as mel_set_foreground_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			set_button_font as mel_set_button_font,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine
			parent
		end

creation
	make

feature {NONE} -- Initialization

	make (a_font_box_dialog: FONT_BOX_D; oui_parent: COMPOSITE) is
			-- Create a motif dialog message box.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			a_font_box_dialog.set_dialog_imp (Current);
			mel_fb_d_make (a_font_box_dialog.identifier, mc);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL
			-- Dialog shell of the working dialog

end -- class FONT_BOX_D_IMP


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

