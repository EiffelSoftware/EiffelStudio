indexing
	description: "EiffelVision menu-container, Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_CONTAINER_IMP

inherit
	EV_MENU_CONTAINER_I

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		do
		end

feature {EV_MENU_CONTAINER} -- Implementation

	add_menu (menu: EV_MENU) is
			-- Add `a_menu' into container.
		local
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= menu.implementation
			check
				menu_imp /= Void
			end
			menu_container.append_popup (menu_imp, menu_imp.text)
			menu_imp.set_position (menu_container.count)
			menu_imp.set_parent_container (Current)
		end

feature {EV_MENU_IMP} -- Implementation

	menu_container: WEL_MENU is
			-- Actual WEL container
		deferred
		end

	ev_children: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- List of all the children

end -- class EV_MENU_CONTAINER_IMP

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
