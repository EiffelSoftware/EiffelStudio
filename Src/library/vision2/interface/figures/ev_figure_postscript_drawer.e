indexing
	description:
		"Class for drawing of figures to postscript."
	status: "See notice at end of class"
	keywords: "figure, primitives, drawing, postscript" 
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POSTSCRIPT_DRAWER

inherit
	EV_FIGURE_DRAWING_ROUTINES

	EV_POSTSCRIPT_PAGE_CONSTANTS

feature -- Figure drawing

	--| FIXME No figure drawing routines have support for the orientation attribute.

	draw_figure_arc (arc: EV_FIGURE_ARC) is
			-- Draw a standard representation of `arc' to the canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			cx, cy, w, h: INTEGER
		do
			if arc.is_show_requested then
				add_ps ("%%Drawing PS Figure Arc")
				add_ps ("gsave")
				m := arc.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				w := m.integer_item (3)
				h := m.integer_item (4)
				translate_to (cx + (w//2), (point_height-(cy + (h//2))))
				append_line_styles (arc)
				add_ps ("1 " + (h / w).out + " scale")
				add_ps (arc.foreground_color.out + " setrgbcolor")
				draw_arc (w//2, ((arc.start_angle * 180) / Pi).rounded, (((arc.aperture + arc.start_angle) * 180) / Pi).rounded)
				add_ps ("stroke")
				add_ps ("grestore")
			end
		end

	draw_figure_dot (dot: EV_FIGURE_DOT) is
			-- Draw a standard representation of `dot' to the canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER]
			cx, cy, r: INTEGER
		do
			if dot.is_show_requested then
				add_ps ("%%Drawing PS Figure Dot")
				add_ps ("gsave")
				m := dot.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				r := m.integer_item (3)
				translate_to (cx, (point_height-cy))
				append_line_styles (dot)
				add_ps ("1 1 scale")
				add_ps (dot.foreground_color.out + " setrgbcolor")
				draw_arc (r, 0, 360)
				add_ps ("fill")
				add_ps ("grestore")
			end
		end

	draw_figure_ellipse (ellipse: EV_FIGURE_ELLIPSE) is
			-- Draw a standard representation of `ellipse' to the canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			cx, cy, w, h: INTEGER
		do
			if ellipse.is_show_requested then
				add_ps ("%%Drawing PS Figure Ellipse")
				add_ps ("gsave")
				m := ellipse.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				w := m.integer_item (3)
				h := m.integer_item (4)
				translate_to (cx + (w // 2), (point_height-(cy + (h //2))))
				append_line_styles (ellipse)
				add_ps ("1 " + (h / w).out + " scale")
				if ellipse.is_filled then
					add_ps (ellipse.background_color.out + " setrgbcolor")
					draw_arc (w // 2, 0, 360)
					add_ps ("fill")
				end
				add_ps (ellipse.foreground_color.out + " setrgbcolor")
				draw_arc (w // 2, 0, 360)
				add_ps ("stroke")
				add_ps ("grestore")
			end
		end

	draw_figure_equilateral (eql: EV_FIGURE_EQUILATERAL) is
			-- Draw a standard representation of `eql' to the canvas.
		do
			if eql.is_show_requested then
				add_ps ("%%Drawing PS Figure Equilateral")
				if eql.is_filled then
					start_drawing_polygon (eql, True)
					draw_polygon (eql.polygon_array.linear_representation)
					finish_drawing_polygon (True)
				end
				start_drawing_polygon (eql, False)
				draw_polygon (eql.polygon_array.linear_representation)
				finish_drawing_polygon (False)
			end
		end

	draw_figure_line (line: EV_FIGURE_LINE) is
			-- Draw a standard representation of `line' to the canvas.
		do
			if line.is_show_requested then
				add_ps ("%%Drawing PS Figure Line")
				draw_polyline (line, False)
				if line.is_start_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, line.start_arrow.i_th_point (1),
							line.start_arrow.i_th_point (2), line.start_arrow.i_th_point (3))
				end
				if line.is_end_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, line.end_arrow.i_th_point (1),
							line.end_arrow.i_th_point (2), line.end_arrow.i_th_point (3))
				end
			end
		end

	draw_figure_picture (picture: EV_FIGURE_PICTURE) is
			-- Draw a standard representation of `picture' to the canvas.
		local
			hex_string: STRING
			pixmap_width, pixmap_height, i: INTEGER
		do
			if picture.is_show_requested then 
				add_ps ("%%Drawing PS Figure Picture")
				add_ps ("gsave")
				translate_to (picture.point.x_abs, point_height-picture.point.y_abs-picture.height)
				pixmap_width := picture.pixmap.width
				pixmap_height := picture.pixmap.height
				add_ps (pixmap_width.out + " " + pixmap_height.out + " scale")
				hex_string := picture.pixmap.implementation.raw_image_data.rgb_hex_representation
				add_ps ("/pic_str " + pixmap_width.out + " string def")
				add_ps (pixmap_width.out + " " + pixmap_height.out + " 8 [" + pixmap_width.out + " 0 0 " + (-pixmap_height).out
					+ " 0 " + pixmap_height.out + "] {currentfile pic_str readhexstring pop} false 3 colorimage")
				from
					i := 255
				until
					i + 255 > hex_string.count
				loop
					hex_string.insert ("%N", i + 1)
					i := i + 256
				end
				add_ps (hex_string)
				add_ps ("grestore")
			end
		end

	draw_figure_pie_slice (slice: EV_FIGURE_PIE_SLICE) is
			-- Draw a standard representation of `slice' to the canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			cx, cy, w, h: INTEGER
		do
			if slice.is_show_requested then
				m := slice.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				w := m.integer_item (3)
				h := m.integer_item (4)
				add_ps ("%%Drawing PS Figure Pie Slice%N")
				add_ps ("gsave")
				if slice.is_filled then
					translate_to (cx + (w // 2), point_height-(cy + (h // 2)))
					add_ps (slice.background_color.out + " setrgbcolor")
					draw_pie_slice (h, w, slice.line_width, ((slice.start_angle * 180) / Pi).rounded, ((slice.aperture * 180) / Pi).rounded, slice.dashed_line_style, True)
					add_ps ("gsave")
				end
				translate_to (cx + (w // 2), point_height-(cy + (h // 2)))
				add_ps (slice.foreground_color.out + " setrgbcolor")
				draw_pie_slice (h, w, slice.line_width, ((slice.start_angle * 180) / Pi).rounded, ((slice.aperture * 180) / Pi).rounded, slice.dashed_line_style, False)
			end
		end

	draw_figure_polygon (polygon: EV_FIGURE_POLYGON) is
			-- Draw a standard representation of `polygon' to the canvas.
		do
			if polygon.is_show_requested then
				add_ps ("%%Drawing PS Figure Polygon")
				if polygon.is_filled then
					start_drawing_polygon (polygon, True)
					draw_polygon (polygon.point_array.linear_representation)
					finish_drawing_polygon (True)
				end
				start_drawing_polygon (polygon, False)
				draw_polygon (polygon.point_array.linear_representation)
				finish_drawing_polygon (False)
			end
		end

	draw_figure_polyline (line: EV_FIGURE_POLYLINE) is
			-- Draw a standard representation of `polyline' to the canvas.
		do
			if line.is_show_requested then
				add_ps ("%%Drawing PS Figure Polyline")
				draw_polyline (line, line.is_closed)
				if line.is_start_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, line.start_arrow.i_th_point (1),
							line.start_arrow.i_th_point (2), line.start_arrow.i_th_point (3))
				end
				if line.is_end_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, line.end_arrow.i_th_point (1),
							line.end_arrow.i_th_point (2), line.end_arrow.i_th_point (3))
				end
			end
		end

	draw_figure_rectangle (rectangle: EV_FIGURE_RECTANGLE) is
			-- Draw a standard representation of `rectangle' to the canvas.
		do
			if rectangle.is_show_requested then
				add_ps ("%%Drawing PS Figure Rectangle")
				if rectangle.is_filled then
					start_drawing_polygon (rectangle, True)
					draw_polygon (rectangle.polygon_array.linear_representation)
					finish_drawing_polygon (True)
				end
				start_drawing_polygon (rectangle, False)
				draw_polygon (rectangle.polygon_array.linear_representation)
				finish_drawing_polygon (False)
			end
		end

	draw_figure_rounded_rectangle (rounded_rectangle: EV_FIGURE_ROUNDED_RECTANGLE) is
			-- Draw a standard representation of `rounded_rectangle' to the canvas.
		do
			if rounded_rectangle.is_show_requested then
				add_ps ("%%Drawing PS Figure Rounded Rectangle")
				if rounded_rectangle.is_filled then
					start_drawing_polygon (rounded_rectangle, True)
					draw_polygon (rounded_rectangle.polygon_array.linear_representation)
					finish_drawing_polygon (True)
				end
				start_drawing_polygon (rounded_rectangle, False)
				draw_polygon (rounded_rectangle.polygon_array.linear_representation)
				finish_drawing_polygon (False)
			end
		end

	draw_figure_star (star: EV_FIGURE_STAR) is
			-- Draw a standard representation of `star' to the canvas.
		local
				coord_array: LINEAR [EV_COORDINATE]
		do
			if star.is_show_requested then
				coord_array := star.polygon_array.linear_representation
				add_ps ("%%Drawing PS Figure Star")
				add_ps ("gsave")
				translate_to (0, 0)
				add_ps ("newpath")
				append_line_styles (star)
				add_ps ("1 1 scale")
				add_ps (star.foreground_color.out + " setrgbcolor")
				from
					coord_array.start
					add_ps (star.center_point.x_abs.out + " " + (point_height-star.center_point.y_abs).out + " moveto")
				until
					coord_array.after
				loop
					add_ps (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " lineto")
					add_ps (star.center_point.x_abs.out + " " + (point_height-star.center_point.y_abs).out + " moveto")
					coord_array.forth
				end
				add_ps ("stroke")
				add_ps ("grestore")
			end
		end

	draw_figure_text (text_figure: EV_FIGURE_TEXT) is
			-- Draw a standard representation of `text_figure' to the canvas.
		local
			font_name, font_style: STRING
		do
			if text_figure.is_show_requested then
				add_ps ("%%Drawing PS Figure Text")
				add_ps ("gsave")
				translate_to (0, 0)
				add_ps ("1 1 scale")
				add_ps (text_figure.foreground_color.out + " setrgbcolor")
				if text_figure.font.name.is_equal ("times") then
					font_name := "Times"
				elseif text_figure.font.name.is_equal ("helvetica") then
					font_name := "Helvetica"
				elseif text_figure.font.name.is_equal ("courier") then
					font_name := "Courier"
				elseif text_figure.font.name.is_equal ("system") then
					font_name := "System"
				else
					font_name := "Times"
				end
				font_style := ""
				if text_figure.font.weight = 8 then
					font_style.append ("Bold")
				end
				if font_name.is_equal ("Times") then
					if text_figure.font.shape = 11 then
						font_style.append ("Italic")
					end
				else
					if text_figure.font.shape = 11 then
						font_style.append ("Oblique")
					end
				end
				if font_style.count = 0 then
					font_style.append ("Roman")
				end
				add_ps ("/" + font_name.out + "-" + font_style.out + " findfont")
				add_ps (text_figure.font.height.out + " scalefont")
				add_ps ("setfont")
				add_ps (text_figure.point.x_abs.out + " " + (point_height-text_figure.point.y_abs-text_figure.font.ascent).out + " moveto")
				add_ps ("(" + text_figure.text + ") show")
				add_ps ("grestore")
			end
		end

feature -- Access

	postscript_result: STRING

	point_width: INTEGER

	point_height: INTEGER

	left_margin: INTEGER

	bottom_margin: INTEGER

feature -- Status setting

	set_margins (a_left_margin, a_bottom_margin: INTEGER) is
			-- Set the `left' and `bottom' margins to `a_left_margin'
			-- and `a_bottom_margin'.
			--| FIXME Requires pre- and post-conditions.
		do
			left_margin := a_left_margin
			bottom_margin := a_bottom_margin
		end

	set_page_size (a_size: INTEGER; landscape: BOOLEAN) is
			-- Set the horizontal and vertical dimensions of the page.
		do
			point_width := page_width (a_size, landscape) - (left_margin*2)
			point_height := page_height (a_size, landscape) - (bottom_margin*2)
		end

feature {NONE} -- Implementation

	add_ps (a_code: STRING) is
			-- Add `a_code' to postscript data.
		do
			postscript_result.append (a_code + "%N")
		end

	append_line_styles (a_figure: EV_ATOMIC_FIGURE) is
			-- Add postscript code for the dashed line style and line width.
		do
			if a_figure.dashed_line_style then
				add_ps ("[3] 0 setdash")
			else
				add_ps ("[] 0 setdash")
			end
			add_ps (a_figure.line_width.out + " setlinewidth")
		end

	translate_to (a_x, a_y: INTEGER) is
		do
			add_ps (a_x.out + " " + a_y.out + " " + "translate")
		end

	draw_arc (a_radius, start_angle, end_angle: INTEGER) is
		do
			
			add_ps ("0 0 "+a_radius.out+" " + start_angle.out + " " + end_angle.out + " arc")
		end

	draw_pie_slice (a_h, a_w, a_line_width, start_angle, end_angle: INTEGER; dashed, filled: BOOLEAN) is
		do
			add_ps ("newpath")
			if dashed then
				add_ps ("[3] 0 setdash")
			else
				add_ps ("[] 0 setdash")
			end
			add_ps (a_line_width.out + " setlinewidth")
			if (a_w > a_h) then
				add_ps ("1 " + (a_h / a_w).out + " scale")
			else
				add_ps ((a_w / a_h).out + " 1 scale")
			end
			add_ps ("0 0 moveto")
			draw_arc (a_h // 2, start_angle, end_angle)
			add_ps ("closepath")
			if filled then
				add_ps ("fill")
			else
				add_ps ("stroke")
			end
			add_ps ("grestore")
		end

	start_drawing_polygon (a_figure: EV_CLOSED_FIGURE; filled: BOOLEAN) is
		do
			add_ps ("gsave")
			translate_to (0, 0)
			add_ps ("newpath")
			append_line_styles (a_figure)
			add_ps ("1 1 scale")
			if filled then
				add_ps (a_figure.background_color.out + " setrgbcolor")
			else
				add_ps (a_figure.foreground_color.out + " setrgbcolor")
			end
		end

	draw_polygon (coord_array: LINEAR [EV_COORDINATE]) is
		do
			from
				coord_array.start
				add_ps (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " moveto")
				coord_array.forth
			until
				coord_array.after
			loop
				add_ps (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " lineto")
				coord_array.forth
			end
		end

	finish_drawing_polygon (filled: BOOLEAN) is
		do
			add_ps ("closepath")
			if filled then
				add_ps ("eofill")
			else
				add_ps ("stroke")
			end
			add_ps ("grestore")
		end

	draw_polyline (a_polyline: EV_ATOMIC_FIGURE; closed: BOOLEAN) is
		local
			coord_array: LINEAR [EV_COORDINATE]
		do
			coord_array := a_polyline.point_array.linear_representation
			add_ps ("gsave")
			translate_to (0, 0)
			add_ps ("newpath")
			append_line_styles (a_polyline)
			add_ps ("1 1 scale")
			add_ps (a_polyline.foreground_color.out + " setrgbcolor")
			from
				coord_array.start
				add_ps (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " moveto")
				coord_array.forth
			until
				coord_array.after
			loop
				add_ps (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " lineto")
				coord_array.forth
			end
			if closed then
				add_ps ("closepath")
			end
			add_ps ("stroke")
			add_ps ("grestore")
		end

	draw_arrowhead (a_color, a_line_width: STRING; point1, point2, point3: EV_RELATIVE_POINT) is
		do
			add_ps ("%%Draw arrowhead")
			add_ps ("gsave")
			translate_to (0, 0)
			add_ps ("newpath")
			add_ps (a_line_width.out + " setlinewidth")
			add_ps ("1 1 scale")
			add_ps (a_color.out + " setrgbcolor")
			add_ps (point1.x_abs.out + " " + (point_height-point1.y_abs).out + " moveto")
			add_ps (point2.x_abs.out + " " + (point_height-point2.y_abs).out + " lineto")
			add_ps (point3.x_abs.out + " " + (point_height-point3.y_abs).out + " lineto")
			add_ps ("closepath")
			add_ps ("fill")
			add_ps ("grestore")
		end

end -- class EV_FIGURE_POSTSCRIPT_DRAWER

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
