indexing

	description: 
		"EiffelVision implementation of a Motif form dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FORM_D_M

inherit

	FORM_D_I;

	DIALOG_M
		redefine
			screen_object
		end;

	FORM_M
		rename
			make as form_m_make
		undefine
			lower, raise, 
			hide, show, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, clean_up,
			form_make, create_widget
		redefine
			screen_object
		end;

	MEL_FORM_DIALOG
		rename
			make as mel_form_d_make,
			make_no_auto_unmanage as mel_make_no_auto_unmanage,
			foreground_color as mel_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_foreground_color as mel_set_foreground_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			attach_right as mel_attach_right,
			attach_left as mel_attach_left,
			attach_top as mel_attach_top,
			attach_bottom as mel_attach_bottom,
			detach_right as mel_detach_right,
			detach_left as mel_detach_left,
			detach_top as mel_detach_top,
			detach_bottom as mel_detach_bottom,
            is_shown as shown
		undefine
			set_x, set_y, set_x_y, raise, lower, 
			show, hide
		redefine
			screen_object
		select
			form_make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_form_dialog: FORM_D; oui_parent: COMPOSITE) is
			-- Create a motif form dialog.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_make_no_auto_unmanage (a_form_dialog.identifier,
				mel_parent (a_form_dialog, widget_index));
			a_form_dialog.set_dialog_imp (Current);
			action_target := screen_object;
			initialize (dialog_shell)
		end;

feature -- Access

	screen_object: POINTER
			-- Associated C widget pointer

end -- class FORM_D

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
