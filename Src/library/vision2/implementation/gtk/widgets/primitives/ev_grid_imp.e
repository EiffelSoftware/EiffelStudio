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
			enable_capture,
			disable_capture,
			has_capture,
			set_default_colors
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

				-- Initialize colors from gtk style.
			set_focused_selection_color (color_from_state (base_style, {EV_GTK_EXTERNALS}.gtk_state_selected_enum))
			set_non_focused_selection_color (color_from_state (base_style, {EV_GTK_EXTERNALS}.gtk_state_active_enum))
			set_focused_selection_text_color (color_from_state (text_style, {EV_GTK_EXTERNALS}.gtk_state_selected_enum))
			set_non_focused_selection_text_color (color_from_state (text_style, {EV_GTK_EXTERNALS}.gtk_state_active_enum))

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

	string_size (s: STRING; f: EV_FONT; tuple: TUPLE [INTEGER, INTEGER]) is
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			a_font_imp: EV_FONT_IMP
			a_pango_layout: POINTER
			a_cs: EV_GTK_C_STRING
			a_width, a_height: INTEGER
			l_app_imp: like app_implementation
		do
			if s.is_empty then
				tuple.put_integer (0, 1)
				tuple.put_integer (0, 2)
			else
				a_font_imp ?= f.implementation
				l_app_imp := app_implementation
				a_pango_layout := l_app_imp.pango_layout
				a_cs := l_app_imp.c_string_from_eiffel_string (s)
				{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
				{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, a_font_imp.font_description)
				{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_get_pixel_size (a_pango_layout, $a_width, $a_height)
				{EV_GTK_DEPENDENT_EXTERNALS}.pango_layout_set_font_description (a_pango_layout, default_pointer)
				tuple.put_integer (a_width, 1)
				tuple.put_integer (a_height, 2)
			end
		end

	color_from_state (style_type, a_state: INTEGER): EV_COLOR is
			-- Return color of either fg or bg representing `a_state'
		require
			a_state_valid: a_state >= {EV_GTK_EXTERNALS}.gtk_state_normal_enum and a_state <= {EV_GTK_EXTERNALS}.gtk_state_insensitive_enum
		local
			a_widget, a_style: POINTER
			a_gdk_color: POINTER
			a_r, a_g, a_b: INTEGER
		do
			a_widget := {EV_GTK_EXTERNALS}.gtk_menu_item_new
			a_style := {EV_GTK_EXTERNALS}.gtk_rc_get_style (a_widget)
				-- Style is cached so it doesn't need to be unreffed.

			inspect
				style_type
			when text_style  then
				a_gdk_color := {EV_GTK_EXTERNALS}.gtk_style_struct_text (a_style)
			when base_style then
				a_gdk_color := {EV_GTK_EXTERNALS}.gtk_style_struct_base (a_style)
			when bg_style then
				a_gdk_color := {EV_GTK_EXTERNALS}.gtk_style_struct_bg (a_style)
			when fg_style then
				a_gdk_color := {EV_GTK_EXTERNALS}.gtk_style_struct_fg (a_style)
			end

			a_gdk_color := a_gdk_color + (a_state * {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
			a_r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_gdk_color)
			a_g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_gdk_color)
			a_b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_gdk_color)
			{EV_GTK_EXTERNALS}.gtk_widget_destroy (a_widget)
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

