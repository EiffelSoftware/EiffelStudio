-- Retrieve the "project.eif" of the precompiled project

class PRECOMP_R

inherit

	WINDOWS;
	SHARED_WORKBENCH;
	SHARED_ENV;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	PROJECT_CONTEXT
		redefine
			init_precompilation_directory
		end

feature

	init_precompilation_directory: PROJECT_DIR;

	retried: BOOLEAN;

	retrieve_precompiled (precompiled_project_name: STRING) is
			-- Initialize the system with precompiled
			-- information contained in `project_dir'.
		local
			project_name: STRING;
			project_dir: PROJECT_DIR;
			workb: WORKBENCH_I;
			workbench_file: RAW_FILE;
			freeze: BOOLEAN;
			vd41: VD41
		do
			if not retried then
				project_name := Environ.interpret (precompiled_project_name);
				!! project_dir.make (project_name);
	
				project_dir.check_precompiled;
				Error_handler.checksum;
	
				if project_dir.is_valid then
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
						Universe.update_cluster_paths
					else
						!! vd41;	
						vd41.set_path (project_name);
						Error_handler.insert_error (vd41);
						Error_handler.raise_error
					end;
				end;
			else
				retried := False;
				!! vd41;	
				vd41.set_path (project_name);
				Error_handler.insert_error (vd41);
				Error_handler.raise_error
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
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
