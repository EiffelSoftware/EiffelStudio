indexing
	description: "Default icons for Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	SD_DEFAULT_ICONS

inherit
	SD_ICONS_SINGLETON
		redefine
			stick_buffer,
			unstick_buffer,
			maximize_buffer,
			minimize_buffer,
			normal_buffer,
			close_buffer,
			tool_bar_dropdown_buffer,
			tool_bar_indicator_buffer,
			hide_tab_indicator,
			editor_area
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			create internal_shared
		end

feature -- Implementation

	sd_shared: SD_SHARED is
			-- All shared singletons.
		do
			create Result
		end

	unstick: EV_PIXMAP is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_unpin_icon
		end

	unstick_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_unpin_icon_buffer
		end

	stick: 	EV_PIXMAP is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_pin_icon
		end

	stick_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_pin_icon_buffer
		end

	minimize: EV_PIXMAP is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_minimize_icon
		end

	minimize_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_minimize_icon_buffer
		end

	maximize: EV_PIXMAP is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_maximize_icon
		end

	maximize_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_maximize_icon_buffer
		end

	normal: EV_PIXMAP is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_normalize_icon
		end

	normal_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_normalize_icon_buffer
		end

	close: EV_PIXMAP is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_close_icon
		end

	close_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		once
			Result := icons_10_10.tool_bar_close_icon_buffer
		end

	hide_tab_indicator_buffer (a_hide_number: INTEGER): EV_PIXEL_BUFFER is
			-- <Precursor>
		local
			l_font: EV_FONT
			l_orignal: EV_PIXEL_BUFFER
			l_point: EV_COORDINATE
		do
			l_orignal := icons_10_10.tool_bar_hidden_dropdown_small_icon_buffer

			if a_hide_number < 10 then
				create Result.make_with_size (18, 16)
			elseif a_hide_number < 100 then
				create Result.make_with_size (21, 16)
			else
				create Result.make_with_size (24, 16)
			end

			Result.draw_pixel_buffer_with_x_y (0, 0, l_orignal)

			create l_font
			l_font.set_height_in_points (7)
			l_font.set_family ({EV_FONT_CONSTANTS}.family_roman)

			if a_hide_number < 10 then
				create l_point.make (Result.width - 8, 2)
			elseif a_hide_number < 100 then
				create l_point.make (Result.width - 12, 2)
			else
				create l_point.make (Result.width - 16, 2)
			end

			Result.draw_text (a_hide_number.out, l_font, l_point)
		end

	hide_tab_indicator (a_hide_number: INTEGER): EV_PIXMAP is
			-- <Precursor>
		local
			l_orignal: EV_PIXMAP
			l_colors: EV_STOCK_COLORS
			l_font: EV_FONT
		do
			l_orignal := icons_10_10 .tool_bar_hidden_dropdown_small_icon
			Result := l_orignal.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_orignal.width, l_orignal.height))

			create l_colors
			Result.set_background_color (l_colors.default_background_color)

			if a_hide_number < 10 then
				Result.set_size (18, 16)
			elseif a_hide_number < 100 then
				Result.set_size (21, 16)
			else
				Result.set_size (24, 16)
			end

			create l_font
			l_font.set_height_in_points (7)
			l_font.set_family ({EV_FONT_CONSTANTS}.family_roman)
			Result.set_font (l_font)

			if a_hide_number < 10 then
				Result.draw_text_top_left (Result.width - 7, 2, a_hide_number.out)
			elseif a_hide_number < 100 then
				Result.draw_text_top_left (Result.width - 11, 2, a_hide_number.out)
			else
				Result.draw_text_top_left (Result.width - 15, 2, a_hide_number.out)
			end
		end

	tool_bar_indicator: EV_PIXMAP is
			-- <Precursor>
		do
			Result := icons_10_10.tool_bar_hidden_dropdown_icon
		end

	tool_bar_indicator_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		do
			Result := icons_10_10.tool_bar_hidden_dropdown_icon_buffer
		end

	tool_bar_separator_icon: EV_PIXMAP is
			-- Redefine
		local
			l_bitmap: EV_BITMAP
		once
			create Result.make_with_size (16, 16)
			create l_bitmap.make_with_size (16, 16)
			l_bitmap.fill_rectangle (0, 0, l_bitmap.width, l_bitmap.height)
			Result.set_mask (l_bitmap)
		end

	tool_bar_customize_indicator: EV_PIXMAP is
			-- <Precursor>
		do
			Result := icons_8_16.tool_bar_customize_indicator_icon
		end

	tool_bar_customize_indicator_buffer: EV_PIXEL_BUFFER is
			-- <Precursor>
		do
			Result := icons_8_16.tool_bar_customize_indicator_icon_buffer
		end

	tool_bar_customize_indicator_horizontal: EV_PIXMAP is
			-- Redefine
		once
			Result := icons_16_8.tool_bar_customize_indicator_horizontal_icon
		end

	tool_bar_customize_indicator_horizontal_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		once
			Result := icons_16_8.tool_bar_customize_indicator_horizontal_icon_buffer
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal: EV_PIXMAP is
			-- Redefine
		once
			Result := icons_16_8.tool_bar_customize_indicator_hidden_items_horizontal_icon
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		once
			Result := icons_16_8.tool_bar_customize_indicator_hidden_items_horizontal_icon_buffer
		end

	tool_bar_customize_indicator_with_hidden_items: EV_PIXMAP is
			-- Redefine
		do
			Result := icons_8_16.tool_bar_customize_indicator_hidden_items_icon
		end

	tool_bar_customize_indicator_with_hidden_items_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		do
			Result := icons_8_16.tool_bar_customize_indicator_hidden_items_icon_buffer
		end

	tool_bar_dropdown_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		do
			Result := icons_8_16.tool_bar_dropdown_icon_buffer
		end

	tool_bar_floating_customize: EV_PIXMAP is
			-- Redefine
		once
			Result := floating_tool_bar_icon.icon_drop_down_icon
		end

	tool_bar_floating_close: EV_PIXMAP is
			-- Redefine
		once
			Result := floating_tool_bar_icon.icon_close_icon
		end

	floating_tool_bar_icon: SD_ICONS_11_7 is
			-- Redefine
		once
			create Result.make
		end

	tool_bar_customize_dialog: EV_PIXMAP is
			-- Redefine
		local
			l_stock: EV_STOCK_PIXMAPS
		once
			create l_stock
			Result := l_stock.default_window_icon
		end

	drag_pointer_up: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_32_32.drag_up_icon_buffer, 16, 16)
		end

	drag_pointer_down: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_32_32.drag_down_icon_buffer, 16, 16)
		end

	drag_pointer_left: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_32_32.drag_left_icon_buffer, 16, 16)
		end

	drag_pointer_right: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_32_32.drag_right_icon_buffer, 16, 16)
		end

	drag_pointer_center: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_32_32.drag_center_icon_buffer, 16, 16)
		end

	drag_pointer_float: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_32_32.drag_float_icon_buffer, 16, 16)
		end

feature -- Generated matrix classes

	icons_32_32: SD_ICONS_32_32 is
			-- 32 * 32 icons.
		once
			create Result.make
		end

	icons_16_16: SD_ICONS_16_16 is
			-- 16 * 16 icons.
		once
			create Result.make
		end

	icons_8_16: SD_ICONS_8_16 is
			-- 8 * 16 icons.
		once
			create Result.make
		end

	icons_16_8: SD_ICONS_16_8 is
			-- 16 * 8 icons.
		once
			create Result.make
		end

	icons_10_10: SD_ICONS_10_10 is
			-- 10 * 10 icons.
		once
			create Result.make
		end

feature -- Feedback indicators

	arrow_indicator_center: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_CENTER_ICON} Result.make
		end

	arrow_indicator_center_lightening_up: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_CENTER_UP_LIGHT_ICON} Result.make
		end

	arrow_indicator_center_lightening_down: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_CENTER_DOWN_LIGHT_ICON} Result.make
		end

	arrow_indicator_center_lightening_left: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_CENTER_LEFT_ICON} Result.make
		end

	arrow_indicator_center_lightening_right: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_CENTER_RIGHT_ICON} Result.make
		end

	arrow_indicator_center_lightening_center: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_CENTER_CENTER_LIGHT_ICON} Result.make
		end

	arrow_indicator_up: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_UP_ICON} Result.make
		end

	arrow_indicator_down: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_DOWN_ICON} Result.make
		end

	arrow_indicator_left: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_LEFT_ICON} Result.make
		end

	arrow_indicator_right: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_RIGHT_ICON} Result.make
		end

	arrow_indicator_up_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_UP_LIGHT_ICON} Result.make
		end

	arrow_indicator_down_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_DOWN_LIGHT_ICON} Result.make
		end

	arrow_indicator_left_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_LEFT_LIGHT_ICON} Result.make
		end

	arrow_indicator_right_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		once
			create {SD_RIGHT_LIGHT_ICON} Result.make
		end

feature -- Editor icons

	close_context_tool_bar: EV_PIXMAP  is
			-- Redefine
		do
			Result := icons_16_16.zone_close_icon
		end

	close_others: EV_PIXMAP is
			-- Redefine
		do
			create Result
		end

	close_all: EV_PIXMAP is
			-- Redefine
		do
			Result := icons_16_16.zone_close_all_icon
		end

	editor_area: EV_PIXEL_BUFFER is
			-- <Precursor>
		do
			Result := icons_16_16.editor_area_icon_buffer
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons

invariant

	internal_shared_not_void: internal_shared /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
