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
				not is_dnd_in_transport
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

			create env
			
			application_imp.transport_ended

			application_imp.set_transport_just_ended

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

feature {NONE} -- Implementation

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

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.33  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.32  2001/07/06 18:34:48  rogers
--| ev_pick_and_dropable_imp.e
--|
--| Revision 1.31  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.8.79  2001/06/04 22:12:39  rogers
--| Removed redundent require else.
--|
--| Revision 1.8.8.78  2001/05/01 00:00:05  rogers
--| Improved comment.
--|
--| Revision 1.8.8.77  2001/03/20 18:23:39  rogers
--| Pnd_Screen is no longer a once function, but created at the start of
--| each transport in `real_start_transport'. This fixes a problem with the
--| screen on Windows 98.
--|
--| Revision 1.8.8.76  2001/03/16 19:26:28  rogers
--| Added modify_widget_appearence.
--|
--| Revision 1.8.8.75  2001/02/25 17:55:24  pichery
--| Added tight reference tracking for GDI objects.
--|
--| Revision 1.8.8.74  2001/02/23 23:42:30  pichery
--| Added reference tracking for the current cursor.
--|
--| Revision 1.8.8.73  2001/02/16 19:20:30  rogers
--| Removed unreferenced variable from application_imp.
--|
--| Revision 1.8.8.72  2001/02/16 17:24:36  rogers
--| Added `original_top_level_window_imp'. As `Current' may be un parented
--| during a pick and drop, we need to know the original
--| `top_level_window_imp' at the end of the pick/drag and drop.
--|
--| Revision 1.8.8.71  2001/02/13 23:11:50  rogers
--| Added query_pebble_function.
--|
--| Revision 1.8.8.70  2001/02/10 01:39:40  rogers
--| Added application_imp which reduces repeated code in `Current'.
--|
--| Revision 1.8.8.68  2001/02/08 18:04:56  rogers
--| Removed unecessary calls to `move_to_foreground' on `top_level_window_imp'.
--|
--| Revision 1.8.8.67  2001/02/06 20:22:08  rogers
--| End_transport calls allow_movement on `top_level_window_imp. This fixes a
--| bug when cancelling a pick and drop, and then attempting to raise the
--| `top_level_window_imp' with alt-tab on the keyboard.
--|
--| Revision 1.8.8.66  2001/02/06 01:45:18  rogers
--| Modified real_pointed_target. There is no longer a relience on knowing
--| about each time of item and holder. One general check is now done when
--| checking if an item is the target. This greatly simplifies the code and
--| will make it much easier to add new cases.
--|
--| Revision 1.8.8.65  2001/01/31 17:22:42  rogers
--| Added post condition to escape_pnd. Comments.
--|
--| Revision 1.8.8.64  2001/01/29 21:27:47  rogers
--| Optimized transport_executing.
--|
--| Revision 1.8.8.63  2001/01/29 21:05:43  rogers
--| implemented internal_set_pointer_style with previous implementation from
--| set_pointer_style. set_pointer_style now calls internal_set_pointer_style
--| when necessary. This fixes a bug in setting the pointer_style of a widget
--| when in a pick and drop started from that widget.
--|
--| Revision 1.8.8.62  2001/01/22 21:14:15  rogers
--| Real_start_transport now calls update_pointer_style to update the
--| current cursor. This fixes a bug whereby you would have to move the
--| mouse for the cursor to be updated after starting a pick and drop.
--|
--| Revision 1.8.8.61  2001/01/19 19:20:16  rogers
--| Removed previous commit. The bug was fixed but it introduced a bug with
--| restoring the cursor after use. Both bugs can be fixed as soon as we have
--| a way of knowing in `Current' whether seT_pointer_style was called from the
--| interface or the pick and drop implementation in EV_PICK_AND_DROPABLE_I.
--|
--| Revision 1.8.8.60  2001/01/18 18:41:13  rogers
--| Fixed bug in set_pointer_style. If set_pointer_style is called during
--| a pick/drag and drop, then we now store the new pointer style for use when
--| restoring the cursor after transport.
--|
--| Revision 1.8.8.59  2001/01/16 22:43:14  rogers
--| Fixed bug in check_drag_and_drop_release. If the release has occured
--| before the real transport has started (i.e. awaiting_movement := True)
--| then we must raise the top level window to the foreground.
--|
--| Revision 1.8.8.58  2001/01/02 19:17:08  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.8.8.57  2000/12/29 00:31:02  rogers
--| Removed call_press_event, discard_press_event and keep_press_event.
--|
--| Revision 1.8.8.56  2000/12/15 19:48:52  rogers
--| Fixed a bug in real_start_transport. If you had a very slow pebble function
--| and had pebble_positioning enabled, if the mouse was moved over another
--| widget during the pebble functions execution, then the band would be drawn
--| relative to the wrong widget.
--|
--| Revision 1.8.8.55  2000/12/15 18:28:27  rogers
--| Fixed bugs with the pebble_position. Once set, it now remains. Added
--| internal_pick_x, internal_pick_y.
--|
--| Revision 1.8.8.54  2000/12/08 03:10:24  manus
--| Check for Windows 95 is done within the check to avoid useless computation.
--|
--| Revision 1.8.8.53  2000/12/07 00:25:11  rogers
--| The application is retrieved and notified of the pick and drop ending
--| before we call the drop_actions. It was previously called after, and
--| would cause a system to crash if a dialog was displayed during the
--| drop_actions and that dialog was then closed by pressing escape.
--| Comment improvement.
--|
--| Revision 1.8.8.52  2000/12/04 23:34:58  rogers
--| Set_pointer_style now queries is_windows95 instead of is_windows_95 for
--| compilation on 4.5 which uses an old version of WEL_WINDOWS_VERSION.
--|
--| Revision 1.8.8.51  2000/12/04 22:29:31  rogers
--| Set_pointer_style now only checks that the size of the cursor is correct
--| if Windows 95 is being used. This check is not required for other
--| versions.
--|
--| Revision 1.8.8.50  2000/11/28 21:34:20  manus
--| Renamed call to `empty' into `is_empty' as now defined in CONTAINER.
--|
--| Revision 1.8.8.49  2000/11/27 22:56:52  rogers
--| Fixed bug in real_pointed_target, where a disabled tool bar button with
--| drop_actions would still be set as the target when the mouse was over it.
--| This was overlooked probabably because most items do not inherit
--| EV_SENSITIVE.
--|
--| Revision 1.8.8.48  2000/11/27 19:13:10  rogers
--| Added call_press_event, discard_press_event and keep_press_event, for use
--| internally so we can cancel the press_actions when a pick and drop is
--| cancelled.
--|
--| Revision 1.8.8.47  2000/11/14 19:55:16  rogers
--| Improved comment on disable_capture.
--|
--| Revision 1.8.8.46  2000/11/14 19:41:06  rogers
--| Streamlined enable_capture. Comments.
--|
--| Revision 1.8.8.44  2000/11/07 01:09:04  rogers
--| Fixed real_start_transport. I had mistakenly commited a change in the
--| capture type from heavy to normal.
--|
--| Revision 1.8.8.43  2000/11/06 17:45:47  rogers
--| Renamed pnd_escape to escape_pnd. Removed a_key from the parameters.
--|
--| Revision 1.8.8.42  2000/11/03 23:45:19  rogers
--| Modified real_start_transport and end_transport so they now update the
--| application.
--|
--| Revision 1.8.8.41  2000/11/02 18:39:55  rogers
--| Corrected start_transport so that if we are not starting a transport,
--|  `Current' is now raised to the foreground before checking that the
--| pebble /= Void.
--|
--| Revision 1.8.8.40  2000/11/02 17:51:27  rogers
--| Pressing any button apart from the right will raise `Current' to the
--| foreground. The exception is pressing the left button when drag and drop is
--| enabled on `Current'.
--|
--| Revision 1.8.8.38  2000/10/31 23:49:18  rogers
--| Fixed bug in check_drag_and_drop_release. previously,
--| `top_level_window_imp' would be raised to the foreground even if there
--| was no drag and drop on `Current'. This caused `top_level_window_imp' to
--| be raised to the foreground twice when a left button was pressed on a
--| widget without drag and drop.
--|
--| Revision 1.8.8.37  2000/10/31 19:47:19  rogers
--| Now inherits WEL_SYSTEM_METRICS so we can check that the cursor width and
--| height correspond to those of windows before setting a new_cursor.
--|
--| Revision 1.8.8.36  2000/10/25 23:08:48  rogers
--| Please ignore last log message for this file. Should have read:
--| modified transport_executing and minor formatting.
--|
--| Revision 1.8.8.33  2000/10/24 18:47:17  king
--| Updated end_transport signature
--|
--| Revision 1.8.8.32  2000/09/23 00:22:47  manus
--| Fixed `set_pebble_position' that was working on global screen position and
--| not relative to current widget: fix is in `real_start_transport' where
--| pick_x and pick_y are computed correctly to do the conversion client to
--| screen coordinates.
--|
--| Revision 1.8.8.31  2000/09/22 23:24:08  manus
--| Cosmetics
--| Fixed a windows bug where calling `set_pointer_style' did not change the
--| cursor shape until we process the event loop (through a WM_SETCURSOR
--| callback). Now it change it right away which can make the cursor blinks
--| if cursor associated with current widget is different from the one we
--| just set.
--|
--| Revision 1.8.8.30  2000/09/13 15:40:20  manus
--| Removed a useless `else' clause in `set_pointer_stylee'.
--|
--| Revision 1.8.8.29  2000/09/06 02:26:00  manus
--| Cosmetics
--|
--| Revision 1.8.8.28  2000/08/14 23:51:06  rogers
--| Fixed bug in end_transport. The cursor is now restored to its original
--| state before the drop_actions are executed.
--|
--| Revision 1.8.8.27  2000/08/11 20:51:41  king
--| Removed setting of widget_x/y
--|
--| Revision 1.8.8.26  2000/08/11 19:14:28  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.8.8.25  2000/08/10 22:58:51  rogers
--| Removed FIXME_NOT_REVIEWED. Comments, formatting to 80 columns.
--|
--| Revision 1.8.8.24  2000/08/04 00:40:36  rogers
--| Replaced action sequence calls through the interface of `Current' with
--| calls to the internal action sequences.
--|
--| Revision 1.8.8.23  2000/07/25 18:51:43  brendel
--| Changed type of real_pointed_target to EV_PICK_AND_DROPABLE.
--|
--| Revision 1.8.8.22  2000/07/25 16:04:50  brendel
--| Fixed precursor call.
--|
--| Revision 1.8.8.21  2000/07/25 15:52:25  brendel
--| Redefined create_drop_actions.
--|
--| Revision 1.8.8.20  2000/07/24 22:44:32  rogers
--| Now inherits EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.8.8.19  2000/07/24 19:39:43  rogers
--| Moved call_pebble_function up so it is platform independent.
--|
--| Revision 1.8.8.18  2000/07/24 17:39:14  king
--| Now setting widget_x/y b4 call to pointed target
--|
--| Revision 1.8.8.17  2000/07/17 20:48:38  brendel
--| EV_PICK_AND_DROPABLE -> EV_ABSTRACT_PICK_AND_DROPABLE.
--|
--| Revision 1.8.8.16  2000/07/17 17:55:09  brendel
--| pointed_target -> real_pointed_target.
--| TEMPORARILY added call_pebble_function.
--|
--| Revision 1.8.8.15  2000/07/13 01:51:42  brendel
--| Now does not start PND anymore when pebble_function returns a Void pebble.
--|
--| Revision 1.8.8.14  2000/07/12 22:20:53  brendel
--| Added check for `target_menu_mode' in `start_transport'. If this is
--| True, show the context menu for `pebble'.
--|
--| Revision 1.8.8.13  2000/07/12 16:17:13  rogers
--| Very minor format.
--|
--| Revision 1.8.8.12  2000/07/10 17:50:15  rogers
--| Corrected the start trasnsport type within real_start_transport.
--|
--| Revision 1.8.8.11  2000/06/27 20:14:24  rogers
--| Fixed bug in Pointed target. Pointed target previously assumed that all
--| wel_window's pointed at had a corresponding EV_wIDGET_IMP. This is not
--| true for EV_COMBO_bOX_IMP. So now we check that
--| widget_imp_at_cursor_position is not void before checking the PND.
--|
--| Revision 1.8.8.10  2000/06/22 16:18:45  rogers
--| Removed debugging io.putstring from end_transport.
--|
--| Revision 1.8.8.9  2000/06/12 23:49:12  rogers
--| Removed inheritence from EV_PND_EVENTS_CONSTANTS_IMP as they were not
--| referenced at all.
--|
--| Revision 1.8.8.8  2000/06/09 17:41:03  rogers
--| Added drag_and_drop_starting_movement which is the movement required in
--| pixels, for a drag and drop to start. This removes some `magic' numbers.
--|
--| Revision 1.8.8.7  2000/05/30 16:30:00  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.8.8.6  2000/05/16 20:19:45  king
--| Converted to new tree item structure
--|
--| Revision 1.8.8.5  2000/05/15 21:57:57  rogers
--| Drag and drop now will only execute after the mouse has been held down and
--| moved at least three pixels in any one direction from the press position.
--|
--| Revision 1.8.8.4  2000/05/05 22:34:26  pichery
--| Moved the mouse capture instruction to minimize
--| impact while debugging.
--|
--| Revision 1.8.8.3  2000/05/04 04:20:45  pichery
--| Replaced calls to EV_CURSOR_CODE with
--| calls to EV_DEFAULT_PIXMAPS
--|
--| Revision 1.8.8.2  2000/05/03 19:09:14  oconnor
--| mergred from HEAD
--|
--| Revision 1.29  2000/04/27 17:34:46  rogers
--| More formatting and comments.
--|
--| Revision 1.26  2000/04/14 23:27:10  rogers
--| start transport sets capture type to Capture_heavy.
--|
--| Revision 1.24  2000/04/07 22:41:43  rogers
--| set normal capture as default.
--|
--| Revision 1.23  2000/04/03 18:19:02  rogers
--| Added checks for toolbar items to pointed_target.
--|
--| Revision 1.22  2000/03/30 17:07:02  rogers
--| Removed duplicate comments in pointed_target.
--|
--| Revision 1.21  2000/03/27 20:59:15  pichery
--| Added "heavy" mouse capture notion in pick&drop mechanism.
--| This is NOW the default mouse capture method. The old method
--| (which does not work with Trees and MulticolumnsList) is still
--| available. It is possible to switch from one method to the another
--| using `set_capture_type'.
--|
--| Revision 1.20  2000/03/27 19:42:56  oconnor
--| added support for pebble_funtion
--|
--| Revision 1.19  2000/03/22 20:26:57  rogers
--| Added support for tree_items and multi_column_list_rows in pointed_target.
--| This implementation is not comlete and needs to be reduced.
--|
--| Revision 1.18  2000/03/21 01:27:45  rogers
--| End transport now returns the cursor to the previous state before PND.
--|
--| Revision 1.17  2000/03/17 23:36:06  rogers
--| Fixed pointed_target, and implemented ability for a list_item to be a
--| target. Added the following features : curosr_imp, pnd_stored_cursor_imp,
--| set_pointer_style and cursor_on_widget.
--|
--| Revision 1.16  2000/03/16 17:19:43  brendel
--| Fixed creation of EV_CURSOR_CODE.
--|
--| Revision 1.15  2000/02/21 18:28:59  rogers
--| Removed commented out 'end' within pointed target as it is required.
--|
--| Revision 1.14  2000/02/19 07:51:49  oconnor
--| temp removal or ref to EV_TREE
--|
--| Revision 1.13  2000/02/19 07:07:54  oconnor
--| released
--|
--| Revision 1.12  2000/02/17 00:23:24  brendel
--| Commented out line that assumes that EV_MULTI_COLUMN_LIST_ROW is pick
--| and dropable, but that is not yet implemented.
--|
--| Revision 1.11  2000/02/15 19:24:01  rogers
--| Changed the export status of implementation features to EV_ANY_I.
--|
--| Revision 1.10  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.8.1.2.6  2000/01/27 19:30:11  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.8.1.2.5  2000/01/27 01:16:50  rogers
--| Code in pointed target now uses is_sensitve for the tool bar button check.
--|
--| Revision 1.8.8.1.2.4  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.8.8.1.2.3  2000/01/21 23:15:24  brendel
--| Added features en/dis-able_capture.
--|
--| Revision 1.8.8.1.2.2  1999/12/17 21:33:02  rogers
--| this file now contains EV_PICK_AND_DROPABLE. This now replaces
--| EV_PND_SOURCE, EV_PND_TARGET and EV_PND_TRANSPORTER.
--|
--| Revision 1.8.8.1.2.1  1999/11/24 17:30:19  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
