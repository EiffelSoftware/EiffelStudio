indexing
	description:
		"Repeatedly executes a sequence of `actions' at a regular `interval'."
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
			initialize,
			is_in_default_state
		end

create
	default_create,
	make_with_interval

feature {NONE} -- Initialization

	make_with_interval (an_interval: INTEGER) is
			-- Create with `an_interval' in milliseconds.
		require
			an_interval_not_negative: an_interval >= 0
		do
			default_create
			set_interval (an_interval)
		end
		
	initialize is
			-- Create action sequence.
		do
			create actions
			is_initialized := True
		end

feature -- Access

	interval: INTEGER is
			-- Time between calls to `actions' in milliseconds.
			-- Zero when disabled.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.interval
		ensure
			bridge_ok: Result = implementation.interval
		end

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		require
			not_destroyed: not is_destroyed
			an_interval_not_negative: an_interval >= 0
		do
			implementation.set_interval (an_interval)
		ensure
			interval_assigned: interval = an_interval
			count_not_changed: count = old count
		end

	actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed at a regular `interval'.

feature -- Status report

	count: INTEGER is
			-- Number of times `actions' have been called since last
			-- call to `reset_count'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.count
		ensure
			bridge_ok: Result = implementation.count
		end

feature -- Status setting

	reset_count is
			-- Set `count' to 0.
		require
			not_destroyed: not is_destroyed
		do
			implementation.reset_count
		ensure
			count_is_zero: count = 0
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default sate.
		do
			Result := Precursor {EV_ANY} and (
				interval = 0 and
				count = 0
			)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TIMEOUT_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of button.
		do
			create {EV_TIMEOUT_IMP} implementation.make (Current)
		end

invariant
	interval_not_negative: interval >= 0
	count_not_negative: count >= 0
	actions_not_void: actions /= Void

end -- class EV_TIMEOUT

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
