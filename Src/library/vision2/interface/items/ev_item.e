indexing
	description:
		" EiffelVision base item. Base class of all the items.%
		% Each base item fits in a specific control. For example,%
		% an EV_LIST_ITEM will go into an EV_LIST and an%
		% EV_MULTI_COLUMN_LIST_ITEM into a EV_MULTI_COLUMN_LIST."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM

inherit
	EV_ANY
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make (par: like parent) is
			-- Create the widget with `par' as parent.
		deferred
		end

	make_with_index (par: like parent; pos: INTEGER) is
			-- Create a row at the given `value' index in the list.
		require
			valid_parent: par /= Void
			valid_index: pos >= 0 and pos <= par.count
		do
			-- create {?} implementation.make
			check
				valid_implementation: implementation /= Void
			end
			implementation.set_interface (Current)
			set_parent_with_index (par, pos)
		ensure
			parent_set: parent.is_equal (par)
			index_set: index = pos
		end

feature -- Access

	parent: EV_ITEM_HOLDER [EV_ITEM] is
			-- The parent of the Current widget
			-- Can be void.
		require
			exists: not destroyed
		do
			Result := implementation.parent
		end

	top_parent: EV_ITEM_HOLDER [EV_ITEM] is
			-- Top item holder that contains the current item.
		require
			exists: not destroyed
		do
			if implementation.top_parent_imp = Void then
				Result := Void
			else
				Result ?= implementation.top_parent_imp.interface
			end
		end

	data: ANY
			-- A data kept by the item
			-- May be redefine

	index: INTEGER is
			-- One based index of the current item
			-- in its parent.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.index
		ensure
			valid_index: index >= 1 and index <= parent.count
		end

feature -- Element change

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
			-- Can be used only if the item has no children
		require
			exists: not destroyed
		do
			implementation.set_parent (par)
		ensure
			parent_set: parent = par
		end

	set_parent_with_index (par: like parent; pos: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `pos'.
		require
			exists: not destroyed
			valid_index: pos >= 1 and pos <= par.count + 1
		do
			implementation.set_parent_with_index (par, pos)
		ensure
			parent_set: parent = par
			index_set: index = pos
		end

	set_data (a: like data) is
			-- Make `a' the new data of the item.
		require
			exists: not destroyed
		do
			data := a
		ensure
			data_set: (data /= Void) implies (data.is_equal (a))
				and (data = Void) implies (a = Void)
		end

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item.
		require
			exists: not destroyed
			has_parent: parent /= Void
			valid_index: pos >= 1 and pos <= parent.count + 1
		do
			implementation.set_index (pos)
		ensure
			index_set: index = pos
		end

feature -- Implementation

	implementation: EV_ITEM_I
		-- Platform dependent access.

end -- class EV_ITEM

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
