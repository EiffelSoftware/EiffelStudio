note
	description: "Summary description for {CTR_ICONS_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_ICONS_FACTORY

feature -- Catalog tool

	small_tool_bar_button_icon_height: INTEGER = 10

	small_tool_bar_button_icon_font_height: INTEGER = 9

	default_font: EV_FONT
		once
			create Result
		end

	icon_grid_bold_font: EV_FONT
		once
			Result := default_font
			create Result.make_with_values (Result.family, {EV_FONT_CONSTANTS}.weight_bold, Result.shape, 8)
		end

	icon_font: EV_FONT
		once
			Result := default_font
			create Result.make_with_values (Result.family, Result.weight, Result.shape, small_tool_bar_button_icon_font_height)
		end

	new_custom_text_small_toolbar_button_icon (t: STRING_GENERAL): EV_PIXMAP
		local
			bcol,fcol,borcol: EV_COLOR
		do
			create Result.make_with_size (icon_font.string_width (t) + 2, small_tool_bar_button_icon_height)

			create bcol.make_with_8_bit_rgb (255,210,190)
			create fcol.make_with_8_bit_rgb (0,0,0)
			create borcol.make_with_8_bit_rgb (210,190,60)
			Result.set_background_color (bcol)
			Result.set_foreground_color (fcol)
			Result.clear
			Result.set_font (icon_font)
			Result.draw_text_top_left (1, 0, t)
		end

	new_check_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_custom_text_small_toolbar_button_icon ("Check")
		end

	new_remove_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_custom_text_small_toolbar_button_icon ("Delete")
		end

	new_archive_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_custom_text_small_toolbar_button_icon ("Archive")
		end

	new_diff_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_custom_text_small_toolbar_button_icon ("Diff")
		end

	active_cursor_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
		once
			create fcol.make_with_8_bit_rgb (0,210,0)
			create Result.make_with_size (10, 10)
			Result.set_foreground_color (fcol)
			Result.fill_rectangle (2, 2, 6, 6)
		end

	review_approved_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
			l_mask: EV_BITMAP
		once
			create fcol.make_with_8_bit_rgb (0,190,0)
			create Result.make_with_size (10, 10)
			Result.set_foreground_color (fcol)
			Result.fill_ellipse (1, 1, 9, 9)
			result.set_drawing_mode (0)

			create l_mask.make_with_size (10, 10)
			l_mask.set_foreground_color (colors.white)
			l_mask.fill_ellipse (1, 1, 9, 9)
			Result.set_mask (l_mask)
		end

	review_refused_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
			l_mask: EV_BITMAP
		once
			create fcol.make_with_8_bit_rgb (190, 0,0)
			create Result.make_with_size (10, 10)
			Result.set_foreground_color (fcol)
			Result.set_line_width (2)
			Result.draw_straight_line (2, 2, 7, 7)
			Result.draw_straight_line (2, 7, 7, 2)

			create l_mask.make_with_size (10, 10)
			l_mask.set_foreground_color (colors.white)
			l_mask.set_line_width (2)
			l_mask.draw_straight_line (2, 2, 7, 7)
			l_mask.draw_straight_line (2, 7, 7, 2)
			Result.set_mask (l_mask)
		end

	review_question_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
			l_mask: EV_BITMAP
			c1, c2, c3: EV_COORDINATE
		once
			create fcol.make_with_8_bit_rgb (210, 210, 255)
			create Result.make_with_size (10, 10)
			Result.set_foreground_color (fcol)
			Result.set_line_width (1)
			create c1.make_precise (1, 9)
			create c2.make_precise (5, 1)
			create c3.make_precise (9, 9)
			Result.fill_polygon (<<c1, c2, c3>>)


			create l_mask.make_with_size (10, 10)
			l_mask.set_foreground_color (colors.white)
			l_mask.set_line_width (1)
			l_mask.fill_polygon (<<c1, c2, c3>>)
			Result.set_mask (l_mask)
		end

	colors: EV_STOCK_COLORS
		once
			create Result
		end

end
