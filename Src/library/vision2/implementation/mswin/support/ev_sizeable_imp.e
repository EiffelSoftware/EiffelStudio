indexing
	description:
		"Eiffel Vision sizeable. Mswindows implementation of ancestor%N%
		%for EV_SIZEABLE_PRIMITIVE_IMP and EV_SIZEABLE_CONTAINER_IMP."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$" 

deferred class
	EV_SIZEABLE_IMP

inherit
	EV_ANY_I

feature {NONE} -- Initialization

	initialize_sizeable is
			-- Initialize sizing attributes of `Current'.
		do
			create child_cell
		end

feature -- Access

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		do
			Result := child_cell.minimum_width
		end

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		do
			Result := child_cell.minimum_height
		end

feature -- Resizing

	set_size (w, h: INTEGER) is
			-- Resize `Current'.
		do
			ev_resize (w.max (minimum_width), h.max (minimum_height))
		end

	set_width (value:INTEGER) is
			-- Make `value' the new width of `Current'.
		do
			ev_resize (value.max (minimum_width), height)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height of `Current'.
		do
			ev_resize (width, value.max (minimum_height))
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		do
			ev_set_minimum_width (value)
			child_cell.set_user_minimum_width (value)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		do
			ev_set_minimum_height (value)
			child_cell.set_user_minimum_height (value)
		end

	set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
		do
			ev_set_minimum_size (mw, mh)
			child_cell.set_user_minimum_width (mw)
			child_cell.set_user_minimum_height (mh)
		end

	ev_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		deferred
		end

	ev_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		deferred
		end

	ev_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
		deferred
		end

feature -- Position

	set_position (new_x_position: INTEGER; new_y_position: INTEGER) is
			-- Put at horizontal position `new_x_position' and at
			-- vertical position `new_y_position' relative to parent.
		do
			child_cell.set_is_positioned
			ev_move (new_x_position, new_y_position)
		end

feature -- Basic operation

	set_move_and_size
		(a_x_position, a_y_position, a_width, a_height: INTEGER) is
			-- Move and resize the widget. Only the parent can call this feature
			-- because it doesn't notify the parent of the change.
			-- Equivalent of `parent_ask_resize' with move.
		do
			ev_move_and_resize (a_x_position, a_y_position,
					minimum_width.max (a_width),
					minimum_height.max (a_height), True)
		end

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- Called by the parent when the size of `Current' has to be
			-- changed to `a_width', `a_height'.
		do
			ev_move_and_resize (child_cell.x, child_cell.y,
					minimum_width.max (a_width),
					minimum_height.max (a_height), True)
		end

	internal_set_size (mw, mh: INTEGER) is
			-- Set `size' of `child_cell'.
		require
			positive_mw: mw >= 0
			positive_mh: mh >= 0
		do
			if is_displayed then
				child_cell.set_width (mw)
				child_cell.set_height (mh)
			end
		end

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_value: value >= 0
		do
			child_cell.set_minimum_width (value)
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_value: value >= 0
		do
			child_cell.set_minimum_height (value)
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_mw: mw >= 0
			positive_mh: mh >= 0
		do
			child_cell.set_minimum_width (mw)
			child_cell.set_minimum_height (mh)
		end

feature {EV_SIZEABLE_IMP} -- Implementation

	child_cell: EV_POS_INFO
			-- The space that the parent allow to the current
			-- child plus its minimum size properties.

feature {EV_ANY_I} -- deferred feature

	parent_imp: EV_SIZEABLE_CONTAINER_IMP is
			-- Parent of `Current'.
		deferred
		end

	width: INTEGER is
			-- Width of `Current'.
			-- Implemented by wel.
		deferred
		end

	height: INTEGER is
			-- Height of `Current'.
			-- Implemented by wel.
		deferred
		end

	x_position: INTEGER is
			-- Horizontal position relative to parent
			-- Implemented by wel.
		deferred
		end

	y_position: INTEGER is
			-- Vertical position relative to parent
			-- Implemented by wel.
		deferred
		end

	frozen ev_move (a_x_position, a_y_position: INTEGER) is
			-- Move the window to `a_x_position', `a_y_position'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		do
			child_cell.move (a_x_position, a_y_position)
			if is_show_requested then
				wel_move (a_x_position, a_y_position)
			end
		end

	ev_apply_new_size, frozen ev_move_and_resize (a_x_position, a_y_position,
			a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		do
			child_cell.move_and_resize
				(a_x_position, a_y_position, a_width, a_height)
			if is_show_requested then
				wel_move_and_resize
					(a_x_position, a_y_position, a_width, a_height, True)
			end
		end

	frozen ev_resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
		do
			child_cell.resize (a_width, a_height)
			if is_show_requested then
				wel_resize (a_width, a_height)
			end
		end

	frozen ev_width: INTEGER is
		do
			if is_show_requested then
				Result := wel_width
			else
				Result := child_cell.width
			end
		end

	frozen ev_height: INTEGER is
		do
			if is_show_requested then
				Result := wel_height
			else
				Result := child_cell.height
			end
		end

	wel_move (a_x_position, a_y_position: INTEGER) is
			-- Move the window to `a_x_position', `a_y_position'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		deferred
		end

	wel_move_and_resize (a_x_position, a_y_position, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		deferred
		end

	wel_resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
		deferred
		end

	wel_width: INTEGER is
			-- Real `width' of widget as seen on screen.
		deferred
		end

	wel_height: INTEGER is
			-- Real `height' of widget as seen on screen.
		deferred
		end

	is_show_requested: BOOLEAN is
			-- Is `Current' to be shown?
			-- Implemented by wel.
		deferred
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible to screen?
			-- Implemented by WEL
		deferred
		end

feature -- Obsolete

	Nc_minwidth: INTEGER is 1
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum width of 
			-- `Current' has changed.

	Nc_minheight: INTEGER is 2
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum height of 
			-- `Current' has changed.

	Nc_minsize: INTEGER is 3
			-- Used only in the `notify_change' feature to
			-- notify the parent that both the minimum width
			-- and height of `Current' widget have changed.

end -- EV_SIZEABLE_IMP
 
--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.26  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.25  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.24  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.8.11  2000/12/05 00:33:05  xavier
--| Fixed a bug that made it impossible to set the position of windows before they were
--| displayed (fix by Emmanuel).
--|
--| Revision 1.16.8.10  2000/10/06 23:58:53  rogers
--| Set_position now calls ev_move instead of wel_move. This updates the
--| x and y of `child_cell' correctly now.
--|
--| Revision 1.16.8.9  2000/09/15 22:56:30  manus
--| Fixed a Typo in variable name due to a copy/paste of some unknowns source.
--|
--| Revision 1.16.8.8  2000/08/11 19:00:57  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.16.8.7  2000/08/08 01:49:01  manus
--| New resizing policy which always do a minimum_size computation when needed, but not
--| always. See `vision2/implementation/mswin/doc/sizing_how_to.txt' for more details.
--|
--| Revision 1.16.8.6  2000/06/19 22:04:53  rogers
--| Removed integrate_changes, as Vision2 never uses it.
--|
--| Revision 1.16.8.5  2000/06/13 00:53:28  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.16.8.4  2000/06/05 20:48:55  manus
--| Added `is_displayed' that tells if a window is shown (ie visible) on screen.
--|
--| Revision 1.16.8.3  2000/05/13 00:51:26  king
--| Integrated with change to EV_DYNAMIC_LIST
--|
--| Revision 1.16.8.2  2000/05/03 22:13:03  pichery
--| Removed some obsolete features
--|
--| Revision 1.16.8.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.22  2000/03/14 20:01:08  brendel
--| Renamed initialize to initialize_sizeable.
--|
--| Revision 1.21  2000/03/14 16:17:36  brendel
--| Improved initialize.
--|
--| Revision 1.20  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.19.2.4  2000/03/14 00:14:31  brendel
--| Removed request_paint and move_and_resize.
--| Changed all calls to wel_move_and_resize back to have repaint `True' at
--| every call. It seems to be inevitable to have every change redrawn.
--| This is what causes the flickering, though, so a workaround has to be
--| found or the entire design has to be redone.
--|
--| Revision 1.19.2.3  2000/03/11 00:11:12  brendel
--| Changed initialization sequence.
--| Replaced is_displayed consistently with is_show_requested. Whether that is
--| really necessary is unclear.
--| Redefined move_and_resize. Adds no functionality yet, but could be
--| optimized if only position or size is changed for example.
--| Added feature `request_paint' that repaints the widget. Maybe `invalidate'
--| can be used instead.
--| Changed type of parent_imp to EV_SIZEABLE_CONTAINER_IMP.
--| Renamed move_and_resize and resize and move to wel_*, to make more clear
--| which calls are direct toolkit calls.
--|
--| Revision 1.19.2.1  2000/03/09 21:54:20  brendel
--| Moved features that were before redefined by EV_SIZEABLE_CONTAINER_IMP
--| to EV_SIZEABLE_PRIMITIVE_IMP.
--|
--| Revision 1.19  2000/03/06 21:19:48  brendel
--| Fixed bug in internal_set_minimum_width.
--|
--| Revision 1.18  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.17  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.10.4  2000/02/07 18:26:40  rogers
--| Replaced all calls to displayed by is_show_requested.
--|
--| Revision 1.16.10.3  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.10.2  1999/12/17 01:06:58  rogers
--| Altered to fit in with the review branch. Shown replaced with
--| is_show_requested.
--|
--| Revision 1.16.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
