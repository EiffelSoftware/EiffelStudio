indexing
	description: "Windows implementation of SD_NOTEBOOK_TAB_DRAWER_I."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_DRAWER_IMP

inherit
	SD_NOTEBOOK_TAB_DRAWER_I
		redefine
			make
		end

	EV_BUTTON_IMP
		-- We use it as ancestor for export features
		-- And use it's `draw_edge'
		rename
			make as make_not_use,
			text as text_not_use,
			set_text as set_text_not_use,
			pixmap as pixmap_not_use,
			set_pixmap as set_pixmap_not_use,
			width as width_not_use,
			height as height_not_use
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature{NONE} -- Initlization

	make (a_drawing_area: EV_DRAWING_AREA; a_draw_at_top: BOOLEAN) is
			-- Creation method
		local
			l_env: EV_ENVIRONMENT
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_drawing_area, a_draw_at_top)
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
			theme_data := theme_drawer.open_theme_data (l_wel_tool_bar.item, "Tab")
		end

feature -- Commands

	expose_unselected (a_width: INTEGER; a_tab_before, a_tab_after: BOOLEAN) is
			-- Redefine
		local
			l_client_dc: WEL_CLIENT_DC
			l_wel_rect: WEL_RECT
			l_brush: WEL_BRUSH
			l_wel_window: WEL_WINDOW

			l_bitmap: WEL_BITMAP
			l_bitmap_dc: WEL_MEMORY_DC
		do
			l_wel_window ?= internal_drawing_area.implementation
			check not_void: l_wel_window /= Void end
			create l_client_dc.make (l_wel_window)
			l_client_dc.get

			create l_bitmap.make_compatible (l_client_dc, a_width, internal_drawing_area.height)
			create l_bitmap_dc.make
			l_bitmap_dc.select_bitmap (l_bitmap)

			create l_brush.make_solid (l_client_dc.background_color)
			create l_wel_rect.make (0, 0, a_width, internal_drawing_area.height)

			if a_tab_before then
				if a_tab_after then
					theme_drawer.draw_theme_background (theme_data, l_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_normal, l_wel_rect, Void, l_brush)
				else
					theme_drawer.draw_theme_background (theme_data, l_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_normal, l_wel_rect, Void, l_brush)
				end
			else
				if a_tab_after then
					theme_drawer.draw_theme_background (theme_data, l_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_normal, l_wel_rect, Void, l_brush)
				else
					theme_drawer.draw_theme_background (theme_data, l_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitembothedge, {WEL_THEME_TTI_CONSTANTS}.ttibes_normal, l_wel_rect, Void, l_brush)
				end
			end

			if not internal_draw_border_at_top then
				l_bitmap_dc.delete
				-- We need to mirror bitmaps, because Windows XP theme manager only support draw top tabs.
				mirror_image (l_bitmap)
				create l_bitmap_dc.make
				l_bitmap_dc.select_bitmap (l_bitmap)
			end

			-- Finally we bit blt
			l_client_dc.bit_blt (0, 0, l_wel_rect.width, l_wel_rect.height, l_bitmap_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)

			l_brush.delete
			l_client_dc.delete
			l_wel_rect.dispose
			l_bitmap_dc.delete
			l_bitmap.delete

			draw_pixmap_text_unselected (a_width)
		end

	expose_selected (a_width: INTEGER; a_tab_before, a_tab_after: BOOLEAN) is
			-- Redefine
		local
			l_client_dc: WEL_CLIENT_DC
			l_wel_rect: WEL_RECT
			l_brush: WEL_BRUSH
			l_wel_window: WEL_WINDOW

			l_bitmap: WEL_BITMAP
			l_bitmap_dc: WEL_MEMORY_DC
		do
			l_wel_window ?= internal_drawing_area.implementation
			check not_void: l_wel_window /= Void end
			create l_client_dc.make (l_wel_window)
			l_client_dc.get

			create l_bitmap.make_compatible (l_client_dc, a_width, internal_drawing_area.height)
			create l_bitmap_dc.make
			l_bitmap_dc.select_bitmap (l_bitmap)

			create l_brush.make_solid (l_client_dc.background_color)
			create l_wel_rect.make (0, 0, a_width, internal_drawing_area.height)

			if theme_data /= default_pointer then
				draw_xp_selected_tab (l_bitmap_dc, l_bitmap, a_tab_before, a_tab_after, l_wel_rect, l_brush)
			else
				draw_classic_selected_tab (l_bitmap_dc, a_tab_before, a_tab_after, l_wel_rect, l_brush)
			end

			-- Finally we bit blt
			l_client_dc.bit_blt (0, 0, l_wel_rect.width, l_wel_rect.height, l_bitmap_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)

			l_brush.delete
			l_client_dc.delete
			l_wel_rect.dispose
			l_bitmap.delete
			l_bitmap_dc.delete

			draw_pixmap_text_selected (a_width)
		end

feature{NONE} -- Implementation

	mirror_image (a_bitmap: WEL_BITMAP) is
			-- Mirror image
		require
			not_void: a_bitmap /= Void
		local
			l_orignal_dc: WEL_MEMORY_DC
			l_bits: ARRAY [CHARACTER]
			l_info: WEL_BITMAP_INFO
			l_result: INTEGER
		do
			create l_orignal_dc.make

			l_orignal_dc.select_bitmap (a_bitmap)
			l_orignal_dc.get

			create l_info.make_by_dc (l_orignal_dc, a_bitmap, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)
			-- When use SetDiBits/GetDiBits Api, windows require bitmap is not selected by any dc.
			l_orignal_dc.unselect_bitmap

			l_bits := l_orignal_dc.di_bits (a_bitmap, 0, a_bitmap.height, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)

			-- Following line is key to mirror bitmap
			l_info.header.set_height (-l_info.header.height)
			l_result := l_orignal_dc.set_di_bits (a_bitmap, 0, a_bitmap.height, l_bits, l_info, {WEL_DIB_COLORS_CONSTANTS}.dib_rgb_colors)

			l_orignal_dc.delete
		end

	draw_xp_selected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_tab_before, a_tab_after: BOOLEAN; a_wel_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use theme manager to draw selected tab.
		do
			if a_tab_before then
				if a_tab_after then
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_selected, a_wel_rect, Void, a_brush)
				else
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_selected, a_wel_rect, Void, a_brush)
				end
			else
				if a_tab_after then
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_selected, a_wel_rect, Void, a_brush)
				else
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitembothedge, {WEL_THEME_TTI_CONSTANTS}.ttibes_selected, a_wel_rect, Void, a_brush)
				end
			end

			if not internal_draw_border_at_top then
				a_bitmap_dc.unselect_bitmap
				-- We need to mirror bitmaps, because Windows XP theme manager only support draw top tabs.
				mirror_image (a_bitmap)
				a_bitmap_dc.select_bitmap (a_bitmap)
			end
		end

	draw_xp_unselected_tab is
			-- Use theme manager to draw unselected tab.
		do
			to_implement ("Separate xp and classic drawing codes.")
		end

	draw_classic_selected_tab (a_bitmap_dc: WEL_DC; a_tab_before, a_tab_after: BOOLEAN; a_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use GDI to draw classic tab.
		do
			to_implement ("")
			theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, 0, 0, a_rect, Void, a_brush)
			draw_edge (a_bitmap_dc, a_rect, {WEL_DRAWING_ROUTINES_CONSTANTS}.bdr_raisedouter, {WEL_DRAWING_ROUTINES_CONSTANTS}.bf_left | {WEL_DRAWING_ROUTINES_CONSTANTS}.bf_top)
		end

	draw_classic_unselected_tab (a_bitmap_dc: WEL_DC; a_tab_before, a_tab_after: BOOLEAN; a_wel_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use GDI to draw classic tab.
		do
			to_implement ("")
		end

feature {NONE} -- Attributes

	theme_drawer: EV_THEME_DRAWER_IMP
			-- Theme drawer

	theme_data: POINTER
			-- Theme data

end
