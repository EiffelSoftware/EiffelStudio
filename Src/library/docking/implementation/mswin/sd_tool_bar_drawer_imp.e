indexing
	description: "Windows SD_TOOL_BAR_DRAWER implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I
		rename
			to_sepcial_state as to_mswin_state
		end

	WEL_CONSTANTS

	EV_BUTTON_IMP
		rename
			make as make_not_use
		export
			{NONE} all
		redefine
			on_wm_theme_changed
		end

create
	make

feature{NONE} -- Initlization

	make is
			-- Creation method
		local
			l_env: EV_ENVIRONMENT
		do
			init_theme
			create l_env
			l_env.application.theme_changed_actions.extend (agent init_theme)
		end

	init_theme is
			-- Initialize theme drawer.
		local
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
			l_tool_bar: EV_TOOL_BAR
			l_wel_tool_bar: WEL_TOOL_BAR
		do
			create l_env
			l_app_imp ?= l_env.application.implementation
			check not_void: l_app_imp /= Void end
			l_app_imp.update_theme_drawer
			theme_drawer := l_app_imp.theme_drawer

			create l_tool_bar
			l_wel_tool_bar ?= l_tool_bar.implementation
			check not_void: l_wel_tool_bar /= Void end
			if theme_data /= default_pointer then
				theme_drawer.close_theme_data (theme_data)
			end
			theme_data := theme_drawer.open_theme_data (l_wel_tool_bar.item, "Toolbar")
		end

feature -- Redefine

	tool_bar: SD_TOOL_BAR
			-- Tool bar which to draw on.

	internal_buffered_dc: WEL_DC
			-- Buffered dc.

	internal_rectangle: EV_RECTANGLE
			-- Whole rectangle ara during a `start_draw' and `end_draw'.

	internal_client_dc: WEL_DC
			-- Dc for tool bar windows implementation.

	is_start_draw_called: BOOLEAN is
			-- Redefine
		do
			if internal_buffered_dc /= Void and internal_client_dc /= Void then
				Result := internal_buffered_dc.exists and internal_client_dc.exists
			end
		end

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Redefine
		do
			tool_bar := a_tool_bar
		end

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Redefine
		local
			l_imp: WEL_WINDOW
			l_shared_font: WEL_SHARED_FONTS
			l_wel_bitmap: WEL_BITMAP
			l_color_imp: EV_COLOR_IMP
			l_background_pixmap: EV_PIXMAP
			l_background_pixmap_state: EV_PIXMAP_IMP_STATE
			l_brush: WEL_BRUSH
		do
			internal_rectangle := a_rectangle
			l_imp ?= tool_bar.implementation
			check not_void: l_imp /= Void end

			create {WEL_CLIENT_DC} internal_client_dc.make (l_imp)
			internal_client_dc.get

			create {WEL_MEMORY_DC} internal_buffered_dc.make_by_dc (internal_client_dc)

			-- We must select font to draw.
			-- See MSDN "Using Windows XP Visual Styles" section about drawThemeText.
			create l_shared_font
			internal_buffered_dc.select_font (l_shared_font.menu_font)

			create l_wel_bitmap.make_compatible (internal_client_dc, tool_bar.width, tool_bar.height)
			internal_buffered_dc.select_bitmap (l_wel_bitmap)
			l_wel_bitmap.dispose

			l_color_imp ?= tool_bar.background_color.implementation
			check not_void: l_color_imp /= Void end
			internal_buffered_dc.set_background_color (l_color_imp)


			-- If we draw background like this, when non-32bits color depth, color will broken.
--			create l_background_pixmap.make_with_size (tool_bar.width, tool_bar.height)
--			l_background_pixmap.set_background_color (tool_bar.background_color)
--			l_background_pixmap.clear
--			l_background_pixmap_state ?= l_background_pixmap.implementation
--			check not_void: l_background_pixmap_state /= Void end
--			internal_buffered_dc.draw_bitmap (l_background_pixmap_state.get_bitmap, internal_rectangle.left, internal_rectangle.top, internal_rectangle.width, internal_rectangle.height)

			-- So we draw background color like this.
			create l_brush.make_solid (l_color_imp)
			internal_buffered_dc.fill_rect (create {WEL_RECT}.make (internal_rectangle.left, internal_rectangle.top, internal_rectangle.right, internal_rectangle.bottom), l_brush)
			l_brush.delete

		ensure then
			set: internal_rectangle = a_rectangle
		end

	end_draw is
			-- Redefine
		local
		do
			internal_client_dc.bit_blt (internal_rectangle.left,
										internal_rectangle.top,
										internal_rectangle.width,
										internal_rectangle.height,
										internal_buffered_dc,
										internal_rectangle.left,
										internal_rectangle.top,
										{WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)

			internal_buffered_dc.unselect_all
			internal_buffered_dc.delete
			internal_client_dc.unselect_all
			internal_client_dc.delete
		end

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Redefine
		local
			l_rect: WEL_RECT
			l_vision_rect: EV_RECTANGLE
		do
			l_vision_rect := a_arguments.item.rectangle

			create l_rect.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right, l_vision_rect.bottom)

			draw_button_background (internal_buffered_dc, l_rect, a_arguments.item.state, part_constants_by_type (a_arguments.item))
			draw_pixmap (internal_buffered_dc, a_arguments)
			draw_text (internal_buffered_dc, a_arguments)

		end

	draw_button_background (a_dc: WEL_DC; a_rect: WEL_RECT; a_state: INTEGER; a_part_constant: INTEGER) is
			-- Draw button background on `a_dc'
		require
			not_void: a_dc /= Void and then a_dc.exists
			not_void: a_rect /= Void and then a_rect.exists
			valid: (create {SD_TOOL_BAR_ITEM_STATE}).is_valid (a_state)
		local
			l_brush: WEL_BRUSH
		do
			if a_state /= {SD_TOOL_BAR_ITEM_STATE}.normal and theme_data = default_pointer then
				if a_state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
					-- We reuse the code here, button check adge is looks same as pressed toggle button.
					theme_drawer.draw_button_edge (a_dc, {WEL_THEME_TS_CONSTANTS}.ts_checked, a_rect)
				elseif a_state = {SD_TOOL_BAR_ITEM_STATE}.checked then
					a_dc.draw_frame_control (a_rect, Wel_drawing_constants.dfcs_button3state, Wel_drawing_constants.dfcs_checked)
				elseif a_state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
					a_dc.draw_frame_control (a_rect, Wel_drawing_constants.dfcs_button3state, Wel_drawing_constants.dfcs_pushed)
				else
					theme_drawer.draw_button_edge (a_dc, to_mswin_state (a_state), a_rect)
				end
			end
			create l_brush.make_solid (a_dc.background_color)
			if theme_data /= default_pointer then
				theme_drawer.draw_theme_background (theme_data, a_dc, a_part_constant, a_state, a_rect, Void, l_brush)
			end
		end

	on_wm_theme_changed is
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
		do
			create l_env
			l_app_imp ?= l_env.application.implementation
			l_app_imp.theme_drawer.close_theme_data (theme_data)
			debug ("docking")
				print ("%N SD_TOOL_BAR_DRAWER_IMP on_wm_theme_change")
			end
		end

feature {NONE} -- Implementation

	theme_data: POINTER
			-- Theme data.

	theme_drawer: EV_THEME_DRAWER_IMP
			-- Theme drawer.

	to_mswin_state (a_state: INTEGER): INTEGER is
			-- Convert from SD_TOOL_BAR_ITEM_STATE to WEL_THEME_TS_CONSTANTS.
		do
			inspect
				a_state
			when {SD_TOOL_BAR_ITEM_STATE}.checked then
				Result := {WEL_THEME_TS_CONSTANTS}.ts_checked
			when {SD_TOOL_BAR_ITEM_STATE}.disabled then
				Result := {WEL_THEME_TS_CONSTANTS}.ts_disabled
			when {SD_TOOL_BAR_ITEM_STATE}.hot then
				Result := {WEL_THEME_TS_CONSTANTS}.ts_hot
			when {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				Result := {WEL_THEME_TS_CONSTANTS}.ts_hotchecked
			when {SD_TOOL_BAR_ITEM_STATE}.normal then
				Result := {WEL_THEME_TS_CONSTANTS}.ts_normal
			when {SD_TOOL_BAR_ITEM_STATE}.pressed then
				Result := {WEL_THEME_TS_CONSTANTS}.ts_pressed
			end
		end

	draw_pixmap (a_dc_to_draw: WEL_DC; a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Draw pixmap
		require
			not_void: a_dc_to_draw /= Void
			exist: a_dc_to_draw.exists
			not_void: a_arguments /= Void
		local
			l_pixmap_state: EV_PIXMAP_IMP_STATE
			l_wel_bitmap, l_mask_bitmap: WEL_BITMAP
			l_coordinate: EV_COORDINATE
			l_button: SD_TOOL_BAR_BUTTON
			l_orignal_pixmap, l_grey_pixmap: EV_PIXMAP

			l_imp: EV_PIXMAP_IMP
		do
			l_button ?= a_arguments.item
			if l_button /= Void and then l_button.pixmap /= Void then
				if not a_arguments.item.is_sensitive then
					l_orignal_pixmap := a_arguments.item.pixmap
					l_grey_pixmap := l_orignal_pixmap.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_orignal_pixmap.width, l_orignal_pixmap.height))

					l_imp ?= l_grey_pixmap.implementation
					check l_imp /= Void end

					arguments := a_arguments
					dc_to_draw := a_dc_to_draw
					pixmap_coordinate := l_button.pixmap_position
					if l_button.pixel_buffer /= Void and (create {WEL_GDIP_STARTER}).is_gdi_plus_installed then
						desaturation_pixel_buffer (l_button.pixel_buffer)
					else
						desaturation (l_grey_pixmap, 1)
					end

					l_pixmap_state ?= l_grey_pixmap.implementation
				else
					l_pixmap_state ?= l_button.pixmap.implementation
				end

				check not_void: l_pixmap_state /= Void end
				l_wel_bitmap := l_pixmap_state.get_bitmap

				if l_pixmap_state.has_mask then
					l_mask_bitmap := l_pixmap_state.get_mask_bitmap
				end
				l_coordinate := l_button.pixmap_position

				if a_arguments.item.is_sensitive then
					theme_drawer.draw_bitmap_on_dc (a_dc_to_draw, l_wel_bitmap, l_mask_bitmap, l_coordinate.x, l_coordinate.y, True)
				else
					-- It already drawn by GDI+.
				end

				l_wel_bitmap.decrement_reference
				if l_mask_bitmap /= Void then
					l_mask_bitmap.decrement_reference
				end
			end
		end

	arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS
			-- Temp arguments during draw desartuated tool bar icons.

	dc_to_draw: WEL_DC
			-- Temp arguments during draw desartuated tool bar icons.

	pixmap_coordinate: EV_COORDINATE
			-- Temp arguments during draw desartuated tool bar icons.

	draw_text (a_dc_to_draw: WEL_DC; a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Draw text
		require
			not_void: a_dc_to_draw /= Void
			exist: a_dc_to_draw.exists
			not_void: a_arguments /= Void
		local
			l_text_rect: WEL_RECT
			l_text_vision_rect: EV_RECTANGLE
			l_text_flags: INTEGER
			l_forground_color: EV_COLOR_IMP
			l_button: SD_TOOL_BAR_BUTTON
		do
			l_button ?= a_arguments.item
			if l_button /= Void and then l_button.text /= Void then
				l_text_flags := {WEL_DT_CONSTANTS}.dt_left | {WEL_DT_CONSTANTS}.dt_vcenter | {WEL_DT_CONSTANTS}.dt_singleline

				l_text_vision_rect := l_button.text_rectangle

				create l_text_rect.make (l_text_vision_rect.x, l_text_vision_rect.y, l_text_vision_rect.right, l_text_vision_rect.bottom)

				l_forground_color ?= (create {EV_STOCK_COLORS}).default_foreground_color.implementation
				check not_void: l_forground_color /= Void end
				theme_drawer.draw_text (theme_data, a_dc_to_draw, part_constants_by_type (a_arguments.item), to_mswin_state (a_arguments.item.state), l_button.text, l_text_flags, a_arguments.item.is_sensitive, l_text_rect, l_forground_color)
			end
		end

	part_constants_by_type (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Part constants base on `a_item''s type.
		require
			not_void: a_item /= Void
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_button: SD_TOOL_BAR_BUTTON
		do
			l_separator ?= a_item
			l_button ?= a_item

			if l_button /= Void then
				Result := {WEL_THEME_PART_CONSTANTS}.tp_button
			elseif l_separator /= Void then
				if l_separator.is_wrap then
					Result := {WEL_THEME_PART_CONSTANTS}.tp_separatorvert
				else
					Result := {WEL_THEME_PART_CONSTANTS}.tp_separator
				end
			else
				check not_possible: False end
			end
		ensure
			valid: Result = {WEL_THEME_PART_CONSTANTS}.tp_button or Result = {WEL_THEME_PART_CONSTANTS}.tp_separatorvert
				or Result = {WEL_THEME_PART_CONSTANTS}.tp_separator
		end

	desaturation (a_pixmap: EV_PIXMAP; a_k: REAL) is
			-- Desatuation `a_pixmap' with `a_k' when Gdi+ is not available.
		local
			l_intensity: REAL
			l_wel_dc: WEL_MEMORY_DC
			l_bitmap_imp: EV_PIXMAP_IMP_STATE
			l_width_count, l_height_count, l_width, l_height: INTEGER
			l_wel_color,l_new_color: WEL_COLOR_REF
		do
			l_bitmap_imp ?= a_pixmap.implementation
			check not_void: l_bitmap_imp /= Void end
			create l_wel_dc.make
			l_wel_dc.select_bitmap (l_bitmap_imp.get_bitmap)

			from
				l_width := a_pixmap.width
				l_height := a_pixmap.height
			until
				l_width_count >= l_width
			loop
				from
					l_height_count := 0
				until
					l_height_count >= l_height
				loop
					l_wel_color := l_wel_dc.pixel_color (l_width_count, l_height_count)
					l_intensity := 0.3 * l_wel_color.red + 0.59 * l_wel_color.green + 0.11 * l_wel_color.blue
					create l_new_color.make_rgb (
										(l_intensity * a_k + l_wel_color.red * (1 - a_k)).rounded,
										(l_intensity * a_k + l_wel_color.green * (1 - a_k)).rounded,
										(l_intensity * a_k + l_wel_color.blue * (1 - a_k)).rounded)
					l_wel_dc.set_pixel (l_width_count, l_height_count, l_new_color)

					l_height_count := l_height_count + 1
				end
				l_width_count := l_width_count + 1
			end
			l_wel_dc.delete

			dc_to_draw.draw_bitmap (l_bitmap_imp.get_bitmap, pixmap_coordinate.x, pixmap_coordinate.y, a_pixmap.width, a_pixmap.height)
		end

	desaturation_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Disaturation `a_pixel_buffer' when Gdi+ is available.
		require
			not_void: a_pixel_buffer /= Void
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_image: WEL_GDIP_BITMAP

			l_graphics: WEL_GDIP_GRAPHICS
			l_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES
			l_src_rect, l_dest_rect: WEL_RECT
		do

			l_imp ?= a_pixel_buffer.implementation
			check not_void: l_imp /= Void end
			l_image := l_imp.gdip_bitmap

			create l_image_attributes.make
			l_image_attributes.clear_color_key
			l_image_attributes.set_color_matrix (disabled_color_matrix)
			create l_src_rect.make (0, 0, l_image.width, l_image.height)
			create l_dest_rect.make (pixmap_coordinate.x, pixmap_coordinate.y, pixmap_coordinate.x + l_image.width, pixmap_coordinate.y + l_image.height)
			create l_graphics.make_from_dc (dc_to_draw)
			l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (l_image, l_dest_rect, l_src_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)

			l_graphics.destroy_item
			l_dest_rect.dispose
			l_src_rect.dispose
			l_image_attributes.destroy_item
		end

	disabled_color_matrix: WEL_COLOR_MATRIX is
			-- Disable color matrix.
		do
			Result := mulitply_color_matix (disabled_color_matrix_2, disabled_color_matrix_1)
		ensure
			not_void: Result /= Void
		end

	disabled_color_matrix_1: WEL_COLOR_MATRIX is
			-- Disabled color matrix used by GDI+ DrawImage.
			-- See MSDN "A Twist in Color Space"
		do
			create Result.make
			Result.set_m_row (<<0.2125, 0.2125, 0.2125, 0, 0>>, 0) -- Grey scale R channel
			Result.set_m_row (<<0.2577, 0.2577, 0.2577, 0, 0>>, 1) -- Grey scale G channel
			Result.set_m_row (<<0.0361, 0.0361, 0.0361, 0, 0>>, 2) -- Grey scale B channel			
			Result.set_m_row (<<0, 0, 0, 1, 0>>, 3) -- Opacity
			Result.set_m_row (<<0.38, 0.38, 0.38, 0, 1>>, 4) -- Brightness
		ensure
			not_void: Result /= Void
		end

	disabled_color_matrix_2: WEL_COLOR_MATRIX is
			-- Disabled color matrix used by GDI+ DrawImage.
			-- See MSDN "A Twist in Color Space"
		do
			create Result.make
			Result.set_m_row (<<1, 0, 0, 0, 0>>, 0) -- Grey scale R channel
			Result.set_m_row (<<0, 1, 0, 0, 0>>, 1) -- Grey scale G channel
			Result.set_m_row (<<0, 0, 1, 0, 0>>, 2) -- Grey scale B channel			
			Result.set_m_row (<<0, 0, 0, 0.7, 0>>, 3) -- Opacity
			Result.set_m_row (<<0, 0, 0, 0, 0>>, 4) -- Brightness
		ensure
			not_void: Result /= Void
		end

	mulitply_color_matix (a_matrix_1, a_matrix_2: WEL_COLOR_MATRIX): WEL_COLOR_MATRIX is
			-- Mulitply `a_matrix_1' and `a_matrix_2'
		require
			not_void: a_matrix_1 /= Void
			not_void: a_matrix_2 /= Void
		local
			l_i, l_j, l_k: INTEGER
			l_temp_array: ARRAY [REAL]
			l_sum: REAL
		do
			create Result.make
			create l_temp_array.make (0, 4)
			from
				l_j := 0
			until
				l_j > 4
			loop
				from
					l_k := 0
				until
					l_k > 4
				loop
					l_temp_array [l_k] := a_matrix_1.m (l_k, l_j)
					l_k := l_k + 1
				end
				from
					l_i := 0
				until
					l_i > 4
				loop
					l_sum := 0
					from
						l_k := 0
					until
						l_k > 4
					loop
						l_sum := l_sum + a_matrix_2.m (l_i, l_k) * l_temp_array [l_k]
						l_k := l_k + 1
					end
					Result.m (l_i, l_j) := l_sum
					l_i := l_i + 1
				end

				l_j := l_j + 1
			end
		end

invariant
	not_void: theme_drawer /= Void

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
