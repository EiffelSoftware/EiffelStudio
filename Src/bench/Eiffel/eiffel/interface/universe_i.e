indexing
	description: "Internal representation of the Eiffel universe."
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

	SHARED_TEXT_ITEMS
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

	override_cluster_name: STRING
			-- Tag of the (optional) override cluster.

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
		local
			cur: CURSOR
			cname: STRING
			classes: HASH_TABLE [CLASS_I, STRING]
		do
			create {ARRAYED_LIST [CLASS_I]} Result.make (2)
			cname := clone (class_name)
			cname.to_lower
			buffered_classes.search (cname)
			if not buffered_classes.found then
				cur := clusters.cursor
				from
					clusters.start
				until
					clusters.after
				loop
					classes := clusters.item.classes
					if classes.has (cname) then
						Result.extend (classes.found_item)
						Result.forth
					end
					clusters.forth
				end
				clusters.go_to (cur)
				if Result.count = 1 then
					buffered_classes.put (Result.first, cname)
				end
			else
				Result.extend (buffered_classes.found_item)
			end
		end

	compiled_classes_with_name (class_name: STRING): LIST [CLASS_I] is
			-- Compiled classes with name `class_name' found in the Universe
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
		local
			l_cluster: CLUSTER_I
			real_name: STRING
			rename_clause: RENAME_I
			renamings: HASH_TABLE [STRING, STRING]
			old_cursor: CURSOR
		do
			if
				has_override_cluster and then
				not a_cluster.ignored (override_cluster)
			then
				real_name := class_name
				rename_clause := a_cluster.rename_clause_for (override_cluster)
				if rename_clause /= Void then
						-- Evaluation of the real name of the class
					renamings := rename_clause.renamings
					if renamings.has (class_name) then
						real_name := renamings.found_item
					elseif renamings.has_item (class_name) then
						real_name := Has_been_renamed
					end
				end
				Result := override_cluster.classes.item (real_name)
			end
			if Result = Void then
					-- First look for a renamed class in `a_cluster'
				Result := a_cluster.renamed_class (class_name)

				if Result = Void then
					from
						old_cursor := clusters.cursor
						clusters.start
					until
						clusters.after or else Result /= Void
					loop
						l_cluster := clusters.item
						if not a_cluster.ignored (l_cluster) then
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
							Result := l_cluster.classes.item (real_name)
						end
						clusters.forth
					end
					clusters.go_to (old_cursor)
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
			Result := override_cluster_name /= void
		end

	override_cluster: CLUSTER_I is
			-- Override cluster in the universe.
		require
			has_override_cluster: has_override_cluster
		local
			c: CURSOR
		do
				-- Saving position
			c := clusters.cursor
			
			Result := cluster_of_name (override_cluster_name)

			clusters.go_to (c)
		end

feature -- Update

	reset_assemblies_to_be_added is
			-- Reset `assemblies_to_be_added'.
		do
			assemblies_to_be_added := Void
		ensure
			assemblies_to_be_added_reset: assemblies_to_be_added = Void
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

	set_override_cluster_name (cluster_name: STRING) is
			-- Set `override_cluster_name' to `cluster_name'.
		do
			override_cluster_name := cluster_name
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
				override_cluster_name := other.override_cluster_name
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
			Result := equal (override_cluster_name, other.override_cluster_name)
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
				l_actions.put (agent system.set_system_object_class, "system_object")
			end

			l_actions.put (agent system.set_any_class, "any")
			l_actions.put (agent system.set_boolean_class, "boolean")
			l_actions.put (agent system.set_character_class (?, False), "character")
			l_actions.put (agent system.set_integer_class (?, 8), "integer_8")
			l_actions.put (agent system.set_integer_class (?, 16), "integer_16")
			l_actions.put (agent system.set_integer_class (?, 32), "integer")
			l_actions.put (agent system.set_integer_class (?, 64), "integer_64")
			l_actions.put (agent system.set_real_class, "real")
			l_actions.put (agent system.set_double_class, "double")
			l_actions.put (agent system.set_pointer_class, "pointer")
			l_actions.put (agent system.set_typed_pointer_class, "typed_pointer")
			l_actions.put (agent system.set_string_class, "string")
			l_actions.put (agent system.set_array_class, "array")
			l_actions.put (agent system.set_special_class, "special")
			l_actions.put (agent system.set_tuple_class, "tuple")
			l_actions.put (agent system.set_memory_class, "memory")
			l_actions.put (agent system.set_routine_class, "routine")
			l_actions.put (agent system.set_procedure_class, "procedure")
			l_actions.put (agent system.set_function_class, "function")
			l_actions.put (agent system.set_to_special_class, "to_special")

				-- XX_REF classes
			l_actions.put (agent system.set_bit_class, "bit_ref")
			l_actions.put (agent system.set_boolean_ref_class, "boolean_ref")
			l_actions.put (agent system.set_character_ref_class (?, False), "character_ref")
			l_actions.put (agent system.set_integer_ref_class (?, 8), "integer_8_ref")
			l_actions.put (agent system.set_integer_ref_class (?, 16), "integer_16_ref")
			l_actions.put (agent system.set_integer_ref_class (?, 32), "integer_ref")
			l_actions.put (agent system.set_integer_ref_class (?, 64), "integer_64_ref")
			l_actions.put (agent system.set_real_ref_class, "real_ref")
			l_actions.put (agent system.set_double_ref_class, "double_ref")
			l_actions.put (agent system.set_pointer_ref_class, "pointer_ref")

			if not system.il_generation then
				l_actions.put (agent system.set_character_class (?, True), "wide_character")
				l_actions.put (agent system.set_character_ref_class (?, True), "wide_character_ref")
			else
				l_actions.put (agent system.set_system_string_class, "system_string")
				l_actions.put (agent system.set_native_array_class, "native_array")
					-- In MSIL generation, WIDE_CHARACTER does not exist since
					-- all characters are wide.
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
		local
			l_cluster: CLUSTER_I
			real_name: STRING
			rename_clause: RENAME_I
			renamings: HASH_TABLE [STRING, STRING]
			vscn: VSCN
			new_class, override_class, precompiled_class: CLASS_I
			error_list: LINKED_LIST [VSCN]
		do
			last_class := Void

			from
				clusters.start
			until
				clusters.after
			loop
				l_cluster := clusters.item
				if not a_cluster.ignored (l_cluster) then
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
						if l_cluster.is_override_cluster then
							override_class := new_class
						end
						if l_cluster.is_precompiled then
							precompiled_class := new_class
						end
					end
				end
				clusters.forth
			end

			if override_class /= Void then
				last_class := override_class
			end

			if
					-- Conflict detected
				error_list /= Void and then
					-- No override or conflict override/precompiled class
				(override_class = Void or else precompiled_class /= Void)
			then
				from
					error_list.start
				until
					error_list.after
				loop
					error_handler.insert_error (error_list.item)
					error_list.forth
				end
			end
		end

	is_ambiguous_name (class_name: STRING): BOOLEAN is
			-- Is the raw class name `class_name' ambiguous for the
			-- universe ?
		require
			good_argument: class_name /= Void
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

	process_override_cluster is
			-- incrementality of the override_cluster option
		local
			old_universe: UNIVERSE_I
			old_tag: STRING
			old_cluster: CLUSTER_I
			classes: HASH_TABLE [CLASS_I, STRING]
			a_class: CLASS_C
			ovc    : CLUSTER_I
		do
			if has_override_cluster then
					-- Remove classes which are overridden
				ovc := override_cluster

				if ovc /= Void then
					from
						clusters.start
					until
						clusters.after
					loop
						if clusters.item /= ovc then
							clusters.item.process_overrides (ovc)
						end
						clusters.forth
					end
				end
			end

			old_universe := lace.old_universe
			if old_universe /= Void and then old_universe.has_override_cluster then
				old_tag := old_universe.override_cluster_name
				if not equal (old_tag, override_cluster_name) then
					if has_cluster_of_name (old_tag) then
						old_cluster := cluster_of_name (old_tag)
						from
							classes := old_cluster.classes
							classes.start
						until
							classes.after
						loop
							a_class := classes.item_for_iteration.compiled_class
							if a_class /= void then
								a_class.recompile_syntactical_clients
							end
							classes.forth
						end
					end
				end
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
			precomp_ids.resize (1, nb)
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

end
