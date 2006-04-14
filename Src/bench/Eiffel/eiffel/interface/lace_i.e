indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Lace controller

class LACE_I

inherit
	SHARED_WORKBENCH
	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	COMPILER_EXPORTER
	SHARED_EIFFEL_PROJECT
	SHARED_CONF_FACTORY
	PROJECT_CONTEXT
	CONF_ACCESS
	SHARED_EXEC_ENVIRONMENT
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end
	REFACTORING_HELPER
		export
			{NONE} all
		end
	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end
	EIFFEL_ENV
		export
			{NONE} all
		end
	SHARED_OVERRIDDEN_METADATA_CACHE_PATH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Lace initialization
		do
		end

feature -- Status

	is_error: BOOLEAN
			-- Is there an error?

feature -- Access

	file_name: STRING
			-- Full path to the universe/system description

	target_name: STRING
			-- Target to use. (optional, if only one target)

	project_path: STRING
			-- Project path to use. (optional)

	date: INTEGER
			-- Time stamp of file named `file_name'

	successful: BOOLEAN
			-- Is the last compilation successful?

	has_changed: BOOLEAN
			-- Did configuraiton change?

	has_group_changed: BOOLEAN
			-- Did configuration change (and is not group equivalent to the previous).

	date_has_changed: BOOLEAN is
		local
			str: ANY
			new_date: INTEGER
		do
			str := file_name.to_c
			new_date := eif_date ($str)
			Result := new_date /= date
		end

	user_options: USER_OPTIONS
			-- User options, like the eifgen path.

	conf_system: CONF_SYSTEM
			-- Current parsed configuration system.

	target: CONF_TARGET is
			-- Current parsed target as in the configuration file (may not be processed).
		require
			conf_system_set: conf_system /= Void
			target_name_set: target_name /= Void
			target_name_valid: conf_system.targets.item (target_name) /= Void
		do
			Result := conf_system.targets.item (target_name)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Update from retrieved object.

	update_from_retrieved_project (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void
		do
			-- standard_copy (other)
			date := other.date
			compile_all_classes := other.compile_all_classes
			successful := True
		end
feature -- Status setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
			-- if s is relative, the file_name will be absolut.
		require
			s_not_void: s /= Void
		do
			file_name := file_system.absolute_pathname (s)
		end

	set_target_name (s: STRING) is
			-- Assign `s' to `target_name'.
		require
			s_ok: s /= Void and then not s.is_empty
		do
			target_name := s
		ensure
			target_name_set: target_name = s
		end

	set_conf_system (s: like conf_system) is
			-- Assign `s' to `conf_system'.
		require
			s_not_void: s /= Void
		do
			conf_system := s
		ensure
			conf_system_set: conf_system = s
		end

	set_date_stamp is
			-- Set `date' information to the current timestamp of the file.
		local
			ptr: ANY
		do
			ptr := file_name.to_c
			date := eif_date ($ptr)
		end

	reset_date_stamp is
			-- Reset `date' information, that way a complete recompilation
			-- is done on Lace.
		do
				-- Dummy value to make sure it is different from before.
			date := date - 1
		end

	store_user_options is
			-- Store user options to disk.
			-- `successful' is True if there is no error.
		require
			user_options_set: user_options /= Void
		local
			l_user_file: STRING
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
		do
			l_user_file := file_name+".user"
			create l_file.make (l_user_file)
			l_file.open_write
			if l_file.is_writable then
				create l_sed_rw.make (l_file)
				l_sed_rw.set_for_writing
				create l_sed_facilities
				l_sed_facilities.independent_store (user_options, l_sed_rw, True)
				l_file.close
				successful := True
			else
				successful := False
			end
		end


	store is
			-- Store updated configuration into `file_name'.
		require
			conf_system_set: conf_system /= Void
		local
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
			vd72: VD72
		do
			create l_print.make
			conf_system.process (l_print)
			check
				no_error: not l_print.is_error
			end
			create l_file.make (file_name)
			if (l_file.exists and then l_file.is_writable) or else l_file.is_creatable then
				l_file.open_write
				l_file.put_string (l_print.text)
				l_file.close
			else
				create vd72
				vd72.set_file_name (file_name)
				Error_handler.insert_error (vd72)
				Error_handler.raise_error
			end
		end


	recompile is
			-- Recompile config description
		require
			file_name_exists: file_name /= Void
		local
			file: PLAIN_TEXT_FILE
			vd21: VD21
			d1, d2: DATE_TIME
		do
			debug ("Timing")
				create d1.make_now
			end

			create file.make (file_name)
			has_group_changed := False
			has_changed := False
			if not file.exists then
				successful := False
				create vd21
				vd21.set_file_name (file_name)
				Error_handler.insert_error (vd21)
				Error_handler.raise_error
			end

				-- If last compilation was not successful, we have to trigger
				-- the parse again even though the `date' on file did not change.
			if
				conf_system = Void or else
				(universe.target = Void and universe.new_target = Void) or else
				date_has_changed or else
				not successful
			then
				has_changed := True
				do_recompilation
				set_date_stamp
			else
				if universe.new_target = Void then
						-- target hasn't changed so use this as the new one
					universe.set_new_target (universe.target)
				end
			end
			debug ("Timing")
				create d2.make_now
				print ("Degree 7 duration: ")
				print (d2.relative_duration (d1).fine_seconds_count)
				print ("%N")
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				successful := False
			end
		end

	compile_all_classes: BOOLEAN
			-- Are all classes root? i.e. all the classes must be compiled

	process_user_file (a_project_path: STRING) is
			-- Handle the user file.
			-- If we have a user file retrieve it, else create it
			-- If we have a -project_directory argument, set the new path, else set the default path.
			-- Store the new file.
		require
			file_name_ok: file_name /= Void and then not file_name.is_empty
			target_name_set: target_name /= Void and then not target_name.is_empty
			valid_target: conf_system.targets.has (target_name)
		local
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			l_user_file: STRING
			l_file: RAW_FILE
			vd21: VD21
			vd72: VD72
			l_changed: BOOLEAN
		do
			l_user_file := file_name+".user"

				-- if file exists, load it
			create l_file.make (l_user_file)
			if l_file.exists then
				l_file.open_read
				if l_file.is_open_read then
					create l_sed_rw.make (l_file)
					l_sed_rw.set_for_reading
					create l_sed_facilities
					user_options ?= l_sed_facilities.retrieved (l_sed_rw, True)
					l_file.close
				else
					create vd21
					vd21.set_file_name (l_user_file)
					Error_handler.insert_error (vd21)
					Error_handler.raise_error
				end
			end

				-- if we don't have a user_options object, create one.
			if user_options = Void then
				create user_options
			end

				 -- update project path
			if a_project_path /= Void then
				project_path := a_project_path.twin
				l_changed := not equal (a_project_path, user_options.eifgen)
				user_options.set_eifgen (a_project_path)
			elseif user_options.eifgen /= Void then
				project_path := user_options.eifgen
			else
				project_path := file_system.dirname (file_name)
				user_options.set_eifgen (project_path)
				l_changed := True
			end

				-- store the updated config file
			if l_changed then
				store_user_options
				if not successful then
					create vd72
					vd72.set_file_name (l_user_file)
					Error_handler.insert_error (vd72)
					Error_handler.raise_error
				end
			end
		ensure
			user_options_set: user_options /= Void
		rescue
			is_error := True
		end

feature {NONE} -- Implementation

	retrieve_config is
			-- Parse config file.
		require
			file_name_ok: file_name /= Void and then not file_name.is_empty
		local
			l_load: CONF_LOAD
			vd00: VD00
		do
				-- load configuration file
			create l_load
			l_load.retrieve_configuration (file_name)
			if l_load.is_error then
				create vd00
				vd00.set_error (l_load.last_error)
				Error_handler.insert_error (vd00)
				error_handler.raise_error
			end

			conf_system := l_load.last_system
		ensure
			conf_system_set: conf_system /= Void
		rescue
			is_error := True
		end

	compute_target is
			-- Compute the target to compile.
		require
			conf_system_set: conf_system /= Void
		local
			l_new_target: CONF_TARGET
			vd69: VD69
			vd70: VD70
		do
				-- get new target
			if target_name /= Void then
				l_new_target := conf_system.targets.item (target_name)
			elseif conf_system.targets.count = 1 then
				l_new_target := conf_system.targets.linear_representation.first
			else
				create vd69
				Error_handler.insert_error (vd69)
				Error_handler.raise_error
			end
			if l_new_target = Void then
				create vd70.make (target_name)
				Error_handler.insert_error (vd70)
				Error_handler.raise_error
			end
			target_name := l_new_target.name

			internal_project_target_name.set_name (target_name)
		ensure
			target_name_set: target_name /= Void and then not target_name.is_empty
			valid_target: conf_system.targets.has (target_name)
		rescue
			is_error := True
		end

	do_recompilation is
			-- Recompile config description.
		do
			retrieve_config
			compute_target
			build_universe
		ensure
			conf_system_set: conf_system /= Void
		end

	build_universe is
			-- Build the universe using the AST
		require
			valid_conf_system: conf_system /= Void
			valid_target: conf_system.targets.has (target_name)
		local
			sys: SYSTEM_I
			l_new_target, l_old_target: CONF_TARGET
			vd00: VD00
			vd73: VD73
			vd74: VD74
			vd75: VD75
			l_option_vis: CONF_RECOMPUTE_OPTIONS
			l_errors: LIST [CONF_ERROR]
			l_old_pre, l_new_pre: CONF_PRECOMPILE
			l_first: BOOLEAN
			l_root: CONF_ROOT
			l_all_libs: HASH_TABLE [CONF_TARGET, UUID]
		do
				-- get new target
			l_new_target := conf_system.targets.item (target_name)

			l_root := l_new_target.root
			compile_all_classes := l_root /= Void and then l_root.is_all_root

				-- init system, universe, ...
			eiffel_project.init_system
			sys := workbench.system
			if sys = Void then
				l_first := True
					-- do we have a precompile?
				if l_new_target.precompile /= Void then
						--  load precompile as system
					retrieve_precompile (l_new_target)
					sys := workbench.system
				else
						-- no precompile, create new system
					create sys.make
					workbench.set_system (sys)
				end
			else
				date := sys.lace.date
				successful := sys.lace.successful
			end
				-- if the system name has changed, update it
			if sys.name = Void or else not sys.name.is_equal (conf_system.name) then
				sys.set_name (conf_system.name)
			end

				-- we are only here if something in the ace changed, so we always melt
			sys.set_melt

				-- set the old target
			l_old_target := universe.target

				-- set the new target
			universe.set_new_target (l_new_target)

				-- check if target has changed, update target or options if necessary
			has_group_changed := universe.conf_system = Void or l_old_target = Void or else not conf_system.is_group_equivalent (universe.conf_system)
			if has_group_changed then
					-- check if a precompile was modified
				if l_old_target /= Void then
					l_old_pre := l_old_target.precompile
				end
				l_new_pre := l_new_target.precompile
				if l_old_pre /= Void and l_new_pre = Void then
					-- precompile removed
					create vd73
					Error_handler.insert_error (vd73)
					Error_handler.raise_error
				elseif not l_first and l_old_target /= Void and l_old_pre = Void and l_new_pre /= Void then
					-- precompile added and not first compilation
					create vd74
					Error_handler.insert_error (vd74)
					Error_handler.raise_error
				elseif l_old_pre /= Void and then l_new_pre /= Void and then not l_old_pre.is_group_equivalent (l_new_pre) then
					-- precompile changed
					create vd75
					Error_handler.insert_error (vd75)
					Error_handler.raise_error
				end
			else
					-- set the new options on the old target
				create l_option_vis.make (l_new_target)
				l_old_target.process (l_option_vis)
				if l_option_vis.is_error then
					from
						l_errors := l_option_vis.last_errors
						l_errors.start
					until
						l_errors.after
					loop
						create vd00
						vd00.set_error (l_errors.item)
						Error_handler.insert_error (vd00)
						l_errors.forth
					end
					Error_handler.raise_error
				end

					-- update dates of used config files
				l_all_libs := l_old_target.all_libraries
				check
					libraries_set: l_all_libs /= Void
				end
				from
					l_all_libs.start
				until
					l_all_libs.after
				loop
					l_all_libs.item_for_iteration.system.set_file_date
					l_all_libs.forth
				end
				l_new_target := l_old_target
			end
			universe.set_conf_system (conf_system)

			update_settings (l_new_target)

			successful := True
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				successful := False
			end
		end

	update_settings (a_target: CONF_TARGET) is
			-- Update settings set in `a_target'.
		require
			a_target_not_void: a_target /= Void
			system_valid: system /= Void
		local
			l_s: STRING
			l_b: BOOLEAN
			vd15: VD15
			vd83: VD83
			l_settings: HASH_TABLE [STRING, STRING]
		do
			l_settings := a_target.settings

			update_settings_for_eweasel (l_settings)

			l_s := l_settings.item ("address_expression")
			if l_s /= Void then
				if l_s.is_boolean then
					system.allow_address_expression (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("address_expression")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.allow_address_expression (False)
			end

			l_s := l_settings.item ("arguments")
			if l_s /= Void then
			end

			l_s := l_settings.item ("array_optimization")
			if l_s /= Void then
				if l_s.is_boolean then
					fixme ("Enable array optimizations")
					system.set_array_optimization_on (False)
				else
					create vd15
					vd15.set_option_name ("array_optimization")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_array_optimization_on (False)
			end

			System.server_controler.set_block_size (1024)

			l_s := l_settings.item ("check_generic_creation_constraint")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_check_generic_creation_constraint (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("check_generic_creation_constraint")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_check_generic_creation_constraint (True)
			end

			l_s := l_settings.item ("check_vape")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_do_not_check_vape (not l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("check_vape")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_do_not_check_vape (False)
			end

				-- CLS compliant implies that the generated
				-- metadata are CLS compliant and that generated
				-- names are too. However, you might want to
				-- keep your Eiffel names in which case, after
				-- having set `cls_compliant (yes)' you
				-- have to do `dotnet_naming_convention (no)'. If
				-- you do it the other way the `dotnet_naming_convention (no)'
				-- option will not be taken into account.
				-- Also you cannot change this option after
				-- the first successful compilation as it might
				-- break a lot of stuff.
			l_s := l_settings.item ("cls_compliant")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_cls_compliant (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("cls_compliant")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				-- once set don't loose it
			end

			l_s := l_settings.item ("console_application")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_console_application (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("console_application")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_console_application (False)
			end

			l_s := l_settings.item ("dead_code_removal")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_remover_off (not l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("dead_code_removal")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_remover_off (False)
			end

				-- see cls_compliant comment above
			l_s := l_settings.item ("dotnet_naming_convention")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_dotnet_naming_convention (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("dotnet_naming_convention")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_dotnet_naming_convention (False)
			end

			l_s := l_settings.item ("dynamic_runtime")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_dynamic_runtime (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("dynamic_runtime")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_dynamic_runtime (False)
			end

			l_s := l_settings.item ("dynamic_runtime")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_dynamic_runtime (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("dynamic_runtime")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_dynamic_runtime (False)
			end

			l_s := l_settings.item ("exception_trace")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_exception_stack_managed (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("exception_trace")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_exception_stack_managed (False)
			end

			l_s := l_settings.item ("external_runtime")
			if l_s /= Void then
				system.set_external_runtime (l_s)
			end

			l_s := l_settings.item ("full_type_checking")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_full_type_checking (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("full_type_checking")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_full_type_checking (False)
			end

			l_s := l_settings.item ("il_verifiable")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_il_verifiable (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("il_verifiable")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_il_verifiable (True)
			end

			l_s := l_settings.item ("inlining")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_inlining_on (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("inlining")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_inlining_on (False)
			end

			l_s := l_settings.item ("inlining_size")
			if l_s /= Void then
				if l_s.is_integer and then l_s.to_integer >= 0 and l_s.to_integer <= 100 then
					system.set_inlining_size (l_s.to_integer)
				else
					create vd15
					vd15.set_option_name ("inlining_size")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_inlining_size (4)
			end

			l_s := l_settings.item ("java_generation")
			if l_s /= Void then
				if l_s.is_boolean then
					l_b := l_s.to_boolean
						-- value can't change from a precompile or in a compiled system
					if l_b /= system.il_generation and then (a_target.precompile /= Void or workbench.has_compilation_started) then
						create vd83.make ("java_generation")
						Error_handler.insert_warning (vd83)
					else
						system.set_java_generation (l_b)
					end
				else
					create vd15
					vd15.set_option_name ("java_generation")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
					-- don't loose java_generation flag
			end

			l_s := l_settings.item ("line_generation")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_line_generation (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("line_generation")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_line_generation (False)
			end

			l_s := l_settings.item ("metadata_cache_path")
			if l_s = Void then
				l_s := overridden_metadata_cache_path
			else
				l_s := conf_factory.new_location_from_path (l_s, a_target).evaluated_directory
			end
				-- value can't change from a precompile or in a compiled system
			if l_s /= Void and then not equal (l_s, system.metadata_cache_path) and then (a_target.precompile /= Void or workbench.has_compilation_started) then
				create vd83.make ("metadata_cache_path")
				Error_handler.insert_warning (vd83)
				-- new system without precompile, set value
			elseif (a_target.precompile = Void and not workbench.has_compilation_started) then
				if l_s = Void then
					l_s := conf_factory.new_location_from_path ((create {EIFFEL_ENV}).assemblies_path, a_target).evaluated_directory
				end
				system.set_metadata_cache_path (l_s)
			end

			l_s := l_settings.item ("msil_assembly_compatibility")
			if l_s /= Void then
				system.set_msil_assembly_compatibility (l_s)
			end

			l_s := l_settings.item ("msil_classes_per_module")
			if l_s /= Void then
				if l_s.is_natural_16 then
					system.set_msil_classes_per_module (l_s.to_natural_16)
				else
					create vd15
					vd15.set_option_name ("msil_classes_per_module")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			end

			l_s := l_settings.item ("msil_culture")
			if l_s /= Void then
				system.set_msil_culture (l_s)
			end

			l_s := l_settings.item ("msil_generation")
			if l_s /= Void then
				if l_s.is_boolean then
					l_b := l_s.to_boolean
						-- value can't change from a precompile or in a compiled system
					if l_b /= system.il_generation and then (a_target.precompile /= Void or workbench.has_compilation_started) then
						create vd83.make ("msil_generation")
						Error_handler.insert_warning (vd83)
					else
						system.set_il_generation (l_b)
						il_parsing_cell.set_item (l_b)
					end
				else
					create vd15
					vd15.set_option_name ("msil_generation")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
					-- don't loose il generation flag
			end

			l_s := l_settings.item ("msil_clr_version")
			if system.il_generation then
				set_clr_runtime_version (l_s)
			end

			l_s := l_settings.item ("msil_generation_type")
			if l_s /= Void then
				if l_s.is_case_insensitive_equal ("exe") or l_s.is_case_insensitive_equal ("dll") then
					system.set_msil_generation_type (l_s.as_lower)
				else
					create vd15
					vd15.set_option_name ("msil_generation_type")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_msil_generation_type ("exe")
			end

			l_s := l_settings.item ("msil_key_file_name")
			if l_s /= Void then
				system.set_msil_key_file_name (conf_factory.new_location_from_full_path (l_s, a_target).evaluated_path)
			end

			l_s := l_settings.item ("msil_use_optimized_precompile")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_msil_use_optimized_precompile (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("msil_use_optimized_precompile")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_msil_use_optimized_precompile (False)
			end

				-- il generation has no multithreaded
			if not system.il_generation then
				l_s := l_settings.item ("multithreaded")
				if l_s /= Void then
					if l_s.is_boolean then
						l_b := l_s.to_boolean
							-- value can't change from a precompile or in a compiled system
						if l_b /= system.has_multithreaded and then (a_target.precompile /= Void or workbench.has_compilation_started) then
							create vd83.make ("multithreaded")
							Error_handler.insert_warning (vd83)
						else
							system.set_has_multithreaded (l_b)
						end
					else
						create vd15
						vd15.set_option_name ("multithreaded")
						vd15.set_option_value (l_s)
						Error_handler.insert_error (vd15)
					end
				else
					-- once set we don't loose the multithreaded flag
				end
			end

			l_s := l_settings.item ("old_verbatim_strings")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_has_old_verbatim_strings (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("old_verbatim_strings")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_has_old_verbatim_strings (False)
			end
			l_s := l_settings.item ("old_verbatim_strings_warning")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_has_old_verbatim_strings_warning (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("old_verbatim_strings_warning")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_has_old_verbatim_strings_warning (False)
			end

			l_s := l_settings.item ("shared_library_definition")
				-- If the release doesn't generate DLL's,
				-- we do not take the option into account in the Ace.
			if l_s /= Void and has_dll_generation then
				system.set_dynamic_def_file (conf_factory.new_location_from_full_path (l_s, a_target).evaluated_path)
			end

			l_s := l_settings.item ("syntax_warning")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_has_syntax_warning (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("syntax_warning")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_has_syntax_warning (False)
			end

			l_s := l_settings.item ("use_cluster_name_as_namespace")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_use_cluster_as_namespace (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("use_cluster_name_as_namespace")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_use_cluster_as_namespace (True)
			end

			l_s := l_settings.item ("use_all_cluster_name_as_namespace")
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_use_all_cluster_as_namespace (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name ("use_all_cluster_name_as_namespace")
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_use_all_cluster_as_namespace (True)
			end

			Error_handler.checksum
		end

	update_settings_for_eweasel (a_settings: HASH_TABLE [STRING, STRING]) is
			-- Update settings to run with eweasel
		local
			l_shared: SHARED_CONFIGURE_RESOURCES
			l_runtime_version: STRING
		do
			create l_shared
			if l_shared.configure_resources.get_boolean ("eweasel_for_dotnet", False) then
				l_runtime_version := l_shared.configure_resources.get_string ("clr_version", Void)

				a_settings.force ("true", "msil_generation")

				if compilation_modes.is_precompiling then
					a_settings.force ("dll", "msil_generation_type")
				else
					a_settings.force ("exe", "msil_generation_type")
				end

				if l_runtime_version /= Void then
					a_settings.force (l_runtime_version, "msil_clr_version")
				end

				a_settings.force ("true", "console_application")
			end
		end

	retrieve_precompile (a_target: CONF_TARGET) is
			-- Load the precompile as the system.
		require
			valid_conf_system: conf_system /= Void
			valid_target: a_target /= Void and then a_target.precompile /= Void
		local
			l_pre: CONF_PRECOMPILE
			l_system: CONF_SYSTEM
			l_load: CONF_LOAD
			vd77: VD77
			vd78: VD78
			vd79: VD79
			vd21: VD21
			l_file_name, l_user_file: STRING
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			l_file: RAW_FILE
			l_pre_path: FILE_NAME
			l_user_options: USER_OPTIONS
			l_precomp_r: PRECOMP_R
			l_target: CONF_TARGET
			l_old_target: CONF_TARGET
		do
			l_pre := a_target.precompile

				-- check if the configuration file is ok
			l_file_name := l_pre.location.evaluated_path
			create l_load
			l_load.retrieve_configuration (l_file_name)
			if l_load.is_error then
				create vd77
				vd77.set_error (l_load.last_error)
				Error_handler.insert_error (vd77)
				Error_handler.raise_error
			end
			l_system := l_load.last_system

				-- check if user file is ok and get EIFGENS location
			l_user_file := l_file_name+".user"
			create l_file.make (l_user_file)
			if l_file.exists then
				l_file.open_read
				if l_file.is_open_read then
					create l_sed_rw.make (l_file)
					l_sed_rw.set_for_reading
					create l_sed_facilities
					l_user_options ?= l_sed_facilities.retrieved (l_sed_rw, True)
					l_file.close
				else
					create vd21
					vd21.set_file_name (l_user_file)
					Error_handler.insert_error (vd21)
					Error_handler.raise_error
				end
			else
					-- default
				create l_user_options
				l_user_options.set_eifgen (l_pre.location.build_path (eiffelgens, ""))
			end
			if l_user_options = Void or else l_user_options.eifgen = Void then
				create vd79
				Error_handler.insert_error (vd79)
				Error_handler.raise_error
			end

				-- check if we have a library target
			if l_system.library_target = Void then
				create vd78
				Error_handler.insert_error (vd78)
				Error_handler.raise_error
			end

				-- retrieve precompile project
			create l_pre_path.make_from_string (l_user_options.eifgen)
			l_pre_path.extend (Eiffelgens)
			l_pre_path.extend (l_system.library_target.name)
			create l_precomp_r
			l_precomp_r.retrieve_precompiled (l_pre_path)

				-- move the configuration data from the precompile into the precompile node
			l_target := universe.target
			l_old_target := a_target
			l_old_target.precompile.set_library_target (l_target)
			l_old_target.set_all_libraries (l_target.all_libraries)
			l_old_target.set_all_assemblies (l_target.all_assemblies)
			universe.set_new_target (l_old_target)
			universe.new_target_to_target

				-- Force a rebuild for the first compilation of a system using
				-- a precompiled library.
			system.set_rebuild (True)
		ensure
			valid_system: workbench.system /= Void
		end

	set_clr_runtime_version (a_version: STRING) is
			-- Set clr runtime version, use default if `a_version' is Void.
		local
			l_installed_runtimes: DS_LINEAR [STRING]
			l_il_env: IL_ENVIRONMENT
			vd15: VD15
		do
			create l_il_env

			if a_version = Void then
				system.set_clr_runtime_version (l_il_env.default_version)
			else
				l_installed_runtimes := l_il_env.installed_runtimes
				if not l_installed_runtimes.has (a_version) then
					create vd15
					vd15.set_option_name ("msil_clr_version")
					vd15.set_option_value (a_version)
					Error_handler.insert_error (vd15)
					Error_handler.raise_error
				end

				system.set_clr_runtime_version (a_version)
			end

			create l_il_env.make (system.clr_runtime_version)
			l_il_env.register_environment_variable
		end

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- Time stamp primitive
		external
			"C"
		end

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
