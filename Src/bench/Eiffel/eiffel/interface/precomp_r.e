indexing

	description: 
		"Retrieve the `project.eif' of the precompiled project.";
	date: "$Date$";
	revision: "$Revision $"

class PRECOMP_R

inherit

	WINDOWS;
	SHARED_ENV;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	PROJECT_CONTEXT;
	COMPILER_EXPORTER;
	SHARED_EIFFEL_PROJECT;
	SHARED_WORKBENCH

feature

	retried: BOOLEAN;

	retrieve_precompiled (precompiled_project_name: STRING) is
			-- Initialize the system with precompiled
			-- information contained in `project_dir'.
		local
			project_name: STRING;
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: RAW_FILE;
			freeze: BOOLEAN;
			vd41: VD41;
			sys: SYSTEM_I
		do
			if not retried then
				project_name := Environ.interpret (precompiled_project_name);
				!! project_dir.make (project_name);
	
				project_dir.check_precompiled;
				Error_handler.checksum;
	
				if project_dir.is_valid then
					Precompilation_directory.make_from_string (project_name)
					!! project_eif.make_open_read (Precompilation_file_name);
					project ?= Eiffel_project.retrieved (project_eif);
					project_eif.close;
					-- Check that it is a precompiled cluster
	
					sys := project.saved_workbench.system;
					if (project /= Void) and then sys.is_precompiled then
						Universe.copy (project.saved_workbench.universe);
						Workbench.set_system (sys);
		
						sys.server_controler.init;
						Eiffel_project.set_system (project.system);
						sys.set_precompilation (False);
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
				if 
					project_eif /= Void and then 
					not project_eif.is_closed 
				then
					project_eif.close
				end;
				retried := False;
				!! vd41;	
				vd41.set_path (project_name);
				Error_handler.insert_error (vd41);
				Error_handler.raise_error
			end
		rescue
			if Rescue_status.is_unexpected_exception then
print ("retrying...%N");
				--retried := True;
				--retry
			end;
		end;

	set_precomp_dir is
			-- Creates the once function `Precompilation_directory'
		do
			Precompilation_directory.make_from_string 
						(Workbench.precompiled_directory_name);
		end;

end -- class PRECOMP_R
