indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_IMP
	
inherit
	EV_DOCKABLE_SOURCE_I
	
	EV_SHARED_TRANSPORT_IMP

feature -- Status setting

	release_capture is
			--
		deferred
		end
		
	set_capture is
			--
		deferred
		end
		
	wel_has_capture: BOOLEAN is
			--
		deferred
		end

	dragable_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			if a_button = 1 then
				start_docking 
					(a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y, interface)
			end
		end
		
	dragable_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if awaiting_movement then
				if (doriginal_x - a_x).abs > drag_and_drop_starting_movement or
					(doriginal_y - a_y).abs > drag_and_drop_starting_movement
					then real_start_dragging (doriginal_x, doriginal_y, 1,
						doriginal_x_tilt, doriginal_y_tilt, doriginal_pressure,
						a_screen_x + (doriginal_x - a_x), a_screen_y +
						(doriginal_y - a_y))
					awaiting_movement := False
				end
			else
				execute_dragging (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
			end
		end
		
	check_dragable_release (a_x, a_y: INTEGER) is
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
			--| Only called when the left button is released after
			--| initial drag and drop execution is started, possibly before
			--| movement thresh hold has been passed.
		do
			if is_dock_executing then
				application_imp.end_awaiting_movement
	--			if press_action = Ev_pnd_end_transport then
					end_dragable (a_x, a_y, 1, 0, 0, 0, 0, 0)
					-- If Current has drag and drop, but we are waiting for the
					-- mouse movement then we raise the window containing `Current'
					-- to the foreground.
	--			elseif awaiting_movement then
	--					top_level_window_imp.move_to_foreground
	--			end
				doriginal_x := -1
				doriginal_y := -1
				awaiting_movement := False
			elseif awaiting_movement then
				awaiting_movement := False
			end
		end
		
feature {EV_ANY_I} -- Implementation

	end_dragable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			pick_and_dropable: EV_PICK_AND_DROPABLE
			text_component: EV_TEXT_COMPONENT_IMP
		do
			awaiting_movement := False
				-- As this may be called when cancelling awaiting the movement of
				-- the mouse before really starting the transport, we must
				-- only complete the transport if we are really dragging.
			if is_dock_executing then
				if orig_cursor /= Void then
						-- Restore the cursor style of `Current' if necessary.
					internal_set_pointer_style (orig_cursor)
				else
						-- Restore standard cursor style.
					if text_component /= Void then
						internal_set_pointer_style (Default_pixmaps.Ibeam_cursor)
					else
						internal_set_pointer_style (Default_pixmaps.Standard_cursor)
					end
				end
				--set_pointer_style (orig_cursor)
				
				if wel_has_capture then
					disable_capture
				end
					-- Return capture type to capture_normal.
					--| normal capture only works on the current windows thread.
				set_capture_type (Capture_normal)
	
	
				complete_dock
			end
			
		ensure then
		--	original_window_void: original_top_level_window_imp = Void
		--	press_action_Reset: press_action = Ev_pnd_start_transport
		--	not_has_capture: internal_capture_status = False
		end


feature {NONE} -- Implementation

	internal_enable_dockable, internal_disable_dockable is
			--
		do
			
		end
		

	start_docking (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; source: EV_DOCKABLE_SOURCE) is
			-- Initialize the docking mechanism.
		do
			if not awaiting_movement then
					-- Store arguments so they can be passed to
					-- real_start_transport.
				doriginal_x := a_x
				doriginal_y := a_y
				original_x_offset := a_x
				original_y_offset := a_y
				doriginal_x_tilt := a_x_tilt
				doriginal_y_tilt := a_y_tilt
				doriginal_pressure := a_pressure
				awaiting_movement := True
				application_imp.start_awaiting_movement
				actual_source := source
			end
		end
		
	actual_source: EV_DOCKABLE_SOURCE
		
	real_start_dragging (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		require
	--		not_already_transporting: not is_pnd_in_transport and
	--			not is_dnd_in_transport and
	--			application_imp.pick_and_drop_source = Void
	--		original_window_void: original_top_level_window_imp = Void
		local
			pt, win_pt: WEL_POINT
			env: EV_ENVIRONMENT
		do
			if not is_dock_executing then
					-- We now create the screen at the start of every pick.
					-- See `pnd_screen' comment for explanation.
				if pnd_screen = Void then
					create pnd_screen
				end

--				interface.pointer_motion_actions.block
						-- Block `pointer_motion_actions'.
				initialize_transport (a_screen_x, a_screen_y, actual_source)

				set_capture_type (Capture_normal)

								--	if widget_imp_at_cursor_position /= Void then
				orig_cursor := pointer_style
				set_pointer_style (drag_cursor)
				if not wel_has_capture then
					internal_enable_capture	
				end
			end
		end
		
	orig_cursor: EV_CURSOR		
		
	doriginal_x: INTEGER
			--
		
	doriginal_y: INTEGER
			--
		
	doriginal_x_tilt: DOUBLE
			--
		
	doriginal_y_tilt: DOUBLE
			--

	doriginal_pressure: DOUBLE
			--

	application_imp: EV_APPLICATION_IMP is
			--
		deferred
		end
	
	set_pointer_style (a_cursor: EV_CURSOR) is
			--
		deferred
			
		end
		
	pointer_style: EV_CURSOR is
			--
		deferred
		end
		
	set_capture_type (a_capture_type: INTEGER) is
			--
		deferred
		end
		
	internal_enable_capture is
			--
		deferred
		end
	
	capture_heavy: INTEGER is
			--
		deferred
		end
		
	capture_normal: INTEGER is
			--
		deferred
		end
		
		
	disable_capture is
			--
		deferred
		end
		
		
		

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_DOCKABLE_SOUR