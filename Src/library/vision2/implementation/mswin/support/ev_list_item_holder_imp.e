--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision list-item container. %
				% Ms windows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_HOLDER_IMP

inherit
	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_LIST_ITEM] 

feature -- Access

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP] is
			-- List of the children
			-- Deferred because it will be implemented in
			-- the _I classes.
		deferred
		end

	background_brush: WEL_BRUSH is
			-- Brush used to clear the list
		--require
		--	exitst: not destroyed
		do
			!! Result.make_solid (background_color_imp)
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	move_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Move `item_imp' to the `an_index' position.
			--|FIXME Can this be removed?
		local
			bool: BOOLEAN
		do
		--	bool := item_imp.is_selected
		--	remove_item (item_imp)
		--	insert_item (item_imp, an_index)
		--	if bool then
		--		item_imp.set_selected (True)
		--	end
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `itemm' from the list.
		local
			id: INTEGER
		do
			-- First, we remove the child from the graphical list
			id := ev_children.index_of (item_imp, 1)
			delete_string (id - 1)

			-- Then, we update ev_children.
			ev_children.go_i_th (id)
			ev_children.remove
		end

	clear_items is
			-- Remove all the elements of the combo-box.
		do
			reset_content
			clear_ev_children
		end

feature -- Basic operations

	internal_copy_list is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		local
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			original_index: INTEGER
		do
			original_index := index
			if not ev_children.is_empty then
				from
					list := ev_children
					list.start
				until
					list.after
				loop
					graphical_insert_item (list.item.interface, list.index - 1)
					list.forth
				end
			end
			interface.go_i_th (original_index)
		ensure
			index_not_changed: index = old index
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Make `item_imp' selected.
			--|FIXME Can this be removed?
		local
			id: INTEGER
		do
		--	id := ev_children.index_of (item_imp, 1)
		--	select_item (id)
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Make `item_imp' unselected.
			--|FIXME Can this be removed?
		local
			id: INTEGER
		do
		--	id := ev_children.index_of (item_imp, 1)
		--	deselect_item (id)
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' selected?
		local
			id: INTEGER
		do
			id := ev_children.index_of (item_imp, 1)
			Result := is_selected (id - 1)
		end

	internal_get_text (item_imp: EV_LIST_ITEM_IMP): STRING is
			-- Return the text of `item_imp'
			--|FIXME Can this be removed?
		local
			id: INTEGER
		do
		--	id := ev_children.index_of (item_imp, 1) - 1
		--	Result := i_th_text (id)
		end

	internal_set_text (item_imp: EV_LIST_ITEM; txt: STRING) is
			-- Make `txt' the text of `item_imp'.
			--|FIXME Can this be removed?
		local
			id: INTEGER
		do
		--	id := ev_children.index_of (item_imp, 1) - 1
		--	delete_string (id)
		--	graphical_insert_item (item_imp, id)
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- Return the index of `item_imp' in the list.
			--|FIXME Can this be removed?
		do
			Result := ev_children.index_of (item_imp, 1) - 1
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to mouse pointer.
		deferred
		end

feature {NONE} -- Implementation

	item_type: EV_LIST_ITEM_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
		end

	clear_ev_children is
			-- Clear all the items of the list.
			--|FIXME Can this be removed?
		local
			list: ARRAYED_LIST [EV_LIST_ITEM]
		do
		--	from
		--		list := ev_children
		--		list.start
		--	until
		--		list.after
		--	loop
		--		list.item.implementation.remove_implementation
		--		list.forth
		--	end
		--	list.wipe_out
		end

feature {EV_LIST_ITEM_IMP} -- Deferred features

	graphical_insert_item (item_imp: EV_LIST_ITEM; an_index: INTEGER) is
				-- Add the item to the graphical list.
		deferred
		end

	delete_string (id: INTEGER) is
		deferred
		end

	reset_content is
		deferred
		end

	select_item (id: INTEGER) is
		deferred
		end

	deselect_item (id: INTEGER) is
		deferred
		end

	is_selected (id: INTEGER): BOOLEAN is
		deferred
		end

	i_th_text (id: INTEGER): STRING is
		deferred
		end

	background_color_imp: EV_COLOR_IMP is
		deferred
		end

	foreground_color_imp: EV_COLOR_IMP is
		deferred
		end

end -- class EV_LIST_ITEM_HOLDER_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.25  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.4.2  2001/03/01 03:23:44  manus
--| Removed obsolete calls to `empty', now replaced by `is_equal'.
--|
--| Revision 1.17.4.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/03/29 02:21:24  brendel
--| Unreleased.
--|
--| Revision 1.23  2000/03/21 01:30:32  rogers
--| Added deferred feature, set_pointer_style.
--|
--| Revision 1.22  2000/03/01 18:32:12  rogers
--| Re-implemented internal_get_index.
--|
--| Revision 1.21  2000/02/25 22:03:05  rogers
--| Internal_copy_list, now restores the index after performing its actions. Added a postcondition to ensure this.
--|
--| Revision 1.20  2000/02/25 17:51:22  rogers
--| Re implemented internal_is_selected. Added FIXME's to the other routines that have commented out bodies.
--|
--| Revision 1.19  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.18  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.5  2000/02/02 21:04:07  rogers
--| Changed the inheritance of EV_ARRAYED_LIST_ITEM_HOLDER to EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_LIST_ITEM].
--|
--| Revision 1.17.6.4  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.3  2000/01/19 20:19:25  rogers
--| Uncommented bodies of insert_item and remove_item.
--|
--| Revision 1.17.6.2  1999/12/17 17:05:23  rogers
--| Altered to fit in with the review branch.
--|
--| Revision 1.17.6.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
