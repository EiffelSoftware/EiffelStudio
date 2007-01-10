indexing
	description: "Windows implementation of SD_NOTEBOOK_TAB_DRAWER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		-- And use it's `draw_edge', `internal_background_brush'
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

create
	make

feature{NONE} -- Initlization

	make is
			-- Creation method
		local
			l_env: EV_ENVIRONMENT
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I}
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

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Redefine
		do
			expose_unselected_or_hot (a_width, a_tab_info, False)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Redefine
		local
			l_wel_rect: WEL_RECT
			l_brush: WEL_BRUSH

			l_pixmap_imp: EV_PIXMAP_IMP_DRAWABLE
			l_bitmap: WEL_BITMAP
			l_bitmap_dc: WEL_MEMORY_DC
		do
			start_draw

			l_pixmap_imp ?= buffer_pixmap.implementation
			check not_void: l_pixmap_imp /= Void end
			l_bitmap_dc := l_pixmap_imp.dc
			l_bitmap := l_bitmap_dc.bitmap

			l_brush := internal_background_brush
			create l_wel_rect.make (0, 0, a_width, buffer_pixmap.height)

			if theme_data /= default_pointer then
				draw_xp_selected_tab (l_bitmap_dc, l_bitmap, a_tab_info, l_wel_rect, l_brush)
			else
				draw_classic_selected_tab (l_bitmap_dc, l_bitmap, a_tab_info, l_wel_rect, l_brush)
			end

			l_brush.delete
			l_wel_rect.dispose

			draw_pixmap_text_selected (buffer_pixmap, 0, a_width)

			end_draw
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Redefine
		do
			expose_unselected_or_hot (a_width, a_tab_info, True)
		end

feature{NONE} -- Implementation

	draw_xp_selected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_wel_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use theme manager to draw selected tab.
		local
			l_helper: WEL_BITMAP_HELPER
		do
			if a_info.is_tab_before then
				if a_info.is_tab_after then
					-- There is tab before and after
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_selected, a_wel_rect, Void, a_brush)
				else
					-- There is tab before but no tab after
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_selected, a_wel_rect, Void, a_brush)
				end
			else
				if a_info.is_tab_after then
					-- There is no tab before but a tab after
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_selected, a_wel_rect, Void, a_brush)
				else
					-- There is no tab before and after
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttibes_selected, a_wel_rect, Void, a_brush)
				end
			end

			if not is_top_side_tab then
				a_bitmap_dc.unselect_bitmap
				-- We need to mirror bitmaps, because Windows XP theme manager only support draw top tabs.
				create l_helper
				l_helper.mirror_image (a_bitmap)
				a_bitmap_dc.select_bitmap (a_bitmap)
			end
		end

	draw_xp_unselected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use theme manager to draw unselected tab.
		local
			l_temp_rect: WEL_RECT
		do
			create l_temp_rect.make (a_rect.left, a_rect.top + 2, a_rect.right, a_rect.bottom)
			if a_info.is_tab_before then
				if a_info.is_tab_after then
					-- There is tab before and tab after
					if a_info.is_tab_before_selected then
						l_temp_rect.set_left (l_temp_rect.left)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_normal, l_temp_rect, Void, a_brush)
					elseif a_info.is_tab_after_selected then
						l_temp_rect.set_right (l_temp_rect.right + 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_normal, l_temp_rect, Void, a_brush)
					else
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_normal, l_temp_rect, Void, a_brush)
					end
				else
					-- There is tab before, but no tab after
					if a_info.is_tab_before_selected then
						l_temp_rect.set_left (l_temp_rect.left - 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_normal, l_temp_rect, Void, a_brush)
					else
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_normal, l_temp_rect, Void, a_brush)
					end
				end
			else
				if a_info.is_tab_after then
					-- There is no tab before, but a tab after
					if a_info.is_tab_after_selected then
						l_temp_rect.set_right (l_temp_rect.right + 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_normal, l_temp_rect, Void, a_brush)
					else
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_normal, l_temp_rect, Void, a_brush)
					end
				else
					-- There is no tab before and after
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitembothedge, {WEL_THEME_TTI_CONSTANTS}.ttibes_normal, l_temp_rect, Void, a_brush)
				end
			end
		end

	draw_xp_hot_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use theme manager to draw unselected tab.
		local
			l_temp_rect: WEL_RECT
		do
			create l_temp_rect.make (a_rect.left, a_rect.top + 2, a_rect.right, a_rect.bottom)
			if a_info.is_tab_before then
				if a_info.is_tab_after then
					-- There is tab before and tab after
					if a_info.is_tab_before_selected then
						l_temp_rect.set_left (l_temp_rect.left - 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_hot, l_temp_rect, Void, a_brush)
					elseif a_info.is_tab_after_selected then
						l_temp_rect.set_right (l_temp_rect.right + 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_hot, l_temp_rect, Void, a_brush)
					else
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitem, {WEL_THEME_TTI_CONSTANTS}.ttis_hot, l_temp_rect, Void, a_brush)
					end
				else
					-- There is tab before, but no tab after
					if a_info.is_tab_before_selected then
						l_temp_rect.set_left (l_temp_rect.left - 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_hot, l_temp_rect, Void, a_brush)
					else
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemrightedge, {WEL_THEME_TTI_CONSTANTS}.ttires_hot, l_temp_rect, Void, a_brush)
					end
				end
			else
				if a_info.is_tab_after then
					-- There is no tab before, but a tab after
					if a_info.is_tab_after_selected then
						l_temp_rect.set_right (l_temp_rect.right + 2)
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_hot, l_temp_rect, Void, a_brush)
					else
						theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitemleftedge, {WEL_THEME_TTI_CONSTANTS}.ttiles_hot, l_temp_rect, Void, a_brush)
					end
				else
					-- There is no tab before and after
					theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, {WEL_THEME_PART_CONSTANTS}.tabp_tabitembothedge, {WEL_THEME_TTI_CONSTANTS}.ttibes_hot, l_temp_rect, Void, a_brush)
				end
			end
		end

	draw_classic_selected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use GDI to draw classic tab.
		do
			theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, 0, 0, a_rect, Void, a_brush)

			if a_info.is_tab_before then
				if a_info.is_tab_after then
					-- There is tab after and tab before
					draw_classic_tab (a_bitmap_dc, a_rect, is_top_side_tab)
				else
					-- There is tab before but no tab after
					draw_classic_tab (a_bitmap_dc, a_rect, is_top_side_tab)
				end
			else
				if a_info.is_tab_after then
					-- There is no tab before, but a tab after
					draw_classic_tab (a_bitmap_dc, a_rect, is_top_side_tab)
				else
					-- There is no tab before and no tab after
					draw_classic_tab (a_bitmap_dc, a_rect, is_top_side_tab)
				end
			end
		end

	draw_classic_unselected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH) is
			-- Use GDI to draw classic tab.
		local
			l_temp_rect: WEL_RECT
		do
			theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, 0, 0, a_rect, Void, a_brush)
			if is_top_side_tab then
				create l_temp_rect.make (a_rect.left, a_rect.top + 2, a_rect.right, a_rect.bottom)
			else
				create l_temp_rect.make (a_rect.left, a_rect.top, a_rect.right, a_rect.bottom - 2)
			end

			if a_info.is_tab_before then
				if a_info.is_tab_after then
					-- There is tab before and tab after
					if a_info.is_tab_before_selected then
						l_temp_rect.set_left (l_temp_rect.left - 2)
						draw_classic_tab (a_bitmap_dc, l_temp_rect, is_top_side_tab)
					elseif a_info.is_tab_after_selected then
						l_temp_rect.set_right (l_temp_rect.right + 2)
					else
					end
				else
					-- There is tab before, but no tab after
					if a_info.is_tab_before_selected then
						l_temp_rect.set_left (l_temp_rect.left - 2)
					else
					end
				end
			else
				if a_info.is_tab_after then
					-- There is no tab before, but a tab after
					if a_info.is_tab_after_selected then
						l_temp_rect.set_right (l_temp_rect.right + 2)
					else
					end
				else
					-- There is no tab before and after
				end
			end
			draw_classic_tab (a_bitmap_dc, l_temp_rect, is_top_side_tab)
		end

	expose_unselected_or_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO; a_hot: BOOLEAN) is
			-- If is `a_hot' then draw hot tab, otherwise draw normal unselect tab.
		local
			l_pixmap_imp: EV_PIXMAP_IMP_DRAWABLE
			l_buffer_dc: WEL_MEMORY_DC
			l_buffer_pixmap: WEL_BITMAP

			l_wel_rect: WEL_RECT
			l_brush: WEL_BRUSH
			l_helper: WEL_BITMAP_HELPER
		do
			start_draw

			l_pixmap_imp ?= buffer_pixmap.implementation
			check not_void: l_pixmap_imp /= Void end

			l_buffer_dc := l_pixmap_imp.dc

			l_brush := internal_background_brush

			create l_wel_rect.make (0, 0, a_width, buffer_pixmap.height)

			if theme_data /= default_pointer then
				if a_hot then
					draw_xp_hot_tab (l_buffer_dc, l_buffer_pixmap, a_tab_info, l_wel_rect, l_brush)
				else
					draw_xp_unselected_tab (l_buffer_dc, l_buffer_pixmap, a_tab_info, l_wel_rect, l_brush)
				end
			else
				-- There no hot stat for classic
				draw_classic_unselected_tab (l_buffer_dc, l_buffer_pixmap, a_tab_info, l_wel_rect, l_brush)
			end

			if theme_data /= default_pointer and then not is_top_side_tab then
				-- We need to mirror bitmaps, because Windows XP theme manager only support draw top tabs.
				l_buffer_pixmap := l_buffer_dc.bitmap
				l_buffer_dc.unselect_bitmap
				create l_helper
				l_helper.mirror_image (l_buffer_pixmap)
				l_buffer_dc.select_bitmap (l_buffer_pixmap)
			end

			l_brush.delete
			l_wel_rect.dispose

			draw_pixmap_text_unselected (buffer_pixmap , 0, a_width)

			end_draw
		end

	draw_classic_tab (a_dc: WEL_DC; a_rect: WEL_RECT; a_is_top: BOOLEAN) is
			-- Draw classic tab.
		do
			if a_is_top then
				draw_classic_tab_top (a_dc, a_rect)
			else
				draw_classic_tab_down (a_dc, a_rect)
			end
		end

	draw_classic_tab_top (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Draw classic tab at top side.
		local
			l_color: WEL_COLOR_REF
			l_drawer: SD_CLASSIC_THEME_DRAWER
		do
			create l_drawer

			-- Draw | at left
			l_color := l_drawer.rhighlight
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.top + 2, a_rect.left, a_rect.bottom, l_color)

			-- Draw . at left top
			l_drawer.draw_line (a_dc, a_rect.left + 1, a_rect.top + 1, a_rect.left + 1, a_rect.top + 2, l_color)

			-- Draw - at top
			l_drawer.draw_line (a_dc, a_rect.left + 2, a_rect.top, a_rect.right - 2, a_rect.top, l_color)

			-- Draw | at right
			l_color := l_drawer.rshadow
			l_drawer.draw_line (a_dc, a_rect.right - 2, a_rect.top + 2, a_rect.right - 2, a_rect.bottom, l_color)
			l_color := l_drawer.rdark_shadow
			l_drawer.draw_line (a_dc, a_rect.right - 1, a_rect.top + 2, a_rect.right - 1, a_rect.bottom, l_color)

			-- Draw a at right top
			l_drawer.draw_line (a_dc, a_rect.right - 2, a_rect.top + 1, a_rect.right - 2, a_rect.top + 2, l_color)

		end

	draw_classic_tab_down (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Draw classic tabs which at bottom side.
		local
			l_color: WEL_COLOR_REF
			l_drawer: SD_CLASSIC_THEME_DRAWER
		do
			create l_drawer

			-- Draw | at left
			l_color := l_drawer.rhighlight
			l_drawer.draw_line (a_dc, a_rect.left, a_rect.top, a_rect.left, a_rect.bottom - 2, l_color)

			-- Draw . at left top
			l_drawer.draw_line (a_dc, a_rect.left + 1, a_rect.bottom - 2, a_rect.left + 1, a_rect.bottom - 3, l_color)

			-- Draw - at bottom
			l_color := l_drawer.rshadow
			l_drawer.draw_line (a_dc, a_rect.left + 2, a_rect.bottom - 2, a_rect.right - 2, a_rect.bottom - 2, l_color)
			l_color := l_drawer.rdark_shadow
			l_drawer.draw_line (a_dc, a_rect.left + 2, a_rect.bottom - 1, a_rect.right - 2, a_rect.bottom - 1, l_color)

			-- Draw | at right
			l_color := l_drawer.rshadow
			l_drawer.draw_line (a_dc, a_rect.right - 2, a_rect.top, a_rect.right - 2, a_rect.bottom - 2, l_color)
			l_color := l_drawer.rdark_shadow
			l_drawer.draw_line (a_dc, a_rect.right - 1, a_rect.top, a_rect.right - 1, a_rect.bottom - 2, l_color)

			-- Draw a at right bottom
			l_drawer.draw_line (a_dc, a_rect.right - 2, a_rect.bottom - 2, a_rect.right - 2, a_rect.bottom - 3, l_color)

		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP)
			-- Redefine
		local
			l_imp: EV_PIXMAP_IMP_DRAWABLE
			l_brush: WEL_BRUSH
			l_rect: WEL_RECT
			l_vision_rect: EV_RECTANGLE
		do
			if (internal_tab.is_hot or internal_tab.is_selected)and is_top_side_tab then

				l_imp ?= a_drawable.implementation

				check not_void: l_imp /= Void end
				create l_brush.make_solid (l_imp.dc.background_color)
				l_vision_rect := close_rectangle

				create l_rect.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right, l_vision_rect.bottom)

				-- Draw hot state background
				if internal_tab.is_pointer_in_close_area then
					if internal_tab.is_pointer_pressed then
						tool_bar_drawer.draw_button_background (l_imp.dc, l_rect, {SD_TOOL_BAR_ITEM_STATE}.pressed, {WEL_THEME_PART_CONSTANTS}.tp_button)
					else
						tool_bar_drawer.draw_button_background (l_imp.dc, l_rect, {SD_TOOL_BAR_ITEM_STATE}.hot, {WEL_THEME_PART_CONSTANTS}.tp_button)
					end
				end

				-- We draw close button
				if internal_tab.is_pointer_pressed and internal_tab.is_pointer_in_close_area then
					a_drawable.draw_pixmap (start_x_close + 1, start_y_close, a_close_pixmap)
				else
					a_drawable.draw_pixmap (start_x_close, start_y_close, a_close_pixmap)
				end
			end
		end

feature {NONE} -- Attributes

	gap_height: INTEGER is 2
	 		-- Redefine

	start_y_position: INTEGER is 0
	 		-- Redefine

	start_y_position_text: INTEGER is 3
			-- Redefine

	theme_drawer: EV_THEME_DRAWER_IMP
			-- Theme drawer

	tool_bar_drawer: SD_TOOL_BAR_DRAWER_IMP is
			-- Tool bar drawer
		do
			Result ?= internal_shared.tool_bar_drawer.implementation
		end

	theme_data: POINTER;
			-- Theme data

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
