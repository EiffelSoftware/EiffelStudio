note
	description:
		"Handles that allow the user to control certain EV_MODELs%N%
		%in an EV_MODEL_WORLD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "point, handle, move, resize, grab"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_MOVE_HANDLE

inherit
	EV_MODEL_GROUP
		redefine
			default_create
		end

create
	default_create

create {EV_MODEL_MOVE_HANDLE}
	list_make,
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Initialize actions.
		do
			create start_actions
			create end_actions
			create move_actions
			create rotate_actions
			create scale_x_actions
			create scale_y_actions
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
			is_moving := True
			is_scaling := False
			is_rotating := True
			move_button := 1
			scale_button := 3
			rotate_button := 2
			Precursor {EV_MODEL_GROUP}
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

	real_position_agent: detachable FUNCTION [ANY, TUPLE [INTEGER, INTEGER], TUPLE [x: INTEGER; y: INTEGER]]
			-- User defined function that translates actual coordinates to
			-- the coordinates `Current' will be displayed on.

	move_button: INTEGER
			-- Mouse button used to move.
			-- Default: 1

	scale_button: INTEGER
			-- Mouse button used to scale.
			-- Default: 3

	rotate_button: INTEGER
			-- Mouse button used to rotate.
			-- Default: 2

feature -- Status report

	is_always_shown: BOOLEAN
			-- Is `figure' always shown?
			-- (Or only when pointer over `figure'?)

	is_snapping: BOOLEAN
			-- Does `Current' snap to grid when grid is enabled?
			-- Default: True

	is_moving: BOOLEAN
			-- Does `Current' move its items?
			-- Default: True

	is_rotating: BOOLEAN
			-- Does `Current' rotate its items?
			-- Default: True

	is_scaling: BOOLEAN
			-- Does `Current' scale its items?
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
				set_x (snapped_x (x))
				set_y (snapped_y (y))
			end
		end

	enable_moving
			-- Set `is_moving' to `True'.
		do
			is_moving := True
		ensure
			moving_enabled: is_moving = True
		end

	disable_moving
			-- Set `is_moving' to `False'.
		do
			is_moving := False
		ensure
			moving_disabled: is_moving = False
		end

	enable_rotating
			-- Set `is_moving' to `True'.
		do
			is_rotating := True
		ensure
			rotating_enabled: is_rotating = True
		end

	disable_rotating
			-- Set `is_moving' to `False'.
		do
			is_rotating := False
		ensure
			rotating_disabled: is_rotating = False
		end

	enable_scaling
			-- Set `is_moving' to `True'.
		do
			is_scaling := True
		ensure
			scaling_enabled: is_scaling = True
		end

	disable_scaling
			-- Set `is_moving' to `False'.
		do
			is_scaling := False
		ensure
			scaling_disabled: is_scaling = False
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

	set_move_button (nr: INTEGER)
			-- Set `move_button' to `nr'.
		do
			move_button := nr
		ensure
			set: move_button = nr
		end

	set_scale_button (nr: INTEGER)
			-- Set `scale_button' to `nr'.
		do
			scale_button := nr
		ensure
			set: scale_button = nr
		end

	set_rotate_button (nr: INTEGER)
			-- Set `rotate_button' to `nr'.
		do
			rotate_button := nr
		ensure
			set: rotate_button = nr
		end

feature -- Actions

	start_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when drag starts.

	end_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when drag ends.

	move_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions called when user drags `Current'.

	rotate_actions: EV_DOUBLE_VALUE_CHANGE_ACTION_SEQUENCE
			-- Actions called when the user rotates `Current'

	scale_x_actions: EV_DOUBLE_VALUE_CHANGE_ACTION_SEQUENCE
			-- Actions called when the user scales `Current' to x direction.

	scale_y_actions: EV_DOUBLE_VALUE_CHANGE_ACTION_SEQUENCE
			-- Actions called when the user scales `Current' to y direction.

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

	center_x, center_y: INTEGER
			-- Position of the mouse when a button was pressed.

	delta_center_x, delta_center_y: INTEGER
			-- Difference between position of the mouse end center when a button was pressed.

	is_scale: BOOLEAN
			-- Is in scale mode?

	is_move: BOOLEAN
			-- Is in move mode?

	is_rotate: BOOLEAN
			-- Is in rotate mode?

	snapped_x (ax: INTEGER): INTEGER
			-- Nearest point on horizontal grid to `ax'.
		local
			l_world: like world
		do
			l_world := world
			check l_world /= Void end
			Result := l_world.x_to_grid (ax)
		end

	snapped_y (ay: INTEGER): INTEGER
			-- Nearest point on vertical grid to `ay'.
		local
			l_world: like world
		do
			l_world := world
			check l_world /= Void end
			Result := l_world.y_to_grid (ay)
		end

	on_start_resizing (ax, ay, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER)
			-- User pressed pointer button on `Current'.
		do
			if attached world as l_world and then l_world.capture_figure = Void then
				if (attached ev_application as l_ev_app and then not l_ev_app.ctrl_pressed) or else ev_application = Void then

					if b = move_button and is_moving then
						-- move
						enable_capture
						delta_center_x := ax - point_x
						delta_center_y := ay - point_y
						is_move := True
						is_scale := False
						is_rotate := False
						start_actions.call (Void)
					elseif b = scale_button and is_scalable and is_scaling then
						-- scale
						enable_capture
						center_x := ax
						center_y := ay
						is_move := False
						is_scale := True
						is_rotate := False
						start_actions.call (Void)
					elseif b = rotate_button and is_rotatable and is_rotating then
						-- rotate
						enable_capture
						center_x := ax
						center_y := ay
						is_move := False
						is_scale := False
						is_rotate := True
						start_actions.call (Void)
					end
				end
			end
		end

	on_resizing (ax, ay: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER)
			-- Mouse moved over `Current'.
		local
			new_x, new_y, a_delta_x, a_delta_y: INTEGER
			new_scale_x, new_scale_y: DOUBLE
			new_angle: DOUBLE
			t: TUPLE [x: INTEGER; y: INTEGER]
			l_bounding_box: like bounding_box
		do
			if has_capture then

				if is_move then

					new_x := ax - delta_center_x
					new_y := ay - delta_center_y

					new_x := new_x.min (maximum_x).max (minimum_x)
					new_y := new_y.min (maximum_y).max (minimum_y)

					if attached real_position_agent as l_real_position_agent then
						t := l_real_position_agent.item ([new_x, new_y])
						new_x := t.x
						new_y := t.y
					else
						if attached world as l_world and then l_world.grid_enabled and is_snapping then
							new_x := snapped_x (new_x)
							new_y := snapped_y (new_y)
						end
					end
					if x /= new_x or y /= new_y then
						a_delta_x := new_x - point_x
						a_delta_y := new_y - point_y
						set_point_position (new_x, new_y)
						move_actions.call ([a_delta_x, a_delta_y, 0.0, 0.0, 0.0, ax, ay])
					end
				elseif is_scale then
					-- get user scale x and y
					a_delta_x := (ax - center_x)
					a_delta_y := (ay - center_y)

					-- rotate it
					new_scale_x := cosine (-angle) * a_delta_x - sine (-angle) * a_delta_y
					new_scale_y := sine (-angle) * a_delta_x + cosine (-angle) * a_delta_y

					-- "normalize" it
					new_scale_x := (new_scale_x / 200 + 1).abs
					new_scale_y := (new_scale_y / 200 + 1).abs

					l_bounding_box := bounding_box

					if new_scale_x /= 1 and then new_scale_x > 0 and then
						l_bounding_box.left * new_scale_x > minimum_x and then
						l_bounding_box.right * new_scale_x < maximum_x
					then
						scale_x (new_scale_x)
						center_x := ax
						scale_x_actions.call ([new_scale_x])
					end
					if new_scale_y /= 1 and then new_scale_y > 0 and then
						l_bounding_box.top * new_scale_y > minimum_y and then
						l_bounding_box.bottom * new_scale_y < maximum_y
					then
						scale_y (new_scale_y)
						center_y := ay
						scale_y_actions.call ([new_scale_y])
					end

				elseif is_rotate then
					new_x := ax
					new_y := ay
					if attached world as l_world and then l_world.grid_enabled and is_snapping then
						new_x := snapped_x (ax)
						new_y := snapped_y (ay)
					end

					new_angle := line_angle (x, y, new_x, new_y) - line_angle (x, y, center_x, center_y)

					rotate (new_angle)

					center_x := new_x
					center_y := new_y

					rotate_actions.call ([new_angle])
				end
			end
		end

	on_stop_resizing (ax, ay, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER)
			-- User release pointer button from `Current'.
		do
			if has_capture then
				disable_capture
				end_actions.call (Void)
			end
			is_scale := False
			is_rotate := False
			is_move := False
		end

	ev_application: detachable EV_APPLICATION
			-- The application `Current' is part of.
		do
			Result := ev_environment.application
		end

feature {NONE} -- Implementation

	ev_environment: EV_ENVIRONMENT
			-- The application `Current' is part of.
		once
			create Result
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




end -- class EV_MODEL_MOVE_HANDLE






