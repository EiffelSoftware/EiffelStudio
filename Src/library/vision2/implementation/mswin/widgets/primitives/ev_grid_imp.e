indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		MSWindows implementation.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_IMP

inherit

	EV_CELL_IMP
		rename
			item as cell_item,
			set_item as wel_set_item,
			interface as drawing_area_interface,
			hide_horizontal_scroll_bar as wel_hide_horizontal_scroll_bar,
			show_horizontal_scroll_bar as wel_show_horizontal_scroll_bar,
			hide_vertical_scroll_bar as wel_hide_vertical_scroll_bar,
			show_vertical_scroll_bar as wel_show_vertical_scroll_bar
		undefine
			drop_actions,
			has_focus,
			set_focus,
			set_pebble,
			set_pebble_function,
			conforming_pick_actions,
			pick_actions,
			pick_ended_actions,
			set_accept_cursor,
			set_deny_cursor,
			enable_capture, disable_capture,
			has_capture,
			set_default_colors,
			set_default_key_processing_handler,
			set_pick_and_drop_mode,
			set_drag_and_drop_mode,
			set_target_menu_mode,
			set_configurable_target_menu_mode,
			set_configurable_target_menu_handler
		redefine
			initialize,
			destroy,
			set_background_color,
			set_foreground_color
		end

	EV_GRID_I
		redefine
			interface
		select
			interface
		end

	WEL_SHARED_TEMPORARY_OBJECTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			color_imp: EV_COLOR_IMP
		do
			Precursor {EV_CELL_IMP}
			initialize_grid
			set_is_initialized (True)
			create focused_selection_color
			color_imp ?= focused_selection_color.implementation
			color_imp.set_with_system_id (wel_color_constants.color_highlight)
			create non_focused_selection_color
			color_imp ?= non_focused_selection_color.implementation
			color_imp.set_with_system_id (wel_color_constants.color_btnface)
			create focused_selection_text_color
			color_imp ?= focused_selection_text_color.implementation
			color_imp.set_with_system_id (wel_color_constants.color_highlighttext)
			create non_focused_selection_text_color
			color_imp ?= non_focused_selection_text_color.implementation
			color_imp.set_with_system_id (wel_color_constants.color_btntext)
		end

feature -- Access

	string_size (s: STRING_GENERAL; f: EV_FONT; tuple: TUPLE [width: INTEGER; height: INTEGER]) is
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			font_imp: EV_FONT_IMP
			screen_dc: WEL_SCREEN_DC
			bounding_rect: WEL_RECT
		do
			font_imp ?= f.implementation
			if s.is_empty then
				tuple.width := 0
				tuple.height := 0
			else
				bounding_rect := wel_rect
				bounding_rect.set_rect (0, 0, 32767, 32767)
				create screen_dc
				screen_dc.get
				screen_dc.select_font (font_imp.wel_font)
				screen_dc.draw_text (s, bounding_rect, {WEL_DT_CONSTANTS}.dt_calcrect | {WEL_DT_CONSTANTS}.dt_expandtabs | {WEL_DT_CONSTANTS}.dt_noprefix)
				tuple.width := bounding_rect.width
				tuple.height := bounding_rect.height
				screen_dc.unselect_font
				screen_dc.quick_release
			end
		end

feature {NONE} -- Status setting

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			redraw_client_area
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			redraw_client_area
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			Precursor {EV_CELL_IMP}
		end

	extra_text_spacing: INTEGER is
			-- Extra spacing for rows that is added to the height of a row text to make up `default_row_height'.
		do
			Result := 3
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID;

indexing
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

