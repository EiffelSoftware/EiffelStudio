indexing

	description: 
		"Representation of an Eiffel Project.";
	date: "$Date$";
	revision: "$Revision $"

class E_PROJECT

inherit

	EIFFEL_ENV;
	BENCH_COMMAND_EXECUTOR;
	SHARED_MELT_ONLY;
	PROJECT_CONTEXT;
	SHARED_WORKBENCH
		rename
			system as comp_system
		end;
	STORABLE;
	C_COMPILE_ACTIONS
		rename
			system as comp_system
		end;
	SHARED_MELT_ONLY;
	SHARED_RESCUE_STATUS;
	SHARED_ERROR_HANDLER;
	SHARED_APPLICATION_EXECUTION;

feature -- Initialization

	make (project_dir: PROJECT_DIRECTORY) is
			-- Create an Eiffel Project. 
			-- Also create the sub-directories (EIFGEN, W_code ...)
			-- (If a read-write error occured you must exit from
			-- application.).
		require
			not_initialized: not initialized;
			is_new: project_dir.is_new;
			is_readable: project_dir.is_readable;
			is_writable: project_dir.is_writable;
			is_executable: project_dir.is_executable;
			--is_creatable: project_dir.is_creatable;
			prev_read_write_error: not read_write_error
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
		do
			Project_directory.make_from_string (project_dir.name);
			Create_compilation_directory;
			Create_generation_directory;
			!! workb;
			!! init_work.make (workb);
			workb.make;
			Workbench.init;
			set_is_initialized;
		ensure
			initialized: initialized
		end;

	retrieve (project_dir: PROJECT_DIRECTORY) is
			-- Retrieve an existing Eiffel Project from `file.
			-- (If a read-write error occured you must exit from
			-- application).
		require
			non_void_project_dir: project_dir /= Void;
			project_dir_exists: project_dir.exists;
			file_readable: project_dir.is_readable;
			not_initialized: not initialized;
			project_eif_ok: project_dir.valid_project_eif;
			prev_read_write_error: not read_write_error
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			precomp_r: PRECOMP_R;
			extendible_r: EXTENDIBLE_R;
			temp: STRING;
			e_project: like Current;
			retried: BOOLEAN;
			p_eif: RAW_FILE
		do
			if not retried then
				p_eif := project_dir.project_eif_file;
				set_error_status (Ok_status);
				!! workb;
				p_eif.open_read;
				e_project ?= retrieved (p_eif);
				if e_project = Void then
					retried := True;
				end;
			end;
			if not retried then
				Project_directory.make_from_string (project_dir.name);
				if not p_eif.is_closed then
					p_eif.close
				end
				system := e_project.system;
				!! init_work.make (e_project.saved_workbench);
				Workbench.init;
				if Comp_system.uses_precompiled then
					!! precomp_r;
					precomp_r.set_precomp_dir
				end;
				if Comp_system.is_dynamic then
					!! extendible_r;
					extendible_r.set_extendible_dir
				end;

				Comp_system.server_controler.init;
				Universe.update_cluster_paths;

				check_permissions (project_dir)
				if not error_occurred then
					set_is_initialized;
				end
			else
				set_error_status (Retrieve_error_status);
				retried := False;
			end
		ensure
			initialized_if_no_error: not error_occurred implies initialized;
			error_implies_ret_or_rw: error_occurred implies 
								retrieval_error or else
								read_write_error
		rescue
			if (p_eif /= Void) and then not p_eif.is_closed then
				p_eif.close
			end;
			retried := True;
			retry
		end;

feature -- Properties

	ace: E_ACE is
			-- Eiffel Ace file
		once
			!! Result
		end;

	system: E_SYSTEM;
			-- Eiffel system

	lace_file_name: STRING is
			-- Path to the universe/system description
		obsolete
			"Use file_name from E_ACE"
		do
			Result := Ace.file_name
		end;

	lace_text: STRING is
			-- Text of the Lace file.
			-- Void if unreadable file
		obsolete
			"Use text from E_ACE"
		do
			Result := Ace.text
		end;

	lace_click_list: CLICK_LIST is
			-- Click list for the lace file
		obsolete
			"Use click_list from E_ACE"
		do
			Result := Ace.click_list
		end;

	name: DIRECTORY_NAME is
			-- Path of eiffel project
		do
			Result := Project_directory
		ensure
			is_project_dir: Result = Project_directory
		end;

	error_displayer: ERROR_DISPLAYER is
			-- Displays error and warning messages
		do
			Result := Error_handler.error_displayer
		end

feature -- Access

	is_read_only: BOOLEAN is
			-- Is the project open in read only permission?
		do
			Result := file_status = read_only_status
		end;

	successful: BOOLEAN is
			-- Was the last compilation successful?
		do
			Result := Workbench.successfull and then
				error_status /= Dle_error_status
		ensure
			not_successful_means_dle_or_wb: Result implies
				(Workbench.successfull or else
				(error_status /= Dle_error_status)) 
		end;

	initialized: BOOLEAN is
			-- Is the Eiffel project initialized?
		do
			Result := initialized_mode.item
		end;

	system_defined: BOOLEAN is
			-- Has the Eiffel system been defined.
		do
			Result := system /= Void
		ensure
			Result = Workbench.system_defined
		end;

	able_to_compile: BOOLEAN is
			-- Can we compile?
		do
			Result := not is_read_only and then
				initialized and then
				lace_file_name /= Void and then
				error_displayer /= Void
		ensure
			yes_if_ok: Result implies not is_read_only and then
					initialized and then 
					lace_file_name /= Void and then
					error_displayer /= Void
		end;

	was_saved: BOOLEAN is
			-- Was the last attempt to save successful?
		do
			Result := not save_error
		end;

	freezing_occurred: BOOLEAN is
			-- Did the system have to freeze during melting?
			-- (True, if new externals are introduce or a 
			-- new derivation of SPECIAL was made).
		do
			Result := Workbench.system_defined and then
				Comp_system.freezing_occurred
		end;

	is_final_code_optimal: BOOLEAN is
			-- Will the final code generate be optimal?
			-- (if not, more optimal code is generated from
			-- a new project and do not use precompilation).
		do
			Result := not Comp_system.poofter_finalization or else
				Comp_system.is_dynamic
		end;

	lace_has_assertions: BOOLEAN is
			-- Does the Ace file specify assertions?
		do
			Result := Lace.has_assertions
		end;

	is_new: BOOLEAN is
			-- Is the Current Project new?
		local
			proj_dir: PROJECT_DIRECTORY
		do	
			!! proj_dir.make (Project_directory);
			Result := proj_dir.is_new
		end;

feature -- Error status

	error_occurred: BOOLEAN is
			-- Did an error occurred in last operation?
		do
			Result := error_status /= Ok_status
		end;

	read_write_error: BOOLEAN is
			-- Does the project not have read write permission?
		do
			Result := error_status = file_error_status
		ensure
			saved_implies: Result implies 
						error_status = file_error_status 
		end;

	save_error: BOOLEAN is
			-- Was the last attempt to save the project not successful?
		do
			Result := error_status = save_error_status
		ensure
			saved_implies: Result implies 
						error_status = save_error_status 
		end;

	retrieval_error: BOOLEAN is
			-- Was the to retr the project successful?
		do
			Result := error_status = retrieve_error_status 
		ensure
			correct_error: Result implies 
						error_status = retrieve_error_status 
		end;

feature -- Setting

	set_lace_file_name (f_name: STRING) is
			-- Set lace_file_name to `f_name'.
		obsolete
			"Use set_file_name from E_ACE"
		do
			Ace.set_file_name (f_name)
		end;

	set_error_displayer (ed: like error_displayer) is
			-- Set `error_displayer' to `ed'.
		require
			non_void_ed: ed /= Void
		do
			Error_handler.set_error_displayer (ed)
		ensure
			set: error_displayer = Error_handler.error_displayer
		end;

feature -- Update

	melt is
			-- Incremental recompilation of Eiffel project.
			-- Raise error messages if necessary if unsuccessful. Otherwize,
			-- save the project and link driver to precompiled library 
			-- (if it exists).
		require
			able_to_compile: able_to_compile
		do
			Application.clear_debugging_information;
			Workbench.recompile
			if successful then
				save_project;
				if Comp_system.is_dynamic then
					dle_link_system
				end;
				if not freezing_occurred then
					link_driver
				end;
			end
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error;
			freezing_occurred_if_successful: system /= Void and then
					freezing_occurred implies successful 
		end;

	freeze is
			-- Melt eiffel project and then freeze it (i.e generate
			-- C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			if not melt_only then
				Compilation_modes.set_is_freezing (True)
			end;
			melt;
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			successful_implies_freezing_occurred: 
					successful implies freezing_occurred 
		end;

	finalize (keep_assertions: BOOLEAN) is
			-- Melt eiffel project and then finalize it (i.e generate
			-- optimize C code for workbench mode).
		require
			able_to_compile: able_to_compile
		local
			retried: BOOLEAN
		do
			if not retried then
				Compilation_modes.set_is_finalizing (True);
				melt;
				if successful and then not melt_only then
					set_error_status (Ok_status);
					finalize_system (keep_assertions);
					if Comp_system.extendible then
						save_project
					end
				end
			end
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error;
		rescue
			if Rescue_status.is_error_exception then
					-- A validity error has been detected during the
					-- finalization. This happens with DLE dealing
					-- with statically bound feature calls.
				error_status_mode.put (Dle_error_status);
				Rescue_status.set_is_error_exception (false);
				Comp_system.set_current_class (Void);
				retried := true;
				Error_handler.trace;
				retry
			end
		end;

	call_finish_freezing (workbench_mode: BOOLEAN) is
			-- Call `finish_freezing' after freezing
			-- an eiffel project in W_code or F_wode
			-- depending on the value `workbench_mode'
		require
			able_to_compile: able_to_compile;
		local
			path: STRING
		do
			if workbench_mode then
				path := Workbench_generation_path
			else
				path := Final_generation_path
			end;
			invoke_finish_freezing (path, freeze_command_name)
		end;

	precompile is
			-- Precompile eiffel project.
		require
			able_to_compile: able_to_compile;
			project_is_new: is_new
		do
			Compilation_modes.set_is_precompiling (True);	
			Compilation_modes.set_is_freezing (True);	
			Workbench.recompile;
			if successful then
				Comp_system.save_precompilation_info;
				save_project;
			end;
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error;
			successful_implies_freezing_occurred: 
					successful implies freezing_occurred 
		end;

feature -- Output

	save_project is
			-- Clear the servers and save the system structures
			-- to disk.
		require
			initialized: initialized;
			compilation_successful: successful;
		local
			retried: BOOLEAN;
			file: RAW_FILE
		do
			if not retried then
				error_status_mode.put (Ok_status);
				!! file.make (Project_file_name);
				Comp_system.server_controler.wipe_out;
				file.open_write;
				saved_workbench := workbench;
				independent_store (file);
				file.close;
			else
				if file /= Void and then not file.is_closed then
					file.close
				end;
				retried := False;
				set_error_status (Save_error_status);
			end;
			saved_workbench := Void
		ensure
			error_implies: error_occurred implies save_error
		rescue
			retried := True;
			retry
		end;

feature {DEBUG_INFO} -- Clearing

	reset_debug_counter is
			-- Reset debug counters.
		do
			if Workbench.system_defined then
				Comp_system.reset_debug_counter
			end
		end;

feature {LACE_I} -- Initialization

	init_system is
			-- Initializes the system.
		do
			!! system.make
		end;

feature {APPLICATION_EXECUTION}

	compilation_counter: INTEGER is
		do
			Result := Workbench.compilation_counter
		end;

feature {NONE} -- Implementation

	check_permissions (project_dir: PROJECT_DIRECTORY) is
			-- Check the permissions of `project_dir'.
		require
			valid_project_dir: project_dir /= Void;
			status_ok: not error_occurred
		do
			if project_dir.is_project_writable then
				set_file_status (write_status)
			elseif project_dir.is_project_readable then
				set_file_status (read_only_status)
			else
				set_error_status (file_error_status);
			end
		end;

feature {NONE} -- Implementation

	Ok_status: INTEGER is UNIQUE;

	Write_status: INTEGER is UNIQUE;
	Read_only_status: INTEGER is UNIQUE;
	File_error_status: INTEGER is UNIQUE;

	Corrupt_status: INTEGER is UNIQUE;
	Dle_error_status: INTEGER is UNIQUE;
	Retrieve_error_status: INTEGER is UNIQUE;
	Save_error_status: INTEGER is UNIQUE;
	
	error_status: INTEGER is
		do
			Result := error_status_mode.item
		end;

	file_status: INTEGER is
		do
			Result := file_status_mode.item
		end;

	error_status_mode: CELL [INTEGER] is
		once
			!! Result.put (Ok_status)
		end;

	file_status_mode: CELL [INTEGER] is
		once
			!! Result.put (Write_status)
		end;

	initialized_mode: CELL [BOOLEAN] is
		once
			!! Result.put (False)
		end;

	set_is_initialized is
			-- Set `initialized' to `True';
		do
			initialized_mode.put (True)
		ensure
			initialized: initialized
		end;

	set_error_status (status: INTEGER) is
			-- Set `error_status' to `status'
		do
			error_status_mode.put (status)
		ensure
			set: error_status = status
		end;

	set_file_status (status: INTEGER) is
			-- Set `file_status' to `status'
		do
			file_status_mode.put (status)
		ensure
			set: file_status = status
		end;

feature {PRECOMP_R, EXTENDIBLE_R} -- Implementation

	set_system (s: like system) is
		do
			system := s
		end;

feature {E_PROJECT, PRECOMP_R, EXTENDIBLE_R} -- Implementation

	saved_workbench: WORKBENCH_I;

feature {NONE} -- Implementation

	link_driver is
		local
			uf: PLAIN_TEXT_FILE;
			app_name: STRING
			file_name: FILE_NAME;
		do
			if
-- Melt only compiler does the copy anyway. FIXME???
				--not melt_only and then
				Comp_system.uses_precompiled and then
				not Comp_system.is_dynamic
			then
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH

					-- Target
				!!file_name.make_from_string (Workbench_generation_path);
				app_name := clone (system.name);
				app_name.append (Executable_suffix);
				file_name.set_file_name (app_name);

				!!uf.make (file_name);
				if not uf.exists then
					link_eiffel_driver (Workbench_generation_path,
						system.name,
						Prelink_command_name,
						Precompilation_driver);
				end;
			end;
		end;


	dle_link_system is
			-- Link executable and melted.eif files from the static system.
		require
			dynamic_system: Comp_system.is_dynamic
		local
			uf: PLAIN_TEXT_FILE;
			app_name: STRING;
			file_name: FILE_NAME
		do
			!!file_name.make_from_string (Workbench_generation_path);
			app_name := clone (system.name);
			app_name.append (Executable_suffix);
			file_name.set_file_name (app_name);
			!!uf.make (file_name);
			if not uf.exists then
				!! file_name.make_from_string (Extendible_W_code);
				app_name := clone (Comp_system.dle_system_name);
				app_name.append (Executable_suffix);
				file_name.set_file_name (app_name);
				link_eiffel_driver (Workbench_generation_path,
					System.name,
					Prelink_command_name,
					file_name);
				!! file_name.make_from_string (Extendible_W_code);
				file_name.set_file_name (Updt);
				link_eiffel_driver (Workbench_generation_path,
					Updt, 
					Prelink_command_name, 
					file_name)
			end
		end;

end -- class E_PROJECT
