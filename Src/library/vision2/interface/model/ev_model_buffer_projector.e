indexing
	description: "Projectors for widgets using limited-sized buffer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_BUFFER_PROJECTOR

inherit
	EV_MODEL_WIDGET_PROJECTOR
		export
			{NONE} set_drawable
		redefine
			project_rectangle,
			buffer_used,
			change_area_position,
			update_rectangle,
			full_project,
			offset_x,
			offset_y
		end

	EV_MODEL_BUFFER_MANAGER
		rename
			drawable as drawable_in_the_cell
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make_with_buffer

feature {NONE} -- Initialization

	make_with_buffer (
		a_world: like world;
		a_drawing_area: EV_DRAWING_AREA) is
			-- Create with `a_world' and `a_drawing_area'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
		local
			a_buffer: EV_PIXMAP;
		do
			create a_buffer.make_with_size (a_drawing_area.width.max (1) * buffer_scale_factor, a_drawing_area.height.max (1) * buffer_scale_factor)
			create drawable_cell.put (a_buffer)
			make_with_drawable_widget_and_buffer (
				a_world,
				a_drawing_area,
				a_buffer,
				a_drawing_area)
			a_drawing_area.expose_actions.extend (agent on_paint)
			a_drawing_area.resize_actions.extend (agent resize_buffer)
			create drawable_position
		end

feature -- Access

	buffer_scale_factor: INTEGER is 2
			-- The buffer is `buffer_scale_factor' times biger than the window.

	offset_x: INTEGER is
			-- Everyting is drawen offset_x pixels to the right.
		do
			Result := -drawable_position.x
		end

	offset_y: INTEGER is
			-- Everyting is drawen offset_y pixels to bottom.
		do
			Result := -drawable_position.y
		end

	world_as_pixmap (a_border: INTEGER): EV_PIXMAP is
			-- Image of the `world' with `a_border'.
		require
			a_border_positive: a_border >= 0
		local
			rectangle: EV_RECTANGLE
			old_drawable: like drawable
			old_drawable_position: EV_COORDINATE
			u_x, u_y: INTEGER
		do
			is_world_too_large := False
			old_drawable := drawable
			old_drawable_position := drawable_position
			rectangle := world.bounding_box
			create drawable_position.make (rectangle.left - a_border, rectangle.top - a_border)

			drawable := create {EV_PIXMAP}.make_with_size (rectangle.width + 2 * a_border, rectangle.height + 2 * a_border)

			u_x := rectangle.x
			u_y := rectangle.y
			drawable.set_background_color (world.background_color)
			drawable.clear_rectangle (u_x + offset_x, u_y + offset_y, rectangle.width, rectangle.height)
			if world.is_show_requested then
				project_figure_group_full (world)
			end
			world.validate

			Result ?= drawable
			set_drawable_position (old_drawable_position)
			drawable := old_drawable
			full_project
		ensure
			Result_not_void: Result /= Void
		rescue
			is_world_too_large := True
			set_drawable_position (old_drawable_position)
			drawable := old_drawable
			full_project
		end

	is_world_too_large: BOOLEAN

feature -- Element change

	change_area_position (a_x, a_y: INTEGER) is
			-- `area' has moved to (`a_x', `a_y') of `drawable'.
		do
			area_x := a_x
			area_y := a_y
			if not buffer_covers_area then
				move_buffer
			elseif area_centered then
				area_centered := False
				ev_application.idle_actions.extend (recenter_agent)
			end
			update
		end

feature -- Status report

	buffer_used: BOOLEAN is True

feature {EV_MODEL_WORLD_CELL} -- Element change

	simulate_mouse_move (ax, ay: INTEGER) is
			-- Let `Current' behave as if pointer was moved to `ax', `ay'
		do
			is_projecting := True
			mouse_move (ax, ay, 0, 0, 0, 0, 0)
		end

feature -- Display updates

	full_project is
			-- Project entire area.
		local
			rectangle: EV_RECTANGLE
		do
			create rectangle.make (drawable_position.x, drawable_position.y, drawable.width, drawable.height)
			project_rectangle (rectangle)
		end

	project_rectangle (u: EV_RECTANGLE) is
			-- Project area under `u'
		local
			pixmap: EV_PIXMAP
			u_x, u_y: INTEGER
		do
			u_x := u.x
			u_y := u.y
			drawable.set_background_color (world.background_color)
			drawable.clear_rectangle (u_x - drawable_position.x, u_y - drawable_position.y, u.width, u.height)

			if world.grid_visible then
				draw_grid
			end

			if world.is_show_requested then
				project_figure_group (world, u)
			end
			if has_mouse then
				change_current (figure_on_position (world, last_pointer_x,
				last_pointer_y))
			end
			if world.points_visible then
				draw_points (world)
			end

			world.validate

			pixmap ?= drawable
			if pixmap /= Void then
				u.set_x (u_x - drawable_position.x)
				u.set_y (u_y - drawable_position.y)
				area.draw_sub_pixmap (
					u_x - area_x,
					u_y - area_y,
					pixmap,
					u
				)
			end
		end

	update_rectangle (u: EV_RECTANGLE; a_x, a_y: INTEGER) is
			-- Flush `u' on `area' at (`a_x', `a_y').
		local
			pixmap: EV_PIXMAP
		do
			if world.is_show_requested then
				pixmap ?= drawable
				if pixmap /= Void then
					u.set_x (u.x + area_x - drawable_position.x)
					u.set_y (u.y + area_y - drawable_position.y)
					area.draw_sub_pixmap (a_x, a_y, pixmap, u)
				end
			end
		end

	update is
			-- Update display by drawing the right part of the buffer on `area'.
		local
			u: EV_RECTANGLE
			pixmap: EV_PIXMAP
		do
			if world.is_show_requested then
				pixmap ?= drawable
				if pixmap /= Void then
					create u.set (
						area_x - drawable_position.x,
						area_y - drawable_position.y,
						area.width,
						area.height
					)
					area.draw_sub_pixmap (0, 0, pixmap, u)
				end
			end
		end

feature {NONE} -- Implementation

	on_paint (x, y, w, h: INTEGER) is
		do
			update_rectangle (create {EV_RECTANGLE}.make (x, y, w, h), x, y)
		end

	move_buffer is
			-- Move buffer so that `area' is in its middle.
		local
			buffer_bounds: EV_RECTANGLE
		do
			area_centered := True
			create buffer_bounds.make (
				area_x - area.width * (Buffer_scale_factor - 1) // 2,
				area_y - area.height * (Buffer_scale_factor - 1) // 2,
				drawable.width,
				drawable.height
				)
			drawable_position.set (buffer_bounds.x, buffer_bounds.y)
			project_rectangle (buffer_bounds)
		end

	resize_buffer (a_x, a_y, area_width, area_height: INTEGER) is
			-- Resize buffer if it is smaller than `Buffer_scale_factor' times
			-- the size given by `area_width' and `area_height'.
		local
			buffer: EV_PIXMAP
		do
			buffer ?= drawable
			if
				buffer /= Void
					and then
				(buffer.width < area_width * Buffer_scale_factor
					or else
				buffer.height < area_height * Buffer_scale_factor)
			then
				buffer.set_size (area_width.max (1) * Buffer_scale_factor, area_height.max (1) * Buffer_scale_factor)
			end
			move_buffer
			update
		end

	buffer_covers_area: BOOLEAN is
			-- Is `area' still in the surface covered by buffer ?
		do
			Result :=
				area_x > drawable_position.x
					and then
				area_x + area.width < drawable_position.x + drawable.width
					and then
				area_y > drawable_position.y
					and then
				area_y + area.height < drawable_position.y + drawable.height
		end

	recenter_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent for recentering on idle.
		once
			Result := agent recenter_area
		end

	recenter_area is
			-- Move buffer so that `area' is at its center.
		do
			if not area_centered then
				move_buffer
			end
			ev_application.idle_actions.prune_all (recenter_agent)
		end

	area_centered: BOOLEAN
			-- Is `area' showing the central part of `drawable', i.e. the buffer ?

invariant
	right_drawable_in_the_cell: drawable = drawable_in_the_cell

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_BUFFER_PROJECTOR

