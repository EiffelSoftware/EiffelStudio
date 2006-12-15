indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_TIMER

inherit
	ANY
		redefine default_create end

feature {NONE} -- Initialization

	default_create is
			-- Create Current debugger timer
		do
			Precursor
			create ev_timer
		end

feature -- Access

	interval: INTEGER is
		do
			Result := ev_timer.interval
		end

	actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed at a regular interval.
			-- Only called when interval is greater than 0.	
		do
			Result := ev_timer.actions
		end

feature -- Change

	set_interval (i: like interval) is
		do
			ev_timer.set_interval (i)
		end

feature {NONE} -- Implementation

	ev_timer: EV_TIMEOUT

invariant
	ev_timer /= Void

end
