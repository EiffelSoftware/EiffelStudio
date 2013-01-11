note
	description:
		"Class for drawing of figures to postscript."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, primitives, drawing, postscript"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POSTSCRIPT_DRAWER

inherit
	EV_FIGURE_DRAWING_ROUTINES

	EV_POSTSCRIPT_PAGE_CONSTANTS

	EV_ANY_HANDLER

feature -- Figure drawing

	--| FIXME No figure drawing routines have support for the orientation attribute.

	draw_figure_arc (arc: EV_FIGURE_ARC)
			-- Draw standard representation of `arc' to canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			cx, cy, w, h: INTEGER
		do
			if arc.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Arc")
				add_ps_line ("gsave")
				m := arc.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				w := m.integer_item (3)
				h := m.integer_item (4)
				translate_to (cx + (w//2), (point_height-(cy + (h//2))))
				append_line_styles (arc)
				add_ps_line ("1 " + (h / w).out + " scale")
				add_ps_line (arc.foreground_color.out + " setrgbcolor")
				draw_arc (w//2, ((arc.start_angle * 180) / Pi).rounded, (((arc.aperture + arc.start_angle) * 180) / Pi).rounded)
				add_ps_line ("stroke")
				add_ps_line ("grestore")
			end
		end

	draw_figure_dot (dot: EV_FIGURE_DOT)
			-- Draw standard representation of `dot' to canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER]
			cx, cy, r: INTEGER
		do
			if dot.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Dot")
				add_ps_line ("gsave")
				m := dot.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				r := m.integer_item (3)
				translate_to (cx, (point_height-cy))
				append_line_styles (dot)
				add_ps_line ("1 1 scale")
				add_ps_line (dot.foreground_color.out + " setrgbcolor")
				draw_arc (r, 0, 360)
				add_ps_line ("fill")
				add_ps_line ("grestore")
			end
		end

	draw_figure_ellipse (ellipse: EV_FIGURE_ELLIPSE)
			-- Draw standard representation of `ellipse' to canvas.
		local
			m: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			cx, cy, w, h: INTEGER
		do
			if ellipse.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Ellipse")
				add_ps_line ("gsave")
				m := ellipse.metrics
				cx := m.integer_item (1)
				cy := m.integer_item (2)
				w := m.integer_item (3)
				h := m.integer_item (4)
				translate_to (cx + (w // 2), (point_height-(cy + (h //2))))
				append_line_styles (ellipse)
				add_ps_line ("1 " + (h / w).out + " scale")
				if ellipse.is_filled and then attached ellipse.background_color as l_background_color then
					add_ps_line (l_background_color.out + " setrgbcolor")
					draw_arc (w // 2, 0, 360)
					add_ps_line ("fill")
				end
				add_ps_line (ellipse.foreground_color.out + " setrgbcolor")
				draw_arc (w // 2, 0, 360)
				add_ps_line ("stroke")
				add_ps_line ("grestore")
			end
		end

	draw_figure_equilateral (eql: EV_FIGURE_EQUILATERAL)
			-- Draw standard representation of `eql' to canvas.
		do
			if eql.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Equilateral")
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

	draw_figure_line (line: EV_FIGURE_LINE)
			-- Draw standard representation of `line' to canvas.
		do
			if line.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Line")
				draw_polyline (line, False)
				if line.is_start_arrow and then attached line.start_arrow as l_start_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, l_start_arrow.i_th_point (1),
							l_start_arrow.i_th_point (2), l_start_arrow.i_th_point (3))
				end
				if line.is_end_arrow and then attached line.end_arrow as l_end_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, l_end_arrow.i_th_point (1),
							l_end_arrow.i_th_point (2), l_end_arrow.i_th_point (3))
				end
			end
		end

	draw_figure_picture (picture: EV_FIGURE_PICTURE)
			-- Draw standard representation of `picture' to canvas.
		local
			hex_string: STRING
			pixmap_width, pixmap_height, i: INTEGER
		do
			if picture.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Picture")
				add_ps_line ("gsave")
				translate_to (picture.point.x_abs, point_height-picture.point.y_abs-picture.height)
				pixmap_width := picture.pixmap.width
				pixmap_height := picture.pixmap.height
				add_ps_line (pixmap_width.out + " " + pixmap_height.out + " scale")
				hex_string := picture.pixmap.implementation.raw_image_data.rgb_hex_representation
				add_ps_line ("/pic_str " + pixmap_width.out + " string def")
				add_ps_line (pixmap_width.out + " " + pixmap_height.out + " 8 [" + pixmap_width.out + " 0 0 " + (-pixmap_height).out
					+ " 0 " + pixmap_height.out + "] {currentfile pic_str readhexstring pop} false 3 colorimage")
				from
					i := 255
				until
					i + 255 > hex_string.count
				loop
					hex_string.insert_string ("%N", i + 1)
					i := i + 256
				end
				add_ps_line (hex_string)
				add_ps_line ("grestore")
			end
		end

	draw_figure_pie_slice (slice: EV_FIGURE_PIE_SLICE)
			-- Draw standard representation of `slice' to canvas.
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
				add_ps_line ("%%Drawing PS Figure Pie Slice%N")
				add_ps_line ("gsave")
				if slice.is_filled and then attached slice.background_color as l_background_color then
					translate_to (cx + (w // 2), point_height-(cy + (h // 2)))
					add_ps_line (l_background_color.out + " setrgbcolor")
					draw_pie_slice (h, w, slice.line_width, ((slice.start_angle * 180) / Pi).rounded, ((slice.aperture * 180) / Pi).rounded, slice.dashed_line_style, True)
					add_ps_line ("gsave")
				end
				translate_to (cx + (w // 2), point_height-(cy + (h // 2)))
				add_ps_line (slice.foreground_color.out + " setrgbcolor")
				draw_pie_slice (h, w, slice.line_width, ((slice.start_angle * 180) / Pi).rounded, ((slice.aperture * 180) / Pi).rounded, slice.dashed_line_style, False)
			end
		end

	draw_figure_polygon (polygon: EV_FIGURE_POLYGON)
			-- Draw standard representation of `polygon' to canvas.
		do
			if polygon.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Polygon")
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

	draw_figure_polyline (line: EV_FIGURE_POLYLINE)
			-- Draw standard representation of `polyline' to canvas.
		do
			if line.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Polyline")
				draw_polyline (line, line.is_closed)
				if line.is_start_arrow and then attached line.start_arrow as l_start_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, l_start_arrow.i_th_point (1),
							l_start_arrow.i_th_point (2), l_start_arrow.i_th_point (3))
				end
				if line.is_end_arrow and then attached line.end_arrow as l_end_arrow then
					draw_arrowhead (line.foreground_color.out, line.line_width.out, l_end_arrow.i_th_point (1),
							l_end_arrow.i_th_point (2), l_end_arrow.i_th_point (3))
				end
			end
		end

	draw_figure_rectangle (rectangle: EV_FIGURE_RECTANGLE)
			-- Draw standard representation of `rectangle' to canvas.
		do
			if rectangle.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Rectangle")
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

	draw_figure_rounded_rectangle (rounded_rectangle: EV_FIGURE_ROUNDED_RECTANGLE)
			-- Draw standard representation of `rounded_rectangle' to canvas.
		do
			if rounded_rectangle.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Rounded Rectangle")
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

	draw_figure_star (star: EV_FIGURE_STAR)
			-- Draw standard representation of `star' to canvas.
		local
				coord_array: LINEAR [EV_COORDINATE]
		do
			if star.is_show_requested then
				coord_array := star.polygon_array.linear_representation
				add_ps_line ("%%Drawing PS Figure Star")
				add_ps_line ("gsave")
				translate_to (0, 0)
				add_ps_line ("newpath")
				append_line_styles (star)
				add_ps_line ("1 1 scale")
				add_ps_line (star.foreground_color.out + " setrgbcolor")
				from
					coord_array.start
					add_ps_line (star.center_point.x_abs.out + " " + (point_height-star.center_point.y_abs).out + " moveto")
				until
					coord_array.after
				loop
					add_ps_line (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " lineto")
					add_ps_line (star.center_point.x_abs.out + " " + (point_height-star.center_point.y_abs).out + " moveto")
					coord_array.forth
				end
				add_ps_line ("stroke")
				add_ps_line ("grestore")
			end
		end

	draw_figure_text (text_figure: EV_FIGURE_TEXT)
			-- Draw standard representation of `text_figure' to canvas.
		local
			font_name, font_style: STRING_32
		do
			if text_figure.is_show_requested then
				add_ps_line ("%%Drawing PS Figure Text")
				add_ps_line ("gsave")
				translate_to (0, 0)
				add_ps_line ("1 1 scale")
				add_ps_line (text_figure.foreground_color.out + " setrgbcolor")
				font_name := text_figure.font.name.twin
				font_name.put (font_name.item (1).as_upper, 1)
				create font_style.make (10)
				if text_figure.font.weight = 8 then
					font_style.append_string_general ("Bold")
				end
				if font_name.same_string_general ("Times") then
					if text_figure.font.shape = 11 then
						font_style.append_string_general ("Italic")
					end
				else
					if text_figure.font.shape = 11 then
						font_style.append_string_general ("Oblique")
					end
				end
				if font_style.count = 0 then
					font_style.append_string_general ("Roman")
				end
				add_ps_line ("/" + font_name + "-" + font_style + " findfont")
				add_ps_line (text_figure.font.height.out + " scalefont")
				add_ps_line ("setfont")
				add_ps_line (text_figure.point.x_abs.out + " " + (point_height-text_figure.point.y_abs-text_figure.font.ascent).out + " moveto")
				add_ps_line ("(")
				add_ps_line (text_figure.text)
				add_ps_line (") show")
				add_ps_line ("grestore")
			end
		end

feature -- Access

	postscript_result: detachable STRING

	point_width: INTEGER

	point_height: INTEGER

	left_margin: INTEGER

	bottom_margin: INTEGER

feature -- Status setting

	set_margins (a_left_margin, a_bottom_margin: INTEGER)
			-- Set `left' and `bottom' margins to `a_left_margin'
			-- and `a_bottom_margin'.
			--| FIXME Requires pre- and post-conditions.
		do
			left_margin := a_left_margin
			bottom_margin := a_bottom_margin
		end

	set_page_size (a_size: INTEGER; landscape: BOOLEAN)
			-- Set horizontal and vertical dimensions of page.
		do
			point_width := page_width (a_size, landscape) - (left_margin*2)
			point_height := page_height (a_size, landscape) - (bottom_margin*2)
		end

feature {NONE} -- Implementation

	add_ps_line (a_code: READABLE_STRING_GENERAL)
			-- Add `a_code' to postscript data.
		require
			a_code_not_void: a_code /= Void
		local
			l_ps_result: like postscript_result
		do
			l_ps_result := postscript_result
			check l_ps_result /= Void end
			l_ps_result.append (a_code.to_string_8)
			l_ps_result.append_character ('%N')
		end

	add_ps_string (a_code: READABLE_STRING_GENERAL)
			-- Add `a_code' to postscript data.
		require
			a_code_not_void: a_code /= Void
		local
			l_ps_result: like postscript_result
		do
			l_ps_result := postscript_result
			check l_ps_result /= Void end
			l_ps_result.append (a_code.to_string_8)
		end

	append_line_styles (a_figure: EV_ATOMIC_FIGURE)
			-- Add postscript code for dashed line style and line width.
		do
			if a_figure.dashed_line_style then
				add_ps_line ("[3] 0 setdash")
			else
				add_ps_line ("[] 0 setdash")
			end
			add_ps_line (a_figure.line_width.out + " setlinewidth")
		end

	translate_to (a_x, a_y: INTEGER)
		do
			add_ps_line (a_x.out + " " + a_y.out + " " + "translate")
		end

	draw_arc (a_radius, start_angle, end_angle: INTEGER)
		do

			add_ps_line ("0 0 "+a_radius.out+" " + start_angle.out + " " + end_angle.out + " arc")
		end

	draw_pie_slice (a_h, a_w, a_line_width, start_angle, end_angle: INTEGER; dashed, filled: BOOLEAN)
		do
			add_ps_line ("newpath")
			if dashed then
				add_ps_line ("[3] 0 setdash")
			else
				add_ps_line ("[] 0 setdash")
			end
			add_ps_line (a_line_width.out + " setlinewidth")
			if (a_w > a_h) then
				add_ps_line ("1 " + (a_h / a_w).out + " scale")
			else
				add_ps_line ((a_w / a_h).out + " 1 scale")
			end
			add_ps_line ("0 0 moveto")
			draw_arc (a_h // 2, start_angle, end_angle)
			add_ps_line ("closepath")
			if filled then
				add_ps_line ("fill")
			else
				add_ps_line ("stroke")
			end
			add_ps_line ("grestore")
		end

	start_drawing_polygon (a_figure: EV_CLOSED_FIGURE; filled: BOOLEAN)
		do
			add_ps_line ("gsave")
			translate_to (0, 0)
			add_ps_line ("newpath")
			append_line_styles (a_figure)
			add_ps_line ("1 1 scale")
			if filled and then attached a_figure.background_color as l_background_color then
				add_ps_line (l_background_color.out + " setrgbcolor")
			else
				add_ps_line (a_figure.foreground_color.out + " setrgbcolor")
			end
		end

	draw_polygon (coord_array: LINEAR [EV_COORDINATE])
		do
			from
				coord_array.start
				add_ps_line (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " moveto")
				coord_array.forth
			until
				coord_array.after
			loop
				add_ps_line (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " lineto")
				coord_array.forth
			end
		end

	finish_drawing_polygon (filled: BOOLEAN)
		do
			add_ps_line ("closepath")
			if filled then
				add_ps_line ("eofill")
			else
				add_ps_line ("stroke")
			end
			add_ps_line ("grestore")
		end

	draw_polyline (a_polyline: EV_ATOMIC_FIGURE; closed: BOOLEAN)
		local
			coord_array: LINEAR [EV_COORDINATE]
		do
			coord_array := a_polyline.point_array.linear_representation
			add_ps_line ("gsave")
			translate_to (0, 0)
			add_ps_line ("newpath")
			append_line_styles (a_polyline)
			add_ps_line ("1 1 scale")
			add_ps_line (a_polyline.foreground_color.out + " setrgbcolor")
			from
				coord_array.start
				add_ps_line (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " moveto")
				coord_array.forth
			until
				coord_array.after
			loop
				add_ps_line (coord_array.item.x.out + " " + (point_height-coord_array.item.y).out + " lineto")
				coord_array.forth
			end
			if closed then
				add_ps_line ("closepath")
			end
			add_ps_line ("stroke")
			add_ps_line ("grestore")
		end

	draw_arrowhead (a_color, a_line_width: READABLE_STRING_GENERAL; point1, point2, point3: EV_RELATIVE_POINT)
		do
			add_ps_line ("%%Draw arrowhead")
			add_ps_line ("gsave")
			translate_to (0, 0)
			add_ps_line ("newpath")
			add_ps_string (a_line_width)
			add_ps_line (" setlinewidth")
			add_ps_line ("1 1 scale")
			add_ps_string (a_color)
			add_ps_line (" setrgbcolor")
			add_ps_line (point1.x_abs.out + " " + (point_height-point1.y_abs).out + " moveto")
			add_ps_line (point2.x_abs.out + " " + (point_height-point2.y_abs).out + " lineto")
			add_ps_line (point3.x_abs.out + " " + (point_height-point3.y_abs).out + " lineto")
			add_ps_line ("closepath")
			add_ps_line ("fill")
			add_ps_line ("grestore")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FIGURE_POSTSCRIPT_DRAWER





