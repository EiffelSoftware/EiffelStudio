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
		rename
			is_shown as shown
		end;

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

feature -- Status setting

	allow_recompute_size is
			-- Allow Current to recompute its size
			-- according to the children.
		do
			set_recomputing_size_allowed (True)
		end;

	forbid_recompute_size is
			-- Forbid Current to recompute its size
			-- according to the children.
		do
			set_recomputing_size_allowed (False)
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
