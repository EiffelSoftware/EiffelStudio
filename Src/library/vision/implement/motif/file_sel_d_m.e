indexing

	description:
		"EiffelVision Implementation of a Motif file selection box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FILE_SEL_D_M 

inherit

	FILE_SEL_D_I;

	DIALOG_M
		redefine
			screen_object
		end;

	FILE_SELEC_M
		rename
			make as file_select_m_make,
			make_no_auto_unmanage as file_select_m_make_no_auto_unmanage
		undefine
			lower, raise, 
			show, hide, is_shown, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			clean_up, is_stackable, file_selection_make
		redefine
			screen_object
		select
			file_select_m_make_no_auto_unmanage
		end;

	MEL_FILE_SELECTION_DIALOG
		rename
			make as mel_file_selection_d_make,
			foreground_color as mel_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_foreground_color as mel_set_foreground_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			dir_list as mel_dir_list,
			set_pattern as mel_set_pattern,
			pattern as mel_pattern,
			set_directory as mel_set_directory,
			directory as mel_directory
		undefine
			raise, lower, show, hide, is_shown
		redefine
			screen_object
		end

creation

	make

feature {NONE} -- Initialization

	make (a_file_select_dialog: FILE_SEL_D) is
			-- Create a motif file selection dialog.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			mel_file_selection_d_make (a_file_select_dialog.identifier,
					mel_parent (a_file_select_dialog, widget_index))
			a_file_select_dialog.set_dialog_imp (Current);
			action_target := screen_object;
			initialize (dialog_shell)
		end;

feature -- Access

	screen_object: POINTER
			-- Associated C widget pointer

end -- class FILE_SEL_D_M

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
