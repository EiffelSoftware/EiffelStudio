class 
	EV_APPLICATION_IMP
	
	
inherit
	EV_GTK_EXTERNALS
	
creation 
	
	make
	
feature {NONE} -- Initialization
	
	
feature {NONE} -- Implementation
	
	init_windowing is
			-- Initialize the toolkit.
			-- (force call to once routines).
		do
			c_gtk_init_toolkit
		end
	
       iterate is
                        -- Loop the application.
                do
                        gtk_main
                end

	
--	message_box: MSG_WINDOW is
			-- Popup message window
-- 		once
 	--		!!Result.make ("Message", main_window);
 		--end;

	main_window: WINDOW1 is
			-- Main window of the example
		once
			!!Result.make 
		end

-- 	other_window: WINDOW2 is
-- 			-- Secondary window of the example
-- 		once
-- 			!!Result.make ("Window", a_screen)
-- 		end

end

