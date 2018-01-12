note
	description: "Utility for timeout conversion."
	date: "$Date$"
	revision: "$Revision$"

class
	SOCKET_TIMEOUT_UTILITIES

feature -- Time helpers

	one_second_in_nanoseconds: NATURAL_64 = 1_000_000_000
			-- Number of nanoseconds in one second.

	max_timeout_ns_value: NATURAL_64 = 2_147_483_647_999_999_999
			-- Maximum value for a timeout in nanoseconds.
			-- See `is_valid_timeout_ns` for explanation.

	nanoseconds_to_seconds (ns: NATURAL_64): INTEGER
			-- Number of seconds in `ns` nanoseconds (that fits in INTEGER_32 value).
			-- Warning: Result can not be more than {INTEGER}.max_value.
		local
			n64: NATURAL_64
		do
			n64 := ns // one_second_in_nanoseconds
			if n64 > {INTEGER}.max_value.to_natural_64 then
				Result := {INTEGER}.max_value
			else
				Result := n64.to_integer_32
			end
		ensure
			non_negative: Result >= 0
			coherent: Result.to_natural_64 * one_second_in_nanoseconds <= ns
		end

	seconds_to_nanoseconds (s: INTEGER): NATURAL_64
			-- Number of nanoseconds in `s` seconds (that fits in NATURAL_64 value).
		do
			Result := one_second_in_nanoseconds * s.to_natural_64
		end

feature -- Validation			

	is_valid_timeout_ns (ns: NATURAL_64): BOOLEAN
			--| Note: internally (C API), the ns timeout is splitted into:
			--|  - a long value `tv_sec` : number of seconds
			--|  - a long value `tv_usec`: number of microseconds (with struct timeval)
			--| or in the future
			--|  - a long value `tv_nsec`: number of nanoseconds  (with struct timespec)
			--| tv_usec or tv_nsec should be >= 0 and < equivalent of 1 second.
			--| tv_usec < 1_000_000
			--| tv_nsec < 1_000_000_000
			--| so there is no issue with NATURAL_64 for usec or nsec
			--| but, then, there is restriction for the seconds value which is coded as long int
			--|  and long values (32 bits) are between -2_147_483_647 and +2_147_483_647 (i.e 2e31 - 1 = {INTEGER_32}.max_value).
			--|  then, the `seconds` part of the timeout <= +2_147_483_647, and then expressed in nanoseconds, and taking into account
			--|  the usec or nsec part, the timeout should not be greater than:
			--|     +2_147_483_647 * 1_000_000_000 + 999_999_999 =  2_147_483_647_999_999_999
			--|      and as NATURAL_64's max value is bigger     = 18_446_744_073_709_551_615
			--|      features dealing with timeout in nanoseconds have related preconditions.
		do
			Result := 0 <= ns and then ns <= max_timeout_ns_value
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
