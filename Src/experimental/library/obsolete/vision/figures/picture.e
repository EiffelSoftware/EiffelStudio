note

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	PICTURE 

inherit

	FIGURE
		redefine
			conf_recompute
		end;

	CHILD_CLIP;

	LOGICAL;

	BACKGROUND;

	FOREGROUND

create

	make

feature -- Initialization 

		make
			-- Create a picture.
		do
			init_fig (Void);
			create foreground_color.make;
			create background_color.make;
			create upper_left;
			create pixmap.make;
			logical_function_mode := GXcopy;
		end;

feature -- Access

	height: INTEGER;
	
	width: INTEGER;

	pixmap: PIXMAP;
			-- pixmap associated

	upper_left: COORD_XY_FIG;
			-- Upper left point of picture

	origin: COORD_XY_FIG
			-- Origin of picture
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


feature -- Element change
	
	set_pixmap (a_pixmap: like pixmap)
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_exists: a_pixmap /= Void;
			a_pixmap_valid: a_pixmap.is_valid
		do
			pixmap := a_pixmap;
			set_conf_modified
		ensure
			pixap_set: a_pixmap = pixmap
		end;

	set_origin_to_upper_left
			-- Set `origin' to `upper_left'.
		do
			origin_user_type := 2;
		ensure
			origin.is_superimposable (upper_left)
		end;

	set_upper_left (a_point: like upper_left)
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			upper_left := a_point;
			set_conf_modified
		ensure
			a_point = upper_left
		end;	

	xyrotate (a: REAL; px,py: INTEGER)
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `upper_left'.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			upper_left.xyrotate (a, px ,py);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER)
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `upper_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			upper_left.xyscale (f, px, py);
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER)
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy);
			set_conf_modified
		end;

feature -- Output
	
	draw
			-- Draw the current picture.
		require else
			drawing_attached: drawing /= Void;
			pixmap_valid: pixmap.is_valid
		do
			if drawing.is_drawable then
				drawing.set_logical_mode (logical_function_mode);
				drawing.set_subwindow_mode (subwindow_mode);
				drawing.set_foreground_gc_color (foreground_color);
				drawing.set_background_gc_color (background_color);
				drawing.copy_bitmap (upper_left, pixmap)
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN
			-- Is the current picture superimposable to other ?
			-- Not compare pixmap resource structures : they must be the
			-- same in reference.
		require else
			other_exists: other /= Void
		do
			Result := upper_left.is_superimposable (other.upper_left) and 
				(pixmap = other.pixmap)
		end;
	
feature {CONFIGURE_NOTIFY} -- Implementation
	
	conf_recompute
		require else
			pixmap /= Void and upper_left /= Void
		do
			width := pixmap.width;
			height := pixmap.height;
			surround_box.set (upper_left.x, upper_left.y, width, height);
			unset_conf_modified
		end;

invariant

	origin_user_type_constraint: origin_user_type <= 2;
	upper_left_exists: upper_left /= Void;
	pixmap_exists: pixmap /= Void;
	correct_pixmap_depth: pixmap.is_valid implies pixmap.depth <= 2;
	foreground_color_exists: foreground_color /= Void;
	background_color_exists: background_color /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end  -- class PICTURE

