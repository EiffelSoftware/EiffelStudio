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
				-- Comment out this if statement when generating executable for
				-- Visual studio wizard, as that version of Build should not be
				-- executable independently.
			if command_line.argument_array.count = 1 then
				default_create
				xml_handler.load_components
				main_window.build_interface
				main_window.show
				launch
			end
			if (command_line.argument_array.count > 1) then
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
		
	clear_status_during_transport (an_x, a_y: INTEGER; a_target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Clear status bar if `a_target' is Void.
		do
			if a_target = Void then
				clear_status_bar
			end
		end
		
	clear_status_after_transport (a: ANY) is
			-- Clear `status_bar'.
		do
			clear_status_bar
		end

end