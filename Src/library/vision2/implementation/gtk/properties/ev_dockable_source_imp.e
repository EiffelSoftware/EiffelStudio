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
				if trg = Void or else trg.is_destroyed then
					--| FIXME Unsensitive widgets should not be droppable.
					Global_drag_targets.forth
					-- If Void or destroyed then it will be removed on the next pick.
				else
					x1 := trg.screen_x
					y1 := trg.screen_y
					x2 := x1 + trg.width
					y2 := y1 + trg.height
					if (a_x >= x1 and a_x <= x2) and (a_y >= y1 and a_y <= y2) then
						Result := trg
					end			
					Global_drag_targets.forth
				end
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
						print ("Viable for dragging%N")
						if not is_dock_executing then
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
		
	dragable_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			--io.putstring ("dragable_motion%N")
--			if dawaiting_movement then
--				if (doriginal_x - a_x).abs > drag_and_drop_starting_movement or
--					(doriginal_y - a_y).abs > drag_and_drop_starting_movement
--					then real_start_dragging (doriginal_x, doriginal_y, 1,
--						doriginal_x_tilt, doriginal_y_tilt, doriginal_pressure,
--						a_screen_x + (doriginal_x - a_x), a_screen_y +
--						(doriginal_y - a_y))
--					dawaiting_movement := False
--				end
--			else
				execute_dragging (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
--			end
		end
		
	check_dragable_release (a_x, a_y: INTEGER) is
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
			--| Only called when the left button is released after
			--| initial drag and drop execution is started, possibly before
			--| movement thresh hold has been passed.
		do
--			io.putstring ("check_dragable_release%N")
--			if is_dragging then
--				application_imp.end_awaiting_movement
--	--			if press_action = Ev_pnd_end_transport then
--					end_dragable (a_x, a_y, 1, 0, 0, 0, 0, 0)
--					-- If Current has drag and drop, but we are waiting for the
--					-- mouse movement then we raise the window containing `Current'
--					-- to the foreground.
--	--			elseif awaiting_movement then
--	--					top_level_window_imp.move_to_foreground
--	--			end
--				doriginal_x := -1
--				doriginal_y := -1
--				dawaiting_movement := False
--			elseif dawaiting_movement then
--				dawaiting_movement := False
--			end
		end

feature {NONE} -- Implementation

	start_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize the pick/drag and drop mechanism.
		local
			app_imp: EV_APPLICATION_IMP
		do
			io.putstring ("start_dragable%N")
			--call_press_actions (interface, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)

			--pointer_motion_actions_internal.block
			initialize_transport (a_screen_x, a_screen_y, interface)
			--pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y)
--			real_signal_connect (
--				c_object,
--				"motion-notify-event",
--				agent Gtk_marshal.add_grab_cb_intermediary (c_object),
--				App_implementation.default_translate
--			)
--			grab_callback_connection_id := last_signal_connection_id

			enable_capture
			
--			if drop_actions_internal /= Void and then drop_actions_internal.accepts_pebble (pebble) then
--				-- Set correct accept cursor
--				if accept_cursor /= Void then
--					internal_set_pointer_style (accept_cursor)
--				else
--					internal_set_pointer_style (default_accept_cursor)
--				end
--			else
--				-- Set correct deny cursor
--				if deny_cursor /= Void then
--					internal_set_pointer_style (deny_cursor)
--				else
--					internal_set_pointer_style (default_deny_cursor)
--				end
--			end

--			signal_disconnect (button_press_connection_id)
--			real_signal_connect (
--				c_object,
--				"button-press-event",
--				agent Gtk_marshal.end_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
--				App_implementation.default_translate
--			)
--			button_press_connection_id := last_signal_connection_id
--			if set_to_drag_and_drop then
--				check
--					release_not_connected: button_release_connection_id = 0
--				end
				real_signal_connect (
					c_object,
					"button-release-event",
					agent end_dragable (?, ?, ?, ?, ?, ?, ?, ?),
					App_implementation.default_translate
				)
				drag_button_release_connection_id := last_signal_connection_id
--			end

			real_signal_connect (
				c_object,
				"motion-notify-event",
				agent execute_dragging (?,?,?,?,?,?,?),--Gtk_marshal.temp_execute_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?),
				App_implementation.default_translate
			)
			drag_motion_notify_connection_id := last_signal_connection_id
--			real_signal_connect (
--				c_object,
--				"enter_notify_event",
--				agent Gtk_marshal.signal_emit_stop_intermediary (c_object, "enter_notify_event"),
--				App_implementation.default_translate
--			)
--			enter_notify_connection_id := last_signal_connection_id
--			real_signal_connect (
--				c_object,
--				"leave_notify_event",
--				agent Gtk_marshal.signal_emit_stop_intermediary (c_object, "leave_notify_event"),
--				App_implementation.default_translate
--			)
--			leave_notify_connection_id := last_signal_connection_id
--			check
--				motion_notify_connected: motion_notify_connection_id > 0
--				enter_notify_connected: enter_notify_connection_id > 0
--				leave_notify_connected: leave_notify_connection_id > 0
--				mode_is_drag_and_drop_implies_release_connected:
--					mode_is_drag_and_drop implies
--					button_release_connection_id > 0
--			end
--			Gtk_marshal.signal_emit_stop_intermediary (c_object, "button-press-event")
		end
		
		drag_button_release_connection_id, drag_motion_notify_connection_id: INTEGER
			-- Signal id's for drag event connection.
			


--	--		application_imp.clear_transport_just_ended
--	--		if mode_is_pick_and_drop and a_button /= 3 then
--	--		else	
--					-- We used to call `call_pebble_function' here, but this causes
--					-- the pebble function to be executed twice. The first execution
--					-- occurrs in EV_WINDOW_IMP source_at_pointer_position. This should
--					-- have always been called in order for us to be here in `start_transport'.
--					-- If it is not, then there must be a fix for that, but I do not know of any
--					-- case in which it would not be called first. Julian 09/27/2001
--	--			if pebble_function /= Void then
--	--				pebble := pebble_function.last_result
--	--			end
--	--			if pebble /= Void then
--	--				if mode_is_pick_and_drop and a_button = 3 then
--	--					real_start_transport (a_x, a_y, a_button, a_x_tilt,
--	--						a_y_tilt, a_pressure, a_screen_x, a_screen_y)
--	--				elseif mode_is_drag_and_drop and a_button = 1 then
--						if not dawaiting_movement then
--								-- Store arguments so they can be passed to
--								-- real_start_transport.
----							doriginal_x := a_x
----							doriginal_y := a_y
----							original_x_offset := a_x
----							original_y_offset := a_y
----							doriginal_x_tilt := a_x_tilt
----							doriginal_y_tilt := a_y_tilt
----							doriginal_pressure := a_pressure
----							dawaiting_movement := True
----							application_imp.start_awaiting_movement
--						end
--	--				elseif mode_is_target_menu and a_button = 3 then
--	--					(create {EV_ENVIRONMENT}).application.
--	--						implementation.target_menu (pebble).show
--	--				end
--	--			end
--	--		end
--		end
		
	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		require
	--		not_already_transporting: not is_pnd_in_transport and
	--			not is_dnd_in_transport and
	--			application_imp.pick_and_drop_source = Void
	--		original_window_void: original_top_level_window_imp = Void
		local
			--pt, win_pt: WEL_POINT
			env: EV_ENVIRONMENT
		do
			io.putstring ("real_start_draggging%N")
			if not is_dock_executing then
----				create top_screen.make_top ("Internal window%N")
----			--	top_screen.maximize
----				top_screen.set_x (-800)
----				top_screen.set_x (0)
----				top_screen.set_width (2000)
----				top_screen.set_height (1000)
--				
--					-- We now create the screen at the start of every pick.
--					-- See `pnd_screen' comment for explanation.
--				create dpnd_screen
--
--				interface.pointer_motion_actions.block
--					-- Block `pointer_motion_actions'.
--			initialize_transport (a_screen_x, a_screen_y)
--			dawaiting_movement := False
--
--				set_capture_type (Capture_normal)
--
--					-- Assign correct pointer for transport.
----				update_pointer_style (pointed_target)
--
--					-- Start the capture (as late as possible because 
--					-- we can't debug when the capture is enabled)
--					
--								--	if widget_imp_at_cursor_position /= Void then
--			orig_cursor := pointer_style
--			set_pointer_style (drag_cursor)
--			
--			--	end
--
--				if not wel_has_capture then
--					internal_enable_capture	
--				end
		end
		end
		
	orig_cursor: EV_CURSOR
		
	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			pick_and_dropable: EV_PICK_AND_DROPABLE
			text_component: EV_TEXT_COMPONENT_IMP
		--	dragable_target: EV_DRAGABLE_TARGET
		--	target_container: EV_CONTAINER_IMP
		--	target_widget: EV_WIDGET_IMP
		do
			io.putstring ("end_dragable%N")
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
--			
--			
			disable_capture
--				-- Return capture type to capture_normal.
--				--| normal capture only works on the current windows thread.
--			set_capture_type (Capture_normal)
--
--
			if drag_button_release_connection_id > 0 then
				signal_disconnect (drag_button_release_connection_id)
			end
			if drag_motion_notify_connection_id > 0 then
				signal_disconnect (drag_motion_notify_connection_id)
			end		
			complete_dock
--			
		ensure then
		--	original_window_void: original_top_level_window_imp = Void
		--	press_action_Reset: press_action = Ev_pnd_start_transport
		--	not_has_capture: internal_capture_status = False
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
