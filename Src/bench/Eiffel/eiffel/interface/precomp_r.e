indexing

	description: 
		"Retrieve the `project.eif' of the precompiled project.";
	date: "$Date$";
	revision: "$Revision $"

class PRECOMP_R

inherit

	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	PROJECT_CONTEXT;
	COMPILER_EXPORTER;
	SHARED_EIFFEL_PROJECT;
	SHARED_WORKBENCH;
	SHARED_CONFIGURE_RESOURCES

feature

	retrieve_precompiled (precompiled_project: PAIR [D_PRECOMPILED_SD, STRING]) is
			-- Initialize the system with precompiled information
			-- contained in `precompiled_project' as specified in the
			-- default clause of the Ace file.
		require
			precompiled_project_not_void: precompiled_project /= Void
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd52: VD52;
			sys: SYSTEM_I;
			workb: WORKBENCH_I
		do
			project_dir := precompiled_project_directory (precompiled_project);
			if project_dir /= Void then
				project_eif := project_dir.project_eif_file;
				project := project_eif.retrieved_project;
				if project_eif.error then
					if project_eif.is_interrupted then
						Error_handler.insert_interrupt_error (True)
					elseif project_eif.is_corrupted then
						!! vd41;
						vd41.set_path (project_dir.name);
						Error_handler.insert_error (vd41);
						Error_handler.raise_error
					else
							-- Must be incompatible version
						!! vd52;	
						vd52.set_path (project_dir.name);
						vd52.set_precompiled_version 
								(project_eif.project_version_number);
						vd52.set_compiler_version (version_number);
						Error_handler.insert_error (vd52);
						Error_handler.raise_error
					end
				else
						-- Check that it is a precompiled cluster
					sys := project.saved_workbench.system
					if sys /= Void and then sys.is_precompiled then
						workb := project.saved_workbench;
						Workbench.set_precompiled_directories (workb.precompiled_directories);
						Universe.copy (workb.universe);
						precompiled_project.first.rename_clusters (Universe);
						Workbench.set_system (sys);
		
						Eiffel_project.set_system (project.system);
						project_dir.set_has_precompiled_preobj (sys.has_precompiled_preobj);
						sys.set_precompilation (False);
						sys.set_has_precompiled_preobj (False);
						Workbench.precompiled_directories.force (project_dir, sys.compilation_id);
						Workbench.set_precompiled_driver (project_dir.precompiled_driver);
						Workbench.set_melted_file_name (project_dir.system_name);
						set_precomp_dir;
						sys.init_counters
						sys.server_controler.init
						Universe.update_cluster_paths
					else
						!! vd41;	
						vd41.set_path (project_dir.name);
						Error_handler.insert_error (vd41);
						Error_handler.raise_error
					end;
				end
			end
		end;

	set_precomp_dir is
			-- Update precompilation related once functions.
		require	
			driver_not_void: Workbench.precompiled_driver /= Void
		local
			precomp_dirs: EXTEND_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
		do
			Precompilation_driver.make_from_string
					(Workbench.precompiled_driver)
			precomp_dirs := Workbench.precompiled_directories;
			from 
				precomp_dirs.start 
			until 
				precomp_dirs.after 
			loop
				precomp_dirs.item_for_iteration.update_path;
				precomp_dirs.forth
			end;
			Precompilation_directories.copy (precomp_dirs)
		end;

	check_version_number is
			-- Check the version number for all precompilation.
			-- Raise an error if there an incompatible version.
		require	
			driver_not_void: Workbench.precompiled_driver /= Void
		local
			precomp_dirs: EXTEND_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
		do
			Precompilation_driver.make_from_string (Workbench.precompiled_driver)
			precomp_dirs := Workbench.precompiled_directories;
			from 
				precomp_dirs.start 
			until 
				precomp_dirs.after 
			loop
				precomp_dirs.item_for_iteration.check_version_number 
					(precomp_dirs.key_for_iteration);
				precomp_dirs.forth
			end;
		end;

feature {NONE} -- Implementation

	precompiled_project_directory
		(precompiled_project: PAIR [D_PRECOMPILED_SD, STRING]): REMOTE_PROJECT_DIRECTORY is
			-- Precompiled project directory containing all other
			-- precompiled libraries listed in `precompiled_project'
		require
			precompiled_project_not_void: precompiled_project /= Void
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			info: PRECOMP_INFO;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd45: VD45;
			vd52: VD52;
			precomp_ids: HASH_TABLE [INTEGER, STRING];
			dir_name: STRING;
			id: INTEGER
		do
			!! precomp_ids.make (15);
			!! project_dir.make (precompiled_project.second);

			project_dir.check_precompiled;
			Error_handler.checksum;

			if project_dir.is_valid then
				project_eif := project_dir.precomp_eif_file;
				info := project_eif.retrieved_precompile;
				if project_eif.error then
					if project_eif.is_interrupted then
						Error_handler.insert_interrupt_error (True)
					elseif project_eif.is_corrupted then
						!! vd41;	
						vd41.set_path (project_dir.name);
						Error_handler.insert_error (vd41);
						Error_handler.raise_error
					else
						-- Must be incompatible version
						!! vd52;	
						vd52.set_path (project_dir.name);
						vd52.set_precompiled_version 
							(project_eif.project_version_number);
						vd52.set_compiler_version (version_number);
						Error_handler.insert_error (vd52);
						Error_handler.raise_error
					end
				else
					project_dir.set_licensed (info.licensed)
					project_dir.set_system_name (info.name)
					from info.start until info.after loop
						dir_name := info.key_for_iteration;
						id := info.item_for_iteration;
						if precomp_ids.has (dir_name) then
								-- Check compatibility between
								-- precompiled libraries.
							if id /= precomp_ids.found_item then
								!! vd45;	
								vd45.set_path (dir_name);
								Error_handler.insert_error (vd45);
								Error_handler.raise_error
							end
						else
							precomp_ids.put (id, dir_name)
						end;
						info.forth
					end;
					dir_name := precompiled_project.second;
					id := info.compilation_id;
					if precomp_ids.has (dir_name) then
							-- Check compatibility between
							-- precompiled libraries.
						if id /= precomp_ids.found_item then
							!! vd45;	
							vd45.set_path (dir_name);
							Error_handler.insert_error (vd45);
							Error_handler.raise_error
						end
					else
						precomp_ids.put (id, dir_name)
					end;
					Result := project_dir
				end
			end;
		ensure
			valid_project: Result /= Void implies Result.is_valid
		end

end -- class PRECOMP_R
