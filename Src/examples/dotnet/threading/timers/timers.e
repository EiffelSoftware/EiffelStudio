indexing
	description: "[
					Launch a timer that executes a feature every 2 seconds until
					user press enter to finish the program execution.
					]"
	date: "$Date$"
	revision: "$Revision$"
	
class
	TIMERS

create
	make

feature {NONE} -- Initialization

	make is
			-- Launch the timer and wait for the user to press enter to finish the execution."
		local
			timer: TIMER
		do
			io.put_string ("Checking for status updates every 2 seconds.%N")
			io.put_string ("   (Hit Enter to terminate the sample)%N")
			
			create timer.make (create {TIMER_CALLBACK}.make (Current, $check_status), Void, 0, 2000)
			io.read_line
		end


	check_status (a_state: SYSTEM_OBJECT) is
			-- The callback method's signature MUST match that of a TIMER_CALLBACK 
			-- delegate (it takes an SYSTEM_OBJECT parameter and returns void)
		do
			io.put_string ("Checking Status.%N")
			-- ...
		end

end -- class TIMERS
