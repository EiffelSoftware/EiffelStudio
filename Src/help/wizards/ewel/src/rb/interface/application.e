indexing
	description: "Root class of Resource Bench"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	WEL_APPLICATION
		rename 
			make as wel_make
		redefine
			init_application, accelerators
		end

	INTERFACE_MANAGER

	APPLICATION_IDS

creation
	make


feature -- Initialization

	make is
		local
			retried: BOOLEAN
		do
			if not retried then
				wel_make
			else
				interface.display_text (std_error, "An internal error occurred%NPlease contact <support@eiffel.com>")
			end
		rescue
			retried := true
			retry
		end

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			!! Result.make
		end

	accelerators: WEL_ACCELERATORS is
			-- Create the application's accelerator
		once
			!! Result.make_by_id (Idr_accelerator)
		end

	init_application is
			-- Load the common controls dll
		do
			!! common_controls_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL

end -- class APPLICATION
