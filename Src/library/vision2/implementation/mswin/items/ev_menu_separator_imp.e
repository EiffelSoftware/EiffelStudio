indexing
	description:
		"EiffelVision menu separator, mswindows implemenatation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		redefine
			parent_imp
		end

	EV_SEPARATOR_ITEM_IMP
		redefine
			parent_imp,
			set_parent,
			set_parent_with_index,
			set_index
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		do
			-- Nothing usefull to do
		end

feature -- Access

	parent_imp: EV_MENU_ITEM_HOLDER_IMP
			-- Parent implementation

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the menu.
		do
			Result := False
		end

feature -- Element change

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		do
			parent_imp.move_separator (Current, pos)
		end

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				parent_imp.remove_separator (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_separator (Current)
			end
		end

	set_parent_with_index (par: like parent; pos: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `pos'.
		do
			if parent_imp /= Void then
				parent_imp.remove_separator (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.insert_separator (Current, pos)
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
--|----------------------------------------------------------------
