indexing
	description:
		"Eiffel Vision pick and drop source, GTK implementation."
	status: "See notice at end of class"
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_ANY_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

feature -- Implementation

--| FIXME IEK Remove this when cursor setting is fixed on Windows.
	temp_execute (
			a_x, a_y: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Executed when `pebble' is being moved.
			-- Draw a rubber band from pick position to pointer position.
		local
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			real_target: EV_PICK_AND_DROPABLE
		do
			draw_rubber_band
			pointer_x := a_screen_x
			pointer_y := a_screen_y
			
			target := pointed_target
			real_target ?= target
			if target /= last_pointed_target then
				update_pointer_style (target)
			end

			if App_implementation.pnd_motion_actions_internal /= Void then
				App_implementation.pnd_motion_actions_internal.call ([a_x, a_y, real_target])
			end
			
			last_pointed_target := target
		end

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
			check
				button_release_not_connected: button_release_connection_id = 0
			end
			if button_press_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_press_connection_id)
			end
			real_signal_connect (
				visual_widget,
				"button-press-event",
				agent (App_implementation.gtk_marshal).start_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
				App_implementation.default_translate
			)
			button_press_connection_id := last_signal_connection_id
			is_transport_enabled := True
		ensure then
			press_connection_successful: button_press_connection_id > 0
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
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_press_connection_id)
				button_press_connection_id := 0
			end
			if button_release_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_release_connection_id)
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
			if a_type = feature {EV_GTK_EXTERNALS}.Gdk_button_press_enum and then widget_imp_at_pointer_position = Current 
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
				x_origin := a_screen_x
				y_origin := a_screen_y
			else
				if pick_x > width then
					pick_x := width
				end
				if pick_y > height then
					pick_y := height
				end
				x_origin := pick_x + (a_screen_x - a_x)
				y_origin := pick_y + (a_screen_y - a_y)
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
		do
			Result := (mode_is_drag_and_drop and then a_button = 1 and then not is_dockable) or
				(mode_is_pick_and_drop and then a_button = 3)
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
		do
			if not has_focus and then (a_button = 1 or a_button = 3) then
					-- We explicitly set the focus for both left and right mouse buttons if not set already
				feature {EV_GTK_EXTERNALS}.gtk_widget_grab_focus (visual_widget)
			end
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
						visual_widget,
						"motion-notify-event",
						agent (App_implementation.gtk_marshal).add_grab_cb_intermediary (c_object),
						App_implementation.default_translate
					)
					grab_callback_connection_id := last_signal_connection_id

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

					feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_press_connection_id)
					real_signal_connect (
						visual_widget,
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
							visual_widget,
							"button-release-event",
							agent (App_implementation.gtk_marshal).end_transport_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?),
							App_implementation.default_translate
						)
						button_release_connection_id := last_signal_connection_id
					end

					real_signal_connect (
						visual_widget,
						"motion-notify-event",
						agent (App_implementation.gtk_marshal).temp_execute_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?),
						App_implementation.default_translate
					)
					motion_notify_connection_id := last_signal_connection_id
					real_signal_connect (
						visual_widget,
						"enter_notify_event",
						agent (App_implementation.gtk_marshal).signal_emit_stop_intermediary (internal_id, visual_widget, "enter_notify_event"),
						App_implementation.default_translate
					)
					enter_notify_connection_id := last_signal_connection_id
					real_signal_connect (
						visual_widget,
						"leave_notify_event",
						agent (App_implementation.gtk_marshal).signal_emit_stop_intermediary (internal_id, visual_widget, "leave_notify_event"),
						App_implementation.default_translate
					)
					leave_notify_connection_id := last_signal_connection_id
					check
						motion_notify_connected: motion_notify_connection_id > 0
						enter_notify_connected: enter_notify_connection_id > 0
						leave_notify_connected: leave_notify_connection_id > 0
						mode_is_drag_and_drop_implies_release_connected:
							mode_is_drag_and_drop implies
							button_release_connection_id > 0
					end
					(App_implementation.gtk_marshal).signal_emit_stop_intermediary (internal_id, visual_widget, "button-press-event")

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
			create a_cs.make (signal)
			feature {EV_GTK_EXTERNALS}.signal_emit_stop_by_name (a_c_object, a_cs.item)
		end

	end_transport_filter (a_type, a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER) is
			-- Filter out double click events.
		do
			if a_type = feature {EV_GTK_EXTERNALS}.Gdk_button_press_enum then
				end_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- End a pick and drop transport.
		local
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			--a_mouse_x, a_mouse_y: INTEGER
			--a_mouse_window: POINTER
		do
			check
				motion_notify_connected: motion_notify_connection_id > 0
				enter_notify_connected: enter_notify_connection_id > 0
				leave_notify_connected: leave_notify_connection_id > 0
			end
			erase_rubber_band
			disable_capture
			if button_release_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_release_connection_id)
				button_release_connection_id := 0
			end
			if motion_notify_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, motion_notify_connection_id)
				motion_notify_connection_id := 0
			end
			if enter_notify_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, enter_notify_connection_id)
				enter_notify_connection_id := 0
			end
			if leave_notify_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, leave_notify_connection_id)
				leave_notify_connection_id := 0
			end
			if grab_callback_connection_id > 0 then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, grab_callback_connection_id)
				grab_callback_connection_id := 0
			end
			if not is_destroyed then
				if pointer_style /= Void then
					internal_set_pointer_style (pointer_style)
				else
					-- Reset the cursors.
					feature {EV_GTK_EXTERNALS}.gdk_window_set_cursor (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), NULL)
					feature {EV_GTK_EXTERNALS}.gdk_window_set_cursor (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget), NULL)
				end
				feature {EV_GTK_EXTERNALS}.gtk_widget_draw (c_object, NULL)
				feature {EV_GTK_EXTERNALS}.gtk_widget_draw (visual_widget, NULL)				
			end
			
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

			post_drop_steps
			call_press_actions (target, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)			
			check
				motion_notify_not_connected: motion_notify_connection_id = 0
				enter_notify_not_connected: enter_notify_connection_id = 0
				leave_notify_not_connected: leave_notify_connection_id = 0
				grab_callback_not_connected: grab_callback_connection_id = 0
				button_release_not_connected: button_release_connection_id = 0
			end
		end
		
	pointer_style: EV_CURSOR is
			-- Style of the mouse pointer for `Current'
		deferred
		end

	call_press_actions (targ: EV_ABSTRACT_PICK_AND_DROPABLE; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
		local
			wid: EV_WIDGET
			wid_imp: EV_WIDGET_IMP
			tup: TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
		do
			wid ?= targ
			if wid /= Void then
				wid_imp ?= wid.implementation
				if wid_imp /= Void and not wid_imp.is_destroyed then
					if wid_imp.pointer_button_press_actions_internal /= Void then
						if (a_x >= 0 and a_x <= wid_imp.width) and (a_y >= 0 and a_y <= wid_imp.height) then
							tup := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y]
							wid_imp.pointer_button_press_actions_internal.call (tup)							
						end
					end
				end
			end
		end

	post_drop_steps is
			-- Steps to perform once an attempted drop has happened.
		do
			if mode_is_pick_and_drop and not is_destroyed then
				signal_emit_stop (visual_widget, "button-press-event")
			end
			App_implementation.on_drop (pebble)
			x_origin := 0
			y_origin := 0
			last_pointed_target := Void
			if pebble_function /= Void then
				pebble := Void
			end
		end

	add_grab_cb is
			-- Disconnect callback that called us and `enable_capture'.
		do	
			check
				grab_callback_connected: grab_callback_connection_id > 0
			end
			feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, grab_callback_connection_id)
			grab_callback_connection_id := 0
			enable_capture
		end

	draw_rubber_band is
			-- Draw a segment between initial pick point and `destination'.
		local
			l_invert_gc, l_root_parent: POINTER
		do
			if
				feature {EV_GTK_EXTERNALS}.gtk_events_pending <= 1
			then
				l_invert_gc := invert_gc
				l_root_parent := root_parent
				if rubber_band_is_drawn then
					feature {EV_GTK_EXTERNALS}.gdk_draw_line (l_root_parent, l_invert_gc, x_origin, y_origin, old_pointer_x, old_pointer_y)
					rubber_band_is_drawn := False
				end
				old_pointer_x := pointer_x
				old_pointer_y := pointer_y
				feature {EV_GTK_EXTERNALS}.gdk_draw_line (l_root_parent, l_invert_gc, x_origin, y_origin, old_pointer_x, old_pointer_y)
				rubber_band_is_drawn := True
			end
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				feature {EV_GTK_EXTERNALS}.gdk_draw_line (root_parent, invert_gc, x_origin, y_origin, old_pointer_x, old_pointer_y)
				rubber_band_is_drawn := False
			end
		end
		
	root_parent: POINTER is
			-- GdkWindow of X root window.
		once
			Result := feature {EV_GTK_EXTERNALS}.gdk_root_parent
		end

	invert_gc: POINTER is
		local
			col: POINTER
			max_16_bit: INTEGER
		once
			max_16_bit := 65535
			Result := feature {EV_GTK_EXTERNALS}.gdk_gc_new (feature {EV_GTK_EXTERNALS}.gdk_root_parent)
			col := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (col, Max_16_bit)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (col, Max_16_bit)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (col, Max_16_bit)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_foreground (Result, col)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_function (Result, feature {EV_GTK_EXTERNALS}.Gdk_invert_enum)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_subwindow (Result, feature {EV_GTK_EXTERNALS}.Gdk_include_inferiors_enum)
			col.memory_free
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			gdkwin: POINTER
			x, y: INTEGER
			a_wid_imp: EV_WIDGET_IMP
			a_pnd_deferred_item_parent: EV_PND_DEFERRED_ITEM_PARENT
			a_row_imp: EV_PND_DEFERRED_ITEM
			pnd_targets: ARRAYED_LIST [INTEGER] 
		do
			a_wid_imp := widget_imp_at_pointer_position
			if a_wid_imp /= Void and then a_wid_imp.is_sensitive then
				if App_implementation.pnd_targets.has (a_wid_imp.interface.object_id) then
					Result := a_wid_imp.interface
				end	
				a_pnd_deferred_item_parent ?= a_wid_imp
				if a_pnd_deferred_item_parent /= Void then
						-- We need to explicitly search for PND deferred items
					gdkwin := feature {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($x, $y)
					pnd_targets := App_implementation.pnd_targets
					a_row_imp := a_pnd_deferred_item_parent.row_from_y_coord (y)
					if a_row_imp /= Void and then pnd_targets.has (a_row_imp.interface.object_id) then
						Result := a_row_imp.interface
					end
				end				
			end
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
		do
			create Result
			interface.init_drop_actions (Result)
		end

feature {EV_APPLICATION_IMP, EV_PICK_AND_DROPABLE_IMP, EV_DOCKABLE_SOURCE_IMP} -- Implementation

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- Used for PND real_pointed_target optimization.
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (visual_widget)
				// feature {EV_GTK_EXTERNALS}.GTK_MAPPED_ENUM) \\ 2)
			) = 1
		end
	
	pre_pnd_state: INTEGER
	
	internal_non_sensitive: BOOLEAN is
			-- 
		deferred
		end

	is_dockable: BOOLEAN is
			-- 
		deferred
		end
	
feature {NONE} -- Implementation

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- Widget implementation at current mouse pointer position (if any)
		deferred
		end

	width: INTEGER is deferred end
	height: INTEGER is deferred end
	has_focus: BOOLEAN is deferred end

	x_origin, y_origin: INTEGER
		-- Temp coordinate values for origin of Pick and Drop.

	old_pointer_x,
	old_pointer_y: INTEGER

	draw_rubber_band_calls_ignored: INTEGER
			-- Number of `draw_rubber_band' calls ignored.

	grab_callback_connection_id: INTEGER
			-- GTK signal connection id for motion-notify-event.
			-- (Used to trigger a global user input grab)

	motion_notify_connection_id: INTEGER
			-- GTK signal connection id for motion-notify-event.
			-- (Used to draw rubber band line between pick point and pointer)

	leave_notify_connection_id: INTEGER
			-- GTK signal connection id for leave-notify-event.
			-- (Used to suspend leave events during rubber band line drawing)

	enter_notify_connection_id: INTEGER
			-- GTK signal connection id for enter-notify-event.
			-- (Used to suspend enter events during rubber band line drawing)

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

	interface: EV_PICK_AND_DROPABLE

end -- class EV_PICK_AND_DROPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

