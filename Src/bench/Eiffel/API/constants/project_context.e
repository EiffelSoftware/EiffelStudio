

class PROJECT_CONTEXT

	
feature {NONE}

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

	Eiffel_gen_path: STRING is
		once
			!!Result.make (Project_directory.name.count + 11);
			Result.append (Project_directory.name);
			Result.append ("/EIFFELGEN");
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
		once
			!!Result.make (Eiffel_gen_path.count + 7);
			Result.append (Eiffel_gen_path);
			Result.append ("/W_code")
		end;

	Final_generation_path: STRING is
		once
			!!Result.make (Eiffel_gen_path.count + 7);
			Result.append (Eiffel_gen_path);
			Result.append ("/F_code")
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
		once
			!!Result.make (Eiffel_gen_path.count + 6);
			Result.append (Eiffel_gen_path);
			Result.append ("/COMP")
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
		once
			!!Result.make (Project_directory.name.count + 8);
			Result.append (Project_directory.name);
			Result.append (storing_name)
		end;

	storing_name: STRING is "/EIFFELGEN/.workbench";

	Precompilation_path: STRING is
			-- Path to the precompilation directory
		once
			!!Result.make (Precompilation_directory.name.count + 6);
			Result.append (Precompilation_directory.name);
			Result.append ("/EIFFELGEN/COMP")
		end;

	Precompilation_file_name: STRING is
			-- Full name of the file where the precompiled 
			-- workbench is stored
		once
			!!Result.make (Precompilation_directory.name.count + 8);
			Result.append (Precompilation_directory.name);
			Result.append (storing_name)
		end;

end
