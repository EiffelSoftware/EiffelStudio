indexing
	description: "Ancestor of all PND widgets which contain items."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP

inherit

	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press,
			interface,
			escape_pnd
		end

feature {EV_ANY_I, EV_INTERNAL_COMBO_FIELD_IMP,
		EV_INTERNAL_COMBO_BOX_IMP} -- Implementation

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5,
					a_screen_x, a_screen_y)
					-- We must only set the parent source to true if
					-- the P/DND and drop has just started.
				if (a_button = 1 and mode_is_drag_and_drop) or
					(a_button = 3 and mode_is_pick_and_drop) then
					set_parent_source_true
				end
			when
				Ev_pnd_end_transport
			then
				end_transport (a_x, a_y, a_button, 0, 0, 0.5,
						a_screen_x, a_screen_y)
					-- If the user cancelled a pick and drop with the left
					-- button then we need to make sure that the
					-- pointer_button_press_actions are not called on
					-- `Current' or an item at the current
					-- pointer position.
				if a_button = 1 then
					discard_press_event
				end
				set_parent_source_false
			else
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end
		
	escape_pnd is
			-- Escape the pick and drop.
		do
				--| This is redefined so that when escape has been pressed, we
				--| can reset the attributes help in `Current' which relate to
				--| the current state of a pick and drop.
			item_is_pnd_source:= False
			parent_is_pnd_source := False
			pnd_item_source := Void
			application_imp.clear_transport_just_ended
				-- If we are executing a pick and drop
			if application_imp.pick_and_drop_source /= Void then
					-- We use default values which cause pick and drop to end.
				application_imp.pick_and_drop_source.end_transport (0, 0, 2, 0, 0, 0,
					0, 0)
			end
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 2)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_press_actions.call
				([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	press_actions_called: BOOLEAN
		-- Have `pointer_button_press_actions' been called on `Current'? 

	item_is_pnd_source_at_entry: BOOLEAN
		-- Is an item the source of a pick/drag and drop?
		-- updated every time entering `on_right_button_down'.
		-- or `on_left_button_down.

	item_is_in_pnd: BOOLEAN is
		do
			if pnd_item_source /= Void then
				if pnd_item_source.is_pnd_in_transport then
					Result := True
				end
				if pnd_item_source.is_dnd_in_transport then
					Result := True
				end								
			end
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
			item_is_pnd_source_at_entry := item_is_pnd_source
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if (not item_is_pnd_source and not is_pnd_in_transport
				and not is_dnd_in_transport) or (item_is_pnd_source and not
				pnd_item_source.is_pnd_in_transport and not
				pnd_item_source.is_dnd_in_transport) then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])
				press_actions_called := True
			end
			internal_propagate_pointer_press (keys, x_pos, y_pos, 3)
			press_actions_called := False
			item_is_pnd_source_at_entry := False
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
				-- If a pick/drag and drop is currently executing then
				-- we are now cancelling it. We do not want the default
				-- processing to be carried out on `Current'. i.e. if this is
				-- happening in a list, cancelling over an item would have
				-- selected the item.
			if pnd_item_source /= Void or parent_is_pnd_source then
				disable_default_processing
			end
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if not (item_is_pnd_source and not is_pnd_in_transport and not
				is_dnd_in_transport) or (item_is_pnd_source and not
				pnd_item_source.is_pnd_in_transport and not
				pnd_item_source.is_dnd_in_transport) then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
				press_actions_called := True
			end
			internal_propagate_pointer_press (keys, x_pos, y_pos, 1)
			press_actions_called := False
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wmlbuttonup message
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if item_is_pnd_source then
				pnd_item_source.check_drag_and_drop_release (x_pos, y_pos)
			elseif parent_is_pnd_source then
				check_drag_and_drop_release (x_pos, y_pos)
				parent_is_pnd_source := False
			end
			interface.pointer_button_release_actions.call
				([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
		end


	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		do
			button_double_click_received (keys, x_pos, y_pos, 1)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		do
			button_double_click_received (keys, x_pos, y_pos, 2)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		do
			button_double_click_received (keys, x_pos, y_pos, 3)
		end

	button_double_click_received (keys, x_pos, y_pos, a_button: INTEGER) is
			-- Handle a double click from button `a_button'.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
				-- Assign the screen coordinates of the click to `pt'
			pt := client_to_screen (x_pos, y_pos)
				-- Propagate the double click event to the appropriate item.
			internal_propagate_pointer_double_press
				(keys, x_pos, y_pos, a_button)
				-- Call pointer_double_press_actions on `Current'.
			interface.pointer_double_press_actions.call
				([x_pos, y_pos, a_button, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	client_to_screen (x_pos, y_pos: INTEGER): WEL_POINT is
		deferred
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
		deferred
		end

	internal_propagate_pointer_double_press (
		keys, x_pos, y_pos, button: INTEGER) is
		deferred
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_ITEM_IMP is
			-- `Result' is item at pixel position `x_pos', `y_pos'.
		deferred
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen.
		deferred
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen.
		deferred
		end

	interface: EV_WIDGET

feature {EV_PICK_AND_DROPABLE_ITEM_IMP} -- Status report
	
	call_press_event: BOOLEAN
			-- Should we call the press event or ignore it due to the
			-- pick and drop?
			--| For example, if you start a pick and drop in an EV_LIST, move
			--| the mouse over an item and cancel the pick and drop with the
			--| left button, we do not want the pointer_button_press_actions
			--| to be called for that item as we are not pressing the item but
			--| cancelling the PND instead. 

	discard_press_event is
			-- Assign `True' to `call_press_event'.
		do
			call_press_event := False
		end

	keep_press_event is
			-- Assign `True' to `call_press_event'.
		do
			call_press_event := True
		end

	parent_is_pnd_source : BOOLEAN
			-- PND started in the widget.

	pnd_item_source: EV_PICK_AND_DROPABLE_ITEM_IMP
			-- PND source if PND started in an item.

	item_is_pnd_source: BOOLEAN
		-- PND started in an item. 

	set_item_source (source: EV_PICK_AND_DROPABLE_ITEM_IMP) is
			-- Assign `source' to `pnd_item_source'
		do
			pnd_item_source := source
		end

	set_parent_source_true is
			-- Assign `True' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := True
		end

	set_parent_source_false is
			-- Assign `False' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := False
		end

	set_item_source_true is
			-- Assign `True' to `item_is_pnd_source'.
		do
			item_is_pnd_source := True
		end

	set_item_source_false is
			-- Assign `False' to `item_is_pnd_source'.
		do
			item_is_pnd_source := False
		end

feature {EV_PICK_AND_DROPABLE_ITEM_IMP} -- Deferred

	disable_default_processing is
			-- Disable default window processing.
		deferred
		end


	top_level_window_imp: EV_WINDOW_IMP is
		deferred
		end

	set_pointer_style (c: EV_CURSOR) is
		deferred
		end

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		deferred
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		deferred
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		deferred
		end

	release_heavy_capture is
			-- Release user input
			-- Works on all windows threads.
		deferred
		end

end -- class EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP

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
--| Revision 1.14  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.13  2001/07/10 17:22:20  rogers
--| Removed author from the indexing clause.
--|
--| Revision 1.12  2001/06/14 00:12:23  rogers
--| Redefined escape_pnd, as there were certain state variables for pick and
--| dropable item holders that were not being reset correctly when escape was
--| used to cancel a pick and drop. This meant that a pick and drop could then
--| be started again, when it should not have been.
--|
--| Revision 1.11  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.9.2.20  2001/02/08 18:06:14  rogers
--| Removed uneeded call to move_to_foreground.
--|
--| Revision 1.9.2.19  2001/02/06 02:03:52  rogers
--| Added find_item_at_position, screen_x and screen_y as deferred.
--|
--| Revision 1.9.2.18  2001/01/05 23:10:50  rogers
--| Removed disable_default_processing from on_left_button_up. This was
--| completely unecessary and causing many problems with select_actions.
--|
--| Revision 1.9.2.17  2001/01/02 19:19:27  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.9.2.16  2000/12/29 18:15:16  rogers
--| Now when cancelling a pick and drop, the default processing for the
--| widget is turned off. Added disable_default_processing as deferred.
--|
--| Revision 1.9.2.15  2000/12/29 00:35:14  rogers
--| Pnd_press now calls discard_press_event on `pnd_original_parent' if the
--| left button is pressed. Added call_press_event, discard_press_event and
--| keep_press_event.
--|
--| Revision 1.9.2.14  2000/11/27 19:11:40  rogers
--| Removed call_press_event, discard_press_event and keep_press_event as all
--| pick_and_dropable widgetes will need these functions. They are being moved
--| into EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.9.2.13  2000/11/02 23:25:55  rogers
--| Corrected button comparison mistake in pnd_press.
--|
--| Revision 1.9.2.12  2000/11/02 19:08:31  rogers
--| Corrected button_value passed from on_left_button_down.
--|
--| Revision 1.9.2.11  2000/11/02 17:52:45  rogers
--| Pressing any button apart from the right will raise `Current' to the
--| foreground. The exception is pressing the left button when drag and drop is
--| enabled on `Current'.
--|
--| Revision 1.9.2.9  2000/10/26 00:20:28  rogers
--| Corrected bugs in on_left_button_down and on_right_button_down.
--|
--| Revision 1.9.2.8  2000/10/25 23:16:02  rogers
--| Please ignore last log message. Should have read:
--| Major change to pick and drop with items. The events are now called before
--| a pick/drag and drop is started or after a pick/drag and drop is completed
--| where as before, they were alwasy called after. As well as modifications to
--| existing routines, added press_actions_called, item_is_pnd_source_at_entry,
--| item_is_in_pnd, call press_event, discard_event and keep_press_event to
--| keep track of the pick/drag and drop status.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------


