indexing
	description: 
		"EiffelVision Split Area. GTK+ implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			interface,
			initialize
		end

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			update_splitter
			second_expandable := True
		end

feature

	split_position: INTEGER is
			-- Position from the left/top of the splitter from `Current'.
		do
			Result := gtk_paned_struct_child1_size (c_object)
			if Result = 0 then
				Result := minimum_split_position
			end
		end

	set_first (an_item: like item) is
			-- Make `an_item' `first'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check item_imp_not_void: item_imp /= Void end
			C.gtk_container_set_resize_mode (c_object, C.gtk_resize_immediate_enum)
			C.gtk_paned_pack1 (c_object, item_imp.c_object, False, False)
			C.gtk_container_set_resize_mode (c_object, C.gtk_resize_parent_enum)
		--	update_child_requisition (item_imp.c_object)
			first := an_item
			set_item_resize (first, False)
			update_splitter
		end

	set_second (an_item: like item) is
			-- Make `an_item' `second'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check item_imp_not_void: item_imp /= Void end
			C.gtk_container_set_resize_mode (c_object, C.gtk_resize_immediate_enum)
			C.gtk_paned_pack2 (c_object, item_imp.c_object, True, False)
			C.gtk_container_set_resize_mode (c_object, C.gtk_resize_parent_enum)
	--		update_child_requisition (item_imp.c_object)
			second := an_item
			set_item_resize (second, True)
			update_splitter
		end

	prune (an_item: like item) is
			-- Remove `an_item' if present from `Current'.
		local
			item_imp: EV_WIDGET_IMP
		do
			if has (an_item) and then an_item /= Void then
				item_imp ?= an_item.implementation
				check item_imp_not_void: item_imp /= Void end
				C.gtk_container_remove (c_object, item_imp.c_object)
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if second /= Void then
						set_item_resize (second, True)
					end
				else
					second := Void
					second_expandable := True
					if first /= Void then
						set_item_resize (first, True)
					end
				end
				update_splitter
			end
		end

	extend (an_item: like item) is
			-- Add `an_item' to `Current'.
		do
			put (an_item)
		end

	enable_item_expand (an_item: like item) is
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: like item) is
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Set the position of the splitter.
		do
			C.gtk_paned_set_position (c_object, a_split_position)
		end

	enable_flat_separator is
			-- Set the separator to be "flat".
		do
			flat_separator := True
			--| Do nothing (Win32 Implementation only)
		end

	disable_flat_separator is
			-- Set the separator to be "raised"
		do
			flat_separator := False
			--| Do nothing (Win32 Implementation only)
		end

	show_separator is
			-- Make separator visible.
		do
			C.gtk_paned_set_gutter_size (c_object, splitter_width)
			C.gtk_paned_set_handle_size (c_object, splitter_width)
		end

	hide_separator is
			-- Hide Separator.
		do
			C.gtk_paned_set_gutter_size (c_object, 0)
			C.gtk_paned_set_handle_size (c_object, 0)
		end

feature {EV_WIDGET_IMP} -- Implementation

	update_child_visibility (a_widget_imp: EV_WIDGET_IMP) is
		do

		end

feature {NONE} -- Implementation

	splitter_width: INTEGER is 8

	set_item_resize (an_item: like item; a_resizable: BOOLEAN) is
		local
			item_imp: EV_WIDGET_IMP
		do
			if an_item = first then
				set_gtk_paned_struct_child1_resize (c_object, a_resizable)
				first_expandable := a_resizable
			else
				set_gtk_paned_struct_child2_resize (c_object, a_resizable)
				second_expandable := a_resizable
			end
			item_imp ?= an_item.implementation
			C.gtk_widget_queue_resize (item_imp.c_object)
		end

	update_splitter is
			-- Update splitter to account for different configurations
		do
			if first /= Void and second = Void then
				set_split_position (maximum_split_position)
				hide_separator
			elseif first = Void and second /= Void then
				set_split_position (0)
				hide_separator
			elseif first = Void and second = Void then
				set_split_position (0)
				hide_separator
			else
				-- Both first and second are visible
				show_separator
			end
		end

feature {NONE} -- Externals.

	gtk_paned_struct_child1_size (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned): EIF_INTEGER"
		alias
			"child1_size"
		end

	set_gtk_paned_struct_child1_resize (a_c_struct: POINTER; a_resize: BOOLEAN) is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned, EIF_BOOLEAN)"
		alias
			"child1_resize"
		end

	set_gtk_paned_struct_child2_resize (a_c_struct: POINTER; a_resize: BOOLEAN) is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned, EIF_BOOLEAN)"
		alias
			"child2_resize"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPLIT_AREA


end -- class EV_SPLIT_AREA_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.17  2001/07/12 18:08:57  etienne
--| Fixed infinite loop problem in `set_first'/`set_second'.
--|
--| Revision 1.16  2001/07/12 16:32:24  etienne
--| Corrected oversight of last commit.
--|
--| Revision 1.15  2001/07/12 16:07:30  etienne
--| Now widget inserted in a split area are immediately resized.
--|
--| Revision 1.14  2001/06/21 22:34:40  king
--| Added calls to update_child_requisition on child addition
--|
--| Revision 1.13  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.4.19  2001/05/10 22:17:22  king
--| Added unimplemented split area hack
--|
--| Revision 1.8.4.18  2000/11/17 19:39:43  etienne
--| (by KING) Fixed bug in prune
--|
--| Revision 1.8.4.17  2000/10/27 16:54:42  manus
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
--| Revision 1.8.4.16  2000/09/18 18:06:43  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.8.4.15  2000/08/15 16:22:17  king
--| Undefining replace
--|
--| Revision 1.8.4.14  2000/08/08 00:03:14  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.8.4.13  2000/07/28 19:37:58  king
--| Added code to forfill prune postcondition
--|
--| Revision 1.8.4.12  2000/07/28 00:22:25  king
--| Added update_splitter feature to hide/show as appropriate
--|
--| Revision 1.8.4.11  2000/07/27 20:41:08  king
--| Now satisfying post conds for flat sep functionality
--|
--| Revision 1.8.4.10  2000/07/27 20:38:34  king
--| Added comments to flat separator implementation features
--|
--| Revision 1.8.4.9  2000/07/27 19:16:35  king
--| All implemented apart from flat separator functionality
--|
--| Revision 1.8.4.7  2000/07/26 22:42:02  king
--| Moved put imp in to _I
--|
--| Revision 1.8.4.6  2000/07/26 21:34:03  king
--| Implemented hide show separator
--|
--| Revision 1.8.4.5  2000/07/26 20:39:54  king
--| Implemented initialize and prune
--|
--| Revision 1.8.4.4  2000/07/26 18:53:46  king
--| Added empty bodied extend
--|
--| Revision 1.8.4.3  2000/07/26 18:29:30  king
--| Added empty bodied implementation
--|
--| Revision 1.8.4.2  2000/07/26 17:15:44  king
--| Initial split area implementation
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
