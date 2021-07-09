note
	description:
		"EiffelVision screen. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface,
			widget_at_mouse_pointer,
			virtual_x,
			virtual_y,
			virtual_width,
			virtual_height,
			monitor_count,
			monitor_area_from_position,
			monitor_area_from_window,
			working_area_from_position,
			working_area_from_window,
			start_drawing_session, end_drawing_session
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			supports_pixbuf_alpha,
			device_x_offset,
			device_y_offset,
			draw_segment,
			set_drawing_mode,
			set_line_width,
			enable_dashed_line_style,
			disable_dashed_line_style,
			init_default_values,
			start_drawing_session,
			end_drawing_session,
			clear_rectangle,
			fill_rectangle,
			internal_set_color,
			draw_ellipse,
			draw_point,
			draw_arc,
			draw_rectangle,
			draw_polyline,
			fill_ellipse,
			fill_polygon,
			fill_pie_slice
		end

	EV_GTK_DEPENDENT_ROUTINES

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create an empty drawing area.
		do
			assign_interface (an_interface)
		end

	make
		do
				-- In order to access the screen, the EV_APPLICATION needs to be created
			app_implementation.do_nothing

			drawable := {GTK2}.gdk_screen_get_root_window ({GTK2}.gdk_screen_get_default)

			-- TODO update this code to support different environments like (Wayland)
			{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			gc := {GDK_X11}.create_gc (drawable)
			{GDK_X11}.x_set_subwindow_mode (drawable, gc, {GDK_X11}.x_subwindow_mode_include_inferiors)
			init_default_values

				-- Set offset values to match Win32 implementation.
			device_x_offset := -app_implementation.screen_virtual_x.as_integer_16
			device_y_offset := -app_implementation.screen_virtual_y.as_integer_16

			set_is_initialized (True)
			-- Set up action sequence connections and create graphics context.
		end

	init_default_values
			-- Set default values. Call during initialization.
		do
			enable_dashed_line_style
			set_drawing_mode (drawing_mode_copy)
			set_line_width (1)
		end

feature -- Access

	gc: POINTER
		--

	drawable: POINTER
			-- Pointer to the screen (root window)

	get_cairo_context
		do
			cairo_context := drawable
		end

	xdisplay: POINTER
			-- Pointer X display of a GdkDisplay.
		once
			Result := gdk_x_display
		end

feature -- Clear Operations

	clear_rectangle (x, y, a_width, a_height: INTEGER)
			-- Erase rectangle specified with `background_color'.
		local
			tmp_fg_color, tmp_bg_color: detachable EV_COLOR
		do
			pre_drawing
			{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				tmp_fg_color := internal_foreground_color
				if tmp_fg_color = Void then
					tmp_fg_color := foreground_color
				end
				tmp_bg_color := internal_background_color
				if tmp_bg_color = Void then
					tmp_bg_color := background_color
				end
				internal_set_color (True, tmp_bg_color.red, tmp_bg_color.green, tmp_bg_color.blue)
				{GDK_X11}.draw_rectangle (drawable_x_window, drawable_x_display, gc, True,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height)
				internal_set_color (True, tmp_fg_color.red, tmp_fg_color.green, tmp_fg_color.blue)
				update_if_needed
			end
			post_drawing
		end
feature -- Drawing

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			debug ("refactor_fixme")
				{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			end
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				{GDK_X11}.draw_line (
					drawable_x_window, drawable_x_display,
					gc,
					(x1 + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y1 + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(x2 + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y2 + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)
				)
				update_if_needed
				redraw
			end
			post_drawing
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		do
			debug ("refactor_fixme")
				{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			end
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer and then
				a_width > 0 and a_height > 0
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				{GDK_X11}.draw_arc (
					drawable_x_window, drawable_x_display,
					gc,
					False,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width - 1,
					a_height - 1,
					0,
					whole_circle
				)
				update_if_needed
			end
			post_drawing
		end

	draw_point (x, y: INTEGER)
			-- Draw point at (`x', `y').
		do
			debug ("refactor_fixme")
				{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			end
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
	 			{GDK_X11}.draw_point (
	 				drawable_x_window, drawable_x_display,
	 				gc,
	 				(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
	 				(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value)
	 			)
	 			update_if_needed
			end
			post_drawing
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		local
			a_radians: INTEGER
		do
			debug ("refactor_fixme")
				{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			end
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				a_radians := radians_to_gdk_angle
				{GDK_X11}.draw_arc (
					drawable_x_window, drawable_x_display,
					gc,
					False,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height,
					(a_start_angle * a_radians + 0.5).truncated_to_integer,
					(an_aperture * a_radians + 0.5).truncated_to_integer
				)
				update_if_needed
			end
			post_drawing
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			debug ("refactor_fixme")
					{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			end
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer and then
				a_width > 0 and then a_height > 0
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
					-- If width or height are zero then nothing will be rendered.
				{GDK_X11}.draw_rectangle (
					drawable_x_window, drawable_x_display,
					gc,
					False,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width - 1,
					a_height - 1
				)
				update_if_needed
			end
			post_drawing
		end


	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			tmp: SPECIAL [INTEGER]
		do
			debug ("refactor_fixme")
					{REFACTORING_HELPER}.to_implement ("update this code to support different environments like (Wayland)")
			end
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				tmp := coord_array_to_gdkpoint_array (points).area
				if is_closed then
					{GDK_X11}.draw_polygon (drawable_x_window, drawable_x_display, gc, False, $tmp, points.count)
					update_if_needed
				else
					{GDK_X11}.draw_lines (drawable_x_window, drawable_x_display, gc, $tmp, points.count)
					update_if_needed
				end
			end
		end

feature -- Fill Operations

	fill_rectangle (x, y, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		do
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				if tile /= Void then
					{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_tiled)
				end
				{GDK_X11}.draw_rectangle (
					drawable_x_window, drawable_x_display,
					gc,
					True,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height
				)
				{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_solid)
				update_if_needed
			end
			post_drawing
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER)
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
		do
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				if tile /= Void then
					{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_tiled)
				end
				{GDK_X11}.draw_arc (drawable_x_window, drawable_x_display, gc, True, (x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value), a_width,
					a_height, 0, whole_circle)
				{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_solid)
				update_if_needed
			end
			post_drawing
		end

	fill_polygon (points: ARRAY [EV_COORDINATE])
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		local
			tmp: SPECIAL [INTEGER]
		do
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				tmp := coord_array_to_gdkpoint_array (points).area
				if tile /= Void then
					{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_tiled)
				end
				{GDK_X11}.draw_polygon (drawable_x_window, drawable_x_display, gc, True, $tmp, points.count)
				{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_solid)
				update_if_needed
			end
			post_drawing
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL)
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			pre_drawing
			if
				not drawable_x_window.is_default_pointer and then
				not drawable_x_display.is_default_pointer
			then
				{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
				if tile /= Void then
					{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_tiled)
				end
				{GDK_X11}.draw_arc (
					drawable_x_window, drawable_x_display,
					gc,
					False,
					(x + device_x_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					(y + device_y_offset).max ({INTEGER_16}.min_value).min ({INTEGER_16}.max_value),
					a_width,
					a_height,
					(a_start_angle * radians_to_gdk_angle).truncated_to_integer,
					(an_aperture * radians_to_gdk_angle).truncated_to_integer
				)
				{GDK_X11}.x_set_fill_style (drawable_x_display, gc, {GDK_X11}.x_fill_solid)
				update_if_needed
			end
			post_drawing
		end

feature -- Session		

	start_drawing_session
		do
			Precursor
			drawable_x_window := default_pointer
			drawable_x_display := default_pointer
			get_drawable_x_display_and_window
		end

	end_drawing_session
		do
			if not drawable_x_display.is_default_pointer then
				{GDK_X11}.x_flush (drawable_x_display)
			end
			drawable_x_window := default_pointer
			drawable_x_display := default_pointer
			Precursor
		end

	get_drawable_x_display_and_window
		do

			if
				not drawable.is_default_pointer and then
				(drawable_x_window.is_default_pointer
				or drawable_x_display.is_default_pointer)
			then
				drawable_x_window := {GDK_X11}.x_window (drawable)
				drawable_x_display := {GDK_X11}.x_display (drawable)
			end
		end

	drawable_x_window: POINTER
	drawable_x_display: POINTER

feature {EV_ANY_I} -- Drawing wrapper

	pre_drawing
			-- <Precursor>
		do
			get_drawable_x_display_and_window
		end

	post_drawing
			-- <Precursor>
		do
		end

feature -- Status report

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		local
			l_display_data: TUPLE [a_window: POINTER; a_x: INTEGER; a_y: INTEGER; a_mask: NATURAL_32]
		do
			l_display_data := app_implementation.retrieve_display_data
				-- Logical offset is taken in to account in `retrieve_display_data'.
			create Result.set (l_display_data.a_x, l_display_data.a_y)
		end

	widget_at_position (x, y: INTEGER): detachable EV_WIDGET
			-- Widget at position ('x', 'y') if any.
		local
			l_pointer_position: TUPLE [a_window: POINTER; a_x: INTEGER; a_y: INTEGER; a_mask: NATURAL_32]
			l_widget_imp: detachable EV_WIDGET_IMP
			l_change: BOOLEAN
		do
			l_pointer_position := app_implementation.retrieve_display_data
				-- If `x' and `y' are at the pointer position then as an optimization we do not change the position of the mouse.
			l_change := l_pointer_position.a_x /= x or else l_pointer_position.a_y /= y
			if l_change then
				set_pointer_position (x, y)
			end
			l_widget_imp := widget_imp_at_pointer_position
			if l_change then
				set_pointer_position (l_pointer_position.a_x, l_pointer_position.a_y)
			end
			if l_widget_imp /= Void then
				Result := l_widget_imp.interface
			end
		end

	widget_at_mouse_pointer: detachable EV_WIDGET
			-- Widget at mouse pointer if any.
		local
			l_widget_imp: detachable EV_WIDGET_IMP
		do
			l_widget_imp := widget_imp_at_pointer_position
			if l_widget_imp /= Void then
				Result := l_widget_imp.interface
			end
		end

	widget_imp_at_pointer_position: detachable EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		local
			gdkwin, gtkwid: POINTER
			l_display_data: TUPLE [a_window: POINTER; a_x: INTEGER; a_y: INTEGER; a_mask: NATURAL_32]
		do
			l_display_data := app_implementation.retrieve_display_data
			gdkwin := l_display_data.a_window
			if gdkwin /= default_pointer then
				from
					{GTK}.gdk_window_get_user_data (gdkwin, $gtkwid)
				until
					Result /= Void or else gtkwid = default_pointer
				loop
					Result ?= {EV_GTK_CALLBACK_MARSHAL}.c_get_eif_reference_from_object_id (gtkwid)
					gtkwid := {GTK}.gtk_widget_get_parent (gtkwid)
				end
			end
		end

	monitor_count: INTEGER
			-- Number of monitors used for displaying virtual screen.
		do
			Result := app_implementation.screen_monitor_count
		end

	monitor_area_from_position (a_x, a_y: INTEGER): EV_RECTANGLE
			-- Full area of monitor nearest to coordinates (a_x, a_y)
		local
			l_mon: POINTER
			l_rect: POINTER
			l_x, l_y, l_width, l_height: INTEGER
		do
			l_mon := {GDK}.gdk_display_get_monitor_at_point ({GDK}.gdk_display_get_default, a_x + device_x_offset, a_y + device_y_offset)
			l_rect := {GTK}.c_gdk_rectangle_struct_allocate
			{GDK}.gdk_monitor_get_geometry(l_mon, l_rect)

			l_x := {GTK}.gdk_rectangle_struct_x (l_rect) - device_x_offset
			l_y := {GTK}.gdk_rectangle_struct_y (l_rect) - device_y_offset
			l_width := {GTK}.gdk_rectangle_struct_width (l_rect)
			l_height := {GTK}.gdk_rectangle_struct_height (l_rect)
			l_rect.memory_free

			create Result.make (l_x, l_y, l_width, l_height)
		end

	monitor_area_from_window (a_window: EV_WINDOW): EV_RECTANGLE
			-- Full area of monitor of which most of `a_window' is located.
			-- Returns nearest monitor area if `a_window' does not overlap any monitors.
		local
			l_window_imp: detachable EV_WINDOW_IMP
			l_rect: POINTER
			l_x, l_y, l_width, l_height: INTEGER
			l_monitor: POINTER
		do
			l_window_imp ?= a_window.implementation
			check l_window_imp /= Void then end
			l_monitor := {GDK}.gdk_display_get_monitor_at_window ({GDK}.gdk_display_get_default, {GTK}.gtk_widget_get_window (l_window_imp.c_object))

			l_rect := {GTK}.c_gdk_rectangle_struct_allocate
			{GDK}.gdk_monitor_get_geometry(l_monitor, l_rect)

			l_x := {GTK}.gdk_rectangle_struct_x (l_rect) - device_x_offset
			l_y := {GTK}.gdk_rectangle_struct_y (l_rect) - device_y_offset
			l_width := {GTK}.gdk_rectangle_struct_width (l_rect)
			l_height := {GTK}.gdk_rectangle_struct_height (l_rect)
			l_rect.memory_free

			create Result.make (l_x, l_y, l_width, l_height)
		end

	working_area_from_position (a_x, a_y: INTEGER): EV_RECTANGLE
			-- <Precursor>
		do
				--| FIXME Implement with respect to desktop background.
			Result := monitor_area_from_position (a_x, a_y)
		end

	working_area_from_window (a_window: EV_WINDOW): EV_RECTANGLE
			-- <Precursor>
		do
				--| FIXME Implement with respect to desktop background.
			Result := monitor_area_from_window (a_window)
		end

feature -- Status setting

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

feature -- Element change

	set_drawing_mode (a_drawing_mode: INTEGER)
			-- Set drawing mode to `a_drawing_mode'.
		local
			l_gc: like gc
			l_drawable: like drawable
		do
			Precursor (a_drawing_mode)
			l_gc := gc
			l_drawable := drawable
			if
				not l_gc.is_default_pointer and then
				not l_drawable.is_default_pointer
			then
				inspect
					a_drawing_mode
				when {EV_DRAWABLE_CONSTANTS}.drawing_mode_copy then
					{GDK_X11}.x_set_function (l_drawable, l_gc, {GDK_X11}.x_function_GXcopy)
				when {EV_DRAWABLE_CONSTANTS}.drawing_mode_and then
					{GDK_X11}.x_set_function (l_drawable, l_gc, {GDK_X11}.x_function_GXand)
				when {EV_DRAWABLE_CONSTANTS}.drawing_mode_xor then
					{GDK_X11}.x_set_function (l_drawable, l_gc, {GDK_X11}.x_function_GXxor)
				when {EV_DRAWABLE_CONSTANTS}.drawing_mode_invert then
					{GDK_X11}.x_set_function (l_drawable, l_gc, {GDK_X11}.x_function_GXinvert)
				when {EV_DRAWABLE_CONSTANTS}.drawing_mode_or then
					{GDK_X11}.x_set_function (l_drawable, l_gc, {GDK_X11}.x_function_GXor)
				else
					check
						drawing_mode_exists: False
					end
					{GDK_X11}.x_set_function (l_drawable, l_gc, {GDK_X11}.x_function_GXcopy)
				end
			end
		end

	set_line_width (a_width: INTEGER)
			-- Assign `a_width' to `line_width'.
		do
			Precursor (a_width)
			if
				not gc.is_default_pointer and then
				not drawable.is_default_pointer
			then
				if dashed_line_style then
					{GDK_X11}.set_line_attributes_to_dashed_style (drawable, gc, a_width)
				else
					{GDK_X11}.set_line_attributes_to_solid_style (drawable, gc, a_width)
				end
			end
		end

	enable_dashed_line_style
			-- Draw lines dashed.
		do
			Precursor {EV_DRAWABLE_IMP}
			if
				not gc.is_default_pointer and then
				not drawable.is_default_pointer
			then
				{GDK_X11}.set_line_attributes_to_dashed_style (drawable, gc, line_width)
			end
		end

	disable_dashed_line_style
			-- Draw lines solid.
		do
			Precursor {EV_DRAWABLE_IMP}
			if
				not gc.is_default_pointer and then
				not drawable.is_default_pointer
			then
				{GDK_X11}.set_line_attributes_to_solid_style (drawable, gc, line_width)
			end
		end

feature -- Basic operation

	redraw
			-- Redraw the entire area.
		do

			{GTK2}.gdk_window_invalidate_rect (cairo_context, default_pointer, True)
			-- FIXME JV gdk_window_process_updates has been deprecated since version 3.22 and should not be used in newly-written code.
			--{GTK2}.gdk_window_process_updates (drawable, True)
			--{GTK}.gtk_widget_queue_draw (drawable)
			-- https://stackoverflow.com/questions/34912757/how-do-you-force-a-screen-refresh-in-gtk-3-8
			{GTK}.gtk_widget_queue_draw (cairo_context)
			app_implementation.process_pending_events_on_default_context
		end

	set_pointer_position (a_x, a_y: INTEGER)
			-- Set pointer position to (a_x, a_y).
		local
			a_success_flag: BOOLEAN
			l_gdk_display_warp_pointer_symbol, l_x_test_fake_motion_event_symbol: POINTER
			l_x, l_y: INTEGER
		do
				-- Update logical coords to device coords
			l_x := a_x + device_x_offset
			l_y := a_y + device_y_offset
			l_gdk_display_warp_pointer_symbol := gdk_display_warp_pointer_symbol
			if l_gdk_display_warp_pointer_symbol /= default_pointer then
				gdk_display_warp_pointer_call (l_gdk_display_warp_pointer_symbol, {GDK_HELPERS}.default_display, {GDK_HELPERS}.default_screen, l_x, l_y)
			else
				l_x_test_fake_motion_event_symbol := x_test_fake_motion_event_symbol
				if l_x_test_fake_motion_event_symbol /= default_pointer then
					a_success_flag := x_test_fake_motion_event_call (l_x_test_fake_motion_event_symbol, gdk_x_display, -1, l_x, l_y, 0)
				end
			end
			if app_implementation.use_stored_display_data then
					-- If we are set to using the stored display data then it needs to be updated.
				app_implementation.update_display_data
			end
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Fake button `a_button' press on pointer.
		local
			a_success_flag: BOOLEAN
			l_p_b_press_symbol: POINTER
			l_window: POINTER
			l_x, l_y: INTEGER
			l_x_test_fake_button_event_symbol: POINTER
		do
			l_p_b_press_symbol := gdk_test_simulate_button_symbol
			if l_p_b_press_symbol /= default_pointer then
				l_window := {GDK_HELPERS}.window_at ($l_x, $l_y)
				a_success_flag := gdk_test_simulate_call (l_p_b_press_symbol, l_window, l_x, l_y, a_button, 0, {EV_GTK_ENUMS}.gdk_button_press_enum)
			end
			if not a_success_flag then
				l_x_test_fake_button_event_symbol := x_test_fake_button_event_symbol
				if l_x_test_fake_button_event_symbol /= default_pointer then
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_button_event_symbol, gdk_x_display, a_button, True, 0)
				end
			end
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Fake button `a_button' release on pointer.
		local
			a_success_flag: BOOLEAN
			l_p_b_release_symbol: POINTER
			l_window: POINTER
			l_x, l_y: INTEGER
			l_x_test_fake_button_event_symbol: POINTER
		do
			l_p_b_release_symbol := gdk_test_simulate_button_symbol
			if l_p_b_release_symbol /= default_pointer then
				l_window := {GDK_HELPERS}.window_at ($l_x, $l_y)
				a_success_flag := gdk_test_simulate_call (l_p_b_release_symbol, l_window, l_x, l_y, a_button, 0, {EV_GTK_ENUMS}.gdk_button_release_enum)
			end
			if not a_success_flag then
				l_x_test_fake_button_event_symbol := x_test_fake_button_event_symbol
				if l_x_test_fake_button_event_symbol /= default_pointer then
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_button_event_symbol, gdk_x_display, a_button, False, 0)
				end
			end
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		do
				--| Mouse pointer button number 4 relates to mouse wheel up
			fake_pointer_button_press (4)
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		do
				--| Mouse pointer button number 5 relates to mouse wheel up
			fake_pointer_button_press (5)
		end

	fake_key_press (a_key: EV_KEY)
			-- Fake key `a_key' press.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
			l_window, l_x_test_fake_key_event_symbol, l_x_keysym_to_keycode_symbol, l_gdk_test_simulate_key_symbol: POINTER
			l_x, l_y: INTEGER
		do
			l_x_test_fake_key_event_symbol := x_test_fake_key_event_symbol
			if l_x_test_fake_key_event_symbol /= default_pointer then
				l_x_keysym_to_keycode_symbol := x_keysym_to_keycode_symbol
				if l_x_keysym_to_keycode_symbol /= default_pointer then
					a_key_code := x_keysym_to_keycode_call (l_x_keysym_to_keycode_symbol, gdk_x_display, key_conversion.key_code_to_gtk (a_key.code).to_integer_32)
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_key_event_symbol, gdk_x_display, a_key_code, True, 0)
				end
			end

			if not a_success_flag then
				a_key_code := key_conversion.key_code_to_gtk (a_key.code).to_integer_32
				l_gdk_test_simulate_key_symbol := gdk_test_simulate_key_symbol
				if l_gdk_test_simulate_key_symbol /= default_pointer then
					l_window := {GDK_HELPERS}.window_at ($l_x, $l_y)
					a_success_flag := gdk_test_simulate_call (l_gdk_test_simulate_key_symbol, l_window, l_x, l_y, a_key_code, 0, {GTK}.gdk_key_press_enum)
				end
			end
		end

	fake_key_release (a_key: EV_KEY)
			-- Fake key `a_key' release.
		local
			a_success_flag: BOOLEAN
			a_key_code: INTEGER
			l_window, l_x_test_fake_key_event_symbol, l_x_keysym_to_keycode_symbol, l_gdk_test_simulate_key_symbol: POINTER
			l_x, l_y: INTEGER
		do
			l_x_test_fake_key_event_symbol := x_test_fake_key_event_symbol
			if l_x_test_fake_key_event_symbol /= default_pointer then
				l_x_keysym_to_keycode_symbol := x_keysym_to_keycode_symbol
				if l_x_keysym_to_keycode_symbol /= default_pointer then
					a_key_code := x_keysym_to_keycode_call (l_x_keysym_to_keycode_symbol, gdk_x_display, key_conversion.key_code_to_gtk (a_key.code).to_integer_32)
					a_success_flag := x_test_fake_key_button_event_call (l_x_test_fake_key_event_symbol, gdk_x_display, a_key_code, False, 0)
				end
			end

			if not a_success_flag then
				a_key_code := key_conversion.key_code_to_gtk (a_key.code).to_integer_32
				l_gdk_test_simulate_key_symbol := gdk_test_simulate_key_symbol
				if l_gdk_test_simulate_key_symbol /= default_pointer then
					l_window := {GDK_HELPERS}.window_at ($l_x, $l_y)
					a_success_flag := gdk_test_simulate_call (l_gdk_test_simulate_key_symbol, l_window, l_x, l_y, a_key_code, 0, {GTK}.gdk_key_release_enum)
				end
			end
		end

	key_conversion: EV_GTK_KEY_CONVERSION
			-- Utilities for converting X key codes.
		once
			create Result
		end


feature -- Measurement

	horizontal_resolution: INTEGER
			-- Number of logical pixels per inch along horizontal axis
		do
			Result := {GTK2}.gdk_screen_get_resolution ({GTK2}.gdk_screen_get_default)
			if Result = -1 then
					-- If no resolution has been set then default to 96.
				Result := 96
			end
		end

	vertical_resolution: INTEGER
			-- Number of logical pixels per inch along vertical axis
		do
			Result := {GTK2}.gdk_screen_get_resolution ({GTK2}.gdk_screen_get_default)
			if Result = -1 then
					-- If no resolution has been set then default to 96.
				Result := 96
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := app_implementation.screen_height
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := app_implementation.screen_width
		end

	virtual_x: INTEGER
			-- <Precursor>
		do
			Result := app_implementation.screen_virtual_x
		end

	virtual_y: INTEGER
			-- <Precursor>
		do
			Result := app_implementation.screen_virtual_y
		end

	virtual_height: INTEGER
			-- <Precursor>
		do
			Result := app_implementation.screen_virtual_height
		end

	virtual_width: INTEGER
			-- <Precursor>
		do
			Result := app_implementation.screen_virtual_width
		end

feature {NONE} -- Externals (XTEST extension)

	device_x_offset: INTEGER
			-- <Precursor>

	device_y_offset: INTEGER
			-- <Precursor>

	gdk_test_simulate_button_symbol: POINTER
			-- Symbol for `gdk_test_simulate_button'
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_test_simulate_button")
		end

	x_test_fake_button_event_symbol: POINTER
			-- Symbol for `XTestFakeButtonEvent'
		once
			Result := app_implementation.symbol_from_symbol_name ("XTestFakeButtonEvent")
		end

	x_test_fake_key_event_symbol: POINTER
			-- Symbol for `XTestFakeKeyEvent'
		once
			Result := app_implementation.symbol_from_symbol_name ("XTestFakeKeyEvent")
		end

	x_test_fake_motion_event_symbol: POINTER
			-- Symbol for `XTestFakeMotionEvent'
		once
			Result := app_implementation.symbol_from_symbol_name ("XTestFakeMotionEvent")
		end

	gdk_test_simulate_key_symbol: POINTER
			-- Symbol for `gdk_test_simulate_key'
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_test_simulate_key")
		end

	gdk_display_warp_pointer_symbol: POINTER
			-- Symbol for `gdk_display_warp_pointer'.
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_display_warp_pointer")
		end

	gdk_test_simulate_call (a_function, a_window: POINTER; a_x, a_y: INTEGER; a_button, a_modifiers: INTEGER; a_press_release: INTEGER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (FUNCTION_CAST(gboolean, (GdkWindow*, gint, gint, guint, GdkModifierType, GdkEventType)) $a_function) ((GdkWindow*) $a_window, (gint) $a_x, (gint) $a_y, (guint) $a_button, (GdkModifierType) $a_modifiers, (GdkEventType) $a_press_release)"
		end

	gdk_display_warp_pointer_call (a_function, a_display, a_screen: POINTER; a_x, a_y: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"(FUNCTION_CAST(void, (GdkDisplay*, GdkScreen*, gint, gint)) $a_function) ((GdkDisplay*) $a_display, (GdkScreen*) $a_screen, (gint) $a_x, (gint) $a_y)"
		end

	x_keysym_to_keycode_symbol: POINTER
			-- Symbol for `x_keysym_to_keycode'.
		once
			Result := app_implementation.symbol_from_symbol_name ("XKeysymToKeycode")
		end

	x_keysym_to_keycode_call (a_function, a_display: POINTER; a_keycode: INTEGER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_INTEGER, (EIF_POINTER, EIF_INTEGER)) $a_function) ((EIF_POINTER) $a_display, (EIF_INTEGER) $a_keycode)"
		end

	x_test_fake_key_button_event_call (a_function, a_display: POINTER; a_keycode_or_button: INTEGER; a_is_press: BOOLEAN; a_delay: INTEGER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_BOOLEAN, (EIF_POINTER, EIF_INTEGER, EIF_BOOLEAN, EIF_INTEGER)) $a_function) ((EIF_POINTER) $a_display, (EIF_INTEGER) $a_keycode_or_button, (EIF_BOOLEAN) $a_is_press, (EIF_INTEGER) $a_delay)"
		end

	x_test_fake_motion_event_call (a_function, a_display: POINTER; a_scr_num, a_x, a_y, a_delay: INTEGER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_BOOLEAN, (EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER)) $a_function) ((EIF_POINTER) $a_display, (EIF_INTEGER) $a_scr_num, (EIF_INTEGER) $a_x, (EIF_INTEGER) $a_x, (EIF_INTEGER) $a_delay)"
		end

feature {NONE} -- Implementation

	supports_pixbuf_alpha: BOOLEAN
			-- <Precursor>
		do
				-- For the moment EV_SCREEN doesn't support direct alpha blending.
			Result := False
		end

	frozen gdk_x_display: POINTER
		local
			l_symbol: POINTER
		do
			l_symbol := gdk_x11_display_get_xdisplay_symbol
			if l_symbol /= default_pointer then
				Result := gdk_x11_display_get_xdisplay_call (l_symbol, {GDK}.gdk_display_get_default)
			end
		end

	gdk_x11_display_get_xdisplay_symbol: POINTER
			-- Symbol for `gdk_x11_display_get_xdisplay'.
		once
			Result := app_implementation.symbol_from_symbol_name ("gdk_x11_display_get_xdisplay")
		end

	gdk_x11_display_get_xdisplay_call (a_function, a_display: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return (FUNCTION_CAST(EIF_POINTER, (GdkDisplay*)) $a_function) ((GdkDisplay*) $a_display)"
		end

	app_implementation: EV_APPLICATION_IMP
			-- Return the instance of EV_APPLICATION_IMP.
		local
			l_result: detachable EV_APPLICATION_IMP
		once
			l_result ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_result /= Void then end
			Result := l_result
		end

	flush
			-- Force all queued draw to be called.
		do
			-- By default do nothing
			if not drawable.is_default_pointer then
				{GDK_X11}.flush_drawable (drawable)
			end
		end

	update_if_needed
			-- Update `Current' if needed
		do
			device_x_offset := -app_implementation.screen_virtual_x.as_integer_16
			device_y_offset := -app_implementation.screen_virtual_y.as_integer_16
		end

	destroy
		do
			set_is_destroyed (True)
		end

	dispose
			-- Cleanup
		do
			if gc /= default_pointer then
				{GDK_X11}.x_free_gc (drawable, gc)
				gc := default_pointer
			end
		end

	internal_set_color (a_foreground: BOOLEAN; a_red, a_green, a_blue: REAL_64)
		local
			r,g,b: INTEGER
		do
			debug ("refactor_fixme")
				{REFACTORING_HELPER}.fixme ("The current Xlib code does not set the bg and fg correcty")
			end
			r := (a_red * 0xFFFF).rounded
			g := (a_green * 0xFFFF).rounded
			b := (a_blue * 0xFFFF).rounded
			if a_foreground then
				{GDK_X11}.set_drawable_foreground (drawable, gc, r, g, b)
			else
				{GDK_X11}.set_drawable_background (drawable, gc, r, g, b)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SCREEN note option: stable attribute end;

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

end -- class EV_SCREEN_IMP
