indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		Carbon implementation.
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

	make (an_interface: like interface) is
			-- Create grid
		do
			base_make (an_interface)

		end

	initialize is
			-- Initialize `Current'
		do
				-- We need to explicitly show the cell gtk widget as we are not calling the Precursor as the event hookup is not needed.

			initialize_grid

				-- Initialize colors from gtk style.
			set_is_initialized (True)
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			Precursor {EV_CELL_IMP} (a_color)
			redraw_client_area
		end

feature {EV_GRID_ITEM_I} -- Implementation

	extra_text_spacing: INTEGER is
			-- Extra spacing for rows that is added to the height of a row text to make up `default_row_height'.
		do
			Result := 6
		end

	string_size (s: STRING_GENERAL; f: EV_FONT; tuple: TUPLE [INTEGER, INTEGER]) is
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			a_font_imp: EV_FONT_IMP
			a_pango_layout: POINTER
			a_cs: EV_CARBON_CF_STRING
			a_width, a_height: INTEGER
			l_app_imp: like app_implementation
		do
			if s.is_empty then
				tuple.put_integer (0, 1)
				tuple.put_integer (0, 2)
			else
				a_font_imp ?= f.implementation
				l_app_imp := app_implementation

				tuple.put_integer (a_width, 1)
				tuple.put_integer (a_height, 2)
			end
		end

	color_from_state (style_type, a_state: INTEGER): EV_COLOR is
			-- Return color of either fg or bg representing `a_state'
		local
			a_widget, a_style: POINTER
			a_gdk_color: POINTER
			a_r, a_g, a_b: INTEGER
		do
				-- Style is cached so it doesn't need to be unreffed.
			create Result
			Result.set_rgb_with_16_bit (a_r, a_g, a_b)
		end

	text_style, base_style, fg_style, bg_style: INTEGER is unique
		-- Different coloring styles used in gtk.

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end

