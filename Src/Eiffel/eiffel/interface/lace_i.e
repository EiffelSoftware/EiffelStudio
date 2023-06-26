note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class LACE_I

inherit
	SHARED_WORKBENCH
	SHARED_BATCH_NAMES
	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	COMPILER_EXPORTER
	SHARED_EIFFEL_PROJECT
	PROJECT_CONTEXT
	CONF_ACCESS
	SHARED_EXECUTION_ENVIRONMENT
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

	SHARED_CONF_SETTING
		export
			{NONE} all
		end

	CONF_ERROR_OBSERVER
		export
			{NONE} all
		end

	CONF_INTERFACE_CONSTANTS
		export
			{NONE} all
		end

	SHARED_DEGREES

create
	make

feature {NONE} -- Initialization

	make
			-- Lace initialization
		do
			(create {CONF_PARSER_CONTROLLER}).prefer_safe (eiffel_layout.compiler_profile.is_safe_mode)
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

feature -- Access: iron packages

	iron_packages_to_install: detachable ARRAYED_LIST [READABLE_STRING_32]
			-- Does the target has iron package that needs to be installed?

	reset_iron_packages_to_install
			-- Reset list of iron package to install
		do
			iron_packages_to_install := Void
		end

	suggest_iron_package_installation (a_package_name: READABLE_STRING_32)
		require
			a_package_name_valid: a_package_name /= Void and then not a_package_name.is_empty
		local
			l_iron_packages_to_install: like iron_packages_to_install
		do
			l_iron_packages_to_install := iron_packages_to_install
			if l_iron_packages_to_install = Void then
				create l_iron_packages_to_install.make (1)
				l_iron_packages_to_install.compare_objects
				iron_packages_to_install := l_iron_packages_to_install
			end
			if not l_iron_packages_to_install.has (a_package_name) then
				l_iron_packages_to_install.force (a_package_name)
			end
		end

feature -- Access

	file_name: STRING_32
			-- Full path to the universe/system description.

	directory_name: STRING_32
			-- Full path to the universe/system description parent directory.

	target_name: STRING_32
			-- Target to use. (optional, if only one target).

	project_path: PATH
			-- Project path to use. (optional).

	date: INTEGER
			-- Time stamp of file named `file_name'.

	successful: BOOLEAN
			-- Is the last compilation successful?.

	has_changed: BOOLEAN
			-- Did configuraiton change?

	has_group_changed: BOOLEAN
			-- Did configuration change (and is not group equivalent to the previous).

	date_has_changed: BOOLEAN
		do
			Result := file_modified_date (file_name) /= date
		end

	user_options: USER_OPTIONS
			-- User options, like the eifgen path.

	conf_system: CONF_SYSTEM
			-- Current parsed configuration system.

	target: CONF_TARGET
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

	settings: detachable CONF_TARGET_SETTINGS
			-- Settings that may override those specified in `target'.

	precompile: CONF_PRECOMPILE
			-- Precompile needed for building our target.

	shared_library_definition_stamp: INTEGER
			-- Time stamp of a shared library definition file (if any)

	is_void_safe: BOOLEAN
			-- Is current system void-safe, i.e. preserving types attachment status?

	inlining_threshold: INTEGER = 101
			-- The value of inlining measure that should not be reached for inlined code.

feature -- Modification

	set_settings (s: like settings)
			-- Set `settings' to `s'.
		do
			settings := s
		ensure
			settings_set: settings = s
		end

feature -- Update from retrieved object.

	update_from_retrieved_project (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		require
			other_not_void: other /= Void
		do
			-- standard_copy (other)
			date := other.date
			shared_library_definition_stamp := other.shared_library_definition_stamp
			compile_all_classes := other.compile_all_classes
			successful := True
		end

feature -- Status setting

	force_new_target
			-- Set `is_force_new_target' to True.
		do
			is_force_new_target := True
		ensure
			is_force_new_target: is_force_new_target
		end

	check_location_mappings
			-- Check location mappings
			-- and for iron missing packages, suggest installation.
		require
			valid_conf_system: conf_system /= Void
			valid_target: target /= Void
		local
			s: READABLE_STRING_32
		do
			reset_iron_packages_to_install
			if attached target as tgt then
				if attached tgt.precompile as pre then
					s := pre.location.original_path
					if attached conf_location_mapper.expected_action (s) as l_action_info then
						check attached {CONF_LOCATION_IRON_MAPPING} l_action_info.mapping end
						if
							l_action_info.is_action ("iron install") and then
							attached l_action_info.parameter ("package_name") as l_package_name
						then
							suggest_iron_package_installation (l_package_name)
						end
					end
				end

				across
					tgt.libraries as ic
				loop
					s := ic.item.location.original_path
					if attached conf_location_mapper.expected_action (s) as l_action_info then
						check attached {CONF_LOCATION_IRON_MAPPING} l_action_info.mapping end
						if
							l_action_info.is_action ("iron install") and then
							attached l_action_info.parameter ("package_name") as l_package_name
						then
							suggest_iron_package_installation (l_package_name)
						end
					end
				end
			end
		end

	check_precompile
			-- Check precompile and update `precompile', `is_precompile_invalid' and `is_precompilation_needed'.
		require
			valid_conf_system: conf_system /= Void
			valid_target: target /= Void
		local
			l_load: CONF_LOAD
			l_project_location: PROJECT_DIRECTORY
			l_epr: PROJECT_EIFFEL_FILE
			l_precompile: like precompile
		do
			l_precompile := target.precompile
				-- check if the precompile is valid
			if
				l_precompile /= Void and then
				eiffel_project.initialized and then
				not l_precompile.is_enabled (conf_state_for_precompile_checking (target))
			then
				l_precompile := Void
			end
			if l_precompile /= Void then
				precompile := l_precompile
				create l_load.make (create {CONF_COMP_FACTORY})
				l_load.retrieve_configuration (l_precompile.path)
				if l_load.is_error then
					is_precompile_invalid := True
				else
					is_precompile_invalid := l_load.last_system.library_target = Void
				end
					-- check if it needs to be (re)precompiled
				if not is_precompile_invalid then
					if l_precompile.eifgens_location /= Void then
						create l_project_location.make (l_precompile.eifgens_location.evaluated_path, l_load.last_system.library_target.name)
					else
						create l_project_location.make (l_precompile.location.evaluated_path.parent, l_load.last_system.library_target.name)
					end
					create l_epr.make (l_project_location.target_path.extended (project_file_name))
					l_epr.check_version_number (0)
					is_precompilation_needed := l_epr.has_error
				end
			else
				precompile := Void
			end
		ensure
			compilation_need_implies_ok: is_precompilation_needed implies precompile /= Void and not is_precompile_invalid
		end

	set_file_name (s: STRING_32)
			-- Assign `s' to `file_name'.
			-- if s is relative, the file_name will be absolute.
			-- Assign parent directory of file_name
		require
			s_not_void: s /= Void
		local
			p: PATH
		do
			create p.make_from_string (s)
			p := p.canonical_path
			file_name := p.name
			directory_name := p.parent.name
		end

	set_target_name (s: like target_name)
			-- Assign `s' to `target_name'.
		require
			s_ok: s /= Void and then not s.is_empty
		do
			target_name := s
		ensure
			target_name_set: target_name = s
		end

	set_conf_system (s: like conf_system)
			-- Assign `s' to `conf_system'.
		require
			s_not_void: s /= Void
		do
			conf_system := s
		ensure
			conf_system_set: conf_system = s
		end

	set_date_stamp
			-- Set `date' information to the current timestamp of the file.
		do
			date := file_modified_date (file_name)
		end

	reset_date_stamp
			-- Reset `date' information, that way a complete recompilation
			-- is done on Lace.
		do
				-- Dummy value to make sure it is different from before.
			date := date - 1
		end

	recompile
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

				-- Resetting values
			is_error := False
			create file.make_with_name (file_name)
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

	process_user_file (a_project_path: PATH; a_user_file_enabled: BOOLEAN)
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
					vd21.set_file_name (l_user_factory.last_file_name.name)
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
					-- Make it into an absolute path
				project_path := a_project_path.canonical_path
				l_target_options.set_last_location (project_path)
				l_changed := True
			elseif l_target_options.last_location /= Void then
				project_path := l_target_options.last_location
			else
				project_path := (create {PATH}.make_from_string (file_name)).parent
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

	check_shared_library_definition_stamp
			-- Check if a shared library definition file has changed and request to freeze if required.
		local
			s: PATH
		do
			s := system.dynamic_def_file
			if s = Void then
				shared_library_definition_stamp := 0
			elseif file_path_modified_date (s) /= shared_library_definition_stamp then
					-- Record new time stamp.
				shared_library_definition_stamp := file_path_modified_date (s)
					-- New definition file is taken into account only during freeze.
				system.request_freeze
			end
		end

	update_capabilities
			-- Update capabilities for all elements a target `t` depends on
			-- to the target's settings.
		do
			if
				attached target as t and then
				not system.compiler_profile.is_capability_strict
			then
					-- Update options to use target's settings.
				(create {CONF_CAPABILITY_SETTER}.make (t)).do_nothing
			end
		end

	update_capability_root
			-- Update capability settings used at every compilation.
		do
			if attached target as t then
				is_void_safe := t.options.void_safety_capability.root_index /= {CONF_TARGET_OPTION}.void_safety_index_none
			end
		end

feature {NONE} -- Implementation

	retrieve_config
			-- Parse config file.
		require
			file_name_ok: file_name /= Void and then not file_name.is_empty
		local
			l_load: CONF_LOAD
			vd00: VD00
			vd80: VD80
		do
				-- Load configuration file.
			create l_load.make (create {CONF_COMP_FACTORY})
			l_load.retrieve_configuration (file_name)
			if l_load.is_error then
				create vd00
				vd00.set_error (l_load.last_error)
				Error_handler.insert_error (vd00)
				error_handler.raise_error
			end

				-- add warnings
			if l_load.is_warning then
				across l_load.last_warnings as w loop
					create vd80
					vd80.set_warning (w.item)
					error_handler.insert_warning (vd80, target.options.is_warning_as_error)
				end
			end

			set_conf_system (l_load.last_system)
		ensure
			conf_system_set: conf_system /= Void
		rescue
			is_error := True
		end

	compute_target
			-- Compute the target to compile.
		require
			conf_system_set: conf_system /= Void
		local
			l_new_target: CONF_TARGET
		do
				-- get new target
			if target_name /= Void then
				l_new_target := conf_system.targets.item (target_name)
			elseif conf_system.targets.count = 1 then
				l_new_target := conf_system.targets.linear_representation.first
			else
				Error_handler.insert_error (create {VD69})
				Error_handler.raise_error
			end
			if l_new_target = Void then
				Error_handler.insert_error (create {VD70}.make (target_name))
				Error_handler.raise_error
			end
			target_name := l_new_target.name
			if l_new_target.is_abstract then
				Error_handler.insert_error (create {VD68}.make (target_name))
				Error_handler.raise_error
			end

				-- Resolve remote parent target (i.e from another ecf file).
				-- raise error if issue is found.
			validate_target (l_new_target)
			validate_groups (l_new_target)

				-- Update found target with `settings'.
			if attached settings as s then
				l_new_target.force (s)
			end

			project_location.set_target (target_name)

				 -- Set ISE_PRECOMP.
			eiffel_layout.set_precompile (target.setting_msil_generation)
		ensure
			target_name_set: target_name /= Void and then not target_name.is_empty
			valid_target: conf_system.targets.has (target_name)
		rescue
			is_error := True
		end

	do_recompilation
			-- Recompile config description.
		do
			retrieve_config
			compute_target
			build_universe
		ensure
			conf_system_set: conf_system /= Void
		end

	build_universe
			-- Build the universe using the AST
		require
			valid_conf_system: conf_system /= Void
			valid_target: conf_system.targets.has (target_name)
		local
			sys: SYSTEM_I
			l_new_target, l_old_target: CONF_TARGET
			vd00: VD00
			l_option_vis: CONF_RECOMPUTE_OPTIONS
			l_errors: LIST [CONF_ERROR]
			l_old_pre, l_new_pre: CONF_PRECOMPILE
			l_first: BOOLEAN
			l_root: CONF_ROOT
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
				if
					attached l_new_target.precompile as l_precompile and then
					l_precompile.is_enabled (conf_state_for_precompile_checking (l_new_target))
				then
						-- load precompile as system
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

				-- changes in application configuration are handled specially so that we don't
				-- need to rebuild if we only change an option.
				-- Note that this has only a small impact for eweasel as only eweasel test#vd10001
				-- behavior is affected if we remove this call to `set_file_date'.
			if universe.conf_system /= Void then
				universe.conf_system.set_file_date
			end

				-- if groups in application configuration have changed or if any other configuration file
				-- has changed, we are not sure to be group equivalent anymore else we can just update the options.
				-- Note that we use `l_old_target.system' and not `Universe.conf_system' because the later might be
				-- the new one already (case of a compilation that has restarted again (think about VD71 error)), and
				-- we actually perform the options recomputations against `l_old_target' so there was a mismatch.
				-- This fixes eweasel test#config038.
			has_group_changed := is_force_new_target or else universe.conf_system = Void or l_old_target = Void or else l_old_target.system.deep_date_has_changed or not conf_system.is_group_equivalent (l_old_target.system)
			if has_group_changed then
					-- check if a precompile was modified
				if l_old_target /= Void then
					l_old_pre := l_old_target.precompile
				end
				l_new_pre := l_new_target.precompile
				if l_old_pre /= Void and l_new_pre = Void then
						-- Precompile removed.
					Error_handler.insert_error (create {VD73})
					Error_handler.raise_error
				elseif not l_first and l_old_target /= Void and l_old_pre = Void and l_new_pre /= Void then
						-- Precompile added and not first compilation.
					Error_handler.insert_error (create {VD74})
					Error_handler.raise_error
				elseif l_old_pre /= Void and then l_new_pre /= Void and then not l_old_pre.is_group_equivalent (l_new_pre) then
					-- precompile changed
					Error_handler.insert_error (create {VD75})
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
				if attached l_old_target.system.all_libraries as l_all_libs then
					from
						l_all_libs.start
					until
						l_all_libs.after
					loop
						l_all_libs.item_for_iteration.system.set_file_date
						l_all_libs.forth
					end
				else
					check False end
				end
				l_new_target := l_old_target
			end

			update_settings (l_new_target)
			if l_new_target.version /= Void then
				system.set_msil_version (l_new_target.version.version)
			end

				-- Resolve parent target, and groups
			resolve_system (l_new_target.system)

			if has_group_changed then
				parse_target (l_new_target)
			end

			validate_capabilities

				-- Only set the new target when parsing is ok, otherwise we get a failure,
				-- See eweasel test#config028 and test#config029.
			universe.set_new_target (l_new_target)

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

	resolve_system (cfg: CONF_SYSTEM)
			-- Resolve entities such as parent targets, overrides, dependencies, ... for the system `cfg`.
		require
			no_error: not is_error
		local
			l_parent_checker: CONF_PARENT_TARGET_CHECKER
			l_group_checker: CONF_GROUPS_TARGET_CHECKER
		do
				-- Resolve remote parent target (i.e from another ecf file).
				-- raise warning if issue is found.
			create l_parent_checker.make_with_observer (create {CONF_COMP_FACTORY}, Current)
			l_parent_checker.report_issue_as_warning
			l_parent_checker.resolve_system (cfg)

				-- Resolve override, dependencies ...
				-- raise warning if issue is found.
			create l_group_checker.make
			l_group_checker.report_issue_as_warning
			l_group_checker.check_system (cfg)
		end

	validate_target (a_target: CONF_TARGET)
			-- Check if `a_target` has no cycle, and no conflict.
		require
			no_error: not is_error
		local
			l_checker: CONF_PARENT_TARGET_CHECKER
		do
				-- Resolve remote parent target (i.e from another ecf file).
				-- raise error if issue is found.
			create l_checker.make_with_observer (create {CONF_COMP_FACTORY}, Current)
			l_checker.check_target (a_target)
		end

	validate_groups (a_target: CONF_TARGET)
			-- Check if `a_target` has no cycle, and no conflict.
		require
			no_error: not is_error
		do
				-- Resolve remote parent target (i.e from another ecf file).
				-- raise error if issue is found.
			;(create {CONF_GROUPS_TARGET_CHECKER}.make_with_observer (Current)).check_target (a_target)
		end

	validate_capabilities
			-- Check if capability validity rules are satisfied.
		do
			if attached target as t then
				(create {CONF_CAPABILITY_CHECKER}.make (t, system.compiler_profile.is_capability_strict, Current)).do_nothing
					-- Check compiler-specific rule for precompiled libraries:
					-- Target root option should be related to precompiled option as
					-- 	• cat-call: both "none" or both not "none"
					-- 	• concurrency: equal
					-- 	• void safety: both "none" or both not "none"
				if attached t.precompile as precompiled and then attached precompiled.library_target as p then
					if
						(t.options.catcall_safety_capability.root_index = {CONF_TARGET_OPTION}.catcall_detection_index_none) /=
						(p.options.catcall_safety_capability.root_index = {CONF_TARGET_OPTION}.catcall_detection_index_none)
					then
						error_handler.insert_error (create {VD46}.make (messages.e_precompile_catcall_detection_mismatch (
							conf_interface_names.option_catcall_detection_value [t.options.catcall_safety_capability.root_index],
							conf_interface_names.option_catcall_detection_value [p.options.catcall_safety_capability.root_index],
							conf_interface_names.option_catcall_detection_value [{CONF_TARGET_OPTION}.catcall_detection_index_none])))
					end
					if t.options.concurrency_capability.root_index /= p.options.concurrency_capability.root_index then
						error_handler.insert_error (create {VD46}.make (messages.e_precompile_concurrency_mismatch (
							conf_interface_names.option_concurrency_value [t.options.concurrency_capability.root_index],
							conf_interface_names.option_concurrency_value [p.options.concurrency_capability.root_index])))
					end
					if
						(t.options.void_safety_capability.root_index = {CONF_TARGET_OPTION}.void_safety_index_none) /=
						(p.options.void_safety_capability.root_index = {CONF_TARGET_OPTION}.void_safety_index_none)
					then
						error_handler.insert_error (create {VD46}.make (messages.e_precompile_void_safety_mismatch (
							conf_interface_names.option_void_safety_value [t.options.void_safety_capability.root_index],
							conf_interface_names.option_void_safety_value [p.options.void_safety_capability.root_index],
							conf_interface_names.option_void_safety_value [{CONF_TARGET_OPTION}.void_safety_index_none])))
					end
				end
				if error_handler.has_error then
					error_handler.raise_error
				end
			end
		end

	report_error (e: CONF_ERROR)
			-- <Precursor>
		do
			if attached {CONF_ERROR_CAPABILITY} e as l_cap_error then
				if system.compiler_profile.is_capability_warning then
					error_handler.insert_warning (create {VD01}.make (l_cap_error), target.options.is_warning_as_error)
				else
					error_handler.insert_error (create {VD01}.make (l_cap_error))
				end
			else
				error_handler.insert_error (create {VD00}.make (e))
			end
		end

	report_warning (e: CONF_ERROR)
			-- <Precursor>
		do
			if attached {CONF_ERROR_CAPABILITY} e as l_cap_error then
				if system.compiler_profile.is_capability_error then
					error_handler.insert_error (create {VD01}.make (l_cap_error))
				else
					error_handler.insert_warning (create {VD01}.make (l_cap_error), target.options.is_warning_as_error)
				end
			else
				error_handler.insert_warning (create {VD00}.make (e), target.options.is_warning_as_error)
			end
		end

	parse_target (a_target: CONF_TARGET)
			-- Parse `a_target' completely (incl. all libraries)
		require
			a_target_not_void: a_target /= Void
		local
			l_factory: CONF_COMP_FACTORY
			l_parse_vis: CONF_PARSE_VISITOR
			l_state: CONF_STATE
			vd00: VD00
			vd80: VD80
			vd89: VD89
			l_errors: LIST [CONF_ERROR]
			l_cycle_checker: CONF_LIBRARY_CYCLE_CHECKER
			l_cycles: like {CONF_LIBRARY_CYCLE_CHECKER}.library_cycles
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
			else
					-- Check cycles
				create l_cycle_checker.make_with_targets (l_parse_vis.processed_targets)
				l_cycles := l_cycle_checker.library_cycles
				if not l_cycles.is_empty then
					create vd89
					vd89.set_cycles (l_cycles)
					error_handler.insert_warning (vd89, False)
				end

				if not is_force_new_target and l_parse_vis.last_warnings /= Void then
					from
						l_errors := l_parse_vis.last_warnings
						l_errors.start
					until
						l_errors.after
					loop
						create vd80
						vd80.set_warning (l_errors.item)
						error_handler.insert_warning (vd80, False)
						l_errors.forth
					end
				end
			end
			is_force_new_target := False
		ensure
			application_target_set: not is_error implies a_target.system.application_target /= Void
			all_libraries_set: not is_error implies a_target.system.all_libraries /= Void
			not_force_new_target: not is_force_new_target
		end

	update_settings (a_target: CONF_TARGET)
			-- Update settings set in `a_target'.
		require
			a_target_not_void: a_target /= Void
			system_valid: system /= Void
		local
			l_s: like {CONF_TARGET}.settings.item
			l_p: PATH
			l_b: BOOLEAN
			vd15: VD15
			vd83: VD83
			l_settings: like {CONF_TARGET}.settings
			l_factory: CONF_COMP_FACTORY
		do
			create l_factory

			l_settings := a_target.settings

			l_s := l_settings.item (s_absent_explicit_assertion)
			if attached l_s and then not l_s.is_boolean then
					-- Invalid setting value.
				create vd15
				vd15.set_option_name (s_absent_explicit_assertion)
				vd15.set_option_value (l_s)
				Error_handler.insert_error (vd15)
			else
				l_b :=
					if attached l_s then
						l_s.to_boolean
					else
						is_boolean_setting_true (s_absent_explicit_assertion, a_target.system.namespace)
					end
				if l_b = system.absent_explicit_assertion or else not workbench.has_compilation_started then
						-- Set the value of the setting for fresh compilation.
					system.set_absent_explicit_assertion (l_b)
				elseif not is_force_new_target then
						-- Value cannot be changed in a compiled system.
					Error_handler.insert_error (create {VD83}.make_error (s_absent_explicit_assertion, system.absent_explicit_assertion.out.as_lower, l_b.out.as_lower))
				end
			end

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
							Error_handler.insert_warning (vd83, a_target.options.is_warning_as_error)
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
				system.set_32bits (not {PLATFORM}.is_64_bits)
			end

			if
				workbench.has_compilation_started and then
				a_target.options.dead_code.index /= system.dead_code
			then
					-- The optimization option has changed, request finalization.
				system.set_finalize
			end
			system.set_dead_code (a_target.options.dead_code.index)

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
				system.set_external_runtime (l_s.as_string_8_conversion)
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
			if l_s /= Void and then (system.name = Void or else not system.name.same_string_general (l_s)) then
				system.set_name (l_s.as_string_8_conversion)
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
				if l_s.is_integer and then l_s.to_integer >= 0 and l_s.to_integer < inlining_threshold then
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
							Error_handler.insert_warning (vd83, a_target.options.is_warning_as_error)
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
				l_s := l_factory.new_location_from_path (l_s, a_target).evaluated_directory.name
			end
				-- value can't change from a precompile or in a compiled system
			if
				l_s /= Void and then
				not (system.metadata_cache_path /= Void and then l_s.is_case_insensitive_equal (system.metadata_cache_path)) and then
				(a_target.precompile /= Void or workbench.has_compilation_started)
			then
				if not is_force_new_target then
					create vd83.make (s_metadata_cache_path, system.metadata_cache_path, l_s)
					Error_handler.insert_warning (vd83, a_target.options.is_warning_as_error)
				end
				-- new system without precompile, set value
			elseif a_target.precompile = Void and not workbench.has_compilation_started then
				if l_s = Void then
					l_s := eiffel_layout.assemblies_path.name
				end
				system.set_metadata_cache_path (l_s)
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
							Error_handler.insert_warning (vd83, a_target.options.is_warning_as_error)
						end
					elseif l_b and then not eiffel_layout.default_il_environment.is_dotnet_installed then
						Error_handler.insert_error (create {VD86})
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
				if
					l_s /= Void and then
					not equal (system.clr_runtime_version, l_s) and then
					(a_target.precompile /= Void or workbench.has_compilation_started)
				then
						-- Due to hack to support .net version major.minor without specifing the exact version
					if
						attached system.clr_runtime_version as l_sys_clr_rt_version and then
						l_sys_clr_rt_version.starts_with (l_s)
					then
							-- This is not really a new clr runtime version value
					elseif not is_force_new_target then
						create vd83.make (s_msil_clr_version, system.clr_runtime_version, l_s)
						Error_handler.insert_warning (vd83, a_target.options.is_warning_as_error)
					end
				elseif a_target.precompile = Void and not workbench.has_compilation_started then
					set_clr_runtime_version (l_s)
				end
			end

			l_s := l_settings.item (s_msil_generation_type)
			if l_s /= Void then
				if attached msil_generation_type_value (l_s, 1, l_s.count) as v then
					system.set_msil_generation_type (v)
				else
					create vd15
					vd15.set_option_name (s_msil_generation_type)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				system.set_msil_generation_type ({STRING_32} "exe")
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

			if
				not workbench.has_compilation_started and then
				not (
					attached a_target.precompile as p and then
					p.is_enabled (universe.conf_state_from_target (a_target))
				)
			then
					-- Update concurrency setting on first compilation.
				system.set_concurrency_index (a_target.options.concurrency_capability.root_index)
					-- Update void_safety setting on first compilation.
				system.set_void_safety_index (a_target.options.void_safety_capability.root_index)
			elseif
				(not system.il_generation or else
				a_target.options.concurrency_capability.root_index = {CONF_TARGET_OPTION}.concurrency_index_scoop or else
				system.concurrency_index = {CONF_TARGET_OPTION}.concurrency_index_scoop) and then
				(attached a_target.precompile implies a_target.options.concurrency_capability.is_root_set) and then
				a_target.options.concurrency_capability.root_index /= system.concurrency_index and then
				not is_force_new_target
			then
					-- Value can't change from a precompile or in a compiled system.
					-- IL generation has no multithreaded, but is affected by SCOOP setting.
					-- If there is a precompile, an error is reported only when concurrency is set explicitly, otherwise it is taken from the precompile.
					-- If there is no precompile, an error is reported because of concurrency change (explicit or not).
					-- At this point `system.concurrency_index' should be set because the system is compiled or has a precompile.
					-- Its value is retrieved from a disk.
				create vd83.make_error (s_concurrency,
					a_target.options.concurrency_capability.value [system.concurrency_index],
					a_target.options.concurrency_capability.root)
				Error_handler.insert_error (vd83)
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

			l_s := l_settings.item (s_platform)
			if l_s /= Void then
				if get_platform (l_s) = 0 then
					create vd15
					vd15.set_option_name (s_platform)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				else
					system.set_platform (get_platform (l_s))
				end
			end

			l_s := l_settings.item (s_shared_library_definition)
			if l_s /= Void then
				l_p := l_factory.new_location_from_full_path (l_s, a_target).evaluated_path
				if system.dynamic_def_file = Void or else not system.dynamic_def_file.same_as (l_p) or else
					shared_library_definition_stamp /= file_path_modified_date (l_p)
				then
					system.set_dynamic_def_file (l_p)
						-- Record new time stamp.
					shared_library_definition_stamp := file_path_modified_date (l_p)
						-- New definition file is taken into account only during freeze.
					system.request_freeze
				end
			else
					-- Settings might have been changed and do not list DLL definition file anymore.
				system.set_dynamic_def_file (Void)
				shared_library_definition_stamp := 0
			end

			l_s := l_settings.item (s_total_order_on_reals)
			if l_s /= Void then
				if l_s.is_boolean then
					l_b := l_s.to_boolean
						-- Value cannot change from a precompile or in a compiled system
					if l_b /= system.total_order_on_reals and then (a_target.precompile /= Void or workbench.has_compilation_started) then
						if not is_force_new_target then
							create vd83.make (s_total_order_on_reals, system.total_order_on_reals.out.as_lower, l_s)
							Error_handler.insert_warning (vd83, a_target.options.is_warning_as_error)
						end
					else
						set_total_order_on_reals (l_b, a_target)
					end
				else
					create vd15
					vd15.set_option_name (s_total_order_on_reals)
					vd15.set_option_value (l_s)
					Error_handler.insert_error (vd15)
				end
			else
				if a_target.precompile = Void and then not workbench.has_compilation_started then
					set_total_order_on_reals (is_boolean_setting_true (s_total_order_on_reals, a_target.system.namespace), a_target)
				end
			end

			if
				workbench.has_compilation_started and then
				a_target.options.array_override.index /= system.array_override
			then
					-- Recheck all compiled classes using the new array override setting.
				across
					system.classes as cc
				loop
					if attached cc.item as c and then c.is_valid and then not c.is_precompiled then
						degree_3.insert_class (c)
						c.set_need_type_check (True)
					end
				end
			end
			system.set_array_override (a_target.options.array_override.index)

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

	set_total_order_on_reals (v: BOOLEAN; t: CONF_TARGET)
			-- Update system setting for total order on reals to `v` for a target `t`.
		require
			no_precompile: attached t.precompile implies system.total_order_on_reals = v
			first_compilation: workbench.has_compilation_started implies system.total_order_on_reals = v
		do
			if not v then
				error_handler.insert_warning (create {VD81}.make (t), t.options.is_warning_as_error)
			end
			system.set_total_order_on_reals (v)
		ensure
			system.total_order_on_reals = v
		end

	conf_state_for_precompile_checking (a_target: CONF_TARGET): CONF_STATE
			-- State needed during `check_precompile` to check if precompile is enabled.
			-- note: at this point, the system is not yet defined, then platform, concurrency, ... values are not relevant.
		local
			l_version: STRING_TABLE [CONF_VERSION]
		do
			create l_version.make (1)
			l_version.force (compiler_version_number, v_compiler)
			create Result.make (universe.platform, universe.build, concurrency_none, void_safety_none, False, False, a_target.variables, l_version)
		end

	retrieve_precompile (a_target: CONF_TARGET)
			-- Load the precompile as the system.
		require
			valid_conf_system: conf_system /= Void
			valid_target: a_target /= Void and then a_target.precompile /= Void
		local
			l_pre: CONF_PRECOMPILE
			l_system: CONF_SYSTEM
			l_load: CONF_LOAD
			l_file_name: like {CONF_PRECOMPILE}.path
			l_target: CONF_TARGET
			l_old_target: CONF_TARGET
			l_factory: CONF_COMP_FACTORY
			l_project_location: PROJECT_DIRECTORY
			l_system_name: READABLE_STRING_GENERAL
			vd80: VD80
		do
			create l_factory
			l_pre := a_target.precompile

				-- check if the configuration file is ok
			l_file_name := l_pre.path
			create l_load.make (l_factory)
			l_load.retrieve_configuration (l_file_name)
			if l_load.is_error then
				Error_handler.insert_error (create {VD77}.make (l_pre.location.original_path, l_load.last_error))
				Error_handler.raise_error
			end

				-- add warnings
			if l_load.is_warning then
				across l_load.last_warnings as w loop
					create vd80
					vd80.set_warning (w.item)
					error_handler.insert_warning (vd80, a_target.options.is_warning_as_error)
				end
			end

			l_system := l_load.last_system

				-- check if we have a library target
			if l_system.library_target = Void then
				Error_handler.insert_error (create {VD78})
				Error_handler.raise_error
			end

				-- retrieve precompile project (use EIFGENs location if specified, else next to the config file)
			if l_pre.eifgens_location /= Void then
				create l_project_location.make (l_pre.eifgens_location.evaluated_path, l_system.library_target.name)
			else
				create l_project_location.make (l_pre.location.evaluated_path.parent, l_system.library_target.name)
			end
			;(create {PRECOMP_R}).retrieve_precompiled (l_project_location)

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
				l_system_name := a_target.setting_executable_name
			else
				l_system_name := a_target.system.name
			end
			if l_system_name.is_valid_as_string_8 then
				system.set_name (l_system_name.to_string_8)
			else
					-- FIXME: invalid system name!
				system.set_name (l_system_name.as_string_8_conversion)
			end
		ensure
			valid_system: workbench.system /= Void
		end

	set_clr_runtime_version (a_version: detachable READABLE_STRING_GENERAL)
			-- Set clr runtime version, use default if `a_version' is Void.
		local
			l_il_env: IL_ENVIRONMENT_I
			vd15: VD15
		do
			create {IL_ENVIRONMENT} l_il_env

			if a_version = Void then
				system.set_clr_runtime_version (l_il_env.default_version)
			else
				if attached l_il_env.installed_version (a_version) as v then
					system.set_clr_runtime_version (v)
				else
					create vd15
					vd15.set_option_name ("msil_clr_version")
					vd15.set_option_value (a_version)
					Error_handler.insert_error (vd15)
					Error_handler.raise_error

					system.set_clr_runtime_version (a_version)
				end
			end

			create {IL_ENVIRONMENT} l_il_env.make (system.clr_runtime_version)
			l_il_env.register_environment_variable
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
