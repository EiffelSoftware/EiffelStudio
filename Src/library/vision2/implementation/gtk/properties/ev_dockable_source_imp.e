indexing
	description: "Gtk implementation of dockable source."
	status: "See notice at end of class"
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
		redefine
			interface
		end

feature -- Status setting

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- 
		local
			a_x, a_y: INTEGER
			gdkwin, gtkwid: POINTER
		do
			gdkwin := C.gdk_window_at_pointer ($a_x, $a_y)
			if gdkwin /= NULL then				
				from
					C.gdk_window_get_user_data (gdkwin, $gtkwid)
				until
					Result /= Void or else gtkwid = NULL
				loop
					Result ?= eif_object_from_c (gtkwid)
					gtkwid := C.gtk_widget_struct_parent (gtkwid)
				end
			end
		end

	start_dragable_filter (
				a_type: INTEGER;
				a_x, a_y, a_button: INTEGER;
				a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
				a_screen_x, a_screen_y: INTEGER)
			is
				-- Filter out double click events.
			do
				if a_type = C.Gdk_button_press_enum then
					if a_button = 1 and not dawaiting_movement and not App_implementation.is_in_docking then
							enable_capture
							App_implementation.enable_is_in_docking
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
							start_dragable (
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
					real_start_dragging (original_x_offset, original_y_offset, 1,
						0.0, 0.0, 0.0,
						a_screen_x + (original_x_offset - a_x), a_screen_y +
						(original_y_offset - a_y))
					dawaiting_movement := False
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
				signal_disconnect (drag_button_press_connection_id)
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
			initialize_transport (a_screen_x, a_screen_y, interface)
			
			real_signal_connect (
				c_object,
				"button-release-event",
				agent end_dragable (?, ?, ?, ?, ?, ?, ?, ?),
				App_implementation.default_translate
			)
			drag_button_release_connection_id := last_signal_connection_id
		end
		
	drag_button_press_connection_id, drag_button_release_connection_id, drag_motion_notify_connection_id: INTEGER
			-- Signal id's for drag event connection.

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		do
			if not is_dock_executing then
			end
		end
		
	orig_cursor: EV_CURSOR
		
	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		do
			disable_capture
--			if orig_cursor /= Void then
--					-- Restore the cursor style of `Current' if necessary.
--				internal_set_pointer_style (orig_cursor)
--			else
--					-- Restore standard cursor style.
--				if text_component /= Void then
--					internal_set_pointer_style (Default_pixmaps.Ibeam_cursor)
--				else
--					internal_set_pointer_style (Default_pixmaps.Standard_cursor)
--				end
--			end
--			--set_pointer_style (orig_cursor)

			if drag_button_release_connection_id > 0 then
				signal_disconnect (drag_button_release_connection_id)
				drag_button_release_connection_id := 0
			end
			if drag_motion_notify_connection_id > 0 then
				signal_disconnect (drag_motion_notify_connection_id)
				drag_motion_notify_connection_id := 0
			end
			if not dawaiting_movement then
				complete_dock
				original_x_offset := -1
				original_y_offset := -1
				dawaiting_movement := False
			elseif dawaiting_movement then
				dawaiting_movement := False
			end
			App_implementation.disable_is_in_docking
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
		
feature {EV_ANY_I} -- Implementation

	interface: EV_DOCKABLE_SOURCE

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_IMP

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
