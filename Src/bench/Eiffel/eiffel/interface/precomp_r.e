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

	retrieve_precompiled (precompiled_options: HASH_TABLE [D_PRECOMPILED_SD, STRING]) is
			-- Initialize the system with precompiled information
			-- contained in `precompiled_options' as specified in the
			-- default clause of the Ace file.
		require
			precompiled_options_not_void: precompiled_options /= Void
			not_empty: not precompiled_options.empty
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd52: VD52;
			sys: SYSTEM_I;
			workb: WORKBENCH_I
		do
			project_dir := precompiled_project_directory (precompiled_options);
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
						precompiled_options.item (project_dir.dollar_name).rename_clusters (Universe);
						Workbench.set_system (sys);
		
						Eiffel_project.set_system (project.system);
						project_dir.set_has_precompiled_preobj (sys.has_precompiled_preobj);
						sys.set_precompilation (False);
						sys.set_has_precompiled_preobj (False);
						Workbench.precompiled_directories.force (project_dir, sys.compilation_id);
						Workbench.set_precompiled_driver (project_dir.precompiled_driver);
						Workbench.set_melted_file_name (project_dir.system_name);
						set_precomp_dir;
						sys.init_counters;
						if merge_project_names /= Void then
							merge_precompiled (precompiled_options);
							merge_project_names := Void
						else
							sys.server_controler.init
						end
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
		(precompiled_options: HASH_TABLE [D_PRECOMPILED_SD, STRING]):
		REMOTE_PROJECT_DIRECTORY is
			-- Precompiled project directory containing all other
			-- precompiled libraries listed in `precompiled_options'
		require
			precompiled_options_not_void: precompiled_options /= Void
			not_empty: not precompiled_options.empty
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			precomp_info, info: PRECOMP_INFO;
			project_name: STRING;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd45: VD45;
			vd52: VD52;
			nb, size: INTEGER;
			precomp_ids: HASH_TABLE [INTEGER, STRING];
			dir_name: STRING;
			id: INTEGER
		do
			!! precomp_ids.make (15);
			from
				precompiled_options.start
			until
				precompiled_options.after
			loop
				!! project_dir.make (precompiled_options.key_for_iteration);
	
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
						dir_name := precompiled_options.key_for_iteration;
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
						if
							info.count > nb or (info.count = nb and
							info.compilation_size > size)
						then
							nb := info.count;
							size := info.compilation_size;
							precomp_info := info;
							Result := project_dir
						end
					end
				end;
				precompiled_options.forth
			end;
			!! merge_project_names.make;
			from
				precompiled_options.start
			until
				precompiled_options.after
			loop
				project_name := precompiled_options.key_for_iteration;
				if not project_name.is_equal (Result.dollar_name) then
					if not precomp_info.has (project_name) then
						merge_project_names.extend (project_name)
					end
				end;
				precompiled_options.forth
			end;
			if merge_project_names.empty then
				merge_project_names := Void
			end
		ensure
			valid_project: Result /= Void implies Result.is_valid
		rescue
			merge_project_names := Void
		end

	merge_project_names: LINKED_LIST [STRING]
			-- Name of precompiled projects to be merged

	merge_precompiled (precompiled_options: HASH_TABLE [D_PRECOMPILED_SD, STRING]) is
			-- Merge precompiled project listed in `merge_project_names'
			-- to current system.
		require
			merge_project_names_not_void: merge_project_names /= Void
			precompiled_options_not_void: precompiled_options /= Void
		local
			precomp_name: STRING;
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: PROJECT_EIFFEL_FILE;
			vd41: VD41;
			vd52: VD52;
			sys: SYSTEM_I
		do
			from
				merge_project_names.start
			until
				merge_project_names.after
			loop
					-- The project validity has already been checked
					-- in `precompiled_project_directory'.
				precomp_name := merge_project_names.item;
				!! project_dir.make (precomp_name);
				project_eif := project_dir.project_eif_file;
				project := project_eif.retrieved_project;
					-- Check that it is a precompiled cluster
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
						vd52.set_precompiled_version (project_eif.project_version_number);
						vd52.set_compiler_version (version_number);
						Error_handler.insert_error (vd52);
						Error_handler.raise_error
					end
				else
					sys := project.saved_workbench.system
					if sys /= Void and then sys.is_precompiled then
						project_dir.set_has_precompiled_preobj (sys.has_precompiled_preobj);
						project_dir.set_licensed (sys.licensed_precompilation)
						project_dir.set_system_name (sys.system_name)
						Workbench.precompiled_directories.force (project_dir, sys.compilation_id);
						precompiled_options.item (precomp_name).rename_clusters (project.saved_workbench.universe)
						Workbench.merge (project.saved_workbench)
					else
						!! vd41;	
						vd41.set_path (project_dir.name);
						Error_handler.insert_error (vd41);
						Error_handler.raise_error
					end
				end;
				merge_project_names.forth
			end
		end

end -- class PRECOMP_R
