-- Retrive the workbench of the precompiled project

class PRECOMP_R

inherit

	SHARED_WORKBENCH;
	SHARED_ENV;
	PROJECT_CONTEXT
		redefine
			init_precompilation_directory
		end;

feature

	init_precompilation_directory: PROJECT_DIR;

	retrieve_precompiled (precompiled_project_name: STRING) is
			-- Initialize the system with precompiled
			-- information contained in `project_dir'.
		local
			project_name: STRING;
			project_dir: PROJECT_DIR;
			workb: WORKBENCH_I;
			workbench_file: UNIX_FILE;
			error_occurred: BOOLEAN;
			freeze: BOOLEAN;
		do
			project_name := Environ.interpret (precompiled_project_name);
			!! project_dir.make (project_name);
			if project_dir.valid and project_dir.exists then
				init_precompilation_directory := project_dir;
				if Precompilation_directory /= Precompilation_directory then end;
				!!workb;
				!!workbench_file.make_open_read (Precompilation_file_name);
				workb ?= workb.retrieved (workbench_file);

				-- Check that it is a precompiled cluster

				if (workb /= Void) and then workb.system.precompilation then
					freeze := System.freeze;

					Universe.copy (workb.universe);
					System.copy (workb.system);

					System.set_freeze (freeze);

					System.server_controler.init;
					System.set_precompilation (False);
					Workbench.set_precompiled_directory_name (project_name);
				else
					io.error.putstring (project_name);
					io.error.putstring (" is not a precompiled system%N");
					error_occurred := True
				end;
			else
				io.error.putstring (project_name);
				io.error.putstring (" is not a valid project name%N");
				error_occurred := True;
			end;
			if error_occurred then
				die (1);
			end;
		end;

	set_precomp_dir is
			-- Creates the once function `Precompilation_directory'
		local
			project_dir: PROJECT_DIR;
		do
			!!project_dir.make (workbench.precompiled_directory_name);
			init_precompilation_directory := project_dir;
			if Precompilation_directory /= Precompilation_directory then end;
		end;

end
