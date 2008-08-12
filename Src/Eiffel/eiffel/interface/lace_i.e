indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class LACE_I

inherit
	SHARED_WORKBENCH
	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	COMPILER_EXPORTER
	SHARED_EIFFEL_PROJECT
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
	SYSTEM_CONSTANTS
		export
			{NONE} all
		end
	SHARED_OVERRIDDEN_METADATA_CACHE_PATH
		export
			{NONE} all
		end
	CONF_VALIDITY
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	CONF_FILE_DATE
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

	is_precompile_invalid: BOOLEAN
			-- Is the specified precompile invalid (configuration file can not be read or no library target)?
			-- It is NOT invalid if it is not compiled or compiled with a different version.

	is_precompilation_needed: BOOLEAN
			-- Does the target have a precompile that needs to be (re)precompiled?

	is_force_new_target: BOOLEAN
			-- Should a new target be created even if we didn't have any changes.
			-- This also ignores warnings as it is expected that such warnings have already been added/reported
			-- when real changes were done.

feature -- Access

	file_name: STRING
			-- Full path to the universe/system description.

	directory_name: STRING
			-- Full path to the universe/system description parent directory.

	target_name: STRING
			-- Target to use. (optional, if only one target).

	project_path: STRING
			-- Project path to use. (optional).

	date: INTEGER
			-- Time stamp of file named `file_name'.

	successful: BOOLEAN
			-- Is the last compilation successful?.

	has_changed: BOOLEAN
			-- Did configuraiton change?

	has_group_changed: BOOLEAN
			-- Did configuration change (and is not group equivalent to the previous).

	date_has_changed: BOOLEAN is
		do
			Result := file_modified_date (file_name) /= date
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

	precompile: CONF_PRECOMPILE
			-- Precompile needed for building our target.

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

	force_new_target is
			-- Set `is_force_new_target' to True.
		do
			is_force_new_target := True
		ensure
			is_force_new_target: is_force_new_target
		end

	check_precompile is
			-- Check precompile and update `precompile', `is_precompile_invalid' and `is_precompilation_needed'.
		require
			valid_conf_system: conf_system /= Void
			valid_target: target /= Void
		local
			l_load: CONF_LOAD
			l_factory: CONF_COMP_FACTORY
			l_project_location: PROJECT_DIRECTORY
			l_epr: PROJECT_EIFFEL_FILE
			l_epr_file: FILE_NAME
		do
				-- check if the precompile is valid
			precompile := target.precompile
			if precompile /= Void then
				create l_factory
				create l_load.make (l_factory)
				l_load.retrieve_configuration (precompile.location.evaluated_path)
				if l_load.is_error then
					is_precompile_invalid := True
				else
					is_precompile_invalid := l_load.last_system.library_target = Void
				end
			end

				-- check if it needs to be (re)precompiled
			if precompile /= Void and then not is_precompile_invalid then
				if precompile.eifgens_location /= Void then
					create l_project_location.make (precompile.eifgens_location.evaluated_path, l_load.last_system.library_target.name)
				else
					create l_project_location.make (precompile.location.build_path ("", ""), l_load.last_system.library_target.name)
				end
				create l_epr_file.make_from_string (l_project_location.target_path)
				l_epr_file.set_file_name (project_file_name)
				create l_epr.make (l_epr_file)
				l_epr.check_version_number (0)
				is_precompilation_needed := l_epr.has_error
			end
		ensure
			compilation_need_implies_ok: is_precompilation_needed implies precompile /= Void and not is_precompile_invalid
		end

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
			-- if s is relative, the file_name will be absolute.
			-- Assign parent directory of file_name
		require
			s_not_void: s /= Void
		do
			file_name := file_system.absolute_pathname (s)
			directory_name := file_system.absolute_parent_directory (file_name)
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
		do
			date := file_modified_date (file_name)
		end

	reset_date_stamp is
			-- Reset `date' information, that way a complete recompilation
			-- is done on Lace.
		do
				-- Dummy value to make sure it is different from before.
			date := date - 1
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

			if
				is_force_new_target or else
				conf_system = Void or else
				(universe.target = Void and universe.new_target = Void) or else
				date_has_changed or else not successful or else
				(universe.target /= Void and then universe.conf_system.deep_date_has_changed) or else
				(universe.new_target /= Void and then universe.new_target.system.deep_date_has_changed)
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
		ensure
			new_target_set: successful implies universe.new_target /= Void
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				successful := False
			end
		end

	compile_all_classes: BOOLEAN
			-- Are all classes root? i.e. all the classes must be compiled

	process_user_file (a_project_path: STRING; a_user_file_enabled: BOOLEAN) is
			-- Handle the user file.
			-- If `a_user_file_enabled' and then if we have a user file retrieve it, else create it
			-- If we have a -project_directory argument, set the new path, else set the default path.
			-- Store the new file.
		require
			file_name_ok: file_name /= Void and then not file_name.is_empty
			target_name_set: target_name /= Void and then not target_name.is_empty
			valid_target: conf_system.targets.has (target_name)
		local
			vd21: VD21
			l_changed: BOOLEAN
			l_user_factory: USER_OPTIONS_FACTORY
			l_target_options: TARGET_USER_OPTIONS
		do
			if a_user_file_enabled then
				create l_user_factory
				l_user_factory.load (conf_system.file_name)
				if l_user_factory.successful then
					user_options := l_user_factory.last_options
					if user_options = Void then
							-- No user options yet.
						create user_options.make (conf_system.file_name, target_name)
					end
				else
					create vd21
					vd21.set_file_name (l_user_factory.last_file_name)
					Error_handler.insert_error (vd21)
					Error_handler.raise_error
				end
			else
					-- Create fake options to avoid too many if statements below.
				create user_options.make (conf_system.file_name, target_name)
			end

				-- Update targets
			if not equal (user_options.target_name, target_name) then
				user_options.set_target_name (target_name)
				l_changed := True
			end

				-- Get options for selected target.
			l_target_options := user_options.target

				 -- update project path
			if a_project_path /= Void then
				project_path := a_project_path.twin

					-- make it into an absolute path
				project_path := file_system.absolute_pathname (project_path)

				l_changed := not equal (project_path, l_target_options.last_location)
				l_target_options.set_last_location (project_path)
				l_changed := True
			elseif l_target_options.last_location /= Void then
				project_path := l_target_options.last_location
			else
				project_path := file_system.dirname (file_name)
				l_target_options.set_last_location (project_path)
				l_changed := True
			end

				-- store the updated config file
			if l_changed and a_user_file_enabled then
					-- We do not check that we could store the options.
				l_user_factory.store (user_options)
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
			l_factory: CONF_COMP_FACTORY
		do
			create l_factory
				-- load configuration file
			create l_load.make (l_factory)
			l_load.retrieve_configuration (file_name)
			if l_load.is_error then
				create vd00
				vd00.set_error (l_load.last_error)
				Error_handler.insert_error (vd00)
				error_handler.raise_error
			end

				-- add warnings
			if l_load.is_warning then
				l_load.last_warnings.do_all (agent (a_warning: CONF_ERROR)
					require
						a_warning_not_void: a_warning /= Void
					local
						vd80: VD80
					do
						create vd80
						vd80.set_warning (a_warning)
						error_handler.insert_warning (vd80)
					end)
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
			vd68: VD68
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
			if conf_system.targets.item (target_name).is_abstract then
				create vd68.make (target_name)
				Error_handler.insert_error (vd68)
				Error_handler.raise_error
			end

			project_location.set_target (target_name)

				 -- set ISE_PRECOMP
			eiffel_layout.set_precompile (target.setting_msil_generation)
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

				-- we are only here if something in the ace changed, so we always melt
			sys.set_melt

				-- set the old target
			l_old_target := universe.target

				-- if groups in application configuration have changed or if any other configuration file has changed, we are not sure to be group equivalent anymore
				-- else we can just update the options

				-- changes in application configuration are handled specially so that we don't need to rebuild if we only change an option
			if universe.conf_system /= Void then
				universe.conf_system.set_file_date
			end
			has_group_changed := is_force_new_target or else universe.conf_system = Void or l_old_target = Void or else l_old_target.system.deep_date_has_changed or not conf_system.is_group_equivalent (universe.conf_system)
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
				l_all_libs := l_old_target.system.all_libraries
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

			update_settings (l_new_target)
			if l_new_target.version /= Void then
				system.set_msil_version (l_new_target.version.version)
			end

				-- set the new target
			universe.set_new_target (l_new_target)

			if has_group_changed then
				parse_target (l_new_target)
			end

			successful := True
		ensure
			new_target_ok: universe.new_target /= Void and then
					universe.new_target.system.all_libraries /= Void and universe.new_target.system.application_target /= Void
			old_target_ok: universe.target = old universe.target and universe.target /= Void implies
					universe.target.system.application_target /= Void and universe.target.system.all_libraries /= Void
		rescue
			if Rescue_status.is_error_exception then
					-- Reset `Workbench'
				successful := False
			end
		end

	parse_target (a_target: CONF_TARGET) is
			-- Parse `a_target' completely (incl. all libraries)
		require
			a_target_not_void: a_target /= Void
		local
			l_factory: CONF_COMP_FACTORY
			l_parse_vis: CONF_PARSE_VISITOR
			l_state: CONF_STATE
			vd00: VD00
			vd80: VD80
			l_errors: LIST [CONF_ERROR]
		do
			create l_factory
			l_state := universe.conf_state_from_target (a_target)
			create l_parse_vis.make_build (l_state, a_target, l_factory)
			a_target.process (l_parse_vis)
			if l_parse_vis.is_error then
				is_error := True
				from
					l_errors := l_parse_vis.last_errors
					l_errors.start
				until
					l_errors.after
				loop
					create vd00
					vd00.set_error (l_errors.item)
					error_handler.insert_error (vd00)
					l_errors.forth
				end
				error_handler.raise_error
			elseif not is_force_new_target and l_parse_vis.last_warnings /= Void then
				from
					l_errors := l_parse_vis.last_warnings
					l_errors.start
				until
					l_errors.after
				loop
					create vd80
					vd80.set_warning (l_errors.item)
					error_handler.insert_warning (vd80)
					l_errors.forth
				end
			end
			is_force_new_target := False
		ensure
			application_target_set: not is_error implies a_target.system.application_target /= Void
			all_libraries_set: not is_error implies a_target.system.all_libraries /= Void
			not_force_new_target: not is_force_new_target
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
			vd86: VD86
			l_settings: HASH_TABLE [STRING, STRING]
			l_factory: CONF_COMP_FACTORY
		do
			create l_factory

			l_settings := a_target.settings

			l_s := l_settings.item (s_address_expression)
			if l_s /= Void then
				if l_s.is_boolean then
					system.allow_address_expression (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_address_expression)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.allow_address_expression (False)
			end

			l_s := l_settings.item (s_array_optimization)
			if l_s /= Void then
				if l_s.is_boolean then
					fixme ("Enable array optimizations")
					system.set_array_optimization_on (False)
				else
					create vd15
					vd15.set_option_name (s_array_optimization)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_array_optimization_on (False)
			end

			l_s := l_settings.item (s_automatic_backup)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_automatic_backup (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_automatic_backup)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_do_not_check_vape (False)
			end

			System.server_controler.set_block_size (1024)

			l_s := l_settings.item (s_check_generic_creation_constraint)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_check_generic_creation_constraint (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_check_generic_creation_constraint)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_check_generic_creation_constraint (True)
			end

			l_s := l_settings.item (s_check_vape)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_do_not_check_vape (not l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_check_vape)
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
			l_s := l_settings.item (s_cls_compliant)
			if l_s /= Void then
				if l_s.is_boolean then
					l_b := l_s.to_boolean
						-- value can't change from a precompile or in a compiled system
					if l_b /= system.cls_compliant and then (a_target.precompile /= Void or workbench.has_compilation_started) then
						if not is_force_new_target then
							create vd83.make (s_cls_compliant, system.cls_compliant.out.as_lower, l_s)
							Error_handler.insert_warning (vd83)
						end
					else
						system.set_cls_compliant (l_b)
					end
				else
					create vd15
					vd15.set_option_name (s_cls_compliant)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_cls_compliant (True)
			end

			l_s := l_settings.item (s_console_application)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_console_application (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_console_application)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_console_application (False)
			end

			l_s := l_settings.item (s_check_for_void_target)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_check_for_void_target (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_check_for_void_target)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_check_for_void_target (True)
			end

			l_s := l_settings.item (s_check_for_catcall_at_runtime)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_check_for_catcall_at_runtime (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_check_for_catcall_at_runtime)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_check_for_catcall_at_runtime (False)
			end

			l_s := l_settings.item (s_force_32bits)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_32bits (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_force_32bits)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_32bits (not platform_constants.is_64_bits)
			end

			l_s := l_settings.item (s_dead_code_removal)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_remover_off (not l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_dead_code_removal)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_remover_off (False)
			end

				-- see cls_compliant comment above
			l_s := l_settings.item (s_dotnet_naming_convention)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_dotnet_naming_convention (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_dotnet_naming_convention)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_dotnet_naming_convention (False)
			end

			l_s := l_settings.item (s_dynamic_runtime)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_dynamic_runtime (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_dynamic_runtime)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_dynamic_runtime (False)
			end

			l_s := l_settings.item (s_dynamic_runtime)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_dynamic_runtime (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_dynamic_runtime)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_dynamic_runtime (False)
			end

			l_s := l_settings.item (s_exception_trace)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_exception_stack_managed (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_exception_trace)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_exception_stack_managed (False)
			end

			l_s := l_settings.item (s_external_runtime)
			if l_s /= Void then
				system.set_external_runtime (l_s)
			end

			l_s := l_settings.item (s_executable_name)
			if l_s = Void then
				l_s := a_target.system.name
			elseif not (create {EIFFEL_SYNTAX_CHECKER}).is_valid_system_name (l_s) then
				create vd15
				vd15.set_option_name (s_executable_name)
				vd15.set_option_value (l_s)
				Error_handler.insert_error (vd15)
				l_s := Void
			end
			if l_s /= Void and then (system.name = Void or else not system.name.is_equal (l_s)) then
				system.set_name (l_s)
				system.request_freeze
			end

			l_s := l_settings.item (s_il_verifiable)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_il_verifiable (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_il_verifiable)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_il_verifiable (True)
			end

			l_s := l_settings.item (s_inlining)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_inlining_on (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_inlining)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_inlining_on (True)
			end

			l_s := l_settings.item (s_inlining_size)
			if l_s /= Void then
				if l_s.is_integer and then l_s.to_integer >= 0 and l_s.to_integer <= 100 then
					system.set_inlining_size (l_s.to_integer)
				else
					create vd15
					vd15.set_option_name (s_inlining_size)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_inlining_size (0)
			end

			l_s := l_settings.item (s_java_generation)
			if l_s /= Void then
				if l_s.is_boolean then
					l_b := l_s.to_boolean
						-- value can't change from a precompile or in a compiled system
					if l_b /= system.il_generation and then (a_target.precompile /= Void or workbench.has_compilation_started) then
						if not is_force_new_target then
							create vd83.make (s_java_generation, system.il_generation.out.as_lower, l_s)
							Error_handler.insert_warning (vd83)
						end
					else
						system.set_java_generation (l_b)
					end
				else
					create vd15
					vd15.set_option_name (s_java_generation)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
					-- don't loose java_generation flag
			end

			l_s := l_settings.item (s_line_generation)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_line_generation (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_line_generation)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_line_generation (False)
			end

			l_s := l_settings.item (s_metadata_cache_path)
			if l_s = Void then
				l_s := overridden_metadata_cache_path
			end
			if l_s /= Void then
				l_s := l_factory.new_location_from_path (l_s, a_target).evaluated_directory
			end
				-- value can't change from a precompile or in a compiled system
			if
				l_s /= Void and then
				not (system.metadata_cache_path /= Void and then l_s.is_case_insensitive_equal (system.metadata_cache_path)) and then
				(a_target.precompile /= Void or workbench.has_compilation_started)
			then
				if not is_force_new_target then
					create vd83.make (s_metadata_cache_path, system.metadata_cache_path, l_s)
					Error_handler.insert_warning (vd83)
				end
				-- new system without precompile, set value
			elseif (a_target.precompile = Void and not workbench.has_compilation_started) then
				if l_s = Void then
					l_s := eiffel_layout.assemblies_path
				end
				system.set_metadata_cache_path (l_s)
			end

			l_s := l_settings.item (s_msil_assembly_compatibility)
			if l_s /= Void then
				system.set_msil_assembly_compatibility (l_s)
			end

			l_s := l_settings.item (s_msil_classes_per_module)
			if l_s /= Void then
				if l_s.is_natural_16 and then l_s.to_natural_16 > 0 then
					system.set_msil_classes_per_module (l_s.to_natural_16)
				else
					create vd15
					vd15.set_option_name (s_msil_classes_per_module)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			end

			l_s := l_settings.item (s_msil_culture)
			if l_s /= Void then
				system.set_msil_culture (l_s)
			end

			l_s := l_settings.item (s_msil_generation)
			if l_s /= Void then
				if l_s.is_boolean then
					l_b := l_s.to_boolean
						-- value can't change from a precompile or in a compiled system
					if l_b /= system.il_generation and then (a_target.precompile /= Void or workbench.has_compilation_started) then
						if not is_force_new_target then
							create vd83.make (s_msil_generation, system.il_generation.out.as_lower, l_s)
							Error_handler.insert_warning (vd83)
						end
					elseif l_b and then not eiffel_layout.default_il_environment.is_dotnet_installed then
						create vd86
						Error_handler.insert_error (vd86)
					else
						system.set_il_generation (l_b)
						il_parsing_cell.put (l_b)
					end
				else
					create vd15
					vd15.set_option_name (s_msil_generation)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
					-- don't loose il generation flag
			end

			l_s := l_settings.item (s_msil_clr_version)
			if system.il_generation then
					-- value can't change from a precompile or in a compiled system
				if l_s /= Void and then not equal (system.clr_runtime_version, l_s) and then (a_target.precompile /= Void or workbench.has_compilation_started) then
					if not is_force_new_target then
						create vd83.make (s_msil_clr_version, system.clr_runtime_version, l_s)
						Error_handler.insert_warning (vd83)
					end
				elseif (a_target.precompile = Void and not workbench.has_compilation_started) then
					set_clr_runtime_version (l_s)
				end
			end

			l_s := l_settings.item (s_msil_generation_type)
			if l_s /= Void then
				if l_s.is_case_insensitive_equal ("exe") or l_s.is_case_insensitive_equal ("dll") then
					system.set_msil_generation_type (l_s.as_lower)
				else
					create vd15
					vd15.set_option_name (s_msil_generation_type)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_msil_generation_type ("exe")
			end

			l_s := l_settings.item (s_msil_key_file_name)
			if l_s /= Void then
				system.set_msil_key_file_name (l_factory.new_location_from_full_path (l_s, a_target).evaluated_path)
			end

			l_s := l_settings.item (s_msil_use_optimized_precompile)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_msil_use_optimized_precompile (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_msil_use_optimized_precompile)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_msil_use_optimized_precompile (False)
			end

				-- il generation has no multithreaded
			if not system.il_generation then
				l_s := l_settings.item (s_multithreaded)
				if l_s /= Void then
					if l_s.is_boolean then
						l_b := l_s.to_boolean
							-- value can't change from a precompile or in a compiled system
						if l_b /= system.has_multithreaded and then (a_target.precompile /= Void or workbench.has_compilation_started) then
							if not is_force_new_target then
								create vd83.make (s_multithreaded, system.has_multithreaded.out.as_lower, l_s)
								Error_handler.insert_warning (vd83)
							end
						else
							system.set_has_multithreaded (l_b)
						end
					else
						create vd15
						vd15.set_option_name (s_multithreaded)
						vd15.set_option_value (l_s)
						Error_handler.insert_error (vd15)
					end
				else
					-- once set we don't loose the multithreaded flag
				end
			end

			l_s := l_settings.item (s_old_feature_replication)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_has_old_feature_replication (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_old_feature_replication)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
					-- By default we set the value to True for backwards compatibility.
				system.set_has_old_feature_replication (True)
			end

			l_s := l_settings.item (s_old_verbatim_strings)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_has_old_verbatim_strings (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_old_verbatim_strings)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_has_old_verbatim_strings (False)
			end

			l_s := l_settings.item (s_platform)
			if l_s /= Void then
				if get_platform (l_s) /= 0 then
					system.set_platform (get_platform (l_s))
				else
					create vd15
					vd15.set_option_name (s_platform)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			end

			l_s := l_settings.item (s_shared_library_definition)
				-- If the release doesn't generate DLL's,
				-- we do not take the option into account in the Ace.
			if l_s /= Void and eiffel_layout.has_dll_generation then
				system.set_dynamic_def_file (l_factory.new_location_from_full_path (l_s, a_target).evaluated_path)
			end

			l_s := l_settings.item (s_use_cluster_name_as_namespace)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_use_cluster_as_namespace (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_use_cluster_name_as_namespace)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_use_cluster_as_namespace (True)
			end

			l_s := l_settings.item (s_use_all_cluster_name_as_namespace)
			if l_s /= Void then
				if l_s.is_boolean then
					system.set_use_all_cluster_as_namespace (l_s.to_boolean)
				else
					create vd15
					vd15.set_option_name (s_use_all_cluster_name_as_namespace)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_use_all_cluster_as_namespace (True)
			end

			Error_handler.checksum
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
			l_file_name: STRING
			l_precomp_r: PRECOMP_R
			l_target: CONF_TARGET
			l_old_target: CONF_TARGET
			l_factory: CONF_COMP_FACTORY
			l_project_location: PROJECT_DIRECTORY
		do
			create l_factory
			l_pre := a_target.precompile

				-- check if the configuration file is ok
			l_file_name := l_pre.location.evaluated_path
			create l_load.make (l_factory)
			l_load.retrieve_configuration (l_file_name)
			if l_load.is_error then
				create vd77
				vd77.set_error (l_load.last_error)
				Error_handler.insert_error (vd77)
				Error_handler.raise_error
			end

				-- add warnings
			if l_load.is_warning then
				l_load.last_warnings.do_all (agent (a_warning: CONF_ERROR)
					require
						a_warning_not_void: a_warning /= Void
					local
						vd80: VD80
					do
						create vd80
						vd80.set_warning (a_warning)
						error_handler.insert_warning (vd80)
					end)
			end

			l_system := l_load.last_system

				-- check if we have a library target
			if l_system.library_target = Void then
				create vd78
				Error_handler.insert_error (vd78)
				Error_handler.raise_error
			end

				-- retrieve precompile project (use EIFGENs location if specified, else next to the config file)
			if l_pre.eifgens_location /= Void then
				create l_project_location.make (l_pre.eifgens_location.evaluated_path, l_system.library_target.name)
			else
				create l_project_location.make (l_pre.location.build_path ("", ""), l_system.library_target.name)
			end
			create l_precomp_r
			l_precomp_r.retrieve_precompiled (l_project_location)

				-- move the configuration data from the precompile into the precompile node
			l_target := universe.target
			l_old_target := a_target
			l_old_target.precompile.set_library_target (l_target)
			l_old_target.system.set_all_libraries (l_target.system.all_libraries)
			l_old_target.system.set_all_assemblies (l_target.system.all_assemblies)
			l_old_target.system.set_application_target (l_old_target)
			universe.set_old_target (l_old_target)

				-- Force a rebuild for the first compilation of a system using
				-- a precompiled library.
			system.set_rebuild (True)

				-- Update the system name
			if not a_target.setting_executable_name.is_empty then
				system.set_name (a_target.setting_executable_name)
			else
				system.set_name (a_target.system.name)
			end
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
