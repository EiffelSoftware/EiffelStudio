indexing
	description: "Task used for initializing directories where EiffelCOM Wizard will generate files"
	date: "$date"
	revision: "$revision"

class
	WIZARD_DIRECTORY_INITIALIZATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

feature -- Access

	title: STRING is "Initializing Generation:"
			-- Task title

	steps_count: INTEGER is 12
			-- Number of steps involved in task

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		local
			l_path, l_path2: STRING
		do
			l_path := environment.destination_folder.twin
			initialize_subdirectory (l_path, "Common")
			progress_report.step
			l_path2 := l_path.twin
			l_path2.append ("Common\")
			initialize_clib_include (l_path2)
			progress_report.step
			initialize_subdirectory (l_path2, "Interfaces")
			progress_report.step
			initialize_subdirectory (l_path2, "Structures")
			progress_report.step
			initialize_subdirectory (l_path, "Client")
			progress_report.step
			l_path2 := l_path.twin
			l_path2.append ("Client\")
			initialize_clib_include (l_path2)
			progress_report.step
			initialize_subdirectory (l_path2, "Component")
			progress_report.step
			initialize_subdirectory (l_path2, "Interface_proxy")
			progress_report.step
			initialize_subdirectory (l_path, "Server")
			progress_report.step
			l_path2 := l_path.twin
			l_path2.append ("Server\")
			initialize_clib_include (l_path2)
			progress_report.step
			initialize_subdirectory (l_path2, "Component")
			progress_report.step
			initialize_subdirectory (l_path2, "Interface_stub")
			progress_report.step
		end

	initialize_clib_include (a_path: STRING) is
			-- Initialize sub-directories `Clib' and `Include' of directory `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			initialize_subdirectory (a_path, "Clib")
			initialize_subdirectory (a_path, "Include")
		end

	initialize_subdirectory (a_path, a_subdirectory: STRING) is
			-- Initialize sub-directory `a_subdirectory' from directory `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_subdirectory: a_subdirectory /= Void
			valid_subdirectory: not a_subdirectory.is_empty
		local
			l_path: STRING
		do
			create l_path.make (a_path.count + a_subdirectory.count)
			l_path.append (a_path)
			l_path.append (a_subdirectory)
			initialize_directory (l_path)
		end
	
	initialize_directory (a_path: STRING) is
			-- Initialize directory `a_path'
		require
			non_void_path: a_path /= Void
		local
			l_file: RAW_FILE
			l_string: STRING
			l_directory: DIRECTORY
		do
			create l_file.make (a_path)
			if l_file.exists then
				if not l_file.is_directory then
					if environment.backup then
						l_string := "File already exists: "
						l_string.append (a_path)
						message_output.add_warning (Current, l_string)
						message_output.add_message (Current, "File backed up with extension %".bac%"")
						l_string := a_path.twin
						l_string.append (".bac")
						file_copy (a_path, l_string)
					end
					file_delete (a_path)
					create l_directory.make (a_path)
					check
						not_exists: not l_directory.exists
					end
					l_directory.create_dir
				end
			else
				create l_directory.make (a_path)
				check
					not_exists: not l_directory.exists
				end
				l_directory.create_dir
			end
	end

end -- class WIZARD_DIRECTORY_INITIALIZATION_TASK
