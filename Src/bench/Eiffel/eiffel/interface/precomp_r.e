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
	SHARED_WORKBENCH

feature

	retried: BOOLEAN;

	retrieve_precompiled (precompiled_project_names: LINKED_LIST [STRING]) is
			-- Initialize the system with precompiled
			-- information contained in `project_dir'.
		require
			project_names_not_void: precompiled_project_names /= Void
			not_empty: not precompiled_project_names.empty
			no_void_names: not precompiled_project_names.has (Void)
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			project: E_PROJECT;
			project_eif: RAW_FILE;
			vd41: VD41;
			sys: SYSTEM_I;
			workb: WORKBENCH_I
		do
			if not retried then
				project_dir :=
					precompiled_project_directory (precompiled_project_names);
				if project_dir /= Void then
					!! project_eif.make_open_read (project_dir.project_eif);
					project ?= Eiffel_project.retrieved (project_eif);
					project_eif.close;
					-- Check that it is a precompiled cluster
	
					if project /= Void then
						sys := project.saved_workbench.system
					end
					if sys /= Void and then sys.is_precompiled then
						workb := project.saved_workbench;
						Workbench.set_precompiled_directories 
								(workb.precompiled_directories);
						Universe.copy (workb.universe);
						Workbench.set_system (sys);
		
						Eiffel_project.set_system (project.system);
						sys.set_precompilation (False);
						Workbench.precompiled_directories.force
							(project_dir, sys.compilation_id);
						Workbench.set_precompiled_driver
							(project_dir.precompiled_driver);
						Workbench.set_precompiled_descobj
							(project_dir.precompiled_descobj);
						set_precomp_dir;
						sys.init_counters;
						Universe.update_cluster_paths;
						sys.server_controler.init
					else
						!! vd41;	
						vd41.set_path (project_dir.name);
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
				vd41.set_path (project_dir.name);
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
			-- Update precompilation related once functions.
		require
			driver_not_void: Workbench.precompiled_driver /= Void
			descobj_not_void: Workbench.precompiled_descobj /= Void
		local
			precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
		do
			Precompilation_driver.make_from_string
				(Workbench.precompiled_driver);
			Precompilation_descobj.make_from_string
				(Workbench.precompiled_descobj);
			precomp_dirs := Workbench.precompiled_directories;
			from precomp_dirs.start until precomp_dirs.after loop
				precomp_dirs.item_for_iteration.update_path;
				precomp_dirs.forth
			end;
			Precompilation_directories.copy (precomp_dirs)
		end;

feature {NONE} -- Implementation

	precompiled_project_directory
		(project_names: LINKED_LIST [STRING]): REMOTE_PROJECT_DIRECTORY is
			-- Precompiled project directory containing all other
			-- precompiled libraries listed in `project_names'
		require
			project_names_not_void: project_names /= Void
			not_empty: not project_names.empty
			no_void_names: not project_names.has (Void)
		local
			project_dir: REMOTE_PROJECT_DIRECTORY;
			precomp_info, info: PRECOMP_INFO;
			project_name: STRING;
			project_eif: RAW_FILE;
			vd41: VD41;
			nb: INTEGER
		do
			if not retried then
				from project_names.start until project_names.after loop
					!! project_dir.make (project_names.item)
	
					project_dir.check_precompiled;
					Error_handler.checksum;
	
					if project_dir.is_valid then
						!! project_eif.make_open_read (project_dir.precomp_eif);
						info ?= Eiffel_project.retrieved (project_eif);
						project_eif.close;
						if info /= Void then
							if Result = Void or info.count > nb then
								nb := info.count;
								precomp_info := info;
								Result := project_dir
							end
						else
							!! vd41;	
							vd41.set_path (project_dir.name);
							Error_handler.insert_error (vd41);
							Error_handler.raise_error
						end
					end;
					project_names.forth
				end
				from project_names.start until project_names.after loop
					project_name := project_names.item;
					if
						not project_name.is_equal (project_dir.dollar_name) and
						not precomp_info.has (project_name)
					then
-- TO DO
-- TEMPORARY: this is the wrong error message but I don't want to bother
-- writing a new error class since this piece of code will be removed
-- very soon.
						!! vd41;	
						vd41.set_path (project_name);
						Error_handler.insert_error (vd41);
						Error_handler.raise_error
					end;
					project_names.forth
				end
			else
				if 
					project_eif /= Void and then 
					not project_eif.is_closed 
				then
					project_eif.close
				end;
				retried := False;
				!! vd41;	
				vd41.set_path (project_dir.name);
				Error_handler.insert_error (vd41);
				Error_handler.raise_error
			end
		ensure
			valid_project: Result /= Void implies Result.is_valid
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry
			end
		end

end -- class PRECOMP_R
