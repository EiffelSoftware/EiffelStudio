indexing
	description: 
		"Eiffel Vision application. Implementation interface.%N%
		%See ev_application.e"
	status: "See notice at end of class"
	keywords: "application"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_APPLICATION_I

inherit
	EV_ANY_I
		redefine
			interface
		end
			
feature {EV_APPLICATION} -- Initialization
	
	initialize is
			-- Create pick and drop target list.
		do
			create pnd_targets.make
			create internal_idle_actions
			is_initialized := True
		end

	launch is
			-- Start the event loop.
		deferred
		end

feature -- Access

	pnd_targets: LINKED_LIST [INTEGER] 
		-- Global list of pick and drop target object ids.

feature -- Basic operation

	process_events is
			-- Process any pending events.
			-- Pass control to the GUI toolkit so that it can
			-- handle any events that may be in its queue.
		deferred
		end

	sleep (msec: INTEGER) is
			-- Wait for `msec' milliseconds and return.
		require
			msec_non_negative: msec >= 0 
		deferred
		end

feature -- Events

	internal_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when no events are in queue.

feature -- Event handling

	accelerator_actions (an_accelerator: EV_ACCELERATOR):
		EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `an_accelerator' key sequence is
			-- pressed.
		do
			-- FIXME implement this!!
			create Result
		ensure
			not_void: Result /= Void
		end

feature -- Root windows management

	root_windows: ARRAYED_LIST [EV_WINDOW] is
			-- List of the root windows
		once
			create Result.make (0)
		ensure
			not_void: Result /= Void
		end

	add_root_window (a_window: EV_WINDOW) is
			-- Add `a_window' to the `root_windows'.
		require
			a_window_not_void: a_window /= Void
		deferred
		ensure
			a_window_added: root_windows.has (a_window)
		end

	remove_root_window (a_window: EV_WINDOW) is
			-- Remove `a_window' from the root windows list.
		require
			a_window_not_void: a_window /= Void
			a_window_is_a_root_window: root_windows.has (a_window)
		deferred
		ensure
			a_window_removed: not root_windows.has (a_window)
		end

feature -- Status report

	tooltip_delay: INTEGER is
			-- Time in milliseconds before tooltips pop up.
		deferred
		end

feature -- Status setting

	set_tooltip_delay (a_delay: INTEGER) is
			-- Set `tooltip_delay' to `a_delay'.
		require
			a_delay_non_negative: a_delay >= 0
		deferred
		ensure
			assigned: tooltip_delay = a_delay
		end

feature -- Implementation

	interface: EV_APPLICATION
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	root_windows_not_void: root_windows /= void
	internal_idle_actions_not_void: is_useable implies
		internal_idle_actions /= Void

end -- class EV_APPLICATION_I

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
--| Revision 1.11  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.16  2000/02/04 04:15:55  oconnor
--| release
--|
--| Revision 1.10.6.15  2000/01/28 21:16:58  brendel
--| Added feature `tooltip_delay'.
--|
--| Revision 1.10.6.14  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.13  2000/01/26 18:08:51  brendel
--| Added feature `sleep'.
--|
--| Revision 1.10.6.12  2000/01/21 18:20:19  oconnor
--| added stub for accelertor_actions
--|
--| Revision 1.10.6.11  2000/01/20 17:36:19  king
--| Added idle_actions and internal_idle_actions.
--|
--| Revision 1.10.6.10  1999/12/16 09:20:18  oconnor
--| provide user access to root windows list
--|
--| Revision 1.10.6.9  1999/12/15 05:21:11  oconnor
--| formatting
--|
--| Revision 1.10.6.8  1999/12/15 03:58:46  oconnor
--| use weak refs for global PND list
--|
--| Revision 1.10.6.7  1999/12/14 16:52:56  oconnor
--| renamed EV_PND_SOURCE -> EV_PICK_AND_DROPABLE
--|
--| Revision 1.10.6.6  1999/12/13 19:40:59  oconnor
--| added pnd_targets: LINKED_LIST [EV_PND_TARGET], global list of pnd targets
--|
--| Revision 1.10.6.5  1999/12/07 20:46:36  oconnor
--| revised layout and comments
--|
--| Revision 1.10.6.4  1999/12/03 04:09:24  brendel
--| Added is_initialized as postcondition to initialize.
--|
--| Revision 1.10.6.3  1999/12/01 00:04:41  brendel
--| Deffered -> deferred.
--|
--| Revision 1.10.6.2  1999/11/30 23:55:22  oconnor
--| added process events
--|
--| Revision 1.10.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.4  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.3  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
