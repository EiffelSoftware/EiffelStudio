indexing
	description: "An interval timer server that manages virtual %
		%interval timers"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "September 15, 1998"

class INTERVAL_TIMER_SERVER

inherit
	ANY
	UNIX_OS_ACCESS
		export
			{NONE} all
		end
	INTERNAL
		rename
			class_name as internal_class_name
		export
			{NONE} all
		end
	EXCEPTIONS
		export
			{NONE} all
		end
create
	make

feature {NONE} -- Creation

	make is
			-- Create new interval timer server
		do
			record_original_alarm_signal_handler;
			create {ARRAYED_LIST [INTERVAL_TIMER]} timers.make (5);
			timers.compare_objects
		end

feature -- Operations

	set_new_timer (timer: INTERVAL_TIMER; t: DOUBLE) is
			-- Set new virtual interval timer `timer'
			-- for `t' seconds
		do
			next_identifier := next_identifier + 1;
			timer.initialize (t, next_identifier);
			timers.extend (timer)
			if current_timer = Void or else t < current_timer.seconds_remaining then
				stop_system_timer;
				start_timer (timer);
			end
		end

	release_expired_timer (t: INTERVAL_TIMER) is
			-- Release virtual interval timer `t' which has
			-- expired
		do
			timers.start
			timers.search (t)
			-- Remove all timers started after one that expired
			-- since they should be started from child
			-- routines
			from 
			until
				timers.off
			loop
				timers.remove
			end
			if equal (current_timer , t) then
				stop_system_timer;
				start_next_timer
			end
		end

	release_cleared_timer (t: INTERVAL_TIMER) is
			-- Release virtual interval timer `t' which has
			-- been cleared
		do
			timers.prune_all (t)
			if equal (current_timer , t) then
				stop_system_timer;
				start_next_timer
			end
		end

	handle_possible_timer_expiration is
			-- Handle possible expiration of system interval timer
		do
			if current_timer /= Void and then current_timer.is_expired then
				last_expiration_identifier := current_timer.identifier;
				release_expired_timer (current_timer)
			end
		end

	last_expiration_identifier: INTEGER
			-- Identifier of last virtual interval timer that
			-- expired

feature {NONE} -- Implementation

	next_identifier: INTEGER
			-- Next timer identifier

	timers: DYNAMIC_LIST [INTERVAL_TIMER]
			-- Virtual interval timers that have been
			-- created and have not expired or been cleared or
			-- released

	current_timer: INTERVAL_TIMER
			-- Virtual timer which is currently using the
			-- system interval timer (it is the one with the 
			-- shortest remaining interval)

	set_current_timer (t: INTERVAL_TIMER) is
			-- Set `current_timer' to `t'
		do
			current_timer := t;
			if t /= Void then
				pass_current_timer_to_c (t.address)
			else
				pass_void_timer_to_c
			end
		end

	stop_system_timer is
			-- Stop system interval timer, in case it is running
		do
			unix_os.system_interval_timer.clear
			set_original_alarm_signal_handler;
			set_current_timer (Void);
		end

	start_next_timer is
			-- Start next timer, if any, on system interval timer
		local
			min_time, current_time, time_left: DOUBLE
			next_timer: INTERVAL_TIMER
		do
			min_time := 1.0E22;
			next_timer := Void
			current_time := unix_os.current_time_in_fine_seconds
			from
				timers.start
			until
				timers.after
			loop
				time_left := timers.item.seconds_remaining_at (current_time);
				if time_left < min_time then
					min_time := time_left;
					next_timer := timers.item
				end
				timers.forth
			end
			if next_timer /= Void then
				start_timer (next_timer)
			end
		end

	start_timer (t: INTERVAL_TIMER) is
			-- Start timer `t' on system interval timer
		require
			timer_exists: t /= Void
		local
			time_left: DOUBLE
		do
			time_left := t.seconds_remaining
			if time_left < 1.0E-6 then
				time_left := 1.0E-6;
			end
			set_current_timer (t);
			set_new_alarm_signal_handler;
			unix_os.system_interval_timer.set_seconds (time_left)
		end

feature {NONE} -- Externals

	record_original_alarm_signal_handler is
			-- Record original signal handler for SIGALRM signal
			-- (the one installed by the Eiffel run-time)
		external
			"C"
		end

	set_new_alarm_signal_handler is
			-- Set new signal handler for SIGALRM signal
			-- used by timer server
		external
			"C"
		end

	set_original_alarm_signal_handler is
			-- Set signal handler for SIGALRM signal
			-- back to original value (original handler 
			-- installed by Eiffel run-time)
		external
			"C"
		end

	pass_current_timer_to_c (t: POINTER) is
			-- Pass address `t', 
			-- which represents the `is_expired' attribute of the
			-- virtual interval timer currently using the
			-- system interval timer, to C code.  The C
			-- code alarm signal handler will then be able to 
			-- set the `is_expired'  attribute for this timer
			-- when the system timer expires
		require
			timer_exists: t /= default_pointer
		external
			"C"
		end

	pass_void_timer_to_c is
			-- Pass void timer indication to C code,
			-- indicating that no virtual interval timer 
			-- is currently using the system interval timer
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


end -- class INTERVAL_TIMER_SERVER
