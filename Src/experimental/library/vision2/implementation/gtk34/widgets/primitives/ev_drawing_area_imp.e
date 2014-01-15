note
	description: "EiffelVision drawing area. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface, get_drawable, release_drawable
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			call_button_event_actions,
			make,
			internal_set_focus,
			on_size_allocate,
			on_widget_mapped,
			process_draw_event,
			button_actions_handled_by_signals
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create an empty drawing area.
		do
			assign_interface (an_interface)
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_expose_actions: like expose_actions
		do
			set_c_object ({GTK}.gtk_drawing_area_new)

			{GTK2}.gtk_widget_set_redraw_on_allocate (c_object, False)
			{GTK2}.gtk_widget_set_app_paintable (c_object, True)
			{GTK2}.gtk_widget_set_double_buffered (visual_widget, False)

			real_signal_connect (c_object, once "button-press-event", agent (app_implementation.gtk_marshal).on_button_event (app_implementation, ?), app_implementation.gtk_marshal.button_event_translate_agent)
			real_signal_connect (c_object, once "button-release-event", agent (app_implementation.gtk_marshal).on_button_event (app_implementation, ?), app_implementation.gtk_marshal.button_event_translate_agent)

			line_width := 1
			drawing_mode := drawing_mode_copy

			real_set_background_color (c_object, background_color)

			Precursor {EV_PRIMITIVE_IMP}

			l_expose_actions := expose_actions

			disable_tabable_to
			disable_tabable_from
		end

feature {EV_APPLICATION_IMP} -- Implementation

	button_actions_handled_by_signals: BOOLEAN
			-- Are the button actions (press/release) handled by signals?
		do
			Result := True
		end

feature -- Implementation

	enable_double_buffering
			-- Enable backbuffer for `Current'.
		do
			{GTK2}.gtk_widget_set_double_buffered (visual_widget, True)
		end

	disable_double_buffering
			-- Disable backbuffer for `Current'.
		do
			{GTK2}.gtk_widget_set_double_buffered (visual_widget, False)
		end

feature {NONE} -- Implementation

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER)
			-- Gtk_Widget."size-allocate" happened.
		do
			Precursor (a_x, a_y, a_width, a_height)
		end

	on_widget_mapped
			-- <Precursor>
		do
			Precursor
		end

	redraw
			-- Redraw the entire area.
		do
			{GTK}.gtk_widget_queue_draw (visual_widget)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
			{GTK}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, a_width, a_height)
		end

	clear_and_redraw
			-- Clear `Current' and redraw.
		do
			clear
			redraw
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Clear the rectangle area defined by `a_x', `a_y', `a_width', `a_height' and then redraw it.
		do
			clear_rectangle (a_x, a_y, a_width, a_height)
			redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	flush
			-- Redraw the screen immediately.
		do
			refresh_now
		end

	update_if_needed
			-- Update `Current' if needed.
		do
			if not in_expose_actions then
				{GTK}.gtk_widget_queue_draw (visual_widget)
			end
		end

feature {EV_ANY_I} -- Implementation

	get_drawable: POINTER
			-- Drawable used for rendering docking components.
		local
			l_window: POINTER
		do
			if drawable /= default_pointer then
				Result := drawable
			else
				l_window := {GTK}.gtk_widget_get_window (c_object)
				if l_window /= default_pointer then
					Result := {GTK}.gdk_cairo_create (l_window)
					initialize_drawable (Result)
				end
			end
		end

	release_drawable (a_drawable: POINTER)
			-- Release resources of drawable `a_drawable'.
		do
			if a_drawable /= drawable and then a_drawable /= default_pointer then
				{CAIRO}.cairo_destroy (a_drawable)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	in_expose_actions: BOOLEAN
		-- Is `Current' in an expose action?

	process_draw_event (a_cairo_context: POINTER)
			-- Call the expose actions for the drawing area.
		local
			l_x, l_y, l_width, l_height: REAL_64
		do
			in_expose_actions := True

			drawable := a_cairo_context

			{CAIRO}.cairo_clip_extents (a_cairo_context, $l_x, $l_y, $l_width, $l_height)

			initialize_drawable (a_cairo_context)

			if expose_actions_internal /= Void then
				expose_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (l_x.truncated_to_integer, l_y.truncated_to_integer, l_width.truncated_to_integer, l_height.truncated_to_integer))
			end

			drawable := default_pointer

			in_expose_actions := False
		end

	initialize_drawable (a_drawable: POINTER)
			-- Initialize new `drawable' to existing parameters.
		local
			l_red, l_green, l_blue: REAL_64
		do
			{CAIRO}.cairo_set_antialias (a_drawable, {CAIRO}.cairo_antialias_none)
			{CAIRO}.cairo_set_line_width (a_drawable, line_width)
			if attached internal_foreground_color as l_internal_foreground_color then
				l_red := l_internal_foreground_color.red
				l_green := l_internal_foreground_color.green
				l_blue := l_internal_foreground_color.blue
			end
			{CAIRO}.cairo_set_source_rgb (a_drawable, l_red, l_green, l_blue)
			internal_set_drawing_mode (a_drawable, drawing_mode)
		end

	internal_set_focus
			-- Grab keyboard focus.
		local
			l_can_focus: BOOLEAN
		do
			l_can_focus := {GTK}.gtk_widget_get_can_focus (visual_widget)
			if not l_can_focus then
				{GTK}.gtk_widget_set_can_focus (visual_widget, True)
			end
			Precursor {EV_PRIMITIVE_IMP}
				-- Reset focus handling.
			if not l_can_focus then
				{GTK}.gtk_widget_set_can_focus (visual_widget, False)
			end
		end

feature {NONE} -- Implementation

	call_button_event_actions (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do
			if a_type = {EV_GTK_ENUMS}.gdk_button_press_enum and then not {GTK}.gtk_widget_has_focus (visual_widget) and then (a_button = 1 and then a_button <= 3) and then not focus_on_press_disabled then
					-- As a button has been pressed on the drawing area then
				set_focus
			end
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWING_AREA note option: stable attribute end
		-- Interface object of Current.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_DRAWING_AREA_IMP
