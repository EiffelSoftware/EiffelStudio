indexing

	description: 
		"Directories management for an Eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_CONTEXT

inherit

	SYSTEM_CONSTANTS

feature {NONE} -- Eiffel Project Directories

	Update_file: RAW_FILE is
			-- File containing all the byte code to update
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Workbench_generation_path);
			file_name.set_file_name (Updt);
			!!Result.make (file_name)
		end;

	Project_directory: DIRECTORY_NAME is
			-- Shared project directory
		once
			!! Result.make
		end;

	Precompilation_directories: EXTEND_TABLE [REMOTE_PROJECT_DIRECTORY,INTEGER] is
			-- Shared precompilation directories, indexed by precompilation ids
		once
			!! Result.make (5)
		end

	Backup_path: DIRECTORY_NAME is
			-- Path to the backup directory
		once
			!! Result.make_from_string (Project_directory);
			Result.extend_from_array (<<Eiffelgen, Backup>>);
		end;

	Case_storage_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.extend_from_array (<<Casegen , Case_storage>>);
		end;

	Case_gen_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.extend (Casegen);
		end;

	Documentation_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.extend (Documentation);
		end;

	Eiffel_gen_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.extend (Eiffelgen);
		end;

	Workbench_generation_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.extend_from_array (<<Eiffelgen, W_code>>);
		end;

	Final_generation_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.extend_from_array (<<Eiffelgen, F_code>>);
		end;

	Compilation_path: DIRECTORY_NAME is
			-- Path to the compilation directory
		once
			!! Result.make_from_string (Project_directory);
			Result.extend_from_array (<<Eiffelgen, Comp>>);
		end;

	Project_file_name: FILE_NAME is
			-- Full name of the file where the workbench is stored
		once
			!! Result.make_from_string (Project_directory);
			Result.extend (Eiffelgen);
			Result.set_file_name (Dot_workbench);
		end;

	Project_txt_name: FILE_NAME is
			-- Full name of the file where the project text is stored
		once
			!! Result.make_from_string (Project_directory);
			Result.extend (Eiffelgen);
			Result.set_file_name (Project_txt);
		end;

	Precompilation_file_name: FILE_NAME is
			-- Full name of file where current precompilation
			-- information is stored
		do
			!! Result.make_from_string (Project_directory);
			Result.extend (Eiffelgen);
			Result.set_file_name (Precomp_eif);
		end

	Precompilation_driver: FILE_NAME is
			-- Full name of the precompilation driver used
		once
			!! Result.make
		end;

feature {NONE} -- Directory creation

	Create_generation_directory is
		local
			d: DIRECTORY
		once
			Create_eiffel_gen_directory;
			!!d.make (Final_generation_path);
			if not d.exists then
				d.create
			end;
			!!d.make (Workbench_generation_path);
			if not d.exists then
				d.create
			end;
		end;

	Create_case_storage_directory is
		local
			d: DIRECTORY
		do
			!!d.make (Case_gen_path);
			if not d.exists then
				d.create
			end;
			!!d.make (Case_storage_path);
			if not d.exists then
				d.create
			end;
		end;

	Create_eiffel_gen_directory is
		local
			d: DIRECTORY
		once
			!!d.make (Eiffel_gen_path);
			if not d.exists then
				d.create
			end;
		end;

	Create_compilation_directory is
			-- Directory where the compilation files are generated
		local
			d: DIRECTORY
		once
			Create_eiffel_gen_directory;
			!!d.make (compilation_path);
			if not d.exists then
				d.create
			end
		end;

feature {NONE} -- DLE Directories

	Melted_dle_file: RAW_FILE is
			-- File containing all the melted byte code of the DC-set
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Workbench_generation_path);
			file_name.set_file_name (Melted_dle);
			!!Result.make (file_name)
		end;

	Extendible_directory: REMOTE_PROJECT_DIRECTORY is
			-- Directory of the project which is intended to
			-- be dynamically extended
		once
			!! Result.make ("")
		end;

	Extendible_path: DIRECTORY_NAME is
			-- Path of the system which is intended to
			-- be dynamically extended
		once
			Result := Extendible_directory.compilation_path
		end;

	Extendible_file_name: FILE_NAME is
			-- Full name of the file where the dynamically extendible
			-- project's workbench is stored
		once
			Result := Extendible_directory.project_eif
		end;

	Extendible_W_code: DIRECTORY_NAME is
			-- Workbench generation code directory of the static system
		once
			!! Result.make_from_string (Extendible_directory.name);
			Result.extend_from_array (<<Eiffelgen, W_code>>);
		end;

	Extendible_F_code: DIRECTORY_NAME is
			-- Finalization generation code directory of the static system
		once
			!! Result.make_from_string (Extendible_directory.name);
			Result.extend_from_array (<<Eiffelgen, F_code>>);
		end;

end -- class PROJECT_CONTEXT
