--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Implementation of a pick and drop source."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_IMP

inherit
	EV_PICK_AND_DROPABLE_I


	EV_PND_EVENTS_CONSTANTS_IMP

feature -- Access

	capture_enabled: BOOLEAN is
			-- Is the mouse currently captured?
			-- See constants Capture_xxxx at the end of the class
		do
			Result := internal_capture_status.item
		end

	capture_type: INTEGER is
			-- Type of capture to use when capturing the mouse
			-- See constants Capture_xxxx at the end of the class
		do
			Result := internal_capture_type.item
		ensure
			valid_result: Result = Capture_normal or
						  Result = Capture_heavy
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
				end_transport (a_x, a_y, a_button)
			else
				-- If there is no drag and drop on `Current' then
				-- we make `Current' the topmost window as soon as
				-- the left button is pressed. If there is drag and drop
				-- on `Current' and a press did not lead to execution of the
				-- drag and drop then this will happen during
				-- check_drag_and_drop_release.
				if a_button = 1 then
					top_level_window_imp.move_to_foreground
				end
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
			original_x := -1
			original_y := -1
			awaiting_movement := False
			if mode_is_drag_and_drop and press_action =
				Ev_pnd_end_transport then
				end_transport (a_x, a_y, 1)
			else
				-- If we have not started an actual drag and drop then make
				-- `Current' the topmost window. We have to wait for the release
				-- if `Current' has drag and drop enabled which is true if
				-- check_drag_and_drop_release has been called.
				top_level_window_imp.move_to_foreground
			end
		end

	pnd_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- If in drag/pick and drop then update.
			--| This is executed every time the pointer is moved over
			--| `Current' while pick/drag and drop is in process.
		do
			if awaiting_movement then
				if (original_x - a_x).abs > 3 or (original_y - a_y).abs > 3 then
					real_start_transport (original_x, original_y, 1,
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
	

feature {EV_ANY_I} -- Implementation

	start_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize the pick/drag and drop mechanism.
		do
			if mode_is_pick_and_drop and a_button = 3 then
				real_start_transport (a_x, a_y, a_button, a_x_tilt, a_y_tilt,
					a_pressure, a_screen_x, a_screen_y)
			elseif mode_is_pick_and_Drop and a_button = 1 then
				top_level_window_imp.move_to_foreground
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
				end
			end
		end
		
	real_start_transport (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt,
		a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Actually start the pick/drag and drop mechanism.
		require else
			not_already_transporting: not is_pnd_in_transport and
				not is_dnd_in_transport 
		local
			env: EV_ENVIRONMENT
		do
			if
				(mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
				-- Check that transport can be started.
				--| Drag and drop is always started with the left button press.
				--| Pick and drop is always started with the right button press.
			then
				interface.pointer_motion_actions.block
					-- Block `pointer_motion_actions'.

				create env
					-- Create `env'
					--| See description for EV_ENVIRONMENT.
				if pebble_function /= Void then
					pebble_function.call ([a_x, a_y])
					pebble := pebble_function.last_result
					-- Set the data to be transported.
				end
				env.application.pick_actions.call ([pebble])
					-- Execute pick_actions for the application.
				interface.pick_actions.call ([a_x, a_y])
					-- Execute pick_actions for `Current'.
				if mode_is_pick_and_drop then
					is_pnd_in_transport := True
						-- Assign `True' to `is_pnd_in_transport'
				else
					is_dnd_in_transport := True
						-- Assign `True' to `is_dnd_in_transport'
				end
				pointer_x := a_screen_x
				pointer_y := a_screen_y
				if pick_x = 0 and pick_y = 0 then
					pick_x := a_screen_x
					pick_y := a_screen_y
				end
				press_action := Ev_pnd_end_transport
				motion_action := Ev_pnd_execute
					-- Store the previous cursor of `Current'.
				pnd_stored_cursor := cursor_pixmap
				set_capture_type (Capture_heavy)

					-- Start the capture (as late as possible because 
					-- we can't debug when the capture is enabled)
				enable_capture
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_PICK_AND_DROPABLE
		do
			io.putstring ("Transport Ended%N")
				-- Remove the capture (as soon as possible because we can't
				-- debug
				-- when the capture is enabled)
			disable_capture

				-- Return capture type to capture_normal.
				--| normal capture only works on the current windows thread.
			set_capture_type (Capture_normal)

			release_action := Ev_pnd_disabled
			motion_action := Ev_pnd_disabled

				-- Remove the line drawn from source position to Pointer.
			erase_rubber_band

			if
				(a_button = 3 and is_pnd_in_transport) or
				(a_button = 1 and is_dnd_in_transport)
				-- Check that transport can be started.
				--| Drag and drop is always ended with the left button release.
				--| Pick and drop is always ended with the right button press.
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
			create env
			env.application.drop_actions.call ([pebble])
				-- Execute drop_actions for the application.
			is_dnd_in_transport := False
			is_pnd_in_transport := False
			pick_x := 0
			pick_y := 0
			last_pointed_target := Void
				-- Assign `Void' to `last_pointer_target'.
			if pnd_stored_cursor /= Void then
					-- Restore the cursor style of `Current' if necessary.
				set_pointer_style (pnd_stored_cursor)
			else
					-- Restore the standard cursor style.
				set_pointer_style (Default_pixmaps.Standard_cursor)
			end
			press_action := Ev_pnd_start_transport
			if pebble_function /= Void then
				pebble := Void
			end
		end

	pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			wel_point: WEL_POINT
			current_target: EV_PICK_AND_DROPABLE
			widget_imp_at_cursor_position: EV_WIDGET_IMP
			wel_window_at_cursor_position: WEL_WINDOW
			list: EV_LIST
			list_imp: EV_LIST_IMP
			list_item: EV_LIST_ITEM_IMP
			tree: EV_TREE			
			tree_imp: EV_TREE_IMP
			tree_item: EV_TREE_NODE_IMP
			mcl: EV_MULTI_COLUMN_LIST
			mcl_imp: EV_MULTI_COLUMN_LIST_IMP
			mcl_item: EV_MULTI_COLUMN_LIST_ROW_IMP
			current_target_object_id: INTEGER
			tb: EV_TOOL_BAR
			tb_imp: EV_TOOL_BAR_IMP
			tb_item: EV_TOOL_BAR_BUTTON_IMP
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
				check 
					widget_imp_at_cursor_position /= Void
				end
	
				current_target := widget_imp_at_cursor_position.interface
					-- Current pick and drop target is the interface of 

				current_target_object_id := current_target.object_id
						-- The current_target_object_id is set to the widget.
						-- If a widget holds items, we now need to check that
						-- the correct target is in fact one of its children.
					
				list ?= current_target
				if list /= Void then
					list_imp ?= list.implementation
							-- Retrieve implementation of list.
					check	
						list_imp /= Void
					end
					list_item := list_imp.find_item_at_position (
					wel_point.x - list.screen_x, wel_point.y - list.screen_y)
							-- Return list item at cursor position.
					if list_item /= Void then
						if not list_item.interface.drop_actions.empty then
				-- If the cursor is over an item and the item is a
				-- pick and drop target then we set the target id to that of the
				-- item, as the items are conceptually 'above' the list and so
				-- if a list and one of its items are pnd targets then the 
				-- item should recieve.
							current_target_object_id :=
								list_item.interface.object_id
						end
					end
				end
				
				tree ?= current_target
				if tree /= Void then
					tree_imp ?= tree.implementation
							-- Retrieve implementation of tree.
					check	
						tree_imp /= Void
					end
					tree_item := tree_imp.find_item_at_position (
					wel_point.x - tree.screen_x, wel_point.y - tree.screen_y)
							-- Return list item at cursor position.
					if tree_item /= Void then
						if not tree_item.interface.drop_actions.empty then
							current_target_object_id :=
								tree_item.interface.object_id
						end
					end
				end

				mcl ?= current_target
				if mcl /= Void then
					mcl_imp ?= mcl.implementation
							-- Retrieve implementation of tree.
					check	
						mcl_imp /= Void
					end
					mcl_item := mcl_imp.find_item_at_position (
					wel_point.x - mcl.screen_x, wel_point.y - mcl.screen_y)
							-- Return list item at cursor position.
					if mcl_item /= Void then
						if not mcl_item.interface.drop_actions.empty then
							current_target_object_id :=
								mcl_item.interface.object_id
						end
					end
				end

				tb ?= current_target
				if tb /= Void then
					tb_imp ?= tb.implementation
							-- Retrieve implementation of tree.
					check	
						tb_imp /= Void
					end
					tb_item := tb_imp.find_item_at_position (
					wel_point.x - tb.screen_x, wel_point.y - tb.screen_y)
							-- Return list item at cursor position.
					if tb_item /= Void then
						if not tb_item.interface.drop_actions.empty then
							current_target_object_id :=
								tb_item.interface.object_id
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


		-- Hold the values passed to start transport so when a drag and drop
		-- actually starts, with real_start_transport,these can be passed
		-- as arguments.
	original_x, original_y: INTEGER
	original_x_tilt, original_y_tilt, original_pressure: DOUBLE

		-- Is a drag and drop awaiting mouse movement?
	awaiting_movement: BOOLEAN


	cursor_pixmap: EV_CURSOR
			-- Cursor used on the widget.

	pnd_stored_cursor: EV_CURSOR
			-- Cursor used on the widget before PND started.

	set_pointer_style (new_cursor: EV_CURSOR) is
			-- Make `new_cursor' the new cursor of the widget
		local
			wel_cursor: WEL_CURSOR
			cursor_imp: EV_PIXMAP_IMP_STATE
		do
			if new_cursor /= Void then
				cursor_pixmap := new_cursor
				if cursor_on_widget.item = Current then
					cursor_imp ?= cursor_pixmap.implementation
					wel_cursor := cursor_imp.cursor
					if wel_cursor = Void then
						wel_cursor := cursor_imp.build_cursor
					end
--| FIXME ARNAUD:
--| Windows 95: The width and height of the cursor must be the values returned
--|	by the GetSystemMetrics  function for SM_CXCURSOR and SM_CYCURSOR. In
--| addition, either the cursor bit depth must match the bit depth of the
--| display or the cursor must be monochrome. 
--| See MSDN:Platform SDK:Windows User Interface:SetCursor
					wel_cursor.set
				end
			else
				cursor_imp := Void
			end
		end

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
				(pick_x, pick_y, old_pointer_x, old_pointer_y)
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		do
			if rubber_band_is_drawn then
				real_draw_rubber_band
				rubber_band_is_drawn := False
			end
		end

	pnd_screen: EV_SCREEN is
			-- `Result' is screen, used for drawing rubber band.
		once
			create Result
		end

	enable_capture is
			-- Grab all user events.
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

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.30  2000/06/07 17:27:54  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
