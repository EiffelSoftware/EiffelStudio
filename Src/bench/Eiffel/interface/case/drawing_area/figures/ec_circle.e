indexing

	description: 
		"Circle used to draw share feature of relations.";
	date: "$Date$";
	revision: "$Revision $"

class EC_CIRCLE

inherit

	CONSTANTS;
	EC_CLOSED_FIG

creation

	make

feature -- Initialization

	make (a_radius: like radius) is
			-- Make a circle with 'a_radius' as radius
		do
			!!closure.make;
			!!path.make;
			!!interior.make;
		--	interior.set_foreground_color (Resources.drawing_bg_color);
			!!center;
			radius := a_radius
		ensure
			has_path: path /= Void;
			has_center: center /= Void;
			radius_correctly_set: radius = a_radius
		end;

feature -- Properties

	center: EC_COORD_XY;

	radius: INTEGER;

	origin: EC_COORD_XY is
			-- origin of circle
		do
			Result := center
		end -- origin

feature -- Setting

	set_color (a_color: EV_COLOR) is
		require
			valid_a_color: a_color /= Void
		do
	--		path.set_foreground_color (a_color);
		end;

	set_center (a_point: like center) is
			-- set 'center' to 'a_point'
		require
			has_point: a_point /= Void
		do
			center := a_point
		ensure
			center_correctly_set: center = a_point
		end; -- set_center

	set_radius (a_radius: like radius) is
			-- set 'radius' to 'a_radius'
		do
			radius := a_radius
		ensure
			radius_correctly_set: radius = a_radius
		end -- set_radius

feature -- Access

	contains (a_point: EC_COORD_XY): BOOLEAN is
			-- Is 'a_point' in current circle?
		require else
			has_point: a_point /= Void
		local
			dx, dy: INTEGER
		do
			dx := a_point.x - center.x;
			dy := a_point.y - center.y;
			Result := (dx * dx + dy * dy) <= radius * radius
		end 

feature -- Output

	draw is
			-- Draw current circle in drawing area
		do
			if drawing.is_drawable then
				interior.set_drawing_attributes (drawing);
				drawing.fill_arc (center, radius, radius, 0, 360, 0, 0);
							path.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
							drawing.draw_arc (center, radius, radius, 0, 360, 0, -1)
			end
		end; 

	erase is
			-- Erase current circle from drawing area
		do
			if drawing.is_drawable then
				path.set_drawing_attributes (drawing);
				interior.set_drawing_attributes (drawing);
				drawing.set_line_width (1);
				drawing.set_foreground_color
							(Resources.drawing_bg_color);
				drawing.fill_arc (center, radius, radius, 0, 360, 0, 0);
							drawing.draw_arc (center, radius, radius, 0, 360, 0, -1)
			end
		end;

feature -- Update

	recompute_closure is
			-- Recalculate circle's closure.
		do
		--	closure.set (center.x - radius - path.line_width,
		--			center.y - radius - path.line_width,
		--			2 * (radius + path.line_width),
		--			2 * (radius + path.line_width))
		end 

invariant

	has_center: center /= Void;
	has_path: path /= Void

end -- class EC_CIRCLE
