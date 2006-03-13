indexing
	description: "A project cluster."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CLUSTER

inherit
	CONF_GROUP
		redefine
			make,
			options,
			is_group_equivalent,
			process,
			class_by_name,
			is_cluster
		end

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

feature -- Access, in compiled only, not stored to configuration file

	application_target: CONF_TARGET
			-- The application target.

feature -- Access queries

	is_used_library: BOOLEAN is
			-- Is this this cluster used in a library? (as opposed to directly in the application system)
		do
			Result := application_target /= target
		end

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
			Result := internal_file_rule.twin
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
			l_libs: HASH_TABLE [CONF_LIBRARY, STRING]
			l_lib: CONF_LIBRARY
			l_uuid: UUID
			l_options: CONF_OPTION
		do
				-- if used as library, get options from application level
				-- either if the library is defined there or otherwise directly from the application target
			if is_used_library then
				l_uuid := target.system.uuid
				if application_target.precompile /= Void and then application_target.precompile.uuid.is_equal (l_uuid) then
					l_options := application_target.precompile.options
				else
					from
						l_libs := application_target.libraries
						l_libs.start
					until
						l_options /= Void or l_libs.after
					loop
						l_lib := l_libs.item_for_iteration
						if l_lib.uuid.is_equal (l_uuid) then
							l_options := l_lib.options
						end
						l_libs.forth
					end
				end
				if l_options /= Void then
					Result := l_options
				else
					Result := application_target.options
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

	is_visible (a_feature, a_class: STRING): BOOLEAN is
			-- Is `a_feature' of `a_class' visible?
		require
			a_feature_ok: a_feature /= Void and then not a_feature.is_empty
			a_feature_lower: a_feature.is_equal (a_feature.as_lower)
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
		local
			l_tbl: HASH_TABLE [STRING, STRING]
		do
			if visible /= Void then
				l_tbl ?= visible.item (a_class).item (2)
				Result := l_tbl.has ("*") or l_tbl.has (a_feature)
			end
		end

	renamed_visible (a_feature, a_class: STRING): STRING is
			-- If `a_feature' of `a_class' is visible, return the (possible renamed) name of the feature?
		require
			a_feature_ok: a_feature /= Void and then not a_feature.is_empty
			a_feature_lower: a_feature.is_equal (a_feature.as_lower)
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
		local
			l_tbl: HASH_TABLE [STRING, STRING]
		do
			if visible /= Void then
				l_tbl ?= visible.item (a_class).item (2)
				Result := l_tbl.item (a_feature)
				if Result = Void and then l_tbl.has ("*") or l_tbl.has (a_feature) then
					Result := a_feature
				end
			end
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): ARRAYED_LIST [CONF_CLASS] is
			-- Get the class with the final (after renaming/prefix) name `a_class'.
			-- Either if it is defined in this cluster or if `a_dependencies' in a dependency.
		local
			l_groups: LINKED_SET [CONF_GROUP]
			l_class: CONF_CLASS
		do
			create Result.make (1)
			l_class := classes.item (a_class)
			if l_class /= Void then
				Result.extend (l_class)
			end

			if a_dependencies then
				if dependencies = Void then
					create l_groups.make
					l_groups.merge (target.assemblies)
					l_groups.merge (target.libraries)
					l_groups.merge (target.clusters)
					l_groups.merge (target.overrides)
					if target.precompile /= Void then
						l_groups.extend (target.precompile)
					end
					l_groups.search (Current)
					l_groups.remove
				else
					l_groups := dependencies
				end
				if l_groups /= Void then
					from
						l_groups.start
					until
						l_groups.after
					loop
						Result.append (l_groups.item.class_by_name (a_class, False))
						l_groups.forth
					end
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

	set_visible (a_visible: like visible) is
			-- Set `a_visible'.
		do
			visible := a_visible
		ensure
			visible_set: visible = a_visible
		end

	add_visible (a_class, a_feature, a_class_rename, a_feature_rename: STRING) is
			-- Add a visible.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_upper: a_class.is_equal (a_class.as_upper)
			a_feature_ok: a_feature /= Void and then not a_feature.is_empty
		local
			l_v_cl: HASH_TABLE [STRING, STRING]
			l_tpl: TUPLE [STRING, HASH_TABLE [STRING, STRING]]
			l_visible_name: STRING
		do
			if visible = Void then
				create visible.make (1)
			end
			if a_class_rename /= Void then
				l_visible_name := a_class_rename.as_upper
			else
				l_visible_name := a_class
			end
			l_tpl := visible.item (a_class)
			if l_tpl = Void then
				create l_tpl
				create l_v_cl.make (1)
				l_tpl.put (l_visible_name, 1)
				l_tpl.put (l_v_cl, 2)
			end
			a_feature.to_lower
			l_v_cl.force (a_feature_rename, a_feature)
			visible.force (l_tpl, a_class)
		end


feature {CONF_ACCESS} -- Update, in compiled only, not stored to configuration file

	set_application_target (a_target: CONF_TARGET) is
			-- Set `application_target' to `a_target'.
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
			Result := Precursor (other) and then equal (dependencies, other.dependencies) and then
						file_rule.is_equal (other.file_rule)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_cluster (Current)
		end

feature {CONF_VISITOR, CONF_CLASS} -- Implementation, attributes stored in configuration file

	internal_dependencies: LINKED_SET [CONF_GROUP]
			-- Dependencies to other groups of this cluster itself.

	internal_file_rule: CONF_FILE_RULE
			-- Rules for files to be included or excluded of this cluster itself.

	visible: HASH_TABLE [TUPLE [STRING, HASH_TABLE [STRING, STRING]], STRING]
			-- Table of table of features of classes that are visible (feature name "*" = all features visible).
			-- Mapped to their rename (if any).

invariant
	internal_file_rule_not_void: internal_file_rule /= Void

end
