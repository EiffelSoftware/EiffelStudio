indexing

	description: 
		"Single line used to draw relations";
	date: "$Date$";
	revision: "$Revision $"

class EC_SINGLE_LINE

inherit

	EC_LINE

	ONCES


creation

	make

feature -- Output

	draw is
			-- Draw a single line on drawing area
		local
			algorithm: ALGORITHM [EV_COORDINATES]
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				drawing.set_line_width (Resources.link_width);

				!! algorithm
				drawing.draw_polyline (algorithm.linked_list_to_array (points), false)
			end
		end; -- draw

	erase is
			-- Erase the single line drawn
		local
			algorithm: ALGORITHM [EV_COORDINATES]
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				drawing.set_foreground_color
						(Resources.get_color("drawing_background_color"))				drawing.set_line_width (Resources.link_width);
				!! algorithm
				drawing.draw_polyline (algorithm.linked_list_to_array (points), false)
			end

		end -- erase

end -- class EC_SINGLE_LINE
