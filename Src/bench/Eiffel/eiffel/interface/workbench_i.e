-- Internal representation of the workbench.

class WORKBENCH_I

inherit
	SHARED_ERROR_HANDLER
		export
			{ANY} Error_handler
		end

	SHARED_RESCUE_STATUS

	SHARED_PASS

	SHARED_COMPILATION_MODES

	SHARED_CONFIGURE_RESOURCES

	PROJECT_CONTEXT

	COMPILER_EXPORTER

	SHARED_EIFFEL_PROJECT

	SHARED_ID

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

	compilation_counter: INTEGER
			-- Number of recompilations

	system_defined: BOOLEAN is
			-- Has the system been defined?
			-- (Yes, if the Ace file has been
			-- parsed).
		do
			Result := system /= Void
		ensure
			defined: Result implies system /= Void
		end

feature -- Conveniences

	set_system (s: like system) is
			-- Assign `s' to `system'.
		require
			valid_s: s /= Void
		do
			system := s
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

feature -- Initialization

	make is
			-- Initialize the workbench.
			-- (Do not create system until the
			-- first compilation).
		do
			!! universe.make
			!! precompiled_directories.make (5)
			!! lace
			compilation_counter := 1
			init
		ensure
			initialized: universe /= Void and then
					lace /= Void
		end

	init is
			-- Create an eiffel workbench.
		local
			eiffel_init: EBENCH_YACC_EIFFEL
			lace_init: YACC_LACE
			feature_as: FEATURE_AS_B
			invariant_as: INVARIANT_AS_B
		once
				-- Initialization of Yacc-Eiffel interface
			!!eiffel_init.init
			!!lace_init.init

				-- Record dynamic types for instances of FEATURE_AS and
				-- INVARIANT_AS (See routine `make_index' of class
				-- TMP_AST_SERVER).
			!!feature_as
			set_dtype1 ($feature_as)
			!!invariant_as
			set_dtype2 ($invariant_as)

				-- Parsers initialization
			eiffel_parser_init
			lace_parser_init

				-- Error handler initialization
			Error_handler.send_yacc_information

			new_session := True
		end

feature -- Commands

	recompile is
			-- Incremental recompilation
		require
			Error_handler_has_no_errors: Error_handler.error_list.empty
		local
			retried: BOOLEAN
		do
			if not retried then
				if automatic_backup then
					create_backup_directory
				end

				if Compilation_modes.is_quick_melt then
					record_changed_classes
				else 
					Lace.recompile
				end

					-- If it was the first compilation and if the ace file
					-- was incorrect we need to raise again the exception
					-- which was made first by yacc, since it has been forget
					-- during the rescue processing within the Lace.
				if System /= Void and then Lace.successful then
					System.recompile
				else
					Error_handler.raise_error
				end

					-- If the compilation is successful we are going to print the warnings only
					-- If there was an error during the compilation, this feature won't never be called
					-- and the Error_handler.trace from the rescue clause will print the warnings
				Error_handler.trace_warnings
			else
				retried := False
			end

			if successful then
					--| Store the System info even after an error
					--|	(the next compilation will be stored in a different
					--| directory)
				if automatic_backup then
					save_backup_info
					create_backup_directory
				end

				compilation_counter := compilation_counter + 1
			end
		ensure
			increment_compilation_counter: compilation_counter = old compilation_counter + 1
		rescue
			if Rescue_status.is_error_exception then
				Compilation_modes.reset_modes
				Rescue_status.set_is_error_exception (False)
				retried := True
				Error_handler.trace
				if System /= Void then
						-- System is created if precompilation is valid
					System.set_current_class (Void)
				end
				retry
			end
		end

	successful: BOOLEAN is
			-- Is the last compilation successful?
		do
			Result := lace.successful and then system.successful
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
			pass1_controler.insert_new_class (cl.compiled_class)
		end
		
	record_changed_classes is
			-- Record all the classes in the universe that
			-- have changed.
		local
			classes: ARRAY [CLASS_C]
			classc: CLASS_C
			classi: CLASS_I
			i,c : INTEGER
		do
			from
				Degree_output.put_start_degree_6 (0)

					-- Get the array with all the classes in the system
				classes := System.classes.item (Normal_compilation)

					-- Get the number of element in the array
				c := System.class_counter.item (Normal_compilation).count
				i := 1
			until
				i > c
			loop
					-- We are looking to all the classes of a Normal compilation
				classc := classes.item (i)
				if classc /= Void then
					classi := classc.lace_class
					if classi.date_has_changed then
						change_class (classi)
						classi.set_date	
					end
				end
				i := i + 1
			end
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
			pass1_controler.insert_changed_class (class_to_recompile)
			pass2_controler.insert_new_class (class_to_recompile)
			pass3_controler.insert_new_class (class_to_recompile)
			pass4_controler.insert_new_class (class_to_recompile)
		end

feature -- Merging

	merge (other: like Current) is
			-- Merge `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			precompiled_directories.merge (other.precompiled_directories)
			Precompilation_directories.copy (precompiled_directories)
			universe.merge (other.universe)
			system.merge (other.system)
		end

feature -- Automatic backup

	automatic_backup: BOOLEAN is
			-- Is the automatic backup on?
		once
			Result := Configure_resources.get_boolean (r_AutomaticBackup, True)
		end

	create_backup_directory is
			-- Create the subdirectory for backup `compilation_counter'
		local
			d: DIRECTORY
		do
				-- Create the EIFGEN/BACKUP directory
			!!d.make (Backup_path)
			if not d.exists then
				d.create
			end

				-- Create the EIFGEN/BACKUP/COMP<n> directory
			!!d.make (backup_subdirectory)
			if not d.exists then
				d.create
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
			temp.append_integer (compilation_counter)
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
				file.putstring (c.cluster_name)
				file.put_character ('%T')
				file.putstring (c.backup_subdirectory)
				file.new_line
				l.forth
			end

			file.close

			new_session := False
		end

feature {NONE} -- Automatic Backup

	new_session: BOOLEAN
		-- Is it the first compilation in the session?

feature {NONE} -- Externals

	eiffel_parser_init is
			-- Eiffel parser initialization.
		external
			"C"
		alias
			"eif_init"
		end

	lace_parser_init is
			-- Lace parser initialization
		external
			"C"
		alias 
			"lp_init"
		end

	set_dtype1 (o: POINTER) is
			-- Record dynamic type of FEATURE_AS
		external	
			"C"
		end

	set_dtype2 (o: POINTER) is
			-- Record dynamic type of INVARIANT_AS
		external
			"C"
		end

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end

end
