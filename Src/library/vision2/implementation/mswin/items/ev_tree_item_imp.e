indexing
	description: "Eiffel Vision tree item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		redefine
			interface
		end

	EV_TREE_NODE_IMP
		undefine
			parent
		redefine
			interface,
			set_tooltip
		end

create
	make

feature {NONE} -- Implementation

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
				-- Assign `a_tooltip' to `tooltip'.
			tooltip := clone (a_tooltip)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM

end -- class EV_TREE_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

