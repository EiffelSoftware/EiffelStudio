indexing
	description:
		"Eiffel Vision standard projection. %N%
		%Projectors that display figure worlds on a EV_DRAWING_AREA. %N%
		%From the moment you create the projector, appropriate events %N%
		%will be sent to the figures in the world. The actions supported %N%
		%are: pointer_motion, pointer_button_press/release, pointer_leave/ %N%
		%enter, proximity_in/out. %N%
		%The projector ignores any figure objects it does not know %N%
		%If you create new figures, modify the projector so that it now %N%
		%displays your figures."
	keywords: "figures, project, pointer, drawing, points"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STANDARD_PROJECTION

inherit
	EV_PROJECTION
		rename
			make as projection_make
		end

	SINGLE_MATH

create
	make

feature {NONE} -- Initialization

	make (a_world: EV_FIGURE_WORLD; a_device: EV_DRAWABLE) is
			-- Create projection with `a_world' and `a_device'.
		require
			a_world_not_void: a_world /= Void
			a_device_not_void: a_device /= Void
		local
			prim: EV_WIDGET
		do
			projection_make (a_world)
			create device.make_with_drawable (a_device)
			prim ?= a_device
			if prim /= Void then
				--| If the drawable is a widget, events can
				--| be connected to them.
				prim.pointer_motion_actions.extend (~mouse_move)
				prim.pointer_button_press_actions.extend (~button_press)
				prim.pointer_button_release_actions.extend (~button_release)
				prim.pointer_leave_actions.extend (~pointer_leave)
				prim.proximity_in_actions.extend (~proximity_in)
				prim.proximity_out_actions.extend (~proximity_out)
			end
		end

feature -- Access

	device: EV_FIGURE_DRAWER
			-- The device to draw to.

feature -- Basic operations

	project is
			-- Make a standard projection of the world on the device.
		do
			clear_device
			world.invalidate_absolute_position
			-- Now the position of the mouse is the same,
			-- but the world has changed. Do leave/enter commands!
			project_figure_group (world)
			if has_mouse then
				change_current (figure_on_position (world, last_pointer_x, last_pointer_y))
			end
			if world.points_visible then
				project_rel_point (world.point)
			end
		end

	draw_pixel (x, y: INTEGER) is
			-- Put a pixel on (`x', `y').
			--| Used to test on_mouse_over event.
		do
			device.drawable.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
			device.drawable.draw_point (x, y)
		end

feature {NONE} -- Event implementation

	current_figure: EV_FIGURE
			-- Figure the mouse is currently on.
			--| To generate leave and enter actions.

	last_pointer_x, last_pointer_y: INTEGER
			-- The last mouse coordinates.
			--| Used when the world changes using `project'.

	has_mouse: BOOLEAN
			-- Does the canvas have the mouse on it?

	figure_on_position (group: EV_FIGURE_GROUP; x, y: INTEGER): EV_FIGURE is
			-- Get the figure the mouse-cursor is on.
		local
			grp: EV_FIGURE_GROUP
		do
			from
				group.start
			until
				Result /= Void or else group.after
			loop
				grp ?= group.item
				if grp /= Void then
					Result := figure_on_position (grp, x, y)
				elseif group.item.position_on_figure (x, y) then
					Result := group.item
				end
				group.forth
			end
		end

	button_press (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Pointer button down happened.
		local
			event_fig: EV_FIGURE
		do
			from
				event_fig := figure_on_position (world, x, y)
			until
				event_fig = Void
			loop
				event_fig.pointer_button_press_actions.call (
					[x, y, button, x_tilt, y_tilt, pressure,
					screen_x, screen_y])
				event_fig := event_fig.group
			end
		end

	button_release (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Pointer button up happened.
		local
			event_fig: EV_FIGURE
		do
			from
				event_fig := figure_on_position (world, x, y)
			until
				event_fig = Void
			loop
				event_fig.pointer_button_release_actions.call (
					[x, y, button, x_tilt, y_tilt, pressure,
					screen_x, screen_y])
				event_fig := event_fig.group
			end
		end

	pointer_leave is
			-- Pointer left the canvas.
		do
			has_mouse := False
			change_current (Void)
		end

	change_current (new_current_figure: EV_FIGURE) is
			-- Change the current to `new_focused_figure'.
			--| Generate leave and/or enter events accordingly.
		do
			if current_figure /= new_current_figure then
				if current_figure /= Void then
					current_figure.pointer_leave_actions.call ([])
				end
				current_figure := new_current_figure
				if current_figure /= Void then
					current_figure.pointer_enter_actions.call ([])
				end
			end
		ensure
			current_figure_assigned: current_figure = new_current_figure
		end

	mouse_move (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Fire events that belong to mouse movement.
			--| i.e. leave, enter, motion.
		local
			event_fig: EV_FIGURE
		do
			has_mouse := True
			last_pointer_x := x
			last_pointer_y := y
			from
				event_fig := figure_on_position (world, x, y)
				change_current (event_fig)
			until
				event_fig = Void
			loop
				event_fig.pointer_motion_actions.call (
					[x, y, x_tilt, y_tilt, pressure,
					screen_x, screen_y])
				event_fig := event_fig.group
			end
		end

	proximity_in (x, y: INTEGER) is
			-- Pointer put down on the pad.
		local
			event_fig: EV_FIGURE
		do
			from
				event_fig := figure_on_position (world, x, y)
				change_current (event_fig)
			until
				event_fig = Void
			loop
				event_fig.proximity_in_actions.call ([x, y])
				event_fig := event_fig.group
			end
		end

	proximity_out (x, y: INTEGER) is
			-- Pointer lifted from the pad.
		local
			event_fig: EV_FIGURE
		do
			from
				event_fig := figure_on_position (world, x, y)
				change_current (Void)
			until
				event_fig = Void
			loop
				event_fig.proximity_out_actions.call ([x, y])
				event_fig := event_fig.group
			end
		end
	
feature {NONE} -- Implementation

	clear_device is
			-- Do smart erasing of the canvas.
		do
			device.drawable.set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 0))
			device.drawable.clear
		end

	project_figure_group (group: EV_FIGURE_GROUP) is
			-- Draw all figures in group to device.
		local
			group_fig: EV_FIGURE_GROUP
			atomic_fig: EV_ATOMIC_FIGURE
		do
			from
				group.start
			until
				group.after
			loop
				group_fig ?= group.item
				if group_fig /= Void then
					project_figure_group (group_fig)
				else
					atomic_fig ?= group.item
					if atomic_fig /= Void then
						project_figure (atomic_fig)
					end
				end
				group.forth
			end
		end

	project_figure (figure: EV_ATOMIC_FIGURE) is
			-- Determine the figure and apply it to the device.
		local
			arc: EV_FIGURE_ARC
			dot: EV_FIGURE_DOT
			ellipse: EV_FIGURE_ELLIPSE
			equilateral: EV_FIGURE_EQUILATERAL
			line: EV_FIGURE_LINE
			picture: EV_FIGURE_PICTURE
			pie_slice: EV_FIGURE_PIE_SLICE
			polygon: EV_FIGURE_POLYGON
			polyline: EV_FIGURE_POLYLINE
			rectangle: EV_FIGURE_RECTANGLE
			text: EV_FIGURE_TEXT
			triangle: EV_FIGURE_TRIANGLE
		do
			arc ?= figure
			if arc /= Void then
				device.draw_figure_arc (arc)
			end

			dot ?= figure
			if dot /= Void then
				device.draw_figure_dot (dot)
			end

			ellipse ?= figure
			if ellipse /= Void then
				device.draw_figure_ellipse (ellipse)
			end

			equilateral ?= figure
			if equilateral /= Void then
				device.draw_figure_equilateral (equilateral)
			end

			line ?= figure
			if line /= Void then
				device.draw_figure_line (line)
			end

			picture ?= figure
			if picture /= Void then
				device.draw_figure_picture (picture)
			end

			pie_slice ?= figure
			if pie_slice /= Void then
				device.draw_figure_pie_slice (pie_slice)
			end

			polygon ?= figure
			if polygon /= Void then
				device.draw_figure_polygon (polygon)
			end

			polyline ?= figure
			if polyline /= Void then
				device.draw_figure_polyline (polyline)
			end

			rectangle ?= figure
			if rectangle /= Void then
				device.draw_figure_rectangle (rectangle)
			end

			text ?= figure
			if text /= Void then
				device.draw_figure_text (text)
			end

			triangle ?= figure
			if triangle /= Void then
				device.draw_figure_triangle (triangle)
			end
		end

	axle_length: INTEGER is 15
			-- Length of the x and y axles when points are displayed.

	project_rel_point (point: EV_RELATIVE_POINT) is
			-- Draw a representation of a point on the canvas.
		local
			dx, dy: INTEGER
		do
			dx := (sine (point.angle_abs) * axle_length).rounded
			dy := (cosine (point.angle_abs) * axle_length).rounded
			if point.origin /= Void then
				device.drawable.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 0, 1))
				device.drawable.draw_segment (point.x_abs, point.y_abs, point.origin.x_abs, point.origin.y_abs)
			end
			device.drawable.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 1, 0))
			device.drawable.draw_segment (point.x_abs, point.y_abs,
					point.x_abs - (sine (point.angle_abs) * axle_length * point.scale_y_abs).rounded,
					point.y_abs + (cosine (point.angle_abs) * axle_length * point.scale_y_abs).rounded)
			device.drawable.draw_segment (point.x_abs, point.y_abs,
					point.x_abs + (cosine (point.angle_abs) * axle_length * point.scale_x_abs).rounded,
					point.y_abs + (sine (point.angle_abs) * axle_length * point.scale_x_abs).rounded)
			from
				point.notify_list.start
			until
				point.notify_list.after
			loop
				project_rel_point (point.notify_list.item)
				point.notify_list.forth
			end
		end

feature

	ray_trace (fig: EV_FIGURE) is
			-- Test the event mask/calculation.
		local
			xc, yc: INTEGER
		do
			from
				xc := 0
			until
				xc > 200
			loop
				from
					yc := 0
				until
					yc > 200
				loop
					if fig.position_on_figure (xc, yc) then
						device.drawable.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
					else
						device.drawable.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 1, 0))
					end
					device.drawable.draw_point (xc, yc)
					yc := yc + 1
				end
				xc := xc + 1
			end
		end

invariant
	device_not_void: device /= Void

end -- class EV_STANDARD_PROJECTION
