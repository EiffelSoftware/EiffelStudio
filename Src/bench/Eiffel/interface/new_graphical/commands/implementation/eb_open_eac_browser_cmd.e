indexing
	description: "Command used to launch Eiffel Assembly Cache Browser"

class
	EB_OPEN_EAC_BROWSER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
	
	EB_CONSTANTS
		export
			{NONE} all
		end
		
	EB_SHARED_WINDOW_MANAGER
	
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create implementation
		end

feature -- Access

	ISE_eac_browser_filename: STRING is
			-- Filename of Eiffel Assembly Cache Browser
		once
			Result := clone (Eiffel_delivery_path)
			Result.append (ISE_eac_browser_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: not Result.is_empty
		end

	tooltip: STRING is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.E_open_eac_browser
		end

	description: STRING is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.E_open_eac_browser
		end

	name: STRING is
			-- Text identifier for `Current'.
		do
			Result := "Dotnet_import"
		end

	menu_name: STRING is
			-- Menu name identifier (empty since not in menu)
		do
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Icon for `current'.
		do
			Result := Pixmaps.Icon_dotnet_import
		end

feature -- Basic operations

	execute is
			-- Command execution.
		do
			development_window := window_manager.last_focused_development_window.window
			disable_sensitive 
			implementation.launch_and_refresh (ISE_eac_browser_filename, "", ~on_refresh)
			enable_sensitive
		end
		
feature {NONE} -- Implementation

	implementation: EB_OPEN_EAC_BROWSER_CMD_IMP
			-- Implementation (platform specific)
			
	development_window: EV_WINDOW
			-- Last focused EiffelStudio development window
			
	Eiffel_delivery_path: STRING is 
			-- Path to Eiffel delivery
		once
			Result := get (Eiffel_key)
		ensure
			non_void_path: Result /= Void
			not_empty_path: not Result.is_empty
		end
	
	Eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable for Eiffel delivery

	ISE_eac_browser_relative_filename: STRING is "\studio\spec\windows\bin\eac_browser.exe"
			-- Filename of EAC Browser (relative to Eiffel delivery path) 

	on_refresh is
			-- Action performed while ISE Assembly Manager is active to refresh EiffelStudio development window
		do
			(create {EV_ENVIRONMENT}).application.process_events
		end
		
end -- class EB_OPEN_EAC_BROWSER_CMD
