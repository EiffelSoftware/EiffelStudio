indexing

	description: 
		"Picture used for class annotations.";
	date: "$Date$";
	revision: "$Revision $"

class EC_PICTURE 

inherit

	EC_FIGURE;
	--CHILD_CLIP;
	--LOGICAL;
	EC_BACKGROUND;
	EC_FOREGROUND

creation

	make

feature -- Initialization

	make is
			-- Create a picture.
		do
		--	logical_function_mode := GXcopy;
		--	!!foreground_color.make;
		--	!!background_color.make;
		--	!!upper_left;
		--	--!!pixmap.make;
		--	!!closure.make
		--ensure
		--	foreground_color_created : not (foreground_color = Void);
		--	background_color_created : not (background_color = Void);
		--	upper_left_created       : not (upper_left = Void);
		--	pixmap_created           : not (pixmap = Void);
		--	closure_created          : not (closure = Void)
		end -- make

feature -- Components specification

	upper_left: EC_COORD_XY;
			-- Upper left point of picture

	orientation: INTEGER;
			-- bitmap orientation

	pixmap: EV_PIXMAP;
			-- pixmap associated

	origin: EC_COORD_XY is
			-- Origin of picture
		do
			Result := upper_left
		end -- origin

feature -- Setting

	set_pixmap (a_pixmap: like pixmap) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_exists: not (a_pixmap = Void);
		--	a_pixmap_valid: a_pixmap.is_valid
		do
			pixmap := a_pixmap
		ensure
			a_pixmap = pixmap
		end; -- set_pixmap

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void)
		do
			upper_left := a_point
		ensure
			a_point = upper_left
		end; -- set_upper_left

	set_orientation(new_orientation : INTEGER) is
			-- Set `orientation' to `new_orientation.
		do
			orientation := new_orientation
		ensure
			orientation = new_orientation
		end -- set_orientation

feature -- Output
			
	draw is
			-- Draw the current picture.
		require else
			drawing_attached: not (drawing = Void);
		--	pixmap_valid: pixmap.is_valid
		do
			--if drawing.is_drawable then
			--	drawing.set_logical_mode (logical_function_mode);
			--	drawing.set_subwindow_mode (subwindow_mode);
			--	drawing.set_foreground_gc_color (foreground_color);
			--	drawing.set_background_gc_color (background_color);
			--	drawing.copy_bitmap (upper_left, pixmap)
			--end
		end; -- draw

	erase is
			-- Erase current figure
		do
		--	if drawing.is_drawable then
		--		set_clear_mode;
		--		draw;
		--		set_copy_mode
		--	end
		end; -- erase

feature -- Update

	recompute_closure is
			-- Recalculate figure's closure.
		do
			closure.set (upper_left.x, upper_left.y, pixmap.width,
									pixmap.height)
		end -- recompute_closure

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `upper_left'.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			upper_left.xyrotate (a, px ,py);
		end; -- xyrotate

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `upper_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			upper_left.xyscale (f, px, py);
		end; -- xyscale

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy);
		end; -- xytranslate

feature -- Access

	contains(p : EC_COORD_XY) : BOOLEAN is
			-- Is p in figure?
		require else
			points_exists : not (p = Void)
		do
			Result := (p.x > upper_left.x and p.x < upper_left.x +
				pixmap.width) and
				(p.y > upper_left.y and p.y < upper_left.y +
				pixmap.height)
		end -- contains
			
invariant

	--not (upper_left = Void);
	--not (pixmap = Void);
	--pixmap.is_valid implies pixmap.depth <= 2;
	--not (foreground_color = Void);
	--not (background_color = Void)

end -- class EC_PICTURE
