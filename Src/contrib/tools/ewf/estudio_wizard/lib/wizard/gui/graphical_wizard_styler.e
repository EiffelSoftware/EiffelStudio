note
	description: "Summary description for {GRAPHICAL_WIZARD_STYLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_WIZARD_STYLER

inherit
	EV_LAYOUT_CONSTANTS

feature -- Access: layout

	default_width: INTEGER = 400

	default_height: INTEGER = 350

feature -- Style

	apply_title_style (lab: EV_LABEL)
		do
			lab.align_text_left
			lab.align_text_vertical_center
			lab.set_foreground_color (colors.black)
			lab.set_font (title_font)
		end

	apply_subtitle_style (lab: EV_LABEL)
		do
			lab.align_text_left
			lab.align_text_vertical_center
			lab.set_foreground_color (colors.black)
			lab.set_font (subtitle_font)
		end

	apply_text_style (w: EV_WIDGET)
		do
			if attached {EV_TEXT_ALIGNABLE} w as l_alignable then
				l_alignable.align_text_left
				if attached {EV_LABEL} w as lab then
					lab.align_text_top
				end
			end
			if attached {EV_COLORIZABLE} w as l_colorizable then
				l_colorizable.set_foreground_color (colors.black)
			end
			if attached {EV_FONTABLE} w as l_fontable then
				l_fontable.set_font (text_font)
			end
		end

	apply_fixed_size_text_style (w: EV_WIDGET)
		do
			apply_text_style (w)
			if attached {EV_FONTABLE} w as l_fontable then
				l_fontable.set_font (fixed_size_text_font)
			end
		end

	apply_section_style (w: EV_WIDGET)
		do
			apply_text_style (w)
			if attached {EV_FONTABLE} w as l_fontable then
				l_fontable.set_font (section_font)
			end
		end

	apply_report_style (w: EV_WIDGET)
		do
			if attached {EV_TEXT_ALIGNABLE} w as l_alignable then
				l_alignable.align_text_left
				if attached {EV_LABEL} w as lab then
					lab.align_text_top
				end
			end
			if attached {EV_FONTABLE} w as l_fontable then
				l_fontable.set_font (report_font)
			end
		end

	apply_field_description_style (w: EV_WIDGET)
		do
			apply_text_style (w)
			if attached {EV_COLORIZABLE} w as l_colorizable then
				l_colorizable.set_foreground_color (colors.dark_gray)
			end
			if attached {EV_FONTABLE} w as l_fontable then
				l_fontable.set_font (field_description_font)
			end
		end

	apply_button_style (but: EV_BUTTON)
		do
			but.set_minimum_width (default_button_width)
			but.set_minimum_height (default_button_height)
		end

feature -- Access: colors

	colors: EV_STOCK_COLORS
		once
			create Result
		end

	color_light_yellow: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 210, 210)
		end

	color_light_green: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (150, 255, 150)
		end

	color_light_orange: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 210, 50)
		end

	color_light_red: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 210, 210)
		end

feature -- Access: pixmaps		

	pixmaps: EV_STOCK_PIXMAPS
		once
			create Result
		end

feature -- Access: fonts

	title_font: EV_FONT
		once
			create Result
			Result.set_family ({EV_FONT_CONSTANTS}.family_sans)
			Result.set_height_in_points (10)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	subtitle_font: EV_FONT
		once
			create Result
--			Result.set_family ({EV_FONT_CONSTANTS}.family_sans)
			Result.set_height_in_points (9)
--			Result.set_weight ({EV_FONT_CONSTANTS}.weight_thin)
		end

	section_font: EV_FONT
		once
			create Result
			Result.set_family ({EV_FONT_CONSTANTS}.family_sans)
			Result.set_height_in_points (12)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	text_font: EV_FONT
		once
			create Result
			Result.set_height_in_points (9)
		end

	fixed_size_text_font: EV_FONT
		once
			create Result
			Result.set_height_in_points (9)
			Result.set_family ({EV_FONT_CONSTANTS}.family_typewriter)
		end

	field_description_font: EV_FONT
		once
			create Result
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
			Result.set_height_in_points (9)
		end

	report_font: EV_FONT
		once
			create Result
			Result.set_height_in_points (9)
		end

end
