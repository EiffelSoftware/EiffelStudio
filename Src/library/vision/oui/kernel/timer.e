
-- A timer manager.
-- This class should be used for real-time tasks (like in games).
-- The times given are a millisecond and are of course real-time and not
-- process-time (in multi-tasking environments).

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TIMER 

inherit

	G_ANY
		export
			{NONE} all
		end

creation

	make

feature 

	make is
			-- Create a timer.
		do
			implementation := toolkit.timer (Current)
		end;

	implementation: TIMER_I;
			-- Implementation of timer

	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		do
			Result := implementation.is_call_back_set
		end;

	is_regular_call_back: BOOLEAN is
			-- Is the call back set a regular one ?
		require
			is_call_back_set
		do
			Result := implementation.is_regular_call_back
		end;

	set_next_call_back (a_delay: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_delay'
			-- in milliseconds has expired.
		require
			no_call_back_already_set: not is_call_back_set;
			a_delay_positive_and_not_null: a_delay > 0;
			not_a_command_void: not (a_command = Void)
		do
			implementation.set_next_call_back (a_delay, a_command, an_argument)
		ensure
			is_call_back_set and (not is_regular_call_back)
		end;

	set_no_call_back is
			-- Remove any call-back already set.
		require
			a_call_back_must_be_set: is_call_back_set
		do
			implementation.set_no_call_back
		ensure
			not is_call_back_set
		end;

	set_regular_call_back (a_time: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute all the `a_time'
			-- milliseconds.
		require
			no_call_back_already_set: not is_call_back_set;
			a_time_positive_and_not_null: a_time >0;
			not_a_command_void: not (a_command = Void)
		do
			implementation.set_regular_call_back (a_time, a_command, an_argument)
		ensure
			is_call_back_set and is_regular_call_back
		end

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
