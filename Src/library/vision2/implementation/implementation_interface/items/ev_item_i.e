indexing	
	description: 
		"EiffelVision base item, implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_I

inherit
	EV_ANY_I

feature {NONE} -- Initialization

	make is
			-- Create an empty row with `par' as parent.
		deferred
		end

feature -- Access

	parent: EV_ITEM_HOLDER [EV_ITEM] is
			-- The parent of the Current widget
			-- Can be void.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

	parent_imp: EV_ITEM_HOLDER_IMP is
			-- The parent of the Current widget
			-- Can be void.
		require
			exists: not destroyed
		deferred
		end

	top_parent_imp: EV_ITEM_HOLDER_IMP is
			-- Top item holder containing the current item.
		local
			itm: EV_ITEM_IMP
		do
			itm ?= parent_imp
			if itm = Void then
				Result ?= parent_imp
			else
				Result := itm.top_parent_imp
			end
		end

	index: INTEGER is
			-- Index of the current item.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		ensure
			valid_index: index >= 1 and index <= parent.count + 1
		end

feature -- Element change

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		deferred
		ensure
			parent_set: parent_set (par)
		end

	set_parent_with_index (par: like parent; pos: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `pos'.
		require
			exists: not destroyed
			valid_index: pos >= 1 and pos <= par.count + 1
		deferred
		ensure
			index_set: index = pos
		end

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
			valid_index: pos >= 1 and pos <= parent.count + 1
		deferred
		ensure
			index_set: index = pos
		end

feature -- Assertion

	parent_set (par: like parent): BOOLEAN is
			-- Is the parent set
		do
			if parent_imp /= Void then
				Result := parent_imp.interface = par
			else
				Result := par = Void
			end
		end

end -- class EV_ITEM_I

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
