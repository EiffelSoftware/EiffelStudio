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
			motion_action := Ev_pnd_disabled -- FIXME needed??
			is_transport_enabled := False
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
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
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	pnd_motion (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
		do
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
	

feature -- Implementation

	start_transport (
        a_x, a_y, a_button: INTEGER;
        a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        a_screen_x, a_screen_y: INTEGER)
	 is
			-- Initialize the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			curs_code: EV_CURSOR_CODE
		do
			if
				mode_is_drag_and_drop and a_button = 1 or
				mode_is_pick_and_drop and a_button = 3
			then
				print ("start transport%N")
				interface.pointer_motion_actions.block
				create env
				if pebble_function /= Void then
					pebble_function.call ([a_x, a_y])
					pebble := pebble_function.last_result
				end
				env.application.pick_actions.call ([pebble])
				interface.pick_actions.call ([a_x, a_y])

				if mode_is_pick_and_drop then
					is_pnd_in_transport := True
				else
					is_dnd_in_transport := True
				end

				pointer_x := a_screen_x
				pointer_y := a_screen_y
				if pick_x = 0 and pick_y = 0 then
					pick_x := a_screen_x
					pick_y := a_screen_y
				end

				set_capture
	
				press_action := Ev_pnd_end_transport
				motion_action := Ev_pnd_execute
				pnd_stored_cursor_imp := cursor_imp
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_PICK_AND_DROPABLE
			list: EV_LIST
			list_imp: EV_LIST_IMP
			list_item: EV_LIST_ITEM_IMP
			standard_cursor: EV_CURSOR
			cursor_code: EV_CURSOR_CODE
		do
			print ("End transport%N")
			release_action := Ev_pnd_disabled
			motion_action := Ev_pnd_disabled
			erase_rubber_band
			release_capture
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
			create env
			env.application.drop_actions.call ([pebble])
			is_dnd_in_transport := False
			is_pnd_in_transport := False
			pick_x := 0
			pick_y := 0
			--|FIXME This has been added to stop violation of postcondition
			--| 	last_pointed_target_is_void: last_pointed_target = Void
			--|Is this correct?
			last_pointed_target := Void
			if pnd_stored_cursor_imp /= Void then
				set_pointer_style (pnd_stored_cursor_imp.interface)
				-- Set the pointer style back to state before PND.
			else
				create cursor_code
				create standard_cursor.make_with_code (cursor_code.standard)
				set_pointer_style (standard_cursor)
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
			tree_item: EV_TREE_ITEM_IMP
			mcl: EV_MULTI_COLUMN_LIST
			mcl_imp: EV_MULTI_COLUMN_LIST_IMP
			mcl_item: EV_MULTI_COLUMN_LIST_ROW_IMP
			current_target_object_id: INTEGER
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
				-- If the cursor is over an item and the item is a
				-- pick and drop target then we set the target id to that of the
				-- item, as the items are conceptually 'above' the list and so
				-- if a list and one of its items are pnd targets then the 
				-- item should recieve.
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
				-- If the cursor is over an item and the item is a
				-- pick and drop target then we set the target id to that of the
				-- item, as the items are conceptually 'above' the list and so
				-- if a list and one of its items are pnd targets then the 
				-- item should recieve.
							current_target_object_id :=
								mcl_item.interface.object_id
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

	is_pnd_in_transport,
	is_dnd_in_transport: BOOLEAN
	
	press_action: INTEGER
	release_action: INTEGER
	motion_action: INTEGER

	Ev_pnd_disabled: INTEGER is 0
	Ev_pnd_start_transport: INTEGER is 1
	Ev_pnd_end_transport: INTEGER is 2
	Ev_pnd_execute: INTEGER is 3

	old_pointer_x,
	old_pointer_y: INTEGER

	cursor_imp: EV_CURSOR_IMP
			-- Cursor used on the widget.

	pnd_stored_cursor_imp: EV_CURSOR_IMP
			-- Cursor used on the widget before PND started.

	set_pointer_style (value: EV_CURSOR) is
			-- Make `value' the new cursor of the widget
		do
			if value /= Void then
				cursor_imp ?= value.implementation
				if cursor_on_widget.item = Current then
					cursor_imp.set
				end
			else
				cursor_imp := Void
			end
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
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
			set_capture
		end

	disable_capture is
			-- Release all user events.
		do
			release_capture
		end

	set_capture is
		deferred
	end

	release_capture is
		deferred
	end

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
