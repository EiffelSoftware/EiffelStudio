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
			interface,
			init_expose_actions
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

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
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
			-- TODO double check.
			--{GTK2}.gtk_widget_set_double_buffered (visual_widget, False)

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
		obsolete
			"double buffering is enabled by default [2021-06-01]"
		do
		  -- {GTK2}.gtk_widget_set_double_buffered (visual_widget, True)
		end

	disable_double_buffering
			-- Disable backbuffer for `Current'.
		obsolete
			"Disabling double buffering is mostly detrimental to the performance of an app. [2021-06-01]"
		do
			-- {GTK2}.gtk_widget_set_double_buffered (visual_widget, False)
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
		local
			flag: BOOLEAN
		do
				-- TODO JV review
				-- Workaround, sometimes we got a negative vaue for width `a_width`.
				-- For example from EV_GRID_I
			if a_width < 0 then
				{GTK}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, 0, a_height)
			else
				{GTK}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, a_width, a_height)
			end
			from
			until
				{GTK2}.events_pending
			loop
				flag := {GTK2}.gtk_event_iteration
				debug ("gtk3_redraw")
					print (generator + ".redraw " + flag.out + "%N")
				end
			end
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
			l_window, l_surface: POINTER
		do
			if in_expose_actions then
					-- We have been called via an expose event.
				check drawable_not_null: drawable /= null end
				Result := drawable
			else
						-- User is drawing directly to the window outside
						-- of an expose event. We need to create a drawable
						-- context for each draw operations.
				l_window := {GTK}.gtk_widget_get_window (c_object)
				if l_window /= default_pointer then
--					Result := {GDK_CAIRO}.create_context (l_window)
--					initialize_drawable (Result)
					l_surface := {GDK}.gdk_window_create_similar_surface (l_window, 0x3000, {GDK}.gdk_window_get_width(l_window), {GDK}.gdk_window_get_height(l_window) )
					Result := {CAIRO}.create_context (l_surface)
					initialize_drawable (Result)
				end
			end
		end

	release_drawable (a_drawable: POINTER)
			-- Release resources of drawable `a_drawable'.
		do
			if not in_expose_actions and a_drawable /= default_pointer then
				{CAIRO}.destroy (a_drawable)
				cairo_context := Void
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

			{CAIRO}.clip_extents (a_cairo_context, $l_x, $l_y, $l_width, $l_height)

			initialize_drawable (a_cairo_context)

			if expose_actions_internal /= Void then
				expose_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (l_x.truncated_to_integer, l_y.truncated_to_integer, l_width.truncated_to_integer, l_height.truncated_to_integer))
			end

			drawable := default_pointer

			in_expose_actions := False
		end

	initialize_drawable (a_drawable: POINTER)
			-- Initialize new `drawable' to existing parameters.
		do
			{CAIRO}.set_antialias (a_drawable, aliasing_mode)
			{CAIRO}.set_line_cap (a_drawable, line_cap_mode)
			{CAIRO}.set_line_width (a_drawable, line_width)
			if attached internal_foreground_color as l_color then
				{CAIRO}.set_source_rgb (a_drawable, l_color.red, l_color.green, l_color.blue)
			else
					-- No colors specified, it will be black
				{CAIRO}.set_source_rgb (a_drawable, 0.0, 0.0, 0.0)
			end
			{CAIRO}.set_operator (a_drawable, cairo_drawing_mode (drawing_mode))
			{CAIRO}.set_dashed_line_style (a_drawable, dashed_line_style)
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

	init_expose_actions (a_expose_actions: like expose_actions)
		local
			l_app_imp: like app_implementation
		do
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (visual_widget, once "draw", agent (l_app_imp.gtk_marshal).create_draw_actions_intermediary (c_object, ?), l_app_imp.gtk_marshal.draw_translate_agent, True)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWING_AREA note option: stable attribute end
		-- Interface object of Current.

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

end -- class EV_DRAWING_AREA_IMP
