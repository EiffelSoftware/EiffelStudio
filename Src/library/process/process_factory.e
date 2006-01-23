indexing
	description: "A factory to generate proper process launcher on different platforms."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_FACTORY

feature
	process_launcher (a_file_name: STRING; args: LIST [STRING]; a_working_directory: STRING): PROCESS is
			-- Get a process launcher to launch program `a_file_name'  with arguments `args', 
			-- and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.
			-- Apply Void to `args' if no argument is necessary.			
		require
			a_file_name_not_null: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty	
				
		local
			prc: PROCESS_IMP
		do
			create prc.make (a_file_name, args, a_working_directory)
			Result := prc
		ensure
			process_launched_created: Result /= Void
		end
		
	process_launcher_with_command_line (a_cmd_line: STRING; a_working_directory: STRING): PROCESS is
			-- Get a process launcher to launch `cmd_line' as command line in which executable and 
			-- arguments are included and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.		
		require
			command_line_not_null: a_cmd_line /= Void
			command_line_not_empty: not a_cmd_line.is_empty		
		local
			prc: PROCESS_IMP
		do
			create prc.make_with_command_line (a_cmd_line, a_working_directory)
			Result := prc
		ensure
			process_launched_created: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
