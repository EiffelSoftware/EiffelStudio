indexing
	description: "A factory to generate proper process launcher on different platforms."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_FACTORY

feature -- Access

	process_launcher (a_file_name: STRING; args: LIST [STRING]; a_working_directory: STRING): PROCESS is
			-- Returns a process launcher used to launch program `a_file_name' with arguments `args'
			-- and working directory `a_working_directory'.
			-- Use Void for `a_working_directory' if no working directory is specified.
			-- Use Void for `args' if no arguments are required.			
		require
			a_file_name_not_null: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		do
			create {PROCESS_IMP} Result.make (a_file_name, args, a_working_directory)
		ensure
			process_launched_created: Result /= Void
		end

	process_launcher_with_command_line (a_cmd_line: STRING; a_working_directory: STRING): PROCESS is
			-- Returns a process launcher to launch command line `cmd_line' that specifies an executable and
			-- optional arguments, using `a_working_directory' as its working directory.
			-- Use Void for `a_working_directory' if no working directory is required.		
		require
			command_line_not_null: a_cmd_line /= Void
			command_line_not_empty: not a_cmd_line.is_empty
		do
			create {PROCESS_IMP} Result.make_with_command_line (a_cmd_line, a_working_directory)
		ensure
			process_launched_created: Result /= Void
		end

	current_process_info: PROCESS_INFO is
			-- Return an object representation of current process information
		do
			create {PROCESS_INFO_IMP} Result
		ensure
			result_attached: Result /= Void
		end

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
