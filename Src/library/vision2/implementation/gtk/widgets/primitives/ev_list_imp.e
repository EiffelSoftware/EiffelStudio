--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
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
			pointer_over_widget,
			initialize,
			interface,
			make
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
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
		local
			scroll_window: POINTER

		do
			base_make (an_interface)

			-- `Vision2 list' = gtk_scrolled_window + gtk_list.
			-- We do this to allow the scrolling.

			set_c_object (C.gtk_event_box_new)

			-- Creating the gtk scrolled window.
			scroll_window := (C.gtk_scrolled_window_new (
					NULL,
					NULL
					)
					)
			C.gtk_widget_show (scroll_window)

			C.gtk_container_add (c_object, scroll_window)

			C.gtk_scrolled_window_set_policy (
				scroll_window,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			-- Creating the gtk_list, pointed by `list_widget':
			list_widget := C.gtk_list_new

			disable_multiple_selection
			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (scroll_window, list_widget)
			real_signal_connect (
				list_widget,
				"unselect_child",
				~deselect_callback,
				Void
			)
		end

	initialize is
		do
			{EV_PRIMITIVE_IMP} Precursor
			real_signal_connect (
				list_widget,
				"select_child",
				~select_callback,
				Void
			)
		end

	select_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is selected
		require
			one_arg: n_args = 1
		local
			l_item: EV_LIST_ITEM_IMP
		do
		 	l_item ?= eif_object_from_c (
				gtk_value_pointer (args)
			)

			if previous_selected_item /= Void and then
			previous_selected_item.parent = interface and then
			previous_selected_item /= l_item.interface then
				previous_selected_item.deselect_actions.call ([])
			end
			
			if l_item.has_parent and then l_item.is_selected then
					-- Parent check due to bug in combo box.
				l_item.interface.select_actions.call ([])
				interface.select_actions.call ([l_item.interface])
				previous_selected_item := l_item.interface
			elseif l_item.has_parent then
				interface.deselect_actions.call ([l_item.interface])
				previous_selected_item := Void
			end		
		end

	deselect_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is deselected.
		require
			one_arg: n_args = 1
		local
			l_item: EV_LIST_ITEM_IMP
		do
		 	l_item ?= eif_object_from_c (
				gtk_value_pointer (args)
			)
			l_item.interface.deselect_actions.call ([])
			interface.deselect_actions.call ([l_item.interface])
			previous_selected_item := Void
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is one item selected ?
		local
			list_pointer: POINTER
		do
			list_pointer := C.gtk_tree_struct_selection (list_widget)
			if list_pointer /= NULL then
				Result := C.g_list_length (list_pointer) > 0
			end
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
			Result := C.gtk_list_struct_selection_mode (list_widget) 
					= C.GTK_SELECTION_MULTIPLE_ENUM
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index.
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
			C.gtk_list_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_MULTIPLE_ENUM
			)	
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			C.gtk_list_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_SINGLE_ENUM
			)
		end

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Is mouse pointer over widget.
		do
			Result := a_gdkwin = C.gtk_widget_struct_window (list_widget)
		end

feature {EV_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

	previous_selected_item: EV_LIST_ITEM
		-- Item that was selected previously.

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		local
			item_pointer: POINTER
				-- Single element glist holding `a_child'.
		do
			item_pointer := C.g_list_nth (
						C.gtk_container_children (a_container),
						C.gtk_list_child_position (a_container, a_child)
					)
			check
				item_pointer_not_null: item_pointer /= NULL
			end
			C.gtk_list_remove_items_no_unref (a_container, item_pointer)
			C.gtk_list_insert_items (a_container, item_pointer, a_position)
		end

	interface: EV_LIST

	list_widget: POINTER

end -- class EV_LIST_IMP

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
--| Revision 1.42  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.41  2000/04/19 20:58:47  oconnor
--| no more externals used
--|
--| Revision 1.40  2000/04/12 18:48:28  oconnor
--| fixed interpretation of Gdk event data in deselect_callback
--|
--| Revision 1.39  2000/04/06 22:21:47  brendel
--| Added list_widget. Removed invariant since it is now in
--| EV_DYNAMIC_LIST_IMP.
--|
--| Revision 1.38  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.37  2000/04/04 20:54:08  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.36  2000/03/31 19:11:25  king
--| Accounted for rename of pebble_over_widget
--|
--| Revision 1.35.2.1  2000/04/04 23:46:23  brendel
--| removed list_widget.
--| Changed EV_LIST_ITEM_HOLDER to EV_ITEM_LIST [EV_LIST_ITEM].
--|
--| Revision 1.35  2000/03/23 19:19:01  king
--| Updated for signature change of pebble_over_widget
--|
--| Revision 1.34  2000/03/22 22:02:09  king
--| Redefined pebble_over_widget to return correct gdkwindow
--|
--| Revision 1.33  2000/03/21 21:32:45  king
--| Made c_object an event box
--|
--| Revision 1.32  2000/03/13 19:07:04  king
--| Implemented gtk_reorder_child
--|
--| Revision 1.31  2000/03/08 21:39:04  king
--| Reimplemented to be compatible with combo box
--|
--| Revision 1.30  2000/03/07 01:27:23  king
--| Added event handling
--|
--| Revision 1.29  2000/03/03 23:55:07  king
--| Indented c externals
--|
--| Revision 1.28  2000/03/02 17:49:05  king
--| Removed redundant features from old implementation
--|
--| Revision 1.27  2000/03/01 00:58:16  king
--| Removed selected_item
--|
--| Revision 1.26  2000/02/29 19:07:50  king
--| Removed now platform independent selected_items
--|
--| Revision 1.25  2000/02/29 18:43:41  king
--| Tidied up code
--|
--| Revision 1.24  2000/02/29 00:00:23  king
--| Added multiple item features
--|
--| Revision 1.23  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
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
--| renamed is_multiple_selection -> multiple_selection_enabled, 
--| set_multiple_selection -> enable_multiple_selection & 
--| set_single_selection -> disable_multiple_selection
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
