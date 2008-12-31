note

	description:

		"Objects that meassure time"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_TIMER

inherit
	ANY

	DT_SHARED_SYSTEM_CLOCK
		export {NONE} all end

create
	make


feature {NONE} -- Initialization

	make
			-- Create new timer.
		do
		end

feature -- Status report

	is_running: BOOLEAN
			-- Is timer currently running?
		do
			Result := start_time /= Void
		end

	last_duration: DT_DATE_TIME_DURATION


feature -- Timing

	start
			-- Start timer.
		do
			start_time := system_clock.date_time_now
		end

	calculate_duration
			-- Calculate duration since `start_time' and now.
		require
			running: is_running
		local
			time_now: DT_DATE_TIME
		do
			time_now := system_clock.date_time_now
			last_duration := time_now.duration (start_time)
			last_duration.set_time_canonical
		ensure
			last_duration_set: last_duration /= Void
		end

feature -- Implementation

	start_time: DT_DATE_TIME

;note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
