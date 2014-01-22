note
	description: "A project cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CLUSTER

inherit
	CONF_PHYSICAL_GROUP
		redefine
			make,
			options,
			is_group_equivalent,
			process,
			class_by_name,
			name_by_class,
			is_cluster,
			is_readonly,
			accessible_groups,
			location
		end

	CONF_VISIBLE

create {CONF_PARSE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET)
			-- Create
		do
			Precursor (a_name, a_location, a_target)
			create internal_file_rule.make (0)
			internal_file_rule.compare_objects
			create class_by_name_cache.make (50)
			create name_by_class_cache.make (50)
		end

feature -- Status

	is_cluster: BOOLEAN
			-- Is this a cluster?
		once
			Result := True
		end

feature -- Access, stored in configuration file

	location: CONF_DIRECTORY_LOCATION
			-- Directory of this cluster

	is_recursive: BOOLEAN
			-- Are subdirectories included recursively?

	is_hidden: BOOLEAN
			-- Is this a hidden cluster that can not be used if the cluster is used in a library.

	parent: detachable CONF_CLUSTER
			-- An optional parent cluster.

	children: detachable ARRAYED_LIST [like Current]
			-- Optionally multiple children.

feature -- Access queries

	dependencies: detachable SEARCH_TABLE [CONF_GROUP]
			-- Dependencies to other groups.
			-- Empty = No dependencies
			-- Void = Depend on all
		do
			if attached parent as l_parent and then attached l_parent.dependencies as l_parent_dependencies then
				Result := l_parent_dependencies.twin
			end

			if attached internal_dependencies as l_internal_dependencies then
				if Result /= Void then
					Result.merge (l_internal_dependencies)
				else
					Result := l_internal_dependencies
				end
			end
		end

	active_file_rule (a_state: CONF_STATE): CONF_FILE_RULE
			-- Active file rule for `a_state'.
		require
			a_state_not_void: a_state /= Void
		local
			l_rules: like file_rule
		do
			create Result.make
			from
				l_rules := file_rule
				l_rules.start
			until
				l_rules.after
			loop
				if l_rules.item.is_enabled (a_state) then
					Result.merge (l_rules.item)
				end
				l_rules.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	file_rule: ARRAYED_LIST [CONF_FILE_RULE]
			-- Rules for files to be included or excluded.
		do
			Result := internal_file_rule.twin
			if attached parent as l_parent then
				Result.append (l_parent.file_rule)
			end
			Result.append (target.file_rule)
		ensure
			Result_not_void: Result /= Void
		end

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		local
			l_lib: detachable CONF_LIBRARY
			l_local: CONF_OPTION
			l_result: detachable CONF_OPTION
		do
				-- get local options
			if attached internal_options as l_internal_options then
				l_local := l_internal_options.twin
			else
				create l_local
			end
			if attached parent as l_parent then
				l_local.merge (l_parent.options)
			else
				l_local.merge (target.options)
			end

				-- if used as library, get options from application level if the library is defined there
			if is_used_in_library then
				l_lib := target.system.application_target_library
				if l_lib /= Void then
					l_result := l_lib.options
				end
			end

			if l_result /= Void then
				l_result.merge (l_local)

					-- Need to set local namespace, because local namespaces cannot be merged for libraries
				l_result.set_local_namespace (l_local.local_namespace)
			else
				l_result := l_local
			end
			Result := l_result
		end

	class_options: like internal_class_options
			-- Options for classes.
		local
			l_lib: detachable CONF_LIBRARY
			l_class_options: like class_options
		do
				-- get local options
			if attached parent as l_parent then
				l_class_options :=  l_parent.class_options
				if l_class_options /= Void then
					Result := l_class_options.twin
				end
			end
			if attached internal_class_options as l_internal_class_options then
				if Result /= Void then
					Result.merge (l_internal_class_options)
				else
					Result := l_internal_class_options.twin
				end
			end

				-- if used as library, get options from application level if the library is defined there
			if is_used_in_library then
				l_lib := target.system.application_target_library
				if l_lib /= Void then
					l_class_options := l_lib.class_options
					if l_class_options /= Void then
						if Result /= Void then
							Result.merge (l_class_options)
						else
							Result := l_class_options.twin
						end
					end
				end
			end
		end

	mapping: STRING_TABLE [STRING_32]
			-- Special classes name mapping (eg. STRING => STRING_32).
		local
			l_cached_mapping: like cached_mapping
		do
			l_cached_mapping := cached_mapping
			if l_cached_mapping = Void then
				if internal_mapping = Void and parent = Void then
					l_cached_mapping := target.mapping
				else
					l_cached_mapping := target.mapping.twin
					if attached parent as l_parent then
						l_cached_mapping.merge (l_parent.mapping)
					end
					if attached internal_mapping as l_internal_mapping then
						l_cached_mapping.merge (l_internal_mapping)
					end
				end
				cached_mapping := l_cached_mapping
			end
			Result := l_cached_mapping
		ensure then
			Result_cached: Result = cached_mapping
		end

	class_by_name (a_class: READABLE_STRING_GENERAL; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS]
			-- Get the class with the final (after renaming/prefix) name `a_class'.
			-- Either if it is defined in this cluster or if `a_dependencies' in a dependency.
		local
			l_groups: like accessible_groups
			l_grp: CONF_GROUP
			l_name: READABLE_STRING_GENERAL
		do
				-- apply mapping
			if attached mapping.item (a_class) as l_mapping_found_item then
				l_name := l_mapping_found_item
			else
				l_name := a_class
			end

			if a_dependencies and then attached class_by_name_cache.item (l_name) as l_found_item then
				Result := l_found_item
			else
					-- search in cluster itself
				create Result.make
				if
					attached classes as l_classes and then
					attached l_classes.item (l_name) as l_class and then
					not l_class.does_override
				then
					Result.extend (l_class)
				end

					-- search in dependencies
				if a_dependencies then
					l_groups := accessible_groups
					from
						l_groups.start
					until
						l_groups.after
					loop
						l_grp := l_groups.item_for_iteration
						if l_grp.classes_set then
							Result.append (l_grp.class_by_name (l_name, False))
						end
						l_groups.forth
					end

					class_by_name_cache.force (Result, l_name)
				end
			end
		end

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [READABLE_STRING_GENERAL]
			-- Get name in this context of `a_class' (if `a_dependencies') then we check dependencies).
		local
			l_groups: like accessible_groups
			l_grp: CONF_GROUP
		do
			if a_dependencies and then attached name_by_class_cache.item (a_class) as l_name_by_class_cache_found_item then
				Result := l_name_by_class_cache_found_item
			else
					-- search in cluster itself
				Result := Precursor {CONF_PHYSICAL_GROUP} (a_class, a_dependencies)

					-- search in dependencies
				if a_dependencies then
					l_groups := accessible_groups
					from
						l_groups.start
					until
						l_groups.after
					loop
						l_grp := l_groups.item_for_iteration
						if l_grp.classes_set then
							Result.append (l_grp.name_by_class (a_class, False))
						end
						l_groups.forth
					end
					name_by_class_cache.force (Result, a_class)
				end
			end
		end

	accessible_groups: SEARCH_TABLE [CONF_GROUP]
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else everything except `Current'.
		local
			l_grps: STRING_TABLE [CONF_GROUP]
			l_accessible_groups_cache: like accessible_groups_cache
		do
			l_accessible_groups_cache := accessible_groups_cache
			if l_accessible_groups_cache = Void then
				if attached dependencies as l_dependencies then
					l_accessible_groups_cache := l_dependencies
					accessible_groups_cache := l_accessible_groups_cache
				else
					l_grps := target.clusters
					create l_accessible_groups_cache.make_map (l_grps.count)
					accessible_groups_cache := l_accessible_groups_cache

					from
						l_grps.start
					until
						l_grps.after
					loop
						l_accessible_groups_cache.force (l_grps.item_for_iteration)
						l_grps.forth
					end

					l_grps := target.libraries
					l_accessible_groups_cache.resize (accessible_groups.count+l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						l_accessible_groups_cache.force (l_grps.item_for_iteration)
						l_grps.forth
					end

					l_grps := target.assemblies
					l_accessible_groups_cache.resize (accessible_groups.count+l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						l_accessible_groups_cache.force (l_grps.item_for_iteration)
						l_grps.forth
					end

					l_grps := target.overrides
					l_accessible_groups_cache.resize (accessible_groups.count+l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						l_accessible_groups_cache.force (l_grps.item_for_iteration)
						l_grps.forth
					end

					if attached target.precompile as l_target_precompile then
						l_accessible_groups_cache.force (l_target_precompile)
					end
					l_accessible_groups_cache.remove (Current)
				end
			end
			Result := l_accessible_groups_cache
		end

	sub_group_by_name (a_name: READABLE_STRING_GENERAL): detachable CONF_GROUP
			-- Return sub cluster with `a_name' if there is any.
		do
			if attached children as l_children then
				from
					l_children.start
				until
					Result /= Void or l_children.after
				loop
					if l_children.item.name.same_string_general (a_name) then
						Result := l_children.item
					end
					l_children.forth
				end
			end
		end

	is_readonly: BOOLEAN
			-- Is this group read only?
		local
			l_lib: detachable CONF_LIBRARY
		do
			Result := internal_read_only
			if not Result and then is_used_in_library then
					-- if used as library and the library defined in the application target itself, take value from there
					-- else take the system value.
				l_lib := target.system.application_target_library
				if l_lib /= Void then
					Result := l_lib.is_readonly
				else
					Result := target.system.is_readonly
				end
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_parent (a_cluster: like parent)
			-- Set `parent' to `a_cluster'.
		do
			parent := a_cluster
		ensure
			parent_set: parent = a_cluster
		end

	add_child (a_cluster: like Current)
			-- Add `a_cluster' to `children'.
		local
			l_children: like children
		do
			l_children := children
			if l_children = Void then
				create l_children.make (1)
				children := l_children
			end
			l_children.force (a_cluster)
		ensure
			children_set: attached children as el_children
			child_added: el_children.has (a_cluster)
		end

	remove_child (a_cluster: like Current)
			-- Remove `a_cluster' from `children'.
		do
			if attached children as l_children then
				l_children.prune_all (a_cluster)
			end
		end

	set_recursive (a_enabled: BOOLEAN)
			-- Set `is_recursive' to `a_enabled'.
		do
			is_recursive := a_enabled
		ensure
			is_recursive_set: is_recursive = a_enabled
		end

	set_hidden (a_enabled: BOOLEAN)
			-- Set `is_hidden' to `a_enabled'.
		do
			is_hidden := a_enabled
		ensure
			is_hidden_set: is_hidden = a_enabled
		end

	set_dependencies (a_dependencies: like internal_dependencies)
			-- Set `a_dependencies'.
		do
			internal_dependencies := a_dependencies
		ensure
			dependencies_set: internal_dependencies = a_dependencies
		end

	add_dependency (a_group: CONF_GROUP)
			-- Add a dependency.
		require
			a_group_not_void: a_group /= Void
		local
			l_internal_dependencies: like internal_dependencies
		do
			l_internal_dependencies := internal_dependencies
			if l_internal_dependencies = Void then
				create l_internal_dependencies.make (0)
				internal_dependencies := l_internal_dependencies
			end
			l_internal_dependencies.force (a_group)
		ensure
			internal_dependencies_set: attached internal_dependencies as el_internal_dependencies
			added: el_internal_dependencies.has (a_group)
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

	set_file_rule (a_file_rule: like internal_file_rule)
			-- Set `a_file_rule'.
		require
			a_file_rule_not_void: a_file_rule /= Void
		do
			internal_file_rule := a_file_rule
		ensure
			file_rule_set: internal_file_rule = a_file_rule
		end

	add_mapping (a_old_name, a_new_name: STRING_32)
			-- Add a new mapping from `a_old_name' to `a_new_name'.
		require
			a_old_name_ok: a_old_name /= Void and then not a_old_name.is_empty
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
		local
			l_internal_mapping: like internal_mapping
		do
			l_internal_mapping := internal_mapping
			if l_internal_mapping = Void then
				create l_internal_mapping.make_equal (1)
				internal_mapping := l_internal_mapping
			end
			l_internal_mapping.force (a_new_name.as_upper, a_old_name.as_upper)
			cached_mapping := Void
		end

	set_mapping (a_mapping: like internal_mapping)
			-- Set `internal_mapping' to `a_mapping'.
		do
			internal_mapping := a_mapping
			cached_mapping := Void
		ensure
			internal_mapping_set: internal_mapping = a_mapping
		end

feature {CONF_ACCESS} -- Update, not stored in configuration file

	wipe_class_cache
			-- Wipe out the class cache.
		do
			class_by_name_cache.wipe_out
			name_by_class_cache.wipe_out
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal (dependencies, other.dependencies) and then
						file_rule.is_equal (other.file_rule) and then equal (visible, other.visible) and then
						is_recursive = other.is_recursive and then is_hidden = other.is_hidden and then
						equal (mapping, other.mapping)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_cluster (Current)
		end

feature {CONF_ACCESS} -- Implementation, attributes stored in configuration file

	internal_dependencies: detachable like dependencies
			-- Dependencies to other groups of this cluster itself.

	internal_file_rule: like file_rule
			-- Rules for files to be included or excluded of this cluster itself.

	internal_mapping: detachable like mapping
			-- Special classes name mapping (eg. STRING => STRING_32) of this cluster itself.

feature {NONE} -- Cached informations

	class_by_name_cache: STRING_TABLE [like class_by_name]
			-- Cached version of `class_by_name' lookup.
	name_by_class_cache: HASH_TABLE [like name_by_class, CONF_CLASS]
			-- Cached version of `name_by_class' lookup.
	cached_mapping: like internal_mapping
			-- Special classes name mapping cache, has the fully merge version of the mapping.

invariant
	internal_file_rule_not_void: internal_file_rule /= Void
	parent_child_relationship: attached parent as p implies (attached p.children as p_children and then p_children.has (Current))

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
