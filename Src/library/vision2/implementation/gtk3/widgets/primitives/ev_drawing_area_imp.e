﻿note
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
			start_drawing_session,
			end_drawing_session
		end

	EV_DRAWABLE_IMP
		redefine
			start_drawing_session, end_drawing_session,
			interface
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
			process_draw_event,
			process_configure_event,
			process_button_event,
			button_actions_handled_by_signals,
			destroy,
			c_object_dispose,
			process_scroll_event
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
			{GTK}.gtk_widget_set_size_request (l_drawing_area, 1, 1)
			set_c_object (l_drawing_area)
			l_c_object := c_object

			{GTK2}.gtk_widget_set_redraw_on_allocate (l_c_object, False)
			{GTK2}.gtk_widget_set_app_paintable (l_c_object, True)

			l_app_imp := App_implementation

			real_signal_connect (l_c_object,
					{EV_GTK_EVENT_STRINGS}.configure_event_name,
					agent (l_app_imp.gtk_marshal).configure_event (l_c_object, ?))

			real_signal_connect (l_c_object,
					{EV_GTK_EVENT_STRINGS}.scroll_event_name,
					agent (l_app_imp.gtk_marshal).scroll_event (l_drawing_area, ?))

			real_signal_connect_after (l_c_object,
					{EV_GTK_EVENT_STRINGS}.draw_event_name,
					agent (l_app_imp.gtk_marshal).draw_actions_event (l_c_object, ?))

			check cairo_surface.is_default_pointer end

			init_default_values
--			disable_double_buffering -- deprecated!

			real_set_background_color (l_c_object, background_color)
			if
				attached visual_widget as vw and then
				not vw.is_default_pointer and then
			 	vw /= l_c_object
			then
				real_set_background_color (vw, background_color)
			end

			Precursor {EV_PRIMITIVE_IMP}

			disable_tabable_to
			disable_tabable_from
		end

feature {NONE} -- Dispose

	destroy
		do
			clear_cairo_context
			if not cairo_surface.is_default_pointer then
				release_cairo_surface (cairo_surface)
				cairo_surface := default_pointer
			end
			Precursor {EV_PRIMITIVE_IMP}
		end

	c_object_dispose
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		do
			if not cairo_context.is_default_pointer then
				{CAIRO}.destroy (cairo_context)
				cairo_context := default_pointer
			end
			if not cairo_surface.is_default_pointer then
				{CAIRO}.surface_destroy (cairo_surface)
				cairo_surface := default_pointer
			end
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Transparency

	start_transparency (alpha: REAL_64)
		local
			cr: like cairo_context
		do
			cr := cairo_context
			if not cr.is_default_pointer then
				set_background_transparency (alpha)
				{CAIRO}.set_source_rgba (cr, 1, 1, 1, alpha)
				{CAIRO}.set_operator (cr, {CAIRO}.operator_source)
			end
		end

	stop_transparency
		local
			cr: like cairo_context
		do
			cr := cairo_context
			if not cr.is_default_pointer then
				{CAIRO}.set_operator (cr, {CAIRO}.operator_over)
			end
		end

feature {EV_ANY_I} -- Drawing wrapper

	pre_drawing
		local
			cr: like cairo_context
		do
				-- If inside drawing session
				-- the cairo context is already created in `start_drawing_session`
			if not is_in_drawing_session then
					-- Reuse or get once a new cairo_context
				get_cairo_context
				cr := cairo_context
				if not cr.is_default_pointer then
					{CAIRO}.save (cr)
				end
			end
		end

	post_drawing
		local
			cr: like cairo_context
		do
				-- If inside drawing session
				-- keep the cairo context for the next draw operation, it will be releazed by `end_drawing_session`
			if not is_in_drawing_session then
				cr := cairo_context
				if not cr.is_default_pointer then
					{CAIRO}.restore (cr)
				end
				update_if_needed
			end
		end

feature {NONE} -- Session implementation		

	start_drawing_session
		do
			Precursor
				-- If the drawing session is on the top (i.e not inside another session)
				-- Create a new cairo context (that will be released by `end_drawing_session`)
			if is_in_top_drawing_session then
				get_new_cairo_context
			end
		end

	end_drawing_session
		do
				-- If the drawing session is on the top (i.e not inside another session)
				-- clear cairo context created in `start_drawing_session`
			if is_in_top_drawing_session then
				clear_cairo_context
				update_if_needed
			end
			Precursor
		end

feature {EV_ANY_I} -- cairo object access

	cairo_surface: POINTER

	get_new_cairo_surface (a_width, a_height: INTEGER)
		require
			cairo_surface.is_default_pointer
		local
			l_surface,
			l_widget,
			l_window: POINTER
			w,h:  INTEGER
		do
			check
				no_surface: cairo_surface.is_default_pointer
			end
			l_widget := c_object
			l_window := {GTK}.gtk_widget_get_window (l_widget)
			if l_window /= default_pointer then
				w := {GTK}.gtk_widget_get_allocated_width (l_widget)
				h := {GTK}.gtk_widget_get_allocated_height (l_widget)
				check same_width: w = a_width end
				check same_height: h = a_height end
				debug ("gtk3_redraw")
					print (generator + ".get_new_cairo_surface -> "+ l_window.out + ", .., w=" + w.out + ", h=" + h.out +"%N")
				end

				l_surface := {GDK}.gdk_window_create_similar_surface (
						l_window,
						{CAIRO}.cairo_content_color_alpha,
						w, h
					)
				cairo_surface := l_surface
			else
				debug ("gtk3_redraw")
					print (generator + ".get_new_cairo_surface -> no window !!!%N")
				end
			end
		end

	get_cairo_context
			-- Drawable used for rendering docking components.
		local
		 	l_surface, cr: POINTER
		do
			cr := cairo_context
			if cr.is_default_pointer then
				l_surface := cairo_surface
				if not l_surface.is_default_pointer then
					cr := {CAIRO}.create_context (l_surface)
					initialize_cairo_context (cr)
					cairo_context := cr
				end
			end
		end

feature {EV_ANY_I} -- cairo object release			

	release_cairo_surface (a_surface: POINTER)
		do
			if not a_surface.is_default_pointer then
				{CAIRO}.surface_destroy (a_surface)
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

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	in_expose_actions: BOOLEAN
			-- Is `Current' in an expose action?

	process_draw_event (a_cairo_context: POINTER): BOOLEAN
			-- Call the expose actions for the drawing area.
		local
			l_x, l_y, l_width, l_height: REAL_64
			l_surface: like cairo_surface
		do
			check
				outside_drawing_session: not is_in_drawing_session
			end
			l_surface := cairo_surface
			if l_surface.is_default_pointer then
				check has_surface: False end
				debug ("gtk3_redraw")
					print (($Current).out + "::" + generator + ".process_draw_event ("+ a_cairo_context.out +")  NO SURFACE !!! ref_count="+ {CAIRO}.get_reference_count (a_cairo_context).out +"%N")
				end
			else
				debug ("gtk3_redraw")
					print (($Current).out + "::" + generator + ".process_draw_event ("+ a_cairo_context.out +")  surface=" + l_surface.out + " ref_count="+ {CAIRO}.get_reference_count (a_cairo_context).out +"%N")
				end

				{CAIRO}.set_source_surface (a_cairo_context, l_surface, 0, 0)
				if
					attached expose_actions_internal as l_expose_actions and then
					not l_expose_actions.is_empty
				then
					in_expose_actions := True
					{CAIRO}.clip_extents (a_cairo_context, $l_x, $l_y, $l_width, $l_height)

						-- Even if the callback on "draw" event provides a cairo_context, the implementation
						-- will use a new one using the expected cairo_surface.
					start_drawing_session
					l_expose_actions.call (l_x.truncated_to_integer, l_y.truncated_to_integer, l_width.truncated_to_integer, l_height.truncated_to_integer)
					end_drawing_session
					in_expose_actions := False
				end

				{CAIRO}.paint (a_cairo_context)
			end

			Result := False
		end

	process_configure_event (a_x, a_y, a_width, a_height: INTEGER): BOOLEAN
			-- A "configure-event" signal has occurred
		local
			l_old_surface, l_new_surface, cr: POINTER
		do
			debug ("gtk3_redraw")
				print (($Current).out + "::" + generator + ".process_configure_event ("+ a_x.out + ", " + a_y.out + ", " + a_width.out + ", " + a_height.out + ")%N")
			end
			if
				cairo_surface.is_default_pointer
				or a_width /= previous_width
				or a_height /= previous_height
			then
				clear_cairo_context
				l_old_surface := cairo_surface
				if not l_old_surface.is_default_pointer then
					{CAIRO}.surface_flush (l_old_surface)
					cairo_surface := default_pointer

					get_new_cairo_surface (a_width, a_height)
					l_new_surface := cairo_surface
					cr := {CAIRO}.create_context (l_new_surface)
					{CAIRO}.set_source_surface (cr, l_old_surface, 0, 0)
					{CAIRO}.set_operator (cr, {CAIRO}.OPERATOR_SOURCE)
					{CAIRO}.paint (cr)
					release_cairo_context (cr)
					release_cairo_surface (l_old_surface)
				end
				if cairo_surface.is_default_pointer then
					get_new_cairo_surface (a_width, a_height)
				end
			end
			Result := True
		end

	process_button_event (a_gdk_event: POINTER; a_recursive: BOOLEAN)
			-- "button-press-event" signal occurred
		local
			l_screen_x, l_screen_y: INTEGER
		do
			if attached app_implementation as l_app_imp then
				l_screen_x := {GDK}.gdk_event_button_struct_x_root (a_gdk_event).truncated_to_integer + l_app_imp.screen_virtual_x
				l_screen_y := {GDK}.gdk_event_button_struct_y_root (a_gdk_event).truncated_to_integer + l_app_imp.screen_virtual_y
				on_mouse_button_event (
						{GDK}.gdk_event_button_struct_type (a_gdk_event),
						{GDK}.gdk_event_button_struct_x (a_gdk_event).truncated_to_integer,
						{GDK}.gdk_event_button_struct_y (a_gdk_event).truncated_to_integer,
						{GDK}.gdk_event_button_struct_button (a_gdk_event),
						0.5,
						0.5,
						0.5,
						l_screen_x,
						l_screen_y
					)
			end
		end

	process_scroll_event (a_gdk_event: POINTER): BOOLEAN
			-- "scroll-event" signal occurred
		local
			l_button_number: INTEGER
		do
			if {GDK}.gdk_event_scroll_struct_scroll_direction (a_gdk_event) = {GTK2}.gdk_scroll_up_enum then
				l_button_number := 4
			else
				l_button_number := 5
			end
			call_button_event_actions ({GDK}.gdk_button_press_enum, 0, 0, l_button_number, 0.5, 0.5, 0.5, 0, 0)
			Result := True
		end

feature {EV_APPLICATION_IMP} -- Implementation

	button_actions_handled_by_signals: BOOLEAN
			-- Are the button actions (press/release) handled by signals?
		do
			Result := True
		end

feature {NONE} -- Implementation

	on_size_allocate (a_x, a_y, a_width, a_height: INTEGER)
			-- Gtk_Widget."size-allocate" happened.
		do
			Precursor (a_x, a_y, a_width, a_height)
		end

	redraw
			-- Redraw the entire area.
		do
			{GTK}.gtk_widget_queue_draw (visual_widget)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		do
				-- TODO JV review
				-- Workaround, sometimes we got a negative value for width `a_width`.
				-- For example from EV_GRID_I
			{GTK}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, a_width.max (0), a_height)
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
