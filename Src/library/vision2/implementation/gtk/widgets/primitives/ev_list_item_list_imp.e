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
		redefine
			pointer_over_widget,
			initialize,
			interface,
			make,
			visual_widget,
			create_focus_in_actions,
			create_focus_out_actions,
			has_focus
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
		redefine
			interface,
			list_widget,
			visual_widget
		end
	
	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)

			set_c_object (C.gtk_scrolled_window_new (NULL, NULL))
			gtk_widget_set_flags (c_object, C.GTK_CAN_FOCUS_ENUM)
			C.gtk_scrolled_window_set_policy (
				c_object,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			-- Creating the gtk_list, pointed by `list_widget':
			list_widget := C.gtk_list_new

			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (c_object, list_widget)
			real_signal_connect (
				list_widget,
				"unselect_child",
				~deselect_callback,
				Void
			)
		end

	initialize is
		local
			temp_sig_id: INTEGER
		do
			{EV_PRIMITIVE_IMP} Precursor
			real_signal_connect (
				list_widget,
				"select_child",
				~select_callback,
				Void
			)
			temp_sig_id := c_signal_connect (
					visual_widget,
					eiffel_to_c ("button-press-event"),
					~list_press
			)
			temp_sig_id := c_signal_connect (
					visual_widget,
					eiffel_to_c ("focus-in-event"),
					~attain_focus
			)
			temp_sig_id := c_signal_connect (
					visual_widget,
					eiffel_to_c ("focus-out-event"),
					~lose_focus
			)
			gtk_widget_set_flags (visual_widget, C.GTK_CAN_FOCUS_ENUM)
		end

	select_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is selected.
		require
			one_arg: n_args = 1
		local
			l_item: EV_LIST_ITEM_IMP
			--item_alloc_y: INTEGER
			--v_adjustment: POINTER
		do
		 	l_item ?= eif_object_from_c (
				gtk_value_pointer (args)
			)

			-- Move down in to ev_list_imp or refactor a scrolled window pointer.
			--item_alloc_y := C.gtk_allocation_struct_y (C.gtk_widget_struct_allocation (l_item.c_object))
			--if item_alloc_y /= -1 then
				--print ("Scroll window to " + item_alloc_y.out + "%N")
			--	v_adjustment := C.gtk_scrolled_window_get_vadjustment (c_object)
			--	C.set_gtk_adjustment_struct_value (v_adjustment, item_alloc_y)
			--	C.gtk_scrolled_window_set_vadjustment (c_object, v_adjustment)
			--end
			if previous_selected_item_imp /= Void and then
			previous_selected_item_imp.parent = interface and then
			previous_selected_item_imp /= l_item then
				if previous_selected_item_imp.deselect_actions_internal /= Void then
					previous_selected_item_imp.deselect_actions_internal.call ([])
				end
			end
			
			if l_item.parent /= Void and then l_item.is_selected then
					-- Parent check due to bug in combo box.
				if l_item.select_actions_internal /= Void then
					l_item.select_actions_internal.call ([])
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([l_item.interface])
				end
				previous_selected_item_imp := l_item
			elseif l_item.parent /= Void then
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call ([l_item.interface])
				end
				previous_selected_item_imp := Void
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
			if l_item.deselect_actions_internal /= Void then
				l_item.deselect_actions_internal.call ([])
			end

			if deselect_actions_internal /= Void then
				deselect_actions_internal.call ([l_item.interface])
			end

			previous_selected_item_imp := Void
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
			-- Is one item selected?
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
			-- Select the item of the list at the one-based
			-- `index'.
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

	visual_widget: POINTER is
			-- Pointer to the gtk event box that list is in.
		do
			Result := list_widget
		end

	previous_selected_item_imp: EV_LIST_ITEM_IMP
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
	
feature {NONE} -- Implementation

	list_press is
		do
			if not has_focus then
				set_focus	
			end
print ("List pressed%N")
		end

	attain_focus is
		do
			top_level_window_imp.set_focus_widget (Current)
print ("List has focus%N")
			if focus_in_actions_internal /= Void then
				focus_in_actions_internal.call ([])				
			end
		end

	lose_focus is
		do
print ("List has lost focus%N")
			top_level_window_imp.set_focus_widget (Void)
			if not has_focus and focus_out_actions_internal /= Void then
				focus_out_actions_internal.call ([])
			end
		end
		
	has_focus: BOOLEAN is
			-- 
		local
			a_selected_imp: EV_LIST_ITEM_IMP
			a_selected: EV_LIST_ITEM
			a_selected_gtk_obj: POINTER
		do
			a_selected := selected_item
				-- This is a hack to avoid loss of focus on list item click.
			if a_selected /= Void then
				a_selected_imp ?= a_selected.implementation
				a_selected_gtk_obj := a_selected_imp.c_object
			end
			if Precursor {EV_PRIMITIVE_IMP} or else gtk_widget_has_focus (a_selected_gtk_obj) then
				Result := True
				if selected_item /= Void then
					print (selected_item.text + "%N")
				end
			end
		end
		

feature {NONE} -- Implementation

	create_focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- 	
		do
			create Result
		end
	
	create_focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- 
		do
			create Result
		end
		
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
--| Revision 1.3  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.16  2001/06/05 01:36:10  king
--| Uncommented focus code, needs fixing
--|
--| Revision 1.1.2.15  2001/05/18 18:18:22  king
--| Updated focus implementation
--|
--| Revision 1.1.2.14  2001/04/26 19:12:24  king
--| Removed unused locals
--|
--| Revision 1.1.2.13  2000/12/08 18:17:43  etienne
--| Removed invalid scroll code
--|
--| Revision 1.1.2.12  2000/11/30 19:28:41  king
--| Removed unused local variable
--|
--| Revision 1.1.2.11  2000/11/06 19:45:07  king
--| Temp code store for new checkout
--|
--| Revision 1.1.2.10  2000/10/27 16:54:44  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.1.2.9  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.1.2.8  2000/08/28 16:42:31  king
--| Removed event_widget
--|
--| Revision 1.1.2.7  2000/08/02 23:29:56  king
--| Calling internal AS directly instead of indirecting though interface
--|
--| Revision 1.1.2.6  2000/07/28 23:58:43  king
--| Changed selection callbacks to avoid unneccessary instantiation of empty
--| action sequences via call to interface.
--|
--| Revision 1.1.2.5  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.1.2.4  2000/06/28 00:10:18  king
--| c_object is now scroll_window from event_box
--|
--| Revision 1.1.2.3  2000/06/12 16:41:38  oconnor
--| removed references to obsolete features
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
