indexing
	description	: "Simple drawing program."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	DA_TEST

inherit
	EV_APPLICATION

	EV_DRAWABLE_CONSTANTS
		undefine
			default_create
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			a_color: EV_COLOR
			a_label: EV_LABEL
		do
				-- Create the container
			create my_container

			create my_pixmap
			my_pixmap.set_with_named_file ("car.png")

			initialize_drawing_operations			

			create da_direct
			da_direct.set_line_width (5)

			create da_paint
			da_paint.set_line_width (5)

			create my_separator
			create a_label.make_with_text ("<-- Direct Drawing%N%N%N Drawing via expose_actions --> ")
			my_separator.extend (a_label)

			my_container.extend (da_direct)
			my_container.extend (my_separator)
			my_container.extend (da_paint)

			my_container.disable_item_expand(my_separator)

			
				-- Add widgets to our window
			first_window.extend(my_container)

			idle_actions.extend (~on_idle_action)
			da_paint.expose_actions.extend (~on_paint)
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 Drawing Area example")
			Result.set_size (800, 400)
		end

feature {NONE} -- Graphical interface

	my_pixmap: EV_PIXMAP
 
	my_container: EV_HORIZONTAL_BOX
			-- Container that groups the da.

	my_separator: EV_HORIZONTAL_BOX
			-- Separator between the two da.

	da_direct: EV_DRAWING_AREA

	da_paint: EV_DRAWING_AREA

feature {NONE} -- Implementation
	
	on_paint(x, y, width, height: INTEGER) is
		do
			draw (da_paint, Dominant_blue)
		end

	on_idle_action is
		do
			draw (da_direct, Dominant_red)

			da_paint.redraw
			da_paint.flush
		end

	draw (da: EV_DRAWING_AREA; dominant_color: INTEGER) is
		local
			random_int: INTEGER
			drawing_primitive: PROCEDURE[DA_TEST,TUPLE]
		do
			random_int := (get_random_real * Number_drawing_operations).floor
			drawing_primitive := drawing_operations @ random_int

			da.set_foreground_color (get_random_color(dominant_color))
			da.set_line_width (get_random_int(10)+1)

			drawing_primitive.call([da])
		end

feature {NONE} -- Drawing Operations

	draw_polyline (da: EV_DRAWING_AREA) is
		local
			i: INTEGER
			ev_coord: EV_COORDINATES
			poly_coord: ARRAY [EV_COORDINATES]
			nb_summit: INTEGER
			poly_closed: BOOLEAN
			filled: BOOLEAN
		do
			nb_summit := get_random_int (10) + 2
			
			create poly_coord.make (0, nb_summit)

				-- Draw the rectangle on the direct Drawing Area
			from i := 0 until i > nb_summit loop
				create ev_coord.set (get_random_x(da), get_random_y(da))
				poly_coord.put (ev_coord, i)
				i := i + 1
			end

			filled := (get_random_int(2) = 1)
			if filled then
				da.fill_polygon (poly_coord)
			else
				poly_closed := (get_random_int(2) = 1)
				da.draw_polyline (poly_coord, poly_closed)
			end
		end

	draw_text (da: EV_DRAWING_AREA) is
		local
			a_font: EV_FONT
		do
			create a_font
			a_font.set_family (get_random_int(5)+1)
			a_font.set_weight (get_random_int(4)+6)
			a_font.set_shape (get_random_int(2)+10)
			a_font.set_height (get_random_int(40)+8)
			da.set_font (a_font)
			da.draw_text (
				get_random_x(da), 
				get_random_y(da),
				"Text"
				)
		end

	draw_point (da: EV_DRAWING_AREA) is
		do
			da.draw_point (
				get_random_x(da), get_random_y(da)
				)
		end

	draw_pixmap (da: EV_DRAWING_AREA) is
		local
			is_segment: BOOLEAN
		do
			da.draw_pixmap (
				get_random_x(da), 
				get_random_y(da),
				my_pixmap
				)
		end

	draw_line (da: EV_DRAWING_AREA) is
		local
			is_segment: BOOLEAN
		do
			is_segment := (get_random_int(2) = 1)

			if is_segment then
				da.draw_segment (
					get_random_x(da), get_random_y(da),
					get_random_x(da), get_random_y(da)
					)
			else
				da.draw_straight_line (
					get_random_x(da), get_random_y(da),
					get_random_x(da), get_random_y(da)
					)
			end
		end

	draw_ellipse (da: EV_DRAWING_AREA) is
		local
			filled: BOOLEAN
		do
			filled := (get_random_int(2) = 1)

			if filled then
				da.fill_ellipse (
					get_random_x(da), get_random_y(da),
					get_random_x(da)//2, get_random_y(da)//2
					)
			else
				da.draw_ellipse (
					get_random_x(da), get_random_y(da),
					get_random_x(da)//2, get_random_y(da)//2
					)
			end
		end

	draw_arc (da: EV_DRAWING_AREA) is
		local
			filled: BOOLEAN
			poly_closed: BOOLEAN
		do
			filled := (get_random_int(2) = 1)
			poly_closed := (get_random_int(2) = 1)

			if filled then
				da.fill_pie_slice (
					get_random_x(da), get_random_y(da),
					get_random_x(da)//2, get_random_y(da)//2,
					get_random_real * 2 * 3.14, get_random_real * 2 * 3.14
					)
			else
				if poly_closed then
					da.draw_pie_slice (
						get_random_x(da), get_random_y(da),
						get_random_x(da)//2, get_random_y(da)//2,
						get_random_real * 2 * 3.14, get_random_real * 2 * 3.14
						)
				else
					da.draw_arc (
						get_random_x(da), get_random_y(da),
						get_random_x(da)//2, get_random_y(da)//2,
						get_random_real * 2 * 3.14, get_random_real * 2 * 3.14
						)
				end
			end
		end

	draw_rectangle (da: EV_DRAWING_AREA) is
		local
			filled: BOOLEAN
			x1, x2, y1, y2: INTEGER
		do
			filled := (get_random_int(2) = 1)
			x1 := get_random_x(da)
			x2 := get_random_x(da)
			y1 := get_random_y(da)
			y2 := get_random_y(da)

			if filled then
				da.fill_rectangle (x1, y1, (x2-x1).abs, (y2-y1).abs)
			else
				da.draw_rectangle (x1, y1, (x2-x1).abs, (y2-y1).abs)
			end
		end

feature {NONE} -- Random Drawing 

	drawing_operations: ARRAY [PROCEDURE[DA_TEST,TUPLE]]
	
	initialize_drawing_operations is
		do
			create drawing_operations.make (0, Number_drawing_operations)
			drawing_operations.put (~draw_polyline, 0)
			drawing_operations.put (~draw_text, 1)
			drawing_operations.put (~draw_arc, 2)
			drawing_operations.put (~draw_point, 3)
			drawing_operations.put (~draw_ellipse, 4)
			drawing_operations.put (~draw_rectangle, 5)
			drawing_operations.put (~draw_pixmap, 6)
		end

feature {NONE} -- Random Implementation

	get_random_color(dominant_color: INTEGER): EV_COLOR is
		local
			random_real: REAL
			dark: BOOLEAN
		do
			dark := (get_random_int(2) = 1)
			random_real := get_random_real
			create Result.make_with_rgb (0, 0, 0)

			inspect dominant_color
			when Dominant_red then
				if dark then
					Result.set_red (random_real)
				else
					Result.set_red (1.0)
					Result.set_green (random_real)
					Result.set_blue (random_real)
				end

			when Dominant_blue then
				if dark then
					Result.set_blue (random_real)
				else
					Result.set_red (random_real)
					Result.set_green (random_real)
					Result.set_blue (1.0)
				end

			when Dominant_green then
				if dark then
					Result.set_green (random_real)
				else
					Result.set_red (random_real)
					Result.set_green (1.0)
					Result.set_blue (random_real)
				end

			end
		end

	get_random_x (da: EV_DRAWING_AREA): INTEGER is
		do
			Result := (get_random_real * da.width).floor
		end

	get_random_y (da: EV_DRAWING_AREA): INTEGER is
		do
			Result := (get_random_real * da.height).floor
		end

	random: RANDOM is
		once
			create Result.make
		end

	random_index: INTEGER

	get_random_real: REAL is
		do
			random_index := random_index + 1
			Result := random.real_i_th (random_index)
		end

	get_random_int (max_int: INTEGER): INTEGER is
		do
			Result := (get_random_real * max_int).floor
		end

feature {NONE} -- Constants

	Number_drawing_operations: INTEGER is 7
	
	Dominant_red, Dominant_blue, Dominant_green: INTEGER is unique

end -- class DRAWING_AREA_TEST

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

