indexing
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

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_system: CONF_SYSTEM) is
			-- Create with `a_name'.
		require
			a_name_ok: a_name /= Void and not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
			a_system_not_void: a_system /= Void
		do
			name := a_name
			create internal_libraries.make (1)
			create internal_overrides.make (0)
			create internal_clusters.make (1)
			create internal_assemblies.make (0)

			create internal_file_rule.make

			create internal_external_include.make (1)
			create internal_external_object.make (1)
			create internal_external_ressource.make (1)
			create internal_external_make.make (1)
			create internal_pre_compile_action.make (1)
			create internal_post_compile_action.make (1)
			create internal_variables.make (1)
			create environ_variables.make (1)
			create internal_settings.make (1)
			system := a_system
		ensure
			name_set: name = a_name
			system_set: system = a_system
		end


feature -- Access, stored in configuration file

	name: STRING
			-- Name of the target.

	description: STRING
			-- A description about the target.

	extends: CONF_TARGET
			-- If we extend another target, this is the other target.

	system: CONF_SYSTEM
			-- The associated system

feature -- Access, in compiled only, not stored to configuration file

	environ_variables: HASH_TABLE [STRING, STRING]
			-- Saved environment variables.

	location: STRING
			-- Absolute location of the configuration file.

	used_in_libraries: ARRAYED_LIST [CONF_LIBRARY]
			-- Libraries this target is used in.

	all_libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- All libraries in current system.

	all_assemblies: HASH_TABLE [CONF_ASSEMBLY, STRING]
			-- All assemblies in current system.

	application_target: CONF_TARGET
			-- The application target.

feature -- Access queries

	version: CONF_VERSION is
			-- Version number of the target.
		do
			if internal_version /= Void then
				Result := internal_version
			elseif extends /= Void then
				Result := extends.version
			end
		end

	precompile: like internal_precompile is
			-- The precompile (if any).
		do
			if internal_precompile = Void and extends /= Void then
				Result := extends.precompile
			else
				Result := internal_precompile
			end
		end

	libraries: like internal_libraries is
			-- The used libraries.
		do
			if extends /= Void then
				Result := extends.libraries.twin
				Result.merge (internal_libraries)
			else
				Result := internal_libraries
			end
		ensure
			Result_not_void: Result /= Void
		end

	assemblies: like internal_assemblies is
			-- The assemblies.
		do
			if extends /= Void then
				Result := extends.assemblies.twin
				Result.merge (internal_assemblies)
			else
				Result := internal_assemblies
			end
		ensure
			Result_not_void: Result /= Void
		end

	clusters: like internal_clusters is
			-- The normal clusters.
		do
			if extends /= Void then
				Result := extends.clusters.twin
				Result.merge (internal_clusters)
			else
				Result := internal_clusters
			end
		ensure
			Result_not_void: Result /= Void
		end

	overrides: like internal_overrides is
			-- The override clusters.
		do
			if extends /= Void then
				Result := extends.overrides.twin
				Result.merge (internal_overrides)
			else
				Result := internal_overrides
			end
		ensure
			Result_not_void: Result /= Void
		end

	groups: HASH_TABLE [CONF_GROUP, STRING] is
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

	root: CONF_ROOT is
			-- The root feature.
		do
			if internal_root /= Void then
				Result := internal_root
			elseif extends /= Void then
				Result := extends.root
			end
		end

	file_rule: CONF_FILE_RULE is
			-- Rules for files to be included or excluded.
		do
			Result := internal_file_rule.twin
			if extends /= Void then
				Result.merge (extends.file_rule)
			end
		end

	options: CONF_OPTION is
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

	settings: like internal_settings is
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

	all_external_include: like internal_external_include is
			-- All external include files including the ones from libraries.
		require
			all_libraries_set: all_libraries /= Void
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_include)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_object: like internal_external_object is
			-- All external object files including the ones from libraries.
		require
			all_libraries_set: all_libraries /= Void
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_object)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_ressource: like internal_external_ressource is
			-- All external ressource files including the ones from libraries.
		require
			all_libraries_set: all_libraries /= Void
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_ressource)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	all_external_make: like internal_external_make is
			-- All external make files including the ones from libraries.
		require
			all_libraries_set: all_libraries /= Void
		do
			create Result.make (10)
			from
				all_libraries.start
			until
				all_libraries.after
			loop
				Result.append (all_libraries.item_for_iteration.external_make)
				all_libraries.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_include: like internal_external_include is
			-- Global external include files.
		do
			Result := internal_external_include.twin
			if extends /= Void then
				Result.append (extends.external_include)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_object: like internal_external_object is
			-- Global external object files.
		do
			Result := internal_external_object.twin
			if extends /= Void then
				Result.append (extends.external_object)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_make: like internal_external_make is
			-- Global external make files.
		do
			Result := internal_external_make.twin
			if extends /= Void then
				Result.append (extends.external_make)
			end
		ensure
			Result_not_void: Result /= Void
		end

	external_ressource: like internal_external_ressource is
			-- Global external ressource files.
		do
			Result := internal_external_ressource.twin
			if extends /= Void then
				Result.append (extends.external_ressource)
			end
		ensure
			Result_not_void: Result /= Void
		end

	pre_compile_action: ARRAYED_LIST [CONF_ACTION] is
			-- Actions to be executed before compilation.
		do
			if internal_pre_compile_action /= Void then
				Result := internal_pre_compile_action
			elseif extends /= Void then
				Result := extends.pre_compile_action
			else
				create Result.make (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

	post_compile_action: ARRAYED_LIST [CONF_ACTION] is
			-- Actions to be executed after compilation.
		do
			if internal_post_compile_action /= Void then
				Result := internal_post_compile_action
			elseif extends /= Void then
				Result := extends.post_compile_action
			else
				create Result.make (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

	variables: like internal_variables is
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

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_name (a_name: like name) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lowoer: a_name.is_equal (a_name.as_lower)
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_parent (a_target: like extends) is
			-- Set `extends' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			extends := a_target
		ensure
			parent_set: extends = a_target
		end

	remove_parent is
			-- Remove the parent target.
		do
			extends := Void
		end

	set_version (a_version: like internal_version) is
			-- Set `version' to `a_version'.
		do
			internal_version := a_version
		ensure
			version_set: internal_version = a_version
		end

	set_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Set `a_precompile'.
		require
			a_precompile_not_void: a_precompile /= Void
		do
			internal_precompile := a_precompile
		ensure
			precompile_set: internal_precompile = a_precompile
		end

	add_library (a_library: CONF_LIBRARY) is
			-- Add `a_library'.
		require
			a_library_not_void: a_library /= Void
		do
			internal_libraries.force (a_library, a_library.name)
		ensure
			library_added: internal_libraries.has (a_library.name)
		end

	add_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Add `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			internal_assemblies.force (an_assembly, an_assembly.name)
		ensure
			assembly_added: internal_assemblies.has (an_assembly.name)
		end

	add_cluster (a_cluster: CONF_CLUSTER) is
			-- Add `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			internal_clusters.force (a_cluster, a_cluster.name)
		ensure
			cluster_added: internal_clusters.has (a_cluster.name)
		end

	add_override (an_override: CONF_OVERRIDE) is
			-- Add `an_override'.
		require
			an_override_not_void: an_override /= Void
		do
			internal_overrides.force (an_override, an_override.name)
		ensure
			override_added: internal_overrides.has (an_override.name)
		end

	remove_library (a_name: STRING) is
			-- Remove a library with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_libraries.remove (a_name)
		end

	remove_assembly (a_name: STRING) is
			-- Remove an assembly with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_assemblies.remove (a_name)
		end

	remove_cluster (a_name: STRING) is
			-- Remove a cluster with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_clusters.remove (a_name)
		end

	remove_override (a_name: STRING) is
			-- Remove an override with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_overrides.remove (a_name)
		end

	set_root (a_root: like root) is
			-- Set `a_root'.
		require
			a_root_not_void: a_root /= Void
		do
			internal_root := a_root
		ensure
			root_set: internal_root = a_root
		end

	remove_root is
			-- Remove root.
		do
			internal_root := Void
		ensure
			root_removed: internal_root = Void
		end

	set_file_rule (a_file_rule: like internal_file_rule) is
			-- Set `a_file_rule'.
		require
			a_file_rule_not_void: a_file_rule /= Void
		do
			internal_file_rule := a_file_rule
		ensure
			file_rule_set: internal_file_rule = a_file_rule
		end

	set_options (an_option: like internal_options) is
			-- Set `an_option'.
		require
			an_option_not_void: an_option /= Void
		do
			internal_options := an_option
		ensure
			option_set: internal_options = an_option
		end

	set_settings (a_settings: like internal_settings) is
			-- Set `a_settings'.
		require
			a_settings_not_void: a_settings /= Void
		do
			internal_settings := a_settings
		ensure
			settings_set: internal_settings = a_settings
		end

	add_setting (a_name, a_value: STRING) is
			-- Add a new setting.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		do
			internal_settings.force (a_value, a_name)
		ensure
			added: internal_settings.item (a_name) = a_value
		end

	set_external_includes (an_includes: like internal_external_include) is
			-- Set `an_includes'.
		require
			an_includes_not_void: an_includes /= Void
		do
			internal_external_include := an_includes
		ensure
			includes_set: internal_external_include =an_includes
		end

	set_external_objects (an_objects: like internal_external_object) is
			-- Set `an_objects'.
		require
			an_objects_not_void: an_objects /= Void
		do
			internal_external_object := an_objects
		ensure
			objects_set: internal_external_object = an_objects
		end

	set_external_ressources (a_ressources: like internal_external_ressource) is
			-- Set `a_ressources'.
		require
			a_ressources_not_void: a_ressources /= Void
		do
			internal_external_ressource := a_ressources
		ensure
			ressources_set: internal_external_ressource = a_ressources
		end

	set_external_make (a_makes: like internal_external_make) is
			-- Set `a_makes'.
		require
			a_makes_not_void: a_makes /= Void
		do
			internal_external_make := a_makes
		ensure
			makes_set: internal_external_make = a_makes
		end

	add_external_include (an_include: CONF_EXTERNAL_INCLUDE) is
			-- Add `an_include'.
		require
			an_include_not_void: an_include /= Void
		do
			if internal_external_include = Void then
				create internal_external_include.make (1)
			end
			internal_external_include.extend (an_include)
		ensure
			added: internal_external_include.has (an_include)
		end

	add_external_object (an_object: CONF_EXTERNAL_OBJECT) is
			-- Add `an_object'.
		require
			an_object_not_void: an_object /= Void
		do
			if internal_external_object = Void then
				create internal_external_object.make (1)
			end
			internal_external_object.extend (an_object)
		ensure
			added: internal_external_object.has (an_object)
		end

	add_external_ressource (a_ressource: CONF_EXTERNAL_RESSOURCE) is
			-- Add `a_ressource'.
		require
			a_ressource_not_void: a_ressource /= Void
		do
			if internal_external_ressource = Void then
				create internal_external_ressource.make (1)
			end
			internal_external_ressource.extend (a_ressource)
		ensure
			added: internal_external_ressource.has (a_ressource)
		end

	add_external_make (a_make: CONF_EXTERNAL_MAKE) is
			-- Add `a_make'.
		require
			a_make_not_void: a_make /= Void
		do
			if internal_external_make = Void then
				create internal_external_make.make (1)
			end
			internal_external_make.extend (a_make)
		ensure
			added: internal_external_make.has (a_make)
		end

	set_pre_compile (a_pre_compile: like internal_pre_compile_action) is
			-- Set `a_pre_compile'.
		do
			internal_pre_compile_action := a_pre_compile
		ensure
			pre_compile_set: internal_pre_compile_action = a_pre_compile
		end

	set_post_compile (a_post_compile: like internal_post_compile_action) is
			-- Set `a_post_compile'.
		do
			internal_post_compile_action := a_post_compile
		ensure
			post_compile_set: internal_post_compile_action = a_post_compile
		end

	add_pre_compile (an_action: CONF_ACTION) is
			-- Add `an_action'.
		require
			an_action_not_void: an_action /= Void
		do
			if internal_pre_compile_action = Void then
				create internal_pre_compile_action.make (1)
			end
			internal_pre_compile_action.extend (an_action)
		end

	add_post_compile (an_action: CONF_ACTION) is
			-- Add `an_action'.
		require
			an_action_not_void: an_action /= Void
		do
			if internal_post_compile_action = Void then
				create internal_post_compile_action.make (1)
			end
			internal_post_compile_action.extend (an_action)
		end


	add_variable (a_name, a_value: STRING) is
			-- Add a variable with `a_name' and `a_value'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
			a_value_not_void: a_value /= Void
			name_not_used: not variables.has (a_name)
		do
			internal_variables.put (a_value, a_name)
		ensure
			variable_added: internal_variables.has (a_name) and then internal_variables.item (a_name) = a_value
		end

	remove_variable (a_name: STRING) is
			-- Remove a variable with `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			internal_variables.remove (a_name)
		ensure
			variable_removed: not internal_variables.has (a_name)
		end

	update_variable (a_name, a_value: STRING) is
			-- Update a variable with `a_name' and `a_value'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
			a_value_not_void: a_value /= Void
			entry_exists: variables.has (a_name)
		do
			internal_variables.force (a_value, a_name)
		ensure
			variable_added: internal_variables.has (a_name) and then internal_variables.item (a_name) = a_value
		end

feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_environ_variables (a_vars: like environ_variables) is
			-- Set `environ_variables' to `a_vars'.
		require
			a_vars_not_void: a_vars /= Void
		do
			environ_variables := a_vars
		ensure
			environ_variables_set: environ_variables = a_vars
		end

	set_location (a_location: like location) is
			-- Set `location' to `a_location'.
		require
			a_location_not_void: a_location /= Void
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	add_library_usage (a_library: CONF_LIBRARY) is
			-- `Current' is library of `a_library'.
		require
			a_library_not_void: a_library /= Void
			a_library_target: a_library.library_target = Current
		do
			if used_in_libraries = Void then
				create used_in_libraries.make (1)
			end
			used_in_libraries.force (a_library)
		ensure
			added_libs: used_in_libraries.has (a_library)
		end

	set_all_libraries (a_libraries: like all_libraries) is
			-- Set `all_libraries' to `a_libraries'.
		require
			a_libraries_not_void: a_libraries /= Void
		do
			all_libraries := a_libraries
		ensure
			libraries_set: all_libraries = a_libraries
		end

	set_all_assemblies (an_assemblies: like all_assemblies) is
			-- Set `all_assemlibes' to `an_assemblies'.
		require
			an_assemblies_not_void: an_assemblies /= Void
		do
			all_assemblies := an_assemblies
		ensure
			assemblies_set: all_assemblies = an_assemblies
		end

	set_application_target (a_target: CONF_TARGET) is
			-- Set `application_target' to `a_target'.
			-- (export status {CONF_ACCESS})
		require
			a_target_not_void: a_target /= Void
		do
			application_target := a_target
		ensure
			application_target_set: application_target = a_target
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := is_group_equal_check (libraries, other.libraries) and then
						is_group_equal_check (assemblies, other.assemblies) and then
						is_group_equal_check (clusters, other.clusters) and then
						is_group_equal_check (overrides, other.overrides) and then
						equal (variables, other.variables) and then
						equal (root, other.root) and then
						equal (file_rule, other.file_rule)
			if Result then
				if precompile = Void then
					Result := other.precompile = Void
				else
					Result := other.precompile /= Void and then precompile.is_group_equivalent (other.precompile)
				end
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_target (Current)
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

	internal_file_rule: CONF_FILE_RULE
			-- Rules for files to be included or excluded of this target itself.

	internal_options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...) of this target itself.

	internal_settings: HASH_TABLE [STRING, STRING]
			-- Settings of this target itself.

	internal_external_include: ARRAYED_LIST [CONF_EXTERNAL_INCLUDE]
			-- Global external include files of this target itself.

	internal_external_object: ARRAYED_LIST [CONF_EXTERNAL_OBJECT]
			-- Global external object files of this target itself.

	internal_external_ressource: ARRAYED_LIST [CONF_EXTERNAL_RESSOURCE]
			-- Global external ressource files of this target itself.

	internal_external_make: ARRAYED_LIST [CONF_EXTERNAL_MAKE]
			-- Global external make files of this target itself.

	internal_pre_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- Actions to be executed before compilation of this target itself.

	internal_post_compile_action: ARRAYED_LIST [CONF_ACTION]
			-- Actions to be executed after compilation of this target itself.

	internal_variables: CONF_HASH_TABLE [STRING, STRING]
			-- User defined variables of this target itself.

feature {NONE} -- Implementation

	is_group_equal_check (a, b: HASH_TABLE [CONF_GROUP, STRING]): BOOLEAN is
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
	internal_external_object_not_void: internal_external_object /= Void
	internal_external_ressource_not_void: internal_external_ressource /= Void
	internal_external_make_not_void: internal_external_make /= Void
	internal_pre_compile_not_void: internal_pre_compile_action /= Void
	internal_post_compile_not_void: internal_post_compile_action /= Void
	internal_variables_not_void: internal_variables /= Void
	internal_settings_not_void: internal_settings /= Void
	environ_variables_not_void: environ_variables /= Void
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
