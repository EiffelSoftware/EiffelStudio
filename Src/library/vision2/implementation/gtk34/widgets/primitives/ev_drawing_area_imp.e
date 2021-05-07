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
			pre_drawing, post_drawing,
			interface, release_cairo_context
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color
		redefine
			needs_event_box, event_widget,
			interface,
			call_button_event_actions,
			make,
			internal_set_focus,
			on_size_allocate,
			on_widget_mapped,
			process_draw_event,
			process_configure_event,
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
			l_drawing_area: POINTER
			l_c_object: POINTER
			l_app_imp: like App_implementation
		do
			l_drawing_area := {GTK}.gtk_drawing_area_new
			set_c_object (l_drawing_area)
			l_c_object := c_object

			{GTK2}.gtk_widget_set_redraw_on_allocate (l_c_object, False)
			{GTK2}.gtk_widget_set_app_paintable (l_c_object, True)

			l_app_imp := App_implementation

			real_signal_connect (l_c_object,
					{EV_GTK_EVENT_STRINGS}.button_press_event_name,
					agent (l_app_imp.gtk_marshal).on_button_event (l_app_imp, ?),
					l_app_imp.gtk_marshal.button_event_translate_agent
				)
			real_signal_connect (l_c_object,
					{EV_GTK_EVENT_STRINGS}.button_release_event_name,
					agent (l_app_imp.gtk_marshal).on_button_event (l_app_imp, ?),
					l_app_imp.gtk_marshal.button_event_translate_agent
				)

			real_signal_connect (l_drawing_area,
					{EV_GTK_EVENT_STRINGS}.configure_event_name,
					agent (l_app_imp.gtk_marshal).configure_event_intermediary (l_drawing_area, ?, ?, ?, ?),
					l_app_imp.gtk_marshal.configure_translate_agent
				)

			real_signal_connect_after (l_drawing_area,
					{EV_GTK_EVENT_STRINGS}.draw_event_name,
					agent (l_app_imp.gtk_marshal).draw_actions_intermediary (l_drawing_area, ?),
					l_app_imp.gtk_marshal.draw_translate_agent
				)

			check cairo_surface.is_default_pointer end
			get_new_cairo_surface

			init_default_values
--			disable_double_buffering -- deprecated!

			real_set_background_color (l_c_object, background_color)

			Precursor {EV_PRIMITIVE_IMP}

			disable_tabable_to
			disable_tabable_from
		end

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

	event_widget: POINTER
		do
			Result := visual_widget
		end

feature -- filling operations

	drawing_context: POINTER

	pre_drawing
		do
			get_new_cairo_context
		end

	post_drawing
		local
			cr: like cairo_context
		do
			cr := cairo_context
			check not cr.is_default_pointer end
			release_cairo_context (cr)
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
		  -- {GTK2}.gtk_widget_set_double_buffered (c_object, True)
		end

	disable_double_buffering
			-- Disable backbuffer for `Current'.
		obsolete
			"Disabling double buffering is mostly detrimental to the performance of an app. [2021-06-01]"
		do
			-- {GTK2}.gtk_widget_set_double_buffered (c_object, False)
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
			process_pending_events
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
				-- TODO JV review
				-- Workaround, sometimes we got a negative vaue for width `a_width`.
				-- For example from EV_GRID_I
			if a_width < 0 then
				{GTK}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, 0, a_height)
			else
				{GTK}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, a_width, a_height)
			end
			process_pending_events
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

	cairo_surface: POINTER

	get_new_cairo_surface
		require
			cairo_surface.is_default_pointer
		local
			l_surface,
			l_widget,
			l_window: POINTER
			cr: POINTER
		do
			check
				no_surface: cairo_surface.is_default_pointer
			end
			print (generator + ".get_cairo_surface%N")
			l_widget := c_object
			l_window := {GTK}.gtk_widget_get_window (l_widget)
			if l_window /= default_pointer then
				l_surface := {GDK}.gdk_window_create_similar_surface (
						l_window,
						{CAIRO}.cairo_content_color, -- TODO: use with _alpha ?
						{GTK}.gtk_widget_get_allocated_width (l_widget),
						{GTK}.gtk_widget_get_allocated_height (l_widget)
					)
				cairo_surface := l_surface

				get_new_cairo_context
				cr := cairo_context
				{CAIRO}.paint (cr)
				{CAIRO}.destroy (cr)
				cairo_context := default_pointer
			end
		end

	get_cairo_context
			-- Drawable used for rendering docking components.
--		require
--			no_drawable: cairo_context.is_default_pointer
		local
		 	l_surface, cr: POINTER
		do
			cr := cairo_context
			if cr.is_default_pointer then
						-- User is drawing directly to the window outside
						-- of an expose event. We need to create a drawable
						-- context for each draw operations.
				l_surface := cairo_surface
				if l_surface.is_default_pointer then
					get_new_cairo_surface
					l_surface := cairo_surface
				end

				cr := {CAIRO}.create_context (l_surface)
				cairo_context := cr
				initialize_cairo_context (cr)
			end
		end

	release_cairo_context (cr: POINTER)
			-- Release resources of cairo context `cr'.
		do
			if
				not in_expose_actions and
				not cr.is_default_pointer
			then
-- FIXME				{CAIRO}.destroy (cr)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	in_expose_actions: BOOLEAN
		-- Is `Current' in an expose action?

	process_draw_event (a_cairo_context: POINTER)
			-- Call the expose actions for the drawing area.
		local
			l_x, l_y, l_width, l_height: REAL_64
			l_surface: like cairo_surface
			l_old_cr: like cairo_context
		do
			debug ("gdk_event")
				print (generator + ".process_draw_event ("+ a_cairo_context.out +")%N")
			end

			l_surface := cairo_surface;
			check has_surface: not l_surface.is_default_pointer end

			{CAIRO}.set_source_surface (a_cairo_context, l_surface, 0, 0) --l_x, l_y)

			if attached expose_actions_internal as l_actions then
				in_expose_actions := True
				l_old_cr := cairo_context
				cairo_context := a_cairo_context
				{CAIRO}.clip_extents (a_cairo_context, $l_x, $l_y, $l_width, $l_height)
				l_actions.call (l_x.truncated_to_integer, l_y.truncated_to_integer, l_width.truncated_to_integer, l_height.truncated_to_integer)
				cairo_context := l_old_cr
				in_expose_actions := False
			end

			{CAIRO}.paint (a_cairo_context)
		end

	process_configure_event (a_x, a_y, a_width, a_height: INTEGER)
			-- A "configure-event" signal has occurred
		local
			l_surface: POINTER
		do
			debug ("gdk_event")
				print (generator + ".process_configure_event ("+ a_x.out + ", " + a_y.out + ", " + a_width.out + ", " + a_height.out + ")%N")
			end
			l_surface := cairo_surface
			if not l_surface.is_default_pointer then
				{CAIRO}.surface_flush (l_surface)
				{CAIRO}.surface_destroy (l_surface)
				cairo_surface := default_pointer
			end
			if cairo_surface.is_default_pointer then
				get_new_cairo_surface
			end
		end

feature {NONE} -- Implementation		

	initialize_cairo_context (cr: POINTER)
			-- Initialize new `drawable' to existing parameters.
		require
			not cr.is_default_pointer
		do
			{CAIRO}.set_antialias (cr, aliasing_mode)
			{CAIRO}.set_line_cap (cr, line_cap_mode)
			{CAIRO}.set_line_width (cr, line_width)
			if attached internal_foreground_color as l_color then
				{CAIRO}.set_source_rgb (cr, l_color.red, l_color.green, l_color.blue)
			else
					-- No colors specified, it will be black
				{CAIRO}.set_source_rgb (cr, 0.0, 0.0, 0.0)
			end
			{CAIRO}.set_operator (cr, cairo_drawing_mode (drawing_mode))
			{CAIRO}.set_dashed_line_style (cr, dashed_line_style)
		end

	internal_set_focus
			-- Grab keyboard focus.
		local
			l_can_focus: BOOLEAN
		do
			l_can_focus := {GTK}.gtk_widget_get_can_focus (c_object)
			if not l_can_focus then
				{GTK}.gtk_widget_set_can_focus (c_object, True)
			end
			Precursor {EV_PRIMITIVE_IMP}
				-- Reset focus handling.
			if not l_can_focus then
				{GTK}.gtk_widget_set_can_focus (c_object, False)
			end
		end

feature {NONE} -- Implementation

	call_button_event_actions (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do
			if
				a_type = {EV_GTK_ENUMS}.gdk_button_press_enum and then
			 	not {GTK}.gtk_widget_has_focus (c_object) and then
			 	(a_button = 1 and then a_button <= 3) and then
			 	not focus_on_press_disabled
			 then
					-- As a button has been pressed on the drawing area then
				set_focus
			end
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	init_expose_actions (a_expose_actions: like expose_actions)
		do
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
