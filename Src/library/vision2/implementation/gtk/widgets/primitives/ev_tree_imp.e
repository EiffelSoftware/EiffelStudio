--| FIXME Not for release
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
			destroy
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
		do
			base_make (an_interface)
			set_c_object (C.gtk_scrolled_window_new (Default_pointer, Default_pointer))
			C.gtk_scrolled_window_set_policy (
				c_object, 
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			list_widget := C.gtk_tree_new
			C.gtk_tree_set_selection_mode (list_widget, C.GTK_SELECTION_SINGLE_ENUM)
			C.gtk_tree_set_view_mode (list_widget, C.GTK_TREE_VIEW_ITEM_ENUM)
			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (c_object, list_widget)
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is one item selected ?
		do
			--Result := (selected_item /= Void)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_TREE

	list_widget: POINTER
			-- Pointer to the tree widget

feature {NONE} -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to tree.
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_tree_widget_imp (Current)
			C.gtk_widget_show (item_imp.c_object)
			C.gtk_tree_append (list_widget, item_imp.c_object)
		end

	remove_item_from_position (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			item_imp ?= interface.i_th (a_position).implementation
			item_imp.set_tree_widget_imp (Void)	
			Precursor (a_position)
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in container.
		local
			imp: EV_TREE_ITEM_IMP
		do
			imp ?= v.implementation
			C.gtk_tree_remove_item (list_widget, imp.c_object)
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
