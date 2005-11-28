indexing
	description:
		"A delayed action operation."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DELAYED_ACTION

create
	make

feature {NONE} -- Initialization

	make (	a_delayed_action: like delayed_action;
			a_delay: like delay
			) is
		require
			a_delayed_action /= Void
			a_delay >= 0
		do
			delayed_action := a_delayed_action
			delay := a_delay
		ensure
			delayed_action = a_delayed_action
			delay = a_delay
		end

feature -- Changes

	set_delayed_action (v: like delayed_action) is
		do
			delayed_action := v
		end

	set_delay (d: like delay) is
		do
			delay := d
		end

	set_starting_delayed_action (v: like starting_delayed_action) is
		do
			starting_delayed_action := v
		end

	set_ending_delayed_action (v: like ending_delayed_action) is
		do
			ending_delayed_action := v
		end

feature -- Delayed action access

	delayed_action_exists: BOOLEAN is
		do
			Result := delayed_action /= Void
		end

	call is
		require
			delayed_action_exists: delayed_action_exists
		do
			cancel
			delayed_action.call (Void)
		ensure
			delayed_action_timer_destroyed: delayed_action_timer = Void
		end

	request_call is
		require
			delayed_action_exists: delayed_action_exists
		do
			if delay = 0 then
				call
			elseif delayed_action_timer = Void then
				if starting_delayed_action /= Void then
					starting_delayed_action.call ([])
				end
				create delayed_action_timer.make_with_interval (delay)
				delayed_action_timer.actions.extend (agent call)
			end
		ensure
			delayed_action_timer_created: delay >0 implies delayed_action_timer /= Void
		end

	cancel is
		require
			delayed_action_exists: delayed_action_exists
		do
			if delayed_action_timer /= Void then
				delayed_action_timer.actions.wipe_out
				delayed_action_timer.destroy
				delayed_action_timer := Void
				if ending_delayed_action /= Void then
					ending_delayed_action.call ([])
				end
			end
		ensure
			delayed_action_timer_destroyed: delayed_action_timer = Void
		end

feature {NONE} -- Delayed cleaning implementation

	delay: INTEGER
			-- Number of milliseconds waited before clearing grid
			-- By waiting for a short period of time, the flicker is removed

	starting_delayed_action: PROCEDURE [ANY, TUPLE]
	ending_delayed_action: PROCEDURE [ANY, TUPLE]

	delayed_action: PROCEDURE [ANY, TUPLE]

	delayed_action_timer: EV_TIMEOUT

end
