indexing
	date: "August 21, 1998";
	description: "A Unix operating system interval timer that counts %
		%down in real time"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class UNIX_SYSTEM_INTERVAL_TIMER

inherit
	SYSTEM_INTERVAL_TIMER

feature -- Properties

	is_set: BOOLEAN is
			-- Is timer set?
		do
			get_timer_value;
			Result := seconds > 0 or microseconds > 0
		end
	
	seconds_remaining: DOUBLE is
			-- Number of seconds remaining until timer expires
			-- NOTE: number of seconds remaining can be
			-- zero shortly before the timer expires.  Also,
			-- intervals may be rounded to the resolution of
			-- the system clock, which can cause the time
			-- interval to appear to increase right after it
			-- is set
		do
			get_timer_value;
			Result := seconds;
			Result := Result + microseconds / 1.0E6;
		end

feature -- Validity

	valid_interval (d: DOUBLE): BOOLEAN is
			-- Is `d' a valid number of seconds for a
			-- timer interval?
		do
			Result := d >= 1.0E-6 and d <= 100_000_000.0
		end
	
feature -- Modification

	set_seconds (d: DOUBLE) is
			-- Set timer to expire in `d' seconds.  Raise
			-- a Sigalrm signal exception after it expires
		local
			secs, micro_secs: INTEGER;
		do
			secs := d.floor;
			micro_secs := ((d - secs) * 1_000_000).rounded;
			set_interval_timer (secs, micro_secs, 0, 0)
		end;
	
	clear is
		do
			set_interval_timer (0, 0, 0, 0)
		end
	
feature {NONE} -- Implementation

	get_timer_value is
			-- Get value of timer (seconds and microseconds
			-- left and seconds and microseconds in reset
			-- interval) and put in `seconds', `microseconds',
			-- `interval_seconds' and `interval_microseconds'
		do
			get_interval_timer ($seconds, $microseconds, $interval_seconds, $interval_microseconds)
		end

	seconds: INTEGER
			-- Number of whole seconds left before timer expires

	microseconds: INTEGER
			-- Additional number of microseconds left before 
			-- timer expires

	interval_seconds: INTEGER
			-- Number of whole seconds in timer reset interval

	interval_microseconds: INTEGER
			-- Additional number of microseconds in timer
			-- reset interval


feature {NONE} -- Externals

	get_interval_timer (secs, micro_secs, interval_secs, interval_micro_secs: POINTER) is
			-- Get components of timer (seconds and microseconds
			-- left and seconds and microseconds in reset
			-- interval) and put at addresses specified by
			-- `secs', `micro_secs', `interval_secs' and
			-- `interval_micro_secs'
		external 
			"C"
		end

	set_interval_timer (secs, micro_secs, interval_secs, interval_micro_secs: INTEGER) is
			-- Set components of timer (seconds and microseconds
			-- left and seconds and microseconds in reset
			-- interval) to `secs', `micro_secs', `interval_secs' 
			-- and `interval_micro_secs'
		external 
			"C"
		end

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class UNIX_SYSTEM_INTERVAL_TIMER

