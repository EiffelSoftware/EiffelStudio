indexing

	description:
		"EiffelVision implementation of Motif prompt dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PROMPT_D_IMP

inherit

	PROMPT_D_I;

	DIALOG_IMP;

	SELECTION_IMP
		rename
			make as sel_make
		undefine
			lower, raise, hide,
			show, destroy, selection_make,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, created_dialog_automatically, create_widget
		redefine
			parent
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine
			parent
		select
			selection_make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_prompt_dialog: PROMPT_D; oui_parent: COMPOSITE) is
			-- Create a motif prompt dialog.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_prompt_d_no_auto (a_prompt_dialog.identifier, mc);
			a_prompt_dialog.set_dialog_imp (Current);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL
			-- Dialog shell of the working dialog

end -- class PROMPT_D_IMP


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

