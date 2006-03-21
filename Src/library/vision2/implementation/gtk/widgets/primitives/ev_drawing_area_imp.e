indexing
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
			interface
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
			button_press_switch,
			initialize,
			tooltips_pointer,
			set_tooltip,
			tooltip,
			on_pointer_enter_leave,
			on_key_event,
			set_focus
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface,
			process_gdk_event
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_drawing_area_new)
		end

	initialize is
			-- Initialize `Current'.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_redraw_on_allocate (c_object, True)
				-- When false, this means that when the drawing area is resized, only the new portions are redrawn
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (App_implementation.default_gdk_window)
			init_default_values
			disable_double_buffering
			disable_tabable_to
			disable_tabable_from

			real_set_background_color (c_object, background_color)

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

	enable_double_buffering is
			-- Allow `Current' to have all exposed area double buffered.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_double_buffered (visual_widget, True)
		end

	disable_double_buffering is
			-- Disable double buffering for exposed areas.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_double_buffered (visual_widget, False)
		end

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
					reset_tooltip_position := True
					tooltip_repeater.set_interval (app_implementation.tooltip_delay)
				else
					show_tooltips_if_activated := False
					update_tooltip_window
					tooltip_repeater.set_interval (0)
				end
			end
		end

	reset_tooltip_position: BOOLEAN
		-- Should the tooltip window position be reset?

	update_tooltip_window is
			-- Update the tooltip window.
		local
			a_tip_win: POINTER
			l_show_tooltips: BOOLEAN
			a_window: POINTER
			i, a_x, a_y, a_screen_x, a_screen_y: INTEGER
		do
			a_window := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_x, $a_y)
			if a_window = drawable and then show_tooltips_if_activated and then not has_capture then
				if reset_tooltip_position then
					i := {EV_GTK_EXTERNALS}.gdk_window_get_origin (a_window, $a_screen_x, $a_screen_y)
					tooltip_initial_x := a_screen_x + a_x
					tooltip_initial_y := a_screen_y + a_y
					reset_tooltip_position := False
				end
				l_show_tooltips := True
			else
				show_tooltips_if_activated := False
				tooltip_repeater.set_interval (0)
			end
			a_tip_win := {EV_GTK_EXTERNALS}.gtk_tooltips_struct_tip_window (tooltips_pointer)
			if l_show_tooltips then
				{EV_GTK_EXTERNALS}.gtk_window_move (a_tip_win, tooltip_initial_x, tooltip_initial_y + tooltip_window_y_offset)
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_tip_win)
			else
				{EV_GTK_EXTERNALS}.gtk_widget_hide (a_tip_win)
			end
		end

	tooltip_initial_x, tooltip_initial_y: INTEGER
		-- Initial x and y coordinates for the tooltip window.

	tooltip_window_y_offset: INTEGER is 20
		-- Amount of pixels tooltip window is offset down from the mouse pointer when shown.

	tooltip_repeater: EV_TIMEOUT
		-- Timeout repeater used for hiding/show tooltip.

	show_tooltips_if_activated: BOOLEAN
		-- Should tooltips be shown if activated?

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
			if not a_text.is_empty and then is_displayed then
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
			Result := a_key.is_arrow or else (not is_tabable_from and a_key.code = {EV_KEY_CONSTANTS}.key_tab)
		end

	redraw is
			-- Redraw the entire area.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_queue_draw (c_object)
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
			refresh_now
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

	mask: POINTER is
			-- Mask of Current, which is always NULL.
		do
			-- Not applicable for drawing area
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

	lose_focus is
			-- Current has lost keyboard focus.
		do
			update_tooltip (False)
		end

	set_focus is
			-- Grab keyboard focus.
		local
			l_can_focus: BOOLEAN
		do
			l_can_focus := has_struct_flag (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			if not l_can_focus then
				{EV_GTK_EXTERNALS}.gtk_widget_set_flags (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			end
			Precursor {EV_PRIMITIVE_IMP}
				-- Reset focus handling.
			if not l_can_focus then
				{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			end
		end

feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Used for key event actions sequences.
		do
				-- Make sure tooltip window is hidden.
			update_tooltip (False)
			Precursor {EV_PRIMITIVE_IMP} (a_key, a_key_string, a_key_press)
		end

	button_press_switch (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		do
				-- Make sure the tooltip is hidden if any button events occur.
			update_tooltip (False)
			if a_type = {EV_GTK_ENUMS}.gdk_button_press_enum and then not has_struct_flag (visual_widget, {EV_GTK_EXTERNALS}.gtk_has_focus_enum) and then (a_button = 1 and then a_button <= 3) then
					-- As a button has been pressed on the drawing area then
				set_focus
			end
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	interface: EV_DRAWING_AREA
		-- Interface object of Current.

	destroy is
			-- Destroy implementation.
		do
			update_tooltip (False)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DRAWING_AREA_IMP

