note
	description: "List of default colors used by the system.%
		% Gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP

feature -- Access

	color_read_write: EV_COLOR
			-- Color used for read write.
		local
			l_widget: POINTER
		do
			l_widget := {GTK}.gtk_entry_new
			Result := color_from_state (l_widget, base_style, {GTK}.gtk_state_flag_normal_enum)
			{GTK}.gtk_widget_destroy (l_widget)
		end

	color_read_only: EV_COLOR
			-- Color used for read only.
		local
			l_widget: POINTER
		do
			l_widget := {GTK}.gtk_entry_new
			Result := color_from_state (l_widget, base_style, {GTK}.gtk_state_flag_insensitive_enum)
			{GTK}.gtk_widget_destroy (l_widget)
		end

	default_background_color, Color_dialog, Color_3d_face: EV_COLOR
			-- Color used for the background of dialogs
		local
			l_widget: POINTER
		do
			l_widget := {GTK2}.gtk_dialog_new
			Result := color_from_state (l_widget, bg_style, {GTK}.gtk_state_flag_normal_enum)
			{GTK}.gtk_widget_destroy (l_widget)
		end

	default_foreground_color, Color_dialog_fg, Color_3d_highlight, Color_3d_shadow: EV_COLOR
			-- Color used for the foreground of dialogs.
		local
			l_widget: POINTER
		do
			l_widget := {GTK2}.gtk_dialog_new
			Result := color_from_state (l_widget, fg_style, {GTK}.gtk_state_flag_normal_enum)
			{GTK}.gtk_widget_destroy (l_widget)
		end

feature {EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	color_from_state (a_widget: POINTER; style_type, a_state: INTEGER): EV_COLOR
			-- Return color of either fg or bg representing `a_state'
		require
			a_state_valid: a_state >= {GTK}.gtk_state_flag_normal_enum and a_state <= {GTK}.gtk_state_flag_insensitive_enum
		local
			a_style: POINTER
			a_gdk_rgba: POINTER
			a_r, a_g, a_b: REAL_32
			gtk_c_string: EV_GTK_C_STRING
		do
			a_style := {GTK}.gtk_widget_get_style_context (a_widget)
				-- Style context if owned by gtk and must not be freed.

			--a_gdk_rgba := {GTK}.c_gdk_rgba_struct_allocate

				-- GTK3 does not recommend using this way, but if we must, the
				-- recommended way is this: saving the context, setting the state,
				-- getting our color, and restoring the context to its initial state.
			{GTK}.gtk_style_context_save(a_style)
			{GTK}.gtk_style_context_set_state (a_style, a_state)
			inspect
				style_type
			when fg_style then
				--{GTK}.gtk_style_context_get_color (a_style, {GTK}.gtk_style_context_get_state (a_style), a_gdk_rgba)
				{GTK2}.gtk_style_context_get (a_style, {GTK}.gtk_style_context_get_state (a_style), {GTK2}.GTK_STYLE_PROPERTY_COLOR, $a_gdk_rgba )
			when bg_style then
--				{GTK}.gtk_style_context_get_background_color (a_style, {GTK}.gtk_style_context_get_state (a_style), a_gdk_rgba)
				--gtk_c_string := "background-color"
				--{GTK2}.gtk_style_context_lookup_color (a_style, gtk_c_string.item, a_gdk_rgba)
				{GTK2}.gtk_style_context_get (a_style, {GTK}.gtk_style_context_get_state (a_style), {GTK2}.GTK_STYLE_PROPERTY_BACKGROUND_COLOR, $a_gdk_rgba )
			when text_style then
				--{GTK}.gtk_style_context_get_color (a_style, {GTK}.gtk_style_context_get_state (a_style), a_gdk_rgba)
				{GTK2}.gtk_style_context_get (a_style, {GTK}.gtk_style_context_get_state (a_style), {GTK2}.GTK_STYLE_PROPERTY_FONT, $a_gdk_rgba )
			when base_style then
--				{GTK}.gtk_style_context_get_background_color (a_style, {GTK}.gtk_style_context_get_state (a_style), a_gdk_rgba)
				gtk_c_string := "background-color"
				--{GTK2}.gtk_style_context_lookup_color (a_style, gtk_c_string.item, a_gdk_rgba)
				{GTK2}.gtk_style_context_get (a_style, {GTK}.gtk_style_context_get_state (a_style), gtk_c_string.item, $a_gdk_rgba )

			end
			{GTK}.gtk_style_context_restore (a_style)

			a_r := {GDK}.rgba_struct_red (a_gdk_rgba).truncated_to_real
			a_g := {GDK}.rgba_struct_green (a_gdk_rgba).truncated_to_real
			a_b := {GDK}.rgba_struct_blue (a_gdk_rgba).truncated_to_real
			debug ("gtk_log")
				if attached {GDK}.rgba_struct_alpha (a_gdk_rgba).truncated_to_real as l_alpha then
					do_nothing -- for debugging purpose.
				end
			end
			create Result.make_with_rgb (a_r, a_g, a_b)
			{GDK}.rgba_free (a_gdk_rgba)
		end

	text_style: INTEGER = 1
	base_style: INTEGER = 2
	fg_style: INTEGER = 3
	bg_style: INTEGER = 4;
		-- Different coloring styles used in gtk.

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




end -- class EV_STOCK_COLORS_IMP

