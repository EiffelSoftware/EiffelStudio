indexing
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
			is_cluster,
			is_readonly,
			accessible_groups,
			accessible_classes
		end

	CONF_VISIBLE

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create
		do
			Precursor (a_name, a_location, a_target)
			create internal_file_rule.make
		end

feature -- Status

	is_cluster: BOOLEAN is
			-- Is this a cluster?
		once
			Result := True
		end


feature -- Access, stored in configuration file

	is_recursive: BOOLEAN
			-- Are subdirectories included recursively?

	parent: CONF_CLUSTER
			-- An optional parent cluster.

	children: ARRAYED_LIST [CONF_CLUSTER]
			-- Optionally multiple children.

feature -- Access queries

	dependencies: LINKED_SET [CONF_GROUP] is
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

	file_rule: CONF_FILE_RULE is
			-- Rules for files to be included or excluded.
		do
			create Result.make
			Result.merge (internal_file_rule)
			if parent /= Void then
				Result.merge (parent.file_rule)
			end
			Result.merge (target.file_rule)
		ensure
			Result_not_void: Result /= Void
		end

	options: CONF_OPTION is
			-- Options (Debuglevel, assertions, ...)
		local
			l_lib: CONF_LIBRARY
		do
				-- if used as library, get options from application level
				-- either if the library is defined there or otherwise directly from the application target
			if is_used_library then
				l_lib := find_parent_library_in_application_target
				if l_lib /= Void then
					Result := l_lib.options
				else
					Result := target.application_target.options
				end
			else
				if internal_options /= Void then
					Result := internal_options.twin
				else
					create Result
				end
				if parent /= Void then
					Result.merge (parent.options)
				end
				Result.merge (target.options)
			end
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): LINKED_SET [CONF_CLASS] is
			-- Get the class with the final (after renaming/prefix) name `a_class'.
			-- Either if it is defined in this cluster or if `a_dependencies' in a dependency.
		local
			l_groups: LINKED_SET [CONF_GROUP]
			l_class: CONF_CLASS
			l_grp: CONF_GROUP
		do
			create Result.make
			l_class := classes.item (a_class)
			if l_class /= Void then
				Result.extend (l_class)
			end

			if a_dependencies then
				l_groups := accessible_groups
				if l_groups /= Void then
					from
						l_groups.start
					until
						l_groups.after
					loop
						l_grp := l_groups.item
						if l_grp.classes_set then
							Result.append (l_grp.class_by_name (a_class, False))
						end
						l_groups.forth
					end
				end
			end
		end

	accessible_groups: LINKED_SET [CONF_GROUP] is
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else everything except `Current'.
		do
			if dependencies = Void then
				create Result.make
				Result.merge (target.assemblies)
				Result.merge (target.libraries)
				Result.merge (target.clusters)
				Result.merge (target.overrides)
				if target.precompile /= Void then
					Result.extend (target.precompile)
				end
				Result.search (Current)
				Result.remove
			else
				Result := dependencies
			end
		end

	accessible_classes: like classes is
			-- Classes that are accessible within `Current'.
		local
			l_groups: LINKED_SET [CONF_GROUP]
			l_grp: CONF_GROUP
		do
			Result :=  Precursor
			l_groups := accessible_groups
			if l_groups /= Void then
				from
					l_groups.start
				until
					l_groups.after
				loop
					l_grp := l_groups.item
					Result.merge (l_grp.classes)
					l_groups.forth
				end
			end
		end

	sub_group_by_name (a_name: STRING): CONF_GROUP is
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

	is_readonly: BOOLEAN is
			-- Is this group read only?
		local
			l_lib: CONF_LIBRARY
		do
			Result := internal_read_only
			if not Result and then is_used_library then
				-- if used as library and the library defined in the application target itself, take value from there
				-- else it is read only.
				l_lib := find_parent_library_in_application_target
				if l_lib /= Void then
					Result := l_lib.is_readonly
				else
					Result := True
				end
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_parent (a_cluster: like parent) is
			-- Set `parent' to `a_cluster'.
		do
			parent := a_cluster
		ensure
			parent_set: parent = a_cluster
		end

	add_child (a_cluster: like Current) is
			-- Add `a_cluster' to `children'.
		do
			if children = Void then
				create children.make (1)
			end
			children.force (a_cluster)
		ensure
			child_added: children.has (a_cluster)
		end

	enable_recursive is
			-- Set `is_recursive' to true.
		do
			is_recursive := True
		ensure
			is_recursive: is_recursive
		end

	disable_recursive is
			-- Set `is_recursive' to false.
		do
			is_recursive := False
		ensure
			not_is_recursive: not is_recursive
		end

	set_dependencies (a_dependencies: like internal_dependencies) is
			-- Set `a_dependencies'.
		require
			a_dependencies_not_void: a_dependencies /= Void
		do
			internal_dependencies := a_dependencies
		ensure
			dependencies_set: internal_dependencies = a_dependencies
		end

	add_dependency (a_group: CONF_GROUP) is
			-- Add a dependency.
		require
			a_group_not_void: a_group /= Void
		do
			if internal_dependencies = Void then
				create internal_dependencies.make
			end
			internal_dependencies.extend (a_group)
		ensure
			added: internal_dependencies.has (a_group)
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

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal (dependencies, other.dependencies) and then
						file_rule.is_equal (other.file_rule) and then equal (visible, other.visible) and then
						is_recursive = other.is_recursive
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_cluster (Current)
		end

feature {CONF_ACCESS} -- Implementation, attributes stored in configuration file

	internal_dependencies: LINKED_SET [CONF_GROUP]
			-- Dependencies to other groups of this cluster itself.

	internal_file_rule: CONF_FILE_RULE
			-- Rules for files to be included or excluded of this cluster itself.

feature {NONE} -- Implementation

	find_parent_library_in_application_target: CONF_LIBRARY is
			-- Find system as a library in `application_target' if it is defined there directly.
		require
			application_target_not_void: target.application_target /= Void
		local
			l_libs: HASH_TABLE [CONF_LIBRARY, STRING]
			l_lib: CONF_LIBRARY
			l_uuid: UUID
			l_app_target: CONF_TARGET
		do
			l_uuid := target.system.uuid
			l_app_target := target.application_target
			if l_app_target.precompile /= Void and then l_app_target.precompile.uuid.is_equal (l_uuid) then
				Result := l_app_target.precompile
			else
				from
					l_libs := l_app_target.libraries
					l_libs.start
				until
					Result /= Void or l_libs.after
				loop
					l_lib := l_libs.item_for_iteration
					if l_lib.uuid /= Void and then l_lib.uuid.is_equal (l_uuid) then
						Result := l_lib
					end
					l_libs.forth
				end
			end
		end

invariant
	internal_file_rule_not_void: internal_file_rule /= Void
	parent_child_relationship: parent /= Void implies parent.children /= Void and then parent.children.has (Current)
	classes_by_filename_ok: classes_set implies classes_by_filename /= Void and then classes.count = classes_by_filename.count

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
