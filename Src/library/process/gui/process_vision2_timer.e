indexing
	description: "Process status listening timer implemented with Vision2 timer."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_VISION2_TIMER

inherit
	PROCESS_TIMER

	EXECUTION_ENVIRONMENT

create
	make

feature{NONE} -- Implementation

	make (interval: INTEGER) is
			-- Set time interval which this timer will be triggered with `interval'.
			-- Unit of `interval' is milliseconds.
		require
			interval_positive: interval > 0
		do
			sleep_time := interval
			create timer.default_create
			timer.destroy
		ensure
			sleep_time_set: sleep_time = interval
			destroyed_set: destroyed = True
		end

feature -- Control

	start is
		local
			prc_imp: PROCESS_IMP
		do
			prc_imp ?= process_launcher
			check
				prc_imp /= Void
			end
			create timer.make_with_interval (sleep_time)
			timer.actions.extend (agent prc_imp.check_exit)
			has_started := True
		end

	wait (a_timeout: INTEGER): BOOLEAN is
		local
			l_sleep_time: INTEGER_64
			prc_imp: PROCESS_IMP
			l_timeout: BOOLEAN
			l_start_time: DATE_TIME
			l_now_time: DATE_TIME
		do
			if not destroyed then
				prc_imp ?= process_launcher
				check prc_imp /= Void end
				destroy
				if a_timeout > 0 then
					create l_start_time.make_now
				end
				from
					l_sleep_time := sleep_time * 1000000
				until
					prc_imp.has_exited or l_timeout
				loop
					prc_imp.check_exit
					if not prc_imp.has_exited then
						if a_timeout > 0 then
							create l_now_time.make_now
							if l_now_time.relative_duration (l_start_time).fine_seconds_count * 1000 > a_timeout then
								l_timeout := True
								start
							else
								sleep (l_sleep_time)
							end
						else
							sleep (l_sleep_time)
						end
					end
				end
				Result := not l_timeout
			else
				Result := True
			end
		end

	destroy is
		do
			timer.destroy
		end

	destroyed: BOOLEAN is
		do
			Result := timer.is_destroyed
		end

feature{NONE} -- Implementation

	timer: EV_TIMEOUT
			-- Internal Vision2 Timer

invariant
	timer_not_void: timer /= Void

end
