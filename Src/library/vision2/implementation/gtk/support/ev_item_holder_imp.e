indexing
	description:
		"Eiffel Vision item list. GTK+ implementation."
	keywords: item
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_ITEM_LIST_IMP [G -> EV_ITEM]

inherit
	EV_ANY_IMP
		redefine
			interface
		end

	EV_ITEM_LIST_I [G]
		redefine
			interface
		end

feature -- Access

	index: INTEGER
			-- Index of current position.

	item: G is
			-- Item at current position.
		local
			item_imp: EV_ITEM_IMP
			aa: ASSIGN_ATTEMPT [G]
		do
			item_imp ?= eif_object_from_c (
				C.g_list_nth_data (
					C.gtk_container_children (list_widget),
					index - 1
				)
			)
			if item_imp /= Void then
				create aa
				Result := aa.attempt (item_imp.interface)
			end
		end

	cursor: CURSOR is
			-- Current cursor position
		do
			create {EV_WIDGET_LIST_CURSOR} Result.make (index)
		end

feature -- Measurment

	count: INTEGER is
			-- Number of items
		do
			if not is_destroyed then
					--| called by invariant: empty_constraint
				Result := C.g_list_length (C.gtk_container_children (list_widget))
			end
		end

feature -- Status report

        valid_cursor (a_cursor: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			wl_cursor: EV_WIDGET_LIST_CURSOR
		do
			wl_cursor ?= a_cursor;
			Result := wl_cursor /= Void and then
				(wl_cursor.index >= 0 and wl_cursor.index <= count + 1)
		end

feature -- Cursor movement

	back is
			-- Move to previous item.
		do
			index := index - 1
		end

	forth is
			-- Move cursor to next position.
		do
			index := index + 1
		end

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			wl_c: EV_WIDGET_LIST_CURSOR
		do
			wl_c ?= p;
			check
				wl_c /= Void
			end
			index := wl_c.index
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			index := index + i
			if (index > count + 1) then
				index := count + 1
			elseif (index < 0) then
				index := 0
			end
		end

feature -- Element change

	extend (v: like item) is
			-- If add `v' to end.
			-- Do not move cursor.
		do
			add_to_container (v)
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		do
			remove
			add_to_container (v)
			reorder_child (v, index - 1)
		end

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		do
			index := index + 1
			add_to_container (v)
			reorder_child (v, 0)
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		do
			add_to_container (v)
			reorder_child (v, index)
		end


feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present.
		local
			imp: EV_WIDGET_IMP
		do
			imp ?= v.implementation
			remove_from_container (imp.c_object)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			remove_from_container (
				C.g_list_nth_data (
					C.gtk_container_children (list_widget),
					index - 1
				)
			)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			remove_from_container (
				C.g_list_nth_data (
					C.gtk_container_children (list_widget),
					index - 2
				)
			)
			index := index - 1
		end


	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			remove_from_container (
				C.g_list_nth_data (
					C.gtk_container_children (list_widget),
					index
				)
			)
		end

feature -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to container.
		local
			imp: EV_WIDGET_IMP
		do	
			imp ?= v.implementation
			C.gtk_container_add (list_widget, imp.c_object)
		end

	remove_from_container (a_c_object: POINTER) is
			-- Remove `a_c_object' from container.
			--| Redefined in EV_MENU_IMP.
		do	
			C.gtk_container_remove (list_widget, a_c_object)
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in container.
		local
			imp: EV_WIDGET_IMP
		do
			imp ?= v.implementation
			gtk_reorder_child (list_widget, imp.c_object, a_position)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		deferred
		end

	list_widget: POINTER is
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| Revision 1.9  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.16  2000/02/14 11:03:23  oconnor
--| protect count from accessing C when is_destroyed
--|
--| Revision 1.8.6.15  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.8.6.14  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.8.6.13  2000/02/03 23:30:09  brendel
--| Added feature `remove_from_container' that gets called everytime an item is
--| removed.
--|
--| Revision 1.8.6.12  2000/02/02 00:45:24  king
--| Tidied up code by abstracting assignment attempts and external calling in to single eiffel functions (for adding, reordering)
--|
--| Revision 1.8.6.11  2000/01/31 18:56:59  king
--| Altered item feature to use assign_attempt
--|
--| Revision 1.8.6.10  2000/01/28 19:01:38  king
--| Made to be generically constrained to ev_item
--|
--| Revision 1.8.6.9  2000/01/27 19:29:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.8  2000/01/26 23:45:29  king
--| Altered item to be of type ev_item and not ev_list_item
--|
--| Revision 1.8.6.7  2000/01/26 16:54:08  oconnor
--| moved features from EV_LIST to EV_ITEM_LIST
--|
--| Revision 1.8.6.6  1999/12/01 18:55:05  oconnor
--| moved item_by_data into _I
--|
--| Revision 1.8.6.5  1999/12/01 18:50:26  oconnor
--| use self instead of ev_children since we inherit DYNAMIC_LIST
--|
--| Revision 1.8.6.4  1999/12/01 17:47:53  oconnor
--| renamed class name in comment
--|
--| Revision 1.8.6.3  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.8.6.2  1999/11/30 22:59:21  oconnor
--| change to DYNAMIC_LIST implementation
--|
--| Revision 1.8.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.3  1999/11/04 23:10:27  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
