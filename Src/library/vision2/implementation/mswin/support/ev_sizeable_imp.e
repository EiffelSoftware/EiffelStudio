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
			child_cell.disable_user_min_width_set
			ev_set_minimum_width (value)
			child_cell.set_user_minimum_width (value)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		do
			child_cell.disable_user_min_height_set
			ev_set_minimum_height (value)
			child_cell.set_user_minimum_height (value)
		end

	set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
		do
			child_cell.disable_user_min_width_set
			child_cell.disable_user_min_height_set
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
 
--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

