indexing
	description: "This is the usage pattern of the figure cluster."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	FIGURE_TEST

inherit
	EV_APPLICATION

	EV_FONT_CONSTANTS
		undefine
			default_create
		end

	EV_DRAWABLE_CONSTANTS
		undefine
			default_create
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			pos: EV_RELATIVE_POINT
			pixmap: EV_PIXMAP
			f: RAW_FILE
		do
			-- First, create the world.
			-- Like every figure-group, has origin (0, 0) by default.
			create my_world

			-- While you are debugging the world set points to visible.
			-- Slow but clarifying.
			--my_world.set_points_visible (True)

			-- This world has one position that is moved by the mouse cursor and
			-- of which the scaling and rotation change as well, every time it moves.
			-- The point starts on (50, 50)
			create controlled_position.make_with_origin_and_position (my_world.point, 50, 50)

			-- We want to create a line that moves with one point relative to the
			-- controlled position and the other one moves over a path, defined by a positioning agent.
			create line
			line.point_a.set_origin (controlled_position)
			line.point_b.set_origin (my_world.point)
			my_world.extend (line) -- The line is now a part of the world.

			-- Some other properties of line are now set:
			line.set_line_width (7)
			line.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 1, 0))

			-- Now we create an ellipse with one fixed point (100,5) and the other one exactly
			-- on the controlled position. We do not use the controlled position as
			-- this point. This is to make it easier to change something later on.
			create ellipse
			create pos.make_with_origin_and_position (my_world.point, 100, 5)
			ellipse.set_point_a (pos)
			create pos.make_with_origin_and_position (controlled_position, 0, 0)
			ellipse.set_point_b (pos)
			ellipse.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
			my_world.extend (ellipse)

			-- We want a rectangle as well. This rectangle, unlike the ellipse, gets point_a
			-- relative to the controlled position. This means that the rectangle is
			-- resized and rotated by the values in controlled_position which are propagated
			-- through depending points.
			create rectangle
			create pos.make_with_origin_and_position (controlled_position, 20, 30)
			rectangle.set_point_a (pos)
			create pos.make_with_origin_and_position (rectangle.point_a, 10, 50)
			rectangle.set_point_b (pos)
			my_world.extend (rectangle)

			create picture
			create pixmap
			create f.make_open_read ("c:\eiffel46\bench\bitmaps\bmp\isepower.bmp")
			pixmap.set_with_file (f)
			picture.set_pixmap (pixmap)
			picture.point.set_origin (my_world.point)
			picture.point.set_position (200, 200)
			my_world.extend (picture)

			create text
			text.set_text ("EV_FIGURE_TEXT")
			text.font.set_height (40)
			text.font.set_family (Ev_font_family_roman)
			text.point.set_origin (my_world.point)
			text.point.set_position (20, 250)
			my_world.extend (text)

			-- This is where it all comes together:
			create my_device
			first_window.extend (my_device)
			my_device.set_minimum_size (300, 300)

			my_device.draw_pixmap (0, 0, pixmap)

			my_device.expose_actions.extend (~on_repaint)
			my_device.pointer_motion_actions.extend (~on_mouse_move)
			my_device.pointer_button_press_actions.extend (~on_click)

			-- Bind the world and the device and you're all set.
			create projector.make (my_world, my_device)
			projector.device.draw_figure_line (line)
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Figure world test")
			Result.set_size (300, 300)
		end

	on_click (x, y, z: INTEGER; s,w,e:DOUBLE; sx,sy:INTEGER) is
		do
		end

	on_repaint (x, y, w, h: INTEGER) is
			-- Do the projection
		do
			projector.project
		end

	on_mouse_move (x, y: INTEGER; s,w,e:DOUBLE; sx,sy:INTEGER) is
			-- Mouse moved on world. Do something funny.
		do
			controlled_position.set_x (x)
			controlled_position.set_y (y)
		--	controlled_position.set_angle (controlled_position.angle + 0.1)
		--	controlled_position.set_scale (controlled_position.scale_x * 1.02)
		--	if controlled_position.scale_x > 3 then
		--		controlled_position.set_scale (0.5)
		--	end
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
	my_device: EV_DRAWING_AREA

	dot: EV_FIGURE_DOT
	ellipse: EV_FIGURE_ELLIPSE
	rectangle: EV_FIGURE_RECTANGLE
	line: EV_FIGURE_LINE

	arc: EV_FIGURE_ARC
	text: EV_FIGURE_TEXT
	polyline: EV_FIGURE_POLYLINE
	polygon: EV_FIGURE_POLYGON
	eql: EV_FIGURE_EQUILATERAL
	triangle: EV_FIGURE_TRIANGLE
	picture: EV_FIGURE_PICTURE

	controlled_position: EV_RELATIVE_POINT
			-- By moving this position, we move the rectangle
			-- and resize the ellipse.

	projector: EV_STANDARD_PROJECTION
			-- The "link" between the world and the drawing area.

end -- class FIGURE_TEST

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

