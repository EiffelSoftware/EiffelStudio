note
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

	DEBUG_OUTPUT

	CONF_NOTABLE

	CONF_TARGET_SETTINGS
		rename
			make as make_settings
		redefine
			options,
			setting_concurrency,
			settings
		end

	HASHABLE

create {CONF_PARSE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_system: CONF_SYSTEM)
			-- Create with `a_name'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
			a_system_not_void: a_system /= Void
		do
			make_settings
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
			create internal_variables.make_equal_caseless (1)
			create environ_variables.make (1)
			system := a_system
		ensure
			name_set: name /= Void and then name.is_equal (a_name.as_lower)
			system_set: system = a_system
		end

feature -- Access, stored in configuration file

	name: STRING_32
			-- Name of the target.

	description: detachable STRING_32
			-- A description about the target.

	extends: detachable CONF_TARGET
			-- If we extend another target, this is the other target.

	system: CONF_SYSTEM
			-- The associated system

	is_abstract: BOOLEAN
			-- Is this an abstract target? (i.e. cannot be used to compile the system).

feature -- Access, in compiled only, not stored to configuration file

	environ_variables: STRING_TABLE [READABLE_STRING_32]
			-- Saved environment variables.

	library_root: detachable PATH
			-- Root location to use for relative paths, defaults to the location of the configuration file.
			--| note: it is also use to replace $ECF_CONFIG_PATH value.
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
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access queries

	child_targets: LIST [CONF_TARGET]
			-- Targets that extend this target.
		local
			l_targets: STRING_TABLE [CONF_TARGET]
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

	version: detachable CONF_VERSION
			-- Version number of the target.
		do
			if attached internal_version as l_internal_version then
				Result := l_internal_version
			elseif attached extends as l_extends then
				Result := l_extends.version
			end
		end

	precompile: detachable CONF_PRECOMPILE
			-- The precompile (if any).
		local
			l_internal_precompile: like internal_precompile
		do
			l_internal_precompile := internal_precompile
			if
				l_internal_precompile = Void and
				attached extends as l_extends
			then
				Result := l_extends.precompile
			else
				Result := l_internal_precompile
			end
		end

	libraries: STRING_TABLE [CONF_LIBRARY]
			-- The used libraries.
		do
			if attached extends as l_extends then
				Result := l_extends.libraries.twin
				Result.merge (internal_libraries)
			else
				Result := internal_libraries.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	assemblies: STRING_TABLE [CONF_ASSEMBLY]
			-- The assemblies.
		do
			if attached extends as l_extends then
				Result := l_extends.assemblies.twin
				Result.merge (internal_assemblies)
			else
				Result := internal_assemblies.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	clusters: STRING_TABLE [CONF_CLUSTER]
			-- The normal clusters.
		do
			if attached extends as l_extends then
				Result := l_extends.clusters.twin
				Result.merge (internal_clusters)
			else
				Result := internal_clusters.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	overrides: STRING_TABLE [CONF_OVERRIDE]
			-- The override clusters.
		do
			if attached extends as l_extends then
				Result := l_extends.overrides.twin
				Result.merge (internal_overrides)
			else
				Result := internal_overrides.twin
			end
		ensure
			Result_not_void: Result /= Void
		end

	groups: STRING_TABLE [CONF_GROUP]
			-- All groups of this target (union of clusters, assemblies, overrides and libraries)
		do
			create Result.make (libraries.count + assemblies.count + clusters.count + overrides.count + 1)
			Result.merge (libraries)
			Result.merge (assemblies)
			Result.merge (clusters)
			Result.merge (overrides)
			if attached precompile as l_precompile then
				Result.force (l_precompile, l_precompile.name)
			end
		ensure
			Result_not_void: Result /= Void
		end

	root: detachable CONF_ROOT
			-- The root feature.
		do
			if internal_root /= Void then
				Result := internal_root
			elseif attached extends as l_extends then
				Result := l_extends.root
			end
		end

	file_rule: ARRAYED_LIST [CONF_FILE_RULE]
			-- Rules for files to be included or excluded.
		do
			Result := internal_file_rule.twin
			if attached extends as l_extends then
				Result.append (l_extends.file_rule)
			end
		ensure
			Result_not_void: Result /= Void
		end

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		do
			Result := Precursor.twin
			if attached extends as l_extends then
				Result.merge (l_extends.options)
			end
		end

	settings: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			-- Settings.
		do
			if attached extends as l_extends then
				Result := l_extends.settings.twin
				Result.merge (Precursor)
			else
				Result := Precursor
			end
		end

	external_include: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE]
			-- Global external include files.
		do
			Result := internal_external_include.twin
			if attached extends as l_extends then
				Result.append (l_extends.external_include)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_cflag: ARRAYED_LIST [CONF_EXTERNAL_CFLAG]
			-- Global external C flags.
		do
			Result := internal_external_cflag.twin
			if attached extends as e then
				Result.append (e.external_cflag)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_object: ARRAYED_LIST [CONF_EXTERNAL_OBJECT]
			-- Global external object files.
		do
			Result := internal_external_object.twin
			if attached extends as l_extends then
				Result.append (l_extends.external_object)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_library: ARRAYED_LIST [CONF_EXTERNAL_LIBRARY]
			-- Global external library files.
		do
			Result := internal_external_library.twin
			if attached extends as l_extends then
				Result.append (l_extends.external_library)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_linker_flag: ARRAYED_LIST [CONF_EXTERNAL_LINKER_FLAG]
			-- Global external linker flags.
		do
			Result := internal_external_linker_flag.twin
			if attached extends as l_extends then
				Result.append (l_extends.external_linker_flag)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_make: ARRAYED_LIST [CONF_EXTERNAL_MAKE]
			-- Global external make files.
		do
			Result := internal_external_make.twin
			if attached extends as l_extends then
				Result.append (l_extends.external_make)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_resource: ARRAYED_LIST [CONF_EXTERNAL_RESOURCE]
			-- Global external ressource files.
		do
			Result := internal_external_resource.twin
			if attached extends as l_extends then
				Result.append (l_extends.external_resource)
			end
		ensure
			Result_not_void: Result /= Void
		end

	pre_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- Actions to be executed before compilation.
		do
			if attached internal_pre_compile_action as l_internal_pre_compile_action then
				Result := l_internal_pre_compile_action.twin
			else
				create Result.make (0)
			end
			if attached extends as l_extends then
				Result.append (l_extends.pre_compile_action)
			end
		ensure
			Result_not_void: Result /= Void
		end

	post_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- Actions to be executed after compilation.
		do
			if attached internal_post_compile_action as l_internal_post_compile_action then
				Result := l_internal_post_compile_action.twin
			else
				create Result.make (0)
			end
			if attached extends as l_extends then
				Result.append (l_extends.post_compile_action)
			end
		ensure
			Result_not_void: Result /= Void
		end

	variables: STRING_TABLE [READABLE_STRING_32]
			-- User defined variables.
		do
			if attached extends as l_extends then
				Result := l_extends.variables.twin
				Result.merge (internal_variables)
			else
				Result := internal_variables
			end
		ensure
			Result_not_void: Result /= Void
		end

	mapping: STRING_TABLE [STRING_32]
			-- Special classes name mapping (eg. STRING => STRING_32)
		do
			if attached extends as l_extends then
				Result := l_extends.mapping.twin
				if attached internal_mapping as l_internal_mapping then
					Result.merge (l_internal_mapping)
				end
			else
				if attached internal_mapping as l_internal_mapping then
					Result := l_internal_mapping
				else
					create Result.make_equal (5)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access: concurrency setting

	setting_concurrency: CONF_VALUE_CHOICE
			-- Value of the "concurrency" setting
			-- calculated using both immediate and inherited data.
		do
			if attached extends as e then
				Result := Precursor.twin
				Result.set_safely (e.setting_concurrency)
			else
				Result := Precursor
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if attached system as l_system then
				l_system.targets.replace_key (a_name.as_lower, name)
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

	set_version (a_version: like version)
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

	remove_library (a_name: READABLE_STRING_GENERAL)
			-- Remove a library with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_libraries.remove (a_name)
		end

	remove_assembly (a_name: READABLE_STRING_GENERAL)
			-- Remove an assembly with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_assemblies.remove (a_name)
		end

	remove_cluster (a_name: READABLE_STRING_GENERAL)
			-- Remove a cluster with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_clusters.remove (a_name)
		end

	remove_override (a_name: READABLE_STRING_GENERAL)
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

	set_file_rules (a_file_rules: detachable like file_rule)
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

	set_external_includes (an_includes: like external_include)
			-- Set `an_includes'.
		require
			an_includes_not_void: an_includes /= Void
		do
			internal_external_include := an_includes
		ensure
			includes_set: internal_external_include =an_includes
		end

	set_external_cflag (v: like external_cflag)
			-- Set `internal_external_cflag' to `v'.
		require
			v_attached: attached v
		do
			internal_external_cflag := v
		ensure
			internal_external_cflag_set: internal_external_cflag = v
		end

	set_external_objects (an_objects: like external_object)
			-- Set `an_objects'.
		require
			an_objects_not_void: an_objects /= Void
		do
			internal_external_object := an_objects
		ensure
			objects_set: internal_external_object = an_objects
		end

	set_external_libraries (a_libraries: like external_library)
			-- Set `a_libraries'.
		require
			a_libraries_not_void: a_libraries /= Void
		do
			internal_external_library := a_libraries
		ensure
			libraries_set: internal_external_library = a_libraries
		end

	set_external_resources (a_ressources: like external_resource)
			-- Set `a_ressources'.
		require
			a_ressources_not_void: a_ressources /= Void
		do
			internal_external_resource := a_ressources
		ensure
			ressources_set: internal_external_resource = a_ressources
		end

	set_external_linker_flag (v: like external_linker_flag)
			-- Set `internal_external_linker_flag' to `v'.
		require
			v_attached: attached v
		do
			internal_external_linker_flag := v
		ensure
			internal_external_linker_flag_set: internal_external_linker_flag = v
		end

	set_external_make (a_makes: like external_make)
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

	set_pre_compile (a_pre_compile: like pre_compile_action)
			-- Set `a_pre_compile'.
		do
			internal_pre_compile_action := a_pre_compile
		ensure
			pre_compile_set: internal_pre_compile_action = a_pre_compile
		end

	set_post_compile (a_post_compile: like post_compile_action)
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

	add_variable (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_32)
			-- Add a variable with `a_name' and `a_value'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		do
			internal_variables.force (a_value, a_name)
		ensure
			variable_added: internal_variables.has (a_name) and then internal_variables.item (a_name) = a_value
		end

	remove_variable (a_name: READABLE_STRING_GENERAL)
			-- Remove a variable with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			internal_variables.remove (a_name)
		ensure
			variable_removed: not internal_variables.has (a_name)
		end

	add_mapping (a_old_name: READABLE_STRING_GENERAL; a_new_name: STRING_32)
			-- Add/replace  mapping from `a_old_name' to `a_new_name'.
		require
			a_old_name_ok: a_old_name /= Void and then not a_old_name.is_empty
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
		local
			l_internal_mapping: like internal_mapping
		do
			l_internal_mapping := internal_mapping
			if l_internal_mapping = Void then
				create l_internal_mapping.make_equal_caseless (15)
				internal_mapping := l_internal_mapping
			end
				-- Eventhough we are caseless, we do store mapping in upper.
			l_internal_mapping.force (a_new_name.as_upper, a_old_name.as_upper)
		end

	remove_mapping (a_name: READABLE_STRING_GENERAL)
			-- Remove a mapping with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			if attached internal_mapping as l_internal_mapping then
				l_internal_mapping.remove (a_name)
			end
		ensure
			mapping_removed: attached internal_mapping as el_internal_mapping implies not el_internal_mapping.has (a_name)
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
		local
			l_extends, l_other_extends: like extends
		do
				-- If there is a change in the target hierarchy, we cannot cope with it
				-- properly, see eweasel test#incr379
			l_extends := extends
			l_other_extends := other.extends
			if l_extends = Void then
				Result := l_other_extends = Void
			elseif l_other_extends /= Void then
				Result := l_extends.name.same_string (l_other_extends.name)
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
				if attached precompile as l_precompile then
					Result := attached other.precompile as l_other_precompile and then l_precompile.is_group_equivalent (l_other_precompile)
				else
					Result := other.precompile = Void
				end
			end
		end

	is_deep_group_equivalent (other: like Current; a_processed_libraries: SEARCH_TABLE [UUID]): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout, even down into used libraries?
			-- do not process already processed libraries and add newly processed libraries to `a_processed_libraries'.
		require
			a_processed_libraries: a_processed_libraries /= Void
		local
			l_libs, l_other_libs: like libraries
			l_lib, l_other_lib: detachable CONF_LIBRARY
			l_library_target: detachable CONF_TARGET
		do
			Result := is_group_equivalent (other)
				-- check if all the used library are deep group equivalent
			if Result then
				from
					l_other_libs := other.libraries
					l_libs := libraries
						-- if we have a precompile, add this to the list of libraries
					if attached precompile as l_precompile then
						l_libs := l_libs.twin
						l_libs.force (l_precompile, l_precompile.name)
					end
					if attached other.precompile as l_other_precompile then
						l_other_libs := l_other_libs.twin
						l_other_libs.force (l_other_precompile, l_other_precompile.name)
					end
					l_libs.start
				until
					not Result or else l_libs.after
				loop
					l_lib := l_libs.item_for_iteration
					l_other_lib := l_other_libs.item (l_lib.name)
					if l_other_lib /= Void then
						l_library_target := l_lib.library_target
						if l_library_target = Void then
							Result := l_other_lib.library_target = Void
						elseif not a_processed_libraries.has (l_library_target.system.uuid) then
							a_processed_libraries.force (l_library_target.system.uuid)
							Result := attached l_other_lib.library_target as l_other_library_target and then
										l_library_target.is_deep_group_equivalent (l_other_library_target, a_processed_libraries)
						end
					else
						check
								-- `is_group_equivalent' is implying `other_library_found'.
							other_library_found: False
						end
						Result := False
					end
					l_libs.forth
				end
			end
		end

feature -- Hashable

	hash_code: INTEGER
			-- Hash code value
		do
			Result := name.hash_code
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_target (Current)
		end

feature -- Output

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := system.name + "/" + name
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, attributes that are stored to the configuration file

	internal_root: detachable CONF_ROOT
			-- The root feature of this target itself.

	internal_version: detachable CONF_VERSION
			-- The version of this target itself.

	internal_precompile: detachable like precompile
			-- Precompile of this target itself.

	internal_libraries: like libraries
			-- The used libraries of this target itself.

	internal_overrides: like overrides
			-- The override clusters of this target itself.

	internal_clusters: like clusters
			-- The normal clusters of this target itself.

	internal_assemblies: like assemblies
			-- The assemblies of this target itself.

	internal_file_rule: like file_rule
			-- Rules for files to be included or excluded of this target itself.

	internal_mapping: detachable like mapping
			-- Special classes name mapping (eg. STRING => STRING_32) of this target itself.

	internal_external_include: like external_include
			-- Global external include files of this target itself.

	internal_external_cflag: like external_cflag
			-- Global external C flags of this target itself.

	internal_external_object: like external_object
			-- Global external object files of this target itself.

	internal_external_library: like external_library
			-- Global external library files of this target itself.

	internal_external_resource: like external_resource
			-- Global external ressource files of this target itself.

	internal_external_linker_flag: like external_linker_flag
			-- Global external linker flags of this target itself.

	internal_external_make: like external_make
			-- Global external make files of this target itself.

	internal_pre_compile_action: like pre_compile_action
			-- Actions to be executed before compilation of this target itself.

	internal_post_compile_action: like post_compile_action
			-- Actions to be executed after compilation of this target itself.

	internal_variables: like variables
			-- User defined variables of this target itself.

feature {NONE} -- Implementation

	is_group_equal_check (a, b: STRING_TABLE [CONF_GROUP]): BOOLEAN
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
	environ_variables_not_void: environ_variables /= Void

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
