indexing
	description: "Eiffel Vision menu item list. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_LIST_IMP
	
inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]
		redefine
			insert_i_th,
			interface,
			remove_i_th
		end

feature {NONE} -- implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		do
			check do_not_call: False end
		end

	insert_i_th (v: like item; pos: INTEGER) is
		local
			an_item_imp: EV_ITEM_IMP
			a_curs: CURSOR
			sep_imp: EV_MENU_SEPARATOR_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
			menu_imp: EV_MENU_IMP
			chk_imp: EV_CHECK_MENU_ITEM_IMP
			rgroup: POINTER
		do
			an_item_imp ?= v.implementation
			a_curs := interface.cursor
			interface.go_i_th (pos)
			sep_imp ?= an_item_imp
			if sep_imp /= Void then
				from
					interface.go_i_th (pos + 1)
				until
					interface.after or else is_menu_separator_imp (interface.item.implementation)
				loop
					radio_imp ?= interface.item.implementation
					if radio_imp /= Void then
						if rgroup = Default_pointer then
							-- Create a new radio group
							-- Reset radio_imp's radio group
							rgroup := C.gtk_radio_menu_item_struct_group (radio_imp.c_object)
							if rgroup /= Default_pointer then
								C.set_gtk_radio_menu_item_struct_group (radio_imp.c_object, Default_pointer)
								rgroup := C.g_slist_remove (rgroup, radio_imp.c_object)
							end
							rgroup := C.g_slist_prepend (rgroup,  radio_imp.c_object)
							C.gtk_radio_menu_item_set_group (radio_imp.c_object, rgroup)
						else
							-- Disable select of item
							C.gtk_check_menu_item_set_active (radio_imp.c_object, False)
							-- Prevent action sequence from being fired
						end
						radio_imp.set_radio_group (rgroup)
						-- Set radio group for radio menu item
					end
					interface.forth
				end
				if rgroup /= Default_pointer then
					-- Set radio group for separator
					sep_imp.set_radio_group (rgroup)
				end
				-- Insert separator at position `pos'
				--| Scaled down implementation from add-to_container, gtk_reorder_child

				insert_menu_item (an_item_imp, pos)

			else
				menu_imp ?= an_item_imp
				if menu_imp /= Void then
				-- If sub menu then add sub menu
					insert_menu_item (an_item_imp, pos)
				else
				-- Add menu item
					insert_menu_item (an_item_imp, pos)

					radio_imp ?= an_item_imp
					if radio_imp /= Void then
						-- Attach it to a radio group
						sep_imp := separator_imp_by_index (pos)
						if sep_imp /= Void then
							-- It follows a separator.
							if sep_imp.radio_group = Default_pointer then
								-- Create radio group for separator
								-- Created from radio menu item
								sep_imp.set_radio_group (radio_imp.radio_group)
								radio_imp.enable_select
							end
						else
							-- It is above any separator.
							if radio_group = Default_pointer then
								-- create a radio_group pointer for current
								-- First item inserted in group is selected.
								radio_group := radio_imp.radio_group
								radio_imp.enable_select
							end
						end
					end
				end
			end

			if not is_menu_separator_imp (an_item_imp) then
				--if not menu_item_imp.is_sensitive then
				--	menu_item_imp.disable_sensitive
				--end
				chk_imp ?= an_item_imp
				if chk_imp /= Void then
					if chk_imp.is_selected then
						chk_imp.enable_select
					end
				end
			end

			interface.go_to (a_curs)
		end

	insert_menu_item (an_item_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		do
			an_item_imp.set_parent_imp (Current)
			C.gtk_menu_append (c_object, an_item_imp.c_object)
			C.gtk_menu_reorder_child (c_object, an_item_imp.c_object, pos)
		end

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP is
			-- Separator before item `an_index'.
		require
			an_index_within_bounds:
				an_index > 0 and then an_index <= interface.count
		local
			cur: CURSOR
			cur_item: INTEGER
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			cur := interface.cursor
			from
				interface.start
				cur_item := 1
			until
				interface.off or else an_index = cur_item
			loop
				sep_imp ?= interface.item
				if sep_imp /= Void then
					Result := sep_imp
				end
				interface.forth
				cur_item := cur_item + 1
			end
			interface.go_to (cur)
		end
				
		

	is_menu_separator_imp (an_item_imp: EV_ITEM_I): BOOLEAN is
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
		do
			sep_imp ?= an_item_imp
			Result := sep_imp /= Void
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_ITEM_IMP
		do
			item_imp ?= eif_object_from_c (
				C.g_list_nth_data (
					C.gtk_container_children (list_widget),
					a_position - 1
				)
			)
			Precursor (a_position)
			item_imp.set_parent_imp (Void)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST

	radio_group: POINTER
			-- Pointer to GSList.

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
--| Revision 1.10  2000/04/25 18:48:59  king
--| Initial implementation of new radio grouping structure
--|
--| Revision 1.9  2000/04/06 20:26:14  brendel
--| Commented out more of separator_imp_by_index.
--|
--| Revision 1.8  2000/04/06 18:41:51  brendel
--| Added separator_imp_by_index.
--|
--| Revision 1.7  2000/04/05 21:16:09  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.6.2.1  2000/04/04 16:22:22  brendel
--| remove_item_from_position -> remove_i_th.
--|
--| Revision 1.6  2000/03/09 22:15:20  king
--| Implemented parenting fix, corrected remove_item_from_position
--|
--| Revision 1.5  2000/02/25 01:53:02  brendel
--| While not implemented, a check false is performed when removing or moving
--| a separator or radio item around.
--|
--| Revision 1.4  2000/02/22 19:58:17  brendel
--| Added functionality that groups radio-menu-items together between
--| separators.
--|
--| Revision 1.3  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/05 01:39:40  brendel
--| Redefined `add_to_container', because for separators, we need to call
--| gtk_menu_append instead of gtk_container_add to make the separator appear.
--|
--| Revision 1.1.2.4  2000/02/04 19:02:12  brendel
--| Removed redefinitions of add_to_container and remove_from_container, since
--| we do not want to prevent the submenu-arrow (>) to show anymore if there
--| are no items in the menu-list.
--|
--| Revision 1.1.2.3  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.1.2.2  2000/02/04 01:13:59  brendel
--| Removed unused local variable.
--|
--| Revision 1.1.2.1  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
