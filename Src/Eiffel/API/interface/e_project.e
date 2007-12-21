indexing
	description: "Representation of an Eiffel Project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class E_PROJECT

inherit
	COMMAND_EXECUTOR

	PROJECT_CONTEXT

	SHARED_WORKBENCH
		rename
			system as comp_system
		end

	SHARED_RESCUE_STATUS

	SHARED_ERROR_HANDLER

	SHARED_EIFFEL_PARSER

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	COMPILER_EXPORTER

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Initialization

	make (a_project_location: PROJECT_DIRECTORY) is
			-- An Eiffel Project has already been created.
			-- We just create the basic structure to enable the retrieving.
		require
			not_initialized: not initialized
			exists: a_project_location.path_exists
			is_readable: a_project_location.is_path_readable
			is_writable: a_project_location.is_path_writable
			prev_read_write_error: not read_write_error
		local
			l_prev_work: STRING
		do
			project_directory := a_project_location
			l_prev_work := Execution_environment.current_working_directory
 			Execution_environment.change_working_directory (a_project_location.path)
			retrieve
			if not error_occurred then
				Workbench.on_project_loaded
				manager.on_project_create
				manager.on_project_loaded
			end
			Execution_environment.change_working_directory (l_prev_work)
		ensure
  			initialized_if_no_error: not error_occurred implies initialized
		end

	make_new (
		base_dir: DIRECTORY;
		a_project_location: PROJECT_DIRECTORY
		deletion_requested: BOOLEAN
		deletion_agent: PROCEDURE [ANY, TUPLE [ARRAYED_LIST [STRING]]]
		cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
	) is
			-- Create an Eiffel Project.
			-- Also create, if needed, the sub-directories (EIFGEN, W_code ...)
			-- (If a read-write error occurred you must exit from
			-- application.).
			--
			-- Arguments:
			-- ----------
			-- a_project_location:
			--   Project directory.
			--
			-- deletion_requested:
			--   Should the files present in `a_project_location' be removed?
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
			base_dir_not_void: base_dir /= Void
			project_dir_not_void: a_project_location /= Void
			is_readable: base_dir.is_readable
			is_writable: base_dir.is_writable
			is_executable: base_dir.is_executable
			prev_read_write_error: not read_write_error
			valid_deletion_agent: deletion_agent /= Void implies deletion_requested
		local
			d: DIRECTORY
			new_name: STRING
			l_prev_work: STRING
		do
			l_prev_work := Execution_environment.current_working_directory
			create d.make (a_project_location.eifgens_path)
			if d.exists then
				create d.make (a_project_location.target_path)
				if d.exists then
					new_name := a_project_location.target_path.twin
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
						d.change_name (a_project_location.target_path)
						delete_project_file (a_project_location.project_file_name)
						delete_generation_directory (a_project_location.backup_path, deletion_agent, cancel_agent)
						delete_generation_directory (a_project_location.compilation_path, deletion_agent, cancel_agent)
						delete_generation_directory (a_project_location.final_path, deletion_agent,
							cancel_agent)
						delete_generation_directory (a_project_location.workbench_path, deletion_agent,
							cancel_agent)
					end
				end
			end
			if (cancel_agent = Void) or else (not cancel_agent.item (Void)) then
				project_directory := a_project_location
				a_project_location.create_project_directories
				set_is_initialized
 				Execution_environment.change_working_directory (project_directory.path)
			end
			manager.on_project_create
			Execution_environment.change_working_directory (l_prev_work)
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
			Result := project_directory.path
		ensure
			is_project_dir: Result = project_directory.path
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
			Result := system /= Void and then workbench.system_defined
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

feature -- Update

	melt (is_for_finalization: BOOLEAN) is
			-- Incremental recompilation of Eiffel project.
			-- Raise error messages if necessary if unsuccessful. Otherwize,
			-- save the project and link driver to precompiled library
			-- (if it exists).
		require
			able_to_compile: able_to_compile
		do
			set_error_status (ok_status)
			degree_output.put_new_compilation
			if not Compilation_modes.is_precompiling then
				is_compiling_ref.set_item (True)
				workbench.start_compilation
				workbench.recompile
				if not is_for_finalization then
					workbench.stop_compilation
				end

				if successful then
					if not freezing_occurred then
						link_driver
					end
					if
						not manager.is_project_loaded and then
						workbench.has_compilation_started
					then
						manager.on_project_loaded
					end
				elseif exit_on_error and then exit_agent /= Void then
					exit_agent.call (Void)
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
		rescue
				-- Reset `is_compiling' as if we are here, it means that an internal
				-- error occurred
			is_compiling_ref.set_item (False)
		end

	discover_melt is
			-- Full rebuild and melt.
		require
			able_to_compile: able_to_compile
		do
			if not Compilation_modes.is_precompiling then
				Compilation_modes.set_is_discover
				melt (False)
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
				Compilation_modes.set_is_quick_melt
				melt (False)
			else
				Compilation_modes.reset_modes
				precompile (False)
			end
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
		end

	override_scan is
			-- Same as `quick_melt' but only scans override clusters for changes.
		require
			able_to_compile: able_to_compile
		do
			if not Compilation_modes.is_precompiling then
				Compilation_modes.set_is_override_scan
				melt (False)
			else
				Compilation_modes.reset_modes
				precompile (False)
			end
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
		end

	freeze is
			-- Melt eiffel project and then freeze it (i.e generate
			-- C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			Compilation_modes.set_is_freezing
			melt (False)
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			successful_implies_freezing_occurred:
					successful implies (freezing_occurred or else workbench.system.il_generation)
		end

	finalize (keep_assertions: BOOLEAN) is
			-- Melt eiffel project and then finalize it (i.e generate
			-- optimize C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			Compilation_modes.set_is_quick_melt
			melt (True)
			if successful then
				Compilation_modes.set_is_finalizing
				set_error_status (Ok_status)
				is_compiling_ref.set_item (True)
				Comp_system.finalize_system (keep_assertions)
				if successful then
						-- No point on trying to save a cancelled (i.e. non successful compilation).
						-- False because we are not precompiling here.
					Workbench.save_project (False)
				end
				is_compiling_ref.set_item (False)
				Compilation_modes.reset_modes
			end
			Workbench.stop_compilation
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
		end

	call_finish_freezing (workbench_mode: BOOLEAN) is
			-- Call `finish_freezing' after freezing
			-- an eiffel project in W_code or F_wode
			-- depending on the value `workbench_mode'
		local
			path: STRING
			l_cmd: STRING
			l_processors: INTEGER
		do
			if workbench_mode then
				path := project_directory.workbench_path
			else
				path := project_directory.final_path
			end
			create l_cmd.make_from_string ("%"" + eiffel_layout.Freeze_command_name + "%"")
			if comp_system.il_generation and (not eiffel_layout.platform.is_windows_64_bits or Comp_system.force_32bits) then
					-- Force 32bit compilation
				l_cmd.append (" -x86")
			end
			l_processors := preferences.maximum_processor_usage
			if l_processors > 0 then
				l_cmd.append (" -nproc ")
				l_cmd.append_integer (l_processors)
			end
			invoke_finish_freezing (path, l_cmd, True, workbench_mode)
		end

	call_finish_freezing_and_wait (workbench_mode: BOOLEAN) is
			-- Call `finish_freezing' after freezing
			-- an eiffel project in W_code or F_wode
			-- depending on the value `workbench_mode'.
			-- Wait until C compilation is done.
		local
			path: STRING
			l_cmd: STRING
			l_processors: INTEGER
		do
			if workbench_mode then
				path := project_directory.workbench_path
			else
				path := project_directory.final_path
			end
			create l_cmd.make_from_string ("%"" + eiffel_layout.Freeze_command_name + "%"")
			if comp_system.il_generation and (not eiffel_layout.platform.is_windows_64_bits or Comp_system.force_32bits) then
					-- Force 32bit compilation
				l_cmd.append (" -x86")
			end
			l_processors := preferences.maximum_processor_usage
			if l_processors > 0 then
				l_cmd.append (" -nproc ")
				l_cmd.append_integer (l_processors)
			end
				-- Set below normal priority.
			l_cmd.append (" -low")
			invoke_finish_freezing (path, l_cmd, False, workbench_mode)
		end

	precompile (is_for_finalization: BOOLEAN) is
			-- Precompile eiffel project.
		require
			able_to_compile: able_to_compile
			project_is_new: is_new
		do
			set_error_status (ok_status)
			Compilation_modes.set_is_precompiling (True)
			Compilation_modes.set_is_freezing
			workbench.start_compilation
			workbench.recompile
			if not is_for_finalization then
				workbench.stop_compilation
			end

			if successful then
				Comp_system.save_precompilation_info
				if not save_error then
					save_precomp
				end
				if
					not manager.is_project_loaded and then
					workbench.has_compilation_started
				then
					manager.on_project_loaded
				end
			end
		ensure
			was_saved: successful and then not error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			successful_implies_freezing_occurred: successful implies freezing_occurred
		rescue
				-- Reset `is_compiling' as if we are here, it means that an internal
				-- error occurred
			is_compiling_ref.set_item (False)
		end

	finalize_precompile (keep_assertions: BOOLEAN) is
			-- precompile eiffel project and then finalize it (i.e generate
			-- optimize C code for workbench mode).
		require
			able_to_compile: able_to_compile
		do
			precompile (True)
			if successful and then comp_system.il_generation then
				Compilation_modes.set_is_finalizing
				set_error_status (Ok_status)
				is_compiling_ref.set_item (True)
				Comp_system.finalize_system (keep_assertions)
				Workbench.save_project (True)
				is_compiling_ref.set_item (False)
			end
			Workbench.stop_compilation
		ensure
			was_saved: successful and then not
				error_occurred implies was_saved
			error_implies: error_occurred implies save_error
			successful_implies_freezing_occurred: successful implies freezing_occurred
		end

	delete_generation_directory (
			base_name: STRING; deletion_agent: PROCEDURE [ANY, TUPLE];
			cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN])
		is
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
						generation_directory.delete_content_with_action (deletion_agent,
							cancel_agent, Deletion_agent_efficiency)
					else
						generation_directory.delete_content
					end
				end
			end
		rescue
			retried := True
			retry
		end

	delete_project_file (a_file_name: STRING) is
			-- Delete `a_file_name' if possible.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make (a_file_name)
				if l_file.exists then
					l_file.delete
				end
			end
		rescue
			retried := True
			retry
		end

	stop_and_exit (ag: like exit_agent) is
			-- Stop the compilation and exit EiffelStudio.
		do
			exit_on_error := True
			exit_agent := ag
			error_handler.insert_error (create {INTERRUPT_ERROR}.make (True))
			error_handler.raise_error
		end

feature -- Output

	save_project is
			-- Clear the servers and save the system structures
			-- to disk.
		require
			initialized: initialized
			compilation_successful: not Comp_system.il_generation implies successful
		local
			l_epr_file: PROJECT_EIFFEL_FILE
		do
				--| Prepare informations to store
			Comp_system.server_controler.wipe_out
			saved_workbench := workbench

			error_status_mode.set_item (Ok_status)
			l_epr_file := project_directory.project_file
			l_epr_file.store (Current, comp_system.compilation_id)

			if l_epr_file.has_error then
				set_error_status (Save_error_status)
			end
			saved_workbench := Void
		ensure
			error_implies: error_occurred implies save_error
		end

	save_precomp is
			-- Save precompilation information to disk.
		require
			initialized: initialized
			compilation_successful: successful
		local
			precomp_info: PRECOMP_INFO
			l_epr_file: PROJECT_EIFFEL_FILE
		do
			error_status_mode.set_item (Ok_status)
			create precomp_info.make (Precompilation_directories)
			create l_epr_file.make (project_directory.precompilation_file_name)
			l_epr_file.store (precomp_info, comp_system.compilation_id)

			if l_epr_file.has_error then
				set_error_status (Precomp_save_error_status)
			else
				set_file_status (read_only_status)
			end
		ensure
			error_implies: error_occurred implies precomp_save_error
		end

feature {LACE_I} -- Initialization

	init_system is
			-- Initializes the system.
		do
			create system.make
		end

feature {NONE} -- Retrieval

	retrieve is
			-- Retrieve an existing Eiffel Project from `file.
			-- (If a read-write error occurred you must exit from
			-- application).
		require
			non_void_project_dir: project_directory /= Void
			project_dir_exists: project_directory.path_exists
			file_readable: project_directory.is_project_readable
			not_initialized: not initialized
			project_eif_ok: project_directory.is_project_file_valid
			prev_read_write_error: not read_write_error
		local
			precomp_r: PRECOMP_R
			e_project: like Current
			p_eif: PROJECT_EIFFEL_FILE
			precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
			remote_dir: REMOTE_PROJECT_DIRECTORY
		do
			set_error_status (Ok_status)

			check_existence

			if not error_occurred then

				p_eif := project_directory.project_file
				e_project := p_eif.retrieved_project
				if p_eif.error then
					if p_eif.is_corrupted then
						set_error_status (Retrieve_corrupt_error_status)
					elseif p_eif.is_interrupted then
						set_error_status (Retrieve_interrupt_error_status)
					else
						set_error_status (Retrieve_incompatible_error_status)
						incompatible_version_number.clear_all
						incompatible_version_number.append (p_eif.project_version_number)
					end
				else
					system := e_project.system
					dynamic_lib := e_project.dynamic_lib
					Workbench.update_from_retrieved_project (e_project.saved_workbench)
					if Comp_system.is_precompiled then
						precomp_dirs := Workbench.precompiled_directories
						Precompilation_directories.copy (precomp_dirs)
						create remote_dir.make (project_directory)
						remote_dir.set_system_name (Comp_system.name)
						remote_dir.set_is_precompile_finalized (comp_system.is_precompile_finalized)
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

					check_permissions

					if not error_occurred then
						set_is_initialized
						Execution_environment.change_working_directory (project_directory.path)
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
			if not System.is_precompiled and then project_directory.is_project_writable then
				set_file_status (write_status)
			elseif project_directory.is_project_readable then
				set_file_status (read_only_status)
			else
				set_error_status (file_error_status)
			end
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

	exit_agent: PROCEDURE [ANY, TUPLE]
			-- Optional procedure that should be called when an error occurs and
			-- `exit_on_error' is set.

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
					-- Target
				create file_name.make_from_string (project_directory.workbench_path)
				file_name.set_file_name (System.name)
				app_name := eiffel_layout.Executable_suffix
				if not app_name.is_empty then
					file_name.add_extension (app_name)
				end

				create uf.make (file_name)
				if not uf.exists then
					create uf.make (Precompilation_driver)
					if uf.exists and then uf.is_readable then
						link_eiffel_driver (project_directory.workbench_path,
							system.name,
							eiffel_layout.Prelink_command_name,
							Precompilation_driver)
					end
				end
			end
		end

invariant
	degree_output_not_void: degree_output /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class E_PROJECT
