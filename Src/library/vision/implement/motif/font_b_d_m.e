indexing

	description:
		"EiffelVision implementation of a font box dialog.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FONT_B_D_M 

inherit

	FONT_B_D_I;

	DIALOG_M
		redefine
			screen_object
		end;

	FONT_BOX_M
		rename
			make as font_box_make
		undefine
			lower, raise, 
			show, hide, is_shown, destroy,
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable
		redefine
			mel_destroy, screen_object
		end

creation

	make

feature {NONE} -- Creation

	make (a_font_box_dialog: FONT_BOX_D) is
			-- Create a motif font box.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_font_box_dialog.identifier.to_c;
			data := font_box_create ($ext_name,
					parent_screen_object (a_font_box_dialog, widget_index),
					True, True);
			screen_object := font_box_form (data);
			a_font_box_dialog.set_dialog_imp (Current);
			action_target := screen_object;
			!! dialog_shell.make_from_existing (xt_parent (screen_object));
			initialize (dialog_shell)
		end;

feature -- Access

	dialog_shell: MEL_DIALOG_SHELL;
			-- Dialog shell where font box is in

	screen_object: POINTER
			-- Associated C widget pointer

feature -- Removal

	mel_destroy is
			-- Destroy the dialog shell of the font box.
		do
			dialog_shell.destroy
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
