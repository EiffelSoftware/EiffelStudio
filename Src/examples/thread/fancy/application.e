class
	APPLICATION

inherit
	WEL_APPLICATION
		redefine
			init_application
		end

	APPLICATION_IDS

creation
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			!! Result.make
		end

	init_application is
			-- Load the common controls dll
		do
			!! common_controls_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL

end -- class APPLICATION
