indexing

	description: 
		"Rectangle used to erase clusters.";
	date: "$Date$";
	revision: "$Revision $"

class EC_RECTANGLE

inherit

	EC_CLOSED_FIG;
	--JOINABLE

creation

	make

feature -- Initialization

	make is
			-- Create a rectangle.
		do
			!!upper_left;
			!!closure.make;
			!!path.make;
			width := 1;
			height := 1
		end -- make

feature -- Properties

	upper_left: EC_COORD_XY;
			-- Upper left coin of the rectangle

	height: INTEGER;
			-- Height of rectangle

	width: INTEGER;
			-- Width of rectangle

	origin: EC_COORD_XY is
			-- Origin of rectangle
		do
			Result := upper_left
		end -- origin

feature -- Management

	set_height (new_height: like height) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height;
		ensure
			height = new_height
		end; -- set_height

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void)
		do
			upper_left := a_point;
		ensure
			upper_left = a_point
		end; -- set_upper_left

	set_width (new_width: like width) is
			-- Set `width' to `new_width'
		require
			new_width_positive: new_width >= 0
		do
			width := new_width;
		ensure
			width = new_width
		end -- set_width


feature -- Drawing management

	draw is
			-- Draw the rectangle
		do
			if drawing.is_drawable then
		--		drawing.set_join_style (join_style);
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_rectangle (center, width,
								height, 0.0)
				end;
				path.set_drawing_attributes (drawing);
				drawing.draw_rectangle (center, width, height, 0.0)
			end
		end

	erase is
			-- Erase the rectangle
		do
-- 			if drawing.is_drawable then
-- 				if interior /= Void then
-- 					interior.set_clear_mode
-- 				end;
-- 				path.set_clear_mode;
-- 				draw;
-- 				if interior /= Void then
-- 					interior.set_copy_mode
-- 				end;
-- 				path.set_copy_mode
-- 			end
		end; -- erase

feature -- Update

	recompute_closure is
			-- Recalculate figure's closure.
		do
			closure.set (upper_left.x, upper_left.y, width, height)
		end -- recompute_closure

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			upper_left.xyrotate (a, px, py);
		end; -- xyrotate

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			width := (f*width).truncated_to_integer;
			height := (f*height).truncated_to_integer;
			upper_left.xyscale (f, px, py);
		end; -- xyscale

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy);
		end; -- xytranslate

feature -- Access

	contains (p : EC_COORD_XY) : BOOLEAN is
			-- Is p in figure?
		require else
			points_exists : not (p = Void)
		do
			Result := p.x >= upper_left.x and p.x <= upper_left.x + width
				and p.y >= upper_left.y and p.y <= upper_left.y + height
		end -- contains


feature {NONE} -- Implementation

	center: EC_COORD_XY is
			-- Center of the rectangle.
		do
			!!Result;
			Result.set (upper_left.x + width // 2, upper_left.y +
					height // 2)
		end 

invariant

	width >= 0;
	height >= 0;
	not (upper_left = Void)


end -- class EC_RECTANGLE
