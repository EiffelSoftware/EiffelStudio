-- Internal representation of the Eiffel universe

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

creation {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make is
			-- Create the hash table.
		do
			!! clusters.make
		end

feature -- Properties

	clusters: LINKED_LIST [CLUSTER_I]
			-- Clusters of the universe

	clusters_sorted_by_tag: LINKED_LIST [CLUSTER_I] is
			-- Clusters sorted by their tags
		local
			loc_clusters: like clusters
		do
			loc_clusters := clusters
			!! Result.make
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
					!! fn.make_from_string (classes.item_for_iteration.file_name)
					if f_name.is_equal (fn) then
						Result := classes.item_for_iteration
					end
					classes.forth	
				end
				clusters.forth
			end
			clusters.go_to (cur)
		end

	classes_with_name (class_name: STRING): LINKED_LIST [CLASS_I] is
			-- Classes with name `class_name' found in the Universe
		local
			cur: CURSOR
			cname: STRING
			classes: HASH_TABLE [CLASS_I, STRING]
		do
			!! Result.make
			cname := clone (class_name)
			cname.to_lower
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
		end

	compiled_classes_with_name (class_name: STRING): LINKED_LIST [CLASS_I] is
			-- Compiled classes with name `class_name' found in the Universe
		local
			cur: CURSOR
			cname: STRING
			class_i: CLASS_I
			classes: HASH_TABLE [CLASS_I, STRING]
		do
			!! Result.make
			cname := clone (class_name)
			cname.to_lower
			cur := clusters.cursor
			from clusters.start until clusters.after loop
				classes := clusters.item.classes
				if classes.has (cname) then
					class_i := classes.found_item
					if class_i.compiled then
						Result.extend (class_i)
						Result.forth
					end
				end
				clusters.forth
			end
			clusters.go_to (cur)
		end

	class_named (class_name: STRING cluster: CLUSTER_I): CLASS_I is
			-- Class named `class_name' in cluster `cluster'
		require
			good_argument: class_name /= Void
			good_cluster: cluster /= Void
		local
			a_cluster: CLUSTER_I
			real_name: STRING
			rename_clause: RENAME_I
			renamings: HASH_TABLE [STRING, STRING]
			old_cursor: CURSOR
		do
			if
				has_override_cluster and then
				not cluster.ignored (override_cluster)
			then
				real_name := class_name
				rename_clause := cluster.rename_clause_for (override_cluster)
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
					-- First look for a renamed class in `cluster'
				Result := cluster.renamed_class (class_name)

				if Result = Void then
					from
						old_cursor := clusters.cursor
						clusters.start
					until
						clusters.after or else Result /= Void
					loop
						a_cluster := clusters.item
						if not cluster.ignored (a_cluster) then
							real_name := class_name
							rename_clause := cluster.rename_clause_for (a_cluster)
							if rename_clause /= Void then
									-- Evaluation of the real name of the class
								renamings := rename_clause.renamings
								if renamings.has (class_name) then
									real_name := renamings.found_item
								elseif renamings.has_item (class_name) then
									real_name := Has_been_renamed
								end
							end
							Result := a_cluster.classes.item (real_name)
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
			a_cluster: CLUSTER_I
			new_date: INTEGER
			ptr: ANY
		do
			from
				clusters.start
			until
				clusters.after or else Result
			loop
				a_cluster := clusters.item
				ptr := a_cluster.path.to_c
				new_date := eif_date ($ptr)
				Result := a_cluster.date /= new_date
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

feature {COMPILER_EXPORTER} -- Implementation

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
		do
			system.set_any_class (unique_class ("any"))
			system.set_boolean_class (unique_class ("boolean"))
			system.set_character_class (unique_class ("character"), False)
			system.set_integer_class (unique_class ("integer_8"), 8)
			system.set_integer_class (unique_class ("integer_16"), 16)
			system.set_integer_class (unique_class ("integer"), 32)
			system.set_integer_class (unique_class ("integer_64"), 64)
			system.set_real_class (unique_class ("real"))
			system.set_double_class (unique_class ("double"))
			system.set_string_class (unique_class ("string"))
			system.set_pointer_class (unique_class ("pointer"))

			if not system.il_generation then
				system.set_tuple_class (unique_class ("tuple"))
				system.set_array_class (unique_class ("array"))
				system.set_to_special_class (unique_class ("to_special"))
				system.set_special_class (unique_class ("special"))
				system.set_bit_class (unique_class ("bit_ref"))
				system.set_character_ref_class (unique_class ("character_ref"), False)
				system.set_boolean_ref_class (unique_class("boolean_ref"))
				system.set_integer_ref_class (unique_class("integer_8_ref"), 8)
				system.set_integer_ref_class (unique_class("integer_16_ref"), 16)
				system.set_integer_ref_class (unique_class("integer_ref"), 32)
				system.set_integer_ref_class (unique_class("integer_64_ref"), 64)
				system.set_real_ref_class (unique_class("real_ref"))
				system.set_double_ref_class (unique_class("double_ref"))
				system.set_pointer_ref_class (unique_class("pointer_ref"))
				system.set_memory_class_i (unique_class ("memory"))
				system.set_routine_class (unique_class ("routine"))
				system.set_procedure_class (unique_class ("procedure"))
				system.set_function_class (unique_class ("function"))
				system.set_character_class (unique_class ("wide_character"), True)
				system.set_character_ref_class (unique_class ("wide_character_ref"), True)
			else
					-- In IL generation an ARRAY is equivalent to a SPECIAL object
					-- in normal generation
				system.set_special_class (unique_class ("array"))
				system.set_array_class (system.special_class)
			end

				-- Check sum error
			Error_handler.checksum
		end

	reset_clusters is
			-- Reset all the clusters
		local
			a_cluster: CLUSTER_I
		do
			from
				clusters.start
			until
				clusters.after
			loop
				a_cluster := clusters.item
				if not a_cluster.is_precompiled then
					a_cluster.reset_cluster
				end
				clusters.forth
			end
		end

	unique_class (class_name: STRING): CLASS_I is
			-- Universe checking
		require
			good_argument: class_name /= Void
		local
			cluster: CLUSTER_I
			vd23: VD23
			vd24: VD24
			old_cursor: CURSOR
		do
			from
				clusters.start
			until
				clusters.after
			loop
				cluster := clusters.item
				old_cursor := clusters.cursor
				compute_last_class (class_name, cluster)
				if last_class = Void then
					!!vd23
					vd23.set_class_name (class_name)
					Error_handler.insert_error (vd23)
				elseif	Result /= Void
						and then
						last_class /= Result
				then
					!!vd24
					vd24.set_cluster (cluster)
					vd24.set_other_cluster (Result.cluster)
					vd24.set_class_name (class_name)
					Error_handler.insert_error (vd24)
				end
				Result := last_class
				clusters.go_to (old_cursor)
				clusters.forth
			end
		end

	duplicate: like Current is
			-- Duplication of universe
		local
			old_cursor: CURSOR
		do
			old_cursor := clusters.cursor

			!! Result.make
			clusters.start
			Result.set_clusters (clusters.duplicate (clusters.count))

			clusters.go_to (old_cursor)
		end

	compute_last_class (class_name: STRING cluster: CLUSTER_I) is
			-- Assign to `last_class' the class named `class_name'
			-- in cluster `cluster'
		require
			good_argument: class_name /= Void
			good_cluster: cluster /= Void
		local
			a_cluster: CLUSTER_I
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
				a_cluster := clusters.item
				if not cluster.ignored (a_cluster) then
					real_name := class_name
					rename_clause := cluster.rename_clause_for (a_cluster)
					if rename_clause /= Void then
							-- Evaluation of the real name of the class
						renamings := rename_clause.renamings
						if renamings.has (class_name) then
							real_name := renamings.found_item
						elseif renamings.has_item (class_name) then
							real_name := Has_been_renamed
						end
					end

					if a_cluster.classes.has (real_name) then
						new_class := a_cluster.classes.found_item
						if last_class = Void then
							last_class := new_class
						else
							!! vscn
							vscn.set_first (last_class)
							vscn.set_second (new_class)
							vscn.set_cluster (a_cluster)
							if error_list = Void then
								!! error_list.make
							end
							error_list.extend (vscn)
						end
						if a_cluster.is_override_cluster then
							override_class := new_class
						end
						if a_cluster.is_precompiled then
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
				error_list /= Void
			and then
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
			classes: EXTEND_TABLE [CLASS_I, STRING]
			a_class: CLASS_C
			ovc    : CLUSTER_I
		do
			if override_cluster_name /= Void then
				cluster_of_name (override_cluster_name).set_is_override_cluster (True)
			end

			if has_override_cluster then
					-- Remove classes which are overridden
				ovc := override_cluster

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

			old_universe := lace.old_universe
			if old_universe.has_override_cluster then
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
			other_clusters: LINKED_LIST [CLUSTER_I]
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
						!! vdcn
						vdcn.set_cluster (c)
						Error_handler.insert_error (vdcn)
						Error_handler.raise_error
					end
				elseif c_of_path /= Void then
						-- Two clusters with same path.
					!!vd28
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
