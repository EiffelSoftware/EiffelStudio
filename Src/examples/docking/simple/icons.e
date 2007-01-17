indexing
	description: "Objects that have all the icons requied in the system."
	legal      : "See notice at end of class."
	status     : "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	ICONS

inherit
	SD_ICONS_SINGLETON

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			init
			create internal_shared
		end

feature -- Implementation

	sd_shared: SD_SHARED is
			--
		do
			create Result
		end

	unstick: EV_PIXMAP is
			-- Unstick icon pixmap.
		once
			Result := icons_10_10.tool_bar_unpin_icon
		end

	stick: 	EV_PIXMAP is
			-- Stick icon pixmap.
		once
			Result := icons_10_10.tool_bar_pin_icon
		end

	minimize: EV_PIXMAP is
			-- Minimize icon pixmap
		once
			Result := icons_10_10.tool_bar_minimize_icon
		end

	maximize: EV_PIXMAP is
				-- Maximize icon pixmap.
		once
			Result := icons_10_10.tool_bar_maximize_icon
		end

	normal: EV_PIXMAP is
			-- Minimize icon pixmap.
		once
			Result := icons_10_10.tool_bar_normalize_icon
		end

	close: EV_PIXMAP is
			-- close icon pixmap.
		once
			Result := icons_10_10.tool_bar_close_icon
		end

	hide_tab_indicator_buffer (a_hide_number: INTEGER): EV_PIXEL_BUFFER is
			-- Hide tab indicator.
		local
			l_font: EV_FONT
			l_orignal: EV_PIXEL_BUFFER
			l_orignal_rect: EV_RECTANGLE
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

			create l_orignal_rect.make (0, 0, l_orignal.width, l_orignal.height)
			Result.draw_pixel_buffer (l_orignal, l_orignal_rect)

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

	tool_bar_indicator: EV_PIXMAP is
			-- Redefine.
		do
			Result := icons_10_10.tool_bar_hidden_dropdown_icon
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
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_icon
		end

	tool_bar_customize_indicator_buffer: EV_PIXEL_BUFFER is
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_icon_buffer
		end

	tool_bar_customize_indicator_horizontal: EV_PIXMAP is
			-- Redefine
		once
			Result := icons_8_16_horizontal.tool_bar_customize_indicator_horizontal_icon
		end

	tool_bar_customize_indicator_horizontal_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		once
			Result := icons_8_16_horizontal.tool_bar_customize_indicator_horizontal_icon_buffer
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal: EV_PIXMAP is
			--
		once
			Result := icons_8_16_horizontal.tool_bar_customize_indicator_hidden_items_horizontal_icon
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal_buffer: EV_PIXEL_BUFFER is
			--
		once
			Result := icons_8_16_horizontal.tool_bar_customize_indicator_hidden_items_horizontal_icon_buffer
		end

	tool_bar_customize_indicator_with_hidden_items: EV_PIXMAP is
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_hidden_items_icon
		end

	tool_bar_customize_indicator_with_hidden_items_buffer: EV_PIXEL_BUFFER is
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_hidden_items_icon_buffer
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

	floating_tool_bar_icon: ICONS_11_7 is
			--
		local
			l_file_name: FILE_NAME
		once
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("floating_tool_bar_icon.png")
			create Result.make (l_file_name)
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
			create Result.make_with_pixel_buffer (icons_16_16.drag_up_icon_buffer, 16, 16)
		end

	drag_pointer_down: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_16_16.drag_down_icon_buffer, 16, 16)
		end

	drag_pointer_left: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_16_16.drag_left_icon_buffer, 16, 16)
		end

	drag_pointer_right: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_16_16.drag_right_icon_buffer, 16, 16)
		end

	drag_pointer_center: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_16_16.drag_center_icon_buffer, 16, 16)
		end

	drag_pointer_float: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icons_16_16.drag_float_icon_buffer, 16, 16)
		end

feature -- Generated matrix classes

	icons_16_16: ICONS_16_16 is
			--
		local
			l_file_name:FILE_NAME
		once

			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("smart_docking_icon_matrix.png")
			create Result.make (l_file_name)
		end

	icons_8_16: ICONS_8_16 is
			--
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("smart_docking_icon_matrix_8_16.png")
			create Result.make (l_fn)
		end

	icons_8_16_horizontal: ICONS_8_16_HORIZONTAL is
			--
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("smart_docking_icon_matrix_8_16_horizontal.png")
			create Result.make (l_fn)
		end

	icons_10_10: ICONS_10_10 is
			--
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("smart_docking_icon_matrix_10_10.png")
			create Result.make (l_fn)
		end

feature -- Feedback indicators

	arrow_indicator_center: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("center.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_up: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("center_up_light.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_down: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("center_down_light.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_left: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("center_left.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_right: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("center_right.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_center: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("center_center_light.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_up: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("up.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_down: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("down.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_left: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("left.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_right: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("right.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_up_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("up_light.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_down_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("down_light.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_left_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("left_light.png")
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_right_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create Result
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("right_light.png")
			Result.set_with_named_file (l_fn)
		end

feature -- Right click on tabs context tool bars' icons.

	close_context_tool_bar: EV_PIXMAP  is
			-- Redefine
		do
			Result := icons_16_16.zone_close_icon
		end

	close_others: EV_PIXMAP is
			-- Redefine
		do
			Result := icons_16_16.zone_close_others_icon
		end

	close_all: EV_PIXMAP is
			-- Redefine
		do
			Result := icons_16_16.zone_close_all_icon
		end

feature {NONE}  -- Implementation

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the icons
		once
			create Result.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			Result.extend ("images")
		ensure then
			path_valid: Result.is_valid
		end

	internal_shared: SD_SHARED
			-- All singletons

invariant

	internal_shared_not_void: internal_shared /= Void

indexing
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end
