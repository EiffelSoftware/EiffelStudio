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

	parent: CONF_CLUSTER
			-- An optional parent cluster.

	children: ARRAYED_LIST [like Current]
			-- Optionally multiple children.

feature -- Access queries

	dependencies: DS_HASH_SET [CONF_GROUP]
			-- Dependencies to other groups.
			-- Empty = No dependencies
			-- Void = Depend on all
		do
			if parent /= Void and then parent.dependencies /= Void then
				Result := parent.dependencies.twin
			end

			if internal_dependencies /= Void then
				if Result /= Void then
					Result.merge (internal_dependencies)
				else
					Result := internal_dependencies
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

	file_rule: like internal_file_rule
			-- Rules for files to be included or excluded.
		do
			Result := internal_file_rule.twin
			if parent /= Void then
				Result.append (parent.file_rule)
			end
			Result.append (target.file_rule)
		ensure
			Result_not_void: Result /= Void
		end

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		local
			l_lib: CONF_LIBRARY
			l_local: CONF_OPTION
		do
				-- get local options
			if internal_options /= Void then
				l_local := internal_options.twin
			else
				create l_local
			end
			if parent /= Void then
				l_local.merge (parent.options)
			else
				l_local.merge (target.options)
			end

				-- if used as library, get options from application level if the library is defined there
			if is_used_in_library then
				l_lib := target.system.application_target_library
				if l_lib /= Void then
					Result := l_lib.options
				end
			end

			if Result /= Void then
				Result.merge (l_local)

					-- Need to set local namespace, because local namespaces cannot be merged for libraries
				Result.set_local_namespace (l_local.local_namespace)
			else
				Result := l_local
			end
		end

	class_options: like internal_class_options
			-- Options for classes.
		local
			l_lib: CONF_LIBRARY
			l_class_options: like class_options
		do
				-- get local options
			if parent /= Void then
				l_class_options :=  parent.class_options
				if l_class_options /= Void then
					Result := l_class_options.twin
				end
			end
			if internal_class_options /= Void then
				if Result /= Void then
					Result.merge (internal_class_options)
				else
					Result := internal_class_options.twin
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

	mapping: like internal_mapping
			-- Special classes name mapping (eg. STRING => STRING_32).
		do
			if cached_mapping = Void then
				if internal_mapping = Void and parent = Void then
					cached_mapping := target.mapping
				else
					cached_mapping := target.mapping.twin
					if parent /= Void then
						cached_mapping.merge (parent.mapping)
					end
					if internal_mapping /= Void then
						cached_mapping.merge (internal_mapping)
					end
				end
			end
			Result := cached_mapping
		ensure then
			Result_cached: Result = cached_mapping
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS]
			-- Get the class with the final (after renaming/prefix) name `a_class'.
			-- Either if it is defined in this cluster or if `a_dependencies' in a dependency.
		local
			l_groups: like accessible_groups
			l_class: CONF_CLASS
			l_grp: CONF_GROUP
			l_name: STRING
			l_cursor: DS_HASH_SET_CURSOR [CONF_GROUP]
		do
				-- apply mapping
			if mapping.has_key (a_class) then
				l_name := mapping.found_item
			else
				l_name := a_class
			end

			if a_dependencies and then class_by_name_cache.has_key (l_name) then
				Result := class_by_name_cache.found_item
			else
					-- search in cluster itself
				create Result.make
				l_class := classes.item (l_name)
				if l_class /= Void and then not l_class.does_override then
					Result.extend (l_class)
				end

					-- search in dependencies
				if a_dependencies then
					l_groups := accessible_groups
					l_cursor := l_groups.new_cursor
					from
						l_cursor.start
					until
						l_cursor.after
					loop
						l_grp := l_cursor.item
						if l_grp.classes_set then
							Result.append (l_grp.class_by_name (l_name, False))
						end
						l_cursor.forth
					end

					class_by_name_cache.force (Result, l_name)
				end
			end
		end

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [STRING]
			-- Get name in this context of `a_class' (if `a_dependencies') then we check dependencies).
		local
			l_groups: like accessible_groups
			l_grp: CONF_GROUP
		do
			if a_dependencies and then name_by_class_cache.has_key (a_class) then
				Result := name_by_class_cache.found_item
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

	accessible_groups: DS_HASH_SET [CONF_GROUP]
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else everything except `Current'.
		local
			l_grps: HASH_TABLE [CONF_GROUP, STRING]
		do
			if accessible_groups_cache = Void then
				if dependencies = Void then
					l_grps := target.clusters
					create accessible_groups_cache.make (l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						accessible_groups.force (l_grps.item_for_iteration)
						l_grps.forth
					end
					l_grps := target.libraries
					accessible_groups.resize (accessible_groups.count+l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						accessible_groups.force (l_grps.item_for_iteration)
						l_grps.forth
					end
					l_grps := target.assemblies
					accessible_groups.resize (accessible_groups.count+l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						accessible_groups.force (l_grps.item_for_iteration)
						l_grps.forth
					end
					l_grps := target.overrides
					accessible_groups.resize (accessible_groups.count+l_grps.count)
					from
						l_grps.start
					until
						l_grps.after
					loop
						accessible_groups.force (l_grps.item_for_iteration)
						l_grps.forth
					end

					if target.precompile /= Void then
						accessible_groups_cache.force (target.precompile)
					end
					accessible_groups_cache.remove (Current)
				else
					accessible_groups_cache := dependencies
				end
			end
			Result := accessible_groups_cache
		end

	sub_group_by_name (a_name: STRING): CONF_GROUP
			-- Return sub cluster with `a_name' if there is any.
		do
			if children /= Void then
				from
					children.start
				until
					Result /= Void or children.after
				loop
					if children.item.name.is_equal (a_name) then
						Result := children.item
					end
					children.forth
				end
			end
		end

	is_readonly: BOOLEAN
			-- Is this group read only?
		local
			l_lib: CONF_LIBRARY
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
		do
			if children = Void then
				create children.make (1)
			end
			children.force (a_cluster)
		ensure
			child_added: children.has (a_cluster)
		end

	remove_child (a_cluster: like Current)
			-- Remove `a_cluster' from `children'.
		do
			if children /= Void then
				children.start
				children.search (a_cluster)
				if not children.exhausted then
					children.remove
				end
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
		do
			if internal_dependencies = Void then
				create internal_dependencies.make_default
			end
			internal_dependencies.force (a_group)
		ensure
			added: internal_dependencies.has (a_group)
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

	add_mapping (a_old_name, a_new_name: STRING)
			-- Add a new mapping from `a_old_name' to `a_new_name'.
		require
			a_old_name_ok: a_old_name /= Void and then not a_old_name.is_empty
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
		do
			if internal_mapping = Void then
				create internal_mapping.make (1)
			end
			internal_mapping.force (a_new_name.as_upper, a_old_name.as_upper)
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

	set_mapping_32 (a_mapping_32: like mapping_32)
			-- Set `mapping' to `a_mapping_32'.
		do
			if a_mapping_32 = Void then
				internal_mapping := Void
			else
				create internal_mapping.make (a_mapping_32.count)
				from
					a_mapping_32.start
				until
					a_mapping_32.after
				loop
					internal_mapping.extend (a_mapping_32.item_for_iteration, a_mapping_32.key_for_iteration)
					a_mapping_32.forth
				end
			end
			cached_mapping := Void
		end

feature {CONF_ACCESS} -- Update, not stored in configuration file

	wipe_class_cache
			-- Wipe out the class cache.
		do
			class_by_name_cache.clear_all
			name_by_class_cache.clear_all
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

	internal_dependencies: DS_HASH_SET [CONF_GROUP]
			-- Dependencies to other groups of this cluster itself.

	internal_file_rule: ARRAYED_LIST [CONF_FILE_RULE]
			-- Rules for files to be included or excluded of this cluster itself.

	internal_mapping: EQUALITY_HASH_TABLE [STRING, STRING]
			-- Special classes name mapping (eg. STRING => STRING_32) of this cluster itself.

feature {NONE} -- Cached informations

	class_by_name_cache: HASH_TABLE [like class_by_name, STRING]
			-- Cached version of `class_by_name' lookup.
	name_by_class_cache: HASH_TABLE [like name_by_class, CONF_CLASS]
			-- Cached version of `name_by_class' lookup.
	cached_mapping: like internal_mapping
			-- Special classes name mapping cache, has the fully merge version of the mapping.

invariant
	internal_file_rule_not_void: internal_file_rule /= Void
	parent_child_relationship: parent /= Void implies parent.children /= Void and then parent.children.has (Current)

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
