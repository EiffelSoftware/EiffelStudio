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

feature -- Access

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := internal_minimum_width
		end

	minimum_height: INTEGER
		-- Minimum width that the widget may occupy.
		do
			Result := internal_minimum_height
		end

feature -- Resizing

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
		do
			is_user_min_width_set := False
			internal_set_minimum_width (a_minimum_width)
			is_user_min_width_set := True
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			is_user_min_width_set := False
			internal_set_minimum_height (a_minimum_height)
			is_user_min_height_set := True
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			is_user_min_height_set := False
			is_user_min_width_set := False
			internal_set_minimum_size (a_minimum_width, a_minimum_height)
			is_user_min_height_set := True
			is_user_min_width_set := True
		end

	reset_minimum_width
			-- Reset the minimum width.
		do
			is_user_min_width_set := False
		end

	reset_minimum_height
			-- Reset the minimum height.
		do
			is_user_min_height_set := False
		end

	reset_minimum_size
			-- Reset the minimum size (width and height).
		do
			is_user_min_width_set := False
			is_user_min_height_set := False
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
			ev_move_and_resize (x_position, y_position,
					minimum_width.max (a_width),
					minimum_height.max (a_height), True)
		end

	internal_set_minimum_width (value: INTEGER)
			-- Make `value' the new `minimum_width' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_value: value >= 0
		deferred
		end

	internal_set_minimum_height (value: INTEGER)
			-- Make `value' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_value: value >= 0
		deferred
		end

	internal_set_minimum_size (mw, mh: INTEGER)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		require
			positive_mw: mw >= 0
			positive_mh: mh >= 0
		deferred
		end

feature {EV_SIZEABLE_IMP} -- Implementation

	-- Was the minimum width set by the user? In that case don't override it when recomputing

	is_user_min_width_set: BOOLEAN

	is_user_min_height_set: BOOLEAN


	internal_minimum_width: INTEGER
			-- Minimum width for the widget.

	internal_minimum_height: INTEGER
			-- Minimum height for the widget.

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
--			child_cell.move (a_x_position, a_y_position)
--			if is_show_requested then
				cocoa_move (a_x_position, a_y_position)
--			end
		end

	ev_apply_new_size, frozen ev_move_and_resize (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the widget to `a_x_position', `a_y_position' position and resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its children too.
		require
			not_is_destroyed: not is_destroyed
		do
--			child_cell.move_and_resize (a_x_position, a_y_position, a_width, a_height)
--			if is_show_requested then
				cocoa_set_size (a_x_position, a_y_position, a_width, a_height)
--			end
		end

	cocoa_move (a_x_position, a_y_position: INTEGER)
			-- Move the window to `a_x_position', `a_y_position'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		require
			not_is_destroyed: not is_destroyed
		deferred
		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER)
			-- Move the window to `a_x_position', `a_y_position' position and
			-- resize it with `a_width', `a_height'.
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- EV_SIZEABLE_IMP
