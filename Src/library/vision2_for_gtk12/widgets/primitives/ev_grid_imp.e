indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		GTK implementation.
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
			disable_capture,
			enable_capture,
			has_capture
		redefine
			interface,
			initialize,
			make,
			needs_event_box,
			set_background_color,
			set_foreground_color
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False
		-- Needs to be set to True so that `screen_x' and `screen_y' give correct values.

	make (an_interface: like interface) is
			-- Create grid
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
		end

	initialize is
			-- Initialize `Current'
		do
				-- We need to explicitly show the cell gtk widget as we are not calling the Precursor as the event hookup is not needed.
			{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
			initialize_grid
			set_focused_selection_color (create {EV_COLOR}.make_with_8_bit_rgb (83, 85, 161))
			set_non_focused_selection_color (create {EV_COLOR}.make_with_8_bit_rgb (160, 189, 238))
			set_focused_selection_text_color (create {EV_COLOR}.make_with_8_bit_rgb (239, 251, 254))
			set_non_focused_selection_text_color (create {EV_COLOR}.make_with_8_bit_rgb (196, 236, 253))
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

	string_size (s: STRING; f: EV_FONT; tuple: TUPLE [INTEGER, INTEGER]) is
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			a_font_imp: EV_FONT_IMP
			a_tuple: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
		do
			if s.is_empty then
				tuple.put_integer (0, 1)
				tuple.put_integer (0, 2)
			else
				a_font_imp ?= f.implementation
				a_tuple := a_font_imp.string_size (s)
				tuple.put_integer (a_tuple.integer_32_item (1), 1)
				tuple.put_integer (a_tuple.integer_32_item (2), 2)				
			end
		end

	set_focused_selection_text_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `focused_selection_text_color'.
		do
			focused_selection_text_color := a_color
		end
		
	set_non_focused_selection_text_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `non_focused_selection_text_color'.
		do
			non_focused_selection_text_color := a_color
		end

feature {EV_ANY_I} -- Implementation

	extra_text_spacing: INTEGER is
			-- Extra spacing for rows that is added to the height of a row text to make up `default_row_height'.
		do
			Result := 6
		end

	interface: EV_GRID;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

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

