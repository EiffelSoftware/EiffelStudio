indexing

	description: 
		"EiffelVision implementation of a Motif form dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FORM_D_IMP

inherit

	FORM_D_I;

	DIALOG_IMP;

	FORM_IMP
		rename
			make as form_m_make
		undefine
			lower, raise, 
			hide, show, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable, created_dialog_automatically,
			form_make, create_widget
		redefine
			parent
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			attach_right as child_attach_right,
			attach_left as child_attach_left,
			attach_top as child_attach_top,
			attach_bottom as child_attach_bottom,
			detach_right as child_detach_right,
			detach_left as child_detach_left,
			detach_top as child_detach_top,
			detach_bottom as child_detach_bottom,
			is_shown as shown,
			is_valid as is_widget_valid
		undefine
			set_x, set_y, set_x_y, raise, lower, 
			show, hide
		redefine
			parent
		select
			form_make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_form_dialog: FORM_D; oui_parent: COMPOSITE) is
			-- Create a motif form dialog.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_make_no_auto_unmanage (a_form_dialog.identifier, mc);
			a_form_dialog.set_dialog_imp (Current);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL
			-- Dialog shell of the working dialog

end -- class FORM_D


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

