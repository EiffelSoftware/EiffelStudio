indexing

	description: 
		"EiffelVision implementation of a Motif error dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	ERROR_D_IMP

inherit

	ERROR_D_I;

	MESSAGE_D_IMP
		undefine
			create_widget
		redefine
			make, parent
		end;

	MEL_ERROR_DIALOG
		rename
			make as mel_error_make,
			make_no_auto_unmanage as mel_error_make_no_auto,
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
			mel_error_make, mel_error_make_no_auto
		end

creation

	make

feature {NONE} -- Initialization

	make (an_error_dialog: ERROR_D; oui_parent: COMPOSITE) is
			-- Create a motif error dialog.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_error_make_no_auto (an_error_dialog.identifier, mc);
			an_error_dialog.set_dialog_imp (Current);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL
			-- Dialog shell of the working dialog

end -- class ERROR_D_IMP


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

