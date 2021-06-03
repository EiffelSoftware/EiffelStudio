note
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
		undefine
			drawable_position
		redefine
			project_rectangle,
			buffer_used,
			change_area_position,
			update_rectangle,
			offset_x,
			offset_y,
			update
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
	make, make_with_buffer

feature {NONE} -- Initialization

	make (
		a_world: like world;
		a_drawing_area: EV_DRAWING_AREA)
			-- Create with `a_world' and `a_drawing_area'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
		do
			make_with_buffer (a_world, a_drawing_area)
		end

	make_with_buffer (
		a_world: like world;
		a_drawing_area: EV_DRAWING_AREA)
			-- Create with `a_world' and `a_drawing_area'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
		local
			a_buffer: EV_PIXMAP;
		do
			create a_buffer
			create drawable_cell.put (a_buffer)
			create drawable_position
			make_with_drawable_widget_and_buffer (
				a_world,
				a_drawing_area,
				a_buffer,
				a_drawing_area)
			a_drawing_area.expose_actions.extend (agent on_paint)
			a_drawing_area.resize_actions.extend (agent resize_buffer)
			a_drawing_area.dpi_changed_actions.extend (agent dpi_resize_buffer)

			recenter_agent := agent
				do
					if not area_centered then
						move_buffer
					end
				end
		end

feature -- Access

	buffer_scale_factor: REAL_32 = 1.2
			-- The buffer is `buffer_scale_factor' times bigger than the window.

	offset_x: INTEGER
			-- Everyting is drawn offset_x pixels to the right.
		do
			Result := -drawable_position.x
		end

	offset_y: INTEGER
			-- Everyting is drawen offset_y pixels to bottom.
		do
			Result := -drawable_position.y
		end

	world_as_pixmap (a_border: INTEGER): EV_PIXMAP
			-- Image of the `world' with `a_border'.
		require
			a_border_positive: a_border >= 0
		local
			rectangle: EV_RECTANGLE
			old_drawable: detachable like drawable
			old_drawable_position: detachable EV_COORDINATE
			u_x, u_y: INTEGER
		do
			is_world_too_large := False
			old_drawable := drawable
			old_drawable_position := drawable_position
			rectangle := world.bounding_box
			create drawable_position.make (rectangle.left - a_border, rectangle.top - a_border)

			create Result.make_with_size (rectangle.width + 2 * a_border, rectangle.height + 2 * a_border)
			drawable := Result

			u_x := rectangle.x
			u_y := rectangle.y
			drawable.set_background_color (world.background_color)
			drawable.set_anti_aliasing (world.is_anti_aliasing_enabled)
			drawable.clear_rectangle (u_x + offset_x, u_y + offset_y, rectangle.width, rectangle.height)
			if world.is_show_requested then
				project_figure_group_full (world)
			end
			world.validate

			set_drawable_position (old_drawable_position)
			drawable := old_drawable

		ensure
			Result_not_void: Result /= Void
		rescue
			is_world_too_large := True
			if old_drawable_position /= Void then
				set_drawable_position (old_drawable_position)
			end
			if old_drawable /= Void then
				drawable := old_drawable
			end
			full_project
		end

	is_world_too_large: BOOLEAN

feature -- Element change

	change_area_position (a_x, a_y: INTEGER)
			-- `area' has moved to (`a_x', `a_y') of `drawable'.
		do
			area_x := a_x
			area_y := a_y
			if not buffer_covers_area then
				move_buffer
			elseif area_centered then
				area_centered := False
				if attached recenter_agent then
					ev_application.do_once_on_idle (recenter_agent)
				end
			end
			update
		end

feature -- Status report

	buffer_used: BOOLEAN = True

feature -- Display updates

	project_rectangle (u: EV_RECTANGLE)
			-- Project area under `u'
		local
			u_x, u_y, u_width, u_height: INTEGER
			l_rect: EV_RECTANGLE
		do
			u_x := u.x
			u_y := u.y
			u_width := u.width
			u_height := u.height
			create l_rect.make (u_x, u_y, u_width, u_height)
			drawable.set_background_color (world.background_color)
			drawable.set_anti_aliasing (world.is_anti_aliasing_enabled)
			drawable.clear_rectangle (u_x - drawable_position.x, u_y - drawable_position.y, u_width, u_height)

			if world.grid_visible then
				draw_grid (world)
			end

			if world.is_show_requested then
				project_figure_group (world, l_rect)
			end
			if has_mouse then
				change_current (figure_on_position (world, last_pointer_x,
				last_pointer_y))
			end
			if world.points_visible then
				draw_points (world)
			end

			world.validate

			if 
				attached {EV_PIXMAP} drawable as pixmap and then
				attached area as l_area 
			then
				l_rect.set_x (u_x - drawable_position.x)
				l_rect.set_y (u_y - drawable_position.y)
				l_rect.set_width (u_width)
				l_rect.set_height (u_height)
				l_area.draw_sub_pixmap (
					u_x - area_x,
					u_y - area_y,
					pixmap,
					l_rect
				)
			end
		end

	update_rectangle (u: EV_RECTANGLE; a_x, a_y: INTEGER)
			-- Flush `u' on `area' at (`a_x', `a_y').
		do
			if world.is_show_requested then
				if
					attached {EV_PIXMAP} drawable as pixmap and then
					attached area as l_area
				then
					u.set_x (u.x + area_x - drawable_position.x)
					u.set_y (u.y + area_y - drawable_position.y)
					l_area.draw_sub_pixmap (a_x, a_y, pixmap, u)
				end
			end
		end

	update
			-- Update display by drawing the right part of the buffer on `area'.
		local
			u: EV_RECTANGLE
		do
			if world.is_show_requested then
				if
					attached {EV_PIXMAP} drawable as pixmap and then
					attached area as l_area
				then
					create u.set (
						area_x - drawable_position.x,
						area_y - drawable_position.y,
						l_area.width,
						l_area.height
					)
					l_area.draw_sub_pixmap (0, 0, pixmap, u)
				end
			end
		end

feature {NONE} -- Implementation

	on_paint (x, y, w, h: INTEGER)
		do
			update_rectangle (create {EV_RECTANGLE}.make (x, y, w, h), x, y)
		end

	move_buffer
			-- Move buffer so that `area' is in its middle.
		local
			buffer_bounds: EV_RECTANGLE
			l_area: like area
		do
			l_area := area
			check l_area /= Void then end
			area_centered := True
			create buffer_bounds.make (
				(area_x - l_area.width * (Buffer_scale_factor - 1) / 2).rounded,
				(area_y - l_area.height * (Buffer_scale_factor - 1) / 2).rounded,
				drawable.width,
				drawable.height
				)
			drawable_position.set (buffer_bounds.x, buffer_bounds.y)
			project_rectangle (buffer_bounds)
		end

	resize_buffer (a_x, a_y, area_width, area_height: INTEGER)
			-- Resize buffer if it is smaller than `Buffer_scale_factor' times
			-- the size given by `area_width' and `area_height'.
		do
			if attached {EV_PIXMAP} drawable as buffer then
				buffer.reset_for_buffering ((area_width.max (1) * Buffer_scale_factor).rounded, (area_height.max (1) * Buffer_scale_factor).rounded)
			end
			move_buffer
			update
		end

	dpi_resize_buffer (a_dpi: NATURAL_32; a_x, a_y, area_width, area_height: INTEGER)
			-- Resize buffer if it is smaller than `Buffer_scale_factor' times
			-- the size given by `area_width' and `area_height'.
		do
			resize_buffer (a_x, a_y, area_width, area_height)
		end

	buffer_covers_area: BOOLEAN
			-- Is `area' still in the surface covered by buffer ?
		local
			l_area: like area
		do
			l_area := area
			check l_area /= Void then end
			Result :=
				area_x > drawable_position.x
					and then
				area_x + l_area.width < drawable_position.x + drawable.width
					and then
				area_y > drawable_position.y
					and then
				area_y + l_area.height < drawable_position.y + drawable.height
		end

	recenter_agent: detachable PROCEDURE note option: stable attribute end
			-- Agent for recentering on idle.

	area_centered: BOOLEAN
			-- Is `area' showing the central part of `drawable', i.e. the buffer ?

invariant
	right_drawable_in_the_cell: drawable = drawable_in_the_cell

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
