deferred class 
	EV_APPLICATION
	

feature {NONE} -- Initialization
	
	make is
		do
			implementation.make
		end
	
feature	
	
	main_window: EV_WINDOW is
			-- Must be defined as a once funtion to create
			-- the application's main_window.
		deferred
		end

end

