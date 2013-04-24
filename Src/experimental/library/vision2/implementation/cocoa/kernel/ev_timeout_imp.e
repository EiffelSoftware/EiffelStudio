note
	description: "Eiffel Vision timeout. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I
		redefine
			interface,
			on_timeout
		end

	EV_ANY_IMP
		redefine
			interface,
			destroy
		end

create
	make

feature -- Initialization

	make
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `timeout_actions' in milliseconds.
			-- Zero when disabled.

	set_interval (an_interval: INTEGER)
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		do
			if attached timer as previous_timer then
				previous_timer.invalidate
				timer := Void
			end
			if an_interval > 0 then
				create timer.scheduled_timer (an_interval / 1000.0, agent on_timeout, Void, True)
			end
			interval := an_interval
		end

feature -- Implementation

	on_timeout
			-- Call the timeout actions.
		do
				-- Prevent nested calls by flagging intermediary to not call should a call be in progress.
			actions_called := True
			Precursor
			actions_called := False
		end

	actions_called: BOOLEAN
		-- Are the timeout actions in the process of being called.

	timer: detachable NS_TIMER

feature {EV_ANY, EV_ANY_I} -- Implementation

	destroy
			-- Render `Current' unusable.
		do
			set_interval (0)
			Precursor {EV_ANY_IMP}
		end

	interface: detachable EV_TIMEOUT note option: stable attribute end;
		-- Interface object.

end -- class EV_TIMEOUT_IMP
