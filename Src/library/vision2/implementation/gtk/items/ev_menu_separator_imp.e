indexing
	description:
		"EiffelVision menu separator, implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I

	EV_SEPARATOR_ITEM_IMP

creation
	make

feature -- Initialisation

	make is
			-- Create a menu separator.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Element change

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			check
				To_be_implemented: False
			end
		end

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		do
			check
				To_be_implemented: False
			end
		end


end -- class EV_MENU_SEPARATOR_IMP

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
