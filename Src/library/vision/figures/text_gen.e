indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TEXT_GEN 

inherit

	FIGURE
		redefine
			conf_recompute
		end;

	G_ANY
		export
			{NONE} all
		end

feature -- Access

	ascent: INTEGER;
	
	descent: INTEGER;

	string_width: INTEGER;

	text: STRING;
			-- Text to be drawn

	top_center: like top_left is
			-- Top and center point of the rectangle containing the text
		do
			!! Result;
			Result.set (top_left.x+(string_width//2), top_left.y);
		end;

	top_left: COORD_XY_FIG;
			-- Top left coiner of the rectangle containing the text

	top_right: like top_left is
			-- Top and right point of the rectangle containing the text
		do
			!! Result;
   	Result.set (top_left.x+string_width, top_left.y)
		end;

	base_center: like top_left is
			-- Center point of the baseline of the text
		do
			!! Result;
			Result.set (top_left.x+(string_width // 2), top_left.y+ascent)
		end;

	base_left: like top_left is
			-- Left point of the baseline of the text
		do
			!! Result;
			Result.set (top_left.x, top_left.y+ascent)
		end;

	base_right: like top_left is
			-- Right point of the baseline of the text
		do
			!! Result;
			Result.set (top_left.x+string_width, top_left.y+ascent)
		end; 

	bottom_center: like top_left is
			-- Center and bottom point of the rectangle containing the text
		do
			!! Result;
			Result.set (top_left.x+(string_width // 2 ),top_left.y+ascent+descent )
		end;

	bottom_left: like top_left is
			-- Left and bottom point of the rectangle containing the text
		do
			!! Result;
			Result.set ( top_left.x, top_left.y+ascent+descent)
		end; 

	bottom_right: like top_left is
			-- Right and bottom point of the rectangle containing the text
		do
			!! Result;
			Result.set (top_left.x+string_width, top_left.y+ascent+descent)
		end;

	font: FONT;
			-- Font to be used


	middle_center: like top_left is
			-- Center and middle point of the rectangle containing the text
		do
			!! Result;
			Result.set ( top_left.x+(string_width // 2), top_left.y+ascent+descent)
		end;

	middle_left: like top_left is
			-- Left and middle point of the rectangle containing the text
		do
			!! Result;
			Result.set ( top_left.x, top_left.y+((ascent+descent) // 2))
		end;

	middle_right: like top_left is
			-- Right and middle point of the rectangle containing the text
		do
			!! Result;
			Result.set (top_left.x+string_width, ((top_left.y+ascent+descent)//2))
		end;

	origin: COORD_XY_FIG is
			-- Origin of picture
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := top_left
			when 3 then
				Result := top_center
			when 4 then
				Result := top_right
			when 5 then
				Result := middle_left
			when 6 then
				Result := middle_center
			when 7 then
				Result := middle_right
			when 8 then
				Result := base_left
			when 9 then
				Result := base_center
			when 10 then
				Result := base_right
			when 11 then
				Result := bottom_left
			when 12 then
				Result := bottom_center
			when 13 then
				Result := bottom_right
			end
		end;

feature -- Element change

	set_base_center (a_point: like top_left) is
			-- Set `base_center' to `a_point'.
		require
			a_point_exists: a_point /=Void
		do
			top_left.set (a_point.x-(string_width // 2),  a_point.y-ascent);
			set_conf_modified
		ensure
			base_center.is_superimposable (a_point)
		end;

	set_base_left (a_point: like top_left) is
			-- Set `base_left' to `a_point'.
		require
			a_point_exists: a_point /=Void
		do
			top_left.set (a_point.x, a_point.y-ascent);
			set_conf_modified
		ensure
			base_left.is_superimposable (a_point)
		end;

	set_base_right (a_point: like top_left) is
			-- Set `base_right' to `a_point'.
		require
			a_point_exists: a_point /=Void
		do
			top_left.set ( a_point.x-string_width, a_point.y-ascent);
			set_conf_modified
		ensure
			base_right.is_superimposable (a_point)
		end;

	set_bottom_center (a_point: like top_left) is
			-- Set `bottom_center' to `a_point'.
		require
			a_point_exists: a_point /=Void
		do
			top_left.set (a_point.x-(string_width // 2 ), a_point.y-ascent-descent);
			set_conf_modified
		ensure
			bottom_center.is_superimposable (a_point)
		end;

	set_bottom_left (a_point: like top_left) is
			-- Set `bottom_left' to `a_point'.
		require
			a_point_exists: a_point /=Void
		do
			top_left.set (a_point.x, a_point.y-ascent-descent);
				set_conf_modified
		ensure
			bottom_left.is_superimposable (a_point)
		end;

	set_bottom_right (a_point: like top_left) is
			-- Set `bottom_right' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
		top_left.set (a_point.x-string_width, a_point.y-ascent-descent);
				set_conf_modified
		ensure
			bottom_right.is_superimposable (a_point)
		end;

	set_font (a_font: FONT) is
			-- Set `font' to `a_font'.
		require
			a_font_exists: a_font /= Void;
			a_font_specified: a_font.is_specified
		do
			font := a_font;
			set_conf_modified
		end;

	set_middle_center (a_point: like top_left) is
			-- Set `middle_center' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
			top_left.set (a_point.x- (string_width//2), a_point.y-((ascent+descent)// 2));
			set_conf_modified
		ensure
			middle_center.is_superimposable (a_point)
		end;

	set_middle_left (a_point: like top_left) is
			-- Set `middle_left' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
			top_left.set (a_point.x, a_point.y- ((ascent+descent) // 2));
				set_conf_modified
		ensure
			middle_left.is_superimposable (a_point)
		end;

	set_middle_right (a_point: like top_left) is
			-- Set `middle_right' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
			top_left.set (a_point.x-string_width, a_point.y-((ascent+descent) // 2));
			set_conf_modified
		ensure
			middle_right.is_superimposable (a_point)
		end;

	set_origin_to_base_center is
			-- Set `origin' to `base_center'.
		do
			origin_user_type := 9;
		end;

	set_origin_to_base_left is
			-- Set `origin' to `base_left'.
		do
			origin_user_type := 8;
		end;

	set_origin_to_base_right is
			-- Set `origin' to `base_right'.
		do
			origin_user_type := 10;
		end;

	set_origin_to_bottom_center is
			-- Set `origin' to `bottom_center'.
		do
			origin_user_type := 12;
		end;

	set_origin_to_bottom_left is
			-- Set `origin' to `bottom_left'.
		do
			origin_user_type := 11;
		end;

	set_origin_to_bottom_right is
			-- Set `origin' to `bottom_right'.
		do
			origin_user_type := 13;
		end;

	set_origin_to_middle_center is
			-- Set `origin' to `middle_center'.
		do
			origin_user_type := 6;
		end;

	set_origin_to_middle_left is
			-- Set `origin' to `middle_left'.
		do
			origin_user_type := 5;
		end;

	set_origin_to_middle_right is
			-- Set `origin' to `middle_right'.
		do
			origin_user_type := 7;
		end;

	set_origin_to_top_center is
			-- Set `origin' to `top_center'.
		do
			origin_user_type := 3;
		end;

	set_origin_to_top_left is
			-- Set `origin' to `top_left'.
		do
			origin_user_type := 2;
		end;

	set_origin_to_top_right is
			-- Set `origin' to `top_right'.
		do
			origin_user_type := 4;
		end; 

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: a_text /= Void
		do
			text := a_text;
			set_conf_modified
		end;

	set_top_center (a_point: like top_left) is
			-- Set `top_center' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
			top_left.set (a_point.x-(string_width // 2), a_point.y);
			set_conf_modified
		ensure
			top_center.is_superimposable (a_point)
		end;

	set_top_left (a_point: like top_left) is
			-- Set `top_left' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
			top_left := a_point;
			set_conf_modified
		ensure
			a_point = top_left
		end;

	set_top_right (a_point: like top_left) is
			-- Set `top_right' to `a_point'.
		require
			a_point_exists: a_point /=Void;
		do
			top_left.set (a_point.x-string_width, a_point.y);
				set_conf_modified
		ensure
			top_right.is_superimposable (a_point)
		end;


	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `top_left'.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			top_left.xyrotate (a, px ,py);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `top_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			top_left.xyscale (f, px, py);
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			top_left.xytranslate (vx, vy);
			set_conf_modified
		end


feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current picture superimposable to other ?
			-- Don't compare font in structure : Must be the
			-- same in reference.
		do
			Result := top_left.is_superimposable (other.top_left) and 
				text.is_equal (other.text) and (font = other.font)
		end; 

feature {NONE} -- Access

	drawing_i_to_widget_i (a_drawing: DRAWING_I): WIDGET_I is
			-- Conversion routine
		do
			Result ?= a_drawing;
		end;

feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute is
		do
			if drawing /= Void and
				font.implementation.is_valid then
					ascent := font.implementation.ascent
					descent :=font.implementation.descent
					string_width := font.implementation.width_of_string (text);
					unset_conf_modified;
			end;
			surround_box.set (top_left.x, top_left.y, bottom_right.x - top_left.x, bottom_right.y - top_left.y)
		end;

invariant

	origin_user_type_constraint: origin_user_type <= 10;
	top_left_exists: top_left /= Void;
	text_exists: text /= Void;
	font_exists: font /= Void;
	font_is_specified: font.is_specified

end -- class TEXT_GEN



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

