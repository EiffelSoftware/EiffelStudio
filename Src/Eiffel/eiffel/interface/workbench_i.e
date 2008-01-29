indexing
	description: "Internal representation of the workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class WORKBENCH_I

inherit
	SHARED_ERROR_HANDLER
		export
			{ANY} Error_handler
		end

	SHARED_RESCUE_STATUS

	SHARED_FLAGS

	SHARED_DEGREES

	SHARED_COMPILATION_MODES

	SHARED_CONFIGURE_RESOURCES

	PROJECT_CONTEXT

	COMPILER_EXPORTER

	SHARED_EIFFEL_PROJECT

	CONF_ACCESS

	SYSTEM_CONSTANTS

	SHARED_NAMES_HEAP
		export
			{NONE} all
			{SYSTEM_I} names_heap
		end

feature -- Status

	is_changed: BOOLEAN
			-- Have classes been changed?

feature -- Attributes

	universe: UNIVERSE_I
			-- Universe of the workbench

	system: SYSTEM_I
			-- Current system of the workbench

	lace: LACE_I
			-- Current lace description

	precompiled_directories: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
			-- Precompilation directories, indexed by precompilation ids

	precompiled_driver: FILE_NAME
			-- Full file name of the precompilation driver

	melted_file_name: STRING
			-- File name of the melted file used by the precompilation driver.

	compilation_counter: INTEGER
			-- Number of recompilations

	backup_counter: INTEGER
			-- Number of recompilations using backups

	universe_defined: BOOLEAN is
			-- Has the universe been defined?
		do
			Result := universe /= Void
		ensure
			defined: Result implies universe /= Void
		end

	system_defined: BOOLEAN is
			-- Has the system been defined?
			-- (Yes, if the Ace file has been
			-- parsed).
		do
			Result := system /= Void
		ensure
			defined: Result implies system /= Void
		end

	successful: BOOLEAN is
			-- Is the last compilation successful?
		do
			if system_defined then
				Result := lace.successful and then system.successful and not not_actions_successful
			end
		end

feature -- Update

	set_lace (a_lace: like lace) is
			-- Set `lace' to `a_lace'.
		require
			a_lace_not_void: a_lace /= Void
		do
			lace := a_lace
		ensure
			lace_set: lace = a_lace
		end

	set_changed is
			-- Set `is_changed' to true.
		do
			is_changed := True
		ensure
			is_changed: is_changed
		end

	unset_changed is
			-- Set `is_changed' to false.
		do
			is_changed := False
		ensure
			not_is_changed: not is_changed
		end

feature -- Update from retrieved object.

	update_from_retrieved_project (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void
			lace_not_void: lace /= Void
		local
			l_lace: LACE_I
		do
			l_lace := lace
			standard_copy (other)
			lace := l_lace
			lace.update_from_retrieved_project (other.lace)
				-- Initialize SHARED_NAMES_HEAP with the heap of SYSTEM_I.
			set_names_heap (system.names)
		ensure
			lace_preserved: lace = old lace
		end

feature -- Additional properties

	is_already_compiled: BOOLEAN is
			-- Has project already been compiled at least once?
		do
			Result := compilation_counter > 1
		end

	has_compilation_started: BOOLEAN
			-- Did Eiffel compilation already start in such a way that
			-- some option cannot be changed anymore.

	is_compiling: BOOLEAN
			-- Is the project being compiled?

	is_in_stable_state: BOOLEAN is
			-- Is project in such a state that one can manipulate the project settings,
			-- add new classes, search for classes,...
		do
			Result := system_defined and then not is_compiling and then last_reached_degree <= 5
		ensure
			is_in_stable_state_implies_ready: Result implies is_universe_ready
		end

	is_universe_ready: BOOLEAN is
			-- Is project in such a state that one can search for classes/clusters/libraries.
		do
			Result := system_defined and then last_reached_degree <= 5
		end

	last_reached_degree: INTEGER is
			-- What is the lowest degree that was reached during last compilation?
			-- Or what is the current degree if `is_compiling'?
			-- Warning: it might not have been completed!
		do
			if not successful then
				Result := Eiffel_project.degree_output.last_reached_degree
			else
				Result := -4
			end
		end

feature -- Conveniences

	set_system (s: like system) is
			-- Assign `s' to `system'.
		require
			valid_s: s /= Void
			valid_heap: s.names /= Void
		do
			system := s
				-- Initialize SHARED_NAMES_HEAP with the heap of SYSTEM_I.
			set_names_heap (system.names)
		ensure
			system_set: system = s
			names_heap_set: names_heap = system.names
		end

	set_compilation_started is
			-- Assign `True' to `has_compilation_started'.
		do
			has_compilation_started := True
		ensure
			has_compilation_started_set: has_compilation_started
		end

	set_precompiled_directories (directories: like precompiled_directories) is
			-- Set `precompiled_directories' to `directories'.
		require
			directories_not_void: directories /= Void
		do
			precompiled_directories := directories
		ensure
			assigned: precompiled_directories = directories
		end

	set_precompiled_driver (pd: like precompiled_driver) is
			-- Set `precompiled_driver' to `pd'.
		do
			precompiled_driver := pd
		ensure
			assigned: precompiled_driver = pd
		end

	set_melted_file_name (update_file_name: like melted_file_name) is
			-- Set `melted_file_name' to `upate_file_name'.
		do
			if update_file_name /= Void and then not update_file_name.is_empty then
				melted_file_name := update_file_name.twin
			else
				melted_file_name := Void
			end
		ensure
			assigned: melted_file_name /= Void implies equal (melted_file_name, update_file_name)
			reset: melted_file_name = Void implies (update_file_name = Void or else update_file_name.is_empty)
		end

	on_project_loaded is
			-- A project has just been loaded.
			-- Initialize `Current' accordingly.
		do
			is_compiling := False
			forbid_degree_6 := False
		end

feature -- Initialization

	make is
			-- Initialize the workbench.
			-- (Do not create system until the
			-- first compilation).
		do
			if universe = Void then
				create universe.make
			end
			if lace = Void then
				create lace.make
			end
			create precompiled_directories.make (5)

			compilation_counter := 1
			backup_counter := 0
			new_session := True
		ensure
			initialized: universe /= Void and then lace /= Void
		end

feature -- Commands

	process_actions (an_actions: ARRAYED_LIST [CONF_ACTION]) is
			-- Process pre/post compilation actions.
		require
			an_actions_not_void: an_actions /= Void
		local
			l_action: CONF_ACTION
			vd84: VD84
			vd85: VD85
			l_prc_factory:  PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_success: BOOLEAN
			l_wd: STRING
		do
			create l_prc_factory
			from
				an_actions.start
			until
				an_actions.after
			loop
				l_action := an_actions.item
				if l_action.working_directory /= Void then
					l_wd := l_action.working_directory.evaluated_path
				end
				l_prc_launcher := l_prc_factory.process_launcher_with_command_line (l_action.command, l_wd)
				l_prc_launcher.set_separate_console (is_gui)
				l_prc_launcher.launch
				if l_prc_launcher.launched then
					l_prc_launcher.wait_for_exit
					l_success := l_prc_launcher.exit_code = 0
				end
				if not l_success then
					if l_action.must_succeed then
						create vd84.make (l_action.command)
						error_handler.insert_error (vd84)
						error_handler.checksum
						not_actions_successful := True
					else
						create vd85.make (l_action.command)
						error_handler.insert_warning (vd85)
					end
				end
				an_actions.forth
			end
		end

	recompile is
			-- Incremental recompilation
		local
			retried: INTEGER
			missing_class_error: BOOLEAN
			degree_6_done: BOOLEAN
			l_pre_actions_done: BOOLEAN
		do
			if retried = 0 then
				error_handler.clear_display
			end
			not_actions_successful := False
			if retried = 0 and then (system = Void or else system.automatic_backup) then
					-- Even if backup is not enabled, we will always create a BACKUP
					-- directory. This will be done only once if `automatic_backup' is not
					-- enabled.
				backup_counter := backup_counter + 1
				create_backup_directory
				save_starting_backup_info
			end

				-- We perform a degree 6 only when it is the first the compilation or
				-- when there was an error during the compilation concerning a missing
				-- class and that no degree 6 has been done before.
				-- To avoid a recursion, we do it at most twice.
			if
				not degree_6_done and then
				(retried = 0 or else (retried = 1 and then missing_class_error))
			then
				if not forbid_degree_6 then
					Lace.recompile
				end

				if Lace.successful then
					if not l_pre_actions_done then
						process_actions (universe.conf_system.all_pre_compile_action)
						l_pre_actions_done := True
					end

					System.set_rebuild (False)
					if Lace.has_changed then
						System.set_config_changed (True)
						System.set_melt
						System.set_finalize
					else
						System.set_config_changed (False)
					end
					if Lace.has_group_changed or missing_class_error or compilation_modes.is_discover then
						system.set_rebuild (True)
					end
					System.recompile

					process_actions (universe.conf_system.all_post_compile_action)
				else
					if not Error_handler.error_list.is_empty then
						Error_handler.raise_error
					end
				end

				if successful then
					unset_changed
					system.set_rebuild (False)
					system.reset_has_compilation_started
					compilation_counter := compilation_counter + 1
					if (System.has_been_changed or else System.freezing_occurred) then
						save_project (Compilation_modes.is_precompiling)
					end
				end

					-- If the compilation is successful we are going to print the
					-- warnings only. If there was an error during the compilation,
					-- this feature won't never be called and the Error_handler.trace
					-- from the rescue clause will print the warnings
				Error_handler.trace_warnings
			else
				retried := 2
			end

				--| Store the System info even after an error
				--|	(the next compilation will be stored in a different
				--| directory)
			if system /= Void and then system.automatic_backup then
				save_ending_backup_info
			end
		ensure
			increment_compilation_counter:
				(successful and (System.has_been_changed or else System.freezing_occurred))
					implies compilation_counter = old compilation_counter + 1
			error_handler_empty: error_handler.error_list.is_empty
		rescue
			if Rescue_status.is_error_exception then
				Error_handler.force_display
				if error_handler.error_list.item.code.is_equal ("VIGE") then
						-- An error occurs during IL generation, we need to
						-- save current project otherwise EIFGEN is corrupted
						-- due to a bad project file. We also increment
						-- `compilation_counter' since even though it is not
						-- successful, project is created.
					compilation_counter := compilation_counter + 1
					save_project (Compilation_modes.is_precompiling)
				end
				Rescue_status.set_is_error_exception (False)
				retried := retried + 1
				if not missing_class_error then
					degree_6_done := system /= Void and then system.is_rebuild
					Error_handler.error_list.start
					if
						not degree_6_done and then
						(error_handler.error_list.item.code.is_equal ("VTCT") or else
						error_handler.error_list.item.code.is_equal ("VD21") or else
						error_handler.error_list.item.code.is_equal ("VD20") or else
						error_handler.error_list.item.code.is_equal ("VSCN") or else
						error_handler.error_list.item.code.is_equal ("VD01"))
					then
						missing_class_error := True
						lace.reset_date_stamp
						Error_handler.wipe_out
					else
						Error_handler.trace
					end
				else
					missing_class_error := False
					Error_handler.trace
				end
				if system_defined then
						-- System is created if precompilation is valid
					System.set_current_class (Void)
				end
				retry
			else
				stop_compilation
			end
		end

	save_project (was_precompiling: BOOLEAN) is
			-- Save project after a successful compilation.
		do
				-- FIXME: We don't purge the system when precompiling, because of a
				-- problems with IDs and we give a `False' arguments to
				-- `prepare_before_saving' when precompiling.
				-- i.e. the system which is using the precompiled can think that some
				-- IDs are available but they are not. This is due because of a bad
				-- merging of SERVER_CONTROLs from the different precompiled libraries.
			System.prepare_before_saving (not was_precompiling)
			if was_precompiling then
				System.save_precompilation_info
			end
				-- NOTE: possible speed improvement by saving the project when this
				-- condition is satisfied:
				-- not (Compilation_modes.is_quick_melt and then not freezing_occurred)
				-- The drawback is that if you crash and did not save your project
				-- is corrupted.
			Eiffel_project.save_project
			if was_precompiling then
				Eiffel_project.save_precomp
			end
		end

	change_class (cl: CLASS_I) is
			-- Change a class of the system.
		require
			good_argument: cl /= Void
			not_override: not cl.config_class.does_override
		do
			add_class_to_recompile (cl)

				-- Mark the class syntactically changed
			cl.set_changed (True)

				-- Syntax analysis must be done
			Degree_5.insert_new_class (cl.compiled_class)
		end

	change_all_new_classes is
			-- Record all the classes in the universe as
			-- changed (for compilation using `ANY' as root class)
		local
			classes: DS_HASH_SET [CLASS_I]
			cl: CLASS_I
		do
			from
				classes := universe.all_classes
				classes.start
			until
				classes.after
			loop
				cl := classes.item_for_iteration
				if not cl.is_compiled and not cl.is_external_class and not cl.config_class.does_override then
					change_class (cl)
				end
				classes.forth
			end
		end

	add_class_to_recompile (cl: CLASS_I) is
			-- Recompile the class but do not do the parsing
		require
			good_argument: cl /= Void
		local
			class_to_recompile: CLASS_C
		do
			class_to_recompile := cl.compiled_class
			if class_to_recompile = Void then
					-- Creation of a new instance of a class to recompile:
				   -- a class neither compiled must be compiled.
				class_to_recompile := cl.class_to_recompile
					-- Update system
				system.insert_new_class (class_to_recompile)
			end

				-- Insertion in the pass controlers
			Degree_5.insert_changed_class (class_to_recompile)
			Degree_4.insert_new_class (class_to_recompile)
			Degree_3.insert_new_class (class_to_recompile)
			Degree_2.insert_new_class (class_to_recompile)
		end

feature -- Directory creation

	create_data_directory is
			-- Create the subdirectory for data storage.
		local
			d: DIRECTORY
		do
			if universe_defined then
				create d.make (project_location.data_path)
				if not d.exists then
					d.create_dir
				end
			end
		end

feature -- Automatic backup

	create_backup_directory is
			-- Create the subdirectory for backup `backup_counter'
		local
			d: DIRECTORY
		do
				-- Create the EIFGEN/BACKUP directory
			create d.make (project_location.backup_path)
			if not d.exists then
				d.create_dir
			end

				-- Create the EIFGEN/BACKUP/COMP<n> directory
			create d.make (backup_subdirectory)
			if not d.exists then
				d.create_dir
			end
		end

	backup_subdirectory: DIRECTORY_NAME is
			-- Current backup subdirectory
		local
			temp: STRING
		do
			create Result.make_from_string (project_location.backup_path)
			create temp.make (9)
			temp.append (Comp)
			temp.append_integer (backup_counter)
			Result.extend (temp)
		end

	backup_info_file_name: FILE_NAME is
			-- File where info about the compilation is saved
		do
			create Result.make_from_string (backup_subdirectory)
			Result.set_file_name (Backup_info)
		end

	save_starting_backup_info is
			-- Save the information about this compilation
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (backup_info_file_name)
			if file.is_creatable or else (file.exists and then file.is_writable) then
				file.open_append
				file.put_string ("Compiler version: ")
				file.put_string (Version_number)
				file.put_new_line
				file.put_string ("Type: ")
				file.put_string (compilation_modes.string_representation)
				file.put_new_line
				file.put_string ("batch mode: ")
				file.put_boolean (not is_gui)
				file.put_new_line
				file.put_string ("new session: ")
				file.put_boolean (new_session)
				file.put_new_line
				file.put_string ("starting date: ")
				file.put_string ((create {DATE_TIME}.make_now).out)
				file.put_new_line
				file.close
			end

			new_session := False
		end

	save_ending_backup_info is
			-- Save the information about the status of this compilation
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (backup_info_file_name)
			if file.is_creatable or else (file.exists and then file.is_writable) then
				file.open_append
				file.put_string ("Compilation status is: ")
				file.put_boolean (successful)
				file.put_new_line
				file.put_string ("ending date: ")
				file.put_string ((create {DATE_TIME}.make_now).out)
				file.put_new_line
				file.close
			end

			new_session := False
		end

feature {E_PROJECT} -- Status update

	start_compilation is
			-- Warn the interface that a new compilation is beginning.
		do
			is_compiling := True
			Eiffel_universe.reset_internals
			Eiffel_project.Manager.on_project_compiles
		end

	stop_compilation is
			-- Warn the interface that a compilation is over.
		do
			is_compiling := False
			Eiffel_project.Manager.on_project_recompiled (successful)
		end

feature {NONE} -- Automatic Backup

	new_session: BOOLEAN
			-- Is it the first compilation in the session?

	forbid_degree_6: BOOLEAN
			-- Should the next compilation avoid to perform a degree 6?

feature {NONE} -- Implementation

	not_actions_successful: BOOLEAN;
			-- Was there a problem during running the pre and post compile actions?

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

end


