indexing
	description:
		"Handles that allow the user to control certain EV_RELATIVE_POINTs%N%
		%in an EV_FIGURE_WORLD."
	status: "See notice at end of class"
	keywords: "point, handle, move, resize, grab"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MOVE_HANDLE

inherit
	EV_FIGURE_GROUP
		redefine
			default_create,
			snap_to_grid
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize actions.
		do
			Precursor
			initialize
		end

	initialize is
			-- Set action sequences.
		do
			create start_actions
			create end_actions
			create move_actions
			pointer_button_press_actions.extend (~on_start_resizing)
			pointer_motion_actions.extend (~on_resizing)
			pointer_button_release_actions.extend (~on_stop_resizing)
			show_agent := ~on_enter
			hide_agent := ~on_leave
			is_always_shown := True
			minimum_x := Min_integer
			minimum_y := Min_integer
			maximum_x := Max_integer
			maximum_y := Max_integer
			is_snapping := True
		end

feature -- Access

	minimum_x: INTEGER
			-- Left boundary.

	maximum_x: INTEGER
			-- Right boundary.

	minimum_y: INTEGER
			-- Top boundary.

	maximum_y: INTEGER
			-- Bottom boundary.

	real_position_agent: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], TUPLE [INTEGER, INTEGER]]
			-- User defined function that translates actual coordinates to
			-- the coordinates `Current' will be displayed on.

feature -- Status report

	is_always_shown: BOOLEAN
			-- Is `figure' always shown?
			-- (Or only when pointer over `figure'?)

	is_snapping: BOOLEAN
			-- Does `Current' snap to grid when grid is enabled?
			-- Default: True

feature -- Status setting

	enable_always_shown is
			-- Set `is_always_shown' `True'.
		do
			if not is_always_shown then
				is_always_shown := True
				show
				pointer_leave_actions.prune_all (hide_agent)
				pointer_enter_actions.prune_all (show_agent)
			end
		ensure
			is_always_shown: is_always_shown
		end

	disable_always_shown is
			-- Set `is_always_shown' `False'.
		do
			if is_always_shown then
				is_always_shown := False
				hide
				pointer_leave_actions.put_front (hide_agent)
				pointer_enter_actions.put_front (show_agent)
			end
		ensure
			not_always_shown: not is_always_shown
		end

	enable_snapping is
			-- Set `is_snapping' `True'.
		do
			is_snapping := True
		ensure
			snap_enabled: is_snapping
		end

	disable_snapping is
			-- Set `is_snapping' `False'.
		do
			is_snapping := False
		ensure
			snap_disabled: not is_snapping
		end

	snap_to_grid is
			-- Move to the most nearby point on the grid.
		do
			if is_snapping then
				point.set_position (snapped_x (point.x), snapped_y (point.y))
			end
		end

feature -- Element change

	set_minimum_x (a_x: INTEGER) is
			-- Assign `a_x' to `minimum_x'.
		do
			minimum_x := a_x
		end

	set_minimum_y (a_y: INTEGER) is
			-- Assign `a_y' to `minimum_y'.
		do
			minimum_y := a_y
		end

	set_maximum_x (a_x: INTEGER) is
			-- Assign `a_x' to `maximum_x'.
		do
			maximum_x := a_x
		end

	set_maximum_y (a_y: INTEGER) is
			-- Assign `a_y' to `maximum_y'.
		do
			maximum_y := a_y
		end

	set_real_position_agent (an_agent: like real_position_agent) is
			-- Assign `an_agent' to `real_position_agent'.
		require
			an_agent_not_void: an_agent /= Void
		do
			real_position_agent := an_agent
		ensure
			real_position_agent_assigned: real_position_agent = an_agent
		end

feature -- Actions

	start_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when drag starts.

	end_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when drag ends.

	move_actions: EV_PND_START_ACTION_SEQUENCE
			-- Actions called when user drags `Current'.

feature {NONE} -- Events

	Max_integer: INTEGER is 100000
			-- Highest possible integer value.

	Min_integer: INTEGER is -100000
			-- Lowest possible integer value.

	show_agent: PROCEDURE [ANY, TUPLE []]
			-- Connected to `enter_actions'.

	hide_agent: PROCEDURE [ANY, TUPLE []]
			-- Connected to `leave_actions'.

	on_enter is
		do
			show
		end

	on_leave is
		do
			hide
		end

	rel_x, rel_y: INTEGER

	snapped_x (ax: INTEGER): INTEGER is
			-- Nearest point on horizontal grid to `ax'.
		local
			px, wx: INTEGER
		do
			wx := world.point.x
			if point.origin /= Void and then point.origin /= world.point then
				px := (point.origin.x_abs / point.origin.scale_x_abs).rounded
			end
			Result := world.x_to_grid (wx + px + ax) - px - wx
		end

	snapped_y (ay: INTEGER): INTEGER is
			-- Nearest point on vertical grid to `ay'.
		local
			py, wy: INTEGER
		do
			wy := world.point.y
			if point.origin /= Void and then point.origin /= world.point then
				py := (point.origin.y_abs / point.origin.scale_y_abs).rounded
			end
			Result := world.y_to_grid (wy + py + ay) - py - wy
		end

	on_start_resizing (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER) is
			-- User pressed pointer button on `Current'.
		do
			if b = 1 then
				start_actions.call ([])
				enable_capture
				rel_x := (x / point.origin.scale_x_abs).rounded - point.x
				rel_y := (y / point.origin.scale_y_abs).rounded - point.y
			end
		end

	on_resizing (x, y: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER) is
			-- Mouse moved over `Current'.
		local
			tx, ty: INTEGER
			scx, scy: DOUBLE
			new_x, new_y: INTEGER
			t: TUPLE [INTEGER, INTEGER]
		do
			if has_capture then
				scx := point.origin.scale_x_abs
				scy := point.origin.scale_y_abs
				tx := (x / scx).rounded - rel_x
				ty := (y / scy).rounded - rel_y
				tx := tx.min (maximum_x).max (minimum_x)
				ty := ty.min (maximum_y).max (minimum_y)
				if real_position_agent /= Void then
					real_position_agent.call ([tx, ty])
					t := real_position_agent.last_result
					new_x := t.integer_item (1)
					new_y := t.integer_item (2)
				else
					if world.grid_enabled and is_snapping then
						world.set_grid_x (world.Default_grid_x)
						world.set_grid_y (world.Default_grid_y)
						new_x := snapped_x (tx)
						new_y := snapped_y (ty)
						world.set_grid_x ((world.Default_grid_x * scx).rounded)
						world.set_grid_y ((world.Default_grid_y * scy).rounded)
					else
						new_x := tx
						new_y := ty
					end
				end
				if point.x /= new_x or point.y /= new_y then
					point.set_position (new_x, new_y)
					move_actions.call ([new_x, new_y])
				end
			end
		end

	on_stop_resizing (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER) is
			-- User release pointer button from `Current'.
		do
			if has_capture then
				disable_capture
				end_actions.call ([])
			end
		end

end -- class EV_MOVE_HANDLE

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

