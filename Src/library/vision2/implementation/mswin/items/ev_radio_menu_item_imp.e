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
		undefine
			on_draw_menu_item_left_part
		redefine
			interface,
			on_activate,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

	EV_CHECKABLE_MENU_ITEM_IMP

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

	check_mark_bitmap_constant: INTEGER is
			-- Constant coding for the check mark used in Current.
		do
			Result := Wel_drawing_constants.Dfcs_menubullet
		end

end -- class EV_RADIO_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

