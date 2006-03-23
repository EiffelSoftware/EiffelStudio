indexing
	description: "Internal representation of the Eiffel universe."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UNIVERSE_I

inherit
	SHARED_ERROR_HANDLER
		export
			{COMPILER_EXPORTER} all
		redefine
			copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{COMPILER_EXPORTER} all
		redefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		redefine
			copy, is_equal
		end

	PROJECT_CONTEXT
		redefine
			copy, is_equal
		end

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make is
			-- Create the hash table.
		do
			create clusters.make (25)
			assemblies_to_be_added := Void
			override_cluster_names := Void
		ensure
			clusters_not_void: clusters /= Void
			assemblies_to_be_added_reset: assemblies_to_be_added = Void
		end

feature -- Properties

	clusters: ARRAYED_LIST [CLUSTER_I]
			-- Clusters of the universe

	assemblies_to_be_added: ARRAYED_LIST [ASSEMBLY_I]
			-- List of assemblies that needs to be added in Ace file
			-- before next compilation.

	clusters_sorted_by_tag: ARRAYED_LIST [CLUSTER_I] is
			-- Clusters sorted by their tags
		local
			loc_clusters: like clusters
		do
			loc_clusters := clusters
			create Result.make (loc_clusters.count)
			if not loc_clusters.is_empty then
				Result.force (loc_clusters.first)
				from
					loc_clusters.start
					loc_clusters.forth
				until
					loc_clusters.after
				loop
					from
						Result.start
					until
						Result.after or else
						loc_clusters.item.cluster_name < Result.item.cluster_name
					loop
						Result.forth
					end
					Result.put_left (loc_clusters.item)
					loc_clusters.forth
				end
			end
		end

	last_class: CLASS_I
			-- Last class subject to a query

	override_cluster_names: SEARCH_TABLE [STRING]
			-- List of all override clusters in system.

feature -- Access

	class_with_file_name (f_name: FILE_NAME): CLASS_I is
			-- Class with name `f_name' found in the Universe
		local
			cur: CURSOR
			classes: HASH_TABLE [CLASS_I, STRING]
			fn: FILE_NAME
		do
			cur := clusters.cursor
			from
				clusters.start
			until
				clusters.after or else Result /= Void
			loop
				classes := clusters.item.classes
				from
					classes.start
				until
					classes.after or else Result /= Void
				loop
					create fn.make_from_string (classes.item_for_iteration.file_name)
					if f_name.is_equal (fn) then
						Result := classes.item_for_iteration
					end
					classes.forth
				end
				clusters.forth
			end
			clusters.go_to (cur)
		end

	classes_with_name (class_name: STRING): LIST [CLASS_I] is
			-- Classes with name `class_name' found in the Universe
		require
			class_name_not_void: class_name /= Void
			class_name_is_in_upper_case: class_name.as_upper.is_equal (class_name)
		local
			cur: CURSOR
			classes: HASH_TABLE [CLASS_I, STRING]
			l_class_name: STRING
		do
				-- FIXME: Manu 03/06/2004: When we are 100% sure that all callers
				-- of `classes_with_name' satisfy the precondition, we will be able to remove
				-- this line:
			l_class_name := class_name.as_upper

			create {ARRAYED_LIST [CLASS_I]} Result.make (2)
			buffered_classes.search (l_class_name)
			if not buffered_classes.found then
				cur := clusters.cursor
				from
					clusters.start
				until
					clusters.after
				loop
					classes := clusters.item.classes
					if classes.has (l_class_name) then
						Result.extend (classes.found_item)
						Result.forth
					end
					clusters.forth
				end
				clusters.go_to (cur)
				if Result.count = 1 then
					buffered_classes.put (Result.first, l_class_name)
				end
			else
				Result.extend (buffered_classes.found_item)
			end
		ensure
			classes_with_name_not_void: Result /= Void
		end

	overriden_classes_with_name (class_name: STRING): LIST [CLASS_I] is
			-- Classes with name `class_name' found in the Universe of classes
			-- which have been overriden.
		require
			class_name_not_void: class_name /= Void
			class_name_is_in_upper_case: class_name.as_upper.is_equal (class_name)
		local
			cur: CURSOR
			classes: HASH_TABLE [CLASS_I, STRING]
		do
			create {ARRAYED_LIST [CLASS_I]} Result.make (2)
			cur := clusters.cursor
			from
				clusters.start
			until
				clusters.after
			loop
				classes := clusters.item.overriden_classes
				if classes.has (class_name) then
					Result.extend (classes.found_item)
					Result.forth
				end
				clusters.forth
			end
			clusters.go_to (cur)
		ensure
			classes_with_name_not_void: Result /= Void
		end

	compiled_classes_with_name (class_name: STRING): LIST [CLASS_I] is
			-- Compiled classes with name `class_name' found in the Universe
		require
			class_name_not_void: class_name /= Void
			class_name_is_in_upper_case: class_name.as_upper.is_equal (class_name)
		do
			Result := classes_with_name (class_name)
			from
				Result.start
			until
				Result.after
			loop
				if Result.item.is_compiled then
					Result.forth
				else
					Result.remove
				end
			end
		end

	class_named (class_name: STRING; a_cluster: CLUSTER_I): CLASS_I is
			-- Class named `class_name' in cluster `a_cluster'
		require
			good_argument: class_name /= Void
			good_cluster: a_cluster /= Void
			class_name_is_in_upper_case: class_name.as_upper.is_equal (class_name)
		local
			l_cluster: CLUSTER_I
			real_name: STRING
			rename_clause: RENAME_I
			renamings: HASH_TABLE [STRING, STRING]
			old_cursor: CURSOR
			l_ignore: LINKED_LIST [CLUSTER_I]
			l_class_name: STRING
		do
				-- FIXME: Manu 03/06/2004: When we are 100% sure that all callers
				-- of `class_named' satisfy the precondition, we will be able to remove
				-- this line:
			l_class_name := class_name.as_upper

			l_ignore := a_cluster.ignore
				-- First look for a renamed class in `a_cluster'
			Result := a_cluster.renamed_class (l_class_name)

			if Result = Void then
				from
					old_cursor := clusters.cursor
					clusters.start
				until
					clusters.after or else Result /= Void
				loop
					l_cluster := clusters.item
					if l_ignore = Void or else not l_ignore.has (l_cluster) then
						real_name := l_class_name
						rename_clause := a_cluster.rename_clause_for (l_cluster)
						if rename_clause /= Void then
								-- Evaluation of the real name of the class
							renamings := rename_clause.renamings
							if renamings.has (l_class_name) then
								real_name := renamings.found_item
							elseif renamings.has_item (l_class_name) then
								real_name := Has_been_renamed
							end
						end
						Result := l_cluster.classes.item (real_name)
					end
					clusters.forth
				end
				clusters.go_to (old_cursor)
			end
		end

	class_from_assembly (an_assembly, a_dotnet_name: STRING; lower_case_comparison: BOOLEAN): CLASS_I is
			-- Associated CLASS_I instance for `a_dotnet_name' external class name
			-- from given assembly `an_assembly'. If more than one assembly with
			-- `an_assembly' as name, look only in first found item.
			--| An example of usage would be:
			--|	 l_class := universe.class_from_assembly ("mscorlib", "System.IComparable", False)
			--| to get the associated `System.IComparable' from `mscorlib'.
			--|
			--| Nota: if `lower_case_comparison' is True, compare assembly names in lower case
		require
			an_assembly_not_void: an_assembly /= Void
			an_assembly_not_empty: not an_assembly.is_empty
			a_dotnet_name_not_void: a_dotnet_name /= Void
			a_dotnet_name_not_empty: not a_dotnet_name.is_empty
		local
			l_an: STRING
			l_assembly_name: STRING
			l_assembly: ASSEMBLY_I
			l_found: BOOLEAN
		do
				-- Iterate through to find proper assembly.
			if lower_case_comparison then
				l_an := an_assembly.as_lower
			else
				l_an := an_assembly
			end
			from
				clusters.start
			until
				clusters.after or l_found
			loop
				l_assembly ?= clusters.item
				if l_assembly /= Void then
					l_assembly_name := l_assembly.assembly_name
					if lower_case_comparison then
						l_assembly_name := l_assembly_name.as_lower
					end
					l_found := equal (l_an, l_assembly_name)
				end
				clusters.forth
			end

			check
				l_found_implies_found: l_found implies l_assembly /= Void
			end

			if l_found then
				l_assembly.dotnet_classes.search (a_dotnet_name)
				if l_assembly.dotnet_classes.found then
					Result := l_assembly.dotnet_classes.found_item
				end
			end
		end

	cluster_changed: BOOLEAN is
			-- Has the time stamps of the present clusters changed ?
		local
			l_cluster: CLUSTER_I
			new_date: INTEGER
			ptr: ANY
		do
			from
				clusters.start
			until
				clusters.after or else Result
			loop
				l_cluster := clusters.item
				ptr := l_cluster.path.to_c
				new_date := eif_date ($ptr)
				Result := l_cluster.date /= new_date
				clusters.forth
			end
		end

	cluster_of_name (cluster_name: STRING): CLUSTER_I is
			-- Cluster whose name is `cluster_name' (Void if none)
		require
			good_argument: cluster_name /= Void
		local
			cluster_list: like clusters
		do
			from
				cluster_list := clusters
				cluster_list.start
			until
				cluster_list.after or else
				cluster_name.is_equal (cluster_list.item.cluster_name)
			loop
				cluster_list.forth
			end
			if not cluster_list.after then
				Result := cluster_list.item
			end
		end

	has_cluster_of_name (cluster_name: STRING): BOOLEAN is
			-- Does `clusters' have a cluster whose name is `cluster_name' ?
		require
			good_argument: cluster_name /= Void
		do
			Result := cluster_of_name (cluster_name) /= Void
		end

	cluster_of_path (cluster_path: STRING): CLUSTER_I is
			-- Cluster whose path is `cluster_path' (Void if none)
		require
			good_argument: cluster_path /= Void
		local
			cluster_list: like clusters
		do
			from
				cluster_list := clusters
				cluster_list.start
			until
				cluster_list.after or else
				cluster_list.item.path.is_equal (cluster_path)
			loop
				cluster_list.forth
			end
			if not cluster_list.after then
				Result := cluster_list.item
			end
		end

	assembly_of_specification (a_name, a_culture, a_key, a_version: STRING): ASSEMBLY_I is
			-- Find an assembly matching `a_name', `a_culture', `a_key' and `a_version'.
		require
			a_name_not_void: a_name /= Void
		local
			l_key: like a_key
			l_culture: like a_culture
			l_result_key: like a_key
			l_done: BOOLEAN
			l_list: like clusters
		do
			if equal (a_key, "null") then
				l_key := Void
			else
				l_key := a_key.as_lower
			end
			l_culture := a_culture.as_lower

			from
				l_list := clusters
				l_list.start
			until
				l_list.after or l_done
			loop
				Result ?= l_list.item
				if Result /= Void then
					if Result.public_key_token /= Void then
						l_result_key := Result.public_key_token.as_lower
					else
						l_result_key := Void
					end
					l_done := Result.assembly_name.is_equal (a_name) and
							equal (Result.culture.as_lower, l_culture) and
							equal (l_result_key, l_key) and
							equal (Result.version, a_version)
				end
				l_list.forth
			end
			if not l_done then
				Result := Void
			end
		end

	has_cluster_of_path (cluster_path: STRING): BOOLEAN is
			-- Does `clusters' have a cluster whose path is `cluster_path' ?
		require
			good_argument: cluster_path /= Void
		do
			Result := cluster_of_path (cluster_path) /= Void
		end

	has_override_cluster: BOOLEAN is
			-- Is there a cluster with the override flag on?
		do
			Result := override_cluster_names /= Void and then
				not override_cluster_names.is_empty
		ensure
			override_cluster_names_status: Result implies override_cluster_names /= Void
		end

	has_override_cluster_of_name (a_name: STRING): BOOLEAN is
			-- Is there a cluster of name `a_name' with the override flag on?
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			Result := override_cluster_names /= Void and then
				override_cluster_names.has (a_name)
		ensure
			override_cluster_names_status: Result implies override_cluster_names /= Void
		end

	override_clusters: ARRAYED_LIST [CLUSTER_I] is
			-- Override cluster in the universe.
		require
			has_override_cluster: has_override_cluster
		local
			c: CURSOR
			l_cluster: CLUSTER_I
		do
				-- Saving position
			c := clusters.cursor

			from
				create Result.make (override_cluster_names.count)
				override_cluster_names.start
			until
				override_cluster_names.after
			loop
				l_cluster := cluster_of_name (override_cluster_names.item_for_iteration)
				if l_cluster /= Void then
					Result.extend (l_cluster)
				end
				override_cluster_names.forth
			end

			clusters.go_to (c)
		ensure
			override_cluster_not_void: Result /= Void and then not Result.is_empty
		end

feature -- Update

	reset_assemblies_to_be_added is
			-- Reset `assemblies_to_be_added'.
		do
			assemblies_to_be_added := Void
		ensure
			assemblies_to_be_added_reset: assemblies_to_be_added = Void
		end

	reset_override_clusters is
			-- Reset `override_cluster_names'.
		do
			override_cluster_names := Void
		ensure
			override_cluster_names_reset: override_cluster_names = Void
		end

	add_new_assembly_in_ace (an_assembly: ASSEMBLY_I) is
			-- Add `an_assembly' in list of assemblies that are not originally in Ace
			-- but needs to.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			if assemblies_to_be_added = Void then
				create assemblies_to_be_added.make (10)
			end
			assemblies_to_be_added.extend (an_assembly)
		end

	update_cluster_paths is
			-- Update the paths of the clusters in the universe.
			-- (Re-interpret environment variables)
			-- FIXME shouldn't be exported to all
		do
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.update_path
				clusters.forth
			end
		end

	reset_internals is
			-- Should be called when a new compilation starts.
		do
			buffered_classes.wipe_out
		end

feature {COMPILER_EXPORTER} -- Implementation

	buffered_classes: HASH_TABLE [CLASS_I, STRING] is
			-- Hash table that contains recent results of calls to `classes_with_name'.
		once
			create Result.make (200)
		end

	set_clusters (l: like clusters) is
			-- Assign `l' to `clusters'.
		do
			clusters := l
		end

	set_last_class (c: CLASS_I) is
			-- Assign `c' to `last_class'.
		do
			last_class := c
		end

	add_override_cluster_name (cluster_name: STRING) is
			-- Extend `override_cluster_names' with `cluster_name'.
		require
			cluster_name_not_void: cluster_name /= Void
			cluster_name_not_empty: not cluster_name.is_empty
		do
			if override_cluster_names = Void then
				create override_cluster_names.make (5)
			end
			override_cluster_names.force (cluster_name)
		end

	insert_cluster (c: CLUSTER_I) is
			-- Insert `c' in `clusters'.
		require
			good_argument: c /= Void
			consistency: not has_cluster_of_path (c.path)
		do
			clusters.extend (c)
			clusters.finish
		end

	copy (other: like Current) is
			-- Clone universe
		do
			from
				make
				override_cluster_names := other.override_cluster_names
				if override_cluster_names /= Void then
					override_cluster_names := override_cluster_names.twin
				end
				other.clusters.start
			until
				other.clusters.after
			loop
				insert_cluster (other.clusters.item)
				other.clusters.forth
			end
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := equal (override_cluster_names, other.override_cluster_names)
			from
				clusters.start
				other.clusters.start
			until
				not Result or clusters.after or other.clusters.after
			loop
				Result := Result and clusters.item.is_equal (other.clusters.item)
				clusters.forth
				other.clusters.forth
			end
		end

	check_universe is
			-- Check universe
		require
			system_exists: system /= Void
		local
			l_actions: HASH_TABLE [PROCEDURE [ANY, TUPLE [CLASS_I]], STRING]
		do
			create l_actions.make (50)

			if system.il_generation then
				l_actions.put (agent system.set_system_object_class, "SYSTEM_OBJECT")
				l_actions.put (agent system.set_system_value_type_class, "VALUE_TYPE")
			end

			l_actions.put (agent system.set_any_class, "ANY")
			l_actions.put (agent system.set_boolean_class, "BOOLEAN")
			l_actions.put (agent system.set_character_class (?, False), "CHARACTER")
			l_actions.put (agent system.set_character_class (?, True), "WIDE_CHARACTER")
			l_actions.put (agent system.set_natural_class (?, 8), "NATURAL_8")
			l_actions.put (agent system.set_natural_class (?, 16), "NATURAL_16")
			l_actions.put (agent system.set_natural_class (?, 32), "NATURAL_32")
			l_actions.put (agent system.set_natural_class (?, 64), "NATURAL_64")
			l_actions.put (agent system.set_integer_class (?, 8), "INTEGER_8")
			l_actions.put (agent system.set_integer_class (?, 16), "INTEGER_16")
			l_actions.put (agent system.set_integer_class (?, 32), "INTEGER")
			l_actions.put (agent system.set_integer_class (?, 64), "INTEGER_64")
			l_actions.put (agent system.set_real_32_class, "REAL")
			l_actions.put (agent system.set_real_64_class, "DOUBLE")
			l_actions.put (agent system.set_pointer_class, "POINTER")
			l_actions.put (agent system.set_typed_pointer_class, "TYPED_POINTER")
			l_actions.put (agent system.set_string_class, "STRING")
			l_actions.put (agent system.set_array_class, "ARRAY")
			l_actions.put (agent system.set_special_class, "SPECIAL")
			l_actions.put (agent system.set_tuple_class, "TUPLE")
			l_actions.put (agent system.set_disposable_class, "DISPOSABLE")
			l_actions.put (agent system.set_routine_class, "ROUTINE")
			l_actions.put (agent system.set_procedure_class, "PROCEDURE")
			l_actions.put (agent system.set_function_class, "FUNCTION")
			l_actions.put (agent system.set_type_class, "TYPE")

				-- XX_REF classes
			l_actions.put (agent system.set_bit_class, "BIT_REF")
			l_actions.put (agent system.set_boolean_ref_class, "BOOLEAN_REF")
			l_actions.put (agent system.set_character_ref_class (?, False), "CHARACTER_REF")
			l_actions.put (agent system.set_character_ref_class (?, True), "WIDE_CHARACTER_REF")
			l_actions.put (agent system.set_natural_ref_class (?, 8), "NATURAL_8_REF")
			l_actions.put (agent system.set_natural_ref_class (?, 16), "NATURAL_16_REF")
			l_actions.put (agent system.set_natural_ref_class (?, 32), "NATURAL_32_REF")
			l_actions.put (agent system.set_natural_ref_class (?, 64), "NATURAL_64_REF")
			l_actions.put (agent system.set_integer_ref_class (?, 8), "INTEGER_8_REF")
			l_actions.put (agent system.set_integer_ref_class (?, 16), "INTEGER_16_REF")
			l_actions.put (agent system.set_integer_ref_class (?, 32), "INTEGER_REF")
			l_actions.put (agent system.set_integer_ref_class (?, 64), "INTEGER_64_REF")
			l_actions.put (agent system.set_real_32_ref_class, "REAL_REF")
			l_actions.put (agent system.set_real_64_ref_class, "DOUBLE_REF")
			l_actions.put (agent system.set_pointer_ref_class, "POINTER_REF")

			if system.il_generation then
				l_actions.put (agent system.set_system_string_class, "SYSTEM_STRING")
				l_actions.put (agent system.set_native_array_class, "NATIVE_ARRAY")
				l_actions.put (agent system.set_arguments_class, "ARGUMENTS")
				l_actions.put (agent system.set_system_type_class, "SYSTEM_TYPE")
			end

			check_class_unicity (l_actions)

			if system.il_generation then
					-- One more check, let's find out that `system_object' and `system_string'
					-- are set with EXTERNAL_CLASS_I instances

					-- We test against Void as `system_object_class' is declared as
					-- EXTERNAL_CLASS_I.
				if system.system_object_class = Void then
						-- Report error here
						-- FIXME: Manu: 06/03/2003
				end

					-- Check it is an EXTERNAL_CLASS_I instance.
				if
					system.system_string_class = Void or else
					not system.system_string_class.is_external_class
				then
						-- Report error here
						-- FIXME: Manu: 06/03/2003
				end
			end

				-- Check sum error
			Error_handler.checksum
		end

	reset_clusters is
			-- Reset all the clusters
		local
			l_cluster: CLUSTER_I
		do
			from
				clusters.start
			until
				clusters.after
			loop
				l_cluster := clusters.item
				if not l_cluster.is_precompiled then
					l_cluster.reset_cluster
				end
				clusters.forth
			end
		end

	check_class_unicity (a_set: HASH_TABLE [PROCEDURE [ANY, TUPLE [CLASS_I]], STRING]) is
			-- Universe checking, check all class names in `a_set' to ensure that only
			-- one instance with specified name is found in universe. If it is unique,
			-- then for each unique instance calls associated action.
		require
			a_set_not_void: a_set /= Void
		local
			l_cluster: CLUSTER_I
			l_classes: HASH_TABLE [CLASS_I, STRING]
			vd23: VD23
			vd24: VD24
			vscn: VSCN
			old_cursor: CURSOR
			l_processed_set: HASH_TABLE [CLASS_I, STRING]
			l_conflicts_set: HASH_TABLE [ARRAYED_LIST [CLASS_I], STRING]
			l_list: ARRAYED_LIST [CLASS_I]
			l_first_class, l_second_class: CLASS_I
			l_class_name: STRING
			l_has_error: BOOLEAN
		do
				-- First pass, we check that all classes in `a_set' are located at least
				-- in one cluster. If located in two or more clusters, we record them
				-- in `l_conflicts'.
			from
				create l_processed_set.make (a_set.count)
				create l_conflicts_set.make (a_set.count)
				old_cursor := clusters.cursor
				clusters.start
			until
				clusters.after
			loop
				l_cluster := clusters.item
				from
					l_classes := l_cluster.classes
					l_classes.start
				until
					l_classes.after
				loop
					l_class_name := l_classes.key_for_iteration
					if a_set.has (l_class_name) then
						l_processed_set.search (l_class_name)
						if l_processed_set.found then
								-- We have a conflict here, let's record it for further analyzis.
							l_list := l_conflicts_set.item (l_class_name)
							if l_list = Void then
									-- Create conflicts list for `l_class_name', we insert
									-- as first element first element inserted for `l_class_name'
									-- in `l_processed_set'.
								create l_list.make (clusters.count)
								l_conflicts_set.put (l_list, l_class_name)
								l_list.extend (l_processed_set.found_item)
							end
							l_list.extend (l_classes.item_for_iteration)
						else
							l_processed_set.put (l_classes.item_for_iteration, l_class_name)
						end
					end
					l_classes.forth
				end
				clusters.forth
			end

			if l_processed_set.count /= a_set.count then
					-- Some classes were missing, so for each missing class we report a VD23 error.
				from
					a_set.start
				until
					a_set.after
				loop
					if not l_processed_set.has (a_set.key_for_iteration) then
							-- No class `a_set.key_for_iteration' found.
						create vd23
						vd23.set_class_name (a_set.key_for_iteration)
						Error_handler.insert_error (vd23)
					end
					a_set.forth
				end
				l_has_error := True
			end

			if not l_conflicts_set.is_empty then
					-- We have found classes with the same name either in different cluster
					-- (report a VD24 error) or in same cluster (report a VSCN error)
				from
					l_conflicts_set.start
				until
					l_conflicts_set.after
				loop
					l_class_name := l_conflicts_set.key_for_iteration
					l_list := l_conflicts_set.item_for_iteration
					check
							-- We have at least 2 elements per list.
						list_count_valid: l_list.count > 1
					end
					from
						l_list.start
						l_first_class := l_list.first
						l_list.forth
					until
						l_list.after
					loop
						l_second_class := l_list.item
						if l_first_class.cluster = l_second_class.cluster then
								-- Report VSCN error
							create vscn
							vscn.set_cluster (l_first_class.cluster)
							vscn.set_first (l_first_class)
							vscn.set_second (l_second_class)
							Error_handler.insert_error (vscn)
						else
								-- Report VD24 error
							create vd24
							vd24.set_cluster (l_first_class.cluster)
							vd24.set_other_cluster (l_second_class.cluster)
							vd24.set_class_name (l_class_name)
							Error_handler.insert_error (vd24)
						end
						l_list.forth
					end
					l_conflicts_set.forth
				end
				l_has_error := True
			end

			if not l_has_error then
					-- No error occurred, we can safely call the actions associated to
					-- `a_set'.
				from
					a_set.start
				until
					a_set.after
				loop
					a_set.item_for_iteration.call ([l_processed_set.item (a_set.key_for_iteration)])
					a_set.forth
				end
			end

				-- Restore clusters cursor.
			clusters.go_to (old_cursor)
		end

	duplicate: like Current is
			-- Duplication of universe
		local
			old_cursor: CURSOR
		do
			old_cursor := clusters.cursor

			create Result.make
			clusters.start
			Result.set_clusters (clusters.duplicate (clusters.count))

			clusters.go_to (old_cursor)
		end

	compute_last_class (class_name: STRING; a_cluster: CLUSTER_I) is
			-- Assign to `last_class' the class named `class_name'
			-- in cluster `a_cluster'
		require
			good_argument: class_name /= Void
			good_cluster: a_cluster /= Void
			class_name_is_in_upper_case: class_name.as_upper.is_equal (class_name)
		local
			l_cluster: CLUSTER_I
			real_name: STRING
			rename_clause: RENAME_I
			renamings: HASH_TABLE [STRING, STRING]
			vscn: VSCN
			new_class: CLASS_I
			error_list: LINKED_LIST [VSCN]
			l_ignore: LINKED_LIST [CLUSTER_I]
		do
			last_class := Void
			l_ignore := a_cluster.ignore

			from
				clusters.start
			until
				clusters.after
			loop
				l_cluster := clusters.item
				if l_ignore = Void or else not l_ignore.has (l_cluster) then
					real_name := class_name
					rename_clause := a_cluster.rename_clause_for (l_cluster)
					if rename_clause /= Void then
							-- Evaluation of the real name of the class
						renamings := rename_clause.renamings
						if renamings.has (class_name) then
							real_name := renamings.found_item
						elseif renamings.has_item (class_name) then
							real_name := Has_been_renamed
						end
					end

					if l_cluster.classes.has (real_name) then
						new_class := l_cluster.classes.found_item
						if last_class = Void then
							last_class := new_class
						else
							create vscn
							vscn.set_first (last_class)
							vscn.set_second (new_class)
							vscn.set_cluster (l_cluster)
							if error_list = Void then
								create error_list.make
							end
							error_list.extend (vscn)
						end
					end
				end
				clusters.forth
			end

					-- Conflict detected
			if error_list /= Void then
				from
					error_list.start
				until
					error_list.after
				loop
					error_handler.insert_error (error_list.item)
					error_list.forth
				end
				last_class := Void
				error_handler.raise_error
			end
		end

	is_ambiguous_name (class_name: STRING): BOOLEAN is
			-- Is the raw class name `class_name' ambiguous for the
			-- universe ?
		require
			good_argument: class_name /= Void
			class_name_is_in_upper_case: class_name.as_upper.is_equal (class_name)
		local
			found, one_found: BOOLEAN
		do
			from
				clusters.start
			until
				clusters.after or else Result
			loop
				if not clusters.item.belongs_to_all then
					found := clusters.item.classes.has (class_name)
					Result := found and then one_found
					one_found := one_found or else found
				end
				clusters.forth
			end
		end

	process_override_clusters is
			-- incrementality of the override_cluster option
		local
			l_ovcs: like override_clusters
			l_cluster: CLUSTER_I
		do
			if has_override_cluster then
					-- Remove classes which are overridden
				l_ovcs := override_clusters

				from
					l_ovcs.start
				until
					l_ovcs.after
				loop
					l_cluster := l_ovcs.item
					from
						clusters.start
					until
						clusters.after
					loop
						if not clusters.item.is_override_cluster then
							clusters.item.process_overrides (l_cluster)
						end
						clusters.forth
					end
					l_ovcs.forth
				end
			end
		end

	rebuild_override_fast is
			-- Performed during a recompile without degree 6. We simply analyzes
			-- content of override clusters to find modified classes outside environment.
		require
			has_override_cluster: has_override_cluster
		local
			l_ovcs: like override_clusters
		do
				-- Remove classes which are overridden
			l_ovcs := override_clusters

			from
				l_ovcs.start
			until
				l_ovcs.after
			loop
				l_ovcs.item.rebuild_override
				l_ovcs.forth
			end
		end

feature {COMPILER_EXPORTER} -- Merging

	merge (other: like Current) is
			-- Merge `other' to current universe.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		local
			other_clusters: like clusters
			c_of_name, c_of_path: CLUSTER_I
			c: CLUSTER_I
			vd28: VD28
			vdcn: VDCN
		do
			other_clusters := other.clusters
			from other_clusters.start until other_clusters.after loop
				c := other_clusters.item
				c_of_name := Universe.cluster_of_name (c.cluster_name)
				c_of_path := Universe.cluster_of_path (c.path)
				if c_of_name /= Void then
					if c_of_path /= c_of_name then
							-- Two clusters with the same name.
						create vdcn
						vdcn.set_cluster (c)
						Error_handler.insert_error (vdcn)
						Error_handler.raise_error
					end
				elseif c_of_path /= Void then
						-- Two clusters with same path.
					create vd28
					vd28.set_cluster (c_of_path)
					vd28.set_second_cluster_name (c.cluster_name)
					Error_handler.insert_error (vd28)
					Error_handler.raise_error
				else
					insert_cluster (c)
				end
				other_clusters.forth
			end
		end

feature {COMPILER_EXPORTER} -- Precompilation

	mark_precompiled is
			-- Mark all the clusters of the universe as being precompiled.
		local
			precomp_ids: ARRAY [INTEGER]
			nb: INTEGER
		do
			precomp_ids := Precompilation_directories.current_keys
			nb := precomp_ids.count + 1
			precomp_ids.conservative_resize (1, nb)
			precomp_ids.put (System.compilation_id, nb)
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.set_is_precompiled (precomp_ids)
				clusters.forth
			end
		end

feature {NONE} -- Constants

	Has_been_renamed: STRING is "_"
			-- Fake name to identify a class which has been renamed

feature {NONE} -- Externals

	eif_date (s: POINTER): INTEGER is
			-- External time stamp primitive
		external
			"C"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
