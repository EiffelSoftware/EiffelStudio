indexing
	description: "Command used to launch ISE Assembly Manager (Windows implementation)"

class
	EB_DOTNET_IMPORT_CMD_IMP

feature -- Basic operations

	launch_and_refresh (a_command_line, a_working_directory: STRING; a_refresh_handler: ROUTINE [ANY, TUPLE]) is
			-- Display `ISE.AssemblyManager' and refresh EiffelStudio development window.
		require
			non_void_command_line: a_command_line /= Void
			valid_command_line: not a_command_line.is_empty
			non_void_working_directory: a_working_directory /= Void		
		local
			process_launcher: WEL_PROCESS_LAUNCHER
		do
			create process_launcher
			process_launcher.launch_and_refresh (a_command_line, a_working_directory, a_refresh_handler)
		end
				
end -- class EB_DOTNET_IMPORT_CMD_IMP
