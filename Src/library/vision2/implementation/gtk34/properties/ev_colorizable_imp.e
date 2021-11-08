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
			check has_implementation: attached {like background_color_imp} a_color.implementation as l_col_imp then
				if background_color_imp /= a_color.implementation then
					if needs_event_box then
						{GTK2}.gtk_event_box_set_visible_window (c_object, True)
					end
					background_color_imp := l_col_imp
					real_set_background_color (c_object, a_color)
					if
						attached visual_widget as vw and then
						not vw.is_default_pointer and then
					 	vw /= c_object
					then
						real_set_background_color (vw, a_color)
					end
				end
			end
		end

	real_set_default_background_color (a_c_object: POINTER)
			-- Set the (style) background to the default application background color.
		local
			l_context: POINTER
			l_provider: POINTER
			l_css: STRING
			l_css_data: C_STRING
			l_error: POINTER
		do
--			real_set_background_color (a_c_object, {GTK}.default_background_color)
				-- Using style context a_c_object
			l_context := {GTK}.gtk_widget_get_style_context (a_c_object)

			l_css := "* { background: " + {GTK}.rgba_string_default_background_color + ";}%N"
			create l_css_data.make (l_css)
			l_provider := {GTK_CSS}.gtk_css_provider_new
			{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
			if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
				-- TODO Handle error
			end
			if not l_provider.is_default_pointer then
				{GTK2}.g_object_unref (l_provider)
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
			l_context: POINTER
			r, g, b, m, mx: INTEGER
			l_css: STRING
			l_bg_name: STRING
		do
			if
				not a_c_object.is_default_pointer and
				a_color /= Void
			then
				l_context := {GTK}.gtk_widget_get_style_context (a_c_object)

				create l_css.make (1024)

					-- TODO check the old implementation used 16 bits.
				r := a_color.red_16_bit
				g := a_color.green_16_bit
				b := a_color.blue_16_bit
				m := a_color.max_16_bit

					-- TODO support for background-pixmap ???
					-- for instance EV_CONTAINER.background_pixmap
					-- do not use background, but background-color otherwise the pixmap will be removed.
					-- instead of background, it could also be background-image: none; background-color: ...
				l_bg_name := "background"
				l_css.append ("* {"
						+ new_css_color_style_string (l_bg_name,
												r / m,
												g / m,
												b / m)
						+ "}%N"
					)

					--| Set active state color.
				l_css.append ("*:active {"
						+ new_css_color_style_string (l_bg_name,
												(r * Highlight_scale).rounded.max (0) / m,
												(g * Highlight_scale).rounded.max (0) / m,
												(b * Highlight_scale).rounded.max (0) / m)
						+ "}%N"
					)

					--| Set prelight state color.
				l_css.append ("*:hover {"
						+ new_css_color_style_string (l_bg_name,
												(r * Prelight_scale).rounded.min (m) / m,
												(g * Prelight_scale).rounded.min (m) / m,
												(b * Prelight_scale).rounded.min (m) / m)
						+ "}%N"
					)

					--| Set selected state color to reverse.
				l_css.append ("*:selected {"
						+ new_css_color_style_string (l_bg_name,
												(m - r) / m,
												(m - g) / m,
												(m - b // 2) / m)
						+ ";}%N"
					)

					--| Set the insensitive state color.
				mx := r.max (g).max (b)
				l_css.append ("*:disabled {"
						+ new_css_color_style_string (l_bg_name,
												(mx + ((r - mx) // 4)) / m,
												(mx + ((g - mx) // 4)) / m,
												(mx + ((b - mx) // 4)) / m )
						+ ";}%N"
					)

				apply_background_color_to_style_context (l_context, a_color, l_css)
			end
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			check has_implementation: attached {like foreground_color_imp} a_color.implementation as l_col_imp then
				if foreground_color_imp /= l_col_imp then
					foreground_color_imp := l_col_imp
					real_set_foreground_color (c_object, a_color)
					if
						attached visual_widget as vw and then
						not vw.is_default_pointer and then
					 	vw /= c_object
					then
						real_set_foreground_color (vw, a_color)
					end
				end
			end
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: detachable EV_COLOR)
			-- Implementation of `set_foreground_color'
		local
			r,g,b,m: INTEGER
			l_context: POINTER
			l_color_string: STRING
			l_foreground_color_imp: like foreground_color_imp
		do
			if
				not a_c_object.is_default_pointer and
				a_color /= Void
			then
				l_context := {GTK}.gtk_widget_get_style_context (a_c_object)

				l_foreground_color_imp := foreground_color_imp
				check l_foreground_color_imp /= Void then end
				r := l_foreground_color_imp.red_16_bit
				g := l_foreground_color_imp.green_16_bit
				b := l_foreground_color_imp.blue_16_bit
				m := {EV_COLOR}.max_16_bit

				l_color_string := new_rgb_color_string (r / m, g / m, b / m)
				apply_foreground_color_to_style_context (l_context, a_color, "*, *:active, *:hover { color:"+ l_color_string + "; }%N")
			end
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		do
			background_color_imp := Void
			foreground_color_imp := Void
			real_set_foreground_color (c_object, Void)
			real_set_background_color (c_object, Void)
			if
				attached visual_widget as vw and then
				not vw.is_default_pointer and then
			 	vw /= c_object
			then
				real_set_foreground_color (vw, Void)
				real_set_background_color (vw, Void)
			end
		end

feature {NONE} -- Implementation

	apply_background_color_to_style_context (a_style_context: POINTER; a_color: detachable EV_COLOR; a_css: READABLE_STRING_8)
		local
			l_provider: POINTER
			l_css_data: C_STRING
			l_error: POINTER
		do
			create l_css_data.make (a_css)
			l_provider := {GTK_CSS}.gtk_css_provider_new
			{GTK2}.gtk_style_context_add_provider (a_style_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
			if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
				-- TODO Handle error
			end

			if not l_provider.is_default_pointer then
				{GTK2}.g_object_unref (l_provider)
			end
		end

	apply_foreground_color_to_style_context (a_style_context: POINTER; a_color: detachable EV_COLOR; a_css: READABLE_STRING_8)
		local
			l_provider: POINTER
			l_css_data: C_STRING
			l_error: POINTER
		do
			create l_css_data.make (a_css)
			l_provider := {GTK_CSS}.gtk_css_provider_new
			{GTK2}.gtk_style_context_add_provider (a_style_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
			if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
				-- TODO Handle error
			end
			if not l_provider.is_default_pointer then
				{GTK2}.g_object_unref (l_provider)
			end
		end

	new_css_color_style_string (a_name: READABLE_STRING_8; r,g,b: REAL_64): STRING
		do
			create Result.make_from_string (a_name)
			Result.append_character (':')
			Result.append (new_rgb_color_string (r, g, b))
			Result.append_character (';')
		end

	new_gdk_rgba_string (r,g,b: REAL_64; a: REAL_64; a_reuse_color_object: POINTER): STRING
			-- New color string from `r,g,b,a`
			-- reusing the Gtk struct `a_reuse_color_object`, if it is set
			-- otherwise allocate a new struct.
		require
			valid_red:   r >= 0.0 and r <= 1.0
			valid_green: g >= 0.0 and g <= 1.0
			valid_blue:  b >= 0.0 and b <= 1.0
			valid_alpha: a >= 0.0 and a <= 1.0
		local
			color: POINTER
		do
			if a_reuse_color_object.is_default_pointer then
				color := {GTK}.c_gdk_rgba_struct_allocate
			else
				color := a_reuse_color_object
			end
			{GDK}.set_rgba_struct_red (color, r)
			{GDK}.set_rgba_struct_green (color, g)
			{GDK}.set_rgba_struct_blue (color, b)
			{GDK}.set_rgba_struct_alpha (color, a)
			create Result.make_from_c ({GDK}.gdk_rgba_to_string (color))
			if a_reuse_color_object.is_default_pointer and not color.is_default_pointer then
				color.memory_free
			end
		end

	new_rgb_color_string (r,g,b: REAL_64): STRING
			-- New color string from `r,g,b`
		require
			valid_red:   r >= 0.0 and r <= 1.0
			valid_green: g >= 0.0 and g <= 1.0
			valid_blue:  b >= 0.0 and b <= 1.0
		do
			create Result.make (16)
			Result.append ("rgb(")
			Result.append_integer ((r * {EV_COLOR}.max_8_bit).truncated_to_integer)
			Result.append_character (',')
			Result.append_integer ((g * {EV_COLOR}.max_8_bit).truncated_to_integer)
			Result.append_character (',')
			Result.append_integer ((b * {EV_COLOR}.max_8_bit).truncated_to_integer)
			Result.append_character (')')
				-- Alpha is 1.0, then no need to specify it in CSS.
		end

	rgb_string_color (a_style_ctx: POINTER; a_name: READABLE_STRING_8): STRING
		local
			l_gtk_c_string: EV_GTK_C_STRING
			c_rgba: POINTER
			r,g,b: INTEGER
			a: REAL_64
		do
			c_rgba := {GTK}.c_gdk_rgba_struct_allocate
			create l_gtk_c_string.set_with_eiffel_string (a_name)
			{GTK2}.gtk_style_context_lookup_color (a_style_ctx, l_gtk_c_string.item, c_rgba)

			r := ({GDK}.rgba_struct_red (c_rgba) * {EV_COLOR}.max_8_bit).truncated_to_integer
			g := ({GDK}.rgba_struct_green (c_rgba) * {EV_COLOR}.max_8_bit).truncated_to_integer
			b := ({GDK}.rgba_struct_blue (c_rgba) * {EV_COLOR}.max_8_bit).truncated_to_integer
			a := {GDK}.rgba_struct_alpha (c_rgba).truncated_to_real
			Result := "rgb(" + r.out + "," + g.out + "," + b.out + ")"
			c_rgba.memory_free
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





