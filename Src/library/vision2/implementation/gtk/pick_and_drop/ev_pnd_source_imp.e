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
			signal_connect ("button-press-event", ~start_transport_filter)
			button_press_connection_id := last_signal_connection_id
			is_transport_enabled := True
		ensure then
			press_connection_successful: button_press_connection_id > 0
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			if button_press_connection_id > 0 then
				signal_disconnect (button_press_connection_id)
				button_press_connection_id := 0
			end
			if button_release_connection_id > 0 then
				signal_disconnect (button_release_connection_id)
				button_release_connection_id := 0
			end
			is_transport_enabled := False
		ensure then
			is_transport_disabled: not is_transport_enabled
			button_press_disconnected: button_press_connection_id = 0
			button_release_disconnected: button_release_connection_id = 0
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
				start_transport (a_x, a_y, a_button,
					 a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			end
		end

	start_transport (
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		local
			env: EV_ENVIRONMENT
			curs_code: EV_CURSOR_CODE
			app_imp: EV_APPLICATION_IMP
		do	
			if
				(mode_is_drag_and_drop and a_button = 1 or
				mode_is_pick_and_drop and a_button = 3)
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
				create env
				app_imp ?= env.application.implementation
				check
					app_imp_not_void: app_imp /= Void
				end
				app_imp.on_pick (pebble)
				interface.pick_actions.call ([a_x, a_y])

				if mode_is_pick_and_drop then
					is_pnd_in_transport := True
				else
					is_dnd_in_transport := True
				end

				if not gdk_widget_no_window (c_object) then
						--| see gtkwidget.c: line 3864 (gtk_widget_add_events):
						--| assertion `!GTK_WIDGET_NO_WINDOW (widget)'
					C.gtk_widget_add_events (
						c_object,
						C.Gdk_pointer_motion_mask_enum
					)
				end
				signal_connect ("motion-notify-event", ~add_grab_cb)
				grab_callback_connection_id := last_signal_connection_id
				create curs_code.make
				if accept_cursor = Void then
					create accept_cursor.make_with_code (curs_code.standard)
				end
				if deny_cursor = Void then
					create deny_cursor.make_with_code (curs_code.no)
				end

				pointer_x := a_screen_x
				pointer_y := a_screen_y
				if pick_x = 0 and pick_y = 0 then
					pick_x := a_screen_x
					pick_y := a_screen_y
				end

				enable_capture
--FIXME this line for testing only		env.application.process_events

				signal_disconnect (button_press_connection_id)
				signal_connect ("button-press-event", ~end_transport_filter)
				button_press_connection_id := last_signal_connection_id
				if is_dnd_in_transport then
					check
						release_not_connected: button_release_connection_id = 0
					end
					signal_connect ("button-release-event", ~end_transport)
					button_release_connection_id := last_signal_connection_id
				end

				signal_connect ("motion-notify-event", ~execute)
				motion_notify_connection_id := last_signal_connection_id
				signal_connect ("enter_notify_event",
					~signal_emit_stop (c_object, "enter_notify_event"))
				enter_notify_connection_id := last_signal_connection_id
				signal_connect ("leave_notify_event",
					~signal_emit_stop (c_object, "leave_notify_event"))
				leave_notify_connection_id := last_signal_connection_id
				check
					motion_notify_connected: motion_notify_connection_id > 0
					enter_notify_connected: enter_notify_connection_id > 0
					leave_notify_connected: leave_notify_connection_id > 0
					is_dnd_in_transport_implies_release_connected:
					is_dnd_in_transport implies button_release_connection_id > 0
				end
				signal_emit_stop (c_object, "button-press-event")
			end
		end

	signal_emit_stop (a_c_object: POINTER; signal: STRING) is
		do
			C.gtk_signal_emit_stop_by_name (a_c_object, eiffel_to_c (signal))
		end

	end_transport_filter (a_type, a_x, a_y, a_button: INTEGER) is
			-- Filter out double click events.
		do
            if a_type = C.Gdk_button_press_enum then
				end_transport (a_x, a_y, a_button)
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER) is
			-- End a pick and drop transport.
		local
			target: EV_PICK_AND_DROPABLE
			app_imp: EV_APPLICATION_IMP
			env: EV_ENVIRONMENT
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
			signal_disconnect (motion_notify_connection_id)
			motion_notify_connection_id := 0
			signal_disconnect (enter_notify_connection_id)
			enter_notify_connection_id := 0
			signal_disconnect (leave_notify_connection_id)
			leave_notify_connection_id := 0
			if grab_callback_connection_id > 0 then
				signal_disconnect (grab_callback_connection_id)
				grab_callback_connection_id := 0
			end
			if
				(a_button = 3 and is_pnd_in_transport) or
				(a_button = 1 and is_dnd_in_transport)
			then
				target := pointed_target
				if target /= Void then
					target.drop_actions.call ([pebble])
				end
			end
			enable_transport
			interface.pointer_motion_actions.resume
			if not is_dnd_in_transport then
				signal_emit_stop (c_object, "button-press-event")
			end
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end
			app_imp.on_drop (pebble)
			is_dnd_in_transport := False
			is_pnd_in_transport := False
			pick_x := 0
			pick_y := 0
			last_pointed_target := Void
			check
				motion_notify_not_connected: motion_notify_connection_id = 0
				enter_notify_not_connected: enter_notify_connection_id = 0
				leave_notify_not_connected: leave_notify_connection_id = 0
				grab_callback_not_connected: grab_callback_connection_id = 0
				button_release_not_connected: button_release_connection_id = 0
			end
		end

	is_dnd_in_transport,
	is_pnd_in_transport: BOOLEAN
			-- Is a particular transport mechanism in operation.

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
				pick_x, pick_y, old_pointer_x, old_pointer_y)
			if target_highlight_is_drawn then
				C.gdk_draw_arc (C.gdk_root_parent, gc,
					1, old_pointer_x - Pebble_size, old_pointer_y - Pebble_size,
					Pebble_size*2, Pebble_size*2, 0, Full_circle)
			else
				head:= Head_size
				if pick_x = old_pointer_x then
					ang := pi/2
					if pick_y < old_pointer_y then
						head := - head
					end
				else
					ang := arc_tangent ((pick_y - old_pointer_y)
						/ (pick_x - old_pointer_x))
				end
				a := 0.3
				if old_pointer_x <= pick_x then
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
				C.gdk_draw_arc (C.gdk_root_parent, gc,
					1, pick_x - Pebble_size, pick_y - Pebble_size,
					Pebble_size*2, Pebble_size*2, 0, Full_circle)
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

	pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			widget: EV_WIDGET
			widget_imp: EV_WIDGET_IMP
			gdkwin, gdkpar, currentwin: POINTER
			x, y: INTEGER
		do
			gdkwin := C.gdk_window_at_pointer ($x, $y)
			if gdkwin /= Default_pointer then
				gdkpar := C.gdk_window_get_parent (gdkwin)
			end
			if gdkwin /= Default_pointer then
				from
					global_pnd_targets.start
				until
					global_pnd_targets.off or Result /= Void
				loop
					widget ?= id_object (global_pnd_targets.item)
					widget_imp ?= widget.implementation
					currentwin := C.gtk_widget_struct_window (	
						widget_imp.c_object)
					if
						currentwin = gdkwin or else
						currentwin = gdkpar
					then
						Result := widget
					end
					global_pnd_targets.forth
				end
			end
		end

feature {NONE} -- Implementation

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

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
