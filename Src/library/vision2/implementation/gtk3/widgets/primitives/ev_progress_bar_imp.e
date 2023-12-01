note
	description: "Eiffel Vision Progress bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make, value_changed_handler,
			needs_event_box,
			event_widget,
			set_minimum_height,
			set_minimum_width,
			set_minimum_size,
			real_set_background_color,
			real_set_foreground_color
		end

feature {NONE} -- Implementation

	make
			-- Create and initialize `Current'
		local
			l_c_progress_bar: POINTER
		do
			l_c_progress_bar := {GTK}.gtk_progress_bar_new
			set_c_object (l_c_progress_bar)
			gtk_progress_bar := l_c_progress_bar
			enable_segmentation
			Precursor
			apply_css (visual_widget)
		end

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	event_widget: POINTER
		do
			Result := visual_widget
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display segmented?

	is_vertical: BOOLEAN
		deferred
		end

	is_horizontal: BOOLEAN
		do
			Result := not is_vertical
		end

feature -- Status setting

	enable_segmentation
			-- Display bar divided into segments.
		do
			is_segmented := True
		end

	disable_segmentation
			-- Display bar without segments.
		do
			is_segmented := False
		end

feature -- Element change / colors

	real_set_background_color (a_c_object: POINTER; a_color: detachable EV_COLOR)
		do
			Precursor (a_c_object, a_color)
			apply_css (a_c_object)
		end

	real_set_foreground_color (a_c_object: POINTER; a_color: detachable EV_COLOR)
		do
			Precursor (a_c_object, a_color)
			apply_css (a_c_object)
		end

	apply_css (a_c_object: POINTER)
		local
			l_context: POINTER
			l_provider: POINTER
			l_css: STRING
			l_css_data: C_STRING
			l_error: POINTER
			cl: STRING
		do
			create l_css.make (2048)
			l_context := {GTK}.gtk_widget_get_style_context (a_c_object)
			if is_vertical then
				cl := "" -- ".vertical"
				l_css.append ("progressbar" + cl + " > trough { min-width: " + minimum_width.out + "px; }%N")
				l_css.append ("progressbar" + cl + " > trough > progress { min-width: " + minimum_width.out + "px; }%N")
			else
				cl := ".horizontal"
				l_css.append ("progressbar" + cl + " > trough { min-height: " + minimum_height.out + "px; }%N")
				l_css.append ("progressbar" + cl + " > trough > progress { min-height: " + minimum_height.out + "px; }%N")
			end
			if attached background_color_imp as bg then
				l_css.append ("progressbar" + cl + " > trough { background-color: rgb(" + bg.red_8_bit.out + "," + bg.green_8_bit.out + "," + bg.blue_8_bit.out + "); }%N")
			elseif attached {GTK}.rgba_string_style_color (l_context, "theme_selected_fg_color") as bg_str then
				l_css.append ("progressbar" + cl + " > trough { background-color: " + bg_str + "; }%N")
			end
			if attached foreground_color_imp as fg then
				l_css.append ("progressbar" + cl + " > trough > progress { background-color: rgb(" + fg.red_8_bit.out + "," + fg.green_8_bit.out + "," + fg.blue_8_bit.out + "); }%N")
			elseif attached {GTK}.rgba_string_style_color (l_context, "theme_selected_bg_color") as fg_str then
				l_css.append ("progressbar" + cl + " > trough > progress { background-color: " + fg_str + "; }%N")

			end
			create l_css_data.make (l_css)
			l_provider := {GTK_CSS}.gtk_css_provider_new
			{GTK2}.gtk_style_context_add_provider (l_context, l_provider, {EV_GTK_ENUMS}.gtk_style_provider_priority_application)
			if not {GTK_CSS}.gtk_css_provider_load_from_data (l_provider, l_css_data.item, -1, $l_error) then
				-- TODO Handle error
			end
			if not l_provider.is_default_pointer then
				{GDK}.g_object_unref (l_provider)
			end
		end

feature -- Element change

	set_minimum_width (a_minimum_width: INTEGER)
		do
			Precursor (a_minimum_width)
			apply_css (visual_widget)
		end

	set_minimum_height (a_minimum_height: INTEGER)
		do
			Precursor (a_minimum_height)
			apply_css (visual_widget)
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
		do
			Precursor (a_minimum_width, a_minimum_height)
			apply_css (visual_widget)
		end

feature {EV_INTERMEDIARY_ROUTINES}

	value_changed_handler
			-- <Precursor>
		do
			{GTK}.gtk_progress_bar_set_fraction (gtk_progress_bar, proportion)
			Precursor
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_bar: POINTER

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PROGRESS_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PROGRESS_BAR_IMP
