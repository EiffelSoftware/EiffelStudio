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

feature -- Access

	parent: EV_ANY is
			-- The parent of the Current widget
			-- Can be void.
		require
			exists: not destroyed
		do
			if implementation.parent_imp /= Void then
				Result := implementation.parent_imp.interface
			else
				Result := Void
			end
		end

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		require
			exists: not destroyed
		do
			Result := implementation.parent_widget
		end

	data: ANY
			-- A data kept by the item
			-- May be redefine

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
