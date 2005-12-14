indexing
	description: "Process status listening timer implemented with Vision2 timer."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_VISION2_TIMER

inherit
	PROCESS_TIMER
create
	make

feature{NONE} -- Implementation

	make (interval: INTEGER_64) is
			-- Set time interval which this timer will be triggered with `interval'.
			-- Unit of `interval' is milliseconds.
		require
			interval_positive: interval > 0
		do
			time_interval := interval
			create timer.default_create
			timer.destroy
		ensure
			time_interval_set: time_interval = interval
			destroyed_set: destroyed = True
		end

feature -- Control

	start is
			--
		local
			prc_imp: PROCESS_IMP
		do
			prc_imp ?= process_launcher
			check
				prc_imp /= Void
			end
			create timer.make_with_interval (time_interval.to_integer)
			timer.actions.extend (agent prc_imp.check_exit)
		end

	destroy is
			--
		do
			if timer /= Void then
				timer.destroy
			end
		end

	destroyed: BOOLEAN is
			--
		do
			Result := timer.is_destroyed
		end

feature{NONE} -- Implementation

	timer: EV_TIMEOUT

invariant

	timer_not_void: timer /= Void

end
