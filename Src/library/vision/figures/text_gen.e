--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class TEXT_GEN 

inherit

	FIGURE;

	G_ANY
		export
			{NONE} all
		end

feature {NONE}

	drawing_i_to_widget_i (a_drawing: DRAWING_I): WIDGET_I is
			-- Conversion routine
		do
			Result ?= a_drawing;
		end;

feature 

	base_center: like top_left is
			-- Center point of the baseline of the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
			futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := top_left.y+font.implementation.ascent (drawing_i_to_widget_i (drawing));
			Result.set (futur_x, futur_y)
		end;

	base_left: like top_left is
			-- Left point of the baseline of the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x;
			futur_y := top_left.y+font.implementation.ascent (drawing_i_to_widget_i (drawing));
			Result.set (futur_x, futur_y)
		end;

	base_right: like top_left is
			-- Right point of the baseline of the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
			futur_y := top_left.y+font.implementation.ascent (drawing_i_to_widget_i (drawing));
			Result.set (futur_x, futur_y)
		end; 

	bottom_center: like top_left is
			-- Center and bottom point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := top_left.y+font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing));
			Result.set (futur_x, futur_y)
		end;

	bottom_left: like top_left is
			-- Left and bottom point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x;
			futur_y := top_left.y+font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing));
			Result.set (futur_x, futur_y)
		end; 

	bottom_right: like top_left is
			-- Right and bottom point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
			futur_y := top_left.y+font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing));
			Result.set (futur_x, futur_y)
		end;

	font: FONT;
			-- Font to be used

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current picture surimposable to other ?
			-- Don't compare font in structure : Must be the
			-- same in reference.
		do
			Result := top_left.is_surimposable (other.top_left) and text.is_equal (other.text) and (font = other.font)
		end; 

	middle_center: like top_left is
			-- Center and middle point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
			futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := top_left.y+((font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing))) // 2);
			Result.set (futur_x, futur_y)
		end;

	middle_left: like top_left is
			-- Left and middle point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x;
			futur_y := top_left.y+((font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing))) // 2);
			Result.set (futur_x, futur_y)
		end;

	middle_right: like top_left is
			-- Right and middle point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
			futur_y := top_left.y+((font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing))) // 2);
			Result.set (futur_x, futur_y)
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

	set_base_center (a_point: like top_left) is
			-- Set `base_center' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x-(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := a_point.y-font.implementation.ascent (drawing_i_to_widget_i (drawing));
			top_left.set (futur_x, futur_y)
		ensure
			base_center.is_surimposable (a_point)
		end;

	set_base_left (a_point: like top_left) is
			-- Set `base_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x;
            		futur_y := a_point.y-font.implementation.ascent (drawing_i_to_widget_i (drawing));
            		top_left.set (futur_x, futur_y)
		ensure
			base_left.is_surimposable (a_point)
		end;

	set_base_right (a_point: like top_left) is
			-- Set `base_right' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x-font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
			futur_y := a_point.y-font.implementation.ascent (drawing_i_to_widget_i (drawing));
            		top_left.set (futur_x, futur_y)
		ensure
			base_right.is_surimposable (a_point)
		end;

	set_bottom_center (a_point: like top_left) is
			-- Set `bottom_center' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x-(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := a_point.y-font.implementation.ascent (drawing_i_to_widget_i (drawing))-font.implementation.descent (drawing_i_to_widget_i (drawing));
			top_left.set (futur_x, futur_y)
		ensure
			bottom_center.is_surimposable (a_point)
		end;

	set_bottom_left (a_point: like top_left) is
			-- Set `bottom_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
        	do
            		futur_x := a_point.x;
            		futur_y := a_point.y-font.implementation.ascent (drawing_i_to_widget_i (drawing))-font.implementation.descent (drawing_i_to_widget_i (drawing));
            		top_left.set (futur_x, futur_y)
		ensure
			bottom_left.is_surimposable (a_point)
		end;

	set_bottom_right (a_point: like top_left) is
			-- Set `bottom_right' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
        	do
            		futur_x := a_point.x-font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
            		futur_y := a_point.y-font.implementation.ascent (drawing_i_to_widget_i (drawing))-font.implementation.descent (drawing_i_to_widget_i (drawing));
            		top_left.set (futur_x, futur_y)
		ensure
			bottom_right.is_surimposable (a_point)
		end;

	set_font (a_font: FONT) is
			-- Set `font' to `a_font'.
		require
			a_font_exists: not (font = Void);
			a_font_specified: font.is_specified
		do
			font := a_font
		end;

	set_middle_center (a_point: like top_left) is
			-- Set `middle_center' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x-(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := a_point.y-((font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing))) // 2);
			top_left.set (futur_x, futur_y)
		ensure
			middle_center.is_surimposable (a_point)
		end;

	set_middle_left (a_point: like top_left) is
			-- Set `middle_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
        	do
			futur_x := a_point.x;
            		futur_y := a_point.y-((font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing))) // 2);
            		top_left.set (futur_x, futur_y)
		ensure
			middle_left.is_surimposable (a_point)
		end;

	set_middle_right (a_point: like top_left) is
			-- Set `middle_right' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x-font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
			futur_y := a_point.y-((font.implementation.ascent (drawing_i_to_widget_i (drawing))+font.implementation.descent (drawing_i_to_widget_i (drawing))) // 2);
			top_left.set (futur_x, futur_y)
		ensure
			middle_right.is_surimposable (a_point)
		end;

	set_origin_to_base_center is
			-- Set `origin' to `base_center'.
		do
			origin_user_type := 9
		end;

	set_origin_to_base_left is
			-- Set `origin' to `base_left'.
		do
			origin_user_type := 8
		end;

	set_origin_to_base_right is
			-- Set `origin' to `base_right'.
		do
			origin_user_type := 10
		end;

	set_origin_to_bottom_center is
			-- Set `origin' to `bottom_center'.
		do
			origin_user_type := 12
		end;

	set_origin_to_bottom_left is
			-- Set `origin' to `bottom_left'.
		do
			origin_user_type := 11
		end;

	set_origin_to_bottom_right is
			-- Set `origin' to `bottom_right'.
		do
			origin_user_type := 13
		end;

	set_origin_to_middle_center is
			-- Set `origin' to `middle_center'.
		do
			origin_user_type := 6
		end;

	set_origin_to_middle_left is
			-- Set `origin' to `middle_left'.
		do
			origin_user_type := 5
		end;

	set_origin_to_middle_right is
			-- Set `origin' to `middle_right'.
		do
			origin_user_type := 7
		end;

	set_origin_to_top_center is
			-- Set `origin' to `top_center'.
		do
			origin_user_type := 3
		end;

	set_origin_to_top_left is
			-- Set `origin' to `top_left'.
		do
			origin_user_type := 2
		end;

	set_origin_to_top_right is
			-- Set `origin' to `top_right'.
		do
			origin_user_type := 4
		end; 

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: not (a_text = Void)
		do
			text := a_text
		end;

	set_top_center (a_point: like top_left) is
			-- Set `top_center' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := a_point.x-(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := a_point.y;
			top_left.set (futur_x, futur_y)
		ensure
			top_center.is_surimposable (a_point)
		end;

	set_top_left (a_point: like top_left) is
			-- Set `top_left' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		do
			top_left := a_point
		ensure
			a_point = top_left
		end;

	set_top_right (a_point: like top_left) is
			-- Set `top_right' to `a_point'.
		require
			a_point_exists: not (a_point = Void);
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
        	do
            		futur_x := a_point.x-font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
            		futur_y := a_point.y;
            		top_left.set (futur_x, futur_y)
		ensure
			top_right.is_surimposable (a_point)
		end;

	text: STRING;
			-- Text to be drawn

	top_center: like top_left is
			-- Top and center point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
            		futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+(font.implementation.string_width (drawing_i_to_widget_i (drawing), text) // 2);
			futur_y := top_left.y;
			Result.set (futur_x, futur_y)
		end;

	top_left: COORD_XY_FIG;
			-- Top left coiner of the rectangle containing the text

	top_right: like top_left is
			-- Top and right point of the rectangle containing the text
		require
			drawing_attached: not (drawing = Void);
			font_valid_for_drawing: font.implementation.is_valid (drawing_i_to_widget_i (drawing))
		local
			futur_x, futur_y: INTEGER
		do
			!! Result;
			futur_x := top_left.x+font.implementation.string_width (drawing_i_to_widget_i (drawing), text);
            		futur_y := top_left.y;
            		Result.set (futur_x, futur_y)
		end;

	xyrotate (a: REAL; px,py: INTEGER) is
			-- Rotate by `a' relative to (`px', `py').
			-- Warning: don't rotate `pixmap' but just `top_left'.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			top_left.xyrotate (a, px ,py)
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
			-- Warning: don't scale `pixmap' but just `top_left'.
		require else
			scale_factor_positive: f > 0.0
		do
			top_left.xyscale (f, px, py)
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			top_left.xytranslate (vx, vy)
		end

invariant

	origin_user_type <= 10;
	not (top_left = Void);
	not (text = Void);
	not (font = Void);
	font.is_specified

end
