indexing
	description: "EiffelVision item container. This class  %
			% has been created to centralise the     %
			% implementation of several features for %
			% EV_LIST_IMP and EV_MENU_ITEM_CONTAINER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_CONTAINER_IMP

feature -- Initialization

	initialize is
			-- Initilize all the parameters of the container.
		do
			!! ev_children.make
		end

feature {NONE} -- Access

	ev_children: LINKED_LIST [EV_ITEM_IMP]
			-- List of all the children of the container
			-- In most case, the index of the child is its id.

feature {NONE} -- Implementation

	name_item: STRING
			-- Name of the item that is going to be add
			-- When an item is created, it called this feature
			-- to stock his name temporary and once the string has
			-- been added in the menu, the name of the item is
			-- stored in the menu

feature {EV_ITEM_IMP} -- Implementation

	set_name (new_name: STRING) is
			-- Set `name_item' to `new_name'. This string corresponds
			-- to the name of the item that will be added next.
			-- This feature avoid to have a name feature on each
			-- menu item.
		require
			new_name /= Void
		do
			name_item := new_name
		end

end -- class EV_ITEM_CONTAINER_IMP

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
