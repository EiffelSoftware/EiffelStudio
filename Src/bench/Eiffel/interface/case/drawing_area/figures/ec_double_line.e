indexing

	description: 
		"Double line used to draw client-supplier links.";
	date: "$Date$";
	revision: "$Revision $"

class EC_DOUBLE_LINE

inherit

	EC_LINE

	ONCES

creation
	
	make 

feature -- Output

	draw is
			-- Draw a double line on drawing area
		local
			algorithm: ALGORITHM [EV_COORDINATES]
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing)
				if System.uml_layout then
						-- actually draw only one line
						drawing.set_line_width (Resources.link_width);

						!! algorithm
						drawing.draw_polyline (algorithm.linked_list_to_array (points), false)
				else
					drawing.set_line_width ((Resources.link_apart + 2) *
								Resources.link_width);

					!! algorithm
					drawing.draw_polyline (algorithm.linked_list_to_array (points), false);
					erase_middle;
				end
			end
		end; -- draw

	erase_middle is
			-- Erase the middle of the line to give
			-- the double line effect.
		local
			algorithm: ALGORITHM [EV_COORDINATES]
		do
			if drawing.is_drawable then
					drawing.set_line_width (Resources.link_apart *
								Resources.link_width);
					drawing.set_foreground_color
								(Resources.drawing_bg_color);

					!! algorithm
					drawing.draw_polyline (algorithm.linked_list_to_array (points), false )
			end
		end

	erase is
			-- Erase double line drawn
		local
			algorithm: ALGORITHM [EV_COORDINATES]
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				drawing.set_foreground_color
							(Resources.drawing_bg_color);
				if System.uml_layout then
					drawing.set_line_width (Resources.link_width);
				else
					drawing.set_line_width ((Resources.link_apart + 2) *
							Resources.link_width);
				end

				!! algorithm
				drawing.draw_polyline (algorithm.linked_list_to_array (points), false)
			end
		end -- erase

end -- class EC_DOUBLE_LINE
