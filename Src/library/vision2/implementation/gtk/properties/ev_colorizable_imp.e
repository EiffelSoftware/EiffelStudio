indexing
	description: 
		"Eiffel Vision colorizable. GTK+ implementation."
	status: "See notice at end of class"
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

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Access

	background_color: EV_COLOR is
			-- Color of face.
		local
			color: POINTER
		do
			check
				normal_color_at_head_of_array: feature {EV_GTK_EXTERNALS}.gTK_STATE_NORMAL_ENUM = 0 
					--| GtkStyle has GdkColor bg[5] with 5 background colors
					--| for the 5 gtk states, since normal state is at the 
					--| front we just treat is as: GdkColor* bg_state_normal
			end
			color := background_color_pointer

			create Result
			Result.set_rgb_with_16_bit (
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (color),
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (color),
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			)
		end

	foreground_color: EV_COLOR is
			-- Color of foreground features like text.
		local
			color: POINTER
		do
			check
				normal_color_at_head_of_array: feature {EV_GTK_EXTERNALS}.gTK_STATE_NORMAL_ENUM = 0 
					--| See `background_color'
			end
			color := foreground_color_pointer
			create Result
			Result.set_rgb_with_16_bit (
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (color),
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (color),
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color)
			)
		end

feature -- Status setting


	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			real_set_background_color (visual_widget, a_color)
			if visual_widget /= c_object then
				real_set_background_color (c_object, a_color)
			end
		end

	real_set_background_color (a_c_object: POINTER; a_color: EV_COLOR) is
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
			--| Check that the color is not already set.
			--| Copy the existing GtkStyle, modifiy it	
			--| and set it back into the widget.
			--| (See gtk/docs/styles.txt)
		local
			style: POINTER
			color: POINTER
			r, g, b, nr, ng, nb, m, mx: INTEGER
		do
			if default_background_color = Void then
				default_background_color := background_color
			end
			
			style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (a_c_object)
			color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (style)
			r := a_color.red_16_bit
			g := a_color.green_16_bit
			b := a_color.blue_16_bit
			if
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (color) /= r or else
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (color) /= g or else
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color) /= b or else
				(r = 0 and g = 0 and b = 0)
			then
				m := a_color.Max_16_bit
				style := feature {EV_GTK_EXTERNALS}.gtk_style_copy (style)
					--| Set normal state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_NORMAL_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, r)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, g)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, b)
					--| Set active state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_ACTIVE_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				nr := (r * Highlight_scale).rounded
				ng := (g * Highlight_scale).rounded
				nb := (b * Highlight_scale).rounded
				if nr < 0 then nr := 0 end
				if ng < 0 then ng := 0 end
				if nb < 0 then nb := 0 end
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, nr)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, ng)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, nb)
					--| Set prelight state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_PRELIGHT_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				nr := (r * Prelight_scale).rounded
				ng := (g * Prelight_scale).rounded
				nb := (b * Prelight_scale).rounded
				if nr > m then nr := m end
				if ng > m then ng := m end
				if nb > m then nb := m end
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, nr)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, ng)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, nb)
					--| Set selected state color to reverse.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_SELECTED_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red   (color, m - r)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, m - g)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue  (color, m - b//2)
					--| Set the insensitive state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_INSENSITIVE_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				mx := r.max (g).max (b)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red   (color, mx + ((r - mx)//4))
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, mx + ((g - mx)//4))
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue  (color, mx + ((b - mx)//4))

				feature {EV_GTK_EXTERNALS}.gtk_widget_set_style (a_c_object, style)
				feature {EV_GTK_EXTERNALS}.gtk_style_unref (style)
			end
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			real_set_foreground_color (visual_widget, a_color)
			if visual_widget /= c_object then
				real_set_foreground_color (c_object, a_color)
			end	
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: EV_COLOR) is
			-- Implementation of `set_background_color'
			-- Used also by classes that inherit EV_WIDGET_IMP but not
			-- EV_WIDGET. (eg EV_PIXMAPABLE_IMP)
			--| Check that the color is not already set.
			--| Copy the existing GtkStyle, modifiy it	
			--| and set it back into the widget.
			--| (See gtk/docs/styles.txt)
		local
			style: POINTER
			color: POINTER
			r, g, b, m: INTEGER
		do
			if default_foreground_color= Void then
				default_foreground_color := foreground_color
			end
			style := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (a_c_object)
			color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (style)
			r := a_color.red_16_bit
			g := a_color.green_16_bit
			b := a_color.blue_16_bit
			if
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (color) /= r or else
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (color) /= g or else
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color) /= b or else
				(r = 0 and g = 0 and b = 0)
			then
				m := a_color.Max_16_bit
				style := feature {EV_GTK_EXTERNALS}.gtk_style_copy (style)
					--| Set normal state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_NORMAL_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, r)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, g)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, b)
					--| Set active state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_ACTIVE_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, r)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, g)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, b)
					--| Set prelight state color.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_PRELIGHT_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, r)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, g)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, b)
					--| Set selected state color to reverse.
				color := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (style)
					 + (feature {EV_GTK_EXTERNALS}.gTK_STATE_SELECTED_ENUM * feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color, m - r)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color, m - g)
				feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color, m - b)
					--| Don't touch insensitive state color
					--| (GTK_STATE_INSENSITIVE_ENUM)

				feature {EV_GTK_EXTERNALS}.gtk_widget_set_style (a_c_object, style)
				feature {EV_GTK_EXTERNALS}.gtk_style_unref (style)
			end
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			if default_foreground_color /= Void then
				set_foreground_color (default_foreground_color)
			end
			if default_background_color /= Void then
				set_background_color (default_background_color)
			end
		end	

feature {NONE} -- Implementation

	default_background_color: EV_COLOR
		-- Color used for background of 'Current'

	default_foreground_color: EV_COLOR
		-- Color used for foreground of 'Current'

	background_color_pointer: POINTER is
			-- Pointer to bg color for `a_widget'.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_style_struct_bg (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (visual_widget)
			)
		end

	foreground_color_pointer: POINTER is
			-- Pointer to fg color for `a_widget'.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (visual_widget)
			)
		end

	Prelight_scale: REAL is 1.0909488
		-- Prelight color is this much lighter than `background_color'.

	Highlight_scale: REAL is 0.90912397
		-- Highlight color is this much darker than `background_color'.

feature {EV_ANY_I} -- Implementation

	interface: EV_COLORIZABLE

end -- EV_COLORIZABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

