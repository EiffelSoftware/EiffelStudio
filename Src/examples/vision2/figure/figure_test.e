indexing
	description: "This is the usage pattern of the figure cluster."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	FIGURE_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		do
			make_world
			io.put_string ("prepared!%N")
			projector.project
		end

	make_world is
			-- Initialize world.
		local
			my_device: EV_DRAWING_AREA
			pos: EV_RELATIVE_POINT
			cmd: EV_ROUTINE_COMMAND
		do
			-- First, create the world.
			-- Like every figure-group, has origin (0, 0) by default.
			create my_world

			-- While you are debugging the world set points to visible.
			-- This will make it a lot clearer why the world behaves like it does.
			--my_world.set_points_visible (True)

			-- This world has one position that is moved by the mouse cursor and
			-- of which the scaling and rotation change as well, every time it moves.
			-- To create a point, it is recommended to use get_relative_point.
			-- The point starts on (50, 50)
			controlled_position := my_world.get_relative_point (50, 50)

			-- We want to create a line that moves with one point relative to the
			-- controlled position and the other one moves over a path, defined by a positioning agent.
			create line
			line.set_point_a (controlled_position.get_relative_point (30, 0))
			create pos -- Note that this is the only pos that is created here.
			pos.set_positioner (~line_positioner)
			line.set_point_b (pos)
			my_world.extend (line) -- The line is added to the world.

			-- Some other properties of line will be set:
			line.set_line_width (7)
			line.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 1, 0))
			line.pointer_enter_actions.extend (~display_text ("Entering line...%N"))
			line.pointer_leave_actions.extend (~display_text ("Leaving line...%N"))
			--line.pointer_button_release_actions.extend (~display_text (?,?,?,?,?,?,"Button release on line...%N"))

			-- Now we create an ellipse with one fixed point (100,5) and the other one exactly
			-- on the controlled position. We do not use the controlled position as
			-- this point. This is to make it easier to change something later on.
			create ellipse
			ellipse.set_point_a (my_world.get_relative_point (100,5))
			ellipse.set_point_b (controlled_position.get_relative_point (0, 0))
			my_world.extend (ellipse)
			ellipse.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
			--ellipse.set_fill_color (create {EV_COLOR}.make_with_rgb (1, 1, 0))
			--ellipse.pointer_enter_actions.extend (~display_text ("Entering ellipse...%N"))
			--ellipse.pointer_leave_actions.extend (~display_text ("Leaving ellipse...%N"))
			--ellipse.pointer_button_release.extend (~diplay_text ("Button release on ellipse...%N")

			-- We want a rectangle as well. This rectangle, unlike the ellipse, gets point a
			-- relative to the controlled position. This means that the rectangle is
			-- resized and rotated by the values in controlled_position which are propagated
			-- through depending points.
			create rectangle
			rectangle.set_point_a (controlled_position.get_relative_point (20, 30))
			rectangle.set_point_b (rectangle.point_a.get_relative_point (10, 50))
			my_world.extend (rectangle)
			--rectangle.pointer_enter_actions.extend (~display_text ("Entering rectangle...%N"))
			--rectangle.pointer_leave_actions.extend (~display_text ("Leaving rectangle...%N"))
			--rectangle.pointer_button_release.extend (~diplay_text ("Button release on rectangle...%N")

			-- Creating some other figures as well:
		--	create polyline
		--	polyline.add_point (my_world.get_relative_point (10, 100))
		--	polyline.add_point (my_world.get_relative_point (20, 110))
		--	polyline.add_point (controlled_position.get_relative_point (-30, -30))
		--	polyline.add_point (my_world.get_relative_point (40, 100))
		--	polyline.add_point (my_world.get_relative_point (50, 120))
		--	polyline.set_closed (True)
		--	my_world.extend (polyline)

		--	create polygon
		--	polygon.set_fill_color (create {EV_COLOR}.make_with_rgb (0.1, 0.1, 0.1))
		--	polygon.add_point (controlled_position.get_relative_point (0, 0))
		--	polygon.add_point (my_world.get_relative_point (150, 110))
		--	polygon.add_point (my_world.get_relative_point (150, 160))
		--	polygon.add_point (my_world.get_relative_point (100, 170))
		--	polygon.add_point (my_world.get_relative_point (50, 90))
		--	my_world.extend (polygon)

			--create text.make_with_point_and_text (my_world.get_relative_point (35, 140), "Seems to work")
			--my_world.extend (text)

		--	create arrow
		--	arrow.source.set_x (200)
		--	arrow.target.set_origin (polyline.get_point_by_index (5).get_relative_point (0, 0))
		--	my_world.extend (arrow)

			--create arc.make_with_points (
			--	my_world.get_relative_point (150, 150),
			--	controlled_position.get_relative_point (30, -30),
			--	my_world.get_relative_point (200, 150))
			--my_world.extend (arc)
			--arc.set_line_width (3)

		--	create eql
		--	eql.set_center_point (my_world.get_relative_point (250, 250))
		--	eql.set_corner_point (controlled_position.get_relative_point (0, 0))
		--	my_world.extend (eql)

			create my_device
			first_window.extend (my_device)
			my_device.set_minimum_size (300, 300)
			--my_device.set_fill_color (create {EV_COLOR}.make_with_rgb (0,0,0))
			--my_device.set_line_color (create {EV_COLOR}.make_with_rgb (1,1,1))
		--	my_device.set_background_color (create {EV_COLOR}.make_with_rgb (0,0,0))
		--	my_device.set_foreground_color (create {EV_COLOR}.make_with_rgb (1,1,1))

			my_device.expose_actions.extend (~on_repaint)

			my_device.pointer_motion_actions.extend (~on_mouse_move)

			my_device.pointer_button_press_actions.extend (~on_click)

			create projector.make (my_world, my_device)
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Figure world test")
			Result.set_size (300, 300)
			Result.show
		end

	on_click (x, y, z: INTEGER; s,w,e:DOUBLE) is
			-- Test something.
		do
			projector.ray_trace (rectangle)
		end

	on_repaint (x, y, w, h: INTEGER) is
			-- Do the projection
		do
			projector.project
		end

	on_mouse_move (x, y: INTEGER; s,w,e:DOUBLE) is
			-- Mouse moved on world. Do something funny.
		do
			controlled_position.set_x (x)
			controlled_position.set_y (y)
			controlled_position.set_angle (controlled_position.angle + 0.1)
			controlled_position.set_scale (controlled_position.scale_x * 1.02)
			if controlled_position.scale_x > 3 then
				controlled_position.set_scale (0.5)
			end
			projector.project
		end

	display_text (str: STRING) is
			-- Write `str' to standard output. Used for event testing.
		do
			io.put_string (str)
		end

	line_x_pos: INTEGER

	line_positioner (pos: EV_RELATIVE_POINT) is
			-- Position one point of the line.
		do
			pos.set_x_abs (line_x_pos + 10)
			pos.set_y_abs (10)
			line_x_pos := line_x_pos + 1
			if line_x_pos > 100 then
				line_x_pos := 0
			end
		end

feature -- Access

	my_world: EV_FIGURE_WORLD

	ellipse: EV_FIGURE_ELLIPSE
	rectangle: EV_FIGURE_RECTANGLE
	line: EV_FIGURE_LINE

	arc: EV_FIGURE_ARC
	text: EV_FIGURE_TEXT
	polyline: EV_FIGURE_POLYLINE
	arrow: EV_FIGURE_ARROW
	polygon: EV_FIGURE_POLYGON
	eql: EV_FIGURE_EQUILATERAL

	controlled_position: EV_RELATIVE_POINT
			-- By moving this position, we move the rectangle
			-- and resize the ellipse.

	projector: EV_STANDARD_PROJECTION
			-- The "link" between the world and the drawing area.

end -- class FIGURE_TEST
