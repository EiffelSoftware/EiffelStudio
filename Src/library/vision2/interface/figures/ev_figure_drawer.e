indexing
	description:
		"Adapters for EV_DRAWABLE that allow drawing of figures."
	status: "See notice at end of class"
	keywords: "figure, primitives, drawing" 
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FIGURE_DRAWER

inherit
	EV_FIGURE_DRAWING_ROUTINES

feature {NONE} -- Initialization

	make_with_drawable (a_drawable: EV_DRAWABLE) is
			-- Initialize.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			set_drawable (a_drawable)
		ensure
			assigned: drawable = a_drawable
		end

feature -- Basic Operations

	draw_grid is
			-- Draw the grid on the canvas.
			-- `world.point' is the origin of the grid.
		local
			cur_x, cur_y: INTEGER
			gx, gy: INTEGER
		do
			gx := world.grid_x
			gy := world.grid_y
			drawable.set_foreground_color (Default_colors.Grey)
			from
				cur_y := world.point.y_abs \\ gy
			until
				cur_y > drawable.height
			loop
				from
					cur_x := world.point.x_abs \\ gx
				until
					cur_x > drawable.width
				loop
					drawable.draw_point (cur_x, cur_y)
					cur_x := cur_x + gx
				end
				cur_y := cur_y + gy
			end
		end

feature -- Access

	drawable: EV_DRAWABLE
			-- Drawable surface. (screen, drawing area or pixmap)

	world: EV_FIGURE_WORLD is 
		deferred
		end

	Default_colors: EV_STOCK_COLORS is
		deferred
		end
	
feature -- Element Change

	set_drawable (a_drawable: EV_DRAWABLE) is
			-- Set `drawable' to `a_drawable'.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			drawable := a_drawable
		ensure
			assigned: drawable = a_drawable
		end

feature -- Figure drawing

	draw_figure_arc (arc: EV_FIGURE_ARC) is
			-- Draw a standard representation of `arc' to
			-- the canvas.
		local
			d: like drawable
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			a_x, a_y, a_width, a_height: INTEGER
		do
			d := drawable
			m := arc.metrics
			a_x := m.integer_item (1)
			a_y := m.integer_item (2)
			a_width := m.integer_item (3)
			a_height := m.integer_item (4)
			if arc.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (arc.line_width)
			d.set_foreground_color (arc.foreground_color)
			d.draw_arc (a_x, a_y, a_width, a_height, arc.start_angle,
				arc.aperture)
			if arc.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_dot (dot: EV_FIGURE_DOT) is
			-- Draw a standard representation of `dot' to
			-- the canvas.
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
			d.fill_ellipse (m.integer_item (1), m.integer_item (2),
				w, w)
			if dot.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_ellipse (ellipse: EV_FIGURE_ELLIPSE) is
			-- Draw a standard representation of `ellipse' to
			-- the canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			a_x, a_y, a_width, a_height: INTEGER
			bg: EV_COLOR
			d: like drawable
		do
			d := drawable
			if ellipse.dashed_line_style then
				d.enable_dashed_line_style
			end
			m := ellipse.metrics
			a_x := m.integer_item (1)
			a_y := m.integer_item (2)
			a_width := m.integer_item (3)
			a_height := m.integer_item (4)
			d.set_line_width (ellipse.line_width)
			bg := ellipse.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_ellipse (a_x, a_y, a_width, a_height)
			end
			d.set_foreground_color (ellipse.foreground_color)
			d.draw_ellipse (a_x, a_y, a_width, a_height)
			if ellipse.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_equilateral (eql: EV_FIGURE_EQUILATERAL) is
			-- Draw a standard representation of `eql' to
			-- the canvas.
		local
			bg: EV_COLOR
			d: like drawable
		do
			d := drawable
			if eql.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (eql.line_width)
			bg := eql.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_polygon (eql.polygon_array)
			end
			d.set_foreground_color (eql.foreground_color)
			d.draw_polyline (eql.polygon_array, True)
			if eql.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_line (line: EV_FIGURE_LINE) is
			-- Draw a standard representation of `line' to
			-- the canvas.
		local
			s, t: EV_RELATIVE_POINT
			p: EV_FIGURE_POLYGON
			d: like drawable
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)
			if line.is_start_arrow or else line.is_end_arrow then
				d.set_line_width (0)
				if line.is_start_arrow then
					p := line.start_arrow
					p.i_th_point (2).set_angle (
						line.start_angle)
					d.fill_polygon (p.point_array)
					s := line.start_draw_point
				else
					s := line.point_a
				end
				if line.is_end_arrow then
					p := line.end_arrow
					p.i_th_point (2).set_angle (
						line.end_angle)
					d.fill_polygon (p.point_array)
					t := line.end_draw_point
				else
					t := line.point_b
				end
			else
				s := line.point_a
				t := line.point_b
			end
			if line.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (line.line_width)
			d.draw_segment (s.x_abs, s.y_abs, t.x_abs, t.y_abs)
			if line.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_picture (picture: EV_FIGURE_PICTURE) is
			-- Draw a standard representation of `picture' to
			-- the canvas.
		local
			c: EV_COORDINATE
		do
			c := picture.point.absolute_coordinates
			drawable.draw_pixmap (c.x, c.y, picture.pixmap)
		end

	draw_figure_pie_slice (slice: EV_FIGURE_PIE_SLICE) is
			-- Draw a standard representation of `slice' to
			-- the canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			cx, cy, a_width, a_height: INTEGER
			bg: EV_COLOR
			d: like drawable
		do
			d := drawable
			if slice.dashed_line_style then
				d.enable_dashed_line_style
			end
			m := slice.metrics
			cx := m.integer_item (1)
			cy := m.integer_item (2)
			a_width := m.integer_item (3)
			a_height := m.integer_item (4)
			d.set_line_width (slice.line_width)
			bg := slice.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_pie_slice (cx, cy, a_height, a_width,
					slice.start_angle, slice.aperture)
			end
			d.set_foreground_color (slice.foreground_color)
			d.draw_pie_slice (cx, cy, a_height, a_width,
				slice.start_angle, slice.aperture)
			if slice.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_polygon (polygon: EV_FIGURE_POLYGON) is
			-- Draw a standard representation of `polygon' to
			-- the canvas.
		local
			bg: EV_COLOR
			d: like drawable
		do
			d := drawable
			if polygon.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (polygon.line_width)
			bg := polygon.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_polygon (polygon.point_array)
			end
			d.set_foreground_color (polygon.foreground_color)
			d.draw_polyline (polygon.point_array, True)
			if polygon.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_polyline (line: EV_FIGURE_POLYLINE) is
			-- Draw a standard representation of `polyline' to
			-- the canvas.
		local
			s, t: EV_RELATIVE_POINT
			p: EV_FIGURE_POLYGON
			d: like drawable
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)
			if line.point_count >= 2 then
				if
					line.is_start_arrow
				or else 
					line.is_end_arrow
				then
					d.set_line_width (0)
					if line.is_start_arrow then
						p := line.start_arrow
						p.i_th_point (2).set_angle (
							line.start_angle)
						d.fill_polygon (p.point_array)
						s := line.start_draw_point
					else
						s := line.start_point
					end
					if line.is_end_arrow then
						p := line.end_arrow
						p.i_th_point (2).set_angle (
							line.end_angle)
						d.fill_polygon (p.point_array)
						s := line.end_draw_point
					else
						t := line.end_point
					end
				end
			end
			--| FIXME Take `s' and `t' into account.
			if line.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (line.line_width)
			d.draw_polyline (line.point_array, line.is_closed)
			if line.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rectangle (rectangle: EV_FIGURE_RECTANGLE) is
			-- Draw a standard representation of `rectangle' to
			-- the canvas.
		local
			top, left: INTEGER
			d: like drawable
			bg: EV_COLOR
		do
			d := drawable
			if rectangle.dashed_line_style then
				d.enable_dashed_line_style
			end
			top := rectangle.point_a.y_abs.min (
				rectangle.point_b.y_abs)
			left := rectangle.point_a.x_abs.min (
				rectangle.point_b.x_abs)
			d.set_line_width (rectangle.line_width)
			bg := rectangle.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				if rectangle.orientation = 0.0 then
					d.fill_rectangle (
						left,
						top,
						rectangle.width,
						rectangle.height)
				else
					d.fill_polygon (
						rectangle.polygon_array)
				end
			end
			d.set_foreground_color (rectangle.foreground_color)
			if rectangle.orientation = 0.0 then
				d.draw_rectangle (left, top, rectangle.width,
					rectangle.height)
			else
				d.draw_polyline (rectangle.polygon_array, True)
			end
			if rectangle.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rounded_rectangle (f: EV_FIGURE_ROUNDED_RECTANGLE) is
			-- Draw a standard representation of `f' to the canvas.
		local
			d: like drawable
			bg: EV_COLOR
		do
			d := drawable
			if f.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (f.line_width)
			bg := f.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_polygon (f.polygon_array)
			end
			d.set_foreground_color (f.foreground_color)
			d.draw_polyline (f.polygon_array, True)
			if f.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_star (star: EV_FIGURE_STAR) is
			-- Draw a standard representation of `star' to
			-- the canvas.
		local
			cx, cy: INTEGER
			cl: ARRAY [EV_COORDINATE]
			c: EV_COORDINATE
			d: like drawable
			i: INTEGER
		do
			d := drawable
			if star.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_foreground_color (star.foreground_color)
			d.set_line_width (star.line_width)
			c := star.center_point.absolute_coordinates
			cx := c.x
			cy := c.y
			cl := star.polygon_array
			from i := cl.lower until i > cl.upper loop
				c := cl.item (i)
				d.draw_segment (cx, cy, c.x, c.y)
				i := i + 1
			end
			if star.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_text (text_figure: EV_FIGURE_TEXT) is
			-- Draw a standard representation of `text_figure' to
			-- the canvas.
			--| FIXME Hazardous when origin of `text_figure' has
			--| different values for `scale_x_abs'
			--| and `scale_y_abs'.
		local
			c: EV_COORDINATE
			cur_font, scaled_font: EV_FONT
			d: like drawable
		do
			d := drawable
			c := text_figure.point.absolute_coordinates
			cur_font := text_figure.font
			create scaled_font.make_with_values (
				cur_font.family,
				cur_font.weight,
				cur_font.shape,
				cur_font.height)
			scaled_font.set_height (
				(scaled_font.height *
				text_figure.point.scale_y_abs).rounded)
			d.set_font (scaled_font)
			d.set_foreground_color (text_figure.foreground_color)
			d.draw_text_top_left (c.x, c.y, text_figure.text)
		end

invariant
	drawable_not_void: drawable /= Void

end -- class EV_FIGURE_DRAWER

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
