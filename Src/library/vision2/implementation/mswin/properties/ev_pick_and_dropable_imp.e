--| FIXME Not for release
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
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
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
				env.application.pick_actions.call ([pebble])
	
				interface.pick_actions.call ([a_x, a_y])

				if mode_is_pick_and_drop then
					is_pnd_in_transport := True
				else
					is_dnd_in_transport := True
				end

				if accept_cursor = Void then
					create curs_code.make
					create accept_cursor.make_with_code (curs_code.standard)
				end
				if deny_cursor = Void then
					create curs_code.make
					create deny_cursor.make_with_code (curs_code.no)
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
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER) is
			-- Terminate the pick and drop mechanism.
		local
			env: EV_ENVIRONMENT
			target: EV_PICK_AND_DROPABLE
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
		end

	pointed_target: EV_PICK_AND_DROPABLE is
			-- Hole at mouse position
		local
			wel_point: WEL_POINT
			toolbar: EV_TOOL_BAR_IMP
			tbutton: EV_TOOL_BAR_BUTTON_IMP
			mc_list: EV_MULTI_COLUMN_LIST_IMP
			tree: EV_TREE_IMP
			tg: EV_PICK_AND_DROPABLE
			widget_pointed: EV_WIDGET_IMP
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			widget_pointed ?= wel_point.window_at
			if widget_pointed /= Void then
				toolbar ?= widget_pointed
				if toolbar /= Void then
					wel_point.screen_to_client (toolbar)
					tbutton := toolbar.find_item_at_position (wel_point.x, wel_point.y)
					if tbutton /= Void and then tbutton.is_sensitive then
						tg := tbutton.interface
					end
				else
					mc_list ?= widget_pointed
					if mc_list /= Void then
						wel_point.screen_to_client (mc_list)
						tg := mc_list.find_item_at_position (wel_point.x, wel_point.y).interface
					else
						tree ?= widget_pointed
						if tree /= Void then
							wel_point.screen_to_client (tree)
							tg := tree.find_item_at_position (wel_point.x, wel_point.y).interface
						end
					end
				end
				if tg = Void then
					tg := widget_pointed.interface
				end
				global_pnd_targets.start
				global_pnd_targets.search (tg.object_id)
				if not global_pnd_targets.exhausted then
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
			pnd_screen.draw_segment (pick_x, pick_y, old_pointer_x, old_pointer_y)
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

--|----------------------------------------------------------------
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
--|----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| this file now contains EV_PICK_AND_DROPABLE. This now replaces EV_PND_SOURCE, EV_PND_TARGET and EV_PND_TRANSPORTER.
--|
--| Revision 1.8.8.1.2.1  1999/11/24 17:30:19  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
