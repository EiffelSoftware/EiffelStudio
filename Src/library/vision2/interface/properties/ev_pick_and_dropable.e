indexing
	description:
		"Eiffel Vision pick and drop mechanism.%N%
		%Decendents can act as both pick and drop sources and targets.%N%
		%When the user picks a `pebble' from a source and drops on a target,%N%
		%the `drop_actions' of the target receive the `pebble' as input.%N%
		%The user interface can be either pick and drop or drag and drop,%N%
		%selected by `set_pick_and_drop' and `set_drag_and_drop'."
	example:
		"Create two buttons one with the string %"Hello world!%" as pebble%N%
		%and the other with io~put_string as a drop action.%N%
		%Picking the first button and dropping on the second will print%N%
		%%"Hello world!%".%N%
		%b1, b2: BUTTON%N%
		%create b1; create b2%N%
		%b1.set_pebble (%"Hello world!%")%N%
		%b2.drop_actions.extend (io~put_string)"
	status: "See notice at end of class"
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE

inherit
	EV_ANY
		redefine
			create_action_sequences,
			implementation
		end

	IDENTIFIED
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Access

	pebble: ANY is
			-- Data to be transported by pick and drop mechanism.
		do
			Result := implementation.pebble
		ensure
			bridge_ok: Result = implementation.pebble
		end

feature -- Status setting

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		do
			implementation.set_pebble (a_pebble)
		ensure
			pebble_assigned: pebble = a_pebble
		end

	remove_pebble is
			-- Remove `pebble'.
		do
			implementation.remove_pebble
		ensure
			pebble_removed: pebble = Void
		end

	set_pick_and_drop_mode is
			-- Set user interface mode to pick and drop,
		do
			implementation.set_pick_and_drop_mode
		ensure
			mode_is_pick_and_drop: mode_is_pick_and_drop 
		end

	set_drag_and_drop_mode is
			-- Set user interface mode to drag and drop,
		do
			implementation.set_drag_and_drop_mode
		ensure
			mode_is_drag_and_drop: mode_is_drag_and_drop 
		end

	set_pebble_position (a_x, a_y: INTEGER) is
			-- Set the initial position for pick and drop in screen pixels.
		require
			a_x_non_negative: a_x >= 0
			a_y_non_negative: a_y >= 0
		do
			implementation.set_pebble_position (a_x, a_y)
		end

	set_accept_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			implementation.set_accept_cursor (a_cursor)
		end

	set_deny_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		do
			implementation.set_deny_cursor (a_cursor)
		end

feature -- Status report

	mode_is_pick_and_drop: BOOLEAN is
			-- Is the user interface mode pick and drop?
		do
			Result := implementation.mode_is_pick_and_drop
		ensure
			bridge_ok: Result = implementation.mode_is_pick_and_drop
		end

	mode_is_drag_and_drop: BOOLEAN is
			-- Is the user interface mode drag and drop?
		do
			Result := implementation.mode_is_drag_and_drop
		ensure
			bridge_ok: Result = implementation.mode_is_drag_and_drop
		end

feature -- User input events

	pick_actions: EV_PND_START_ACTION_SEQUENCE
		-- Actions to be performed when `pebble' is picked up.

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed when a pebble that fits this hole is
		-- picked up from another source.
		-- (when drop_actions.accepts_pebble (pebble))

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		deferred
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to take when pick and drop transport drops on `Current'.

feature -- Implementation

	create_action_sequences is
			-- Create pick and drop action sequences.
		do
			create pick_actions
			create conforming_pick_actions
			create drop_actions
			drop_actions.set_source_connection_agent (
				((create {EV_ENVIRONMENT}).application.
					implementation.pnd_targets)~extend (object_id)
			)
		end

feature {EV_APPLICATION_I, EV_PICK_AND_DROPABLE_I} -- Implementation

	implementation: EV_PICK_AND_DROPABLE_I
            -- Responsible for interaction with the underlying native graphics
			-- toolkit.

invariant
	user_interface_modes_mutually_exclusive:
		mode_is_pick_and_drop /= mode_is_drag_and_drop
	pick_actions_not_void: pick_actions /= Void
	conforming_pick_actions_not_void: conforming_pick_actions /= Void
	drop_actions_not_void: drop_actions /= Void

end -- class EV_PICK_AND_DROPABLE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| Revision 1.2  2000/02/14 12:05:13  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.4  2000/02/04 02:08:24  oconnor
--| added conforming_pick_actions
--|
--| Revision 1.1.2.3  2000/01/28 20:00:10  oconnor
--| released
--|
--| Revision 1.1.2.2  2000/01/27 19:30:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.1  2000/01/24 23:04:45  oconnor
--| removed pick_and_drop/ev_pnd_source.e, contents now in properties/ev_pick_and_dropable.e
--|
--| Revision 1.10.4.1.2.10  2000/01/24 23:02:49  oconnor
--| comments
--|
--| Revision 1.10.4.1.2.9  2000/01/07 01:00:25  king
--| Corrected spelling mistake in invariant
--|
--| Revision 1.10.4.1.2.8  1999/12/15 03:59:50  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.10.4.1.2.7  1999/12/15 00:25:31  oconnor
--| fixed broken contracts on set_pebble
--|
--| Revision 1.10.4.1.2.6  1999/12/14 18:56:41  oconnor
--| simplified API
--|
--| Revision 1.10.4.1.2.5  1999/12/14 16:41:38  oconnor
--| removed enable/disable_transport
--| improved comments
--|
--| Revision 1.10.4.1.2.4  1999/12/13 19:31:13  oconnor
--| kernel/ev_application.e
--|
--| Revision 1.10.4.1.2.3  1999/12/09 01:31:09  oconnor
--| king: added feature enable_drag_and_drop, fixed desactivate -> deactivate
--|
--| Revision 1.10.4.1.2.2  1999/11/24 22:40:24  oconnor
--| added review notes
--|
--| Revision 1.10.4.1.2.1  1999/11/24 17:30:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
