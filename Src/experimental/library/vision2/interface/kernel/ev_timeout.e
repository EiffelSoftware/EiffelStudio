note
	description:
		"Repeatedly executes a sequence of `actions' at a regular `interval'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "timout, delay, timer, background"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_interval

feature {NONE} -- Initialization

	make_with_interval (an_interval: INTEGER)
			-- Create with `an_interval' in milliseconds.
		require
			an_interval_not_negative: an_interval >= 0
		do
			default_create
			set_interval (an_interval)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `actions' in milliseconds.
			-- If 0, then `actions' are disabled.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.interval
		ensure
			bridge_ok: Result = implementation.interval
		end

	actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions to be performed at a regular `interval'.
		-- Only called when `interval' is greater than 0.

feature -- Status report

	count: INTEGER
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

	set_interval (an_interval: INTEGER)
			-- Assign `an_interval' in milliseconds to `interval'.
			-- If `an_interval' is 0, `actions' are disabled.
		require
			not_destroyed: not is_destroyed
			an_interval_not_negative: an_interval >= 0
		do
			implementation.set_interval (an_interval)
		ensure
			interval_assigned: interval = an_interval
			count_not_changed: count = old count
		end

	reset_count
			-- Set `count' to 0.
		require
			not_destroyed: not is_destroyed
		do
			implementation.reset_count
		ensure
			count_is_zero: count = 0
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and (
				interval = 0 and
				count = 0
			)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TIMEOUT_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do
			create actions
		end

	create_implementation
			-- Create implementation of button.
		do
			create {EV_TIMEOUT_IMP} implementation.make
		end

invariant
	interval_not_negative: interval >= 0
	count_not_negative: count >= 0
	actions_not_void: actions /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TIMEOUT








