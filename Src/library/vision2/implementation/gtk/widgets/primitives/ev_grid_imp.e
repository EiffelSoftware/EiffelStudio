indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		GTK implementation.
			]"
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
			set_deny_cursor
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

	make (an_interface: like interface) is
			-- Create grid
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0))
		end

	initialize is
			-- Initialize `Current'
		do
			Precursor {EV_CELL_IMP}
			initialize_grid
			set_focused_selection_color (create {EV_COLOR}.make_with_8_bit_rgb (83, 85, 161))
			
			--set_focused_selection_color (color_from_state (False, {EV_GTK_EXTERNALS}.gtk_state_selected_enum))
			
			--set_non_focused_selection_color (color_from_state (False, {EV_GTK_EXTERNALS}.gtk_state_active_enum))
			
			set_non_focused_selection_color (create {EV_COLOR}.make_with_8_bit_rgb (160, 189, 238))
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

	set_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `focused_selection_color'.
		do
			focused_selection_color := a_color
		end
		
	set_non_focused_selection_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `non_focused_selection_color'.
		do
			non_focused_selection_color := a_color
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

	focused_selection_color: EV_COLOR
			-- Color used for selected items while focused.

--	focused_selection_text_color: EV_COLOR is
--			-- Color used for text of selected items while focused.
--		local
--			a_text_field: POINTER
--			a_style: POINTER
--			fg_color: POINTER
--			a_focus_sel_color: POINTER
--			a_r, a_g, a_b: INTEGER
--		once
--			Result := color_from_state (True, {EV_GTK_EXTERNALS}.gtk_state_selected_enum)
--		end
--
--	non_focused_selection_text_color: EV_COLOR is
--			-- Color used for text of selected items while focused.
--		once
--			Result := color_from_state (True, {EV_GTK_EXTERNALS}.gtk_state_active_enum)
--		end

--	color_from_state (use_fg: BOOLEAN; a_state: INTEGER): EV_COLOR is
--			-- Return color of either fg or bg representing `a_state'
--		require
--			a_state_valid: a_state >= {EV_GTK_EXTERNALS}.gtk_state_normal_enum and a_state <= {EV_GTK_EXTERNALS}.gtk_state_insensitive_enum
--		local
--			a_widget: POINTER
--			a_style: POINTER
--			a_color, a_gdk_color, a_gc, a_gc_values: POINTER
--			a_r, a_g, a_b: INTEGER
--		do
--			a_widget := {EV_GTK_EXTERNALS}.gtk_entry_new
--			a_style := {EV_GTK_EXTERNALS}.gtk_widget_struct_style (a_widget)
--			if use_fg then
--				a_gc := gtk_style_struct_text_gc (a_style)
--				--a_color := gtk_style_struct_text (a_style)
--			else
--				a_gc := gtk_style_struct_base_gc (a_style)
--				--a_color := gtk_style_struct_base (a_style)
--			end
--			--a_gc := a_gc + (a_state * pointer_bytes)
--			
--			a_gc_values := {EV_GTK_EXTERNALS}.c_gdk_gcvalues_struct_allocate
--			
--			{EV_GTK_EXTERNALS}.gdk_gc_get_values (a_gc, a_gc_values)
--			
--			a_gdk_color := {EV_GTK_EXTERNALS}.gdk_gcvalues_struct_foreground (a_gc_values)
--			
--			a_color := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
--			
--			{EV_GTK_EXTERNALS}.gdk_colormap_query_color ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, {EV_GTK_EXTERNALS}.gdk_color_struct_pixel (a_gdk_color), a_color)
--			
--			a_gdk_color := a_color
--			
--			
--			
--			--a_gdk_color := a_color + (a_state * pointer_bytes)
--			a_r := {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_gdk_color)
--			a_g := {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_gdk_color)
--			a_b := {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_gdk_color)
--			{EV_GTK_EXTERNALS}.object_unref (a_widget)
--			a_gc_values.memory_free
--			a_color.memory_free
--			create Result
--			Result.set_rgb_with_16_bit (a_r, a_g, a_b)			
--		end

	non_focused_selection_color: EV_COLOR
			-- Color used for selected items while not focused.

	non_focused_selection_text_color: EV_COLOR is
			-- Color used for text of selected items while not focused.
		once
			create Result.make_with_8_bit_rgb (196, 236, 253)
		end

	focused_selection_text_color: EV_COLOR is
			-- Color used for text of selected items while not focused.
		once
			create Result.make_with_8_bit_rgb (239, 251, 254)
		end
--
--feature {NONE} -- Externals
--
--	gtk_style_struct_fg (p: POINTER): POINTER is
--		external
--			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&fg"
--		end
--
--	gtk_style_struct_bg (p: POINTER): POINTER is
--		external
--			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&bg"
--		end
--
--	gtk_style_struct_base (p: POINTER): POINTER is
--		external
--			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&text"
--		end
--
--	gtk_style_struct_text (p: POINTER): POINTER is
--		external
--			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&base"
--		end
--
--	gtk_style_struct_base_gc (p: POINTER): POINTER is
--		external
--			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&text_gc"
--		end
--
--	gtk_style_struct_text_gc (p: POINTER): POINTER is
--		external
--			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&base_gc"
--		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
