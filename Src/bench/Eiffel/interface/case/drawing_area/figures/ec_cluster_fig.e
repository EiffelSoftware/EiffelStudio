indexing

	description: 
		"Rectangle with rounded coins drawing clusters.";
	date: "$Date$";
	revision: "$Revision $"

class EC_CLUSTER_FIG
		
inherit

	EC_CLOSED_FIG
				
creation

	make
	
feature -- Initialization

	make is
			-- Create a ec_cluster_fig object with `pt1' and `pt2'
			-- as 'up_left' and 'down_right'.
		local
			new_point: EC_COORD_XY;
			i: INTEGER
		do
			!!up_left;
			!!down_right;
			!!closure.make;
			!!points.make_filled (12);
			from
				i := 1
			until
				i > 12
			loop
				!!new_point;
				points.put_i_th (new_point, i);
				i := i+1
			end;
		ensure
			points_created: not (up_left = Void) and not (down_right = Void) 
		end -- make

feature -- Properties

	up_left, down_right: EC_COORD_XY;
			-- Points which determine the including rectangle
				
	width: INTEGER is
		do
			Result := down_right.x - up_left.x
		end; -- width

	height: INTEGER is
		do
			Result := down_right.y - up_left.y
		end -- height	

feature -- Access

	contains (p: EC_COORD_XY): BOOLEAN is
			-- Is `p' in ec_segment?
		require else
			point_exists: not (p = Void)
		do
			Result := p.x >= up_left.x and p.x <= down_right.x and
				p.y >= up_left.y and p.y <= down_right.y
		end -- contains

feature -- Update

	build is
			-- Initialize Current figure's points.
		do
			points.i_th (1).set (up_left.x+radius, up_left.y);
			points.i_th (2).set (down_right.x-radius, up_left.y);
			points.i_th (3).set (down_right.x-radius_1, up_left.y+radius_1);
			points.i_th (4).set (down_right.x, up_left.y+radius);
			points.i_th (5).set (down_right.x, down_right.y-radius);
			points.i_th (6).set (down_right.x-radius_1,
					down_right.y-radius_1);
			points.i_th (7).set (down_right.x-radius, down_right.y);
			points.i_th (8).set (up_left.x+radius, down_right.y);
			points.i_th (9).set (up_left.x+radius_1, down_right.y-radius_1);
			points.i_th (10).set (up_left.x, down_right.y-radius);
			points.i_th (11).set (up_left.x, up_left.y+radius);
			points.i_th (12).set (up_left.x+radius_1, up_left.y+radius_1);
		end; 

	recompute_closure is
			-- Recalculate ec_segment's closure.
		do
			closure.set_bound (up_left, down_right)
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0
		do
			up_left.xyrotate (a, px, py);
			down_right.xyrotate(a, px, py);
			build
		end; -- xyrotate

	xyscale (f: REAL; px, py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			up_left.xyscale (f, px, py);
			down_right.xyscale(f, px, py);
			build
		end; -- xyscale

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			up_left.xytranslate (vx, vy);
			down_right.xytranslate (vx, vy);
			build
		end; -- xytranslate
		
feature -- Output
			
	draw is
			-- draw a ec_cluster_fig.
		local
			red: EV_COLOR
		do
			if drawing.is_drawable then
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_polygon (points)
				end
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
						!! red.make_rgb (255, 0, 0) 
						drawing.set_foreground_color (red)
					drawing.draw_polyline (points, True)
				end;
			end
		end; -- draw

	erase is
			-- Erase current figure.
		do
 			if drawing.is_drawable then
 				if not (path = Void) then
 					path.set_clear_mode;
 					draw;
 					path.set_copy_mode
 				end
 			end
 		end; -- erase

feature -- Setting

	set_up_left (pt: like up_left) is
			-- set `up_left' with `pt'.
		require
			not_point_void: not (pt = Void)
		do
			up_left := pt;
		ensure
			up_left = pt
		end; -- set_up_left
			
	set_down_right (pt: like down_right) is
			-- set `down_right' with `pt'.
		require
			not_point_void: not (pt = Void)
		do
			down_right := pt;
		ensure
			down_right = pt
		end; -- set_down_right	
			
feature {NONE} -- Implementation properties

	radius: INTEGER is 10;
			-- Arcs radius

	radius_1: INTEGER is 3;
			-- radius*(1-(sqrt(2))/2)

	ec_cluster_width: INTEGER is 2;
			-- width of the lines

	points: FIXED_LIST [EC_COORD_XY];
			-- Points list

	origin: EC_COORD_XY is
			-- Origin of line.
		do
			Result := up_left
		end; -- origin

	center: EC_COORD_XY is
			-- ec_cluster's `enter'.
		do
			!!Result;
			Result.set_x (up_left.x+((down_right.x-up_left.x) // 2));
			Result.set_y (up_left.y+((down_right.y-up_left.y) // 2))
		end 

invariant

	not (up_left = Void);
	not (down_right = Void)

end -- class EC_CLUSTER_FIG
