--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class PICT_COLOR 

inherit

	FIGURE;

	CHILD_CLIP;

    LOGICAL

creation

	make

feature 

	make is
			-- Create a pict_color.
		do
			logical_function_mode := GXcopy;
			!! upper_left;
			!! pixmap.make
		end;

	draw is
			-- Draw the current pict_color.
		require else
			drawing_attached: not (drawing = Void);
			pixmap_valid: pixmap.is_valid
		do
			if drawing.is_drawable then
				drawing.set_logical_mode (logical_function_mode);
				drawing.set_subwindow_mode (subwindow_mode);
				drawing.copy_pixmap (upper_left, pixmap)
			end
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current pict_color surimposable to other ?
			-- Not compare pixmap resource structures : they must be the
			-- same in reference.
		require else
			other_exists: not (other = Void)
		do
			Result := upper_left.is_surimposable (other.upper_left) and (pixmap = other.pixmap)
		end;

	origin: COORD_XY_FIG is
			-- Origin of pict_color
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := upper_left
			end
		end;

	pixmap: PIXMAP;
			-- pixmap associated

	set_origin_to_upper_left is
			-- Set `origin' to `upper_left'.
		do
			origin_user_type := 2
		ensure
			origin.is_surimposable (upper_left)
		end;

	set_pixmap (a_pixmap: like pixmap) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_exists: not (a_pixmap = Void)
		do
			pixmap := a_pixmap
		ensure
			a_pixmap = pixmap
		end;

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void)
		do
			upper_left := a_point
		ensure
			a_point = upper_left
		end;

	upper_left: COORD_XY_FIG;
			-- Upper left point of pict_color

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `upper_left'.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			upper_left.xyrotate (a, px ,py)
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `upper_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			upper_left.xyscale (f, px, py)
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy)
		end

invariant

	origin_user_type <= 2;
	not (upper_left = Void);
	not (pixmap = Void)

end
