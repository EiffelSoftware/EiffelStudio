

class PROJECT_CONTEXT


inherit
	SYSTEM_CONSTANTS;
	SHARED_WORKBENCH

feature {NONE} -- Status report

	Project_read_only: BOOLEAN_REF is
			-- Is the project only usable for browing and debugging
			-- (no compilation)?
		once
			!! Result
		end;

	is_project_readable: BOOLEAN is
			-- May the project be used for browsing and debugging?
		do
			Result :=
				(Update_file.exists and then Update_file.is_readable) and then
				System.server_controler.is_readable
		end;

	is_project_writable: BOOLEAN is
			-- May the project be both compiled and used for browsing?
		local
			w_code_dir, f_code_dir, comp_dir: RAW_FILE;
			project_file: RAW_FILE
		do
			!! w_code_dir.make (Workbench_generation_path);
			!! f_code_dir.make (Final_generation_path);
			!! comp_dir.make (Compilation_path);
			!! project_file.make (Project_file_name);
			Result := project_file.is_writable and then
				Update_file.exists and then
				(Update_file.is_readable and Update_file.is_writable) and then
				(w_code_dir.exists and then w_code_dir.is_writable) and then
				(f_code_dir.exists and then f_code_dir.is_writable) and then
				(f_code_dir.exists and then comp_dir.is_writable) and then
				System.server_controler.is_writable
		end;

feature {NONE}

	Update_file: RAW_FILE is
			-- File containing all the byte code to update
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Workbench_generation_path);
			file_name.set_file_name (Updt);
			!!Result.make (file_name.path)
		end;

	Project_directory: PROJECT_DIR is
			-- Shared project directory
		once
			Result := init_project_directory
		end;

	Precompilation_directory: PROJECT_DIR is
			-- Shared precompilation directory
		once
			Result := init_precompilation_directory
		end;

	init_project_directory: PROJECT_DIR is do end;
	init_precompilation_directory: PROJECT_DIR is do end;

	Project_directory_name: STRING is
		once
			Result := Project_directory.name
		end;

	Case_storage_path: STRING is
		local
			directory_name: DIRECTORY_NAME
		once
			!!directory_name.make_from_string (Project_directory_name);
			directory_name.extend_from_array (<<Casegen , Case_storage>>);
			Result := directory_name.path
		end;

	Case_gen_path: STRING is
		local
			directory_name: DIRECTORY_NAME
		once
			!!directory_name.make_from_string (Project_directory_name);
			directory_name.extend (Casegen);
			Result := directory_name.path
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

	Eiffel_gen_path: STRING is
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Project_directory_name);
			dir_name.extend (Eiffelgen);
			Result := dir_name.path
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

	Workbench_generation_path: STRING is
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Project_directory_name);
			dir_name.extend_from_array (<<Eiffelgen, W_code>>);
			Result := dir_name.path
		end;

	Final_generation_path: STRING is
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Project_directory_name);
			dir_name.extend_from_array (<<Eiffelgen, F_code>>);
			Result := dir_name.path
		end;

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

	Compilation_path: STRING is
			-- Path to the compilation directory
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Project_directory_name);
			dir_name.extend_from_array (<<Eiffelgen, Comp>>);
			Result := dir_name.path
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

	Project_file_name: STRING is
			-- Full name of the file where the workbench is stored
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Project_directory_name);
			file_name.extend (Eiffelgen);
			file_name.set_file_name (Dot_workbench);
			Result := file_name.path
		end;

	Precompilation_path: STRING is
			-- Path to the precompilation directory
		local
			dir_name: DIRECTORY_NAME
		once
			!!dir_name.make_from_string (Precompilation_directory.name);
			dir_name.extend_from_array (<<Eiffelgen, Comp>>);
			Result := dir_name.path
		end;

	Precompilation_file_name: STRING is
			-- Full name of the file where the precompiled 
			-- workbench is stored
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Precompilation_directory.name);
			file_name.extend (Eiffelgen);
			file_name.set_file_name (Dot_workbench);
			Result := file_name.path
		end;

	Precompilation_preobj: STRING is
			-- Full name of the `preobj' object file
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Precompilation_directory.name);
			file_name.extend_from_array (<<Eiffelgen, W_code>>);
			file_name.set_file_name (Preobj);
			Result := file_name.path
		end;

	Precompilation_driver: STRING is
			-- Full name of the `preobj' object file
		local
			file_name: FILE_NAME
		once
			!!file_name.make_from_string (Precompilation_directory.name);
			file_name.extend_from_array (<<Eiffelgen, W_code>>);
			file_name.set_file_name (Driver);
			Result := file_name.path
		end;

end
