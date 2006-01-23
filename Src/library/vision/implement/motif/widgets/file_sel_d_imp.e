indexing

	description:
		"EiffelVision Implementation of a Motif file selection box."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	FILE_SEL_D_IMP

inherit

	FILE_SEL_D_I;

	DIALOG_IMP;

	FILE_SELEC_IMP
		rename
			make as file_select_m_make,
			make_no_auto_unmanage as file_select_m_make_no_auto_unmanage
		undefine
			lower, raise, 
			show, hide, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			created_dialog_automatically, is_stackable, file_selection_make
		redefine
			parent
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			dir_list as mel_dir_list,
			set_pattern as mel_set_pattern,
			pattern as mel_pattern,
			set_directory as mel_set_directory,
			directory as mel_directory,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine
			parent
		end

create

	make

feature {NONE} -- Initialization

	make (a_file_select_dialog: FILE_SEL_D; oui_parent: COMPOSITE) is
			-- Create a motif file selection dialog.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_file_selection_d_make (a_file_select_dialog.identifier, mc);
			a_file_select_dialog.set_dialog_imp (Current);
			initialize (parent)
		end;

feature -- Access

    parent: MEL_DIALOG_SHELL
            -- Dialog shell of the working dialog

feature -- Status setting

	set_open_file is
			-- Set dialog to open file dialog.
		do
		end

	set_save_file is
			-- Set dialog to save file dialog.
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




end -- class FILE_SEL_D_IMP

