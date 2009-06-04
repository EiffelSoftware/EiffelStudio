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
			interface,
			set_default_colors
		end

feature -- Access

	background_color_internal: EV_COLOR
			-- Color of face.
		local
			color: POINTER
		do
			if attached background_color_imp as l_background_color_imp then
				Result := l_background_color_imp.attached_interface.twin
			else
				color := background_color_pointer
				create Result
				Result.set_rgb_with_16_bit (
					{EV_GTK_EXTERNALS}.gdk_color_struct_red (color),
					{EV_GTK_EXTERNALS}.gdk_color_struct_green (color),
					{EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
				)
			end
		end

	foreground_color_internal: EV_COLOR
			-- Color of foreground features like text.
		local
			color: POINTER
		do
			if attached foreground_color_imp as l_foreground_color_imp then
				Result := l_foreground_color_imp.attached_interface.twin
			else
				color := foreground_color_pointer
				create Result
				Result.set_rgb_with_16_bit (
					{EV_GTK_EXTERNALS}.gdk_color_struct_red (color),
					{EV_GTK_EXTERNALS}.gdk_color_struct_green (color),
					{EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
				)
			end
		end

feature -- Status setting

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		do
			if needs_event_box then
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_event_box_set_visible_window (c_object, True)
			end
			background_color_imp ?= a_color.implementation
			real_set_background_color (visual_widget, a_color)
			if visual_widget /= c_object then
				real_set_background_color (c_object, a_color)
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
			l_null, color: POINTER
			r, g, b, nr, ng, nb, m, mx: INTEGER
		do
			if a_color /= Void then
				color := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				r := a_color.red_16_bit
				g := a_color.green_16_bit
				b := a_color.blue_16_bit
				m := a_color.Max_16_bit
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, r)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, g)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, b)
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_bg (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_NORMAL_ENUM, color)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_base (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_NORMAL_ENUM, color)


			if a_color /= Void then
					--| Set active state color.
				nr := (r * Highlight_scale).rounded
				ng := (g * Highlight_scale).rounded
				nb := (b * Highlight_scale).rounded
				if nr < 0 then nr := 0 end
				if ng < 0 then ng := 0 end
				if nb < 0 then nb := 0 end
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, nr)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, ng)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, nb)
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_bg (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_ACTIVE_ENUM, color)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_base (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_ACTIVE_ENUM, color)


			if a_color /= Void then
					--| Set prelight state color.
				nr := (r * Prelight_scale).rounded.min (m)
				ng := (g * Prelight_scale).rounded.min (m)
				nb := (b * Prelight_scale).rounded.min (m)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, nr)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, ng)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, nb)
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_bg (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_PRELIGHT_ENUM, color)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_base (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_PRELIGHT_ENUM, color)


			if a_color /= Void then
					--| Set selected state color to reverse.
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red   (color, m - r)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, m - g)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue  (color, m - b//2)
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_bg (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_SELECTED_ENUM, color)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_base (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_SELECTED_ENUM, color)


			if a_color /= Void then
					--| Set the insensitive state color.
				mx := r.max (g).max (b)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red   (color, mx + ((r - mx)//4))
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, mx + ((g - mx)//4))
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue  (color, mx + ((b - mx)//4))
			end

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_bg (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_INSENSITIVE_ENUM, color)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_base (a_c_object, {EV_GTK_EXTERNALS}.gTK_STATE_INSENSITIVE_ENUM, color)

			if color /= l_null then
				color.memory_free
			end
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'
		do
			foreground_color_imp ?= a_color.implementation
			real_set_foreground_color (visual_widget, a_color)
			if visual_widget /= c_object then
				real_set_foreground_color (c_object, a_color)
			end
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: detachable EV_COLOR)
			-- Implementation of `set_foreground_color'
		local
			color, l_null: POINTER
			l_foreground_color_imp: like foreground_color_imp
		do
			if a_color /= Void then
				color := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				l_foreground_color_imp := foreground_color_imp
				check l_foreground_color_imp /= Void end
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, l_foreground_color_imp.red_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, l_foreground_color_imp.green_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, l_foreground_color_imp.blue_16_bit)
			end

			{EV_GTK_EXTERNALS}.gtk_widget_modify_fg (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_NORMAL_ENUM, color)
			{EV_GTK_EXTERNALS}.gtk_widget_modify_fg (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_ACTIVE_ENUM, color)
			{EV_GTK_EXTERNALS}.gtk_widget_modify_fg (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_PRELIGHT_ENUM, color)
			--{EV_GTK_EXTERNALS}.gtk_widget_modify_fg (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_SELECTED_ENUM, default_pointer)

			{EV_GTK_EXTERNALS}.gtk_widget_modify_text (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_NORMAL_ENUM, color)
			{EV_GTK_EXTERNALS}.gtk_widget_modify_text (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_ACTIVE_ENUM, color)
			{EV_GTK_EXTERNALS}.gtk_widget_modify_text (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_PRELIGHT_ENUM, color)
			--{EV_GTK_EXTERNALS}.gtk_widget_modify_text (a_c_object, {EV_GTK_EXTERNALS}.GTK_STATE_SELECTED_ENUM, default_pointer)

			if color /= l_null  then
				color.memory_free
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

	background_color_pointer: POINTER
			-- Pointer to bg color for `a_widget'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_style_struct_base (
				{EV_GTK_EXTERNALS}.gtk_rc_get_style (visual_widget)
			)
		end

	foreground_color_pointer: POINTER
			-- Pointer to fg color for `a_widget'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_style_struct_fg (
				{EV_GTK_EXTERNALS}.gtk_rc_get_style (visual_widget)
			)
		end

	Prelight_scale: REAL = 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL = 0.90912397
		-- Highlight color is this much darker than `background_color'.

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_COLORIZABLE note option: stable attribute end;

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




end -- EV_COLORIZABLE_IMP





