indexing
	description:
		"EiffelVision tree-item container, gtk implementation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_CONTAINER_IMP

inherit
	EV_TREE_ITEM_CONTAINER_I

	EV_WIDGET_IMP
		-- Inheriting from widget, because tree item and subtree
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

feature {EV_TREE_ITEM} -- Implementation

	add_item (item: EV_TREE_ITEM) is
			-- Add `item' to the list
		deferred
		end

end -- class EV_TREE_ITEM_CONTAINER_IMP

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
