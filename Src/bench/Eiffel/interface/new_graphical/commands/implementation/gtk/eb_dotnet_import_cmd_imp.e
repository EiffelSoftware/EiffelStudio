indexing
	description: "Do nothing on GTK."

class
	EB_DOTNET_IMPORT_CMD_IMP

feature -- Basic operations

	launch_and_refresh (a_command_line, a_working_directory: STRING; a_refresh_handler: ROUTINE [ANY, TUPLE]) is
			-- Do nothing.
		do
		end
				
end -- class EB_DOTNET_IMPORT_CMD_IMP
