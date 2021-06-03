note
	description:
		"Eiffel Vision colorizable. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "colorizible"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLORIZABLE_IMP

inherit
	EV_COLORIZABLE_I
		redefine
			interface
		end

feature -- Access

	background_color_internal: EV_COLOR
			-- Color of face.
		local
			l_rgba_color, l_style_context: POINTER
			--gtk_c_string: EV_GTK_C_STRING
		do
			if attached background_color_imp as l_background_color_imp then
				Result := l_background_color_imp.attached_interface.twin
			else
				--l_rgba_color := {GTK}.c_gdk_rgba_struct_allocate
				l_style_context := background_color_style_context
				--gtk_c_string := "selected_bg_color"
				--{GTK2}.gtk_style_context_lookup_color (l_style_context, gtk_c_string.item, l_rgba_color);
				{GTK2}.gtk_style_context_get (l_style_context, {GTK}.gtk_style_context_get_state (l_style_context), {GTK2}.GTK_STYLE_PROPERTY_BACKGROUND_COLOR, $l_rgba_color )
				create Result.make_with_rgb (
					{GDK}.rgba_struct_red (l_rgba_color).truncated_to_real,
					{GDK}.rgba_struct_green (l_rgba_color).truncated_to_real,
					{GDK}.rgba_struct_blue (l_rgba_color).truncated_to_real
				)
				--l_rgba_color.memory_free
				{GDK}.rgba_free (l_rgba_color)
			end
		end

	foreground_color_internal: EV_COLOR
			-- Color of foreground features like text.
		local
			l_rgba_color, l_style_context: POINTER
		do
			if attached foreground_color_imp as l_foreground_color_imp then
				Result := l_foreground_color_imp.attached_interface.twin
			else

				--l_rgba_color := {GTK}.c_gdk_rgba_struct_allocate
				l_style_context := foreground_color_style_context
				{GTK}.gtk_style_context_save (l_style_context)
				{GTK}.gtk_style_context_set_state (l_style_context, {GTK}.gtk_state_flag_normal_enum)
				--{GTK}.gtk_style_context_get_color (l_style_context, {GTK}.gtk_style_context_get_state (l_style_context), l_rgba_color)
				{GTK2}.gtk_style_context_get (l_style_context, {GTK}.gtk_style_context_get_state (l_style_context), {GTK2}.GTK_STYLE_PROPERTY_COLOR, $l_rgba_color )
				create Result.make_with_rgb (
					{GDK}.rgba_struct_red (l_rgba_color).truncated_to_real,
					{GDK}.rgba_struct_green (l_rgba_color).truncated_to_real,
					{GDK}.rgba_struct_blue (l_rgba_color).truncated_to_real
					)
				--l_rgba_color.memory_free
				{GDK}.rgba_free (l_rgba_color)
			end
		end

feature -- Status setting

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		do
			if background_color_imp /= a_color.implementation then
				if needs_event_box then
					{GTK2}.gtk_event_box_set_visible_window (c_object, True)
				end
				background_color_imp ?= a_color.implementation
				real_set_background_color (visual_widget, a_color)
				if visual_widget /= c_object then
					real_set_background_color (c_object, a_color)
				end
			end
		end

	real_set_background_color (a_c_object: POINTER; a_color: detachable EV_COLOR)
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
			--| Check that the color is not already set.
			--| Copy the existing GtkStyle, modifiy it	
			--| and set it back into the widget.
			--| (See gtk/docs/styles.txt)
		local
			r, g, b, m, mx: INTEGER
			l_context: POINTER
			l_provider: POINTER
			l_css: STRING
			l_css_data: C_STRING
			l_error: POINTER
		do
			if a_color /= Void then
				create l_css.make (1024)

					-- TODO check the old implementation used 16 bits.
				r := a_color.red_16_bit
				g := a_color.green_16_bit
				b := a_color.blue_16_bit
				m := a_color.max_16_bit

				l_css.append ("* {background-color:" + new_rgb_color_string (r, g, b) + ";}%N")

					--| Set active state color.
				l_css.append ("*:active {background-color:"
						+ new_rgb_color_string ((r * Highlight_scale).rounded.max (0),
												(g * Highlight_scale).rounded.max (0),
												(b * Highlight_scale).rounded.max (0))
						+ ";}%N"
					)

					--| Set prelight state color.
				l_css.append ("*:hover {background-color:"
						+ new_rgb_color_string ((r * Prelight_scale).rounded.min (m),
												(g * Prelight_scale).rounded.min (m),
												(b * Prelight_scale).rounded.min (m))
						+ ";}%N"
					)

					--| Set selected state color to reverse.
				l_css.append ("*:selected {background-color:" + new_rgb_color_string (m - r, m - g, m - b // 2) + ";}%N")

					--| Set the insensitive state color.
				mx := r.max (g).max (b)
				l_css.append ("*:disabled {background-color:"
						+ new_rgb_color_string (mx + ((r - mx) // 4),
												mx + ((g - mx) // 4),
												mx + ((b - mx) // 4))
						+ ";}%N"
					)

					--| Set the text selection background and color.
					--| TODO at the moment the colors are hardcoded.
				l_css.append (".view text selection { background-color: blue; color: yellow; }%N")

				create l_css_data.make (l_css)
				l_context := {GTK}.gtk_widget_get_style_context (a_c_object)
				l_provider := {GTK_CSS}.gtk_css_provider_new
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end

				if not l_provider.is_default_pointer then
					{GTK2}.g_object_unref (l_provider)
				end
			end
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			if foreground_color_imp /= a_color.implementation then
				foreground_color_imp ?= a_color.implementation
				real_set_foreground_color (visual_widget, a_color)
				if visual_widget /= c_object then
					real_set_foreground_color (c_object, a_color)
				end
			end
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: detachable EV_COLOR)
			-- Implementation of `set_foreground_color'
		local
			r,g,b: INTEGER
			l_context: POINTER
			l_provider: POINTER
			l_css_data: C_STRING
			l_error: POINTER
			l_color_string: STRING
			l_foreground_color_imp: like foreground_color_imp
		do
			if a_color /= Void then
				l_foreground_color_imp := foreground_color_imp
				check l_foreground_color_imp /= Void then end
				r := l_foreground_color_imp.red_16_bit
				g := l_foreground_color_imp.green_16_bit
				b := l_foreground_color_imp.blue_16_bit

				l_context := {GTK}.gtk_widget_get_style_context (a_c_object)
				l_provider := {GTK_CSS}.gtk_css_provider_new
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
				l_color_string := new_rgb_color_string (r, g, b)
				create l_css_data.make ("*, *:active, *:hover { color:"+ l_color_string + "; }%N")
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end
			end
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
			real_set_foreground_color (visual_widget, Void)
			real_set_background_color (visual_widget, Void)
		end

feature {NONE} -- Implementation

	new_gdk_rgba_string (r,g,b: INTEGER; a: REAL_64; a_reuse_color_object: POINTER): STRING
			-- New color string from `r,g,b,a`
			-- reusing the Gtk struct `a_reuse_color_object`, if it is set
			-- otherwise allocate a new struct.
		require
			valid_red:   r >= 0 and r <= {EV_COLOR}.max_16_bit
			valid_green: g >= 0 and g <= {EV_COLOR}.max_16_bit
			valid_blue:  b >= 0 and b <= {EV_COLOR}.max_16_bit
			valid_alpha: a >= 0.0 and a <= 1.0
		local
			color: POINTER
		do
			if a_reuse_color_object.is_default_pointer then
				color := {GTK}.c_gdk_rgba_struct_allocate
			else
				color := a_reuse_color_object
			end
			{GDK}.set_rgba_struct_red (color, r / {EV_COLOR}.max_16_bit)
			{GDK}.set_rgba_struct_green (color, g / {EV_COLOR}.max_16_bit)
			{GDK}.set_rgba_struct_blue (color, b / {EV_COLOR}.max_16_bit)
			{GDK}.set_rgba_struct_alpha (color, a)
			create Result.make_from_c ({GDK}.gdk_rgba_to_string (color))
			if a_reuse_color_object.is_default_pointer and not color.is_default_pointer then
				color.memory_free
			end
		end

	new_rgb_color_string (r,g,b: INTEGER): STRING
			-- New color string from `r,g,b`
		require
			valid_red:   r >= 0 and r <= {EV_COLOR}.max_16_bit
			valid_green: g >= 0 and g <= {EV_COLOR}.max_16_bit
			valid_blue:  b >= 0 and b <= {EV_COLOR}.max_16_bit
		do
			create Result.make (16)
			Result.append ("rgb(")
			Result.append_integer (r)
			Result.append_character (',')
			Result.append_integer (g)
			Result.append_character (',')
			Result.append_integer (b)
			Result.append_character (')')
				-- Alpha is 1.0, then no need to specify it in CSS.
		end

	visual_widget: POINTER
		deferred
		end

	c_object: POINTER
		deferred
		end

	needs_event_box: BOOLEAN
		deferred
		end

	background_color_imp: detachable EV_COLOR_IMP
		-- Color used for the background of `Current'

	foreground_color_imp: detachable EV_COLOR_IMP
		-- Color used for the foreground of `Current'

	background_color_style_context: POINTER
			-- Pointer to bg color style context
		do
			Result := {GTK}.gtk_widget_get_style_context (visual_widget)
		end

	foreground_color_style_context: POINTER
			-- Pointer to fg color style context
		do
			Result := {GTK}.gtk_widget_get_style_context (visual_widget)
		end

	Prelight_scale: REAL = 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL = 0.90912397
		-- Highlight color is this much darker than `background_color'.


	get_background_color_imp (context: POINTER): EV_COLOR
		local
			l_gdk_rgba: POINTER
		do
			l_gdk_rgba := {GTK}.c_gdk_rgba_struct_allocate
			{GTK2}.gtk_style_context_get (context, {GTK}.gtk_state_flag_normal_enum, {GTK2}.GTK_STYLE_PROPERTY_BACKGROUND_COLOR, l_gdk_rgba )
			create Result.make_with_rgb (
							{GDK}.rgba_struct_red (l_gdk_rgba).truncated_to_real,
							{GDK}.rgba_struct_green (l_gdk_rgba).truncated_to_real,
							{GDK}.rgba_struct_blue (l_gdk_rgba).truncated_to_real
							)
			l_gdk_rgba.memory_free
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_COLORIZABLE note option: stable attribute end;

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





