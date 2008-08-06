indexing
	description: "[
					All icons used in the docking library. 
					Client programmer may inherit this class if you want to use your own icons.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ICONS_SINGLETON

feature -- Initlization

	init is
			-- Initlization
		local
			l_shared: SD_SHARED
		do
			create l_shared
			l_shared.set_icons (Current)
		end

feature -- Icons

	unstick: EV_PIXMAP is
			-- Unstick icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	unstick_buffer: EV_PIXEL_BUFFER is
			-- Unstick icon pixel buffer
		do
		end

	stick: 	EV_PIXMAP is
			-- Stick icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	stick_buffer: EV_PIXEL_BUFFER is
			-- Stick icon pixel buffer
		do
		end

	minimize: EV_PIXMAP is
			-- Minimize icon pixmap
		deferred
		ensure
			not_void: Result /= Void
		end

	minimize_buffer: EV_PIXEL_BUFFER is
			-- Minimize icon pixel buffer
		do
		end

	maximize: EV_PIXMAP is
			-- Maximize icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	maximize_buffer: EV_PIXEL_BUFFER is
			-- Maximize icon pixel buffer
		do
		end

	normal: EV_PIXMAP is
			-- Normal icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	normal_buffer: EV_PIXEL_BUFFER is
			-- Normal icon pixel buffer
		do
		end

	close: EV_PIXMAP is
			-- Close icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	close_buffer: EV_PIXEL_BUFFER is
			-- Close icon pixel buffer
		do
		end

	tool_bar_separator_icon: EV_PIXMAP is
			-- Tool bar separator icon.
			-- Which is shown at customize dialog.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_widget_item_icon: EV_PIXMAP is
			-- Tool bar widget item icon.
		local
			l_bitmap: EV_BITMAP
		do
			create Result.make_with_size (16, 16)
			create l_bitmap.make_with_size (16, 16)
			l_bitmap.fill_rectangle (0, 0, 16, 16)
			Result.set_mask (l_bitmap)
		ensure
			not_void: Result /= Void
		end

	hide_tab_indicator_buffer (a_hide_number: INTEGER): EV_PIXEL_BUFFER is
			-- Hide tab indicator pixel buffer.
		require
			vaild: a_hide_number >= 0 and a_hide_number < 1000
		deferred
		ensure
			not_void: Result /= Void
		end

	hide_tab_indicator (a_hide_number: INTEGER): EV_PIXMAP is
			-- Hide tab indicator.
			-- On GTK, because of drawing text on EV_PIXEL_BUFFER doesn't have a good result, Smart Docking library use this feature instead of `hide_tab_indicator_buffer'.
		do
		end

	tool_bar_indicator: EV_PIXMAP is
			-- Indicator for SD_TITLE_BAR, when there is nor enough space to show custom widget.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_indicator_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer indicator for SD_TITLE_BAR, when there is nor enough space to show custom widget.
		do
		end

feature -- Side indicators

	arrow_indicator_up: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at up side of main window.
		deferred
		end

	arrow_indicator_down: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at down side of main window.
		deferred
		end

	arrow_indicator_left: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at left side of main window.
		deferred
		end

	arrow_indicator_right: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at right side of main window.
		deferred
		end

	arrow_indicator_up_lightening: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, hot feedback indicator shown at up side of main window.
		deferred
		end

	arrow_indicator_down_lightening: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, hot feedback indicator shown at down side of main window.
		deferred
		end

	arrow_indicator_left_lightening: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, hot feedback indicator shown at left side of main window.
		deferred
		end

	arrow_indicator_right_lightening: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, hot feedback indicator shown at right side of main window.
		deferred
		end

feature -- Center indicators

	arrow_indicator_center: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at center of a zone.
		deferred
		end

	arrow_indicator_center_lightening_up: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at center of a zone, up side of indicator is hot.
		deferred
		end

	arrow_indicator_center_lightening_down: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at center of a zone, down side of indicator is hot.
		deferred
		end

	arrow_indicator_center_lightening_left: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at center of a zone, left side of indicator is hot.
		deferred
		end

	arrow_indicator_center_lightening_right: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at center of a zone, right side of indicator is hot.
		deferred
		end

	arrow_indicator_center_lightening_center: EV_PIXEL_BUFFER is
			-- We use transparency feedback style, feedback indicator shown at center of a zone, center of indicator is hot.
		deferred
		end

feature -- Old half-tone style icons.

	drag_pointer_up: EV_POINTER_STYLE is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_down: EV_POINTER_STYLE is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_left: EV_POINTER_STYLE is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_right: EV_POINTER_STYLE is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_center: EV_POINTER_STYLE is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_float: EV_POINTER_STYLE is
			-- When user drag a zone, pointer showed when should float.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Tool bars icons.

	tool_bar_customize_indicator: EV_PIXMAP is
			-- Indicator at right side of a Tool bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_buffer: EV_PIXEL_BUFFER is
			-- Indicator at right side of a Tool bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_with_hidden_items: EV_PIXMAP is
			-- Indictor at right side of a tool bar when there is hidden tool bars.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_with_hidden_items_buffer: EV_PIXEL_BUFFER is
			-- Indictor at right side of a tool bar when there is hidden tool bars.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_horizontal: EV_PIXMAP is
			-- `tool_bar_customize_indicator' horizontal version.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_horizontal_buffer: EV_PIXEL_BUFFER is
			-- `tool_bar_customize_indicator' horizontal version.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal: EV_PIXMAP is
			-- `tool_bar_customize_indicator_with_hidden_items' horizontal version.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal_buffer: EV_PIXEL_BUFFER is
			-- `tool_bar_customize_indicator_with_hidden_items' horizontal version.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_floating_customize: EV_PIXMAP is
			-- When tool bar is floating, customize button's pixmap.
		deferred
		ensure
			not_vod: Result /= Void
		end

	tool_bar_floating_close: EV_PIXMAP is
			-- When tool bar if floating, close buttons's pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_dialog: EV_PIXMAP is
			-- Pixmap used by EB_TOOL_BAR_EDITOR_BOX.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_dropdown_buffer: EV_PIXEL_BUFFER is
			-- SD_TOOL_BAR_POPUP_BUTTON's dropdown icon.
		do
		end

feature -- Editor icons

	close_context_tool_bar: EV_PIXMAP  is
			-- "Close" pixmap when user right click one SD_NOTEBOOK_TAB.
		deferred
		ensure
			not_void: Result /= Void
		end

	close_others: EV_PIXMAP is
			-- "Close all but this" pixmap when user right click one SD_NOTEBOOK_TAB.
		deferred
		ensure
			not_void: Result /= Void
		end

	close_all: EV_PIXMAP is
			-- When user click on a SD_NOTEBOOK_TAB, "close all" pixmap shown on context Tool bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	editor_area: EV_PIXEL_BUFFER is
			-- When whole editor area minimized, this icon shown on the editor area
		do
			create Result.make_with_size (16, 16)
		ensure
			not_void: Result /= Void
		end

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
