indexing

	description: 
		"Directories management for an Eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_CONTEXT

inherit
	SYSTEM_CONSTANTS

feature -- Eiffel Project Directories

	Project_directory_name: DIRECTORY_NAME is
			-- Shared project directory
		once
			create Result.make
		end

	Precompilation_directories: HASH_TABLE [REMOTE_PROJECT_DIRECTORY,INTEGER] is
			-- Shared precompilation directories, indexed by precompilation ids
		once
			create Result.make (5)
		end

	Backup_path: DIRECTORY_NAME is
			-- Path to the backup directory
		once
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<Eiffelgen, Backup>>);
		end

	Case_storage_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<Casegen , Case_storage>>);
		end

	Case_gen_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name);
			Result.extend (Casegen);
		end

	Documentation_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name);
			Result.extend (Documentation);
		end

	Profiler_path: DIRECTORY_NAME is
			-- Directory of the profiler's output files
		once
			create Result.make_from_string (Eiffel_gen_path);
			Result.extend (Profiler)
		end

	Eiffel_gen_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Project_directory_name);
			Result.extend (Eiffelgen);
		end

	Workbench_generation_path: DIRECTORY_NAME is
			-- Valid path for compilation
		once
			Result := temp_workbench_generation_path
		end
	
	Final_generation_path: DIRECTORY_NAME is
		once
			Result := temp_final_generation_path
		end

	Compilation_path: DIRECTORY_NAME is
			-- Path to the compilation directory
		once
			Result := temp_compilation_path
		end

	Precompilation_file_name: FILE_NAME is
			-- Full name of file where current precompilation
			-- information is stored
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend (Eiffelgen);
			Result.set_file_name (Precomp_eif);
		end

	Precompilation_driver: FILE_NAME is
			-- Full name of the precompilation driver used
		once
			create Result.make
		end

feature -- Temporary access prior to the creation or the opening of a file.

	temp_workbench_generation_path: DIRECTORY_NAME is
			-- Generate a temporary generation path
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<Eiffelgen, W_code>>);
		end

	temp_final_generation_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<Eiffelgen, F_code>>);
		end

	temp_compilation_path: DIRECTORY_NAME is
		do
			create Result.make_from_string (Project_directory_name);
			Result.extend_from_array (<<Eiffelgen, Comp>>);
		end

feature {NONE} -- Directory creation

	Create_generation_directory is
		local
			d: DIRECTORY
		once
			create_eiffel_gen_directory
			create d.make (Final_generation_path)
			if not d.exists then
				d.create_dir
			end;
			create d.make (Workbench_generation_path)
			if not d.exists then
				d.create_dir
			end
		end

	Create_case_storage_directory is
		local
			d: DIRECTORY
		do
			create d.make (Case_gen_path);
			if not d.exists then
				d.create_dir
			end;
			create d.make (Case_storage_path);
			if not d.exists then
				d.create_dir
			end;
		end

	Create_eiffel_gen_directory is
		local
			d: DIRECTORY
		once
			create d.make (Eiffel_gen_path);
			if not d.exists then
				d.create_dir
			end;
		end;

	Create_compilation_directory is
			-- Directory where the compilation files are generated
		local
			d: DIRECTORY
		once
			Create_eiffel_gen_directory;
			create d.make (compilation_path);
			if not d.exists then
				d.create_dir
			end
		end;

	Create_profiler_directory is
			-- Directory where the profiler files are generated
		local
			d: DIRECTORY
		once
			create d.make (Profiler_path);
			if not d.exists then
				d.create_dir
			end
		end

end -- class PROJECT_CONTEXT
