indexing
	description: "Eiffel Vision menu item list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_LIST_IMP
	
inherit
	EV_MENU_ITEM_LIST_I

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]

	WEL_MENU
		rename
			make as wel_make,
			item as wel_item
		end

feature {NONE} -- Initialization

	initialize is
		do
			create ev_children.make (2)
			is_initialized := True
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- List of menu items in menu.

	insert_item (item_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Insert `item_imp' on `pos' in `ev_children'.
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			wel_menu: WEL_MENU
			menu_imp: EV_MENU_IMP
			menu_item_imp: EV_MENU_ITEM_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			pix_imp: EV_PIXMAP_IMP
		do
			menu_item_imp ?= item_imp

			ev_children.go_i_th (pos)
			ev_children.put_left (menu_item_imp)

			sep_imp ?= item_imp
			if sep_imp /= Void then
				insert_separator (pos - 1)
			else
				menu_imp ?= item_imp
				if menu_imp /= Void then
					wel_menu ?= menu_imp
					insert_popup (wel_menu, pos - 1, menu_imp.text)
				else
					--| FIXME Pixmaps to be implemented...
					--|	if menu_item_imp.pixmap /= Void then
					--|		pix_imp ?= menu_item_imp.pixmap.implementation
					--|		insert_bitmap (pix_imp.bitmap, pos - 1 , menu_item_imp.id)
					--|	end
					insert_string (menu_item_imp.text, pos - 1, menu_item_imp.id)

					radio_imp ?= item_imp
					if radio_imp /= Void then
						sep_imp := separator_imp_by_index (pos)
						if sep_imp /= Void then
							if sep_imp.radio_group = Void then
								sep_imp.create_radio_group
								radio_imp.enable_select
							end
							radio_imp.set_radio_group (sep_imp.radio_group)
						else
							if radio_group = Void then
								create radio_group.make
								radio_imp.enable_select
							end
							radio_imp.set_radio_group (radio_group)
						end
					end
				end
			end
		end

	remove_item (item_imp: EV_ITEM_IMP) is
			-- Remove `item_imp' from `ev_children'.
		local
			pos: INTEGER
			menu_item_imp: EV_MENU_ITEM_IMP
		do
			menu_item_imp ?= item_imp
			pos := ev_children.index_of (menu_item_imp, 1)
			delete_position (pos - 1)
			ev_children.go_i_th (pos)
			ev_children.remove
		end

	destroy is
		do
		end

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP is
			-- Get the impl. of last separator or `Void'.
		require
			index_within_bounds: index > 0 and then index <= ev_children.count
		local
			cur: CURSOR
			cur_item: INTEGER
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			cur := ev_children.cursor
			from
				ev_children.start
				cur_item := 1
			until
				ev_children.off or else an_index = cur_item
			loop
				sep_imp ?= ev_children.item
				if sep_imp /= Void then
					Result := sep_imp
				end
				ev_children.forth
				cur_item := cur_item + 1
			end
			ev_children.go_to (cur)
		end

feature {EV_ANY_I} -- Implementation

	menu_item_clicked (an_id: INTEGER) is
		local
			cur: CURSOR
			sub_menu: EV_MENU_IMP
			menu_item: EV_MENU_ITEM_IMP
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off
			loop
				menu_item := ev_children.item
				sub_menu ?= menu_item
				if sub_menu /= Void then
					sub_menu.menu_item_clicked (an_id)
				elseif menu_item.id = an_id then
					menu_item.on_activate
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
		end

end -- class EV_MENU_ITEM_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/23 02:23:16  brendel
--| Implemented radio grouping separated by menu-separators.
--| Added feature `menu_item_clicked' that tries to find the menu-item that
--| has been clicked based on its `id'.
--|
--| Revision 1.4  2000/02/22 18:39:46  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/02/05 02:16:08  brendel
--| Started implementing.
--| Remaining to be done:
--|  - pixmaps on menu items.
--|  - check menu item.
--|  - radio menu item.
--|
--| Revision 1.1.2.1  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

