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
			top_level_window_imp,
			wel_move_and_resize
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

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
		repaint: BOOLEAN) is
			-- Make `x' and `y' the new position of `Current' and
			-- `w' and `h' the new width and height.
			-- If there is a child, it also adapts them to fit to the given
			-- value.
		do
			Precursor (a_x, a_y, a_width, a_height, repaint)
			if item_imp /= Void then
				item_imp.set_move_and_size (0, 0, 
					client_width, client_height)
			end
		end

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		do
			if item_imp /= Void then
				internal_set_minimum_width (item_imp.minimum_width)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of `Current'.
		do
			if item_imp /= Void then
				internal_set_minimum_height (item_imp.minimum_height)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		do
			if item_imp /= Void then
				internal_set_minimum_size (item_imp.minimum_width, 
					item_imp.minimum_height)
			end
		end

	interface: EV_CONTAINER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
