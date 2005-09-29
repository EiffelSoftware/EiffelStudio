indexing
	description: "A factory to generate proper process launcher on different platforms."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_FACTORY

feature
	new_process_launcher (fname: STRING; a_working_directory: STRING; args: LIST [STRING]): PROCESS is
			-- Get a process launcher to launch
			-- program `fname' in `a_working_directory' and 
			-- with arguments stored in `args'
		require
			file_name_not_null: fname /= Void
			file_name_not_empty: not fname.is_empty		
		local
			prc: PROCESS_IMP
		do
			create prc.make (fname, a_working_directory, args)
			Result := prc
		ensure
			process_launched_created: Result /= Void
		end
		
	new_process_launcher_with_command_line (c_line: STRING; a_working_directory: STRING): PROCESS is
			-- Get a process launcher to launch
			-- program `c_line' which contains arguments in it in `a_working_directory'
		require
			command_line_not_null: c_line /= Void
			command_line_not_empty: not c_line.is_empty		
		local
			prc: PROCESS_IMP
		do
			create prc.make_with_command_line (c_line, a_working_directory)
			Result := prc
		ensure
			process_launched_created: Result /= Void
		end
		
end
