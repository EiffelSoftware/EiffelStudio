indexing
	description: "Eiffel Vision menu bar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			Precursor (an_interface)
			wel_make
		end
		
feature {EV_ANY_I} -- Status report

	parent: EV_WINDOW is
			-- Parent of `Current'.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface					
			end
		end

feature {NONE} -- Implementation

	is_sensitive: BOOLEAN is True
			-- `Current' is always sensitive as it cannot be disabled
			-- in the interface.

	destroy is
			-- destroy `Current'.
		do
			if parent_imp /= Void then
				parent_imp.remove_menu_bar
			end
			is_destroyed := True
		end
		
	update_parent_size is
			-- Update size of `Parent_imp'.
		do
			if parent_imp /= Void then
				parent_imp.compute_minimum_size	
			end
		end

feature {NONE} -- Pick and drop support

	--| FIXME All these features to be implemented are required by PND.
	-- Due to the way that windows handles messaging with menu's, implementing
	-- pick and drop may be difficult.
	-- I think that the pick and drop can be done using WM_MENURBUTTONUP,
	-- although drag and drop may be a lot more difficult.
	-- Julian Rogers 08/22/2000

	disable_default_processing is
			-- Disable default window processing.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on pointer press.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on pointer double press.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MENU_IMP is
			-- `Result' is menu at pixel position `x_pos', `y_pos'.
		do
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen.
		do
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen.
		do
		end

	set_pointer_style (value: EV_CURSOR) is
			-- Make `value' the new cursor of the widget
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once 
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	release_heavy_capture is
			-- Release user input
			-- Works on all windows threads.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		do
			check
				pick_and_drop_not_implemented_for_menus: False
			end
		end

feature {EV_ANY_I} -- Status Report 
		
	top_level_window_imp: EV_WINDOW_IMP is
			-- Top level window implementation containing `Current'.
		do
			Result := parent_imp
		end

	set_parent_imp (window: EV_WINDOW_IMP) is
			-- Assign `window' to `parent_imp'.
		do
			if window /= Void then
				parent_imp := window
			else
				parent_imp := Void
			end
		end
		
	wel_count_empty: BOOLEAN is
			-- Is `Current' empty?
			--| In some places, we wish to externally query if `Current'
			--| is empty. However, if this is done during a remove_item,
			--| the interface will still return the count as 1. See 
			--|`Extra_minimum_height' from EV_TITLED_WINDOW_IMP.
		do
			Result := wel_count = 0
		end

	parent_imp: EV_WINDOW_IMP
		-- Parent of `Current'.

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR

end -- class EV_MENU_BAR_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.13  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.12  2001/06/21 18:51:42  rogers
--| Implemented parent.
--|
--| Revision 1.11  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.8.15  2001/05/18 00:27:00  rogers
--| Remoed setting of destroy_just_called to True.
--|
--| Revision 1.5.8.14  2001/03/21 22:32:19  rogers
--| Added `wel_count_empty' for querying state of `Current' within
--| our implementation of other classes.
--|
--| Revision 1.5.8.13  2001/03/21 18:19:01  rogers
--| Fixed update_parent_size to check that `parent_imp' is not void. Previously
--| a system would crash if you added an EV_MENU to an EV_MENU_BAR before
--| the EV_MENU_BAR was parented.
--|
--| Revision 1.5.8.12  2001/02/06 01:53:18  rogers
--| Added find_item_at_position, screen_x and screen_y.
--|
--| Revision 1.5.8.11  2000/12/29 18:21:15  rogers
--| Aded disable_default_processing and commented features with missing
--| comments.
--|
--| Revision 1.5.8.10  2000/10/20 17:18:45  rogers
--| Implemented destroy.
--|
--| Revision 1.5.8.9  2000/09/27 16:10:47  rogers
--| Implemented parent_imp, set_parent_imp and top_level_window_imp.
--|
--| Revision 1.5.8.8  2000/09/12 22:04:42  rogers
--| Exported loading/Saving features to EV_DEFAULT_PIXMAPS_IMP.
--|
--| Revision 1.5.8.6  2000/08/21 18:08:38  rogers
--| Added destroy.
--|
--| Revision 1.5.8.5  2000/08/16 23:10:26  rogers
--| Added is_sensitive as True. Added as EV_MENU_ITEM_LIST_IMP has had
--| is_Sensitive added as defferred. Is_sensitive always returns true as the
--| user can never enable or disable sensitivity on `Current'.
--|
--| Revision 1.5.8.4  2000/08/11 23:51:03  rogers
--| Corrected copyright clause.
--|
--| Revision 1.5.8.3  2000/06/09 20:32:31  rogers
--| Added internal_propagate_pointer_double_press.
--|
--| Revision 1.5.8.2  2000/05/15 22:03:54  rogers
--| Added top_level_window_imp.
--|
--| Revision 1.5.8.1  2000/05/03 19:09:52  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/11 16:55:15  rogers
--| Added features required by EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.8  2000/04/10 16:27:57  brendel
--| Modified creation sequence.
--|
--| Revision 1.7  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.6  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.10.4  2000/02/05 02:25:37  brendel
--| Revised.
--| Implemented using newly created EV_MENU_ITEM_LIST.
--|
--| Revision 1.5.10.3  2000/02/04 01:05:41  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.5.10.2  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.10.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
