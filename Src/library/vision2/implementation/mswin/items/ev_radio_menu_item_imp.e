indexing	
	description: "Eiffel Vision radio menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface,
			on_activate,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize with state `is_selected'.
		do
			Precursor
			is_selected := True
		end

feature {EV_ANY_I} -- Status report

	is_selected: BOOLEAN

feature {EV_ANY_I} -- Status setting

	disable_select is
			-- Assign `False' to `is_selected'.
		do
			is_selected := False
		end
	
	enable_select is
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					parent_imp.uncheck_item (radio_group.item.id)
					radio_group.item.disable_select
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			is_selected := True
			if has_parent then
				parent_imp.check_item (id)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_MENU_ITEM

feature {NONE} -- Implementation

	on_activate is
			-- Enable this item and call `Precursor'.
		do
			enable_select
			Precursor
		end

end -- class EV_RADIO_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

