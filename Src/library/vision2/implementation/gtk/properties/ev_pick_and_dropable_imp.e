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
				~start_transport_filter,
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
						~add_grab_cb,
						default_translate
					)
					grab_callback_connection_id := last_signal_connection_id

					enable_capture
	--FIXME this line for testing only		env.application.process_events

					signal_disconnect (button_press_connection_id)
					signal_connect (
						"button-press-event",
						~end_transport_filter,
						default_translate
					)
					button_press_connection_id := last_signal_connection_id
					if set_to_drag_and_drop then
						check
							release_not_connected: button_release_connection_id = 0
						end
						signal_connect (
							"button-release-event",
							~end_transport,
							default_translate
						)
						button_release_connection_id := last_signal_connection_id
					end

					signal_connect (
						"motion-notify-event",
						~execute,
						default_translate
					)
					motion_notify_connection_id := last_signal_connection_id
					signal_connect (
						"enter_notify_event",
						~signal_emit_stop (visual_widget, "enter_notify_event"),
						default_translate
					)
					enter_notify_connection_id := last_signal_connection_id
					signal_connect (
						"leave_notify_event",
						~signal_emit_stop (visual_widget, "leave_notify_event"),
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
		do
			C.gtk_signal_emit_stop_by_name (a_c_object, eiffel_to_c (signal))
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
		Max_draw_ignore: INTEGER is 20

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				real_draw_rubber_band
				rubber_band_is_drawn := False
			end
		end

	real_draw_rubber_band is
			-- Implementation of draw_rubber_band.
		local
			ang, a, head: REAL
			gc: POINTER
		do
			gc := invert_gc
			C.gdk_draw_line (C.gdk_root_parent, gc,
				x_origin, y_origin, old_pointer_x, old_pointer_y)
			if target_highlight_is_drawn then
				C.gdk_draw_arc (C.gdk_root_parent, gc,
					1, old_pointer_x - Pebble_size, old_pointer_y - Pebble_size,
					Pebble_size*2, Pebble_size*2, 0, Full_circle)
			else
				head:= Head_size
				if x_origin = old_pointer_x then
					ang := pi/2
					if y_origin < old_pointer_y then
						head := - head
					end
				else
					ang := arc_tangent ((y_origin - old_pointer_y)
						/ (x_origin - old_pointer_x))
				end
				a := 0.3
				if old_pointer_x <= x_origin then
					head := - head
				end
				C.gdk_draw_line (C.gdk_root_parent, gc,
					old_pointer_x, old_pointer_y,
					old_pointer_x + (cosine (ang - a) * head).rounded,
					old_pointer_y + (sine (ang - a) * head).rounded)
				C.gdk_draw_line (C.gdk_root_parent, gc,
					old_pointer_x, old_pointer_y,
					old_pointer_x + (cosine (ang + a) * head).rounded,
					old_pointer_y + (sine (ang + a) * head).rounded)
--				C.gdk_draw_arc (C.gdk_root_parent, gc,
--					1, x_origin - Pebble_size, y_origin - Pebble_size,
--					Pebble_size*2, Pebble_size*2, 0, Full_circle)
-- FIXME Signature for pebble has changed.
			end
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
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
			gdkwin, gtkwid: POINTER
			x, y: INTEGER
			widget_target_imp: EV_PICK_AND_DROPABLE_IMP
		do
			gdkwin := C.gdk_window_at_pointer ($x, $y)
			if gdkwin /= NULL then
				widget_target_imp ?= last_pointed_target
				if widget_target_imp /= Void and then widget_target_imp.pointer_over_widget (gdkwin, x, y) then
						Result ?= last_pointed_target
				else
				--	C.gdk_window_get_user_data (gdkwin, $gtkwid)
				--	check
				--		gtkwid_not_null: gtkwid /= NULL
				--	end
				--	from
				--		Result ?= eif_object_from_c (gtkwid)
				--	until
				--		Result /= Void
				--	loop
				--		gtkwid := C.gtk_widget_struct_parent (gtkwid)
				--		Result ?= eif_object_from_c (gtkwid)
				--	end
					Result := app_implementation.pnd_target_from_gdk_window (gdkwin, x, y)
				end			
			end
		end
		
	app_implementation: EV_APPLICATION_IMP is
			-- 
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result ?= env.application.implementation
			check
				Result_not_void: Result /= Void
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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/06/16 01:07:33  king
--| Slightly optimized
--|
--| Revision 1.2  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.7  2001/05/24 00:30:27  king
--| Added fixme
--|
--| Revision 1.1.2.6  2001/05/23 19:42:28  etienne
--| (Ian and I) Prevented calls to the pebble function after a mouse left click.
--|
--| Revision 1.1.2.5  2001/05/10 21:37:29  king
--| Refactored a disable_transport_signals routine
--|
--| Revision 1.1.2.4  2001/04/27 21:31:45  king
--| Added is_displayed for slight optimization of PND
--|
--| Revision 1.1.2.3  2000/11/30 19:25:33  king
--| Commented out unused local variables
--|
--| Revision 1.1.2.2  2000/10/25 23:14:33  king
--| Corrected button actions sequence calling
--|
--| Revision 1.1.2.1  2000/10/09 18:43:30  oconnor
--| Renamed ev_pnd_source_imp.e to ev_pick_and_dropable_imp.e
--|
--| Revision 1.8.2.26  2000/10/05 19:19:36  oconnor
--| cosmetics
--|
--| Revision 1.8.2.25  2000/08/28 16:33:00  king
--| event_widget->visual_widget
--|
--| Revision 1.8.2.24  2000/08/11 20:42:53  king
--| Removed setting of widget_x/y
--|
--| Revision 1.8.2.23  2000/08/03 23:16:25  king
--| Using internal pick_actions
--|
--| Revision 1.8.2.22  2000/07/25 17:51:08  king
--| Redefined create_drop_actions to initialize result
--|
--| Revision 1.8.2.21  2000/07/24 21:37:02  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.8.2.20  2000/07/24 19:43:05  rogers
--| Removed call_pebble_function as this is now inherited platform independently.
--|
--| Revision 1.8.2.19  2000/07/24 17:36:18  king
--| Added setting of widget_x/y b4 pointed_target
--|
--| Revision 1.8.2.18  2000/07/19 18:56:09  king
--| Changed local variable to be of type abstract_pnd
--|
--| Revision 1.8.2.17  2000/07/17 17:52:20  brendel
--| pointed_target -> real_pointed_target.
--| Moved call_pebble_function TEMPORARILY down again.
--|
--| Revision 1.8.2.16  2000/07/13 00:38:45  brendel
--| Moved `call_pebble_function' up in _I.
--|
--| Revision 1.8.2.15  2000/06/27 23:40:37  king
--| Implemented pick position functionality, integrated event_widget with events
--|
--| Revision 1.8.2.14  2000/06/26 23:10:11  king
--| Added set_to_drag_and_drop for mcl row pnd compatibility
--|
--| Revision 1.8.2.13  2000/06/26 19:49:54  king
--| Abstracted able_to_transport and ready_for_pnd_menu for use with mcl
--|
--| Revision 1.8.2.12  2000/06/26 00:23:23  king
--| Slight cosmetics
--|
--| Revision 1.8.2.11  2000/06/25 20:45:59  king
--| Added x, y_origin to prevent resetting of user settings
--|
--| Revision 1.8.2.10  2000/06/21 21:02:14  oconnor
--| typo
--|
--| Revision 1.8.2.9  2000/06/21 20:58:09  oconnor
--| Do nothing if pebble_function returns Void.
--|
--| Revision 1.8.2.8  2000/06/14 23:13:47  king
--| Removed gdk event mask code that is already handled in ev_widget_imp
--|
--| Revision 1.8.2.7  2000/05/25 00:29:15  king
--| Removed references to cursor code
--|
--| Revision 1.8.2.6  2000/05/04 18:34:44  king
--| Made compilable with new cursor changes
--|
--| Revision 1.8.2.5  2000/05/03 19:08:39  oconnor
--| mergred from HEAD
--|
--| Revision 1.25  2000/05/02 18:55:22  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.24  2000/04/25 00:58:36  oconnor
--| added support of right click PND menus
--|
--| Revision 1.23  2000/04/07 17:39:42  king
--| Added imp comment to pointed_target
--|
--| Revision 1.22  2000/04/05 17:05:28  king
--| Abstracted start/end transport for easier integration with mc list
--|
--| Revision 1.21  2000/04/04 21:00:34  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.20  2000/03/31 19:10:25  king
--| pebble_over_widget -> pointer_over_widget
--|
--| Revision 1.19  2000/03/29 22:14:14  king
--| Removed debugging line
--|
--| Revision 1.18  2000/03/27 19:43:36  oconnor
--| added support for pebble_funtion
--|
--| Revision 1.17  2000/03/23 19:17:40  king
--| Changed pebble_over_widget to pass mouse coords
--|
--| Revision 1.16  2000/03/22 22:00:21  king
--| Revised pointed_target, added pebble_over_widget
--|
--| Revision 1.15  2000/03/17 23:22:28  king
--| Corrected pointed_target to assign attempt to PND
--|
--| Revision 1.14  2000/03/15 22:45:37  king
--| Updated due to interface change in cursor_code
--|
--| Revision 1.13  2000/03/10 01:24:08  king
--| Indented start_transport_filter
--|
--| Revision 1.12  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.2.2.2.23  2000/02/14 11:02:17  oconnor
--| avoid calling gtk_widget_add_events when GTK_WIDGET_NO_WINDOW
--|
--| Revision 1.8.2.2.2.22  2000/02/04 05:19:37  oconnor
--| removed dead local
--|
--| Revision 1.8.2.2.2.21  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.8.2.2.2.20  2000/01/27 19:29:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.2.2.2.19  2000/01/25 17:11:46  king
--| Removed unneeded local variables of type ev_arg*
--|
--| Revision 1.8.2.2.2.18  2000/01/25 03:18:30  brendel
--| Commented out line with EV_INTERNAL_COMMAND that has been removed.
--|
--| Revision 1.8.2.2.2.17  2000/01/22 01:33:48  oconnor
--| commented out print statement
--|
--| Revision 1.8.2.2.2.16  2000/01/21 19:05:58  king
--| Changed capture feature names to fit in with interface
--|
--| Revision 1.8.2.2.2.15  2000/01/19 08:05:27  oconnor
--| removed usless call to process_events
--|
--| Revision 1.8.2.2.2.14  1999/12/17 23:20:20  oconnor
--| formatting
--|
--| Revision 1.8.2.2.2.13  1999/12/15 23:46:46  oconnor
--| graphical tweak
--|
--| Revision 1.8.2.2.2.12  1999/12/15 23:02:27  oconnor
--| clean up color struct
--|
--| Revision 1.8.2.2.2.11  1999/12/15 17:45:37  oconnor
--| moved deferred set|release_capture to _I
--|
--| Revision 1.8.2.2.2.10  1999/12/15 04:24:19  oconnor
--| formatting
--|
--| Revision 1.8.2.2.2.9  1999/12/15 03:59:52  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.8.2.2.2.8  1999/12/15 00:33:06  oconnor
--| general code cleanup
--|
--| Revision 1.8.2.2.2.7  1999/12/14 16:46:35  oconnor
--| rearranged check statements, improved line drawing
--|
--| Revision 1.8.2.2.2.6  1999/12/13 19:47:19  oconnor
--| reorganise for GTK implementation of PND
--|
--| Revision 1.8.2.2.2.5  1999/12/09 23:19:54  brendel
--| Removed comma.
--|
--| Revision 1.8.2.2.2.4  1999/12/09 19:05:39  oconnor
--| mid way through converting PND to new event system
--|
--| Revision 1.8.2.2.2.3  1999/12/09 02:29:36  oconnor
--| king: merged from GTK_PND_IMPLEMENTED
--|
--| Revision 1.8.2.2.2.2  1999/12/02 19:55:59  brendel
--| Commented out old event related features.
--|
--| Revision 1.8.2.2.2.1  1999/11/24 17:29:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
