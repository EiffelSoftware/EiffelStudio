indexing

	description:
		"EiffelVision multi-column list row, gtk implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			parent_imp,
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a row with one empty column.
		do
			base_make (an_interface)
		end

	initialize is
			-- Create the linked lists.
		do			
			is_initialized := True
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			row ?= Current.interface			
			Result := (parent_imp.selected_items.has (row))
			 or (parent_imp.selected_item = row)
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		local
		do
			parent_imp := Void	
		end

	enable_select is
			-- Select the row in the list.
		do
			C.gtk_clist_select_row (parent_imp.list_widget, index - 1, 0)
		end

	disable_select is
			-- Deselect the row from the list.
		do
			C.gtk_clist_unselect_row (parent_imp.list_widget, index - 1, 0)
		end

feature -- PND

	enable_transport is 
		do
			is_transport_enabled := True
			if parent_imp /= Void then
				parent_imp.update_pnd_status
			end
		end

	disable_transport is
		do
			is_transport_enabled := False
			if parent_imp /= Void then
				parent_imp.update_pnd_status
			end
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is 
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
		do
			check
				do_not_call: False
			end
		end

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdk_window: POINTER; a_x, a_y: INTEGER): BOOLEAN is
		-- Is mouse pointer over the row.
		local
			gdkwin_parent, clist_parent: POINTER
		do
			if parent_imp /= Void then
				gdkwin_parent := C.gdk_window_get_parent (a_gdk_window)
				clist_parent := C.gdk_window_get_parent (
					C.gtk_clist_struct_clist_window (parent_imp.list_widget)
				)
				if gdkwin_parent = clist_parent then
					if parent_imp.row_from_y_coord (a_y) = index then
						Result := True
					end	
				end
			end
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_pebble_void is
			-- Resets pebble from MCL_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is the row able to transport data with `a_button' click.
		do
			Result := is_transport_enabled and
			((a_button = 1 and mode_is_drag_and_drop) or
			(a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {EV_ANY_I} -- Implementation

	set_parent_imp (par_imp: EV_MULTI_COLUMN_LIST_IMP) is
			-- Set the rows parent to `par_imp'.
		do
			parent_imp := par_imp
		end
	
	parent_imp: EV_MULTI_COLUMN_LIST_IMP
			-- Implementation of the rows parent.

	index: INTEGER is
			-- Index of the row in the list
			-- (starting from 1).
		do
			-- The `ev_children' array has to contain
			-- the same rows in the same order than in the gtk
			-- part.
			Result := parent_imp.ev_children.index_of (Current, 1)
		end

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end	

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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
--| Revision 1.48  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.22.4.8  2001/01/29 21:25:41  rogers
--| Added internal_set_pointer_style.
--|
--| Revision 1.22.4.7  2000/10/25 23:14:32  king
--| Corrected button actions sequence calling
--|
--| Revision 1.22.4.6  2000/09/06 23:18:38  king
--| Reviewed
--|
--| Revision 1.22.4.5  2000/07/24 21:33:39  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.22.4.4  2000/07/19 18:55:31  king
--| Made compilable with new pnd changes, needs testing
--|
--| Revision 1.22.4.3  2000/06/26 00:22:41  king
--| Added able_to_transport
--|
--| Revision 1.22.4.2  2000/06/25 19:03:10  king
--| Added set_pebble_void function
--|
--| Revision 1.22.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.47  2000/04/05 17:00:13  king
--| Added update_pnd_status calls for PND transport enabling/disabling
--|
--| Revision 1.46  2000/03/31 19:07:26  king
--| Renamed pebble_o_wid -> pointer_o_wid, indented redundant PND features
--|
--| Revision 1.44  2000/03/30 23:22:21  king
--| Implemented pnd target functionality
--|
--| Revision 1.43  2000/03/30 19:33:33  king
--| Half implemented pebble_over_widget
--|
--| Revision 1.42  2000/03/29 01:41:22  king
--| Moved pixmapping features up
--|
--| Revision 1.41  2000/03/28 01:08:58  king
--| Updated pixmap features
--|
--| Revision 1.40  2000/03/25 01:51:44  king
--| Removed old implementation
--|
--| Revision 1.39  2000/03/24 01:27:47  king
--| Removed invalid destroyed feature, checking for void pixmap
--|
--| Revision 1.38  2000/03/23 19:16:59  king
--| Made compilable with new row structure
--|
--| Revision 1.37  2000/03/17 23:23:45  king
--| Added set_pointer_style as it doesnt inherit from widget
--|
--| Revision 1.36  2000/03/15 22:43:09  king
--| check falsed PND features
--|
--| Revision 1.35  2000/03/09 01:16:37  king
--| Added unimplemented pick and drop features
--|
--| Revision 1.34  2000/03/04 00:23:46  king
--| Commented out redundant color features
--|
--| Revision 1.33  2000/03/03 18:17:43  king
--| Fixed bug in set_columns
--|
--| Revision 1.32  2000/03/03 00:12:53  king
--| Changed set_selected to enable/disable_select
--|
--| Revision 1.31  2000/03/02 21:56:35  king
--| Removed redundant command association commands
--|
--| Revision 1.30  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.29  2000/02/19 00:35:29  oconnor
--| removed old command stuff
--|
--| Revision 1.28  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.27  2000/02/17 21:47:20  king
--| Added check for parent in set_cell_*
--|
--| Revision 1.26  2000/02/16 23:00:51  king
--| Removed redundant features
--|
--| Revision 1.25  2000/02/16 20:23:46  king
--| Corrected inheritence, add C feature
--|
--| Revision 1.24  2000/02/15 19:21:50  king
--| Made compilable
--|
--| Revision 1.23  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.3  2000/02/02 23:43:27  king
--| Removed definition of parent_imp
--|
--| Revision 1.22.6.2  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
