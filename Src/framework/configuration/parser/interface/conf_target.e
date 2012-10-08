﻿note
	description: "A configuration target."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_TARGET

inherit
	CONF_VISITABLE

	CONF_ACCESS

	CONF_CONSTANTS
		export
			{NONE} all
		end

	CONF_VALIDITY

	DEBUG_OUTPUT

	CONF_NOTABLE

create {CONF_PARSE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_system: CONF_SYSTEM)
			-- Create with `a_name'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
			a_system_not_void: a_system /= Void
		do
			name := a_name.as_lower
			create internal_libraries.make (1)
			create internal_overrides.make (0)
			create internal_clusters.make (1)
			create internal_assemblies.make (0)

			create internal_file_rule.make (0)
			internal_file_rule.compare_objects

			create internal_external_include.make (1)
			create internal_external_cflag.make (1)
			create internal_external_object.make (1)
			create internal_external_library.make (1)
			create internal_external_resource.make (1)
			create internal_external_linker_flag.make (1)
			create internal_external_make.make (1)
			create internal_pre_compile_action.make (1)
			create internal_post_compile_action.make (1)
			create internal_variables.make (1)
			create environ_variables.make (1)
			create internal_settings.make (1)
			system := a_system
			create immediate_setting_concurrency.make (setting_concurrency_name, setting_concurrency_index_none)
		ensure
			name_set: name /= Void and then name.is_equal (a_name.as_lower)
			system_set: system = a_system
		end

feature -- Access, stored in configuration file

	name: STRING
			-- Name of the target.

	description: STRING_32
			-- A description about the target.

	extends: CONF_TARGET
			-- If we extend another target, this is the other target.

	system: CONF_SYSTEM
			-- The associated system

	is_abstract: BOOLEAN
			-- Is this an abstract target? (i.e. cannot be used to compile the system).

feature -- Access, in compiled only, not stored to configuration file

	environ_variables: HASH_TABLE [STRING_32, STRING_32]
			-- Saved environment variables.

	library_root: STRING_32
			-- Root location to use for relative paths, defaults to the location of the configuration file.
		require
			location_set: system.is_location_set
		local
			l_fac: CONF_PARSE_FACTORY
			l_target: CONF_TARGET
			l_dir: CONF_DIRECTORY_LOCATION
		do
			if attached settings.item (s_library_root) as l_item then
					-- create a new target instead of using Current because we could end in an infinite recursion otherwise.
				create l_fac
				l_target := l_fac.new_target ("dummy", system)
				create l_dir.make (l_item, l_target)
				Result := l_dir.evaluated_path
			else
				Result := system.directory
			end
			if Result.item (Result.count) /= operating_environment.directory_separator then
				Result.append_character (operating_environment.directory_separator)
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access queries

	child_targets: LIST [CONF_TARGET]
			-- Targets that extend this target.
		local
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
			l_target: CONF_TARGET
		do
			create {ARRAYED_LIST [CONF_TARGET]}Result.make (5)
			from
				l_targets := system.targets
				l_targets.start
			until
				l_targets.after
			loop
				l_target := l_targets.item_for_iteration
				if l_target.extends = Current then
					Result.force (l_target)
				end
				l_targets.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	version: CONF_VERSION
			-- Version number of the target.
		do
			if internal_version /= Void then
				Result := internal_version
			elseif extends /= Void then
				Result := extends.version
			end
		end

	precompile: like internal_precompile
			-- The precompile (if any).
		do
			if internal_precompile = Void and extends /= Void then
				Result := extends.precompile
			else
				Result := internal_precompile
			end
		end

	libraries: like internal_libraries
			-- The used libraries.
		do
			if extends /= Void then
				Result := extends.libraries.twin
				Result.merge (internal_libraries)
			else
				Result := internal_libraries.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	assemblies: like internal_assemblies
			-- The assemblies.
		do
			if extends /= Void then
				Result := extends.assemblies.twin
				Result.merge (internal_assemblies)
			else
				Result := internal_assemblies.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	clusters: like internal_clusters
			-- The normal clusters.
		do
			if extends /= Void then
				Result := extends.clusters.twin
				Result.merge (internal_clusters)
			else
				Result := internal_clusters.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	overrides: like internal_overrides
			-- The override clusters.
		do
			if extends /= Void then
				Result := extends.overrides.twin
				Result.merge (internal_overrides)
			else
				Result := internal_overrides.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	groups: HASH_TABLE [CONF_GROUP, STRING]
			-- All groups of this target (union of clusters, assemblies, overrides and libraries)
		do
			create Result.make (libraries.count + assemblies.count + clusters.count + overrides.count + 1)
			Result.merge (libraries)
			Result.merge (assemblies)
			Result.merge (clusters)
			Result.merge (overrides)
			if precompile /= Void then
				Result.force (precompile, precompile.name)
			end
		ensure
			Result_not_void: Result /= Void
		end

	root: CONF_ROOT
			-- The root feature.
		do
			if internal_root /= Void then
				Result := internal_root
			elseif extends /= Void then
				Result := extends.root
			end
		end

	file_rule: like internal_file_rule
			-- Rules for files to be included or excluded.
		do
			Result := internal_file_rule.twin
			if extends /= Void then
				Result.append (extends.file_rule)
			end
		ensure
			Result_not_void: Result /= Void
		end

	options: like internal_options
			-- Options (Debuglevel, assertions, ...)
		do
			if internal_options /= Void then
				Result := internal_options.twin
			else
				create Result
			end
			if extends /= Void then
				Result.merge (extends.options)
			end
		end

	settings: like internal_settings
			-- Settings.
		do
			if extends /= Void then
				Result := extends.settings.twin
				Result.merge (internal_settings)
			else
				Result := internal_settings
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_include: like internal_external_include
			-- Global external include files.
		do
			Result := internal_external_include.twin
			if extends /= Void then
				Result.append (extends.external_include)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_cflag: like internal_external_cflag
			-- Global external C flags.
		do
			Result := internal_external_cflag.twin
			if attached extends as e then
				Result.append (e.external_cflag)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_object: like internal_external_object
			-- Global external object files.
		do
			Result := internal_external_object.twin
			if extends /= Void then
				Result.append (extends.external_object)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_library: like internal_external_library
			-- Global external library files.
		do
			Result := internal_external_library.twin
			if extends /= Void then
				Result.append (extends.external_library)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_linker_flag: like internal_external_linker_flag
			-- Global external linker flags.
		do
			Result := internal_external_linker_flag.twin
			if attached extends as e then
				Result.append (e.external_linker_flag)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_make: like internal_external_make
			-- Global external make files.
		do
			Result := internal_external_make.twin
			if extends /= Void then
				Result.append (extends.external_make)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_resource: like internal_external_resource
			-- Global external ressource files.
		do
			Result := internal_external_resource.twin
			if extends /= Void then
				Result.append (extends.external_resource)
			end
		ensure
			Result_not_void: Result /= Void
		end

	pre_compile_action: like internal_pre_compile_action
			-- Actions to be executed before compilation.
		do
			if internal_pre_compile_action /= Void then
				Result := internal_pre_compile_action.twin
			else
				create Result.make (0)
			end
			if extends /= Void then
				Result.append (extends.pre_compile_action)
			end
		ensure
			Result_not_void: Result /= Void
		end

	post_compile_action: like internal_post_compile_action
			-- Actions to be executed after compilation.
		do
			if internal_post_compile_action /= Void then
				Result := internal_post_compile_action.twin
			else
				create Result.make (0)
			end
			if extends /= Void then
				Result.append (extends.post_compile_action)
			end
		ensure
			Result_not_void: Result /= Void
		end

	variables: like internal_variables
			-- User defined variables.
		do
			if extends /= Void then
				Result := extends.variables.twin
				Result.merge (internal_variables)
			else
				Result := internal_variables
			end
		ensure
			Result_not_void: Result /= Void
		end

	mapping: like internal_mapping
			-- Special classes name mapping (eg. STRING => STRING_32)
		do
			if extends /= Void then
				Result := extends.mapping.twin
				if internal_mapping /= Void then
					Result.merge (internal_mapping)
				end
			else
				if internal_mapping /= Void then
					Result := internal_mapping
				else
					create Result.make (5)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access queries for settings

	setting_boolean (a_name: STRING): BOOLEAN
			-- Get value of boolean setting with `a_name'.
		require
			a_name_valid: valid_setting (a_name)
		local
			l_settings: like settings
		do
			l_settings := settings
			l_settings.search (a_name)
			if l_settings.found then
				check l_settings.found_item.is_boolean end
				if not a_name.is_equal (s_array_optimization) then
					Result := l_settings.found_item.to_boolean
				end
			else
				Result := true_boolean_settings.has (a_name)
			end
		end

	setting_address_expression: BOOLEAN
			-- Value of the address_expression setting.
		do
			Result := setting_boolean (s_address_expression)
		end

	setting_array_optimization: BOOLEAN
			-- Value of the array_optimization setting.
		do
			Result := setting_boolean (s_array_optimization)
		end

	setting_check_for_void_target: BOOLEAN
			-- Value for the `check_for_void_target' setting.
		do
			Result := setting_boolean (s_check_for_void_target)
		end

	setting_check_for_catcall_at_runtime: BOOLEAN
			-- Value for the `check_for_catcall_at_runtime' setting.
		do
			Result := setting_boolean (s_check_for_catcall_at_runtime)
		end

	setting_check_generic_creation_constraint: BOOLEAN
			-- Value of the check_generic_creation_constraint setting.
		do
			Result := setting_boolean (s_check_generic_creation_constraint)
		end

	setting_check_vape: BOOLEAN
			-- Value for the check_vape setting.
		do
			Result := setting_boolean (s_check_vape)
		end

	setting_console_application: BOOLEAN
			-- Value for the console_application setting.
		do
			Result := setting_boolean (s_console_application)
		end

	setting_cls_compliant: BOOLEAN
			-- Value for the cls_compliant setting.
		do
			Result := setting_boolean (s_cls_compliant)
		end

	setting_dead_code_removal: BOOLEAN
			-- Value for the dead_code_removal setting.
		do
			Result := setting_boolean (s_dead_code_removal)
		end

	setting_dotnet_naming_convention: BOOLEAN
			-- Value for the dotnet_naming_convention setting.
		do
			Result := setting_boolean (s_dotnet_naming_convention)
		end

	setting_dynamic_runtime: BOOLEAN
			-- Value for the dynamic_runtime setting.
		do
			Result := setting_boolean (s_dynamic_runtime)
		end

	setting_executable_name: STRING_32
			-- Value for the executable_name setting.
		do
			if attached settings.item (s_executable_name) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_enforce_unique_class_names: BOOLEAN
			-- Valeu for the enforce_unique_class_names setting.
		do
			Result := setting_boolean (s_enforce_unique_class_names)
		end

	setting_exception_trace: BOOLEAN
			-- Value for the exception_trace setting.
		do
			Result := setting_boolean (s_exception_trace)
		end

	setting_force_32bits: BOOLEAN
			-- Value for the force_32bits setting.
		do
			Result := setting_boolean (s_force_32bits)
		end

	setting_il_verifiable: BOOLEAN
			-- Value for the console_application setting.
		do
			Result := setting_boolean (s_il_verifiable)
		end

	setting_inlining: BOOLEAN
			-- Value for the inlining setting.
		do
			Result := setting_boolean (s_inlining)
		end

	setting_inlining_size: NATURAL_8
			-- Value for the inlining_size setting.
		local
			l_settings: like settings
		do
			l_settings := settings
			l_settings.search (s_inlining_size)
			if l_settings.found then
				check l_settings.found_item.is_natural_8 and then l_settings.found_item.to_natural_8 <= 100 end
				Result := l_settings.found_item.to_natural_8
			else
				Result := 4
			end
		end

	setting_java_generation: BOOLEAN
			-- Value for the java_generation setting.
		do
			Result := setting_boolean (s_java_generation)
		end

	setting_line_generation: BOOLEAN
			-- Value for the line_generation setting.
		do
			Result := setting_boolean (s_line_generation)
		end

	setting_metadata_cache_path: STRING_32
			-- Value for the metadata_cache_path setting.
		do
			if attached settings.item (s_metadata_cache_path) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_assembly_compatibility: STRING_32
			-- Value for the msil_assembly_compatibility setting.
		do
			if attached settings.item (s_msil_assembly_compatibility) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_classes_per_module: NATURAL_16
			-- Value for the msil_classes_per_module setting.
		local
			l_settings: like settings
		do
			l_settings := settings
			l_settings.search (s_msil_classes_per_module)
			if l_settings.found then
				check l_settings.found_item.is_natural_16 and then l_settings.found_item.to_natural_16 > 0 end
				Result := l_settings.found_item.to_natural_16
			else
				Result := 0
			end
		end

	setting_msil_clr_version: STRING_32
			-- Value for the msil_clr_version setting.
		do
			if attached settings.item (s_msil_clr_version) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_culture: STRING_32
			-- Value for the msil_culture setting.
		do
			if attached settings.item (s_msil_culture) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_generation: BOOLEAN
			-- Value for the msil_generation setting.
		do
			Result := setting_boolean (s_msil_generation)
		end

	setting_msil_generation_type: STRING_32
			-- Value for the msil_generation_type setting.
		local
			l_settings: like settings
		do
			l_settings := settings
			l_settings.search (s_msil_generation_type)
			if l_settings.found then
				check l_settings.found_item.is_case_insensitive_equal ("exe") or l_settings.found_item.is_case_insensitive_equal ("dll") end
				Result := l_settings.found_item
			else
				Result := "exe"
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_key_file_name: STRING_32
			-- Value for the msil_key_file_name setting.
		do
			if attached settings.item (s_msil_key_file_name) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_use_optimized_precompile: BOOLEAN
			-- Value for the msil_use_optimized_precompile setting.
		do
			Result := setting_boolean (s_msil_use_optimized_precompile)
		end

	setting_platform: STRING_32
			-- Value for the platform setting.
		local
			l_settings: like settings
		do
			l_settings := settings
			l_settings.search (s_platform)
			if l_settings.found then
				check get_platform (l_settings.found_item) /= 0 end
				Result := l_settings.found_item.as_lower
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_external_runtime: STRING_32
			-- Value for the external_runtime setting.
		do
			if attached settings.item (s_external_runtime) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_shared_library_definition: STRING_32
			-- Value for the shared_library_definition setting.
		do
			if attached settings.item (s_shared_library_definition) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_total_order_on_reals: BOOLEAN
			-- Value for the total_order_on_reals setting.
		do
			Result := setting_boolean (s_total_order_on_reals)
		end

	setting_use_cluster_name_as_namespace: BOOLEAN
			-- Value for the use_cluster_name_as_namespace setting.
		do
			Result := setting_boolean (s_use_cluster_name_as_namespace)
		end

	setting_use_all_cluster_name_as_namespace: BOOLEAN
			-- Value for the use_all_cluster_name_as_namespace setting.
		do
			Result := setting_boolean (s_use_all_cluster_name_as_namespace)
		end

	setting_automatic_backup: BOOLEAN
			-- Value for the automatic_backup setting.
		do
			Result := setting_boolean (s_automatic_backup)
		end

feature -- Access: concurrency setting

	setting_concurrency: CONF_VALUE_CHOICE
			-- Value of the "concurrency" setting
			-- calculated using both immediate and inherited data.
		do
			if attached extends as e then
				Result := immediate_setting_concurrency.twin
				Result.set_safely (e.setting_concurrency)
			else
				Result := immediate_setting_concurrency
			end
		ensure
			result_attached: attached Result
		end

	concurrency_mode: like {CONF_STATE}.concurrency
			-- Concurrency mode corresponding to `setting_concurrency'.
		do
			inspect setting_concurrency.index
			when setting_concurrency_index_none   then Result := concurrency_none
			when setting_concurrency_index_thread then Result := concurrency_multithreaded
			when setting_concurrency_index_scoop  then Result := concurrency_scoop
			end
		ensure
			definition:
				setting_concurrency.index = setting_concurrency_index_none   and then Result = concurrency_none or else
				setting_concurrency.index = setting_concurrency_index_thread and then Result = concurrency_multithreaded or else
				setting_concurrency.index = setting_concurrency_index_scoop  and then Result = concurrency_scoop
		end

	setting_concurrency_index_none: NATURAL_8 = 1
			-- Option index for no concurrency

	setting_concurrency_index_thread: NATURAL_8 = 2
			-- Option index for thread-based concurrency

	setting_concurrency_index_scoop: NATURAL_8 = 3
			-- Option index for SCOOP concurrency

	immediate_setting_concurrency: like setting_concurrency
			-- Value of the "concurrency" setting specified for this target.

	set_immediate_setting_concurrency (v: like setting_concurrency)
			-- Set value of the "concurrency" setting specified for this target.
			-- Inherited setting (if any) overrides this one.
		require
			v_attached: attached v
		do
			immediate_setting_concurrency := v
		ensure
			immediate_setting_concurrency_set: immediate_setting_concurrency = v
		end

feature {NONE} -- Access: concurrency setting

	setting_concurrency_name: ARRAY [READABLE_STRING_32]
			-- Available values for `setting_concurrency'.
		once
			Result := <<concurrency_none_name, concurrency_multithreaded_name, concurrency_scoop_name>>
		ensure
			result_attached: Result /= Void
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if system /= Void then
				system.targets.replace_key (a_name.as_lower, name)
			end
			name := a_name.as_lower
		ensure
			name_set: name.is_case_insensitive_equal (a_name) and name.is_equal (name.as_lower)
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_parent (a_target: like extends)
			-- Set `extends' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			extends := a_target
		ensure
			parent_set: extends = a_target
		end

	set_parent_by_name (a_target: STRING)
			-- Set `parent' to `a_target'.
		require
			system: system /= Void
			a_target_ok: a_target /= Void and then not a_target.is_empty implies system.targets.has (a_target)
		do
			if a_target /= Void and then not a_target.is_empty then
				set_parent (system.targets.item (a_target))
			else
				extends := Void
			end
		end

	remove_parent
			-- Remove the parent target.
		do
			extends := Void
		end

	set_version (a_version: like internal_version)
			-- Set `version' to `a_version'.
		do
			internal_version := a_version
		ensure
			version_set: internal_version = a_version
		end

	set_precompile (a_precompile: CONF_PRECOMPILE)
			-- Set `a_precompile'.
		do
			internal_precompile := a_precompile
		ensure
			precompile_set: internal_precompile = a_precompile
		end

	add_library (a_library: CONF_LIBRARY)
			-- Add `a_library'.
		require
			a_library_not_void: a_library /= Void
			not_precompile: not a_library.is_precompile
		do
			internal_libraries.force (a_library, a_library.name)
		ensure
			library_added: internal_libraries.has (a_library.name)
		end

	add_assembly (an_assembly: CONF_ASSEMBLY)
			-- Add `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			internal_assemblies.force (an_assembly, an_assembly.name)
		ensure
			assembly_added: internal_assemblies.has (an_assembly.name)
		end

	add_cluster (a_cluster: CONF_CLUSTER)
			-- Add `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
			not_override: not a_cluster.is_override
		do
			internal_clusters.force (a_cluster, a_cluster.name)
		ensure
			cluster_added: internal_clusters.has (a_cluster.name)
		end

	add_override (an_override: CONF_OVERRIDE)
			-- Add `an_override'.
		require
			an_override_not_void: an_override /= Void
		do
			internal_overrides.force (an_override, an_override.name)
		ensure
			override_added: internal_overrides.has (an_override.name)
		end

	remove_library (a_name: STRING)
			-- Remove a library with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_libraries.remove (a_name)
		end

	remove_assembly (a_name: STRING)
			-- Remove an assembly with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_assemblies.remove (a_name)
		end

	remove_cluster (a_name: STRING)
			-- Remove a cluster with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_clusters.remove (a_name)
		end

	remove_override (a_name: STRING)
			-- Remove an override with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_overrides.remove (a_name)
		end

	set_root (a_root: like root)
			-- Set `a_root'.
		do
			internal_root := a_root
		ensure
			root_set: internal_root = a_root
		end

	remove_root
			-- Remove root.
		do
			internal_root := Void
		ensure
			root_removed: internal_root = Void
		end

	set_file_rules (a_file_rules: like internal_file_rule)
			-- Set `internal_file_rule' to `a_file_rules'.
		do
			if a_file_rules /= Void then
				internal_file_rule := a_file_rules
			else
				create internal_file_rule.make (0)
			end
		ensure
			file_rules_set: a_file_rules /= Void implies internal_file_rule = a_file_rules
			file_rules_set: a_file_rules = Void implies internal_file_rule.is_empty
		end

	add_file_rule (a_file_rule: CONF_FILE_RULE)
			-- Add `a_file_rule'.
		require
			a_file_rule_not_void: a_file_rule /= Void
		do
			internal_file_rule.force (a_file_rule)
		ensure
			file_rule_added: internal_file_rule.has (a_file_rule)
		end

	set_options (an_option: like internal_options)
			-- Set `an_option'.
		require
			an_option_not_void: an_option /= Void
		do
			internal_options := an_option
		ensure
			option_set: internal_options = an_option
		end

	set_settings (a_settings: like internal_settings)
			-- Set `a_settings'.
		require
			a_settings_not_void: a_settings /= Void
		do
			internal_settings := a_settings
		ensure
			settings_set: internal_settings = a_settings
		end

	add_setting (a_name, a_value: STRING_32)
			-- Add a new setting.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		do
			internal_settings.force (a_value, a_name)
		ensure
			added: internal_settings.item (a_name) = a_value
		end

	update_setting (a_name, a_value: STRING_32)
			-- Update/add/remove a setting.
		require
			a_name_valid: a_name /= Void and then valid_setting (a_name)
		do
			if a_value = Void or else a_value.is_empty then
				internal_settings.remove (a_name)
			else
				add_setting (a_name, a_value)
			end
		ensure
			updated_removed: a_value = Void or else a_value.is_empty implies not internal_settings.has (a_name)
			updated_added_set: a_value /= Void and then not a_value.is_empty implies internal_settings.item (a_name) = a_value
		end

	set_external_includes (an_includes: like internal_external_include)
			-- Set `an_includes'.
		require
			an_includes_not_void: an_includes /= Void
		do
			internal_external_include := an_includes
		ensure
			includes_set: internal_external_include =an_includes
		end

	set_external_cflag (v: like internal_external_cflag)
			-- Set `internal_external_cflag' to `v'.
		require
			v_attached: attached v
		do
			internal_external_cflag := v
		ensure
			internal_external_cflag_set: internal_external_cflag = v
		end

	set_external_objects (an_objects: like internal_external_object)
			-- Set `an_objects'.
		require
			an_objects_not_void: an_objects /= Void
		do
			internal_external_object := an_objects
		ensure
			objects_set: internal_external_object = an_objects
		end

	set_external_libraries (a_libraries: like internal_external_library)
			-- Set `a_libraries'.
		require
			a_libraries_not_void: a_libraries /= Void
		do
			internal_external_library := a_libraries
		ensure
			libraries_set: internal_external_library = a_libraries
		end

	set_external_resources (a_ressources: like internal_external_resource)
			-- Set `a_ressources'.
		require
			a_ressources_not_void: a_ressources /= Void
		do
			internal_external_resource := a_ressources
		ensure
			ressources_set: internal_external_resource = a_ressources
		end

	set_external_linker_flag (v: like internal_external_linker_flag)
			-- Set `internal_external_linker_flag' to `v'.
		require
			v_attached: attached v
		do
			internal_external_linker_flag := v
		ensure
			internal_external_linker_flag_set: internal_external_linker_flag = v
		end

	set_external_make (a_makes: like internal_external_make)
			-- Set `a_makes'.
		require
			a_makes_not_void: a_makes /= Void
		do
			internal_external_make := a_makes
		ensure
			makes_set: internal_external_make = a_makes
		end

	add_external_include (an_include: CONF_EXTERNAL_INCLUDE)
			-- Add `an_include'.
		require
			an_include_not_void: an_include /= Void
		do
			internal_external_include.extend (an_include)
		ensure
			added: internal_external_include.has (an_include)
		end

	add_external_cflag (a_cflag: CONF_EXTERNAL_CFLAG)
			-- Add `a_cflag'.
		require
			a_cflag_not_void: a_cflag /= Void
		do
			internal_external_cflag.extend (a_cflag)
		ensure
			added: internal_external_cflag.has (a_cflag)
		end

	add_external_object (an_object: CONF_EXTERNAL_OBJECT)
			-- Add `an_object'.
		require
			an_object_not_void: an_object /= Void
		do
			internal_external_object.extend (an_object)
		ensure
			added: internal_external_object.has (an_object)
		end

	add_external_library (a_library: CONF_EXTERNAL_LIBRARY)
			-- Add `a_library'.
		require
			a_library_not_void: a_library /= Void
		do
			internal_external_library.extend (a_library)
		ensure
			added: internal_external_library.has (a_library)
		end

	add_external_resource (a_resource: CONF_EXTERNAL_RESOURCE)
			-- Add `a_resource'.
		require
			a_resource_not_void: a_resource /= Void
		do
			if internal_external_resource = Void then
				create internal_external_resource.make (1)
			end
			internal_external_resource.extend (a_resource)
		ensure
			added: internal_external_resource.has (a_resource)
		end

	add_external_linker_flag (a_linker_flag: CONF_EXTERNAL_LINKER_FLAG)
			-- Add `a_linker_flag'.
		require
			a_linker_flag_not_void: a_linker_flag /= Void
		do
			internal_external_linker_flag.extend (a_linker_flag)
		ensure
			added: internal_external_linker_flag.has (a_linker_flag)
		end

	add_external_make (a_make: CONF_EXTERNAL_MAKE)
			-- Add `a_make'.
		require
			a_make_not_void: a_make /= Void
		do
			internal_external_make.extend (a_make)
		ensure
			added: internal_external_make.has (a_make)
		end

	remove_external_include (an_include: CONF_EXTERNAL_INCLUDE)
			-- Remove `an_include'.
		require
			an_include_not_void: an_include /= Void
			has_an_include: internal_external_include.has (an_include)
		do
			internal_external_include.start
			internal_external_include.search (an_include)
			internal_external_include.remove
		ensure
			removed: not internal_external_include.has (an_include)
		end

	remove_external_cflag (v: CONF_EXTERNAL_CFLAG)
			-- Remove `v' from `internal_external_cflag'.
		require
			v_attached: attached v
			has_v: internal_external_cflag.has (v)
		do
			internal_external_cflag.start
			internal_external_cflag.search (v)
			internal_external_cflag.remove
		ensure
			removed: internal_external_cflag.occurrences (v) = old internal_external_cflag.occurrences (v) - 1
		end

	remove_external_object (an_object: CONF_EXTERNAL_OBJECT)
			-- Remove `an_object'.
		require
			an_object_not_void: an_object /= Void
			has_an_object: internal_external_object.has (an_object)
		do
			internal_external_object.start
			internal_external_object.search (an_object)
			internal_external_object.remove
		ensure
			removed: not internal_external_object.has (an_object)
		end

	remove_external_library (a_library: CONF_EXTERNAL_LIBRARY)
			-- Remove `a_library'.
		require
			a_library_not_void: a_library /= Void
			has_a_library: internal_external_library.has (a_library)
		do
			internal_external_library.start
			internal_external_library.search (a_library)
			internal_external_library.remove
		ensure
			removed: not internal_external_library.has (a_library)
		end

	remove_external_resource (a_resource: CONF_EXTERNAL_RESOURCE)
			-- Remove `a_ressource'.
		require
			a_ressource_not_void: a_resource /= Void
			has_a_resource: internal_external_resource.has (a_resource)
		do
			internal_external_resource.start
			internal_external_resource.search (a_resource)
			internal_external_resource.remove
		ensure
			removed: not internal_external_resource.has (a_resource)
		end

	remove_external_linker_flag (v: CONF_EXTERNAL_LINKER_FLAG)
			-- Remove `v' from `internal_external_linker_flag'.
		require
			v_attached: attached v
			has_v: internal_external_linker_flag.has (v)
		do
			internal_external_linker_flag.start
			internal_external_linker_flag.search (v)
			internal_external_linker_flag.remove
		ensure
			removed: internal_external_linker_flag.occurrences (v) = old internal_external_linker_flag.occurrences (v) - 1
		end

	remove_external_make (a_make: CONF_EXTERNAL_MAKE)
			-- Remove `a_make'.
		require
			a_make_not_void: a_make /= Void
			has_a_make: internal_external_make.has (a_make)
		do
			internal_external_make.start
			internal_external_make.search (a_make)
			internal_external_make.remove
		ensure
			removed: not internal_external_make.has (a_make)
		end

	set_pre_compile (a_pre_compile: like internal_pre_compile_action)
			-- Set `a_pre_compile'.
		do
			internal_pre_compile_action := a_pre_compile
		ensure
			pre_compile_set: internal_pre_compile_action = a_pre_compile
		end

	set_post_compile (a_post_compile: like internal_post_compile_action)
			-- Set `a_post_compile'.
		do
			internal_post_compile_action := a_post_compile
		ensure
			post_compile_set: internal_post_compile_action = a_post_compile
		end

	add_pre_compile (an_action: CONF_ACTION)
			-- Add `an_action'.
		require
			an_action_not_void: an_action /= Void
		do
			if internal_pre_compile_action = Void then
				create internal_pre_compile_action.make (1)
			end
			internal_pre_compile_action.extend (an_action)
		end

	add_post_compile (an_action: CONF_ACTION)
			-- Add `an_action'.
		require
			an_action_not_void: an_action /= Void
		do
			if internal_post_compile_action = Void then
				create internal_post_compile_action.make (1)
			end
			internal_post_compile_action.extend (an_action)
		end

	remove_action (an_action: CONF_ACTION)
			-- Remove `an_action'.
		require
			an_action_not_void: an_action /= Void
		do
			internal_pre_compile_action.start
			internal_pre_compile_action.prune (an_action)
			internal_post_compile_action.start
			internal_post_compile_action.prune (an_action)
		ensure
			removed: not internal_pre_compile_action.has (an_action) and
					not internal_post_compile_action.has (an_action)
		end

	add_variable (a_name, a_value: STRING_32)
			-- Add a variable with `a_name' and `a_value'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		do
			internal_variables.force (a_value, a_name.as_lower)
		ensure
			variable_added: internal_variables.has (a_name.as_lower) and then internal_variables.item (a_name.as_lower) = a_value
		end

	remove_variable (a_name: STRING_32)
			-- Remove a variable with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			internal_variables.remove (a_name.as_lower)
		ensure
			variable_removed: not internal_variables.has (a_name.as_lower)
		end

	add_mapping (a_old_name, a_new_name: STRING)
			-- Add/replace  mapping from `a_old_name' to `a_new_name'.
		require
			a_old_name_ok: a_old_name /= Void and then not a_old_name.is_empty
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
		do
			if internal_mapping = Void then
				create internal_mapping.make (15)
			end
			internal_mapping.force (a_new_name.as_upper, a_old_name.as_upper)
		end

	remove_mapping (a_name: STRING)
			-- Remove a mapping with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if internal_mapping /= Void then
				internal_mapping.remove (a_name.as_upper)
			end
		ensure
			mapping_removed: not internal_mapping.has (a_name.as_upper)
		end

	set_abstract (an_enabled: like is_abstract)
			-- Set `is_abstract' to `an_enabled'.
		do
			is_abstract := an_enabled
		ensure
			is_abstract_set: is_abstract = an_enabled
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_environ_variables (a_vars: like environ_variables)
			-- Set `environ_variables' to `a_vars'.
		require
			a_vars_not_void: a_vars /= Void
		do
			environ_variables := a_vars
		ensure
			environ_variables_set: environ_variables = a_vars
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
				-- If there is a change in the target hierarchy, we cannot cope with it
				-- properly, see eweasel test#incr379
			if extends = Void then
				Result := other.extends = Void
			elseif other.extends /= Void then
				Result := extends.name.same_string (other.extends.name)
			end
			if Result then
				Result := is_abstract = other.is_abstract and then is_group_equal_check (libraries, other.libraries) and then
						is_group_equal_check (assemblies, other.assemblies) and then
						is_group_equal_check (clusters, other.clusters) and then
						is_group_equal_check (overrides, other.overrides) and then
						equal (variables, other.variables) and then
						equal (root, other.root) and then
						equal (file_rule, other.file_rule) and then
						equal (mapping, other.mapping) and then
						other.setting_enforce_unique_class_names = setting_enforce_unique_class_names
			end
			if Result then
				if precompile = Void then
					Result := other.precompile = Void
				else
					Result := other.precompile /= Void and then precompile.is_group_equivalent (other.precompile)
				end
			end
		end

	is_deep_group_equivalent (other: like Current; a_processed_libraries: SEARCH_TABLE [UUID]): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout, even down into used libraries?
			-- do not process already processed libraries and add newly processed libraries to `a_processed_libraries'.
		require
			a_processed_libraries: a_processed_libraries /= Void
		local
			l_libs, l_other_libs: HASH_TABLE [CONF_LIBRARY, STRING]
			l_lib, l_other_lib: CONF_LIBRARY
		do
			Result := is_group_equivalent (other)
				-- check if all the used library are deep group equivalent
			if Result then
				from
					l_other_libs := other.libraries
					l_libs := libraries
						-- if we have a precompile, add this to the list of libraries
					if precompile /= Void then
						l_libs := l_libs.twin
						l_libs.force (precompile, precompile.name)
						l_other_libs := l_other_libs.twin
						l_other_libs.force (other.precompile, other.precompile.name)
					end
					l_libs.start
				until
					not Result or else l_libs.after
				loop
					l_lib := l_libs.item_for_iteration
					l_other_lib := l_other_libs.item (l_lib.name)
					check
						other_library_found: l_other_lib /= Void
					end
					if l_lib.library_target = Void then
						Result := l_other_lib.library_target = Void
					elseif not a_processed_libraries.has (l_lib.library_target.system.uuid) then
						a_processed_libraries.force (l_lib.library_target.system.uuid)
						Result := l_other_lib.library_target /= Void and then l_lib.library_target.is_deep_group_equivalent (l_other_lib.library_target, a_processed_libraries)
					end
					l_libs.forth
				end
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_target (Current)
		end

feature -- Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := system.name + "/" + name
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, attributes that are stored to the configuration file

	internal_root: CONF_ROOT
			-- The root feature of this target itself.

	internal_version: CONF_VERSION
			-- The version of this target itself.

	internal_precompile: CONF_PRECOMPILE
			-- Precompile of this target itself.

	internal_libraries: HASH_TABLE [CONF_LIBRARY, STRING]
			-- The used libraries of this target itself.

	internal_overrides: HASH_TABLE [CONF_OVERRIDE, STRING]
			-- The override clusters of this target itself.

	internal_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			-- The normal clusters of this target itself.

	internal_assemblies: HASH_TABLE [CONF_ASSEMBLY, STRING]
			-- The assemblies of this target itself.

	internal_file_rule: ARRAYED_LIST [CONF_FILE_RULE]
			-- Rules for files to be included or excluded of this target itself.

	internal_options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...) of this target itself.

	internal_mapping: EQUALITY_HASH_TABLE [STRING, STRING]
			-- Special classes name mapping (eg. STRING => STRING_32) of this target itself.

	changeable_internal_options: like internal_options
			-- A possibility to change settings without knowing if we have some options already set.
		do
			if internal_options = Void then
				create internal_options
			end
			Result := internal_options
		ensure
			Result_not_void: Result /= Void
		end

	internal_settings: HASH_TABLE [STRING_32, STRING_32]
			-- Settings of this target itself.

	internal_external_include: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE]
			-- Global external include files of this target itself.

	internal_external_cflag: ARRAYED_LIST [CONF_EXTERNAL_CFLAG]
			-- Global external C flags of this target itself.

	internal_external_object: ARRAYED_LIST [CONF_EXTERNAL_OBJECT]
			-- Global external object files of this target itself.

	internal_external_library: ARRAYED_LIST [CONF_EXTERNAL_LIBRARY]
			-- Global external library files of this target itself.

	internal_external_resource: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE]
			-- Global external ressource files of this target itself.

	internal_external_linker_flag: ARRAYED_LIST [CONF_EXTERNAL_LINKER_FLAG]
			-- Global external linker flags of this target itself.

	internal_external_make: ARRAYED_LIST [CONF_EXTERNAL_MAKE]
			-- Global external make files of this target itself.

	internal_pre_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- Actions to be executed before compilation of this target itself.

	internal_post_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- Actions to be executed after compilation of this target itself.

	internal_variables: EQUALITY_HASH_TABLE [STRING_32, STRING_32]
			-- User defined variables of this target itself.

feature {NONE} -- Implementation

	is_group_equal_check (a, b: HASH_TABLE [CONF_GROUP, STRING]): BOOLEAN
			-- Check if `a' and `b' are group equivalent.
		do
			if a.count = b.count then
				Result := True
				from
					a.start
					b.start
				until
					not Result or a.after or b.after
				loop
					Result := a.item_for_iteration.is_group_equivalent (b.item_for_iteration)
					a.forth
					b.forth
				end
			end
		end

invariant
	name_ok: name /= Void and not name.is_empty
	name_lower: name.is_equal (name.as_lower)
	system_not_void: system /= Void
	internal_libraries_not_void: internal_libraries /= Void
	internal_overrides_not_void: internal_overrides /= Void
	internal_clusters_not_void: internal_clusters /= Void
	internal_assemblies_not_void: internal_assemblies /= Void
	internal_file_rule_not_void: internal_file_rule /= Void
	internal_external_include_not_void: internal_external_include /= Void
	internal_external_cflag_not_void: internal_external_cflag /= Void
	internal_external_object_not_void: internal_external_object /= Void
	internal_external_ressource_not_void: internal_external_resource /= Void
	internal_external_linker_flag_not_void: internal_external_linker_flag /= Void
	internal_external_make_not_void: internal_external_make /= Void
	internal_pre_compile_not_void: internal_pre_compile_action /= Void
	internal_post_compile_not_void: internal_post_compile_action /= Void
	internal_variables_not_void: internal_variables /= Void
	internal_settings_not_void: internal_settings /= Void
	environ_variables_not_void: environ_variables /= Void
	internal_setting_concurrency_attached: attached immediate_setting_concurrency

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
