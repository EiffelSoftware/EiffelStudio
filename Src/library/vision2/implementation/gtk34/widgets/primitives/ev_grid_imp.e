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
			set_default_size_values
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
			destroy,
			interface,
			make,
			old_make,
			needs_event_box,
			set_background_color,
			set_foreground_color
		end

	EV_ANY_HANDLER

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

	old_make (an_interface: attached like interface)
			-- Create grid
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		do
			set_c_object ({GTK}.gtk_event_box_new)
				-- Initialize colors from gtk style.
			set_non_focused_selection_color (color_from_state ({EV_STOCK_COLORS_IMP}.base_style, {GTK}.gtk_state_flag_active_enum))
			set_non_focused_selection_text_color (color_from_state ({EV_STOCK_COLORS_IMP}.text_style, {GTK}.gtk_state_flag_active_enum))
			set_focused_selection_color (color_from_state ({EV_STOCK_COLORS_IMP}.base_style, {GTK}.gtk_state_flag_selected_enum))
			set_focused_selection_text_color (color_from_state ({EV_STOCK_COLORS_IMP}.text_style, {GTK}.gtk_state_flag_selected_enum))

			create_implementation_objects

			Precursor {EV_CELL_IMP}

			initialize_grid
				-- Force a resize of all internal items to make sure everything is updated correctly.
			{GTK}.gtk_container_check_resize (c_object)

			set_is_initialized (True)
		end

	set_default_size_values
			-- <Precursor/>
		do
				-- For gtk3, as it is using cairo_surface, using 30_000 is not possible
				-- due to (huge) memory usage
			Precursor
			buffered_drawable_size := 4_000
			maximum_header_width := 4_000
		end

feature {NONE} -- Dispose

	destroy
		do
			drawable.destroy
			fixed.destroy
			viewport.destroy

			Precursor
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
				if a_font_imp /= Void then
					l_app_imp := app_implementation
					a_pango_layout := l_app_imp.pango_layout
					a_cs := l_app_imp.c_string_from_eiffel_string (s)
					{PANGO}.layout_set_text (a_pango_layout, a_cs.item, a_cs.string_length)
					{PANGO}.layout_set_font_description (a_pango_layout, a_font_imp.font_description)
					{PANGO}.layout_get_pixel_size (a_pango_layout, $a_width, $a_height)
					{PANGO}.layout_set_font_description (a_pango_layout, default_pointer)
					tuple.put_integer (a_width, 1)
					tuple.put_integer (a_height, 2)
				end
			end
		end

	color_from_state (style_type, a_state: INTEGER): EV_COLOR
			-- Return color of either fg or bg representing `a_state'
		require
			a_state_valid: a_state >= {GTK}.gtk_state_flag_normal_enum and a_state <= {GTK}.gtk_state_flag_insensitive_enum
		local
			a_widget: POINTER
		do
			a_widget := {GTK2}.gtk_tree_view_new
			Result := stock_colors_imp.color_from_state (a_widget, style_type, a_state)
			{GTK}.gtk_widget_destroy (a_widget)
		end

	stock_colors_imp: EV_STOCK_COLORS_IMP
		once
			check attached {EV_STOCK_COLORS_IMP} (create {EV_STOCK_COLORS}).implementation as l_imp then
				Result := l_imp
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
