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

	SINGLE_MATH

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
		do
			draw_rubber_band
			pointer_x := a_screen_x
			pointer_y := a_screen_y
			
			target := pointed_target
			if target /= last_pointed_target then
				update_pointer_style (target)
			end
		end

	enable_transport is
			-- Activate pick/drag and drop mechanism.
 		do
			check
				button_release_not_connected: button_release_connection_id = 0
			end
			if button_press_connection_id > 0 then
				signal_disconnect (button_press_connection_id)
			end
			signal_connect (
				"button-press-event",
				agent start_transport_filter,
				default_translate
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
				signal_disconnect (button_press_connection_id)
				button_press_connection_id := 0
			end
			if button_release_connection_id > 0 then
				signal_disconnect (button_release_connection_id)
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
			if a_type = C.Gdk_button_press_enum then
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
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			app_imp.on_pick (pebble)
			if pick_actions_internal /= Void then
				pick_actions_internal.call ([a_x, a_y])
			end

			
			if accept_cursor = Void then
				--| FIXME IEK
				create accept_cursor--.make_with_code (curs_code.standard)
			end
			if deny_cursor = Void then
				create deny_cursor--.make_with_code (curs_code.no)
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
			Result := (mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
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
					signal_connect (
						"motion-notify-event",
						agent add_grab_cb,
						default_translate
					)
					grab_callback_connection_id := last_signal_connection_id

					enable_capture
	--FIXME this line for testing only		env.application.process_events

					signal_disconnect (button_press_connection_id)
					signal_connect (
						"button-press-event",
						agent end_transport_filter,
						default_translate
					)
					button_press_connection_id := last_signal_connection_id
					if set_to_drag_and_drop then
						check
							release_not_connected: button_release_connection_id = 0
						end
						signal_connect (
							"button-release-event",
							agent end_transport,
							default_translate
						)
						button_release_connection_id := last_signal_connection_id
					end

					signal_connect (
						"motion-notify-event",
						agent temp_execute,
						default_translate
					)
					motion_notify_connection_id := last_signal_connection_id
					signal_connect (
						"enter_notify_event",
						agent signal_emit_stop (visual_widget, "enter_notify_event"),
						default_translate
					)
					enter_notify_connection_id := last_signal_connection_id
					signal_connect (
						"leave_notify_event",
						agent signal_emit_stop (visual_widget, "leave_notify_event"),
						default_translate
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
					signal_emit_stop (visual_widget, "button-press-event")

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
			temp_string: ANY
		do
			temp_string := signal.to_c
			C.gtk_signal_emit_stop_by_name (a_c_object, $temp_string)
		end

	end_transport_filter (a_type, a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER) is
			-- Filter out double click events.
		do
			if a_type = C.Gdk_button_press_enum then
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
				signal_disconnect (button_release_connection_id)
				button_release_connection_id := 0
			end
			if motion_notify_connection_id > 0 then
				signal_disconnect (motion_notify_connection_id)
				motion_notify_connection_id := 0
			end
			if enter_notify_connection_id > 0 then
				signal_disconnect (enter_notify_connection_id)
				enter_notify_connection_id := 0
			end
			if leave_notify_connection_id > 0 then
				signal_disconnect (leave_notify_connection_id)
				leave_notify_connection_id := 0
			end
			if grab_callback_connection_id > 0 then
				signal_disconnect (grab_callback_connection_id)
				grab_callback_connection_id := 0
			end
			if
				able_to_transport (a_button)
			then
				target := pointed_target
				if target /= Void then
					target.drop_actions.call ([pebble])
				end
			end
			enable_transport
			interface.pointer_motion_actions.resume

			post_drop_steps

			call_press_actions (target, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			
			if pointer_style /= Void then
				internal_set_pointer_style (pointer_style)
			else
				C.gdk_window_set_cursor (C.gtk_widget_struct_window (c_object), NULL)
			end

			--a_mouse_window := C.gdk_window_at_pointer ($a_mouse_x, $a_mouse_y)
			--if pointer_over_widget (a_mouse_window, a_mouse_x, a_mouse_y) then
			--	target := interface
			--	print ("Pointer over source%N")
			--end

			--if not able_to_transport (a_button) and target /= Void then
			--	print ("PND Cancelled on widget%N")
			--end

			check
				motion_notify_not_connected: motion_notify_connection_id = 0
				enter_notify_not_connected: enter_notify_connection_id = 0
				leave_notify_not_connected: leave_notify_connection_id = 0
				grab_callback_not_connected: grab_callback_connection_id = 0
				button_release_not_connected: button_release_connection_id = 0
			end
		end
		
	pointer_style: EV_CURSOR is
			-- 
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
				if wid_imp /= Void then
					if wid_imp.pointer_button_press_actions_internal /= Void then
						tup := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y]
						wid_imp.pointer_button_press_actions_internal.call (tup)
					end
				end
			end
		end
			

	post_drop_steps is
			-- Steps to perform once an attempted drop has happened.
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			if mode_is_pick_and_drop then
				signal_emit_stop (visual_widget, "button-press-event")
			end
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end
			app_imp.on_drop (pebble)
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
			signal_disconnect (grab_callback_connection_id)
			grab_callback_connection_id := 0
			enable_capture
		end

	draw_rubber_band is
			-- Draw a segment between initial pick point and `destination'.
		do
			if
				pointer_x /= old_pointer_x or
				pointer_y /= old_pointer_y
			then
				if
					C.gtk_events_pending = 0 or
					draw_rubber_band_calls_ignored > Max_draw_ignore
				then
					if rubber_band_is_drawn then
						real_draw_rubber_band
					end
					old_pointer_x := pointer_x
					old_pointer_y := pointer_y
					target_highlight_is_drawn := over_valid_target
					real_draw_rubber_band
					rubber_band_is_drawn := True
					draw_rubber_band_calls_ignored := 0
				else
					draw_rubber_band_calls_ignored
						 := draw_rubber_band_calls_ignored + 1
				end
			end
		end
		Max_draw_ignore: INTEGER is 2

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				real_draw_rubber_band
				rubber_band_is_drawn := False
			end
		end
		
	root_parent: POINTER is
			-- GdkWindow of X root window.
		once
			Result := C.gdk_root_parent
		end

	real_draw_rubber_band is
			-- Implementation of draw_rubber_band.
		local
			ang, a, head: REAL
			gc: POINTER
		do
		--	gc := invert_gc
			C.gdk_draw_line (root_parent, invert_gc,
				x_origin, y_origin, old_pointer_x, old_pointer_y)
			--| FIXME IEK  Implement cursor functionality.
--			if target_highlight_is_drawn then
--				C.gdk_draw_arc (C.gdk_root_parent, gc,
--					1, old_pointer_x - Pebble_size, old_pointer_y - Pebble_size,
--					Pebble_size*2, Pebble_size*2, 0, Full_circle)
--			else
--				head:= Head_size
--				if x_origin = old_pointer_x then
--					ang := pi/2
--					if y_origin < old_pointer_y then
--						head := - head
--					end
--				else
--					ang := arc_tangent ((y_origin - old_pointer_y)
--						/ (x_origin - old_pointer_x))
--				end
--				a := 0.3
--				if old_pointer_x <= x_origin then
--					head := - head
--				end
--				C.gdk_draw_line (C.gdk_root_parent, gc,
--					old_pointer_x, old_pointer_y,
--					old_pointer_x + (cosine (ang - a) * head).rounded,
--					old_pointer_y + (sine (ang - a) * head).rounded)
--				C.gdk_draw_line (C.gdk_root_parent, gc,
--					old_pointer_x, old_pointer_y,
--					old_pointer_x + (cosine (ang + a) * head).rounded,
--					old_pointer_y + (sine (ang + a) * head).rounded)
--				C.gdk_draw_arc (C.gdk_root_parent, gc,
--					1, x_origin - Pebble_size, y_origin - Pebble_size,
--					Pebble_size*2, Pebble_size*2, 0, Full_circle)
-- FIXME Signature for pebble has changed.
--			end
		end
		Head_size: INTEGER is -15
		Pebble_size: INTEGER is 4
		Full_circle: INTEGER is 23040

	invert_gc: POINTER is
		local
			col: POINTER
		once
			Result := C.gdk_gc_new (C.gdk_root_parent)
			col := C.c_gdk_color_struct_allocate
			C.set_gdk_color_struct_red (col, Max_16_bit)
			C.set_gdk_color_struct_green (col, Max_16_bit)
			C.set_gdk_color_struct_blue (col, Max_16_bit)
			C.gdk_gc_set_foreground (Result, col)
			C.gdk_gc_set_function (Result, C.Gdk_invert_enum)
			C.gdk_gc_set_subwindow (Result, C.Gdk_include_inferiors_enum)
			C.c_gdk_color_struct_free (col)
		end

	Max_16_bit: INTEGER is 65535

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			gdkwin: POINTER
			x, y: INTEGER
			widget_target_imp: EV_PICK_AND_DROPABLE_IMP
		do
			gdkwin := C.gdk_window_at_pointer ($x, $y)
			if gdkwin /= NULL then
				widget_target_imp ?= last_pointed_target
				if widget_target_imp /= Void and then widget_target_imp.pointer_over_widget (gdkwin, x, y) then
						Result ?= last_pointed_target
				else
					Result := app_implementation.pnd_target_from_gdk_window (gdkwin, x, y)
				end			
			end
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
		do
			create Result
			interface.init_drop_actions (Result)
		end

feature {EV_APPLICATION_IMP, EV_PICK_AND_DROPABLE_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Comparison of gdk window and widget position to determine
			-- if mouse pointer is over widget.
		do
			Result := a_gdkwin = C.gtk_widget_struct_window (visual_widget)
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- Used for PND real_pointed_target optimization.
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(C.gtk_object_struct_flags (c_object)
				// C.GTK_MAPPED_ENUM) \\ 2)
			) = 1
		end
		
	enable_pnd_prelight_state is
			-- 
		do
			pre_pnd_state := C.gtk_widget_struct_state (c_object)
			C.gtk_widget_set_state (c_object, C.Gtk_state_prelight_enum)
			C.gtk_widget_draw (c_object, NULL)
		end
		
	disable_pnd_prelight_state is
		do
			if C.gtk_widget_struct_state (c_object) = C.Gtk_state_prelight_enum then
				C.gtk_widget_set_state (c_object, pre_pnd_state)
				C.gtk_widget_draw (c_object, NULL)
			end	
		end
	
	pre_pnd_state: INTEGER
	
feature {NONE} -- Implementation

	width: INTEGER is deferred end
	height: INTEGER is deferred end

	x_origin, y_origin: INTEGER
		-- Temp coordinate values for origin of Pick and Drop.

	old_pointer_x,
	old_pointer_y: INTEGER

	draw_rubber_band_calls_ignored: INTEGER
			-- Number of `draw_rubber_band' calls ignored.

	target_highlight_is_drawn: BOOLEAN
			-- Is a highlight drawn on a target?

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

