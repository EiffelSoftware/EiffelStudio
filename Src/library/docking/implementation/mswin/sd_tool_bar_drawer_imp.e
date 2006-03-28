indexing
	description: "Windows SD_TOOL_BAR_DRAWER implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I
		rename
			to_sepcial_state as to_mswin_state
		end

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

	make (a_tool_bar: SD_TOOL_BAR) is
			-- Creation method
		require
			not_void: a_tool_bar /= Void
		do
			tool_bar := a_tool_bar
			init_theme
		ensure
			set: tool_bar = a_tool_bar
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

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Redefine
		local
			l_imp: WEL_WINDOW
			l_shared_font: WEL_SHARED_FONTS
			l_wel_bitmap: WEL_BITMAP
			l_color_imp: EV_COLOR_IMP
			l_background_pixmap: EV_PIXMAP
			l_background_pixmap_state: EV_PIXMAP_IMP_STATE
		do
			internal_rectangle := a_rectangle
			l_imp ?= tool_bar.implementation
			check not_void: l_imp /= Void end

			create {WEL_CLIENT_DC} internal_client_dc.make (l_imp)
			internal_client_dc.get

			create {WEL_MEMORY_DC}internal_buffered_dc.make_by_dc (internal_client_dc)

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
			create l_background_pixmap.make_with_size (tool_bar.width, tool_bar.height)
			l_background_pixmap.set_background_color (tool_bar.background_color)
			l_background_pixmap.clear
			l_background_pixmap_state ?= l_background_pixmap.implementation
			check not_void: l_background_pixmap_state /= Void end
			internal_buffered_dc.draw_bitmap (l_background_pixmap_state.get_bitmap, internal_rectangle.left, internal_rectangle.top, internal_rectangle.width, internal_rectangle.height)

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
			l_brush: WEL_BRUSH
		do
			l_vision_rect := a_arguments.item.rectangle

			create l_rect.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right, l_vision_rect.bottom)

			if a_arguments.item.state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
				theme_drawer.draw_button_edge (internal_buffered_dc, to_mswin_state (a_arguments.item.state), l_rect)
			end
			create l_brush.make_solid (internal_buffered_dc.background_color)
			theme_drawer.draw_theme_background (theme_data, internal_buffered_dc, part_constants_by_type (a_arguments.item), to_mswin_state (a_arguments.item.state), l_rect, Void, l_brush)

			draw_pixmap (internal_buffered_dc, a_arguments)
			draw_text (internal_buffered_dc, a_arguments)

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
		do
			l_button ?= a_arguments.item
			if l_button /= Void and then l_button.pixmap /= Void then
				l_pixmap_state ?= l_button.pixmap.implementation
				check not_void: l_pixmap_state /= Void end
				l_wel_bitmap := l_pixmap_state.get_bitmap
				l_wel_bitmap.decrement_reference
				if l_pixmap_state.has_mask then
					l_mask_bitmap := l_pixmap_state.get_mask_bitmap
				end
				l_coordinate := l_button.pixmap_position
				theme_drawer.draw_bitmap_on_dc (a_dc_to_draw, l_wel_bitmap, l_mask_bitmap, l_coordinate.x, l_coordinate.y, a_arguments.item.is_sensitive)

				if l_mask_bitmap /= Void then
					l_mask_bitmap.decrement_reference
				end
			end
		end

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

invariant
	not_void: theme_drawer /= Void

end
