deferred class 
	EV_APPLICATION
	
	
inherit
 	WEL_APPLICATION
 		rename
 			main_window as wel_main_window
		redefine
			wel_main_window
 		end

feature
	main_window: EV_WINDOW is
			-- Must be defined as a once funtion to create
			-- the application's main_window.
		deferred
		end


	init_windowing is
			-- Initialize the toolkit.
			-- (force call to once routines).
		do
		end
	
	iterate is
                        -- Loop the application.
                do
                end
	
feature -- Implementation
	
	wel_main_window: WEL_FRAME_WINDOW is
		local
			window_imp: EV_WINDOW_IMP
		once
			window_imp ?= main_window.implementation
			check
				window_imp /= Void
			end
			Result := window_imp.wel_window
		end
end
