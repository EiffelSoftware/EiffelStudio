--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_IMP

inherit
	EV_LIST_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_colors
		redefine
			interface,
			make
		end

	EV_LIST_ITEM_HOLDER_IMP
		redefine
			interface,
			list_widget
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)

			-- `Vision2 list' = gtk_scrolled_window + gtk_list.
			-- We do this to allow the scrolling.

			-- Creating the gtk scrolled window, pointed by `widget':
			set_c_object (C.gtk_scrolled_window_new (Default_pointer, Default_pointer))
			C.gtk_scrolled_window_set_policy (c_object, C.Gtk_policy_automatic_enum, C.Gtk_policy_automatic_enum)

			-- Creating the gtk_list, pointed by `list_widget':
			list_widget := C.gtk_list_new
			disable_multiple_selection
			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (c_object, list_widget)

			-- Create the array where the items will be listed.
			create ev_children.make (0)
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
			-- XX Currently just give head of the gtk selection list
		local
			p: POINTER
			o: EV_ANY_IMP
		do
			p := C.gtk_list_struct_selection (list_widget)
			if p/= Default_pointer then
				p := C.g_list_nth_data (p, 0)
				if p /= Default_pointer then
					o := eif_object_from_c (p)
					Result ?= o.interface
				end
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := C.c_gtk_list_selected (list_widget) = 0
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
			Result := C.c_gtk_list_selection_mode (list_widget) = C.Gtk_selection_multiple_enum
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index. (Gtk uses 0 based indexs, I think)
		do
			C.gtk_list_select_item (list_widget, an_index - 1)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			C.gtk_list_unselect_item (list_widget, an_index - 1)
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			C.gtk_list_unselect_all (list_widget)
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_multiple_enum)
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_single_enum)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	add_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Add `item' to the list.
		do
			ev_children.extend (item_imp)
			C.gtk_container_add (list_widget, item_imp.c_object)
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; value: INTEGER) is
			-- insert `item_imp' at the position
			-- `value' of list.
		do
			check
				To_be_implemented: False
			end
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		do
			ev_children.prune_all (item_imp)
			C.gtk_container_remove (list_widget, item_imp.c_object)
		end

feature {EV_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check
				not_implemented: False
			end
		end

	list_widget: POINTER
			-- Pointer to the gtk_list because the vision `EV_LIST'
			-- is made of a gtk_scrolled_window (pointed by `c_object')
			-- and a gtk_list (pointed by `list_widget').
			-- Exported to EV_LIST_ITEM_IMP. 

	interface : EV_LIST

invariant
	list_widget_not_void: is_initialized implies list_widget /= Void

end -- class EV_LIST_IMP

--!----------------------------------------------------------------
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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.22  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.21.6.15  2000/02/10 16:56:59  king
--| Removed redundant command association features
--|
--| Revision 1.21.6.14  2000/02/04 08:00:02  oconnor
--| removed old command features
--|
--| Revision 1.21.6.13  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.21.6.12  2000/01/27 19:29:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.21.6.11  2000/01/26 16:54:08  oconnor
--| moved features from EV_LIST to EV_ITEM_LIST
--|
--| Revision 1.21.6.10  2000/01/24 19:31:26  oconnor
--| reimplemented selected_item to use GTK directly (not ev_children)
--|
--| Revision 1.21.6.9  2000/01/17 19:39:44  oconnor
--| fixed indexing bug in selected_item
--|
--| Revision 1.21.6.8  2000/01/15 00:53:19  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled, set_multiple_selection -> enable_multiple_selection & set_single_selection -> disable_multiple_selection
--|
--| Revision 1.21.6.7  1999/12/13 20:02:50  oconnor
--| commented out old command stuff
--|
--| Revision 1.21.6.6  1999/12/08 17:42:32  oconnor
--| removed more inherited externals
--|
--| Revision 1.21.6.5  1999/12/04 18:59:20  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.21.6.4  1999/12/01 20:27:50  oconnor
--| tweaks for new externals
--|
--| Revision 1.21.6.3  1999/12/01 17:37:13  oconnor
--| migrating to new externals
--|
--| Revision 1.21.6.2  1999/11/30 23:03:38  oconnor
--| new DYNAMIC_LIST based implementation
--|
--| Revision 1.21.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.21.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.21.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
