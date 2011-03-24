note
	description: "Summary description for {CTR_ICONS_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_ICONS_FACTORY


feature -- Access

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
			Result.set_drawing_mode (0)

			create l_mask.make_with_size (10, 10)
			l_mask.set_foreground_color (colors.white)
			l_mask.fill_ellipse (1, 1, 9, 9)
			Result.set_mask (l_mask)
		end

	delete_icon, review_refused_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
			l_mask: EV_BITMAP
		once
			create fcol.make_with_8_bit_rgb (190, 0,0)
			create Result.make_with_size (10, 10)
			Result.set_foreground_color (fcol)
			Result.set_line_width (2)
			Result.draw_straight_line (3, 3, 6, 6)
			Result.draw_straight_line (3, 6, 6, 3)

			create l_mask.make_with_size (10, 10)
			l_mask.set_foreground_color (colors.white)
			l_mask.set_line_width (2)
			l_mask.draw_straight_line (3, 3, 6, 6)
			l_mask.draw_straight_line (3, 6, 6, 3)
			Result.set_mask (l_mask)
		end

	review_local_only_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
			l_mask: EV_BITMAP
		once
			create fcol.make_with_8_bit_rgb (148, 0, 211)
			create Result.make_with_size (10, 10)
			Result.set_foreground_color (fcol)
			Result.set_line_width (1)
			Result.fill_rectangle (4, 0, 2, 6)
			Result.fill_rectangle (4, 8, 2, 2)

			create l_mask.make_with_size (10, 10)
			l_mask.set_foreground_color (colors.white)
			l_mask.set_line_width (1)
			l_mask.fill_rectangle (4, 0, 2, 6)
			l_mask.fill_rectangle (4, 8, 2, 2)
			Result.set_mask (l_mask)
		end

	review_question_icon: EV_PIXMAP
		local
			fcol: EV_COLOR
			l_mask: EV_BITMAP
			c1, c2, c3: EV_COORDINATE
		once
			create fcol.make_with_8_bit_rgb (255, 165, 0)
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

	dropdown_pixel_buffer: EV_PIXEL_BUFFER
		local
			fcol: EV_COLOR
			p: EV_PIXMAP
			pb: EV_PIXEL_BUFFER
		do
			create fcol.make_with_8_bit_rgb (0, 0, 0)
			create p.make_with_size (8, 16)
			p.set_foreground_color (fcol)
--			p.fill_rectangle (0,0 , 6, 14)
			p.fill_polygon (<<
								create {EV_COORDINATE}.make (1, 8),
								create {EV_COORDINATE}.make (8, 8),
								create {EV_COORDINATE}.make (4, 12)
							>>)

			create pb.make_with_pixmap (p)
			Result := pb
		end

feature -- Access: text icon

	new_check_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_text_small_toolbar_button_careful_icon ("Check")
		end

	new_remove_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_text_small_toolbar_button_careful_icon ("Delete")
		end

	new_archive_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_text_small_toolbar_button_standard_icon ("Archive")
		end

	new_mark_all_read_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_text_small_toolbar_button_standard_icon ("Mark-All-Read")
		end

	new_diff_small_toolbar_button_icon: EV_PIXMAP
		do
			Result := new_text_small_toolbar_button_standard_icon ("Diff")
		end

feature -- grid

	new_custom_text_grid_icon (t: STRING_GENERAL; tc,bc,fc: EV_COLOR): EV_PIXMAP
		local
			mask: EV_BITMAP
			w,h: INTEGER
		do
			w := icon_font.string_width (t) + 4
			h := small_tool_bar_button_icon_height + 3

			create Result.make_with_size (w, h)
			Result.clear
			Result.set_foreground_color (bc)
			Result.fill_rectangle (0, 0, w, h - 1)

			Result.set_foreground_color (fc)
			Result.draw_rectangle (0, 0, w, h - 1)

			Result.set_foreground_color (tc)
			Result.set_font (icon_font)
			Result.draw_text_top_left (2, 1, t)

			create mask.make_with_size (w, h)
			mask.set_foreground_color (colors.white)
			mask.fill_rectangle (0, 0, w, h - 1)
			mask.set_foreground_color (fg_mask_color)
			mask.set_font (icon_font)
			mask.draw_text_top_left (2, 1, t)
			mask.draw_rectangle (0, 0, w, h - 1)
			mask.set_foreground_color (colors.black)
			mask.draw_point (0,0)
			mask.draw_point (w-1,h-2)
			mask.draw_point (w-1,0)
			mask.draw_point (0,h-2)
			Result.set_mask (mask)
		end


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

	new_text_small_toolbar_button_standard_icon (t: STRING_GENERAL): EV_PIXMAP
		do
			Result := new_custom_text_small_toolbar_button_icon (t, text_color, back_color, border_color)
		end

	new_text_small_toolbar_button_careful_icon (t: STRING_GENERAL): EV_PIXMAP
		do
			Result := new_custom_text_small_toolbar_button_icon (t, careful_text_color, careful_back_color, careful_border_color)
		end

	new_custom_text_small_toolbar_button_icon (t: STRING_GENERAL; tc,bc,fc: EV_COLOR): EV_PIXMAP
		local
			mask: EV_BITMAP
			w,h: INTEGER
		do
			w := icon_font.string_width (t) + 4
			h := small_tool_bar_button_icon_height + 3

			create Result.make_with_size (w, h)
			Result.clear
			Result.set_foreground_color (bc)
			Result.fill_rectangle (0, 0, w, h - 1)

			Result.set_foreground_color (fc)
			Result.draw_rectangle (0, 0, w, h - 1)

			Result.set_foreground_color (tc)
			Result.set_font (icon_font)
			Result.draw_text_top_left (2, 1, t)

			create mask.make_with_size (w, h)
			mask.set_foreground_color (bg_mask_color)
			mask.fill_rectangle (0, 0, w, h - 1)
			mask.set_foreground_color (fg_mask_color)
			mask.set_font (icon_font)
			mask.draw_text_top_left (2, 1, t)
			mask.draw_rectangle (0, 0, w, h - 1)
			Result.set_mask (mask)
		end

	colors: EV_STOCK_COLORS
		once
			create Result
		end

	careful_text_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (190, 0, 0)
		end

	careful_border_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (190, 0, 0)
		end

	careful_back_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 255, 210)
		end

	text_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 190)
		end

	border_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 255)
		end

	back_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		end

	fg_mask_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		end

	bg_mask_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (210, 210, 210)
		end

end
