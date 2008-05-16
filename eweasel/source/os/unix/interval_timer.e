indexing
	date: "September 15, 1998";
	description: "A virtual interval timer that counts down in %
		%real time.  Multiple virtual timers share the one %
		%actual system timer"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class INTERVAL_TIMER

inherit
	ANY
		redefine
			is_equal
		end
	UNIX_OS_ACCESS
		export
			{NONE} all
		redefine
			is_equal
		end
	INTERVAL_TIMER_SERVER_ACCESS
		export
			{NONE} all
		redefine
			is_equal
		end
	EXCEPTIONS
		export
			{NONE} all
		redefine
			is_equal
		end
	UNIX_SIGNALS
		rename
			meaning as signal_meaning,
			ignore as signal_ignore,
			catch as signal_catch
		export
			{NONE} all
		redefine
			is_equal
		end
	C_MEMORY_ALLOCATION
		export
			{NONE} all
		redefine
			is_equal
		end
	MEMORY
		export
			{NONE} all
		redefine
			is_equal, dispose
		end


create
	set_seconds

feature -- Creation

   	set_seconds (t: DOUBLE) is
			-- Create new virtual interval timer object
			-- set to expire after `t' seconds
		require
			nonnegative_interval: t >= 0.0
		local
			interval: DOUBLE
		do
			-- Make sure interval doesn't violate Unix
			-- system timer interval requirements

			if t < 1.0E-6 then
				interval := 1.0E-6
			elseif t > 100_000_000 then
				interval := 100_000_000
			else
				interval := t
			end
			interval_timer_server.set_new_timer (Current, interval);
		end

feature {INTERVAL_TIMER_SERVER} -- Initialization

   	initialize (t: DOUBLE; id: INTEGER) is
			-- Create new virtual interval timer object
			-- set for `t' seconds, with unique identifier `id'
		local
			addr: POINTER
		do
			seconds_original := t
			identifier := id
			addr := allocate_nongc_memory (8);

			-- Set `is_expired' to False in C memory before
			-- putting its address in `Current'

			set_boolean_value (addr, False);
			address := addr;
			time_when_set := unix_os.current_time_in_fine_seconds;
		ensure
			timer_set: not is_expired
			interval_set: seconds_original = t
			identifier_set: identifier = id
		end

feature -- Properties

	identifier: INTEGER
			-- Unique identifier for `Current'

	is_expired: BOOLEAN is
			-- Has timer expired?  Expiration of timer
			-- always raises an exception
		do
			if address /= default_pointer then
				Result := boolean_value (address);
			end
		end

	is_expiration_exception: BOOLEAN is
			-- Is last exception originally due to expiration
			-- of `Current'?  Must only be referenced in
			-- a routine rescue clause
		do
			interval_timer_server.handle_possible_timer_expiration
			Result := is_signal and then signal = Sigalrm and
				is_expired and
				identifier = interval_timer_server.last_expiration_identifier
		end

	seconds_original: DOUBLE
			-- Number of seconds timer was originally set for

	seconds_remaining: DOUBLE is
			-- Number of seconds left until timer expires.
			-- May be <= 0.0 before timer expires due to
			-- delay in operating system delivering alarm signal
			-- or delay in signal being processed
		do
			Result := seconds_remaining_at (unix_os.current_time_in_fine_seconds)
		end

feature -- Modification

	clear is
		require
			timer_set: not is_expired
		do
			set_is_expired (True)
			interval_timer_server.release_cleared_timer (Current)
		ensure
			timer_not_set: is_expired
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := identifier = other.identifier
		end

feature {INTERVAL_TIMER_SERVER} -- Implementation

	seconds_remaining_at (t: DOUBLE): DOUBLE is
			-- Number of seconds remaining on timer at time `t'.
			-- May be <= 0.0 seconds
		do
			Result := time_when_set + seconds_original - t;
		end

	address: POINTER;
			-- Address of C memory for `is_expired' indicator

feature {NONE} -- Implementation

	time_when_set: DOUBLE
			-- Time in seconds when timer was set

	set_is_expired (b: BOOLEAN) is
			-- Set `is_expired' to `b'
		do
			set_boolean_value (address, b);
		end

	dispose is
			-- Deallocate resources when object is
			-- garbage collected
		local
			null_ptr: POINTER;
		do
			if address /= null_ptr then
				free_nongc_memory (address);
				address := null_ptr;
			end
		end

	boolean_value (addr: POINTER): BOOLEAN is
			-- Boolean value at address `addr'
		external
			"C"
		end

	set_boolean_value (addr: POINTER; b: BOOLEAN) is
			-- Set boolean value at address `addr' to `b'
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


end -- class INTERVAL_TIMER
