indexing
	description:
		"Eiffel Vision timeout. Repeatedly executes a sequence of `actions'%N%
		%at a regular `interval'."
	status: "See notice at end of class"
	keywords: "timout, delay, timer, background"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT

inherit
	EV_ANY
		redefine
			implementation,
			create_action_sequences,
			is_in_default_state
		end

create
	default_create,
	make_with_interval

feature -- Initialization

	make_with_interval (an_interval: INTEGER) is
			-- Create with `an_interval' in milliseconds.
		require
			an_interval_not_negative: an_interval >= 0
		do
			default_create
			set_interval (an_interval)
		end

feature -- Access

	interval: INTEGER is
			-- Time between calls to `actions' in milliseconds.
			-- Zero when disabled.
		do
			Result := implementation.interval
		ensure
			bridge_ok: Result = implementation.interval
		end

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		require
			an_interval_not_negative: an_interval >= 0
		do
			implementation.set_interval (an_interval)
		ensure
			interval_assigned: interval = an_interval
			count_not_changed: count = old count
		end

feature -- Status report

	count: INTEGER is
			-- Number of times `actions' have been called.
		do
			Result := implementation.count
		ensure
			bridge_ok: Result = implementation.count
		end

feature -- Status setting

	reset_count is
			-- Set `count' to 0.
		do
			implementation.reset_count
		ensure
			count_is_zero: count = 0
		end

feature -- Event handling

	actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed at a regular `interval'.

feature {EV_ANY_I} -- Implementation

	implementation: EV_TIMEOUT_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_action_sequences is
			-- Create action sequences for button.
		do
			{EV_ANY} Precursor
			create actions
		end

	create_implementation is
			-- Create implementation of button.
		do
			create {EV_TIMEOUT_IMP} implementation.make (Current)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default sate.
		do
			Result := {EV_ANY} Precursor and (
				interval = 0 and
				count = 0
			)
		end

invariant
	interval_not_negative: interval >= 0
	count_not_negative: count >= 0
	actions_not_void: actions /= Void

end -- class EV_TIMEOUT

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
--| Revision 1.3  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.7  2000/01/28 20:02:21  oconnor
--| released
--|
--| Revision 1.2.6.6  2000/01/27 19:30:45  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.5  2000/01/19 07:59:25  oconnor
--| renamed timeout_actions -> actions
--|
--| Revision 1.2.6.4  2000/01/19 07:55:32  oconnor
--| added default state checking, reorganised count, added resent_count.
--|
--| Revision 1.2.6.3  2000/01/18 19:30:58  king
--| Updated comments, added count invariant and postcondition to guide
--| implementation on Win32
--|
--| Revision 1.2.6.2  2000/01/18 01:05:39  king
--| Implemented to use action sequence
--|
--| Revision 1.2.6.1  1999/11/24 17:30:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.2.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

