indexing
	description: "List of default colors used by the system.%
		% Gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP

feature -- Access

	default_background_color, Color_dialog, Color_3d_face, Color_read_only, Color_read_write: EV_COLOR is
			-- Color usely used for the background of dialogs
		do
			Result := color_from_state (bg_style, {EV_GTK_EXTERNALS}.gtk_state_normal_enum)
		end

	default_foreground_color, Color_dialog_fg, Color_3d_highlight, Color_3d_shadow: EV_COLOR is
			-- Color usely used for the foreground of dialogs
		do
			Result := color_from_state (fg_style, {EV_GTK_EXTERNALS}.gtk_state_normal_enum)
		end

feature {NONE} -- Implementation

	color_from_state (style_type, a_state: INTEGER): EV_COLOR is
			-- Return color of either fg or bg representing `a_state'
		require
			a_state_valid: a_state >= {EV_GTK_EXTERNALS}.gtk_state_normal_enum and a_state <= {EV_GTK_EXTERNALS}.gtk_state_insensitive_enum
		local
			a_widget, a_style: POINTER
			a_gdk_color: POINTER
			a_r, a_g, a_b: INTEGER
		do
			a_widget := {EV_GTK_EXTERNALS}.gtk_event_box_new
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

	text_style, base_style, fg_style, bg_style: INTEGER is unique;
		-- Different coloring styles used in gtk.

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




end -- class EV_STOCK_COLORS_IMP

