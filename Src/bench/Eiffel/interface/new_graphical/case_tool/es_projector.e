indexing
	description: "Projectors for widgets using limited-sized buffer."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PROJECTOR

inherit

	EV_WIDGET_PROJECTOR
		export
			{NONE} set_drawable
		redefine
			project_rectangle,
			buffer_used,
			change_area_position,
			update_rectangle,
			draw_figure_dot
		end

	ES_DIAGRAM_BUFFER_MANAGER
		rename
			drawable as drawable_in_the_cell
		end
create
	make_with_buffer
	
feature {NONE} -- Initialization

	make_with_buffer (
		a_world: EV_FIGURE_WORLD;
		a_drawing_area: EV_DRAWING_AREA) is
			-- Create with `a_world', `a_drawing_area' and `a_buffer'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
		local
			a_buffer: EV_PIXMAP;
		do
			create a_buffer.make_with_size (a_drawing_area.width * Buffer_scale_factor, a_drawing_area.height * Buffer_scale_factor)
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
		
feature -- Element change
	
	change_area_position (a_x, a_y: INTEGER) is
			-- `area' has moved to (`a_x', `a_y') of `drawable'.
		local
			u: EV_RECTANGLE
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

feature -- Display updates

	project_rectangle (u: EV_RECTANGLE) is
			-- Project area under `u'.
		local
			pixmap: EV_PIXMAP
			u_x, u_y: INTEGER
		do
			u_x := u.x
			u_y := u.y
			drawable.set_background_color (world.background_color)
			drawable.clear_rectangle (u_x - drawable_position.x, u_y - drawable_position.y, u.width, u.height)

			if world.grid_enabled and world.grid_visible then
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
				project_rel_point (world.point)
			end

			world.validate

			pixmap ?= drawable
			if pixmap /= Void then
				u.set_x (u.x - drawable_position.x)
				u.set_y (u.y - drawable_position.y)
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
			pixmap ?= drawable
			if pixmap /= Void then
				u.set_x (u.x + area_x - drawable_position.x)
				u.set_y (u.y + area_y - drawable_position.y)
				area.draw_sub_pixmap (a_x, a_y, pixmap, u)
			end
		end

	update is
			-- Update display by drawing the right part of the buffer on `area'.
		local
			u: EV_RECTANGLE
			pixmap: EV_PIXMAP
		do
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

feature -- Export to PNG

	diagram_image (limits: EV_RECTANGLE): EV_PIXMAP is
			-- Projection of the portion of the diagram whithin bounds
			-- defined by `limits'.
		local
			old_x, old_y: INTEGER
			old_drawable: EV_DRAWABLE
		do
			old_x := drawable_position.x
			old_y := drawable_position.y
			old_drawable := drawable
			drawable_position.set (limits.x, limits.y)
			create Result.make_with_size (limits.width, limits.height)
			drawable := Result
			drawable_cell.replace (Result)
			drawable.set_background_color (world.background_color)
			drawable.clear_rectangle (0, 0, limits.width, limits.height)
			if world.grid_enabled and world.grid_visible then
				draw_grid
			end
			if world.is_show_requested then
				project_figure_group (world, limits)
			end
			drawable := old_drawable
			drawable_cell.replace (drawable)
			drawable_position.set (old_x, old_y)
		end
		
feature {NONE} -- Implementation

	draw_figure_dot (dot: EV_FIGURE_DOT) is
			-- Draw standard representation of `dot' to canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER]
			w: INTEGER
			d: like drawable
		do
			d := drawable
			if dot.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_foreground_color (dot.foreground_color)
			m := dot.metrics
			w := m.integer_item (3)
			d.fill_ellipse (
				m.integer_item (1) - drawable_position.x,
				m.integer_item (2) - drawable_position.y,
				w,
				w
			)
			if dot.dashed_line_style then
				d.disable_dashed_line_style
			end
		end
		
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
			move_buffer
			buffer ?= drawable
			if 
				buffer /= Void
					and then
				(buffer.width < area_width * Buffer_scale_factor
					or else
				buffer.height < area_height * Buffer_scale_factor)
			then
				buffer.set_size (area_width * Buffer_scale_factor, area_height * Buffer_scale_factor)
			end
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

	ev_application: EV_APPLICATION is
			-- Current application.
		once
			Result := (create {EV_ENVIRONMENT}).application
		end		

feature {NONE} -- Constants 		

	buffer_used: BOOLEAN is True	
		
	Buffer_scale_factor: INTEGER is 2
	
invariant
	right_drawable_in_the_cell: drawable = drawable_in_the_cell

end -- class ES_PROJECTOR
