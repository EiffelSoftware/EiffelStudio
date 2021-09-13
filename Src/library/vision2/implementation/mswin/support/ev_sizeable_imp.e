note
	description:
		"Eiffel Vision sizeable. Mswindows implementation of ancestor%N%
		%for EV_SIZEABLE_PRIMITIVE_IMP and EV_SIZEABLE_CONTAINER_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SIZEABLE_IMP

inherit
	EV_ANY_I

feature {NONE} -- Initialization

	initialize_sizeable
			-- Initialize sizing attributes of `Current'.
		do
			create child_cell
		end

feature -- Access

	minimum_width: INTEGER
			-- Lower bound on `width' in pixels.
		do
			Result := child_cell.minimum_width
		end

	minimum_height: INTEGER
			-- Lower bound on `height' in pixels.
		do
			Result := child_cell.minimum_height
		end

feature -- Resizing

	set_size (w, h: INTEGER)
			-- Resize `Current'.
		require
			not_is_destroyed: not is_destroyed
		do
			ev_resize (w.max (minimum_width), h.max (minimum_height))
		end

	set_width (value:INTEGER)
			-- Make `value' the new width of `Current'.
		require
			not_is_destroyed: not is_destroyed
		do
			ev_resize (value.max (minimum_width), height)
		end

	set_height (value: INTEGER)
			-- Make `value' the new height of `Current'.
		require
			not_is_destroyed: not is_destroyed
		do
			ev_resize (width, value.max (minimum_height))
		end

	set_minimum_width (value: INTEGER)
			-- Make `value' the new `minimum_width' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.disable_user_min_width_set
			ev_set_minimum_width (value, False)
			child_cell.set_user_minimum_width (value)
		end

	set_minimum_height (value: INTEGER)
			-- Make `value' the new `minimum_height' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.disable_user_min_height_set
			ev_set_minimum_height (value, False)
			child_cell.set_user_minimum_height (value)
		end

	set_minimum_size (mw, mh: INTEGER)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.disable_user_min_width_set
			child_cell.disable_user_min_height_set
			ev_set_minimum_size (mw, mh, False)
			child_cell.set_user_minimum_width (mw)
			child_cell.set_user_minimum_height (mh)
		end

	ev_set_minimum_width (value: INTEGER; a_is_size_forced: BOOLEAN)
			-- Make `value' the new `minimum_width' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
			-- If `a_is_size_forced' then force an actual computation of the real size too.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	ev_set_minimum_height (value: INTEGER; a_is_size_forced: BOOLEAN)
			-- Make `value' the new `minimum_height' of `Current'.
			-- There is no need to grow `Current' if its size is
			-- too small, the parent will do it if necessary.
			-- If `a_is_size_forced' then force an actual computation of the real size too.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	ev_set_minimum_size (mw, mh: INTEGER; a_is_size_forced: BOOLEAN)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- If `a_is_size_forced' then force an actual computation of the real size too.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

feature -- Position

	set_position (new_x_position: INTEGER; new_y_position: INTEGER)
			-- Put at horizontal position `new_x_position' and at
			-- vertical position `new_y_position' relative to parent.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.set_is_positioned
			ev_move (new_x_position, new_y_position)
		end

feature -- Basic operation

	set_move_and_size
		(a_x_position, a_y_position, a_width, a_height: INTEGER)
			-- Move and resize the widget. Only the parent can call this feature
			-- because it doesn't notify the parent of the change.
			-- Equivalent of `parent_ask_resize' with move.
		require
			not_is_destroyed: not is_destroyed
		do
			ev_move_and_resize (a_x_position, a_y_position,
					minimum_width.max (a_width),
					minimum_height.max (a_height), True)
		end

	parent_ask_resize (a_width, a_height: INTEGER)
			-- Called by the parent when the size of `Current' has to be
			-- changed to `a_width', `a_height'.
		require
			not_is_destroyed: not is_destroyed
		do
			ev_move_and_resize (child_cell.x, child_cell.y,
					minimum_width.max (a_width),
					minimum_height.max (a_height), True)
		end

	internal_set_size (mw, mh: INTEGER)
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

	internal_set_minimum_width (value: INTEGER)
			-- Make `value' the new `minimum_width' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_value: value >= 0
		do
			child_cell.set_minimum_width (value)
		end

	internal_set_minimum_height (value: INTEGER)
			-- Make `value' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_value: value >= 0
		do
			child_cell.set_minimum_height (value)
		end

	internal_set_minimum_size (mw, mh: INTEGER)
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

	parent_imp: detachable EV_SIZEABLE_CONTAINER_IMP
			-- Parent of `Current'.
		deferred
		end

	width: INTEGER
			-- Width of `Current'.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	height: INTEGER
			-- Height of `Current'.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	x_position: INTEGER
			-- Horizontal position relative to parent
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	y_position: INTEGER
			-- Vertical position relative to parent
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	frozen ev_move (a_x_position, a_y_position: INTEGER)
			-- Move the window to `a_x_position', `a_y_position'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.move (a_x_position, a_y_position)
			wel_move (a_x_position, a_y_position)
		end

	ev_apply_new_size, frozen ev_move_and_resize (a_x_position, a_y_position,
			a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.move_and_resize (a_x_position, a_y_position, a_width, a_height)
			if is_show_requested then
				wel_move_and_resize
					(a_x_position, a_y_position, a_width, a_height, True)
			end
		end

	frozen ev_resize (a_width, a_height: INTEGER)
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		do
			child_cell.resize (a_width, a_height)
			if is_show_requested then
				wel_resize (a_width, a_height)
			end
		end

	frozen ev_width: INTEGER
		require
			not_is_destroyed: not is_destroyed
		do
			if is_show_requested then
				Result := wel_width
			else
				Result := child_cell.width
			end
		end

	frozen ev_height: INTEGER
		require
			not_is_destroyed: not is_destroyed
		do
			if is_show_requested then
				Result := wel_height
			else
				Result := child_cell.height
			end
		end

	wel_move (a_x_position, a_y_position: INTEGER)
			-- Move the window to `a_x_position', `a_y_position'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	wel_move_and_resize (a_x_position, a_y_position, a_width, a_height: INTEGER;
			repaint: BOOLEAN)
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	wel_resize (a_width, a_height: INTEGER)
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	wel_width: INTEGER
			-- Real `width' of widget as seen on screen.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	wel_height: INTEGER
			-- Real `height' of widget as seen on screen.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	is_show_requested: BOOLEAN
			-- Is `Current' to be shown?
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible to screen?
			-- Implemented by WEL
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

feature -- Obsolete

	Nc_minwidth: INTEGER = 1
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum width of
			-- `Current' has changed.

	Nc_minheight: INTEGER = 2
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum height of
			-- `Current' has changed.

	Nc_minsize: INTEGER = 3;
			-- Used only in the `notify_change' feature to
			-- notify the parent that both the minimum width
			-- and height of `Current' widget have changed.

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
