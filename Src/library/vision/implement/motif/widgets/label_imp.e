indexing

	description: 
		"EiffelVision implementation of Motif label.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	LABEL_IMP

inherit

	LABEL_I;

	PRIMITIVE_IMP
		rename
			is_shown as shown
		undefine
			shown
		end;

	FONTABLE_IMP;

	BUTTON_IMP
		redefine
			is_label
		end

creation

	make

feature {NONE} -- Initialization

	make (a_label: LABEL; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif label.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_label_make (a_label.identifier, mc, man);
			a_label.set_font_imp (Current)
		end;

feature -- Access

	is_label: BOOLEAN is
			-- Is current button a label?
			-- (False by default)
		do
			Result := True
		end;

end -- class LABEL_IMP


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

