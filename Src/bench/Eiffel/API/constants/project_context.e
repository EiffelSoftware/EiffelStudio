

class PROJECT_CONTEXT

	
feature {NONE}

	Project_directory: PROJECT_DIR is
			-- Shared project directory
		once
			Result := init_project_directory
		end;

	init_project_directory: PROJECT_DIR is do end;

	Generation_path: STRING is
			-- Path to the generation directory
		once
			!!Result.make (Project_directory.name.count + 7);
			Result.append (Project_directory.name);
			Result.append ("/C_code")
		end;

	Generation_directory: DIRECTORY is
			-- Directory where the C code is generated
		once
			!!Result.make (Generation_path);
			if not Result.exists then
				Result.create
			end;
		end;

	Compilation_path: STRING is
			-- Path to the compilation directory
		once
			!!Result.make (Project_directory.name.count + 6);
			Result.append (Project_directory.name);
			Result.append ("/COMP")
		end;

	Compilation_directory: DIRECTORY is
			-- Directory where the compilation files are generated
		once
			!!Result.make (compilation_path);
			if not Result.exists then
				Result.create
			end
		end;

	Project_file_name: STRING is
			-- Full name of the file where the workbench is stored
		once
			!!Result.make (Project_directory.name.count + 8);
			Result.append (Project_directory.name);
			Result.append (storing_name)
		end;

	storing_name: STRING is "/.workbench"

end
