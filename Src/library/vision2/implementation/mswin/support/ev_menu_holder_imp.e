indexing
	description: "EiffelVision menu-container, Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_HOLDER_IMP

inherit
	EV_MENU_HOLDER_I

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		deferred
		end

feature {EV_MENU_IMP} -- Implementation

	add_menu (menu_imp: EV_MENU_IMP) is
			-- Add `a_menu' into container.
		do
			menu_container.append_popup (menu_imp, menu_imp.text)
			menu_imp.set_position (menu_container.count)
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove menu_imp from the container.
		do
			menu_container.delete_position (menu_imp.position)
		end

feature {EV_MENU_IMP} -- Implementation

	menu_container: WEL_MENU is
			-- Actual WEL container
		deferred
		end

	ev_children: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- List of all the children

end -- class EV_MENU_HOLDER_IMP

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
