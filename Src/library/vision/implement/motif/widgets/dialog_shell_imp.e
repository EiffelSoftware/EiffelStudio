indexing

	description: 
		"EiffelVision implementation of a Motif dialog shell.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	DIALOG_SHELL_IMP

inherit

	DIALOG_SHELL_I;

	WM_SHELL_IMP
		rename
			is_shown as shown
		undefine
			popdown, make_from_existing, mel_destroy, mel_set_insensitive
		end;

	POPUP_SHELL_IMP
		undefine
			make_from_existing, mel_destroy, mel_set_insensitive
		end;

	MEL_DIALOG_SHELL
		rename
			make as mel_dialog_make,
			icon_mask as mel_icon_mask,
			set_icon_mask as mel_set_icon_mask,
			icon_pixmap as mel_icon_pixmap,
			set_icon_pixmap as mel_set_icon_pixmap,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		undefine
			popdown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_dialog_shell: DIALOG_SHELL; oui_parent: COMPOSITE) is
			-- Create a dialog shell.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_dialog_make (a_dialog_shell.identifier, mc);
			a_dialog_shell.set_wm_imp (Current);
			initialize (Current)
		end;

end -- class DIALOG_SHELL_IMP


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

