indexing

	description: 
		"Triangle used to choice the direction of%
		%a link for drawing an angle";
	date: "$Date$";
	revision: "$Revision $"

class EC_ACTIVE_TRIANGLE

inherit

	EC_TRIANGLE

creation

	make

feature -- Setting

	set (headx, heady, size : INTEGER; angle : REAL; axex, axey : INTEGER) is
			-- Set triangle's coordinates
		do
			i_th (1).set (headx, heady);
			i_th (2).set (headx + size, heady + size);
			i_th (3).set (headx - size, heady + size);
			i_th (1).xyrotate (angle, axex, axey);
			i_th (2).xyrotate (angle, axex, axey);
			i_th (3).xyrotate (angle, axex, axey)
		end 

feature -- Update

	select_it is
			-- Fill the triangle
		require
			has_drawing : drawing /= void
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				interior.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				drawing.fill_polygon (Current)
			end
		end; -- select_it

	unselect is
			-- Unfill the arrow.
		require
			has_drawing: drawing /= void
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				interior.set_drawing_attributes (drawing);
				drawing.set_foreground_color
							(Resources.get_color("drawing_background_color"))
				drawing.set_line_width (1);
				drawing.fill_polygon (Current);
				path.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				drawing.draw_polyline (Current, true)
			end
		end -- unselect


end -- class EC_ACTIVE_TRIANGLE
