indexing
	description: "Objects that ..."
	author: ""
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
			gdkwin: POINTER
			cur: CURSOR
			src: EV_DOCKABLE_TARGET
			trg: EV_WIDGET_IMP
			drag_trgs: ARRAYED_LIST [INTEGER]
			x1, y1, x2, y2: INTEGER
		do
			gdkwin := C.gdk_window_get_pointer (NULL, $a_x, $a_y, NULL)
			from
				drag_trgs := global_drag_targets
				cur := global_drag_targets.cursor
				Global_drag_targets.start
			until
				Global_drag_targets.after or Result /= Void
			loop
				src ?= id_object (Global_drag_targets.item)
				trg ?= src.implementation
				if trg /= Void or else not trg.is_destroyed then
					x1 := trg.screen_x
					y1 := trg.screen_y
					x2 := x1 + trg.width
					y2 := y1 + trg.height
					if (a_x >= x1 and a_x <= x2) and (a_y >= y1 and a_y <= y2) then
						Result := trg
					end
				end
				Global_drag_targets.forth
			end
			Global_drag_targets.go_to (cur)
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
					if a_button = 1 then
						if not is_dock_executing then
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
					then real_start_dragging (original_x_offset, original_y_offset, 1,
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

	drag_and_drop_starting_movement: INTEGER is 3

	start_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize the pick/drag and drop mechanism.
		do
			io.putstring ("start_dragable%N")
			--call_press_actions (interface, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)

			--pointer_motion_actions_internal.block
			initialize_transport (a_screen_x, a_screen_y, interface)
			enable_capture
			real_signal_connect (
				c_object,
				"button-release-event",
				agent end_dragable (?, ?, ?, ?, ?, ?, ?, ?),
				App_implementation.default_translate
			)
			drag_button_release_connection_id := last_signal_connection_id
		end
		
	drag_button_release_connection_id, drag_motion_notify_connection_id: INTEGER
			-- Signal id's for drag event connection.

	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		do
			io.putstring ("real_start_draggging%N")
			if not is_dock_executing then
			end
		end
		
	orig_cursor: EV_CURSOR
		
	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		do
			io.putstring ("end_dragable%N")
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
			if not dawaiting_movement then
				complete_dock
				original_x_offset := -1
				original_y_offset := -1
				dawaiting_movement := False
			elseif dawaiting_movement then
				dawaiting_movement := False
			end
			
				-- Return capture type to capture_normal.
			if drag_button_release_connection_id > 0 then
				signal_disconnect (drag_button_release_connection_id)
				drag_button_release_connection_id := 0
			end
			if drag_motion_notify_connection_id > 0 then
				signal_disconnect (drag_motion_notify_connection_id)
				drag_motion_notify_connection_id := 0
			end
			source_being_docked := Void
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
		
feature {EV_ANY_I} -- Implementation

	interface: EV_DOCKABLE_SOURCE

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_IMP
