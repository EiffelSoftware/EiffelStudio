indexing
	description:
		"Adapters for EV_DRAWABLE that allows drawing of figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, primitives, drawing"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_DRAWER

inherit
	EV_MODEL_DRAWING_ROUTINES

feature {NONE} -- Initialization

	make_with_drawable (a_drawable: like drawable) is
			-- Initialize.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			set_drawable (a_drawable)
		ensure
			assigned: drawable = a_drawable
		end

feature -- Access

	offset_x: INTEGER is
			-- Everyting is drawen offset_x pixels to the right.
		do
			Result := 0
		end

	offset_y: INTEGER is
			-- Everyting is drawen offest_y pixels to bottom.
		do
			Result := 0
		end

feature -- Basic Operations

	draw_grid is
			-- Draw grid on canvas.
			-- `world.point' is the origin of the grid.
		local
			cur_x, cur_y, start_x, start_y: INTEGER
			gx, gy, h, w: INTEGER
			l_drawable: like drawable
		do
			gx := world.grid_x
			gy := world.grid_y
			l_drawable := drawable
			l_drawable.set_foreground_color (default_colors.grey)
			h := l_drawable.height
			w := l_drawable.width
			start_x := offset_x \\ gx
			start_y := offset_y \\ gy

			from
				cur_y := start_y
			until
				cur_y > h
			loop
				from
					cur_x := start_x
				until
					cur_x > w
				loop
					drawable.draw_point (cur_x, cur_y)
					cur_x := cur_x + gx
				end
				cur_y := cur_y + gy
			end
		end

feature -- Access

	drawable: EV_DRAWABLE
			-- Drawable surface (screen, drawing area or pixmap).

	world: EV_MODEL_WORLD is
		deferred
		end

	Default_colors: EV_STOCK_COLORS is
		deferred
		end

feature -- Element Change

	set_drawable (a_drawable: like drawable) is
			-- Set `drawable' to `a_drawable'.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			drawable := a_drawable
		ensure
			assigned: drawable = a_drawable
		end

feature -- Figure drawing

	draw_figure_arc (arc: EV_MODEL_ARC) is
			-- Draw standard representation of `arc' to canvas.
		local
			l_point_array: SPECIAL [EV_COORDINATE]
			min_x, min_y, max_x, max_y: INTEGER
			p0, p1: EV_COORDINATE
			p0x, p0y, p1x, p1y: INTEGER
			d: like drawable
		do
			l_point_array := arc.point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)

			p0x := p0.x
			p0y := p0.y

			p1x := p1.x
			p1y := p1.y

			min_x := p0x.min (p1x)
			max_x := p0x.max (p1x)

			min_y := p0y.min (p1y)
			max_y := p0y.max (p1y)


			d := drawable
			if arc.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (arc.line_width)
			d.set_foreground_color (arc.foreground_color)
			d.draw_arc (min_x + offset_x, min_y + offset_y, max_x - min_x, max_y - min_y, arc.start_angle, arc.aperture)

			if arc.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rotated_arc  (arc: EV_MODEL_ROTATED_ARC) is
			-- Draw standard representation of `arc' to canvas.
		local
			d: like drawable
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1, p2, p3: EV_COORDINATE
			cx, cy: INTEGER
			r1, r2: INTEGER
			l_angle: DOUBLE
			l_offset_x, l_offset_y: INTEGER
		do
			l_point_array := arc.point_array

			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)

			r1 := arc.radius1
			r2 := arc.radius2

			d := drawable

			l_offset_x := offset_x
			l_offset_y := offset_y

			if r1 = 0 or else r2 = 0 then
				d.set_foreground_color (arc.foreground_color)
				d.set_line_width (arc.line_width)
				if arc.dashed_line_style then
					d.enable_dashed_line_style
				end
				if r1 = 0 then
					p3 := l_point_array.item (2)
					d.draw_segment (p0.x + l_offset_x, p0.y + l_offset_y, p3.x + l_offset_x, p3.y + l_offset_y)
				else
					p1 := l_point_array.item (1)
					d.draw_segment (p0.x + l_offset_x, p0.y + l_offset_y, p1.x + l_offset_x, p1.y + l_offset_y)
				end
				if arc.dashed_line_style then
					d.disable_dashed_line_style
				end
			else

				p2 := l_point_array.item (2)

				cx := ((p0.x_precise + p2.x_precise) / 2).truncated_to_integer
				cy := ((p0.y_precise + p2.y_precise) / 2).truncated_to_integer

				l_angle := arc.angle

				d.set_foreground_color (arc.foreground_color)
				d.set_line_width (arc.line_width)
				if arc.dashed_line_style then
					d.enable_dashed_line_style
				end
				draw_rotated_arc (cx + l_offset_x, cy + l_offset_y, r1, r2, -l_angle, arc.start_angle, arc.aperture)
				if arc.dashed_line_style then
					d.disable_dashed_line_style
				end
			end
		end

	draw_figure_dot (dot: EV_MODEL_DOT) is
			-- Draw standard representation of `dot' to canvas.
		local
			lw, lwh: INTEGER
			d: like drawable
			ce: EV_COORDINATE
		do
			d := drawable
			if dot.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_foreground_color (dot.foreground_color)

			lw := dot.line_width
			lwh := lw // 2

			ce := dot.point_array.item (0)

			d.fill_ellipse (ce.x - lwh + offset_x, ce.y - lwh + offset_y, lw, lw)
			if dot.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_ellipse (ellipse: EV_MODEL_ELLIPSE) is
			-- Draw standard representation of `ellipse' to canvas.
		local
			l_point_array: SPECIAL [EV_COORDINATE]
			min_x, min_y, max_x, max_y: INTEGER
			p0, p1: EV_COORDINATE
			p0x, p0y, p1x, p1y: INTEGER
			d: like drawable
			bg: EV_COLOR
			l_offset_x, l_offset_y: INTEGER
		do
			l_point_array := ellipse.point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)

			p0x := p0.x
			p0y := p0.y

			p1x := p1.x
			p1y := p1.y

			min_x := p0x.min (p1x)
			max_x := p0x.max (p1x)

			min_y := p0y.min (p1y)
			max_y := p0y.max (p1y)


			d := drawable
			if ellipse.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (ellipse.line_width)

			bg := ellipse.background_color

			l_offset_x := offset_x
			l_offset_y := offset_y

			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_ellipse (min_x + l_offset_x, min_y + l_offset_y, max_x - min_x, max_y - min_y)
			end
			d.set_foreground_color (ellipse.foreground_color)
			d.draw_ellipse (min_x + l_offset_x, min_y + l_offset_y, max_x - min_x, max_y - min_y)

			if ellipse.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rotated_ellipse (ellipse: EV_MODEL_ROTATED_ELLIPSE) is
			-- Draw standard representation of `ellipse' to canvas.
		local
			bg: EV_COLOR
			d: like drawable
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1, p2, p3: EV_COORDINATE
			cx, cy: INTEGER
			r1, r2: INTEGER
			l_angle: DOUBLE
			l_offset_x, l_offset_y: INTEGER
		do
			l_point_array := ellipse.point_array

			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)

			r1 := ellipse.radius1
			r2 := ellipse.radius2

			d := drawable

			l_offset_x := offset_x
			l_offset_y := offset_y

			if r1 = 0 or else r2 = 0 then
				d.set_foreground_color (ellipse.foreground_color)
				d.set_line_width (ellipse.line_width)
				if ellipse.dashed_line_style then
					d.enable_dashed_line_style
				end
				if r1 = 0 then
					p3 := l_point_array.item (2)
					d.draw_segment (p0.x + l_offset_x, p0.y + l_offset_y, p3.x + l_offset_x, p3.y + l_offset_y)
				else
					p1 := l_point_array.item (1)
					d.draw_segment (p0.x + l_offset_x, p0.y + l_offset_y, p1.x + l_offset_x, p1.y + l_offset_y)
				end
				if ellipse.dashed_line_style then
					d.disable_dashed_line_style
				end
			else

				bg := ellipse.background_color

				p2 := l_point_array.item (2)

				cx := ((p0.x_precise + p2.x_precise) / 2).truncated_to_integer
				cy := ((p0.y_precise + p2.y_precise) / 2).truncated_to_integer

				l_angle := ellipse.angle

				if bg /= Void then
					d.set_foreground_color (bg)
					fill_rotated_ellipse (cx + l_offset_x, cy + l_offset_y, r1, r2, -l_angle)
				end
				d.set_foreground_color (ellipse.foreground_color)
				d.set_line_width (ellipse.line_width)
				if ellipse.dashed_line_style then
					d.enable_dashed_line_style
				end
				draw_rotated_ellipse (cx + l_offset_x, cy + l_offset_y, r1, r2, -l_angle)
				if ellipse.dashed_line_style then
					d.disable_dashed_line_style
				end
			end
		end

	draw_figure_equilateral (eql: EV_MODEL_EQUILATERAL) is
			-- Draw standard representation of `eql' to canvas.
		local
			bg: EV_COLOR
			d: like drawable
			poly: ARRAY [EV_COORDINATE]
		do
			d := drawable
			if eql.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (eql.line_width)
			bg := eql.background_color
			poly := eql.polygon_array
			if offset_x /= 0 or else offset_y /= 0 then
				offset_coordinates (poly)
			end
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_polygon (poly)
			end
			d.set_foreground_color (eql.foreground_color)
			d.draw_polyline (poly, True)
			if eql.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_line (line: EV_MODEL_LINE) is
			-- Draw standard representation of `line' to canvas.
		local
			p: EV_MODEL_POLYGON
			d: like drawable
			l_point_array: SPECIAL [EV_COORDINATE]
			point_a, point_b: EV_COORDINATE
			poly: ARRAY [EV_COORDINATE]
			l_offset_x, l_offset_y: INTEGER
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)
			l_offset_x := offset_x
			l_offset_y := offset_y
			if line.is_start_arrow or else line.is_end_arrow then
				d.set_line_width (0)
				if line.is_start_arrow then
					p := line.start_arrow
					poly := create {EV_COORDINATE_ARRAY}.make_from_area(p.point_array)
					if l_offset_x /= 0 or else l_offset_y /= 0 then
						offset_coordinates (poly)
						d.fill_polygon (poly)
						deoffset_coordinates (poly)
					else
						d.fill_polygon (poly)
					end
				end
				if line.is_end_arrow then
					p := line.end_arrow
					poly := create {EV_COORDINATE_ARRAY}.make_from_area(p.point_array)
					if l_offset_x /= 0 or else l_offset_y /= 0 then
						offset_coordinates (poly)
						d.fill_polygon (poly)
						deoffset_coordinates (poly)
					else
						d.fill_polygon (poly)
					end
				end
			end
			if line.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (line.line_width)
			l_point_array := line.point_array
			point_a := l_point_array.item (0)
			point_b := l_point_array.item (1)
			d.draw_segment (point_a.x + l_offset_x, point_a.y + l_offset_y,
							point_b.x + l_offset_x, point_b.y + l_offset_y)
			if line.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_picture (picture: EV_MODEL_PICTURE) is
			-- Draw standard representation of `picture' to canvas.
		local
			c: EV_COORDINATE
		do
			c := picture.point_array.item (0)
			drawable.draw_pixmap (c.x + offset_x, c.y + offset_y, picture.scaled_pixmap)
		end

	draw_figure_pie_slice (slice: EV_MODEL_PIE_SLICE) is
			-- Draw standard representation of `slice' to canvas.
		local
			l_point_array: SPECIAL [EV_COORDINATE]
			min_x, min_y, max_x, max_y: INTEGER
			p0, p1: EV_COORDINATE
			p0x, p0y, p1x, p1y: INTEGER
			d: like drawable
			bg: EV_COLOR
			l_offset_x, l_offset_y: INTEGER
		do
			l_point_array := slice.point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)

			p0x := p0.x
			p0y := p0.y

			p1x := p1.x
			p1y := p1.y

			min_x := p0x.min (p1x)
			max_x := p0x.max (p1x)

			min_y := p0y.min (p1y)
			max_y := p0y.max (p1y)


			d := drawable
			if slice.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (slice.line_width)

			l_offset_x := offset_x
			l_offset_y := offset_y

			bg := slice.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_pie_slice (min_x + l_offset_x, min_y + l_offset_y, max_x - min_x, max_y - min_y, slice.start_angle, slice.aperture)
			end
			d.set_foreground_color (slice.foreground_color)
			d.draw_pie_slice (min_x + l_offset_x, min_y + l_offset_y, max_x - min_x, max_y - min_y, slice.start_angle, slice.aperture)

			if slice.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rotated_pie_slice (slice: EV_MODEL_ROTATED_PIE_SLICE) is
			-- Draw standard representation of `slice' to canvas.
		local
			bg: EV_COLOR
			d: like drawable
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1, p2, p3: EV_COORDINATE
			cx, cy: INTEGER
			r1, r2: INTEGER
			l_angle: DOUBLE
			l_offset_x, l_offset_y: INTEGER
		do
			l_point_array := slice.point_array

			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)

			r1 := slice.radius1
			r2 := slice.radius2

			l_offset_x := offset_x
			l_offset_y := offset_y

			d := drawable

			if r1 = 0 or else r2 = 0 then
				d.set_foreground_color (slice.foreground_color)
				d.set_line_width (slice.line_width)
				if slice.dashed_line_style then
					d.enable_dashed_line_style
				end
				if r1 = 0 then
					p3 := l_point_array.item (2)
					d.draw_segment (p0.x + l_offset_x, p0.y + l_offset_y, p3.x + l_offset_x, p3.y + l_offset_y)
				else
					p1 := l_point_array.item (1)
					d.draw_segment (p0.x + l_offset_x, p0.y + l_offset_y, p1.x + l_offset_x, p1.y + l_offset_y)
				end
				if slice.dashed_line_style then
					d.disable_dashed_line_style
				end
			else

				bg := slice.background_color

				p2 := l_point_array.item (2)

				cx := ((p0.x_precise + p2.x_precise) / 2).truncated_to_integer
				cy := ((p0.y_precise + p2.y_precise) / 2).truncated_to_integer

				l_angle := slice.angle

				if bg /= Void then
					d.set_foreground_color (bg)
					fill_rotated_pie_slice (cx + l_offset_x, cy + l_offset_y, r1, r2, -l_angle, slice.start_angle, slice.aperture)
				end
				d.set_foreground_color (slice.foreground_color)
				d.set_line_width (slice.line_width)
				if slice.dashed_line_style then
					d.enable_dashed_line_style
				end
				draw_rotated_pie_slice (cx + l_offset_x, cy + l_offset_y, r1, r2, -l_angle, slice.start_angle, slice.aperture)
				if slice.dashed_line_style then
					d.disable_dashed_line_style
				end
			end
		end

	draw_figure_polygon (polygon: EV_MODEL_POLYGON) is
			-- Draw standard representation of `polygon' to canvas.
		local
			bg: EV_COLOR
			d: like drawable
			polygon_array: ARRAY [EV_COORDINATE]
		do
			d := drawable
			if polygon.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (polygon.line_width)
			bg := polygon.background_color
			polygon_array := create {EV_COORDINATE_ARRAY}.make_from_area (polygon.point_array)
			if offset_x /= 0 or else offset_y /= 0 then
				offset_coordinates (polygon_array)
				if bg /= Void then
					d.set_foreground_color (bg)
					d.fill_polygon (polygon_array)
				end
				d.set_foreground_color (polygon.foreground_color)
				d.draw_polyline (polygon_array, True)
				deoffset_coordinates (polygon_array)
			else
				if bg /= Void then
					d.set_foreground_color (bg)
					d.fill_polygon (polygon_array)
				end
				d.set_foreground_color (polygon.foreground_color)
				d.draw_polyline (polygon_array, True)
			end
			if polygon.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_polyline (line: EV_MODEL_POLYLINE) is
			-- Draw standard representation of `polyline' to canvas.
		local
			p: EV_MODEL_POLYGON
			d: like drawable
			point_array, poly: ARRAY [EV_COORDINATE]
			a1, a2: EV_COORDINATE
			old_lsx, old_lsy, old_lex, old_ley: DOUBLE
			l_item: EV_COORDINATE
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)
			point_array := create {EV_COORDINATE_ARRAY}.make_from_area (line.point_array)
			d.set_line_width (line.line_width)
			if point_array.count >= 2 then
				if line.is_start_arrow then
					p := line.start_arrow
					poly := create {EV_COORDINATE_ARRAY}.make_from_area (p.point_array)
					if offset_x /= 0 or else offset_y /= 0 then
						offset_coordinates (poly)
						d.fill_polygon (poly)
						deoffset_coordinates (poly)
					else
						d.fill_polygon (poly)
					end
					a1 := p.point_array.item (1)
					a2 := p.point_array.item (2)
					l_item := point_array.item (0)
					old_lsx := l_item.x_precise
					old_lsy := l_item.y_precise
					l_item.set_precise ((a1.x_precise + a2.x_precise) / 2, (a1.y_precise + a2.y_precise) / 2)
				end
				if line.is_end_arrow then
					p := line.end_arrow
					poly := create {EV_COORDINATE_ARRAY}.make_from_area (p.point_array)
					if offset_x /= 0 or else offset_y /= 0 then
						offset_coordinates (poly)
						d.fill_polygon (poly)
						deoffset_coordinates (poly)
					else
						d.fill_polygon (poly)
					end
					a1 := p.point_array.item (1)
					a2 := p.point_array.item (2)
					l_item := point_array.item (point_array.count)
					old_lex := l_item.x_precise
					old_ley := l_item.y_precise
					l_item.set_precise ((a1.x_precise + a2.x_precise) / 2, (a1.y_precise + a2.y_precise) / 2)
				end
			end
			if line.dashed_line_style then
				d.enable_dashed_line_style
			end
			if offset_x /= 0 or else offset_y /= 0 then
				offset_coordinates (point_array)
				d.draw_polyline (point_array, line.is_closed)
				deoffset_coordinates (point_array)
			else
				d.draw_polyline (point_array, line.is_closed)
			end
			if line.is_start_arrow then
				point_array.item (0).set_precise (old_lsx, old_lsy)
			end
			if line.is_end_arrow then
				point_array.item (point_array.count).set_precise (old_lex, old_ley)
			end
			if line.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_parallelogram (parallelogram: EV_MODEL_PARALLELOGRAM) is
			-- Draw standad representation of `parallelogram' to canvas.
		local
			d: like drawable
			bg: EV_COLOR
			point_area: SPECIAL [EV_COORDINATE]
			point_array: ARRAY [EV_COORDINATE]
			p1, p2, p4: EV_COORDINATE
			width, height: INTEGER
			p1x, p1y, p2x, p4y, min_x, max_x, min_y, max_y: INTEGER
					-- p1 ------ p2
					-- |          |
					-- p4 ------ p3
		do
			d := drawable
			if parallelogram.dashed_line_style then
				d.enable_dashed_line_style
			end

			d.set_line_width (parallelogram.line_width)
			bg := parallelogram.background_color

			point_area := parallelogram.point_array
			p1 := point_area.item (0)
			p1x := p1.x
			p1y := p1.y
			p2 := point_area.item (1)
			p4 := point_area.item (3)

			if p1y = p2.y and then p1x = p4.x then
				min_x := p1x
				max_x := min_x
				min_y := p1y
				max_y := min_y

				p2x := p2.x
				min_x := min_x.min (p2x)
				max_x := max_x.max (p2x)

				p4y := p4.y
				min_y := min_y.min (p4y)
				max_y := max_y.max (p4y)

				width := max_x - min_x
				height := max_y - min_y
				min_x := min_x + offset_x
				min_y := min_y + offset_y
				if bg /= Void then
					d.set_foreground_color (bg)
					d.fill_rectangle (min_x, min_y, width + 1, height + 1)
				end
				d.set_foreground_color (parallelogram.foreground_color)
				d.draw_rectangle (min_x, min_y, width + 1, height + 1)
			else
				point_array := create {EV_COORDINATE_ARRAY}.make_from_area (point_area)
				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (point_array)
					if bg /= Void then
						d.set_foreground_color (bg)
						d.fill_polygon (point_array)
					end
					d.set_foreground_color (parallelogram.foreground_color)
					d.draw_polyline (point_array, True)
					deoffset_coordinates (point_array)
				else
					if bg /= Void then
						d.set_foreground_color (bg)
						d.fill_polygon (point_array)
					end
					d.set_foreground_color (parallelogram.foreground_color)
					d.draw_polyline (point_array, True)
				end
			end

			if parallelogram.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rectangle (rectangle: EV_MODEL_RECTANGLE) is
			-- Draw standard representation of `rectangle' to canvas.
		local
			width, height, min_x, min_y, p0x, p0y, p1x, p1y: INTEGER
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1: EV_COORDINATE
			d: like drawable
			bg: EV_COLOR
		do
			l_point_array := rectangle.point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)

			p0x := p0.x
			p0y := p0.y
			p1x := p1.x
			p1y := p1.y

			width := (p0x - p1x).abs
			height := (p0y - p1y).abs

			min_x := p0x.min (p1x) + offset_x
			min_y := p0y.min (p1y) + offset_y

			d := drawable
			if rectangle.dashed_line_style then
				d.enable_dashed_line_style
			end

			d.set_line_width (rectangle.line_width)


			bg := rectangle.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				d.fill_rectangle (min_x, min_y, width + 1, height + 1)
			end
			d.set_foreground_color (rectangle.foreground_color)
			d.draw_rectangle (min_x, min_y, width + 1, height + 1)
			if rectangle.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_rounded_parallelogram (f: EV_MODEL_ROUNDED_PARALLELOGRAM) is
			-- Draw standart representation of `f' to canvas.
		local
			d: like drawable
			bg: EV_COLOR
			p_array: ARRAY [EV_COORDINATE]
		do
			d := drawable
			if f.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (f.line_width)
			bg := f.background_color
			p_array := f.polygon_array
			if offset_x /= 0 or else offset_y /= 0 then
				offset_coordinates (p_array)
				if bg /= Void then
					d.set_foreground_color (bg)
					d.fill_polygon (p_array)
				end
				d.set_foreground_color (f.foreground_color)
				d.draw_polyline (p_array, True)
				deoffset_coordinates (p_array)
			else
				if bg /= Void then
					d.set_foreground_color (bg)
					d.fill_polygon (p_array)
				end
				d.set_foreground_color (f.foreground_color)
				d.draw_polyline (p_array, True)
			end

			if f.dashed_line_style then
				d.disable_dashed_line_style
			end

		end

	draw_figure_rounded_rectangle (f: EV_MODEL_ROUNDED_RECTANGLE) is
			-- Draw standard representation of `f' to canvas.
		local
			d: like drawable
			bg: EV_COLOR
			l_point_array: SPECIAL [EV_COORDINATE]
			p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y, p4x, p4y, p5x, p5y: INTEGER
			p0, p1, p2, p3, p4, p5: EV_COORDINATE
			l_offset_x, l_offset_y: INTEGER
			pi2: DOUBLE
		do
			l_point_array := f.point_array
			p0 := l_point_array.item (2)
			p1 := l_point_array.item (3)
			p2 := l_point_array.item (4)
			p3 := l_point_array.item (5)
			p4 := l_point_array.item (6)
			p5 := l_point_array.item (7)

			l_offset_x := offset_x
			l_offset_y := offset_y

			p0x := p0.x + l_offset_x
			p0y := p0.y + l_offset_y
			p1x := p1.x + l_offset_x
			p1y := p1.y + l_offset_y
			p2x := p2.x + l_offset_x
			p2y := p2.y + l_offset_y
			p3x := p3.x + l_offset_x
			p3y := p3.y + l_offset_y
			p4x := p4.x + l_offset_x
			p4y := p4.y + l_offset_y
			p5x := p5.x + l_offset_x
			p5y := p5.y + l_offset_y

			d := drawable
			if f.dashed_line_style then
				d.enable_dashed_line_style
			end

			d.set_line_width (f.line_width)

			bg := f.background_color
			if bg /= Void then
				d.set_foreground_color (bg)
				if p3x > p2x and then p1y > p0y then
					d.fill_rectangle (p2x, p0y, p3x - p2x, p1y - p0y)
				end
				if p2x > p0x and then p5y > p2y then
					d.fill_rectangle (p0x, p2y, p2x - p0x, p5y - p2y)
				end
				if p1x > p3x and then p4y > p3y then
					d.fill_rectangle (p3x, p3y, p1x - p3x, p4y - p3y)
				end

				d.fill_ellipse (p0x, p0y, (p2x - p0x) * 2, (p2y - p0y) * 2)
				d.fill_ellipse (p1x - (p1x - p3x) * 2, p0y, (p1x - p3x) * 2, (p3y - p0y) * 2)
				d.fill_ellipse (p1x - (p1x - p4x) * 2 + 1, p1y - (p1y - p4y) * 2 + 1, (p1x - p4x) * 2, (p1y - p4y) * 2)
				d.fill_ellipse (p0x, p1y - (p1y - p5y) * 2 + 1, (p5x - p0x) * 2, (p1y - p5y) * 2)

			end
			d.set_foreground_color (f.foreground_color)

			d.draw_segment (p2x, p0y, p3x, p0y)
			d.draw_segment (p1x, p3y, p1x, p4y)
			d.draw_segment (p5x - 1, p1y, p4x, p1y)
			d.draw_segment (p0x, p2y - 1, p0x, p5y)

			pi2 := pi / 2

			d.draw_arc (p0x, p0y, (p2x - p0x) * 2, (p2y - p0y) * 2, pi2, pi2)
			d.draw_arc (p1x - (p1x - p3x) * 2, p0y, (p1x - p3x) * 2, (p3y - p0y) * 2, 0, pi2)
			d.draw_arc (p1x - (p1x - p4x) * 2 + 1, p1y - (p1y - p4y) * 2 + 1, (p1x - p4x) * 2, (p1y - p4y) * 2, 3* pi2, pi2)
			d.draw_arc (p0x, p1y - (p1y - p5y) * 2 + 1, (p5x - p0x) * 2, (p1y - p5y) * 2, pi, pi2)

			if f.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_star (star: EV_MODEL_STAR) is
			-- Draw standard representation of `star' to canvas.
		local
			cx, cy: INTEGER
			l_point_area: SPECIAL [EV_COORDINATE]
			c: EV_COORDINATE
			d: like drawable
			i, nb: INTEGER
			l_offset_x, l_offset_y: INTEGER
		do
			d := drawable
			if star.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_foreground_color (star.foreground_color)
			d.set_line_width (star.line_width)
			l_point_area := star.point_array
			cx := l_point_area.item (0).x
			cy := l_point_area.item (0).y
			l_offset_x := offset_x
			l_offset_y := offset_y
			from
				i := 1
				nb := l_point_area.count - 1
			until
				i > nb
			loop
				c := l_point_area.item (i)
				d.draw_segment (cx + l_offset_x, cy + l_offset_y, c.x + l_offset_x, c.y + l_offset_y)
				i := i + 1
			end
			if star.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

	draw_figure_text (text_figure: EV_MODEL_TEXT) is
			-- Draw standard representation of `text_figure' to canvas.
		local
			p0: EV_COORDINATE
			d: like drawable
		do
			if text_figure.height > 2 then
				p0 := text_figure.point_array.item (0)

				d := drawable
				d.set_font (text_figure.scaled_font)
				d.set_foreground_color (text_figure.foreground_color)

				d.draw_text_top_left (p0.x + offset_x - text_figure.left_offset, p0.y + offset_y, text_figure.text)
			end
		end

feature {NONE} -- Implementation

	offset_coordinates (coordinates: ARRAY [EV_COORDINATE]) is
			-- Add `offset_x' `offset_y' to all points in `coordinates'.
		local
			i, nb: INTEGER
			coordinate: EV_COORDINATE
		do
			from
				i := coordinates.lower
				nb := coordinates.upper
			until
				i > nb
			loop
				coordinate := coordinates.item (i)
				coordinate.set_precise (coordinate.x_precise + offset_x, coordinate.y_precise + offset_y)
				i := i + 1
			end
		end

	deoffset_coordinates (coordinates: ARRAY [EV_COORDINATE]) is
			-- Subtract `offset_x' `offset_y' from all points in `coordinates'.
		local
			i, nb: INTEGER
			coordinate: EV_COORDINATE
		do
			from
				i := coordinates.lower
				nb := coordinates.upper
			until
				i > nb
			loop
				coordinate := coordinates.item (i)
				coordinate.set_precise (coordinate.x_precise - offset_x, coordinate.y_precise - offset_y)
				i := i + 1
			end
		end

	fill_rotated_ellipse (xcen, ycen, a, b: INTEGER; phi: DOUBLE) is
			 -- Draw a filled ellipse with center (`xcen',`ycen'), radius1 `a',
			 -- radius2 `b' and rotation `phi' counter clockwise.
			 --
			 -- The algorithm used here was written by James Tough some time ago and was (or is?)
			 -- used in the xfig project (www.xfig.org). Please read the orginal comment
			 -- from James to see how it works:
			 --
			 --  An Ellipse Generator.
			 --  Written by James Tough   7th May 92
			 --
			 --  The following routines displays a filled ellipse on the screen from the
			 --    semi-minor axis 'a', semi-major axis 'b' and angle of rotation
			 --    'phi'.
			 --
			 --  It works along these principles .....
			 --
			 --        The standard ellipse equation is
			 --
			 --             x*x     y*y
			 --             ---  +  ---
			 --             a*a     b*b
			 --
			 --
			 --        Rotation of a point (x,y) is well known through the use of
			 --
			 --            x' = x*COS(phi) - y*SIN(phi)
			 --            y' = y*COS(phi) + y*COS(phi)
			 --
			 --        Taking these to together, this gives the equation for a rotated
			 --      ellipse centered around the origin.
			 --
			 --           [x*COS(phi) - y*SIN(phi)]^2   [x*SIN(phi) + y*COS(phi)]^2
			 --           --------------------------- + ---------------------------
			 --                      a*a                           b*b
			 --
			 --        NOTE -  some of the above equation can be precomputed, eg,
			 --
			 --              i = COS(phi)/a        and        j = SIN(phi)/b
			 --
			 --        NOTE -  y is constant for each line so,
			 --
			 --              m = -yk*SIN(phi)/a    and     n = yk*COS(phi)/b
			 --              where yk stands for the kth line ( y subscript k)
			 --
			 --        Where yk=y, we get a quadratic,
			 --
			 --              (i*x + m)^2 + (j*x + n)^2 = 1
			 --
			 --        Thus for any particular line, y, there is two corresponding x
			 --      values. These are the roots of the quadratic. To get the roots,
			 --      the above equation can be rearranged using the standard method,
			 --
			 --          -(i*m + j*n) +- sqrt[i^2 + j^2 - (i*n -j*m)^2]
			 --      x = ----------------------------------------------
			 --                           i^2 + j^2
			 --
			 --        NOTE -  again much of this equation can be precomputed.
			 --
			 --           c1 = i^2 + j^2
			 --           c2 = [COS(phi)*SIN(phi)*(a-b)]
			 --           c3 = [b*b*(COS(phi)^2) + a*a*(SIN(phi)^2)]
			 --           c4 = a*b/c3
			 --
			 --      x = c2*y +- c4*sqrt(c3 - y*y),    where +- must be evaluated once
			 --                                      for plus, and once for minus.
			 --
			 --        We also need to know how large the ellipse is. This condition
			 --      arises when the sqrt of the above equation evaluates to zero.
			 --      Thus the height of the ellipse is give by
			 --
			 --              sqrt[ b*b*(COS(phi)^2) + a*a*(SIN(phi)^2) ]
			 --
			 --       which just happens to be equal to sqrt(c3).
			 --
			 --         It is now possible to create a routine that will scan convert
			 --       the ellipse on the screen.
			 --
			 -- Please also consider the copyright notice from the xfig project:
			 --
			 -- Any party obtaining a copy of these files is granted, free of charge, a
			 -- full and unrestricted irrevocable, world-wide, paid up, royalty-free,
			 -- nonexclusive right and license to deal in this software and
			 -- documentation files (the "Software"), including without limitation the
			 -- rights to use, copy, modify, merge, publish and/or distribute copies of
			 -- the Software, and to permit persons who receive copies from any such
			 -- party to do so, with the only requirement being that this copyright
			 -- notice remain intact.
		require
			a_larger_0: a > 0
			b_larger_0: b > 0
		local
			c1, c2, c3, c4, c5, c6, v1, cphi, sphi, cphisqr, sphisqr: DOUBLE
 			d, asqr, bsqr: DOUBLE
 			xleft, xright: INTEGER
			y_top, y_bottom: INTEGER
			l_drawable: like drawable
		do
			 cphi := cosine (phi)
			 sphi := sine (phi)
			 cphisqr := cphi * cphi
			 sphisqr := sphi * sphi
			 asqr := a * a
			 bsqr := b * b

			 c1 := (cphisqr / asqr) + (sphisqr / bsqr)
			 c2 := ((cphi * sphi / asqr) - (cphi * sphi / bsqr)) / c1
			 c3 := (bsqr * cphisqr) + (asqr * sphisqr)
			 c4 := a * b / c3
			 c5 := 0
			 v1 := c4 * c4
			 c6 := 2 * v1
			 c3 := c3 * v1 - v1

			 from
			 	l_drawable := drawable
			 	l_drawable.set_line_width (2)
			 	y_top := ycen
			 	y_bottom := ycen
			 until
			 	c3 < 0
			 loop
				d := sqrt (c3)
				xleft := (c5 - d).truncated_to_integer
				xright := (c5 + d).truncated_to_integer

				l_drawable.draw_segment (xcen + xleft + 1, y_top, xcen + xright, y_top)
				l_drawable.draw_segment (xcen - xleft, y_bottom + 1, xcen - xright + 1, y_bottom + 1)

				c5 := c5 + c2
				v1 := v1 + c6
				c3 := c3 - v1
			 	y_top := y_top + 1
			 	y_bottom := y_bottom - 1
		 	end
		end

	draw_rotated_ellipse (xcen, ycen, a, b: INTEGER; phi: DOUBLE) is
			-- Draw a ellipse border with center (`xcen',`ycen'), radius1 `a',
			-- radius2 `b' and rotation `phi' counter clockwise.
			-- Please see fill_rotated_ellipse for more informations.
		require
			a_larger_0: a > 0
			b_larger_0: b > 0
		local
			c1, c2, c3, c4, c5, c6, v1, cphi, sphi, cphisqr, sphisqr: DOUBLE
 			d, asqr, bsqr: DOUBLE
 			xleft, xright, oldxleft, oldxright: INTEGER
			y_top, y_bottom, x, xnb, pix1_count, pix2_count: INTEGER
			l_drawable: like drawable
			dashed: BOOLEAN
			lw: INTEGER
		do
			 cphi := cosine (phi)
			 sphi := sine (phi)
			 cphisqr := cphi * cphi
			 sphisqr := sphi * sphi
			 asqr := a * a
			 bsqr := b * b

			 c1 := (cphisqr / asqr) + (sphisqr / bsqr)
			 c2 := ((cphi * sphi / asqr) - (cphi * sphi / bsqr)) / c1
			 c3 := (bsqr * cphisqr) + (asqr * sphisqr)
			 c4 := a * b / c3
			 c5 := 0
			 v1 := c4 * c4
			 c6 := 2 * v1
			 c3 := c3 * v1 - v1

			 from
			 	l_drawable := drawable
			 	lw := l_drawable.line_width
			 	dashed := l_drawable.dashed_line_style and lw = 1
			 	d := sqrt (c3)
			 	oldxleft := (c5 - d).truncated_to_integer
			 	oldxright := (c5 + d).truncated_to_integer
			 	c5 := c5 + c2
				v1 := v1 + c6
				c3 := c3 - v1
			 	y_top := ycen + 1
			 	y_bottom := ycen - 1
			 until
			 	c3 < 0
			 loop
				d := sqrt (c3)
				xleft := (c5 - d).truncated_to_integer
				xright := (c5 + d).truncated_to_integer

				if lw > 0 then
					if dashed then
						from
							x := oldxleft.min (xleft)
							xnb := oldxleft.max (xleft)
						until
							x > xnb
						loop
							if pix1_count \\ 8 < 4 then
								l_drawable.draw_point (xcen + x, y_top-1)
								l_drawable.draw_point (xcen - x, y_bottom)
							end
							pix1_count := pix1_count + 1
							x := x + 1
						end
						from
							x := oldxright.min (xright)
							xnb := oldxright.max (xright)
						until
							x > xnb
						loop
							if pix2_count \\ 8 < 4 then
								l_drawable.draw_point (xcen + x, y_top-1)
								l_drawable.draw_point (xcen - x, y_bottom)
							end
							pix2_count := pix2_count + 1
							x := x + 1
						end
					else
						l_drawable.draw_segment (xcen + oldxleft, y_top - 1, xcen + xleft, y_top)
				  		l_drawable.draw_segment (xcen + oldxright, y_top - 1, xcen + xright, y_top)
					  	l_drawable.draw_segment (xcen - oldxleft, y_bottom + 1, xcen - xleft, y_bottom)
					  	l_drawable.draw_segment (xcen - oldxright, y_bottom + 1, xcen - xright, y_bottom)
					end
				end

				c5 := c5 + c2
				v1 := v1 + c6
				c3 := c3 - v1
			 	y_top := y_top + 1
			 	y_bottom := y_bottom - 1
			 	oldxleft := xleft
			 	oldxright := xright
		 	end
		 	if lw > 0 then
			 	l_drawable.draw_segment (xcen + xleft, y_top, xcen + xright, y_top)
			 	l_drawable.draw_segment (xcen - xleft, y_bottom + 1, xcen - xright, y_bottom + 1)
		 	end
		end

	draw_rotated_arc (xcen, ycen, a, b: INTEGER; phi, start_angle, aperture: DOUBLE) is
			-- Draw a ellipse border from `start_angle' to `start_angle' + `aperture'.
			-- with center (`xcen',`ycen'), radius1 `a',
			-- radius2 `b' and rotation `phi' counter clockwise.
			-- `start_angle' is counter clockwise starting at 3 o'clock.
			-- Please see fill_rotated_ellipse for more informations.
		require
			a_larger_0: a > 0
			b_larger_0: b > 0
		local
			c1, c2, c3, c4, c5, c6, v1, cphi, sphi, cphisqr, sphisqr: DOUBLE
 			d, asqr, bsqr: DOUBLE
 			xleft, xright, oldxleft, oldxright: INTEGER
			y_top, y_bottom, x, xnb, pix1_count, pix2_count: INTEGER
			l_drawable: like drawable
			dashed: BOOLEAN
			a_start_angle, an_end_angle: DOUBLE
			lw, lw2: INTEGER
		do
		 	if drawable.line_width > 0 then
				 cphi := cosine (phi)
				 sphi := sine (phi)
				 cphisqr := cphi * cphi
				 sphisqr := sphi * sphi
				 asqr := a * a
				 bsqr := b * b

				 c1 := (cphisqr / asqr) + (sphisqr / bsqr)
				 c2 := ((cphi * sphi / asqr) - (cphi * sphi / bsqr)) / c1
				 c3 := (bsqr * cphisqr) + (asqr * sphisqr)
				 c4 := a * b / c3
				 c5 := 0
				 v1 := c4 * c4
				 c6 := 2 * v1
				 c3 := c3 * v1 - v1

				 a_start_angle :=  phi + start_angle
				 a_start_angle := modulo (a_start_angle, 2 * pi)

				 an_end_angle := a_start_angle + aperture
				 an_end_angle := modulo (an_end_angle, 2 * pi)
				 from
				 	l_drawable := drawable
				 	lw := l_drawable.line_width
				 	if lw > 1 then
				 		l_drawable.set_background_color (l_drawable.foreground_color)
				 		l_drawable.disable_dashed_line_style
				 		if lw <= 2 then
				 			lw := lw + 1
				 		end
				 	end
				 	lw2 := lw // 2
				 	dashed := l_drawable.dashed_line_style
				 	d := sqrt (c3)
				 	oldxleft := (c5 - d).truncated_to_integer
				 	oldxright := (c5 + d).truncated_to_integer

				 	c5 := c5 + c2
					v1 := v1 + c6
					c3 := c3 - v1
				 	y_top := ycen --+ 1
				 	y_bottom := ycen-- - 1
				 until
				 	c3 < 0
				 loop
					d := sqrt (c3)
					xleft := (c5 - d).truncated_to_integer
					xright := (c5 + d).truncated_to_integer

					from
						x := oldxleft.min (xleft)
						xnb := oldxleft.max (xleft)
					until
						x > xnb
					loop
						if not dashed or else pix1_count \\ 8 < 4 then
							if inside (x, y_top - ycen, a_start_angle, an_end_angle) then
								if lw = 1 then
									l_drawable.draw_point (xcen + x, y_top)
								else
									l_drawable.fill_ellipse (xcen + x - lw2, y_top - lw2, lw, lw)
								end
							end
							if inside (-x, y_bottom - ycen, a_start_angle, an_end_angle) then
								if lw = 1 then
									l_drawable.draw_point (xcen - x, y_bottom-1)
								else
									l_drawable.fill_ellipse (xcen - x - lw2, y_bottom - lw2, lw, lw)
								end
							end
						end

						pix1_count := pix1_count + 1
						x := x + 1
					end
					from
						x := oldxright.min (xright)
						xnb := oldxright.max (xright)
					until
						x > xnb
					loop
						if not dashed or else pix2_count \\ 8 < 4 then
							if inside (x, y_top - ycen, a_start_angle, an_end_angle) then
								if lw = 1 then
									l_drawable.draw_point (xcen + x, y_top)
								else
									l_drawable.fill_ellipse (xcen + x - lw2, y_top - lw2, lw, lw)
								end
							end
							if inside (-x, y_bottom - ycen, a_start_angle, an_end_angle) then
								if lw = 1 then
									l_drawable.draw_point (xcen - x, y_bottom-1)
								else
									l_drawable.fill_ellipse (xcen - x - lw2, y_bottom - lw2, lw, lw)
								end
							end
						end
						pix2_count := pix2_count + 1
						x := x + 1
					end

					c5 := c5 + c2
					v1 := v1 + c6
					c3 := c3 - v1
				 	y_top := y_top + 1
				 	y_bottom := y_bottom - 1
				 	oldxleft := xleft
				 	oldxright := xright
			 	end

			 	from
					x := xright.min (xleft)
					xnb := xright.max (xleft)
				until
					x > xnb
				loop
					if not dashed or else pix2_count \\ 8 < 4 then
						if inside (x, y_top - ycen, a_start_angle, an_end_angle) then
							if lw = 1 then
								l_drawable.draw_point (xcen + x, y_top)
							else
								l_drawable.fill_ellipse (xcen + x - lw2, y_top - lw2, lw, lw)
							end
						end
						if inside (-x, y_bottom - ycen, a_start_angle, an_end_angle) then
							if lw = 1 then
								l_drawable.draw_point (xcen - x, y_bottom - 1)
							else
								l_drawable.fill_ellipse (xcen - x - lw2, y_bottom - lw2, lw, lw)
							end
						end
					end
					pix2_count := pix2_count + 1
					x := x + 1
				end
		 	end
		end

	draw_rotated_pie_slice (xcen, ycen, a, b: INTEGER; phi, start_angle, aperture: DOUBLE) is
			-- Draw a pie slice border from `start_angle' to `start_angle' + `aperture'.
			-- with center (`xcen',`ycen'), radius1 `a',
			-- radius2 `b' and rotation `phi' counter clockwise.
			-- `start_angle' is counter clockwise starting at 3 o'clock.
			-- Please see fill_rotated_ellipse for more informations.
		require
			a_larger_0: a > 0
			b_larger_0: b > 0
		local
			a_start_angle, an_end_angle: DOUBLE
			cphi, sphi, cos, sin: DOUBLE
			start_x, start_y, end_x, end_y: INTEGER

			val_x, val_y, r: DOUBLE
		do
			if drawable.line_width > 0 then
				draw_rotated_arc (xcen, ycen, a, b, phi, start_angle, aperture)

				a_start_angle :=  phi + start_angle
				a_start_angle := modulo (a_start_angle, 2 * pi)

				cos := cosine (start_angle)
				sin := sine (start_angle)

				r := sqrt ((b ^ 2 * a ^ 2) / (b ^ 2 * cos ^ 2 + a ^ 2 * sin ^ 2))

			 	val_x := r * cos
			 	val_y := r * sin

				cphi := cosine (phi)
				sphi := sine (phi)

				start_x := xcen + (val_x * cphi - val_y * sphi).truncated_to_integer
				start_y := ycen - (val_x * sphi + val_y * cphi).truncated_to_integer

				an_end_angle := a_start_angle + aperture
				an_end_angle := modulo (an_end_angle, 2 * pi)

				cos := cosine (start_angle + aperture)
				sin := sine (start_angle + aperture)

				r := sqrt ((b ^ 2 * a ^ 2) / (b ^ 2 * cos ^ 2 + a ^ 2 * sin ^ 2))

				val_x := r * cos
				val_y := r * sin

				end_x := xcen + (val_x * cphi - val_y * sphi).truncated_to_integer
				end_y := ycen - (val_x * sphi + val_y * cphi).truncated_to_integer

				drawable.draw_segment (xcen, ycen, start_x, start_y)
				drawable.draw_segment (xcen, ycen, end_x, end_y)
			end
		end

	fill_rotated_pie_slice (xcen, ycen, a, b: INTEGER; phi, start_angle, aperture: DOUBLE) is
			-- Draw a pie slice from `start_angle' to `start_angle' + `aperture'.
			-- with center (`xcen',`ycen'), radius1 `a',
			-- radius2 `b' and rotation `phi' counter clockwise.
			-- `start_angle' is counter clockwise starting at 3 o'clock.
			-- Please see fill_rotated_ellipse for more informations.
		require
			a_larger_0: a > 0
			b_larger_0: b > 0
		local
			a_start_angle, an_end_angle: DOUBLE
			cos, sin: DOUBLE
			start_x, start_y, end_x, end_y: INTEGER

			val_x, val_y, r: DOUBLE

			c1, c2, c3, c4, c5, c6, v1, cphi, sphi, cphisqr, sphisqr: DOUBLE
 			d, asqr, bsqr: DOUBLE
 			xleft, xright: INTEGER
			y_top, y_bottom: INTEGER
			l_drawable: like drawable

			start_line_x, end_line_x: DOUBLE
			start_line_y, end_line_y: INTEGER
			end_y_inc, start_y_inc: INTEGER

			dx, dy: INTEGER
			m_start_inv: BOOLEAN
			m_start: DOUBLE
			m_end_inv: BOOLEAN
			m_end: DOUBLE
			bs, be, s, e: INTEGER
		do
			a_start_angle :=  phi + start_angle
			a_start_angle := modulo (a_start_angle, 2 * pi)

			cos := cosine (start_angle)
			sin := sine (start_angle)

			r := sqrt ((b ^ 2 * a ^ 2) / (b ^ 2 * cos ^ 2 + a ^ 2 * sin ^ 2))

		 	val_x := r * cos
		 	val_y := r * sin

			cphi := cosine (phi)
			sphi := sine (phi)

			start_x := xcen + (val_x * cphi - val_y * sphi).truncated_to_integer
			start_y := ycen - (val_x * sphi + val_y * cphi).truncated_to_integer

			an_end_angle := a_start_angle + aperture
			an_end_angle := modulo (an_end_angle, 2 * pi)

			cos := cosine (start_angle + aperture)
			sin := sine (start_angle + aperture)

			r := sqrt ((b ^ 2 * a ^ 2) / (b ^ 2 * cos ^ 2 + a ^ 2 * sin ^ 2))

			val_x := r * cos
			val_y := r * sin

			end_x := xcen + (val_x * cphi - val_y * sphi).truncated_to_integer
			end_y := ycen - (val_x * sphi + val_y * cphi).truncated_to_integer

			cphisqr := cphi * cphi
			sphisqr := sphi * sphi
			asqr := a * a
			bsqr := b * b

			c1 := (cphisqr / asqr) + (sphisqr / bsqr)
			c2 := ((cphi * sphi / asqr) - (cphi * sphi / bsqr)) / c1
			c3 := (bsqr * cphisqr) + (asqr * sphisqr)
			c4 := a * b / c3
			c5 := 0
			v1 := c4 * c4
			c6 := 2 * v1
			c3 := c3 * v1 - v1

			dx := start_x - xcen
			dy := start_y - ycen
			if dy < 0 then
				start_y_inc := -1
			else
				start_y_inc := 1
			end
			if dy = 0 then
				m_start_inv := True
			else
				m_start := dx / dy * start_y_inc
				m_start_inv := False
			end

			dx := end_x - xcen
			dy := end_y - ycen
			if dy < 0 then
				end_y_inc := -1
			else
				end_y_inc := 1
			end
			if dy = 0 then
				m_end_inv := True
			else
				m_end := dx / dy * end_y_inc
				m_end_inv := False
			end

			from
				l_drawable := drawable
			 	l_drawable.set_line_width (2)
			 	y_top := ycen
			 	y_bottom := ycen
			 	start_line_x := xcen
			 	start_line_y := ycen
			 	end_line_x := xcen
			 	end_line_y := ycen
			until
			 	c3 < 0
			loop
				d := sqrt (c3)
				xleft := (c5 - d).truncated_to_integer
				xright := (c5 + d).truncated_to_integer

				-- top fill line
				bs := xcen + xright
				be := xcen + xleft
				s := start_line_x.rounded
				e := end_line_x.rounded
				if m_end_inv and then start_y < ycen then
					if end_x > xcen then
						l_drawable.draw_segment (bs, y_top, be, y_top)
					end
				elseif m_start_inv and end_y < ycen then
					if start_x < xcen then
						l_drawable.draw_segment (bs, y_top, be, y_top)
					end
				elseif end_line_y = y_top and then start_line_y = y_top and then s < e then
					-- cut with e and s and s is left from e
					-- draw e -> s
					if not ((s >= bs and then e >= bs) or else (s <= be and then e <= be)) then
						if e <= bs then
							bs := e
						end
						if s >= be then
							be := s
						end
						l_drawable.draw_segment (bs, y_top, be, y_top)
					end
				elseif end_line_y = y_top and then start_line_y = y_top and then s = e then
					-- cut with s and e and s and e are on the same position
					if start_x >= end_x and end_y > ycen and start_y > ycen then
						l_drawable.draw_segment (be, y_top, bs, y_top)
					end
				elseif end_line_y = y_top or else start_line_y = y_top then
					-- cut with e or s or both but then s is right from e
					if start_line_y = y_top and then s < bs then
						-- draw bs -> s
						if s >= be then
							l_drawable.draw_segment (s, y_top, bs, y_top)
						else
							l_drawable.draw_segment (be, y_top, bs, y_top)
						end
					end
					if end_line_y = y_top and then e > be then
						-- draw e -> be
						if e <= bs then
							l_drawable.draw_segment (e, y_top, be, y_top)
						else
							l_drawable.draw_segment (bs, y_top, be, y_top)
						end
					end
				elseif start_line_x <= end_line_x then
					-- cut with none
					-- draw bs -> be
					l_drawable.draw_segment (bs, y_top, be, y_top)
				end

				-- top fill line
				bs := xcen - xright + 1
				be := xcen - xleft
				s := start_line_x.rounded
				e := end_line_x.rounded
				if m_end_inv and then start_y >= ycen then
					if end_x < xcen then
						l_drawable.draw_segment (bs, y_bottom , be, y_bottom )
					end
				elseif m_start_inv and end_y >= ycen then
					if start_x > xcen then
						l_drawable.draw_segment (bs, y_bottom, be, y_bottom)
					end
				elseif end_line_y = y_bottom and then start_line_y = y_bottom and then s > e then
					-- cut with e and s and s is right from e
					-- draw e -> s
					if e < be and s > bs then

						if e >= bs then
							bs := e
						end
						if s <= be then
							be := s
						end
						l_drawable.draw_segment (bs, y_bottom, be, y_bottom)
					end
				elseif end_line_y = y_bottom and then start_line_y = y_bottom and then s = e then
					-- cut with s and e and s and e are on the same position
					if start_x <= end_x and then end_y + 1 < ycen and then start_y < ycen then
						l_drawable.draw_segment (be, y_bottom, bs, y_bottom)
					end
				elseif end_line_y = y_bottom or else start_line_y = y_bottom then
					-- cut with e or s or both but then s is left from e
					if start_line_y = y_bottom and then s > bs then
						-- draw be -> s
						if s <= be then
							l_drawable.draw_segment (s, y_bottom, bs, y_bottom)
						else
							l_drawable.draw_segment (be, y_bottom, bs, y_bottom)
						end
					end
					if end_line_y = y_bottom and then e < be then
						-- draw e -> be
						if e >= bs then
							l_drawable.draw_segment (e, y_bottom, be, y_bottom)
						else
							l_drawable.draw_segment (bs, y_bottom, be, y_bottom)
						end
					end
				elseif start_line_x >= end_line_x then
					-- cut with none
					-- draw bs -> be
					l_drawable.draw_segment (bs, y_bottom, be, y_bottom)
				end

				c5 := c5 + c2
				v1 := v1 + c6
				c3 := c3 - v1
			 	y_top := y_top + 1
			 	y_bottom := y_bottom - 1

			 	if not m_start_inv then
					start_line_y := start_line_y + start_y_inc
					start_line_x := start_line_x + m_start
				end

				if not m_end_inv then
					end_line_y := end_line_y + end_y_inc
					end_line_x := end_line_x + m_end
				end

				check
					not m_start_inv implies (y_top = start_line_y or y_bottom = start_line_y)
					not m_end_inv implies (y_top = end_line_y or y_bottom = end_line_y)
				end
		 	end

		end

	inside (x, y: INTEGER start_angle, end_angle: DOUBLE): BOOLEAN is
			-- Does the line (0,0) - (`x', `y') lie between `start_angle' and `end_angle'?
		local
			an_angle: DOUBLE
		do
			an_angle := line_angle (0, 0, x, -y)
			if start_angle < end_angle then
				Result := an_angle >= start_angle and an_angle <= end_angle
			else
				Result := an_angle >= start_angle or an_angle <= end_angle
			end
		end


invariant
	drawable_not_void: drawable /= Void

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




end -- class EV_MODEL_DRAWER

