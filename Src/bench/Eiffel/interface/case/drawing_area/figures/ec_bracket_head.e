indexing

	description: 
		"Arrow bracket head used to draw aggregation link.";
	date: "$Date$";
	revision: "$Revision $"

class EC_BRACKET_HEAD

inherit

	EC_ARROW_HEAD;
	SINGLE_MATH
	ONCES
		undefine
			is_equal,
			copy
		end

creation

	make

feature -- Initialization

	make (an_origin : EC_COORD_XY; i : INTEGER) is
			-- Create a bracket at 'an_origin'
		require
			has_origin: an_origin /= Void;
		do
			type := i
			create closure.make
			create path.make
			create interior.make
			origin := an_origin
			create center1
			create center2
			create center3
			create center4
		end

feature -- Properties

	center1, center2, center3, center4 : EC_COORD_XY;
			-- Centers of small circle of the bracket

	angle : REAL
			-- Angle made by origin and points.i_th (points.count - 1)

	origin : EC_COORD_XY
			-- Origin of the bracket

feature -- Setting

	build (first_point, last_point : EC_COORD_XY) is
			-- Build current bracket at 'first_point'
		local
			dx, dy: INTEGER;
			rad_to_degree: REAL
		do
			center1.set (origin.x + 2 * Resources.link_bracket_size,
					origin.y - Resources.link_bracket_size);
			center2.set (origin.x, origin.y - Resources.link_bracket_size);
			center3.set (origin.x + 2 * Resources.link_bracket_size,
					origin.y + Resources.link_bracket_size);
			center4.set (origin.x, origin.y + Resources.link_bracket_size);
			dx := origin.x - last_point.x;
			dy := origin.y - last_point.y;
			if dx = 0 then
				if 0 < dy then
					angle := pi / 2;
				else
					angle := -pi / 2;
				end
			else
				angle := -arc_tangent (dy / dx)
				if 0 < dx then
					angle := angle + pi
				end
			end
			center1.xyrotate (angle, origin.x, origin.y);
			center2.xyrotate (angle, origin.x, origin.y);
			center3.xyrotate (angle, origin.x, origin.y);
			center4.xyrotate (angle, origin.x, origin.y);
		--	rad_to_degree := 180 / pi;
		--	angle := angle * rad_to_degree;
		--	if angle < 0 then
		--		angle := angle + 360
		--	end
		end

feature -- Output

	draw is
			-- Display current bracket
		local
			r0, r90, r180, r270: REAL
			p1,p2,p3,p4 : EC_COORD_XY
			f : FIXED_LIST [ EC_COORD_XY ]
			kx,ky,tmp : INTEGER
		do
 			if drawing.is_drawable then
 				r0 := 0
 				r90 := pi/2
 				r180 := pi
 				r270 := 3.0*pi/2
 				path.set_drawing_attributes (drawing);
 				interior.set_drawing_attributes (drawing);
 				if System.uml_layout then
 					kx := origin.x + (Resources.link_bracket_size*cosine(angle)).floor
 					ky := origin.y - (Resources.link_bracket_size*sine(angle)).floor
 					!! p1 ; p1.set(5 + kx ,ky)
 					!! p2;p2.set(kx , 5+ky)
 					!! p3;p3.set(kx -5,ky)
 					!! p4;p4.set(kx ,-5+ky)
 					!! f.make(4)
 					f.extend(p1)
 					f.extend(p2)
 					f.extend(p3)
 					f.extend(p4)
 					drawing.fill_polygon(f)
 				else
 					drawing.set_line_width (1);
 					drawing.draw_arc (center1, Resources.link_bracket_size,
 								Resources.link_bracket_size,
 								r180, r90, angle, -1);
 					drawing.draw_arc (center3, Resources.link_bracket_size,
 						Resources.link_bracket_size, r90, r90,
 								angle, -1)
 				end
 			end
		end; -- draw

	erase is
			-- Erase current bracket
		local
			r0, r90, r180, r270: REAL
			kx,ky : INTEGER
			p1,p2,p3,p4 : EC_COORD_XY
			f : FIXED_LIST [ EC_COORD_XY ]
		do
 			if drawing.is_drawable then
 				r0 := 0;
 				r90 := 90;
 				r180 := 180;
 				r270 := 270;
 				path.set_drawing_attributes (drawing);
 				interior.set_drawing_attributes (drawing);
 				drawing.set_foreground_color
 								(Resources.get_color("drawing_background_color"))
 				if System.uml_layout then
 						kx := origin.x + (Resources.link_bracket_size*cosine(angle)).floor
 						ky := origin.y - (Resources.link_bracket_size*sine(angle)).floor
 					!! p1 ; p1.set(5 + kx ,ky)
 					!! p2;p2.set(kx , 5+ky)
 					!! p3;p3.set(kx -5,ky)
 					!! p4;p4.set(kx ,-5+ky)
 					!! f.make(4)
 					f.extend(p1)
 					f.extend(p2)
 					f.extend(p3)
 					f.extend(p4)
 					drawing.fill_polygon(f)
 				else
 					drawing.set_line_width (1);
 					drawing.draw_arc (center1, Resources.link_bracket_size,
 							Resources.link_bracket_size,
 							r180, r90, angle, -1);
 					drawing.draw_arc (center3, Resources.link_bracket_size,
 							Resources.link_bracket_size,
							r90, r90, angle, -1);
				end
			end
		end

feature -- Update

	recompute_closure is
			-- Closure of bracket
		do
			closure.set (center1.x - Resources.link_bracket_size,
				center2.y - Resources.link_bracket_size,
				center2.x - center1.x + 2 *
						Resources.link_bracket_size,
				center4.y - center2.y + 2 *
						Resources.link_bracket_size)
		end; 

	contains (a_point : EC_COORD_XY) : BOOLEAN is
			-- Is 'a_point' on bracket ?
		require else
			has_point : a_point /= Void
		local
		do
		end -- contains

feature -- Access

	base (first_point, last_point : EC_COORD_XY) : EC_COORD_XY is
			-- Intersection point between bracket and arrow's body
		require else
			has_first : first_point /= Void;
			has_last : last_point /= Void
		local
			x_arrow: INTEGER;
				-- x composant of arrow as vector

			y_arrow: INTEGER;
				-- y composant of arrow as vector

			length_arrow: REAL;
				-- length of arrow as vector

			factor_arrow: REAL
		do
			Result := last_point;
			x_arrow := last_point.x - first_point.x;
			y_arrow := last_point.y - first_point.y;
			length_arrow := sqrt (x_arrow * x_arrow + y_arrow * y_arrow);
			factor_arrow := length_arrow /
				(2 * Resources.link_bracket_size);
			if factor_arrow = 0 then
				Result.set_x (Result.x);
				Result.set_y (Result.y);
			else
				Result.set_x (Result.x - 
						(x_arrow / factor_arrow).truncated_to_integer);
				Result.set_y (Result.y - 
						(y_arrow / factor_arrow).truncated_to_integer)
			end
		end

invariant
		has_center1: center1 /= Void;
		has_center2: center2 /= Void;
		has_center3: center3 /= Void;
		has_center4: center4 /= Void;
		origin_correctly_set: origin /= Void
end -- class EC_BRACKET_HEAD
