indexing

	description:
		"EiffelVision implementation of Motif prompt dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PROMPT_D_M

inherit

	PROMPT_D_I;

	DIALOG_M
		redefine
			screen_object
		end;

	PROMPT_M
		rename
			make as prompt_make
		undefine
			lower, raise, hide,
			show, destroy, selection_make,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, clean_up, create_widget
		redefine
			screen_object
		end;

	MEL_PROMPT_DIALOG
		rename
			make as mel_prompt_d_make,
			make_no_auto_unmanage as mel_prompt_d_no_auto,
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
		select
			selection_make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_prompt_dialog: PROMPT_D; oui_parent: COMPOSITE) is
			-- Create a motif prompt dialog.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_prompt_d_no_auto (a_prompt_dialog.identifier,
				mel_parent (a_prompt_dialog, widget_index));
			a_prompt_dialog.set_dialog_imp (Current);
			action_target := screen_object;
			initialize (dialog_shell)
		end;

feature -- Access

	screen_object: POINTER
			-- Associated C widget pointer

end -- class PROMPT_D_M

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
