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
			sleep as obsolete_sleep
		end

	EXECUTION_ENVIRONMENT
		rename
			launch as environment_launch
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (interval: INTEGER)
			-- Set time interval which this timer will be triggered with `interval'.
			-- Unit of `interval' is milliseconds.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			interval_positive: interval > 0
		do
			sleep_time := interval
			create mutex.make
			has_started := False
		ensure
			sleep_time_set: sleep_time = interval
			destroyed_set: destroyed = True
		end

feature -- Control

	start
		local
			l_thread_attribute: THREAD_ATTRIBUTES
		do
			mutex.lock
			should_destroy := False
			terminated := False
			create l_thread_attribute.make
			l_thread_attribute.set_detached (True)
			launch_with_attributes (l_thread_attribute)
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
		local
			l_sleep_time: INTEGER_64
			l_timeout: BOOLEAN
			l_start_time: detachable DATE_TIME
			l_now_time: DATE_TIME
		do
			if not destroyed then
				if {PLATFORM}.is_thread_capable then
					if a_timeout > 0 then
						create l_start_time.make_now
					end
					from
						l_sleep_time := sleep_time * 1000000
					until
						destroyed or l_timeout
					loop
						if a_timeout > 0 then
							create l_now_time.make_now
							check l_start_time /= Void end
							if l_now_time.relative_duration (l_start_time).fine_seconds_count * 1000 > a_timeout then
								l_timeout := True
							end
						end
						if not l_timeout then
							sleep (l_sleep_time)
						end
					end
					Result := not l_timeout
				elseif a_timeout = 0 then
						-- We are not in multithreaded mode, simply wait indefinitely
					if attached {PROCESS_IMP} process_launcher as l_prc_imp then
						l_prc_imp.check_exit
					else
						check launcher_has_valid_type: False end
					end
				end
			else
				Result := True
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
					l_sleep_time := sleep_time.to_integer_64 * 1000000
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

feature{NONE} -- Implementation

	should_destroy: BOOLEAN
			-- Should this timer be destroyed?

	mutex: MUTEX
			-- Internal mutex

invariant

	mutex_not_void: mutex /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
