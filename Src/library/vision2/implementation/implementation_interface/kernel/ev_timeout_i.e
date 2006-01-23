indexing
	description:
		"Eiffel Vision timeout. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TIMEOUT_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	interval: INTEGER is
			-- Time between calls to `interface.actions' in milliseconds.
			-- Zero when disabled.
		deferred
		end

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		require
			an_interval_not_negative: an_interval >= 0
		deferred
		ensure
			interval_assigned: interval = an_interval
		end

feature -- Status report

	count: INTEGER
			-- Number of times `interface.actions' has been called.

feature -- Status setting

	reset_count is
			-- Set `count' to 0.
		do
			count := 0
		ensure
			count_is_zero: count = 0
		end

feature -- Implementation

	on_timeout is
			-- Call actions and increment count.
		do
			interface.actions.call (Void)
			count := count + 1
		ensure
			count_incremented_or_reset:
				count = old count + 1 or else count = 1
		end

feature {EV_ANY_I} --Implementation

	interface: EV_TIMEOUT
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	interval_not_negative: interval >= 0
	count_not_negative: count >= 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TIMEOUT_I

