indexing
	description: "Representation of an Eiffel Project."
	date: "$Date$"
	revision: "$Revision $"

class E_PROJECT

inherit
	EIFFEL_ENV

	COMMAND_EXECUTOR

	PROJECT_CONTEXT

	SHARED_WORKBENCH
		rename
			system as comp_system
		end

	SHARED_RESCUE_STATUS

	SHARED_ERROR_HANDLER

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PARSER

feature -- Initialization

	make (project_dir: PROJECT_DIRECTORY) is
			-- An Eiffel Project has already been created. 
			-- We just create the basic structure to enable the retrieving.
		require
			not_initialized: not initialized
			is_not_new: not project_dir.is_new
			is_readable: project_dir.is_base_readable
			is_writable: project_dir.is_base_writable
			is_executable: project_dir.is_base_executable
			--is_creatable: project_dir.is_creatable
			prev_read_write_error: not read_write_error
		do
			project_directory := project_dir
			Workbench.make
 			Execution_environment.change_working_directory (project_directory.name)
			retrieve
			if not error_occurred then
				is_finalizing := False
				Workbench.on_project_loaded
				manager.on_project_create
				manager.on_project_loaded
			end
		ensure
  			initialized_if_no_error: not error_occurred implies initialized
		end

	make_new (
		project_dir: PROJECT_DIRECTORY
		deletion_requested: BOOLEAN
		deletion_agent: PROCEDURE [ANY, TUPLE]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Create an Eiffel Project. 
			-- Also create, if needed, the sub-directories (EIFGEN, W_code ...)
			-- (If a read-write error occurred you must exit from
			-- application.).
			--
			-- Arguments:
			-- ----------
			-- project_dir: 
			--   Project directory.
			--
			-- deletion_requested:
			--   Should the files present in `project_dir' be removed?
			--
			-- deletion_agent: 
			--   Agent called each time `Deletion_agent_efficiency' files are deleted. 
			--   You can set it to `Void' if you don't need any feedback.
			--
			-- cancel_agent: 
			--   Agent called each time `Deletion_agent_efficiency' files are deleted. 
			--   Make it return `True' to cancel the operation.
		require
			not_initialized: not initialized
			is_readable: project_dir.is_base_readable
			is_writable: project_dir.is_base_writable
			is_executable: project_dir.is_base_executable
			prev_read_write_error: not read_write_error
			valid_deletion_agent: deletion_agent /= Void implies deletion_requested
		local
			d: DIRECTORY
			new_name: STRING
		do
			create d.make (Eiffel_gen_path)
			if d.exists then
				new_name := clone (Eiffel_gen_path)
				if new_name.item (new_name.count) = ']' then
						-- VMS specification. We need to append `_old' before the `]'.
					new_name.insert_string ("_old", new_name.count - 1)
				else
					new_name.append ("_old")
				end
					-- Rename the old project
				d.change_name (new_name)
				if deletion_requested then
						-- Rename the old project to EIFGEN so that we can
						-- delete it.
					d.change_name (Eiffel_gen_path)
					delete_f_code_content (deletion_agent, cancel_agent)
					delete_w_code_content (deletion_agent, cancel_agent)
					delete_comp_content (deletion_agent, cancel_agent)
					delete_backup_content (deletion_agent, cancel_agent)
				end
			end
			if (cancel_agent = Void) or else (not cancel_agent.item ([])) then
				project_directory := project_dir
				Create_compilation_directory
				Create_generation_directory
				Workbench.make
				set_is_initialized
 				Execution_environment.change_working_directory (project_directory.name)
			end
			manager.on_project_create
		ensure
			initialized: initialized
		end

	create_dynamic_lib is
		do
			create dynamic_lib
		end

feature -- Properties

	ace: E_ACE is
			-- Eiffel Ace file
		once
			create Result
		end

	dynamic_lib: E_DYNAMIC_LIB
			-- Eiffel Dynamic Lib

	project_directory: PROJECT_DIRECTORY
			-- Information about the project files structures

	system: E_SYSTEM
			-- Eiffel system

	name: DIRECTORY_NAME is
			-- Path of eiffel project
		do
			Result := Project_directory_name
		ensure
			is_project_dir: Result = Project_directory_name
		end

	error_displayer: ERROR_DISPLAYER is
			-- Displays error and warning messages
		do
			Result := Error_handler.error_displayer
		end

	manager: EB_PROJECT_MANAGER is
			-- interface between `Current' and the user interface.
		once
			create Result.make (Current)
		end

feature -- Access

	is_read_only: BOOLEAN is
			-- Is the project open in read only permission?
		do
			Result := file_status = read_only_status
		end

	successful: BOOLEAN is
			-- Was the last compilation successful?
		do
			Result := Workbench.successful
		ensure
			not_successful_means_wb: Result implies Workbench.successful
		end

	initialized: BOOLEAN is
			-- Is the Eiffel project initialized?
		do
			Result := initialized_mode.item
		end

	system_defined: BOOLEAN is
			-- Has the Eiffel system been defined.
		do
			Result := system /= Void
		ensure
			Result = Workbench.system_defined
		end

	able_to_compile: BOOLEAN is
			-- Can we compile?
		do
			Result := not is_read_only and then
				(System = Void or else not System.is_precompiled) and then 
				initialized and then
				ace.file_name /= Void and then
				error_displayer /= Void and then
				not is_compiling
		ensure
			yes_if_ok: Result implies not is_read_only and then
					initialized and then 
					ace.file_name /= Void and then
					error_displayer /= Void and then
					not is_compiling
		end

	was_saved: BOOLEAN is
			-- Was the last attempt to save successful?
		do
			Result := not save_error
		end

	freezing_occurred: BOOLEAN is
			-- Did the system have to freeze during melting?
			-- (True, if new externals are introduce or a 
			-- new derivation of SPECIAL was made).
		do
			Result := Workbench.system_defined and then
				Comp_system.freezing_occurred
		end

	is_final_code_optimal: BOOLEAN is
			-- Will the final code generate be optimal?
			-- (if not, more optimal code is generated from
			-- a new project and do not use precompilation).
		do
			Result := not Comp_system.poofter_finalization
		end

	lace_has_assertions: BOOLEAN is
			-- Does the Ace file specify assertions?
		do
			Result := Lace.has_assertions
		end

	is_new: BOOLEAN is
			-- Is the Current Project new?
		local
--			proj_dir: PROJECT_DIRECTORY
--			p: PROJECT_EIFFEL_FILE
		do	
				-- The next two lines commented out by Manus, 23 Aug 98
				-- Reason: the way how to do the check is incorrect, we need
				-- to review it completely.
--			create proj_dir.make (Project_directory_name, p)
--			Result := proj_dir.is_new
			Result := True
		end

	batch_mode: BOOLEAN is
			-- Is the compiler in batch mode?
			-- (By default it is true)
		do
			Result := mode.item
		end

	is_compiling: BOOLEAN is
			-- Is it compiling?
		do
			Result := is_compiling_ref.item
		end

feature -- Error status

	error_occurred: BOOLEAN is
			-- Did an error occurred in last operation?
		do
			Result := error_status /= Ok_status
		end

	read_write_error: BOOLEAN is
			-- Does the project not have read write permission?
		do
			Result := error_status = file_error_status
		ensure
			saved_implies: Result implies 
						error_status = file_error_status 
		end

	incomplete_project: BOOLEAN is
		do
			Result := error_status = incomplete_project_status
		ensure
			saved_implies: Result implies 
						error_status = incomplete_project_status 
		end

	save_error: BOOLEAN is
			-- Was the last attempt to save the project not successful?
		do
			Result := error_status = save_error_status or
					error_status = precomp_save_error_status
		ensure
			saved_implies: Result implies 
						(error_status = save_error_status or
						error_status = precomp_save_error_status)
		end

	precomp_save_error: BOOLEAN is
			-- Was the last attempt to save the precompilation information
			-- not successful?
		do
			Result := error_status = Precomp_save_error_status
		ensure
			saved_implies: Result implies 
						error_status = Precomp_save_error_status 
		end

	retrieval_error: BOOLEAN is
			-- Was the project retrieved successful?
		do
			Result := 
				error_status = retrieve_corrupt_error_status or else
				error_status = retrieve_interrupt_error_status or else
				error_status = retrieve_incompatible_error_status
			
		ensure
			correct_error: Result implies 
						error_status = retrieve_corrupt_error_status or else
						error_status = retrieve_interrupt_error_status or else
						error_status = retrieve_incompatible_error_status 
		end

	retrieval_interrupted: BOOLEAN is
			-- Was the retrieval of the project interrupted?
		require
			retrieval_error: retrieval_error
		do
			Result := error_status = retrieve_interrupt_error_status 
		ensure
			correct_error: Result implies 
						error_status = retrieve_interrupt_error_status 
		end

	is_corrupted: BOOLEAN is
			-- Is the retrieved project corrupted?
		require
			retrieval_error: retrieval_error
		do
			Result := error_status = retrieve_corrupt_error_status 
		ensure
			correct_error: Result implies 
						error_status = retrieve_corrupt_error_status 
		end

	incompatible_version_number: STRING is
			-- Incompatible version number of project
		require	
			is_project_incompatible: is_incompatible
		once
			create Result.make (0)
		end
		
	ace_file_path: STRING
			-- Path for the ace file as written in the header of each .epr file
			-- Used when the project can be retrieved.
			--
			-- Void if none.

	is_incompatible: BOOLEAN is
			-- Is the retrieved project incompatible with current version
			-- of the compiler?
		require
			retrieval_error: retrieval_error
		do
			Result := error_status = retrieve_incompatible_error_status 
		ensure
			correct_error: Result implies 
						error_status = retrieve_incompatible_error_status 
		end

feature -- Status report

	degree_output: DEGREE_OUTPUT is
			-- Degree output messages during compilation 
			-- (By default it redirects output compilation
			-- messages to io.)
		do
			Result := degree_output_cell.item
		end

	is_finalizing: BOOLEAN
			-- Are we in the middle of a finalization?

feature -- Status setting

	set_degree_output (a_degree_ouput: like degree_output) is
			-- Set `degree_output' to `a_degree_ouput'.
		require
			non_void_a_degree_ouput: a_degree_ouput /= Void
		do
			degree_output_cell.put (a_degree_ouput)
		ensure
			set: degree_output = a_degree_ouput
		end

	set_error_displayer (ed: like error_displayer) is
			-- Set `error_displayer' to `ed'.
		require
			non_void_ed: ed /= Void
		do
			Error_handler.set_error_displayer (ed)
		ensure
			set: error_displayer = Error_handler.error_displayer
		end

	set_batch_mode (compiler_mode: BOOLEAN) is
			-- Set `batch_mode' to `compiler_mode'
		do
			mode.set_item (compiler_mode)
		ensure
			set: compiler_mode = batch_mode
		end

	set_filter_path (f_path: STRING) is
			-- Set filter_path to `f_path'.
		require
			valid_arg: f_path /= Void 
		do
			if not f_path.is_equal (filter_path) then
				filter_path.make_from_string (clone 
						(interpreted_string (f_path)))
			end
		end

	set_profile_path (p_path: STRING) is
			-- Set profile_path to `p_path'.
		require
			valid_arg: p_path /= Void 
		do
			if not p_path.is_equal (profile_path) then
				profile_path.make_from_string (clone 
					(interpreted_string (p_path)))
			end
		end

	set_tmp_directory (t_path: STRING) is
			-- Set tmp_directory to `t_path'.
		require
			valid_args: t_path /= Void 
		do
			if not t_path.is_equal (tmp_directory) then
				tmp_directory.wipe_out
				tmp_directory.make_from_string (interpreted_string (t_path))
			end
		end

feature -- Update

	melt is
			-- Incremental recompilation of Eiffel project.
			-- Raise error messages if necessary if unsuccessful. Otherwize,
			-- save the project and link driver to precompiled library 
			-- (if it exists).
		require
			able_to_compile: able_to_compile
		do
			degree_output.put_new_compilation
			if not Compilation_modes.is_precompiling then
				is_compiling_ref.set_item (True)
				Workbench.recompile

				if successful then
					if not freezing_occurred then
						link_driver
					end

					if Application.has_breakpoints then
						Degree_output.put_resynchronizing_breakpoints_message
						Application.resynchronize_breakpoints
					end
				elseif exit_on_error and then exit_agent /= Void then
					exit_agent.call ([])
				end
				if
					not manager.is_project_loaded and then
					Workbench.last_reached_degree < 3
				then
					manager.on_project_loaded
				end
				Compilation_modes.reset_modes
				is_compiling_ref.set_item (False)
			else
				Compilation_modes.reset_modes
				precompile (False)
			end
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
		end

	quick_melt is
			-- Melt eiffel project and then freeze it (i.e generate
			-- C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			if not Compilation_modes.is_precompiling then
				if 
					System_defined and then 
					Ace.successful and then
					not Ace.date_has_changed
				then
					Compilation_modes.set_is_quick_melt
				end
				melt
			else
				Compilation_modes.reset_modes
				precompile (False)
			end
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			freezing_occurred_if_successful: system /= Void and then
					freezing_occurred implies successful 
		end

	freeze is
			-- Melt eiffel project and then freeze it (i.e generate
			-- C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			Compilation_modes.set_is_freezing
			melt
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			successful_implies_freezing_occurred: 
					successful implies freezing_occurred 
		end

	finalize (keep_assertions: BOOLEAN) is
			-- Melt eiffel project and then finalize it (i.e generate
			-- optimize C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			is_finalizing := True
			melt
			if
				successful and then
				not comp_system.lace.compile_all_classes and then
				not comp_system.il_generation
			then
				Compilation_modes.set_is_finalizing
				set_error_status (Ok_status)
				is_compiling_ref.set_item (True)
				Comp_system.finalize_system (keep_assertions)
				Comp_system.prepare_before_saving (True)
				is_compiling_ref.set_item (False)
				Compilation_modes.reset_modes
			end
			Workbench.stop_compilation
			is_finalizing := False
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
		rescue
			is_finalizing := False
		end

	call_finish_freezing (workbench_mode: BOOLEAN) is
			-- Call `finish_freezing' after freezing
			-- an eiffel project in W_code or F_wode
			-- depending on the value `workbench_mode'
		local
			path: STRING
		do
			if workbench_mode then
				path := Workbench_generation_path
			else
				path := Final_generation_path
			end
			invoke_finish_freezing (path, freeze_command_name)
		end

	precompile (licensed: BOOLEAN) is
			-- Precompile eiffel project.
		require
			able_to_compile: able_to_compile
			project_is_new: is_new
		do
			Compilation_modes.set_is_precompiling (True)
			Compilation_modes.set_is_freezing
			Workbench.recompile

			if successful then
				Comp_system.set_licensed_precompilation (licensed)
				Comp_system.save_precompilation_info
				if not save_error then
					save_precomp (licensed)
				end
			end
			if
				not manager.is_project_loaded and then
				Workbench.last_reached_degree < 3
			then
				manager.on_project_loaded
			end
			--Compilation_modes.reset_modes
		ensure
			was_saved: successful and then not error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			successful_implies_freezing_occurred: successful implies freezing_occurred 
		end

	delete_f_code_content (
		deletion_agent: PROCEDURE [ANY, TUPLE]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Delete the content of the F_code directory.
		do
			delete_generation_directory (Final_generation_path, deletion_agent, cancel_agent)
		end

	delete_w_code_content (
		deletion_agent: PROCEDURE [ANY, TUPLE]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Delete the content of the W_code directory.
		do
			delete_generation_directory (Workbench_generation_path, deletion_agent, cancel_agent)
		end

	delete_comp_content (
		deletion_agent: PROCEDURE [ANY, TUPLE]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Delete the content of the COMP directory.
		do
			delete_generation_directory (Compilation_path, deletion_agent, cancel_agent)
		end

	delete_backup_content (
		deletion_agent: PROCEDURE [ANY, TUPLE]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Delete the content of the COMP directory.
		do
			delete_generation_directory (Backup_path, deletion_agent, cancel_agent)
		end

	stop_and_exit (ag: like exit_agent) is
			-- Stop the compilation and exit EiffelStudio.
		do
			exit_on_error := True
			exit_agent := ag
			error_handler.insert_interrupt_error (True)
		end

feature -- Output

	save_upon_exiting is
			-- When quitting, we need to clear all the unused files
			-- and then if the project has not yet been saved upon a 
			-- successful compilation we save it.
		do
				-- Purge uselss files
			Comp_system.prepare_before_saving (True)
			Comp_system.tmp_purge

			save_project
		end

	save_project is
			-- Clear the servers and save the system structures
			-- to disk.
		require
			initialized: initialized
			compilation_successful: not Comp_system.il_generation implies successful
		local
			retried: BOOLEAN
			file_name: FILE_NAME
			project_file: RAW_FILE
		do
			if not retried then
				error_status_mode.set_item (Ok_status)

					--| Prepare informations to store
				Comp_system.server_controler.wipe_out
				saved_workbench := workbench
				create file_name.make_from_string (Project_directory.name);
				if Compilation_modes.is_precompiling then 
					file_name.set_file_name (dot_workbench)
				else
					file_name.set_file_name (System.name)
					file_name.add_extension (Project_extension)
				end

				create project_file.make_open_write (file_name)
				store_project_info (project_file)
				compiler_store (project_file.descriptor, $Current)
				project_file.close
			else
				if project_file /= Void and then not project_file.is_closed then
					project_file.close
				end
				retried := False
				set_error_status (Save_error_status)
			end
			saved_workbench := Void
		ensure
			error_implies: error_occurred implies save_error
		rescue
			retried := True
			retry
		end

	save_precomp (licensed: BOOLEAN) is
			-- Save precompilation information to disk.
		require
			initialized: initialized
			compilation_successful: successful
		local
			retried: BOOLEAN
			file: RAW_FILE
			precomp_info: PRECOMP_INFO
		do
			if not retried then
				error_status_mode.set_item (Ok_status)
				create precomp_info.make (Precompilation_directories, licensed)
				create file.make (Precompilation_file_name)
				file.open_write
				store_project_info (file)
				compiler_store (file.descriptor, $precomp_info)
				file.close
				set_file_status (read_only_status)
			else
				if file /= Void and then not file.is_closed then
					file.close
				end
				retried := False
				set_error_status (Precomp_save_error_status)
			end
		ensure
			error_implies: error_occurred implies precomp_save_error
		rescue
			retried := True
			retry
		end

feature {LACE_I} -- Initialization

	init_system is
			-- Initializes the system.
		do
			create system.make
		end

feature {APPLICATION_EXECUTION}

	compilation_counter: INTEGER is
		do
			Result := Workbench.compilation_counter
		end

feature {NONE} -- Retrieval

	store_project_info (file: RAW_FILE) is
			-- Store project specific info in project file `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		do
			file.putstring (info_flag_begin)
			file.putstring (System.name)
			file.new_line
			file.putstring (version_number_tag)
			file.putstring (":")
			file.putstring (version_number)
			file.new_line
			file.putstring (precompilation_id_tag)
			file.putstring (":")
			file.putstring (Comp_system.compilation_id.out)
			file.new_line
			file.putstring (ace_file_path_tag)
			file.putstring (":")
			file.putstring (ace.file_name)
			file.new_line
			file.putstring (info_flag_end)
			file.new_line

				--| To store correctly the information after the project
				--| header, we need to set the position, otherwise the
				--| result is quite strange and won't be retrievable
			file.go (file.count)
		end

	retrieve is
			-- Retrieve an existing Eiffel Project from `file.
			-- (If a read-write error occurred you must exit from
			-- application).
		require
			non_void_project_dir: project_directory /= Void
			project_dir_exists: project_directory.exists
			file_readable: project_directory.is_readable
			not_initialized: not initialized
			project_eif_ok: project_directory.valid_project_eif
			prev_read_write_error: not read_write_error
		local
			precomp_r: PRECOMP_R
			e_project: like Current
			p_eif: PROJECT_EIFFEL_FILE
			precomp_dirs: EXTEND_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
			remote_dir: REMOTE_PROJECT_DIRECTORY
		do
			set_error_status (Ok_status)

			check_existence

			if not error_occurred then

				p_eif := project_directory.project_eif_file
				e_project := p_eif.retrieved_project
				if p_eif.error then
					if p_eif.is_corrupted then
						set_error_status (Retrieve_corrupt_error_status)
						ace_file_path := p_eif.ace_file_path
					elseif p_eif.is_interrupted then
						set_error_status (Retrieve_interrupt_error_status)
					else
						set_error_status (Retrieve_incompatible_error_status)
						incompatible_version_number.wipe_out
						incompatible_version_number.append (p_eif.project_version_number)
						ace_file_path := p_eif.ace_file_path
					end
				else
--!! FIXME: check Concurrent_Eiffel license
					Project_directory_name.make_from_string (project_directory.name)
					system := e_project.system
					dynamic_lib := e_project.dynamic_lib
					Workbench.copy (e_project.saved_workbench)
					if Comp_system.is_precompiled then
						precomp_dirs := Workbench.precompiled_directories
						from
							precomp_dirs.start
						until
							precomp_dirs.after
						loop
							precomp_dirs.item_for_iteration.update_path
							precomp_dirs.forth
						end
						Precompilation_directories.copy (precomp_dirs)
						create remote_dir.make (project_directory.name)
						remote_dir.set_licensed (Comp_system.licensed_precompilation)
						remote_dir.set_system_name (Comp_system.system_name)
						Precompilation_directories.force
							(remote_dir, Comp_system.compilation_id)
					else
						if Comp_system.uses_precompiled then
							create precomp_r
							precomp_r.set_precomp_dir
						end
					end

					Comp_system.server_controler.init
					set_il_parsing (Comp_system.il_generation)
					Universe.update_cluster_paths
					
					check_permissions

					if not error_occurred then
						set_is_initialized
						Execution_environment.change_working_directory (project_directory.name)
					end
				end
			end
		ensure
			initialized_if_no_error: not error_occurred implies initialized
			error_implies_ret_or_rw: error_occurred implies 
								retrieval_error or else
								read_write_error
		end

feature {NONE} -- Implementation

	check_existence is
			-- Check the permissions of `project_directory' before to retrieve
			-- the project.
		require
			valid_project_dir: project_directory /= Void
			status_ok: not error_occurred
		do
			if not project_directory.exists then
				set_error_status (Incomplete_project_status)
			end
		end

	check_permissions is
			-- Check the permissions of `project_directory' after the retrieving
			-- of the project.
		do
			if not System.is_precompiled and then project_directory.is_writable then
				set_file_status (write_status)
			elseif project_directory.is_readable then
				set_file_status (read_only_status)
			else
				set_error_status (file_error_status)
			end
		end

	delete_generation_directory (
		base_name: STRING
		deletion_agent: PROCEDURE [ANY, TUPLE]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Delete then EIFFEL generated directory named `base_name'.
			--
			-- `deletion_agent' is called each time `Deletion_agent_efficiency'
			-- files are deleted.
			-- same for `cancel_agent'. Make it return `True' to cancel the operation.
		local
			generation_directory: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create generation_directory.make (base_name)
				if generation_directory.exists then
					if (deletion_agent /= Void) or (cancel_agent /= Void) then
						generation_directory.delete_content_with_action (deletion_agent, cancel_agent, Deletion_agent_efficiency)
					else
						generation_directory.delete_content
					end
				end
			end
		rescue
			retried := True
			retry
		end

	

feature {NONE} -- Implementation

	Ok_status: INTEGER is 1

	Write_status: INTEGER is 2
	Read_only_status: INTEGER is 3
	File_error_status: INTEGER is 4
	Incomplete_project_status: INTEGER is 5

	Corrupt_status: INTEGER is 6
	Retrieve_corrupt_error_status: INTEGER is 8
	Retrieve_incompatible_error_status: INTEGER is 9
	Retrieve_interrupt_error_status: INTEGER is 10
	Save_error_status: INTEGER is 11
	Precomp_save_error_status: INTEGER is 12
	
	error_status: INTEGER is
			-- Give last error status.
		do
			Result := error_status_mode.item
		end

	file_status: INTEGER is
			-- Give last file status.
		do
			Result := file_status_mode.item
		end

	error_status_mode: INTEGER_REF is
			-- Structure to keep the last error status.
		once
			create Result
			Result.set_item (Ok_status)
		end

	file_status_mode: INTEGER_REF is
			-- Structure to keep the last file status.
		once
			create Result
			Result.set_item (Write_status)
		end

	initialized_mode: BOOLEAN_REF is
		once
			create Result
		end

	set_is_initialized is
			-- Set `initialized' to `True'
		do
			initialized_mode.set_item (True)
		ensure
			initialized: initialized
		end

	set_error_status (status: INTEGER) is
			-- Set `error_status' to `status'
		do
			error_status_mode.set_item (status)
		ensure
			set: error_status = status
		end

	set_file_status (status: INTEGER) is
			-- Set `file_status' to `status'
		do
			file_status_mode.set_item (status)
		ensure
			set: file_status = status
		end

feature {PRECOMP_R} -- Implementation

	set_system (s: like system) is
		do
			system := s
		end

feature {E_PROJECT, PRECOMP_R} -- Implementation

	saved_workbench: WORKBENCH_I

feature {NONE} -- Implementation

	Deletion_agent_efficiency: INTEGER is 50
		-- When deleting a directory, the callback function is called 
		-- each time `Deletion_agent_efficiency' files are deleted
		--
		-- Set this value to 1 for a better look, a to 50 for better
		-- performances.

	degree_output_cell: CELL [DEGREE_OUTPUT] is
			-- Degree output window
		local
			deg_output: DEGREE_OUTPUT
		once
			create deg_output
			create Result.put (deg_output)
		end

	exit_agent: PROCEDURE [ANY, TUPLE[]]
			-- Optional procedure that should be called when an error occurs and `exit_on_error' is set.

	mode: BOOLEAN_REF is
			-- Is the compile in batch mode?
		once
			create Result
			Result.set_item (True)
		end

	is_compiling_ref: BOOLEAN_REF is
			-- Is it compiling?
		once
			create Result
		end

	exit_on_error: BOOLEAN
			-- Should we exit EiffelStudio when an error occurs? (used to kill EiffelStudio during compilations)

	link_driver is
		local
			uf: PLAIN_TEXT_FILE
			app_name: STRING
			file_name: FILE_NAME
		do
			if Comp_system.uses_precompiled then
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH

					-- Target
				create file_name.make_from_string (Workbench_generation_path)
				file_name.set_file_name (System.name)
				app_name := Platform_constants.Executable_suffix
				if not app_name.is_empty then
					file_name.add_extension (app_name)
				end

				create uf.make (file_name)
				if not uf.exists then
					create uf.make (Precompilation_driver)
					if uf.exists and then uf.is_readable then
						link_eiffel_driver (Workbench_generation_path,
							system.name,
							Prelink_command_name,
							Precompilation_driver)
					end
				end
			end
		end

feature {NONE} -- Implementation

	compiler_store (f_desc: INTEGER; obj: POINTER) is
		external
			"C | %"pstore.h%""
		alias
			"parsing_store"
		end

invariant
	degree_output_not_void: degree_output /= Void

end -- class E_PROJECT
