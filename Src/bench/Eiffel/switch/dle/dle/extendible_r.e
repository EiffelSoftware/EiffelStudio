-- Retrieve the "project.eif" of the dynamically extendible project

class EXTENDIBLE_R

inherit

	WINDOWS;
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	PROJECT_CONTEXT;
	COMPILER_EXPORTER;
	SHARED_EIFFEL_PROJECT

feature

	retried: BOOLEAN;

	retrieve_extendible (extendible_project_name: STRING) is
			-- Initialize the system with information contained in 
			-- the dynamically extendible project directory.
		require
			project_name_not_void: extendible_project_name /= Void
		local
			project_name: STRING;
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: RAW_FILE;
			workb: WORKBENCH_I;	
			precomp_r: PRECOMP_R;
			v9ds: V9DS;
			dle_system: DLE_SYSTEM_I
		do
			if not retried then
				!! project_dir.make (extendible_project_name);

				project_dir.check_extendible;
				Error_handler.checksum;

				if project_dir.is_valid then
					!! project_eif.make_open_read (project_dir.project_eif);
					project ?= project_eif.retrieved;
					project_eif.close;

						-- Check that it is a dynamically extendible system.
					if project /= Void then
						workb := project.saved_workbench
					end;
					if workb /= Void and then 
						workb.system.extendible
					then
						Workbench.set_precompiled_directories 
									(workb.precompiled_directories);
						Workbench.set_precompiled_driver
									(workb.precompiled_driver);
						Workbench.set_extendible_directory (project_dir);
						set_extendible_dir;
						Universe.copy (workb.universe);
							-- Do not call the once function `System' directly
							-- since it's value will be replaced later on
							-- (the system describes a Dynamic Class Set).
						!! dle_system;
						Workbench.set_system (dle_system);
debug ("DLE SYSTEM")
io.error.put_string ("The DLE `System' has just been initialized.");
io.error.new_line
end;
						Eiffel_project.set_system (project.system);
						dle_system.extending (workb.system);
						if dle_system.uses_precompiled then
							!! precomp_r;
							precomp_r.set_precomp_dir
						end;
						dle_system.init_counters;
						dle_system.server_controler.init;
						Universe.update_cluster_paths
					else
						!! v9ds;
						v9ds.set_path (project_dir.name);
						Error_handler.insert_error (v9ds);
						Error_handler.raise_error
					end
				end
			else
				if 
					project_eif /= Void and then 
					not project_eif.is_closed 
				then
					project_eif.close
				end;
				retried := False;
				!! v9ds;
				v9ds.set_path (project_dir.name);
				Error_handler.insert_error (v9ds);
				Error_handler.raise_error
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end;

	set_extendible_dir is
			-- Creates the once function `Extendible_directory'
		local
			extendible_dir: REMOTE_PROJECT_DIRECTORY
		do
			extendible_dir := Workbench.extendible_directory;
			extendible_dir.update_path;
			Extendible_directory.copy (extendible_dir)
		end;
			
end
