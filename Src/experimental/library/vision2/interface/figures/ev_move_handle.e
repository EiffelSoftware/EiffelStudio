note
	description:
		"Handles that allow the user to control certain EV_RELATIVE_POINTs%N%
		%in an EV_FIGURE_WORLD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	default_create

create {EV_MOVE_HANDLE}
	list_make,
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Initialize actions.
		do
			initialize
			Precursor
		end

	initialize
			-- Set action sequences.
		do
			create start_actions
			create end_actions
			create move_actions
			pointer_button_press_actions.extend (agent on_start_resizing)
			pointer_motion_actions.extend (agent on_resizing)
			pointer_button_release_actions.extend (agent on_stop_resizing)
			show_agent := agent on_enter
			hide_agent := agent on_leave
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

	real_position_agent: detachable FUNCTION [ANY, TUPLE [INTEGER, INTEGER], TUPLE [INTEGER, INTEGER]]
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

	enable_always_shown
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

	disable_always_shown
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

	enable_snapping
			-- Set `is_snapping' `True'.
		do
			is_snapping := True
		ensure
			snap_enabled: is_snapping
		end

	disable_snapping
			-- Set `is_snapping' `False'.
		do
			is_snapping := False
		ensure
			snap_disabled: not is_snapping
		end

	snap_to_grid
			-- Move to the most nearby point on the grid.
		do
			if is_snapping then
				point.set_position (snapped_x (point.x), snapped_y (point.y))
			end
		end

feature -- Element change

	set_minimum_x (a_x: INTEGER)
			-- Assign `a_x' to `minimum_x'.
		do
			minimum_x := a_x
		end

	set_minimum_y (a_y: INTEGER)
			-- Assign `a_y' to `minimum_y'.
		do
			minimum_y := a_y
		end

	set_maximum_x (a_x: INTEGER)
			-- Assign `a_x' to `maximum_x'.
		do
			maximum_x := a_x
		end

	set_maximum_y (a_y: INTEGER)
			-- Assign `a_y' to `maximum_y'.
		do
			maximum_y := a_y
		end

	set_real_position_agent (an_agent: like real_position_agent)
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

	Max_integer: INTEGER = 100000
			-- Highest possible integer value.

	Min_integer: INTEGER = -100000
			-- Lowest possible integer value.

	show_agent: PROCEDURE [ANY, TUPLE]
			-- Connected to `enter_actions'.

	hide_agent: PROCEDURE [ANY, TUPLE]
			-- Connected to `leave_actions'.

	on_enter
		do
			show
		end

	on_leave
		do
			hide
		end

	rel_x, rel_y: INTEGER

	snapped_x (ax: INTEGER): INTEGER
			-- Nearest point on horizontal grid to `ax'.
		local
			px, wx: INTEGER
			l_world: like world
		do
			l_world := world
			check l_world /= Void end
			wx := l_world.point.x
			if attached point.origin as l_point_origin and then l_point_origin /= l_world.point then
				px := (l_point_origin.x_abs / l_point_origin.scale_x_abs).rounded
			end
			Result := l_world.x_to_grid (wx + px + ax) - px - wx
		end

	snapped_y (ay: INTEGER): INTEGER
			-- Nearest point on vertical grid to `ay'.
		local
			py, wy: INTEGER
			l_world: like world
		do
			l_world := world
			check l_world /= Void end
			wy := l_world.point.y
			if attached point.origin as l_point_origin and then l_point_origin /= l_world.point then
				py := (l_point_origin.y_abs / l_point_origin.scale_y_abs).rounded
			end
			Result := l_world.y_to_grid (wy + py + ay) - py - wy
		end

	on_start_resizing (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER)
			-- User pressed pointer button on `Current'.
		local
			l_origin: detachable EV_RELATIVE_POINT
		do
			if b = 1 then
				start_actions.call (Void)
				enable_capture
				l_origin := point.origin
				check l_origin /= Void end
				rel_x := (x / l_origin.scale_x_abs).rounded - point.x
				rel_y := (y / l_origin.scale_y_abs).rounded - point.y
			end
		end

	on_resizing (x, y: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER)
			-- Mouse moved over `Current'.
		local
			tx, ty: INTEGER
			scx, scy: DOUBLE
			new_x, new_y: INTEGER
			t: detachable TUPLE [INTEGER, INTEGER]
			l_world: like world
			l_point_origin: detachable EV_RELATIVE_POINT
		do
			if has_capture then
				l_world := world
				check l_world /= Void end
				l_point_origin := point.origin
				check l_point_origin /= Void end
				scx := l_point_origin.scale_x_abs
				scy := l_point_origin.scale_y_abs
				tx := (x / scx).rounded - rel_x
				ty := (y / scy).rounded - rel_y
				tx := tx.min (maximum_x).max (minimum_x)
				ty := ty.min (maximum_y).max (minimum_y)
				if attached real_position_agent as l_real_position_agent then
					l_real_position_agent.call ([tx, ty])
					t := l_real_position_agent.last_result
					check t /= Void end
					new_x := t.integer_item (1)
					new_y := t.integer_item (2)
				else
					if l_world.grid_enabled and is_snapping then
						l_world.set_grid_x (l_world.Default_grid_x)
						l_world.set_grid_y (l_world.Default_grid_y)
						new_x := snapped_x (tx)
						new_y := snapped_y (ty)
						l_world.set_grid_x ((l_world.Default_grid_x * scx).rounded)
						l_world.set_grid_y ((l_world.Default_grid_y * scy).rounded)
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

	on_stop_resizing (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER)
			-- User release pointer button from `Current'.
		do
			if has_capture then
				disable_capture
				end_actions.call (Void)
			end
		end

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




end -- class EV_MOVE_HANDLE






