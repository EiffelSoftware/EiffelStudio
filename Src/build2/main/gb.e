indexing
	description: "Graphical builder application."
	date : "$Date$"
	id : "$Id$"
	revision : "$Revision$"

class
	GB

inherit

	EV_APPLICATION
		export
			{NONE} all
		redefine
			initialize
		end
		
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EXECUTION_ENVIRONMENT
		rename
			launch as environment_launch
		export
			{NONE} all
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
			if command_line.argument_array.count = 1 then
				default_create
				xml_handler.load_components
				main_window.build_interface
				main_window.show
				launch
			elseif (command_line.argument_array @ 2).as_lower.is_equal (Visual_studio_project_argument) then
				check
					five_arguments: command_line.argument_array.count = 6
				end
						-- Now create the project_settings.
				create project_settings.make_with_default_values
					-- Enable complete project in the project settings.
				if (command_line.argument_array @ 2).as_lower.is_equal (Visual_studio_project_argument) then
					project_settings.enable_complete_project
				end
					-- Set the project location.
				project_settings.set_project_location (command_line.argument_array @ 3)
				
					-- Set the project_name
				project_settings.set_project_name ((command_line.argument_array @ 4))

					-- And set them as the build settings.
				system_status.set_current_project (project_settings)
				system_status.enable_wizard_system
				create wizard_manager.make_and_launch ((command_line.argument_array @ 5).to_integer)
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