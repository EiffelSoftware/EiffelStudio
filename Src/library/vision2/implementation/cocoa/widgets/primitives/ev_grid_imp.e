note
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		Cocoa implementation.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_IMP

inherit
	EV_GRID_I
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface,
			initialize
		end

	EV_CELL_IMP
		rename
			item as cell_item
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
			enable_capture,
			disable_capture,
			has_capture,
			set_default_colors,
			set_default_key_processing_handler,
			set_pick_and_drop_mode,
			set_drag_and_drop_mode,
			set_target_menu_mode,
			set_configurable_target_menu_mode,
			set_configurable_target_menu_handler
		redefine
			interface,
			initialize,
			make,
			set_background_color,
			set_foreground_color
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create grid
		do
			base_make (an_interface)
			create {NS_VIEW}cocoa_item.new
		end

	initialize
			-- Initialize `Current'
--		local
--			color_imp: EV_COLOR_IMP
		do
			Precursor {EV_CELL_IMP}
			initialize_grid

			create focused_selection_color.make_with_rgb (1, 0, 0)
			create non_focused_selection_color.make_with_rgb (1, 1, 0)
			create focused_selection_text_color.make_with_rgb (0, 1, 0)
			create non_focused_selection_text_color.make_with_rgb (0, 0, 1)
--			color_imp ?= non_focused_selection_text_color.implementation

			set_is_initialized (True)
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

feature {EV_GRID_ITEM_I} -- Implementation

	extra_text_spacing: INTEGER
			-- Extra spacing for rows that is added to the height of a row text to make up `default_row_height'.
		do
			Result := 6
		end

	string_size (a_string: STRING_GENERAL; a_font: EV_FONT; tuple: TUPLE [INTEGER, INTEGER])
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			l_font_imp: EV_FONT_IMP
			l_string: NS_STRING
			l_attributes: NS_DICTIONARY
			l_size: NS_SIZE
		do
			if a_string.is_empty then
				tuple.put_integer (0, 1)
				tuple.put_integer (0, 2)
			else
				l_font_imp ?= a_font.implementation
				create l_string.make_with_string (a_string)
				create l_attributes.dictionary_with_object_for_key (l_font_imp.cocoa_item, l_font_imp.cocoa_item.font_attribute_name)
				l_size := l_string.size_with_attributes (l_attributes)

				tuple.put_integer (l_size.width, 1)
				tuple.put_integer (l_size.height, 2)
			end
		end

	color_from_state (style_type, a_state: INTEGER): EV_COLOR
			-- Return color of either fg or bg representing `a_state'
		local
			a_r, a_g, a_b: INTEGER
		do
				-- Style is cached so it doesn't need to be unreffed.
			create Result
			Result.set_rgb_with_16_bit (a_r, a_g, a_b)
		end

	text_style, base_style, fg_style, bg_style: INTEGER = unique

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end

