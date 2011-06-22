note
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
			make
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
			make,
			old_make,
			needs_event_box,
			set_background_color,
			set_foreground_color
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

	old_make (an_interface: like interface)
			-- Create grid
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		do
				-- Initialize colors from gtk style.
			set_focused_selection_color (color_from_state (base_style, {GTK}.gtk_state_selected_enum))
			set_non_focused_selection_color (color_from_state (base_style, {GTK}.gtk_state_active_enum))
			set_focused_selection_text_color (color_from_state (text_style, {GTK}.gtk_state_selected_enum))
			set_non_focused_selection_text_color (color_from_state (text_style, {GTK}.gtk_state_active_enum))

			Precursor {EV_CELL_IMP}

			initialize_grid
				-- Force a resize of all internal items to make sure everything is updated correctly.
			{GTK}.gtk_container_check_resize (c_object)

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
			Result := 3
		end

	string_size (s: READABLE_STRING_GENERAL; f: EV_FONT; tuple: TUPLE [INTEGER, INTEGER])
			-- `Result' contains width and height required to
			-- fully display string `s' in font `f'.
			-- This should be used instead of `string_size' from EV_FONT
			-- as we can perform an optimized implementation which does
			-- not include the horizontal overhang or underhang. This can
			-- make quite a difference on certain platforms.
		local
			a_font_imp: detachable EV_FONT_IMP
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
				check a_font_imp /= Void end
				l_app_imp := app_implementation
				a_pango_layout := l_app_imp.pango_layout
				a_cs := l_app_imp.c_string_from_eiffel_string (s)
				{GTK2}.pango_layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
				{GTK2}.pango_layout_set_font_description (a_pango_layout, a_font_imp.font_description)
				{GTK2}.pango_layout_get_pixel_size (a_pango_layout, $a_width, $a_height)
				{GTK2}.pango_layout_set_font_description (a_pango_layout, default_pointer)
				tuple.put_integer (a_width, 1)
				tuple.put_integer (a_height, 2)
			end
		end

	color_from_state (style_type, a_state: INTEGER): EV_COLOR
			-- Return color of either fg or bg representing `a_state'
		require
			a_state_valid: a_state >= {GTK}.gtk_state_normal_enum and a_state <= {GTK}.gtk_state_insensitive_enum
		local
			a_widget, a_style: POINTER
			a_gdk_color: POINTER
			a_r, a_g, a_b: INTEGER
		do
			a_widget := {GTK}.gtk_menu_item_new
			a_style := {GTK}.gtk_rc_get_style (a_widget)
				-- Style is cached so it doesn't need to be unreffed.

			inspect
				style_type
			when text_style  then
				a_gdk_color := {GTK}.gtk_style_struct_text (a_style)
			when base_style then
				a_gdk_color := {GTK}.gtk_style_struct_base (a_style)
			when bg_style then
				a_gdk_color := {GTK}.gtk_style_struct_bg (a_style)
			when fg_style then
				a_gdk_color := {GTK}.gtk_style_struct_fg (a_style)
			end

			a_gdk_color := a_gdk_color + (a_state * {GTK}.c_gdk_color_struct_size)
			a_r := {GTK}.gdk_color_struct_red (a_gdk_color)
			a_g := {GTK}.gdk_color_struct_green (a_gdk_color)
			a_b := {GTK}.gdk_color_struct_blue (a_gdk_color)
			{GTK}.gtk_widget_destroy (a_widget)
			create Result
			Result.set_rgb_with_16_bit (a_r, a_g, a_b)
		end

	text_style: INTEGER = 1
	base_style: INTEGER = 2
	fg_style: INTEGER = 3
	bg_style: INTEGER = 4;
		-- Different coloring styles used in gtk.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

note
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
