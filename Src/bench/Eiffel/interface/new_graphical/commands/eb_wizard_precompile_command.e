indexing
	description	: "Command to start the precompilation wizard."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WIZARD_PRECOMPILE_COMMAND

inherit
	EB_MENUABLE_COMMAND

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

end -- class EB_WIZARD_PRECOMPILE_COMMAND
