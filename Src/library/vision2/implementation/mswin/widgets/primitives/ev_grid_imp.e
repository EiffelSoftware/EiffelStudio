note
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
			make,
			interface,
			destroy,
			set_background_color,
			set_foreground_color
		end

	EV_GRID_I
		redefine
			interface
		end

	WEL_SHARED_TEMPORARY_OBJECTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create_implementation_objects
				--| Needed for Void safety.

			focused_selection_color := default_focused_selection_color
			non_focused_selection_color := default_non_focused_selection_color
			focused_selection_text_color := default_focused_selection_text_color
			non_focused_selection_text_color := default_non_focused_selection_text_color

			Precursor {EV_CELL_IMP}
			initialize_grid

			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	default_focused_selection_color: EV_COLOR
			-- Default focused selection color.
		local
			color_imp: detachable EV_COLOR_IMP
		once
			create Result
			color_imp ?= Result.implementation
			check color_imp /= Void then end
			color_imp.set_with_system_id (wel_color_constants.color_highlight)
		end

	default_non_focused_selection_color: EV_COLOR
			-- Default non-focused selection color.
		local
			color_imp: detachable EV_COLOR_IMP
		once
			create Result
			color_imp ?= Result.implementation
			check color_imp /= Void then end
			color_imp.set_with_system_id (wel_color_constants.color_btnface)
		end

	default_focused_selection_text_color: EV_COLOR
			-- Default focused selection text color.
		local
			color_imp: detachable EV_COLOR_IMP
		once
			create Result
			color_imp ?= Result.implementation
			check color_imp /= Void then end
			color_imp.set_with_system_id (wel_color_constants.color_highlighttext)
		end

	default_non_focused_selection_text_color: EV_COLOR
			-- Default non-focused selection text color.
		local
			color_imp: detachable EV_COLOR_IMP
		once
			create Result
			color_imp ?= Result.implementation
			check color_imp /= Void then end
			color_imp.set_with_system_id (wel_color_constants.color_btntext)
		end

feature -- Access

	string_size (s: READABLE_STRING_GENERAL; f: EV_FONT; tuple: TUPLE [width: INTEGER; height: INTEGER])
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			font_imp: detachable EV_FONT_IMP
			l_size_tuple: TUPLE [width: INTEGER; height: INTEGER]
		do
			if s.count = 0 then
				tuple.width := 0
				tuple.height := 0
			else
				font_imp ?= f.implementation
				if font_imp /= Void then
					l_size_tuple := font_imp.string_size_no_offset (s)
					tuple.width := l_size_tuple.width
					tuple.height := l_size_tuple.height
				end
			end
		end

feature {NONE} -- Status setting

	set_background_color (color: EV_COLOR)
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			redraw_client_area
		end

	set_foreground_color (color: EV_COLOR)
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			redraw_client_area
		end

feature {NONE} -- Implementation

	destroy
			-- Destroy `Current'.
		do
			Precursor {EV_CELL_IMP}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
