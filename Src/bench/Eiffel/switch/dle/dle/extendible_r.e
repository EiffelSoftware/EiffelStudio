-- Retrieve the "project.eif" of the dynamically extendible project

class EXTENDIBLE_R

inherit

	WINDOWS;
	SHARED_WORKBENCH;
	SHARED_ENV;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	PROJECT_CONTEXT

feature

	retried: BOOLEAN;

	retrieve_extendible (extendible_project_name: STRING) is
			-- Initialize the system with information contained in 
			-- the dynamically extendible project directory.
		local
			project_name: STRING;
			project_dir: REMOTE_PROJECT_DIRECTORY;
			workb: WORKBENCH_I;
			workbench_file: RAW_FILE;
			freeze: BOOLEAN;
			precomp_r: PRECOMP_R;
			v9ds: V9DS;
			dle_system: DLE_SYSTEM_I
		do
			if not retried then
				project_name := Environ.interpret (extendible_project_name);
				!! project_dir.make (project_name);

				project_dir.check_extendible;
				Error_handler.checksum;

				if project_dir.is_valid then
					Extendible_directory.make_from_string (project_name);
					!! workb;
					!! workbench_file.make_open_read (Extendible_file_name);
					workb ?= workb.retrieved (workbench_file);
					workbench_file.close;

						-- Check that it is a dynamically extendible system.
					if 
						workb /= Void and then 
						workb.system.extendible
					then
						Workbench.set_precompiled_directory_name 
									(workb.precompiled_directory_name);
						Workbench.set_extendible_directory_name (project_name);
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
						dle_system.extending (workb.system);
						if dle_system.uses_precompiled then
							!! precomp_r;
							precomp_r.set_precomp_dir
						end;
						dle_system.server_controler.init;
						Universe.update_cluster_paths
					else
						!! v9ds;
						v9ds.set_path (project_name);
						Error_handler.insert_error (v9ds);
						Error_handler.raise_error
					end
				end
			else
				if 
					workbench_file /= Void and then 
					not workbench_file.is_closed 
				then
					workbench_file.close
				end;
				retried := False;
				!! v9ds;
				v9ds.set_path (project_name);
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
		do
			Extendible_directory.make_from_string 
							(workbench.extendible_directory_name);
		end;
			
end
