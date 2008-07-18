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
			on_wm_theme_changed,
			base_make_called
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initlization

	make is
			-- Creation method
		do
			init_theme
			ev_application.theme_changed_actions.extend (agent init_theme)

			create internal_shared
		end

	init_theme is
			-- Initialize theme drawer.
		local
			l_app_imp: EV_APPLICATION_IMP
			l_tool_bar: EV_TOOL_BAR
			l_wel_tool_bar: WEL_TOOL_BAR
		do
			l_app_imp ?= ev_application.implementation
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

	base_make_called: BOOLEAN is True
			-- Not breaking the invariant.

feature -- Redefine

	internal_buffered_dc: WEL_DC
			-- Buffered dc.

	internal_rectangle: EV_RECTANGLE
			-- Whole rectangle ara during a `start_draw' and `end_draw'.

	internal_client_dc: WEL_DC
			-- Dc for tool bar windows implementation.

	is_start_draw_called: BOOLEAN
			-- Redefine

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Redefine
		do
			tool_bar := a_tool_bar
		end

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Redefine
		local
			l_imp: WEL_WINDOW
			l_wel_bitmap: WEL_BITMAP
			l_color_imp: EV_COLOR_IMP
			l_brush: WEL_BRUSH
		do
			internal_rectangle := a_rectangle
			l_imp ?= tool_bar.implementation
			check not_void: l_imp /= Void end

			if l_imp.exists then
				create {WEL_CLIENT_DC} internal_client_dc.make (l_imp)
				internal_client_dc.get

				create {WEL_MEMORY_DC} internal_buffered_dc.make_by_dc (internal_client_dc)

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
			end

			is_start_draw_called := True
		ensure then
			set: internal_rectangle = a_rectangle
		end

	end_draw is
			-- Redefine
		local
		do
			if internal_buffered_dc /= Void then
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

				internal_buffered_dc := Void
				internal_client_dc := Void
			end

			is_start_draw_called := False
		end

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Redefine
		local
			l_rect, l_rect_2: WEL_RECT
			l_vision_rect: EV_RECTANGLE
			l_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
		do
		 	if internal_buffered_dc /= Void then
				l_vision_rect := a_arguments.item.rectangle

				create l_rect.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right, l_vision_rect.bottom)

				l_button ?= a_arguments.item
				if l_button = Void then
					draw_button_background (internal_buffered_dc, l_rect, a_arguments.item.state, part_constants_by_type (a_arguments.item))
				else
					-- Specail handling for SD_TOOL_BAR_DUAL_POPUP_BUTTON background
					if l_button.is_dropdown_area then
						-- Draw the background as a whole without separator
						draw_button_background (internal_buffered_dc, l_rect, a_arguments.item.state, {WEL_THEME_PART_CONSTANTS}.tp_button)
					else
						-- Draw dropdown area which cover the whole background
						create l_rect_2.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right, l_vision_rect.bottom)
						draw_button_background (internal_buffered_dc, l_rect, a_arguments.item.state, {WEL_THEME_PART_CONSTANTS}.tp_button)

						-- Draw front area, overwrite the front
						create l_rect.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right - l_button.dropdrown_width - l_button.gap // 2, l_vision_rect.bottom)
						draw_button_background (internal_buffered_dc, l_rect, a_arguments.item.state, {WEL_THEME_PART_CONSTANTS}.tp_splitbutton)
					end
				end

				draw_pixmap (internal_buffered_dc, a_arguments)
				draw_text (internal_buffered_dc, a_arguments)
		 	end
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
			-- If "theme_data = default_pointer" it means we are in classic theme
			if theme_data = default_pointer then
				if a_state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
					if a_state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
						draw_flat_button_edge_pressed (a_dc, a_rect)
					elseif a_state = {SD_TOOL_BAR_ITEM_STATE}.checked then
						a_dc.draw_frame_control (a_rect, Wel_drawing_constants.dfcs_button3state, Wel_drawing_constants.dfcs_checked)
						draw_flat_button_edge_hot_pressed (a_dc, a_rect)
					elseif a_state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
						draw_flat_button_edge_pressed (a_dc, a_rect)
					else
						draw_flat_button_edge_hot (a_dc, a_rect)
					end
				elseif a_part_constant = {WEL_THEME_PART_CONSTANTS}.tp_separator or a_part_constant = {WEL_THEME_PART_CONSTANTS}.tp_separatorvert then
					draw_classic_separator (a_dc, a_rect, a_part_constant)
				end
			end

			create l_brush.make_solid (a_dc.background_color)
			if theme_data /= default_pointer then
				theme_drawer.draw_theme_background (theme_data, a_dc, a_part_constant, a_state, a_rect, Void, l_brush)
			end
			l_brush.delete
		end

	on_wm_theme_changed is
			-- Redefine
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp ?= ev_application.implementation
			l_app_imp.theme_drawer.close_theme_data (theme_data)
			debug ("docking")
				print ("%N SD_TOOL_BAR_DRAWER_IMP on_wm_theme_change")
			end
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

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
			l_button: SD_TOOL_BAR_BUTTON
		do
			l_button ?= a_arguments.item
			if l_button /= Void and then (l_button.pixmap /= Void or l_button.pixel_buffer /= Void) and l_button.tool_bar /= Void then
				if is_use_gdip (a_arguments) then
					draw_pixel_buffer (a_dc_to_draw, a_arguments)
				else
					draw_pixmap_real (a_dc_to_draw, a_arguments)
				end
			end
		end

	is_use_gdip (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS): BOOLEAN is
			-- If using gdi+ to draw icons?
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			l_button ?= a_arguments.item
			if l_button /= Void then
				Result := l_button.pixel_buffer /= Void and (create {WEL_GDIP_STARTER}).is_gdi_plus_installed
			end
		end

	draw_pixel_buffer (a_dc_to_draw: WEL_DC; a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Draw icons when using gdi+.
		require
			use_gdip: is_use_gdip (a_arguments)
		local
			l_coordinate: EV_COORDINATE
			l_button: SD_TOOL_BAR_BUTTON
			l_dropdown_button: SD_TOOL_BAR_POPUP_BUTTON
			l_graphics: WEL_GDIP_GRAPHICS
			l_buffer_imp, l_dropdown_imp: EV_PIXEL_BUFFER_IMP
			l_dest_rect, l_src_rect: WEL_RECT
			l_dropdown: EV_PIXEL_BUFFER
			l_left: INTEGER
		do
			l_button ?= a_arguments.item
			l_dropdown_button ?= a_arguments.item
			if l_button /= Void and then l_button.pixel_buffer /= Void and l_button.tool_bar /= Void then
				if not a_arguments.item.is_sensitive then
					arguments := a_arguments

					pixmap_coordinate := l_button.pixmap_position
					desaturation_pixel_buffer (l_button.pixel_buffer, a_dc_to_draw)

					if l_dropdown_button /= Void then
						pixmap_coordinate.set_x (l_dropdown_button.dropdown_left)
						desaturation_pixel_buffer (l_dropdown_button.dropdown_pixel_buffer, a_dc_to_draw)
					end
				else
					create l_graphics.make_from_dc (a_dc_to_draw)
					l_buffer_imp ?= l_button.pixel_buffer.implementation
					l_coordinate := l_button.pixmap_position
					create l_dest_rect.make (l_coordinate.x, l_coordinate.y, l_coordinate.x + l_buffer_imp.width, l_coordinate.y + l_buffer_imp.height)
					create l_src_rect.make (0, 0, l_buffer_imp.width, l_buffer_imp.height)
					l_graphics.draw_image_with_dest_rect_src_rect (l_buffer_imp.gdip_bitmap, l_dest_rect, l_src_rect)

					if l_dropdown_button /= Void then
						l_dropdown := l_dropdown_button.dropdown_pixel_buffer
						l_dropdown_imp ?= l_dropdown.implementation
						l_left := l_dropdown_button.dropdown_left

						create l_dest_rect.make (l_left, l_coordinate.y, l_left + l_dropdown.width , l_coordinate.y + l_dropdown.height)
						create l_src_rect.make (0, 0, l_dropdown.width, l_dropdown.height)
						l_graphics.draw_image_with_dest_rect_src_rect (l_dropdown_imp.gdip_bitmap, l_dest_rect, l_src_rect)
					end

					l_graphics.dispose
				end
			end
		end

	draw_pixmap_real (a_dc_to_draw: WEL_DC; a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Draw icons when using gdi.
		local
			l_pixmap_state: EV_PIXMAP_IMP_STATE
			l_wel_bitmap, l_mask_bitmap: WEL_BITMAP
			l_coordinate: EV_COORDINATE
			l_button: SD_TOOL_BAR_BUTTON
			l_orignal_pixmap, l_grey_pixmap: EV_PIXMAP

			l_imp: EV_PIXMAP_IMP
		do
			l_button ?= a_arguments.item
			if l_button /= Void and then l_button.pixmap /= Void and l_button.tool_bar /= Void then
				if not a_arguments.item.is_sensitive then
					l_orignal_pixmap := a_arguments.item.pixmap
					l_grey_pixmap := l_orignal_pixmap.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_orignal_pixmap.width, l_orignal_pixmap.height))

					l_imp ?= l_grey_pixmap.implementation
					check l_imp /= Void end

					arguments := a_arguments

					pixmap_coordinate := l_button.pixmap_position
					desaturation (l_grey_pixmap, 1, a_dc_to_draw)

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
				end

				l_wel_bitmap.decrement_reference
				if l_mask_bitmap /= Void then
					l_mask_bitmap.decrement_reference
				end
			end
		end

	arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS
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
			l_font_button: SD_TOOL_BAR_FONT_BUTTON
			l_width_button: SD_TOOL_BAR_WIDTH_BUTTON
			l_font_imp: EV_FONT_IMP
		do
			l_button ?= a_arguments.item
			l_font_button ?= a_arguments.item
			l_width_button ?= a_arguments.item
			if l_button /= Void and then l_button.text /= Void and l_button.tool_bar /= Void then
				if l_width_button /= Void then
					l_text_flags := {WEL_DT_CONSTANTS}.dt_left | {WEL_DT_CONSTANTS}.dt_vcenter | {WEL_DT_CONSTANTS}.dt_singleline | {WEL_DT_CONSTANTS}.dt_word_ellipsis
				else
					l_text_flags := {WEL_DT_CONSTANTS}.dt_left | {WEL_DT_CONSTANTS}.dt_vcenter | {WEL_DT_CONSTANTS}.dt_singleline
				end
				l_text_vision_rect := l_button.text_rectangle
				create l_text_rect.make (l_text_vision_rect.x, l_text_vision_rect.y, l_text_vision_rect.right, l_text_vision_rect.bottom)

				if l_font_button /= Void and then l_font_button.font /= Void then
					l_font_imp ?= l_font_button.font.implementation
					check not_void: l_font_imp /= Void end
					internal_buffered_dc.select_font (l_font_imp.wel_font)
				else
					-- We must select font to draw.
					-- See MSDN "Using Windows XP Visual Styles" section about drawThemeText.
					l_font_imp ?= internal_shared.tool_bar_font.implementation
					check not_void: l_font_imp /= Void end
					internal_buffered_dc.select_font (l_font_imp.wel_font)

				end
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

	desaturation (a_pixmap: EV_PIXMAP; a_k: REAL; a_dc_to_draw: WEL_DC) is
			-- Desatuation `a_pixmap' with `a_k' when Gdi+ is not available.
		require
			valid: 0 <= a_k  and a_k <= 1
			not_void: a_pixmap /= Void
			not_void: a_dc_to_draw /= Void and then a_dc_to_draw.exists
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

			a_dc_to_draw.draw_bitmap (l_bitmap_imp.get_bitmap, pixmap_coordinate.x, pixmap_coordinate.y, a_pixmap.width, a_pixmap.height)
		end

	desaturation_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_dc_to_draw: WEL_DC) is
			-- Disaturation `a_pixel_buffer' when Gdi+ is available.
		require
			not_void: a_pixel_buffer /= Void
			not_void: a_dc_to_draw /= Void and then a_dc_to_draw.exists
		local
			l_image: WEL_GDIP_BITMAP
			l_imp: EV_PIXEL_BUFFER_IMP
		do
			l_imp ?= a_pixel_buffer.implementation
			check not_void: l_imp /= Void end
			l_image := l_imp.gdip_bitmap

			grayscale_icon_drawer.draw_grayscale_bitmap (l_image, a_dc_to_draw, pixmap_coordinate.x, pixmap_coordinate.y)
		end

	grayscale_icon_drawer: WEL_GDIP_GRAYSCALE_IMAGE_DRAWER
			-- Grayscale icon drawer.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	draw_classic_separator (a_dc: WEL_DC; a_rect: WEL_RECT; a_part_constant: INTEGER) is
			-- Draw separator for classic theme
		require
			not_void: a_dc /= Void
			not_void: a_rect /= Void
			valid: a_part_constant = {WEL_THEME_PART_CONSTANTS}.tp_separator or a_part_constant = {WEL_THEME_PART_CONSTANTS}.tp_separatorvert
		local
			l_drawer: SD_CLASSIC_THEME_DRAWER
			l_color: WEL_COLOR_REF
			l_middle: INTEGER
			l_border: INTEGER
		do
			create l_drawer
			l_border := 3

			if a_part_constant = {WEL_THEME_PART_CONSTANTS}.tp_separator then
				l_middle := a_rect.width // 2

				l_color := l_drawer.rshadow
				l_drawer.draw_line (a_dc, a_rect.left + l_middle - 1, a_rect.top + l_border, a_rect.left + l_middle - 1, a_rect.bottom - l_border, l_color)

				l_color := l_drawer.rhighlight
				l_drawer.draw_line (a_dc, a_rect.left + l_middle, a_rect.top + l_border, a_rect.left + l_middle, a_rect.bottom - l_border, l_color)
			elseif a_part_constant = {WEL_THEME_PART_CONSTANTS}.tp_separatorvert then
				l_middle := a_rect.height // 2

				l_color := l_drawer.rshadow
				l_drawer.draw_line (a_dc, a_rect.left + l_border, a_rect.top + l_middle - 1, a_rect.right - l_border, a_rect.top + l_middle - 1, l_color)

				l_color := l_drawer.rhighlight
				l_drawer.draw_line (a_dc, a_rect.left + l_border, a_rect.top + l_middle, a_rect.right - l_border, a_rect.top + l_middle, l_color)
			end
		end

	draw_flat_button_edge_hot (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Draw flat style button edge when is hot.
		require
			not_void: a_dc /= Void
			not_void: a_rect /= Void
		local
			l_color: WEL_COLOR_REF
			l_drawer: SD_CLASSIC_THEME_DRAWER
		do
			create l_drawer
			-- Draw | at left
			l_color := l_drawer.rhighlight
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.top, a_rect.left, a_rect.bottom, l_color)
			-- Draw - at top
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.top, a_rect.right, a_rect.top, l_color)

			-- Draw | at right
			l_color := l_drawer.rshadow
			l_drawer.draw_line (a_dc, a_rect.right - 1, a_rect.top, a_rect.right - 1, a_rect.bottom, l_color)
			-- Draw _ at bottom	
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.bottom - 1, a_rect.right, a_rect.bottom - 1, l_color)
		end

	draw_flat_button_edge_hot_pressed (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Draw flat style button edge when is hot and checked.
		require
			not_void: a_dc /= Void
			not_void: a_rect /= Void
		local
			l_color: WEL_COLOR_REF
			l_drawer: SD_CLASSIC_THEME_DRAWER
		do
			draw_flat_button_edge_pressed (a_dc, a_rect)

			create l_drawer
			-- Clear extra line drawn by native call
			create l_color.make_system ({WEL_COLOR_CONSTANTS}.color_btnface)
			-- clear top -
			l_drawer.draw_line (a_dc, a_rect.left + 1, a_rect.top + 1, a_rect.right - 1, a_rect.top + 1, l_color)
			-- clear left |
			l_drawer.draw_line (a_dc, a_rect.left + 1, a_rect.top + 1, a_rect.left + 1, a_rect.bottom - 1, l_color)
		end

	draw_flat_button_edge_pressed (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Draw flat style button edge when is pressed.
		require
			not_void: a_dc /= Void
			not_void: a_rect /= Void
		local
			l_color: WEL_COLOR_REF
			l_drawer: SD_CLASSIC_THEME_DRAWER
		do
			create l_drawer

			-- Draw | at left
			l_color := l_drawer.rshadow
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.top, a_rect.left, a_rect.bottom, l_color)
			-- Draw - at top
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.top, a_rect.right, a_rect.top, l_color)

			-- Draw | at right
			l_color := l_drawer.rhighlight
			l_drawer.draw_line (a_dc, a_rect.right - 1, a_rect.top, a_rect.right - 1, a_rect.bottom, l_color)
			-- Draw _ at bottom	
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.bottom - 1, a_rect.right, a_rect.bottom - 1, l_color)
		end

invariant
	not_void: theme_drawer /= Void
	not_void: internal_shared /= Void

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
