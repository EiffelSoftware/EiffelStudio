note
	description: "Objects that lets user manipulate a figure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MANIPULATION_HANDLER

inherit
	MATH_CONST

	EV_MODEL_DOUBLE_MATH

create
	make

feature {NONE} -- Initialization

	make (a_figure: like figure)
			-- Create a MANIPULATION_HANDLER manipulating `a_figure'.
		require
			a_figure_not_void: a_figure /= Void
		do
			figure := a_figure
			create parent_group

			build_rotation_handle
			parent_group.extend (rotation_handle)
			build_scale_x_handle
			parent_group.extend (scale_x_handle)
			build_scale_y_handle
			parent_group.extend (scale_y_handle)
			build_scale_handle
			parent_group.extend (scale_handle)
			build_move_handle
			parent_group.extend (move_handle)
			build_center_handle
			parent_group.extend (center_handle)
			center_handle.disable_moving
			center_handle.disable_rotating
			center_handle.disable_scaling

			if figure.is_scalable then
				scale_x_handle.pointer_button_press_actions.extend (agent on_start_scale_x)
				scale_x_handle.pointer_motion_actions.extend (agent on_scale_x)
				scale_x_handle.pointer_button_release_actions.extend (agent on_end_scale_x)

				scale_y_handle.pointer_button_press_actions.extend (agent on_start_scale_y)
				scale_y_handle.pointer_motion_actions.extend (agent on_scale_y)
				scale_y_handle.pointer_button_release_actions.extend (agent on_end_scale_y)

				scale_handle.pointer_button_press_actions.extend (agent on_start_scale)
				scale_handle.pointer_motion_actions.extend (agent on_scale_x)
				scale_handle.pointer_motion_actions.extend (agent on_scale_y)
				scale_handle.pointer_button_release_actions.extend (agent on_end_scale)
			end

			if figure.is_rotatable then
				rotation_handle.pointer_button_press_actions.extend (agent on_start_rotating)
				rotation_handle.pointer_motion_actions.extend (agent on_rotating)
				rotation_handle.pointer_button_release_actions.extend (agent on_end_rotating)

				center_handle.enable_moving
				center_handle.pointer_double_press_actions.extend (agent on_recenter_center)
			end

			move_handle.pointer_button_press_actions.extend (agent on_start_move)
			move_handle.pointer_motion_actions.extend (agent on_move)
			move_handle.pointer_button_release_actions.extend (agent on_end_move)
		end

feature -- Access

	parent_group: EV_MODEL_GROUP
			-- Group for Current figure

	figure: EV_MODEL
			-- Figure `Current' manipulates.

	world: detachable EV_MODEL_WORLD
		do
			Result := parent_group.world
		end

feature {NONE} -- Implementation

	scale_y_handle: EV_MODEL_GROUP
			-- Handle to scale to y direction.

	scale_x_handle: EV_MODEL_GROUP
			-- Handle to scale to x direction.

	scale_handle: EV_MODEL_GROUP
			-- Handle to scale to x and y direction.

	rotation_handle: EV_MODEL_GROUP
			-- Handle for rotation.

	move_handle: EV_MODEL_GROUP
			-- Handle for moving.

	center_handle: EV_MODEL_MOVE_HANDLE
			-- Handle to select center for rotation.

	angle_indicator: EV_MODEL_PIE_SLICE
			-- Figure showing the rotation angle.

	default_colors: EV_STOCK_COLORS
			-- Quick access to stock colors
		once
			create Result
		end

	build_scale_y_handle
			-- Build `scale_y_handle'.
		local
			polygone: EV_MODEL_POLYGON
		do
			create scale_y_handle
			polygone := new_arrow
			polygone.rotate (-pi/2)
			polygone.set_x_y (0, -33)
			scale_y_handle.extend (polygone)
		end

	build_scale_x_handle
			-- Build `scale_x_handle'.
		local
			polygone: EV_MODEL_POLYGON
		do
			create scale_x_handle
			polygone := new_arrow
			scale_x_handle.extend (polygone)
		end

	build_scale_handle
			-- Build `scale_handle'.
		local
			polygone: EV_MODEL_POLYGON
		do
			create scale_handle
			polygone := new_arrow
			polygone.rotate (-pi/4 - 0.01)
			polygone.set_x_y (28, -28)
			polygone.set_point_count (polygone.point_count + 1)
			polygone.set_i_th_point_position (polygone.point_count, 5, -5)
			scale_handle.extend (polygone)
		end

	new_arrow: EV_MODEL_POLYGON
			-- Build a scale arrow
		do
			create Result
			if figure.is_scalable then
				Result.set_background_color (default_colors.blue)
			else
				Result.set_background_color (default_colors.gray)
			end
			Result.set_point_count (7)
			Result.set_i_th_point_position (1, 5, 5)
			Result.set_i_th_point_position (2, 40, 8)
			Result.set_i_th_point_position (3, 40, 14)
			Result.set_i_th_point_position (4, 60, 0)
			Result.set_i_th_point_position (5, 40, -14)
			Result.set_i_th_point_position (6, 40, -8)
			Result.set_i_th_point_position (7, 5, -5)
		end

	build_rotation_handle
			-- Build `rotation_handle'.
		local
			pie: EV_MODEL_PIE_SLICE
			circ: EV_MODEL_ELLIPSE
			arrow: EV_MODEL_POLYGON
			line: EV_MODEL_POLYLINE
		do
			create rotation_handle
			create pie.make_with_positions (-40, -40, 40, 40)
			pie.set_start_angle (0)
			pie.set_aperture (3.4*pi/2)
			if figure.is_rotatable then
				pie.set_background_color (default_colors.red)
			else
				pie.set_background_color (default_colors.gray)
			end
			rotation_handle.extend (pie)

			create circ.make_with_positions (-25, -25, 25, 25)
			circ.set_background_color (default_colors.white)
			rotation_handle.extend (circ)

			create angle_indicator.make_with_positions (-25, -25, 25, 25)
			if figure.is_rotatable then
				angle_indicator.set_background_color (default_colors.green)
			else
				angle_indicator.set_background_color (default_colors.gray)
			end
			angle_indicator.set_start_angle (modulo (2 * pi - figure.angle, 2 *pi))
			angle_indicator.set_aperture (0.2)
			rotation_handle.extend (angle_indicator)

			create arrow
			arrow.set_point_count (3)
			arrow.set_line_width (0)
			if figure.is_rotatable then
				arrow.set_background_color (default_colors.red)
			else
				arrow.set_background_color (default_colors.gray)
			end
			arrow.set_i_th_point_position (1, 28, 37)
			arrow.set_i_th_point_position (2, 29, 14)
			arrow.set_i_th_point_position (3, 8, 15)
			rotation_handle.extend (arrow)

			create line
			line.set_point_count (5)
			line.set_i_th_point_position (1, 24, 33)
			line.set_i_th_point_position (2, 28, 37)
			line.set_i_th_point_position (3, 29, 14)
			line.set_i_th_point_position (4, 8, 15)
			line.set_i_th_point_position (5, 13, 20)
			rotation_handle.extend (line)
		end

	build_move_handle
			-- Build `move_handle'.
		local
			move_arrow: EV_MODEL_POLYGON
		do
			create move_handle
			move_arrow := new_move_arrow
			move_arrow.set_background_color (default_colors.yellow)
			move_handle.extend (move_arrow)
		end

	new_move_arrow: EV_MODEL_POLYGON
			-- Build a move to all directions arrow.
		do
			create Result
			Result.set_point_count (24)
			Result.set_i_th_point_position (1, 5, -5)
			Result.set_i_th_point_position (2, 5, -10)
			Result.set_i_th_point_position (3, 10, -10)
			Result.set_i_th_point_position (4, 0, -20)
			Result.set_i_th_point_position (5, -10, -10)
			Result.set_i_th_point_position (6, -5, -10)
			Result.set_i_th_point_position (7, -5, -5)

			Result.set_i_th_point_position (8, -10, -5)
			Result.set_i_th_point_position (9, -10, -10)
			Result.set_i_th_point_position (10, -20, 0)
			Result.set_i_th_point_position (11, -10, 10)
			Result.set_i_th_point_position (12, -10, 5)
			Result.set_i_th_point_position (13, -5, 5)

			Result.set_i_th_point_position (14, -5, 10)
			Result.set_i_th_point_position (15, -10, 10)
			Result.set_i_th_point_position (16, 0, 20)
			Result.set_i_th_point_position (17, 10, 10)
			Result.set_i_th_point_position (18, 5, 10)
			Result.set_i_th_point_position (19, 5, 5)

			Result.set_i_th_point_position (20, 10, 5)
			Result.set_i_th_point_position (21, 10, 10)
			Result.set_i_th_point_position (22, 20, 0)
			Result.set_i_th_point_position (23, 10, -10)
			Result.set_i_th_point_position (24, 10, -5)
		end

	build_center_handle
			-- Build `center_handle'.
		local
			circl: EV_MODEL_ELLIPSE
		do
			create circl.make_with_positions (-6, -6, 7, 7)
			if figure.is_rotatable then
				circl.set_background_color (default_colors.red)
			else
				circl.set_background_color (default_colors.gray)
			end
			create center_handle
			center_handle.extend (circl)
		end

feature {NONE} -- Implementation interaction

	start_x, start_y: INTEGER
			-- Position when pointer button down.

	do_scale_x: BOOLEAN
			-- Is scale_x mode?

	do_scale_y: BOOLEAN
			-- Is scale_y mode?

	do_rotate: BOOLEAN
			-- Is rotation mode?

	do_move: BOOLEAN
			-- Is move mode?

	on_start_scale_x (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Start scaling to x.
		do
			if button = 1 and then attached world as l_world
							and then not attached l_world.capture_figure then
				start_x := ax
				start_y := ay
				do_scale_x := True
				scale_x_handle.enable_capture
			end
		end

	on_scale_x (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Scale to x.
		local
			dist: INTEGER
			new_scale_x: DOUBLE
		do
			if do_scale_x then
				dist := ax - start_x
				start_x := ax
				new_scale_x := (dist / 200 + 1).abs
				figure.scale_x_abs (new_scale_x)
			end
		end

	on_end_scale_x (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- End scale to x.
		do
			if do_scale_x then
				do_scale_x := False
				scale_x_handle.disable_capture
			end
		end

	on_start_scale_y (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Start scaling to y.
		do
			if button = 1 and then attached world as l_world
							and then not attached l_world.capture_figure then
				start_x := ax
				start_y := ay
				do_scale_y := True
				scale_y_handle.enable_capture
			end
		end

	on_scale_y (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Scale to y.
		local
			dist: INTEGER
			new_scale_y: DOUBLE
		do
			if do_scale_y then
				dist := ay - start_y
				start_y := ay
				new_scale_y := (-dist / 200 + 1).abs
				figure.scale_y_abs (new_scale_y)
			end
		end

	on_end_scale_y (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- End scale to y.
		do
			if do_scale_y then
				do_scale_y := False
				scale_y_handle.disable_capture
			end
		end

	on_start_scale (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Start scale to x and y.
		do
			if button = 1 and then attached world as l_world
							and then not attached l_world.capture_figure then
				start_x := ax
				start_y := ay
				do_scale_y := True
				do_scale_x := True
				scale_handle.enable_capture
			end
		end

	on_end_scale (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- End scale to x and y.
		do
			if do_scale_y and do_scale_x then
				do_scale_y := False
				do_scale_x := False
				scale_handle.disable_capture
			end
		end

	on_start_rotating (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Start rotation.
		do
			if button = 1 and then attached world as l_world
							and then not attached l_world.capture_figure then
				start_x := ax
				start_y := ay
				do_rotate := True
				rotation_handle.enable_capture
			end
		end

	on_rotating (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Rotate.
		local
			new_angle: DOUBLE
			cx, cy: INTEGER
		do
			if do_rotate then

				cx := center_handle.x
				cy := center_handle.y

				new_angle := line_angle (parent_group.point_x, parent_group.point_y, ax, ay) - line_angle (parent_group.point_x, parent_group.point_y, start_x, start_y)

				figure.rotate_around (new_angle, cx, cy)

				angle_indicator.set_start_angle (modulo (2 * pi - figure.angle, 2 *pi))

				start_x := ax
				start_y := ay
			end
		end

	on_end_rotating (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- End rotation.
		do
			if do_rotate then
				do_rotate := False
				rotation_handle.disable_capture
			end
		end

	on_start_move (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Start moving.
		do
			if button = 1 and then attached world as l_world
							and then not attached l_world.capture_figure
							and then attached parent_group.group as l_group then
				start_x := ax - l_group.point_x
				start_y := ay - l_group.point_y
				do_move := True
				move_handle.enable_capture
			end
		end

	on_move (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Move.
		local
			nx, ny: INTEGER
		do
			if do_move then
				if attached world as l_world and then attached parent_group.group as l_group then
					nx := ax - start_x
					ny := ay - start_y
					if l_world.grid_enabled then
						nx := snapped_x (nx)
						ny := snapped_y (ny)
					end
					l_group.set_point_position (nx, ny)
				end
			end
		end

	on_end_move (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- End moving.
		do
			if do_move then
				do_move := False
				move_handle.disable_capture
			end
		end

	snapped_x (ax: INTEGER): INTEGER
			-- Nearest point on horizontal grid to `ax'.
		require
			world_attached: world /= Void
		local
			l_world: like world
		do
			l_world := world
			check l_world /= Void end
			if ax \\ l_world.grid_x < l_world.grid_x // 2 then
				Result := ax - ax \\ l_world.grid_x
			else
				Result := ax - ax \\ l_world.grid_x + l_world.grid_x
			end
		end

	snapped_y (ay: INTEGER): INTEGER
			-- Nearest point on vertical grid to `ay'.
		require
			world_attached: world /= Void
		local
			l_world: like world
		do
			l_world := world
			check l_world /= Void end
			if ay \\ l_world.grid_y < l_world.grid_y // 2 then
				Result := ay - ay \\ l_world.grid_y
			else
				Result := ay - ay \\ l_world.grid_y + l_world.grid_y
			end
		end

	on_recenter_center (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Set `center_handle' to center of `figure'.
		do
			center_handle.set_x_y (parent_group.point_x, parent_group.point_y)
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


end -- class MANIPULATION_HANDLER
