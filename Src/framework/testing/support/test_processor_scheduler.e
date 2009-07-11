note
	description: "Summary description for {TEST_PROCESSOR_SCHEDULER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_PROCESSOR_SCHEDULER

inherit
	TEST_PROCESSOR_SCHEDULER_I

	DT_SHARED_SYSTEM_CLOCK

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- Initialize `Current'.
		do
			test_suite := a_test_suite
			create processors.make
			create launched_processors.make_default
			last_iteration := system_clock.time_now
		end

feature -- Access

	test_suite: TEST_SUITE_S
			-- <Precursor>

feature {NONE} -- Access

	processors: DS_LINKED_LIST [TUPLE [processor: TEST_PROCESSOR_I; remaining: like duration]]
			-- List containing all running processors together the remaining milliseconds until the
			-- corresponding processor should proceed

	launched_processors: DS_ARRAYED_LIST [TEST_PROCESSOR_I]
			-- Processors which have been launched since last iteration ended

	last_iteration: DT_TIME
			-- Time when `perform_iteration' last scheduled `processors'

	duration: NATURAL
			-- Number of milliseconds between the last two calls to `update_duration'

	requested_sleep_time: like duration
			-- Number of milliseconds before `iterate' should be called next

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := test_suite.is_interface_usable
		end

feature {NONE} -- Status report

	is_iterating: BOOLEAN
			-- Is `perform_iterations' currently called?

feature -- Status setting

	launch_processor (a_processor: TEST_PROCESSOR_I; a_conf: TEST_PROCESSOR_CONF_I)
			-- <Precursor>
		local
			l_sleep_time, l_remaining: like duration
		do
			a_processor.start (a_conf)
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			test_suite.processor_launched_event.publish ([test_suite.as_attached, a_processor.as_attached])

			if is_iterating then
					-- If `Current' is iterating, we add processor to `launched_processors' and let `iterate'
					-- take care of it
				launched_processors.force_last (a_processor)
			else
					-- Otherwise we add processor to `processors' and make sure `iterate' is called when needed,
					-- depending if there were already waiting processors or not
				l_sleep_time := a_processor.sleep_time
				if processors.is_empty then
					update_duration (True)
					l_remaining := l_sleep_time
					requested_sleep_time := l_sleep_time
				else
					update_duration (False)
					if duration >= requested_sleep_time then
						l_remaining := 0
					else
						l_remaining := l_sleep_time.min (requested_sleep_time - duration)
					end
				end
				processors.force_last ([a_processor, l_sleep_time])
				launch_iteration (l_remaining)
			end
		end

feature {NONE} -- Status setting

	update_duration (a_reset: BOOLEAN)
			-- Set `duration' to number of milliseconds passed between `last_iteration' and now. If
			-- `a_reset' is true, set `last_iteration' to current time.
		local
			l_now: like last_iteration
			l_msec: INTEGER
		do
			l_now := system_clock.time_now
			l_msec := l_now.time_duration (last_iteration).millisecond_count
			duration := l_msec.to_natural_32
			if a_reset then
				last_iteration := l_now
			end
		end

feature {NONE} -- Implementation

	launch_iteration (a_sleep_time: like duration)
			-- Assure `iterate' after a given number of milliseconds.
			--
			-- `a_sleep_time': Number of milliseconds until `iterate' should be called.
		require
			not_iterating: not is_iterating
		deferred
		ensure
			not_iterating: not is_iterating
		end

	frozen iterate
			-- Iterate through `processors' and let them proceed if remaining time is smaller or equal
			-- passed time.
		require
			not_iterating: not is_iterating
		local
			l_duration, l_remaining, l_min_remaining: like duration
			l_cur: DS_LIST_CURSOR [ANY]
			l_proc: TEST_PROCESSOR_I
			l_item: TUPLE [processor: TEST_PROCESSOR_I; remaining: NATURAL]
		do
			is_iterating := True
			update_duration (False)
			l_duration := duration

			from
				processors.start
				l_min_remaining := l_min_remaining.max_value
			until
				processors.after and launched_processors.is_empty
			loop
				if processors.after then
					l_proc := launched_processors.last
					launched_processors.remove_last
					l_remaining := l_proc.sleep_time
					l_item := [l_proc, l_proc.sleep_time]
					processors.force_last (l_item)
				else
					l_item := processors.item_for_iteration
					l_proc := l_item.processor
					l_remaining := l_item.remaining
					if l_duration >= l_remaining then
						if l_proc.is_finished then
							l_proc.stop
						else
							l_proc.proceed
							l_remaining := l_proc.sleep_time
							if l_proc.is_finished then
								test_suite.processor_finished_event.publish ([test_suite.as_attached, l_item.processor.as_attached])
							else
								test_suite.processor_proceeded_event.publish ([test_suite.as_attached, l_item.processor.as_attached])
							end
						end
					else
						l_remaining := l_remaining - l_duration
					end
					l_item.remaining := l_remaining
				end
				if l_proc.is_running then
					if l_min_remaining > l_remaining then
						l_min_remaining := l_remaining
					end
					processors.forth
				else
					test_suite.processor_stopped_event.publish_if ([test_suite.as_attached, l_proc.as_attached],
						agent (ts: TEST_SUITE_S; p: TEST_PROCESSOR_I): BOOLEAN
							do
								Result := not p.is_running
							end)
					processors.remove_at
				end
			end
			if not processors.is_empty then
				requested_sleep_time := l_min_remaining
			end

			update_duration (True)

			is_iterating := False
		ensure
			not_iterating: not is_iterating
		end

invariant
	processors_running: processors.for_all (agent (a_t: TUPLE [processor: TEST_PROCESSOR_I; duration: NATURAL]): BOOLEAN
		do
			Result := a_t.processor.is_running
		end)
	iterating_or_no_launched_processors_waiting: is_iterating or launched_processors.is_empty

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
