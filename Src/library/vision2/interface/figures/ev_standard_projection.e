indexing
	description: "Standard projection of a figure world onto a drawable device."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STANDARD_PROJECTION

inherit
	EV_PROJECTION
		redefine
			make
		end

	SINGLE_MATH

create
	make

feature {NONE} -- Initialization

	make (a_world: EV_FIGURE_WORLD; a_device: EV_DRAWING_AREA) is
			-- Create projection with `a_world' and `a_device'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor (a_world, a_device)

			--| FIXME This is to comply with the old event system.
			--| Change this as soon as the new system is introduced.

			create cmd.make (~on_device_button_press)
			a_device.add_button_press_command (1, cmd, Void)
			a_device.add_button_press_command (2, cmd, Void)
			a_device.add_button_press_command (3, cmd, Void)
			create cmd.make (~on_device_button_release)
			a_device.add_button_release_command (1, cmd, Void)
			a_device.add_button_release_command (2, cmd, Void)
			a_device.add_button_release_command (3, cmd, Void)
			create cmd.make (~on_device_pointer_leave)
			a_device.add_leave_notify_command (cmd, Void)
			create cmd.make (~on_device_pointer_motion)
			a_device.add_motion_notify_command (cmd, Void)

			--| It should look like this:

		--|	a_device.pointer_motion_actions.extend (~mouse_move)
		--|	a_device.pointer_button_press_actions.extend (~button_press)
		--|	a_device.pointer_button_release_actions.extend (~button_release)
		--|	a_device.pointer_leave_actions (~pointer_leave)
		--|	a_device.proximity_in_actions.extend (~proximity_in)
		--|	a_device.proximity_out_actions.extend (~proximity_out)
		end

feature -- Basic operations

	project is
			-- Make a standard projection of the world on the device.
		do
			clear_device
			world.invalidate_absolute_position
			-- now the position of the mouse is the same,
			-- but the world has changed. Do leave/enter commands
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
			device.set_foreground_color (create {EV_COLOR}.make_rgb (255, 0, 0))
			device.draw_point (create {EV_COORDINATES}.set (x, y))
		end

feature {NONE} -- Events

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

	button_press (x, y, button: INTEGER; x_tilt, y_tilt, pressure: REAL) is
			-- Pointer button down happened.
		local
			event_fig: EV_FIGURE
		do
			from
				event_fig := figure_on_position (world, x, y)
			until
				event_fig = Void
			loop
				event_fig.pointer_button_press_actions.call ([x, y, button, x_tilt, y_tilt, pressure])
				event_fig := event_fig.group
			end
		end

	button_release (x, y, button: INTEGER; x_tilt, y_tilt, pressure: REAL) is
			-- Pointer button up happened.
		local
			event_fig: EV_FIGURE
		do
			from
				event_fig := figure_on_position (world, x, y)
			until
				event_fig = Void
			loop
				event_fig.pointer_button_release_actions.call ([x, y, button, x_tilt, y_tilt, pressure])
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

	mouse_move (x, y: INTEGER; x_tilt, y_tilt, pressure: REAL) is
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
				event_fig.pointer_motion_actions.call ([x, y, x_tilt, y_tilt, pressure])
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
			-- Pointer put down on the pad.
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

	--| FIXME These are event handlers from the old event mechanism.
	--| All of the figures work with the new event system. (action sequence)
	--| If new system is introduced, these functions can be removed.

	on_device_button_press (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Button down happened on the device.
		local
			button_data: EV_BUTTON_EVENT_DATA
		do
			button_data ?= data
			check
				button_data /= Void
			end
			button_press (button_data.x, button_data.y, button_data.button, 0.5, 0.5, 1.0)
		end

	on_device_button_release (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Button up happened on the device.
		local
			button_data: EV_BUTTON_EVENT_DATA
		do
			button_data ?= data
			check
				button_data /= Void
			end
			button_release (button_data.x, button_data.y, button_data.button, 0.5, 0.5, 1.0)
		end

	on_device_pointer_leave (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Mouse left the device. Send leave to `current_figure'.
		do
			pointer_leave
		end

	on_device_pointer_motion (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Mouse moved on drawing device.
		local
			motion_data: EV_MOTION_EVENT_DATA
			event_fig: EV_FIGURE
			x, y: INTEGER
		do
			motion_data ?= data
			check
				motion_data /= Void
			end
			mouse_move (motion_data.x, motion_data.y, 0.5, 0.5, 1.0)
		end
	
feature {NONE} -- Implementation

	clear_device is
			-- Do smart erasing of the canvas.
		do
			device.clear --| FIXME Smart!!!
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
			line: EV_FIGURE_LINE
			dot: EV_FIGURE_DOT
			ellipse: EV_FIGURE_ELLIPSE
			rectangle: EV_FIGURE_RECTANGLE
			arc: EV_FIGURE_ARC
			polyline: EV_FIGURE_POLYLINE
			text: EV_FIGURE_TEXT
			arrow: EV_FIGURE_ARROW
		do
			line ?= figure
			if line /= Void then
				device.draw_figure_line (line)
			else
				dot ?= figure
				if dot /= Void then
					device.draw_figure_dot (dot)
				else
					ellipse ?= figure
					if ellipse /= Void then
						device.draw_figure_ellipse (ellipse)
					else
						rectangle ?= figure
						if rectangle /= Void then
							device.draw_figure_rectangle (rectangle)
						else
							arc ?= figure
							if arc /= Void then
								device.draw_figure_arc (arc)
							else
								polyline ?= figure
								if polyline /= Void then
									device.draw_figure_polyline (polyline)
								else
									text ?= figure
									if text /= Void then
										device.draw_figure_text (text)
									else
										arrow ?= figure
										if arrow /= Void then
											device.draw_figure_arrow (arrow)
										end
									end
								end
							end
						end
					end
				end
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
				device.set_foreground_color (create {EV_COLOR}.make_rgb (0, 0, 255))
				device.draw_segment (
					create {EV_COORDINATES}.set (point.x_abs, point.y_abs),
					create {EV_COORDINATES}.set (point.origin.x_abs, point.origin.y_abs))
			end
			device.set_foreground_color (create {EV_COLOR}.make_rgb (0, 255, 0))
			device.draw_segment ( -- Y-axle.
				create {EV_COORDINATES}.set (point.x_abs, point.y_abs),
				create {EV_COORDINATES}.set (
					point.x_abs - (sine (point.angle_abs) * axle_length * point.scale_y_abs).rounded,
					point.y_abs + (cosine (point.angle_abs) * axle_length * point.scale_y_abs).rounded))
			device.draw_segment ( -- X-axle.
				create {EV_COORDINATES}.set (point.x_abs, point.y_abs),
				create {EV_COORDINATES}.set (
					point.x_abs + (cosine (point.angle_abs) * axle_length * point.scale_x_abs).rounded,
					point.y_abs + (sine (point.angle_abs) * axle_length * point.scale_x_abs).rounded))
			from
				point.notify_list.start
			until
				point.notify_list.after
			loop
				project_rel_point (point.notify_list.item)
				point.notify_list.forth
			end
		end

end -- class EV_STANDARD_PROJECTION
