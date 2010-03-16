note
	description: "[
					Generic operating system services
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EQA_EW_OPERATING_SYSTEM

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
			{ANY} deep_copy, deep_twin, is_deep_equal, standard_is_equal
		end

feature -- Date and time

	current_time_in_seconds: INTEGER
			-- Current time in seconds since the start of
			-- the epoch (00:00:00 GMT,  Jan.  1,  1970)
		deferred
		end

feature -- Sleeping

	sleep_milliseconds (n: DOUBLE)
			-- Suspend execution for `n' milliseconds.
			-- Actual time could be longer or shorter
		require
			nonnegative_time: n >= 0
		local
			l_nanosecs: INTEGER_64
		do
			l_nanosecs := (n * 1_000_000 + 0.5).truncated_to_integer_64
			sleep (l_nanosecs)
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
