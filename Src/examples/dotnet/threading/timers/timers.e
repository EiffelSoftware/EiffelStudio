indexing
	description: "Launch a timer that executes a feature every 2 seconds until user press enter to finish the program execution."
	
class
	TIMERS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point.	%
						% launch the timer and wait for the user to press enter to finish the execution."
		local
			 my_timer: TIMER
		do
			io.put_string ("Checking for status updates every 2 seconds.")
			io.put_new_line
			io.put_string ("   (Hit Enter to terminate the sample)")
			io.put_new_line
			create my_timer.make_with_callback (create {TIMER_CALLBACK}.make (Current, $check_status), Void, 0, 2000)
			io.read_line
			my_timer.dispose()
		end


	check_status (a_state: SYSTEM_OBJECT) is
			-- The callback method's signature MUST match that of a TIMER_CALLBACK 
			-- delegate (it takes an SYSTEM_OBJECT parameter and returns void)
		do
			io.put_string ("Checking Status.")
			io.put_new_line
			-- ...
		end

end -- class APPLICATION
