indexing

	description: 
		"A timer manager implementation for X."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	TIMER_IMP 

inherit

	TIMER_I;

	INPUT_EVENT_X
	
create
	
	make
	
feature -- Initialization

	make is
		do
		end
	
feature -- Access

	is_regular_call_back: BOOLEAN;
			-- Is the call back set a regular one ?

	regular_time: INTEGER;
			-- Time interval for regular callbacks

feature -- Status setting

	set_next_call_back (a_delay: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_delay';
			-- in milliseconds has expired.
		local
			ac: like application_context
		do
			ac := application_context;
			ac.set_time_out_callback (a_delay, Current, an_argument);
			identifier := ac.last_id;
			command := a_command;
			is_regular_call_back := False
		end; 

	set_regular_call_back (a_time: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute all the `a_time'
			-- milliseconds.
		do
			set_next_call_back (a_time, a_command, an_argument);
			regular_time := a_time;
			is_regular_call_back := True
		end;

feature {NONE} -- Implementation

	command: COMMAND;
			-- Command to call

	execute (argument: ANY) is
			-- Call the command.
		local
			command_clone: COMMAND;
			context_data: CONTEXT_DATA;
			ac: like application_context
		do
			if command.is_template then
				command_clone := clone (command)
			else
				command_clone := command
			end;
			command_clone.set_context_data (context_data);
			if not is_regular_call_back then
                    -- Callback set by next. Identifier is
                    -- automatically removed add the end of this
                    -- callback.
				identifier := Void
			end;
			command_clone.execute (argument);
			if is_regular_call_back then
					-- Identifier will be automatically removed from the
					-- dispatcher table after Current callback is invoked.
					-- Now add the callback again and retrieve the identifier.
				ac := application_context;
				ac.set_time_out_callback (regular_time, Current, argument);
				identifier := ac.last_id
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TIMER_IMP


