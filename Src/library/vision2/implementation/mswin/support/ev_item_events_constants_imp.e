indexing
	description: "This class is used by EV_ITEM_IMP. It gives%
				% the identifications of the different events%
				% that can occur. It is a class of constants"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ITEM_EVENTS_CONSTANTS_IMP

feature -- General events for items

	Cmd_item_activate: INTEGER is 1
			-- The item has been selected

	Cmd_item_dblclk: INTEGER is 2
			-- The user dblclk on the item

end -- class EV_ITEM_EVENTS_CONSTANTS_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
