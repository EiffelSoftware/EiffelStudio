indexing

	description: 
		"EiffelVision implementation of a Motif bulletin dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BULLETIN_D_IMP

inherit

	BULLETIN_D_I;

	DIALOG_IMP;

	BULLETIN_IMP
		rename
			make as bulletin_m_make
		undefine
			lower, raise, 
			show, hide, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, created_dialog_automatically,
			create_widget, bulletin_make, bulletin_make_no_auto_unmanage
		redefine
			parent
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		undefine
			raise, lower, show, hide
		redefine
			parent
		end

creation

	make

feature {NONE} -- Initialization

	make (a_bulletin_d: BULLETIN_D; oui_parent: COMPOSITE) is
			-- Create a motif bulletin dialog.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_make_no_auto_unmanage (a_bulletin_d.identifier, mc);
			a_bulletin_d.set_dialog_imp (Current);
			set_margin_width (0);
			set_margin_height (0);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL
			-- Dialog shell of the working dialog

end -- class BULLETIN_D_IMP


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

