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
		
	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Access

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
			Result := Interface_names.m_Open_eac_browser
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
			Execution_environment.launch (ISE_eac_browser_name)
		end
		
end -- class EB_OPEN_EAC_BROWSER_CMD
