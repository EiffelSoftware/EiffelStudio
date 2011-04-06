note
	description: "Process status listening timer implemented with Vision2 timer."
	status: "See notice at end of class."
	legal: "See notice at end of class."
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

	make (interval: INTEGER)
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

	start
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

	wait (a_timeout: INTEGER): BOOLEAN
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
					l_sleep_time := sleep_time * one_millisecond_in_nanoseconds
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

	destroy
		do
			timer.destroy
		end

	destroyed: BOOLEAN
		do
			Result := timer.is_destroyed
		end

feature{NONE} -- Implementation

	timer: EV_TIMEOUT
			-- Internal Vision2 Timer

invariant
	timer_not_void: timer /= Void

note
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"

end

