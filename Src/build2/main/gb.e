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
		
	GB_SHARED_STATUS_BAR
		undefine
			default_create, copy
		end
		
	GB_SHARED_COMMAND_HANDLER

create
	execute

feature {NONE} -- Initialization

	execute is
			-- Execute `Current'.
			-- There are sections of commented code in here which interpret the command
			-- line for different launches. Each starts with a check to ensure that the
			-- system never gets compiled with more than one command option available.
		local
			wizard_manager: WIZARD_PROJECT_MANAGER
			project_settings: GB_PROJECT_SETTINGS
			file_handler: GB_SIMPLE_XML_FILE_HANDLER
		do
			if command_line.argument_array.count = 1 then
					-- If `argument_array' has one element,
					-- then no argument was specified, only the
					-- name of the executable.
				default_create
				xml_handler.load_components
				main_window.build_interface
				main_window.show
				launch
			elseif command_line.argument_array.count = 2 then
				-- There are two command line options in the case where we double click on a .bpr
				-- file, and open build this way. We must look inside the .bpr file, and determine
				-- how to open build. i.e. Visual studio wizard, or regular file.
				create project_settings
				create file_handler
				project_settings.load (command_line.argument_array @ 1, file_handler)
					-- Question `project_settings' to see how to open the file.
				if project_settings.is_stand_alone_project then
					default_create
					xml_handler.load_components
					main_window.build_interface
					main_window.show
					post_launch_actions.extend (agent open_with_name (command_line.argument_array @ 1))
					launch
				else
					system_status.set_current_project (project_settings)
					system_status.enable_wizard_system
					create wizard_manager.make_and_launch_as_modify_wizard (visual_studio_information.Visual_studio_pixmap_location)
				end
			end

			if (command_line.argument_array.count = 6) then
					-- Arguments have been passed, so we must read them,
					-- and respond accordingly.
				if (command_line.argument_array @ 2).as_lower.is_equal (Visual_studio_project_argument) then
					check
						five_arguments: command_line.argument_array.count = 6
					end
						-- For Visual Studio launches, the arguments are as follows:
						-- 1. The location to the png files for the wizard
						-- 2. "visualstudio_project" which informs Build it has been launched from VS.
						-- 3. Path to where the project will be created.
						-- 4. Project name.
						-- 5. Hwnd of window that Build should be displayed modally to.
					
						-- Now create the project_settings.
					create project_settings.make_envision_with_default_values
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
		end
		
	initialize is
			-- `Initialize `Current'.
		do
			Precursor {EV_APPLICATION}
			-- Any General initialization can be added here.
			-- This will be executed before the program is launched.
			pnd_motion_actions.extend (agent clear_status_during_transport)
			cancel_actions.extend (agent clear_status_after_transport)
		end
		
feature {NONE} -- Implementation

	open_with_name (f: STRING) is
			-- Use the open project command to open
			-- file `f'.
		do
			command_handler.Open_project_command.execute_with_name (f)			
		end
		
end