--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision Tree, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			destroy,
			initialize
		end

	EV_ITEM_LIST_IMP [EV_TREE_ITEM]
		redefine
			interface,
			add_to_container,
			remove_item_from_position,
			reorder_child
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty Tree.
		local
			scroll_window: POINTER
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)

			scroll_window := (C.gtk_scrolled_window_new (Default_pointer, Default_pointer))
			C.gtk_widget_show (scroll_window)
			C.gtk_container_add (c_object, scroll_window)
			C.gtk_scrolled_window_set_policy (
				scroll_window, 
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			list_widget := C.gtk_tree_new
			C.gtk_tree_set_selection_mode (list_widget, C.GTK_SELECTION_SINGLE_ENUM)
			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (scroll_window, list_widget)
		end

	initialize is
			-- Connect action sequences to signals.

		do
			{EV_PRIMITIVE_IMP} Precursor

			real_signal_connect (list_widget, "select_child", ~select_callback)
			
			-- Gtk bug means that select_child signal is fired on mouse press regardless.
		end

feature {EV_TREE_ITEM_IMP} -- Implementation

	select_callback (a_tree_item: POINTER) is
			-- Called when a tree item is selected
		local
			t_item: EV_TREE_ITEM_IMP
		do
		 	t_item ?= eif_object_from_c (a_tree_item)

			if previous_selected_item /= Void and then
			previous_selected_item.parent_tree = interface and then
			previous_selected_item /= t_item.interface then
				previous_selected_item.deselect_actions.call ([])
			end
			
			if t_item.is_selected then
				t_item.interface.select_actions.call ([])
				interface.select_actions.call ([t_item.interface])
				previous_selected_item := t_item.interface
			else
				interface.deselect_actions.call ([t_item.interface])
				previous_selected_item := Void
			end		
		end

feature -- Status report

	selected_item: EV_TREE_ITEM is
			-- Item which is currently selected
		local
			p: POINTER
			o: EV_ANY_IMP
		do
			p := GTK_TREE_SELECTION (list_widget)
			if p /= Default_pointer then
				p := C.g_list_nth_data (p, 0)
				if p /= Default_pointer then
					o := eif_object_from_c (p)
					Result ?= o.interface
				end
			end
		end

	selected: BOOLEAN is
			-- Is one item selected ?
		local
			list_pointer: POINTER
		do
			list_pointer := C.gtk_tree_struct_selection (list_widget)
			if list_pointer /= Default_pointer then
				Result := C.g_list_length (list_pointer) > 0
			end
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_TREE

	list_widget: POINTER
			-- Pointer to the tree widget

feature {NONE} -- External  FIXME IEK Remove when macros are in gel.

	gtk_tree_selection (a_tree: POINTER): POINTER is
			-- Selection of root tree.
		external
			" C [macro <gtk/gtktree.h>]"
		alias
			"GTK_TREE_SELECTION"
		end

feature {NONE} -- Implementation

	previous_selected_item: EV_TREE_ITEM
		-- Item that was selected previously.

	add_to_container (v: like item) is
			-- Add `v' to tree.
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			item_imp ?= v.implementation
			C.gtk_widget_show (item_imp.c_object)
			C.gtk_tree_append (list_widget, item_imp.c_object)
			if item_imp.dummy_list_widget /= Default_pointer then
				C.gtk_tree_item_set_subtree (item_imp.c_object, item_imp.dummy_list_widget)
				item_imp.set_dummy_list_widget (Default_pointer)
			end
		end

	remove_item_from_position (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			item_imp ?= interface.i_th (a_position).implementation
			item_imp.set_dummy_list_widget (item_imp.list_widget)

			if item_imp.list_widget /= Default_pointer then
				C.gtk_widget_ref (item_imp.list_widget)
			end
			Precursor (a_position)
				-- Precursor unrefs list widget.
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in container.
		local
			imp: EV_TREE_ITEM_IMP
		do
			imp ?= v.implementation
			C.gtk_widget_ref (imp.c_object)
			C.gtk_tree_remove_item (list_widget, imp.c_object)
			C.gtk_widget_unref (imp.c_object)
			C.gtk_tree_insert (list_widget, imp.c_object, a_position - 1)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check  do_not_call: False end
		end

end -- class EV_TREE_IMP

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
--!---------------------------------------------------------------
 

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.37  2000/03/21 21:52:30  king
--| Made c_object an event box
--|
--| Revision 1.36  2000/03/13 22:10:13  king
--| Added reference handling for child reordering
--|
--| Revision 1.35  2000/03/10 23:53:10  king
--| Fixed dereferencing of list widget
--|
--| Revision 1.34  2000/03/09 19:56:46  king
--| Removed multiple-selection features as they are not available on win32
--|
--| Revision 1.33  2000/03/07 01:28:18  king
--| Optimized loop by adding and then
--|
--| Revision 1.32  2000/03/06 20:13:51  king
--| Made compatible with new action sequence
--|
--| Revision 1.31  2000/03/02 00:27:49  king
--| Updated bug comment
--|
--| Revision 1.30  2000/03/01 23:42:46  king
--| Corrected select_callback, corrected initialize
--|
--| Revision 1.29  2000/03/01 18:09:22  oconnor
--| released
--|
--| Revision 1.28  2000/03/01 18:06:44  king
--| Corrected selected_item comment
--|
--| Revision 1.27  2000/02/29 22:29:35  king
--| Merged selection callbacks in to one due to gtk bug
--|
--| Revision 1.26  2000/02/29 00:01:53  king
--| Added multiple selection features
--|
--| Revision 1.25  2000/02/26 01:28:43  king
--| Implemented to set sub_tree of children
--|
--| Revision 1.24  2000/02/24 21:40:08  king
--| Removed calling of subtree removal from item removal
--|
--| Revision 1.23  2000/02/24 20:11:05  king
--| corrected indentation
--|
--| Revision 1.22  2000/02/24 01:50:37  king
--| Implemented event handling
--|
--| Revision 1.21  2000/02/22 23:57:32  king
--| Implemented selecrted_item
--|
--| Revision 1.20  2000/02/22 21:37:40  king
--| Initial implementation to fit in with new structure
--|
--| Revision 1.19  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.18  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.2  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.17.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
