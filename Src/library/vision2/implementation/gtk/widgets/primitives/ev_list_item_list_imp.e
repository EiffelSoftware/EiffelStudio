--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision list item list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
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
			scroll_window := (C.gtk_scrolled_window_new (NULL, NULL))
			C.gtk_widget_show (scroll_window)

			C.gtk_container_add (c_object, scroll_window)

			C.gtk_scrolled_window_set_policy (
				scroll_window,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			-- Creating the gtk_list, pointed by `list_widget':
			list_widget := C.gtk_list_new

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

	selected_item: EV_LIST_ITEM is
			-- Currently selected item if any.
		local
			item_pointer: POINTER
		do
			item_pointer := C.gtk_list_struct_selection (list_widget)
			if item_pointer /= NULL then
				item_pointer := C.gslist_struct_data (item_pointer)
				if item_pointer /= NULL then
					Result ?= eif_object_from_c (item_pointer).interface
					check Result_not_void: Result /= Void end
				end
			end
		end

	selected: BOOLEAN is
			-- Is one item selected ?
		local
			list_pointer: POINTER
		do
			list_pointer := C.gtk_list_struct_selection (list_widget)
			if list_pointer /= NULL then
				Result := C.g_list_length (list_pointer) > 0
			end
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

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Is mouse pointer over widget.
		do
			Result := a_gdkwin = C.gtk_widget_struct_window (list_widget)
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

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

	interface: EV_LIST_ITEM_LIST

	list_widget: POINTER

end -- class EV_LIST_ITEM_LIST_IMP

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
--| Revision 1.2  2000/06/07 17:27:39  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.2  2000/05/10 21:22:59  king
--| Implemented selected_item
--|
--| Revision 1.1.2.1  2000/05/10 19:40:01  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
