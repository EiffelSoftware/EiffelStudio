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
			on_activate
		end

creation
	make_with_text

feature -- Status report

	is_peer (peer: EV_RADIO_MENU_ITEM): BOOLEAN is
			-- Is this item in same group as peer?
		do
			Result := True
--			check
--				not_yet_implemented: False
--			end
		end

feature -- Status Setting

	set_peer (peer: EV_RADIO_MENU_ITEM) is
			-- Put in same group as peer.
		do
--			check
--				not_yet_implemented: False
--			end
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activate.
		do
--			parent_imp.uncheck_radio_items
			set_state (True)
			execute_command (Cmd_item_activate, Void)
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
