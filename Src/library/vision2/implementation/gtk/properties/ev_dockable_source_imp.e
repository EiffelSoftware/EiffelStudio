indexing
	description: "Gtk implementation of dockable source."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_IMP
	
inherit
	EV_DOCKABLE_SOURCE_I
		redefine
			interface
		end
	
	EV_ANY_IMP
		undefine
			destroy,
			needs_event_box
		redefine
			interface
		end

feature -- Status setting

	start_dragable_filter (
				a_type: INTEGER;
				a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER)
			is
				-- Filter out double click events.
			do
				if a_type = {EV_GTK_EXTERNALS}.gdk_button_press_enum then
					if a_button = 1 and not dawaiting_movement and widget_imp_at_pointer_position = Current then
							orig_cursor := pointer_style
							original_x_offset := a_x
							original_y_offset := a_y
							original_screen_x := a_screen_x
							original_screen_y := a_screen_y
							dawaiting_movement := True
							real_signal_connect (
								c_object,
								"motion-notify-event",
								agent dragable_motion (?,?,?,?,?,?,?),
								App_implementation.default_translate
							)
							drag_motion_notify_connection_id := last_signal_connection_id
							real_signal_connect (
								c_object,
								"button-release-event",
								agent end_dragable (?, ?, ?, ?, ?, ?, ?, ?),
								App_implementation.default_translate
							)
							drag_button_release_connection_id := last_signal_connection_id
					end
				end
			end
		
	dawaiting_movement: BOOLEAN
	original_screen_x, original_screen_y: INTEGER
		
	dragable_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if dawaiting_movement then
				if (original_screen_x - a_screen_x).abs > drag_and_drop_starting_movement or
					(original_screen_y - a_screen_y).abs > drag_and_drop_starting_movement
					then
						dawaiting_movement := False
						start_dragable (
								a_x,
								a_y,
								1,
								a_x_tilt,
								a_y_tilt,
								a_pressure,
								a_screen_x,
								a_screen_y
							)
						real_start_dragging (original_x_offset, original_y_offset, 1,
							0.0, 0.0, 0.0,
							a_screen_x + (original_x_offset - a_x), a_screen_y +
							(original_y_offset - a_y))
						
				end
			else
				execute_dragging (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
			end
		end

feature {NONE} -- Implementation

	internal_enable_dockable is
			-- Activate drag mechanism.
 		do
			if drag_button_press_connection_id = 0 then
				real_signal_connect (
					c_object,
					"button-press-event",
					agent (App_implementation.gtk_marshal).start_drag_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
					App_implementation.default_translate
				)
				drag_button_press_connection_id := last_signal_connection_id				
			end
		end
		
	internal_disable_dockable is
			-- Deactivate drag mechanism
		do
			if drag_button_press_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, drag_button_press_connection_id)
				drag_button_press_connection_id := 0
			end
		end

	drag_and_drop_starting_movement: INTEGER is 3

	start_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize the pick/drag and drop mechanism.
		do
			--call_press_actions (interface, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)

			--pointer_motion_actions_internal.block	
			enable_capture
			initialize_transport (a_screen_x, a_screen_y, interface)
			App_implementation.enable_is_in_transport
		end
		
	drag_button_press_connection_id, drag_button_release_connection_id, drag_motion_notify_connection_id: INTEGER
			-- Signal id's for drag event connection.

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		do
			set_pointer_style (Drag_cursor)
		end
		
	orig_cursor: EV_CURSOR
		
	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		do
			disable_capture
			set_composite_widget_pointer_style (NULL)
			if drag_button_release_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, drag_button_release_connection_id)
				drag_button_release_connection_id := 0
			end
			if drag_motion_notify_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, drag_motion_notify_connection_id)
				drag_motion_notify_connection_id := 0
			end
			if not dawaiting_movement then
				if orig_cursor /= Void then
						-- Restore the cursor style of `Current' if necessary.
					set_pointer_style (orig_cursor)
					orig_cursor := Void
				end
				if widget_imp_at_pointer_position = Current then
					-- We are dropping back on to the same widget, therefore prevent selection events if applicable.
					--| FIXME IEK Need to find a better method of preventing execution of selection actions.
					signal_emit_stop (event_widget, "button_release_event")
				end
				complete_dock
				original_x_offset := -1
				original_y_offset := -1
				dawaiting_movement := False
				App_implementation.disable_is_in_transport
			elseif dawaiting_movement then
				dawaiting_movement := False
			end
		end
		
	enable_capture is
			-- 
		deferred
		end
		
	disable_capture is
			-- 
		deferred
		end
		
	set_pointer_style (a_cursor: EV_CURSOR) is
			-- Assign `a_cursor' to `pointer_style'
		deferred
		end
		
	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER) is
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		do
			-- For now do nothing until further investigation has taken place.
		end
		
feature {NONE} -- Implementation

	signal_emit_stop (a_c_object: POINTER; signal: STRING) is
		deferred
		end

	event_widget: POINTER is
			-- Pointer to the GtkWidget to which the events are hooked up to
		deferred
		end	
		
feature {EV_ANY_I} -- Implementation

	set_composite_widget_pointer_style (a_cursor: POINTER) is
			-- 
		deferred
		end

	pointer_style: EV_CURSOR is
			-- 
		deferred
		end

	interface: EV_DOCKABLE_SOURCE;

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




end -- class EV_DOCKABLE_IMP

