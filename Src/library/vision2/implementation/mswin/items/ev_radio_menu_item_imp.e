indexing	
	description: 
		"EiffelVision radio menu item. Implementatino interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I

	EV_CHECK_MENU_ITEM_IMP
		redefine
			on_activate,
			destroy
		end

creation
	make,
	make_with_text

feature -- Status report

	is_peer (peer: EV_RADIO_MENU_ITEM): BOOLEAN is
			-- Is this item in same group as peer?
		local
			peer_imp: EV_RADIO_MENU_ITEM_IMP
		do
			peer_imp ?= peer.implementation
			check
				valid_peer: peer_imp /= Void
			end
			Result := group.has (peer_imp)
		end

feature -- Status Setting

	set_peer (peer: EV_RADIO_MENU_ITEM) is
			-- Put in same group as peer.
		local
			a_group: EV_MENU_GROUP_IMP
			peer_imp: EV_RADIO_MENU_ITEM_IMP
		do
			peer_imp ?= peer.implementation
			check
				valid_peer: peer_imp /= Void
			end
			if peer_imp.group /= Void then
				set_group (peer_imp.group)
			else
				!! a_group.make
				set_group (a_group)
				peer_imp.set_group (a_group)
			end
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activate.
		do
			if group /= Void then
				group.uncheck_other_items (Current)
			end
			set_state (True)
			execute_command (Cmd_item_activate, Void)
		end

feature {EV_RADIO_MENU_ITEM_IMP} -- Implementation

	group: EV_MENU_GROUP_IMP
			-- Current group of the item

	set_group (a_group: EV_MENU_GROUP_IMP) is
			-- Make `a_group' the current group and add the 
			-- item to it.
		do
			a_group.add_item (Current)
			group := a_group
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy the current item.
		do
			group.remove_item (Current)
			parent_imp.remove_item (id)
		end

end -- class EV_RADIO_MENU_ITEM_IMP

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
