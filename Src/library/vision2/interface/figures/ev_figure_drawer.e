indexing
	description: "EiffelVision figure drawer. Adapters that take %N%
		%a drawable (screen, drawing area or pixmap) and use %N%
		%it to draw the figures from the figure cluster in it."
	status: "See notice at end of class"
	keywords: "figures, primitives, drawing, line, point, ellipse" 
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_DRAWER

create
	make_with_drawable

feature {NONE} -- Initialization

	make_with_drawable (a_drawable: EV_DRAWABLE) is
			-- Initialize.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			drawable := a_drawable
		ensure
			assigned: drawable = a_drawable
		end

feature -- Access

	drawable: EV_DRAWABLE
			-- Drawable surface. (screen, drawing area or pixmap)

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

	--| FIXME For the Mswindows platform, it will definitely pay off
	--| to make lower level functions, since there is a brush and pen,
	--| hence there is no need to call two primitives for the closed figures.

	draw_figure_dot (dot: EV_FIGURE_DOT) is
			-- Draw a standard representation of `dot' to the canvas.
		require
			dot_not_void: dot /= Void
		do
			drawable.set_drawing_mode (dot.logical_function_mode)	
			drawable.set_foreground_color (dot.foreground_color)
			drawable.fill_ellipse (dot.point.x_abs, dot.point.y_abs,
				dot.line_width * 2, dot.line_width * 2)
		end

	draw_figure_line (line: EV_FIGURE_LINE) is
			-- Draw a standard representation of `line' to the canvas.
		require
			line_not_void: line /= Void
		do
			drawable.set_line_width (line.line_width)
			drawable.set_drawing_mode (line.logical_function_mode)	
			drawable.set_foreground_color (line.foreground_color)
			drawable.draw_segment (line.point_a.x_abs, line.point_a.y_abs,
				line.point_b.x_abs, line.point_b.y_abs)
		end

	draw_figure_arc (arc: EV_FIGURE_ARC) is
			-- Draw a standard representation of `arc' to the canvas.
		require
			arc_not_void: arc /= Void
		do
			drawable.set_line_width (arc.line_width)
			drawable.set_drawing_mode (arc.logical_function_mode)	
			drawable.set_foreground_color (arc.foreground_color)
			--| FIXME This is no arc! It's two lines!
			drawable.draw_polyline (arc.point_array, False)
		end

	draw_figure_polyline (polyline: EV_FIGURE_POLYLINE) is
			-- Draw a standard representation of `polyline' to the canvas.
		require
			polyline_not_void: polyline /= Void
		do
			drawable.set_line_width (polyline.line_width)
			drawable.set_drawing_mode (polyline.logical_function_mode)	
			drawable.set_foreground_color (polyline.foreground_color)
			drawable.draw_polyline (polyline.point_array, polyline.closed)
		end

	draw_figure_polygon (polygon: EV_FIGURE_POLYGON) is
			-- Draw a standard representation of `polygon' to the canvas.
		require
			polygon_not_void: polygon /= Void
		do
			drawable.set_line_width (polygon.line_width)
			drawable.set_drawing_mode (polygon.logical_function_mode)	
			if polygon.fill_color /= Void then
				drawable.set_foreground_color (polygon.fill_color)
				drawable.fill_polygon (polygon.point_array)
			end
			drawable.set_foreground_color (polygon.foreground_color)
			drawable.draw_polyline (polygon.point_array, True)
		end

	draw_figure_triangle (triangle: EV_FIGURE_TRIANGLE) is
			-- Draw a standard representation of `triangle' to the canvas.
		require
			triangle_not_void: triangle /= Void
		do
			drawable.set_line_width (triangle.line_width)
			drawable.set_drawing_mode (triangle.logical_function_mode)	
			if triangle.fill_color /= Void then
				drawable.set_foreground_color (triangle.fill_color)
				drawable.fill_polygon (triangle.point_array)
			end
			drawable.set_foreground_color (triangle.foreground_color)
			drawable.draw_polyline (triangle.point_array, True)
		end

	draw_figure_text (text_figure: EV_FIGURE_TEXT) is
			-- Draw a standard representation of `text_figure' to the canvas.
		require
			text_figure_not_void: text_figure /= Void
		do
			drawable.set_drawing_mode (text_figure.logical_function_mode)	
			drawable.set_font (text_figure.font)
			drawable.set_foreground_color (text_figure.foreground_color)
			drawable.draw_text (text_figure.point.x_abs, text_figure.point.y_abs, text_figure.text)
		end

	draw_figure_rectangle (rectangle: EV_FIGURE_RECTANGLE) is
			-- Draw a standard representation of `rectangle' to the canvas.
		require
			rectangle_not_void: rectangle /= Void
		local
			top, left: INTEGER
		do
			top := rectangle.point_a.y_abs.max (rectangle.point_b.y_abs)
			left := rectangle.point_a.x_abs.max (rectangle.point_b.x_abs)
			drawable.set_line_width (rectangle.line_width)
			drawable.set_drawing_mode (rectangle.logical_function_mode)	
			if rectangle.fill_color /= Void then
				drawable.set_foreground_color (rectangle.fill_color)
				if rectangle.orientation.radians = 0.0 then
					drawable.fill_rectangle (left, top, rectangle.width,
						rectangle.height)
				else
					drawable.fill_polygon (rectangle.polygon_array)
				end
			end
			drawable.set_foreground_color (rectangle.foreground_color)
			if rectangle.orientation.radians = 0.0 then
				drawable.draw_rectangle (left, top, rectangle.width,
					rectangle.height)
			else
				drawable.draw_polyline (rectangle.polygon_array, True)
			end
		end

	draw_figure_ellipse (ellipse: EV_FIGURE_ELLIPSE) is
			-- Draw a standard representation of `ellipse' to the canvas.
		require
			ellipse_not_void: ellipse /= Void
		local
			cx, cy, r1, r2: INTEGER
		do
			cx := (ellipse.point_a.x_abs + ellipse.point_b.x_abs) // 2
			cy := (ellipse.point_a.y_abs + ellipse.point_b.y_abs) // 2
			r2 := ((ellipse.point_a.x_abs - ellipse.point_b.x_abs) // 2).abs
			r1 := ((ellipse.point_a.y_abs - ellipse.point_b.y_abs) // 2).abs
			drawable.set_line_width (ellipse.line_width)
			drawable.set_drawing_mode (ellipse.logical_function_mode)	
			if ellipse.fill_color /= Void then
				drawable.set_foreground_color (ellipse.fill_color)
				drawable.fill_ellipse (cx, cy, r1, r2)
			end
			drawable.set_foreground_color (ellipse.foreground_color)
			drawable.draw_ellipse (cx, cy, r1, r2)
		end

	draw_figure_equilateral (eql: EV_FIGURE_EQUILATERAL) is
			-- Draw a standard representation of `eql' to the canvas.
		require
			eql_not_void: eql /= Void
		do
			drawable.set_line_width (eql.line_width)
			drawable.set_drawing_mode (eql.logical_function_mode)	
			if eql.fill_color /= Void then
				drawable.set_foreground_color (eql.fill_color)
				drawable.fill_polygon (eql.polygon_array)
			end
			drawable.set_foreground_color (eql.foreground_color)
			drawable.draw_polyline (eql.polygon_array, True)
		end

	draw_figure_pie_slice (slice: EV_FIGURE_PIE_SLICE) is
			-- Draw a standard representation of `slice' to the canvas.
		require
			slice_not_void: slice /= Void
		do
			check
				to_be_implemented: False
			end
		end

	draw_figure_picture (picture: EV_FIGURE_PICTURE) is
			-- Draw a standard representation of `picture' to the canvas.
		require
			picture_not_void: picture /= Void
		do
			drawable.draw_pixmap (picture.point.x_abs, picture.point.y_abs, picture.pixmap)
		end

invariant
	drawable_not_void: drawable /= Void

end -- class EV_FIGURE_DRAWER
