indexing
	description	: "Command to start the precompilation wizard."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WIZARD_PRECOMPILE_COMMAND

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

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Execution

	execute is
			-- Start the precompilation wizard.
		local
			command: STRING
		do
			create command.make (50)
			command.append (Precompilation_wizard_command_name)
			command.append (" ")
			command.append (precompilation_wizard_resources_directory)

			launch(command)
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Wizard_precompile
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_wizard_precompile
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Wizard_precompile
		end

	description: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Wizard_precompile
		end

	name: STRING is "Precompile_wizard"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {NONE} -- Private constants

	precompilation_wizard_command_name: FILE_NAME is
			-- Command to be executed to launch the precompilation wizard.
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"bench", "wizards", "precompile", "spec", Eiffel_platform, "bin">>)
			Result.set_file_name ("wizard")
		end

	precompilation_wizard_resources_directory: DIRECTORY_NAME is
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<"bench", "wizards", "precompile">>)
		end

end -- class EB_WIZARD_PRECOMPILE_COMMAND
