indexing
	description: "Objects that represent the current status of the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_STATUS
	
feature -- Access

	current_project_settings: GB_PROJECT_SETTINGS
		-- Information regarding the current project in the system.
		-- `Void' if none.
		
	project_open: BOOLEAN is
			-- Is there a project currently in the system?
		do
			Result := not (current_project_settings = Void)
		end

	project_modified: BOOLEAN
		-- Has `Current' been modified?
		-- Used to enable/disable the save button and other
		-- operations dependent on the user having modified something.
		
	is_wizard_system: BOOLEAN
		-- Is Build behaving as a wizard?
		
	tools_always_on_top: BOOLEAN
		-- Should all windows containing tools be shown modelessly
		-- to the main window. Otherwise, they are independent.
		
feature -- Status setting

	set_current_project (new_project_settings: GB_PROJECT_SETTINGS) is
			-- Assign `new_project_settings' to `current_project_settings'.
		require
			no_project_open: not project_open
		do
			current_project_settings := new_project_settings
		end
		
	close_current_project is
			-- Assign `Void' to `current_project_settings'.
		require
			project_open: project_open
		do
			current_project_settings := Void
			disable_project_modified
		end
		
	enable_project_modified is
			-- Assign `True' to `project_modified'.
		do
			project_modified := True
		end
		
	disable_project_modified is
			-- Assign `False' to `project_modfied'.
		do
			project_modified := False
		end
		
	enable_wizard_system is
			-- Assign `True' to `is_wizard_system'.
			-- There is no corresponding `disable', as
			-- we set the status once at the start.
		do
			is_wizard_system := True
		end
		
	enable_tools_always_on_top is
			-- Assign `True' to `tools_always_on_top'.
		do
			tools_always_on_top := True
		end
		
	disable_tools_always_on_top is
			-- Assign `False' to `tools_always_on_top'.
		do
			tools_always_on_top := False
		end

end -- class GB_SYSTEM_STATUS
