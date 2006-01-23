indexing
	description:
		"Eiffel Vision pick and drop source, GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_GTK_WIDGET_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				execute
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		deferred
		end

feature {NONE} -- Implementation

	enable_capture is
			-- Grab all the mouse and keyboard events.
		local
			i: INTEGER
		do
			if not has_capture then
				App_implementation.disable_debugger
				if not has_focus then
					set_focus
				end
				{EV_GTK_EXTERNALS}.gtk_grab_add (event_widget)
				i := {EV_GTK_EXTERNALS}.gdk_pointer_grab ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), 1, {EV_GTK_EXTERNALS}.gdk_button_release_mask_enum + {EV_GTK_EXTERNALS}.gdk_button_press_mask_enum + {EV_GTK_EXTERNALS}.gdk_pointer_motion_mask_enum, null, null, 0)
				i := {EV_GTK_EXTERNALS}.gdk_keyboard_grab ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), True, 0)
			end
		end

	disable_capture is
			-- Ungrab all the mouse and keyboard events.
			--| Used by pick and drop.
		do
			if has_capture then
				{EV_GTK_EXTERNALS}.gtk_grab_remove (event_widget)
				{EV_GTK_EXTERNALS}.gdk_pointer_ungrab (
					0 -- guint32 time
				)
				{EV_GTK_EXTERNALS}.gdk_keyboard_ungrab (0) -- guint32 time
				App_implementation.enable_debugger
			end
		end

	has_capture: BOOLEAN is
			-- Does Current have the keyboard and mouse event capture?
		do
			Result := has_struct_flag (event_widget, {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM) or else
				has_struct_flag (c_object, {EV_GTK_EXTERNALS}.GTK_HAS_GRAB_ENUM)
		end

feature -- Implementation

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
 			if not is_destroyed then
				if button_press_connection_id > 0 then
					{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, button_press_connection_id)
				end
				real_signal_connect (
					event_widget,
					"button-press-event",
					agent (App_implementation.gtk_marshal).start_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
					App_implementation.default_translate
				)
				button_press_connection_id := last_signal_connection_id
				is_transport_enabled := True
			end
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			disable_transport_signals
			is_transport_enabled := False
		ensure then
			is_transport_disabled: not is_transport_enabled
			button_press_disconnected: button_press_connection_id = 0
			button_release_disconnected: button_release_connection_id = 0
		end

	disable_transport_signals is
		do
			if button_press_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, button_press_connection_id)
				button_press_connection_id := 0
			end
			if button_release_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, button_release_connection_id)
				button_release_connection_id := 0
			end
		end

	start_transport_filter (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Filter out double click events.
		do
			if a_type = {EV_GTK_EXTERNALS}.Gdk_button_press_enum and then gtk_widget_imp_at_pointer_position = Current
			and then not App_implementation.is_in_transport then
				start_transport (
					a_x,
					a_y,
					a_button,
					a_x_tilt,
					a_y_tilt,
					a_pressure,
					a_screen_x,
					a_screen_y
				)
			end
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		do
			update_pointer_style (pointed_target)
			app_implementation.on_pick (pebble)
			if pick_actions_internal /= Void then
				pick_actions_internal.call ([a_x, a_y])
			end
			pointer_x := a_screen_x
			pointer_y := a_screen_y
			if pick_x = 0 and pick_y = 0 then
				App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
			else
				if pick_x > width then
					pick_x := width
				end
				if pick_y > height then
					pick_y := height
				end
				App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
		do
			Result := (mode_is_drag_and_drop and then a_button = 1 and then not is_dockable) or
				(mode_is_pick_and_drop and then a_button = 3)
		end

	is_dockable: BOOLEAN is
			-- Is `Current' dockable?
		deferred
		end

	set_to_drag_and_drop: BOOLEAN is
		do
			Result := mode_is_drag_and_drop
		end

	start_transport (
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		local
			app_imp: EV_APPLICATION_IMP
			l_motion_notify_connection_id, l_enter_notify_connection_id, l_leave_notify_connection_id: INTEGER
		do
			call_press_actions (interface, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			if able_to_transport (a_button) or else ready_for_pnd_menu (a_button) then
				call_pebble_function (a_x, a_y, a_screen_x, a_screen_y)
			end

			if pebble /= Void then
				if
					able_to_transport (a_button)
					--FIXME and then not data.shift_key_pressed
					--FIXME and then not data.control_key_pressed
				then
					check
						grab_callback_not_connected: grab_callback_connection_id = 0
						start_transport_connected: button_press_connection_id > 0
						motion_notify_not_connected: motion_notify_connection_id = 0
						enter_notify_not_connected: enter_notify_connection_id = 0
						leave_notify_not_connected: leave_notify_connection_id = 0
					end
					interface.pointer_motion_actions.block
					pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y)
					real_signal_connect (
						event_widget,
						"motion-notify-event",
						agent (App_implementation.gtk_marshal).add_grab_cb_intermediary (c_object),
						App_implementation.default_translate
					)
					App_implementation.set_grab_callback_connection_id (last_signal_connection_id)

					enable_capture

					if drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (pebble) then
						-- Set correct accept cursor
						if accept_cursor /= Void then
							internal_set_pointer_style (accept_cursor)
						else
							internal_set_pointer_style (default_accept_cursor)
						end
					else
						-- Set correct deny cursor
						if deny_cursor /= Void then
							internal_set_pointer_style (deny_cursor)
						else
							internal_set_pointer_style (default_deny_cursor)
						end
					end

					{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, button_press_connection_id)
					real_signal_connect (
						event_widget,
						"button-press-event",
						agent (App_implementation.gtk_marshal).end_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
						App_implementation.default_translate
					)
					button_press_connection_id := last_signal_connection_id
					if set_to_drag_and_drop then
						check
							release_not_connected: button_release_connection_id = 0
						end
						real_signal_connect (
							event_widget,
							"button-release-event",
							agent (App_implementation.gtk_marshal).end_transport_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?),
							App_implementation.default_translate
						)
						button_release_connection_id := last_signal_connection_id
					end

					real_signal_connect (
						event_widget,
						"motion-notify-event",
						agent (App_implementation.gtk_marshal).execute_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?),
						App_implementation.default_translate
					)
					l_motion_notify_connection_id := last_signal_connection_id
					real_signal_connect (
						event_widget,
						"enter_notify_event",
						agent (App_implementation.gtk_marshal).signal_emit_stop_intermediary (internal_id, event_widget, "enter_notify_event"),
						App_implementation.default_translate
					)
					l_enter_notify_connection_id := last_signal_connection_id
					real_signal_connect (
						event_widget,
						"leave_notify_event",
						agent (App_implementation.gtk_marshal).signal_emit_stop_intermediary (internal_id, event_widget, "leave_notify_event"),
						App_implementation.default_translate
					)
					l_leave_notify_connection_id := last_signal_connection_id
					App_implementation.set_pnd_signal_ids (l_motion_notify_connection_id, l_leave_notify_connection_id, l_enter_notify_connection_id)
					check
						motion_notify_connected: motion_notify_connection_id > 0
						enter_notify_connected: enter_notify_connection_id > 0
						leave_notify_connected: leave_notify_connection_id > 0
						mode_is_drag_and_drop_implies_release_connected:
							mode_is_drag_and_drop implies
							button_release_connection_id > 0
					end
					(App_implementation.gtk_marshal).signal_emit_stop_intermediary (internal_id, event_widget, "button-press-event")

				elseif ready_for_pnd_menu (a_button) then
					app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
					check
						app_imp_not_void: app_imp /= Void
					end
					app_imp.target_menu (pebble).show
				end
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
		do
			Result := mode_is_target_menu and a_button = 3
		end

	signal_emit_stop (a_c_object: POINTER; signal: STRING) is
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := signal
			{EV_GTK_EXTERNALS}.signal_emit_stop_by_name (a_c_object, a_cs.item)
		end

	end_transport_filter (a_type, a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER) is
			-- Filter out double click events.
		do
			if a_type = {EV_GTK_EXTERNALS}.Gdk_button_press_enum then
				end_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End a pick and drop transport.
		local
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			--a_mouse_x, a_mouse_y: INTEGER
			--a_mouse_window: POINTER
			l_motion_notify_connection_id, l_enter_notify_connection_id, l_leave_notify_connection_id: INTEGER
		do
			check
				motion_notify_connected: motion_notify_connection_id > 0
				enter_notify_connected: enter_notify_connection_id > 0
				leave_notify_connected: leave_notify_connection_id > 0
			end
			erase_rubber_band
			disable_capture
			if button_release_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, button_release_connection_id)
				button_release_connection_id := 0
			end
			if motion_notify_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, motion_notify_connection_id)
				l_motion_notify_connection_id := 0
			end
			if enter_notify_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, enter_notify_connection_id)
				l_enter_notify_connection_id := 0
			end
			if leave_notify_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, leave_notify_connection_id)
				l_leave_notify_connection_id := 0
			end
			if grab_callback_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, grab_callback_connection_id)
				App_implementation.set_grab_callback_connection_id (0)
			end
			if not is_destroyed then
				if pointer_style /= Void then
					internal_set_pointer_style (pointer_style)
				else
					-- Reset the cursors.
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL)
					{EV_GTK_EXTERNALS}.gdk_window_set_cursor ({EV_GTK_EXTERNALS}.gtk_widget_struct_window (event_widget), NULL)
				end
				{EV_GTK_EXTERNALS}.gtk_widget_draw (c_object, NULL)
				{EV_GTK_EXTERNALS}.gtk_widget_draw (event_widget, NULL)
			end

			App_implementation.set_pnd_signal_ids (l_motion_notify_connection_id, l_leave_notify_connection_id, l_enter_notify_connection_id)

				-- Make sure 'in_transport' returns False before firing any drop actions.
			App_implementation.on_drop (pebble)

				-- Call appropriate action sequences
			if
				able_to_transport (a_button)
			then
				target := pointed_target
				if target /= Void and then target.drop_actions.accepts_pebble (pebble) then
					target.drop_actions.call ([pebble])
					App_implementation.drop_actions.call ([pebble])
				else
					App_implementation.cancel_actions.call ([pebble])
				end
			else
				App_implementation.cancel_actions.call ([pebble])
			end

			if pick_ended_actions_internal /= Void then
				pick_ended_actions_internal.call ([target])
			end

			if not is_destroyed then
				enable_transport
				interface.pointer_motion_actions.resume
			end

			post_drop_steps (a_button)
			if a_button > 0 and then able_to_transport (a_button) then
				call_press_actions (target, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			end
			check
				motion_notify_not_connected: motion_notify_connection_id = 0
				enter_notify_not_connected: enter_notify_connection_id = 0
				leave_notify_not_connected: leave_notify_connection_id = 0
				grab_callback_not_connected: grab_callback_connection_id = 0
				button_release_not_connected: button_release_connection_id = 0
			end
		end

	call_press_actions (targ: EV_ABSTRACT_PICK_AND_DROPABLE; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
		local
			wid: EV_WIDGET
			wid_imp: EV_WIDGET_IMP
		do
			wid ?= targ
			if wid /= Void then
				wid_imp ?= wid.implementation
				if wid_imp /= Void and not wid_imp.is_destroyed then
					if (a_x >= 0 and a_x <= wid_imp.width) and (a_y >= 0 and a_y <= wid_imp.height) then
						wid_imp.button_press_switch ({EV_GTK_ENUMS}.gdk_button_press_enum, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					end
				end
			end
		end

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
			if a_button > 0 and then mode_is_pick_and_drop and not is_destroyed then
				signal_emit_stop (event_widget, "button-press-event")
			end
			App_implementation.set_x_y_origin (0, 0)
			last_pointed_target := Void
			if pebble_function /= Void then
				pebble_function.clear_last_result
				pebble := Void
			end
		end

	add_grab_cb is
			-- Disconnect callback that called us and `enable_capture'.
		do
			check
				grab_callback_connected: grab_callback_connection_id > 0
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (event_widget, grab_callback_connection_id)
			App_implementation.set_grab_callback_connection_id (0)
			enable_capture
		end

	draw_rubber_band is
			-- Draw a segment between initial pick point and `destination'.
		local
		do
				erase_rubber_band
				App_implementation.set_old_pointer_x_y_origin (pointer_x, pointer_y)
				pnd_screen.draw_segment (x_origin, y_origin, old_pointer_x, old_pointer_y)
				rubber_band_is_drawn := True
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				pnd_screen.draw_segment (x_origin, y_origin, old_pointer_x, old_pointer_y)
				rubber_band_is_drawn := False
			end
		end

	pnd_screen: EV_SCREEN is
			-- Screen object used for drawing PND transport line
		once
			create Result
			Result.enable_dashed_line_style
			Result.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			Result.set_invert_mode
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			gdkwin: POINTER
			x, y: INTEGER
			a_wid_imp: EV_PICK_AND_DROPABLE_IMP
			a_pnd_deferred_item_parent: EV_PND_DEFERRED_ITEM_PARENT
			a_row_imp: EV_PND_DEFERRED_ITEM
			pnd_targets: ARRAYED_LIST [INTEGER]
		do
			a_wid_imp ?= gtk_widget_imp_at_pointer_position
			if a_wid_imp /= Void and then has_struct_flag (a_wid_imp.c_object, {EV_GTK_EXTERNALS}.gTK_SENSITIVE_ENUM) then
				if App_implementation.pnd_targets.has (a_wid_imp.interface.object_id) then
					Result := a_wid_imp.interface
				end
				a_pnd_deferred_item_parent ?= a_wid_imp
				if a_pnd_deferred_item_parent /= Void then
						-- We need to explicitly search for PND deferred items
					gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($x, $y)
					pnd_targets := App_implementation.pnd_targets
					a_row_imp := a_pnd_deferred_item_parent.row_from_y_coord (y)
					if a_row_imp /= Void and then pnd_targets.has (a_row_imp.interface.object_id) then
						Result := a_row_imp.interface
					end
				end
			end
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create and initialize `drop_actions' for `Current'
		do
			create Result
			interface.init_drop_actions (Result)
		end

feature {NONE} -- Implementation

	x_origin: INTEGER is
			-- Temp coordinate value for origin of Pick and Drop.
		do
			Result := app_implementation.x_origin
		end

	y_origin: INTEGER is
			-- Temp coordinate value for origin of Pick and Drop.
		do
			Result := app_implementation.y_origin
		end

	old_pointer_x: INTEGER is
			--
		do
			Result := app_implementation.old_pointer_x
		end

	old_pointer_y: INTEGER is
			--
		do
			Result := app_implementation.old_pointer_y
		end

	grab_callback_connection_id: INTEGER is
			-- GTK signal connection id for motion-notify-event.
			-- (Used to trigger a global user input grab)
		do
			Result := app_implementation.grab_callback_connection_id
		end

	motion_notify_connection_id: INTEGER is
			-- GTK signal connection id for motion-notify-event.
			-- (Used to draw rubber band line between pick point and pointer)
		do
			Result := app_implementation.motion_notify_connection_id
		end

	leave_notify_connection_id: INTEGER is
			-- GTK signal connection id for leave-notify-event.
			-- (Used to suspend leave events during rubber band line drawing)
		do
			Result := app_implementation.leave_notify_connection_id
		end

	enter_notify_connection_id: INTEGER is
			-- GTK signal connection id for enter-notify-event.
			-- (Used to suspend enter events during rubber band line drawing)
		do
			Result := app_implementation.enter_notify_connection_id
		end

	button_press_connection_id: INTEGER
			-- GTK signal connection id for button-press-event.

	button_release_connection_id: INTEGER
			-- GTK signal connection id for button-release-event.

	gdk_widget_no_window (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_WIDGET_NO_WINDOW"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PICK_AND_DROPABLE;

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




end -- class EV_PICK_AND_DROPABLE_IMP

