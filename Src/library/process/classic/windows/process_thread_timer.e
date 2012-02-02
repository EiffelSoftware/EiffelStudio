note
	description: "Process status listening timer implemented with thread."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_THREAD_TIMER

inherit
	PROCESS_TIMER

	THREAD
		rename
			make as thread_make,
			sleep as obsolete_sleep
		end

	EXECUTION_ENVIRONMENT
		rename
			launch as execution_environment_launch
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (a_sleep_time: INTEGER)
			-- Set time interval which this timer will be triggered with `a_sleep_time'.
			-- Unit of `a_sleep_time' is milliseconds.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			interval_positive: a_sleep_time > 0
		do
			thread_make
			sleep_time := a_sleep_time
			create mutex.make
			has_started := False
		ensure
			sleep_time_set: sleep_time = a_sleep_time
			destroyed_set: destroyed = True
		end

feature -- Control

	start
		do
			mutex.lock
			should_destroy := False
			launch
			has_started := True
			mutex.unlock
		end

	destroy
		do
			mutex.lock
			should_destroy := True
			mutex.unlock
		end

	wait (a_timeout: INTEGER): BOOLEAN
		do
			if a_timeout = 0 then
				join
				Result := True
			else
				Result := join_with_timeout (a_timeout.to_natural_64)
			end
		end

	destroyed: BOOLEAN
		do
			mutex.lock
			Result := (not has_started) or (has_started and then terminated)
			mutex.unlock
		end

feature {NONE} -- Implementation

	execute
		local
			l_sleep_time: INTEGER_64
		do
			if attached {PROCESS_IMP} process_launcher as l_prc_imp then
				from
					l_sleep_time := sleep_time.to_integer_64 * one_millisecond_in_nanoseconds
				until
					should_destroy
				loop
					l_prc_imp.check_exit
					if not should_destroy then
						sleep (l_sleep_time)
					end
				end
			else
				check process_launcher_has_valid_type: False end
			end
		end

feature {NONE} -- Implementation

	should_destroy: BOOLEAN
			-- Should this timer be destroyed?

	mutex: MUTEX
			-- Internal mutex

invariant

	mutex_not_void: mutex /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
