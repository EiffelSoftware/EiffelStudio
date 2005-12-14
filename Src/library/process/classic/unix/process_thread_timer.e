indexing
	description: "Process status listening timer implemented with thread."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_THREAD_TIMER

inherit
	PROCESS_TIMER

	THREAD

create
	make

feature {NONE} -- Implementation

	make (interval: INTEGER) is
			-- Set time interval which this timer will be triggered with `interval'.
			-- Unit of `interval' is milliseconds.
		require
			interval_positive: interval > 0
		do
			time_interval := interval.to_integer_64 * 1000000
			create mutex
			has_started := False
		ensure
			time_interval_set: time_interval = interval.to_integer_64 * 1000000
			destroyed_set: destroyed = True
		end

feature -- Control

	destroy is
		do
			should_destroy := True
		end

	start is
		do
			launch
			has_started := True
			should_destroy := False
		end

	destroyed: BOOLEAN is
			--
		do
			mutex.lock
			Result := (not has_started) or (has_started and then terminated)
			mutex.unlock
		end


feature {NONE} -- Implementation

	execute is
		local
			prc_imp: PROCESS_IMP
		do
			prc_imp ?= process_launcher
			from

			until
				should_destroy
			loop
				prc_imp.check_exit
				if not should_destroy then
					sleep (time_interval)
				end
			end
		end

feature{NONE} -- Implementation

	has_started: BOOLEAN
			-- Has this timer started yet?

	should_destroy: BOOLEAN
			-- Should this timer be destroyed?

	mutex: MUTEX
			-- Internal mutex

invariant

	mutex_not_void: mutex /= Void

end
