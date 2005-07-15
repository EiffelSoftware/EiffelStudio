indexing
	description: "EiffelVision drawing area. GTK implementation."
	status: "See notice at end of class"
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
			interface,
			set_background_color,
			clear_rectangle
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			default_key_processing_blocked,
			dispose,
			destroy,
			needs_event_box,
			gdk_events_mask,
			button_press_switch,
			initialize,
			tooltips_pointer,
			set_tooltip,
			tooltip,
			on_pointer_enter_leave
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface,
			needs_event_box,
			process_gdk_event
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False
		-- Place drawing area inside an event box.

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_drawing_area_new)
		end	

	initialize is
			-- Initialize `Current'.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_redraw_on_allocate (c_object, False)
				-- This means that when the drawing area is resized, only the new portions are redrawn
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (App_implementation.default_gdk_window)
			init_default_values
			{EV_GTK_EXTERNALS}.gtk_widget_set_double_buffered (c_object, False)
			disable_tabable_to
			disable_tabable_from
			
				-- Initialize tooltip.
			internal_tooltip := ""		
			Precursor {EV_PRIMITIVE_IMP}
		end

feature -- Status report

	is_tabable_to: BOOLEAN
			-- Is Current able to be tabbed to?

	is_tabable_from: BOOLEAN
			-- Is Current able to be tabbed from?

feature -- Status setting

	enable_tabable_to is
			-- Make `is_tabable_to' `True'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_flags (c_object, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			is_tabable_to := True
		end

	disable_tabable_to is
			-- Make `is_tabable_to' `False'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (c_object, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			is_tabable_to := False
		end

	enable_tabable_from is
			-- Make `is_tabable_from' `True'.
		do
			is_tabable_from := True
		end

	disable_tabable_from is
			-- Make `is_tabable_from' `False'.
		do
			is_tabable_from := False
		end

feature {NONE} -- Implementation

	on_pointer_enter_leave (a_enter: BOOLEAN) is
			-- The mouse pointer has either just entered or left `Current'.
		do
			update_tooltip (a_enter)
			Precursor {EV_PRIMITIVE_IMP} (a_enter)
		end

	update_tooltip (a_show_tooltip: BOOLEAN) is
			-- Set tooltip status to `a_show_tooltip'.
		do
			if tooltips_pointer /= default_pointer then
				-- Tooltips have been initialized so activate them.
				if a_show_tooltip then
					show_tooltips_if_activated := True
					tooltip_repeater.set_interval (app_implementation.tooltip_delay)
				else
					show_tooltips_if_activated := False
					update_tooltip_window
					tooltip_repeater.set_interval (0)
				end
			end	
		end

	update_tooltip_window is
			-- Update the tooltip window.
		local
			a_tip_win: POINTER
			a_mouse_coords: EV_COORDINATE
			l_x, l_y: INTEGER
			l_show_tooltip: BOOLEAN
		do
			a_tip_win := {EV_GTK_EXTERNALS}.gtk_tooltips_struct_tip_window (tooltips_pointer)
			a_mouse_coords := pnd_screen.pointer_position
			l_x := a_mouse_coords.x
			l_y := a_mouse_coords.y
			
			if
				l_x > (tooltip_initial_x + tooltip_delta) or else l_x < (tooltip_initial_x - tooltip_delta) or else
				l_y > (tooltip_initial_y + tooltip_delta) or else l_y < (tooltip_initial_y - tooltip_delta)
			then
				tooltip_initial_x := l_x
				tooltip_initial_y := l_y
				l_show_tooltip := False
			else
				l_show_tooltip := True
			end
			
			if show_tooltips_if_activated and then l_show_tooltip then
				{EV_GTK_EXTERNALS}.gtk_window_move (a_tip_win, tooltip_initial_x, tooltip_initial_y + tooltip_window_y_offset)
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_tip_win)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_hide (a_tip_win)
			end
		end

	tooltip_delta: INTEGER is 5
		-- Amount of pixels +/- that the pointer has to move in either axis to deactivate tooltip from initial showing.

	tooltip_window_y_offset: INTEGER is 20
		-- Amount of pixels tooltip window is offset down from the mouse pointer when shown.

	tooltip_repeater: EV_TIMEOUT
		-- Timeout repeater used for hiding/show tooltip.

	show_tooltips_if_activated: BOOLEAN
		-- Should tooltips be shown if activated?
	
	tooltip_initial_x, tooltip_initial_y: INTEGER
		-- Initial tooltip x and y coordinate.
		
	tooltips_pointer: POINTER
		-- Tooltips pointer for `Current'.

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		local
			a_tip_label: POINTER
			a_tip_win: POINTER
			a_cs: EV_GTK_C_STRING
		do
			if tooltips_pointer = default_pointer then
				-- The tooltips have not yet been initialized.
				tooltips_pointer := {EV_GTK_EXTERNALS}.gtk_tooltips_new
				{EV_GTK_EXTERNALS}.gtk_tooltips_force_window (tooltips_pointer)
				a_tip_win := {EV_GTK_EXTERNALS}.gtk_tooltips_struct_tip_window (tooltips_pointer)
				{EV_GTK_EXTERNALS}.gtk_window_set_position (a_tip_win, {EV_GTK_EXTERNALS}.gtk_win_pos_mouse_enum)
				create tooltip_repeater
				tooltip_repeater.actions.extend (agent update_tooltip_window)
			end
			internal_tooltip := a_text.twin
			a_cs := App_implementation.c_string_from_eiffel_string (internal_tooltip)

			a_tip_label := {EV_GTK_EXTERNALS}.gtk_tooltips_struct_tip_label (tooltips_pointer)
			a_tip_win := {EV_GTK_EXTERNALS}.gtk_tooltips_struct_tip_window (tooltips_pointer)
			{EV_GTK_EXTERNALS}.gtk_label_set_text (a_tip_label, a_cs.item)
			{EV_GTK_EXTERNALS}.gtk_widget_hide (a_tip_win)
			if not a_text.is_empty then
				update_tooltip (True)
			else
				update_tooltip (False)
			end	
		end

	tooltip: STRING is
			-- Tooltip for `Current'.
		do
			Result := internal_tooltip.twin
		end

	internal_tooltip: STRING
		-- Used for storing `tooltip' of `Current'.

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- Should default key processing be allowed for `a_key'.
		do
			Result := a_key.is_arrow or else (not is_tabable_from and a_key.code = App_implementation.Key_constants.key_tab)
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		local
			color_struct: POINTER
			a_success: BOOLEAN
		do
			if internal_background_color /= a_color then
				internal_background_color := a_color
				color_struct := app_implementation.reusable_color_struct
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, a_color.red_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, a_color.green_16_bit)
				{EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, a_color.blue_16_bit)
				a_success := {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, color_struct, False, True)
				{EV_GTK_EXTERNALS}.gdk_gc_set_rgb_bg_color (gc, color_struct)	
				{EV_GTK_EXTERNALS}.gdk_window_set_background (drawable, color_struct)
			end
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Erase rectangle specified with `background_color'.
		do
			if drawable /= default_pointer then
				--| FIXME IEK Find a way so that gtk can do background clearing implicitly without having to repaint the background each time.
				--{EV_GTK_EXTERNALS}.gdk_window_clear_area (drawable, x, y, a_width, a_height)
				Precursor {EV_DRAWABLE_IMP} (x, y , a_width, a_height)
			end
		end

	redraw is
			-- Redraw the entire area.
		do
			redraw_rectangle (0, 0, width, height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'.
		local
			a_rectangle: POINTER
			a_drawable: POINTER
		do
			a_drawable := drawable
			if a_drawable /= NULL then
				a_rectangle := app_implementation.reusable_rectangle_struct
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_width (a_rectangle, a_width)
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_height (a_rectangle, a_height)
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_x (a_rectangle, a_x)
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_y  (a_rectangle, a_y)
				{EV_GTK_EXTERNALS}.gdk_window_invalidate_rect (a_drawable, a_rectangle, False)				
			end
		end
		
	clear_and_redraw is
			-- Clear `Current' and redraw.
		do
			clear
			redraw
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear the rectangle area defined by `a_x', `a_y', `a_width', `a_height' and then redraw it.
		do
			clear_rectangle (a_x, a_y, a_width, a_height)
			redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	flush is
			-- Redraw the screen immediately.
		do
			if drawable /= NULL and then is_displayed then
				{EV_GTK_EXTERNALS}.gdk_window_process_updates (drawable, False)
			end
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
			-- Not applicable
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
			-- Pointer to the drawable object for `Current'.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object)
		end

	mask: POINTER
			-- Mask of Current, which is always NULL.
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

	lose_focus is
		do
			--| FIXME IEK Remove me
		end
		
feature {NONE} -- Implementation

	Gdk_events_mask: INTEGER is
			-- Mask of all the gdk events the gdkwindow shall receive.
		once
			Result := Precursor {EV_PRIMITIVE_IMP} |
			{EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_HINT_MASK_ENUM
				-- We only want motion events when we query for them.
				-- Setting this flag on other gtk widgets such as GtkTreeView causes problems with the implementation
		end

	button_press_switch (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do
			if not is_tabable_to then
				{EV_GTK_EXTERNALS}.gtk_widget_set_flags (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			end
			if a_type = {EV_GTK_ENUMS}.gdk_button_press_enum and then not has_struct_flag (visual_widget, {EV_GTK_EXTERNALS}.gtk_has_focus_enum) and then (a_button = 1 and then a_button <= 3) then
					-- As a button has been pressed on the drawing area then 
				set_focus
			end
			if not is_tabable_to then
				{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			end
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	interface: EV_DRAWING_AREA
		-- Interface object of Current.

	destroy is
			-- Destroy implementation.
		do
			Precursor {EV_PRIMITIVE_IMP}
			if gc /= NULL then
				{EV_GTK_EXTERNALS}.gdk_gc_unref (gc)
				gc := NULL
			end
		end
		
	dispose is
			-- Clean up
		do
			if gc /= NULL then
				gdk_gc_unref (gc)
				gc := NULL
			end
			Precursor {EV_PRIMITIVE_IMP}
		end	

end -- class EV_DRAWING_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

