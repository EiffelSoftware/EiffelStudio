indexing
	description: 
		"Eiffel Vision cell, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_CELL_IMP
	
inherit
	EV_CELL_I
		redefine
			interface
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end

create
	make

feature {NONE} -- initialization

	make (an_interface: like interface) is
			-- Create `Current'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
		end

feature -- Element change

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			if item_imp /= Void then
				item_imp.set_top_level_window_imp (a_window)
			end
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		do
			if item_imp /= Void and item_imp.is_show_requested then
				ev_set_minimum_width (item_imp.minimum_width)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of `Current'.
		do
			if item_imp /= Void and item_imp.is_show_requested then
				ev_set_minimum_height (item_imp.minimum_height)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		do
			if item_imp /= Void and item_imp.is_show_requested then
				ev_set_minimum_size (item_imp.minimum_width, 
					item_imp.minimum_height)
			end
		end

	interface: EV_CONTAINER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

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
--| Revision 1.16  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.15  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.14  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.2.5  2001/01/26 23:38:36  rogers
--| Removed undefinition of on_sys_key_down as this is already done in the
--| ancestor EV_WEL_CONTROL_CONTAINER_IMP.
--|
--| Revision 1.13.2.4  2000/11/06 18:03:29  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.13.2.3  2000/10/18 16:23:00  rogers
--| Compute_minimum_width, compute_minimum_size and compute_minimum_height
--| now all take into account whether the child is visible or not.
--|
--| Revision 1.13.2.2  2000/08/08 03:12:22  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Sizing is now done in EV_SINGLE_CHILD_CONTAINER_IMP
--|
--| Revision 1.13.2.1  2000/05/03 19:09:26  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/05/03 16:23:02  rogers
--| Comments, formatting.
--|
--| Revision 1.12  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.11  2000/03/29 21:30:09  brendel
--| Used redefinition instead of renaming.
--|
--| Revision 1.10  2000/03/23 19:33:26  brendel
--| Removed FIXME related to previous commital.
--|
--| Revision 1.8  2000/03/22 22:49:12  brendel
--| Changed to avoid segmentation violation because of bug in compiler.
--|
--| Revision 1.7  2000/03/21 23:39:00  brendel
--| Modified inheritance clause in compliance with EV_SIZEABLE_IMP.
--|
--| Revision 1.6  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.5.2.1  2000/03/11 00:19:15  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.5  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/22 17:34:49  rogers
--| Redefined move_and_resize from EV_WEL_CONTROL_CONTAINER_IMP,
--| compute_minimum_width, compute_minimum_height and  compute_minimum_size
--| from EV_SINGLE_CHILD_CONTAINER_IMP.
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.1.2.4  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  2000/01/20 20:12:25  brendel
--| Got it to compile.
--|
--| Revision 1.1.2.2  2000/01/20 20:02:29  brendel
--| Started implementing.
--|
--| Revision 1.1.2.1  2000/01/20 19:26:11  brendel
--| Initial.
--|
--| Revision 1.1.2.4  2000/01/20 18:47:16  oconnor
--| made non deferred
--|
--| Revision 1.1.2.3  2000/01/18 19:35:39  oconnor
--| added feature item
--|
--| Revision 1.1.2.2  2000/01/18 18:02:39  oconnor
--| redefined interface
--|
--| Revision 1.1.2.1  2000/01/18 18:01:48  oconnor
--| initial
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
