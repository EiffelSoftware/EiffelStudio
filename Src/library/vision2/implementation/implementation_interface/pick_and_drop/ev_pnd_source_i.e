indexing
	description:
		"Implementation interface for pick and drop.%N%
		%See ev_pick_and_dropable.e"
	status: "See notice at end of class"
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access
	
	pebble: ANY
			-- Data to be transported by pick and drop mechanism.

	pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by pick and drop mechanism.

	pick_x,
	pick_y: INTEGER
			-- Initial point for the pick and drop

feature -- Status setting

	set_pebble_position (a_x, a_y: INTEGER) is
			-- Set the initial position for pick and drop in screen pixels.
		require
			a_x_non_negative: a_x >= 0
			a_y_non_negative: a_y >= 0
		do
			pick_x := a_x
			pick_y := a_y
		ensure
			pick_x_assigned: pick_x = a_x
			pick_y_assigned: pick_y = a_y
		end

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		do
			pebble_function := Void
			pebble := a_pebble
			enable_transport
			-- Data to be transported by pick and drop mechanism.
		ensure
			pebble_assigned: pebble = a_pebble
			is_transport_enabled: is_transport_enabled
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE [], ANY]) is
			-- Assign `a_funtion' to `pebble_funtion'.
		require
			a_function_not_void: a_function /= Void
		do
			pebble := Void
			pebble_function := a_function
			enable_transport
		ensure
			pebble_funtion_assigned: pebble_function = a_function
			is_transport_enabled: is_transport_enabled
		end

	remove_pebble is
			-- Remove `pebble'
		do
			pebble := Void
			pebble_function := Void
			disable_transport
		ensure
			pebble_removed: pebble = Void and pebble_function = Void
			is_transport_disabled: not is_transport_enabled
		end

	enable_transport is
            -- Activate pick/drag and drop mechanism.
		require
			pebble_not_void: pebble /= Void or pebble_function /= Void
		deferred
		ensure
			is_transport_enabled: is_transport_enabled
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		deferred
		ensure
			is_transport_disabled: not is_transport_enabled
		end

	set_pick_and_drop_mode is
			-- Set transport mechanism to pick and drop,
		do
			user_interface_mode := pick_and_drop_mode
		ensure
			mode_is_pick_and_drop: mode_is_pick_and_drop
		end

	set_drag_and_drop_mode is
			-- Set transport mechanism to drag and drop,
		do
			user_interface_mode := drag_and_drop_mode
		ensure
			mode_is_drag_and_drop: mode_is_drag_and_drop
		end

	set_target_menu_mode is
			-- Set transport mechanism to target_menu.
		do
			user_interface_mode := target_menu_mode
		ensure
			mode_is_target_menu: mode_is_target_menu
		end

	set_accept_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			accept_cursor := a_cursor
		end 

	set_deny_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that doesn't accept `pebble' during pick and drop.
		do
			deny_cursor := a_cursor
		end

feature -- Status report

	is_transport_enabled: BOOLEAN
			-- Is the transport mechanism enabled?

	mode_is_pick_and_drop: BOOLEAN is
			-- Is the transport mechanism pick and drop?
		do
			Result := user_interface_mode = pick_and_drop_mode
		end

	mode_is_drag_and_drop: BOOLEAN is
			-- Is the transport mechanism drag and drop?
		do
			Result := user_interface_mode = drag_and_drop_mode
		end

	mode_is_target_menu: BOOLEAN is
			-- Is the transport mechanism target menu?
		do
			Result := user_interface_mode = target_menu_mode
		end

feature {EV_ANY_I} -- Implementation

	user_interface_mode: INTEGER
			-- Transport user interface mode.
	
	pick_and_drop_mode: INTEGER is 0
	drag_and_drop_mode: INTEGER is 1
	target_menu_mode: INTEGER is 2

	start_transport (
        a_x, a_y, a_button: INTEGER;
        a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        a_screen_x, a_screen_y: INTEGER)
	 is
			-- Start a pick and drop transport.
		deferred
		end

	end_transport (a_x, a_y, a_button: INTEGER) is
			-- Terminate the pick and drop mechanism.
		deferred
		ensure
			last_pointed_target_is_void: last_pointed_target = Void
		end

	pointer_x,
	pointer_y: INTEGER
		-- Destination screen position.


	over_valid_target: BOOLEAN
			-- Is the cursor over a target that accepts `pebble'?

	accept_cursor: EV_CURSOR
		-- Accept cursor set by user.
		-- To be displayed when the screen pointer is over a target that accepts
		-- `pebble' during pick and drop.

	deny_cursor: EV_CURSOR
		-- Deny cursor set by user.
		-- To be displayed when the screen pointer is not over a valid target.

	default_accept_cursor: EV_CURSOR is
			-- Used in lieu of a user defined `accept_cursor'.
		once
			Result := Default_pixmaps.Standard_cursor
		end

	default_deny_cursor: EV_CURSOR is
			-- Used in lieu of a user defined `deny_cursor'.
		once
			Result := Default_pixmaps.No_cursor
		end
	
	execute (
			a_x, a_y: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Executed when `pebble' is being moved.
			-- Draw a rubber band from pick position to pointer position.
		require
			accept_cursor_not_void: default_accept_cursor /= Void
			deny_cursor_not_void: default_deny_cursor /= Void
		local
			target: EV_PICK_AND_DROPABLE
		do
			draw_rubber_band
			pointer_x := a_screen_x
			pointer_y := a_screen_y
			target := pointed_target

			if
				target /= Void and then (
					target.drop_actions.accepts_pebble (pebble)
				)
			then
				over_valid_target := True
				last_pointed_target := target
				if accept_cursor /= Void then
					set_pointer_style (accept_cursor)
				else
					set_pointer_style (default_accept_cursor)
				end
			else
				if deny_cursor /= Void then
					set_pointer_style (deny_cursor)
				else
					set_pointer_style (default_deny_cursor)
				end
			end
		end

	pointed_target: EV_PICK_AND_DROPABLE is
			-- Target at mouse position
		deferred
		end

	last_pointed_target: EV_PICK_AND_DROPABLE
			-- Last target at mouse position

	draw_rubber_band  is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		deferred
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		deferred
		end

	rubber_band_is_drawn: BOOLEAN
			-- Is a rubber band line currently on the screen?

	global_pnd_targets: LINKED_LIST [INTEGER] is
			-- Shortcut to EV_APPLICATION.pnd_targets.
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result := env.application.implementation.pnd_targets
		end

feature {EV_WIDGET}

	set_pointer_style (c: EV_CURSOR) is
		deferred
		end

    enable_capture is
            -- Grab the user input.
        deferred
        end

    disable_capture is
            -- Ungrab the user input.
        deferred
        end

feature {NONE} -- Constants

	Default_pixmaps: EV_DEFAULT_PIXMAPS is
			-- Default pixmaps
		once
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PICK_AND_DROPABLE
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.

invariant
	user_interface_modes_mutually_exclusive:
		mode_is_pick_and_drop.to_integer +
		mode_is_drag_and_drop.to_integer +
		mode_is_target_menu.to_integer = 1
	is_transport_enabled_implies_pebble_not_void:
		is_transport_enabled implies pebble /= Void or pebble_function /= Void
	pebble_function_takes_two_integer_open_operands:
		pebble_function /= Void implies pebble_function.valid_operands ([1,1])

end -- class EV_PICK_AND_DROPABLE_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.25  2000/06/07 17:27:44  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.13.4.5  2000/05/30 16:22:47  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.13.4.4  2000/05/04 04:19:08  pichery
--| Replaced calls to EV_CURSOR_CODE with
--| calls to EV_DEFAULT_PIXMAPS
--|
--| Revision 1.13.4.3  2000/05/03 19:08:57  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/04/25 00:56:46  oconnor
--| added right click context menu UI for PND.
--|
--| Revision 1.23  2000/04/12 01:22:19  pichery
--| cosmetics
--|
--| Revision 1.22  2000/03/27 19:47:17  oconnor
--| added pebble_function support
--|
--| Revision 1.21  2000/03/21 18:45:00  rogers
--| Fixed pre-conditions on execute.
--|
--| Revision 1.20  2000/03/21 01:33:12  rogers
--| Fixed the changing of the mouse pointer within execute.
--|
--| Revision 1.19  2000/03/20 18:04:06  rogers
--| Added default_accept_cursor and default_deny_cursor.
--|
--| Revision 1.18  2000/03/17 23:09:53  rogers
--| Fixed execute. Added set_pointer_style.
--|
--| Revision 1.17  2000/02/22 18:39:41  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.16  2000/02/15 19:21:40  rogers
--| Changed the export status of implementation features to EV_ANY_I.
--|
--| Revision 1.15  2000/02/14 11:40:35  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.4.1.2.17  2000/02/04 04:00:19  oconnor
--| released
--|
--| Revision 1.13.4.1.2.16  2000/01/27 19:29:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.4.1.2.15  2000/01/21 19:12:05  king
--| Changed capture feature names to enable and disable
--|
--| Revision 1.13.4.1.2.14  1999/12/17 23:20:32  oconnor
--| formatting
--|
--| Revision 1.13.4.1.2.13  1999/12/15 17:45:37  oconnor
--| moved deferred set|release_capture to _I
--|
--| Revision 1.13.4.1.2.12  1999/12/15 04:24:19  oconnor
--| formatting
--|
--| Revision 1.13.4.1.2.11  1999/12/15 03:59:50  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.13.4.1.2.10  1999/12/15 00:35:52  oconnor
--| .drop_actions.accepts_data is now .drop_actions.accepts_pebble
--|
--| Revision 1.13.4.1.2.9  1999/12/15 00:33:07  oconnor
--| general code cleanup
--|
--| Revision 1.13.4.1.2.8  1999/12/14 18:56:42  oconnor
--| simplified API
--|
--| Revision 1.13.4.1.2.7  1999/12/14 16:45:33  oconnor
--| renamed to EV_PICK_AND_DROPABLE_I
--|
--| Revision 1.13.4.1.2.6  1999/12/13 19:43:18  oconnor
--| rewritten and merged with ev_pnd_transporter
--|
--| Revision 1.13.4.1.2.5  1999/12/09 19:05:40  oconnor
--| mid way through converting PND to new event system
--|
--| Revision 1.13.4.1.2.4  1999/12/09 02:38:37  oconnor
--| king: added is_drag_and_drop_enabled, set_to_drag_and_drop,
--| set_to_pick_and_drop
--|
--| Revision 1.13.4.1.2.3  1999/12/02 19:56:29  brendel
--| Commented out old event related features.
--|
--| Revision 1.13.4.1.2.2  1999/12/02 02:01:14  brendel
--| Commented out obsolete features.
--|
--| Revision 1.13.4.1.2.1  1999/11/24 17:30:06  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
