

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

	Generation_path: STRING is
			-- Path to the generation directory
		do
-- FIXME
--	Generation_path should return TWO different strings
--	One in workbench mode, one in final mode.
			if False then
				Result := Final_generation_path
			else
				Result := Workbench_generation_path
			end;
		end;

	Workbench_generation_path: STRING is
		once
			!!Result.make (Project_directory.name.count + 7);
			Result.append (Project_directory.name);
			Result.append ("/C_code")
		end;

	Final_generation_path: STRING is
		once
			!!Result.make (Project_directory.name.count + 10);
			Result.append (Project_directory.name);
			Result.append ("/Finalized")
		end;

	Create_generation_directory is
		local
			d: DIRECTORY
		once
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
			!!Result.make (Project_directory.name.count + 6);
			Result.append (Project_directory.name);
			Result.append ("/COMP")
		end;

	Create_compilation_directory is
			-- Directory where the compilation files are generated
		local
			d: DIRECTORY
		once
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

	storing_name: STRING is "/.workbench";

	Precompilation_path: STRING is
			-- Path to the precompilation directory
		once
			!!Result.make (Precompilation_directory.name.count + 6);
			Result.append (Precompilation_directory.name);
			Result.append ("/COMP")
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
