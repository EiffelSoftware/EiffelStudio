class
	APPLICATION

inherit
	WEL_APPLICATION
		redefine
			init_application
		end

	APPLICATION_IDS

create
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			create Result.make
		end

	init_application is
			-- Load the common controls dll
		do
			create common_controls_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL

end -- class APPLICATION
