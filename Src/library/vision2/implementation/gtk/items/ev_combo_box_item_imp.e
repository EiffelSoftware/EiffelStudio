indexing
	description: "EiffelVision combo box item , gtk implementation";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_COMBO_BOX_ITEM_IMP

inherit
	EV_COMBO_BOX_ITEM_I

	EV_ITEM_IMP

creation
	make_with_text,
	make

feature {NONE} -- Initialization

	make (par: EV_COMBO_BOX) is
			-- Create a combo-box item with no label and add it
			-- to `par'.
		do
		end	

	make_with_text (par: EV_COMBO_BOX; txt: STRING) is
			-- Create a combo-box item with `txt' for  label and
			-- add it in the `par'.
		do
		end	

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
		end	

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
		end	

end -- class EV_COMBO_BOX_ITEM_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

