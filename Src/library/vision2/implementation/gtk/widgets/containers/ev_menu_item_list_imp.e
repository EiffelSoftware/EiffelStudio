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
			interface,
			add_to_container,
			remove_i_th
		end

feature {NONE} -- implementation

	add_to_container (v: like item) is
			-- Add `v' to container.
		local
			imp: EV_ITEM_IMP
			rmi: EV_RADIO_MENU_ITEM
			sep: EV_MENU_SEPARATOR_IMP
		do
			imp ?= v.implementation
			imp.set_parent_imp (Current)
			rmi ?= v
			if rmi /= Void then
				sep := last_separator_imp
				if sep /= Void then
					if sep.radio_group /= Default_pointer then
						C.gtk_radio_menu_item_set_group (imp.c_object, sep.radio_group)
					end
					sep.set_radio_group (C.gtk_radio_menu_item_group (imp.c_object))
					C.gtk_check_menu_item_set_active (imp.c_object, False)
				else
					if radio_group /= Default_pointer then
						C.gtk_radio_menu_item_set_group (imp.c_object, radio_group)
					end
					radio_group := C.gtk_radio_menu_item_group (imp.c_object)
					C.gtk_check_menu_item_set_active (imp.c_object, False)
				end
			end
			C.gtk_menu_append (list_widget, imp.c_object)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_menu_reorder_child (a_container, a_child, a_position)

			if needs_radio_regrouping (eif_object_from_c (a_child)) then
				reset_radio_groups
			end
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
			if needs_radio_regrouping (item_imp) then
				reset_radio_groups
			end
		end

	needs_radio_regrouping (item_imp: EV_ANY_IMP): BOOLEAN is
		local
			sep_imp: EV_MENU_SEPARATOR_IMP
			radio_imp: EV_RADIO_MENU_ITEM_IMP
		do
			sep_imp ?= item_imp
			radio_imp ?= item_imp
			Result := sep_imp /= Void or else radio_imp /= Void	
		end

	reset_radio_groups is
			-- Update radio grouping after reorder or removal of separator.
		local
			cur: CURSOR
			cur_item: INTEGER
			sep: EV_MENU_SEPARATOR
			last_rgroup: POINTER
		do
			check
				to_be_implemented: False
			end
		--	cur := interface.cursor
		--	from
		--		interface.start
		--	until
		--		interface.off
		--	loop
		--		sep ?= interface.item
		--		if sep /= Void then
		--			--Result ?= sep.implementation
		--		end
		--		interface.forth
		--	end
		--	interface.go_to (cur)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM_LIST

	radio_group: POINTER
			-- Pointer to GSList.

	last_separator_imp: EV_MENU_SEPARATOR_IMP is
			-- Get the impl. of last separator or `Void'.
			--| Used to retreive the radio group of the radio menu
			--| item that has just been added to the end.
		local
			cur: CURSOR
			cur_item: INTEGER
			sep: EV_MENU_SEPARATOR
		do
			cur := interface.cursor
			from
				interface.start
			until
				interface.off
			loop
				sep ?= interface.item
				if sep /= Void then
					Result ?= sep.implementation
				end
				interface.forth
			end
			interface.go_to (cur)
		end

	separator_imp_by_index (an_index: INTEGER): EV_MENU_SEPARATOR_IMP is
			-- Separator before item with `an_index'.
			--| Will be needed by reset_radio_grouping
			--| or insert_i_th.
		require
		--	an_index_within_bounds:
		--		an_index > 0 and then an_index <= ev_children.count
		local
		--	cur: CURSOR
		--	cur_item: INTEGER
		--	sep_imp: EV_MENU_SEPARATOR_IMP
		do
		--	from
		--		ev_children.start
		--		cur_item := 1
		--	until
		--		ev_children.off or else an_index = cur_item
		--	loop
		--		sep_imp ?= ev_children.item
		--		if sep_imp /= Void then
		--			Result := sep_imp
		--		end
		--		ev_children.forth
		--		cur_item := cur_item + 1
		--	end
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
