indexing
	description:
		"EiffelVision tool-bar separator, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I

	EV_SEPARATOR_ITEM_IMP

creation
	make

feature -- Initialization

	make is
			-- create the widget
		do
		end

feature -- Access

	parent_imp: EV_ANY_I is
			-- The parent of the Current widget
			-- Can be void.
			-- XXX
		local
			tmp: EV_ANY_I
		do
			Result := tmp
		end

feature -- Element change

	set_parent (par: EV_ANY) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
		end

end -- class EV_TOOL_BAR_SEPARATOR_I

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
