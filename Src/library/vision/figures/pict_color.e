indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	PICT_COLOR 

inherit

	FIGURE
		redefine
			conf_recompute
		end;

	CHILD_CLIP;

    LOGICAL

creation

	make

feature -- Initialization 

	make is
			-- Create a pict_color.
		do
			init_fig (Void);
			!! upper_left;
			!! pixmap.make;
			logical_function_mode := GXcopy;
		end;

feature -- Access

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

	height: INTEGER;

	width: INTEGER;

	upper_left: COORD_XY_FIG;
			-- Upper left point of pict_color

feature -- Element change

	set_origin_to_upper_left is
			-- Set `origin' to `upper_left'.
		do
			origin_user_type := 2;
		ensure
			origin.is_superimposable (upper_left)
		end;

	set_pixmap (a_pixmap: like pixmap) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_exists: a_pixmap /= Void
		do
			pixmap := a_pixmap;
			set_conf_modified
		ensure
			a_pixmap = pixmap
		end;

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			upper_left := a_point;
			set_conf_modified
		ensure
			a_point = upper_left
		end;

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `upper_left'.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			upper_left.xyrotate (a, px ,py);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `upper_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			upper_left.xyscale (f, px, py);
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy);
			set_conf_modified
		end

feature -- Output

	draw is
			-- Draw the current pict_color.
		require else
			drawing_attached: drawing /= Void;
			pixmap_valid: pixmap.is_valid
		do
			if drawing.is_drawable then
				drawing.set_logical_mode (logical_function_mode);
				drawing.set_subwindow_mode (subwindow_mode);
				drawing.copy_pixmap (upper_left, pixmap)
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current pict_color superimposable to other ?
			-- Not compare pixmap resource structures : they must be the
			-- same in reference.
		require else
			other_exists: other /= Void
		do
			Result := upper_left.is_superimposable (other.upper_left) and 
				(pixmap = other.pixmap)
		end;

feature {CONFIGURE_NOTIFY} -- Updating 

	conf_recompute is
		require else
			upper_left /= Void and pixmap /= Void
		do
			height := pixmap.height;
			width := pixmap.width;
			surround_box.set (upper_left.x, upper_left.y,width,height);
			unset_conf_modified
		end;

invariant

	origin_user_type_constraint: origin_user_type <= 2;
	upper_left_exists: upper_left /= Void;
	pixmap_exists: pixmap /= Void

end -- class PICT_COLOR


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
