indexing

	description:
		"EiffelVision implementation of a font box dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FONT_B_D_M 

inherit

	FONT_B_D_I;

	DIALOG_M;

	FONT_BOX_M
		rename
			make as font_box_make
		undefine
			lower, raise, 
			show, hide, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable
		redefine
			mel_destroy, parent
		end

creation

	make

feature {NONE} -- Creation

	make (a_font_box_dialog: FONT_BOX_D; oui_parent: COMPOSITE) is
			-- Create a motif font box.
		local
			ext_name: ANY;
			so: POINTER;
			mel_comp: MEL_COMPOSITE;
			form_button: MEL_FORM
		do
			so := oui_parent.implementation.screen_object;
			mel_comp ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_font_box_dialog.identifier.to_c;
			data := font_box_create ($ext_name, so, True, True);
			screen_object := font_box_form (data);
			a_font_box_dialog.set_dialog_imp (Current);
			!! parent.make_from_existing (xt_parent (screen_object), mel_comp);
			Mel_widgets.add (Current);
			!! form_button.make_from_existing (xt_parent (font_box_ok_button (data)), Current);
            !! ok_b.make_from_existing (font_box_ok_button (data), form_button);
            !! cancel_b.make_from_existing (font_box_cancel_button (data), form_button);
            !! apply_b.make_from_existing (font_box_apply_button (data), form_button);
			initialize (parent)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL;
			-- Dialog shell where font box is in

feature -- Removal

	mel_destroy is
			-- Destroy the dialog shell of the font box.
		do
			parent.destroy
		end;

end -- class FONT_B_D_M

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
