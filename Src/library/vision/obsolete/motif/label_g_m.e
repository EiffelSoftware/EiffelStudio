indexing

	description: 
		"iffelVision implementation of Motif label gadget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LABEL_G_M 

inherit

	LABEL_G_I;

	BUTTON_G_M

creation

	make

feature {NONE} -- Initialization

	make (a_label_gadget: LABEL_G; man: BOOLEAN) is
			-- Create a motif label gadget.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_label_make (a_label_gadget.identifier,
					mel_parent (a_label_gadget, widget_index),
					man);
			a_label_gadget.set_font_imp (Current)
		end;

end -- class LABEL_G_M

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
