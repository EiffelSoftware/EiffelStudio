indexing

	description: 
		"EiffelVision implementation of a Motif bulletin dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BULLETIN_D_M 

inherit

	BULLETIN_D_I;

	DIALOG_M
		redefine	
			screen_object
		end;

	BULLETIN_M
		rename
			make as bulletin_m_make
		undefine
			lower, raise, 
			show, hide, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, clean_up,
			create_widget, bulletin_make, bulletin_make_no_auto_unmanage
		redefine
			screen_object
		end;

	MEL_BULLETIN_BOARD_DIALOG
		rename
			make as mel_bulletin_d_make,
			make_no_auto_unmanage as mel_make_no_auto_unmanage,
			foreground_color as mel_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_foreground_color as mel_set_foreground_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine	
			screen_object
		end

creation

	make

feature {NONE} -- Initialization

	make (a_bulletin_d: BULLETIN_D) is
			-- Create a motif bulletin dialog.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_make_no_auto_unmanage (a_bulletin_d.identifier,
				mel_parent (a_bulletin_d, widget_index));
			a_bulletin_d.set_dialog_imp (Current);
			action_target := screen_object;
			set_margin_width (0);
			set_margin_height (0);
			initialize (dialog_shell)
		end;

feature -- Access

	screen_object: POINTER
			-- Associated C widget pointer

end -- class BULLETIN_D_M

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
