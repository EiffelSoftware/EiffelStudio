indexing
	description	: "Class which is launching the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_MANAGER

inherit
	EV_APPLICATION
		rename 
			copy as copy_application
		undefine
			help_engine
		select 
			copy_application
		end

	WIZARD_SHARED
		undefine
			default_create
		end

create
	make_and_launch 

feature {NONE} -- Initialization

	make_and_launch is
			-- Initialize and launch application
		do
			if argument_count < 1 then
				io.put_string("wizard -arg1 [resource_path]%N")
			else
				default_create
				set_application (Current)
				prepare
				launch
			end
		end

	prepare is
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			first_window.set_title (Wizard_title)
			first_window.close_request_actions.extend (agent end_application)
			first_window.show
		end

	end_application is
			-- End the current application.
		do
			(create {EV_ENVIRONMENT}).application.destroy
		end

	Wizard_title: STRING is 
			-- Window title for this wizard.
		once
			Result := "Wizard Version 1.1"
		ensure
			Valid_result: Result /= Void and then not Result.is_empty
		end
	
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




end -- class WIZARD_PROJECT_MANAGER


