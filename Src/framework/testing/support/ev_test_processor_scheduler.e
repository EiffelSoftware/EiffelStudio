note
	description: "Summary description for {EV_TEST_PROCESSOR_SCHEDULER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEST_PROCESSOR_SCHEDULER

inherit
	TEST_PROCESSOR_SCHEDULER
		redefine
			make
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end
create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- <Precursor>
		do
			Precursor (a_test_suite)
			create timer.make_with_interval (0)
			timer.actions.extend (agent perform_iterations)
		end

feature {NONE} -- Access

	timer: EV_TIMEOUT
			-- Timer used to invoke `perform_iterations'

feature {NONE} -- Implementation

	launch_iteration (a_sleep_time: like duration)
			-- <Precursor>
		do
			if a_sleep_time > 0 then
				timer.set_interval (a_sleep_time.as_integer_32)
			else
				timer.set_interval (0)
				ev_application.add_idle_action_kamikaze (timer.actions.first)
			end
		end

	perform_iterations
			-- Iteratively call `iterate', allowing EV events to be processed in between.
		require
			not_iterating: not is_iterating
		local
			l_done: BOOLEAN
		do
			from
				timer.set_interval (0)
			until
				l_done
			loop
				iterate
				if processors.is_empty then
					l_done := True
				else
					if requested_sleep_time > 0 then
						timer.set_interval (requested_sleep_time.to_integer_32)
						l_done := True
					else
						ev_application.process_events
					end
				end
			end
		ensure
			not_iterating: not is_iterating
		end

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
