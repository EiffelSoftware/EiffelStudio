indexing
	description: 
		"EiffelVision widget list. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_LIST_IMP
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			initialize,
			replace,
			extend
		end

feature -- Initialization

	initialize is
			-- Precusor and create new_item_actions.
		do
			{EV_CONTAINER_IMP} Precursor
			create new_item_actions.make ("new_item", <<"widget">>)
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item.
		local
			child: POINTER
			imp: EV_ANY_IMP
		do
			child := C.g_list_nth_data (
				C.gtk_container_children (c_object),
				index - 1
			)
			check
				child_not_void: child /= Default_pointer
			end
			imp := eif_object_from_c (child)
			check
				imp_not_void: imp /= Void
					-- C object should have Eiffel object.
			end
			Result ?= imp.interface
			check
				Result_not_void: Result /= Void
			end
		end

	index: INTEGER
			-- Index of current position.

	cursor: CURSOR is
			-- Current cursor position.
		do
			create {EV_WIDGET_LIST_CURSOR} Result.make (index)
		end
	
feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			if c_object /= Default_pointer then
					--| called by invariant: empty_constraint
				Result := C.g_list_length (C.gtk_container_children (c_object))
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
		local
			imp: EV_WIDGET_IMP
		do	
			if v.parent /= Void then
				v.parent.prune (v)
			end
			imp ?= v.implementation
			C.gtk_container_add (c_object, imp.c_object)
			new_item_actions.call ([v])
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			imp: EV_WIDGET_IMP
		do
			if v.parent /= Void then
				v.parent.prune (v)
			end
			imp ?= v.implementation
			remove
			C.gtk_container_add (c_object, imp.c_object)
			gtk_reorder_child (c_object, imp.c_object, index - 1)
			new_item_actions.call ([v])
		end

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		local
			imp: EV_WIDGET_IMP
		do
			if v.parent /= Void then
				v.parent.prune (v)
			end
			imp ?= v.implementation
			index := index + 1
			C.gtk_container_add (c_object, imp.c_object)
			gtk_reorder_child (c_object, imp.c_object, 0)
			new_item_actions.call ([v])
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		local
			imp: EV_WIDGET_IMP
		do
			if v.parent /= Void then
				v.parent.prune (v)
			end
			imp ?= v.implementation
			C.gtk_container_add (c_object, imp.c_object)
			gtk_reorder_child (c_object, imp.c_object, index)
			new_item_actions.call ([v])
		end

feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present.
		local
			imp: EV_WIDGET_IMP
		do
			imp ?= v.implementation
			C.gtk_container_remove (c_object, imp.c_object)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			C.gtk_container_remove (
				c_object, 
				C.g_list_nth_data (
					C.gtk_container_children (c_object),
					index - 1
				)
			)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			C.gtk_container_remove (
				c_object, 
				C.g_list_nth_data (
					C.gtk_container_children (c_object),
					index - 2
				)
			)
			index := index - 1
		end


	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			C.gtk_container_remove (
				c_object, 
				C.g_list_nth_data (
					C.gtk_container_children (c_object),
					index
				)
			)
		end

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed when a new item is added.

feature {EV_ANY_I} -- implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		deferred
		end

	interface: EV_WIDGET_LIST
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	new_item_actions_not_void: is_useable implies new_item_actions /= void

end -- class EV_WIDGET_LIST_IMP

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
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.15  2000/02/14 11:03:37  oconnor
--| protect count from accessing C when is_destroyed
--|
--| Revision 1.1.4.14  2000/02/08 09:33:54  oconnor
--| fixed child /= Void to child /= Default_pointer
--|
--| Revision 1.1.4.13  2000/02/08 00:19:38  king
--| Changed inheritence to deal with changes in ev_dynamic_list
--|
--| Revision 1.1.4.12  2000/02/07 23:51:26  oconnor
--| remove newly inserted items from possible old parent
--|
--| Revision 1.1.4.11  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.1.4.10  2000/02/03 00:02:28  oconnor
--| added is_useable to invariant
--|
--| Revision 1.1.4.9  2000/02/02 20:19:31  oconnor
--| added ACTION_SEQUENCE new_item_actions
--|
--| Revision 1.1.4.8  2000/01/27 19:29:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.7  2000/01/18 19:36:50  oconnor
--| improved checks in item
--|
--| Revision 1.1.4.6  2000/01/18 17:53:36  oconnor
--| Added EV_WIDGET_LIST.gtk_reorder_child deferred.
--| Defined in ev_notebook_imp.e and ev_box_imp.e.
--| GTK is missing a GtkMultiContainer class so there is no way
--| to polymorphicaly call gtk_box_reorder_child and gtk_notebook_reorder_child.
--|
--| Revision 1.1.4.5  1999/12/15 23:48:45  oconnor
--| redefine put to be same as replace
--|
--| Revision 1.1.4.4  1999/12/15 17:03:40  oconnor
--| formatting
--|
--| Revision 1.1.4.3  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.1.4.2  1999/11/30 23:15:48  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.1.4.1  1999/11/24 17:29:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.2  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.1.2.1  1999/11/05 22:37:14  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
