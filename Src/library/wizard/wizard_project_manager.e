indexing
	description: "Class which is launching the application."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROJECT_MANAGER

inherit
	EV_APPLICATION
--		redefine
--			make_and_launch
--		end

	WIZARD_SHARED
		undefine
			default_create
		end

Creation
	make_and_launch 

feature -- Initialization


	make_and_launch is
			-- Initialize and launch application
		do
			if argument_count<1 then
				io.put_string("wizard.exe -arg1 [resource_path]%N")
			else
				default_create
				set_application (Current)
				prepare
				launch
--				precursor
			end
		end

	prepare is
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			first_window.set_title("Wizard Version 1.1")
			first_window.show
		end 

	
end -- class WIZARD_PROJECT_MANAGER
