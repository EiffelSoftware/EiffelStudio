indexing
	description: "Graphical builder application."
	date : "$Date$"
	id : "$Id$"
	revision : "$Revision$"

class
	GB

inherit

	EV_APPLICATION
		redefine
			initialize
		end
		
	GB_SHARED_XML_HANDLER
		undefine
			default_create, copy
		end
		
	GB_SHARED_TOOLS
		undefine
			default_create, copy
		end
	
	ARGUMENTS
		undefine
			default_create, copy
		end

	GB_CONSTANTS
	
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy
		end

create
	execute

feature {NONE} -- Initialization

	execute is
		local
			wizard_manager: WIZARD_PROJECT_MANAGER
			project_settings: GB_PROJECT_SETTINGS
		do
				-- If `argument_array' has one element,
				-- then no argument was specified, only the
				-- name of the executable.
			if argument_array.count = 1 then
				default_create
				xml_handler.load_components
				main_window.build_interface
				main_window.show
				launch
			elseif (argument_array @ 2).as_lower.is_equal (Visual_studio_argument) then
						-- Now create the project_settings.
				create project_settings.make_with_default_values
				if (argument_array @ 3).as_lower.is_equal (Project_argument) then
					project_settings.enable_complete_project
				end
					-- And set them as the build settings.
				system_status.set_current_project (project_settings)
				system_status.enable_wizard_system
				create wizard_manager.make_and_launch
			end
		end
		
	initialize is
			-- `Initialize `Current'.
		do
			Precursor {EV_APPLICATION}
			-- Any General initialization can be added here.
			-- This will be executed before the program is launched.
		end

end