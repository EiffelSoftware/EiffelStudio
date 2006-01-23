indexing
	description: "This class represents a MS_WINDOWS timer"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TIMER_IMP

inherit
	TIMER_I

	--G_ANY_IMP

	WEL_FRAME_WINDOW
		rename
			destroy as wel_destroy
		redefine
			on_timer
		end

create
	make

feature -- Initialization

	make is
		do
			make_top ("")
		end
 
feature -- Status report

 	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		do
			Result := call_back_set
		end

	is_regular_call_back: BOOLEAN is
			-- Is the call back set a regular one ?
		do
			Result := call_back_regular
		end 

feature -- Status setting

	set_next_call_back (a_delay: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_delay'
			-- in milliseconds has expired.
		do
			current_callback := a_command
			current_arg := an_argument
			call_back_set := True
			call_back_regular := False
			set_timer (timer_id, a_delay)
		end 

	set_no_call_back is
			-- Remove any call-back already set.
		do
			call_back_set := False
			call_back_regular := False
			kill_timer (timer_id)
		end 

	set_regular_call_back (a_time: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute all the `a_time'
			-- milliseconds.
		do
			current_callback := a_command
			current_arg := an_argument
			call_back_set := True
			call_back_regular := True
			set_timer (timer_id, a_time)
		end

	destroy is
		do
			if is_call_back_set then
				kill_timer (timer_id)
			end
			wel_destroy
		end

feature {NONE} -- Implementation

	on_timer (a_timer_id: INTEGER) is
		do
			check
				valid_id: a_timer_id = timer_id
			end
			current_callback.execute (current_arg)
			if not call_back_regular then
				kill_timer (timer_id)
			end
		end

	current_callback: COMMAND

	current_arg: ANY

	call_back_set: BOOLEAN

	call_back_regular: BOOLEAN

	timer_id: INTEGER is 1;
			-- Timer identifier

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




end -- TIMER_W 

