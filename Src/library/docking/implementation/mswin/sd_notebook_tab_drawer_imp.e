note
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
			make,
			expose_selected,
			expose_unselected,
			expose_hot,
			draw_focus_rect
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
			height as height_not_use,
			draw_focus_rect as wel_draw_focus_rect
		export
			{NONE} all
		redefine
			base_make_called
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initlization

	make  (a_tab: SD_NOTEBOOK_TAB)
			-- <Precursor>
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_tab)
			init_theme
			create child_cell -- Only for making void safe compiler happy
			ev_application.theme_changed_actions.extend (agent init_theme)
		end

	init_theme
			-- Initialize theme drawer
		local
			l_tool_bar: EV_TOOL_BAR
			l_theme_drawer: detachable like theme_drawer
		do
			if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
				l_app_imp.update_theme_drawer
				l_theme_drawer := l_app_imp.theme_drawer

				create l_tool_bar
				if attached {WEL_TOOL_BAR} l_tool_bar.implementation as l_wel_tool_bar then
					if theme_data /= default_pointer then
						l_theme_drawer.close_theme_data (theme_data)
					end
					theme_data := l_theme_drawer.open_theme_data (l_wel_tool_bar.item, "Tab")
				else
					check False end -- Implied by design of Vision2
				end
			else
				create {SD_CLASSIC_THEME_DRAWER} l_theme_drawer
			end
			theme_drawer := l_theme_drawer
		end

	base_make_called: BOOLEAN = True
			-- Not breaking the invariant

feature -- Commands

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I}(a_width, a_tab_info)
			expose_unselected_or_hot (a_width, a_tab_info, False)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		local
			l_wel_rect: WEL_RECT
			l_brush: WEL_BRUSH
			l_bitmap: detachable WEL_BITMAP
			l_bitmap_dc: WEL_MEMORY_DC

			l_buffer_pixmap: like buffer_pixmap
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I}(a_width, a_tab_info)
			start_draw

			l_buffer_pixmap := buffer_pixmap
			if l_buffer_pixmap /= Void then
				if attached {EV_PIXMAP_IMP_DRAWABLE} l_buffer_pixmap.implementation as l_pixmap_imp then
					l_bitmap_dc := l_pixmap_imp.dc
					l_bitmap := l_bitmap_dc.bitmap
					if l_bitmap /= Void then
						l_brush := internal_background_brush
						create l_wel_rect.make (0, 0, a_width, l_buffer_pixmap.height + 1)

						if theme_data /= default_pointer then
							draw_xp_selected_tab (l_bitmap_dc, l_bitmap, a_tab_info, l_wel_rect, l_brush)
						else
							draw_classic_selected_tab (l_bitmap_dc, l_bitmap, a_tab_info, l_wel_rect, l_brush)
						end
						l_brush.delete
						l_wel_rect.dispose
					else
						-- Implied by `dc' get from pixmap
						check dc_has_bitmap: False end
					end
				else
					check has_implementation: False end
				end

				draw_pixmap_text_selected (l_buffer_pixmap, 0, a_width)
			else
				check buffer_pixmap_attached: False end -- Implied by postcondition of `buffer_pixmap'				
			end

			end_draw

			if attached tab.parent as l_parent and then l_parent.has_focus then
				tab.draw_focus_rect
			end
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I}(a_width, a_tab_info)
			expose_unselected_or_hot (a_width, a_tab_info, True)
		end

	draw_focus_rect (a_rect: EV_RECTANGLE)
			-- <Precursor>
		local
			l_rect: WEL_RECT
			l_dc: WEL_WINDOW_DC
		do
			if
				attached tab.parent as l_parent and then
				attached {WEL_WINDOW} l_parent.implementation as l_wel_window
			then
				create l_dc.make (l_wel_window)
				l_dc.get

				create l_rect.make (a_rect.left, a_rect.top, a_rect.right, a_rect.bottom)
				wel_draw_focus_rect (l_dc, l_rect)
				l_dc.dispose
			else
				check parent_is_wel_window: False end
			end
		end

feature{NONE} -- Implementation

	draw_xp_selected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_wel_rect: WEL_RECT; a_brush: WEL_BRUSH)
			-- Use theme manager to draw selected tab
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
				;(create {WEL_BITMAP_HELPER}).mirror_image (a_bitmap)
				a_bitmap_dc.select_bitmap (a_bitmap)
			end
		end

	draw_xp_unselected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH)
			-- Use theme manager to draw unselected tab
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

	draw_xp_hot_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH)
			-- Use theme manager to draw unselected tab
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

	draw_classic_selected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH)
			-- Use GDI to draw classic tab
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

	draw_classic_unselected_tab (a_bitmap_dc: WEL_DC; a_bitmap: WEL_BITMAP; a_info: SD_NOTEBOOK_TAB_INFO; a_rect: WEL_RECT; a_brush: WEL_BRUSH)
			-- Use GDI to draw classic tab
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

	expose_unselected_or_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO; a_hot: BOOLEAN)
			-- If is `a_hot' then draw hot tab, otherwise draw normal unselect tab
		local
			l_buffer_dc: WEL_MEMORY_DC
			l_buffer_bitmap: detachable WEL_BITMAP

			l_wel_rect: WEL_RECT
			l_brush: WEL_BRUSH
			l_buffer_pixmap: like buffer_pixmap
		do
			start_draw

			l_buffer_pixmap := buffer_pixmap
			if l_buffer_pixmap /= Void then
				if attached {EV_PIXMAP_IMP_DRAWABLE} l_buffer_pixmap.implementation as l_pixmap_imp then
					l_buffer_dc := l_pixmap_imp.dc

					l_brush := internal_background_brush

					create l_wel_rect.make (0, 0, a_width, l_buffer_pixmap.height)
					l_buffer_bitmap := l_buffer_dc.bitmap
					if l_buffer_bitmap /= Void then
						if theme_data /= default_pointer then
							if a_hot then
								draw_xp_hot_tab (l_buffer_dc, l_buffer_bitmap, a_tab_info, l_wel_rect, l_brush)
							else
								draw_xp_unselected_tab (l_buffer_dc, l_buffer_bitmap, a_tab_info, l_wel_rect, l_brush)
							end
						else
							-- There no hot stat for classic
							draw_classic_unselected_tab (l_buffer_dc, l_buffer_bitmap, a_tab_info, l_wel_rect, l_brush)
						end

						if theme_data /= default_pointer and then not is_top_side_tab then
							-- We need to mirror bitmaps, because Windows XP theme manager only support draw top tabs
							l_buffer_dc.unselect_bitmap
							;(create {WEL_BITMAP_HELPER}).mirror_image (l_buffer_bitmap)
							l_buffer_dc.select_bitmap (l_buffer_bitmap)
						end
					else
						check
							 -- Implied by dc comes from `l_pixmap_dc'
							 dc_has_bitmap: False
						end
					end
					l_brush.delete
					l_wel_rect.dispose
				end

				draw_pixmap_text_unselected (l_buffer_pixmap , 0, a_width)
			else
				check has_buffer_pixmap: False end
			end

			end_draw
		end

	draw_classic_tab (a_dc: WEL_DC; a_rect: WEL_RECT; a_is_top: BOOLEAN)
			-- Draw classic tab
		do
			if a_is_top then
				draw_classic_tab_top (a_dc, a_rect)
			else
				draw_classic_tab_down (a_dc, a_rect)
			end
		end

	draw_classic_tab_top (a_dc: WEL_DC; a_rect: WEL_RECT)
			-- Draw classic tab at top side
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

	draw_classic_tab_down (a_dc: WEL_DC; a_rect: WEL_RECT)
			-- Draw classic tabs which at bottom side
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
			-- <Precursor>
		local
			l_rect: WEL_RECT
			l_vision_rect: EV_RECTANGLE
		do
			if (tab.is_hot or tab.is_selected) and is_top_side_tab then
				if attached {EV_PIXMAP_IMP_DRAWABLE} a_drawable.implementation as l_imp then
					l_vision_rect := close_rectangle

					create l_rect.make (l_vision_rect.left, l_vision_rect.top, l_vision_rect.right, l_vision_rect.bottom)

						-- Draw hot state background.
					if
						tab.is_pointer_in_close_area and then
						attached tool_bar_drawer_imp as l_tool_bar_drawer_imp
					then
						if tab.is_pointer_pressed then
							l_tool_bar_drawer_imp.draw_button_background (l_imp.dc, l_rect, {SD_TOOL_BAR_ITEM_STATE}.pressed, {WEL_THEME_PART_CONSTANTS}.tp_button)
						else
							l_tool_bar_drawer_imp.draw_button_background (l_imp.dc, l_rect, {SD_TOOL_BAR_ITEM_STATE}.hot, {WEL_THEME_PART_CONSTANTS}.tp_button)
						end
					end
				end

					-- We draw close button.
				if tab.is_pointer_pressed and tab.is_pointer_in_close_area then
					a_drawable.draw_pixmap (start_x_close + 1, start_y_close, a_close_pixmap)
				else
					a_drawable.draw_pixmap (start_x_close, start_y_close, a_close_pixmap)
				end
			end
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- <Precursor>
		do
			a_pixmap.set_foreground_color (internal_shared.tab_text_color)
			a_pixmap.set_font (internal_shared.tool_bar_font)
			if is_top_side_tab then
				-- Draw pixmap
				a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, start_y_position + gap_height + 1, pixmap)
				a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, gap_height + start_y_position_text, text, close_clipping_width (a_width))
			else
				-- Draw pixmap
				a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, start_y_position, pixmap)
				-- Draw text
				a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_bottom, text, text_clipping_width (a_width))
			end
			draw_close_button (a_pixmap, internal_shared.icons.close)
		end

	draw_pixmap_text_selected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- <Precursor>
		local
			l_font: EV_FONT
		do
			if a_pixmap.height > 0 then
				-- Draw text
				a_pixmap.set_foreground_color (internal_shared.tab_text_color)
				if a_width - start_x_text_internal >= 0 then
					l_font := internal_shared.tool_bar_font
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
					a_pixmap.set_font (l_font)
					if is_top_side_tab then
						a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height - 1, text, close_clipping_width (a_width))
					else
						a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, 1 + start_y_position_bottom, text, text_clipping_width (a_width))
					end
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if is_top_side_tab then
						a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, start_y_position + gap_height, pixmap)
					else
						a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, start_y_position + 1, pixmap)
					end
				end

				draw_close_button (a_pixmap, internal_shared.icons.close)
			end
		end

feature {NONE} -- Attributes

	gap_height: INTEGER = 2
	 		-- <Precursor>

	start_y_position: INTEGER
	 		-- <Precursor>
	 	do
			if pixmap /= Void then
				Result := (height / 2 - pixmap.height / 2).floor
			else
				Result := start_y_position_text
			end
	 	end

	start_y_position_bottom: INTEGER
			-- Start y drawing bottom text position
		once
			Result := internal_shared.tool_bar_font.height // 8 + 2
		end

	start_y_position_text: INTEGER
			-- Start y drawing top text positioion
		once
			Result := internal_shared.tool_bar_font.height // 8 + 3
		end

	theme_drawer: EV_THEME_DRAWER_IMP
			-- Theme drawer

	tool_bar_drawer_imp: detachable SD_TOOL_BAR_DRAWER_IMP
			-- Tool bar drawer
		do
			if attached {like tool_bar_drawer_imp} internal_shared.tool_bar_drawer.implementation as l_result then
				-- Implied by basic design of {SD_TOOL_BAR_DRAWER}
				Result := l_result
			end
		end

	theme_data: POINTER
			-- Theme data

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
