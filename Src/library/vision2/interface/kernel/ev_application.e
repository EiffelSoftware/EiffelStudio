indexing
	description: 
		"Eiffel Vision application.%N%
		%Base class for every Eiffel Vision application.%N%
		%Applications should inherit this class and implement prepare and%N%
		%first_window. `make_and_launch' will construct the application%N%
		%object, call `prepare', open the `first_window' and start%N%
		%proccessing events."
	status: "See notice at end of class"
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_APPLICATION

inherit
	EV_ANY
		redefine
			create_action_sequences,
			implementation
		end

feature {NONE} -- Initialization

	make_and_launch is
			-- Create and launch application.
		do
			default_create
			launch
		end

	create_action_sequences is
			-- Create the post launch action sequence.
		do
			create post_launch_actions
			create pick_actions
			create drop_actions
			create idle_actions
		end

	prepare is
			-- Do pre-launch preperation.
			-- Called by `launch' just before starting the application.
			-- Should be implemented to prepare the application for launch.
		deferred
		end

feature -- Access
	
	first_window: EV_WINDOW is
			-- Must be defined as a once funtion to create
			-- the application's first_window.
		deferred
		ensure
			top_level_window: Result.parent = Void
		end

feature -- Basic operation

	launch is
			-- Start the application.
			-- (Begin event processing.)
		require
			post_launch_actions_not_void: post_launch_actions /= Void
			not_already_launched: not is_launched
		do
			is_launched := True
			prepare
			post_launch_actions.extend (~remove_post_launch_actions)
			implementation.launch
		ensure
			is_launched: is_launched
		end

	process_events is
			-- Process any pending events.
			-- Pass control to the underlying native toolkit so that it can
			-- handle any events that may be in its queue.
			-- (Should be called from time to time during extended computation.)
		require
			is_launched: is_launched
		do
			implementation.process_events
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		require
			msec_non_negative: msec >= 0 
		do
			implementation.sleep (msec)
		end

feature -- Status report

	is_launched: BOOLEAN
			-- Has `launch' been called?

	tooltip_delay: INTEGER is
			-- Time in milliseconds before tooltips pop up.
		do
			Result := implementation.tooltip_delay
		ensure
			bridge_ok: Result = implementation.tooltip_delay
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		require
			a_delay_non_negative: a_delay >= 0
		do
			implementation.set_tooltip_delay (a_delay)
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Event handling

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed as after the application is launched.

	pick_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when a pick and drop "pick" occurs.

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when a pick and drop "drop" occurs.

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions be performed take when the application is otherwise idle.

	accelerator_actions (an_accelerator: EV_ACCELERATOR): 
		 EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `an_accelerator' key sequence is
			-- pressed.
		do
			Result := implementation.accelerator_actions (an_accelerator)
		ensure
			not_void: Result /= Void
		end

feature -- Root window management

	add_root_window (a_window: EV_WINDOW) is
			-- Add `a_window' to the `root_windows'.
		require
			a_window_not_void: a_window /= Void
		do
			implementation.add_root_window (a_window)
		ensure
			a_window_is_root_window: is_root_window (a_window)
		end

	is_root_window (a_window: EV_WINDOW): BOOLEAN is
			-- Is `a_window' a root window?
		require
			a_window_not_void: a_window /= Void
		do
			Result := implementation.root_windows.has (a_window)
		ensure
			implementation_root_window_has_a_window:
				Result = implementation.root_windows.has (a_window)
		end

	remove_root_window (a_window: EV_WINDOW) is
			-- Remove `a_window' from the root windows list.
		require
			a_window_not_void: a_window /= Void
			a_window_is_root_window: is_root_window (a_window)
		do
			implementation.remove_root_window (a_window)
		ensure
			not_a_window_is_root_window: not is_root_window (a_window)
		end

feature {EV_WINDOW, EV_PICK_AND_DROPABLE, EV_PICK_AND_DROPABLE_I}
		-- Implementation
	
	implementation: EV_APPLICATION_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit. (See bridge pattern notes in ev_any.e)

	create_implementation is
			-- Create implementation of button
		do
			(create {EV_ENVIRONMENT}).set_application (Current)
			create {EV_APPLICATION_IMP} implementation.make (Current)
		end

feature {NONE} -- Implementation

	remove_post_launch_actions is
			-- Remove the `post_launch_actions (They are only needed once).
		do
			post_launch_actions := Void
		end

invariant
	pick_actions_not_void: pick_actions /= Void
	drop_actions_not_void: drop_actions /= Void
	idle_actions_not_void: idle_actions /= Void
	first_window_not_void: is_initialized implies first_window /= Void
	tooltip_delay_non_negative: tooltip_delay >= 0

end -- class EV_APPLICATION

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
--| Revision 1.11  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.19  2000/01/28 21:16:59  brendel
--| Added feature `tooltip_delay'.
--|
--| Revision 1.10.6.18  2000/01/28 20:02:20  oconnor
--| released
--|
--| Revision 1.10.6.17  2000/01/27 19:30:40  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.16  2000/01/26 18:08:51  brendel
--| Added feature `sleep'.
--|
--| Revision 1.10.6.15  2000/01/21 18:20:00  oconnor
--| fixed accelerator_actions
--|
--| Revision 1.10.6.14  2000/01/21 18:16:07  oconnor
--| added accelerator_actions for keyboard accelerators
--|
--| Revision 1.10.6.13  2000/01/21 00:47:32  oconnor
--| cosmetics
--|
--| Revision 1.10.6.12  2000/01/20 17:36:19  king
--| Added idle_actions and internal_idle_actions.
--|
--| Revision 1.10.6.11  1999/12/17 21:03:49  rogers
--| addition of drop actions.
--|
--| Revision 1.10.6.10  1999/12/16 09:20:18  oconnor
--| provide user access to root windows list
--|
--| Revision 1.10.6.9  1999/12/15 05:21:12  oconnor
--| formatting
--|
--| Revision 1.10.6.8  1999/12/15 03:57:22  oconnor
--| export implementation to EV_PICK_AND_DROPABLE
--|
--| Revision 1.10.6.7  1999/12/14 16:52:57  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.10.6.6  1999/12/13 19:31:13  oconnor
--| kernel/ev_application.e
--|
--| Revision 1.10.6.5  1999/12/08 01:47:51  oconnor
--| export remove_post_launch_actions to none
--|
--| Revision 1.10.6.4  1999/12/07 20:46:36  oconnor
--| revised layout and comments
--|
--| Revision 1.10.6.3  1999/12/01 00:36:09  oconnor
--| added precondition
--|
--| Revision 1.10.6.2  1999/11/30 23:41:31  oconnor
--| added process events
--|
--| Revision 1.10.6.1  1999/11/24 17:30:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.5  1999/11/04 23:07:47  oconnor
--| reorganised
--|
--| Revision 1.10.2.4  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
