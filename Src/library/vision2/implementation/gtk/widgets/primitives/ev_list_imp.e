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

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			visual_widget,
			initialize,
			clear_selection,
			deselect_item,
			select_item,
			remove_i_th,
			on_item_clicked
		end	
create
	make

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items,
			-- False otherwise.


feature -- Initialize

	initialize is
			-- Initialize the list.
		do
			Precursor
			selection_mode_is_single := True
			disable_multiple_selection
		end

feature -- Status setting

	ensure_i_th_visible (an_index: INTEGER) is
			-- Ensure item `an_index' is visible in `Current'.
		do
			--| FIXME To be implemented.
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			multiple_selection_enabled := True
			if selection_mode_is_single then
				C.gtk_list_set_selection_mode (
					list_widget,
					C.GTK_SELECTION_MULTIPLE_ENUM
				)
			else
				C.gtk_list_set_selection_mode (
					list_widget,
					C.GTK_SELECTION_EXTENDED_ENUM
				)
			end
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			multiple_selection_enabled := False
			selection_mode_is_single := True
			C.gtk_list_unselect_all (list_widget)
			C.gtk_list_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_SINGLE_ENUM
			)
		end

	select_item (an_index: INTEGER) is
			-- Select the item of the list at the one-based
			-- `index'.
		do
			switch_to_browse_mode_if_necessary		
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			switch_to_single_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			if not selection_mode_is_single then
				if multiple_selection_enabled then
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_multiple_enum)
				else
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_single_enum)
				end
				selection_mode_is_single := True
			end
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end
		
	remove_i_th (an_index: INTEGER) is
		do
			switch_to_single_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
		end
		
feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER is
		do
			Result := list_widget
		end

	interface: EV_LIST
	
feature {NONE} -- Implementation

	on_item_clicked is
		do
			switch_to_browse_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end
	
	switch_to_single_mode_if_necessary is
			-- Change selection mode if the last selected item is deselected.
		do
			if not selection_mode_is_single then
				if multiple_selection_enabled then
					if selected_items.count = 1 then
						C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_multiple_enum)
						selection_mode_is_single := True
					end
				else
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_single_enum)
					selection_mode_is_single := True
				end
			end
		end
		
	switch_to_browse_mode_if_necessary is
			-- Change selection mode to browse mode if necessary.
		do
			if selection_mode_is_single then
				if multiple_selection_enabled then
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_extended_enum)					
				else
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_browse_enum)
				end
				selection_mode_is_single := False
			end
		end
	selection_mode_is_single:BOOLEAN

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
--| Revision 1.45  2001/06/08 22:09:17  etienne
--| Modified to have the wanted behavior regarding selection.
--|
--| Revision 1.21.4.11  2001/06/05 01:35:06  king
--| Reset to previous selection mode
--|
--| Revision 1.21.4.10  2001/05/18 18:17:58  king
--| Updated focus code
--|
--| Revision 1.21.4.9  2001/04/26 19:11:29  king
--| Removed focus hack
--|
--| Revision 1.21.4.8  2001/04/20 18:36:44  king
--| Implemented unsetting of item focus flag
--|
--| Revision 1.21.4.7  2000/12/27 00:38:31  rogers
--| Added ensure_i_th_visible as to be implemented.
--|
--| Revision 1.21.4.6  2000/11/03 23:43:16  king
--| Corrected incorrect refocusing in item selection
--|
--| Revision 1.21.4.5  2000/10/30 20:24:24  king
--| Implemented focus handling
--|
--| Revision 1.21.4.4  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.21.4.3  2000/06/29 02:13:19  king
--| Redefined visual_widget
--|
--| Revision 1.21.4.2  2000/05/10 18:50:35  king
--| Integrated ev_list_item_list
--|
--| Revision 1.21.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
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
