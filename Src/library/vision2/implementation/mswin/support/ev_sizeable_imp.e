--| FIXME NOT_REVIEWED this file has not been reviewed
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

	EV_BIT_OPERATIONS_I

feature {NONE} -- Initialization

	initialize is
		do
			is_initialized := True
			create child_cell
			set_vertical_resize (True)
			set_horizontal_resize (True)
		end

feature -- Access

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		deferred
		end

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		deferred
		end

feature -- Status report

	horizontal_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget
		do
			Result := bit_set (internal_changes, 16)
		end

	vertical_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget?
		do
			Result := bit_set (internal_changes, 32)
		end

	is_minwidth_recomputation_needed: BOOLEAN is
			-- Does the minimum width need to be recomputed?
		do
			Result := bit_set (internal_changes, 1)
		end

	is_minheight_recomputation_needed: BOOLEAN is
			-- Does the minimum height need to be recomputed?
		do
			Result := bit_set (internal_changes, 2)
		end

	is_minwidth_locked: BOOLEAN is
			-- Did the user set the minimum width?
			-- In this case, the minimum width cannot be
			-- changed by the system.
		do
			Result := bit_set (internal_changes, 4)
		end

	is_minheight_locked: BOOLEAN is
			-- Did the user set the minimum height?
			-- In this case, the minimum width cannot be
			-- changed by the system.
		do
			Result := bit_set (internal_changes, 8)
		end

feature -- Status setting

	set_horizontal_resize (flag: BOOLEAN) is
			-- Make `flag' the new horizontal_resizable status.
		do
			internal_changes := set_bit (internal_changes, 16, flag)
			if is_show_requested then
				parent_ask_resize (child_cell.width, child_cell.height)
			end
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Make `flag' the new vertical_resizable status.
		do
			internal_changes := set_bit (internal_changes, 32, flag)
			if is_show_requested then
				parent_ask_resize (child_cell.width, child_cell.height)
			end
		end

	set_minwidth_recomputation_needed (flag: BOOLEAN) is
			-- Make `flag' the new is_minwidth_recomputation_needed?
		do
			internal_changes := set_bit (internal_changes, 1, flag)
		end

	set_minheight_recomputation_needed (flag: BOOLEAN) is
			-- Make `flag' the new is_minheight_recomputation_needed?
		do
			internal_changes := set_bit (internal_changes, 2, flag)
		end

	set_minwidth_locked (flag: BOOLEAN) is
			-- Make `flag' the new is_minwidth_locked?
		do
			internal_changes := set_bit (internal_changes, 4, flag)
		end

	set_minheight_locked (flag: BOOLEAN) is
			-- Make `flag' the new is_minwidth_locked?
		do
			internal_changes := set_bit (internal_changes, 8, flag)
		end

feature -- Resizing

	set_size (w, h: INTEGER) is
			-- Resize the widget when it is not managed.
		do
			wel_resize (w.max (minimum_width), h.max (minimum_height))
		end

	set_width (value:INTEGER) is
			-- Make `value' the new width of the widget when
			-- it is not managed.
		do
			wel_resize (value.max (minimum_width), height)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height of the widget when
			-- it is not managed.
		do
			wel_resize (width, value.max (minimum_height))
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- There is no need to grow the object if its size is
			-- too small, the parent will do it if necessary.
		do
			set_minwidth_locked (False)
			internal_set_minimum_width (value)
			set_minwidth_locked (True)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- There is no need to grow the object if its size is
			-- too small, the parent will do it if necessary.
		do
			set_minheight_locked (False)
			internal_set_minimum_height (value)
			set_minheight_locked (True)
		end

	set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
		do
			set_minwidth_locked (False)
			set_minheight_locked (False)
			internal_set_minimum_size (mw, mh)
			set_minwidth_locked (True)
			set_minheight_locked (True)
		end

feature -- Position

	set_position (new_x_position: INTEGER; new_y_position: INTEGER) is
			-- Put at horizontal position `new_x_position' and at
			-- vertical position `new_y_position' relative to parent.
		do
			wel_move (new_x_position, new_y_position)
		end

feature -- Contract support

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		obsolete
			"Do not use it."
		local
			temp: INTEGER
		do
			Result := (width = new_width or else width = internal_minimum_width) and then
				  (height = new_height or else height = internal_minimum_height)
		end

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		obsolete
			"Do not use it."
		do
			if new_width = -1 then
				Result := new_height = internal_minimum_height
			elseif new_height = -1 then
				Result := new_width = internal_minimum_width
			else
				Result := new_width = internal_minimum_width
					and new_height = internal_minimum_height
			end
		end		

	position_set (new_x_position, new_y_position: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		obsolete
			"Do not use it."
		do
			if new_x_position = -1 then
				Result := new_y_position = y_position
			elseif new_y_position = -1 then
				Result := new_x_position = x_position
			else
				Result := new_x_position = x_position and new_y_position = y_position
			end
		end

feature -- Basic operation

	set_move_and_size (a_x_position, a_y_position, a_width, a_height: INTEGER) is
			-- Move and resize the widget. Only the parent can call this feature
			-- because it doesn't notify the parent of the change.
			-- Equivalent of `parent_ask_resize' with move.
		do
			child_cell.move (a_x_position, a_y_position)
			parent_ask_resize (a_width, a_height)
		end

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- Called by the parent when the size of `Current' has to be
			-- changed to `a_width', `a_height'.
			-- Too slow?
		local
			new_width, new_height: INTEGER
			new_x, new_y: INTEGER
		do
			-- We have to use minimum_size here to show the widgets.
			child_cell.resize (minimum_width.max (a_width), minimum_height.max (a_height))

			if vertical_resizable then
				new_height := child_cell.height
				new_y := child_cell.y
			else
				new_height := minimum_height.min (child_cell.height)
				new_y := child_cell.y + (child_cell.height - new_height) // 2
			end

			if horizontal_resizable then
				new_width := child_cell.width
				new_x := child_cell.x
			else
				new_width := minimum_width.min (child_cell.width)
				new_x := child_cell.x + (child_cell.width - new_width) // 2
			end

			wel_move_and_resize (new_x, new_y, new_width, new_height, True)
		end

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		deferred
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		deferred
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		deferred
		end

	integrate_changes is
			-- A fonction that simply recompute the minimum size if
			-- necessary. It do not resize the widget, only integrate
			-- the changes.
		deferred
		end

feature {EV_SIZEABLE_IMP} -- Implementation

	child_cell: EV_RECTANGLE
			-- The space that the parent allow to the current
			-- child.

	internal_minimum_width: INTEGER
			-- Last computed minimum width.

	internal_minimum_height: INTEGER
			-- Last computed minimum height.

	internal_changes: INTEGER
			-- What kind of changes have been done on the object.
			-- Binary integer whith the following meaning :
			-- bit 1 -> the minimum width needs to be recomputed	(1)
			-- bit 2 -> the minimum height needs to be recomputed	(2)
			-- bit 3 -> the user has set the minimum width			(4)
			-- bit 4 -> the user has set the minimum height			(8)
			-- bit 5 -> the child only resize its width				(16)
			-- bit 6 -> the child only resize its height			(32)

feature {EV_ANY_I} -- deferred feature

	parent_imp: EV_SIZEABLE_CONTAINER_IMP is
			-- Parent of this sizeable widget
		deferred
		end

	width: INTEGER is
			-- Width of widget
			-- Implemented by wel.
		deferred
		end

	height: INTEGER is
			-- Height of widget
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

	is_show_requested: BOOLEAN is
			-- Is the widget shown?
			-- Implemented by wel.
		deferred
		end

	--shown: BOOLEAN is obsolete "is_show_requested" do Result := is_show_requested end

	managed: BOOLEAN is
			-- Is the current widget managed?
		deferred
		end

feature -- Obsolete

	Nc_minwidth: INTEGER is 1
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum width of 
			-- the current widget has changed.

	Nc_minheight: INTEGER is 2
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum height of 
			-- the current widget has changed.

	Nc_minsize: INTEGER is 3
			-- Used only in the `notify_change' feature to
			-- notify the parent that both the minimum width
			-- and height of the current widget have changed.

end -- EV_SIZEABLE_IMP
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| Altered to fit in with the review branch. Shown replaced with is_show_requested.
--|
--| Revision 1.16.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
