indexing

	description: 
		"Ellipse used to draw classes.";
	date: "$Date$";
	revision: "$Revision $"

class EC_ELLIPSE 
 
inherit

	EC_CLOSED_FIG

creation

	make

feature -- Initialization

	make is
			-- Create an ellipse
		do
			!!closure.make
			!!center
			!!path.make
		end

feature -- Properties

	center: EC_COORD_XY
			-- Ellipse's center

	radius1: INTEGER
			-- First ellipse's radius.

	radius2: INTEGER
			-- Second ellipse's radius.

	origin: EC_COORD_XY is
			-- Ellipse's origin
		do
			Result := center
		end

feature -- Setting

	set_center (a_point: like center) is
			-- Set 'center' to 'a_point'.
		require
			a_point_exists: not (a_point = Void)
		do
			center := a_point
		ensure
			center = a_point
		end

	set_radius1 (new_radius1: like radius1) is
			-- Set 'radius1' to 'new_radius1', change 'size_of_side'.
		require
			size_positive: new_radius1 > 0
		do
			radius1 := new_radius1
		ensure
			radius1 = new_radius1
		end

	set_radius2 (new_radius2: like radius1) is
			-- Set 'radius2' to 'new_radius2', change 'size_of_side'.
		require
			size_positive: new_radius2 > 0
		do
			radius2 := new_radius2
		ensure
			radius2 = new_radius2
		end

feature -- Update

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate figure by 'a' relative to ('px','py').
			-- Angle 'a' is measured in degrees.
		do
			center.xyrotate(a, px, py);
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by 'f' relative to ('px', 'py').
		require else
			scale_factor_positive: f > 0.0
		do
			radius1 := (f*radius1).truncated_to_integer;
			radius2 := (f*radius2).truncated_to_integer;
			center.xyscale(f, px, py);
		end

	xytranslate (vx, vy: INTEGER) is
			-- Tranlate by 'vx' horizontally and 'vy' vertically.
		do
			center.xytranslate(vx, vy)
		end

	recompute_closure is
			-- Recalculate figure's closure.
		do
 			closure.set (
 				center.x - radius1 - path.line_width,
 				center.y - radius2 - path.line_width,
 				2*(radius1 + path.line_width),
 				2*(radius2 + path.line_width))
		end 

feature -- Access

	contains (p: EC_COORD_XY): BOOLEAN is
			-- Is p in figure?
		require else
			points_exists: not (p = Void)
		local
			x1, y1: INTEGER;
			dx, dy: REAL
		do
			x1 := p.x - center.x;
			y1 := p.y - center.y;
			dx := (x1 * x1) / (radius1 * radius1);
			dy := (y1 * y1) / (radius2 * radius2);
			Result := (dx + dy) <= 1.0
		end -- contains

feature -- Output

	draw is
			-- Draw the ellipse
		require else
			drawable: drawing.is_drawable
		do
			if not (interior = Void) then
				interior.set_drawing_attributes (drawing)
				drawing.fill_arc (center, radius1, radius2, 0, 360, 0.0, 0)
			end
			path.set_drawing_attributes (drawing)
			drawing.draw_arc (center, radius1, radius2, 0, 360, 0.0, -1)
		end

	erase is
			-- Erase current figure
		require else
				drawable: drawing.is_drawable
		do
				if not (interior = Void) then
					interior.set_clear_mode
				end
				path.set_clear_mode
				draw
				if not (interior = Void) then
					interior.set_copy_mode
				end;
				path.set_copy_mode
		end

invariant
	EC_ELLIPSE_consistent_angles: radius1 >= 0 and radius2 >= 0
	EC_ELLIPSE_not_void: closure/=Void and center/=Void and path/=Void
end -- class EC_ELLIPSE
