indexing
	description: "Implementation of a pick and drop source."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_PICK_AND_DROPABLE_I

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
		redefine
			create_drop_actions
		end

	WEL_SYSTEM_METRICS

feature {NONE} -- Initialization

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
			Result := Precursor
			interface.init_drop_actions (Result)
		end

feature -- Access

	capture_enabled: BOOLEAN is
			-- Is the mouse currently captured?
			-- See constants Capture_xxxx at the end of the class.
		do
			Result := internal_capture_status.item
		end

	capture_type: INTEGER is
			-- Type of capture to use when capturing the mouse.
			-- See constants Capture_xxxx at the end of the class.
		do
			Result := internal_capture_type.item
		ensure
			valid_result: Result = Capture_normal or
						  Result = Capture_heavy
		end

	transport_executing: BOOLEAN is
			-- Is a pick and drop or drag and drop currently
			-- being executed?
		do
			Result := is_pnd_in_transport or is_dnd_in_transport
		end

feature -- Status setting

	enable_transport is
            -- Activate pick/drag and drop mechanism.
		do
			check
				release_not_connected: release_action = Ev_pnd_disabled
			end
			press_action := Ev_pnd_start_transport
			is_transport_enabled := True
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			release_action := Ev_pnd_disabled
			press_action := Ev_pnd_disabled
			motion_action := Ev_pnd_disabled
			is_transport_enabled := False
		end

	set_capture_type (a_capture_type: INTEGER) is
			-- Set the type of capture to use when capturing the 
			-- mouse to `a_capture_type'.
			-- See constants Capture_xxxx at the end of the class
		require
			valid_capture_type: a_capture_type = Capture_normal or
								a_capture_type = Capture_heavy
			no_current_capture: not capture_enabled
		do
			internal_capture_type.set_item(a_capture_type)
		ensure
			valid_capture: capture_type = Capture_normal or
						   capture_type = Capture_heavy
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Process `a_button' to start/stop the drag/pick and
			-- drop mechanism.
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
				start_transport
					(a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
			when
				Ev_pnd_end_transport
			then
				end_transport
					(a_x, a_y, a_button, 0, 0, 0, a_screen_x, a_screen_y)
			else
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	check_drag_and_drop_release (a_x, a_y: INTEGER) is
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
			--| Only called when the left button is released after
			--| initial drag and drop execution is started, possibly before
			--| movement thresh hold has been passed.
		do
			if mode_is_drag_and_drop then
				application_imp.end_awaiting_movement
				if press_action = Ev_pnd_end_transport then
					end_transport (a_x, a_y, 1, 0, 0, 0, 0, 0)
					-- If Current has drag and drop, but we are waiting for the
					-- mouse movement then we raise the window containing `Current'
					-- to the foreground.
				elseif awaiting_movement then
						top_level_window_imp.move_to_foreground
				end
				original_x := -1
				original_y := -1
				awaiting_movement := False
			end
		end

	pnd_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if awaiting_movement then
				if (original_x - a_x).abs > drag_and_drop_starting_movement or
					(original_y - a_y).abs > drag_and_drop_starting_movement
					then real_start_transport (original_x, original_y, 1,
						original_x_tilt, original_y_tilt, original_pressure,
						a_screen_x + (original_x - a_x), a_screen_y +
						(original_y - a_y))
					awaiting_movement := False
				end
			else
				inspect
					motion_action
				when
					Ev_pnd_execute
				then
					execute (a_x, a_y, 0, 0, 0.5, a_screen_x, a_screen_y)
				else
					check
						disabled: motion_action = Ev_pnd_disabled
					end
				end
			end
		end

	escape_pnd is
			-- Escape the pick and drop.
		do
			application_imp.clear_transport_just_ended
				-- If we are executing a pick and drop
			if application_imp.pick_and_drop_source /= Void then
					-- We use default values which cause pick and drop to end.
				application_imp.pick_and_drop_source.end_transport (0, 0, 2, 0, 0, 0,
					0, 0)
			end
		ensure
			not_in_transport: not transport_executing
		end
	

feature {EV_ANY_I} -- Implementation

	start_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize the pick/drag and drop mechanism.
		do
			application_imp.clear_transport_just_ended
			if mode_is_pick_and_drop and a_button /= 3 then
			else	
				call_pebble_function (a_x, a_y, a_screen_x, a_screen_y)
				if pebble /= Void then
					if mode_is_pick_and_drop and a_button = 3 then
						real_start_transport (a_x, a_y, a_button, a_x_tilt,
							a_y_tilt, a_pressure, a_screen_x, a_screen_y)
					elseif mode_is_drag_and_drop and a_button = 1 then
						if not awaiting_movement then
								-- Store arguments so they can be passed to
								-- real_start_transport.
							original_x := a_x
							original_y := a_y
							original_x_tilt := a_x_tilt
							original_y_tilt := a_y_tilt
							original_pressure := a_pressure
							awaiting_movement := True
							application_imp.start_awaiting_movement
						end
					elseif mode_is_target_menu and a_button = 3 then
						(create {EV_ENVIRONMENT}).application.
							implementation.target_menu (pebble).show
					end
				end
			end
		end
		
	modify_widget_appearance (starting: BOOLEAN) is
			-- Modify the appearence of widgets to reflect current
			-- state of pick and drop and dropable targets.
			-- If `starting' then the pick and drop is starting,
			-- else it is ending.
		local
			window_imp: EV_WINDOW_IMP
			windows: LINEAR [EV_WINDOW]
		do
			windows := application_imp.windows
			from
				windows.start
			until
				windows.off
			loop
				window_imp ?= windows.item.implementation
				check
					window_implementation_not_void: window_imp /= Void
				end
				window_imp.update_for_pick_and_drop (starting)
				windows.forth
			end
		end
		

	real_start_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		require
			not_already_transporting: not is_pnd_in_transport and
				not is_dnd_in_transport and
				application_imp.pick_and_drop_source = Void
			original_window_void: original_top_level_window_imp = Void
		local
			pt, win_pt: WEL_POINT
			env: EV_ENVIRONMENT
		do
			if
				(mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
				-- Check that transport can be started.
				--| Drag and drop is always started with the left button press.
				--| Pick and drop is always started with the right button press.
			then
					-- We need to store `top_level_window_imp' for use later if `Current'
					-- is unparented during the pick and drop execution.
				original_top_level_window_imp := top_level_window_imp
				
					-- We now create the screen at the start of every pick.
					-- See `pnd_screen' comment for explanation.
				create pnd_screen

				interface.pointer_motion_actions.block
					-- Block `pointer_motion_actions'.

					-- Update `application_imp' with pick_and_drop info.
				application_imp.transport_started (Current)
				
				modify_widget_appearance (True)
				
				create env

					-- Execute pick_actions for the application.
				env.application.pick_actions.call ([pebble])

					-- Execute pick_actions for `Current'.
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
				if mode_is_pick_and_drop then
					is_pnd_in_transport := True
						-- Assign `True' to `is_pnd_in_transport'
				else
					is_dnd_in_transport := True
						-- Assign `True' to `is_dnd_in_transport'
				end
				pointer_x := a_screen_x
				pointer_y := a_screen_y
				if pebble_positioning_enabled then
					create pt.make (pick_x, pick_y)
					create win_pt.make (a_screen_x, a_screen_y)
					pt.client_to_screen (win_pt.window_at)
					internal_pick_x := pt.x
					internal_pick_y := pt.y
				else
					internal_pick_x := a_screen_x
					internal_pick_y := a_screen_y
				end
				press_action := Ev_pnd_end_transport
				motion_action := Ev_pnd_execute
					-- Store the previous cursor of `Current'.
				pnd_stored_cursor := cursor_pixmap
				set_capture_type (Capture_heavy)

					-- Assign correct pointer for transport.
				update_pointer_style (pointed_target)

					-- Start the capture (as late as possible because 
					-- we can't debug when the capture is enabled)
				internal_enable_capture
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_ABSTRACT_PICK_AND_DROPABLE
		do
			modify_widget_appearance (False)
				-- Remove the capture (as soon as possible because we can't
				-- debug when the capture is enabled)
			disable_capture
				-- Return capture type to capture_normal.
				--| normal capture only works on the current windows thread.
			set_capture_type (Capture_normal)

			release_action := Ev_pnd_disabled
			motion_action := Ev_pnd_disabled

				-- Remove the line drawn from source position to Pointer.
			erase_rubber_band

				-- Restore the cursor.
			if pnd_stored_cursor /= Void then
					-- Restore the cursor style of `Current' if necessary.
				internal_set_pointer_style (pnd_stored_cursor)
			else
					-- Restore the standard cursor style.
				internal_set_pointer_style (Default_pixmaps.Standard_cursor)
			end

			if
				(a_button = 3 and is_pnd_in_transport) or
				(a_button = 1 and is_dnd_in_transport)
				-- Check that transport can be ended.
				--| Drag and drop is always ended with the left button release.
				--| Pick and drop is always ended with the right button press.
				--| Drop actions only need to be called if the transport
				--| has actually ended correctly.
			then
				target := pointed_target
					-- Retrieve `target'.
				if target /= Void then
						target.drop_actions.call ([pebble])
							-- If there is a target then execute the drop
							-- actions for `target'.
				end
			end
			enable_transport
				-- Return state ready for next drag/pick and drop.
			
				-- Update `application_imp' to reflect end of transport.
			create env
			application_imp.transport_ended
			application_imp.set_transport_just_ended
			
			interface.pointer_motion_actions.resume
				-- Resume `pointer_motion_actions'.
			
			env.application.drop_actions.call ([pebble])
				-- Execute drop_actions for the application.
			is_dnd_in_transport := False
			is_pnd_in_transport := False
			last_pointed_target := Void
				-- Assign `Void' to `last_pointer_target'.
			press_action := Ev_pnd_start_transport
			if pebble_function /= Void then
				pebble := Void
			end
			original_top_level_window_imp.allow_movement
			original_top_level_window_imp := Void
		ensure then
			original_window_void: original_top_level_window_imp = Void
			press_action_Reset: press_action = Ev_pnd_start_transport
			not_has_capture: internal_capture_status = False
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			wel_point: WEL_POINT
			current_target: EV_ABSTRACT_PICK_AND_DROPABLE
			widget_imp_at_cursor_position: EV_WIDGET_IMP
			wel_window_at_cursor_position: WEL_WINDOW
			current_target_object_id: INTEGER
			item_list_imp: EV_ITEM_LIST_IMP [EV_ITEM]
			item_imp: EV_ITEM_IMP
			sensitive: EV_SENSITIVE
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window_at_cursor_position := wel_point.window_at
				-- Retrieve WEL_WINDOW at cursor position

			if wel_window_at_cursor_position /= Void then
					-- If the cursor is currently over a WEL_WINDOW

				widget_imp_at_cursor_position ?= wel_window_at_cursor_position
					-- Retrieve the implementation of the Vision2 Widget at
					-- Cursor position and check it is not Void.
				
				if widget_imp_at_cursor_position /= Void then	
					current_target := widget_imp_at_cursor_position.interface
						-- Current pick and drop target is the interface of 

					current_target_object_id := current_target.object_id
							-- The current_target_object_id is set to the
							-- widget.
							-- If a widget holds items, we now need to check
							-- that the correct target is in fact one of its
							-- children.

					
					item_list_imp ?= widget_imp_at_cursor_position
					if item_list_imp /= Void then
						item_imp ?= item_list_imp.find_item_at_position (wel_point.x
							- item_list_imp.screen_x, wel_point.y - item_list_imp.screen_y)
						if item_imp /= Void then
						if not item_imp.interface.drop_actions.is_empty then
								-- If the cursor is over an item and the item is a
								-- pick and drop target then we set the target id to that of the
								-- item, as the items are conceptually 'above' the list and so
								-- if a list and one of its items are pnd targets then the 
								-- item should recieve.
							sensitive ?= item_imp.interface
								-- If an item is not `sensitive' then it cannot be dropped on.
							if sensitive = Void or (sensitive /= Void and then sensitive.is_sensitive) then
								Current_target_object_id := item_imp.interface.object_id
							end
						end
						end
					end
				end
						
				global_pnd_targets.start
				global_pnd_targets.search (current_target_object_id)
				if not global_pnd_targets.exhausted then
					-- If the target is valid then return the target.
					-- Otherwise the target will be void.
					Result ?= interface.id_object (global_pnd_targets.item)
				end
			end
		end

	query_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER): ANY is
			-- `Result' is result of `pebble_function'.
		do
			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y])
				Result := pebble_function.last_result
			end
		end

feature {EV_ANY_I} -- Implementation

	is_pnd_in_transport: BOOLEAN
		-- Is `Current' executing pick and drop?

	is_dnd_in_transport: BOOLEAN
		-- Is `Current' executing drag and drop?
	
	press_action: INTEGER
		-- State which is used to decide action on pick/drag and drop press.

	release_action: INTEGER
		-- State which is used to describe action on pick/drag and drop release.

	motion_action: INTEGER
		-- State which is used to describe action on pick/drab and drop
		-- pointer motion.

	Ev_pnd_disabled: INTEGER is 0
	Ev_pnd_start_transport: INTEGER is 1
	Ev_pnd_end_transport: INTEGER is 2
	Ev_pnd_execute: INTEGER is 3
		-- Allowable states for use with `press_action', release_action' and
		-- `motion_action'.

	old_pointer_x, old_pointer_y: INTEGER
		-- Hold the last position that the rubber band was drawn to.
		--| Used to stop unecessary re-draw of the band when no movement.

	internal_pick_x, internal_pick_y: INTEGER
		-- Rubber band starting position.
		-- Only initialised when a pick/drag and drop is started.

	original_x, original_y: INTEGER
	original_x_tilt, original_y_tilt, original_pressure: DOUBLE
		-- Hold the values passed to start transport so when a drag and drop
		-- actually starts, with real_start_transport,these can be passed
		-- as arguments.

	awaiting_movement: BOOLEAN
		-- Is a drag and drop awaiting mouse movement?

	drag_and_drop_starting_movement: INTEGER is 3
		-- Pointer movement in pixels required to start a drag and drop.

	cursor_pixmap: EV_CURSOR
			-- Cursor used on the widget.

	pnd_stored_cursor: EV_CURSOR
			-- Cursor used on the widget before PND started.

	set_pointer_style (new_cursor: EV_CURSOR) is
			-- Assign `new_cursor' to cursor used on `Current'.
			-- Can be called through `interface'.
		do
				-- PND overrides the cursor of `Current' so
				-- if we are currently executing PND then we must store
				-- `new_cursor' in `pnd_stored_cursor' which holds the cursor
				-- that is restored when the PND ends.
			if not transport_executing then
				internal_set_pointer_style (new_cursor)
			end
			pnd_stored_cursor := new_cursor
		end

	internal_set_pointer_style (new_cursor: EV_CURSOR) is
			-- Assign `new_cursor' to cursor used on `Current'.
			-- Only called through implementation.
		local
			wel_cursor: WEL_CURSOR
			cursor_imp: EV_PIXMAP_IMP_STATE
		do
				-- We do a global setting. This means that if the widget
				-- where the cursor is has a different cursor than
				-- `new_cursor' it will flash, but this is better than to
				-- wait until the on_set_cursor event (WM_SETCURSOR) is
				-- called to change the shape of the cursor.
			cursor_pixmap := new_cursor
			cursor_imp ?= cursor_pixmap.implementation
			wel_cursor := cursor_imp.cursor
			if wel_cursor = Void then
				wel_cursor := cursor_imp.build_cursor
				wel_cursor.enable_reference_tracking
			else
				wel_cursor.increment_reference
			end
				-- The cursor has been just built from `cursor_imp'
				-- so we can use it's width and height to check they match
				-- the cursor size from WEL_SYSTEM_METRICS.
				--| If we are running on Windows 95 we need to check that
				--| the cursor size is valid.	 	
			check
				cursor_size_valid: (create {WEL_WINDOWS_VERSION}
					).is_windows_95
					implies (cursor_imp.width = cursor_width and
					cursor_imp.height = cursor_height)
			end
			
			if current_wel_cursor /= Void then
				current_wel_cursor.decrement_reference
				current_wel_cursor := Void
			end
			current_wel_cursor := wel_cursor
			wel_cursor.set
		end
		
	current_wel_cursor: WEL_CURSOR
			-- Current cursor set, Void if none.

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- Cursor of `Current'.
		deferred
		end

	draw_rubber_band  is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			if rubber_band_is_drawn then
				real_draw_rubber_band
			end
			old_pointer_x := pointer_x
			old_pointer_y := pointer_y
			real_draw_rubber_band
			rubber_band_is_drawn := True
		end

	real_draw_rubber_band is
			-- Draw rubber band.
		do
			pnd_screen.set_invert_mode
			pnd_screen.draw_segment
				(internal_pick_x, internal_pick_y, old_pointer_x, old_pointer_y)
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				real_draw_rubber_band
				rubber_band_is_drawn := False
			end
		end

	pnd_screen: EV_SCREEN
			-- Screen, used for drawing rubber band.
		--| This was previously a `Once' function, but on Windows 98,
		--| the screen appeared to become corrupted from time to time.
		--| We now create this screen in `real_start_transport' which
		--| is a reasonable trade off. When EV_SCREEN is fixed on Win98
		--| Then this can be a once again.

	enable_capture is
			-- Enable capture.
			--| Accessible through the interface of widget.
		do
			set_capture_type (Capture_heavy)
			internal_enable_capture
		end

	internal_enable_capture is
			-- Grab all user events.
			--| Not accessible through the interface of widget.
		do
			inspect capture_type
			when Capture_heavy then
				set_heavy_capture
			when Capture_normal then
				set_capture
			end
		end

	disable_capture is
			-- Release all user events.
		do
			inspect capture_type
			when Capture_heavy then
				release_heavy_capture
			when Capture_normal then
				release_capture
			end
		end

	top_level_window_imp: EV_WINDOW_IMP is
			-- Top level window that contains `Current'.
		deferred
		end

	original_top_level_window_imp: EV_WINDOW_IMP
			-- Top level window of `Current' at start of transport.
			-- We need this, as `Current' may be removed from its parent
			-- during the transport, therefore making it impossible for us
			-- to call `top_level_window_imp' after this has occurred as it
			-- recursively checks the parents of `Currents'.

	set_heavy_capture is
		deferred
		end

	release_heavy_capture is
		deferred
		end

	set_capture is
		deferred
		end

	release_capture is
		deferred
		end

	internal_capture_status: BOOLEAN_REF is
			-- System wide once, in order to always get the
			-- same value.
			-- True if there is the mouse is currently captured.
		once
			Create Result
		end

	internal_capture_type: INTEGER_REF is
			-- System wide once, in order to always get the
			-- same value.
		once
			Create Result
		end

feature {EV_ANY_I} -- Implementation 

	application_imp: EV_APPLICATION_IMP is
			-- `Result' is implementation of application from environment.
		local
			environment: EV_ENVIRONMENT
		do
			create environment
			Result ?= environment.application.implementation
		ensure
			Result_not_void: Result /= Void
		end

feature -- Public constants

	Capture_heavy: INTEGER is 1
			-- The mouse [has been/should be] captured through
			-- a call to `set_heavy_capture'

	Capture_normal: INTEGER is 0
			-- The mouse [has been/should be] captured through
			-- a call to `set_capture'
			--
			-- Default value.

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

