indexing
	description: "Internal representation of the workbench."
	date: "$Date$"
	revision: "$Revision$"

class WORKBENCH_I

inherit
	SHARED_ERROR_HANDLER
		export
			{ANY} Error_handler
		end

	SHARED_RESCUE_STATUS

	SHARED_DEGREES

	SHARED_COMPILATION_MODES

	SHARED_CONFIGURE_RESOURCES

	PROJECT_CONTEXT

	COMPILER_EXPORTER

	SHARED_EIFFEL_PROJECT

feature -- Attributes

	universe: UNIVERSE_I
			-- Universe of the workbench

	system: SYSTEM_I
			-- Current system of the workbench

	lace: LACE_I
			-- Current lace description

	precompiled_directories: EXTEND_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
			-- Precompilation directories, indexed by precompilation ids

	precompiled_driver: FILE_NAME
			-- Full file name of the precompilation driver

	melted_file_name: STRING
			-- File name of the melted file used by the precompilation driver.

	compilation_counter: INTEGER
			-- Number of recompilations

	backup_counter: INTEGER
			-- Number of recompilations using backups

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
			Result := lace.successful and then system.successful
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
		do
			system := s
		ensure
			system_set: system = s
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
		require
			update_file_name_not_void: update_file_name /= Void
			update_file_name_exists: update_file_name.count > 0
		do
			melted_file_name := clone (update_file_name)
		ensure
			assigned: melted_file_name.is_equal (update_file_name)
		end

	on_project_loaded is
			-- A project has just been loaded.
			-- Initialize `Current' accordingly.
		do
			is_compiling := False
		end

feature -- Initialization

	make is
			-- Initialize the workbench.
			-- (Do not create system until the
			-- first compilation).
		do
			create universe.make
			create precompiled_directories.make (5)
			create lace.make
			compilation_counter := 1
			backup_counter := 0
			new_session := True
		ensure
			initialized: universe /= Void and then
					lace /= Void
		end

feature -- Commands

	recompile is
			-- Incremental recompilation
		local
			retried: INTEGER
			missing_class_error: BOOLEAN
			degree_6_done: BOOLEAN
		do
			is_compiling := True
				-- We perform a degree 6 only when it is the first the compilation or
				-- when there was an error during the compilation concerning a missing
				-- class and that no degree 6 has been done before.
				-- To avoid a recursion, we do it at most twice.
			if
				not degree_6_done and then
				(retried = 0 or else (retried = 1 and then missing_class_error))
			then
					-- Clean any previous errors
				Error_handler.wipe_out

				if automatic_backup then
					backup_counter := backup_counter + 1
					create_backup_directory
				end

				if missing_class_error then
					Lace.set_need_directory_lookup (True)
				else
					Lace.set_need_directory_lookup (False)
				end

				if
					not system_defined or else not Lace.not_first_parsing or else
					Lace.date_has_changed or else missing_class_error or else
					not Lace.successful
				then
					degree_6_done := True
				end

				if missing_class_error then
					Lace.force_recompile
				else
					Lace.recompile
				end

				if Lace.successful then
					if Lace.has_changed then
						System.set_melt
					end
				end

					-- If it was the first compilation and if the ace file
					-- was incorrect we need to raise again the exception
					-- which was made first by yacc, since it has been forget
					-- during the rescue processing within the Lace.
				if system_defined and then Lace.successful then
					System.recompile
				else
					if not Error_handler.error_list.is_empty then
						Error_handler.raise_error
					end
				end

				if successful and (System.has_been_changed or else System.freezing_occurred) then
					compilation_counter := compilation_counter + 1
					save_project (Compilation_modes.is_precompiling)
				end

					-- If the compilation is successful we are going to print the
					-- warnings only. If there was an error during the compilation,
					-- this feature won't never be called and the Error_handler.trace
					-- from the rescue clause will print the warnings
				Error_handler.force_display
				Error_handler.trace_warnings
			else
				retried := 2
			end

				--| Store the System info even after an error
				--|	(the next compilation will be stored in a different
				--| directory)
			if automatic_backup then
				save_backup_info
			end

			is_compiling := False
		ensure
			increment_compilation_counter:
				(successful and (System.has_been_changed or else System.freezing_occurred))
					implies compilation_counter = old compilation_counter + 1
		rescue
			if Rescue_status.is_error_exception then
				Error_handler.force_display
				if error_handler.error_list.item.code.is_equal ("IL_Error") then
						-- An error occurs during IL generation, we need to
						-- save current project otherwise EIFGEN is corrupted
						-- due to a bad project file. We also increment
						-- `compilation_counter' since even though it is not
						-- successful, project is created.
					compilation_counter := compilation_counter + 1
					save_project (Compilation_modes.is_precompiling)
				end
				if not Compilation_modes.is_precompiling then
					Compilation_modes.reset_modes
				end
				Rescue_status.set_is_error_exception (False)
				retried := retried + 1
				if not missing_class_error then
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
							-- Resetting the date of Lace will triger a new parsing
							-- and a complete traversing of the cluster directories.
						Lace.reset_date_stamp
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
				is_compiling := False
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
				System.set_licensed_precompilation (False)
				System.save_precompilation_info 
			end
				-- NOTE: possible speed improvement by saving the project when this
				-- condition is satisfied:
				-- not (Compilation_modes.is_quick_melt and then not freezing_occurred)
				-- The drawback is that if you crash and did not save your project
				-- is corrupted.
			Eiffel_project.save_project
			if was_precompiling then
				Eiffel_project.save_precomp (False)
			end
		end

	change_class (cl: CLASS_I) is
			-- Change a class of the system.
		require
			good_argument: cl /= Void
		do
			add_class_to_recompile (cl)

				-- Mark the class syntactically changed
			cl.set_changed (True)

				-- Syntax analysis must be done
			Degree_5.insert_new_class (cl.compiled_class)
		end

	change_all is
			-- Record all the classes in the universe as
			-- changed (for precompilation)
		local
			class_list: EXTEND_TABLE [CLASS_I, STRING]
			c: CLUSTER_I
		do
			from
				Universe.clusters.start
			until
				Universe.clusters.after
			loop
				c := Universe.clusters.item
				if not c.is_precompiled then
					from
						class_list := c.classes
						class_list.start
					until
						class_list.after
					loop
						change_class (class_list.item_for_iteration)
						class_list.forth
					end
				end
				Universe.clusters.forth
			end
		end

	change_all_new_classes is
			-- Record all the classes in the universe as
			-- changed (for compilation using `NONE' as root class)
		local
			class_list: EXTEND_TABLE [CLASS_I, STRING]
			c: CLUSTER_I
			cl: CLASS_I
			file_date: INTEGER
			str: ANY
		do
			from
				Universe.clusters.start
			until
				Universe.clusters.after
			loop
				c := Universe.clusters.item
				if not c.is_precompiled then
					from
						class_list := c.classes
						class_list.start
					until
						class_list.after
					loop
						cl := class_list.item_for_iteration
						if cl.compiled then
							str := cl.file_name.to_c
							file_date := eif_date ($str)
							if file_date /= cl.date then
								change_class (class_list.item_for_iteration)
							end
						else
							change_class (class_list.item_for_iteration)
						end
						class_list.forth
					end
				end
				Universe.clusters.forth
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
					-- Update universe
				cl.set_compiled_class (class_to_recompile)
					-- Update system
				system.insert_new_class (class_to_recompile)
			end

				-- Insertion in the pass controlers
			Degree_5.insert_changed_class (class_to_recompile)
			Degree_4.insert_new_class (class_to_recompile)
			Degree_3.insert_new_class (class_to_recompile)
			Degree_2.insert_new_class (class_to_recompile)
		end

feature -- Automatic backup

	automatic_backup: BOOLEAN is
			-- Is the automatic backup on?
		once
			Result := Configure_resources.get_boolean (r_AutomaticBackup, True)
		end

	create_backup_directory is
			-- Create the subdirectory for backup `backup_counter'
		local
			d: DIRECTORY
		do
				-- Create the EIFGEN/BACKUP directory
			!!d.make (Backup_path)
			if not d.exists then
				d.create_dir
			end

				-- Create the EIFGEN/BACKUP/COMP<n> directory
			!!d.make (backup_subdirectory)
			if not d.exists then
				d.create_dir
			end
		end

	backup_subdirectory: DIRECTORY_NAME is
			-- Current backup subdirectory
		local
			temp: STRING
		do
			!! Result.make_from_string (Backup_path)
			!! temp.make (9)
			temp.append (Comp)
			temp.append_integer (backup_counter)
			Result.extend (temp)
		end

	backup_info_file_name: FILE_NAME is
			-- File where info about the compilation is saved
		do
			!! Result.make_from_string (backup_subdirectory)
			Result.set_file_name (Backup_info)
		end

	save_backup_info is
			-- Save the information about this recompilation
		local
			file: PLAIN_TEXT_FILE
			l: LINKED_LIST [CLUSTER_I]
			c: CLUSTER_I
		do
			!! file.make_open_write (backup_info_file_name)
			file.putstring ("Compiler version: ")
			file.putstring (Version_number)
			file.new_line
			file.putstring ("batch mode: ")
			file.putbool (Eiffel_project.batch_mode)
			file.new_line
			file.putstring ("new session: ")
			file.putbool (new_session)
			file.new_line
			file.putstring ("successful: ")
			file.putbool (successful)
			file.new_line
			file.putstring ("Cluster table:")
			file.new_line

			from
				l := Universe.clusters
				l.start
			until
				l.after
			loop
				c := l.item
				if not c.belongs_to_all then
					file.putstring (c.cluster_name)
					file.new_line
				end
				l.forth
			end

			file.close

			new_session := False
		end

feature {NONE} -- Automatic Backup

	new_session: BOOLEAN
		-- Is it the first compilation in the session?

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end

end

