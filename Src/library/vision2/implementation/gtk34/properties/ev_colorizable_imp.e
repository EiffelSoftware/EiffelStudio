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
			r, g, b, nr, ng, nb, m, mx: INTEGER
			l_context: POINTER
			l_provider: POINTER
			l_css_data: C_STRING
			l_error: POINTER
			l_hex_string: STRING
			color: POINTER
		do
			if a_color /= Void then
					-- TODO check the old implementation used 16 bits.
				r := a_color.red_16_bit
				g := a_color.green_16_bit
				b := a_color.blue_16_bit
				m := a_color.Max_16_bit
				l_context := {GTK}.gtk_widget_get_style_context (a_c_object)
				l_provider := {GTK_CSS}.gtk_css_provider_new
				color := {GTK}.c_gdk_rgba_struct_allocate
				{GDK}.set_rgba_struct_red (color, r / m)
				{GDK}.set_rgba_struct_green (color, g / m)
				{GDK}.set_rgba_struct_blue (color, b / m)
				{GDK}.set_rgba_struct_alpha (color, a_color.lightness)

				create l_hex_string.make_from_c ({GDK}.gdk_rgba_to_string (color))
				create l_css_data.make ("* {background:"+ l_hex_string + "; }")

				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)

					--| Set active state color.
				nr := (r * Highlight_scale).rounded
				ng := (g * Highlight_scale).rounded
				nb := (b * Highlight_scale).rounded
				if nr < 0 then nr := 0 end
				if ng < 0 then ng := 0 end
				if nb < 0 then nb := 0 end
				{GDK}.set_rgba_struct_red (color, nr / m)
				{GDK}.set_rgba_struct_green (color, ng / m)
				{GDK}.set_rgba_struct_blue (color, nb / m)
				{GDK}.set_rgba_struct_alpha (color, a_color.lightness)
				create l_hex_string.make_from_c ({GDK}.gdk_rgba_to_string (color))
				create l_css_data.make ("*:active{ background:"+ l_hex_string + ";} ")
				l_provider := {GTK_CSS}.gtk_css_provider_new
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)

					--| Set prelight state color.
				nr := (r * Prelight_scale).rounded.min (m)
				ng := (g * Prelight_scale).rounded.min (m)
				nb := (b * Prelight_scale).rounded.min (m)

				{GDK}.set_rgba_struct_red (color, nr / m)
				{GDK}.set_rgba_struct_green (color, ng / m )
				{GDK}.set_rgba_struct_blue (color, nb / m)
				{GDK}.set_rgba_struct_alpha (color, a_color.lightness)
				create l_hex_string.make_from_c ({GDK}.gdk_rgba_to_string (color))

				create l_css_data.make ("*:hover{ background:"+ l_hex_string + ";} ")
				l_provider := {GTK_CSS}.gtk_css_provider_new
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)

					--| Set selected state color to reverse.
				{GDK}.set_rgba_struct_red   (color, (m - r) / m)
				{GDK}.set_rgba_struct_green (color, (m - g) / m)
				{GDK}.set_rgba_struct_blue  (color, (m - b//2) / m)
				{GDK}.set_rgba_struct_alpha  (color, a_color.lightness)

				create l_hex_string.make_from_c ({GDK}.gdk_rgba_to_string (color))
				create l_css_data.make ("*	:selected{ background:"+ l_hex_string + ";} ")
				l_provider := {GTK_CSS}.gtk_css_provider_new
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)

					--| Set the insensitive state color.
				mx := r.max (g).max (b)
				{GDK}.set_rgba_struct_red   (color, (mx + ((r - mx)//4)) / m)
				{GDK}.set_rgba_struct_green (color, (mx + ((g - mx)//4)) / m)
				{GDK}.set_rgba_struct_blue  (color, (mx + ((b - mx)//4)) / m)

				create l_hex_string.make_from_c ({GDK}.gdk_rgba_to_string (color))
				create l_css_data.make ("*:disabled{ background:"+ l_hex_string + ";} ")
				l_provider := {GTK_CSS}.gtk_css_provider_new
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
			end
			if color /= default_pointer then
				color.memory_free
			end
			if l_provider /= default_pointer then
				{GTK2}.g_object_unref (l_provider)
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
			l_context: POINTER
			l_provider: POINTER
			l_css_data: C_STRING
			l_error: POINTER
			l_hex_string: STRING
			color: POINTER
			l_foreground_color_imp: like foreground_color_imp
			m: INTEGER_32
		do
			if a_color /= Void then
				l_foreground_color_imp := foreground_color_imp
				check l_foreground_color_imp /= Void then end
				color := {GTK}.c_gdk_rgba_struct_allocate
				m := a_color.max_16_bit
				{GDK}.set_rgba_struct_red (color, l_foreground_color_imp.red_16_bit / m)
				{GDK}.set_rgba_struct_green (color, l_foreground_color_imp.green_16_bit / m)
				{GDK}.set_rgba_struct_blue (color, l_foreground_color_imp.blue_16_bit / m)
				{GDK}.set_rgba_struct_alpha (color, a_color.lightness)

				l_context := {GTK}.gtk_widget_get_style_context (a_c_object)
				l_provider := {GTK_CSS}.gtk_css_provider_new
				create l_hex_string.make_from_c ({GDK}.gdk_rgba_to_string (color))
				create l_css_data.make ("	* { color:"+ l_hex_string + "; } \n	*:active{ color:"+ l_hex_string + ";} \n	*:hover{ color:"+ l_hex_string + ";} \n")
				{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
				if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
					-- TODO Handle error
				end

				if color /= default_pointer  then
					color.memory_free
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




end -- EV_COLORIZABLE_IMP





