
-- A timer manager implementation for X.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TIMER_X 

inherit

	TIMER_I;

	EVENT_HDL


creation

	make

	
feature {NONE}

	argument: ANY;
			-- Argument to give to the command

	c_data: POINTER;
			-- Address of datas for C routines.

	call_back is
			-- Call the command.
		local
			command_clone: COMMAND;
			context_data: CONTEXT_DATA
		do
			if not (command = Void) then
				if command.is_template then
					command_clone := clone (command)
				else
					command_clone := command
				end;
				command_clone.set_context_data (context_data);
				command_clone.execute (argument)
			end;
		end;

	command: COMMAND;
			-- Command to call

	
feature 

	make (a_timer: TIMER; an_application_context: POINTER) is
			-- Create a openlook timer.
		require
			a_timer_exists: not (a_timer = Void)
		
		do
			c_data := c_timer_create (an_application_context, Current, $call_back);
			call_back
		end; 

	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		
		do
			Result := c_timer_is_call_back_set (c_data)
		end;

	is_regular_call_back: BOOLEAN is
			-- Is the call back set a regular one ?
		require else
			is_call_back_set
		
		do
			Result := c_tmr_is_rglr_call_back (c_data)
		end; 

	set_next_call_back (a_delay: INTEGER; a_command: COMMAND; an_argument: ANY) is
	            	-- Set `a_command' with `argument' to execute when `a_delay';
			-- in milliseconds has expired.
		require else
			no_call_back_already_set: not is_call_back_set;
			a_delay_positive_and_not_null: a_delay > 0;
			not_a_command_void: not (a_command = Void)
		
		do
			c_tmr_set_next_call_back (c_data, a_delay);
			command := a_command;
			argument := an_argument
		ensure then
			is_call_back_set and (not is_regular_call_back)
		end; 

	set_no_call_back is
			-- Remove any call-back already set.
		require else
			a_call_back_must_be_set: is_call_back_set
		
		do
			c_timer_set_no_call_back (c_data)
		ensure then
			not is_call_back_set
		end; 

	set_regular_call_back (a_time: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute all the `a_time'
			-- milliseconds.
		require else
			no_call_back_already_set: not is_call_back_set;
			a_time_positive_and_not_null: a_time >0;
			not_a_command_void: not (a_command = Void)
		
		do
			c_tmr_set_rglr_call_back (c_data, a_time);
			command := a_command;
			argument := an_argument
		ensure then
			is_call_back_set and is_regular_call_back
		end

feature {NONE} -- External features

	c_timer_create (contxt: POINTER; obj: TIMER_X; cb: POINTER): POINTER is
		external
			"C"
		end; 

	c_tmr_set_rglr_call_back (data: POINTER; a_time: INTEGER) is
		external
			"C"
		end;

	c_timer_set_no_call_back (data: POINTER) is
		external
			"C"
		end; 

	c_tmr_set_next_call_back (data: POINTER; a_delay: INTEGER) is
		external
			"C"
		end;

	c_tmr_is_rglr_call_back (data: POINTER): BOOLEAN is
		external
			"C"
		end; 

	c_timer_is_call_back_set (data: POINTER): BOOLEAN is
		external
			"C"
		end; 

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
