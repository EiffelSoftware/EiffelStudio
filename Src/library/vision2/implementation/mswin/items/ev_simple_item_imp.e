indexing	
	description: "EiffelVision item. Mswindows implementation"
	note: "It is not necessary to inherit from%
		% EV_TEXTABLE_IMP because all the features%
		% use `wel_window', but such a big object isn't%
		% necessary here."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_SIMPLE_ITEM_IMP

inherit
	EV_SIMPLE_ITEM_I

	EV_ITEM_IMP

	EV_PIXMAPABLE_IMP

feature -- Access

	text: STRING
			-- Current label of the item

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			text := txt
		end

feature {NONE} -- Implementation

	parent_imp: EV_ITEM_HOLDER_IMP is
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

end -- class EV_SIMPLE_ITEM_IMP

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
